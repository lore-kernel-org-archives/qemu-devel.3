Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2CED0C615
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L4E-0004TC-Ow; Fri, 25 Oct 2024 10:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L47-0004Km-8m
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:23 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3x-0007tl-3Q
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:23 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43161e7bb25so20292815e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865591; x=1730470391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCkNXmPfCnwutAypvXIltADsiovUrFYgTsHQnSnupeI=;
 b=pca3dyA0DUBtE/UZ+t+nbehNTEGr0PcZJrjxxZux1SDTYiAoHoVAxirQb0lEFRSTff
 M+8TK5ftfu2AmIzHGAhANFHIrybvu/rbdrR9iOX0YWZlIF2AVN8q1LbpyF1ChOaqTmB9
 +kqJZ+sv6Tkhb8s1q3WrbKB63JN2xYe5z05Lb1fRA5NHFRZhWw2b3UPwBcaYt7h8zmVg
 Bv1Ql4ZXRhiQg7QJfpU6WQNk2nfhw39o9Et1J2KKsSL0CCXnzb0G+A++hOshHsN9w/wI
 /ya39ESiS9Z6+iGx5iL55AYEG+E4NOlZAnMyy7pnDlNXSFGLHH7llbuXHi9V36j8GEYc
 3IJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865591; x=1730470391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mCkNXmPfCnwutAypvXIltADsiovUrFYgTsHQnSnupeI=;
 b=sZt5VzfVXDKspvu++NhGK6GR3A4ylNyjJh5FyDkuGIjHofc9FHl1tt1wJS7m/aBP+U
 jL1mjJTx/zcDbG6xDzyZ68NZ5a1Tqf/YD4NZgY7gts5Vam/M4Gqo0MkV2u9A4jQYB0gf
 mutdQFR4Co76bE5nygNOevnRghSoudgKKGwk41Lw/sjncl3YWumhsb/OxNlyxkTpf1Sk
 lRji3Msenpx/r84Ma4KlkSqPMrGBC3g3mVNbxYx8wXTcNt1TE+Wdkf0EZKtzI8bOh5nk
 I1Cs/zeCRaitfvOI01FITlFssR5WDX2xhdjkWnP07OrnuMtN6PmIqeg2c9XNsRhyFUG7
 8AeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEZdfuSd+H4Q1OmqiroKr7gBMSvPudllCJdPRi3doP0dHpZr93GR5FkLjAW+9bMkO9I/GSS+VFsAtJ@nongnu.org
X-Gm-Message-State: AOJu0YxEgodaWx9mkvGS/tHne6hP1te8wfKS77/hOdGZ2AETr42fuHHx
 5PqL+k784LAvVBMaTw+syCaoT4WWv37ex6fajndwj7Mdhpe6AD4pO2djxOJZ/+A=
X-Google-Smtp-Source: AGHT+IGCfuJvgEuS7mdaniKHTJpPLHMzAXjXMIj8NGfV9QhRf3aVvXHwK13uI5ILUl55ENf6cj2t+A==
X-Received: by 2002:a05:600c:4687:b0:431:2460:5574 with SMTP id
 5b1f17b1804b1-4318418ac7amr71250255e9.27.1729865591153; 
 Fri, 25 Oct 2024 07:13:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 17/21] target/microblaze: Move setting of float rounding mode
 to reset
Date: Fri, 25 Oct 2024 15:12:50 +0100
Message-Id: <20241025141254.2141506-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Although the floating point rounding mode for Microblaze is always
nearest-even, we cannot set it just once in the CPU initfn.  This is
because env->fp_status is in the part of the CPU state struct that is
zeroed on reset.

Move the call to set_float_rounding_mode() into the reset fn.

(This had no guest-visible effects because it happens that the
float_round_nearest_even enum value is 0, so when the struct was
zeroed it didn't corrupt the setting.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/microblaze/cpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 135947ee800..6329a774331 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -201,6 +201,8 @@ static void mb_cpu_reset_hold(Object *obj, ResetType type)
 
     env->pc = cpu->cfg.base_vectors;
 
+    set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
+
 #if defined(CONFIG_USER_ONLY)
     /* start in user mode with interrupts enabled.  */
     mb_cpu_write_msr(env, MSR_EE | MSR_IE | MSR_VM | MSR_UM);
@@ -311,15 +313,12 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
 static void mb_cpu_initfn(Object *obj)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(obj);
-    CPUMBState *env = &cpu->env;
 
     gdb_register_coprocessor(CPU(cpu), mb_cpu_gdb_read_stack_protect,
                              mb_cpu_gdb_write_stack_protect,
                              gdb_find_static_feature("microblaze-stack-protect.xml"),
                              0);
 
-    set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
-
 #ifndef CONFIG_USER_ONLY
     /* Inbound IRQ and FIR lines */
     qdev_init_gpio_in(DEVICE(cpu), microblaze_cpu_set_irq, 2);
-- 
2.34.1


