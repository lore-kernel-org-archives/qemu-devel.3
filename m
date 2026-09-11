Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBDFC88E56
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x57u3-0001RA-Jg; Fri, 11 Sep 2026 16:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x57tU-0001LP-Sf
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x57tR-00056A-Ky
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789158633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4wUqdsl2O9IhVLvQX3iGqy2/Ch7Q/OmKIjKQAdl2Qs0=;
 b=IKiFlbKQgA/SkA0GkCBREpx1ezbXgy9uA6G5G+IoselfNg50ipWV59bQ/9EPh5Ljr5RPUU
 /RIQWh1w1gpsh9thwZMc80PCvO5y7CFHrwBNJ+/8WFIszfr2a3ZE3DYxq0m1nZ6n3wDGzv
 G+1Mlt6vx0t4FT9oV4cgHWkboYljcWE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-Ej4HSaMsP8mvs-kwGRXxug-1; Fri,
 11 Sep 2026 16:30:28 -0400
X-MC-Unique: Ej4HSaMsP8mvs-kwGRXxug-1
X-Mimecast-MFC-AGG-ID: Ej4HSaMsP8mvs-kwGRXxug_1789158627
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FFD818015C3; Fri, 11 Sep 2026 20:30:27 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC2C15C0; Fri, 11 Sep 2026 20:30:21 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowangio@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 3/9] qapi: convert multi-paragraph intros (enums)
Date: Fri, 11 Sep 2026 16:29:56 -0400
Message-ID: <20260911203002.305316-4-jsnow@redhat.com>
In-Reply-To: <20260911203002.305316-1-jsnow@redhat.com>
References: <20260911203002.305316-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch converts some slightly-non-trivial intros with more than
one paragraph, but doesn't create any new intro/details splits.

Review notes: The "See also ..." texts here are prime candidates for
moving into the details section with a ".. seealso::", but like the
last patch, as these are for enums and not candidates as an inline
source, I left them alone for now to keep patch sizes and motion down
until after initial review.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 0516112f8e8..710b638b3bf 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -608,12 +608,12 @@
 
 ##
 # @HmatLBMemoryHierarchy:
+#     The memory hierarchy in the System Locality Latency and
+#     Bandwidth Information Structure of HMAT (Heterogeneous Memory
+#     Attribute Table)
 #
-# The memory hierarchy in the System Locality Latency and Bandwidth
-# Information Structure of HMAT (Heterogeneous Memory Attribute Table)
-#
-# For more information about `HmatLBMemoryHierarchy`, see chapter
-# 5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.
+#     For more information about `HmatLBMemoryHierarchy`, see chapter
+#     5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.
 #
 # @memory: the structure represents the memory performance
 #
@@ -630,12 +630,12 @@
 
 ##
 # @HmatLBDataType:
+#     Data type in the System Locality Latency and Bandwidth
+#     Information Structure of HMAT (Heterogeneous Memory Attribute
+#     Table)
 #
-# Data type in the System Locality Latency and Bandwidth Information
-# Structure of HMAT (Heterogeneous Memory Attribute Table)
-#
-# For more information about `HmatLBDataType`, see chapter 5.2.27.4:
-# Table 5-146: Field "Data Type" of ACPI 6.3 spec.
+#     For more information about `HmatLBDataType`, see chapter
+#     5.2.27.4: Table 5-146: Field "Data Type" of ACPI 6.3 spec.
 #
 # @access-latency: access latency (nanoseconds)
 #
@@ -693,12 +693,11 @@
 
 ##
 # @HmatCacheAssociativity:
+#     Cache associativity in the Memory Side Cache Information
+#     Structure of HMAT
 #
-# Cache associativity in the Memory Side Cache Information Structure
-# of HMAT
-#
-# For more information of `HmatCacheAssociativity`, see chapter
-# 5.2.27.5: Table 5-147 of ACPI 6.3 spec.
+#     For more information of `HmatCacheAssociativity`, see chapter
+#     5.2.27.5: Table 5-147 of ACPI 6.3 spec.
 #
 # @none: None (no memory side cache in this proximity domain, or cache
 #     associativity unknown)
@@ -714,12 +713,12 @@
 
 ##
 # @HmatCacheWritePolicy:
+#     Cache write policy in the Memory Side Cache Information
+#     Structure of HMAT
 #
-# Cache write policy in the Memory Side Cache Information Structure of
-# HMAT
-#
-# For more information of `HmatCacheWritePolicy`, see chapter
-# 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
+#     For more information of `HmatCacheWritePolicy`, see chapter
+#     5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3
+#     spec.
 #
 # @none: None (no memory side cache in this proximity domain, or cache
 #     write policy unknown)
-- 
2.55.0


