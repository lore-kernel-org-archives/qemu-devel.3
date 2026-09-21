Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4720DC982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8l5g-0005jx-SF; Mon, 21 Sep 2026 16:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x8l5K-0005bn-3U
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x8l5G-0003d5-0J
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790024272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FhC9+EyQuQfdNCJkMIalX3nmZlPTjCLuc8ixrTiDyYU=;
 b=NysDXK7KF1pjO8pvo+8D24ghxysVMFy43r+s0TUMgasTUUNxy1Jd9WmEh0bpV0jWliAWF+
 o7GN3fTjs3JIKLhnDdIT7un+cn2YMmH20jleBULGZJP6Oyqly6sWzyvLtedtnjIEwHngdd
 eZSFj5zGTL/wabr0A2Y96689tTFqGlM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-YR8IM5GcPYy8eeg5TXudZg-1; Mon,
 21 Sep 2026 16:57:48 -0400
X-MC-Unique: YR8IM5GcPYy8eeg5TXudZg-1
X-Mimecast-MFC-AGG-ID: YR8IM5GcPYy8eeg5TXudZg_1790024266
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A22AB1933E27; Mon, 21 Sep 2026 20:57:46 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.125])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE7921956042; Mon, 21 Sep 2026 20:57:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Snow <jsnow@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 09/10] qapi: split intro sections for data structs
Date: Mon, 21 Sep 2026 16:57:11 -0400
Message-ID: <20260921205712.1862167-10-jsnow@redhat.com>
In-Reply-To: <20260921205712.1862167-1-jsnow@redhat.com>
References: <20260921205712.1862167-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The structs of concern in this patch are those for which no other QAPI
definition uses as a data type to describe its own arguments or as a
branch of a union: i.e. they are not currently inlined and as such the
precise semantics of their intro/details split is *currently* of less
concern.

Of course, they could be inlined in the future, so the semantics of
this split are still worth investigating.

Review notes: Similar notes as previous patches in this series with
respect to how splits were determined, and why details were not
physically relocated.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/acpi.json       | 3 +--
 qapi/block-core.json | 5 ++---
 qapi/compat.json     | 3 +--
 qapi/machine.json    | 9 ++++-----
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/qapi/acpi.json b/qapi/acpi.json
index 291a04a7ea4..82e82d7cf89 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -13,8 +13,7 @@
 
 ##
 # @AcpiTableOptions:
-#
-# Specify an ACPI table on the command line to load.
+#     Specify an ACPI table on the command line to load.
 #
 # At most one of @file and @data can be specified.  The list of files
 # specified by any one of them is loaded and concatenated in order.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 13981d7e69d..741c8165c06 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -843,9 +843,8 @@
 
 ##
 # @BlockMeasureInfo:
-#
-# Image file size calculation information.  This structure describes
-# the size requirements for creating a new image file.
+#     Image file size calculation information.  This structure
+#     describes the size requirements for creating a new image file.
 #
 # The size requirements depend on the new image file format.  File
 # size always equals virtual disk size for the 'raw' format, even for
diff --git a/qapi/compat.json b/qapi/compat.json
index ef1853b9acd..b42d142ddcc 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -37,8 +37,7 @@
 
 ##
 # @CompatPolicy:
-#
-# Policy for handling deprecated management interfaces.
+#     Policy for handling deprecated management interfaces.
 #
 # This is intended for testing users of the management interfaces.
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index 00a03e57b98..b18c6d94a38 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1629,9 +1629,9 @@
 
 ##
 # @SMPConfiguration:
-#
-# Schema for CPU topology configuration.  A missing value lets QEMU
-# figure out a suitable value based on the ones that are provided.
+#     Schema for CPU topology configuration.  A missing value lets
+#     QEMU figure out a suitable value based on the ones that are
+#     provided.
 #
 # The members other than @cpus and @maxcpus define a topology of
 # containers.
@@ -1890,8 +1890,7 @@
 
 ##
 # @CpuModelInfo:
-#
-# Virtual CPU model.
+#     Virtual CPU model.
 #
 # A CPU model consists of the name of a CPU definition, to which delta
 # changes are applied (e.g. features added/removed).  Most magic
-- 
2.55.0


