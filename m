Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ED7C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgedy-0004Mv-Uv; Mon, 06 Jul 2026 04:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wgedZ-0004Dc-6O
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:25:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wgedW-0007ad-9H
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:25:08 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665MIeln1515423; Mon, 6 Jul 2026 08:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9bKGxV
 Fy0P6T+l+6WPC6BF9XJpZr4yjTYaQj0DM8VD8=; b=T25x/Ljrbc14gr/0/3Fww0
 j1HHO/oluizUlZAlz2ztObHekMYuxuO2NIElWYxY2ky5J3mnvz2c1OHMJNezb91B
 1ROd4vDh881piLR9Lv8M1jC8aKQvSiiB15SOsefU7t/pTREy9/H162Z6ZxUhGBog
 Aq18yGN+DxCLBpyBmNLYDT2YCCvHgR1UnCGb6USx1yTyeAgRPxh5V2ESb8RMSV4Q
 jeCXRSY3qEcQHQ9U4APjdznLQzORtezFfWCNzVgUIdqhll7dEOI+MxiAXAvr7Uzt
 mXaZI4npe+s4VoksmxeeDxMqiZmJSUZEDyyZYvZLU1OggGvPu0+CWVFzK/7K9imA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdh3c3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 08:25:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668JqCp025839;
 Mon, 6 Jul 2026 08:25:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvvvr9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 08:25:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6668Ox7w54985146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 08:24:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC77320043;
 Mon,  6 Jul 2026 08:24:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9391A20040;
 Mon,  6 Jul 2026 08:24:58 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.1.190])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 08:24:58 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 1/8] tests/functional: Add remote interrupts test for PowerNV
Date: Mon,  6 Jul 2026 13:54:44 +0530
Message-ID: <20260706082451.59299-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706082451.59299-1-harshpb@linux.ibm.com>
References: <20260706082451.59299-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4b6660 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=NEAV23lmAAAA:8
 a=uOBmU7MlvPw7Df0ZYZUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfXy4w7HZ+w1Jvo
 1ZRvU+TH2+MHiVlqeC5K61Gb6PF2els7/TyrCTYYDZhlVM9M08Vshgu2zPrGGZFEr34/qbke6U0
 cy9Th98FO/3VsFNTYblktrSp7+xTxvXt7dRtXt2+0hf2hw8DQOe6CkK8ORO3/KHR4hxBhntpmWK
 5yeKGbaKiG+ii2Z5LTB8DvDqow1PMyWZ1+7ebU557VgUv/e89VcreUcN3C+AG3cSGHxJh9/T2u1
 2jjE438UaO2n4QIrWS21ZjoaQmRFw4vJKZ19riy4gB3G0wxPgT085SX1zk7YAZE5o9G+rooxB5R
 NrYNAAbYueZt5B8p1ceB5rh5u+BnYjqEf3PeeIyLEOVbNaCTDzljAFl4v9x5rkAKJr54G53kpZh
 irFH0+kgCkfBOoVD58d7Cr1OxhgMGsYNDw5lBMrKZE/dcoX49Rrsv9FJuzJGExfcNaT36bC0ZgD
 umlRic8W9sdeU0ptIZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfXxl0XYk/j3wM1
 qH7a4OrhclkxkW5ROV5iTZOj5amuorwARCwfY2BFCmCGQxPHNORLm9SHagtmgDAQphY8fCd6CUw
 0MJVLvk7wmXV1IDovpY64G1i7JVgC5Y=
X-Proofpoint-GUID: mvqr-feeUS-J4vMRGj1sk1irvdcJ6x5R
X-Proofpoint-ORIG-GUID: mvqr-feeUS-J4vMRGj1sk1irvdcJ6x5R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060083
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

From: Aditya Gupta <adityag@linux.ibm.com>

In the past there have been hard to recreate issues where XIVE changes
cause qemu crashes due to multi-socket interrupts such as in [1].

Add a functional test explicitly to test whether remote interrupts work.

The test can also work as additional boot test for multi-socket boot,
initrd boot test, as well as a check for e1000e to be working in powernv,
though that's not a target goal, and are additional benefits.

>From docs/system/devices/net.rst:

  In order to check that the user mode network is working, you can ping
  the address 10.0.2.2 and verify that you got an address in the range
  10.0.2.x from the QEMU virtual DHCP server.

Hence use 10.0.2.2 with ping.

[1]: https://lore.kernel.org/qemu-devel/baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com/

Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260703085955.2318600-2-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 tests/functional/ppc64/test_powernv.py | 95 ++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index b5b2f0d158..bac2017e18 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -9,6 +9,7 @@
 
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
 
 class PowernvMachine(LinuxKernelTest):
 
@@ -32,6 +33,17 @@ class PowernvMachine(LinuxKernelTest):
         ('https://github.com/roz3x/qemu/raw/refs/heads/sample-dtb/qemu-powernv11.dtb'),
         'ea1271516264eea1eb58a067a99d0c2ca9528be8dc7d4e46bb2d5ae0d42fc568')
 
+    def shell_exec_command_check_fail(self, command):
+        fail_msg="Fail"
+        self.shell_exec_command(f"export __FAIL_MSG={fail_msg}")
+
+        # If the exit code for the command is non 0, print fail message
+        command = command + " || echo $__FAIL_MSG"
+        exec_command_and_wait_for_pattern(self, command, '#', fail_msg)
+
+    def shell_exec_command(self, command):
+        exec_command_and_wait_for_pattern(self, command, '#', self.panic_message)
+
     def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
         self.require_accelerator("tcg")
         kernel_path = self.ASSET_KERNEL.fetch()
@@ -76,6 +88,89 @@ def test_linux_smt_boot(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message)
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
+    def test_linux_remote_interrupts(self):
+        self.require_accelerator("tcg")
+        self.set_machine('powernv')
+
+        # Have below setup in this test:
+        # 1. e1000e attached to pcie.6, which is from 7th PHB, belonging to 2nd
+        #    socket (chip 1), in a powernv boot with default 6 PHBs per socket
+        # 2. CPU on 2nd socket (chip 1) disabled
+        # 3. RX IRQ's affinity to chip 2, and TX IRQ's affinity to chip 3
+        #
+        # Then ping is done, to generate interrupts from e1000e which should go
+        # to IRQ server on the remote sockets
+        self.vm.add_args('-smp', '4,sockets=4,cores=1,threads=1')
+        self.vm.add_args('-netdev', 'user,id=net0')
+        self.vm.add_args('-device', 'e1000e,netdev=net0,bus=pcie.6')
+
+        kernel_path = self.ASSET_KERNEL.fetch()
+        rootfs_path = self.ASSET_INITRD.fetch()
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path,
+            '-drive',
+            f'file={rootfs_path},format=raw,if=none,id=drive0,readonly=on',
+            '-append', 'root=/dev/nvme0n1 console=hvc0',
+            '-device', 'nvme,drive=drive0,bus=pcie.2,addr=0x0,serial=1234')
+        self.vm.launch()
+
+        # Wait for boot to complete
+        console_pattern = 'CPU maps initialized for 1 thread per core'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        console_pattern = 'smp: Brought up 4 nodes, 4 CPUs'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        wait_for_console_pattern(self, 'Run /sbin/init as init process',
+                                 self.panic_message)
+
+        # Wait for login prompt and login as root (no password in buildroot)
+        wait_for_console_pattern(self, 'login:', self.panic_message)
+        exec_command_and_wait_for_pattern(self, 'root', '#', self.panic_message)
+
+        # e1000e is connected to socket 1, disable the CPU on socket 1
+        self.shell_exec_command("echo 0 > /sys/devices/system/cpu/cpu1/online")
+        self.shell_exec_command(
+            "export CPU1_STATE=$(cat /sys/devices/system/cpu/cpu1/online)")
+        self.shell_exec_command_check_fail("[ $CPU1_STATE -eq 0 ]")
+
+        # RX, TX interrupts to chip/cpu 2 & 3 respectively
+        self.shell_exec_command(
+            "export RX_IRQ=$(awk '/eth0-rx/ {print $1}' /proc/interrupts | tr -d ':')")
+        self.shell_exec_command(
+            "export TX_IRQ=$(awk '/eth0-tx/ {print $1}' /proc/interrupts | tr -d ':')")
+        self.shell_exec_command("echo 2 > /proc/irq/$RX_IRQ/smp_affinity_list")
+        self.shell_exec_command("echo 3 > /proc/irq/$TX_IRQ/smp_affinity_list")
+
+        # Capture interrupt counts before generating traffic
+        self.shell_exec_command(
+            "export RX_BEFORE=$(awk '/eth0-rx/ {print $3}' /proc/interrupts)")
+        self.shell_exec_command(
+            "export TX_BEFORE=$(awk '/eth0-tx/ {print $4}' /proc/interrupts)")
+
+        # Wait up to 15 seconds for eth0 link to come up
+        self.shell_exec_command(
+            "c=0; while ! ip addr show eth0 | grep 'inet 10.0.2'; do "
+            "sleep 1; c=$((c+1)); [ $c -gt 15 ] && break; done")
+
+        self.shell_exec_command_check_fail(
+            "ip addr show eth0 | grep 'inet 10.0.2'")
+
+        # Generate network traffic to trigger remote interrupts
+        # Ping QEMU's user-mode network gateway (10.0.2.2)
+        self.shell_exec_command("ping -W2 -c5 10.0.2.2")
+
+        # Show final interrupt counts to verify remote interrupts occurred
+        self.shell_exec_command("cat /proc/interrupts | grep eth0")
+
+        # Verify interrupt counts increased (whether interrupts were delivered)
+        self.shell_exec_command(
+            "export RX_AFTER=$(awk '/eth0-rx/ {print $3}' /proc/interrupts)")
+        self.shell_exec_command(
+            "export TX_AFTER=$(awk '/eth0-tx/ {print $4}' /proc/interrupts)")
+
+        # Check that interrupt counts increased
+        self.shell_exec_command_check_fail("[ $RX_AFTER -gt $RX_BEFORE ]")
+        self.shell_exec_command_check_fail("[ $TX_AFTER -gt $TX_BEFORE ]")
+
     def test_linux_big_boot(self):
         self.set_machine('powernv')
         self.vm.add_args('-smp', '16,threads=4,cores=2,sockets=2')
-- 
2.52.0


