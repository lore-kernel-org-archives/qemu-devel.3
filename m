Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CE3C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 09:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYMyV-0003ld-1R; Mon, 29 Jul 2024 05:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sYMyT-0003fy-Ji
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sYMyR-0004Zn-Ux
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722246443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0wnr40qX08cenRnF3CsAJ3sHAxL0CaU6cGuLQaGj+Q=;
 b=KNQu1MreNZGX0CuotJWExbQyb+URwzuzejMGznY/mt6W9L6EmkpQuNEslP8RFk6464OCk6
 t2ezj75JksNnYVuiDx8zIiebb+d2FcxABHd9S3YPpY6pIdlHNjxgEe3GTxrZuObbi4hQhf
 DDmvbRkXIpEdN2mBrMPwVGZQAw40Pls=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-1Mj4EAV3PbahTWps2-nhHg-1; Mon,
 29 Jul 2024 05:47:20 -0400
X-MC-Unique: 1Mj4EAV3PbahTWps2-nhHg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7C781955D4E; Mon, 29 Jul 2024 09:47:19 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.89])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8EA931955F3B; Mon, 29 Jul 2024 09:47:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 4/4] scsi-disk: Always report RESERVATION_CONFLICT to guest
Date: Mon, 29 Jul 2024 11:47:01 +0200
Message-ID: <20240729094702.50282-5-kwolf@redhat.com>
In-Reply-To: <20240729094702.50282-1-kwolf@redhat.com>
References: <20240729094702.50282-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

RESERVATION_CONFLICT is not a backend error, but indicates that the
guest tried to make a request that it isn't allowed to execute. Pass the
error to the guest so that it can decide what to do with it.

Without this, if we stop the VM in response to a RESERVATION_CONFLICT,
it can happen that the VM cannot be resumed any more because every
attempt to resume it immediately runs into the same error and stops the
VM again.

One case that expects RESERVATION_CONFLICT errors to be visible in the
guest is running the validation tests in Windows 2019's Failover Cluster
Manager, which intentionally tries to execute invalid requests to see if
they are properly rejected.

Buglink: https://issues.redhat.com/browse/RHEL-50000
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/scsi-disk.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 69a195177e..e173b238de 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -235,11 +235,17 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int ret, bool acct_failed)
     } else {
         /* A passthrough command has completed with nonzero status.  */
         status = ret;
-        if (status == CHECK_CONDITION) {
+        switch (status) {
+        case CHECK_CONDITION:
             req_has_sense = true;
             error = scsi_sense_buf_to_errno(r->req.sense, sizeof(r->req.sense));
-        } else {
+            break;
+        case RESERVATION_CONFLICT:
+            /* Don't apply the error policy, always report to the guest */
+            break;
+        default:
             error = EINVAL;
+            break;
         }
     }
 
@@ -249,8 +255,9 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int ret, bool acct_failed)
      * are usually retried immediately, so do not post them to QMP and
      * do not account them as failed I/O.
      */
-    if (req_has_sense &&
-        scsi_sense_buf_is_guest_recoverable(r->req.sense, sizeof(r->req.sense))) {
+    if (!error || (req_has_sense &&
+                   scsi_sense_buf_is_guest_recoverable(r->req.sense,
+                                                       sizeof(r->req.sense)))) {
         action = BLOCK_ERROR_ACTION_REPORT;
         acct_failed = false;
     } else {
-- 
2.45.2


