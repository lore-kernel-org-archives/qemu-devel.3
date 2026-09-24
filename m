Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0934C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9kdM-0003pO-GE; Thu, 24 Sep 2026 10:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kct-0003TI-SA
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kcr-0004ZG-AG
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:43 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC6QjF2221935; Thu, 24 Sep 2026 14:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wvKNC6
 8fB/4KCoF9RcZ6H/26rnYyA4+27dfgr9SNgKI=; b=H16Pcu3oghkRt6CdLUsybJ
 2vh1UEAa8g1l7zkdP59foLIdx44OW8EJRlssBVz9hS0sDNWPgUKHhN0C1MJzLyuJ
 XaSYn5cVH2DUInqhP6+pXkA1lZdSwl7b7sfYOeChX65SkEBQK2CQSXWuVjgEW1bj
 e0aWn7I+ea2SbM8ZsLkfYjd2Dy42vhJXd+1tRqfFyAfFXNUVDK8SMPkiy2aKnp6f
 UPn3DFLbEsU9B04lDeaQRX6+uxiJzDkFF13cCrnHi+iWyTsN5c4+mGtIhIvylt5E
 Evhf8QRZtcpGWbn2kAKYOO35tZhz2zbd9e0ksd3Wvs2A2I/6cZCyeIVzltD0P5bw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvgywc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OENgTA2245197; Thu, 24 Sep 2026 14:40:39 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jx9ss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OEecxH32965160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 14:40:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70D915805B;
 Thu, 24 Sep 2026 14:40:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD7E958059;
 Thu, 24 Sep 2026 14:40:37 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 14:40:37 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 10/10] tests: Add tests with commands with bad length
Date: Thu, 24 Sep 2026 10:40:26 -0400
Message-ID: <20260924144026.953360-11-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924144026.953360-1-stefanb@linux.ibm.com>
References: <20260924144026.953360-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: _IomkbVow_q4fFLd_vqW7f-SwiabTSLS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX5An0SYNCdXHz
 UARAZDPHWo2NSzuLxB+tYzfBgV/RZkJ6zmbXZia1WOJ7y3EW/o12Vt4mgFRsKPNpRmiVKmEZtSf
 MtbhS9twqXSbOU7D/HLvn9Q1i/DCJRg=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab53668 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=rfWPa_Qpybt_VECXH-MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1LdXUmQgQVhchbne3dd3oLCkCLNJblqe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfXw5+UZsxLyfVm
 be8oOa4afGM7BarcNh7ni154rzn6zznBwY+Mt8BBuwUjyov5IylH+JkW0xn4WAco6sfD7cAjCC4
 YW/dyPeLnq+7ZpvwYBCqsSOJRG2zxmHW7zKqnTmyf4pNLHaNKwOGFJ6J63MQDzBVBw9AqL0GUey
 QjJOVLtEflGR7BAU936bIohRgWzZ8DRt/xgcfY4J7tdzR1urgQeOy2xt9eIcHxwV7YdTpL3ooe2
 +MVAY8wRxNecJli3/A0VTMCvl5qjrkWMzsp5PYdMF6hWLd1HBY9yZtKsD6apAR1AIHMlRsp+Wgx
 nANNLhN4waJy/1JHkqiRtJsncqa5iEF4R3HigdeBLQhAgouzLRVizk6SBjMzEB+zdj1UpH/G/jo
 bkcWfcZbpgpdulyThmuQGK4R8QkQVbGYa1yOfo3GLtMUG2UwQl54fY8IWebNk9VVwZvl/WTZazb
 dbr2xODeGBGfgLbD2Lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240060
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

Add two test cases with commands with bad length:

- Send a command that indicates a very large size (0x10000 bytes) to the
  TPM. This will only work with the CRB interface since the TIS wants
  to receive all the bytes indicated by the command header.

- Send a command that indicates that its size is only 9 bytes, which is
  too short to be valid since the command header alone is 10 bytes.
  This test only works with the TIS. The CRB silently rejects commands
  that are shorter than the command header.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


