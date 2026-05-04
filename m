Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAAAFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 20:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJzyC-0004AX-Pa; Mon, 04 May 2026 16:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wJzy9-0004A0-10
 for qemu-devel@nongnu.org; Mon, 04 May 2026 16:32:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wJzy6-0000Oc-44
 for qemu-devel@nongnu.org; Mon, 04 May 2026 16:32:44 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6449bG6r1944676; Mon, 4 May 2026 20:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HL3hyENWQfTq3VtH5
 dYP22IM/tBypRvffuJedpzb+oo=; b=Ieu6ouN6d0FI5RCaQDZ86/VKIOSucHCmI
 9iT01/Dr5V9uFns/wI8QnqiOnvGRhfiHjLh1KrF3+WTPDCQK/Zo3A5v17rTnEwWg
 lLvc2N5/9rrcDQsQwZPPvbenO8Y0xDKNnfT10SFi3SGAKDnFZtQ72yXsBBB6qoHX
 SxGwMcCpNFPq6d5rA6zjMJp3EZZKCSz7gBh2LsvvV90pz1ZTQyIL7Jww78kFgs9d
 xwn+fXiv1vLaMckDko8vd4KtR9MuAZNgHrHmFZPAtqOhLWymQRHa+KHFL3S1+xQa
 +nkQMjsd6fGf7S8EOgaIcgoIHxVLvVy0Sqik0J4QpikSvwOOJ5yQQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w68k9f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 20:32:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644KOP1P000709;
 Mon, 4 May 2026 20:32:39 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyvxu6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 20:32:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644KWdL925887440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 20:32:39 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 312B158055;
 Mon,  4 May 2026 20:32:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D705B58043;
 Mon,  4 May 2026 20:32:38 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 20:32:38 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 1/5] qtests: Enable starting swtpm with a given profile
Date: Mon,  4 May 2026 20:32:24 +0000
Message-ID: <20260504203228.886578-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504203228.886578-1-stefanb@linux.ibm.com>
References: <20260504203228.886578-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f90268 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=THMqCmNMJ_Ezm9plb94A:9
X-Proofpoint-ORIG-GUID: 7tIVeJSUw5r17L37JdKZlyRoO5BmIxKZ
X-Proofpoint-GUID: 7tIVeJSUw5r17L37JdKZlyRoO5BmIxKZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE4NSBTYWx0ZWRfX+K6cfZA4sAW6
 J5h04INwVZ8mg4ipwLXrwjC/WXbs8aHfbjprq/tkeLbeV6kpQJV7LvH7kljjZMXH3QxkoEgjfgu
 /0OcPpWGoKR8Ofd2mwNap4Wn5BkLnkrUZdlwa0gAkJCiRhCNB3RCXP3cNJIKH9ft90dzW5zKtuR
 4lcHtPjKElu8Q4WQ7fWTt5sw2FNsDVzkFuKXGQv5KnaStVVRzSU6qKtJMv/k9TekjmBbsFyHc8h
 VgtwKHUyWh1Sg6eIAC1kBzHi1IyVYic1R6NWQeustlBp4Ha+EXhiJNN8l5yucO22Emud9yc468V
 G3IBEf1N4d4hJ+Fi55MOTqDDjhRq6cISiHP5EWOstoA50VpOueKlE3ooWejziGHE5QuAYEIFyps
 J/kF2Z+5FT3OrzWtbljW0p0JIHocizQRxvZd8sO1FX2eidHDw6k9+eM0Asrn/FomUTHiJJkEzNe
 5ZEk8Ys5Cbn6RSHKKBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040185
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

Enable swtpm to start with a given profile by passing it to swtpm on the
command line using

   --profile name=<profile name>

Remove any existing TPM 2 state file since applying a new profile to
existing state would be refused by swtpm.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 tests/qtest/tpm-tests.c | 6 +++---
 tests/qtest/tpm-util.c  | 9 ++++++++-
 tests/qtest/tpm-util.h  | 3 ++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index 1b4f932b0c..9648e4902b 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -43,7 +43,7 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
         return;
     }
 
-    succ = tpm_util_swtpm_start(src_tpm_path, &swtpm_pid, &addr, &error);
+    succ = tpm_util_swtpm_start(src_tpm_path, &swtpm_pid, &addr, NULL, &error);
     g_assert_true(succ);
 
     args = g_strdup_printf(
@@ -96,11 +96,11 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
     }
 
     succ = tpm_util_swtpm_start(src_tpm_path, &src_tpm_pid,
-                                &src_tpm_addr, &error);
+                                &src_tpm_addr, NULL, &error);
     g_assert_true(succ);
 
     succ = tpm_util_swtpm_start(dst_tpm_path, &dst_tpm_pid,
-                                &dst_tpm_addr, &error);
+                                &dst_tpm_addr, NULL, &error);
     g_assert_true(succ);
 
     tpm_util_migration_start_qemu(&src_qemu, &dst_qemu,
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 51950483f8..1f3e8c93b5 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -225,7 +225,8 @@ bool tpm_util_swtpm_has_tpm2(void)
 }
 
 gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
-                              SocketAddress **addr, GError **error)
+                              SocketAddress **addr, const char *profilename,
+                              GError **error)
 {
     char *swtpm_argv_tpmstate = g_strdup_printf("dir=%s", path);
     char *swtpm_argv_ctrl = g_strdup_printf("type=unixio,path=%s/sock",
@@ -235,11 +236,17 @@ gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
         g_strdup("--tpmstate"), swtpm_argv_tpmstate,
         g_strdup("--ctrl"), swtpm_argv_ctrl,
         g_strdup("--tpm2"),
+        profilename ? g_strdup("--profile") : NULL,
+        profilename ? g_strdup_printf("name=%s", profilename) : NULL,
         NULL
     };
+    g_autofree char *swtpm_state_file;
     gboolean succ;
     unsigned i;
 
+    swtpm_state_file = g_strdup_printf("%s/tpm2-00.permall", path);
+    g_unlink(swtpm_state_file);
+
     *addr = g_new0(SocketAddress, 1);
     (*addr)->type = SOCKET_ADDRESS_TYPE_UNIX;
     (*addr)->u.q_unix.path = g_build_filename(path, "sock", NULL);
diff --git a/tests/qtest/tpm-util.h b/tests/qtest/tpm-util.h
index 681544e7d8..ca2d7d173f 100644
--- a/tests/qtest/tpm-util.h
+++ b/tests/qtest/tpm-util.h
@@ -41,7 +41,8 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
 bool tpm_util_swtpm_has_tpm2(void);
 
 gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
-                              SocketAddress **addr, GError **error);
+                              SocketAddress **addr, const char *profilename,
+                              GError **error);
 void tpm_util_swtpm_kill(GPid pid);
 
 void tpm_util_migrate(QTestState *who, const char *uri);
-- 
2.53.0


