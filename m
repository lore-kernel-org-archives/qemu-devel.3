Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669DAC282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDVj-0004qe-JG; Thu, 06 Mar 2025 10:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVQ-0004Tu-5g
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:28 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUp-0006j2-5n
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:55 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-390f69f8083so791119f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276247; x=1741881047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VfiQ2ykboMAdXTdejxhsHVQUrwF37vkEaR99lI8ZH/I=;
 b=Y1hd3RxqdIGG81NgKnaYpWhus6najBLDnE1dXE9hsRCc/Q42S9NeFv7xClUQesFSGm
 hj4VT6u+Pi7fw+kXPP5wSlZsAeNKTfJDmUCxrrVrMZ7rRs3OmN6HLEEqgCO87rEWIwTC
 hluLwR/6ZADeQRBvtXXB3RhaA66M7g74j6q9uMo5cHF4v7uDt7DkJuH5naK7Ei/DFBwX
 gTPaZNmm/BqmGiICi0hSFurqHMnxd/ukRL8tfYcElrQ/y4L19snnlmfHkg4fXM06umEg
 ChLhMcfIPViMQXKgOQ2MVFQcCy+4muJ2TvbI6nveoPXt0/ohT0k/6iux8vjBqsBzbZ0f
 jp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276247; x=1741881047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VfiQ2ykboMAdXTdejxhsHVQUrwF37vkEaR99lI8ZH/I=;
 b=wtl1UZ3wxDxHVgmB7W7lbUd/Dc5Kkyey86oYFCJzNBbomIU21UDSkla5Ef6LD7KYZJ
 x9rAlQYuKJATwlykyViW+/AgF8P02PppeNVij+c/xGYYvAmWa/4vgU41ep3YeVIYxuqY
 L6lGZhILpn52j3iIwWjddfkHbj1DnGowxu5jcC1b7wSvKb25q0/5Nwf7EriuMshsi8Gk
 WKuoFKwsTVfJTBpuqqguBEXItW8uUISYI006oCTUUlliNNBV+m3hrU706P5iH7R8Naf7
 bzGeAFdhAgQha3ilRFZvPDrvmUtQ3BwrW2J56iaHzKRSqqDnVhZkc6r1+cpcg2hiodgb
 siVQ==
X-Gm-Message-State: AOJu0Yx09MUMxqc8iRcMmxOZJYKZNzMOSwVoHjpTj549gNtwsQTCV8g9
 nUNcuGYbVokibVmCG9AiBejFoZ1E5VnN5XNccT945mz9VLt4uS941fBTOX1KAYgvJ2BVe+hO6Wj
 wfZ0=
X-Gm-Gg: ASbGncu5xAY1lk2X3oeHeXVOWrloKM2HN64MaXEfrhJMNL4HVDiSm7Teo7nL78D0WOD
 oYnwyoxqknJQcEujc6+rdlRWoamKUOMrPy9ec1DhG13iu2vExnNEIjqASQqJgv/RC+Ku69n0xO+
 DntJnfEkpNrsGQOcu4RDvS5b0FrCe0FTyBJw4fbuBlXmkIqFVKIlRAWkPyAZbnsrw+L9rk7wBuH
 vuDufDov2Nj3qHquZml9zQsqTqNvR+lKxcZ11i67ot8WVf/K9dpBD83eaLcall1vKevTmDxllgK
 TUTSWxQqfLAj/FqAbDeKmrTo0rOwxR5yWiRMf7kVbeXAFM4EfFXy4eqqwzDo/S07X2V57qjkNhZ
 /VtvH5r3TvxrwLO/uoM4=
X-Google-Smtp-Source: AGHT+IEgMMWVCiE0XF0Gnk9aisDRgdTVv6jkw8mvqJP6JTjyMAJMhYfK4uRi1/0VefNfsia0cABkww==
X-Received: by 2002:a5d:5f8b:0:b0:385:faaa:9d1d with SMTP id
 ffacd0b85a97d-3911f7b76ddmr7641151f8f.35.1741276247021; 
 Thu, 06 Mar 2025 07:50:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0195casm2438090f8f.53.2025.03.06.07.50.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:50:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/54] target/riscv: Set disassemble_info::endian value in
 disas_set_info()
Date: Thu,  6 Mar 2025 16:47:24 +0100
Message-ID: <20250306154737.70886-43-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250210212931.62401-8-philmd@linaro.org>
---
 target/riscv/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 47424fd5e2a..6da391738f3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1152,6 +1152,15 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
     CPURISCVState *env = &cpu->env;
     info->target_info = &cpu->cfg;
 
+    /*
+     * A couple of bits in MSTATUS set the endianness:
+     *  - MSTATUS_UBE (User-mode),
+     *  - MSTATUS_SBE (Supervisor-mode),
+     *  - MSTATUS_MBE (Machine-mode)
+     * but we don't implement that yet.
+     */
+    info->endian = BFD_ENDIAN_LITTLE;
+
     switch (env->xl) {
     case MXL_RV32:
         info->print_insn = print_insn_riscv32;
-- 
2.47.1


