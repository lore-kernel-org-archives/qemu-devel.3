Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C1ACCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuTK-0003CE-Sr; Thu, 23 Oct 2025 08:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuGY-0001R3-Bo
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:18:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuGU-0006V8-Fi
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:18:02 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3lU3a027999
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=boZzhnriNTM7Whjeo
 biFLf3wFyDVDG3ktmyfi+fB4Zs=; b=aVb4I7qHOqqFmOjL25MNz8Htm/5N7HOLA
 rDBcuyQvtuY2XhgUlGs6/HXoMvCuptkWNpuLTG/q54DZatZ8IlKjRxBkTPaT2n/d
 ZOQyPv6ahRJCYsBJQHP8NkOnZU0/PbxKyBL87DDJzk5xAWUChw7MeLeXx4pjpCvi
 SaQ2hIuoQcDEW8Y0r+JsN3eugPnJf4L1gPa4+XX/oiqIG6LhYs1kWgtIDy5NCL+M
 HXNITvOqxs+CnQy+vxTZPox183eIl3bzTzgJD54ipRM3jkTvq9xRlU070zzA5FSD
 4sdjvUCBcbQa/ruPl13JAnphFeFJaNbutwEwpjaB85dmWBj/slEpA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32721df-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAO1Bs024677
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk5hx3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCHfm547120822
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 12:17:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6ECF820043;
 Thu, 23 Oct 2025 12:17:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DADF20040;
 Thu, 23 Oct 2025 12:17:40 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 12:17:40 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PULL 31/32] tests/functional: Add test for fadump in PSeries
Date: Thu, 23 Oct 2025 17:46:50 +0530
Message-ID: <20251023121653.3686015-32-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023121653.3686015-1-harshpb@linux.ibm.com>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fa1cea cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=NEAV23lmAAAA:8 a=vTr9H3xdAAAA:8
 a=Gr56plS7bk8yA4v_bscA:9 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX73oa7wD9bJUp
 hfP3h7OTUUPHnOkq+M3/iUNCm7aNyC/ZsMrmCFTOkxotq5JLiE0VgFrtDInUcUFBA82ITAWwhmZ
 9VF+c34gu6lmZUY/qCi8WZNec78NVdQvC4kYCacz66hNkzn/MuJkrx7ohfTUkQ+Emh9QZhTHd4U
 uA0Z+osAcQUaeT/I27dPJefpB3TdkgT2MIa/CdhoqA0+AtbqmCYrE6zJMBgeskwNI7shpAUmvBu
 WgqY/1E5OW+mOXD2F6O4jpsU2D+j47B+6EDFUg3wkuPEKL7kLLKr10yEfU33Nxf6tvlQ2c8Xm9t
 dnOVszhqGNQtXCsHhig/CAru7ih6u8DDn7vFwtNyRlX6vLyZX+TmI9HbJiWkU4eeaKLBYTYjjAz
 9Ww7AlEpcZCu5QYLl5h/Ln8ugJgokg==
X-Proofpoint-GUID: F8Un9pVxIcgzuY3CwZgmgRHlvK3dSpRe
X-Proofpoint-ORIG-GUID: F8Un9pVxIcgzuY3CwZgmgRHlvK3dSpRe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Aditya Gupta <adityag@linux.ibm.com>

Add testcases for testing fadump with PSeries and PSeries+KVM
combinations

It tests if fadump is successfully detected and registered in the first
kernel boot. Then crashes the kernel, and verifies whether we have a
/proc/vmcore in the 2nd boot

Also introduce 'wait_for_regex_console_pattern' to check for cases where
there is a single success message, but can have multiple failure
messages.

This is particularly useful for cases such as fadump, where the
success message is
    "Reserved 1024MB ... successfully"
But at the same point, it can fail with multiple errors such as
    "Not supported" or "Allocation failed"

'wait_for_regex_console_pattern' also has a timeout, for cases when we
know the success/failure should appear in a short amount of time,
instead of waiting for the much longer test timeout, such as kernels
with support of fadump will print the success/failure in earlyboot of
the kernel, while kernel without support of fadump won't print anything
for long time, and without a timeout the testcase keeps waiting till
longer test timeout

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20251021134823.1861675-8-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 tests/functional/ppc64/meson.build        |   2 +
 tests/functional/ppc64/test_fadump.py     | 182 ++++++++++++++++++++++
 tests/functional/qemu_test/linuxkernel.py |  59 +++++++
 3 files changed, 243 insertions(+)
 create mode 100755 tests/functional/ppc64/test_fadump.py

diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/meson.build
index 1fa0a70f7e..f0f8ab8f61 100644
--- a/tests/functional/ppc64/meson.build
+++ b/tests/functional/ppc64/meson.build
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 test_ppc64_timeouts = {
+  'fadump' : 480,
   'hv' : 1000,
   'mac99' : 120,
   'powernv' : 480,
@@ -16,6 +17,7 @@ tests_ppc64_system_quick = [
 
 tests_ppc64_system_thorough = [
   'e500',
+  'fadump',
   'hv',
   'mac99',
   'powernv',
diff --git a/tests/functional/ppc64/test_fadump.py b/tests/functional/ppc64/test_fadump.py
new file mode 100755
index 0000000000..2d6b8017e8
--- /dev/null
+++ b/tests/functional/ppc64/test_fadump.py
@@ -0,0 +1,182 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from unittest import skip
+from qemu_test import Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import LinuxKernelTest
+from qemu_test import exec_command, exec_command_and_wait_for_pattern
+
+class QEMUFadump(LinuxKernelTest):
+    """
+    Functional test to verify Fadump is working in following scenarios:
+
+    1. test_fadump_pseries:       PSeries
+    2. test_fadump_pseries_kvm:   PSeries + KVM
+    """
+
+    timeout = 90
+    KERNEL_COMMON_COMMAND_LINE = 'console=hvc0 fadump=on '
+    msg_panic = 'Kernel panic - not syncing'
+    msg_not_supported = 'Firmware-Assisted Dump is not supported on this hardware'
+    msg_registered_success = ''
+    msg_registered_failed = ''
+    msg_dump_active = ''
+
+    ASSET_EPAPR_KERNEL = Asset(
+        ('https://github.com/open-power/op-build/releases/download/v2.7/'
+         'zImage.epapr'),
+        '0ab237df661727e5392cee97460e8674057a883c5f74381a128fa772588d45cd')
+
+    ASSET_VMLINUZ_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
+         'releases/39/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
+        ('81e5541d243b50c8f9568906c6918dda22239744d637bb9a7b22d23c3d661226'
+         '8d5302beb2ca5c06f93bdbc9736c414ef5120756c8bf496ff488ad07d116d67f')
+        )
+
+    ASSET_FEDORA_INITRD = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
+        'releases/39/Everything/ppc64le/os/ppc/ppc64/initrd.img'),
+        'e7f24b44cb2aaa67d30e551db6ac8d29cc57c934b158dabca6b7f885f2cfdd9b')
+
+    def do_test_fadump(self, is_kvm=False, is_powernv=False):
+        """
+        Helper Function for Fadump tests below
+
+        It boots the VM with fadump enabled, checks if fadump is correctly
+        registered.
+        Then crashes the system causing a QEMU_SYSTEM_RESET, after which
+        dump should be available in the kernel.
+        Finally it checks the filesize of the exported /proc/vmcore in 2nd
+        kernel to verify it's same as the VM's memory size
+        """
+        if is_kvm:
+            self.require_accelerator("kvm")
+            self.vm.add_args("-accel", "kvm")
+        else:
+            self.require_accelerator("tcg")
+
+        if is_powernv:
+            self.set_machine("powernv10")
+        else:
+            # SLOF takes upto >20s in startup time, use VOF
+            self.set_machine("pseries")
+            self.vm.add_args("-machine", "x-vof=on")
+            self.vm.add_args("-m", "6G")
+
+        self.vm.set_console()
+
+        kernel_path = None
+
+        if is_powernv:
+            kernel_path = self.ASSET_EPAPR_KERNEL.fetch()
+        else:
+            kernel_path = self.ASSET_VMLINUZ_KERNEL.fetch()
+
+        initrd_path = self.ASSET_FEDORA_INITRD.fetch()
+
+        self.vm.add_args('-kernel', kernel_path)
+        self.vm.add_args('-initrd', initrd_path)
+        self.vm.add_args('-append', "fadump=on"\
+                         " -nodefaults -serial mon:stdio crashkernel=2G"\
+                         " rdinit=/bin/sh ")
+
+        self.vm.launch()
+
+        # If kernel detects fadump support, and "fadump=on" is in command
+        # line which we add above, it will print something like:
+        #
+        #     fadump: Reserved 1024MB of memory at 0x00000040000000 ...
+        #
+        # Else, if the kernel doesn't detect fadump support, it prints:
+        #
+        #     fadump: Firmware-Assisted Dump is not supported on this hardware
+        #
+        # Timeout after 20s if kernel doesn't print any fadump logs, this
+        # can happen due to fadump being disabled in the kernel
+        self.wait_for_regex_console_pattern(
+            success_pattern="fadump: Reserved ",
+            failure_pattern=r"fadump: (Firmware-Assisted Dump is not"\
+            " supported on this hardware|Failed to find memory chunk for"\
+            " reservation!)",
+            timeout=20
+        )
+
+        # Ensure fadump is registered successfully, if registration
+        # succeeds, we get a log from rtas fadump:
+        #
+        #     rtas fadump: Registration is successful!
+        self.wait_for_console_pattern(
+            "rtas fadump: Registration is successful!"
+        )
+
+        # Wait for the shell
+        self.wait_for_console_pattern("#")
+
+        # Mount /proc since not available in the initrd used
+        exec_command(self, command="mount -t proc proc /proc")
+
+        # Crash the kernel
+        exec_command(self, command="echo c > /proc/sysrq-trigger")
+
+        # Check for the kernel panic message, setting timeout to 20s as it
+        # should occur almost immediately after previous echo c
+        self.wait_for_regex_console_pattern(
+            success_pattern="Kernel panic - not syncing: sysrq" \
+                " triggered crash",
+            timeout=20
+        )
+
+        # Check if fadump is active
+        # If the kernel shows that fadump is active, that implies it's a
+        # crashkernel boot
+        # Else if the kernel shows "fadump: Reserved ..." then it's
+        # treating this as the first kernel boot, this is likely the case
+        # that qemu didn't pass the 'ibm,kernel-dump' device tree node
+        wait_for_console_pattern(
+            test=self,
+            success_message="rtas fadump: Firmware-assisted dump is active",
+            failure_message="fadump: Reserved "
+        )
+
+        # In a successful fadump boot, we get these logs:
+        #
+        # [    0.000000] fadump: Firmware-assisted dump is active.
+        # [    0.000000] fadump: Reserving <>MB of memory at <> for preserving crash data
+        #
+        # Check if these logs are present in the fadump boot
+        self.wait_for_console_pattern("preserving crash data")
+
+        # Wait for prompt
+        self.wait_for_console_pattern("sh-5.2#")
+
+        # Mount /proc since not available in the initrd used
+        exec_command_and_wait_for_pattern(self,
+            command="mount -t proc proc /proc",
+            success_message="#"
+        )
+
+        # Check if vmcore exists
+        exec_command_and_wait_for_pattern(self,
+            command="stat /proc/vmcore",
+            success_message="File: /proc/vmcore",
+            failure_message="No such file or directory"
+        )
+
+    def test_fadump_pseries(self):
+        return self.do_test_fadump(is_kvm=False, is_powernv=False)
+
+    @skip("PowerNV Fadump not supported yet")
+    def test_fadump_powernv(self):
+        return
+
+    def test_fadump_pseries_kvm(self):
+        """
+        Test Fadump in PSeries with KVM accel
+        """
+        self.do_test_fadump(is_kvm=True, is_powernv=False)
+
+if __name__ == '__main__':
+    QEMUFadump.main()
diff --git a/tests/functional/qemu_test/linuxkernel.py b/tests/functional/qemu_test/linuxkernel.py
index 2aca0ee3cd..c4767527da 100644
--- a/tests/functional/qemu_test/linuxkernel.py
+++ b/tests/functional/qemu_test/linuxkernel.py
@@ -5,6 +5,9 @@
 
 import hashlib
 import urllib.request
+import logging
+import re
+import time
 
 from .cmd import wait_for_console_pattern, exec_command_and_wait_for_pattern
 from .testcase import QemuSystemTest
@@ -19,6 +22,62 @@ def wait_for_console_pattern(self, success_message, vm=None):
                                  failure_message='Kernel panic - not syncing',
                                  vm=vm)
 
+    def wait_for_regex_console_pattern(self, success_pattern,
+                                       failure_pattern=None,
+                                       timeout=None):
+        """
+        Similar to 'wait_for_console_pattern', but supports regex patterns,
+        hence multiple failure/success patterns can be detected at a time.
+
+        Args:
+            success_pattern (str | re.Pattern): A regex pattern that indicates
+                a successful event. If found, the method exits normally.
+            failure_pattern (str | re.Pattern, optional): A regex pattern that
+                indicates a failure event. If found, the test fails
+            timeout (int, optional): The maximum time (in seconds) to wait for
+                a match.
+                If exceeded, the test fails.
+        """
+
+        console = self.vm.console_file
+        console_logger = logging.getLogger('console')
+
+        self.log.debug(
+            f"Console interaction: success_msg='{success_pattern}' " +
+            f"failure_msg='{failure_pattern}' timeout='{timeout}s'")
+
+        # Only consume console output if waiting for something
+        if success_pattern is None and failure_pattern is None:
+            return
+
+        start_time = time.time()
+
+        while time.time() - start_time < timeout:
+            try:
+                msg = console.readline().decode().strip()
+            except UnicodeDecodeError:
+                msg = None
+            if not msg:
+                continue
+            console_logger.debug(msg)
+            if success_pattern is None or re.search(success_pattern, msg):
+                break
+            if failure_pattern:
+                # Find the matching error to print in log
+                match = re.search(failure_pattern, msg)
+                if not match:
+                    continue
+
+                console.close()
+                fail = 'Failure message found in console: "%s".' \
+                        ' Expected: "%s"' % \
+                        (match.group(), success_pattern)
+                self.fail(fail)
+
+        if time.time() - start_time >= timeout:
+            fail = f"Timeout ({timeout}s) while trying to search pattern"
+            self.fail(fail)
+
     def launch_kernel(self, kernel, initrd=None, dtb=None, console_index=0,
                       wait_for=None):
         self.vm.set_console(console_index=console_index)
-- 
2.43.5


