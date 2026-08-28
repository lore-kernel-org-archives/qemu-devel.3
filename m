Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEC4C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Jr-00015A-J7; Fri, 28 Aug 2026 18:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jm-00010u-VQ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:02 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jl-0004Mw-DR
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:02 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so1275084a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957100; x=1788561900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kjM1/d/rZ39I6QxObJ8R61I/A1eoAPQ0NqTmgqOA2NE=;
 b=JLQGq3FlwTMAwd87nuzmQS7ifriVDvfSSX5KuSh/fSM2DLfC1jDwI9Eld+ghSZc+Jb
 1d6HRr7NFZc0CkVjHxyN7gVjFnbFLmsUaoJiMf74BPmCd28niDrCw6rIGWQ98hJZAXQG
 8TRjkwxfc+2dV40jcCYQ9+uzI8vXywP/Qm43zaX+7iku49wykDq+SbZ5DxeI97ZyZnHS
 hGVq3UjnWIO9mFmXRV41dSahhsVeZCwOOoTIkX7FU1J70EALaYXZoBHTT/OmIgx6XZi+
 okYY1T9N8H1atHLHR2BNjXS/WaKhmYNEyYrMmnk9sUqVfyfWASqhjZqaTjCLyL1k83aZ
 Khhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957100; x=1788561900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kjM1/d/rZ39I6QxObJ8R61I/A1eoAPQ0NqTmgqOA2NE=;
 b=ia2EDiehkS00CUH28wxf6npJpQQAgBxA62t3Xri58qndXOmIfdd5Y0FzN2LfvsI/Ez
 2BQsPnwIk04r2poErVV5Mce8UxlIENcZskIXVCA4CaKPS2T0PImzAiGPwnlAjWb614xJ
 uuziEIVlEmmSANIyImCv5XmnnydTyZLBMrqNvXcebzMNQ/G6nOrFmHhZ4Fc2tgwJNVoc
 lGEBa+Kg318pypcL3kSzaL9Qkztei1h4SB7STSQUyYveTUIrbc6Vmxwht38BKHg0WCq7
 r4e7ZcMMYX9TOjj5oN5D/X8XxeMD+/b4D5IH0TIP/Gp8ee2MGAymBCrYbdq8zWlsFoEd
 SxzQ==
X-Gm-Message-State: AFuF++lzauhhdtegmtwRC6EbEEL7rCUsJJE448X/7wtgfvJlJ2gOIHsg
 J3k3aDeyrFyU+lUfCbbD8IQM1iekzGi/Qi2tQTRoWCDOK5tBYzb3ZPlzewEM3+mnFpKuFT9sDYr
 AruBhaUc=
X-Gm-Gg: AYBFou2BFN8LRopQiRtKDOnkBJpFTQUciyMBFyT9ONCglHFmeEl7y7YItF4LARHo++n
 icKGqvWZy8xO36XwLQiYRc0A6LYp6y6Lm9ucO6TVrW2sfBpFeuDoUwnbCIiQFjyrpxqNPsceJv5
 mZyJ4YAZe/zGJ9oh7Y/j6Q8GQ8p9OaOpyl7i+xzTVnXE5tId/b1upOXZSVaYOPlCMGFV8EezSDV
 iokdCpf4+uF2tujLltER1evPvwIyloQU8QMt5OQz7Uo3yVSzDTi9WGTFq9+I0LwuhmlNGUv5D+M
 ehf0gLER8+kQiRoRBeI3UJ/5WgWyIkeaxJlWIgqJRburHQNE9h2mKM3oD+5ZUDzJZ5VLuayHxyd
 ZnY5qQlFpllZKjcBQqYWhPwm2/SKGEQdR36wJJIDeKw7GmfW1joA7e8wAYKgkcXosJAxgQ+3kQD
 P/9RCStrCgyF0pRTM+68a2r173/Wg3VSK7gbp506FYks+vdckqsC8ny0c74ZFk3DqDckVBEQHY3
 ckSJ3yqNK0byr5D7yAq
X-Received: by 2002:a17:90b:1c0a:b0:396:54ba:8932 with SMTP id
 98e67ed59e1d1-396d104e722mr15414796a91.16.1787957100001; 
 Fri, 28 Aug 2026 15:45:00 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:44:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 09/16] target/i386: Use tcg_gen_lea_tl in gen_lea_modrm_1
Date: Fri, 28 Aug 2026 15:44:44 -0700
Message-ID: <20260828224451.1564072-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d8de290acb6..4d0fff017c4 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1615,31 +1615,32 @@ static TCGv gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
 /* Compute the address, with a minimum number of TCG ops.  */
 static TCGv gen_lea_modrm_1(DisasContext *s, AddressParts a, bool is_vsib)
 {
-    TCGv ea = NULL;
+    TCGv ea = (a.base >= 0 ? cpu_regs[a.base] : NULL);
 
     if (a.index >= 0 && !is_vsib) {
+        TCGv index = cpu_regs[a.index];
+
+        if (ea) {
+            tcg_gen_lea_tl(s->A0, ea, index, a.scale, a.disp);
+            return s->A0;
+        }
         if (a.scale == 0) {
-            ea = cpu_regs[a.index];
+            ea = index;
         } else {
-            tcg_gen_shli_tl(s->A0, cpu_regs[a.index], a.scale);
+            tcg_gen_shli_tl(s->A0, index, a.scale);
             ea = s->A0;
         }
-        if (a.base >= 0) {
-            tcg_gen_add_tl(s->A0, ea, cpu_regs[a.base]);
-            ea = s->A0;
-        }
-    } else if (a.base >= 0) {
-        ea = cpu_regs[a.base];
-    }
-    if (!ea) {
+    } else if (!ea) {
         if (tb_cflags(s->base.tb) & CF_PCREL && a.base == -2) {
             /* With cpu_eip ~= pc_save, the expression is pc-relative. */
             tcg_gen_addi_tl(s->A0, cpu_eip, a.disp - s->pc_save);
         } else {
             tcg_gen_movi_tl(s->A0, a.disp);
         }
-        ea = s->A0;
-    } else if (a.disp != 0) {
+        return s->A0;
+    }
+
+    if (a.disp != 0) {
         tcg_gen_addi_tl(s->A0, ea, a.disp);
         ea = s->A0;
     }
-- 
2.53.0


