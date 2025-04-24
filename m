Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA89C369D8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kvF-00015F-3M; Wed, 23 Apr 2025 20:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktk-00067N-5C
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:05 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktg-00059W-Iz
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:03 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso354521b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456219; x=1746061019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7arlHBpWQbE2q1hDh2KHA5LRT+R2b7K0miN1vyMnVZs=;
 b=InUymLG5wTNXv8vG/b3acKZY/6t716y/oPkGDI+ZuuesJxZJmE9X5ukJFpvtxCjdK6
 67904IUNRnUgGpwjBtBUoQU6IDTzdp+hxypiZbyq0Umk6uWLPP49EH9Z3Jr9aQSh10Xf
 EyOiOgKGsl2hDRCxeKoxYakzRNYfGnRmRrLP2PwYfqKFWF7oTf9M4mcDx5TDjxvmKbG4
 rAhDzm1YVgsAaGzwHj8qmc7j8UCCfUtMbEFF2tjSrFY4SBrFr7/Jq0c4sq98sz6AJOLa
 fuKZhzHjJTN7HaZ1iMsM6JPvsej5hvMDBl4z1HlEkcSFmMhQHYqummNaWXT7uDmbwcEB
 u3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456219; x=1746061019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7arlHBpWQbE2q1hDh2KHA5LRT+R2b7K0miN1vyMnVZs=;
 b=CFAuoekWhoVNJ+XMixHMb9Ab3iF9fzOnPX0ScXjQjtWitOGL7ZpkOX+sreYy1BTQ5H
 L3EYluoBmOIzEVew7iJlhWKYJqLpe+noQagCvegirKkI886mh1kKAwyZdFTrKyx0lJgp
 +LqfialQGgPzYhBVWCjA+pZRp/Bd9PoHZ56Zdv5R60x6J/F49ZaMRJ0JnVrLbJ8AkqSP
 2gdIDsDtCXk0Jtdq0QzhqfHLtjLPvbL/rIdEeLt4i4iWlwIRkuCxxrL/W0Lzj6mnH2ro
 0Q4qD0bZSwZzzF1LHLN/P9vqPg7GDTIeGpc3BbGUspqowABYeORuKWadPVC1U3dALKpZ
 ZgyQ==
X-Gm-Message-State: AOJu0YwCYYF0RVmle3NtHdFv9YaMeXZKRah6WiZJ7XdQWYnRoz10ZbWC
 H4g2kjRuA/Zm4iolNaCmOGQMd+kXhEVpyj9W91CGPmIxprOqjnoQm36whaxYUHA31z7ZZRcHF9A
 x
X-Gm-Gg: ASbGncv8o0CbizzSBhkWl35C+I5yXJAsTONGi7uJbEqrl1wWmNAicpP7/vF9w4bVth0
 07BB4bApGBSZrjmuZjiPr3DDG6mjw9IBlpTaT0ZkZRGGfktW9Yq9qY9LvBr1DVIwYif3kWTSXUN
 jdGHSC1rvub2XzlkpMRZELl+PYfxM+cpEaQLR4kDMys8wBFhmx7TdBvV+1CN8vRJwFtF/+NER4I
 Q3Y/ZHWj2VNt45job52dKHr5nT3Kh9puW2wm/vQUqr3TjVJA3Hm59/n0ZxzP5pLzdMqjP0BUIcT
 AoS+u3xa7ReWvWgvGgrDBVlVJmD7dYsL0iqQA5JDKhHHB4kBXdCTxwYXRw4M4Q3tH6/blWYdYdv
 bW/r/WNdX9Q==
X-Google-Smtp-Source: AGHT+IEwmme/6kTo5fknXcKV6DChVvvCbVaPnXPtbpvZMcEglgScCtajpPNvgw/nK1zxQGRGLJXYDA==
X-Received: by 2002:a05:6a20:2d28:b0:1f5:6e71:e45 with SMTP id
 adf61e73a8af0-20444f276d6mr971621637.27.1745456218906; 
 Wed, 23 Apr 2025 17:56:58 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 116/148] target/arm/cpu: flags2 is always uint64_t
Date: Wed, 23 Apr 2025 17:49:01 -0700
Message-ID: <20250424004934.598783-117-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Do not rely on target dependent type, but use a fixed type instead.
Since the original type is unsigned, it is safe to extend its size
without any side effect.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-21-pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h        | 10 ++++------
 target/arm/tcg/hflags.c |  4 ++--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ab7412772b..cc975175c6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -194,7 +194,7 @@ typedef struct ARMPACKey {
 /* See the commentary above the TBFLAG field definitions.  */
 typedef struct CPUARMTBFlags {
     uint32_t flags;
-    target_ulong flags2;
+    uint64_t flags2;
 } CPUARMTBFlags;
 
 typedef struct ARMMMUFaultInfo ARMMMUFaultInfo;
@@ -2968,11 +2968,9 @@ uint64_t arm_sctlr(CPUARMState *env, int el);
  * We collect these two parts in CPUARMTBFlags where they are named
  * flags and flags2 respectively.
  *
- * The flags that are shared between all execution modes, TBFLAG_ANY,
- * are stored in flags.  The flags that are specific to a given mode
- * are stores in flags2.  Since cs_base is sized on the configured
- * address size, flags2 always has 64-bits for A64, and a minimum of
- * 32-bits for A32 and M32.
+ * The flags that are shared between all execution modes, TBFLAG_ANY, are stored
+ * in flags. The flags that are specific to a given mode are stored in flags2.
+ * flags2 always has 64-bits, even though only 32-bits are used for A32 and M32.
  *
  * The bits for 32-bit A-profile and M-profile partially overlap:
  *
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 8d79b8b7ae..e51d9f7b15 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -506,8 +506,8 @@ void assert_hflags_rebuild_correctly(CPUARMState *env)
 
     if (unlikely(c.flags != r.flags || c.flags2 != r.flags2)) {
         fprintf(stderr, "TCG hflags mismatch "
-                        "(current:(0x%08x,0x" TARGET_FMT_lx ")"
-                        " rebuilt:(0x%08x,0x" TARGET_FMT_lx ")\n",
+                        "(current:(0x%08x,0x%016" PRIx64 ")"
+                        " rebuilt:(0x%08x,0x%016" PRIx64 ")\n",
                 c.flags, c.flags2, r.flags, r.flags2);
         abort();
     }
-- 
2.43.0


