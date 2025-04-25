Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A8BC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8KZJ-0000qd-SK; Fri, 25 Apr 2025 11:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8KZI-0000ng-Jz
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8KZG-0000MY-SU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745593336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yfa3lnOD79mLNG6CZpM8bgqT2DslxkHXpWxQlA717BU=;
 b=apJlwbBxvRSSyG/SEDO8r3QiIc1pjRXgmLLHuiUEKaEtyR2oTSDuoGEKGIxlQAYsvCLbtI
 YZxpm5LdYgmseTrWYSDmeAdRiGCajbjL9aRlJfZQ9dv88PLOafjciYAEkwOpVoziYnW+qx
 jRiI823i/jhYM1RWuBDh1OD2Ry8R1Y8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-LD4h1IPgMemsG4WFSPuAow-1; Fri,
 25 Apr 2025 11:02:14 -0400
X-MC-Unique: LD4h1IPgMemsG4WFSPuAow-1
X-Mimecast-MFC-AGG-ID: LD4h1IPgMemsG4WFSPuAow_1745593332
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A38101955DCE; Fri, 25 Apr 2025 15:02:10 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.183])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7B321800378; Fri, 25 Apr 2025 15:02:06 +0000 (UTC)
Date: Fri, 25 Apr 2025 17:02:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 1/2] scsi-disk: Add native FUA write support
Message-ID: <aAuj7M4pTO0B_WA3@redhat.com>
References: <20250411113036.786841-1-afaria@redhat.com>
 <20250411113036.786841-2-afaria@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411113036.786841-2-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 11.04.2025 um 13:30 hat Alberto Faria geschrieben:
> Simply propagate the FUA flag on write requests to the driver. The block
> layer will emulate it if necessary.
> 
> Signed-off-by: Alberto Faria <afaria@redhat.com>
> ---
>  hw/scsi/scsi-disk.c | 43 ++++++++++---------------------------------
>  1 file changed, 10 insertions(+), 33 deletions(-)

> @@ -416,12 +398,7 @@ static void scsi_dma_complete_noio(SCSIDiskReq *r, int ret)
>  
>      r->sector += r->sector_count;
>      r->sector_count = 0;
> -    if (r->req.cmd.mode == SCSI_XFER_TO_DEV) {
> -        scsi_write_do_fua(r);
> -        return;
> -    } else {
> -        scsi_req_complete(&r->req, GOOD);
> -    }
> +    scsi_req_complete(&r->req, GOOD);
>  
>  done:
>      scsi_req_unref(&r->req);

This (and the same change in scsi_write_complete_noio()) breaks the
handling of VERIFY in scsi_write_data().

I think what VERIFY needs to do after this change is calling
blk_aio_flush() directly, similar to what scsi_read_data() does in the
first && r->needs_fua case.

The READ and WRITE commands look good to me with this change.

Kevin


