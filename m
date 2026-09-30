Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC77CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrkL-0005K7-L9; Wed, 30 Sep 2026 06:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrj3-0001ed-96
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrip-0006rv-I2
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YEdczjgmY/jTF+h++BkZL0wMmaQd1JBLSGyxqDsXCrw=;
 b=aFqks8XlabB2mR2SFMnhpoWBA3oOmQbqHpBTmczTlLj8EvX8upG+xv0uLTxQJv+Ey2Q/1S
 CM2IDmfRhDxxzejk8PjTrxpObw2zAqhppMFdwl7lKAP6DDiDhFm8LX4keE4miuAv1pdFus
 DfxkVtn+NyUm12EFbWvLztlD6NUZkTo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-WLxY_jvlMxqREGOBVn_BIQ-1; Wed,
 30 Sep 2026 06:39:31 -0400
X-MC-Unique: WLxY_jvlMxqREGOBVn_BIQ-1
X-Mimecast-MFC-AGG-ID: WLxY_jvlMxqREGOBVn_BIQ_1790764770
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 752211805A0C; Wed, 30 Sep 2026 10:39:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 337E5195604D; Wed, 30 Sep 2026 10:39:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 42BB821E5D25; Wed, 30 Sep 2026 12:39:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 102/105] qapi: convert/split intros for enums
Date: Wed, 30 Sep 2026 12:39:07 +0200
Message-ID: <20260930103910.3934848-103-armbru@redhat.com>
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
Message-ID: <20260928192557.509157-8-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json | 22 ++++++++++------------
 qapi/ui.json      |  5 ++---
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index e9584f9166..75cbeca185 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -641,9 +641,9 @@
 
 ##
 # @HmatLBMemoryHierarchy:
-#
-# The memory hierarchy in the System Locality Latency and Bandwidth
-# Information Structure of HMAT (Heterogeneous Memory Attribute Table)
+#     The memory hierarchy in the System Locality Latency and
+#     Bandwidth Information Structure of HMAT (Heterogeneous Memory
+#     Attribute Table)
 #
 # For more information about `HmatLBMemoryHierarchy`, see chapter
 # 5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.
@@ -663,9 +663,9 @@
 
 ##
 # @HmatLBDataType:
-#
-# Data type in the System Locality Latency and Bandwidth Information
-# Structure of HMAT (Heterogeneous Memory Attribute Table)
+#     Data type in the System Locality Latency and Bandwidth
+#     Information Structure of HMAT (Heterogeneous Memory Attribute
+#     Table)
 #
 # For more information about `HmatLBDataType`, see chapter 5.2.27.4:
 # Table 5-146: Field "Data Type" of ACPI 6.3 spec.
@@ -726,9 +726,8 @@
 
 ##
 # @HmatCacheAssociativity:
-#
-# Cache associativity in the Memory Side Cache Information Structure
-# of HMAT
+#     Cache associativity in the Memory Side Cache Information
+#     Structure of HMAT
 #
 # For more information of `HmatCacheAssociativity`, see chapter
 # 5.2.27.5: Table 5-147 of ACPI 6.3 spec.
@@ -747,9 +746,8 @@
 
 ##
 # @HmatCacheWritePolicy:
-#
-# Cache write policy in the Memory Side Cache Information Structure of
-# HMAT
+#     Cache write policy in the Memory Side Cache Information
+#     Structure of HMAT
 #
 # For more information of `HmatCacheWritePolicy`, see chapter
 # 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
diff --git a/qapi/ui.json b/qapi/ui.json
index 73ee2cb205..9e3e80a3d7 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -814,10 +814,9 @@
 
 ##
 # @QKeyCode:
+#     An enumeration of key name.
 #
-# An enumeration of key name.
-#
-# This is used by the `send-key` command.
+#     This is used by the `send-key` command.
 #
 # @unmapped: since 2.0
 #
-- 
2.55.0


