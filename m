Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7375CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWYvZ-0006U3-OK; Mon, 08 Jun 2026 08:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wWYvY-0006TF-6t
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:18:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wWYvW-0005mh-FC
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780921075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wyxThJ+d9WzisyFlw2awAmwU3anIasdCf1s2FgDmfvs=;
 b=ZlkNhWUB1QYxWmKpDZigVg8s4JPaDIQS1zfLEBlNNSEjQj0Z6zLqtTs27sAl7HFbWnBIaX
 dHqO8UiJK4qEPWcEWr/TTgYwl+C3SdxdWwN4I02qthCzITB9ERArHe0k2Fh0Zi17m//wQj
 JQ0SDc/shafgg+msCA5R4VxEKT//i5A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-fMNXT9RNOyi_06BXejyCXQ-1; Mon,
 08 Jun 2026 08:17:52 -0400
X-MC-Unique: fMNXT9RNOyi_06BXejyCXQ-1
X-Mimecast-MFC-AGG-ID: fMNXT9RNOyi_06BXejyCXQ_1780921071
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0682195608B; Mon,  8 Jun 2026 12:17:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B620E3008B34; Mon,  8 Jun 2026 12:17:48 +0000 (UTC)
Date: Mon, 8 Jun 2026 14:17:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Boudewijn van der Heide <boudewijn@delta-utec.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH] block: switch to co_wrapper_mixed for blk_lock_medium()
 and blk_eject()
Message-ID: <aiay6pgFEurQMtrx@redhat.com>
References: <20260530175822.10321-1-boudewijn@delta-utec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530175822.10321-1-boudewijn@delta-utec.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

[Cc: Paolo, Stefan]

Am 30.05.2026 um 19:58 hat Boudewijn van der Heide geschrieben:
> scsi_disk_emulate_command() can be called from a coroutine;
> when req->cmd.buf[0] is ALLOW_MEDIUM_REMOVAL, the synchronous
> blk_lock_medium() is called, which hits assert(!qemu_in_coroutine()),
> and crashes:
> 
> 	qemu-system-hppa: block/block-gen.c:1692: blk_lock_medium:
> 	Assertion `!qemu_in_coroutine()' failed.
> 
> blk_eject() has the same problem, it can be called from coroutine,
> because the same vtable entry (SCSIReqOps.send_command,
> scsi_disk_emulate_command() here) calls blk_eject when req->cmd.buf[0]
> is START_STOP.
> 
> Fix by switching to co_wrapper_mixed for blk_lock_medium() and
> blk_eject() instead of just co_wrapper.
> 
> Signed-off-by: Boudewijn van der Heide <boudewijn@delta-utec.com>

Yes, that will fix your immediate symptoms. I'm not completely sure if
that's the level where we want to fix things, though, which is why I
added Paolo and Stefan to Cc.

> ---
> Observed crash on fedora qemu-10.1.5-1.fc43 on x86_64 host using qemu-system-hppa.
> 
> trace:
> 
> Thread 1 (...):
>         # 5 __assert_fail (...) at assert.c
>         # 6 blk_lock_medium (...) at block/block-gen.c
>         # 7 scsi_disk_emulate_command (...) at ../hw/scsi/scsi-disk.c
>         # 8 scsi_req_enqueue (...) at ../hw/scsi/scsi-bus.c
>         # 9 lsi_do_command (...) at ../hw/scsi/lsi53c895a.c
>         # 10 lsi_execute_script (...) at ../hw/scsi/lsi53c895a.c
>         # 11 scsi_read_complete_noio (...) at ../hw/scsi/scsi-disk.c
>         # 12 blk_aio_complete (...) at ../block/block-backend.c
>         # 14 blk_aio_read_entry (...) at ../block/block-backend.c
>         # 15 in coroutine_trampoline (...) at ../util/coroutine-ucontext.c
> 
> blk_eject() has the same path, but req->cmd.buf[0] is START_STOP instead
> of ALLOW_MEDIUM_REMOVAL inside scsi_disk_emulate_command(),
> so fix that aswell.

This would be useful information to have in the commit message proper.

The step from #10 to #11 seems to be a rather big one that left out
intermediate function calls, so I'm not sure if I fully understand it.

Either way, I don't think lsi_execute_script() and the functions called
by it were ever written with the intention to run in a coroutine. I'm
almost sure that problems can be in more than just the two functions
you're changing here. So my question is mostly, should the path involve
a BH somewhere to break out of coroutine context, instead of making one
or two specific cases work?

If the general feeling is that we do want to make essentially all of the
SCSI code coroutine_mixed_fn and are prepared to fix any issues arising
from it, then this patch is fine as far as I am concerned.

Kevin

> ---
>  include/system/block-backend-io.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/system/block-backend-io.h b/include/system/block-backend-io.h
> index fd84723d9d..7368ad5c09 100644
> --- a/include/system/block-backend-io.h
> +++ b/include/system/block-backend-io.h
> @@ -81,10 +81,10 @@ bool coroutine_fn GRAPH_RDLOCK blk_co_is_available(BlockBackend *blk);
>  bool co_wrapper_mixed_bdrv_rdlock blk_is_available(BlockBackend *blk);
>  
>  void coroutine_fn blk_co_lock_medium(BlockBackend *blk, bool locked);
> -void co_wrapper blk_lock_medium(BlockBackend *blk, bool locked);
> +void co_wrapper_mixed blk_lock_medium(BlockBackend *blk, bool locked);
>  
>  void coroutine_fn blk_co_eject(BlockBackend *blk, bool eject_flag);
> -void co_wrapper blk_eject(BlockBackend *blk, bool eject_flag);
> +void co_wrapper_mixed blk_eject(BlockBackend *blk, bool eject_flag);
>  
>  int64_t coroutine_fn blk_co_getlength(BlockBackend *blk);
>  int64_t co_wrapper_mixed blk_getlength(BlockBackend *blk);
> -- 
> 2.54.0
> 


