Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BD1CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6wgx-0007pw-Ck; Thu, 09 Oct 2025 15:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wgp-0007g9-8P
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:52:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wgm-0004Vx-T3
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:52:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so16333445e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760039553; x=1760644353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KS/HbS9tWyX2nSPUXyFmIePyip8hJ77c95vjLMQG1mM=;
 b=XqIYjy/t191IyJf5qlMk5W76TtGTUaCDHQxfhZtbJv5HPvnm7M334jnxfojMCEiyTH
 u+KfLIjyoPeMLcR+Y0ZA+gsb6EZB7T451jRHFNIVqfrSHaY9AqIzjK6U+Md1gr8v5hHu
 yjd3jm+To78vmxqejtcAbOAXx8BpASfkftR9sx+gwOY5Jx3X/WZeqitJCrnmlAZsc63+
 IbEygz7Q9P4St/2J8ce21LOZuK7wHqzAWgHKTiejAs9HwkeRo+03Zrp/i1qC/fR6aJDZ
 7jpMtZlCgK+Gk9l5AYIUnrZODiKvblxQsR5GWX+XTEkcGoZtomIfMyGrGHCExPVlVH0Q
 j4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760039553; x=1760644353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KS/HbS9tWyX2nSPUXyFmIePyip8hJ77c95vjLMQG1mM=;
 b=NN58XYZSnlPqEfy1/OZWMfVwL80DLgBRCf9YvpgBcp98VD1Nq0LKQPLBXIg+PzYGkp
 syEMS2RzirlKKAdlMHonfgFpx5hJncRVeNhldAWO4hFvjVyoowKlgYVo7s/7rXYzNLf5
 h5mjV6fc2URQPf4CXLUFVM+nn30o4MqvlsPbUE4k/puKR+CR8M8/lEA1G0iOH3NfxC9s
 zBH8F2vaWaGcowwrny5TDqv15rYJ21PcKBvlJWGSYnfHvWcHnsj5at9wa8HN8l5+amgb
 efUjELuxWb4F0zo+KjT3b4jALeXiISCjVZh1pFjAPiUyiKTJcBgRHXE7seCVNJTZOPIZ
 7djQ==
X-Gm-Message-State: AOJu0YzExgnDE6m2W/vi7vt7BC3tYmt7nBJyxj6fab0UIsglPYxFQ2Ov
 m8y1MtFS7w8NNWeKxHvqi2GaXC/jvGFpbF9I6U1rBucVsYvb0MCv0AJVsCE0QY6DySY4wU+3OS1
 51WYWd/QNbA==
X-Gm-Gg: ASbGncs+LRV2YgG5hVw4S+wpt2EvSwRP8GVYqVBjnKC5n3Qf5Lb/OJryMOtFnoqkP3U
 SRPPEiHScTRY3Nw7UZwY8RJ3YT5Z59WGz3tD7okE8Qwn0GivqF25aWYlX3UarxvDS9bSD8s/o/r
 jW2HPKXyh74M4Imkgs4HYcz/0r63X/S6ZvATV/a5KXhxXCm1TsTw3brJw3D93ZpYBIX8IHKDyGP
 x2b0DTka6aaTSE7FlknNBFcBPqjQepzdGs7TVjkVV5J6T6opH5su+cjdb7xx4MkT9JKFdUHhKE7
 HoK4C5H6KvGkh2U27VyNesANlJyop7PmVw+VwhJnUf3vKCYvQcq21DnlQL+Vah63z2wWhkXRvK6
 /0EHkc3NzsyE6RFodFLTWMjr5FMqyBheP/beBydTqJqkJtUaGVPNILw4p8TGZQrOgSHizKNnuz9
 KzG4Pmou3+HLUAvXw70bxR1h2uSD/35vcb0UE=
X-Google-Smtp-Source: AGHT+IE/1LdOeBif0KyI6WUKm0+g/cHDcmQkZXMJ3HSKH34hIWc5HagqqycH+XwhkyREphFE8vGtFw==
X-Received: by 2002:a05:600c:c4a4:b0:46e:1d01:11dd with SMTP id
 5b1f17b1804b1-46fa9a89444mr59833565e9.2.1760039552715; 
 Thu, 09 Oct 2025 12:52:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb4982c10sm10840005e9.5.2025.10.09.12.52.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 12:52:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 4/7] tcg/mips: Remove support for O32 and N32 ABIs
Date: Thu,  9 Oct 2025 21:52:07 +0200
Message-ID: <20251009195210.33161-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009195210.33161-1-philmd@linaro.org>
References: <20251009195210.33161-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

See previous commit for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/mips/tcg-target-reg-bits.h           |  9 ++----
 tcg/mips/tcg-target.c.inc                | 15 ++--------
 common-user/host/mips/safe-syscall.inc.S | 35 ------------------------
 3 files changed, 6 insertions(+), 53 deletions(-)

diff --git a/tcg/mips/tcg-target-reg-bits.h b/tcg/mips/tcg-target-reg-bits.h
index a957d2312f3..ee346a3f256 100644
--- a/tcg/mips/tcg-target-reg-bits.h
+++ b/tcg/mips/tcg-target-reg-bits.h
@@ -7,13 +7,10 @@
 #ifndef TCG_TARGET_REG_BITS_H
 #define TCG_TARGET_REG_BITS_H
 
-#if defined(_ABIO32) && _MIPS_SIM == _ABIO32
-# define TCG_TARGET_REG_BITS 32
-#elif (defined(_ABIN32) && _MIPS_SIM == _ABIN32) \
-       || (defined(_ABI64) && _MIPS_SIM == _ABI64)
-# define TCG_TARGET_REG_BITS 64
-#else
+#if !defined(_MIPS_SIM) || _MIPS_SIM != _ABI64
 # error "Unknown ABI"
 #endif
 
+#define TCG_TARGET_REG_BITS 64
+
 #endif
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 045565f4ca8..77af0d8658a 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -26,15 +26,9 @@
 
 /* used for function call generation */
 #define TCG_TARGET_STACK_ALIGN        16
-#if defined(_ABIO32) && _MIPS_SIM == _ABIO32
-# define TCG_TARGET_CALL_STACK_OFFSET 16
-# define TCG_TARGET_CALL_ARG_I64      TCG_CALL_ARG_EVEN
-# define TCG_TARGET_CALL_RET_I128     TCG_CALL_RET_BY_REF
-#else
-# define TCG_TARGET_CALL_STACK_OFFSET 0
-# define TCG_TARGET_CALL_ARG_I64      TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_RET_I128     TCG_CALL_RET_NORMAL
-#endif
+#define TCG_TARGET_CALL_STACK_OFFSET  0
+#define TCG_TARGET_CALL_ARG_I64       TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_RET_I128      TCG_CALL_RET_NORMAL
 #define TCG_TARGET_CALL_ARG_I32       TCG_CALL_ARG_NORMAL
 #define TCG_TARGET_CALL_ARG_I128      TCG_CALL_ARG_EVEN
 
@@ -135,13 +129,10 @@ static const TCGReg tcg_target_call_iarg_regs[] = {
     TCG_REG_A1,
     TCG_REG_A2,
     TCG_REG_A3,
-#if (defined(_ABIN32) && _MIPS_SIM == _ABIN32) \
-     || (defined(_ABI64) && _MIPS_SIM == _ABI64)
     TCG_REG_T0,
     TCG_REG_T1,
     TCG_REG_T2,
     TCG_REG_T3,
-#endif
 };
 
 static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
diff --git a/common-user/host/mips/safe-syscall.inc.S b/common-user/host/mips/safe-syscall.inc.S
index 8857d708dae..3b196cc634c 100644
--- a/common-user/host/mips/safe-syscall.inc.S
+++ b/common-user/host/mips/safe-syscall.inc.S
@@ -30,15 +30,9 @@
          * arguments being syscall arguments (also 'long').
          */
 
-#if defined(_ABIO32) && _MIPS_SIM == _ABIO32
-/* 8 * 4 = 32 for outgoing parameters; 1 * 4 for s0 save; 1 * 4 for align. */
-#define FRAME    40
-#define OFS_S0   32
-#else
 /* 1 * 8 for s0 save; 1 * 8 for align. */
 #define FRAME    16
 #define OFS_S0   0
-#endif
 
 
 NESTED(safe_syscall_base, FRAME, ra)
@@ -47,34 +41,6 @@ NESTED(safe_syscall_base, FRAME, ra)
         .cfi_adjust_cfa_offset FRAME
         REG_S   s0, OFS_S0(sp)
         .cfi_rel_offset s0, OFS_S0
-#if defined(_ABIO32) && _MIPS_SIM == _ABIO32
-        /*
-         * The syscall calling convention is nearly the same as C:
-         * we enter with a0 == &signal_pending
-         *               a1 == syscall number
-         *               a2, a3, stack == syscall arguments
-         *               and return the result in a0
-         * and the syscall instruction needs
-         *               v0 == syscall number
-         *               a0 ... a3, stack == syscall arguments
-         *               and returns the result in v0
-         * Shuffle everything around appropriately.
-         */
-        move    s0, a0          /* signal_pending pointer */
-        move    v0, a1          /* syscall number */
-        move    a0, a2          /* syscall arguments */
-        move    a1, a3
-        lw      a2, FRAME+16(sp)
-        lw      a3, FRAME+20(sp)
-        lw      t4, FRAME+24(sp)
-        lw      t5, FRAME+28(sp)
-        lw      t6, FRAME+32(sp)
-        lw      t7, FRAME+40(sp)
-        sw      t4, 16(sp)
-        sw      t5, 20(sp)
-        sw      t6, 24(sp)
-        sw      t7, 28(sp)
-#else
         /*
          * The syscall calling convention is nearly the same as C:
          * we enter with a0 == &signal_pending
@@ -95,7 +61,6 @@ NESTED(safe_syscall_base, FRAME, ra)
         move    a3, a5
         move    a4, a6
         move    a5, a7
-#endif
 
         /*
          * This next sequence of code works in conjunction with the
-- 
2.51.0


