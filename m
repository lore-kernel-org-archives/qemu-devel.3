Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8E4EEA84F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 20:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqdYZ-0001He-8E; Thu, 12 Feb 2026 15:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdYY-0001Eg-3k; Thu, 12 Feb 2026 15:44:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdYW-0008M9-4Q; Thu, 12 Feb 2026 15:44:57 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CIuqkp475486; Thu, 12 Feb 2026 20:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ZdsJ2AimWDq7Q/TAe
 O+KLwXwXfaBsD4xFd1XIe1zclg=; b=TpNM02N7qyRVeWsv6ns0QvJ0aQBnxw5IS
 YyGMQ+y7vWVCvn0ljeA64Pl+NQx4MypM3AXLoP993OaKLWjEWmPGmg44O4wltJyb
 htH7qRbNvjW8aDH7CVQFEPUvLjt0QK7GVCa7LgXnogYXPfqUBTBQDp088ZdJi3pG
 7Vty6+ZUkNmzrDHjPNwS5OvDc7O+B7Cj9SJRiBD9ETm66takhbI5fHg9F0llPYEZ
 qjL/arAFv0hFR1675j6yGwD86+ZnMKevtVxtKRk97O38lHR/LDu30FP//ElWI7HP
 dA++nAao9e1UleH+GtR0cGPri1tl1Z0USSwPT2ENyz7SMyaTEbqVA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696vd8t6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CH136H008413;
 Thu, 12 Feb 2026 20:44:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3ym7wp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:50 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CKingf26608204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 20:44:49 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DF805804E;
 Thu, 12 Feb 2026 20:44:49 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6702658054;
 Thu, 12 Feb 2026 20:44:47 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.112.15])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 20:44:47 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com
Subject: [PATCH v8 28/30] tests/functional/s390x: Add secure IPL functional
 test
Date: Thu, 12 Feb 2026 15:43:49 -0500
Message-ID: <20260212204352.1044699-29-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212204352.1044699-1-zycai@linux.ibm.com>
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zuPei-1JbkP7i1Sk1wGgHYkmv8Ct1fzw
X-Proofpoint-ORIG-GUID: zuPei-1JbkP7i1Sk1wGgHYkmv8Ct1fzw
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=698e3bc3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=vTr9H3xdAAAA:8 a=VnNF1IyMAAAA:8 a=WP5zsaevAAAA:8
 a=gSyHUACR81Cq5hz7ILYA:9 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE1NyBTYWx0ZWRfXybM1R2cbpj9h
 EIncYdhBMmJunaLvP2Kd7o4n5VJeejuR9qQCvxXPIn6nFph7c6m9BX12oJLku+Zp6pAf8cKwPl+
 BxM7rwNSZL42V0kuF72AHrNv4G2YBrMOHvIyS9xaWVsSTbxDHNlcR80jGcou8PpLmeyyA+bRMiT
 rWy8iWgNLVSr5Kw9fRiCVRYxXL6QwOyvYKEtwWNSnrFDxuD9w5xHlIYsZCV1wBXamIyycfxbC0W
 Sy+oBu2PlqChjY9xLZB6RQVddk4J4iOfFz9q7S6Wjs9s881eFCfmSx83OPYeKYAGbSSCbUgnrNZ
 3DbQQMVTPyNiIiP1wcDCRGYDIXsewGj6lkjJoEhieO3Shoch3zyShF9VbvXRI2AJyw54Q0LrcJc
 KszSVu5SVRqxpIFmSb7/yLZ28HmU0JY957PW9KBGPWJjG4tYCxjtZOpuT7sr5d+RAEEfwm1Nuqs
 VHn6nQ5NrCNuOn66/Vg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120157
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add functional test for secure IPL.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 tests/functional/s390x/meson.build        |   2 +
 tests/functional/s390x/test_secure_ipl.py | 142 ++++++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 tests/functional/s390x/test_secure_ipl.py

diff --git a/tests/functional/s390x/meson.build b/tests/functional/s390x/meson.build
index 70cd36e291..cb050f3c01 100644
--- a/tests/functional/s390x/meson.build
+++ b/tests/functional/s390x/meson.build
@@ -2,6 +2,7 @@
 
 test_s390x_timeouts = {
   'ccw_virtio' : 420,
+  'secure_ipl' : 280,
 }
 
 tests_s390x_system_quick = [
@@ -12,6 +13,7 @@ tests_s390x_system_thorough = [
   'ccw_virtio',
   'pxelinux',
   'replay',
+  'secure_ipl',
   'topology',
   'tuxrun',
 ]
diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional/s390x/test_secure_ipl.py
new file mode 100644
index 0000000000..c95553e4e9
--- /dev/null
+++ b/tests/functional/s390x/test_secure_ipl.py
@@ -0,0 +1,142 @@
+#!/usr/bin/env python3
+#
+# s390x Secure IPL functional test: validates secure-boot verification results
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern, exec_command
+from qemu_test import wait_for_console_pattern, skipBigDataTest
+
+class S390xSecureIpl(QemuSystemTest):
+    ASSET_F40_QCOW2 = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/'
+         'fedora-secondary/releases/40/Server/s390x/images/'
+         'Fedora-Server-KVM-40-1.14.s390x.qcow2'),
+        '091c232a7301be14e19c76ce9a0c1cbd2be2c4157884a731e1fc4f89e7455a5f')
+
+    def __init__(self, *args, **kwargs):
+        super().__init__(*args, **kwargs)
+        self.root_password = None
+        self.qcow2_path = None
+        self.cert_path = None
+        self.prompt = None
+
+    # Boot a temporary VM to set up secure IPL image:
+    # - Create certificate
+    # - Sign stage3 binary and kernel
+    # - Run zipl
+    # - Extract certificate
+    def setup_s390x_secure_ipl(self):
+        temp_vm = self.get_vm(name='sipl_setup')
+        temp_vm.set_machine('s390-ccw-virtio')
+
+        self.qcow2_path = self.ASSET_F40_QCOW2.fetch()
+
+        temp_vm.set_console()
+        temp_vm.add_args('-nographic',
+                         '-accel', 'kvm',
+                         '-m', '1024',
+                         '-drive',
+                         f'id=drive0,if=none,format=qcow2,file={self.qcow2_path}',
+                         '-device', 'virtio-blk-ccw,drive=drive0,bootindex=1')
+        temp_vm.launch()
+
+        # Initial root account setup (Fedora first boot screen)
+        self.root_password = 'fedora40password'
+        wait_for_console_pattern(self, 'Please make a selection from the above',
+                                 vm=temp_vm)
+        exec_command_and_wait_for_pattern(self, '4', 'Password:', vm=temp_vm)
+        exec_command_and_wait_for_pattern(self, self.root_password,
+                                          'Password (confirm):', vm=temp_vm)
+        exec_command_and_wait_for_pattern(self, self.root_password,
+                                    'Please make a selection from the above',
+                                    vm=temp_vm)
+
+        # Login as root
+        self.prompt = '[root@localhost ~]#'
+        exec_command_and_wait_for_pattern(self, 'c', 'localhost login:', vm=temp_vm)
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:', vm=temp_vm)
+        exec_command_and_wait_for_pattern(self, self.root_password, self.prompt,
+                                          vm=temp_vm)
+
+        # Certificate generation
+        exec_command_and_wait_for_pattern(self,
+                                          'openssl version', 'OpenSSL 3.2.1 30',
+                                          vm=temp_vm)
+        exec_command_and_wait_for_pattern(self,
+                            'openssl req -new -x509 -newkey rsa:2048 '
+                            '-keyout mykey.pem -outform PEM -out mycert.pem '
+                            '-days 36500 -subj "/CN=My Name/" -nodes -verbose',
+                            'Writing private key to \'mykey.pem\'', vm=temp_vm)
+
+        # Install kernel-devel (needed for sign-file)
+        exec_command_and_wait_for_pattern(self,
+                                'sudo dnf install kernel-devel-$(uname -r) -y',
+                                'Complete!', vm=temp_vm)
+        wait_for_console_pattern(self, self.prompt, vm=temp_vm)
+        exec_command_and_wait_for_pattern(self,
+                                    'ls /usr/src/kernels/$(uname -r)/scripts/',
+                                    'sign-file', vm=temp_vm)
+
+        # Sign stage3 binary and kernel
+        exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-file '
+                    'sha256 mykey.pem mycert.pem /lib/s390-tools/stage3.bin',
+                    vm=temp_vm)
+        wait_for_console_pattern(self, self.prompt, vm=temp_vm)
+        exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-file '
+                    'sha256 mykey.pem mycert.pem /boot/vmlinuz-$(uname -r)',
+                    vm=temp_vm)
+        wait_for_console_pattern(self, self.prompt, vm=temp_vm)
+
+        # Run zipl to prepare for secure boot
+        exec_command_and_wait_for_pattern(self, 'zipl --secure 1 -VV', 'Done.',
+                                          vm=temp_vm)
+
+        # Extract certificate to host
+        out = exec_command_and_wait_for_pattern(self, 'cat mycert.pem',
+                                                '-----END CERTIFICATE-----',
+                                                vm=temp_vm)
+        # strip first line to avoid console echo artifacts
+        cert = "\n".join(out.decode("utf-8").splitlines()[1:])
+        self.log.info("%s", cert)
+
+        self.cert_path = self.scratch_file("mycert.pem")
+
+        with open(self.cert_path, 'w', encoding="utf-8") as file_object:
+            file_object.write(cert)
+
+        # Shutdown temp vm
+        temp_vm.shutdown()
+
+    @skipBigDataTest()
+    def test_s390x_secure_ipl(self):
+        self.require_accelerator('kvm')
+        self.setup_s390x_secure_ipl()
+
+        self.set_machine('s390-ccw-virtio')
+
+        self.vm.set_console()
+        self.vm.add_args('-nographic',
+                         '-machine', 's390-ccw-virtio,secure-boot=on,'
+                         f'boot-certs.0.path={self.cert_path}',
+                         '-accel', 'kvm',
+                         '-m', '1024',
+                         '-drive',
+                         f'id=drive1,if=none,format=qcow2,file={self.qcow2_path}',
+                         '-device', 'virtio-blk-ccw,drive=drive1,bootindex=1')
+        self.vm.launch()
+
+        # Expect two verified components
+        verified_output = "Verified component"
+        wait_for_console_pattern(self, verified_output)
+        wait_for_console_pattern(self, verified_output)
+
+        # Login and verify the vm is booted using secure boot
+        wait_for_console_pattern(self, 'localhost login:')
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
+        exec_command_and_wait_for_pattern(self, self.root_password, self.prompt)
+        exec_command_and_wait_for_pattern(self, 'cat /sys/firmware/ipl/secure', '1')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.52.0


