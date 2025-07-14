Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8493C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLX3-00056k-Of; Mon, 14 Jul 2025 11:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubKVv-0000Wp-3f
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:50:45 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubKVs-0006ex-Hf
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:50:42 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so2570604f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 07:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752504636; x=1753109436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iQWEhht4mYkxS+fB/JlwS8jEaHQbe2nCEP41K+cHwbQ=;
 b=LFnFFcrDDQBAHodDmcvccJafsC8+i7/wKBQ35wMobI4iAK/zqXDjP/achNKrRYydpC
 rMA2yDGolCHoA4+/umUCZJhfe9TnyVDDPwUZOx/x0vdKJHtgM1in5BW234goDGpG9iVN
 +yVIQOcKvFfU9EBhK3ywQIbiNsyPHeUFImVR7GHXFip0+PkvC16c6Rk4XXds9biMHS7e
 SQozNKjL3BZ4HvkeeHIOzdId32TISbgbK58fF4sGSSKTpD0ApCS8B1suzyUHV8JApuBZ
 2ZZh78xeU1nx2ZPs7UDM8rkNYPgoe81uoaXleMBkcNscOachtApO4x3e4JEZFwSXBklM
 6HVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752504636; x=1753109436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iQWEhht4mYkxS+fB/JlwS8jEaHQbe2nCEP41K+cHwbQ=;
 b=COVTL7C0nO3xgu02W3jnQpoqUQVfcnbapqlSjoLfCImkxLFiyTEnSK2G8QlYZbvkF9
 cNBRnAmLOvzSMSZwZMfiK/QCouJ1JbZF+gRKxzXhllmnCCE5h5juZIMb8wN4n4GQ4hxa
 5TroCUbsenDS6O4N7CoyJgLX0xu5/H9qyckz+E5FodycN96291odMyTBmxPYfnTCo1eH
 nM4/VyoG2x68kP4YLZNzL2FAI084zwBG11KW4Re+lZqLXi3MkK/GjEtUYXGS+7ouNhab
 uUzQTWrU5YLDzqNMldT4VGKM02uW4QSLmCXmVwMQQs8uMk4/kytcjczaOZ0gtQkVpKwO
 +kMw==
X-Gm-Message-State: AOJu0YzbJozxDuksJTu1xkWyp2PUjzujxoo50Epmh/pA/U8lF+mir+fI
 IGkk+94OWBMr08u/Dq4gWfISrEymM1Cr574JDaKryexbaAklaGPkkRLGF41qnVbBqexWvVNSjt6
 7yxsG
X-Gm-Gg: ASbGncva8Qe47dJBP+KYf5rD4q76uRCzahOrc79WSSrRsjQYLhac2asUryXoqk7mTlC
 29N1YG9R4kuxKnNFcHV3Kc/U2Z0aMWGdbm1nslDtlLI/T30ljpZrJmVcveS9+SXC1xsFrwTfSMx
 871ehnRK7UzAHEKppxp18+2+qhzs/sLJpk6T26kmpYkn0tLhhYjw2TgP92I8hY77XXoty4ZA2uf
 sBAVxfjKXuIxpBCHajDmDceW/kjCZx5kQ5CjUuYjiATukAvJzjvnH1VBPd9Fv+hhfQ54N0TVbSu
 tfBASw7rlrEhhv/kMc8YM//PTSJgrZRPDiZHNYk4p0VSZN2C8LNeKUijo+BMS41choIo2is9tof
 Xtb5wCSE5/OYturK2KI6H1eq3qSYy
X-Google-Smtp-Source: AGHT+IGZnqPAgYguUVOQFSqFJ7GqO9+SvEgngVHp/2ualqM8efDUwLet4FMiINUfrpaLLR5xRMdHUQ==
X-Received: by 2002:adf:e191:0:b0:3a4:cfbf:51a0 with SMTP id
 ffacd0b85a97d-3b5f35317a3mr10379367f8f.21.1752504635930; 
 Mon, 14 Jul 2025 07:50:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26f45sm12757578f8f.92.2025.07.14.07.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 07:50:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] host-utils: Drop workaround for buggy Apple Clang
 __builtin_subcll()
Date: Mon, 14 Jul 2025 15:50:33 +0100
Message-ID: <20250714145033.1908788-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

In commit b0438861efe ("host-utils: Avoid using __builtin_subcll on
buggy versions of Apple Clang") we added a workaround for a bug in
Apple Clang 14 where its __builtin_subcll() implementation was wrong.
This bug was only present in Apple Clang 14, not in upstream clang,
and is not present in Apple Clang versions 15 and newer.

Since commit 4e035201 we have required at least Apple Clang 15, so we
no longer build with the buggy versions.  We can therefore drop the
workaround. This is effectively a revert of b0438861efe.

This should not be backported to stable branches, which may still
need to support Apple Clang 14.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3030
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu/compiler.h   | 13 -------------
 include/qemu/host-utils.h |  2 +-
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 65b89958d36..1c2b673c058 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -182,19 +182,6 @@
 #define QEMU_DISABLE_CFI
 #endif
 
-/*
- * Apple clang version 14 has a bug in its __builtin_subcll(); define
- * BUILTIN_SUBCLL_BROKEN for the offending versions so we can avoid it.
- * When a version of Apple clang which has this bug fixed is released
- * we can add an upper bound to this check.
- * See https://gitlab.com/qemu-project/qemu/-/issues/1631
- * and https://gitlab.com/qemu-project/qemu/-/issues/1659 for details.
- * The bug never made it into any upstream LLVM releases, only Apple ones.
- */
-#if defined(__apple_build_version__) && __clang_major__ >= 14
-#define BUILTIN_SUBCLL_BROKEN
-#endif
-
 #if __has_attribute(annotate)
 #define QEMU_ANNOTATE(x) __attribute__((annotate(x)))
 #else
diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 4d28fa22cfa..dd558589cb5 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -677,7 +677,7 @@ static inline uint64_t uadd64_carry(uint64_t x, uint64_t y, bool *pcarry)
  */
 static inline uint64_t usub64_borrow(uint64_t x, uint64_t y, bool *pborrow)
 {
-#if __has_builtin(__builtin_subcll) && !defined(BUILTIN_SUBCLL_BROKEN)
+#if __has_builtin(__builtin_subcll)
     unsigned long long b = *pborrow;
     x = __builtin_subcll(x, y, b, &b);
     *pborrow = b & 1;
-- 
2.43.0


