Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89CAC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971n-0007z5-QM; Tue, 22 Sep 2026 16:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971I-0004kB-HL
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971G-0000N7-Qz
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uo+DvqGml9/takpc/k7aJ516ia5DpBKk/tqAgtISoeU=;
 b=Eh+DkQbNI/igNciw0+5DlapJcNzowdlf6QCmwZgOVLyp3trbDQNZlhNuKsnqA4KrmUy6Nk
 /qK+0D9hx2VU1lIrgN6YtyO7IvMmIhEnSCgApVOIxrICj61kZVcyRrk87535knKNiOG9nM
 q8EIm3KvgUvOFnLyQTDBC3Q1JXZvbc0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-n81VHSN4P3-CxGR2DgGecA-1; Tue,
 22 Sep 2026 16:23:10 -0400
X-MC-Unique: n81VHSN4P3-CxGR2DgGecA-1
X-Mimecast-MFC-AGG-ID: n81VHSN4P3-CxGR2DgGecA_1790108589
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 875461953972; Tue, 22 Sep 2026 20:23:09 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A99461956086; Tue, 22 Sep 2026 20:23:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:14 +0400
Subject: [PATCH 67/88] qemu-iotests/luks-detached-header: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-67-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hyman Huang <infra.ai.cloud@bitdeer.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3080;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MeCIMLJly3FZzybm5mEs0AMwwlJzFXGutdAKehEenOQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKzgnWPUwwKDmMkAsICpMAFWZkTjjtcSgq7B
 KUMWvpNGaqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLiswAKCRDa6OEJdZac
 5Q54D/9x4uGlW/Fx0PQeQoIkgx0lmpszwh5bMgHKvTN7BHZ4YIfnW59I9W7Fgk75AZbY4MibTWw
 PFaNedEph/ezK98K23YVE2+/8npQsbeg/XqRS5f9DzNTzB6vjXScU+BE1385CmkIeNlDwcgtKdE
 yC1ll5jjxsOXbwLYwLdnamHn76iffzDpoXrkhnVSf6KYgfGMwZSzr4EyuxczaVsF4tXZu0wEj4G
 t5op4iRbu1DfpxENHivNgtamPaf1Nvz9Nzc5t1NqE9yHkN4PPH6It2ynLosX6XFimb15XvxknDN
 B1yVCERGNnjEM4wco0KiVuWmMd/6t71cfRcT0YGnMAW8815O3YxFle19kmhOoOaAnxBranGsMGz
 qiCOj8DuSv0EJLw8p/we3svdNyf/JTMRF3Auev3bnuxOUkPGXLM3bUfaB4SJa4/5UDET7Byruzc
 yQfh99N/MpM8aF9npyrcsHdOoVbAdq4GZSyxz8FI6ComeXy92i2SMvRbaBJpHT1jp+x+WaYGcLf
 9HVJL5gNov5s8wzGJ0MbicMXhSxIuFqLUQ0VHh5XyYqXK6tVc4i6Pa2A1rL1bzsz6V+tymS3b95
 mREHR5k8LAgS4bgs7C0Zn3934kdBXmGxqGjvOtAZVkb74sV4XBt2OQYX4ze0N7ctchTkRDcB4ip
 jK/5ezN4+sl1Jsg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/tests/luks-detached-header | 49 +++++++--------------------
 1 file changed, 13 insertions(+), 36 deletions(-)

diff --git a/tests/qemu-iotests/tests/luks-detached-header b/tests/qemu-iotests/tests/luks-detached-header
index 58eb3c2cc484..fbf812902832 100755
--- a/tests/qemu-iotests/tests/luks-detached-header
+++ b/tests/qemu-iotests/tests/luks-detached-header
@@ -266,52 +266,29 @@ class TestDetachedLUKSHeader(QMPTestCase):
         # (Pattern verification will be checked by tearDown())
 
         # Normal LUKS disk
-        result = self.vm.qmp_log(
-            "human-monitor-command",
-            command_line='qemu-io luks-1-format "write -P 40 0 64k"',
-        )
-        self.assert_qmp(result, "return", "")
+        self.vm.qmp_qemu_io("luks-1-format", "write -P 40 0 64k",
+                            use_log=True)
 
-        result = self.vm.qmp_log(
-            "human-monitor-command",
-            command_line='qemu-io luks-1-format "read -P 40 0 64k"',
-        )
-        self.assert_qmp(result, "return", "")
+        self.vm.qmp_qemu_io("luks-1-format", "read -P 40 0 64k",
+                            use_log=True)
 
         # Detached LUKS header with raw payload
-        cmd = 'qemu-io luks-2-payload-raw-format "write -P 41 0 64k"'
-        result = self.vm.qmp(
-            "human-monitor-command",
-            command_line=cmd
-        )
-        self.assert_qmp(result, "return", "")
+        self.vm.qmp_qemu_io("luks-2-payload-raw-format",
+                            "write -P 41 0 64k")
 
-        cmd = 'qemu-io luks-2-payload-raw-format "read -P 41 0 64k"'
-        result = self.vm.qmp(
-            "human-monitor-command",
-            command_line=cmd
-        )
-        self.assert_qmp(result, "return", "")
+        self.vm.qmp_qemu_io("luks-2-payload-raw-format",
+                            "read -P 41 0 64k")
 
         # Detached LUKS header with qcow2 payload
-        cmd = 'qemu-io luks-3-payload-qcow2-format "write -P 42 0 64k"'
-        result = self.vm.qmp(
-            "human-monitor-command",
-            command_line=cmd
-        )
-        self.assert_qmp(result, "return", "")
+        self.vm.qmp_qemu_io("luks-3-payload-qcow2-format",
+                            "write -P 42 0 64k")
 
-        cmd = 'qemu-io luks-3-payload-qcow2-format "read -P 42 0 64k"'
-        result = self.vm.qmp(
-            "human-monitor-command",
-            command_line=cmd
-        )
-        self.assert_qmp(result, "return", "")
+        self.vm.qmp_qemu_io("luks-3-payload-qcow2-format",
+                            "read -P 42 0 64k")
 
         self.vm.shutdown()
 
 
 if __name__ == "__main__":
     # Test image creation and I/O
-    iotests.main(supported_fmts=["luks"], supported_protocols=["file"],
-                 require_hmp=True)
+    iotests.main(supported_fmts=["luks"], supported_protocols=["file"])

-- 
2.56.0.rc0.29.g47ce80527c56


