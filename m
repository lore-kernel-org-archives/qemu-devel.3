Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F158C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7GA3-0002jN-LW; Thu, 17 Sep 2026 13:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x7G9t-0002VW-Vw
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:44:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x7G9q-0001bw-Ge
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:44:29 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HH5W0l1765990
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qVPDT80RNxa
 hzZkfl9aXFi7EzawTflhGPhX2B9euNrY=; b=E2JQUmIUr0/Bq7zcjgpcCNgj/X7
 UGqzEDn01gAv2mbWt2svpkulb2IpAj2zZ6Eyt+xwOU9hx4OVZZU0SxW8dPrsVu8q
 HrLp60PeUc0uV+bCTHS8FTA/9mYBKa0GFwDhOCerav/jn2IsB6QZgGmRw8cIE69x
 vl6ji6zr2yih42zHw2trbRaJi+gWAQBUvhe2/9FTcU+v3wqlDRzpjSHabrqgD/Zw
 nIKVTGKKoxMIr9vGVaa2adqo1gV/JUjjYe18ZdQ3ZZcjGDRD2g8BSlwHY3ZcbcH7
 1MZbetOSgALJQFnuV0RUGeYhO1YQZfXNQ48r2vqRqF2+Xtk8HcClS780t7Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grcraajtn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:44:24 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9124b265371so19426186d6.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 10:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789667063; x=1790271863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qVPDT80RNxahzZkfl9aXFi7EzawTflhGPhX2B9euNrY=;
 b=fkKuCVi25bY0nRCxRMW5ANBMwKvDA1RyECWlV2Jof494pvQS1CT/LKCzCsQrns7bDg
 7U5JEImNa3HQZRUsox1m876h8oMmXpVoSVd8nobet84WZSgjRGJEIZ6G22Nq/OkAmVuS
 TVAWE2u6aHSgH3Ro6t937FzrehREa2xdEHtnZr4SkvKJIedEoqzK9xGea/osPm3Ya5kT
 V9emC4gW+38I7rl2L92YSWQ4eC8zzn95omLGnd/xgcOouy1drhOsJcl/aPqdVuyKJUqW
 9QgkyuHlbgwNdnVDY+elPRr+rXbdJG0hba/FuNHCbHRQdvdlQluuBRc6eIBCzegoCcxp
 9pUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789667063; x=1790271863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qVPDT80RNxahzZkfl9aXFi7EzawTflhGPhX2B9euNrY=;
 b=1DCXEh2TXZ6SpLWQZt4VvvvTwIRDFf1DRNhWseD//jAdMofOcHdm2snOlZ+Qs4WYRE
 btG+SPvZGRfxvbk9SvgKG23n+Jy2w+1VSpNEg6j2wHSX8OoNZRJbRupsQC5kmLMYjRFw
 1oALqskAEjgQlgG3kx43ObOB4uw3u7ZjDx83iWS8LOZezCtiWXa/KsZ8+6eBVf2H3QoH
 jSF/9GCdic4A1ThnfvgAoodOLPFdWmIWfkP16IITpLRo5CrXS3Nmv92qKbBlcoYW3zvn
 saCYODU+l4/I2ovSea1KB8+4emADS+fITVvp0qq/Au2QsIygVayV2kHrtlTUXZhyDylO
 kmvg==
X-Gm-Message-State: AFuF++lzqLUj8oHzQZ08/UXFdIk9VD2p5uRIH9mLyI0F3m458iUGZB/I
 k8MS0mX5dvbrJdlJxTj6O1MPIfcsScXEURr30tPutP7aNv4OILRZ5RCSuzSrpPFyqumixIZ5wpY
 iu76NDOiDs93XZltzNRj2fM1XrhMH2Gva+UN4z2Wk3i/MyDqP5JDAkLeNpU7jQqi4UQ==
X-Gm-Gg: AYBFou3ejm/lYHIlakl3K5ECfmQxaZw2AcWux7LDGzu/+dsI0KQ+LRnYFRhCTt8glwa
 80arjRnYUNNi1aEwIfG5eXYBSTxMLKYiHV+pEaXqgdf9Is5hxUUu+GZllu7Nx4oqWFsgT1VQrxn
 UrHTPIQOx4hAzOcTjyKtutVk5PH7qb0H4Z8UpJPWlStBHNbL7+SOPvCgv2gq8Tt0iiCwFtPh+xI
 V3K29OedVxV5yR4mZgI+BnpBacHl9/mEdAUf9aaRXsCqDgBt532GLT144dBgPQNjQtOFbtjNWhh
 zQkfM2bMg6AQBBBXbj7d5gdJeuxUJVfK3p6A2mZZAHbJnEpWF/VoMQrT5rNUo2HTxC3mxd2bMN1
 hf4x9JjwTh2ZYRIwHNfe9U/0JHGZ7NCmKKgzORYM=
X-Received: by 2002:a05:6214:248f:b0:90e:939f:70bf with SMTP id
 6a1803df08f44-9123d7314bamr134563306d6.15.1789667063013; 
 Thu, 17 Sep 2026 10:44:23 -0700 (PDT)
X-Received: by 2002:a05:6214:248f:b0:90e:939f:70bf with SMTP id
 6a1803df08f44-9123d7314bamr134562736d6.15.1789667062470; 
 Thu, 17 Sep 2026 10:44:22 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.170])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91252c56d73sm3118136d6.13.2026.09.17.10.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:44:21 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Nutty Liu <nutty.liu@hotmail.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v12 4/5] tests/functional/riscv64: add riscv-server-ref tests
Date: Thu, 17 Sep 2026 14:44:03 -0300
Message-ID: <20260917174405.3471736-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917174405.3471736-1-daniel.barboza@oss.qualcomm.com>
References: <20260917174405.3471736-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI1MyBTYWx0ZWRfX94SpmeYRbtbs
 eZsy94kKlgLD/jRbAlBZ6aL/nKDASQ1qfcYVduxGZutDJEQ26gUzNi+I+934W3PX8U2SBDAZPvz
 cyBjXb49a2bBTEsTy1SAwBxaGoy1OVc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI1MyBTYWx0ZWRfX0FatoLBlGrEe
 +HW09bkWSUQMPzbTE9Q5Slb8oqBa1Apz2n4dzWCHDNQHBe26ztfWjZ7c36g24oUU3UPchYsn7AB
 31VF6ghGn4cLvZ5zdkIMJhgbJkp+aQwpXAm7vOd7q0r8F+EftB13kvFwqZXsLgJNjedSgo9v8mu
 5ZW4Vsi/Bus7bj/lgmCHG2MSjEHmpAGxQ5W4sWas/XJ5uP5hfJS9b4cXWE/hDm1Mqp0RHBExL9y
 FeAbMIC1VLkM/HwY5ny0PIsZyP9FYpB2k6YBKxMDtTOMUAMHXFxcTN5s7GZdJaluvHZf6XmlXs/
 8SZEmTIOEootPWlirVm7qzi6s7UDtUrY4PmR8kTc6hBkxVADxNCmDzWF0R0FB1dasu/gA/pWfFZ
 g0QdiXCGncMJ+t55BH2acoAg7JEDTk3VEHwOyNof+S5gU9G86tWt6k/naB9Q5NqTMxIUAOKqzjD
 SoiBe60ABEmWd7nqdvA==
X-Authority-Analysis: v=2.4 cv=WL/qzXsR c=1 sm=1 tr=0 ts=6aac26f8 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=arNgJ3JLhM/z8Vk/iMOFgQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=69EAbJreAAAA:8 a=JF9118EUAAAA:8
 a=QOu4sXKRH9_VvCpQA3IA:9 a=pJ04lnu7RYOZP9TFuWaZ:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: ApNymGpkt1igIjJUK7pNHdmZySjrFAFy
X-Proofpoint-ORIG-GUID: ApNymGpkt1igIjJUK7pNHdmZySjrFAFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170253
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Add tests for the recently added riscv-server-ref machine:

- a new test_opensbi.py test.  The idea is to have a quick test that can
catch trivial regressions that would prevent OpenSBI to finish;
- a new Linux boot "thorough" test that will boot the machine up to the
buildroot prompt.
- a TPM specific selftest for the riscv-server-ref board.  The test
will be skipped if there's no 'swtpm' in the host.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
 tests/functional/riscv64/meson.build        |  2 +
 tests/functional/riscv64/test_opensbi.py    |  4 +
 tests/functional/riscv64/test_server_ref.py | 90 +++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100755 tests/functional/riscv64/test_server_ref.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index d1a3e6c2bf..2d22e49efd 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -3,6 +3,7 @@
 test_riscv64_timeouts = {
   'boston' : 120,
   'k230' : 120,
+  'server_ref' : 120,
   'tuxrun' : 120,
 }
 
@@ -15,6 +16,7 @@ tests_riscv64_system_thorough = [
   'endianness',
   'boston',
   'k230',
+  'server_ref',
   'sifive_u',
   'tt_atlantis',
   'tuxrun',
diff --git a/tests/functional/riscv64/test_opensbi.py b/tests/functional/riscv64/test_opensbi.py
index 0f8beb7e7a..367e131164 100755
--- a/tests/functional/riscv64/test_opensbi.py
+++ b/tests/functional/riscv64/test_opensbi.py
@@ -36,5 +36,9 @@ def test_riscv_virt(self):
         self.set_machine('virt')
         self.boot_opensbi()
 
+    def test_riscv_server_ref(self):
+        self.set_machine('riscv-server-ref')
+        self.boot_opensbi()
+
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/riscv64/test_server_ref.py b/tests/functional/riscv64/test_server_ref.py
new file mode 100755
index 0000000000..ad29094dbe
--- /dev/null
+++ b/tests/functional/riscv64/test_server_ref.py
@@ -0,0 +1,90 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+"""
+riscv-server-ref board test
+"""
+
+import os
+import tempfile
+import subprocess
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import skipIfMissingCommands
+
+class RiscvServerRefTest(QemuSystemTest):
+    """
+    Test the riscv-server-ref board
+    """
+
+    ASSET_KERNEL = Asset(
+        ('https://github.com/danielhb/qemu-machine-boot/raw/refs/heads/'
+         'master/riscv/images/virt64/buildroot/Image'),
+        '6bacc876c769c1bb6057d2bf549eba67fbe83916e8223f9fe21c8e8fff665a36')
+
+    ASSET_ROOTFS = Asset(
+        ('https://github.com/danielhb/qemu-machine-boot/raw/refs/heads/'
+         'master/riscv/images/virt64/buildroot/rootfs.ext2'),
+        'f00bb88749f945d80675540a1338bd1ccb226574685a5b6c65ab44027d0411a8')
+
+    def do_test_boot_linux_test(self, tpmstate_dir=None):
+        self.set_machine('riscv-server-ref')
+        kernel_path = self.ASSET_KERNEL.fetch()
+        rootfs_path = self.ASSET_ROOTFS.fetch()
+
+        self.vm.add_args('-kernel', kernel_path)
+        self.vm.add_args('-append', 'rw rootwait root=/dev/sda')
+        self.vm.add_args('-drive',
+            f'file={rootfs_path},format=raw,id=hd0,snapshot=on,if=none')
+        self.vm.add_args('-device', 'ich9-ahci,id=ahci0')
+        self.vm.add_args('-device', 'ide-hd,drive=hd0,bus=ahci0.0')
+        self.vm.add_args('-netdev', 'user,id=net0')
+        self.vm.add_args('-device', 'e1000e,netdev=net0')
+
+        if tpmstate_dir is not None:
+            # Note: code taken verbatim from
+            # tests/functional/arm/test_aspeed_ast2600_buildroot_tpm.py
+
+            # We must put the TPM state dir in /tmp/, not the build dir,
+            # because some distros use AppArmor to lock down swtpm and
+            # restrict the set of locations it can access files in.
+            socket = os.path.join(tpmstate_dir, 'swtpm-socket')
+            subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
+                            '--tpmstate', f'dir={tpmstate_dir}',
+                            '--ctrl', f'type=unixio,path={socket}'],
+                           check=True)
+            self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
+            self.vm.add_args('-tpmdev', 'emulator,id=tpm0,chardev=chrtpm')
+            self.vm.add_args('-device', 'tpm-tis-device,tpmdev=tpm0')
+
+        self.vm.set_console()
+        self.vm.launch()
+
+        # Wait for OpenSBI
+        wait_for_console_pattern(self, 'OpenSBI')
+
+        # Wait for Linux kernel boot
+        wait_for_console_pattern(self, 'Linux version')
+        wait_for_console_pattern(self, 'Machine model: RISC-V Server Platform')
+
+        # Test e1000e network card functionality
+        wait_for_console_pattern(self, 'e1000e')
+        wait_for_console_pattern(self, 'Network Connection')
+
+        # Wait for boot to complete - system reaches login prompt
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+    def test_boot_linux_test(self):
+        self.do_test_boot_linux_test()
+
+    @skipIfMissingCommands('swtpm')
+    def test_boot_linux_test_tpm(self):
+        with tempfile.TemporaryDirectory(prefix="qemu_") as tpmstate_dir:
+            self.do_test_boot_linux_test(tpmstate_dir)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


