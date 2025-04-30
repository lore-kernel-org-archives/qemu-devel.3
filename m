Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A805C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAcl-00065h-Q2; Wed, 30 Apr 2025 12:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcR-0005AO-BP
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:18 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcM-0001vM-Vu
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:09 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-227a8cdd241so569905ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746031745; x=1746636545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+erat6AyDf4aFwvHPMIYlKBGQpGrVV5ItGv/2Xtf4+w=;
 b=ZKpfl0KDntT/DpJwTDb4HC4UX7Bb6qwfmF/pgpyN4NwHlxSyk6rjDsYDGhuMfVOxci
 a7D2WC20fTtB7TCwIA2iqHSpQwA02Iz74WM8hRIX5JyQ1+mWo6BReINkMQ/DKpj//Mri
 1Kbm3dqYqgsKeZxrWORuruhNxR9gc34u+AkoFg9OQUKCWVi/qK5Fs8BH6Ck2XRYDbebx
 T8Cjb3CCmONkmDER0Jz4F4f5CbbfhIey/ouKPGOyfz/xobrXoBJ/o0LXSg2ceczMHHVk
 8tfFAxW3UZZtcd02m9rH/NCD6uqO6Gev7fOSkzoddUCwdI2lna4OOgczZ/SauBI+OaAd
 oUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031745; x=1746636545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+erat6AyDf4aFwvHPMIYlKBGQpGrVV5ItGv/2Xtf4+w=;
 b=MD+PfZifZS3I/NuPKQbKzJLhqXs9WQwVNNrlxGimIOe1XCVPUcMHGkZctTvCzrZePF
 e95OU7fUti7hJ8MUHWzDFTX821aIPcZM4rVdU88Zd0FD/uwO6mmNZb9qPuBCunz1NqUP
 jYBCKHd9LyR8+DuYD4YUfCxmTEWpD8T/oFbukdHKbHY6+fwUDDX8lyOQ4nqVEm8C0MTN
 IofH7lU38HkjD83UJpwl77lPDoZWi38UoUDW3hw9H4TCYIFbe8/+zjcqUshx3t75AxBs
 w2OC89naIdCtK6ldrWwZca/EIYatZBES71v0G6FfHRWg9N/UiT2iFt+JSIklqrzWFPB2
 5evg==
X-Gm-Message-State: AOJu0Ywc5iu1vXomjofBS/XF1ykc0Moiqp4w4JYLvgGi1xrFE6m3weaE
 TL/ecK/eJvqDOK+EitBCUCnrZ24ed+t7HdmXKedb4Wn49/Lrgm0OQT/5ebgApEv3ou8JVlfVpT5
 I
X-Gm-Gg: ASbGncsMKZ3PpCwmxHyscyDudKekNUwvjktK3h1Oq48u+vDNwpuR7w363V1uMYKbHhk
 FCG1D3e27zPVV4CI3/8x1LPRGAR8gwXItOFkFc2SC6kfyH85lkZ6/87QgnjU3dw6brlEcVXjsF3
 wfK+nmSWxd/d48KFhArJCH8V0Q+/w4Tb8S7zhsuWwW3xzxoi+SE/PxQ3ZiNC/QchzKzGDHJGizE
 nAgyQQ9jVmfROPwckkVIM2WWv2JWM9CKmMcfAKaZOqHqHvrw2Wh8yFqfHjyvS6lePbowVITjMc0
 h8kmQNvQeqUY74c1kLOlGTqp0oR9FrZh0sA5hbRu/ARj5uH/V7+5mtEjUpHfP87S1aaUp+kg9Xs
 =
X-Google-Smtp-Source: AGHT+IGs+lIDMy/b3BaUa7Qa1EEcbxrTuqFAon3iIDzTwDAL7mFRwh/KaHSMQeNo3amMmH5BCIPRDQ==
X-Received: by 2002:a17:903:3bce:b0:220:cd9a:a167 with SMTP id
 d9443c01a7336-22df34b862cmr65616825ad.4.1746031745497; 
 Wed, 30 Apr 2025 09:49:05 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f580asm9129704a12.2.2025.04.30.09.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:49:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 12/16] accel/tcg: Pass TCGTBCPUState to tb_htable_lookup
Date: Wed, 30 Apr 2025 09:48:50 -0700
Message-ID: <20250430164854.2233995-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430164854.2233995-1-richard.henderson@linaro.org>
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 808983e461..8e6899950e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -195,26 +195,24 @@ static bool tb_lookup_cmp(const void *p, const void *d)
     return false;
 }
 
-static TranslationBlock *tb_htable_lookup(CPUState *cpu, vaddr pc,
-                                          uint64_t cs_base, uint32_t flags,
-                                          uint32_t cflags)
+static TranslationBlock *tb_htable_lookup(CPUState *cpu, TCGTBCPUState s)
 {
     tb_page_addr_t phys_pc;
     struct tb_desc desc;
     uint32_t h;
 
     desc.env = cpu_env(cpu);
-    desc.cs_base = cs_base;
-    desc.flags = flags;
-    desc.cflags = cflags;
-    desc.pc = pc;
-    phys_pc = get_page_addr_code(desc.env, pc);
+    desc.cs_base = s.cs_base;
+    desc.flags = s.flags;
+    desc.cflags = s.cflags;
+    desc.pc = s.pc;
+    phys_pc = get_page_addr_code(desc.env, s.pc);
     if (phys_pc == -1) {
         return NULL;
     }
     desc.page_addr0 = phys_pc;
-    h = tb_hash_func(phys_pc, (cflags & CF_PCREL ? 0 : pc),
-                     flags, cs_base, cflags);
+    h = tb_hash_func(phys_pc, (s.cflags & CF_PCREL ? 0 : s.pc),
+                     s.flags, s.cs_base, s.cflags);
     return qht_lookup_custom(&tb_ctx.htable, &desc, h, tb_lookup_cmp);
 }
 
@@ -253,7 +251,7 @@ static inline TranslationBlock *tb_lookup(CPUState *cpu, TCGTBCPUState s)
         goto hit;
     }
 
-    tb = tb_htable_lookup(cpu, s.pc, s.cs_base, s.flags, s.cflags);
+    tb = tb_htable_lookup(cpu, s);
     if (tb == NULL) {
         return NULL;
     }
-- 
2.43.0


