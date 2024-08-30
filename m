Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871F7CA0EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 16:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk4nI-0000bu-7J; Fri, 30 Aug 2024 12:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nF-0000Qz-Ay
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:13 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nB-0006vJ-Pq
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:13 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2d877dab61fso483846a91.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725036488; x=1725641288;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uGkeLBI2Y/3go3w9R9Lqo9sAL0ONNc8YUVIQi3s2bbU=;
 b=XW9FfdvvzTLq9FdtBKUwiivpwlwOTMj6G9k/LCvRj8DRfPNnyeQn4kEGn+6nKwNkJ5
 qEwsm6BASrz45FO9c//O27gN7IVpNxs2Dau6Ws8mi/a5gyTPgtOhoG+Pc4lJzsTWlozS
 /VqL1/6CLVmE+YdeV/nA0Dv9YfnAiA7EcXEaT0IAbvaOaP1rDhw4trNhXlx9qIi3Y/Iz
 3HQHuhkFoJsWIctrngbyWR2Q8sh4GwuabfPPxKm2td8KZYpB2EgzA7xVDnpnOSIjWsuC
 QRO6x8tR2qFBTtvYkrc631mlUi0XT6jxeROS3X2eSNf46n8AbuyT10HByZHxvvkIiDvh
 rutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725036488; x=1725641288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uGkeLBI2Y/3go3w9R9Lqo9sAL0ONNc8YUVIQi3s2bbU=;
 b=Zq0qenEMOjY+eCGy/yFhz6F16rjx8HKuDaAebNhSsKglFrINi/i6yafTEnrMUtLbUi
 +N0U76IGI5E0q9o8a8cHYJUcHd6e1nfLqOVPIT4fhsadMcZ1SwzK5x6uKwIXoq+5c6vx
 MxoGM3ISp+XCYUHJ4eKX9Zmb5iO3g2+buIlHh6Hhv6f8j7nLTKqP+vF8ZZPRaVtwV1Wn
 Xn7O44CEk0WqsBrvxa2hJ3Lym+eto+HQWxYAzFFR4std9ZT9RKRYdkoLX3yXZ+o2gq9z
 HjWuHdeIZWtF2Rge3NjUSxCqj0goeH6D2Cp500yu7852dFpoymdWvMTUyofoPBZCrtVC
 vchA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxREfsV2eubkO4YJxLxLBGJAj5dcSaOEH6oPSXDKRSGMucI9PQQR9b/9v8wv/9Eu1YVxDTwd9UIFZU@nongnu.org
X-Gm-Message-State: AOJu0YxsH3gSk90lKdgwt6VrYQ7Zd9GQEpVmhCNO4LwZMdOS5m/pDIgb
 N3W84upOUqbsyEaiCEio98rfkHgvmhPznw5Nwq55aMD7hDWLTQxzOTfwbqXnt+c=
X-Google-Smtp-Source: AGHT+IFoqYEs2Ktbq6YOP0mxXGwFbRumxQa7yg4Gc+jhfpH/Pe7SsjCtWP83MOseB7XdS0vHx0rOaQ==
X-Received: by 2002:a17:90a:d350:b0:2d3:c0d4:2c33 with SMTP id
 98e67ed59e1d1-2d8561afa0dmr7088322a91.17.1725036487927; 
 Fri, 30 Aug 2024 09:48:07 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8445e813dsm6591257a91.17.2024.08.30.09.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 09:48:07 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v13 01/20] target/riscv: expose *envcfg csr and priv to
 qemu-user as well
Date: Fri, 30 Aug 2024 09:47:37 -0700
Message-ID: <20240830164756.1154517-2-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240830164756.1154517-1-debug@rivosinc.com>
References: <20240830164756.1154517-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Execution environment config CSR controlling user env and current
privilege state shouldn't be limited to qemu-system only. *envcfg
CSRs control enabling of features in next lesser mode. In some cases
bits *envcfg CSR can be lit up by kernel as part of kernel policy or
software (user app) can choose to opt-in by issuing a system call
(e.g. prctl). In case of qemu-user, it should be no different because
qemu is providing underlying execution environment facility and thus
either should provide some default value in *envcfg CSRs or react to
system calls (prctls) initiated from application. priv is set to PRV_U
and menvcfg/senvcfg set to 0 for qemu-user on reest.

`henvcfg` has been left for qemu-system only because it is not expected
that someone will use qemu-user where application is expected to have
hypervisor underneath which is controlling its execution environment. If
such a need arises then `henvcfg` could be exposed as well.

Relevant discussion:
https://lore.kernel.org/all/CAKmqyKOTVWPFep2msTQVdUmJErkH+bqCcKEQ4hAnyDFPdWKe0Q@mail.gmail.com/

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 5 +++++
 target/riscv/cpu.h | 9 +++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 33ef4eb795..c4ea1d4038 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1011,7 +1011,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     }
 
     pmp_unlock_entries(env);
+#else
+    env->priv = PRV_U;
+    env->senvcfg = 0;
+    env->menvcfg = 0;
 #endif
+
     env->xl = riscv_cpu_mxl(env);
     riscv_cpu_update_mask(env);
     cs->exception_index = RISCV_EXCP_NONE;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 87742047ce..270a2a031c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -226,8 +226,12 @@ struct CPUArchState {
     uint32_t elf_flags;
 #endif
 
-#ifndef CONFIG_USER_ONLY
     target_ulong priv;
+    /* CSRs for execution environment configuration */
+    uint64_t menvcfg;
+    target_ulong senvcfg;
+
+#ifndef CONFIG_USER_ONLY
     /* This contains QEMU specific information about the virt state. */
     bool virt_enabled;
     target_ulong geilen;
@@ -429,12 +433,9 @@ struct CPUArchState {
     target_ulong upmmask;
     target_ulong upmbase;
 
-    /* CSRs for execution environment configuration */
-    uint64_t menvcfg;
     uint64_t mstateen[SMSTATEEN_MAX_COUNT];
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
     uint64_t sstateen[SMSTATEEN_MAX_COUNT];
-    target_ulong senvcfg;
     uint64_t henvcfg;
 #endif
     target_ulong cur_pmmask;
-- 
2.44.0


