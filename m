Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FECCD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 20:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXldV-0001ex-7j; Thu, 11 Jun 2026 16:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXldU-0001ep-Ia
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 16:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wXldS-0002q7-ON
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 16:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781208257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0r32HlIcJ7oWUGfUY0ne0z8m08dIeZLttEyfnEkFhNM=;
 b=KN3m6MibV4T2RjRgUjU9Ikc5CsqNVLGW19X6KNHL9sV9AXaEndAJxolieskp2x2nUlZiE6
 kwo/IloYoFZRS6v7kkpx/DvH8FOCep0ngFC+cGa17B8it3reyooPodJtuNVC0lOifc1OwL
 /yV/mHXey9oi5qQ4qxZmYvfn0snZzrk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-ZRPU7vi-MFWTjZtEHajPCw-1; Thu,
 11 Jun 2026 16:04:12 -0400
X-MC-Unique: ZRPU7vi-MFWTjZtEHajPCw-1
X-Mimecast-MFC-AGG-ID: ZRPU7vi-MFWTjZtEHajPCw_1781208251
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5E68195DBAC; Thu, 11 Jun 2026 20:04:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.171])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1176219540C5; Thu, 11 Jun 2026 20:04:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH] scsi: validate ADDITIONAL LENGTH alignment from READ KEYS
Date: Thu, 11 Jun 2026 16:04:08 -0400
Message-ID: <20260611200409.236980-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

A malicious host SCSI device could report a bogus ADDITIONAL LENGTH
value, causing a memcmp() up to 7 bytes beyond the end of the heap
buffer.

This does not seem to be a practical way to extract the contents of
QEMU's memory since it only happens once per live migration and each
migration destination is a new QEMU process. It doesn't hurt to protect
against it though.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/scsi-generic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 8999f3b720..fb4e3c0f85 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -522,6 +522,13 @@ static bool scsi_generic_pr_key_registered(SCSIDevice *s, uint64_t key,
         memcpy(&additional_length, &buf[4], sizeof(additional_length));
         be32_to_cpus(&additional_length);
 
+        /* The reservation key list consists of 8-byte elements */
+        if (additional_length % sizeof(key_be)) {
+            error_setg(errp, "got misaligned ADDITIONAL LENGTH %" PRIu32
+                       " from READ KEYS", additional_length);
+            return false;
+        }
+
         /*
          * The parameter data's ADDITIONAL LENGTH must not overflow the CDB's
          * 16-bit ALLOCATION LENGTH field since the next loop iteration will
-- 
2.54.0


