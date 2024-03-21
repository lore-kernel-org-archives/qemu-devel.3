Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7539ACD11C2
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKgp-0000Um-U0; Thu, 21 Mar 2024 11:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKgj-0000Hd-O2
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:50:41 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKgf-00025C-Ut
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:50:40 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a4707502aafso204994466b.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036236; x=1711641036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3j55vDhtvgXvqb+wl9u2AW0u4cGKkyngFQ2jp+MBRmU=;
 b=en8F9YfVAR5zJfwlRf6vkTDvTDCov1zpNGD37XpiLrHoGTBZcSSMXgegF9trq9NjrO
 a5d13c6sIEN1pUkcHvSTmaoipJ/cC40n++c8rIaj7l9b0v94xr0GHfY1iWsKX+dwd8mj
 HEqeVfBD18c86P/eGGX6JnwKrenP6uh3bEXougSc5EfxV1z6Epp1E/4/+aE7EEMfQyrt
 ih+f26vdxEAvPlKWYRJMKRXCBypC6DA+UTHu2KxAUltw0T4Jmt7YbA1VOnfXME1NKA6e
 WqX7eu7CcAN56JXfkE462k2W79QINbO5CNiAG7Eg2zibbvHCN9QpNsQrNr+FC183guc/
 4Exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036236; x=1711641036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3j55vDhtvgXvqb+wl9u2AW0u4cGKkyngFQ2jp+MBRmU=;
 b=gyCEZWbyzJ+c4ddUVvG8X9Xg7u1piCBCD5koZdcODF6tbLg4ZbbP9SrwUuOBMOTS/5
 Kzc+V3L/p3PkPt+DpF0y9fjmiIH6bpb5MZJs4iMh+Mue98FZlleRFht4zR5qoCaLiFWu
 3Vd/jjIyzyGSZuzxmwwo+SZ5tteVEi4GXh7aoRa0ZQapfQ0bfRPcECv+5RXvlOXk29HG
 R1z2reEhMB3OzbEyH6mE5/cmx4bHPPjdWP/mn0P0V8HXQpgNK88sqtMa0tJBTJFvoFS2
 J+JoKxxGLTIQnjx78T99ljocf/P6KwBkr895hIXt3JH3tpiNO3k0LGGNn8UOMjbi/kYE
 RNCw==
X-Gm-Message-State: AOJu0YyF0ODRg+pJ42kvlZPLNGBob1ZtunNHjvAgKYmH7/lQWrn3DU7L
 3V5EVg9VPo8vdt+EXjNG+46Y8HUADbTAPB84bHkNVvnp6+it2TyiAX+6yZYSuZ2pxnaZrjkqrwd
 8w9g=
X-Google-Smtp-Source: AGHT+IFRSRO+fdMOTgprlXH0Zd9WRAFvm//y4djnsbaR2xZxibyh6sIRkiLEm5NXNehMk0OBzI8ynw==
X-Received: by 2002:a17:906:a48:b0:a46:2b8b:e381 with SMTP id
 x8-20020a1709060a4800b00a462b8be381mr2607800ejf.8.1711036235960; 
 Thu, 21 Mar 2024 08:50:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 c14-20020a170906340e00b00a46baa4723asm48238ejb.119.2024.03.21.08.50.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:50:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0? 15/21] target/sparc: Fix string format errors when
 DEBUG_MMU is defined
Date: Thu, 21 Mar 2024 16:48:31 +0100
Message-ID: <20240321154838.95771-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Fix when building with DEBUG_MMU:

  target/sparc/ldst_helper.c:245:72: error: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Werror,-Wformat]
                    DPRINTF_MMU("auto demap entry [%d] %lx->%lx\n", i, vaddr,
                                                       ~~~             ^~~~~
                                                       %llx
  target/sparc/ldst_helper.c:1736:60: error: no member named 'immuregs' in 'struct CPUArchState'
                              PRIx64 "\n", reg, oldreg, env->immuregs[reg]);
                                                        ~~~  ^
  target/sparc/ldst_helper.c:1820:60: error: no member named 'dmmuregs' in 'struct CPUArchState'
                              PRIx64 "\n", reg, oldreg, env->dmmuregs[reg]);
                                                        ~~~  ^

Fixes: 96df2bc99f ("target-sparc: use SparcV9MMU type for sparc64 I/D-MMUs")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/ldst_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index e581bb42ac..064390d1d4 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -242,8 +242,8 @@ static void replace_tlb_1bit_lru(SparcTLBEntry *tlb,
                 if (new_vaddr == vaddr
                     || (new_vaddr < vaddr + size
                         && vaddr < new_vaddr + new_size)) {
-                    DPRINTF_MMU("auto demap entry [%d] %lx->%lx\n", i, vaddr,
-                                new_vaddr);
+                    DPRINTF_MMU("auto demap entry [%d] %"PRIx64"->%"PRIx64"\n",
+                                i, vaddr, new_vaddr);
                     replace_tlb_entry(&tlb[i], tlb_tag, tlb_tte, env1);
                     return;
                 }
@@ -1733,7 +1733,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
 
             if (oldreg != env->immu.mmuregs[reg]) {
                 DPRINTF_MMU("immu change reg[%d]: 0x%016" PRIx64 " -> 0x%016"
-                            PRIx64 "\n", reg, oldreg, env->immuregs[reg]);
+                            PRIx64 "\n", reg, oldreg, env->immu.mmuregs[reg]);
             }
 #ifdef DEBUG_MMU
             dump_mmu(env);
@@ -1817,7 +1817,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
 
             if (oldreg != env->dmmu.mmuregs[reg]) {
                 DPRINTF_MMU("dmmu change reg[%d]: 0x%016" PRIx64 " -> 0x%016"
-                            PRIx64 "\n", reg, oldreg, env->dmmuregs[reg]);
+                            PRIx64 "\n", reg, oldreg, env->dmmu.mmuregs[reg]);
             }
 #ifdef DEBUG_MMU
             dump_mmu(env);
-- 
2.41.0


