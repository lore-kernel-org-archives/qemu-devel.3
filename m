Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5479EE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagzP-00023n-1T; Tue, 30 Dec 2025 16:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagz1-0001YL-LS
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:27 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagyx-0002do-Mc
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:23 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so1826732f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767129011; x=1767733811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ez5vl1EDt9mc2+b7pnNLOdCCl7mfnkJCH+Oj1B88Eho=;
 b=gxNs5wnQXvndYyx1CRPWSmFWJW2d9WDWZu5kO+dH7485Sj1SrVSr53ONcdgsDrWg8u
 ukhLA/eLDZ4ZWRi/df2mHTsCGdRcdXUOctvDdOtvSPQ8d3bKji+n4OOTPu8O5GWZv3LH
 xVGUY0pG6kIVOSGksBH7HkU/9oAxyNDwu2GG8uIEirONH5qAO0Kn9+ak2rvvknC9ptMH
 tl5Aqcdj2NwJtjl1f8YHUW9h76oPXayu3FA5ZSPcsJDWrTTpHNrsEODJWCuEnGJDWywZ
 Dys0Oc6JriT8rzWOAoVajIwwUyTqM5Zqk5MIQE/gvOVHgT1sDOgyQZY/qOlI3ekQAPyW
 NvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767129011; x=1767733811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ez5vl1EDt9mc2+b7pnNLOdCCl7mfnkJCH+Oj1B88Eho=;
 b=o1NxzjPLfxqK2oeoAFv9UaJXdC8ToKyjihlVvGTFh8VkxUvpgpW5F0lLg+nNe2ySUJ
 UwGrePhJVtblt70gcxS0q0w9aeR6xdV9N6+rU4983CTGOBuCitCrpkwRg/Vf2meUp/+T
 60cUr3/P2ccGU1yjgUo4olqjekJbw467NN1AW7koJD7UiJ6AZru+Le2XPHUOinRyBMOL
 F7bjjS7l1LwVWSBCqPX2DQFyJsg8pu2WYM9yyaZoc7O6KJIu5yrYW1JmbMeKHTUfZFGJ
 z/XhQZDcNZA/A+E0JDcEbekwN36sqS4a+tCS66WixoKDun2apU1pa8op7TclwACuvi7s
 0Tpw==
X-Gm-Message-State: AOJu0YxKIlIiAl2jaT2U/GVujGv6Jv5WouzJHpcpbQ5a84VS5XmpsWKb
 Agfe7Qlsry+ni3ArAgLKqfVcbO+yISip+zkKXvmprriww+2yChgz42y3p1ImAA6ozMtuuwxew3D
 DI1wv+lY=
X-Gm-Gg: AY/fxX4i4deXIF49FcWxAy7mrkDq1LqbqqOx5jvdQnXrnOw6f8ZVTPipasPPgiP6rxO
 cKKvqvqP89Xt7LZP0e4mBYm4IvGjadLqkhHIPGVS/z2w3F3cg9xGKS2rpYcE5q26GisCgxtRC8W
 soow4PABD57XVfKzzvZO6YFBBGxBkkIl9QIH6U7RMHpzi5rXwAAx5Kb5r8nmP7WV9S2ATVQo5Gx
 wWvDnuwfGwRIbjGGFSBx/kKWs999+Qk0ZIhrsQt/pq5PmXyIhqH7uYUW/kH78RXUeKpLYAiXByU
 OJFwGYdkEoiCgBUJn9AZwtO0K2EYtJMZ4245HK7EhmGMNjITiwAZ5fUFrnOEel4sYLPsJcY9KSy
 K9UBTpnegPOl+qFgbdIWOKSlzteh0qh0bSOhYV9WM0yMpOoUJKcWSJ3JUClOARZ861ryPgJeBBM
 CkkmBuFkrJhNXHlDMrZre8yro+VKww8ZTsQzgWuo5OrHdZfdlBP6HON7C4ymfm
X-Google-Smtp-Source: AGHT+IGdbImKySSFSy26RTdWD4TFW08Rc8ls5wCRlARa/EnjFxAZFdsozHCT5bPHccabWIejRmOD2A==
X-Received: by 2002:a05:6000:420c:b0:430:fbe1:3822 with SMTP id
 ffacd0b85a97d-4324e511811mr51141720f8f.54.1767129011323; 
 Tue, 30 Dec 2025 13:10:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea8311fsm70773019f8f.28.2025.12.30.13.10.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:10:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/34] target/i386: Remove x86_stl_phys_notdirty() leftover
Date: Tue, 30 Dec 2025 22:07:42 +0100
Message-ID: <20251230210757.13803-21-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Last use of x86_stl_phys_notdirty() was removed in commit 4a1e9d4d11c
("target/i386: Use atomic operations for pte updates"), let's remove.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20251224151351.86733-2-philmd@linaro.org>
---
 target/i386/cpu.h    |  1 -
 target/i386/helper.c | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 41ea04099b2..2bbc977d908 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2756,7 +2756,6 @@ uint32_t x86_lduw_phys(CPUState *cs, hwaddr addr);
 uint32_t x86_ldl_phys(CPUState *cs, hwaddr addr);
 uint64_t x86_ldq_phys(CPUState *cs, hwaddr addr);
 void x86_stb_phys(CPUState *cs, hwaddr addr, uint8_t val);
-void x86_stl_phys_notdirty(CPUState *cs, hwaddr addr, uint32_t val);
 void x86_stw_phys(CPUState *cs, hwaddr addr, uint32_t val);
 void x86_stl_phys(CPUState *cs, hwaddr addr, uint32_t val);
 void x86_stq_phys(CPUState *cs, hwaddr addr, uint64_t val);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 3f179c6c11f..f9f9488eb4d 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -702,16 +702,6 @@ void x86_stb_phys(CPUState *cs, hwaddr addr, uint8_t val)
     address_space_stb(as, addr, val, attrs, NULL);
 }
 
-void x86_stl_phys_notdirty(CPUState *cs, hwaddr addr, uint32_t val)
-{
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-    MemTxAttrs attrs = cpu_get_mem_attrs(env);
-    AddressSpace *as = cpu_addressspace(cs, attrs);
-
-    address_space_stl_notdirty(as, addr, val, attrs, NULL);
-}
-
 void x86_stw_phys(CPUState *cs, hwaddr addr, uint32_t val)
 {
     X86CPU *cpu = X86_CPU(cs);
-- 
2.52.0


