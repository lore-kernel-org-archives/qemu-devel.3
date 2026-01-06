Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D519CE9D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9Ry-0003Mc-1v; Tue, 06 Jan 2026 10:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9Rt-0003JD-Ew
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:21 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9Rr-0006US-Uz
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:21 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so766414f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 07:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767715098; x=1768319898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0RCypk/eN7poBbZcD877As9DAVSnOVK/KObwXFd6P8=;
 b=pfYJIxTuwfLfNSuHFVEJhzX7zONV+7y42sPUOJYSXzkAlk3tWGBOD2iIPmDZeMozQF
 Ns1lnNf2HS8jiPEf8U9+CGiIdJJi4lR8xs1RhjxRXsccBcb/ca5pDgpxA8L6FzfjWnm0
 fcJ02Tngcrf0bGmeNNMyf/e0k5gjlCZCeT9UVDojV19zSOza1dX7Yc1Jdr5nc0YmwrMK
 A1ztUYhzr3UG45XPgxPEHbp7Jh9uj9Sqj0pr1p2VG7RLjTnfF9jMGpqYTogvoY9mqDA9
 hB8clcC69o08yAfp/gXWSEhpUIXJYWMTAngTt7nglZMJmrWDUyJomjGmiFaK994ios/d
 X9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767715098; x=1768319898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o0RCypk/eN7poBbZcD877As9DAVSnOVK/KObwXFd6P8=;
 b=CMDJ4zKqzef7FTsl1YqDnxTCMz67owpzwfOaKHsTpsohBZ2RcmEcC5nkLiAouMuETW
 ZcRwR4qmLMNbBKiB5Mc+e6xNI3KJ33P4XIRfzt1WljaI+FxbOKYINQsuK29Cf9zwcVLi
 W9JvDydgrH2Wuei3qP+ncyXoArikTOELB04kTvntbVfbWUX0K8Ew+wm8jqhW5u0yeBuT
 DCIbHtUgRoGIi5hxSstyTKgbfMfiaAF36Mt5wUXef5qhduE2oWLb2eU3dWXEA5PmYUhI
 HV+nAlwRzK1yV0OeD/Xm1av7GfmZ2NZ+HexGfob/sbVxICEW14O7E3iMjKybMnYicX5x
 Gt7A==
X-Gm-Message-State: AOJu0YyEbQNQJwrpsu+I7qxOlUzscmWW12RBkFizqPdLMTtiIH+EIMDD
 4guoolc5FA4wOwoNXfGnSHFtPknqrTByUNLvG0oRuKP/9Dl45UAId+hyHbBfjmyQO6v6TH2ii1F
 BngVqi3M=
X-Gm-Gg: AY/fxX7FKoHiMJiyzB+PJ//LmtjxriJKTEDuGAeKMUpXKrKUOHP+INg0qdKz+K6vfQV
 5D+cm3gO524SEnB9i6a+hcK0/U+Wv2Ejzmp8pd+cnBxd1fR0lGsTt0mlRX20MC2QQMrEEZBLlai
 OenIZ8os9Ir/SBEteTaAyKcwmhe/OpvEBjNQHKpWw/cVbi5zB0bvAl9TFAcf9af9pc76PKYpzIi
 tdcmR3B8NkjadLKSkIexxqGclaI7gkPuWKCZTIyNoImGJ5qs0C0+F++iNgYkXwdpnmznyMJ9m3x
 BTYhA/XAwqSxQpsM2xeeiRA76C9+l+p6blx+Q4nnPc47e4aPI7TXBm/rC5f7zNWNbfqof235xp0
 D3+7yz2PD0k1AoT8S2VCbj9n7DUcWp1kNsJK44ZPM+VL1oWOZ1WOY+kwXqJOqTPE/J4ULlEFJQY
 XVtD5uPE/iREdhpMlIsBJPNCpvahYweC9dyj3YHD+6vH5JkBwID5zIfpxoazIt
X-Google-Smtp-Source: AGHT+IFcNmVC82Ta2qKuPmJK65bu0ewS1oD34i3V3bQOBqOoE6OS9N58jDYwCCfZzcld9DtGjEZLyw==
X-Received: by 2002:a05:6000:2387:b0:432:5b81:483 with SMTP id
 ffacd0b85a97d-432bc9d37e3mr5179478f8f.24.1767715097917; 
 Tue, 06 Jan 2026 07:58:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e17aasm5100181f8f.15.2026.01.06.07.58.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 07:58:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/8] target/alpha: Inline cpu_ldl_code() call in
 do_unaligned_access()
Date: Tue,  6 Jan 2026 16:57:49 +0100
Message-ID: <20260106155755.53646-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106155755.53646-1-philmd@linaro.org>
References: <20260106155755.53646-1-philmd@linaro.org>
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

In preparation of removing the cpu_ldl_code wrapper, inline it.
Use the return address argument.

Since Alpha instructions are always stored in little-endian
order, replace MO_TE -> MO_LE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/mem_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 2113fe33ae2..572ea9cb418 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -24,13 +24,15 @@
 
 static void do_unaligned_access(CPUAlphaState *env, vaddr addr, uintptr_t retaddr)
 {
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_LEUL, cpu_mmu_index(cs, true));
     uint64_t pc;
     uint32_t insn;
 
     cpu_restore_state(env_cpu(env), retaddr);
 
     pc = env->pc;
-    insn = cpu_ldl_code(env, pc);
+    insn = cpu_ldl_code_mmu(env, pc, oi, retaddr);
 
     env->trap_arg0 = addr;
     env->trap_arg1 = insn >> 26;                /* opcode */
-- 
2.52.0


