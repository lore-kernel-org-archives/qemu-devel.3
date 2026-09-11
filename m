Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E1AC88E56
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x57un-0002DC-KI; Fri, 11 Sep 2026 16:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x57tx-0001Qd-E2
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:31:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x57tv-0005FW-EV
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789158670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojJHZabKSohJ/qkXkEV6skUgdylBLdnUiEREoGq4xMk=;
 b=IX82CkJ/9+j+71pYGDjV1SB/7UVc4pzOuIRF/UM+VLNny6U6z9fgd/7bmcyev13jd61DYZ
 KGU3aeOOnoSKGO+XFw06GhDoBSdnCJHAT0I97XE4BuRPeWI5FU3L49OY/3TlGuvYDWV64Q
 1KNQlPsmHGjpVPWcoNve3bb3eFEcsAs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-waxcx1QCOWCyqs56XWxSOw-1; Fri,
 11 Sep 2026 16:31:06 -0400
X-MC-Unique: waxcx1QCOWCyqs56XWxSOw-1
X-Mimecast-MFC-AGG-ID: waxcx1QCOWCyqs56XWxSOw_1789158664
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7394319540E2; Fri, 11 Sep 2026 20:31:04 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04BB826D; Fri, 11 Sep 2026 20:30:58 +0000 (UTC)
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
Subject: [PATCH 9/9] qapi: split intro sections for inlinable structs
Date: Fri, 11 Sep 2026 16:30:02 -0400
Message-ID: <20260911203002.305316-10-jsnow@redhat.com>
In-Reply-To: <20260911203002.305316-1-jsnow@redhat.com>
References: <20260911203002.305316-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This patch splits the intro/details section for structs which are used
in an inlinable context; i.e. structs used either as arguments for a
command/event, or used as a branch of a union. The QAPI documentation
block for these entities will have their "intro" section removed when
inlined into other contexts, but may still display the intro section
on generated documentation *IF* these structs are also used as an
argument or return type.

Review notes: Same ol' Same ol'.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-export.json | 5 ++---
 qapi/crypto.json       | 3 +--
 qapi/machine.json      | 3 +--
 qapi/qom.json          | 9 +++------
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 77459f6321b..e3cee2fb5ce 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -154,9 +154,8 @@
 
 ##
 # @BlockExportOptionsFuse:
-#
-# Options for exporting a block graph node on some (file) mountpoint
-# as a raw image.
+#     Options for exporting a block graph node on some (file)
+#     mountpoint as a raw image.
 #
 # Multi-threading note: The FUSE export supports multi-threading.
 # Currently, requests are distributed across these threads in a
diff --git a/qapi/crypto.json b/qapi/crypto.json
index f85d1cebed3..5ae07d650a6 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -429,8 +429,7 @@
 
 ##
 # @SecretProperties:
-#
-# Properties for secret objects.
+#     Properties for secret objects.
 #
 # Either @data or @file must be provided, but not both.
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index 05a2851c0fc..b1064b53ae3 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -899,8 +899,7 @@
 
 ##
 # @CpuInstanceProperties:
-#
-# Properties identifying a CPU.
+#     Properties identifying a CPU.
 #
 # Which members are optional and which mandatory depends on the
 # architecture and board.
diff --git a/qapi/qom.json b/qapi/qom.json
index 3de06488768..d80dd5976ed 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -456,8 +456,7 @@
 
 ##
 # @FilterRedirectorProperties:
-#
-# Properties for filter-redirector objects.
+#     Properties for filter-redirector objects.
 #
 # At least one of @indev or @outdev must be present.  If both are
 # present, they must not refer to the same character device backend.
@@ -756,8 +755,7 @@
 
 ##
 # @MemoryBackendShmProperties:
-#
-# Properties for memory-backend-shm objects.
+#     Properties for memory-backend-shm objects.
 #
 # This memory backend supports only shared memory, which is the
 # default.
@@ -771,8 +769,7 @@
 
 ##
 # @MemoryBackendEpcProperties:
-#
-# Properties for memory-backend-epc objects.
+#     Properties for memory-backend-epc objects.
 #
 # The @merge boolean option is false by default with epc
 #
-- 
2.55.0


