Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401B7CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd4eR-000832-8p; Fri, 26 Jun 2026 07:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wd4e8-0007qE-Fb; Fri, 26 Jun 2026 07:22:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wd4e6-0008Me-Lm; Fri, 26 Jun 2026 07:22:56 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QAIVfD2720502; Fri, 26 Jun 2026 11:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=QXbiSBri+KO47LQF7
 k79BiL1uWCs/Lk2BbgoT6Jctxw=; b=bH3ulWcaynoZsqGsM84ywYoQgQoH/7Zgt
 C6l1kWoZ8ik/HXDb6I/Ny/ZPGzTF7CBMJswoK0fSUom0Gteh7vI6MMopPIL2Dg8f
 XktjCTMowlyz32DbKOyG0NhXfYHPE3k2QAyP2wkuHmHi11h5e4OGkrCW9bDTGUvK
 xtk+qRkw3bfxX2yVREm0cHOdo4HXhmNJwlZv1ZTZiGOnbsVVjS/8HoKNA1I5BQf8
 1Oscjs7LlnPKZD52GoX4F8IlWkEk6RrWvL5RT5P9rH+N8w3LtKVGICxMxhmlRebS
 Y6vNfH0xORQqQUhLr3RAeX/n+M7OZdsNvA3NW7YxbACypY8bY4DHA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4xr81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2026 11:22:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QBJe7i029443;
 Fri, 26 Jun 2026 11:22:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qu1x4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2026 11:22:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65QBMl0c44761510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jun 2026 11:22:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76B8C2004B;
 Fri, 26 Jun 2026 11:22:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE37120040;
 Fri, 26 Jun 2026 11:22:45 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jun 2026 11:22:45 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: shivangu@linux.ibm.com
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH v2 2/2] ppc/pnv: add test to verify external DTB is honored
Date: Fri, 26 Jun 2026 16:52:39 +0530
Message-ID: <20260626112239.177191-3-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112239.177191-1-shivangu@linux.ibm.com>
References: <20260623063156.1110370-1-shivangu@linux.ibm.com>
 <20260626112239.177191-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA5MiBTYWx0ZWRfXyG+bR6/VlP2B
 01f7fnh67hFKn6D9uiO6U81pLXzfftJjjh/IavzJXdDOKrqKpgPRMzo06hPT49aHd8vc99BmT7n
 UTU3Djc4xnSewrbeTid0D1EQEJwCmOM=
X-Proofpoint-ORIG-GUID: YTWi9OLNTgIPKMM2Iy1rdWF7_AyfkQ1w
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3e610c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=vTJmdUFZDnpqFwBdPLoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA5MiBTYWx0ZWRfX+hbCWvTUtSSR
 Yjt5pVPtPVD0zi5hKQ60/m81KkMGO3aGYNF7EAfWG5VcN6/ArH/hjt+upJS4VeKo5rZ4jQLIr9D
 Aiku1k+9mHSNoNeAeVuIj7fBibkm75I2JwgKZrJBSyeOdL9Ly6BnT4W3ragVcAGpW3PsQ5B1sIY
 hZ5eSrwMbsWHxitLtSj3aadQb9HrIeNRggGwGjSbeNVRI4HioHPtJ0OCLdDiwK9gS4GrSRvJho3
 CPJR+XIoQkkBvQtaXxCPMEiGU8WGgl7uKahNT+e2IDi0stwxaGG2GCKBLvJa9W98gNh6ctkqaFG
 D71ueRwVpVp0q/6RXuVZk9YPjPqmh7F6EUThiYsgepveslwE7HPJIYmaeIQD0xX5HOoXIL8vFz2
 V5DaGUhiH1E7JwI2YsAHQYahvUNI+4xnhYVSn3iJ3lOTUhqNPNncjdOvtdVCXLdYVe4FMUddk9N
 0RZwtl/eFY7fvojFrfQ==
X-Proofpoint-GUID: w-o3ZwphgZ03MAVIm0vemmEfKryJiPXO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260092
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Test boots a powernv11 machine, using a custom dtb.
Custom dtb has the following bootargs.

    chosen {
        bootargs = "hello world";
    };

Test Checks wheather above bootargs make it to kernel's command line.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 tests/functional/ppc64/test_powernv.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index 0ea6c93e42..cb8f6545a0 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -27,6 +27,11 @@ class PowernvMachine(LinuxKernelTest):
          'buildroot/qemu_ppc64le_powernv8-2025.02/rootfs.ext2'),
         'aee2192b692077c4bde31cb56ce474424b358f17cec323d5c94af3970c9aada2')
 
+    # testdtb for power11, which contains string "hello world" in command line
+    ASSET_SAMPLE_DTB = Asset(
+        ('https://github.com/roz3x/qemu/raw/refs/heads/sample-dtb/output.dtb'),
+        'ea1271516264eea1eb58a067a99d0c2ca9528be8dc7d4e46bb2d5ae0d42fc568')
+
     def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
         self.require_accelerator("tcg")
         kernel_path = self.ASSET_KERNEL.fetch()
@@ -104,6 +109,20 @@ def do_test_ppc64_powernv(self, proc):
         # Device detection output driven by udev probing is sometimes cut off
         # from console output, suspect S14silence-console init script.
 
+    def test_ppc64_powernv_external_dtb(self):
+        self.set_machine('powernv11')
+        self.require_accelerator("tcg")
+
+        kernel_path = self.ASSET_KERNEL.fetch()
+        sample_dtb_path = self.ASSET_SAMPLE_DTB.fetch()
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', sample_dtb_path)
+        self.vm.launch()
+
+        # check if custom dtb is reflected or not
+        wait_for_console_pattern(self, "Kernel command line: hello world", self.panic_message)
+
     def test_powernv8(self):
         self.set_machine('powernv8')
         self.do_test_ppc64_powernv('P8')
-- 
2.54.0


