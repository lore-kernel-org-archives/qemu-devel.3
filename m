Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B6BC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 04:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfVlu-0002C7-SC; Fri, 03 Jul 2026 00:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wfVln-0002Aj-Fg
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:44:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wfVlY-00038k-QK
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:44:44 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631IU7J1202011
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 04:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=l8+tcnKQiXeRfQTZc
 QsjFHwE0XWO4GEvExQ2EYO3Lic=; b=JwvIyUd7dHWn3RKwGA2Fw+WVkPVg8wDFw
 OxeeziaqnNYrUfzP5O2S5j7ZVkP5b+0hl979AtHY8gemT9wATqp25Rh16jiWGHNe
 sB3m+7AKbeULbewnlMTJKYkaY77Lz/2obhlGz/xkYM2yGlV5lci8CLTKfZocWXYZ
 /xgz1HpOrCdqo9xjtZn603TdDQgC98WW2HyQorqbA0w2y+kfGDis/VUmVlzK6Dl1
 0XQ7+yzR0f8Ov/jeN/Z7IQEmgmi7aRqZVBcXF3RamJuk0E4zGzndZIA8YjaFTBNz
 D/VQocCyAYfNyNTAaFMQHefKgo6/nEuExnE5v2zfAt0RTM+hoGe5g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qacydj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 04:44:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6634YnEY030274
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 04:44:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukf6j1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 04:44:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6634iQIw50528692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 04:44:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC91520043;
 Fri,  3 Jul 2026 04:44:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CC5620040;
 Fri,  3 Jul 2026 04:44:25 +0000 (GMT)
Received: from Mac-11.lan (unknown [9.39.22.184])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 04:44:25 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>
Subject: [PULL 7/7] ppc/pnv: add test to verify external DTB is honored
Date: Fri,  3 Jul 2026 10:14:02 +0530
Message-ID: <20260703044402.79723-8-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260703044402.79723-1-harshpb@linux.ibm.com>
References: <20260703044402.79723-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAzNyBTYWx0ZWRfX3AFFh2FlCBVH
 v1vOsUrvwqzFdEhtl1x8ECbkU7g2y1tCDyzYr1xtn9HewRGCangJDll4yBOMiisK2el4Ki5S7s5
 WtI84xiJbPd0wkR9AJwE0H3j0JB0pGXto73VetlGGrzwNa8zdF0GDsCF4mZwB4kk2kU1eOkEr5K
 vb1YlwY5YZRPEmuWhVp0ohBROZNSdrDln6/CZkJJwJEU5NB5TRMyeXKNrYEiiuojB49e7fsu+pJ
 qD0I55OIV89IIccgJOvPZfPXiwjWrtxATm1V71rkeyvp227485tT3MAS3Gerg8CeAja4Pq/w+iw
 pN4idPsKgopSkckaRKDhfYtlnGvWH+RQVmTpfSvMtHXZd1DcPk4LxizpHPDbSbdAzYK4BJONK1v
 o/qtnKAs9UUXtPvMx4sqhnjlbZf4hRGBXR2J6pY0P7Dngkptn8xwzDt1tv0EhUloSeRc4QzQoju
 ivn/NeusZFCCHk4F8Rw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAzNyBTYWx0ZWRfX8zjb8ESzegZe
 rISsy7/+LEcDkthrGCGfWEbuml3KzU3zYZEqYf71eZFeK0qcx9uFy0JMs3ggiS5W2nFM7yQc8gz
 38+alUeh6PWwjE4dJAo/jLNdG3kXBFM=
X-Proofpoint-GUID: ckk86Xcz4A7MLeeOJYVBTA2cmAdtc932
X-Proofpoint-ORIG-GUID: ckk86Xcz4A7MLeeOJYVBTA2cmAdtc932
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a473e2f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=NEAV23lmAAAA:8 a=ns4rDsgIVyfxSIRMX-EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030037
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

Test boots a powernv11 machine, using a custom dtb.
Custom dtb has the following bootargs.

    chosen {
        bootargs = "hello world";
    };

Test Checks whether above bootargs make it to kernel's command line.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260630103508.254000-3-shivangu@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 tests/functional/ppc64/test_powernv.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index 0ea6c93e42..b5b2f0d158 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -27,6 +27,11 @@ class PowernvMachine(LinuxKernelTest):
          'buildroot/qemu_ppc64le_powernv8-2025.02/rootfs.ext2'),
         'aee2192b692077c4bde31cb56ce474424b358f17cec323d5c94af3970c9aada2')
 
+    # testdtb for power11, which contains string "hello world" in command line
+    ASSET_SAMPLE_DTB = Asset(
+        ('https://github.com/roz3x/qemu/raw/refs/heads/sample-dtb/qemu-powernv11.dtb'),
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
2.52.0


