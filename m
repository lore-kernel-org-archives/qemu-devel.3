Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9220DCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mw0-0001Uz-15; Thu, 16 Oct 2025 08:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v9MvX-0007xi-Bk; Thu, 16 Oct 2025 08:17:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v9MvN-0008M2-PT; Thu, 16 Oct 2025 08:17:47 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GAHTeL021227;
 Thu, 16 Oct 2025 12:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wsJVKV2/dXHjBV4dZ
 JEAzYUAvsft7J0SZdUtFRxu2+E=; b=cpBejVg0BSGXN2ZQFf6+ZNk/6ja6+5qdQ
 x8SLJvakR5FFe8Sp0TTz4bu6lG28XlgjoauMiicVWZ7H5uyZPifecx8yOk/B6auw
 lZkl5tgMTME2jDHTydv6fzYOWxyH1CxJRsy1fzZx41eD2uvzCr5gRR/i3XnyihjY
 pLsORmzudEwJ52J+O3n59f6OJKwtAk7d4L1i2imEOCwMLyqbx7vVLUw6P2/dmzEo
 uHJcbQ24YWRhv0jROklT2UT4p/MQipBBxx727c2hQ2Bo8ofAZgIveHmIppBmH7r2
 dR2QzVKrwjNdcuEU5STYEPf4+OI7VtXllKuZNSm5J3haSABwj9mAQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew09cjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 12:17:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GA85Cb003613;
 Thu, 16 Oct 2025 12:17:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy5q93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 12:17:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GCHS5j52101418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 12:17:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 326EB2013C;
 Thu, 16 Oct 2025 12:17:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EB8A2013B;
 Thu, 16 Oct 2025 12:17:28 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 12:17:28 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Cc: Sebastian Mitterle <smitterl@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v3 2/2] tests/functional: add tests for SCLP event CPI
Date: Thu, 16 Oct 2025 14:17:08 +0200
Message-ID: <20251016121708.334133-2-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251016121708.334133-1-shalini@linux.ibm.com>
References: <20251016121708.334133-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nw6fqr9drwXML8DEYd6XpMe8h-0auhXP
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f0e25d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=WP5zsaevAAAA:8 a=ugThcBDMf7tpZusDcEcA:9 a=t8Kx07QrZZTALmIZmm-o:22
 a=poXaRoVlC6wW9_mwW8W4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX6GvvfXJPWB1T
 kF3bWwsMNjh/bOTqDAMi3CqCzJr4F127VWbQ0YHY2bikqc08PB78g0SpkmdbrncwhYDCAbJQlOe
 UIjsNhpVSwW0iylt1+NhsmzI5vhJXGLN4BURw5Aa/2IyEB6lZM4qUDQ5kDEMvnxdi2S3aFztVTr
 KTCdGqzEjqMI/0PLN3n/2Bl/3QFxtMyom5yK4L1ZJVc0Ywyw+na+71BRTCirAaQDuZg4L4B7EDj
 qnR36kevJZngp1apBwxpPinFI96Aeidb9IGYpI7ZMojD3ISLbjEX0rsIg3Ubv09VgxzJZRg7DAS
 AhEKpnghGfnRyk2NLjyiUWspn+4yPFVDmxAQwhTHZQ06VnOWsIq4c+wTJl/6MT7EjFJb126zS6E
 B6+bwQblnAp2g4Yaa9VC+dneLLxXLg==
X-Proofpoint-GUID: nw6fqr9drwXML8DEYd6XpMe8h-0auhXP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add tests for SCLP event type Control-Program Identification.

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/s390x/test_ccw_virtio.py | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/functional/s390x/test_ccw_virtio.py b/tests/functional/s390x/test_ccw_virtio.py
index 453711aa0f..0455337856 100755
--- a/tests/functional/s390x/test_ccw_virtio.py
+++ b/tests/functional/s390x/test_ccw_virtio.py
@@ -15,6 +15,7 @@
 import tempfile
 
 from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import wait_for_console_pattern
 
@@ -270,5 +271,30 @@ def test_s390x_fedora(self):
                         'while ! (dmesg -c | grep Start.virtcrypto_remove) ; do'
                         ' sleep 1 ; done', 'Start virtcrypto_remove.')
 
+        # Test SCLP event Control-Program Identification (CPI)
+        cpi = '/sys/firmware/cpi/'
+        sclpcpi = '/machine/sclp/s390-sclp-event-facility/sclpcpi'
+        self.log.info("Test SCLP event CPI")
+        exec_command(self, 'echo TESTVM > ' + cpi + 'system_name')
+        exec_command(self, 'echo LINUX > ' + cpi + 'system_type')
+        exec_command(self, 'echo TESTPLEX > ' + cpi + 'sysplex_name')
+        exec_command(self, 'echo 0x001a000000060b00 > ' + cpi + 'system_level')
+        exec_command_and_wait_for_pattern(self,
+                                          'echo 1 > ' + cpi + 'set', ':/#')
+        try:
+            event = self.vm.event_wait('SCLP_CPI_INFO_AVAILABLE')
+        except TimeoutError:
+            self.fail('Timed out waiting for the SCLP_CPI_INFO_AVAILABLE event')
+        ts = self.vm.cmd('qom-get', path=sclpcpi, property='timestamp')
+        self.assertNotEqual(ts, 0)
+        name = self.vm.cmd('qom-get', path=sclpcpi, property='system_name')
+        self.assertEqual(name.strip(), 'TESTVM')
+        typ = self.vm.cmd('qom-get', path=sclpcpi, property='system_type')
+        self.assertEqual(typ.strip(), 'LINUX')
+        sysplex = self.vm.cmd('qom-get', path=sclpcpi, property='sysplex_name')
+        self.assertEqual(sysplex.strip(), 'TESTPLEX')
+        level = self.vm.cmd('qom-get', path=sclpcpi, property='system_level')
+        self.assertEqual(level, 0x001a000000060b00)
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.49.0


