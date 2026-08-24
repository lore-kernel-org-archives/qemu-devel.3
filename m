Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C330C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyX4c-0005HH-9l; Mon, 24 Aug 2026 11:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4Z-0005Ew-Qr
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4W-0001nd-TL
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:55 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFne033785261
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=exF0SEsRCLh
 WmVNU1hzf4y3Jm9bo7VDGn1o53kagov8=; b=Sv2Ac0BczXEzcz4ibtoQ7fEkgWU
 vt22JDm/mDP356raMck/pTqEaDJfEEXS7EcYoRvGHO5he+LUIW1Q+w84lOsum4/v
 zmW4oJ2b1qgXy3GDWjl/DXokcMhlnyX86l9SgxF2akRWBcSGUFb+BodOZSxgxzVx
 zpqLhMc0pSCrxzVf4T8sK1te5xo4clC+0xTj5hCly/OxsIlcygdmZyr+kPC8Eyn3
 4YHZCggl4JBufRupAZ/Geys2GKsNEy87C3eNTOerbCqyOBXrxtZhNKMG1GjHqczn
 j6w2oWp+2wkghoy1zlAElja85TUnDYfKeiYT2JLtQgoDnx2uiW7maESE7pg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hjgt4u6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e6d253330so44044a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787587121; x=1788191921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=exF0SEsRCLhWmVNU1hzf4y3Jm9bo7VDGn1o53kagov8=;
 b=Tteh2IUfGWJSuNoxM2R7DZf73DfA6f4JcyODTWcrq6TGzb8TVLq9IoCzFEH0U4lvme
 rbU/2x6AbfEqYc2+HFeifp57jQbdJ5VwAr2bdCpXc+O24TkJVwtLrYgEI/tXK3+jxXef
 944UL4g9mHKJw16irhhUcmOoByDSJLpkwN7Gmi/R0R6ZfcYAyYTW2gvJ2c80a5vWzu6I
 8fSHQYbYhGTkgGCIQOudI3PKyaS1W62DKmQWv+3qcY3FuLoWGtzdgDAmVRgXJPJoaeSL
 U/1frFivhTY1Z78Zsrpj9rkDXaBa4yqcbQuCYkXm2FHxrXYXSDBa/bmB/hLgpPvD0u2/
 jUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587121; x=1788191921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=exF0SEsRCLhWmVNU1hzf4y3Jm9bo7VDGn1o53kagov8=;
 b=F14X+n5ZEiYM+bH+ukuVj+Ud37R9+078tHCRoggEGaZi96QJNSUNAjwhXVosiKyEEJ
 JvjzOS4WNDYsJM8w7y9yKlxPN91SyhMdh0t/meJdbKbwSK8jTyUWzt/AA+yYea28BtUO
 Ga7L+fkSI3WAu8q+MEO3j6699hxSlII3t1K53KNdQ2Yur/P3zY9MbBrvwCFjUSq1Qtc8
 crNCc6DM5N+9Gw6edLFxpfc6bE+qrFxMn7TkCQDeDKCuZmIRJ1Au6ABZUxUgHumZ6Fzu
 MK6elo1nNeNt57JJpzXwlqsNmbyFRMcrMfJm54n/svwVSMeBBEEViFv7PKkxT+bDiMOW
 RWVA==
X-Gm-Message-State: AFuF++mxtx05hzUF3R9Svon0G7xTaTbEhf+JRpF9UyKo0P+00mKCo4wu
 iQzOzxy7xmZEk1RDcRRbdqSaNupCRsXLkKC8T4/9ivGKFj70AxePKW4QbyA55zZpdOzYD0Ahaim
 XTDoMOCAzfff/nWvDB2JeIeaHub/D7M6YZSjzwUpPqQ1h5Ya0y0eEvNVso5oYN1wevQ==
X-Gm-Gg: AR+sD11WcRO292KlzdOpO76VLKDUQoCcARdm1puQY/lLlO+jZk00Xl23klx9sZYlxyj
 SISjaYmQidH28GLB+AOfBxIM/EMQRkvD+qqmakho/cLzgB8PyjMqMsUSVvVnf7GgnCUa45Q9vw/
 BdbKo3F0+wlrcQhXOXElUuyxp6Mxb9bKc1docC8CcHMUJqcOR5MX5DFMRVji0XryTBJqVEicsri
 kJnXW+IYhXDExIigG/pPDTseJ9QrSJsQ7zlBXR6TnwPNh+ZLJG/8a8fKe0eUbbqiQHqeBuaCJuA
 II3yx7skwdyUAkKRAspT3mJ3MQGC3cSh5U2YCetwpClQ/GJddGWaa2G9QpBS5gfT9iuI/xugT8p
 brQk+n1NeLNjf2ZbpDJrisluJBzqqNG8QDuRqp9tmZNlIilPXWxv8XdCKIDAByOs=
X-Received: by 2002:a17:90b:3844:b0:37f:a913:1554 with SMTP id
 98e67ed59e1d1-39645acc458mr152860a91.16.1787587120947; 
 Mon, 24 Aug 2026 08:58:40 -0700 (PDT)
X-Received: by 2002:a17:90b:3844:b0:37f:a913:1554 with SMTP id
 98e67ed59e1d1-39645acc458mr152813a91.16.1787587120493; 
 Mon, 24 Aug 2026 08:58:40 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186183c0esm41152935c88.12.2026.08.24.08.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:58:39 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v4 14/14] tests/functional: Add hexagon semihosting systests
Date: Mon, 24 Aug 2026 08:58:23 -0700
Message-Id: <0aab35393dcbd5e3e6d19d92287a9af558679460.1787586642.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfXxH2b4Oc6aPaV
 NugjtFi706x9i1w6uANz7pAAxCnpf//GeJHukghwiYqYDuE3gzRsXqpO05kl4SxWa/ARcDYaU5M
 DPF8XS14FmV4LPgZ7pTQ5oSFJk6GYP8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX/hwsBE0VSGCu
 XhnJ4PaQC3djkMl3PXvBgObaW3W/Hi77D/00hr1uoIkvpRy+zex6aGucWEO14Hmt+lLkdNWFpxF
 Kc+ZmxZ0gufBKFlkEumNDMa3OdQQMT3OG4QTr29ZllRpx50+15A1Nq/1TOWO2Rf/JNCXgRrD/Lm
 cKnGprC2DRufCKEkfJwu8KmcF14rZWdk1sStShSgRQ1eSzU0Lm/72rcrEOS4fUJGKHalGlufYAH
 +jhv+jiQyzAFSPiRCnaKCWvChiJtuNVMIbs2Gq6T1++fEFkuSz7SpKGq9oELTS+1PbIj9oYf+S9
 fmEBsfT3ubA4Zm975QkQZiNMaGfBBHVnSmt0SDy8TqNT3/X09H6jAYfG9jYkt6bvSaRrm2/KVcQ
 bKpbYPEiJbI5Xkj3vO6EC0XMdyjgjL+7hdQ3dfcvGs3nsGg+RNQifmavxfot9nGAPiFwXlVQ/k8
 HKvLUSw5oqLYUwfkMmQ==
X-Proofpoint-ORIG-GUID: e27GiykFtvn3FsJ320BLEenfsrJCab8_
X-Authority-Analysis: v=2.4 cv=CoCPtH4D c=1 sm=1 tr=0 ts=6a8c6a31 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=5vFef2XoAAAA:20
 a=EUspDBNiAAAA:8 a=gC5wIKLFQIU-z-kLmxwA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: e27GiykFtvn3FsJ320BLEenfsrJCab8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 tests/functional/hexagon/meson.build      |  5 ++
 tests/functional/hexagon/test_systests.py | 94 +++++++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100755 tests/functional/hexagon/test_systests.py

diff --git a/tests/functional/hexagon/meson.build b/tests/functional/hexagon/meson.build
index 2b5a1a8f26..44053e6467 100644
--- a/tests/functional/hexagon/meson.build
+++ b/tests/functional/hexagon/meson.build
@@ -2,4 +2,9 @@
 
 tests_hexagon_system_thorough = [
   'arch_tests',
+  'systests',
 ]
+
+test_hexagon_timeouts = {
+  'systests': 180,
+}
diff --git a/tests/functional/hexagon/test_systests.py b/tests/functional/hexagon/test_systests.py
new file mode 100755
index 0000000000..f36e015f50
--- /dev/null
+++ b/tests/functional/hexagon/test_systests.py
@@ -0,0 +1,94 @@
+#!/usr/bin/env python3
+#
+# Copyright(c) Qualcomm Innovation Center, Inc. All Rights Reserved.
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import re
+import time
+import unittest
+
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
+
+
+_TARBALL_BIN_PATH = (
+    "systests_standalone_package",
+    "StandaloneSysTests_6.4.0.2_v68",
+    "bin",
+)
+
+class SysTestsStandaloneTests(QemuSystemTest):
+    SYSTEST_TIMEOUT_SEC = 30
+
+    ASSET_TARBALL = Asset(
+        "https://github.com/qualcomm/qemu-hexagon-testing/releases/download/v0.2.11/systests_standalone.tar.gz",
+        "b5777aa65245de7710a7a08d717953c1362be7c8b60d9014c9fee8b17610ad1c",
+    )
+
+    def setUp(self):
+        super().setUp()
+        self.archive_extract(self.ASSET_TARBALL)
+
+    def binary(self, name):
+        path = self.scratch_file(*_TARBALL_BIN_PATH, name)
+        self.assertTrue(os.path.exists(path))
+        return path
+
+    def run_exit_zero(self, binary_name, *extra_args, machine="V66G_1024"):
+        self.set_machine(machine)
+        self.set_vm_arg("-display", "none")
+        self.set_vm_arg("-kernel", self.binary(binary_name))
+        for flag, value in zip(extra_args[::2], extra_args[1::2]):
+            self.set_vm_arg(flag, value)
+        self.vm.launch()
+        self.vm.wait(timeout=60.0)
+        self.assertEqual(self.vm.exitcode(), 0,
+                         f"Test {binary_name} exited with "
+                         f"code {self.vm.exitcode()}, expected 0")
+
+    def run_console_pattern(self, binary_name, pattern, *extra_args,
+                            machine="V66G_1024"):
+        self.set_machine(machine)
+        self.set_vm_arg("-display", "none")
+        self.set_vm_arg("-kernel", self.binary(binary_name))
+        for flag, value in zip(extra_args[::2], extra_args[1::2]):
+            self.set_vm_arg(flag, value)
+        self.vm.set_console(semihosting=True)
+        self.vm.launch()
+        try:
+            wait_for_console_pattern(self, pattern)
+        finally:
+            self.vm.kill()
+
+    def test_fopen(self):
+        """fopen reads a file passed via --append and verifies its contents."""
+        import tempfile
+        # The fopen binary has a short cmdline buffer; use a short path.
+        dummy = os.path.join(tempfile.gettempdir(), "qemu_fopen_test.so")
+        with open(dummy, "w") as f:
+            f.write("valid\n")
+        self.run_exit_zero("fopen", "-append", dummy)
+
+    def test_ftrunc(self):
+        """ftrunc truncates _testfile_ftrunc from 6 bytes to 1 byte."""
+        ftrunc_path = self.scratch_file("_testfile_ftrunc")
+        with open(ftrunc_path, "w") as f:
+            f.write("valid\n")
+        # Sleep 1 s so mtime change is observable
+        time.sleep(1)
+        self.run_exit_zero("ftrunc", "-append", ftrunc_path)
+        self.assertEqual(os.path.getsize(ftrunc_path), 1,
+                         "_testfile_ftrunc should be 1 byte after ftrunc")
+
+    def test_access(self):
+        """access checks R_OK|W_OK on _testfile_access."""
+        testfile = self.scratch_file("_testfile_access")
+        with open(testfile, "w") as f:
+            f.write("valid\n")
+        self.run_exit_zero("access", "-append", testfile)
+
+    def test_semihost(self):
+        self.run_console_pattern("semihost", "PASS", "-append", "arg1", "arg2")
+
+if __name__ == "__main__":
+    QemuSystemTest.main()
-- 
2.37.2


