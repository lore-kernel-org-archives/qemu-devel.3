Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E9EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgQBD-0006hs-Di; Tue, 20 Aug 2024 10:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAx-0005rj-3W
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAh-0006L7-I6
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:34 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4281faefea9so44578755e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724165356; x=1724770156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sHKOV9DrTuAZNRw2GxXIgrum/jUoQJEGc0lRLc3B+xc=;
 b=fm3w8hF2hgmf4pLuC8Yy7dSSfSLfGCEXrNrodmfaVPyxU/USdEMuXMqsPn585plWpV
 YQWQJkh0PW3ei0wTVES2/rhreXeJe4iDQVD7sLFsxQGaJR8nZRGXKOEgTlBab4477ZRu
 bFSuIVFJtmlUXrcTylWS5QgrcL12Clr3EHdnXiJ8ku3QBS/OGiGC4CdbzXZI7/4owtG9
 TxAzE5GXgN+oLdvZUxBaMrIyKlAT4TR5R35/2EfwbjrQp6tWFTYShlUZoBL1PSf4EBcu
 gw0pz9Y+h1H+W4DORDnCLMdDs6+5o0WR+31uZK+QYEqAlxoqKsdZYa8xJMCx3eAgM96D
 rhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724165356; x=1724770156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sHKOV9DrTuAZNRw2GxXIgrum/jUoQJEGc0lRLc3B+xc=;
 b=ro05fV3ABa+6lfeGqiMgAlNCxK3WgaDrB8tFhaWo9YL7o/CQZleutMsahmpM5jHfFd
 HCTiV0Xq5WJuGwrGDJ50Nl3nf8zZT+rICTIXpd1L5r787RCtwWrjYW/016v0aX2gBtnX
 zLPJZDL6ildZwcpLlFy0DydE8kri1DKkcKzFRkxYE90bwK4UazFPwkosNcpM+CinwpdH
 NIeJ73uTdcO8tRYFAeYUkaGhUdk9sxG0YilWdgcvmLRz5Cu+/RMN8SjjokKaew0p8kON
 OKe1yAN+Yv4EFzJ2PMzxEJJh8WRlZEElmriB7hImmb2oK/DaSHKHGI67cAq7l46mh5yH
 7iCA==
X-Gm-Message-State: AOJu0YzyPTR9tnGG0JhH7wlo6sHlePunu58yeNr5+ri6M+u/vkEUPPzS
 ECBLub4wurc7MKZp3NbHaauMt3/RN0IEx3R9pDzAIN7P4P2Wzw9M4Vcwhb614m1xEC4NRgxa2jf
 7
X-Google-Smtp-Source: AGHT+IFAKynH2/06CakJs8Nu9W5Yyh3CngNNQPZEoaZw8ZZvIAx7j9NO60QNYgkLpnzqt58mozTbpg==
X-Received: by 2002:a5d:408a:0:b0:371:8e77:92f with SMTP id
 ffacd0b85a97d-371946dc42emr7630739f8f.61.1724165356481; 
 Tue, 20 Aug 2024 07:49:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a306sm13334672f8f.15.2024.08.20.07.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:49:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH for-9.2 5/9] tests/qtest/migration-test: Free
 QCRyptoTLSTestCertReq objects
Date: Tue, 20 Aug 2024 15:49:08 +0100
Message-Id: <20240820144912.320744-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820144912.320744-1-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In the migration test we create several TLS certificates with
the TLS_* macros from crypto-tls-x509-helpers.h. These macros
create both a QCryptoTLSCertReq object which must be deinitialized
and also an on-disk certificate file. The migration test currently
removes the on-disk file in test_migrate_tls_x509_finish() but
never deinitializes the QCryptoTLSCertReq, which means that memory
allocated as part of it is leaked:

Indirect leak of 2 byte(s) in 1 object(s) allocated from:
    #0 0x5558ba33712e in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f12e) (BuildId: 4c8618f663e538538cad19d35233124cea161491)
    #1 0x7f64afc131f4  (/lib/x86_64-linux-gnu/libtasn1.so.6+0x81f4) (BuildId: 2fde6ecb43c586fe4077118f771077aa1298e7ea)
    #2 0x7f64afc18d58 in asn1_write_value (/lib/x86_64-linux-gnu/libtasn1.so.6+0xdd58) (BuildId: 2fde6ecb43c586fe4077118f771077aa1298e7ea)
    #3 0x7f64af8fc678 in gnutls_x509_crt_set_version (/lib/x86_64-linux-gnu/libgnutls.so.30+0xe7678) (BuildId: 97b8f99f392f1fd37b969a7164bcea884e23649b)
    #4 0x5558ba470035 in test_tls_generate_cert tests/unit/crypto-tls-x509-helpers.c:234:5
    #5 0x5558ba464e4a in test_migrate_tls_x509_start_common tests/qtest/migration-test.c:1058:5
    #6 0x5558ba462c8a in test_migrate_tls_x509_start_default_host tests/qtest/migration-test.c:1123:12
    #7 0x5558ba45ab40 in test_precopy_common tests/qtest/migration-test.c:1786:21
    #8 0x5558ba450015 in test_precopy_unix_tls_x509_default_host tests/qtest/migration-test.c:2077:5
    #9 0x5558ba46d3c7 in migration_test_wrapper tests/qtest/migration-helpers.c:456:5

(and similar reports).

The only function currently provided to deinit a QCryptoTLSCertReq is
test_tls_discard_cert(), which also removes the on-disk certificate
file.  For the migration tests we need to retain the on-disk files
until we've finished running the test, so the simplest fix is to
provide a new function test_tls_deinit_cert() which does only the
cleanup of the QCryptoTLSCertReq, and call it in the right places.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/unit/crypto-tls-x509-helpers.h |  6 ++++++
 tests/qtest/migration-test.c         |  3 +++
 tests/unit/crypto-tls-x509-helpers.c | 12 ++++++++++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/tests/unit/crypto-tls-x509-helpers.h b/tests/unit/crypto-tls-x509-helpers.h
index 562c1606535..2a0f7c04fd8 100644
--- a/tests/unit/crypto-tls-x509-helpers.h
+++ b/tests/unit/crypto-tls-x509-helpers.h
@@ -73,6 +73,12 @@ void test_tls_generate_cert(QCryptoTLSTestCertReq *req,
 void test_tls_write_cert_chain(const char *filename,
                                gnutls_x509_crt_t *certs,
                                size_t ncerts);
+/*
+ * Deinitialize the QCryptoTLSTestCertReq, but don't delete the certificate
+ * file on disk. (The caller is then responsible for doing that themselves.
+ */
+void test_tls_deinit_cert(QCryptoTLSTestCertReq *req);
+/* Deinit the QCryptoTLSTestCertReq, and delete the certificate file */
 void test_tls_discard_cert(QCryptoTLSTestCertReq *req);
 
 void test_tls_init(const char *keyfile);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 9811047eeb4..a659609ccb0 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1062,12 +1062,15 @@ test_migrate_tls_x509_start_common(QTestState *from,
                                    QCRYPTO_TLS_TEST_CLIENT_HOSTILE_NAME :
                                    QCRYPTO_TLS_TEST_CLIENT_NAME,
                                    data->clientcert);
+        test_tls_deinit_cert(&servercertreq);
     }
 
     TLS_CERT_REQ_SIMPLE_SERVER(clientcertreq, cacertreq,
                                data->servercert,
                                args->certhostname,
                                args->certipaddr);
+    test_tls_deinit_cert(&clientcertreq);
+    test_tls_deinit_cert(&cacertreq);
 
     qtest_qmp_assert_success(from,
                              "{ 'execute': 'object-add',"
diff --git a/tests/unit/crypto-tls-x509-helpers.c b/tests/unit/crypto-tls-x509-helpers.c
index 3e74ec5b5d4..b316155d6a6 100644
--- a/tests/unit/crypto-tls-x509-helpers.c
+++ b/tests/unit/crypto-tls-x509-helpers.c
@@ -502,8 +502,7 @@ void test_tls_write_cert_chain(const char *filename,
     g_free(buffer);
 }
 
-
-void test_tls_discard_cert(QCryptoTLSTestCertReq *req)
+void test_tls_deinit_cert(QCryptoTLSTestCertReq *req)
 {
     if (!req->crt) {
         return;
@@ -511,6 +510,15 @@ void test_tls_discard_cert(QCryptoTLSTestCertReq *req)
 
     gnutls_x509_crt_deinit(req->crt);
     req->crt = NULL;
+}
+
+void test_tls_discard_cert(QCryptoTLSTestCertReq *req)
+{
+    if (!req->crt) {
+        return;
+    }
+
+    test_tls_deinit_cert(req);
 
     if (getenv("QEMU_TEST_DEBUG_CERTS") == NULL) {
         unlink(req->filename);
-- 
2.34.1


