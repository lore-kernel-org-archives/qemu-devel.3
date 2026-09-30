Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE29CA5FBE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrkE-0004k6-Qs; Wed, 30 Sep 2026 06:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrj2-0001co-9t
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrin-0006qs-R9
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QqKK+hSxvqu2B0CaCW8C5gkKcUQoJ7vt2mm3yEPLZM0=;
 b=VRmkpAPvcxRdPNzzuVEg6U6tp2j87UPAdrzCInJGq7c0yt6QREEWJlDvPNQOv50DKIjnbY
 YJMmhLi5tvXkQXS+4XKaisCuzhDWFxeIBcJlnA0KdhZsyFdWjFJjZ4u9mkn1cb9XW/nSP6
 GRfvmvdns4FOZ0GR6VnpKYEmY8GdMjo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711--DvZ_d41MHum3YE1nrZMJw-1; Wed,
 30 Sep 2026 06:39:29 -0400
X-MC-Unique: -DvZ_d41MHum3YE1nrZMJw-1
X-Mimecast-MFC-AGG-ID: -DvZ_d41MHum3YE1nrZMJw_1790764768
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99359195423C; Wed, 30 Sep 2026 10:39:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5229319560AB; Wed, 30 Sep 2026 10:39:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E50EA21E6543; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 082/105] qapi: convert remaining simple intros for cxl.json
Date: Wed, 30 Sep 2026 12:38:47 +0200
Message-ID: <20260930103910.3934848-83-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These are either structs or unions that are used in an inlinable
context: i.e. the generated documentation is likely to feature a
version of this documentation block that does not include the intro in
context of another command, event, or structure.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260917194614.549584-3-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/cxl.json | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 631d4def2a..9422d5a0e2 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -32,9 +32,8 @@
 
 ##
 # @CXLCommonEventBase:
-#
-# Common event base for a CXL Event (CXL r3.2 8.2.10.2.1
-# Table 8-55 Common Event Record Format).
+#     Common event base for a CXL Event (CXL r3.2 8.2.10.2.1 Table
+#     8-55 Common Event Record Format).
 #
 # @path: CXL type 3 device canonical QOM path
 #
@@ -63,8 +62,7 @@
 
 ##
 # @CXLGeneralMediaEvent:
-#
-# Event record for a General Media Event (CXL r3.2 8.2.10.2.1.1).
+#     Event record for a General Media Event (CXL r3.2 8.2.10.2.1.1).
 #
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.2 Table 8-57 General
@@ -129,8 +127,7 @@
 
 ##
 # @CXLDRAMEvent:
-#
-# Event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
+#     Event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
 #
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.2 Table 8-58 DRAM
@@ -211,8 +208,7 @@
 
 ##
 # @CXLMemModuleEvent:
-#
-# Event record for a Memory Module Event (CXL r3.2 8.2.10.2.1.3).
+#     Event record for a Memory Module Event (CXL r3.2 8.2.10.2.1.3).
 #
 # @type: Device Event Type.  See CXL r3.2 Table 8-59 Memory Module
 #     Event Record for bit definitions for bit definiions.
-- 
2.55.0


