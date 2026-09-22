Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49F0C98308
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971m-0007lQ-Rc; Tue, 22 Sep 2026 16:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971R-0005jC-AB
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971P-0000Og-6S
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nqJFO9Zbw4yV2Rp9Ae6R33BSQfpuM1brZMcSKDKzp2w=;
 b=JoKr6rfNbdwduiShnfwziP2H7vVCPpBgwgFQQUVIaVrazN1AysFtKKwcI5KDZDpDb9F0N0
 9/mg0wXUrh2U8E0ReuUXUNM2Kds0poZaIg6dV+cPvHEHgEKwm9Evi5iDAomEJR/pMgWBIi
 3AIKBocX16zlMJBOQ10gf+naMtC3xqE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-NNgnS_SCPJ64wSPMEpruvw-1; Tue,
 22 Sep 2026 16:23:21 -0400
X-MC-Unique: NNgnS_SCPJ64wSPMEpruvw-1
X-Mimecast-MFC-AGG-ID: NNgnS_SCPJ64wSPMEpruvw_1790108600
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21BB3195D013; Tue, 22 Sep 2026 20:23:20 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E1F8418; Tue, 22 Sep 2026 20:23:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:17 +0400
Subject: [PATCH 70/88] qemu-iotests/246: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-70-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3039;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=WPaT+n066L0xfnS5yDo40W78Cd4DPrfdTywG4clNEF4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKzOdvKOAimtpeCUFpM+gMjEP+oRu5djGZYp
 127hoeTdqSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLiswAKCRDa6OEJdZac
 5Yr2EACctB6mlGMuqeiS2TzKVVxRLDpDld6CwC0PYXXfAUULhW/gB7YmJhROoo9BnZ2urk7viCO
 Kb7Er/PRlGfkgx5UhhO8lfN7Dnd3JQyW2J2yo4tln4Wn8yWf16G9sf1wdaMRhx6WTZRVO7MKx0p
 sH8LAU/344tebgqR5xaSuudD47qJjEJfSEk6Gohzlcsl//6fdLFjNJr/N/+NUdv27DHsGv2djl8
 uwr+bIk5i8KgoB7xsvfTj3diI35thvKz/Ocasrgv886ivn+rK8ihVBeRSC/ramwCCdAehK7Mnq/
 g6MXqgbIAS68S1P0Vv0ATTuDKh1zOTzCqR/ZgAuAVayh9QORemM2jTwae8lb2C92fUb3rmdeGrj
 F7BMAlam/kUxRvj6rQeg4sYdbxDJQXQ3Sf5rmH6rPdH5XoxOLeXv4AYfLJGzGhbVtlD2v96RWTJ
 EHjgq/j3VWxWedc4yQLNpW4p3aHjTCkRHx9l32gwKbddVgfKWb2megEN6iyktpRvN9iyDWvTADp
 6yF6mxsRssTqJNMU2nWYu1BTTbpCtsNVQQS1YRyTO1wmEAfTYBtzDumghm0+xgeSlGbbx23gM7P
 1JcngePbgdA+6AZ3zyAymgrxB7hGdxFDfW2k1h1Ft9r35EfyJOS77OlbtZkCQMX/gR363S3j7mP
 wtjNRtPhP9Y/PMA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/246     | 11 +++++------
 tests/qemu-iotests/246.out |  8 ++++----
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/246 b/tests/qemu-iotests/246
index cee5131c3ce4..a821e2cab8ea 100755
--- a/tests/qemu-iotests/246
+++ b/tests/qemu-iotests/246
@@ -24,8 +24,7 @@ import iotests
 from iotests import log
 
 iotests.script_initialize(supported_fmts=['qcow2'],
-                          unsupported_imgopts=['compat'],
-                          require_hmp=True)
+                          unsupported_imgopts=['compat'])
 size = 64 * 1024 * 1024 * 1024
 gran_small = 32 * 1024
 gran_large = 128 * 1024
@@ -69,8 +68,8 @@ with iotests.FilePath('img') as img_path, \
     log('--- Adding new bitmap, growing image, and adding 2nd new bitmap ---')
     vm.qmp_log("block-dirty-bitmap-add", node="drive0",
                name="New", persistent=True)
-    vm.qmp_log("human-monitor-command",
-               command_line="block_resize drive0 70G")
+    vm.qmp_log("block_resize", device="drive0",
+               size=70 * 1024 * 1024 * 1024)
     vm.qmp_log("block-dirty-bitmap-add", node="drive0",
                name="Newtwo", persistent=True)
     log(query_bitmaps(vm), indent=2)
@@ -90,8 +89,8 @@ with iotests.FilePath('img') as img_path, \
                name="New")
 
     log('--- Truncating image ---\n')
-    vm.qmp_log("human-monitor-command",
-               command_line="block_resize drive0 50G")
+    vm.qmp_log("block_resize", device="drive0",
+               size=50 * 1024 * 1024 * 1024)
 
     log('--- Adding "NewC" bitmap, removing "NewTwo" bitmap ---')
     vm.qmp_log("block-dirty-bitmap-add", node="drive0",
diff --git a/tests/qemu-iotests/246.out b/tests/qemu-iotests/246.out
index eeb98ab37c93..dde5bfb6d42c 100644
--- a/tests/qemu-iotests/246.out
+++ b/tests/qemu-iotests/246.out
@@ -88,8 +88,8 @@
 --- Adding new bitmap, growing image, and adding 2nd new bitmap ---
 {"execute": "block-dirty-bitmap-add", "arguments": {"name": "New", "node": "drive0", "persistent": true}}
 {"return": {}}
-{"execute": "human-monitor-command", "arguments": {"command-line": "block_resize drive0 70G"}}
-{"return": ""}
+{"execute": "block_resize", "arguments": {"device": "drive0", "size": 75161927680}}
+{"return": {}}
 {"execute": "block-dirty-bitmap-add", "arguments": {"name": "Newtwo", "node": "drive0", "persistent": true}}
 {"return": {}}
 {
@@ -195,8 +195,8 @@
 {"return": {}}
 --- Truncating image ---
 
-{"execute": "human-monitor-command", "arguments": {"command-line": "block_resize drive0 50G"}}
-{"return": ""}
+{"execute": "block_resize", "arguments": {"device": "drive0", "size": 53687091200}}
+{"return": {}}
 --- Adding "NewC" bitmap, removing "NewTwo" bitmap ---
 {"execute": "block-dirty-bitmap-add", "arguments": {"name": "NewC", "node": "drive0", "persistent": true}}
 {"return": {}}

-- 
2.56.0.rc0.29.g47ce80527c56


