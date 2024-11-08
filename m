Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156FCD5C0F1
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9RAa-0006jy-2M; Fri, 08 Nov 2024 10:45:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9RA1-0005ZZ-91
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:44:34 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R9z-0005hI-GA
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:44:32 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d43a9bc03so1592688f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731080669; x=1731685469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZt7LLYaGK4gLd7N4XPj6yKOClYWTX3p+vA4olh24GE=;
 b=S9jWg/eNnVWpra7kLz+hDJCIcNCA6qZe0wMZXK1WrDZMiWaeixpscavNpmJQ143Cv1
 mhOBnXfsxl/25i+Ph1Jete7Tof05lQvqrHQT4I92vVVK4Cfnn3bLU28x7dOT/rRHK/fq
 LRgYoDbIy//szUJPgtOSk6ckRNAhuTJ2u1j049Y2/GYN1EExP21tpV+1/6u93th3rWhp
 A0DidWMVEACNYRVNeWxLV+Kkj2V+LXqpSsNjv/9RJD+vRcixunNW9ilD8ajpW2LIyYkG
 ywbltn+SBJdYru81jwqV3hGi5yvraXpYl7mLFzCk7YK/XRO4cybMoufkUoJXoXniQTB+
 0AcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080669; x=1731685469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZt7LLYaGK4gLd7N4XPj6yKOClYWTX3p+vA4olh24GE=;
 b=P0yhP/wkxUFTqt5NmR+G8Tf11HGq+xXYFEvGT5o5rtxfuFRlEDP7OlFrqUhOwclOkZ
 QM0vVAGAnHnI7sdjNeJx+8AH8Z6Si7oIIbzKyrhEB25tUTcgAFnl2equtdG0+fOkOvI3
 cnxIYYL9MwodTOG5ownxggPlD5Sv8qsgWJVV9fawEPXpSrXIiKARW67Q1SM9eFZUk6M2
 v7X2Akq0KQhVdMRAahQXOAagksLYGDVWpig/7nS9JZijfc8LIUvHfHRgTs6IKDtQeIvS
 Ve3rhEiYtwhQLzet6xjiflbXNVgnbhcGKKTVdYwLJv1PLl9ezHelEsgoan/Us7elXxor
 XQ1A==
X-Gm-Message-State: AOJu0YxpGLwAONOy3BZ3RgwqUFIRZubjTsm2ahOlG5PaMUzk0ncTMABL
 eoHM+ZlOz1iNTR5GkWpk3EJxPaXAM/6nhW62En7tSMh1Dc3TfpigstL/qJAzUd8g6epNqAfJEBV
 z
X-Google-Smtp-Source: AGHT+IEHI5h3XsffnKUeY8YXQP+sHrMubWc20BUSml0N5bJw1VD7eBUobRAX4ssgnj3+YA7f0xhYzw==
X-Received: by 2002:a5d:59c3:0:b0:37d:37b2:385d with SMTP id
 ffacd0b85a97d-381f186319fmr2860087f8f.12.1731080668871; 
 Fri, 08 Nov 2024 07:44:28 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed99681csm5368641f8f.49.2024.11.08.07.44.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Nov 2024 07:44:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 14/17] target/microblaze: Consider endianness while
 translating code
Date: Fri,  8 Nov 2024 15:43:14 +0000
Message-ID: <20241108154317.12129-15-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154317.12129-1-philmd@linaro.org>
References: <20241108154317.12129-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Consider the CPU ENDI bit, swap instructions when the CPU
endianness doesn't match the binary one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       | 7 +++++++
 target/microblaze/translate.c | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 3e5a3e5c60..6d540713eb 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -412,6 +412,13 @@ void mb_tcg_init(void);
 /* Ensure there is no overlap between the two masks. */
 QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
 
+static inline bool mb_cpu_is_big_endian(CPUState *cs)
+{
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+
+    return !cpu->cfg.endi;
+}
+
 static inline void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 0b466db694..5595ae4fad 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -709,7 +709,7 @@ static void record_unaligned_ess(DisasContext *dc, int rd,
 
 static inline MemOp mo_endian(DisasContext *dc)
 {
-    return MO_TE;
+    return dc->cfg->endi ? MO_LE : MO_BE;
 }
 
 static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
@@ -1646,7 +1646,8 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     dc->tb_flags_to_set = 0;
 
-    ir = translator_ldl(cpu_env(cs), &dc->base, dc->base.pc_next);
+    ir = translator_ldl_swap(cpu_env(cs), &dc->base, dc->base.pc_next,
+                             mb_cpu_is_big_endian(cs) != TARGET_BIG_ENDIAN);
     if (!decode(dc, ir)) {
         trap_illegal(dc, true);
     }
-- 
2.45.2


