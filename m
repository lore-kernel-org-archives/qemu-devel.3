Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CDECA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPTI-0005uc-Tq; Wed, 27 Aug 2025 19:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPT1-0004cI-4a
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:14 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSt-0004Km-1y
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:10 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7704f3c4708so474047b3a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336919; x=1756941719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wIvTYAiiT1df2UjL/R0r+8svJREkoZn9cbNcggG3h4=;
 b=HojCeI0MuecbDE6qd6umXxZ0SkeaIPxbnvdQg6I+obvIQkoimsvbKUVBoq9kBNtSS4
 F4PIuNJp2HPOyn8H7hNNqQXAKMll+50bOdOeK/QPL8+XsWbTlSFpekTflYxIzSGcbspf
 c2pfjK1j2OLmpF+6hH3H4KvcBwgDhAOf7rzZyxsGM1FnaXPfDK2a9p42xYarBrTkfbX3
 7wEG6ZKfo3DZCWe2Xtwg1/wuiI0qq6gDQ65jYG1NcYezxRVU4HJNs7DZHg2TiIB6UeC6
 tybbWMR6KN7rRrIlRh5G0DIgOnETNYjh4HKcRcU617N/AB0opZJB821yDD1yPIuvPSef
 H38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336919; x=1756941719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wIvTYAiiT1df2UjL/R0r+8svJREkoZn9cbNcggG3h4=;
 b=OXX5QFgScTGMjCTLSs3rzMqqzBRZpJqF7wbrXGKDjfzzFpHseLpKF1IQ8Lj7L8Wvxf
 /75yCNglkZsEoiGC8/f1RfK8drbrB2QY7xKdDm+6WU+Dfefqn/sH2v4kr5Kir1b8Lrik
 BEInc4p+pt1G4tX7iMq0Uqk/jd1ok2L6yg0kXNabJvwQNwTJOwTX+oSC2E8UeGg7fRSf
 PQC9GU8skJ/U6w2ke4AgTSXYkup6vgqa2slVhcVUfPXzTcm3S1ZGi7S/oZdMf4a03eJd
 yBdCjUiVvuDZGXWMzKZu/1KJsG/EbAu/wEuPJEOTEWPJ2W+NcRL2csFdUFTE12jWPrzJ
 AH0A==
X-Gm-Message-State: AOJu0YxRQsktbIK8PhGoA/T2+6oshFgj0Uiqu4Ww+QsFrGGYLU02D93v
 ND9uPoZ6GZC2GsDl9J0rvhcQZ1aTuW2TEwf0IpE1YXn2Zq2mFQ95o5FOsSm3/nB//D6pl3M+7SJ
 jD77od2Q=
X-Gm-Gg: ASbGncs/nlXUJUiLtnamN1Vj+IZeL/ABt7sf61YEuPfHeCA95E8QNN63omyJOgLTTOC
 PihPJ4PuJ5LvFNvptZNrq4TU27qgjatROB6LoY5+Z7xavM39yZc3ZmbWSkMZ2TY2LhxpTNGyFYI
 qnUm3SOgawqEkMtlfHTxjkPkz2gYbpwpFJPAvEtpdVNnk3oUAmI8/JAuR3pRubsYs+8bz0Bujoa
 51EdWSvPL7BtJMUzeaPe5GinlJV7COGKaxFQ1CYUaLTA+JdjQSafiYI89GbVZEWGdvRgbiZnB3S
 Zy6gHVySdENupjrO7zdU6bCaCJ11TtGZDPwpbpY6Qdmi8oTINbPq6L9ysFjsC19G3fUSfZDWRVq
 o1+ZE7Ew0laEBcnquS2/bV82CDXbvVxB6vNoC
X-Google-Smtp-Source: AGHT+IHsLyBRq2Lvuy/t/MxOiKWKDoEO7O4+VLRFXcJlX1DdW+ScKTDjv+ctRYIYm+MIurI3umdqLg==
X-Received: by 2002:a05:6a00:88e:b0:772:8fd:d512 with SMTP id
 d2e1a72fcca58-77208fddca9mr5494296b3a.2.1756336919018; 
 Wed, 27 Aug 2025 16:21:59 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:21:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 32/46] linux-user/loongarch64: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:09 +1000
Message-ID: <20250827232023.50398-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Note that init_thread had set crmd in target_pt_regs, but
target_cpu_copy_regs did not copy to env.  This turns out to be
ok because loongarch_cpu_reset_hold initializes CRMD properly.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c              |  9 +--------
 linux-user/loongarch64/cpu_loop.c | 11 ++++-------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a30431c7a2..0feccfbe91 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -533,14 +533,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
 
 #define VDSO_HEADER "vdso.c.inc"
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    /*Set crmd PG,DA = 1,0 */
-    regs->csr.crmd = 2 << 3;
-    regs->csr.era = infop->entry;
-    regs->regs[3] = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/loongarch/include/asm/elf.h */
 #define ELF_NREG 45
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index ec8a06c88c..a0a4cbb7cc 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -120,13 +120,10 @@ void cpu_loop(CPULoongArchState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
-
-    for (i = 0; i < 32; i++) {
-        env->gpr[i] = regs->regs[i];
-    }
-    env->pc = regs->csr.era;
+    CPUArchState *env = cpu_env(cs);
 
+    env->pc = info->entry;
+    env->gpr[3] = info->start_stack;
 }
-- 
2.43.0


