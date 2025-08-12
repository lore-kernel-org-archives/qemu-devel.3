Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A074C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 12:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uloBK-0002Gh-WF; Tue, 12 Aug 2025 08:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uloB8-0001zs-5d; Tue, 12 Aug 2025 08:32:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uloAz-0007Sd-7p; Tue, 12 Aug 2025 08:32:33 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAjRrt014766;
 Tue, 12 Aug 2025 12:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=h48j8FAfIr0CZrrU9Lg8q8WzJiHZXXkgxdj1Mpj3Y
 lY=; b=CaYNYTda7R4jDGebWxKsJKzofJ+E9IENSqfTN4KMSEBrHdIwgs8TAHzkv
 VFzfKexYLXyu71JZeCM9QU84AFWGlcy5/FeHzWHWXuGY3Pvl4NtHZZiZSO3/hGKB
 nqXRicJ81YcXAZUUACWUlR32s+fAl4HsyCnmebtguv+ESiTDpiwBciYLw7654nPy
 WZOmtpVT6QAbNaoQTgK9mdkQpU5UPPoqdTb9vlzhNEmSL0U/DFaj9iNKlNQA6I6b
 4cSj6b/1AP31sx/FClsMYvTv3Cd0fvm+Wh+76I8qiGGz6XJJT6cbZsnaK6z7U0+q
 FXvxjV/B+11aLmk843eQzD+LE4MoA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14e9ju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Aug 2025 12:31:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57CA2kKk028585;
 Tue, 12 Aug 2025 12:31:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5n27w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Aug 2025 12:31:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57CCVXeU52953526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Aug 2025 12:31:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1234D2004E;
 Tue, 12 Aug 2025 12:31:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E36F22004B;
 Tue, 12 Aug 2025 12:31:32 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Aug 2025 12:31:32 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Cc: Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH RFC] tests/functional: add tests for SCLP event CPI
Date: Tue, 12 Aug 2025 14:31:24 +0200
Message-ID: <20250812123124.382696-1-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2upH50nkezd9_8nZGkDiVGV_7FCdYBkF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOCBTYWx0ZWRfXz8HTBb5mnMgU
 yeqYGmK7e9r50Qe2ZkILQKaput+JRrPmk5I3rUccxqUyXtSqHHVdnY9vnVzSBYDjIAgsMLE/xcq
 CmaCnKw9LUQ9i83XunT69faMaYGJjqTM3VizcjZtzNtACSPnuYqoAYOKheDEe/Txqe9g7gfLQol
 LnJRRISGYAMBMKjSyJ7XfCFNbC9zzeu5BSSMAWYuDv01Cw9gwzEw2qLE8iCmZUkJmMy9thRGg+O
 RdQ10GsCOlZwhigC+6Xk6zkaO5HnsIehplycctMRCZgXLNM7EwQSwkUdlh0Pm5COQt6bjNZX5zt
 nOsf3uwQ3MiMDzCCail/9v605KqbYLOG6XK9Pdf2MAU/uqbBPVp5loKuwu4ISYecHtx8zmqhemN
 Jy4PkqrT+b2iifsQc3NxZARC3tB20WWLRQtqGmxJiumDLJZ3UyQ5fkjc/MFmvfgLl767JWij
X-Proofpoint-GUID: 2upH50nkezd9_8nZGkDiVGV_7FCdYBkF
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=689b342a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=WP5zsaevAAAA:8
 a=PjYKRGzYlDL-BbGx_40A:9 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120118
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

Add tests for SCLP event type Control-Program Identification
(CPI) to s390x CCW virtio tests.

Please note that these tests are skipped as the guest OS does not
trigger the SCLP event type CPI when the command
'echo 1 > /sys/firmware/cpi/set' is executed in the guest. I
believe that the guest OS must to be updated to support the SCLP
event type CPI.

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_s390x_ccw_virtio.py | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/functional/test_s390x_ccw_virtio.py b/tests/functional/test_s390x_ccw_virtio.py
index 453711aa0f..c14379cbaa 100755
--- a/tests/functional/test_s390x_ccw_virtio.py
+++ b/tests/functional/test_s390x_ccw_virtio.py
@@ -15,6 +15,7 @@
 import tempfile
 
 from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import wait_for_console_pattern
 
@@ -270,5 +271,28 @@ def test_s390x_fedora(self):
                         'while ! (dmesg -c | grep Start.virtcrypto_remove) ; do'
                         ' sleep 1 ; done', 'Start virtcrypto_remove.')
 
+        # Test SCLP event Control-Program Identification (CPI)
+        cpi = '/sys/firmware/cpi/'
+        sclpcpi = '/machine/sclp/s390-sclp-event-facility/sclpcpi'
+        self.log.info("Test SCLP event CPI")
+        exec_command(self, 'echo TESTVM > ' + cpi + 'system_name')
+        exec_command(self, 'echo LINUX > ' + cpi + 'system_type')
+        exec_command(self, 'echo TESTPLEX > ' + cpi + 'sysplex_name')
+        exec_command(self, 'echo 1 > ' + cpi + 'set')
+        try:
+            event = self.vm.event_wait('SCLP_EVENT_CTRL_PGM_ID')
+        except TimeoutError:
+            self.skipTest('SCLP Event type CPI is not supported by guest OS')
+        ts = self.vm.cmd('qom-get', path=sclpcpi, property='timestamp')
+        self.assertNotEqual(int(ts), 0)
+        name = self.vm.cmd('qom-get', path=sclpcpi, property='system_name')
+        self.assertEqual(name, 'TESTVM')
+        typ = self.vm.cmd('qom-get', path=sclpcpi, property='system_type')
+        self.assertEqual(typ, 'LINUX')
+        sysplex = self.vm.cmd('qom-get', path=sclpcpi, property='sysplex_name')
+        self.assertEqual(sysplex, 'TESTPLEX')
+        level = self.vm.cmd('qom-get', path=sclpcpi, property='system_level')
+        self.assertNotEqual(int(level), 0)
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.49.0


