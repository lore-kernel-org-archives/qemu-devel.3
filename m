Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687B2CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Ill-0006uJ-Jy; Mon, 13 Oct 2025 09:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v8Ili-0006r6-NZ; Mon, 13 Oct 2025 09:39:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v8Ilg-0006eg-D9; Mon, 13 Oct 2025 09:39:18 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DAJNTb005690;
 Mon, 13 Oct 2025 13:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=N6U05jtcQ9j8TcIs2
 dLbklNjve+Y2sSXy3dY6uDHi5M=; b=NUktWuTDrpZJaz6kwGNMBTAO12qAjqqon
 hVZ1okLMz+G6u2j7OAuvc6jGNWJTt8IR30id0H5cyQKCl/HWwBoBozi1f7gInFdX
 RtOCwJjKrDurTVnWdP2vRrrL6RqrpRVVWQaWrJ9xtJKrapxQ1ozdMq5QxopPvsi4
 dISTKnf+21k4aYXpbbzMgwTW3XmIINLylXU76NtJc5N9ceqGP4bMiceewu3ymXkP
 4K6PKa4Vc4Y4YfeXCz0iYirng1I/a4ulA232nghRQZRQqklRngNohCWXI5s+WE3c
 JSfLdeEBl7du/7t2n0eYXAR6VZ8E5a9FMURBZYL8AVSzMRYH3QHqA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qdnp944h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 13:39:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59DB6Ff1015010;
 Mon, 13 Oct 2025 13:39:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sj5t0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 13:39:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59DDd9cB24707744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Oct 2025 13:39:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2850200A7;
 Mon, 13 Oct 2025 13:39:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF3A4200A5;
 Mon, 13 Oct 2025 13:39:09 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Oct 2025 13:39:09 +0000 (GMT)
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
Date: Mon, 13 Oct 2025 15:39:02 +0200
Message-ID: <20251013133902.111233-2-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251013133902.111233-1-shalini@linux.ibm.com>
References: <20251013133902.111233-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNSBTYWx0ZWRfX6WN96gMNfbr1
 nFJ28jlJRubEs5MSm0/4R97Gd0yBqoFewVZAiv9ZXFQFUnTVuKnLSBiUfgAKdUdBxEr015DFfc9
 XP6lQKbYbqQtacU92FRyJnklIPMP/CNJ+cfofEP5GT/l9Oucq9ujhnRYGciRLakSoyUK3fjGGv1
 aYV0fmSydy6xt1XWX1uxhcHCao01YaG4eG1LS2siF0ckZdZLXRuO+ElgGmJ0lYMGx2YC0LbCHVw
 GdB/ooEcsXlK6P0V5qZFwdZAIHGUpCbsfi7/3Ww3CulAJ74Ewz1+8V4HP78eEZQdm7a+ckZWCal
 h5D1NwSvw6pNQE5Y52ZzNQnFJQPzTqPVqz+DVwz7B23S/4V30OM1aRitieNWH1r+UZ7F0BaFFX/
 UQc7fa5aYb96ee43vE6NLfmfdi7NHw==
X-Proofpoint-ORIG-GUID: gl9NKq68HY5qjCN2Zrr_quT6a0mpJOXg
X-Proofpoint-GUID: gl9NKq68HY5qjCN2Zrr_quT6a0mpJOXg
X-Authority-Analysis: v=2.4 cv=MoxfKmae c=1 sm=1 tr=0 ts=68ed0102 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=WP5zsaevAAAA:8
 a=5I7fADH3ppHHGO6XMD8A:9 a=t8Kx07QrZZTALmIZmm-o:22 a=poXaRoVlC6wW9_mwW8W4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110005
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


