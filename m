Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A62CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXEpu-0001h2-3V; Wed, 10 Jun 2026 05:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXEpr-0001gL-PL; Wed, 10 Jun 2026 05:02:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXEpq-0005gB-1S; Wed, 10 Jun 2026 05:02:55 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659JHP8T1271233; Wed, 10 Jun 2026 09:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=OTc20iikPNQ5biuIU
 XqboGokYPRRFeqrY770e74eKm4=; b=QE09fqFCMYK1P/pb6XA8J5TMOXS5HV3N1
 3wLmOm+bor8vNoY+9dFtFCufehN6sAzf01HWd1iBgPSKV6e3MB1SnwrDuzL4VxKz
 XQJUaLuQZHwp24rfuyeQ1u9qb7gMo+p3XSk8jj4Q86FXm+5pJeVjsMNVbsZqIg3a
 Y5e+R5YUMvLJCAmpJ4g1LKfepYqUMXO+68q4HpaH0DtDAsKcXkFydDN3jcFvnaek
 YA+2NTDQ6BmtGjrWnGHG5H35Cvt/gpE2ZIZsRvlj7tffX+Z98IFqfsbXa+SKRIye
 Hq1jSLzupnfH9hJR6wlEBQh+7tZERDnA8dxKpNubHay/w/Uepz9sg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye7yjc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 09:02:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A8nhQD026277;
 Wed, 10 Jun 2026 09:02:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq63nf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 09:02:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65A92lLT46006714
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2026 09:02:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1C0E2004B;
 Wed, 10 Jun 2026 09:02:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E43A220040;
 Wed, 10 Jun 2026 09:02:42 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.29.92]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jun 2026 09:02:42 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH 1/4] tests/functional: Add remote interrupts test for PowerNV
Date: Wed, 10 Jun 2026 14:32:32 +0530
Message-ID: <20260610090235.3665904-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610090235.3665904-1-adityag@linux.ibm.com>
References: <20260610090235.3665904-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4MSBTYWx0ZWRfXyQMHpeAa4ozl
 iz8FZnvPOHmhFTtpWVCYwOnlpzUISPK0VV3jx7OE2RTG0NuTVqWnL2DKoWUSwbl6IBDMVlJg7KD
 8DkBttjZSVhJ1wnmztvSjDJGqHRYyYKGvvSgWMLnP1fGDBqYO8kZCXoST7a5WMe9A6/OA64FEwJ
 99i/EbLtIwYRucyVuQC1gOZiFdTWjCl+aoIH2reNUsSdpQROqmWbiuo6tnkTE5qX3r8d68QVu3v
 5S2zhu+D1e0HIhmr/zhuuoNiiqPQdM5zKLQt1t8fdvA0EYfWQGz9YY18PewiCI5Q8HjK4AqG/09
 0GxiKwhn4tuN1zuSAtSeUMRBdJTm2VB45VENE3A5oUiB7XutFgE+kiGCIDij9BFRA3OVuGdTND0
 wGp9cH2zbYtsUbJL3wTJCuNuGcosPA8RIrhgjLVzV0ecx7GxYiyIqzLeL7Bgy2YteeW1poq8a6L
 7w9rdFwq3mmjJqdsFMQ==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a29283c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=i5VTC3xzFh1J627jsWkA:9
X-Proofpoint-GUID: pyE4XFj6Sx7AHvmpeS-oGLKPeKNxcP2F
X-Proofpoint-ORIG-GUID: NpoN7JrwkJk1CDsXcqnin-68FNjT05UK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100081
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

In the past there have been hard to recreate issues where XIVE changes
cause qemu crashes due to multi-socket interrupts such as in [1].

Add a functional test explicitly to test whether remote interrupts work.

The test can also work as additional boot test for multi-socket boot,
initrd boot test, as well as a check for e1000e to be working in powernv,
though that's not a target goal, and are additional benefits.

From docs/system/devices/net.rst:

  In order to check that the user mode network is working, you can ping
  the address 10.0.2.2 and verify that you got an address in the range
  10.0.2.x from the QEMU virtual DHCP server.

Hence use 10.0.2.2 with ping.

[1]: https://lore.kernel.org/qemu-devel/baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com/

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/functional/ppc64/test_powernv.py | 65 ++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index 0ea6c93e4287..eef000ab0e04 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -9,6 +9,7 @@
 
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
 
 class PowernvMachine(LinuxKernelTest):
 
@@ -71,6 +72,70 @@ def test_linux_smt_boot(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message)
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
+    def test_linux_remote_interrupts(self):
+        self.require_accelerator("tcg")
+        self.set_machine('powernv')
+
+        # have more sockets with as few CPUs as possible, increasing the
+        # probability to have remote interrupts from one chip to another
+        # also have e1000e network device to generate interrupts
+        self.vm.add_args('-smp', '4,sockets=4,threads=1')
+        self.vm.add_args('-device', 'e1000e,netdev=net0')
+        self.vm.add_args('-netdev', 'user,id=net0')
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
+        # RX, TX, Control interrupts to chip 2, 3, 4 respectively
+        exec_command_and_wait_for_pattern(self,
+            "RX_IRQ=$(grep eth0-rx /proc/interrupts | awk '{print $1}' | tr -d ':')",
+            '#', self.panic_message)
+        exec_command_and_wait_for_pattern(self,
+            "TX_IRQ=$(grep eth0-tx /proc/interrupts | awk '{print $1}' | tr -d ':')",
+            '#', self.panic_message)
+        exec_command_and_wait_for_pattern(self,
+             "CTL_IRQ=$(grep 'eth0$' /proc/interrupts | awk '{print $1}' | tr -d ':')",
+            '#', self.panic_message)
+        exec_command_and_wait_for_pattern(self,
+            "echo 1 > /proc/irq/$RX_IRQ/smp_affinity_list",
+            '#', self.panic_message)
+        exec_command_and_wait_for_pattern(self,
+            "echo 2 > /proc/irq/$TX_IRQ/smp_affinity_list",
+            '#', self.panic_message)
+        exec_command_and_wait_for_pattern(self,
+            "echo 3 > /proc/irq/$CTL_IRQ/smp_affinity_list",
+            '#', self.panic_message)
+
+        # Generate network traffic to trigger remote interrupts
+        # Ping QEMU's user-mode network gateway (10.0.2.2)
+        exec_command_and_wait_for_pattern(self,
+            "ping -W2 -c5 10.0.2.2",
+            '#', self.panic_message)
+
+        # Show final interrupt counts to verify remote interrupts occurred
+        exec_command_and_wait_for_pattern(self,
+            "cat /proc/interrupts | grep eth0",
+            '#', self.panic_message)
+
     def test_linux_big_boot(self):
         self.set_machine('powernv')
         self.vm.add_args('-smp', '16,threads=4,cores=2,sockets=2')
-- 
2.54.0


