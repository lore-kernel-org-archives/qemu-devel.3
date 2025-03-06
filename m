Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B25C28B22
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 10:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq8Xv-0001p6-AY; Thu, 06 Mar 2025 05:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tq8Xp-0001ne-VO
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:33:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tq8Xj-0008V9-7S
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741257209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lD6Sf+TVxTgz6BVfzLhJ8iXrfuoSY0ZP1efEg8Wzpoo=;
 b=Hh3rETDS6FJJ599/XIOlEI9n86xiszEh4a6+6LTjnajzqhmubAkRFr7EVERU1ajSQKwmJf
 qZXIuOVJQP+EwO2fOtuvDxmp4OGQwdb20lTw4faiUoY8imwtyz49+jT2KNIdHqwUbPX2yH
 r7Rf7HcsQSA+F+8ulB67/nJJJUySX9k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-M-qYRkwaM4CENxojHjnUIw-1; Thu,
 06 Mar 2025 05:33:21 -0500
X-MC-Unique: M-qYRkwaM4CENxojHjnUIw-1
X-Mimecast-MFC-AGG-ID: M-qYRkwaM4CENxojHjnUIw_1741257200
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAD9D1800265; Thu,  6 Mar 2025 10:33:18 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.123])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7353300019E; Thu,  6 Mar 2025 10:33:16 +0000 (UTC)
Date: Thu, 6 Mar 2025 11:33:13 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 2/2] scsi-disk: Add native FUA support
Message-ID: <Z8l56U16vyT7cnvi@redhat.com>
References: <20250304155232.1325581-1-afaria@redhat.com>
 <20250304155232.1325581-3-afaria@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304155232.1325581-3-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 04.03.2025 um 16:52 hat Alberto Faria geschrieben:
> Avoid emulating FUA when the driver supports it natively. This should
> provide better performance than a full flush after the write.
> 
> Signed-off-by: Alberto Faria <afaria@redhat.com>

Did you try out if you can see performance improvements in practice?
It's always nice to have numbers in the commit message for patches that
promise performance improvements.

>  hw/scsi/scsi-disk.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 8cf50845ab..ce48e20ee6 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -43,6 +43,7 @@
>  #include "qemu/cutils.h"
>  #include "trace.h"
>  #include "qom/object.h"
> +#include "block/block_int-common.h"
>  
>  #ifdef __linux
>  #include <scsi/sg.h>
> @@ -75,7 +76,7 @@ struct SCSIDiskClass {
>       */
>      DMAIOFunc       *dma_readv;
>      DMAIOFunc       *dma_writev;
> -    bool            (*need_fua_emulation)(SCSICommand *cmd);
> +    bool            (*need_fua)(SCSICommand *cmd);
>      void            (*update_sense)(SCSIRequest *r);
>  };
>  
> @@ -86,6 +87,7 @@ typedef struct SCSIDiskReq {
>      uint32_t sector_count;
>      uint32_t buflen;
>      bool started;
> +    bool need_fua;
>      bool need_fua_emulation;
>      struct iovec iov;
>      QEMUIOVector qiov;
> @@ -553,7 +555,7 @@ static void scsi_read_data(SCSIRequest *req)
>  
>      first = !r->started;
>      r->started = true;
> -    if (first && r->need_fua_emulation) {
> +    if (first && r->need_fua) {
>          block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, 0,
>                           BLOCK_ACCT_FLUSH);
>          r->req.aiocb = blk_aio_flush(s->qdev.conf.blk, scsi_do_read_cb, r);
> @@ -2384,7 +2386,9 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
>          scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
>          return 0;
>      }
> -    r->need_fua_emulation = sdc->need_fua_emulation(&r->req.cmd);
> +    r->need_fua = sdc->need_fua(&r->req.cmd);
> +    r->need_fua_emulation = r->need_fua &&
> +        (blk_bs(s->qdev.conf.blk)->supported_write_flags & BDRV_REQ_FUA) == 0;

You can just use BDRV_REQ_FUA unconditionally. If the driver doesn't
support it directly, the block layer already emulates it internally. We
don't have to duplicate this here. If scsi_write_data() does a flush
directly for VERIFY (like scsi_read_data() already does),
scsi_write_do_fua() can go away completely.

However, we can only apply this to write requests. We still need to know
that FUA needs to be emulated for reads. scsi_read_data() issues a flush
for FUA requests and your patch would break it if writes support
BDRV_REQ_FUA.

Kevin


