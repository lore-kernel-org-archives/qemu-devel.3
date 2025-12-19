Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3025D7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdUJ-0003hV-1S; Fri, 19 Dec 2025 11:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdU3-0003cK-2E
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:37:39 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdU0-0000Vj-UK
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:37:38 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso17667285e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766162255; x=1766767055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvU8IjxyyWGbnt0TpIestxRQYownf9I7RuEDkGDxUZg=;
 b=FviF48zk64weObPMn1tKb0LLuymJjlpZOOSxPKE4Mt9NHePiYx8FtIQ9oVwcV13ki9
 4mBMAPLBmG96T4Ly0pcCDYt5vVKBwIiBBuGR89ft5eo5WTyZNTbg8P3PKaRTqGXYie5x
 a7Z3+KWQcVIeo7l0EvmwfmgK3Ap0pQOAL7bd+iSZavHRdxxLLghVtdHjEHXmc7Py9r72
 EOATK9pBUm6AQaz5lP2iz1etkidIIym5MkzHva6AdI/Z2wYSe9kz9/eI2g63hNFXJNkJ
 LBcA1qR/cSHei2GfNHiRtLkJIRKtkSGWg7CcTY+6yIG6M6aUXjy2Wkgesd5H5RleHryO
 856Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766162255; x=1766767055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gvU8IjxyyWGbnt0TpIestxRQYownf9I7RuEDkGDxUZg=;
 b=AIvyIxwLmfQwQrhq2psW9Gl+tMfPWU+iLoDx1fJ0DhG966jlws/MKSCy7zuaSecrix
 9SL86OhJjhZv7AYzetHsfx6Lqk7pqTAbumWUcuxfVU2vRCKhfZs4YcPgMlv1maDL4/gw
 9CyMCO6GZdyMLdZF7l1vvRvyCkMQTa790yPKnUa3g+Vp+Axk0L+58f3hAQyTx4a67QwT
 9uJwuWP+4QsLEsT/WYhr9JaTy77T4/8WTiqaMxtviyi8HNW79U4V7JGnG4qcThRlj4T/
 rOk8E10q9rP5NEcBOYUB2Mh2Yab2auMtW8KJz5yjuvzRs5j98f1Dn7zLgHNVpFvVYDaR
 wbSg==
X-Gm-Message-State: AOJu0Yzbdfr7pz8PXM+pJzNWSozU8OLetf90L/dKyoRMpKtbnec1VCjp
 KF1EoPzJIKAt6thhwbLbyx0PA0bwuS4bKvTFUFiLQ3NMzehNdTRf1hIua9z+TBTXKoNQ2j+dPm9
 xhRT+yac=
X-Gm-Gg: AY/fxX7aRjiRGED7SiRcMnyLaV7apKjkWqSXHKzsZq/y4hbrqasF0PZxjB/JxaZH9MR
 ZzPpGyzVJrQpE/tNE6CUcPQe9vgq+mmH2GoTnwKaepa/KriuWVZ8MSq9ZYEcC8kNYewIOr6/pLP
 VUDbgiCBvRijx7CJ6XXJhHclKEmFoMINQlFWbnWYi+CF1pX1sQs1YBQh02roscEF19ckqughiTG
 +m4i1upriNcRLy9YoaplFH2kwhL0/uMp3T0QaSJGLeW+a7WXNAa8/ClD/uY+tEa03iWhrD6du4Q
 VHSzT4bqC65oPPzedytFpu/KhiKwlf35uWq32/QMqfx4kW15h3b1aD0J/J0G8qAwQS6Z/bHDnaq
 U6ee25SZzkBqcS8SJ2+zW+6R9GT6Op1RpfhpwnLABYHCNvZ1ucQENAi1U+9RlbH2QOnD2Tllmpm
 hRaBqNtotx5BAoroMkCwp6vSYXK7agDVnUwiXInIbmPEHGzr0T6fj6KGjDJS6Z49pJAO8fORY=
X-Google-Smtp-Source: AGHT+IFJFYK2I28ZaGAcicQ6d93jyoU5+SdGerlfByXSHGE7xscJVttx8WMqXH4AoyycDRQ/fTjW1Q==
X-Received: by 2002:a05:600c:3b0e:b0:477:b0b9:3129 with SMTP id
 5b1f17b1804b1-47d1955b7d1mr30755685e9.3.1766162255139; 
 Fri, 19 Dec 2025 08:37:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a6c6ebsm40481015e9.4.2025.12.19.08.37.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:37:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/9] target/sparc: Inline translator_ldl()
Date: Fri, 19 Dec 2025 17:36:46 +0100
Message-ID: <20251219163650.74303-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219163650.74303-1-philmd@linaro.org>
References: <20251219163650.74303-1-philmd@linaro.org>
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

translator_ldl() is defined in "exec/translator.h" as:

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> MO_BE
since we only build the SPARC targets as big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 23079697f52..57b50ff8b9a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5743,7 +5743,7 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     unsigned int insn;
 
-    insn = translator_ldl(cpu_env(cs), &dc->base, dc->pc);
+    insn = translator_ldl_end(cpu_env(cs), &dc->base, dc->pc, MO_BE);
     dc->base.pc_next += 4;
 
     if (!decode(dc, insn)) {
-- 
2.52.0


