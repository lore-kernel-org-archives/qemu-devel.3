Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242E8F433D6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 02:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDCgV-0005kU-OS; Wed, 15 Apr 2026 22:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1wDCgT-0005kD-AU
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 22:42:25 -0400
Received: from out-170.mta1.migadu.com ([95.215.58.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1wDCgR-000427-8B
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 22:42:25 -0400
Message-ID: <8e88cfa9-f5a1-4567-9886-d135eb031430@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1776307331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+SiiAWLLVPpzzN82TUNWPLyd0H30MpGaFlIo2z6QdE=;
 b=IK+k08jzlxz3In6WFoRRf8WZEMe0N8mUdBgDD/PU6JMCX5Szlj5QBzPsLEtnkSzuuvbRk8
 8Bbk30M7xGD3RBqz+g0POWbqIDAiWfe/2vOZKaZSfOXaCjn9EGk0jH/9MlTFcla/sDsVur
 WXcN8EGSJi1YAvhP/QNQ3NSTjZYTb28=
Date: Thu, 16 Apr 2026 10:41:52 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] backends/cryptodev-lkcf: fix use-after-free in session
 lifecycle
To: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, qemu-security@nongnu.org
Cc: mcascell@redhat.com, Buzzy <buzzy0257@gmail.com>
References: <20260416015947.1426-1-arei.gonglei@huawei.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: zhenwei pi <zhenwei.pi@linux.dev>
In-Reply-To: <20260416015947.1426-1-arei.gonglei@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.170; envelope-from=zhenwei.pi@linux.dev;
 helo=out-170.mta1.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/16/26 09:59, Gonglei wrote:
> The cryptodev-lkcf backend had a race condition where session close
> could free a session while tasks using that session were still pending
> in the queue. This leads to use-after-free when the worker thread
> later accesses the freed session pointer.
> 
> Add reference counting (in_use) and pending_close flag to ensure:
> - New operations are rejected when a session is closing
> - Session close waits for all in-flight tasks to complete
> - No use-after-free can occur
> 
> Fixes: CVE-2026-6288
> Fixes: 39fff6f3e8 ("cryptodev: Add a lkcf-backend for cryptodev")
> Reported-by: Buzzy <buzzy0257@gmail.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> Tested-by: Buzzy <buzzy0257@gmail.com>
> ---
>   backends/cryptodev-lkcf.c | 54 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
> index 40c7bd3c5a..dc39b7f5aa 100644
> --- a/backends/cryptodev-lkcf.c
> +++ b/backends/cryptodev-lkcf.c
> @@ -66,6 +66,9 @@ typedef struct CryptoDevBackendLKCFSession {
>       size_t keylen;
>       QCryptoAkCipherKeyType keytype;
>       QCryptoAkCipherOptions akcipher_opts;
> +    int in_use;  /* number of tasks currently using this session */
> +    /* session close requested, waiting for in_use to become 0 */
> +    bool pending_close;
>   } CryptoDevBackendLKCFSession;
>   
>   typedef struct CryptoDevLKCFTask CryptoDevLKCFTask;
> @@ -428,6 +431,18 @@ out:
>       if (key_id >= 0) {
>           keyctl_unlink(key_id, KCTL_KEY_RING);
>       }
> +
> +    /*
> +     * Decrement session in_use counter and signal if session is pending close.
> +     * This allows close_session to proceed after all tasks complete.
> +     */
> +    qemu_mutex_lock(&task->lkcf->mutex);
> +    task->sess->in_use--;
> +    if (task->sess->pending_close && task->sess->in_use == 0) {
> +        qemu_cond_broadcast(&task->lkcf->cond);
> +    }
> +    qemu_mutex_unlock(&task->lkcf->mutex);
> +
>       task->status = status;
>   
>       qemu_mutex_lock(&task->lkcf->rsp_mutex);
> @@ -500,7 +515,24 @@ static int cryptodev_lkcf_operation(
>       task->lkcf = lkcf;
>       task->status = -VIRTIO_CRYPTO_ERR;
>   
> +    /*
> +     * Increment session in_use counter before adding task to queue.
> +     * This prevents the session from being freed while a task is pending.
> +     */
>       qemu_mutex_lock(&lkcf->mutex);
> +    sess->in_use++;
> +
> +    /*
> +     * Check if session is pending close - if so, reject this operation
> +     * to avoid potential use-after-free.
> +     */
> +    if (sess->pending_close) {
> +        sess->in_use--;
> +        qemu_mutex_unlock(&lkcf->mutex);
> +        error_report("Session %" PRIu64 " is closing", op_info->session_id);
> +        g_free(task);
> +        return -VIRTIO_CRYPTO_INVSESS;
> +    }

What about moving this block before 'task = g_new0(CryptoDevLKCFTask, 
1);'? This will simplify this error handling?

qemu_mutex_lock(&lkcf->mutex);
sess = lkcf->sess[op_info->session_id];
if (sess->pending_close) {
     qemu_mutex_unlock(&lkcf->mutex);
     error_report("Session %" PRIu64 " is closing", op_info->session_id);
     return -VIRTIO_CRYPTO_INVSESS;
}

sess->in_use++;
qemu_mutex_unlock(&lkcf->mutex);

task = g_new0(CryptoDevLKCFTask, 1);
...

>       QSIMPLEQ_INSERT_TAIL(&lkcf->requests, task, queue);
>       qemu_mutex_unlock(&lkcf->mutex);
>       qemu_cond_signal(&lkcf->cond);
> @@ -606,8 +638,30 @@ static int cryptodev_lkcf_close_session(CryptoDevBackend *backend,
>       CryptoDevBackendLKCFSession *session;
>   
>       assert(session_id < MAX_SESSIONS && lkcf->sess[session_id]);
> +
> +    qemu_mutex_lock(&lkcf->mutex);
>       session = lkcf->sess[session_id];
> +
> +    /*
> +     * Mark session as pending close. New operations using this session
> +     * will be rejected. We hold the mutex until in_use becomes 0 to
> +     * prevent race conditions.
> +     */
> +    session->pending_close = true;
> +
> +    /*
> +     * Wait for all in-flight tasks using this session to complete.
> +     * The worker thread decrements in_use after task execution.
> +     */
> +    while (session->in_use > 0) {
> +        qemu_cond_wait(&lkcf->cond, &lkcf->mutex);
> +    }
> +
> +    /*
> +     * Now safe to remove session and free resources.
> +     */
>       lkcf->sess[session_id] = NULL;
> +    qemu_mutex_unlock(&lkcf->mutex);
>   
>       g_free(session->key);
>       g_free(session);


