Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010D4CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 20:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJzyG-0004BW-Nz; Mon, 04 May 2026 16:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wJzyB-0004AN-0G
 for qemu-devel@nongnu.org; Mon, 04 May 2026 16:32:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wJzy6-0000Oj-V4
 for qemu-devel@nongnu.org; Mon, 04 May 2026 16:32:46 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644EI8MK2210426; Mon, 4 May 2026 20:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Gf3NEw7xbKFeGNFT3
 uS/ALSicvlqpNec7vUBFKZSg4s=; b=nRhLUzkaHYpKyeLFnyQdAYgNubux4SKTF
 gz8tENWVRwGqiHUZhPIH+/TuoOtlMFAOHWCGPnLP8mEAXDmO5eEhK86PyxwVQhkt
 C3uah6x4Sg8dhOYdegDKuYHNE6QlRtrYNxoYTJa9m88HisgiISDmQrkC8EewddHR
 mffvXWJ09GB6buUlKRoIC0Pr1t2nOqWIKyTF1SUZ3ht7pfFNr41pMV2iNCjD61Wi
 3YL/+yQF+bzIoCxV0EQEg3V+2pwvnJkqvtmtLfhR0Mk+SN/87F992Tqk2MyZwPl2
 VEVO86rcKguF1U5aW6JZshmrSwqSfki8giyAdVqt0yVBg9etxkI/A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y18t56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 20:32:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644KORFa021885;
 Mon, 4 May 2026 20:32:40 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9y6fp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 20:32:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644KWdkj29688494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 20:32:39 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97D1258059;
 Mon,  4 May 2026 20:32:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 492AF58043;
 Mon,  4 May 2026 20:32:39 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 20:32:39 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 2/5] tests: Use ML-DSA-87 operations to cause large TPM
 transfers with CRB
Date: Mon,  4 May 2026 20:32:25 +0000
Message-ID: <20260504203228.886578-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504203228.886578-1-stefanb@linux.ibm.com>
References: <20260504203228.886578-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4SfGtnCi7wvvCxTHeoYVQyWP9ii6GFkd
X-Proofpoint-GUID: 4SfGtnCi7wvvCxTHeoYVQyWP9ii6GFkd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE4NSBTYWx0ZWRfX/N7i03CwVZIy
 5zbDUV6zd5bxDi+yugd63FHgU3CoQHB73hZkrysmRF1zntr6rPPSrUdll29fiJARH324mJ1SD5o
 Ybck/A1R3R/zy0zA+B3eU2Od9GuA4YuALF55Cob9E9vIhiElBlnwjYvY2j5kkQ5PURT1IGOu25o
 HxlLj6q0LhVM73L75kPY+EtoVx8E+6ir0v7PVKRyxpubcwSK2AYS0kbfZp5QnrXArnMlhRW6UZL
 /8tGWJqIwXXzmFl0SxRE1UNuuI1voTUgNvV0MCoF0ACewpMva4SRmC4a9Vs7PlfBSsJv2a1qQCy
 ITQqBoMLZ4+q6/P4+FjOKjkq2obeVlXz6BvOBVF2bjd6cEvXNJOxSOn4Kk2nGcbPiZBQBJrWfVN
 wRbXdUp2pEmn4dAIyDlV2f7sX6an9tirArfYcolPKHB7JADOjD9P6d3qqy5iwX89/fejpMJQw6L
 JBgR0Z2LbAGFR6o+rgQ==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69f90268 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=-ob2jAnJSdXix_SXycsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040185
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

To test large data transfers (receiving and sending) that make use of a CRB
chunked transfer, create an ML-DSA-87 key and sign some data with it and
receive the 4627 bytes signature. After this send the signature back to the
TPM to have the TPM verify the signature.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 tests/qtest/tpm-crb-swtpm-test.c |   5 +-
 tests/qtest/tpm-tests.c          | 113 +++++++++++++++++++++++++++++++
 tests/qtest/tpm-tests.h          |   4 ++
 tests/qtest/tpm-util.c           |  37 ++++++++++
 tests/qtest/tpm-util.h           |   2 +
 5 files changed, 159 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/tpm-crb-swtpm-test.c b/tests/qtest/tpm-crb-swtpm-test.c
index 050c7b0c1f..541fd58133 100644
--- a/tests/qtest/tpm-crb-swtpm-test.c
+++ b/tests/qtest/tpm-crb-swtpm-test.c
@@ -37,8 +37,9 @@ static void tpm_crb_chunk_swtpm_test(const void *data)
 {
     const TestState *ts = data;
 
-    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_crb_chunk_transfer,
-                        "tpm-crb", NULL);
+    tpm_test_swtpm_large_tx_test(ts->src_tpm_path,
+                                 tpm_util_crb_chunk_transfer,
+                                 "tpm-crb", NULL);
 }
 
 static void tpm_crb_swtpm_migration_test(const void *data)
diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index 9648e4902b..1c884c87c5 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -13,11 +13,14 @@
  */
 
 #include "qemu/osdep.h"
+#include "system/tpm_util.h"
 #include <glib/gstdio.h>
 
 #include "libqtest-single.h"
 #include "tpm-tests.h"
 
+#define ML_DSA_87_SIGNATURE_SIZE 4627
+
 static bool
 tpm_test_swtpm_skip(void)
 {
@@ -140,3 +143,113 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
     g_unlink(src_tpm_addr->u.q_unix.path);
     qapi_free_SocketAddress(src_tpm_addr);
 }
+
+void tpm_test_swtpm_large_tx_test(const char *src_tpm_path, tx_func *tx,
+                                  const char *ifmodel,
+                                  const char *machine_options)
+{
+    unsigned char signature[2 + 2 + ML_DSA_87_SIGNATURE_SIZE];/*TPMT_SIGNATURE*/
+    unsigned char response[8192];
+    unsigned char request[8192];
+    SocketAddress *addr = NULL;
+    GError *error = NULL;
+    char *args = NULL;
+    GPid swtpm_pid;
+    QTestState *s;
+    gboolean succ;
+
+    if (tpm_test_swtpm_skip()) {
+        return;
+    }
+
+    /* Large transfers based on ML-DSA operations required default-v2 profile */
+    if (!tpm_util_swtpm_has_profile("default-v2", "ml-dsa")) {
+        return;
+    }
+
+    succ = tpm_util_swtpm_start(src_tpm_path, &swtpm_pid, &addr, "default-v2",
+                                &error);
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
+    tpm_util_startup(s, tx);
+
+    static const unsigned char tpm_createprimary_mldsa[] = {
+        0x80, 0x02, 0x00, 0x00, 0x00, 0x38, 0x00, 0x00,
+        0x01, 0x31, 0x40, 0x00, 0x00, 0x07, 0x00, 0x00,
+        0x00, 0x09, 0x40, 0x00, 0x00, 0x09, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00,
+        0x00, 0x00, 0x0f, 0x00, 0xa1, 0x00, 0x0b, 0x00,
+        0x04, 0x04, 0x72, 0x00, 0x00, 0x00, 0x03, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+    };
+    tx(s, tpm_createprimary_mldsa, sizeof(tpm_createprimary_mldsa),
+       response, sizeof(response));
+    g_assert_cmpint(tpm_cmd_get_errcode(response), ==, 0);
+    g_assert_cmpint(tpm_cmd_get_size(response), ==, 2831);
+
+    static const unsigned char tpm_signsequencestart[] = {
+        0x80, 0x01, 0x00, 0x00, 0x00, 0x12, 0x00, 0x00,
+        0x01, 0xaa, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
+        0x00, 0x00
+    };
+    tx(s, tpm_signsequencestart, sizeof(tpm_signsequencestart),
+       response, sizeof(response));
+    g_assert_cmpint(tpm_cmd_get_errcode(response), ==, 0);
+    g_assert_cmpint(tpm_cmd_get_size(response), ==, 14);
+
+    /* Complete sequence and get signature */
+    static const unsigned char tpm_signsequencecomplete[] = {
+        0x80, 0x02, 0x00, 0x00, 0x00, 0x2a, 0x00, 0x00,
+        0x01, 0xa4, 0x80, 0x00, 0x00, 0x01, 0x80, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0x40, 0x00,
+        0x00, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40,
+        0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00,
+        0x00, 0x00
+    };
+    tx(s, tpm_signsequencecomplete, sizeof(tpm_signsequencecomplete),
+       response, sizeof(response));
+    g_assert_cmpint(tpm_cmd_get_errcode(response), ==, 0);
+    g_assert_cmpint(tpm_cmd_get_size(response), ==, 4655);
+
+    /* TPMT_SIGNATURE found at offset 14 */
+    memcpy(signature, &response[14], sizeof(signature));
+
+    static const unsigned char tpm_verifysequencestart[] = {
+        0x80, 0x01, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00,
+        0x01, 0xa9, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00
+    };
+    tx(s, tpm_verifysequencestart, sizeof(tpm_verifysequencestart),
+       response, sizeof(response));
+    g_assert_cmpint(tpm_cmd_get_errcode(response), ==, 0);
+    g_assert_cmpint(tpm_cmd_get_size(response), ==, 14);
+
+    /* TPM2_VerifySequenceComplete */
+    memcpy(request,
+           (unsigned char[]) {
+               0x80, 0x02, 0x00, 0x00, 0x12, 0x36, 0x00, 0x00,
+               0x01, 0xa3, 0x80, 0x00, 0x00, 0x01, 0x80, 0x00,
+               0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x40, 0x00,
+               0x00, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00,
+           }, 31);
+    memcpy(&request[31], signature, sizeof(signature));
+    tx(s, request, 31 + sizeof(signature), response, sizeof(response));
+    g_assert_cmpint(tpm_cmd_get_errcode(response), ==, 0);
+    g_assert_cmpint(tpm_cmd_get_size(response), ==, 27);
+
+    qtest_end();
+    tpm_util_swtpm_kill(swtpm_pid);
+
+    g_unlink(addr->u.q_unix.path);
+    qapi_free_SocketAddress(addr);
+}
diff --git a/tests/qtest/tpm-tests.h b/tests/qtest/tpm-tests.h
index 07ba60d26e..6993ce40dc 100644
--- a/tests/qtest/tpm-tests.h
+++ b/tests/qtest/tpm-tests.h
@@ -24,4 +24,8 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
                                    const char *ifmodel,
                                    const char *machine_options);
 
+void tpm_test_swtpm_large_tx_test(const char *src_tpm_path, tx_func *tx,
+                                  const char *ifmodel,
+                                  const char *machine_options);
+
 #endif /* TESTS_TPM_TESTS_H */
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 1f3e8c93b5..19e49390db 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -224,6 +224,43 @@ bool tpm_util_swtpm_has_tpm2(void)
     return has_tpm2;
 }
 
+bool tpm_util_swtpm_has_profile(const char *profilename,
+                                const char *content)
+{
+    bool has_profile = false;
+    char *out = NULL;
+    static const char *argv[] = {
+        "swtpm", "socket", "--tpm2", "--print-profiles", NULL
+    };
+
+    if (!tpm_util_swtpm_has_tpm2()) {
+        return false;
+    }
+
+    if (!g_spawn_sync(NULL /* working_dir */,
+                      (char **)argv,
+                      NULL /* envp */,
+                      G_SPAWN_SEARCH_PATH,
+                      NULL /* child_setup */,
+                      NULL /* user_data */,
+                      &out,
+                      NULL /* err */,
+                      NULL /* exit_status */,
+                      NULL)) {
+        return false;
+    }
+
+    if (strstr(out, profilename)) {
+        has_profile = true;
+    }
+    if (has_profile && content && strstr(out, content) == NULL) {
+        has_profile = false;
+    }
+
+    g_free(out);
+    return has_profile;
+}
+
 gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
                               SocketAddress **addr, const char *profilename,
                               GError **error)
diff --git a/tests/qtest/tpm-util.h b/tests/qtest/tpm-util.h
index ca2d7d173f..90790f30db 100644
--- a/tests/qtest/tpm-util.h
+++ b/tests/qtest/tpm-util.h
@@ -39,6 +39,8 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
                       const unsigned char *exp_resp, size_t exp_resp_size);
 
 bool tpm_util_swtpm_has_tpm2(void);
+bool tpm_util_swtpm_has_profile(const char *profilename,
+                                const char *content);
 
 gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
                               SocketAddress **addr, const char *profilename,
-- 
2.53.0


