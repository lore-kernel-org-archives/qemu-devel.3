Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC52C624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1UP6-00069O-Bo; Tue, 01 Sep 2026 15:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1UP2-00065I-NC
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 15:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1UP0-0002LV-Qt
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 15:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788291854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oxB0WnpYsMCA8Y8mBhhLF3LrR7eMjZay6oToephObeY=;
 b=bEFl2wTgMLOhpzksk19Z3xYo8xYthCHqrl1qOGeHdqtEuUCnqhjHi24MP0l7ehwU3rdXTT
 U1w8qhU75DAzGTTczSt03Eol7jAbI210ygUO6wrdTSC7yz9a9SF4eyRdiokaF968wV5mFU
 n3D9Y352IgCGDyluHfSYNXym5WOKwGw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-6GnqxVBPM3SQ0s9wKS0RBg-1; Tue,
 01 Sept 2026 15:44:11 -0400
X-MC-Unique: 6GnqxVBPM3SQ0s9wKS0RBg-1
X-Mimecast-MFC-AGG-ID: 6GnqxVBPM3SQ0s9wKS0RBg_1788291850
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 818AD1809C8B; Tue,  1 Sep 2026 19:44:09 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DA8A18005BD; Tue,  1 Sep 2026 19:44:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, linux-cxl@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 08/12] qapi: convert simple command intros for cxl.json
Date: Tue,  1 Sep 2026 15:43:20 -0400
Message-ID: <20260901194324.458482-9-jsnow@redhat.com>
In-Reply-To: <20260901194324.458482-1-jsnow@redhat.com>
References: <20260901194324.458482-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/cxl.json | 74 +++++++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 40 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index aef849a4c2a..58ad82c2dc7 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -118,10 +118,9 @@
 
 ##
 # @cxl-inject-general-media-event:
-#
-# Inject an event record for a General Media Event (CXL r3.2
-# 8.2.10.2.1.1).  This event type is reported via one of the event
-# logs specified via the log parameter.
+#     Inject an event record for a General Media Event (CXL r3.2
+#     8.2.10.2.1.1).  This event type is reported via one of the event
+#     logs specified via the log parameter.
 #
 # Since: 8.1
 ##
@@ -201,10 +200,9 @@
 
 ##
 # @cxl-inject-dram-event:
-#
-# Inject an event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
-# This event type is reported via one of the event logs
-# specified via the log parameter.
+#     Inject an event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
+#     This event type is reported via one of the event logs specified
+#     via the log parameter.
 #
 # Since: 8.1
 ##
@@ -267,10 +265,9 @@
 
 ##
 # @cxl-inject-memory-module-event:
-#
-# Inject an event record for a Memory Module Event (CXL r3.2
-# 8.2.10.2.1.3).  This event includes a copy of the Device Health info
-# at the time of the event.
+#     Inject an event record for a Memory Module Event (CXL r3.2
+#     8.2.10.2.1.3).  This event includes a copy of the Device Health
+#     info at the time of the event.
 #
 # Since: 8.1
 ##
@@ -279,13 +276,12 @@
 
 ##
 # @cxl-inject-poison:
-#
-# Poison records indicate that a CXL memory device knows that a
-# particular memory region may be corrupted.  This may be because of
-# locally detected errors (e.g. ECC failure) or poisoned writes
-# received from other components in the system.  This injection
-# mechanism enables testing of the OS handling of poison records which
-# may be queried via the CXL mailbox.
+#     Poison records indicate that a CXL memory device knows that a
+#     particular memory region may be corrupted.  This may be because
+#     of locally detected errors (e.g. ECC failure) or poisoned writes
+#     received from other components in the system.  This injection
+#     mechanism enables testing of the OS handling of poison records
+#     which may be queried via the CXL mailbox.
 #
 # @path: CXL type 3 device canonical QOM path
 #
@@ -382,9 +378,8 @@
 
 ##
 # @cxl-inject-uncorrectable-errors:
-#
-# Command to allow injection of multiple errors in one go.  This
-# allows testing of multiple header log handling in the OS.
+#     Command to allow injection of multiple errors in one go.  This
+#     allows testing of multiple header log handling in the OS.
 #
 # @path: CXL Type 3 device canonical QOM path
 #
@@ -430,12 +425,11 @@
 
 ##
 # @cxl-inject-correctable-error:
-#
-# Command to inject a single correctable error.  Multiple error
-# injection of this error type is not interesting as there is no
-# associated header log.  These errors are reported via AER as a
-# correctable internal error, with additional detail available from
-# the CXL device.
+#     Command to inject a single correctable error.  Multiple error
+#     injection of this error type is not interesting as there is no
+#     associated header log.  These errors are reported via AER as a
+#     correctable internal error, with additional detail available
+#     from the CXL device.
 #
 # @path: CXL Type 3 device canonical QOM path
 #
@@ -510,12 +504,12 @@
 
 ##
 # @cxl-add-dynamic-capacity:
-#
-# Initiate adding dynamic capacity extents to a host.  This simulates
-# operations defined in Compute Express Link (CXL) Specification,
-# Revision 3.1, Section 7.6.7.6.5.  Note that, currently, establishing
-# success or failure of the full Add Dynamic Capacity flow requires
-# out of band communication with the OS of the CXL host.
+#     Initiate adding dynamic capacity extents to a host.  This
+#     simulates operations defined in Compute Express Link (CXL)
+#     Specification, Revision 3.1, Section 7.6.7.6.5.  Note that,
+#     currently, establishing success or failure of the full Add
+#     Dynamic Capacity flow requires out of band communication with
+#     the OS of the CXL host.
 #
 # @path: path to the CXL Dynamic Capacity Device in the QOM tree.
 #
@@ -576,12 +570,12 @@
 
 ##
 # @cxl-release-dynamic-capacity:
-#
-# Initiate release of dynamic capacity extents from a host.  This
-# simulates operations defined in Compute Express Link (CXL)
-# Specification, Revision 3.1, Section 7.6.7.6.6.  Note that,
-# currently, success or failure of the full Release Dynamic Capacity
-# flow requires out of band communication with the OS of the CXL host.
+#     Initiate release of dynamic capacity extents from a host.  This
+#     simulates operations defined in Compute Express Link (CXL)
+#     Specification, Revision 3.1, Section 7.6.7.6.6.  Note that,
+#     currently, success or failure of the full Release Dynamic
+#     Capacity flow requires out of band communication with the OS of
+#     the CXL host.
 #
 # @path: path to the CXL Dynamic Capacity Device in the QOM tree.
 #
-- 
2.55.0


