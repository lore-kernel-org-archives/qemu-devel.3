Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C818EFF8877
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 12:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI3rg-0004Gv-4j; Wed, 29 Apr 2026 08:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI3rY-0004FR-JW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:17:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI3rV-0000r8-SE
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:17:56 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TBe7vO3687580; Wed, 29 Apr 2026 12:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=1vtQEoUCOZUMsu673
 Dw5Piw3N67i5x8+gnNGnf6Gmfw=; b=AkB7h6FHlTfyE+sqjELqQR1ooxVfY3FKC
 D+EC79PM1AJcOiBB7DLb3x9LxQr5Td12u7NOENExOZjh4mgs5CrM2yfeVbB8GdoM
 cUkZmMeZnqDaiJZ/scHCiEPG/dCHEfWFCQAsFI67wf71R1hGTEWfyz9fsGRAJzAC
 jYp2yWl5TPi5L332wBJQcRx2As3JKqxL+w2CMUPdkpbsJDiv3KicjppgLg5N282C
 GsSRp4doMFJDUehnEPbImnBHVWAx19/5DhdAmW/cqaO4JdUw6BId86DjaJvOqYRR
 lXHm/9ynn4/0qSDRZnhrxj5vuj2kE7U+YvshRMuEBf4htIAKvD1sA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e0ydw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 12:17:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TBrqRE008028;
 Wed, 29 Apr 2026 12:17:52 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9ehe47w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 12:17:52 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TCHpHr31195862
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 12:17:51 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BED858045;
 Wed, 29 Apr 2026 12:17:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFDD858050;
 Wed, 29 Apr 2026 12:17:50 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 12:17:50 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 4/6] tests: Rename id of tpmdev to tpm0
Date: Wed, 29 Apr 2026 12:17:41 +0000
Message-ID: <20260429121743.1346635-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429121743.1346635-1-stefanb@linux.ibm.com>
References: <20260429121743.1346635-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FGZjgh4EfKnQfsqKaKmilYIL2V42TJar
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEyNSBTYWx0ZWRfXxt3WxJ/o3NBn
 A//F5W7EQx6LC9A/wLQ5Rd/v9HhXCABZCCFE9vpHc6VdXPHtXa9Cjz5E/IawbtaVI3fgPAyxEDE
 wmaLzAldvFWfACBxG4o1ibMWxsSBO007+H2ErqtT8trQILZYBMMhh9SjzX1IELmJ5nQb5eGZ1P9
 gjj7YyhTZIeoomL10dlXdcAg9+GBwkoYu5OLdkbR2dWK4LS3CjhZZDzy2VfXF6e6brrAOlcPMUZ
 AeMOT+Yk4A96OPUhgh9t5U+dBDbyq04uX7PyRc9QeF+M4ucLRH3/bh2MxzD0DPnq7o8zp4Pofo8
 hJ00xcVDaH4CETZFkognpzXrXpA7F36KuJC790JyhVL1/N+LT/Sw7FnFXa+yb8li1J5DEbvAaxl
 Zob+c19lx05dE9QoNefycDPNSnt0GaVnSuX49/B9iP5ppjxzuF7hp6Q7pO7rZ/t5wyRIfwSepcH
 D256qS83BB3KQ1Not+A==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f1f6f0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=Tt6dWLOZzW0yVT5AIBMA:9
X-Proofpoint-GUID: FGZjgh4EfKnQfsqKaKmilYIL2V42TJar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Rename the id of the tpmdev from dev to tpm0 because this 'dev' cannot
be used when the tpm-tis-i2c device is used.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Arun Menon <armenon@redhat.com>
---
 tests/qtest/tpm-tests.c | 4 ++--
 tests/qtest/tpm-util.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index 8bd3288f80..1b4f932b0c 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -49,8 +49,8 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
     args = g_strdup_printf(
         "%s "
         "-chardev socket,id=chr,path=%s "
-        "-tpmdev emulator,id=dev,chardev=chr "
-        "-device %s,tpmdev=dev",
+        "-tpmdev emulator,id=tpm0,chardev=chr "
+        "-device %s,tpmdev=tpm0",
         machine_options ? : "", addr->u.q_unix.path, ifmodel);
 
     s = qtest_start(args);
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 63cd5b69db..0f9bef8971 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -240,8 +240,8 @@ void tpm_util_migration_start_qemu(QTestState **src_qemu,
     src_qemu_args = g_strdup_printf(
         "%s "
         "-chardev socket,id=chr,path=%s "
-        "-tpmdev emulator,id=dev,chardev=chr "
-        "-device %s,tpmdev=dev ",
+        "-tpmdev emulator,id=tpm0,chardev=chr "
+        "-device %s,tpmdev=tpm0 ",
         machine_options ? : "", src_tpm_addr->u.q_unix.path, ifmodel);
 
     *src_qemu = qtest_init(src_qemu_args);
@@ -249,8 +249,8 @@ void tpm_util_migration_start_qemu(QTestState **src_qemu,
     dst_qemu_args = g_strdup_printf(
         "%s "
         "-chardev socket,id=chr,path=%s "
-        "-tpmdev emulator,id=dev,chardev=chr "
-        "-device %s,tpmdev=dev "
+        "-tpmdev emulator,id=tpm0,chardev=chr "
+        "-device %s,tpmdev=tpm0 "
         "-incoming %s",
         machine_options ? : "",
         dst_tpm_addr->u.q_unix.path,
-- 
2.43.0


