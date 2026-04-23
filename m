Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F548F99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqxL-0004VW-Hk; Thu, 23 Apr 2026 06:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqxH-00047C-4y
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:06:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqxB-0003zL-U0
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:06:42 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891f625344so49228855e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938796; x=1777543596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7UoOF+gsk2QgBCVNoHyjKQDd0TRiUYFAye9erOTBjMs=;
 b=UYO7C0JMtsgPT5MsWGX68Znlf/Qx02xV/HbLqDnXrZUhbkszo9DzIom5KVDm/4PbuQ
 OEQOQTr16qUYpl78DGq5RhUpqAZ0izTRz3RPdvWm7MqRtXKx8sr/ySt4upNSbh6G5CGQ
 cBqyg5i5tbUq6eXuD29Db2R+bCjgVtSrklor9lK4+wooQZRkx5YsqLENPXbePpug4DQX
 jK6e+/20q9YeOk33SklyMbKQrqa1zqQqAQU3sfQzCpDY7/mNHuMvIafQDhKhI6pioujV
 NEwg5opUoTbbBQsuZMg71toikshxJV7tAI/I1IG5o9BsqeT9ZUCDnZG3/UELQHcnNwUm
 EmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938796; x=1777543596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7UoOF+gsk2QgBCVNoHyjKQDd0TRiUYFAye9erOTBjMs=;
 b=P42QPnOBatfblpBOYOpArvAa7U+J0cvSUGpqKcuCaagi55D4UpFHTY2w8gdnP57qJK
 QIhSA+tL0Pod3AQZdfmA3A0U05Jsq1GBsAzoJU3OUQ27u1k4JQ+RRHhDmGfM/oLG4Pqd
 HOe746YvTeQHtIIEA7jyyELq+QdnDLP5Qzyzyh1VzQZBx6sWHTqTRNtxld4L2LX7sUb1
 9zGn61mFhXOSQVuNj3DCYewPfXuee2NNFacoLtxcN0anWIO4s2s0ZvaHVKWgjVoBRzGC
 nhYVveb6bjTm6aX5TVmuGSLYBKbohg71PsyeZVfeQI1OJ34hPPoy44/jczn8EbIGEh0I
 lAFg==
X-Gm-Message-State: AOJu0Yxnqvy8q4t/pVHI7ClOPNri0nFHPXPmar3429io85U/6Dd74ug6
 eU3ewNJarw9aMtngjWZNHj4dnAWVGuJZ1bHn64SK65z+Vaq9BTI4Na7HkZA1YujX20W7LQAxhZK
 yfs1Wh50=
X-Gm-Gg: AeBDiesN+mHR75TQ0/ZWNHPS5mj5Jv0kM5psL1janeSdF2/sCfibetMrcazW/5pOaCo
 hkLEj/zi4es3kqDDKcHAokqP7cWignk/1cLf++fXszeEIL3AB25BRahuLvnTvQXYandPyOMbP06
 vZwJ3rd7PR8j2B4a30uFKLyDei9l2WpqWaQ0Oc0WA9apXFOEgsLocQRYuNQuIBd+stVW6sj8YpH
 jy8GQ72AanFDhMuBnqVzX1vexDZFbcMV0uo9Bbkz21X6UUAtdw/agn2Frryw2ZD4alSlzvKBxge
 9gmOPrAA4lcdNKCSJvxCqd8clJgacpZiksC7iY9ZGwBYRNjZLj36kDdTdkUWekgN1WYcMtd557A
 Phsl7rEZQRzhysd7eCATzFvnSRh3Rx+THkrAKlQgohF6JL6BI8P9XCsdB0Fva2MQVabl5I/XHfb
 VrMFmGW8MFsyM5iBqmgLeDB/t/7NQGPAjp90f03jyg6axAWjP5S98Tbd2qO4V7+IwVuTTIE7nDw
 XV8tFUpwj0=
X-Received: by 2002:a05:600c:19d3:b0:48a:55ec:c007 with SMTP id
 5b1f17b1804b1-48a55ecc113mr138275795e9.15.1776938795795; 
 Thu, 23 Apr 2026 03:06:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a52583fe7sm217129115e9.13.2026.04.23.03.06.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 03:06:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/9] target/microblaze: Replace translator_ldl_swap() ->
 translator_ldl_end()
Date: Thu, 23 Apr 2026 12:06:06 +0200
Message-ID: <20260423100612.27278-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423100612.27278-1-philmd@linaro.org>
References: <20260423100612.27278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

In preparation of removing the translator_ld[uw,l,q]() methods,
inline them for the microblaze targets, using mo_endian(ctx) --
which we introduced in commit 2c9e8ddd7699 -- instead of MO_TE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/cpu.h       | 7 -------
 target/microblaze/translate.c | 4 ++--
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 5765786e6dc..ad5a4a8e7bf 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -412,13 +412,6 @@ void mb_translate_code(CPUState *cs, TranslationBlock *tb,
 /* Ensure there is no overlap between the two masks. */
 QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
 
-static inline bool mb_cpu_is_big_endian(CPUState *cs)
-{
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-
-    return !cpu->cfg.endi;
-}
-
 #if !defined(CONFIG_USER_ONLY)
 bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                      MMUAccessType access_type, int mmu_idx,
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 5e8bb4ed77b..af6a30b7760 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1646,8 +1646,8 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     dc->tb_flags_to_set = 0;
 
-    ir = translator_ldl_swap(cpu_env(cs), &dc->base, dc->base.pc_next,
-                             mb_cpu_is_big_endian(cs) != TARGET_BIG_ENDIAN);
+    ir = translator_lduw_end(cpu_env(cs), &dc->base, dc->base.pc_next,
+                             mo_endian(dc));
     if (!decode(dc, ir)) {
         trap_illegal(dc, true);
     }
-- 
2.53.0


