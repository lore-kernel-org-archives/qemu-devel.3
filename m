Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEEDCA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrkd-0006eK-F2; Wed, 30 Sep 2026 06:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrix-0001YO-LZ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrim-0006pT-4k
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KThs58CDJc4sJ4/95J/iM0XqI88WJdw/EXHS0/mcfMQ=;
 b=fbW22H+1ANHOJX/q5eo4PgFfl2jG1ZJUUjeaFWJlcV3nWe4ctE8rR1vism6Cixl1OhbEW6
 hSM02XcGaWaLyadV7K0FEy+MGhSZ1qIDc7qrf1Tsr7yJSagYs3VGJ99luXz1JjmvLleo6J
 eACQKatm+q55tf8Gkoe55S5M/z8XGNY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-f9wNE96_OuSoD2N2cA3Pvg-1; Wed,
 30 Sep 2026 06:39:23 -0400
X-MC-Unique: f9wNE96_OuSoD2N2cA3Pvg-1
X-Mimecast-MFC-AGG-ID: f9wNE96_OuSoD2N2cA3Pvg_1790764762
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE5381865FCF; Wed, 30 Sep 2026 10:39:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2360A195604D; Wed, 30 Sep 2026 10:39:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 679BC21E6742; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 051/105] qapi: convert simple command intros for cxl.json
Date: Wed, 30 Sep 2026 12:38:16 +0200
Message-ID: <20260930103910.3934848-52-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260901194324.458482-9-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/cxl.json | 74 +++++++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 40 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index aef849a4c2..58ad82c2dc 100644
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


