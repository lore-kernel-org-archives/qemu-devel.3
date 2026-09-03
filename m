Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D79DC624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x29pU-0000uQ-3g; Thu, 03 Sep 2026 11:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x29pS-0000tp-6a; Thu, 03 Sep 2026 11:58:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x29pQ-0006rG-1R; Thu, 03 Sep 2026 11:58:17 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683DVcgJ1977356; Thu, 3 Sep 2026 15:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/+uGi6TGLiKnn/WAj
 nkh3K2AD9CAS4uNX4S+KwKL74E=; b=kLq5cyhvAAsbbqTVzNpNMnBSNnReF2CMy
 V0ugZfJU8YQtegkCh1GfkN0w/FMSCud7bxdcJ18B8dCZRluYTaLIppPifjRDRyTc
 UhQy1khKtZN+YftUQPSSDDyJr4WFtCw40cNZ3bRARgk2qhq6VRVl9TZkqF06eA+J
 WqSdvSFAXa2N9io0uYuKBFGufMhguOBo4VbaCoCg4zmnp39kjCvCXm5ykxm1sXU7
 szIU92FUcf/kTCVekYz+5urc0jVA9Gm2DLCPz+GiLSafYY6dTSAe5NmR3J6xXZYx
 5ivXx1y9DeOH5fWF++D/uAgSOBC4vrBHfxXW5zbkh8NMIVVdCRQ2Q==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue5brq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 15:58:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683FuW2i014385;
 Thu, 3 Sep 2026 15:58:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hr9v6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 15:58:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683Fw6hM30736952
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 15:58:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDD242004D;
 Thu,  3 Sep 2026 15:58:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0AD320040;
 Thu,  3 Sep 2026 15:58:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Thu,  3 Sep 2026 15:58:05 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56370)
 id 842EF160DFE; Thu, 03 Sep 2026 17:58:05 +0200 (CEST)
From: Joshua Daley <jdaley@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, jdaley@linux.ibm.com
Subject: [PATCH v3 3/3] tests/functional/s390x/test_secure_ipl: Add
 virtio-blk-pci boot dev case
Date: Thu,  3 Sep 2026 17:58:05 +0200
Message-ID: <20260903155805.1881366-4-jdaley@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903155805.1881366-1-jdaley@linux.ibm.com>
References: <20260903155805.1881366-1-jdaley@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NSdbxIW2CQqEyWinYWWfUDpYsX4M6Ufw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEzNSBTYWx0ZWRfX2OxrxjQx0XOJ
 EIZA40pw4JyA6NpjmBNSbY3N7yyOl8fORDrG8AK1VYyrMVJB20UnnnQWv5acJRhhHPZzZjrhBYL
 9L01EUB3Lx4bwtyI+HQHVGPqpRjmhVa/SFLl3KXk6LIbqCaHjhJNzCXCnfFhTAluLF7rdia8soc
 3fwQyAd7c2LnNN+BcRRV+qZSCkg/+pG2Xe3OV/c+544pBy9OypuI+0/BQMPLcfeRyApDADb8mAl
 oKbhs/KfU5ZLA8JtNO0BiO7d15jbdUniCuELeNz1AudXXiwteTJcedBcFVrvDogdCmM09QqMSlF
 QelN0PoSMOJSe8Y63BOJZF9JLLOD3CSadX7CgUQ8HIVlhT5NzcPnuZG6znue8ZfBqR34uarhqKw
 BJ79ITmeRzRxiUxaIK/ywxFOTWzYEwvClYOqVTx6cLsamnwalG7LSvbI0g+/fiLo4c1ZdiADlMs
 VvXCrJmG9ihTbEEQopg==
X-Proofpoint-ORIG-GUID: NSdbxIW2CQqEyWinYWWfUDpYsX4M6Ufw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEzNSBTYWx0ZWRfX5VnKWPDxUG+S
 Sg88/ssoTzh0/Yrq2QeD2VCssrjWQpc3hiJ0CZzwynLBZ+T85i0708TqhqvTmYCP4TkM69Gl76o
 uekGropT13LysO0lnh9XpeVkOdSwBos=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a999912 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=WP5zsaevAAAA:8
 a=jH-0nMekS77raGL10bsA:9 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030135
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jdaley@linux.ibm.com;
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

Split test_s390x_secure_ipl() into two subtests. Each tests with a
different boot device: virtio-blk-ccw or virtio-blk-pci. Use class-level
variables and a temporary shared workdir such that the time-consuming
setup is not run multiple times.

Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
---
 tests/functional/s390x/test_secure_ipl.py | 139 +++++++++++++++-------
 1 file changed, 95 insertions(+), 44 deletions(-)

diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional=
/s390x/test_secure_ipl.py
index 5af36b91d85..461d73c0d7a 100755
--- a/tests/functional/s390x/test_secure_ipl.py
+++ b/tests/functional/s390x/test_secure_ipl.py
@@ -8,6 +8,9 @@
 secure-boot enabled, and verifying cryptographic validation results.
 """
=20
+import os
+import shutil
+import tempfile
 from subprocess import check_call, DEVNULL
=20
 from qemu_test import QemuSystemTest, Asset, get_qemu_img
@@ -22,12 +25,25 @@ class S390xSecureIpl(QemuSystemTest):
          'Fedora-Server-KVM-40-1.14.s390x.qcow2'),
         '091c232a7301be14e19c76ce9a0c1cbd2be2c4157884a731e1fc4f89e7455a5=
f')
=20
-    def __init__(self, *args, **kwargs):
-        super().__init__(*args, **kwargs)
-        self.root_password =3D None
-        self.qcow2_path =3D None
-        self.cert_path =3D None
-        self.prompt =3D None
+    _shared_workdir =3D None
+    _root_password =3D None
+    _qcow2_path =3D None
+    _cert_path =3D None
+    _prompt =3D None
+    _setup_done =3D None
+    _host_lacks_sipl_support =3D False
+
+    @classmethod
+    def setUpClass(cls):
+        super().setUpClass()
+        cls._shared_workdir =3D tempfile.mkdtemp(prefix=3D'qemu_sipl_')
+
+    @classmethod
+    def tearDownClass(cls):
+        if cls._shared_workdir is not None:
+            shutil.rmtree(cls._shared_workdir, ignore_errors=3DTrue)
+            cls._shared_workdir =3D None
+        super().tearDownClass()
=20
     def _require_host_secure_ipl_support(self, vm):
         """
@@ -40,6 +56,7 @@ def _require_host_secure_ipl_support(self, vm):
         missing =3D [f for f in ('sipl', 'sclaf', 'cstore')
                    if not props.get(f)]
         if missing:
+            S390xSecureIpl._host_lacks_sipl_support =3D True
             self.skipTest(
                 f"Host CPU does not support Secure IPL: "
                 f"missing feature(s): {', '.join(missing)}. "
@@ -62,7 +79,7 @@ def _sign_binaries(self, vm):
         exec_command_and_wait_for_pattern(self,
                                 'sudo dnf install kernel-devel-$(uname -=
r) -y',
                                 'Complete!', vm=3Dvm)
-        wait_for_console_pattern(self, self.prompt, vm=3Dvm)
+        wait_for_console_pattern(self, S390xSecureIpl._prompt, vm=3Dvm)
         exec_command_and_wait_for_pattern(self,
                                     'ls /usr/src/kernels/$(uname -r)/scr=
ipts/',
                                     'sign-file', vm=3Dvm)
@@ -71,11 +88,11 @@ def _sign_binaries(self, vm):
         exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-fi=
le '
                     'sha256 mykey.pem mycert.pem /lib/s390-tools/stage3.=
bin',
                     vm=3Dvm)
-        wait_for_console_pattern(self, self.prompt, vm=3Dvm)
+        wait_for_console_pattern(self, S390xSecureIpl._prompt, vm=3Dvm)
         exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-fi=
le '
                     'sha256 mykey.pem mycert.pem /boot/vmlinuz-$(uname -=
r)',
                     vm=3Dvm)
-        wait_for_console_pattern(self, self.prompt, vm=3Dvm)
+        wait_for_console_pattern(self, S390xSecureIpl._prompt, vm=3Dvm)
=20
     def _run_zipl_secure(self, vm):
         """Run zipl to prepare for secure boot"""
@@ -91,10 +108,11 @@ def _extract_certificate(self, vm):
         cert =3D "\n".join(out.decode("utf-8").splitlines()[1:])
         self.log.info("%s", cert)
=20
-        self.cert_path =3D self.scratch_file("mycert.pem")
+        cert_path =3D os.path.join(S390xSecureIpl._shared_workdir, "myce=
rt.pem")
=20
-        with open(self.cert_path, 'w', encoding=3D"utf-8") as file_objec=
t:
+        with open(cert_path, 'w', encoding=3D"utf-8") as file_object:
             file_object.write(cert)
+        S390xSecureIpl._cert_path =3D cert_path
=20
     def setup_s390x_secure_ipl(self):
         """
@@ -109,39 +127,42 @@ def setup_s390x_secure_ipl(self):
         temp_vm.set_machine('s390-ccw-virtio')
=20
         asset_path =3D self.ASSET_F40_QCOW2.fetch()
-        self.qcow2_path =3D self.scratch_file('f40.qcow2')
+        qcow2_path =3D os.path.join(S390xSecureIpl._shared_workdir, 'f40=
.qcow2')
         qemu_img =3D get_qemu_img(self)
         check_call([qemu_img, 'create', '-f', 'qcow2', '-b', asset_path,
-                    '-F', 'qcow2', self.qcow2_path], stdout=3DDEVNULL, s=
tderr=3DDEVNULL)
+                    '-F', 'qcow2', qcow2_path], stdout=3DDEVNULL, stderr=
=3DDEVNULL)
+        S390xSecureIpl._qcow2_path =3D qcow2_path
=20
         temp_vm.set_console()
         temp_vm.add_args('-nographic',
                          '-accel', 'kvm',
                          '-m', '1024',
                          '-drive',
-                         f'id=3Ddrive0,if=3Dnone,format=3Dqcow2,file=3D{=
self.qcow2_path}',
+                         f'id=3Ddrive0,if=3Dnone,format=3Dqcow2,file=3D{=
qcow2_path}',
                          '-device', 'virtio-blk-ccw,drive=3Ddrive0,booti=
ndex=3D1')
         temp_vm.launch()
=20
         self._require_host_secure_ipl_support(temp_vm)
=20
         # Initial root account setup (Fedora first boot screen)
-        self.root_password =3D 'fedora40password'
+        S390xSecureIpl._root_password =3D 'fedora40password'
         wait_for_console_pattern(self, 'Please make a selection from the=
 above',
                                  vm=3Dtemp_vm)
         exec_command_and_wait_for_pattern(self, '4', 'Password:', vm=3Dt=
emp_vm)
-        exec_command_and_wait_for_pattern(self, self.root_password,
+        exec_command_and_wait_for_pattern(self, S390xSecureIpl._root_pas=
sword,
                                           'Password (confirm):', vm=3Dte=
mp_vm)
-        exec_command_and_wait_for_pattern(self, self.root_password,
+        exec_command_and_wait_for_pattern(self, S390xSecureIpl._root_pas=
sword,
                                     'Please make a selection from the ab=
ove',
                                     vm=3Dtemp_vm)
=20
         # Login as root
-        self.prompt =3D '[root@localhost ~]#'
-        exec_command_and_wait_for_pattern(self, 'c', 'localhost login:',=
 vm=3Dtemp_vm)
-        exec_command_and_wait_for_pattern(self, 'root', 'Password:', vm=3D=
temp_vm)
-        exec_command_and_wait_for_pattern(self, self.root_password, self=
.prompt,
+        S390xSecureIpl._prompt =3D '[root@localhost ~]#'
+        exec_command_and_wait_for_pattern(self, 'c', 'localhost login:',
                                           vm=3Dtemp_vm)
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:',
+                                          vm=3Dtemp_vm)
+        exec_command_and_wait_for_pattern(self, S390xSecureIpl._root_pas=
sword,
+                                          S390xSecureIpl._prompt, vm=3Dt=
emp_vm)
=20
         self._create_certificate(temp_vm)
         self._sign_binaries(temp_vm)
@@ -150,41 +171,71 @@ def setup_s390x_secure_ipl(self):
=20
         # Shutdown temp vm
         temp_vm.shutdown()
+        S390xSecureIpl._setup_done =3D True
=20
-    @skipBigDataTest()
-    def test_s390x_secure_ipl(self):
+    def verify_s390x_secure_ipl(self, boot_dev_bus: str):
         """
         Verify secure boot validation during s390x guest boot.
=20
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
-                         '-machine', 's390-ccw-virtio,secure-boot=3Don,'
-                         f'boot-certs.0.path=3D{self.cert_path}',
-                         '-accel', 'kvm',
-                         '-m', '1024',
-                         '-drive',
-                         f'id=3Ddrive1,if=3Dnone,format=3Dqcow2,file=3D{=
self.qcow2_path}',
-                         '-device', 'virtio-blk-ccw,drive=3Ddrive1,booti=
ndex=3D1')
-        self.vm.launch()
+        if boot_dev_bus not in ['ccw', 'pci']:
+            raise ValueError(
+                f"boot_dev_bus must be 'ccw' or 'pci', got {boot_dev_bus=
}")
+
+        vm =3D self.get_vm(name=3Df'sipl_test_vblk_{boot_dev_bus}')
+        vm.set_machine('s390-ccw-virtio')
+
+        vm.set_console()
+        vm.add_args('-nographic',
+                    '-machine', 's390-ccw-virtio,secure-boot=3Don,'
+                    f'boot-certs.0.path=3D{S390xSecureIpl._cert_path}',
+                    '-accel', 'kvm',
+                    '-m', '1024',
+                    '-drive',
+                    f'id=3Ddrive1,if=3Dnone,format=3Dqcow2,'
+                    f'file=3D{S390xSecureIpl._qcow2_path}',
+                    '-device',
+                    f'virtio-blk-{boot_dev_bus},drive=3Ddrive1,bootindex=
=3D1')
+        vm.launch()
=20
         # Expect two verified components
         verified_output =3D "Verified component"
-        wait_for_console_pattern(self, verified_output)
-        wait_for_console_pattern(self, verified_output)
+        wait_for_console_pattern(self, verified_output, vm=3Dvm)
+        wait_for_console_pattern(self, verified_output, vm=3Dvm)
=20
         # Login and verify the vm is booted using secure boot
-        wait_for_console_pattern(self, 'localhost login:')
-        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
-        exec_command_and_wait_for_pattern(self, self.root_password, self=
.prompt)
-        exec_command_and_wait_for_pattern(self, 'cat /sys/firmware/ipl/s=
ecure', '1')
+        wait_for_console_pattern(self, 'localhost login:', vm=3Dvm)
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:', vm=3D=
vm)
+        exec_command_and_wait_for_pattern(
+            self, S390xSecureIpl._root_password, S390xSecureIpl._prompt,=
 vm=3Dvm)
+        exec_command_and_wait_for_pattern(
+            self, 'cat /sys/firmware/ipl/secure', '1', vm=3Dvm)
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
=20
 if __name__ =3D=3D '__main__':
     QemuSystemTest.main()
--=20
2.34.1


