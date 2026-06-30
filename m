Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F27C43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weVoP-0002cW-L1; Tue, 30 Jun 2026 06:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1weVoN-0002c6-Sa; Tue, 30 Jun 2026 06:35:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1weVoL-000202-TX; Tue, 30 Jun 2026 06:35:27 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9n6Fd1843361; Tue, 30 Jun 2026 10:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=OAYq1j3JLwpniO+8h
 yRZFLlSp1odFBS6+jBOH/6ak/I=; b=muwx8d9y2qdg+Q9plqwJaiIY838cUESFw
 m0i7HeCjRRnOJi3m1fjb94tL6uNvt2CslzmiXYfz6r1IAnHw3fAEoa8AT9VaX0ry
 ktepqptabyxXVXqabm+ETQ4Q1/Gw0NroBVLS2S1w3vK9xY5FrWG+bdwf9ARyHfx9
 eWfYnw++S7ceAEY6SaFKjRNmkW5a+pGpTg76AxvIeL9xfWAkbPDvmrsAQXRHgfyw
 YHuvptd9cSUMh0mLpQZ3AUS9HdyFNospB1LHTps6Y9uEDwAuCfaAbTeZx2c5mFu2
 02CbYXk3RBcwl6lkK/fAZ6lp32OIRt9oUxsA9jOVw33Da+VAP7m6w==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfx4nr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 10:35:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UAYqge032648;
 Tue, 30 Jun 2026 10:35:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2g9hb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 10:35:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UAZIJ748103808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 10:35:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDAE020043;
 Tue, 30 Jun 2026 10:35:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E632F20040;
 Tue, 30 Jun 2026 10:35:16 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 10:35:16 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: shivangu@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v3 2/2] ppc/pnv: add test to verify external DTB is honored
Date: Tue, 30 Jun 2026 16:05:08 +0530
Message-ID: <20260630103508.254000-3-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630103508.254000-1-shivangu@linux.ibm.com>
References: <20260630103508.254000-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a439beb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=vTJmdUFZDnpqFwBdPLoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX+wy9xa6ZUzQ3
 rdVfwiehAjIbqzBHTkeAccX4n8A+fhF840VYjlgERxVWCz4tNUJWSj0beTzLhwQnibry7iDFouV
 5W1SZu02Cj948B/oBqN+b/CxPb/dRQc=
X-Proofpoint-GUID: IkDshozW90IfYSAOsqAF6r7lUX1YAz6p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX12beztuojIXX
 kwqWD/V/HE5C+1d6PKAx0/WlMYB/kmbdkpAak7+cT8aB3euH5bOH85HIq3FhrNXzeItXjIRUaVv
 /tGopGPhtMoALv4oYzxnIXHUpDUrzLBBq1Ttqzkz7rjKwSAUKAnPQrMD4dguXfikraFomCgXjxJ
 wXmuUO0b0EirslaY8wUvFTCOJ0P242i0J49CXfMAjdNH1B+UU7CNIGRo02ztcC+ZyPZtHKrVZTw
 GzkyGNbr+6rprrCdOkPksR41/28YwwG2TdcqgC8EBTs4nX1/4Gb1BQK2WvKRfSVubA8bFGKME5K
 StaJV8Y8EjQx0x2K+7tJdDnS2/dpZk4UVEDQ+S4haibvcvOR5/eus6Rm3gRCCZvH+O/9ff8zA9v
 Et488Sng929bvZnEn5Q9/4zWpO+/AmN/wc3wCmpG7zhwDRtyHxEsj8PJcfIU87M1qlHVwLMmJ6Q
 9GEjUk0x672pXphZ9ZA==
X-Proofpoint-ORIG-GUID: IhuvoZMklEeSQF93ARy64gDML7-NX3-u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093
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

Test Checks whether above bootargs make it to kernel's command line.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
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
2.54.0


