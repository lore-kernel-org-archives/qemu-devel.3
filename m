Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271F6C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RAS-0002sp-Tg; Fri, 25 Apr 2025 18:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7o-0005eo-9T
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:24 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7l-0001Oc-L7
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:23 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-301c4850194so2291790a91.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618539; x=1746223339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wEXtO5aiOt/moVB28wigZg1GFsfWpZnoi3y9eQr8QbI=;
 b=MholbeyrjBbIFqD/gLXSZ/By+N+wkuhTeazuMn5H9bGAEh7gGYkzOhVS8uyyDv6SYI
 xFT5C7EA/NBVcPfRiUaHQWS/T80VT33sn3p3C/kPITQM63Tv6kUxrBsB8BZInf3UYCQR
 WJQZ+SA1lr444C9W7UQa2YLwNw7j3j+YlKKcz4FpNOwKR2mQplzuIBKOXZGCLMxG2X/m
 i1SYQGE0bTDFLz1KE7EmLsIDIU3ifXQkJ8Jd7YapWX8BLQg7TkDhaDoRLAaIqGwS/uVl
 F6g//rCM2PB4T1HTTDoWTuAFsxyc6OD9AWHnBax4bUEKxcvt3+OKHbfIM0ebiOLXjLEf
 LzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618539; x=1746223339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wEXtO5aiOt/moVB28wigZg1GFsfWpZnoi3y9eQr8QbI=;
 b=l45ZyHGQf2c5wgQK7jFOz2HIfhCEgV3sEOQ3GTuZCE3CKNIaF5fc/yIuvIcHGJHwZO
 ypVPK7cK7weCsiACYo/HlPh6JhYDMtAsmQlCeF/PGZKrXSNlSSVIfV4ggayM7P8pbMV6
 6+DutNmLpOGuZG4dAxAesqzVqYHBwjPKQWdXlAdfogaNrdB7ippVc4UClR2HCAuhS7uh
 fySNAvd22nVjzHVfxoX4RJM+d9R1eoh05wyMVZDTtSNATAb16JcgEAzyIKZSnQH13K29
 kOx6hE7PY0nvm6kQfwMiUhVzbSD7VOJLf1rwOJ1tyB70VTgse1IfGOFUTqoWbRJCxJkE
 OMjw==
X-Gm-Message-State: AOJu0YynXMKCi/WKEkIgkJAtvKOBPOTP96o0iIBglEPOMfLHC+pzKsTu
 yD3jZL+HRJwESjSnFZKkawHu57EGEbtPmiGQ8rgSPOqOi1qoQXD1ChGWIcDsoCOSS45SGXe7vy5
 z
X-Gm-Gg: ASbGncu8KA2SlTDtokdIgRylL0Q5WagQDLJRvNR5EJZfhTWbIftOgrGVbieVhSKyfk6
 LlEbQIZNbQTcdUA+mlGC6LWXHMglJX2S42Q+mesBjrZxehnFL1jZahDv7Gnot71T2gjv3xgIIj2
 C2OrZKNlnEtNsO/8W27iHfXj6oqSi3XmHZ5nec66NyMEtdME0pa4cCA2SUcbwK4ZdU03skC/Pyx
 W+gO8nG/tTkP8aHk7iL9JnAoblf5F1FlEFXLOljGbkGo3oAB9fXvAf/ORjroZkuY0tjSUsUTYUg
 lEHtZIdXM6CJNTy8fv0xGZLjpn/tuEnBEJWxIXSxoTAJ6H+L75Uppzeti8tAHh8lInN4poY9Klo
 =
X-Google-Smtp-Source: AGHT+IG4eDzzQ6AdeGi1500AnQ+w/ycCUwrgPJwNMRXk+rttC8ud6lQBCX2DD/dI8kgmNaeCEb+bNg==
X-Received: by 2002:a17:90b:586e:b0:2ee:e518:c1cb with SMTP id
 98e67ed59e1d1-30a012ecbd8mr1693925a91.7.1745618539576; 
 Fri, 25 Apr 2025 15:02:19 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 112/159] tcg: Do not default add2/sub2_i32 for 32-bit hosts
Date: Fri, 25 Apr 2025 14:54:06 -0700
Message-ID: <20250425215454.886111-113-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Require TCG_TARGET_HAS_{add2,sub2}_i32 be defined,
one way or another.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target-has.h  | 2 ++
 tcg/mips/tcg-target-has.h | 3 +++
 tcg/ppc/tcg-target-has.h  | 3 +++
 tcg/tcg-has.h             | 3 ---
 tcg/tci/tcg-target-has.h  | 4 ++--
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 0d6a785542..3973df1f12 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -24,6 +24,8 @@ extern bool use_neon_instructions;
 #endif
 
 /* optional instructions */
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 48a1e68fbe..9f6fa194b9 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -48,6 +48,9 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
+#else
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
 #endif
 
 /* optional instructions detected at runtime */
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 033d58e095..8d832ce99c 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -25,6 +25,9 @@
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
+#else
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 6125ac677c..50e8d0cda4 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -14,9 +14,6 @@
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
-/* Turn some undef macros into true macros.  */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
 #endif
 
 #if !defined(TCG_TARGET_HAS_v64) \
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 4cb2b529ae..6063f32f7b 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -8,11 +8,11 @@
 #define TCG_TARGET_HAS_H
 
 #define TCG_TARGET_HAS_qemu_st8_i32     0
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #endif /* TCG_TARGET_REG_BITS == 64 */
-- 
2.43.0


