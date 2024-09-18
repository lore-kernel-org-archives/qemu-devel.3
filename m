Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BF0CDD556
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 21:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr1tW-0005Fn-RR; Wed, 18 Sep 2024 17:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tV-0005AU-Ew
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:25 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tT-0001ds-Rx
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:25 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8a7cdfdd80so14217166b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 14:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726693642; x=1727298442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gcAPVufwlARI8k9tEcW8Q+w96+wb8gfpJ78TxPW758=;
 b=A8EXm7xev3SU5LCSyM53jaU6iAQ54gAk+wpy1jNf5qzJLtogzkVaF2ZiBHMXBb6P9x
 TvMKKLp7gakCmYXR2bYBPcAwF4gemIedMMIFiOl0C/V2mhPvfKBv+EvpqzuT3Dojpk8d
 dEzaQt+ndpe9bhLdeJUJazW4G83igfPtO7nGtVH6m20I4R53R/hG6cUK9odrhs9bWF1r
 IGnHfNrdC9Y8nGsqlyHjSu+eEDOp2Qn64xaW6Ose+KtarfAXckHSolYNHpNARAztX9Ej
 cAEoOpjx6Cjv3vHBqti3Z/rEN52pI2rhGKgQ7ZNMVdS8s60hBovqCqouWvUlcnxJKItQ
 FW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726693642; x=1727298442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gcAPVufwlARI8k9tEcW8Q+w96+wb8gfpJ78TxPW758=;
 b=wU0Jwlk+gMrRMXzUiAkuEELlg2ySqcfeoHKzFije1msAWCh+8am0RBKYzw0Xs/Mm1D
 2bO/ZelIt1QcoLaXBqElkRaa52EoVaaJzElTx6bbkbUwAax4VMtriGV324TzZXYHh9Bd
 NxXT1/lcw8UDk2c4Vu7LKL4Wge29psAC3imrp8ACsXu51/0QiEPl+fZMKK31SQyStm+P
 pRxt4ARRcdNau0X5uiNYdLYKbXZZ0z90N7bgsjsbt5uJgtmmytOOg+gn7jtIltqUxSJC
 kBlBuIuuh3j077fVNQFxiOEEjdBnUxIcRsdfUTkdvvwQQbF3cwii629DhD5hE8RnbPh9
 S9Jg==
X-Gm-Message-State: AOJu0Yz1piezIiB4rs3oOkETGK5rnEPqWcbFtoR5uENiYKNYOv9B8iOI
 JpnFuP7L6z04WvJ0tMnWybsUKa3+zUK6ENAjcDJMWo2/BN65NzVpyyUvyB9Ub+4=
X-Google-Smtp-Source: AGHT+IEB7cgYaHWQBvau9yo4rvoNzkL6GxQWhVCdbmPtKTx6c+sZMh6JomCoXZMKDlxnugYenp/C0w==
X-Received: by 2002:a17:906:794a:b0:a8a:8c8e:f5e6 with SMTP id
 a640c23a62f3a-a9048108fe6mr2110191066b.49.1726693642099; 
 Wed, 18 Sep 2024 14:07:22 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9060f39a8fsm636426366b.0.2024.09.18.14.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 14:07:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 510BF5F94D;
 Wed, 18 Sep 2024 22:07:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 11/18] tests/tcg: only read/write 64 bit words on 64 bit systems
Date: Wed, 18 Sep 2024 22:07:05 +0100
Message-Id: <20240918210712.2336854-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918210712.2336854-1-alex.bennee@linaro.org>
References: <20240918210712.2336854-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

While the compilers will generally happily synthesise a 64 bit value
for you on 32 bit systems it doesn't exercise anything on QEMU. It
also makes it hard to accurately compare the accesses to test_data
when instrumenting.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240916085400.1046925-12-alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
index 8f2371975d..28080767b2 100644
--- a/tests/tcg/multiarch/system/memory.c
+++ b/tests/tcg/multiarch/system/memory.c
@@ -163,6 +163,7 @@ static void init_test_data_u32(int offset)
     ml_printf("done %d @ %p\n", i, ptr);
 }
 
+#if __SIZEOF_POINTER__ >= 8
 static void init_test_data_u64(int offset)
 {
     uint8_t count = 0;
@@ -187,6 +188,7 @@ static void init_test_data_u64(int offset)
     }
     ml_printf("done %d @ %p\n", i, ptr);
 }
+#endif
 
 static bool read_test_data_u16(int offset)
 {
@@ -254,6 +256,7 @@ static bool read_test_data_u32(int offset)
     return true;
 }
 
+#if __SIZEOF_POINTER__ >= 8
 static bool read_test_data_u64(int offset)
 {
     uint64_t word, *ptr = (uint64_t *)&test_data[offset];
@@ -307,11 +310,16 @@ static bool read_test_data_u64(int offset)
     ml_printf("done %d @ %p\n", i, ptr);
     return true;
 }
+#endif
 
 /* Read the test data and verify at various offsets */
-read_ufn read_ufns[] = { read_test_data_u16,
-                         read_test_data_u32,
-                         read_test_data_u64 };
+read_ufn read_ufns[] = {
+    read_test_data_u16,
+    read_test_data_u32,
+#if __SIZEOF_POINTER__ >= 8
+    read_test_data_u64
+#endif
+};
 
 bool do_unsigned_reads(int start_off)
 {
@@ -476,10 +484,14 @@ bool do_signed_reads(bool neg_first)
     return ok;
 }
 
-init_ufn init_ufns[] = { init_test_data_u8,
-                         init_test_data_u16,
-                         init_test_data_u32,
-                         init_test_data_u64 };
+init_ufn init_ufns[] = {
+    init_test_data_u8,
+    init_test_data_u16,
+    init_test_data_u32,
+#if __SIZEOF_POINTER__ >= 8
+    init_test_data_u64
+#endif
+};
 
 int main(void)
 {
-- 
2.39.5


