Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E13FCEE33B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLP7b-00018O-Ng; Tue, 18 Nov 2025 12:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP7Q-0000lj-D1
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP7P-0004sk-2g
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763485430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mjBgl8TAn/PtNsGljFmCNEuEQkuQYHsGrHeqvArlr9A=;
 b=LL+iBJn17D9YSMWnZqBh+FPuW3uQZK6oxdgKql3bCOiMPHoQQJau7nqXob+mS/BbgKeaGA
 Ix3+UPHiHFIIBwKFFBhNEhaTUpyee4lhweDEcPSYXSmCg5Njl5iWNcTOkRN52RnSmZkVYg
 6HsI1xjWZSvMywFl4aYGSRlPX/cO8vQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-F3CtKBTdMSG6re4Hptz3Tw-1; Tue,
 18 Nov 2025 12:03:42 -0500
X-MC-Unique: F3CtKBTdMSG6re4Hptz3Tw-1
X-Mimecast-MFC-AGG-ID: F3CtKBTdMSG6re4Hptz3Tw_1763485421
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDE9B1800357; Tue, 18 Nov 2025 17:03:40 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 662B0300A88D; Tue, 18 Nov 2025 17:03:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 17/19] iscsi: Create AIO BH in original AioContext
Date: Tue, 18 Nov 2025 18:02:54 +0100
Message-ID: <20251118170256.272087-18-kwolf@redhat.com>
In-Reply-To: <20251118170256.272087-1-kwolf@redhat.com>
References: <20251118170256.272087-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

AIO callbacks must be called in the original request’s AioContext,
regardless of the BDS’s “main” AioContext.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251110154854.151484-18-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/iscsi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 852ecccf0d..7d6bf185ea 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -119,6 +119,7 @@ typedef struct IscsiTask {
 
 typedef struct IscsiAIOCB {
     BlockAIOCB common;
+    AioContext *ctx;
     QEMUBH *bh;
     IscsiLun *iscsilun;
     struct scsi_task *task;
@@ -173,7 +174,7 @@ iscsi_schedule_bh(IscsiAIOCB *acb)
     if (acb->bh) {
         return;
     }
-    acb->bh = aio_bh_new(acb->iscsilun->aio_context, iscsi_bh_cb, acb);
+    acb->bh = aio_bh_new(acb->ctx, iscsi_bh_cb, acb);
     qemu_bh_schedule(acb->bh);
 }
 
@@ -1012,8 +1013,7 @@ static void iscsi_ioctl_handle_emulated(IscsiAIOCB *acb, int req, void *buf)
         ret = -EINVAL;
     }
     assert(!acb->bh);
-    acb->bh = aio_bh_new(bdrv_get_aio_context(bs),
-                         iscsi_ioctl_bh_completion, acb);
+    acb->bh = aio_bh_new(acb->ctx, iscsi_ioctl_bh_completion, acb);
     acb->ret = ret;
     qemu_bh_schedule(acb->bh);
 }
@@ -1030,6 +1030,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
     acb = qemu_aio_get(&iscsi_aiocb_info, bs, cb, opaque);
 
     acb->iscsilun = iscsilun;
+    acb->ctx         = qemu_get_current_aio_context();
     acb->bh          = NULL;
     acb->status      = -EINPROGRESS;
     acb->ioh         = buf;
-- 
2.51.1


