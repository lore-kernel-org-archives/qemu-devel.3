Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA499F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBI8h-0003Rw-6o; Fri, 10 Apr 2026 16:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI8X-0003Bn-Ne
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:07:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI8V-00005i-LF
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:07:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488a041eae5so17417525e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775851646; x=1776456446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7uaft+3oypg1B317x+898MucBvPV8z17CqK/WINCHew=;
 b=gDIiVJodXfT/3WeraXa5eoDP9yDigR7IIwzNDCLAiI/pxwyw1BUazULamkk7dngUaI
 arMlF+1ax6l1IdrRToeMvO0mLgmGtQsE/nyBechZ5WnJ5F+1UcqcJRCL2jkm72p+geZX
 nGfajA8+UdIUvax7zgSs9aioweG8h9NeO9W3cuuk1m/SVbDG191asOx53acsaI6coMih
 zNj42SaC3wfPv0PlrQejtIwMF4iuhpCg4/n5dBb/85aMMZbtw1oyh2v0JD0go3m3UcGH
 6myZb3J+zXKPTtoPZEG91372DvFpVVmbfuwZ68zkMrdtELKOkYioTYiYhPElB43JZr0b
 jxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775851646; x=1776456446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7uaft+3oypg1B317x+898MucBvPV8z17CqK/WINCHew=;
 b=cGq8Pwd9WJVxSbLTmrLwKKrTLKxnd7hTigofzS9B30v65tFcNJ0ZKq1Rs33xvLIqFd
 xmVl9TMbDqm6a+iWCffF1sJl9xHkqHWoKpYhdzLkpLL4v3DYP7FkdIBkakocgTO94ToY
 YXurvyBOFOT+IssKpefZ6KE6GDQx2nQZVy2ImThJ8Ap5+WrNW7RlOIoP2QCRjnKqOQzh
 LLmMRj7sX5m49iwLhIiGwknoyQQzsLhnshcVFN5lTfjdmUBlBAbJGThJTfp2lx7jxC9c
 YwoGAi3fQJjKHb8lj9HSKjXFa8rbzr3EPv5PXPwPOvYgHUWkRMsXM9Fh6l90TXwkqGkO
 MIfQ==
X-Gm-Message-State: AOJu0YzlMf+IHPwMY2cZvtwIt42+9dD+Zz27BNlQLxaLjk++DMCYEUXP
 5FUufxW99QeNS3+JCNXdnyNwWp0xIQZ49Jqbmz3u7EBeL9Mzzih20d2GTh0RHRcXJgaiCEwySNA
 cUNsm1/Y=
X-Gm-Gg: AeBDieug31qREAC0eSiJ4LFQTeoOXgjVUL5xKGxtuhsCROKLcGmi8J40lIeqpLOw9Wu
 V0DyyR1JEvYuNSzrTLRXTAwz1+gw5E3oCoBOabxCT6f+peHw0/1ZU1bWu1thkkPKQg/zXVB+xRU
 hcQcreR8J2Vh5geje5GZyc4L8YGrsfuVi9YCVCplxRCWGt6Y/OxVjRKXUSrvyznhXWOgpYVWezS
 dxE6NwuifDDrcQ6rJTqwewHtFnsfEuLYguXVMwvvK+YPOko7bAUx9ZBcm+nWwlGDjFUWKE8GyL4
 riwknJjEixGgqelnXMLns8r99be2K/66gUayrm+IRJoVfpMdy/P90MDwPYQIHKtd0a7aYQ2u4RB
 rISfDEygXqrdozM0sxy6b8U6r60UNHq24P8S82nLFDsTi+U/nmpLJpOTx9/BBgXUzZ3HvLoJvNx
 NiWwWU/g0kd7beugWkUHaBn/aJ42ukhnHct8KRr7WC/aqRR2Agw245BZ5Pgug4dp55nWJgnr+h
X-Received: by 2002:a05:600c:64cf:b0:485:b6dd:5066 with SMTP id
 5b1f17b1804b1-488d67ce664mr55951735e9.7.1775851645626; 
 Fri, 10 Apr 2026 13:07:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d58a8438sm100847805e9.5.2026.04.10.13.07.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 13:07:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/9] target/arm: Replace MO_TE -> mo_endian() for Cortex-M
 helpers
Date: Fri, 10 Apr 2026 22:06:27 +0200
Message-ID: <20260410200628.19378-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410200628.19378-1-philmd@linaro.org>
References: <20260410200628.19378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/m_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f5954ce9bf9..1bec8e9aea3 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -634,7 +634,7 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
 
     /* Note that these stores can throw exceptions on MPU faults */
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN,
+    MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN,
                                  arm_to_core_mmu_idx(mmu_idx));
     cpu_stl_mmu(env, sp, nextinst, oi, GETPC());
     cpu_stl_mmu(env, sp + 4, saved_psr, oi, GETPC());
@@ -1055,7 +1055,7 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
     bool lspact = env->v7m.fpccr[s] & R_V7M_FPCCR_LSPACT_MASK;
     uintptr_t ra = GETPC();
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN,
+    MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN,
                                  arm_to_core_mmu_idx(mmu_idx));
 
     assert(env->v7m.secure);
@@ -1131,7 +1131,7 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
     ARMCPU *cpu = env_archcpu(env);
     uintptr_t ra = GETPC();
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN,
+    MemOpIdx oi = make_memop_idx(mo_endian(env) | MO_UL | MO_ALIGN,
                                  arm_to_core_mmu_idx(mmu_idx));
 
     /* fptr is the value of Rn, the frame pointer we load the FP regs from */
-- 
2.53.0


