Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417E9C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kKB-00069w-NR; Mon, 21 Sep 2026 16:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kK7-0005yk-Sv; Mon, 21 Sep 2026 16:09:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kK5-0005Nx-FH; Mon, 21 Sep 2026 16:09:11 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8PDo1903158; Mon, 21 Sep 2026 20:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Uzn8QYsetvbe8LT9G
 cf+LOOHp4yY1mUFkA6yetFYYmU=; b=VV8tcm3Rl7X9PES8dAfaQiacpEt+vBELm
 73MGb2rIjwt+AyxxUpQ2tTZWw1uLTDZcxZ+v2tm9Fh5MkZ5EwY9T4tm9B688/5cR
 OpuMp0wiXFr3th/8m2/+l4rzdnp792ncNK6HTSbj9UQFY7aObNWZOs+HYmRSc+qC
 b8Aus2EcaBy3rUU0IjIahBAsJQCUe3AauCrt0tD0UgLtvPLwPCdRvyVqlj8L3Js6
 A4KpwKNIBQnpvFxOZheB+JFqg3LRuuOh0fZTrVatq2BrNuUY4KxZtWIukSmSMAJT
 rgl6jwR297jWpU1lm1obdC0tTy3vnCsWaEuZUBJ5ecaw3UGgR9/XQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv2bdx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LJPxfP1408943; Mon, 21 Sep 2026 20:08:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjpvmf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LK8jC832047840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 20:08:45 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A085F58043;
 Mon, 21 Sep 2026 20:08:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27B7558059;
 Mon, 21 Sep 2026 20:08:45 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.69.195]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 20:08:45 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Joshua Daley <jdaley@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 23/33] tests/functional/s390x/test_secure_ipl: Add
 virtio-blk-pci boot dev case
Date: Mon, 21 Sep 2026 16:08:20 -0400
Message-ID: <20260921200830.1302919-24-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921200830.1302919-1-farman@linux.ibm.com>
References: <20260921200830.1302919-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FpHU-T8CgzMFvNpOtJ5c8I3Lu6VgoB3N
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX0SxpQKY+BiOP
 rnuLCH1n52CdCHzbIaZHcBxAbAq98UB33Nnt0EEon476sYasRLmT2yNAyfCnsYrtygOMwfoTOsL
 keLXglsTpniFQb7bBVduFMODL1xZKUQ=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab18ecf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=WP5zsaevAAAA:8
 a=jH-0nMekS77raGL10bsA:9 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-GUID: FpHU-T8CgzMFvNpOtJ5c8I3Lu6VgoB3N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX/Kj/jWcWgLMG
 d+cnw5dtN3Y3tW4HdVHnau5aOVCo0NmGn8Ob5i3lJZn68A8pWt6BAzDeWHNveRt65aOKmkOCJyK
 +HOBxe7IbZ/ccw8a5PyPO6Zql0VdWczQe/H4fL67JIsn5rDT6G/pVlm2ZXLkm96sH70oNZ0v47d
 Mlx6ZtNoBASix1Xw6AcV1/Wky2pxt75+5DSp61Qutfd+gX3lfzUHpvJgGtIhhuc5tpv7EVyp1b9
 8GdcXAtMUgMH1bYGWXsmvAwidRNKQ2/sXAhYh4bqJzmwEkqhCbSEHG6R1wb6IMZ4lvVC0gryTn3
 B3U67WPtMcCJgXPk3J4eF5FJOsfsKo+QGgzGRTwq7DV90S2NeqJu+SwSugZiGhz3prWLUPoXQol
 stBoc+ro+mDKBIHWlhdpHpvsl5qIh6nMOzf9xY8urcKQNqs8X/ubVJ8aS1ejiZf6WQmnSGVsZWI
 8bfYpvZqQMG7ZAAw60w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210294
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Joshua Daley <jdaley@linux.ibm.com>

Split test_s390x_secure_ipl() into two subtests. Each tests with a
different boot device: virtio-blk-ccw or virtio-blk-pci. Use class-level
variables and a temporary shared workdir such that the time-consuming
setup is not run multiple times.

Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260903155805.1881366-4-jdaley@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/functional/s390x/test_secure_ipl.py | 139 +++++++++++++++-------
 1 file changed, 95 insertions(+), 44 deletions(-)

diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional/s390x/test_secure_ipl.py
index 5af36b91d8..461d73c0d7 100755
--- a/tests/functional/s390x/test_secure_ipl.py
+++ b/tests/functional/s390x/test_secure_ipl.py
@@ -8,6 +8,9 @@
 secure-boot enabled, and verifying cryptographic validation results.
 """
 
+import os
+import shutil
+import tempfile
 from subprocess import check_call, DEVNULL
 
 from qemu_test import QemuSystemTest, Asset, get_qemu_img
@@ -22,12 +25,25 @@ class S390xSecureIpl(QemuSystemTest):
          'Fedora-Server-KVM-40-1.14.s390x.qcow2'),
         '091c232a7301be14e19c76ce9a0c1cbd2be2c4157884a731e1fc4f89e7455a5f')
 
-    def __init__(self, *args, **kwargs):
-        super().__init__(*args, **kwargs)
-        self.root_password = None
-        self.qcow2_path = None
-        self.cert_path = None
-        self.prompt = None
+    _shared_workdir = None
+    _root_password = None
+    _qcow2_path = None
+    _cert_path = None
+    _prompt = None
+    _setup_done = None
+    _host_lacks_sipl_support = False
+
+    @classmethod
+    def setUpClass(cls):
+        super().setUpClass()
+        cls._shared_workdir = tempfile.mkdtemp(prefix='qemu_sipl_')
+
+    @classmethod
+    def tearDownClass(cls):
+        if cls._shared_workdir is not None:
+            shutil.rmtree(cls._shared_workdir, ignore_errors=True)
+            cls._shared_workdir = None
+        super().tearDownClass()
 
     def _require_host_secure_ipl_support(self, vm):
         """
@@ -40,6 +56,7 @@ def _require_host_secure_ipl_support(self, vm):
         missing = [f for f in ('sipl', 'sclaf', 'cstore')
                    if not props.get(f)]
         if missing:
+            S390xSecureIpl._host_lacks_sipl_support = True
             self.skipTest(
                 f"Host CPU does not support Secure IPL: "
                 f"missing feature(s): {', '.join(missing)}. "
@@ -62,7 +79,7 @@ def _sign_binaries(self, vm):
         exec_command_and_wait_for_pattern(self,
                                 'sudo dnf install kernel-devel-$(uname -r) -y',
                                 'Complete!', vm=vm)
-        wait_for_console_pattern(self, self.prompt, vm=vm)
+        wait_for_console_pattern(self, S390xSecureIpl._prompt, vm=vm)
         exec_command_and_wait_for_pattern(self,
                                     'ls /usr/src/kernels/$(uname -r)/scripts/',
                                     'sign-file', vm=vm)
@@ -71,11 +88,11 @@ def _sign_binaries(self, vm):
         exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-file '
                     'sha256 mykey.pem mycert.pem /lib/s390-tools/stage3.bin',
                     vm=vm)
-        wait_for_console_pattern(self, self.prompt, vm=vm)
+        wait_for_console_pattern(self, S390xSecureIpl._prompt, vm=vm)
         exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-file '
                     'sha256 mykey.pem mycert.pem /boot/vmlinuz-$(uname -r)',
                     vm=vm)
-        wait_for_console_pattern(self, self.prompt, vm=vm)
+        wait_for_console_pattern(self, S390xSecureIpl._prompt, vm=vm)
 
     def _run_zipl_secure(self, vm):
         """Run zipl to prepare for secure boot"""
@@ -91,10 +108,11 @@ def _extract_certificate(self, vm):
         cert = "\n".join(out.decode("utf-8").splitlines()[1:])
         self.log.info("%s", cert)
 
-        self.cert_path = self.scratch_file("mycert.pem")
+        cert_path = os.path.join(S390xSecureIpl._shared_workdir, "mycert.pem")
 
-        with open(self.cert_path, 'w', encoding="utf-8") as file_object:
+        with open(cert_path, 'w', encoding="utf-8") as file_object:
             file_object.write(cert)
+        S390xSecureIpl._cert_path = cert_path
 
     def setup_s390x_secure_ipl(self):
         """
@@ -109,39 +127,42 @@ def setup_s390x_secure_ipl(self):
         temp_vm.set_machine('s390-ccw-virtio')
 
         asset_path = self.ASSET_F40_QCOW2.fetch()
-        self.qcow2_path = self.scratch_file('f40.qcow2')
+        qcow2_path = os.path.join(S390xSecureIpl._shared_workdir, 'f40.qcow2')
         qemu_img = get_qemu_img(self)
         check_call([qemu_img, 'create', '-f', 'qcow2', '-b', asset_path,
-                    '-F', 'qcow2', self.qcow2_path], stdout=DEVNULL, stderr=DEVNULL)
+                    '-F', 'qcow2', qcow2_path], stdout=DEVNULL, stderr=DEVNULL)
+        S390xSecureIpl._qcow2_path = qcow2_path
 
         temp_vm.set_console()
         temp_vm.add_args('-nographic',
                          '-accel', 'kvm',
                          '-m', '1024',
                          '-drive',
-                         f'id=drive0,if=none,format=qcow2,file={self.qcow2_path}',
+                         f'id=drive0,if=none,format=qcow2,file={qcow2_path}',
                          '-device', 'virtio-blk-ccw,drive=drive0,bootindex=1')
         temp_vm.launch()
 
         self._require_host_secure_ipl_support(temp_vm)
 
         # Initial root account setup (Fedora first boot screen)
-        self.root_password = 'fedora40password'
+        S390xSecureIpl._root_password = 'fedora40password'
         wait_for_console_pattern(self, 'Please make a selection from the above',
                                  vm=temp_vm)
         exec_command_and_wait_for_pattern(self, '4', 'Password:', vm=temp_vm)
-        exec_command_and_wait_for_pattern(self, self.root_password,
+        exec_command_and_wait_for_pattern(self, S390xSecureIpl._root_password,
                                           'Password (confirm):', vm=temp_vm)
-        exec_command_and_wait_for_pattern(self, self.root_password,
+        exec_command_and_wait_for_pattern(self, S390xSecureIpl._root_password,
                                     'Please make a selection from the above',
                                     vm=temp_vm)
 
         # Login as root
-        self.prompt = '[root@localhost ~]#'
-        exec_command_and_wait_for_pattern(self, 'c', 'localhost login:', vm=temp_vm)
-        exec_command_and_wait_for_pattern(self, 'root', 'Password:', vm=temp_vm)
-        exec_command_and_wait_for_pattern(self, self.root_password, self.prompt,
+        S390xSecureIpl._prompt = '[root@localhost ~]#'
+        exec_command_and_wait_for_pattern(self, 'c', 'localhost login:',
                                           vm=temp_vm)
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:',
+                                          vm=temp_vm)
+        exec_command_and_wait_for_pattern(self, S390xSecureIpl._root_password,
+                                          S390xSecureIpl._prompt, vm=temp_vm)
 
         self._create_certificate(temp_vm)
         self._sign_binaries(temp_vm)
@@ -150,41 +171,71 @@ def setup_s390x_secure_ipl(self):
 
         # Shutdown temp vm
         temp_vm.shutdown()
+        S390xSecureIpl._setup_done = True
 
-    @skipBigDataTest()
-    def test_s390x_secure_ipl(self):
+    def verify_s390x_secure_ipl(self, boot_dev_bus: str):
         """
         Verify secure boot validation during s390x guest boot.
 
         Expects two "Verified component" messages and confirms
         /sys/firmware/ipl/secure reports secure boot is active.
         """
-        self.require_accelerator('kvm')
-        self.setup_s390x_secure_ipl()
-
-        self.set_machine('s390-ccw-virtio')
-
-        self.vm.set_console()
-        self.vm.add_args('-nographic',
-                         '-machine', 's390-ccw-virtio,secure-boot=on,'
-                         f'boot-certs.0.path={self.cert_path}',
-                         '-accel', 'kvm',
-                         '-m', '1024',
-                         '-drive',
-                         f'id=drive1,if=none,format=qcow2,file={self.qcow2_path}',
-                         '-device', 'virtio-blk-ccw,drive=drive1,bootindex=1')
-        self.vm.launch()
+        if boot_dev_bus not in ['ccw', 'pci']:
+            raise ValueError(
+                f"boot_dev_bus must be 'ccw' or 'pci', got {boot_dev_bus}")
+
+        vm = self.get_vm(name=f'sipl_test_vblk_{boot_dev_bus}')
+        vm.set_machine('s390-ccw-virtio')
+
+        vm.set_console()
+        vm.add_args('-nographic',
+                    '-machine', 's390-ccw-virtio,secure-boot=on,'
+                    f'boot-certs.0.path={S390xSecureIpl._cert_path}',
+                    '-accel', 'kvm',
+                    '-m', '1024',
+                    '-drive',
+                    f'id=drive1,if=none,format=qcow2,'
+                    f'file={S390xSecureIpl._qcow2_path}',
+                    '-device',
+                    f'virtio-blk-{boot_dev_bus},drive=drive1,bootindex=1')
+        vm.launch()
 
         # Expect two verified components
         verified_output = "Verified component"
-        wait_for_console_pattern(self, verified_output)
-        wait_for_console_pattern(self, verified_output)
+        wait_for_console_pattern(self, verified_output, vm=vm)
+        wait_for_console_pattern(self, verified_output, vm=vm)
 
         # Login and verify the vm is booted using secure boot
-        wait_for_console_pattern(self, 'localhost login:')
-        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
-        exec_command_and_wait_for_pattern(self, self.root_password, self.prompt)
-        exec_command_and_wait_for_pattern(self, 'cat /sys/firmware/ipl/secure', '1')
+        wait_for_console_pattern(self, 'localhost login:', vm=vm)
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:', vm=vm)
+        exec_command_and_wait_for_pattern(
+            self, S390xSecureIpl._root_password, S390xSecureIpl._prompt, vm=vm)
+        exec_command_and_wait_for_pattern(
+            self, 'cat /sys/firmware/ipl/secure', '1', vm=vm)
+
+        vm.shutdown()
+
+    @skipBigDataTest()
+    def test_s390x_secure_ipl_ccw(self):
+        """Test secure IPL with a virtio-blk-ccw boot device."""
+        self.require_accelerator('kvm')
+        if S390xSecureIpl._host_lacks_sipl_support:
+            self.skipTest("Host CPU does not support Secure IPL. "
+                          "Secure IPL requires a z16+ host.")
+        if not S390xSecureIpl._setup_done:
+            self.setup_s390x_secure_ipl()
+        self.verify_s390x_secure_ipl('ccw')
+
+    @skipBigDataTest()
+    def test_s390x_secure_ipl_pci(self):
+        """Test secure IPL with a virtio-blk-pci boot device."""
+        self.require_accelerator('kvm')
+        if S390xSecureIpl._host_lacks_sipl_support:
+            self.skipTest("Host CPU does not support Secure IPL. "
+                          "Secure IPL requires a z16+ host.")
+        if not S390xSecureIpl._setup_done:
+            self.setup_s390x_secure_ipl()
+        self.verify_s390x_secure_ipl('pci')
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.55.0


