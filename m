Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24734CA6018
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvg7-0000RC-PF; Thu, 08 Oct 2026 17:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveY-0000Ms-Pi
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveR-0002pa-7e
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:46 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L5mCo2405237; Thu, 8 Oct 2026 21:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=o/oWpJ
 1rNtqayKq2xuYYcCh6zUdPeUa09P/Cg+GsmvY=; b=aPxNoIwD1xQuRCXDhhQkFJ
 SDdRAKk2GJlgDCtW8fmtgo/Ib1a6D6rxCDFCc11q7iszLDNzo/C1H4YSPdquFbkE
 krJKdEQfpzZqPnBZQ0d8iSWn4upjJ5kF4/eupLb3ngbjksmN3le2dQgeBusfPK4Z
 otOtU5LvwWd52k0f2WzezVPlFXDLwVe4No9oJav+6CIXLXYq9rR7rObjheTMtzoF
 +Z91DV0oTA6r/0i56uJH7iWWqneVIECrXI7GWOaY6wGX+I0LrfLE0LwbEqPtJse/
 yGEs5mF0Vxl/zDgJn412/ylX8FSNAjH2aP16jXYCYATvbj5G0u1z4U/ll/H+b08A
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvepra-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L2b324079039; Thu, 8 Oct 2026 21:27:33 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6ds5g1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698LRWFM31195824
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 21:27:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FA385805A;
 Thu,  8 Oct 2026 21:27:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD09258054;
 Thu,  8 Oct 2026 21:27:31 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 21:27:31 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v1 10/10] tests: Add tests with commands with bad length
Date: Thu,  8 Oct 2026 17:27:23 -0400
Message-ID: <20261008212723.3679685-11-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008212723.3679685-1-stefanb@linux.ibm.com>
References: <20261008212723.3679685-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s2jF8aBbm8nTtKBWibbuis80-P5XOOSo
X-Proofpoint-ORIG-GUID: s2jF8aBbm8nTtKBWibbuis80-P5XOOSo
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac80ac5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=rfWPa_Qpybt_VECXH-MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX/kZb+vQBMsSQ
 hqh6vkB7z3+bPKYI0z575ZM2qGzo24f0p31BBCx7mlyOXf0aR1uPlahwI01Lw8DcsNZquTLry1P
 gYYkN8q2JjOxgeKqGSUwMvQIODeyXt2DHnHatabZiPwLU0UaVuKt04ez/MusA3PMmwpFs0vfEze
 W7RyIC1Nzidg3mvOoegjq6u43YlYJvCOzV2sTOpQ+7Ck/bnKSSsMCpEgXwXVsAWP5XUK4Jh3Jg8
 m1FcFILcE7EXBzsoDSM3EoDw0l5yOYbOT6LetwDi8XiP6A8MkIFzS8aelYtc0Z4ZZQofrLzTZxg
 9RUIrusFe5chpYHf/EEikyXWC632EgcsppnbKNLWX8NNJjfZpo9QJ9zbqnMmvbAAFZglVDl+aMk
 fGKc/Czujo4I8avubagigxVF03Id1sCTmAffrAwuk9lnPtVSFlAaqlwRqkNe7gonqqp0z3Xb3wP
 upW2/QdyIXF8GYnM5FA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX8CjUtzswMG70
 xUw8j6d7oB1x+a0XCbKERWVt5A4wVZ3HJ4xGqhNHAuWGfPGyoxYWKjy/Mgaz/SlaO3kqu1pCx4q
 ODtOpK2x5aSNRYnpGFgao7Z7xxeRFoo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080084
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

Add two test cases with commands with bad length:

- Send a command that indicates a very large size (0x10000 bytes) to the
  TPM. This will only work with the CRB interface since the TIS wants
  to receive all the bytes indicated by the command header.

- Send a command that indicates that its size is only 9 bytes, which is
  too short to be valid since the command header alone is 10 bytes.
  This test only works with the TIS. The CRB silently rejects commands
  that are shorter than the command header.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261002142516.2063735-11-stefanb@linux.ibm.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/qtest/tpm-crb-swtpm-test.c        | 10 +++++
 tests/qtest/tpm-tests.c                 | 56 +++++++++++++++++++++++++
 tests/qtest/tpm-tests.h                 |  8 ++++
 tests/qtest/tpm-tis-device-swtpm-test.c | 10 +++++
 tests/qtest/tpm-tis-swtpm-test.c        | 10 +++++
 tests/qtest/tpm-util.c                  | 55 ++++++++++++++++++++++++
 tests/qtest/tpm-util.h                  |  3 ++
 7 files changed, 152 insertions(+)

diff --git a/tests/qtest/tpm-crb-swtpm-test.c b/tests/qtest/tpm-crb-swtpm-test.c
index 050c7b0c1f..0e83a5325f 100644
--- a/tests/qtest/tpm-crb-swtpm-test.c
+++ b/tests/qtest/tpm-crb-swtpm-test.c
@@ -33,6 +33,14 @@ static void tpm_crb_swtpm_test(const void *data)
                         "tpm-crb", NULL);
 }
 
+static void tpm_crb_short_write_swtpm_test(const void *data)
+{
+    const TestState *ts = data;
+
+    tpm_test_short_write_swtpm_test(ts->src_tpm_path, tpm_util_crb_transfer,
+                                    "tpm-crb", NULL);
+}
+
 static void tpm_crb_chunk_swtpm_test(const void *data)
 {
     const TestState *ts = data;
@@ -62,6 +70,8 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_data_func("/tpm/crb-swtpm/test", &ts, tpm_crb_swtpm_test);
+    qtest_add_data_func("/tpm/crb-short-write-swtpm/test", &ts,
+                        tpm_crb_short_write_swtpm_test);
     qtest_add_data_func("/tpm/crb-chunk-swtpm/test", &ts,
                         tpm_crb_chunk_swtpm_test);
     qtest_add_data_func("/tpm/crb-swtpm-migration/test", &ts,
diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index 1b4f932b0c..74b22c43aa 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -79,6 +79,62 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
     qapi_free_SocketAddress(addr);
 }
 
+/* Setup the TPM and send a command by calling a passed function */
+static void
+tpm_test_simple_cmd_swtpm_test(const char *src_tpm_path, tx_func *tx,
+                               const char *ifmodel,
+                               const char *machine_options,
+                               void (*test_func)(QTestState *, tx_func))
+{
+    char *args = NULL;
+    QTestState *s;
+    SocketAddress *addr = NULL;
+    gboolean succ;
+    GPid swtpm_pid;
+    GError *error = NULL;
+
+    if (tpm_test_swtpm_skip()) {
+        return;
+    }
+
+    succ = tpm_util_swtpm_start(src_tpm_path, &swtpm_pid, &addr, &error);
+    g_assert_true(succ);
+
+    args = g_strdup_printf(
+        "%s "
+        "-chardev socket,id=chr,path=%s "
+        "-tpmdev emulator,id=tpm0,chardev=chr "
+        "-device %s,tpmdev=tpm0",
+        machine_options ? : "", addr->u.q_unix.path, ifmodel);
+
+    s = qtest_start(args);
+    g_free(args);
+
+    test_func(s, tx);
+
+    qtest_end();
+    tpm_util_swtpm_kill(swtpm_pid);
+
+    g_unlink(addr->u.q_unix.path);
+    qapi_free_SocketAddress(addr);
+}
+
+void tpm_test_short_write_swtpm_test(const char *src_tpm_path, tx_func *tx,
+                                     const char *ifmodel,
+                                     const char *machine_options)
+{
+    tpm_test_simple_cmd_swtpm_test(src_tpm_path, tx, ifmodel, machine_options,
+                                   tpm_util_short_write);
+}
+
+void tpm_test_too_short_cmd_swtpm_test(const char *src_tpm_path, tx_func *tx,
+                                       const char *ifmodel,
+                                       const char *machine_options)
+{
+    tpm_test_simple_cmd_swtpm_test(src_tpm_path, tx, ifmodel, machine_options,
+                                   tpm_util_too_short_cmd);
+}
+
 void tpm_test_swtpm_migration_test(const char *src_tpm_path,
                                    const char *dst_tpm_path,
                                    const char *uri, tx_func *tx,
diff --git a/tests/qtest/tpm-tests.h b/tests/qtest/tpm-tests.h
index 07ba60d26e..7684abf8f4 100644
--- a/tests/qtest/tpm-tests.h
+++ b/tests/qtest/tpm-tests.h
@@ -18,6 +18,14 @@
 void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
                          const char *ifmodel, const char *machine_options);
 
+void tpm_test_short_write_swtpm_test(const char *src_tpm_path, tx_func *tx,
+                                     const char *ifmodel,
+                                     const char *machine_options);
+
+void tpm_test_too_short_cmd_swtpm_test(const char *src_tpm_path, tx_func *tx,
+                                       const char *ifmodel,
+                                       const char *machine_options);
+
 void tpm_test_swtpm_migration_test(const char *src_tpm_path,
                                    const char *dst_tpm_path,
                                    const char *uri, tx_func *tx,
diff --git a/tests/qtest/tpm-tis-device-swtpm-test.c b/tests/qtest/tpm-tis-device-swtpm-test.c
index 517a077005..48a7389306 100644
--- a/tests/qtest/tpm-tis-device-swtpm-test.c
+++ b/tests/qtest/tpm-tis-device-swtpm-test.c
@@ -38,6 +38,14 @@ static void tpm_tis_swtpm_test(const void *data)
                         "tpm-tis-device", MACHINE_OPTIONS);
 }
 
+static void tpm_tis_too_short_cmd_swtpm_test(const void *data)
+{
+    const TestState *ts = data;
+
+    tpm_test_too_short_cmd_swtpm_test(ts->src_tpm_path, tpm_tis_transfer,
+                                      "tpm-tis-device", MACHINE_OPTIONS);
+}
+
 static void tpm_tis_swtpm_migration_test(const void *data)
 {
     const TestState *ts = data;
@@ -62,6 +70,8 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_data_func("/tpm/tis-swtpm/test", &ts, tpm_tis_swtpm_test);
+    qtest_add_data_func("/tpm/tis-too-short-cmd-swtpm/test", &ts,
+                        tpm_tis_too_short_cmd_swtpm_test);
     qtest_add_data_func("/tpm/tis-swtpm-migration/test", &ts,
                         tpm_tis_swtpm_migration_test);
     ret = g_test_run();
diff --git a/tests/qtest/tpm-tis-swtpm-test.c b/tests/qtest/tpm-tis-swtpm-test.c
index 105e42e21d..14b4cbce21 100644
--- a/tests/qtest/tpm-tis-swtpm-test.c
+++ b/tests/qtest/tpm-tis-swtpm-test.c
@@ -36,6 +36,14 @@ static void tpm_tis_swtpm_test(const void *data)
                         "tpm-tis", NULL);
 }
 
+static void tpm_tis_too_short_cmd_swtpm_test(const void *data)
+{
+    const TestState *ts = data;
+
+    tpm_test_too_short_cmd_swtpm_test(ts->src_tpm_path, tpm_tis_transfer,
+                                      "tpm-tis", NULL);
+}
+
 static void tpm_tis_swtpm_migration_test(const void *data)
 {
     const TestState *ts = data;
@@ -57,6 +65,8 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_data_func("/tpm/tis-swtpm/test", &ts, tpm_tis_swtpm_test);
+    qtest_add_data_func("/tpm/tis-too-short-cmd-swtpm/test", &ts,
+                        tpm_tis_too_short_cmd_swtpm_test);
     qtest_add_data_func("/tpm/tis-swtpm-migration/test", &ts,
                         tpm_tis_swtpm_migration_test);
     ret = g_test_run();
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 151002ea24..d2042ed5df 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -194,6 +194,61 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
                     &exp_resp[14], exp_resp_size - 14);
 }
 
+/*
+ * Write a TPM command with too large length indicator
+ * The CRB will send the command to the TPM.
+ * The TIS will never send the command since it wants to receive the number of
+ * bytes indicate in the command.
+ */
+void tpm_util_short_write(QTestState *s, tx_func *tx)
+{
+    unsigned char buffer[1024] = { 0 };
+    static const unsigned char tpm_bad_command[] = {
+        0x80, 0x01,
+        0x00, 0x01, 0x00, 0x00, /* length = 0x10000 */
+        0x00, 0x00, 0x01, 0x7e,
+        0x00, 0x00, 0x00, 0x01, 0x00, 0x0b, 0x03, 0x00, 0x04, 0x00
+    };
+
+    tx(s, tpm_bad_command, sizeof(tpm_bad_command), buffer, sizeof(buffer));
+
+    static const unsigned char tpm_error_resp[] = {
+        0x80, 0x01,
+        0x00, 0x00, 0x00, 0x0a,
+        0x00, 0x00, 0x01, 0x42, /* TPM_RC_COMMAND_SIZE */
+    };
+
+    g_assert_cmpmem(buffer, sizeof(tpm_error_resp),
+                    tpm_error_resp, sizeof(tpm_error_resp));
+}
+
+/*
+ * Write a TPM command that is shorter than the header.
+ * The CRB will not send this command.
+ * The TIS will send the command to the backend (needs to be at least
+ * 6 bytes).
+ */
+void tpm_util_too_short_cmd(QTestState *s, tx_func *tx)
+{
+    unsigned char buffer[1024] = { 0 };
+    static const unsigned char tpm_bad_command[] = {
+        0x80, 0x01,
+        0x00, 0x00, 0x00, 0x09, /* 9 bytes command is too short */
+        0x00, 0x00, 0x01,
+    };
+
+    tx(s, tpm_bad_command, sizeof(tpm_bad_command), buffer, sizeof(buffer));
+
+    static const unsigned char tpm_error_resp[] = {
+        0x80, 0x01,
+        0x00, 0x00, 0x00, 0x0a,
+        0x00, 0x00, 0x01, 0x01, /* TPM_RC_FAILURE from tpm_emulator.c */
+    };
+
+    g_assert_cmpmem(buffer, sizeof(tpm_error_resp),
+                    tpm_error_resp, sizeof(tpm_error_resp));
+}
+
 bool tpm_util_swtpm_has_tpm2(void)
 {
     bool has_tpm2 = false;
diff --git a/tests/qtest/tpm-util.h b/tests/qtest/tpm-util.h
index 681544e7d8..70c2fc09c6 100644
--- a/tests/qtest/tpm-util.h
+++ b/tests/qtest/tpm-util.h
@@ -38,6 +38,9 @@ void tpm_util_pcrextend(QTestState *s, tx_func *tx);
 void tpm_util_pcrread(QTestState *s, tx_func *tx,
                       const unsigned char *exp_resp, size_t exp_resp_size);
 
+void tpm_util_short_write(QTestState *s, tx_func *tx);
+void tpm_util_too_short_cmd(QTestState *s, tx_func *tx);
+
 bool tpm_util_swtpm_has_tpm2(void);
 
 gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
-- 
2.55.0


