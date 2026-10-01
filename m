Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C45CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 18:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCLwJ-0001EJ-LY; Thu, 01 Oct 2026 14:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xCLw7-0001Dt-9b
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 14:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xCLw4-0000LA-34
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 14:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790880913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hpnq1iZZvLtuBSV/eAsLvXFDQlOWLshqfpl/t4FLLWE=;
 b=P2id7T54ssvwdzHyIEzD3iJrCd0rtOne3p9R+I1XHiXqzDk+7JxMfGIZUwVcLZhvNSRuep
 owdPmjjxZLR20y1BcKpdcC3W/gpWfjNgAQueNxN+QNdEYBkFY50YBKyx2k8OMXnJpdQY5v
 MMM0nnoYCjfUwR/fY1pHF5k0voLAvOE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-JGB3htQQMkGtY2KzAcHWMw-1; Thu, 01 Oct 2026 14:55:12 -0400
X-MC-Unique: JGB3htQQMkGtY2KzAcHWMw-1
X-Mimecast-MFC-AGG-ID: JGB3htQQMkGtY2KzAcHWMw_1790880912
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cc5f70c8dso51467085a.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 11:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790880912; x=1791485712; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hpnq1iZZvLtuBSV/eAsLvXFDQlOWLshqfpl/t4FLLWE=;
 b=TdFJq/FbtK6WDStWtGw1UCshNsty9ash2dExw6jUSFtaZqguyjeFkrNhWvRV+NaJ5m
 nfqYjfIHssUtM+W21qfH5ASycwMo3Y0SHgu3TrtN06mAoulVztdyluRqrTQ36djzHm3c
 JgRzF4/6W97oD6j2VhfpSNfixAo4LcDUsc7othgdNurLaHODhWhOGZXLR5stT+Cympb7
 HKnW5chWpZpwKiuwHAePPUA+SZYidpWRADbiYriue2h89K62lMIIEb5rbvZThHZGdW+L
 zmUFDqbYKgzc5UBo+v0iO+JVV142C+U4ysSt3ILcaiXpsm0Fn9+OKRMLCh0ekzbJNgbY
 l50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790880912; x=1791485712;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hpnq1iZZvLtuBSV/eAsLvXFDQlOWLshqfpl/t4FLLWE=;
 b=Uo8ORi3skayhQKep7JovOo/ZCBRhzMd4GOe6242Wn/nTQc57KBmmiUlgnMcZ4DmGgh
 nksHvuHIKHK8udFrHm3h1XvmQEjNNCVy2QWu0kuNdpj6exe6kLNcTk8NW8xw/543Ad3P
 Bhu2fc652qHjpD64nsnCMK3jUnIJXAgn7CDq4gLpx5f03bzODQG2rO5eWcXNOCC/8UXk
 JaWgAV+lyXkR5ED56WNp+FvS5l81qppJImFZkCERrZs2oBhBY/CHuaMb86DfZKLLghRB
 gH5hDxLnVHPVyL2LITJSAnxd5u2qMaiAPsdXd49Eow5d6Hr9enlvSqJYPfBrn8VSdeIM
 yR9w==
X-Gm-Message-State: AFuF++mLpPEhoTSRoIXM35UePSt/X04jpDl0JLipAz7FeFRplHEpw1EH
 FYYba0XXWpHXqnbj0skl5Y6fQ7ry8NdwCPJGcHvX23IO7vZL7OdQkMz1ifLdDhdbD40zMXZV8P2
 SjGC8djTrlR0FebL5VODL9JzPrm40mPhL1WbtMBaSKnCzj63g2571DCSj
X-Gm-Gg: AYBFou0TdzJsVNA54nNDOk2lEvR3jt8wgGA4nOVKsYJKpKPgNzJOnu8uAhC6vb7I2UE
 ApnUzEL3QkvMTcVd81/LJSoj+13jUGZ04jl1eUoYbk6UTKENLXvdvtcIp6x3dl/gfm1CR4gz7zo
 Iap+49Fwil6CB07N3dlMO0s8HdLxOu57o6YhWQK1SbihVH/YsE/cOIMf8NftUvJkScSyeruAuib
 hNwsYvOUZ+5x5jWD1nB5IDo8PtpMqicQerc71n1OVs67CFXrPPk3w4e9bOrRFOmW9rWsL7xtHWm
 s9H7c4987AeyA1DbKKTHwg7j2FerNsaUKoJEvOSJOV3Oo9n35I0TwLZqUBqZchYlw9LFVWU=
X-Received: by 2002:a05:620a:d8b:b0:93c:c987:7f70 with SMTP id
 af79cd13be357-93ce7c0dd2emr10874985a.21.1790880911724; 
 Thu, 01 Oct 2026 11:55:11 -0700 (PDT)
X-Received: by 2002:a05:620a:d8b:b0:93c:c987:7f70 with SMTP id
 af79cd13be357-93ce7c0dd2emr10866585a.21.1790880910944; 
 Thu, 01 Oct 2026 11:55:10 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cca2a9bd9sm18415885a.40.2026.10.01.11.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 11:55:10 -0700 (PDT)
Date: Thu, 1 Oct 2026 14:55:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH] migration/rdma: remove the dangling fd handler
 before re-entering loadvm
Message-ID: <ar6sjER6_pAFjhhb@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260904033130.276-1-getshell@seu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260904033130.276-1-getshell@seu.edu.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello, Hongyan,

Sorry for the delay, and thanks for the patch.

On Fri, Sep 04, 2026 at 11:31:30AM +0800, Hongyan Xu wrote:
> The destination RDMA accept path runs the incoming migration coroutine
> (mis->loadvm_co).  While blocked waiting for an RDMA completion it parks
> itself in yield_until_fd_readable() (util/qemu-coroutine-io.c) on a
> completion-channel fd.  That helper registers an fd handler whose opaque
> is a stack object (FDYieldUntilData) and only removes the handler from
> inside its own fd_coroutine_enter() callback.
> 
> rdma_cm_poll_handler() handles RDMA_CM_EVENT_DISCONNECTED /
> RDMA_CM_EVENT_DEVICE_REMOVAL by calling qemu_coroutine_enter() on the
> coroutine directly.  When the coroutine is parked in
> yield_until_fd_readable() at that moment, this bypasses
> fd_coroutine_enter(): the coroutine resumes and returns from the wait,
> but the fd handler stays registered with an opaque that points into the
> (now returned-from) stack frame.  A later event on that fd then calls
> fd_coroutine_enter() with a dangling pointer -> use-after-free.

Looks like an issue indeed, and I wonder if it's a generic coroutine api
problem.  More below.

> 
> Record, around the yield, the AioContext and fd the coroutine is parked
> on, and make rdma_cm_poll_handler() remove that fd handler before it
> re-enters the coroutine.
> 
> This is an RFC: the coroutine/thread wake-up semantics in this area were
> also discussed by Peter Xu's 2025 series ("migration/rdma: Remove
> coroutine path in qemu_rdma_wait_comp_channel" / "Remove
> rdma_cm_poll_handler"); if that direction is preferred this patch should
> be reworked accordingly.

I assume you meant this:

https://lore.kernel.org/qemu-devel/20251022192612.2737648-10-peterx@redhat.com/

I kept getting interrupted by all the things so that series was stranded
for now.. I'll higher priority of this series.. if someone is willing to
pick that work up before I do, please let me know.  It's always good to fix
problems by removing code..

> 
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---
>  migration/rdma.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index e976739fad..66175aa60b 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -360,6 +360,17 @@ typedef struct RDMAContext {
>       */
>      int migration_started_on_destination;
>  
> +    /*
> +     * While the incoming-migration coroutine is parked in
> +     * yield_until_fd_readable() on a completion channel we record the
> +     * fd and AioContext here.  The cm event handler uses this to remove
> +     * the fd handler before re-entering the coroutine; without that the
> +     * handler keeps pointing at the coroutine stack after the wait
> +     * returns, i.e. a dangling fd handler.
> +     */
> +    AioContext *wait_ctx;
> +    int wait_fd;
> +
>      int total_registrations;
>      int total_writes;
>  
> @@ -1248,7 +1259,21 @@ qemu_rdma_wait_comp_channel(RDMAContext *rdma,
>      struct rdma_cm_event *cm_event;
>  
>      if (qemu_in_coroutine()) {
> +        AioContext *ctx = qemu_get_current_aio_context();
> +
> +        /*
> +         * Record where the coroutine is parked so that
> +         * rdma_cm_poll_handler() can remove the fd handler before it
> +         * re-enters us (yield_until_fd_readable() only removes the
> +         * handler through its own fd_coroutine_enter() callback; a
> +         * direct qemu_coroutine_enter() would leave a handler whose
> +         * opaque points at our stack frame).
> +         */
> +        rdma->wait_ctx = ctx;
> +        rdma->wait_fd = comp_channel->fd;
>          yield_until_fd_readable(comp_channel->fd);
> +        rdma->wait_ctx = NULL;
> +        rdma->wait_fd = -1;
>      } else {
>          /* This is the source side, we're in a separate thread
>           * or destination prior to migration_fd_process_incoming()
> @@ -3024,6 +3049,21 @@ static void rdma_cm_poll_handler(void *opaque)
>          }
>          rdma_ack_cm_event(cm_event);
>          if (mis->loadvm_co) {
> +            /*
> +             * The incoming coroutine may be parked in
> +             * yield_until_fd_readable() on a completion channel.  Its
> +             * fd handler is normally removed by fd_coroutine_enter()
> +             * when that fd becomes readable.  If we re-enter the
> +             * coroutine directly we must remove the handler first,
> +             * otherwise it stays registered with an opaque pointing at
> +             * the (now returned-from) coroutine stack frame.
> +             */
> +            if (rdma->wait_fd >= 0 && rdma->wait_ctx) {
> +                aio_set_fd_handler(rdma->wait_ctx, rdma->wait_fd,
> +                                   NULL, NULL, NULL, NULL, NULL);
> +                rdma->wait_fd = -1;
> +                rdma->wait_ctx = NULL;
> +            }
>              qemu_coroutine_enter(mis->loadvm_co);
>          }
>          return;
> -- 
> 2.50.1.windows.1
> 

I feel like this is a bit of an overkill.

If the problem is about wrongly leftover of fd handlers, can we always
unregister it, like this?

Copy more people (both rdma and coroutines).

===8<===

diff --git a/util/qemu-coroutine-io.c b/util/qemu-coroutine-io.c
index 364f4d5abf..7bf38f4495 100644
--- a/util/qemu-coroutine-io.c
+++ b/util/qemu-coroutine-io.c
@@ -74,7 +74,7 @@ typedef struct {
 static void fd_coroutine_enter(void *opaque)
 {
     FDYieldUntilData *data = opaque;
-    aio_set_fd_handler(data->ctx, data->fd, NULL, NULL, NULL, NULL, NULL);
+    /* Postpone fd handler removal to be within the coroutine */
     qemu_coroutine_enter(data->co);
 }

@@ -89,4 +89,9 @@ void coroutine_fn yield_until_fd_readable(int fd)
     aio_set_fd_handler(data.ctx, fd, fd_coroutine_enter, NULL, NULL, NULL,
                        &data);
     qemu_coroutine_yield();
+    /*
+     * Always remove the fd handler, no matter the re-entering of this
+     * coroutine was caused by fd_coroutine_enter() or something else.
+     */
+    aio_set_fd_handler(data.ctx, fd, NULL, NULL, NULL, NULL, NULL);
 }

-- 
Peter Xu


