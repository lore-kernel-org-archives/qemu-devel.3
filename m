Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB22FCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8J1p-0000z6-Mm; Mon, 13 Oct 2025 09:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v8J1h-0000xK-Rg; Mon, 13 Oct 2025 09:55:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v8J1Z-0000fR-9x; Mon, 13 Oct 2025 09:55:45 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DArlMq020895;
 Mon, 13 Oct 2025 13:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=N6U05jtcQ9j8TcIs2
 dLbklNjve+Y2sSXy3dY6uDHi5M=; b=H76nJ4MCuaa1AczcqU9Ot4k3GCgRE1PmB
 hgXCptaFab9XAQM2LAcYhHnkB2kFw4cN1dg8ujwFaoP22FAhJbbQNxUzJGI2yw+e
 3RoantyzyY//Y5u5T92dRnjTY1fxfY9hRh4Dl7hGrdfkRwFdBNKkw+n8eu/+IZlW
 ZNVSQBmiR42zV4Vo4l/5SrLU3kw6lIdotPSzLrVbpq44Tkwj3G3ImxsGDxGh2DPc
 cWbJALKRxWt1UQMUV+MZsR0YVGAr3WBeUpw/vX2GVcPs/X/PSq4IrQN0qqoCdOny
 1ocEtJxO6stE42D0NC/w3M2kCP0RZZ3tu1Q309plqk3Yod2Eq2Wwg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8h81x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 13:55:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59DBwhF6003783;
 Mon, 13 Oct 2025 13:55:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r490ws95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 13:55:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59DDtVAB53608790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Oct 2025 13:55:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E93420087;
 Mon, 13 Oct 2025 13:32:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AF9920084;
 Mon, 13 Oct 2025 13:32:35 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Oct 2025 13:32:35 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Cc: Sebastian Mitterle <smitterl@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v2 2/2] tests/functional: add tests for SCLP event CPI
Date: Mon, 13 Oct 2025 15:32:29 +0200
Message-ID: <20251013133229.110892-2-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251013133229.110892-1-shalini@linux.ibm.com>
References: <20251013133229.110892-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -7diMaeTF1_xfT8AdIX58VhUUuRRV33r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX30qDxdy+vY7l
 K6fya2uOjdBCQWbv1dYJVjaiA6KjdN58yO4xQqKXOyZyE4hotg0femadK/biCKsHeXKtp7J3Bhz
 kCAVyrBKYMs9+JwZ04YPVkkdexCMu4A73Yd4N9bU5JtxZ+s3696+ifeoGmLtz6cY3zFf1ay3xWy
 z5qsvI6Oq2j5ox2sT4da/4gfy85eF1veZI590PEKF8mC3Em5Bi9h4p67goPcZP5vR5l+wyzwQy9
 ZLu2BZrSuyddxIgZRsheSWLZGOc1zj60aAvJGXLGnlhWsjxnoM70fNG57dD3zg4arpD/Liw5YJs
 MOWIvwq4PMr5nX+dUHwxO3ZfvyLkxkReMKHW6bKLeVPy3QG+isLpzKGQthx8wlS8N4Cm1W0I2S4
 Mnb+NsujblRKrpKdrJK5tELhBuaIMw==
X-Proofpoint-GUID: -7diMaeTF1_xfT8AdIX58VhUUuRRV33r
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68ed04d7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=WP5zsaevAAAA:8
 a=5I7fADH3ppHHGO6XMD8A:9 a=t8Kx07QrZZTALmIZmm-o:22 a=poXaRoVlC6wW9_mwW8W4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
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

Add tests for SCLP event type Control-Program Identification.

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/s390x/test_ccw_virtio.py | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/functional/s390x/test_ccw_virtio.py b/tests/functional/s390x/test_ccw_virtio.py
index 453711aa0f..82e73ecf5e 100755
--- a/tests/functional/s390x/test_ccw_virtio.py
+++ b/tests/functional/s390x/test_ccw_virtio.py
@@ -15,6 +15,7 @@
 import tempfile
 
 from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import wait_for_console_pattern
 
@@ -270,5 +271,29 @@ def test_s390x_fedora(self):
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
+        exec_command(self, 'echo 1 > ' + cpi + 'set')
+        try:
+            event = self.vm.event_wait('SCLP_CPI_INFO_AVAILABLE')
+        except TimeoutError:
+            self.skipTest('SCLP Event type CPI is not supported')
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


