Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D53F433FE
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 06:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDGBL-0006Fd-IY; Thu, 16 Apr 2026 02:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1wDGB3-0006D8-IT
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 02:26:15 -0400
Received: from out-181.mta0.migadu.com ([2001:41d0:1004:224b::b5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1wDGAz-0001ru-Pg
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 02:26:12 -0400
Message-ID: <6128bece-0ce1-4e46-a4c6-9208dd211ee9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1776320756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDBlTDVbkaq1xZqdxX9TNPaKB8jEiL6o5xDCbb2JOvo=;
 b=Bpbbln/MIzZkHhouEksQJpqD+8S64R85Fh3X8mGz6oKvuXd0sXwwtyJq3pv0DYFO/aI1fd
 p2PIHv2NDwBzZH0qTbbok67uALXEDJszdmoae/0PMGZxtEVp1IogOHCl8CFS9cjyZcxmXG
 4tH3jpBvVNxpOUHmho3628ihs/Sb3u4=
Date: Thu, 16 Apr 2026 14:25:45 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2] backends/cryptodev-lkcf: fix use-after-free in session
 lifecycle
To: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, qemu-security@nongnu.org
Cc: mcascell@redhat.com, Buzzy <buzzy0257@gmail.com>
References: <20260416061933.1982-1-arei.gonglei@huawei.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: zhenwei pi <zhenwei.pi@linux.dev>
In-Reply-To: <20260416061933.1982-1-arei.gonglei@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::b5;
 envelope-from=zhenwei.pi@linux.dev; helo=out-181.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: zhenwei pi <zhenwei.pi@linux.dev>

On 4/16/26 14:19, Gonglei wrote:
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
> Changes:
> 
> v2:
>   * moved sess->pending_close checking before @task allocated
>     in cryptodev_lkcf_operation().
> 
> ---
>   backends/cryptodev-lkcf.c | 59 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
> index 40c7bd3c5a..3a93c81372 100644
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
> @@ -486,12 +501,32 @@ static int cryptodev_lkcf_operation(
>           return -VIRTIO_CRYPTO_INVSESS;
>       }
>   
> -    sess = lkcf->sess[op_info->session_id];
>       if (algtype != QCRYPTODEV_BACKEND_ALGO_TYPE_ASYM) {
>           error_report("algtype not supported: %u", algtype);
>           return -VIRTIO_CRYPTO_NOTSUPP;
>       }
>   
> +    /*
> +     * Check if session is pending close and increment in_use counter
> +     * atomically under the mutex. This prevents the session from being
> +     * freed while a task is pending.
> +     */
> +    qemu_mutex_lock(&lkcf->mutex);
> +    sess = lkcf->sess[op_info->session_id];
> +    if (!sess) {
> +        qemu_mutex_unlock(&lkcf->mutex);
> +        error_report("Cannot find a valid session id: %" PRIu64 "",
> +                     op_info->session_id);
> +        return -VIRTIO_CRYPTO_INVSESS;
> +    }
> +    if (sess->pending_close) {
> +        qemu_mutex_unlock(&lkcf->mutex);
> +        error_report("Session %" PRIu64 " is closing", op_info->session_id);
> +        return -VIRTIO_CRYPTO_INVSESS;
> +    }
> +    sess->in_use++;
> +    qemu_mutex_unlock(&lkcf->mutex);
> +
>       task = g_new0(CryptoDevLKCFTask, 1);
>       task->op_info = op_info;
>       task->cb = op_info->cb;
> @@ -606,8 +641,30 @@ static int cryptodev_lkcf_close_session(CryptoDevBackend *backend,
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


