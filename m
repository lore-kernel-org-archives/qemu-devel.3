Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEB0606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m+NMsxog
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUDO-0002Sg-O7; Thu, 29 Oct 2026 13:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006qI-90
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003bu-LU
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:31 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGCxpD3872930; Thu, 29 Oct 2026 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7JHT3OcPsiZ
 K/xAOfzUU+x0IYKWrF7A41MZKxJ+xpYE=; b=m+NMsxog9LO3kd4ajvyNVJrOmlY
 MkCCb98/fHwBooqlhPh877xdS48IOBN9v7QSDw4HBVKFW9Ma1ouM3x7RWM2oAzUY
 BIkejJQxWs/7eGXXyZZHU924hwsuTLuiJfU55+XD0L8Cg5mNjcukQVubzXPIGf04
 AMX0C286/k4g9UYWWlfIADkGa/LnOC4t1s4+bEIphFZavIoSxgDuQCozdomXA2En
 tDFBxlmPKZvA+DUm28MOjyLhbOKm2LyeRtazq4va/l0lsVXW7CfSC9pSzXOUjQjX
 GIgoFKL+iH9NjiEJDpKfNahzGsaMUfUEg6bvOVbwID6g/CbM6IZ9XNyxkzQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76217qv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiElm2549284; Thu, 29 Oct 2026 17:44:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 69THiEN82549265
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id CF98125856; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 20/20] tests/functional/hexagon: add HLX system-mode tests
Date: Thu, 29 Oct 2026 10:44:13 -0700
Message-ID: <20261029174413.643130-21-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: QJVl4pGIYNhL8SjLq316cv5mWZzLemU7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXyNLawk78WDrz
 457aWxdVht13ELsm3JFflrAEL/l6PHoyGkbTMoucev7io1m56MZ8jUnPIvt8dsZs33GbwJPFbs4
 SnGRyKTKM1xZXtBlNIyddoPSuxbOFYCqmv4/jahW4HU02LpOdGB6NLFQXKBF68mOW+Ow0v83YzR
 3FPVlnC880zmBwAZvXiBomt7YgzNUbzOwNQrEot8ETskj7d0rtPneD/w6HPvG88cV8aoJEdOjkS
 Ch6JLfQB8HvaBEF8CxKyGQi3QqEdTMsclIQopL1uTUHIReQkTIwHqnImGS2QckYDek9JREWaviE
 5fyWAYMfT09B/lV47eK02WqD+dbMRwux55Z+NZqlOwl6oWdsL7LmC7+CFGuO/z7XXetoXQTSa0m
 WE4zdN92CysLGbKt/zt4X/h6tHWGVqKDINLLqPAxVn8+en22FVr88FgWhD7F+Fg+KCbWro+fPS6
 KlFdULDCE4BigI2T5HQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX8Ej/gaE/cVqF
 Ixy+FNqt5mGbJj4FhotQ02rF5pK+gcKNvlDxhTjg9M1y2RMAEf6EqfyZm0DPj4s5jR0ep2iC/SS
 zZdowfibNKmfVYpMOi2/XbmaP5fds+A=
X-Authority-Analysis: v=2.4 cv=Kv3YSmWN c=1 sm=1 tr=0 ts=6ae385ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8
 a=aFkscosF7gRCcwbLR9sA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: QJVl4pGIYNhL8SjLq316cv5mWZzLemU7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Run standalone HLX tests on V85QA_1 using a prebuilt, hash-checked
archive. This avoids requiring the standalone SDK in QEMU's test
build environment.

Cover CCR enable control, enabled execution, values across packets,
VSP accesses and VTCM loads and stores.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 tests/functional/hexagon/meson.build |  2 ++
 tests/functional/hexagon/test_hlx.py | 49 ++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100755 tests/functional/hexagon/test_hlx.py

diff --git a/tests/functional/hexagon/meson.build b/tests/functional/hexagon/meson.build
index 0fd90e491a..cf87ea3211 100644
--- a/tests/functional/hexagon/meson.build
+++ b/tests/functional/hexagon/meson.build
@@ -4,10 +4,12 @@ tests_hexagon_system_thorough = [
   'arch_tests',
   'qcom_dsp_firmware',
   'systests',
+  'hlx',
   'minivm',
 ]
 
 test_hexagon_timeouts = {
   'qcom_dsp_firmware': 240,
   'systests': 180,
+  'hlx': 180,
 }
diff --git a/tests/functional/hexagon/test_hlx.py b/tests/functional/hexagon/test_hlx.py
new file mode 100755
index 0000000000..6adf2f8d49
--- /dev/null
+++ b/tests/functional/hexagon/test_hlx.py
@@ -0,0 +1,49 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from pathlib import Path
+
+from qemu_test import Asset, QemuSystemTest
+
+
+class HLXSystemTests(QemuSystemTest):
+    timeout = 180
+
+    ASSET_TARBALL = Asset(
+        "https://github.com/qualcomm/qemu-hexagon-testing/releases/"
+        "download/v0.3.2/hlx_systests.tar.gz",
+        "8b4340749d48fe33c23726907ac7d533f801e38f0842fb5f46346aa7b3eaa5a7",
+    )
+
+    def run_hlx_test(self, name):
+        self.archive_extract(self.ASSET_TARBALL)
+        kernel = self.scratch_file("bin", name)
+        self.assertTrue(Path(kernel).is_file(), kernel)
+        self.set_machine("V85QA_1")
+        self.set_vm_arg("-display", "none")
+        self.set_vm_arg("-kernel", kernel)
+        self.vm.launch()
+        self.vm.wait(timeout=30)
+        self.assertEqual(self.vm.exitcode(), 0, self.vm.get_log())
+        self.assertIn("PASS", self.vm.get_log())
+
+    def test_ccr(self):
+        self.run_hlx_test("hlx_sys_ccr")
+
+    def test_enable(self):
+        self.run_hlx_test("hlx_sys_enable")
+
+    def test_packet_values(self):
+        self.run_hlx_test("hlx_sys_persist")
+
+    def test_vsp(self):
+        self.run_hlx_test("hlx_sys_vsp")
+
+    def test_vtcm(self):
+        self.run_hlx_test("hlx_sys_vtcm")
+
+
+if __name__ == "__main__":
+    QemuSystemTest.main()
-- 
2.43.0


