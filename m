Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31E3C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAmE-0002l7-BN; Wed, 12 Aug 2026 11:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wuAll-0002Kt-Nv; Wed, 12 Aug 2026 11:21:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wuAli-0000M7-6c; Wed, 12 Aug 2026 11:21:28 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CE1aGm2585425; Wed, 12 Aug 2026 15:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/gE2WI+bR/jaAHNZ7
 AlLTpuNoPDWuJrSNr4QOXJxD40=; b=KaYxYgC+J4elRpWPwvTRljxxSZYrlQ+P1
 I8W/FAiG54EZe4MEVDoGCVBtFoxwkkZ0yDt6snGT4JfR51WkIllrXxZ4bqGaKdsd
 /vwIp2tF4yrpWTuLcoHxVahnCwry/3pbzBBzEq2Eg894DX7O7qELPnpJxQQcMDBg
 difAQ5dCTugu8t6cI4kZKwrFg5wWfYy6GyR2ghxKVWXZuUQLpr3OdbXvxlWC9LDe
 0rZ01+BN8UiHnq0bK49SWhzz5kgb/jjFjoKd0H0yO9XGyB87rZq8fsZcwHnjFWqD
 andxAQ2vsatK5N8aBqXf+WYjEkv3zlQAUVgeUyWPGf55TkaLB2hvQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23uq34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 15:21:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFBI1w006170;
 Wed, 12 Aug 2026 15:21:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjxmgj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 15:21:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CFLD5e45154580
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 15:21:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 112022004F;
 Wed, 12 Aug 2026 15:21:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE7122004B;
 Wed, 12 Aug 2026 15:21:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 12 Aug 2026 15:21:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56370)
 id B525C1612A6; Wed, 12 Aug 2026 17:21:12 +0200 (CEST)
From: Joshua Daley <jdaley@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, jdaley@linux.ibm.com
Subject: [PATCH v1 3/3] tests/functional/s390x/test_secure_ipl: Add
 virtio-blk-pci boot dev case
Date: Wed, 12 Aug 2026 17:21:12 +0200
Message-ID: <20260812152112.3330493-4-jdaley@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812152112.3330493-1-jdaley@linux.ibm.com>
References: <20260812152112.3330493-1-jdaley@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c8f6d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ZcxCWl5dgxcWn7WeAwEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyMiBTYWx0ZWRfX1D4VewVYUF0B
 v1+JSkzhFenEotjrBAegt7M3XehKoLibtJ9uXw+4KefYbtLnm3oumxV71FdX6WSl+ooei3oKFTM
 au8fQ3GwiPN6x10ezs+4GLvt3A+QwaTtiYbt7wb24CKHY9MVHSjMtEytRqG8UN1pXTRnGxy8G66
 MtPhcEpsaQxtQU2kLe77oTaEBLEMGsboKM7lfAzAZ4sQNQk1hFF8RtfUGz8pFU+tftkJxpF7jKL
 t9Ec9vFGazFs6uFi+1ymcUMOsNjb3Bm0ViqFYMDHKbOJavdagUUx6yE78OuhjRQbp2H3R1LtSz9
 wyCYam2M/QH7nRAy4ND9mjUEe5mI8j9B+c5xbTDvewKI6434NUJzzyrcE2sv8qF1igDMJO/T4+A
 MQPQZq1UED0x8alD+4HRiaEvPUIDjebrvxsIcN//bowfNA7dY1I+ptfsrADylDIUXoNskGpqP+F
 4KgNG2+/SZqQqI8Imtg==
X-Proofpoint-ORIG-GUID: o6DRWGfBz5J10ICBp999zei-1wpZzCeI
X-Proofpoint-GUID: o6DRWGfBz5J10ICBp999zei-1wpZzCeI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyMiBTYWx0ZWRfX3kHOSOmTYGGw
 aokH1DmpF+GvdhK1xnKxtGBDwtf2hlDQOqPMC77dYbDGH2mNQtNFtehR7qCELTrX67Uujdzpik7
 /Ym8CYRPPHIcwq8YOFS/XqbR2T9UOFM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120122
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
different boot device: virtio-blk-ccw or virtio-blk-pci. Use a state var
such that the setup is run only once.

Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
---
 tests/functional/s390x/test_secure_ipl.py | 70 +++++++++++++++--------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional=
/s390x/test_secure_ipl.py
index 5af36b91d8..7fd4cfeaab 100755
--- a/tests/functional/s390x/test_secure_ipl.py
+++ b/tests/functional/s390x/test_secure_ipl.py
@@ -28,6 +28,7 @@ def __init__(self, *args, **kwargs):
         self.qcow2_path =3D None
         self.cert_path =3D None
         self.prompt =3D None
+        self.setup_done =3D False
=20
     def _require_host_secure_ipl_support(self, vm):
         """
@@ -150,41 +151,64 @@ def setup_s390x_secure_ipl(self):
=20
         # Shutdown temp vm
         temp_vm.shutdown()
+        self.setup_done =3D True
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
+                    f'boot-certs.0.path=3D{self.cert_path}',
+                    '-accel', 'kvm',
+                    '-m', '1024',
+                    '-drive',
+                    f'id=3Ddrive1,if=3Dnone,format=3Dqcow2,file=3D{self.=
qcow2_path}',
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
+            self, self.root_password, self.prompt, vm=3Dvm)
+        exec_command_and_wait_for_pattern(
+            self, 'cat /sys/firmware/ipl/secure', '1', vm=3Dvm)
+
+        vm.shutdown()
+
+    @skipBigDataTest()
+    def test_s390x_secure_ipl_ccw(self):
+        """Test secure IPL with a virtio-blk-ccw boot device."""
+        self.require_accelerator('kvm')
+        if not self.setup_done:
+            self.setup_s390x_secure_ipl()
+        self.verify_s390x_secure_ipl('ccw')
+
+    @skipBigDataTest()
+    def test_s390x_secure_ipl_pci(self):
+        """Test secure IPL with a virtio-blk-pci boot device."""
+        self.require_accelerator('kvm')
+        if not self.setup_done:
+            self.setup_s390x_secure_ipl()
+        self.verify_s390x_secure_ipl('pci')
=20
 if __name__ =3D=3D '__main__':
     QemuSystemTest.main()
--=20
2.34.1


