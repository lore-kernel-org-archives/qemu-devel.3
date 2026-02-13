Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F39FEF99C6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqxt6-0007Cs-4h; Fri, 13 Feb 2026 13:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxt2-0007Ca-5v
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:27:28 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxt0-00061w-Az
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:27:27 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48069a48629so11263565e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771007242; x=1771612042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77qp8FLiJwBN5TF68fSF77CWuEI2EM/pcGaKg31STP8=;
 b=S/xx7x+E4deaRLuPLQINzTCP7nez7THKOohO1EgwTyA3MA+o90AWZo6qeIODT6zh6n
 u2roywvLV53JD56qUhbDJR4/vXK1kuRkIET2pY2J+Vn5Elm3Gwsmby4TUBi5GMyh61F1
 ZQNWLEHv2wMoOAam4qVrfnn7ZGU1veVUILJRC+xH5g3E1UsCFbTJKmFJ0rsMJSNG0BFY
 +Yyj/Ka8O/Awrj4rMUrehvw8s5v6P4Fw7re74pn/207Q1I+We1G39nxgrOAlbiX2giFM
 UymGeNJwf5LOk3NVq8KScAcmRD5d/fr1YSQeP4zaZne7tHXKAgOAlqSb/YV2MJZRUjnZ
 qvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771007242; x=1771612042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=77qp8FLiJwBN5TF68fSF77CWuEI2EM/pcGaKg31STP8=;
 b=AlJTP2VvBIgF/vwcYo3j+uo2fpkAUBl/MOW8nWWYre2/4K9FBxwzB7S1raY/Nm/ibo
 Zfpj8ZYeWYi/D8ZF9niYPDtVj66BUl5+7E3pqihiDfwm9yKCTTa6dPjzfzHBJi3RpGa2
 Jh2Gm8lGOxcIbM9xqZDyhumHalxqEhQlI0rfCWvZwed64vZzKdhabSiF8fVjG2a/uZ5k
 l/hOKQcDZsjhw3mCRp2kAlXhuoQpSC1H6YrFJlLKjM2wCikQOHF1bLoFefUkYd0b0thx
 phccRF8VaOp4KU9WhknvKZ5sxLgWbUncbx3iDkI/IlQF7O93FbHwZJhCp2P8H8y8TxXM
 zQ6A==
X-Gm-Message-State: AOJu0YxXAFvtODTlTGBRVnxf8/RvuwLZA8fF6aD7/na+Kca5hmEsmqs5
 JQCTZTf+/yqYSTwO5UaHzkDJ3tOW1pdNaL/sYIQioBoKgM4+Zuy79P/+LoDcYOxGhJrfaWR7peH
 QIRXNBvQ=
X-Gm-Gg: AZuq6aL0qBf4ZET1J8ANOujWb9IsSCYXb6D96XyFwTTAZe0ifVgCw95T/keHa6jKEKv
 XqT24P1bmPpvma2a83CHTh2b3YjCQ1owFzpQ1YIRYk4kgjDsQKSw5KRPCb9VUIQnTtn+GB7/jfJ
 yivjWBb6FMzdjQ/nY4YyL9zQlBHd43/PCWhscCt11E7nn70f21cGg59bXhBsw9K7Vtvf6M1hji6
 Ls405khqotTH0YWG3cJ0tuFoTjLYhjTB4oxquqeOgVySdKCibvl5FGbh5lNBEJInOeAqnd8N9GO
 9Q29FFa7rU0zLz2WNYPj1CeeAPf/bhm2fsUJmaNNizBxs5kSR/NQRri+4wyN3f1wBD25AtSmRae
 MRMYmwNUnUTb8tlAOLaaAN3xhuiV6GsKtMvJmuC1IS0RJmOET8t84o4IEpIMazO2+5PmOxkQldI
 VE1AFQbkEN1y0OY0FWr5L1GpAQgvxqJ2YXMghits5Y7KR1dDx2KPIGP/JCY9yrG5BGHjGAMVs3
X-Received: by 2002:a05:600c:6808:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-48373a3e755mr46236355e9.18.1771007242394; 
 Fri, 13 Feb 2026 10:27:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370a53c51sm22991145e9.6.2026.02.13.10.27.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 10:27:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/5] qemu/target_info: Add target_page_bits_vary() helper
Date: Fri, 13 Feb 2026 19:27:09 +0100
Message-ID: <20260213182713.44924-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213182713.44924-1-philmd@linaro.org>
References: <20260213182713.44924-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Add a helper returning whether a target support variable
page sizes (only ARM targets so far).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info-impl.h   | 2 ++
 include/qemu/target-info.h        | 7 +++++++
 configs/targets/aarch64-softmmu.c | 1 +
 configs/targets/arm-softmmu.c     | 1 +
 target-info-stub.c                | 5 +++++
 target-info.c                     | 5 +++++
 6 files changed, 21 insertions(+)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index e446585bf53..537aad04fa8 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -19,6 +19,8 @@ typedef struct TargetInfo {
     SysEmuTarget target_arch;
     /* runtime equivalent of TARGET_LONG_BITS definition */
     unsigned long_bits;
+    /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
+    bool page_bits_vary;
     /* runtime equivalent of CPU_RESOLVING_TYPE definition */
     const char *cpu_type;
     /* QOM typename machines for this binary must implement */
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index e3287334304..0d2269e0401 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -23,6 +23,13 @@ const char *target_name(void);
  */
 unsigned target_long_bits(void);
 
+/**
+ * target_page_bits_vary:
+ *
+ * Returns: whether the target support variable page sizes
+ */
+bool target_page_bits_vary(void);
+
 /**
  * target_machine_typename:
  *
diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index 4e1e2f64da1..f9fb73a41c6 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -15,6 +15,7 @@ static const TargetInfo target_info_aarch64_system = {
     .target_name = "aarch64",
     .target_arch = SYS_EMU_TARGET_AARCH64,
     .long_bits = 64,
+    .page_bits_vary = true,
     .cpu_type = TYPE_ARM_CPU,
     .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index 9b3fdd2854a..a3bca3c9f0d 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -15,6 +15,7 @@ static const TargetInfo target_info_arm_system = {
     .target_name = "arm",
     .target_arch = SYS_EMU_TARGET_ARM,
     .long_bits = 32,
+    .page_bits_vary = true,
     .cpu_type = TYPE_ARM_CPU,
     .machine_typename = TYPE_TARGET_ARM_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
diff --git a/target-info-stub.c b/target-info-stub.c
index 65220cc7820..a6a080295f0 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -20,6 +20,11 @@ static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
     .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
     .long_bits = TARGET_LONG_BITS,
+#ifdef TARGET_PAGE_BITS_VARY
+    .page_bits_vary = true,
+#else
+    .page_bits_vary = false,
+#endif
     .cpu_type = CPU_RESOLVING_TYPE,
     .machine_typename = TYPE_MACHINE,
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
diff --git a/target-info.c b/target-info.c
index a26532f660f..06bf329de72 100644
--- a/target-info.c
+++ b/target-info.c
@@ -22,6 +22,11 @@ unsigned target_long_bits(void)
     return target_info()->long_bits;
 }
 
+bool target_page_bits_vary(void)
+{
+    return target_info()->page_bits_vary;
+}
+
 SysEmuTarget target_arch(void)
 {
     return target_info()->target_arch;
-- 
2.52.0


