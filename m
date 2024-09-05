Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA293CE7A91
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smIcJ-0006Z9-HE; Thu, 05 Sep 2024 15:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1smIcD-0006Bc-7s
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:58:02 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1smIc8-0005Q2-Sw
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:58:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20570b42f24so16611985ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725566272; x=1726171072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8mnf11fqMhOJ0HRRJgNLp3sCX2YE0q+64B/TUz3Pt8=;
 b=auhXSGLMF2v8csBs6j44cXCeozDbJ8ewJr4PWgWkQcygM8vmAuRAQ+AAIOsuF5qhoO
 jah7829DMkCCrv4jijvJ8/AlwJ4/Mxsbp3O9tdcvjdQSCwdiAyq8YpR+/Xjn8gjhfVQ1
 0gMriHSLCJStvr6JNayGFt3prQWYkHmG5xbvlwas76sSwK4655kUEufJmH+WDpIhBIJn
 V625HKRej1+0dXY+RT0o8zO66qZHj6StH9Zz/qbjPrR0uHEatASjdiYvLP41qC+a2qJy
 Df/ordbCGlT9i9+QNhslKeSnIXZlMvRTsIWLRJxoLLP8lMV6wD07xvzDwKecUp1f00ab
 VTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725566272; x=1726171072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8mnf11fqMhOJ0HRRJgNLp3sCX2YE0q+64B/TUz3Pt8=;
 b=GuawkBIA5JnwEsr72wIQ0aQQeMRhQq3Kcx2lUKTDvCkLOkqGT6BUhUqeiCKNPUy4j8
 y73sPybe0BYdD3QtUQCGrk6z4cyu9+eiXWtJ3xisRFJjH1Q3jaxO5ki15VuVaxqeZ2IT
 pBgerBdEJrjNnRgMxtIYXbt0gwBVH1PCzB/QOT4UF9lDuPsoQH4Tc4hSRFoWZNsdz+5/
 btrEp6UGAVaELeWNkk0IVdaR11Vg0BptGDeQKGZle53FY8YosTKYEFeN4EmDvdKFypgT
 a8vyr8+PqdL2/rn7IB8Alsgsf1FxEMWqkrskHREvm9KSmZi+Xkj7rWLZvUNb7fWXXEon
 DJjA==
X-Gm-Message-State: AOJu0YyAaGgZfRFyIpSkLo0bL4v1mDLjA8K5ODqHcLGC15LqwKJ4w3Ev
 oFBnwGhhGxuc3WZ/wZCQr3ydC9PclJoFn2x7XtSug9p+xviErHymhvBkhA==
X-Google-Smtp-Source: AGHT+IFgj0KrRHswL9j3aMxQ3AeikWLoriDiEUYI7hXra1UrJnBFxerhRYkYvgzbJcdGjYh2BGvHdg==
X-Received: by 2002:a17:902:e950:b0:205:60d2:106b with SMTP id
 d9443c01a7336-206f054fe2cmr2493765ad.34.1725566271741; 
 Thu, 05 Sep 2024 12:57:51 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.145])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea5554dsm32031355ad.235.2024.09.05.12.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 12:57:51 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v6 1/8] crypto: Define macros for hash algorithm digest lengths
Date: Fri,  6 Sep 2024 01:57:28 +0600
Message-Id: <20240905195735.16911-2-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240905195735.16911-1-dorjoychy111@gmail.com>
References: <20240905195735.16911-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 crypto/hash.c         | 14 +++++++-------
 include/crypto/hash.h |  8 ++++++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/crypto/hash.c b/crypto/hash.c
index b0f8228bdc..8087f5dae6 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -23,13 +23,13 @@
 #include "hashpriv.h"
 
 static size_t qcrypto_hash_alg_size[QCRYPTO_HASH_ALG__MAX] = {
-    [QCRYPTO_HASH_ALG_MD5] = 16,
-    [QCRYPTO_HASH_ALG_SHA1] = 20,
-    [QCRYPTO_HASH_ALG_SHA224] = 28,
-    [QCRYPTO_HASH_ALG_SHA256] = 32,
-    [QCRYPTO_HASH_ALG_SHA384] = 48,
-    [QCRYPTO_HASH_ALG_SHA512] = 64,
-    [QCRYPTO_HASH_ALG_RIPEMD160] = 20,
+    [QCRYPTO_HASH_ALG_MD5]       = QCRYPTO_HASH_DIGEST_LEN_MD5,
+    [QCRYPTO_HASH_ALG_SHA1]      = QCRYPTO_HASH_DIGEST_LEN_SHA1,
+    [QCRYPTO_HASH_ALG_SHA224]    = QCRYPTO_HASH_DIGEST_LEN_SHA224,
+    [QCRYPTO_HASH_ALG_SHA256]    = QCRYPTO_HASH_DIGEST_LEN_SHA256,
+    [QCRYPTO_HASH_ALG_SHA384]    = QCRYPTO_HASH_DIGEST_LEN_SHA384,
+    [QCRYPTO_HASH_ALG_SHA512]    = QCRYPTO_HASH_DIGEST_LEN_SHA512,
+    [QCRYPTO_HASH_ALG_RIPEMD160] = QCRYPTO_HASH_DIGEST_LEN_RIPEMD160,
 };
 
 size_t qcrypto_hash_digest_len(QCryptoHashAlgorithm alg)
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 54d87aa2a1..a113cc3b04 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -23,6 +23,14 @@
 
 #include "qapi/qapi-types-crypto.h"
 
+#define QCRYPTO_HASH_DIGEST_LEN_MD5       16
+#define QCRYPTO_HASH_DIGEST_LEN_SHA1      20
+#define QCRYPTO_HASH_DIGEST_LEN_SHA224    28
+#define QCRYPTO_HASH_DIGEST_LEN_SHA256    32
+#define QCRYPTO_HASH_DIGEST_LEN_SHA384    48
+#define QCRYPTO_HASH_DIGEST_LEN_SHA512    64
+#define QCRYPTO_HASH_DIGEST_LEN_RIPEMD160 20
+
 /* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */
 
 /**
-- 
2.39.2


