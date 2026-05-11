Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D5BCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMOBt-0001OJ-M1; Mon, 11 May 2026 06:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMOBZ-0001Kb-RK
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:48:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMOBX-0002iw-Nh
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778496506;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/qAPGhNf/WCKNLxedJD4OrD/oWjx49hX63Zr2Tady7A=;
 b=KX0D2wpefqdmhAziLrZdRWEh95LgP+QcaR/AxKFOc1Tlx9BeMoagaWV5IwLNpWyttABW2l
 ZYNbCgj1BQDnG9X3D+3DPL5JN13wa4l/ETGZkNX8M2KMBaYct77tJGOut+0E6CTIDja3bM
 4eAV/aE9C/HJlDZX8vwf9CwvmjlVlhw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-DvYa0HRmPG-s4Lt-i5_Ljg-1; Mon,
 11 May 2026 06:48:23 -0400
X-MC-Unique: DvYa0HRmPG-s4Lt-i5_Ljg-1
X-Mimecast-MFC-AGG-ID: DvYa0HRmPG-s4Lt-i5_Ljg_1778496502
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1F5E1955F54; Mon, 11 May 2026 10:48:21 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65C911800762; Mon, 11 May 2026 10:48:19 +0000 (UTC)
Date: Mon, 11 May 2026 11:48:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, zhenwei.pi@linux.dev, qemu-security@nongnu.org,
 mcascell@redhat.com, Buzzy <buzzy0257@gmail.com>
Subject: Re: [PATCH v2] backends/cryptodev-lkcf: fix use-after-free in
 session lifecycle
Message-ID: <agGz70Vjs2shvW1T@redhat.com>
References: <20260416061933.1982-1-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260416061933.1982-1-arei.gonglei@huawei.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 16, 2026 at 02:19:32PM +0800, Gonglei wrote:
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

This patch was reviewed quite a while ago, but I don't see it
merged in git yet, so just wanted to double-check it was
queued for a future pull request and not lost. 

> Changes:
> 
> v2: 
>  * moved sess->pending_close checking before @task allocated
>    in cryptodev_lkcf_operation().
> 
> ---
>  backends/cryptodev-lkcf.c | 59 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
> index 40c7bd3c5a..3a93c81372 100644
> --- a/backends/cryptodev-lkcf.c
> +++ b/backends/cryptodev-lkcf.c
> @@ -66,6 +66,9 @@ typedef struct CryptoDevBackendLKCFSession {
>      size_t keylen;
>      QCryptoAkCipherKeyType keytype;
>      QCryptoAkCipherOptions akcipher_opts;
> +    int in_use;  /* number of tasks currently using this session */
> +    /* session close requested, waiting for in_use to become 0 */
> +    bool pending_close;
>  } CryptoDevBackendLKCFSession;
>  
>  typedef struct CryptoDevLKCFTask CryptoDevLKCFTask;
> @@ -428,6 +431,18 @@ out:
>      if (key_id >= 0) {
>          keyctl_unlink(key_id, KCTL_KEY_RING);
>      }
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
>      task->status = status;
>  
>      qemu_mutex_lock(&task->lkcf->rsp_mutex);
> @@ -486,12 +501,32 @@ static int cryptodev_lkcf_operation(
>          return -VIRTIO_CRYPTO_INVSESS;
>      }
>  
> -    sess = lkcf->sess[op_info->session_id];
>      if (algtype != QCRYPTODEV_BACKEND_ALGO_TYPE_ASYM) {
>          error_report("algtype not supported: %u", algtype);
>          return -VIRTIO_CRYPTO_NOTSUPP;
>      }
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
>      task = g_new0(CryptoDevLKCFTask, 1);
>      task->op_info = op_info;
>      task->cb = op_info->cb;
> @@ -606,8 +641,30 @@ static int cryptodev_lkcf_close_session(CryptoDevBackend *backend,
>      CryptoDevBackendLKCFSession *session;
>  
>      assert(session_id < MAX_SESSIONS && lkcf->sess[session_id]);
> +
> +    qemu_mutex_lock(&lkcf->mutex);
>      session = lkcf->sess[session_id];
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
>      lkcf->sess[session_id] = NULL;
> +    qemu_mutex_unlock(&lkcf->mutex);
>  
>      g_free(session->key);
>      g_free(session);
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


