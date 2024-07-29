Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B31EC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 09:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYMyS-0003b3-Fq; Mon, 29 Jul 2024 05:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sYMyQ-0003T8-Pu
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sYMyP-0004ZE-5O
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722246440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48tv8E771azAG/7TbiDrxaNgby/yNJ6CX75QSGZBrqU=;
 b=E2s1Jz+Nfj1EceA+pkF5qsQtX4iTjOOcDa+7l7RAqPDcMO1hG9kJqtAmyR/RpwXWCViX1z
 xTsjKpHZY1emmQbYY0g6N2wd2EZfaeO8Wko4fVwRLSaOloHjkEWuoWadxlbDlTMkuzpJBv
 78b4pTmXbV7MWzcNHneXVcwciorTvN4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-3pfAfK1HM-2y2Yy-V6PyOQ-1; Mon,
 29 Jul 2024 05:47:16 -0400
X-MC-Unique: 3pfAfK1HM-2y2Yy-V6PyOQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09AA719560B6; Mon, 29 Jul 2024 09:47:15 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.89])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 059A41955F40; Mon, 29 Jul 2024 09:47:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 2/4] scsi-block: Don't skip callback for sgio error
 status/driver_status
Date: Mon, 29 Jul 2024 11:46:59 +0200
Message-ID: <20240729094702.50282-3-kwolf@redhat.com>
In-Reply-To: <20240729094702.50282-1-kwolf@redhat.com>
References: <20240729094702.50282-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Instead of calling into scsi_handle_rw_error() directly from
scsi_block_sgio_complete() and skipping the normal callback, go through
the normal cleanup path by calling the callback with a positive error
value.

The important difference here is not only that the code path is cleaner,
but that the callbacks set r->req.aiocb = NULL. If we skip setting this
and the error action is BLOCK_ERROR_ACTION_STOP, resuming the VM runs
into an assertion failure in scsi_read_data() or scsi_write_data()
because the dangling aiocb pointer is unexpected.

Fixes: a108557bbf ("scsi: inline sg_io_sense_from_errno() into the callers.")
Buglink: https://issues.redhat.com/browse/RHEL-50000
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/scsi-disk.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 3ff6798bde..6e1a5c98df 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2832,16 +2832,6 @@ static void scsi_block_sgio_complete(void *opaque, int ret)
         } else {
             ret = io_hdr->status;
         }
-
-        if (ret > 0) {
-            if (scsi_handle_rw_error(r, ret, true)) {
-                scsi_req_unref(&r->req);
-                return;
-            }
-
-            /* Ignore error.  */
-            ret = 0;
-        }
     }
 
     req->cb(req->cb_opaque, ret);
-- 
2.45.2


