Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9081CD6E61
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAag-0006aV-Cj; Mon, 01 Jun 2026 17:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAae-0006Z9-77
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAac-0003pw-0M
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:31 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651LGMpd3717409; Mon, 1 Jun 2026 21:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nCWF5NdZ0vtqDTdte
 KyVyZcxIQshdlAW4YcBUaaZ7G4=; b=rjj1/UEYWCGefVVnWeLMvAv4w9ygU71Rg
 ulDpLtq93lHmGWt1kruIdChbP7/l5JqGAFcttef1u+fOYUerNDcjYSb1iwgtrOSq
 GxmGZRGEjl0Z+JjIhFV1zTrxW9PLZ7OfrN5A4JwAYDtGhJbm5b42X88mH6CgTq9m
 Kva6kHJdZxzoiHHg1tl1zcOUopBiJFagndlx9XuZ1I5OQvn+d550Alxgb2smuYR2
 zMJ2D6+FqrXkLT3tahHP2c85TBn7t0YrjLFIGCidUnphUW6ch7B27gteJ9I6ICPN
 KaVw6i/Xxi2KZnDMP4/VDnjEWJh1M7vJP85gKHpb/yA0PiQ98yQSA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahjwha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Ls8oI022925;
 Mon, 1 Jun 2026 21:54:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegg1s9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651LsRAe30933666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 21:54:27 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C7CC5805C;
 Mon,  1 Jun 2026 21:54:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C957458054;
 Mon,  1 Jun 2026 21:54:26 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jun 2026 21:54:26 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PULL v1 04/16] tests: Rename id of tpmdev to tpm0
Date: Mon,  1 Jun 2026 17:53:57 -0400
Message-ID: <20260601215410.517009-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601215410.517009-1-stefanb@linux.ibm.com>
References: <20260601215410.517009-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDIxMSBTYWx0ZWRfX1ucw1/bRwn8S
 B3kTuNVEMU7T8S7Fzmc2wEeZ4v1bmtbV8ooqmD6qRrcgqu4iXZQTGcY4PdUK8i09ZqbrIC+xYPW
 RTltGq+l/LrytOQp4GN+D4fkgOhI340Lt8fgU5xz9M6AI1jofYESW1mLOS3+R0BNfAxIUO2DWXe
 E2Arx9wMve4UQZxh8KSjeB8DsOYzJNuddhAHnNfdFtmk76Cl3r4P+2vZiuKRTF2ONBSRPvgfzQ7
 xDa7L0UjrdEWdiGo3yDkpNCjpEOoLrcrfSlRseNaGYB/BPz3AMxm+NLxr4XR2iARZBc1wyLgfM4
 kWsFyWa3FEtmlWETcwpppfJfiaPIdipHUfOigb+38O1R7mC+QYKq5hu3G41lagf2Ia85r/BGCuM
 93bNKeI+TnJIFZBg0JucF5zLQxFAdqW5nGAMk7Me7wgWpoksUHEGfamylsYlTLY3Pw5S7FyN1Ac
 yVpJnOv+WF8dGhFK/uA==
X-Proofpoint-ORIG-GUID: YfcKF5BXGmdwWgAL36_VF6nv3sWYwFGn
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1dff94 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=RyEZR7e21Zd7IhWO4CoA:9
X-Proofpoint-GUID: YfcKF5BXGmdwWgAL36_VF6nv3sWYwFGn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010211
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Rename the id of the tpmdev from dev to tpm0 because this 'dev' cannot
be used when the tpm-tis-i2c device is used.

Reviewed-by: Arun Menon <armenon@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260429121743.1346635-5-stefanb@linux.ibm.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
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
2.54.0


