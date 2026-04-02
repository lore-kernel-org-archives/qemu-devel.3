Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59664D6AB10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8QL4-0002lq-5x; Thu, 02 Apr 2026 18:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w8QKt-0001PB-HM; Thu, 02 Apr 2026 18:16:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w8QKl-0004sP-2k; Thu, 02 Apr 2026 18:16:16 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 632HiwKS346198; Thu, 2 Apr 2026 22:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=fgo/QArjjHRRP4aPD
 LJUfA8TArlKTIxtYJFlrYdfzKI=; b=saUG9ksUe1stHJEtTdoC/4fbQZoxiMQkx
 oszptS258gnJ1UM01WLaKFamC5FavRlhQ7QrnoPDXj56hWp2brInC4YapVaP9uju
 kMArUhdKpVgh8mJ7nk08MSEaHFX7E/s9lq8wgSv2cA7TKnO1iT0CfHhZU187KINj
 mMsDLQSzc23aVYCypOS8YvbuLzqEWv7/H+pS/eHKVtME6waVwRgymBRIPSBuFtsB
 fCx+Dk1McHiS24WPnvWcTZ3Uj6OdfagSJ7EnpNB/sDmR5FWrUQsdZHWJDlTx40aL
 BsiqX5r9XXHtxmZq+726geMIRl2G397vXlbBD2RNLmChsh+GkcE3g==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66msdtgr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 22:15:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632JAPs4021659;
 Thu, 2 Apr 2026 22:15:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasv3ac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 22:15:50 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 632MFneY17105446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 22:15:49 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9ADE58069;
 Thu,  2 Apr 2026 22:15:49 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4429D58071;
 Thu,  2 Apr 2026 22:15:48 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.183.185])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 22:15:48 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
Subject: [PATCH v10 28/30] tests/functional/s390x: Add secure IPL functional
 test
Date: Thu,  2 Apr 2026 18:14:50 -0400
Message-ID: <20260402221453.1602899-29-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402221453.1602899-1-zycai@linux.ibm.com>
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69ceea97 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=vTr9H3xdAAAA:8 a=VnNF1IyMAAAA:8 a=WP5zsaevAAAA:8
 a=gSyHUACR81Cq5hz7ILYA:9 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE5NSBTYWx0ZWRfX0sP/3tODmzhL
 W2r/PagT4Jvz79IL5bECH3xLlmHrvxUClcw6P7nrhJ7cPVuV84jMBasOQKyemRCc/EytWR0KKM0
 tFRiz6epHLi4u5ndEcFs3atQkmMrhzNMiIvO4ggsgAS0hEYUDeBA1RN+BUMBQO+MyiSNoItfIAb
 RxEkr30JGyWaj27s7y0V3VLs//rL27voX5gQ29i4WDeXAeq91fwO42ok4LpjugEFaZVAu9CECzN
 +XSVqeFDm0IDlfDMj/lhhhj4Plhb9/nEUG4fUfrv/h3qyP+DrXCu7cme+x09Umn64vDyK3/Wvfs
 oRh7KrvcUjeYs+03Ti0u0ZQqRgIal6lYmbNbjPCCfd/LnFKmR9OAtP9pPPnYTmX4veSuM8qyGco
 tScaE45OCXIfj45YwnsCuFXW5pQQFeKUmGc6fiGKvvycIaKWY0K6CnJEL23h5GCtQGwhze65U3I
 HD7byScXP5rdvMqUB8A==
X-Proofpoint-GUID: ZzPZ8HTMbVTaJ8wXhLyr_BUvgoOTwWjU
X-Proofpoint-ORIG-GUID: ZzPZ8HTMbVTaJ8wXhLyr_BUvgoOTwWjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 tests/functional/s390x/test_secure_ipl.py | 148 ++++++++++++++++++++++
 2 files changed, 150 insertions(+)
 create mode 100755 tests/functional/s390x/test_secure_ipl.py

diff --git a/tests/functional/s390x/meson.build b/tests/functional/s390x/meson.build
index 0f03e1c9db..07191ec996 100644
--- a/tests/functional/s390x/meson.build
+++ b/tests/functional/s390x/meson.build
@@ -2,6 +2,7 @@
 
 test_s390x_timeouts = {
   'ccw_virtio' : 420,
+  'secure_ipl' : 280,
 }
 
 tests_s390x_system_quick = [
@@ -13,6 +14,7 @@ tests_s390x_system_thorough = [
   'ccw_virtio',
   'pxelinux',
   'replay',
+  'secure_ipl',
   'topology',
   'tuxrun',
 ]
diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional/s390x/test_secure_ipl.py
new file mode 100755
index 0000000000..0980daace1
--- /dev/null
+++ b/tests/functional/s390x/test_secure_ipl.py
@@ -0,0 +1,148 @@
+#!/usr/bin/env python3
+#
+# s390x Secure IPL functional test: validates secure-boot verification results
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from subprocess import check_call, DEVNULL
+
+from qemu_test import QemuSystemTest, Asset, get_qemu_img
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
+        asset_path = self.ASSET_F40_QCOW2.fetch()
+        self.qcow2_path = self.scratch_file('f40.qcow2')
+        qemu_img = get_qemu_img(self)
+        check_call([qemu_img, 'create', '-f', 'qcow2', '-b', asset_path,
+                    '-F', 'qcow2', self.qcow2_path], stdout=DEVNULL, stderr=DEVNULL)
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
2.53.0


