Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062EDE77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRWS-0002M2-Qw; Wed, 24 Dec 2025 11:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRWO-0002Kk-HP
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:15:32 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRWM-0001XR-VX
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:15:32 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso32669175e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592928; x=1767197728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lgXG5IcwywLgUhxBZeRWbfWC7uBhw0QUE1k8VCd0sto=;
 b=Pd5XwUP1KQj5+1F6AUwJ0rH2BgtPJ9MqNNdczU0g4PtaCFht1yV5wFSJL/+3KxvzXS
 NDRSTYyFMv5nd/3iZbjQF67Caks5RUrLamqwZHeHOXraC+ru5TNRTWVCqXJfhWxIRR+a
 zroOs2h2w9+jXrYwCbZ8SGovBo4RcmipAA4zP1PU4WMnZ/FHJU6EX5DLLrzkfPoJW1r0
 i9Aw2I8eLOOjISzlxJgfGnMH6hxg3xLfz3w/NdTXqlAD2uEgNGcOeSfhfrhrP9s5hN6a
 nwKxYN8RJyipCoGNgnuAHAygE3nqpbILP0q0tPLASUY8B7S29fKFNMfwKHOojwUaeYc6
 /1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592928; x=1767197728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lgXG5IcwywLgUhxBZeRWbfWC7uBhw0QUE1k8VCd0sto=;
 b=VyvmXRXfnoLioCtNvfP48PH6YI8SFxEQOBx1/kEakpcVuK9eVkLQG0API6c0SZ2dmq
 bTdCy64p58hnn9naK4Nqo7WzLL1ZQfz/XAVayr5Xy+a48YVK6kEw2dDv08HsssdFQtMg
 3rtVxdXd2V0oMMKVoZFuVS6ntTufqtrCLMA0E9xPE+Aw2W+pqCzzmiKPdlkUGUsDBbyv
 AoMdd3VLVatDRfefYUa5wl5IUkjJz3RDDvEQg9pTAvCAIc2DKufFhtw3Pnqbt7QK4fil
 UWzLGxFc8q8k+7D5ixc1Pip1kiDrkwGb+i6HVHORT/KyBGZqXi5RfkhyptLeaX6m0x7l
 02UQ==
X-Gm-Message-State: AOJu0YyKOsZ7Y1a9cYlSdaHw9jKmwuYpzpOs8FyCqZIZI7GX3roqasCW
 HAI/zbSDXypUB4FVfmckaciky0CI/PgkNd63UA6YKRkeDOfhuhVzN1XtfUKbDXibkXBog3WuHnI
 vBn/oj20=
X-Gm-Gg: AY/fxX5hPMXaDC0XxFxrqropqJDc3uZMB3WqZ4l560xv74ssucjpyyND/zpptQOXq2K
 CHw3qN1e/L6bYyzxxLeo5ymoqqcgObsmYrCP+sB4nR36/3qQsepIavFtlvHe3/AhI7/7tp2vjtD
 pPbWVa5cgfIoJFDYssGcbVq8KtPcP7Rfbnmk+bdKPFwwoqu0YZSmmAomIunRSDOv3pPCCuTNBOS
 LeKOnMndwk9GtDWegfV+Af6FdW5A+eciGqN9WLmw5hlcqcrOu6OXRT/WYl8dIR2ZVok6cyo02ld
 paa8ghpCKxUy9OkMx34+rqCS4suVdv4d+XUkMRu9gNEDBdO6HuAqFgCRBpfdOSbc13J7iJm+kMD
 o8OaZR1z8dUix9Y7duUL//yxWZqm+QhT0HVXLnxeiXKaS6Yjbl6c5f7N/yDJoqANITXMZ9bL7OC
 6ALIe02kUJ8S0NOiOiPNXH8I0WUp8HsMzZFcsnfUNACMUAATgiB/1Jmqs=
X-Google-Smtp-Source: AGHT+IG70Y/OxHxa4zEGWlEYuXVOFdgVqgchVKXTUXmr3OaY5Pi7GN79Z7183psQmF/HztyNqa0TWw==
X-Received: by 2002:a05:600c:4e8e:b0:477:b0b8:4dd0 with SMTP id
 5b1f17b1804b1-47d1957b120mr189640545e9.17.1766592927961; 
 Wed, 24 Dec 2025 08:15:27 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b28a7sm357146525e9.12.2025.12.24.08.15.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:15:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Anton Johansson <anjo@rev.ng>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/8] target/loongarch: Use hwaddr type for physical addresses
Date: Wed, 24 Dec 2025 17:14:51 +0100
Message-ID: <20251224161456.89707-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224161456.89707-1-philmd@linaro.org>
References: <20251224161456.89707-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Replace variables used with get_physical_address(), which
expect a physical addresses, by the 'hwaddr' type, instead
of the 'target_ulong' one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu_helper.c     | 2 +-
 target/loongarch/tcg/tlb_helper.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 4864f4d6d87..2b27274f64e 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -146,7 +146,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
                      int access_type, int mmu_idx, int debug)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong index = 0, phys = 0;
+    hwaddr index = 0, phys = 0;
     uint64_t dir_base, dir_width;
     uint64_t base, pte;
     int level;
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 873a0a1b0c4..aab89b9be19 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -691,7 +691,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
 {
     CPUState *cs = env_cpu(env);
     uint64_t badvaddr;
-    target_ulong index, phys;
+    hwaddr index, phys;
     uint64_t dir_base, dir_width;
 
     if (unlikely((level == 0) || (level > 4))) {
@@ -726,7 +726,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
                   uint32_t mem_idx)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1;
+    hwaddr phys, tmp0, ptindex, ptoffset0, ptoffset1;
     uint64_t badv;
     uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
     uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
-- 
2.52.0


