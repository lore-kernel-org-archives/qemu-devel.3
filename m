Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61775CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 19:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBGzk-0003u0-2N; Mon, 28 Sep 2026 15:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBGzh-0003pz-Uz
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBGzg-00036p-CY
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790623591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vn77c4xmgQtd5aYh8oz7/HJHR4GnvPwc2cqbNQDVHPY=;
 b=N5b1GpgGzlZ5H8dc7Q8zfqvb72GL5cYnxQ2VP99q0WX0HUN5JPXKzAwK8mm1fnAU1IaSKe
 GxbymTzQF8/hpIGkYuicUOyjdcDJ05MM2lFY/D1pXuDnaAfn5zGPzNYDE1fM6Fvg24nBPh
 ldoDurA3ofjsKa+tA9qU5CEqe2QXt0w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-b600MRGYM7a4ZjVpXvpt-Q-1; Mon,
 28 Sep 2026 15:26:28 -0400
X-MC-Unique: b600MRGYM7a4ZjVpXvpt-Q-1
X-Mimecast-MFC-AGG-ID: b600MRGYM7a4ZjVpXvpt-Q_1790623586
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A18F21954AEF; Mon, 28 Sep 2026 19:26:26 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.217])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D965A5BC; Mon, 28 Sep 2026 19:26:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v3 07/10] qapi: convert/split intros for enums
Date: Mon, 28 Sep 2026 15:25:54 -0400
Message-ID: <20260928192557.509157-8-jsnow@redhat.com>
In-Reply-To: <20260928192557.509157-1-jsnow@redhat.com>
References: <20260928192557.509157-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json | 22 ++++++++++------------
 qapi/ui.json      |  5 ++---
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index e9584f91666..75cbeca185f 100644
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
index 73ee2cb2056..9e3e80a3d70 100644
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


