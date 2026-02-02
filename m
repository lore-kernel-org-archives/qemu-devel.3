Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F141CE7FDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn14I-0005wZ-JP; Mon, 02 Feb 2026 16:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn140-0003TN-Di
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:02:28 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn13y-0004bs-GF
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:02:28 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-432d2670932so4515093f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770066144; x=1770670944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDhtEQv8WkXrqREcSeWoo48wCAWVx8JbJ4n5iMqvZb0=;
 b=qGQYMT73LxSLXaY3N7yfZve6AxjCXrjatMx7JPqijmL7aftj2phpSKfZ2AfiyBMK2s
 tERyomJRnhUqVi8m6F/u6szpXTyf3H+xn5lDzSIyK95AQ40br6W5hdKkh8LajUfcMUTb
 XwZP/YXeWYToxtIzKHZCeiLurL1yrba1NeG9PtwKswwYkP/2N6eKmLDIgzDcjXVy0aZZ
 wTRKFB/3wi0hRj2hwwoHA2rcznN3Oa77clvI2jWcPoBYGy+dVdAmCcFNXHTRTQiTv2G2
 54ppgYXV9VUuxijI0fku0is5QjQa1V2Dz0BWVuxDU+zMjnHTlzuxdR4tF3TLJsAFWEIB
 SiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770066144; x=1770670944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KDhtEQv8WkXrqREcSeWoo48wCAWVx8JbJ4n5iMqvZb0=;
 b=JuEmEW97ZyjuICQARyPdE04G8vKTAI7lhPsMgata9dxfDNknPDDw1iR3eV0hVUkPEy
 kYM8GV5hEqzjXsPnyOPpuEwBtxDmxBpx+k1YtHz/UFUlRhZ60Sz8NWM5UE82GA404OBY
 kA9X5eCMlG5wn7q2e7EZb2opmHPjG32za9R3qtnFtaLUAiGALQ9Rm+XiDj5j/mc7wqP6
 /Z4wyjTaCxhLBQ6ASV9BkvybizDwmMv1F1O1lseRBUzLvdBvSH6QDpQVo0MC4ujN7ye3
 Ei/3oJ58ngo0qow8xVi4rzczf3g4v2iv39/rjE3oMMr5yE9wHwXBNnedHOAbEgndbmkb
 CjJQ==
X-Gm-Message-State: AOJu0YyUCzJ9MgY0plXmrBEsd7XCPtY3gfsK4ngiI8LjsS2GZ4hngpC5
 nhIJT/t9SUgUd4JXotMZ7ejgNjAV6sHEyfvkwnFlQ5QlJePkdAZjxyWQWHCQRJQe4+LZLKpk58y
 aKHNRwuA=
X-Gm-Gg: AZuq6aLcTjejZBz/qoIa4iflJ36ZlsDJFE+pgAtXlyUHJMwidOJJZv95+XQdoboc4Is
 +xhkclKODDASzGM/oJTN+aQrTsQhYQRAy8fae+QDU5t4BAgqralsyyGjZsfIz6eecR7/bh8BwqC
 07LN6FlLeFgwMSgZSES1dqSwyICnx3doua+vkP0COiqu2NDD3XII/QTUqT8BYeYeZaxrk9SQixu
 BaUOoTu5MxOaw0WO3Qv0nd9a+8/cOfH5nAZcxIVrqHwrlpX5JZptV49OqhSLZqJCsdjJudzeIOi
 b/w24XIA4lev6lvO45lXD2m7s9dF5Uz/5ci8rdFb6WLtdCIF0sklSGVMqGVIkQt8rh9X154otoS
 nvAp3u5nJGt1FDgg2I4LnciQwLaRFBFlZoHEuE4LheUoQx/3+AUyALx0AzsSbU+KxipSBcLdWBd
 9m/hDWMjKZzPbbGyu68nVTrcGcao153LPoHvXhuArr13lf4E2HSNcQN16GYYYC
X-Received: by 2002:a5d:5f83:0:b0:435:abbb:fa77 with SMTP id
 ffacd0b85a97d-435f3a7b8bfmr20497702f8f.20.1770066144397; 
 Mon, 02 Feb 2026 13:02:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee057sm51822039f8f.15.2026.02.02.13.02.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:02:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 11/11] target/ppc: Inline cpu_ldl_code() call in
 ppc_ldl_code()
Date: Mon,  2 Feb 2026 22:01:05 +0100
Message-ID: <20260202210106.93257-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202210106.93257-1-philmd@linaro.org>
References: <20260202210106.93257-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

In preparation of removing the cpu_ldl_code wrapper, inline it.

Get the runtime endianness with ppc_data_endian_env(), passing it
to cpu_ldl_code_mmu(). No need to swap versus qemu-system binary
anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/ppc/tcg-excp_helper.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 3f9eb3d924e..5e6c1e326d4 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -428,22 +428,13 @@ G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason)
     cpu_loop_exit_noexc(cs);
 }
 
-/* Return true iff byteswap is needed to load instruction */
-static inline bool insn_need_byteswap(CPUArchState *env)
-{
-    /* SYSTEM builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
-    return !!(env->msr & ((target_ulong)1 << MSR_LE));
-}
-
 uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
 {
-    uint32_t insn = cpu_ldl_code(env, addr);
+    CPUState *cs = env_cpu(env);
+    MemOp op_end = ppc_data_endian_env(env);
+    MemOpIdx oi = make_memop_idx(MO_UL | op_end, cpu_mmu_index(cs, true));
 
-    if (insn_need_byteswap(env)) {
-        insn = bswap32(insn);
-    }
-
-    return insn;
+    return cpu_ldl_code_mmu(env, addr, oi, 0);
 }
 
 #if defined(TARGET_PPC64)
-- 
2.52.0


