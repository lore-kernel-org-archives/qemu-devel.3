Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6420C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBgH-00062r-0F; Fri, 24 Jul 2026 04:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wnBgF-000623-KC; Fri, 24 Jul 2026 04:54:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wnBgD-0005RQ-SQ; Fri, 24 Jul 2026 04:54:55 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O5BsjC825594; Fri, 24 Jul 2026 08:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=44CtHWL9FvI3Sl5VjEEUqKaICbdqIA8sFBOpfgBsu
 hM=; b=KgEirAk6RSZPGz2Cv6xMtzduHKwUVxNxFL1rN/EpZNZmsiAcQINUv8f9y
 d+kBY1qGSsshcDvLPjeLRK++sngsn8HATkrpHBZHSDccYDu6euuh7zBVuw3KJOAI
 GEH5h4md0hPavzYFsxL4xnhypESmOeF91TXFTwLu/Jxgipk3ihKv9t11IpXcP1G7
 knFefgBCpL25dRCn4mP5lFLjaJoo8R4fe4eXJF8sXTp9XTj80koWvqNYa+5c8fas
 4Mbm9LSXFrT5EVZ7uiE85F9K16qmKiUkf6+cdQtSHWuO0v0QNp5Rt6C03nXnvp5e
 PqY7yTFft3eVIEBouC9mZ6pwgIzlA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kk8s5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 08:54:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O8nbkf011015;
 Fri, 24 Jul 2026 08:54:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gqyt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 08:54:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66O8skeG53019084
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 08:54:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE4F4200D7;
 Fri, 24 Jul 2026 08:54:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4489200DE;
 Fri, 24 Jul 2026 08:54:43 +0000 (GMT)
Received: from shivang.com (unknown [9.124.222.251])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2026 08:54:43 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: adityag@linux.ibm.com, amachhiw@linux.ibm.com, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH] tests/functional/ppc: skip remote interrupts test if -net
 user not built
Date: Fri, 24 Jul 2026 14:24:40 +0530
Message-ID: <20260724085440.520125-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a63285b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=59kGxIDDvnFkswMMbX8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3OCBTYWx0ZWRfXyExEZ6h4LFfJ
 t2/fkUuw4miFdHaEPzXxKlJJ6cyYSvteFJrwY2gi3b0j94Tq8sPUopXyBw6PySQo5WSiQdr9Pk9
 utPuXLQWE2joqSe0rPTyzlRMaTMkiVV2AxfMQqJAn5ZD2lLnHFhqL+I1zweS5n23HQia26KuDPG
 mFsxnBVyuxxBDOKYfgHhHhkQLNEnIs3wniKs+V8BGmTVB0LtVVD3LdgDGFSBhPr5L1Wge8rsQaf
 b3abcAS62eYCbdZKdv7Q+mTs34LWm9MrOCdnHbdsRxj+3etFHYpZZpitYL7OkNzSuHiZ55bZYSo
 LjRH4SWSidDsfJVtyqLs1h5jcTozACyCRVXhaiObnCNsyLGmHNvyJeDzW1LjM4yeDYJgT2w55uc
 YmKP9S4p0ErkDxENGkpIJDGYa/Ym1HJk2eHT7kqGPWmnVLN8Jhu3KzE9YERNFIVr6+OmyFQ3b4X
 LEPpi3DbNRBpYP0owwQ==
X-Proofpoint-ORIG-GUID: 2bT37hadG9LsR0wrpz32VjpSoYLSnbJH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3OCBTYWx0ZWRfX4RluCpDwvG6A
 SeSzNsEsY+vq0xZIWt9THl+KHGJwCpfzmGXsLy0NBgXcwCuLO3HWgvzisoc7H4JdnPjXz66jNMU
 VDcDu9paXJaBQQkMLZITqyREhpeCEao=
X-Proofpoint-GUID: mhCT4_u_qEjIw9VbTlQ6WyKtuxYVhi1b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240078
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

While running remote interrupts test, without libslirp-devel installed,
facing the following panic logs.

  File
    ...
    raise VMLaunchFailure(
    ...<3 lines>...
    ) from exc
    ...
        Output: qemu-system-ppc64: -netdev user,id=net0: network backend
'user' is not compiled into this binary

Skipping the test if vm fails to launch.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 tests/functional/ppc64/test_powernv.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index bac2017e18..73ba4e7221 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -11,6 +11,8 @@
 from qemu_test import wait_for_console_pattern
 from qemu_test import exec_command_and_wait_for_pattern
 
+from qemu.machine.machine import VMLaunchFailure
+
 class PowernvMachine(LinuxKernelTest):
 
     timeout = 90
@@ -112,7 +114,11 @@ def test_linux_remote_interrupts(self):
             f'file={rootfs_path},format=raw,if=none,id=drive0,readonly=on',
             '-append', 'root=/dev/nvme0n1 console=hvc0',
             '-device', 'nvme,drive=drive0,bus=pcie.2,addr=0x0,serial=1234')
-        self.vm.launch()
+        try:
+            self.vm.launch()
+        except VMLaunchFailure:
+            # Maybe not compiled with netuser backend
+            self.skipTest(f'Could not find -net user')
 
         # Wait for boot to complete
         console_pattern = 'CPU maps initialized for 1 thread per core'
-- 
2.54.0


