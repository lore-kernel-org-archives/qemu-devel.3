Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4964CC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk2an-0006lP-K5; Wed, 15 Jul 2026 12:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wk1te-0000Ck-G7; Wed, 15 Jul 2026 11:51:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wk1tc-0004mr-RB; Wed, 15 Jul 2026 11:51:42 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FEBvX2398635; Wed, 15 Jul 2026 15:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ZEQKA6xQPW5jDx6y/
 ZJ9epYr43roe0tnp/zAdk9GvVo=; b=h/1yqKbWr6d39kRipyF/bb6Q7AlUcHGBp
 EOjiFNNtDRTj0H466oLRCTeHMMtfcoqsmEW8xCC7MuVzVXI0IaTAFs5y32ZRM6t9
 fC9kyWeFbDXnRIvCwsLWSZq2mKNzE0xYyPd9daaL+JiRGs9uZNHVSUFhbWzmzThm
 1M4DIk9POpkd8ypPzrEM+mEl7o+Lgn4uSvl+sgjGeBHK31nhZI+IKnsO6Ca981yv
 x0Tn3g9wu1vLJTbO+Bm69bXmHn27fgvJ0+m6b4nuovg2Z8+yzgnFbEDkMtEndJLA
 sGhlxLYzYH9nEtpsS8gKF6YrQZJ/6aDFUK2c6gMgL//+HAfO4Y78g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxmcdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 15:50:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FFYanL008961;
 Wed, 15 Jul 2026 15:50:53 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhgnfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 15:50:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66FFonAm32768598
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2026 15:50:49 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32C4358055;
 Wed, 15 Jul 2026 15:50:49 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49C3158066;
 Wed, 15 Jul 2026 15:50:48 +0000 (GMT)
Received: from IBM-MFS.atx-us.ibm.com (unknown [9.16.53.88])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jul 2026 15:50:48 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@us.ibm.com,
 milesg@ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v1 5/5] tests/functional: Add Huygens BMC boot test
Date: Wed, 15 Jul 2026 10:50:36 -0500
Message-ID: <20260715155037.2237011-6-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715155037.2237011-1-mikail.sadic@ibm.com>
References: <20260715155037.2237011-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 49NVuQtehV_6lPhCh9GrcdOv8LPRUdwV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE1NiBTYWx0ZWRfX12LmDUJZaFNC
 Pe8ZBScCN3RbvxPdY147eQ6U/v8mU3SJmj8tqSHcomTN+aQPmIEad/0NLbcO0JDoFWJ1H0R7Jhu
 lIQWqY1t5kNQPo2TdiyNUhc8Yy7o0ZU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE1NiBTYWx0ZWRfX3Mskx0K1vSW5
 zfJJUpFjX3RsWg4tXn53+z4VaPTKJipjl8V/PT90+dzxnxs4siTTRE6B0QS7Ion8NHXstlwrdyB
 bUvpQKt7NWM6uGq9l5NQo048ysUDt6vLiT/ZMW2y+1v20UaThYaMVqYsDjgCNn2Kun/fp6MBf0r
 xUcXNAFxTLck0kLHswJV0Qjz4bpaqhM9ZEGwVwhhAMUuYuyl5VQb1QLmTZ+e0Y9d0XJTZIy5lCO
 C1N+J28c7h0WkIrjJgCEc1yXSGXD1+Sla3HSPoot0sg0yIqNLQWJchzoCPMV5mzBKU8FWUD6AuI
 g6hX9ZXgjzWrekIX/Jdmur+U4ncEW/wcr0gkMZKloLD39HqkoBBDXc8Zh+ocba/5EHu6JYpLjDW
 cwgElP06JK27oGlJf3/onNDN4DTgIM2mG8w6IjipH9viIrfh1mNUrzQZSBhqUWYm2QzTlalgUM+
 cx9foix1m5Lm6d8Irqw==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a57ac5e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=l5ecXwNpp30vdLWItG8A:9
X-Proofpoint-ORIG-GUID: ZwBs9vLLO61V135lGJy61eafrdSFRNAS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150156
Received-SPF: pass client-ip=148.163.156.1; envelope-from=mikail.sadic@ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 15 Jul 2026 12:36:14 -0400
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

Add a functional test for the huygens-bmc machine that boots from FMC
flash and a UFS storage image, verifying the full boot sequence from
U-Boot through OpenBMC login and multi-user target.
Note: The Huygens img is not yet public, so this test is for future/internal
use. It has been tested/verified with the correct image, and will gracefully
exit if image is not found.

Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
---
 tests/functional/aarch64/meson.build          |  2 +
 .../functional/aarch64/test_aspeed_huygens.py | 49 +++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100755 tests/functional/aarch64/test_aspeed_huygens.py

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index e81afd6c39..d81c0d6761 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -4,6 +4,7 @@ test_aarch64_timeouts = {
   'aspeed_ast2700a1' : 600,
   'aspeed_ast2700a2' : 600,
   'aspeed_ast2700fc' : 600,
+  'aspeed_huygens' : 600,
   'device_passthrough' : 720,
   'imx8mm_evk' : 240,
   'imx8mp_evk' : 240,
@@ -29,6 +30,7 @@ tests_aarch64_system_thorough = [
   'aspeed_ast2700a1',
   'aspeed_ast2700a2',
   'aspeed_ast2700fc',
+  'aspeed_huygens',
   'device_passthrough',
   'hotplug_pci',
   'imx8mm_evk',
diff --git a/tests/functional/aarch64/test_aspeed_huygens.py b/tests/functional/aarch64/test_aspeed_huygens.py
new file mode 100755
index 0000000000..750d6e0d7f
--- /dev/null
+++ b/tests/functional/aarch64/test_aspeed_huygens.py
@@ -0,0 +1,49 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED Huygens machine with UFS storage
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from aspeed import AspeedTest
+
+class HuygensMachine(AspeedTest):
+
+    def test_arm_aspeed_ufs_boot(self):
+        self.set_machine('huygens-bmc')
+        self.require_netdev('user')
+
+        # Huygens image is not public yet, skip if missing
+        fmc_path = '/tmp/fmc-huygens.img'
+        ufs_path = '/tmp/ufs-huygens.img'
+
+        if not os.path.exists(fmc_path) or not os.path.exists(ufs_path):
+            self.skipTest(f'Missing required images: {fmc_path}, {ufs_path}')
+
+        self.vm.set_console()
+        self.vm.add_args('-drive',
+                         'file=' + fmc_path + ',if=mtd,format=raw',
+                         '-drive',
+                         'file=' + ufs_path +
+                         ',if=none,format=raw,readonly=off',
+                         '-nic', 'user,model=ftgmac100,net=10.0.2.0/24',
+                         '-nic', 'user,model=ftgmac100,net=10.0.3.0/24',
+                         '-nic', 'user,model=ftgmac100,net=10.0.4.0/24')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('U-Boot 2023.10')
+        self.wait_for_console_pattern(
+            'Vendor: ASPEED Prod.: UFS QEMU Rev: 1.00')
+        self.wait_for_console_pattern('Starting kernel ...')
+        self.wait_for_console_pattern('Machine model: Huygens')
+        self.wait_for_console_pattern('Starting systemd-udevd version 257.1')
+        self.wait_for_console_pattern('Phosphor OpenBMC')
+        self.wait_for_console_pattern('huygens login:')
+        self.wait_for_console_pattern('Active BMC Target')
+        self.wait_for_console_pattern('Multi-User System')
+        self.vm.shutdown()
+
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.53.0


