Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B95E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 16:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDk5-0007UF-Ut; Mon, 16 Dec 2024 11:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNDjk-0007Qi-Db
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:14:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNDji-00075d-SA
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734365661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wkjcazPwHvsy47bb6YhA4CwXiaPpEKId/bwPUAugxmI=;
 b=IT7MCE8hT9xmiD3rw0mXAounnuuDQpy146Q+oCV4I6LsIqsWaqgyYs655BFJKuvLgQHopO
 4fPhLUrLNiUKF0YGG9wgNHnK4qJW9mzNSqX7NIGJxyryRj4P9FGGQaTdSLNVg1qB6oOG1g
 UtCMs/zrTWFHes8WAy/9+OlEDYh6row=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-SbuUYto1N3CcKfQRQsDnAw-1; Mon, 16 Dec 2024 11:14:20 -0500
X-MC-Unique: SbuUYto1N3CcKfQRQsDnAw-1
X-Mimecast-MFC-AGG-ID: SbuUYto1N3CcKfQRQsDnAw
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a9d075bdc3so82277935ab.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 08:14:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734365658; x=1734970458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wkjcazPwHvsy47bb6YhA4CwXiaPpEKId/bwPUAugxmI=;
 b=Wyy/rWixNYt5Q2kmbgFor6fCWl5Oc+obHbv7zVcGzkxm8RZqGYEe2LC6G6gL5dX8V+
 KdjOc97fntn9N6bd3aHz8yVHOiHF4SLJ2vmQFpyEgFyZt9JQuAIh1vor/XvPUP4TeMGu
 HhixIm7id9Ilr0ExhH7F4dd1Z0Png3ewAfJjFEq/1X3Si7AYrUPdupIvfUbw18xJ05v8
 PAdJ2PQTGIyXzZwPwlbtTN7JYbrB6iq4RiTKCmrjQCpt8Pzby7NqbcMkerfiu2IPjTda
 xUcNtZoY1GHJ7hOtRJUFjoPOuYCEHYbLQU6nEGJvAo0nAEyvJ9EIw+wOkgSXQvHKH0+y
 CXBQ==
X-Gm-Message-State: AOJu0YzHo6WuI7rPHTn2AT5lt5e1cFonfFGCl04toEVPTKwyxBC9ibRi
 vS+cN72M0D9pEV2wpA9nHhPr+KwDPqQqFbNb09/TkXo2qiHi+OhTvdqNOp+b+qUy0kKPGbPHOkk
 TcJCYiEfBhrN0qJ+SkP+ZxqDRwgY4IIROxgzwCJJZYzoVmvS0wMEQ9+Zm8qKZ7vjX1vxs269+a7
 +5IhRYAYAfmkqKgeNoU9CLzsdtmovwilFJSg==
X-Gm-Gg: ASbGncuqdIgwDg0wHCGGh/ztTfYxXkAsxaD+w3DLtoQ4D3GvrD76dk7zltm7uS3lvk0
 M9UcxK1SHBCNm41AAswVwa9dSOlLjR2AYxWCQFBDmvCAAhWEsh3S/N2i51cqSqdS3CS+f9W/Pfn
 861qes9/aCAESoRra+b1dfaXOkUnRMiJ/XCpPXJnOrU7YQZJsh5feRRPEPqwRoITQ1eztZp8Is3
 lO3RcKbNPD0CeXPO0wpdCJeD3yKdL87YJSnfVdJ3ZPSPX03aknvRlNNu8f/wZPGvU1uOHj/CxFv
 B5aF7/GR9WGfU8AHOoPp
X-Received: by 2002:a05:6e02:1a45:b0:3a7:6f5a:e5c7 with SMTP id
 e9e14a558f8ab-3aff461ad34mr115509035ab.4.1734365658693; 
 Mon, 16 Dec 2024 08:14:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUtpIHyDwFhQBaCPjNZgp6mHZpmASj9/Hc5sy65v8K/g5A7LbNB8fPrrlcyw+nN1BATOr2Dg==
X-Received: by 2002:a05:6e02:1a45:b0:3a7:6f5a:e5c7 with SMTP id
 e9e14a558f8ab-3aff461ad34mr115508845ab.4.1734365658367; 
 Mon, 16 Dec 2024 08:14:18 -0800 (PST)
Received: from x1n.. (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3b248cb74fbsm15895765ab.34.2024.12.16.08.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 08:14:17 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH 2/3] tests: Use qemu_mkdir_with_parents() for all test code
Date: Mon, 16 Dec 2024 11:14:12 -0500
Message-ID: <20241216161413.1644171-3-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216161413.1644171-1-peterx@redhat.com>
References: <20241216161413.1644171-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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

Coverity isn't happy on the QEMU test cases where g_mkdir_with_parents() is
used without checking retvals.  Use qemu_mkdir_with_parents() to fix them.

Resolves: Coverity CID 1568381
Resolves: Coverity CID 1568378
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/tls-tests.c     | 6 +++---
 tests/unit/test-crypto-tlscredsx509.c | 4 ++--
 tests/unit/test-crypto-tlssession.c   | 6 +++---
 tests/unit/test-io-channel-tls.c      | 6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 5704a1f992..c78daff998 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -43,14 +43,14 @@ migrate_hook_start_tls_psk_common(QTestState *from,
     data->workdir = g_strdup_printf("%s/tlscredspsk0", tmpfs);
     data->pskfile = g_strdup_printf("%s/%s", data->workdir,
                                     QCRYPTO_TLS_CREDS_PSKFILE);
-    g_mkdir_with_parents(data->workdir, 0700);
+    qemu_mkdir_with_parents(data->workdir, 0700);
     test_tls_psk_init(data->pskfile);
 
     if (mismatch) {
         data->workdiralt = g_strdup_printf("%s/tlscredspskalt0", tmpfs);
         data->pskfilealt = g_strdup_printf("%s/%s", data->workdiralt,
                                            QCRYPTO_TLS_CREDS_PSKFILE);
-        g_mkdir_with_parents(data->workdiralt, 0700);
+        qemu_mkdir_with_parents(data->workdiralt, 0700);
         test_tls_psk_init_alt(data->pskfilealt);
     }
 
@@ -152,7 +152,7 @@ migrate_hook_start_tls_x509_common(QTestState *from,
         data->clientcert = g_strdup_printf("%s/client-cert.pem", data->workdir);
     }
 
-    g_mkdir_with_parents(data->workdir, 0700);
+    qemu_mkdir_with_parents(data->workdir, 0700);
 
     test_tls_init(data->keyfile);
 #ifndef _WIN32
diff --git a/tests/unit/test-crypto-tlscredsx509.c b/tests/unit/test-crypto-tlscredsx509.c
index 3c25d75ca1..57ce0134df 100644
--- a/tests/unit/test-crypto-tlscredsx509.c
+++ b/tests/unit/test-crypto-tlscredsx509.c
@@ -75,7 +75,7 @@ static void test_tls_creds(const void *opaque)
     QCryptoTLSCreds *creds;
 
 #define CERT_DIR "tests/test-crypto-tlscredsx509-certs/"
-    g_mkdir_with_parents(CERT_DIR, 0700);
+    qemu_mkdir_with_parents(CERT_DIR, 0700);
 
     unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
     if (data->isServer) {
@@ -141,7 +141,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
 
-    g_mkdir_with_parents(WORKDIR, 0700);
+    qemu_mkdir_with_parents(WORKDIR, 0700);
 
     test_tls_init(KEYFILE);
 
diff --git a/tests/unit/test-crypto-tlssession.c b/tests/unit/test-crypto-tlssession.c
index 3395f73560..db97cbefe7 100644
--- a/tests/unit/test-crypto-tlssession.c
+++ b/tests/unit/test-crypto-tlssession.c
@@ -271,8 +271,8 @@ static void test_crypto_tls_session_x509(const void *opaque)
 
 #define CLIENT_CERT_DIR "tests/test-crypto-tlssession-client/"
 #define SERVER_CERT_DIR "tests/test-crypto-tlssession-server/"
-    g_mkdir_with_parents(CLIENT_CERT_DIR, 0700);
-    g_mkdir_with_parents(SERVER_CERT_DIR, 0700);
+    qemu_mkdir_with_parents(CLIENT_CERT_DIR, 0700);
+    qemu_mkdir_with_parents(SERVER_CERT_DIR, 0700);
 
     unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
     unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
@@ -420,7 +420,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
 
-    g_mkdir_with_parents(WORKDIR, 0700);
+    qemu_mkdir_with_parents(WORKDIR, 0700);
 
     test_tls_init(KEYFILE);
     test_tls_psk_init(PSKFILE);
diff --git a/tests/unit/test-io-channel-tls.c b/tests/unit/test-io-channel-tls.c
index e036ac5df4..6cb83e891a 100644
--- a/tests/unit/test-io-channel-tls.c
+++ b/tests/unit/test-io-channel-tls.c
@@ -125,8 +125,8 @@ static void test_io_channel_tls(const void *opaque)
 
 #define CLIENT_CERT_DIR "tests/test-io-channel-tls-client/"
 #define SERVER_CERT_DIR "tests/test-io-channel-tls-server/"
-    g_mkdir_with_parents(CLIENT_CERT_DIR, 0700);
-    g_mkdir_with_parents(SERVER_CERT_DIR, 0700);
+    qemu_mkdir_with_parents(CLIENT_CERT_DIR, 0700);
+    qemu_mkdir_with_parents(SERVER_CERT_DIR, 0700);
 
     unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
     unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
@@ -273,7 +273,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
 
-    g_mkdir_with_parents(WORKDIR, 0700);
+    qemu_mkdir_with_parents(WORKDIR, 0700);
 
     test_tls_init(KEYFILE);
 
-- 
2.47.0


