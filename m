Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5556EE8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHyj-0002r1-VI; Tue, 03 Feb 2026 10:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHyg-0002az-EW
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:06:06 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHye-0002DG-BN
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:06:05 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so55167345e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131162; x=1770735962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g8GmMSb34/inwMA1Utl9FRkTYGijQxQFdPfSDa96KPk=;
 b=y1LLSnncgCasZkPW7cXwu1h1drj0amGk7hnRiOZ3DIHAGL+v+O5Zod/8fglcMminx4
 0/x7qwae0IMpM+M8sgOnrFyuntjFPnaGHBZV0Ag+QIph1EH5aYsBPzWEaRrobapRRNnl
 TTi1/DMA4Y78QYefBavOFGeNnqSnpkeiEnbYqusQI0dB/ueyqqqscNX3UJc63VTy5TxU
 iBMWLNBLkoXJZ7q8vKhpXb4pGGb5DK0ozAb1fq8eaYmOTcWfqQYcsUh4aNQD0qSAczs1
 f3xyy2VkgNbGRwpZBKtlNuXJ3od5941orGM8yXw0/jtJDDHFS5JIcMCBiwemcA/LNKfG
 H8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131162; x=1770735962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g8GmMSb34/inwMA1Utl9FRkTYGijQxQFdPfSDa96KPk=;
 b=rtM3S9EuIBcvy/pATc3ccPyziotSY37GLCJF34Z3/C7pCSuFB+YIIe00azcPW1IFuv
 hi6x8eqsGIP9d/ihffIgiMKIGVE5uz/1snjKLQWgRYV4zrP6sw7KJZpkQnIegI7+Q05Y
 YacZFDi/Gb2RtQTrf2V8+Gm6ZdJZ8z84Ril+nZZ7sLwgukZrj7IKPdPS3JF/NCMI49H3
 GqQPb7pH7WTzMbJV5hCMJpa8NexvwKbWVUBCidwMfLDQMTlDsv2ZzejXhmsxt7kWk+oC
 baWkV5LzApB8urCyzhFMnEw8GYlGtkIZhV1JJCcrWJ00FFGvj3ltMrCDNjQtpHOVydrf
 rl6A==
X-Gm-Message-State: AOJu0YxnySSVqB2gBnK74YCaXR8taymCal9LqLUxFaKfNhO//ecgUg+2
 aDodEtBybfycHLVw7cRiSHVst1C3ljsAm+27MkNaz1phOcQn9ntkpDpn+OFnnPzTfM1mq14XL0e
 Kr9xF8Ok=
X-Gm-Gg: AZuq6aL9PLbGOVRCZvaFgKYFEE1MmhFb6fDDCHhDn/4Tk63/S2RMhus5bVjRVP2l75z
 HKCU4PF20/pBhk9k16HcPF6iXqJlyAV7Ee05e0yOiZjVq3FpWGJzX4BlIrsA+BEXF0ked8Ue4Nd
 lXrzS8tUc8H9nyb55y7Bf6tOH3AvnO/+2gQgcyScgMlPFgUENVwmznFulm/wvBYx7CPVOtOt79d
 WR9iYQ1dd4rg/B/yBVQ3Kzv2YprdrldgMq1alyXxCiYHCDk8bdy7PiTfChR31PgFUNnfE0w9Fub
 AtX9ao8evTSzfqORjDAeK/U5mUdMmpY3UDH8gk0JyYckrb+GTE+AfcApmPd0ZrNtPB42lbItWv7
 ReCIxz/hSzsbpr1UwFHvM389Z+SbGfCJVpsXuLrvwyyQz3aMjDv+qjQjRSxy8NcduHCY0STJP3e
 uCny/NJ5/ddo4U5ryACSlH59p2OLS252IiYTOqd+T9n1NsdXmJlNXUL31C/0ui
X-Received: by 2002:a05:600c:310f:b0:480:3a72:5238 with SMTP id
 5b1f17b1804b1-482db49243dmr220576615e9.30.1770131162387; 
 Tue, 03 Feb 2026 07:06:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee057sm58694753f8f.15.2026.02.03.07.06.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:06:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/30] target/ppc: Inline cpu_ldl_code() call in ppc_ldl_code()
Date: Tue,  3 Feb 2026 16:04:17 +0100
Message-ID: <20260203150436.71907-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Message-Id: <20260202210106.93257-12-philmd@linaro.org>
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


