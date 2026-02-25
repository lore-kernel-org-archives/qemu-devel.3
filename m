Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA01CFCEE8D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 11:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDE4-0006yr-2E; Wed, 25 Feb 2026 06:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <siddhi.katage@oracle.com>)
 id 1vvDE2-0006yA-2R
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:38:42 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <siddhi.katage@oracle.com>)
 id 1vvDDz-0008KB-Jf
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:38:41 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61P9p3Bx369277; Wed, 25 Feb 2026 11:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=0NkNl
 jW74GG6UBSpt6Mf0JPbzyKm18vQQJfnSlDac6I=; b=rMV5T6z5iyPs/il2xneS1
 JMDi4jfq3tlGT23Dyab9aTwYYrwsyuGIEn8QCG48oz/CDH5Hvn3BHB3mzXJmb09F
 wa2QLQTQvE9Q7us0CVm4y2sWlw2XgG8IgSzokM1WiZfZ2YVF1XbeiMiaaAiiFCrv
 jzOa8JlD+buFFjwuKkSl7T/8XYx6PWdJ0nTUYsNbkLOTMc0qyUm/tARrQE9oruSg
 QzbdEc6JcJ7P7lM7xleHN9M28pXnRllbOXKFlRfirsrMNVHraDjyr/Lh/mSOAM73
 boK4V4MHUdnMd6/1u3wKAaHDQDQGkjm3UyhaPbukkaSpKIWgHHhnmrAtnywbAPRp
 g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k5wxrw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Feb 2026 11:38:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 61PAhcbD027861; Wed, 25 Feb 2026 11:38:34 GMT
Received: from skatage-ol9.osdevelopmeniad.oraclevcn.com
 (skatage-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.50])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4cf35g0xec-2; Wed, 25 Feb 2026 11:38:34 +0000
From: Siddhi Katage <siddhi.katage@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net
Subject: [PATCH] tests/functional: Add hotplug_scsi test to hotplug
 virtio-scsi disk
Date: Wed, 25 Feb 2026 11:36:16 +0000
Message-ID: <20260225113804.1919226-2-siddhi.katage@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260225113804.1919226-1-siddhi.katage@oracle.com>
References: <20260210113135.771697-1-siddhi.katage@oracle.com>
 <20260225113804.1919226-1-siddhi.katage@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602250114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDExNCBTYWx0ZWRfX76xNhm9wt7fA
 BgI/28peTuug7KCzM1+mCtzOMX/nm4IhGFLOoYz179KLmzZhdlzdsaKX+dXUzRK9C/JIICI5KYc
 IPYj9cToWjK7X1Qs813yO6feLP9TeM9+YPspqziw8TtcMDzxRE0IkfvmMigts6CmpnZVvc9T5zZ
 uNQqCpq1bkuouTelsDHfhjyEcTlewdpZicTxNHbaZ9WhVhOiQf2tDnqFgsR0KivHEgwmn7YWR9A
 yDE+SMeV7v7TCM2tfbZhU4TqJMrfyxazlljkwBKjLPLXK+9qkBKYVf45NbX2MMReJ4uM1RzPz+P
 KK0NtLxa0KBLeqNdgxOx34crHv714f55mbvkAHBOZsO1/cY3AD+O5ZddqPpBmQTdmLGKbWSbwNt
 zwJnmQya3lat1nohVEwFJpQAqbiVNZlgn8SFN9WNzcV8N9Pxy2cwI1h64uMaoMImgVq5qm36pWZ
 JrZNkeN2sY8w6qeF2hpOpP6QXCACuWyiWKyTjcfk=
X-Proofpoint-GUID: writ6MUPSWgSD8rQ4pAbOdS729fcV8eT
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=699edf3c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=vTr9H3xdAAAA:8 a=yPCof4ZbAAAA:8
 a=rk2NdRIlDEXxxkLyMG4A:9 cc=ntf awl=host:12262
X-Proofpoint-ORIG-GUID: writ6MUPSWgSD8rQ4pAbOdS729fcV8eT
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=siddhi.katage@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Siddhi Katage <siddhi.katage@oracle.com>
---
 tests/functional/x86_64/meson.build          |  1 +
 tests/functional/x86_64/test_hotplug_scsi.py | 86 ++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100755 tests/functional/x86_64/test_hotplug_scsi.py

diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index f78eec5e6c..466e9db96e 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -24,6 +24,7 @@ tests_x86_64_system_quick = [
 tests_x86_64_system_thorough = [
   'acpi_bits',
   'hotplug_blk',
+  'hotplug_scsi',
   'hotplug_cpu',
   'intel_iommu',
   'kvm_xen',
diff --git a/tests/functional/x86_64/test_hotplug_scsi.py b/tests/functional/x86_64/test_hotplug_scsi.py
new file mode 100755
index 0000000000..10fd306616
--- /dev/null
+++ b/tests/functional/x86_64/test_hotplug_scsi.py
@@ -0,0 +1,86 @@
+#!/usr/bin/env python3
+#
+# Functional test that hotplugs a virtio scsi disk and checks it on a Linux
+# guest
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
+
+class HotPlugScsi(LinuxKernelTest):
+    ASSET_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Server/x86_64/os/images/pxeboot/vmlinuz'),
+        'd4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129')
+
+    ASSET_INITRD = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Server/x86_64/os/images/pxeboot/initrd.img'),
+        '277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8b')
+
+    def blockdev_add(self) -> None:
+        self.vm.cmd('blockdev-add', **{
+            'driver': 'null-co',
+            'size': 1073741824,
+            'node-name': 'disk0'
+        })
+
+    def add_scsi_controller(self) -> None:
+        self.vm.cmd('device_add', {
+            'driver': 'virtio-scsi-pci',
+            'id': 'scsi0',
+            'bus': 'pci.1',
+            'addr': '1',
+        })
+
+    def assert_sda(self) -> None:
+        exec_command_and_wait_for_pattern(self, 'while ! test -e /sys/block/sda ;'
+                                                ' do sleep 0.2 ; done', '# ')
+
+    def assert_no_sda(self) -> None:
+        exec_command_and_wait_for_pattern(self, 'while test -e /sys/block/sda ;'
+                                                ' do sleep 0.2 ; done', '# ')
+
+    def plug(self) -> None:
+        args = {
+            'driver':'scsi-hd',
+            'drive':'disk0',
+            'bus':'scsi0.0',
+            'id':'scsi-disk0',
+        }
+
+        self.assert_no_sda()
+        self.vm.cmd('device_add', args)
+        self.wait_for_console_pattern('[sda] Attached SCSI disk')
+        self.assert_sda()
+
+    def unplug(self) -> None:
+        self.vm.cmd('device_del', id='scsi-disk0')
+
+        self.vm.event_wait('DEVICE_DELETED', 1.0,
+                           match={'data': {'device': 'scsi-disk0'}})
+
+        self.assert_no_sda()
+
+    def test(self) -> None:
+        self.require_accelerator('kvm')
+        self.set_machine('q35')
+        self.vm.add_args('-accel', 'kvm')
+        self.vm.add_args('-device', 'pcie-pci-bridge,id=pci.1,bus=pcie.0')
+        self.vm.add_args('-m', '1G')
+        self.vm.add_args('-append', 'console=ttyS0 rd.rescue')
+
+        self.launch_kernel(self.ASSET_KERNEL.fetch(),
+                           self.ASSET_INITRD.fetch(),
+                           wait_for='Entering emergency mode.')
+        self.wait_for_console_pattern('# ')
+
+        self.blockdev_add()
+        self.add_scsi_controller()
+        self.plug()
+        self.unplug()
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
+
-- 
2.47.3


