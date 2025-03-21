Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FD0C36001
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 12:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvbwb-0007iT-Us; Fri, 21 Mar 2025 08:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvbwa-0007i8-65
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:57:48 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvbwY-000308-IL
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:57:47 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso1737629f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 05:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742561864; x=1743166664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6p8JdnoFtJMlt94AcQnrnXDcS8L2LbxvHkgDYqG268g=;
 b=LWryqueI8+Qco2XyrFhie4QDTBpTMVX7BdCCVCbwdI3XMrjsInuXZzJL7rLi5n97kr
 ZpvB/hYqARFyrQsdoG1g91TrlHMD7atWLa33wdk7OOZpu03h9whBe62i229rfWA7cYHG
 UFkd7XrEmB8ZIA3eQtQ/HQfozMwtQFF520jcH06CBqgOPTPmvzhjuos7UyuFflzIM4j4
 5Z9EUL0rPs2DQtMaVD0InnKqcpmjKMBJHMz6kedbzmUvKHkrp7khbs9OUxea+pa+2SSL
 9Jd7MMOGJkisbv0ROra+KcbO7Baj9FsD1tK6pCC4CX4Fc3nDWHzSl6WraiT7//1aF2dK
 kwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742561864; x=1743166664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6p8JdnoFtJMlt94AcQnrnXDcS8L2LbxvHkgDYqG268g=;
 b=t4PAwWrxbqq7eAKXscDWh6OA2p+65eUQMRyLr/DlahnKwq+u6tw+vcHYN0u0VBBZ5u
 KNEnYYiz3Twc34MDaUg/W4PKX4WC6+6+x3EjxA8zBfKHqIAOo97dAlmtwnX0FlEQTVW5
 iFtVto+ClnFJrLV25tcLPYb+vsg3fLblZXL5qsDpBV4MySUVyy+PtKJssvQBPaoNS1zl
 d2jrdfRzaQefNF8wLiG747DiCi9PxbnmnxRhzdpHcUuH/WYlkR49RY4u7TkpiAQI9I48
 PWwaJUQj5W/gHq3UDXz0JN9NThB4o+div+G1pW+J8sbAAqRQj35uRFPb4KNe6piOjDbQ
 S1Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWxyPVq+g9hotZKxqzIZp6gwunD/OQs5Mjit/dh/CwtwpA0YwjB/MpCCOholVjgrinCJchw98VMVwt@nongnu.org
X-Gm-Message-State: AOJu0YwlqZ+9wgwcAMv0qBYfsQScxGfP1lqTU43OT03Rf/IfGC7oRGxX
 vL/z+9F5m/+HYNN/EtcskunNGQcawJtrkWCh7lkeySDbxvnaDZJqMZshsdeCGr0=
X-Gm-Gg: ASbGncv/RJtvpUV/5fbDZo5qKp936ibMEQBecfjftrEiPU66rEAsd/AYEpMqDZ8zsxa
 h1IpMtug9qvtccrQuPS/gfejavPz6pOAL/nMJ0gp6EuUAXrfQAUV6WJHulkbWrjGaqy2fKd/ttA
 DtkzXg3GUcc11jW/23NpPtg3oy0D9YYXWz+4sFL4oqIhJx3MDpRnj93fS0e7QP0KQxnywp69WEj
 mw8owaspVoOwpf3mm+BMbVK+W3Rf3Nt/wEoteEWhs6Bjk1+fkC+99ygkrpNUgT0usLQDPRXo4Wd
 nxPrequmi3bq3rxpbHp2gyPahf8skCeFCSuwn3yJUr9sggoNWhc0yKAyieaUmKotrjHU9ZQ+tx8
 Xw4KEyZuNwf6MNSW4zeGjg0AB4yzj7g==
X-Google-Smtp-Source: AGHT+IFUQBMp+w2nFZsDKxK0B7nhXJc9Pl4IzFUkoVKyQvFcs0Mvyc3jNpgcCF6ai2dyRtVsSeH4Ug==
X-Received: by 2002:a05:6000:21c2:b0:399:6d53:68d9 with SMTP id
 ffacd0b85a97d-3997f939949mr2323472f8f.38.1742561864432; 
 Fri, 21 Mar 2025 05:57:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6445sm2306470f8f.71.2025.03.21.05.57.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 05:57:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 1/4] tcg: Always define TCG_GUEST_DEFAULT_MO
Date: Fri, 21 Mar 2025 13:57:34 +0100
Message-ID: <20250321125737.72839-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321125737.72839-1-philmd@linaro.org>
References: <20250321125737.72839-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

We only require the TCG_GUEST_DEFAULT_MO for MTTCG-enabled
frontends, otherwise we use a default value of TCG_MO_ALL.

In order to simplify, require the definition for all targets,
defining it for hexagon, m68k, rx, sh4 and tricore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/cpu-param.h | 3 +++
 target/m68k/cpu-param.h    | 3 +++
 target/rx/cpu-param.h      | 3 +++
 target/sh4/cpu-param.h     | 3 +++
 target/tricore/cpu-param.h | 3 +++
 accel/tcg/translate-all.c  | 4 ----
 6 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 45ee7b46409..2d57ea6caf9 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -23,4 +23,7 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 36
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 7afbf6d302d..1a909eaa13e 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -17,4 +17,7 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index ef1970a09e9..2ce199164d7 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -24,4 +24,7 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index 2b6e11dd0ac..1bc90d4695e 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -16,4 +16,7 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index 790242ef3d2..923459370cc 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -12,4 +12,7 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+/* MTTCG not yet supported: require strict ordering */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 82bc16bd535..fb9f83dbba3 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -349,11 +349,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
-#ifdef TCG_GUEST_DEFAULT_MO
     tcg_ctx->guest_mo = TCG_GUEST_DEFAULT_MO;
-#else
-    tcg_ctx->guest_mo = TCG_MO_ALL;
-#endif
 
  restart_translate:
     trace_translate_block(tb, pc, tb->tc.ptr);
-- 
2.47.1


