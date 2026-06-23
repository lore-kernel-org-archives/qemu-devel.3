Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C097CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 06:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbugG-00009D-VV; Tue, 23 Jun 2026 02:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wbugF-00008v-Ci; Tue, 23 Jun 2026 02:32:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wbugD-0006gV-Sv; Tue, 23 Jun 2026 02:32:19 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0nZb2310847; Tue, 23 Jun 2026 06:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0gvviKiEqKtOaD4DX
 1PTnTkhf2yytrnd+6jbc+XTNpA=; b=EHX282wEOB2MOE0SXtdPJpUIOcJqo0Yzy
 BpGyBth6f6+zSnpUUjT+gWgZEzi2zWdPwegZ+jFBZ4ZNdq/ELOw6jsH1vzKSexgt
 K/DVJXL0kIxwfxMpeGSZ0HkkhpaqS9+VjIIEBoht4jYpEI4FR/j+tZ9DZurk/VlP
 ezQ6qNdGei8XRlwrE+DFNy6XIYQh45uPlvpcOUFepxMGfPzi3nF1xhI1n5BZPpvB
 uDF/NwRSAJJP+XtxDMoircsBz4WihwyG6sPMbQMlVjAvfwrCTA0Sd5moTP1qpInK
 4BonHB87pezOkVyfcPKqn9fohDR9E2z4DhGdq1lFg9DMLLtSHkFAQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hn82t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 06:32:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N6Jind013937;
 Tue, 23 Jun 2026 06:32:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k1w1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 06:32:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65N6WBrh51904808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 06:32:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FD8C2004B;
 Tue, 23 Jun 2026 06:32:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1115320040;
 Tue, 23 Jun 2026 06:32:09 +0000 (GMT)
Received: from shivang.com (unknown [9.124.222.24])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 06:32:08 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH 2/2] ppc/pnv: add test to verify external DTB is honored
Date: Tue, 23 Jun 2026 12:01:56 +0530
Message-ID: <20260623063156.1110370-3-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623063156.1110370-1-shivangu@linux.ibm.com>
References: <20260623063156.1110370-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 3zGbLRZWZ9XH7E0SA73c5W69b3UiaCCV
X-Proofpoint-GUID: XAYiTKl1nbRuk8pVmtV2tW_6w36a23RZ
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3a2870 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=XFTqQVwi9e6oHPHJJl4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA0OCBTYWx0ZWRfX7MWbtCPHrN3S
 17iRtHPAKYcSIS3LzAA8QPajvun10frFIB6dhb7phyvsTalWYOZA/0gT5+qHXuj2+4wv9ADbHSd
 pIza5Eq71asQaL4aGaBYFa0s/N9KiMD9o+vYo40T6nk7nmTAzFPskN8ZYNrhhrjZjXL1Rl3ukIE
 qxsGH/jayb5nbeBSg7yX60jNVtp76iaVQstMtfnGorz4jlib+EQWlxWEO3/yDOIEQxEKxXJxTMz
 SKWybpyxnj/mhEYqgBydcIi0+RY37zLKCLqC+op8IWIuXTFoeX8VlikHNHhSFOcixOqe2eFrcH+
 4dtHsmgEgHDxzd7rRFFU6lM5JcK/ujPsyrGa3wlsrHkM78OuDEZrlE0S9Ok9zmb5MD9DzOxzcwP
 loB7qmRcYD+t603eHHkwkfCMuhkw0K5lcY1UkWKGCXji/654PGosgHQg9mpkXBAG+kemOZChXjz
 DU7Jzn5RLPUpKL0DVow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA0OCBTYWx0ZWRfXxYfY/j6a+6+C
 /CdpDopr5BKjkvly6V8D9C11CAYEqg+rIQ/RD7GnYG1F2SRCiD8UlPgOzlWu0ODemF53yPPT2mX
 kEPatjpBnWYmgnf0jkNySczyycjKICc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230048
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 tests/functional/ppc64/test_powernv.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index 0ea6c93e42..80801ee3dc 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -27,6 +27,11 @@ class PowernvMachine(LinuxKernelTest):
          'buildroot/qemu_ppc64le_powernv8-2025.02/rootfs.ext2'),
         'aee2192b692077c4bde31cb56ce474424b358f17cec323d5c94af3970c9aada2')
 
+    # testdtb for power11, which contains string "hello world" in command line
+    ASSET_SAMPLE_DTB = Asset(
+        ('https://github.com/roz3x/qemu/raw/refs/heads/sample-dtb/output.dtb'),
+        '2dd3330561768fc5c8e4b93aa29bc44c64278d186f1e0f8c584cdf15c3f8cf43')
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


