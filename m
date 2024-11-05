Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14063D2B920
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JHG-0007AR-F4; Tue, 05 Nov 2024 08:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JHB-0006pf-8s
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:07:17 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JH8-0002hK-BS
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:07:17 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so3136879f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730812032; x=1731416832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3QZDoqX/9aQeCd67Fxf+7IHrX4YKBlVMoYZ3cKr6J0=;
 b=Fx5T+/Nfvkrkjz42mbrGdXsM6lQSdqc0jzTPq0wGMUEIg9Y8Y/iznyv/zwGDS9n0WK
 Z07GZDuHebljE2j1DGrHJOSsUMb/rYeJrvC81OyksckFK4KkImv2E6nY/7K8uoV3bbg8
 PIa4Cv6qOyCCUC6SvOqPfYGL5h3zLLPyIRISQ8pzbohcDCQTcuRcizqp29hMr/x6cXZL
 dJTsO9v3k7oUDI5miUoDynv5XgMVWKfjGSVlIW0E3s+S8ZZwgTlop7htROrJfvm1fRw5
 bGMHJGDyfQUfy5nqcG/yTf8Rx+IUQLJPVzu0b95LbI/8yO5+6TFLM99cPaK9BHlwBnbY
 ozmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730812032; x=1731416832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3QZDoqX/9aQeCd67Fxf+7IHrX4YKBlVMoYZ3cKr6J0=;
 b=lYyZMVVlQjK5ixK80JGi4lm36viQTR8ZqR+Lzk+B5eMhGQuRHYx9KT5z7i3sHGNsyC
 /RvuRzycXTE4d+1qj/6GHVknMgToSjnSvIfhChNyXpiB+TPUoxsD3lWzCFqvwJd2EAs2
 /ykRb6x9TdYMAmOiY0JFpE2SPiTu0mlsKMU1eCXw4G7Q2EK5qrCRU8+2534ihlNA/q4/
 IZuMBtk3BjsrRDAssPa8jngrZTIHovDemEzSU/elM9FcUxEE2RfUCfI3uvBfuyk7Pz2S
 EvG6ABWgU5doWqTZ8WDlBQinO/+0XWVPqOdZY+Rm3S5GXlTr69lIJqQOnboEb/O/stdn
 b+fg==
X-Gm-Message-State: AOJu0YwUCrqpfveBO/ogRUz9ja4yrBUau8EvxbaaGvGOdKYA7WUmmEs+
 vtIjKRgxlUHAoA9h/gKAc6doprKd5PtUXOAt40IaXuIqDuaBcAYWOXZ8K/3jMQgN72z5gwb0nzA
 hgho=
X-Google-Smtp-Source: AGHT+IFByNjubgvH6X2xmHAKxbhu0fWvnp8dWXrB0BRcK++zMFf01e/6CpppP5sf/SFvCissFqrz+Q==
X-Received: by 2002:a05:6000:410a:b0:381:cfea:2818 with SMTP id
 ffacd0b85a97d-381cfea2a53mr9258718f8f.30.1730812031787; 
 Tue, 05 Nov 2024 05:07:11 -0800 (PST)
Received: from localhost.localdomain (86.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116b11esm16096019f8f.104.2024.11.05.05.07.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 05:07:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 16/19] target/microblaze: Consider endianness while
 translating code
Date: Tue,  5 Nov 2024 14:04:28 +0100
Message-ID: <20241105130431.22564-17-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105130431.22564-1-philmd@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
---
 target/microblaze/cpu.h       | 7 +++++++
 target/microblaze/translate.c | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 3e5a3e5c605..6d540713eb5 100644
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
index 0b466db694c..5595ae4fadb 100644
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


