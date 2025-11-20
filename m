Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0883CFA442
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 20:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMB8b-0004r4-MI; Thu, 20 Nov 2025 15:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB8Z-0004qK-6a
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:20:15 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB8V-0001hX-66
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:20:12 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779d47be12so10546595e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 12:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763670009; x=1764274809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQ4pDasl6Y/n9YuRjyNRdPW3qukt+LDvP4yTxJ1TJQI=;
 b=eDWMijDy337o3HBwQvHeRMZ93cwa/l+rkeGBm8yYQCeh9sSwYWbvCJgsOGKXtntrxt
 lIc6ufwC7QE5C0mLbIQHOZADaDYrkf4IvSJzQwcx4y0hpMpMlWDPTVoVlhqAiMGWuABb
 AyQiG64AiC/Db5+x8Oi7QTQMkMHDo8Qm4ot51uBVsq3bZzk7TlLonodSVq2/ur8Vv5hE
 OWEh/e+bhgHnehWrfpcLnUO6NdgaUgE2gFRw/2ao8monv1vPjsE3zUPzMGrVKtKbAecZ
 kLKizZ+lZemBhUBRimF7hAn6REuM2a1dQ5liFRHeTNoDHcuCwaeHZXgKV39WnlObDPAk
 xJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763670009; x=1764274809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uQ4pDasl6Y/n9YuRjyNRdPW3qukt+LDvP4yTxJ1TJQI=;
 b=etBFgPSLqhEtyNkYLUsRAz5Mdi5JJgwGEXtUk6s8gyi2foyFPQsel7P/GEdhFotP1k
 qaJD9qPtsIF5JhxyQ0f3Ql2RqPC+ezX96aRnBrTr1ZRRHUSZEwdBfqpHAEurQFVyktye
 uzKFH2dGxyZZFFzX7Vkx7hCmsJsX54KTIByF8Efwtp9WvCnN6xWAhcCTRR+ir/pMHhCR
 k63jZs3s78ihIxvTz9OG8inPzM2RynU+ga4uinMDq0wwBTOhvxVqW9GwI9QT7Ep1uLgY
 HOKCz7LhmoSvkeE9cMipaPlnmrZTyc/8jrIL2dVTHUvW1+ZzT269PbTR2CJNQKfnhfPN
 sAgQ==
X-Gm-Message-State: AOJu0YweQiI/arb1ppFIhC2ZZkUtqi2zhUB1neSoCsx7A5iTmEsJgvPi
 LiujF9fZWvvkqdYc1sduby5dFqqVXifJ8pwBLAZulSoJ8FZ1o9ctKJW0Ef2O0+USXEmhPxhGRID
 DlwwXVN9eqg==
X-Gm-Gg: ASbGncvl3WPQFbG3pl42O35gDvnJBGDDwa0gCUTD0Jyw2C0ohVWOqdPyZCmz1G96ASU
 s5ox4wNJe8x7piPq81z3A59tzVy4P00Y6IEAJtbmaCve+/qunHCPfincXY4z8oKqFiKeWO2pcwI
 uDZemgpM0vnTqjiiuVbyZni4T23ATql7QuTAorsGCkP9oGg+tbjRAqM2yniHtovfoY0PMKfhrZi
 ysKAlaYvv5LH7iqB3C9fCN5Vp5kEnIA+MWin4N5BdweRUtBV5zNbRktDysje9xGyX7jcrBjMKOJ
 IaIIa9svuqeFI7GlSRQ127tw0Rkq3hAZln/pRsKRbzs+gHQVYZhqg1fcbCfDJFBsdPcLj1XEf2J
 VXs3Njq1YZgchafO3H00okqLmpv0/881x2Nyy9T7P+y7Z9JkCAvbKRRS/lBEhgjp9v/OUYe6ppx
 +mivxqUadX57yJUMRLwBKViUK7jq7IXFsYDh+u71YvSdDX6Y56jt5vffBTcOCq
X-Google-Smtp-Source: AGHT+IHfqoEqhjnhk60tUs4cs2o6mVWrl8iQpPqPnZWhjlQBBWpkHhZrn9TQCIzWKFvhw5I0W261ww==
X-Received: by 2002:a05:600c:3b09:b0:471:13fa:1b84 with SMTP id
 5b1f17b1804b1-477c0185bc8mr100295e9.12.1763670008695; 
 Thu, 20 Nov 2025 12:20:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1f365fsm6916135e9.8.2025.11.20.12.20.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Nov 2025 12:20:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC-PATCH-for-11.0 v2 7/8] target/ppc: Replace cpu_ldl_code() by
 explicit endianness variants
Date: Thu, 20 Nov 2025 21:19:18 +0100
Message-ID: <20251120201919.8460-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120201919.8460-1-philmd@linaro.org>
References: <20251120201919.8460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/tcg-excp_helper.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index edecfb85725..6058efb09cd 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -424,22 +424,11 @@ G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason)
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
-
-    if (insn_need_byteswap(env)) {
-        insn = bswap32(insn);
-    }
-
-    return insn;
+    return FIELD_EX64(env->msr, MSR, MSR_LE)
+           ? cpu_ldl_le_code(env, addr)
+           : cpu_ldl_be_code(env, addr);
 }
 
 #if defined(TARGET_PPC64)
-- 
2.51.0


