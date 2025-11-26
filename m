Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB504D11197
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM4J-00074l-P7; Wed, 26 Nov 2025 15:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM4D-0006L3-Js
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:24:47 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM45-0002hd-HR
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:24:42 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47790b080e4so377765e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188671; x=1764793471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnIOi7CrJFSwpeAe7LUTjMPzfQSZarulbCgikZO0egs=;
 b=KJAifEMGHkgoV3CfYTdmyXLz7IeKJEmjGPldsUIOAEnxoQFonEvog5G3LdF9hU02Fg
 8czBlu7BY/tBLd7NArdN52t66Wx7kxrZ1K18i20Dt8Zk7ka13GiAk8YK6Z+syPnf8smX
 CD0yGEWfbXSfCICSi6y0qgdK2JewkuMs2mWKpfTHLcW8Pb5eDOaKUavKMQu4ZIDwCu6j
 C03rk8bTKkyXwM7B6kWOHdiLtyKW6cLfKkexdEqV+uvQmxBVJhSnJMTlS6GKjFv/+XIo
 aochDWeYd0EP32EYMeQWZ8kVcDBg/ov8EZz8QI1SBD5Xw6M6SfOXd6diY081Gb3+m4dd
 ftPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188671; x=1764793471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VnIOi7CrJFSwpeAe7LUTjMPzfQSZarulbCgikZO0egs=;
 b=g1ZpL12PRSjRYjthoX+LSZ8p3zbyKmBJ7wL0oA42m80CFIwmPxuBWEsHlrUchUCQO7
 2WmdCVKir7IZBxPJEjvR1BOvw/SqAp7UNPDG2m7gLpSn4ZKZ8dazuwgRYnkGAweakl5Q
 dlt5dVClLUTy0l7rhvZCa5GGNtwfGRAu/EY+1GUdrBvPNMfi8AukW6Ms7scQyoVFJTd+
 AJGr5RSAEiykgGZABG87Nrqzz0o8bmMhgRFvLzgdY8efM1sKybK2djQln0AfZ7LZWm/c
 yRgdFue00Xc/C1nQoi0A3WNkF9HjCXFfwWScxp6ySjdwpF3qgSWoEYopiLv2htx3weqA
 vgtA==
X-Gm-Message-State: AOJu0YxfcDAKzq2WwYEaoSPNY0q5UnttWX9m/SyI35vSI9L5I74+/oxh
 6cEX8FKh7HTeysh6mz+S5ohckRwssCo/Z46qIdvdzRjQynuiETSYn5pfkDqlzhpx/d7tLNLr1oP
 BmC7gzE/oS7K5
X-Gm-Gg: ASbGncv56oAg57/iO12UHwLpLc9k0gpFcqbY1a4aJ9jsoko09ziJHhmB4rN4a7RW6dK
 D1yY0zi0LgSzhofKg/+pNHHmmdMyOJfsrlnCxaQClISYGPG17xnySdNPg2u/rVG/zHOQEZSGI39
 KtjauEOJ/Rug2y9O+7785z706iZAhYsX7abIOdDranaYsQDv4fjPAaA1kN2mXQTRNtFsFl+0cPl
 aIDoWb+wzFDwa6hFW3boK2JM1TmQGlDyveWO/ITGYqsZwiEPYhEBC0sKHUHjz6Zmzz9q39suR98
 M8mc3fNzr8PaLnxfMlx3i3Ovii6QUElnaRLJFdGNFTeMDKq0kRlZ6ur5YWmm1owj8zzg1X7v1wa
 f/WkvK0GtyMAv6yFyGmSROnpAMi3jYazr9mvYGieksNqvBAYmortZmxnhQZOUXY1gI4e42HrBSh
 uRn3kA0rXoirlh9EHHewwhFz/xg0w/xd1EWSOOsHsCp9iItHJ7ee3ZtgRLfbBL
X-Google-Smtp-Source: AGHT+IHS7wggQCdby10NfkSWlMTsSRtRVPteIIaqOZrvUp+QBjmDxVbagc2oqWtRApIfiigyz5Uyqw==
X-Received: by 2002:a05:600c:4f82:b0:477:952d:fc11 with SMTP id
 5b1f17b1804b1-477c11175a9mr246767695e9.16.1764188671036; 
 Wed, 26 Nov 2025 12:24:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8e54sm44005646f8f.40.2025.11.26.12.24.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:24:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH-for-11.0 v3 21/22] target/ppc: Simplify endianness handling in
 Altivec opcodes
Date: Wed, 26 Nov 2025 21:21:57 +0100
Message-ID: <20251126202200.23100-22-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Access the memory in big-endian order, swap bytes
when MSR.LE is set.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/mem_helper.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index cff385b6020..cfc67a527c1 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -31,15 +31,6 @@
 
 /* #define DEBUG_OP */
 
-static inline bool needs_byteswap(const CPUPPCState *env)
-{
-#if TARGET_BIG_ENDIAN
-  return FIELD_EX64(env->msr, MSR, LE);
-#else
-  return !FIELD_EX64(env->msr, MSR, LE);
-#endif
-}
-
 /*****************************************************************************/
 /* Memory load and stores */
 
@@ -421,11 +412,10 @@ target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
         int adjust = HI_IDX * (n_elems - 1);                    \
         int sh = sizeof(r->element[0]) >> 1;                    \
         int index = (addr & 0xf) >> sh;                         \
-        if (FIELD_EX64(env->msr, MSR, LE)) {                    \
-            index = n_elems - index - 1;                        \
-        }                                                       \
+        bool byteswap = FIELD_EX64(env->msr, MSR, LE);          \
                                                                 \
-        if (needs_byteswap(env)) {                              \
+        if (byteswap) {                                         \
+            index = n_elems - index - 1;                        \
             r->element[LO_IDX ? index : (adjust - index)] =     \
                 swap(access(env, addr, GETPC()));               \
         } else {                                                \
@@ -435,8 +425,8 @@ target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
     }
 #define I(x) (x)
 LVE(LVEBX, cpu_ldub_data_ra, I, u8)
-LVE(LVEHX, cpu_lduw_data_ra, bswap16, u16)
-LVE(LVEWX, cpu_ldl_data_ra, bswap32, u32)
+LVE(LVEHX, cpu_lduw_be_data_ra, bswap16, u16)
+LVE(LVEWX, cpu_ldl_be_data_ra, bswap32, u32)
 #undef I
 #undef LVE
 
@@ -448,11 +438,10 @@ LVE(LVEWX, cpu_ldl_data_ra, bswap32, u32)
         int adjust = HI_IDX * (n_elems - 1);                            \
         int sh = sizeof(r->element[0]) >> 1;                            \
         int index = (addr & 0xf) >> sh;                                 \
-        if (FIELD_EX64(env->msr, MSR, LE)) {                            \
-            index = n_elems - index - 1;                                \
-        }                                                               \
+        bool byteswap = FIELD_EX64(env->msr, MSR, LE);                  \
                                                                         \
-        if (needs_byteswap(env)) {                                      \
+        if (byteswap) {                                                 \
+            index = n_elems - index - 1;                                \
             access(env, addr, swap(r->element[LO_IDX ? index :          \
                                               (adjust - index)]),       \
                         GETPC());                                       \
@@ -463,8 +452,8 @@ LVE(LVEWX, cpu_ldl_data_ra, bswap32, u32)
     }
 #define I(x) (x)
 STVE(STVEBX, cpu_stb_data_ra, I, u8)
-STVE(STVEHX, cpu_stw_data_ra, bswap16, u16)
-STVE(STVEWX, cpu_stl_data_ra, bswap32, u32)
+STVE(STVEHX, cpu_stw_be_data_ra, bswap16, u16)
+STVE(STVEWX, cpu_stl_be_data_ra, bswap32, u32)
 #undef I
 #undef LVE
 
-- 
2.51.0


