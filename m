Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87D8FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHiAI-0006W8-B4; Tue, 28 Apr 2026 09:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wHiA5-0006TB-WB
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:07:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wHiA3-0001KD-3L
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:07:37 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SBvplL899091; Tue, 28 Apr 2026 13:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=u7zRD1jLbjv2J3d38
 lrtkX+IaipO4wlaxY9OnsHGeLg=; b=FXMeYWPL0QJALKVNYgfEts/FF+BHxVoH4
 r7nsw+mKNl7FIANM4S5CjSGjZfDPb6eg8Fcrs7JhF/m/ewigNiHNnmfpiT9zPyiC
 jtpQWQwH7YSQZumcbbd+chCM0Z+v80INtSQN3nU6nYj4F9c/p+2Pcg+v6RWmOB6u
 T0807DdhORIEYiLfbL32GrNdjr1QumewZDAyIbSUeO/KciBJbAYIXSkkbOuWiPve
 v2fdx4U0WPCFNxktFjsjTmdxPPYsIcpKSp9dDeWsSC/QzzFptvRIBTSnTEkwgcv0
 7CySuwU7K0TYstZ0x75RHO9CqQ0vgooKy0NfwEIz2JyctyAPUigDA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb55jpr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 13:07:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SCw696020105;
 Tue, 28 Apr 2026 13:07:29 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avsvm7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 13:07:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63SD7Tqx30147300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2026 13:07:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A1495805A;
 Tue, 28 Apr 2026 13:07:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9E3458052;
 Tue, 28 Apr 2026 13:07:28 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2026 13:07:28 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 4/6] tests: Rename id of tpmdev to tpm0
Date: Tue, 28 Apr 2026 13:07:16 +0000
Message-ID: <20260428130718.1325177-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428130718.1325177-1-stefanb@linux.ibm.com>
References: <20260428130718.1325177-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f0b112 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=3rTIqxLH2NqWiAwI-G8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExOCBTYWx0ZWRfX5sWCObex8pEJ
 Fkx80H+aKYdA5TseQxFePZnUTdi7RlL9e3+Jqma95cuEokiEauRwnX38Txh3XZbD2oKAVoFTdtB
 V+LofTgsrZhP8y2ipzYa8OOigPDX+VCLzaHrcstRq3auKJRWLF/skHwWIjPTI8gRFgYEM5dMI/y
 LOZ89EtBR4TnHK8a03/g4CefjSfEilb25k7ureudD5vVN3gn8DJRWJSbXURQQnt5Z/4rRcdch/n
 cFuDFfan7Nf0mTdfNivj3ZmWphRzv8FXCf+ljwr0xm8EF98UmkaGHFzXU1UCTIml/MackvYCCkg
 Zph63peiWohLbJ5qIbq3ueQTz9zA5VRN8wVeFbv2HRZfp6hqNJbXCdnRWMTW4CPoQoyVVJMKTXj
 KSiozTOPC4jvVZpMXT7ULomxLqf95b6d/qhHDOcG+mupDYsN+qWr3m/K2cNQi5K6j4UIeEZjln+
 TKMucVK3CbzFo/xPkTA==
X-Proofpoint-GUID: fSOdGOT0PUMONoGeHmWQJCCMejNVm-sQ
X-Proofpoint-ORIG-GUID: fSOdGOT0PUMONoGeHmWQJCCMejNVm-sQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280118
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
---
 tests/qtest/tpm-tests.c | 4 ++--
 tests/qtest/tpm-util.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index dcbf5457ed..d1fe4a85d4 100644
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
index 1a47099807..35e9d3f32e 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -227,8 +227,8 @@ void tpm_util_migration_start_qemu(QTestState **src_qemu,
     src_qemu_args = g_strdup_printf(
         "%s "
         "-chardev socket,id=chr,path=%s "
-        "-tpmdev emulator,id=dev,chardev=chr "
-        "-device %s,tpmdev=dev ",
+        "-tpmdev emulator,id=tpm0,chardev=chr "
+        "-device %s,tpmdev=tpm0 ",
         machine_options ? : "", src_tpm_addr->u.q_unix.path, ifmodel);
 
     *src_qemu = qtest_init(src_qemu_args);
@@ -236,8 +236,8 @@ void tpm_util_migration_start_qemu(QTestState **src_qemu,
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


