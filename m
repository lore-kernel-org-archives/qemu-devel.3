Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71238C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1tx-0006X4-98; Wed, 01 Jul 2026 16:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1tv-0006Hp-Ih; Wed, 01 Jul 2026 16:51:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1tn-0004X6-Rp; Wed, 01 Jul 2026 16:51:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661GmjPT1295225; Wed, 1 Jul 2026 20:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=y2ZEOyPJnq6RBxjSG
 XHxCe6xCdeisLlDMUSdLmHcyQo=; b=iumfKVfRyAn9Bjm7mfjuMLPyf/J7TW5TC
 HAA0dFA2FvJ3/IcmAriMkcAjxOgPdP+Rel5t04MFan8Hj1QaWVnMPGNOqU9/HeFY
 2Udl36dvpAvbi5fN4BEMuQKwSh/J5/KoTFlb2pvnh4UpLvbgL8gyMyTtkMktdgcO
 VPF8lXBYjqAPCj6VwTG3eCSvwcwdOVhrsQIeEWhU21EGttKReb4qQcVs7FDrQN0y
 oXrWsbi6RLWqUO0LUhAQezstjl0ufC9uLvNlZ5C4a+oeF2DWuxZKJd2JDb02h0Oj
 kcZlnGknXo0g8PU1gfaM1Qx+A8uHa3zpEz2TbxbD8UKwex9hTTwYw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjxafk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:51:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661KnbkB001596;
 Wed, 1 Jul 2026 20:51:07 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w963m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:51:07 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 661Kp6qf33489574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 20:51:06 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64D195804E;
 Wed,  1 Jul 2026 20:51:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAE035803F;
 Wed,  1 Jul 2026 20:51:03 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.149.234])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 20:51:03 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v12 33/35] tests/functional/s390x: Add secure IPL functional
 test
Date: Wed,  1 Jul 2026 16:49:19 -0400
Message-ID: <20260701204922.1320349-34-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701204922.1320349-1-zycai@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfXxXFk8SvTOYFa
 +KNjmH0YxJqXfh9fddgChYFefesP6tl0K9Ej4l4TfRIn9kQVQIiv/op97j6+JastQ7jS5onnSO6
 eB7kuy6IwDC6rSC9n8ugli1lNeLyeVJCR/V1QPD2qQpk98KIwZlN2Jsrgh+Gqt6ggn2rhr5QO7d
 wJZ7tIEa8wanYw2s0Ysv+M5IDogv5bwu4EGCNGglftlB629J5qPBn+GTWTQYM6N2swu4QloCi3a
 W4rtB+GTdFz9scz9p2oHfW09QFH0PDxBVQyD64L/QulP2Bk0nnB2vPnwszTRO/+TgJJqWqOzLV1
 znT5fXBbFspF9hLzM8b9D1wPJ3cLvghDYsUUGfFDwiVLMa70qycDXF5smk962+Qy+XK8dCoQmOl
 tHXQkKwhmll867AJFBGdAqoXF0gS6gMznt/7cAiYtd1wP1KbBdTg7kaH2h/Ggb55JxoZCbjDFL/
 s0We1zrFglYbgDSQlLA==
X-Proofpoint-GUID: JW1I7PefiyOb24AX83uvlLXG0b3ddocO
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a457dbc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=vTr9H3xdAAAA:8 a=VnNF1IyMAAAA:8 a=WP5zsaevAAAA:8
 a=vvdW6g1Vg8v77fwKLDIA:9 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX2b2N5hRHGBR9
 Mra32HnCncUjF3S6ZKKq8gL4aaXjB7y1Iw1qN+DPz1xIYfymGxADN1xYeUIpv/hfaaECBLAdGrM
 kFSAYYUkkCWp2vwOB1TLx6Htz6ais3E=
X-Proofpoint-ORIG-GUID: JW1I7PefiyOb24AX83uvlLXG0b3ddocO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010222
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

Add functional test for secure IPL.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 tests/functional/s390x/meson.build        |   2 +
 tests/functional/s390x/test_secure_ipl.py | 172 ++++++++++++++++++++++
 2 files changed, 174 insertions(+)
 create mode 100755 tests/functional/s390x/test_secure_ipl.py

diff --git a/tests/functional/s390x/meson.build b/tests/functional/s390x/meson.build
index b065b666bc..16da5f0054 100644
--- a/tests/functional/s390x/meson.build
+++ b/tests/functional/s390x/meson.build
@@ -2,6 +2,7 @@
 
 test_s390x_timeouts = {
   'ccw_virtio' : 420,
+  'secure_ipl' : 360,
 }
 
 tests_s390x_system_quick = [
@@ -14,6 +15,7 @@ tests_s390x_system_thorough = [
   'ccw_virtio',
   'pxelinux',
   'replay',
+  'secure_ipl',
   'topology',
   'tuxrun',
 ]
diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional/s390x/test_secure_ipl.py
new file mode 100755
index 0000000000..06fc93e404
--- /dev/null
+++ b/tests/functional/s390x/test_secure_ipl.py
@@ -0,0 +1,172 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+s390x Secure IPL functional test.
+
+Validates s390x secure boot by preparing a signed guest image, booting with
+secure-boot enabled, and verifying cryptographic validation results.
+"""
+
+from subprocess import check_call, DEVNULL
+
+from qemu_test import QemuSystemTest, Asset, get_qemu_img
+from qemu_test import exec_command_and_wait_for_pattern, exec_command
+from qemu_test import wait_for_console_pattern, skipBigDataTest
+
+class S390xSecureIpl(QemuSystemTest):
+    """Test s390x Secure IPL (secure boot) functionality."""
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
+    def _create_certificate(self, vm):
+        """Generate x509 certificate"""
+        exec_command_and_wait_for_pattern(self,
+                                          'openssl version', 'OpenSSL 3.2.1 30',
+                                          vm=vm)
+        exec_command_and_wait_for_pattern(self,
+                            'openssl req -new -x509 -newkey rsa:2048 '
+                            '-keyout mykey.pem -outform PEM -out mycert.pem '
+                            '-days 36500 -subj "/CN=My Name/" -nodes -verbose',
+                            'Writing private key to \'mykey.pem\'', vm=vm)
+
+    def _sign_binaries(self, vm):
+        """Sign stage3 binary and kernel"""
+        # Install kernel-devel (needed for sign-file)
+        exec_command_and_wait_for_pattern(self,
+                                'sudo dnf install kernel-devel-$(uname -r) -y',
+                                'Complete!', vm=vm)
+        wait_for_console_pattern(self, self.prompt, vm=vm)
+        exec_command_and_wait_for_pattern(self,
+                                    'ls /usr/src/kernels/$(uname -r)/scripts/',
+                                    'sign-file', vm=vm)
+
+        # Sign stage3 binary and kernel
+        exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-file '
+                    'sha256 mykey.pem mycert.pem /lib/s390-tools/stage3.bin',
+                    vm=vm)
+        wait_for_console_pattern(self, self.prompt, vm=vm)
+        exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-file '
+                    'sha256 mykey.pem mycert.pem /boot/vmlinuz-$(uname -r)',
+                    vm=vm)
+        wait_for_console_pattern(self, self.prompt, vm=vm)
+
+    def _run_zipl_secure(self, vm):
+        """Run zipl to prepare for secure boot"""
+        exec_command_and_wait_for_pattern(self, 'zipl --secure 1 -VV', 'Done.',
+                                          vm=vm)
+
+    def _extract_certificate(self, vm):
+        """Extract certificate from VM to host filesystem"""
+        out = exec_command_and_wait_for_pattern(self, 'cat mycert.pem',
+                                                '-----END CERTIFICATE-----',
+                                                vm=vm)
+        # strip first line to avoid console echo artifacts
+        cert = "\n".join(out.decode("utf-8").splitlines()[1:])
+        self.log.info("%s", cert)
+
+        self.cert_path = self.scratch_file("mycert.pem")
+
+        with open(self.cert_path, 'w', encoding="utf-8") as file_object:
+            file_object.write(cert)
+
+    def setup_s390x_secure_ipl(self):
+        """
+        Prepare a secure boot-enabled guest image.
+
+        Boots a temporary VM to generate a certificate, sign boot components
+        (stage3 and kernel), run zipl, and extract the certificate to host.
+        """
+        self.require_netdev('user')
+
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
+        self._create_certificate(temp_vm)
+        self._sign_binaries(temp_vm)
+        self._run_zipl_secure(temp_vm)
+        self._extract_certificate(temp_vm)
+
+        # Shutdown temp vm
+        temp_vm.shutdown()
+
+    @skipBigDataTest()
+    def test_s390x_secure_ipl(self):
+        """
+        Verify secure boot validation during s390x guest boot.
+
+        Expects two "Verified component" messages and confirms
+        /sys/firmware/ipl/secure reports secure boot is active.
+        """
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
2.54.0


