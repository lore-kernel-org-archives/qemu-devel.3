Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B9FC369D7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L2t-0001d4-S9; Fri, 25 Apr 2025 11:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2a-0000bH-IE
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:39 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2Y-0004BE-8M
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:36 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c1ee0fd43so1946990f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595152; x=1746199952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ry9O9boaNvWNKXTX4XveCYOkptDL47bcTRXPjT/icgU=;
 b=ETLCHYd5D613QQLF6Ne1RdYSatP80+j9Tg2DedfC+cchdA/1sxBbEy+Eg8lViX0qWL
 1ml191aT8RgbAkBoSHi5Ia3RGBH5Y8MRfA8zf3Dou0ZNAtu0aWIvBHKZwsxTs6zRw0wQ
 VwN+tfSX4/0bAhQ5SfUBFP7D62ftv8LgkwA22/hPSj/ZpbsqraEoJSQZOk6SWzCdIKkZ
 mRWGI6QUAHvKPeFS+9Sq3aFSdT5/CmbaKuwTXLCH+rCrRz8UpWeIep5mEB04IKvJkQNc
 8/uyH+x8eTfvHwbOxb6jYigMVpm9Y/bJkLmP/UOsj9Glxdyhak5/Um8hcnHQyTRR0G1u
 H9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595152; x=1746199952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ry9O9boaNvWNKXTX4XveCYOkptDL47bcTRXPjT/icgU=;
 b=STZPSwwylvosicmfDeLubqE+5xpmYQbzaNQD7z2EPYJzUOk1GMbwwI7qkJfHTdShbo
 aQSV6TddM2v6ygz6UAVq2gR60l5TCwkF6Sb1qdfNmkIq/KMJJ7gdf+Bp4OLic0gAphBh
 J90qnlmXsPJGQfCYA0q5ITKRYVsiFWnuqt2yCrGe0pgC9OQ/RIZ6/gB2lMsCuIvFfhHP
 QNic7hk/p9Y7S0lMfHxNhWviLB6udQCxcYMD8ZezzjefvSitKn+HaKwBi5weeySYYjy2
 i9a5S4zS/loC1p+UT9OOoW90XqPH0eFbZlAj1Uuk1XoErrjH2tV7rmRGYmHTgQngHVlw
 P+HQ==
X-Gm-Message-State: AOJu0YwIUFto8KEQ95n3eJmQeIkdMS73ty4mojwXnW9m7X2X2/JKpRTf
 U11aEwUFFtbSlvIkOQ8d4XKZ1elFjFlDaQC+sKBLzdM3ze6TsBS0ZCFxfnpTUf5n0a5O8YE04Ke
 W
X-Gm-Gg: ASbGncuwvu7hUZMQAfVRzIqRoKq6rFFWHxNJtQAg/jyXmtEpEl/gfjdUq7nAXFT+TS5
 xUdidPcvC+bOnTfnRIthBHJckFKBj1Rplo9WnKtlP2GJSzG9RW5o/iSUkZH6bbDNkguK02BUPbB
 ZCvK4Do19hgs9lNPnZOjlSGwgaZjMij1jsIHyiUQZU/G2TJTEqs000dGhmoN44EcAqEl3BnX3D9
 loSN7Tey9ox4oxu9tj3GrWILntL31tIMlFoWIv+o3vFcmx84F4TBkGRbQCJ1xpwuseuXiMdum0k
 iKfak3sSf02eUFb2J+8yH0zU6+OCBn8MXlfjfyC6qX1RE1MZTRwwHxy/ldoPBQ2MiuVL44in6kW
 JyC3xfqmlWzbZOAc=
X-Google-Smtp-Source: AGHT+IGB/pZtEKXU1RuPRqh7oQio87UgAP7gVCn7Yx/suZaa/vkj9X9tgPtlw0nM5stFzd9gJkyYxw==
X-Received: by 2002:a5d:5847:0:b0:399:6dc0:f134 with SMTP id
 ffacd0b85a97d-3a074f43f47mr1906094f8f.51.1745595152277; 
 Fri, 25 Apr 2025 08:32:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e47307sm2678889f8f.65.2025.04.25.08.32.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:32:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 46/58] target/mips: Check CPU endianness at runtime using
 env_is_bigendian()
Date: Fri, 25 Apr 2025 17:28:30 +0200
Message-ID: <20250425152843.69638-47-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Since CPU endianness can be toggled at runtime before resetting,
checking the endianness at build time preprocessing the
TARGET_BIG_ENDIAN definition isn't correct. We have to call
mips_env_is_bigendian() to get the CPU endianness at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250417131004.47205-4-philmd@linaro.org>
---
 target/mips/tcg/msa_helper.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 14de4a71ff6..e349344647c 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -8212,7 +8212,6 @@ void helper_msa_ffint_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 /* Element-by-element access macros */
 #define DF_ELEMENTS(df) (MSA_WRLEN / DF_BITS(df))
 
-#if TARGET_BIG_ENDIAN
 static inline uint64_t bswap16x4(uint64_t x)
 {
     uint64_t m = 0x00ff00ff00ff00ffull;
@@ -8223,7 +8222,6 @@ static inline uint64_t bswap32x2(uint64_t x)
 {
     return ror64(bswap64(x), 32);
 }
-#endif
 
 void helper_msa_ld_b(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
@@ -8252,10 +8250,10 @@ void helper_msa_ld_h(CPUMIPSState *env, uint32_t wd,
      */
     d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
     d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
-#if TARGET_BIG_ENDIAN
-    d0 = bswap16x4(d0);
-    d1 = bswap16x4(d1);
-#endif
+    if (mips_env_is_bigendian(env)) {
+        d0 = bswap16x4(d0);
+        d1 = bswap16x4(d1);
+    }
     pwd->d[0] = d0;
     pwd->d[1] = d1;
 }
@@ -8273,10 +8271,10 @@ void helper_msa_ld_w(CPUMIPSState *env, uint32_t wd,
      */
     d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
     d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
-#if TARGET_BIG_ENDIAN
-    d0 = bswap32x2(d0);
-    d1 = bswap32x2(d1);
-#endif
+    if (mips_env_is_bigendian(env)) {
+        d0 = bswap32x2(d0);
+        d1 = bswap32x2(d1);
+    }
     pwd->d[0] = d0;
     pwd->d[1] = d1;
 }
@@ -8339,10 +8337,10 @@ void helper_msa_st_h(CPUMIPSState *env, uint32_t wd,
     /* Store 8 bytes at a time.  See helper_msa_ld_h. */
     d0 = pwd->d[0];
     d1 = pwd->d[1];
-#if TARGET_BIG_ENDIAN
-    d0 = bswap16x4(d0);
-    d1 = bswap16x4(d1);
-#endif
+    if (mips_env_is_bigendian(env)) {
+        d0 = bswap16x4(d0);
+        d1 = bswap16x4(d1);
+    }
     cpu_stq_le_data_ra(env, addr + 0, d0, ra);
     cpu_stq_le_data_ra(env, addr + 8, d1, ra);
 }
@@ -8360,10 +8358,10 @@ void helper_msa_st_w(CPUMIPSState *env, uint32_t wd,
     /* Store 8 bytes at a time.  See helper_msa_ld_w. */
     d0 = pwd->d[0];
     d1 = pwd->d[1];
-#if TARGET_BIG_ENDIAN
-    d0 = bswap32x2(d0);
-    d1 = bswap32x2(d1);
-#endif
+    if (mips_env_is_bigendian(env)) {
+        d0 = bswap32x2(d0);
+        d1 = bswap32x2(d1);
+    }
     cpu_stq_le_data_ra(env, addr + 0, d0, ra);
     cpu_stq_le_data_ra(env, addr + 8, d1, ra);
 }
-- 
2.47.1


