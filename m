Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0DCC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXd-0004RN-Os; Tue, 06 May 2025 10:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVA-0001Ts-1w
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:33 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJV5-00026P-R2
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso36187785e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542546; x=1747147346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EE54QuMwHQWEnSKffQHIxH4iI4MordfjnZWjYY41Z1Q=;
 b=zQ5dN+wAYQugZ7q5B5Wyv9txVk5Lr/dSYD02028u8FLl9H21bjLT9NJL+9yfnPEU9u
 2gLl4EKeZLKJK501OwCcO7QK8S8wSEsV9kwmibsymMdQSV990G/08VGP6rCFV+Xs0dZ3
 sQ6Cq0OPfS+h1M8JNr6VKYddT9SlpyV5uUszNNEQqq3tHqvSifCN/O84dlZDDinkB/Sg
 /wxrZ+7Yi6qvIqGcDJal0W7VcfUGvAEsBLm9n+v6aGDy2PLrA1LF7TwAnK4hlU0DFFfB
 3b395HQgN5Pnyl8Eo4wW/vCYQGC8unR62Ga2j3JM23LyOT+XsDjJSi7jrn63uezBX9xi
 773w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542546; x=1747147346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EE54QuMwHQWEnSKffQHIxH4iI4MordfjnZWjYY41Z1Q=;
 b=VqW4sxb0AobBFbOJI1sqCdXoDHUTOKenwJEpKRZL14HN0uVRTzZa5UxBAkD6kN1vCx
 EBZEGN3uhZnfZShpXB1FUMyI+inyRJ/3G0fUxLAu9n2uwztQQS7IX1DfDvz6oZo+H15b
 1Ntx5J/mCNDDYFp60mtpJ4jeX8WOjnD930hivgrbnifUAGPQ+uj6fydjxy32ed4/yEG2
 7cTB2qXXg3qCMPiR85+MCMqme4xFevovd/8S2NvyCFTWKOvRQa510lRBZ4D3Fmw1IJYc
 vfsesXpQDq/iLlXeJNuLEahKnM8yXBxGz8Ie1eqXNMG1axlb/E+25IGtT1f4SFnPI9sm
 S8Fw==
X-Gm-Message-State: AOJu0YzVA3y77R4B+h8gnq7PFQpbs6mkj6z5o90GGd61VOs03/OkspSP
 2Iw88KfVCmYTAC8wOSw1poGYXxZj7ZZ9srfo3rmz6a3M4/khFtjhNRDyMn8FjOW0ZLnLAiGpU8k
 6
X-Gm-Gg: ASbGncspG7M2JzgC7WzuaaWCGQIt/h9bufktcYCOyMlQVsmm43R1qyCZbeGGGjCwqlC
 ts1JJFfMTwH15APXlRf4KijiJ/co6HBGHlZ62j0HmGWVaYLnZBjMP7sPMq/O1be9Il5r2c0fvuj
 GiUDnruSnlL4GlaRJnTYYUY+sfPSXQl66tDdQPydO8TRhxtxmQzdlJesW0ccEC/TPyLfW7Q1Tte
 y2f6DJ02i0PI2qy1y7TD3i57syV/KlFz4H2s8wRAWu+hmaIz1olR5jT+cwglprFJnAMO7Asa+g+
 GwkeUORxJnT+36zhs+wENCMlMfMbkEnO0g8FWcd8IjEfcII=
X-Google-Smtp-Source: AGHT+IGe+fo/MpA5GTy8Ghfm3MUgjS2ydG26jP/QFxVsyBzf/LyudWpvszuFxTuIlckB8tyP7ixtGg==
X-Received: by 2002:a05:600c:4e14:b0:43d:fa5f:7d30 with SMTP id
 5b1f17b1804b1-441d3a821e4mr86025e9.16.1746542545848; 
 Tue, 06 May 2025 07:42:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/32] target/arm/ptw: fix arm_cpu_get_phys_page_attrs_debug
Date: Tue,  6 May 2025 15:41:49 +0100
Message-ID: <20250506144214.1221450-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

It was reported that QEMU monitor command gva2gpa was reporting unmapped
memory for a valid access (qemu-system-aarch64), during a copy from
kernel to user space (__arch_copy_to_user symbol in Linux) [1].
This was affecting cpu_memory_rw_debug also, which
is used in numerous places in our codebase. After investigating, the
problem was specific to arm_cpu_get_phys_page_attrs_debug.

When performing user access from a privileged space, we need to do a
second lookup for user mmu idx, following what get_a64_user_mem_index is
doing at translation time.

[1] https://lists.nongnu.org/archive/html/qemu-discuss/2025-04/msg00013.html

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250414153027.1486719-5-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 3e00e4a8bb4..d0a53d0987f 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3656,5 +3656,25 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     CPUARMState *env = &cpu->env;
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
 
-    return arm_cpu_get_phys_page(env, addr, attrs, mmu_idx);
+    hwaddr res = arm_cpu_get_phys_page(env, addr, attrs, mmu_idx);
+
+    if (res != -1) {
+        return res;
+    }
+
+    /*
+     * Memory may be accessible for an "unprivileged load/store" variant.
+     * In this case, get_a64_user_mem_index function generates an op using an
+     * unprivileged mmu idx, so we need to try with it.
+     */
+    switch (mmu_idx) {
+    case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
+        return arm_cpu_get_phys_page(env, addr, attrs, ARMMMUIdx_E10_0);
+    case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
+        return arm_cpu_get_phys_page(env, addr, attrs, ARMMMUIdx_E20_0);
+    default:
+        return -1;
+    }
 }
-- 
2.43.0


