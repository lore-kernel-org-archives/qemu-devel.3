Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CD3FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINrM-0005cB-Pt; Thu, 30 Apr 2026 05:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINrJ-0005U4-EY
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:39:01 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINr5-0002sd-GK
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:39:01 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso438889f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541925; x=1778146725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ouV2EmJ5IxGHRV6V1ycMGgG0OzUDMtn6AyWeuat9gA=;
 b=ynWAfKQA9ENj59O+pKwIQu24O87PKMtKH2XQhV3SWtVYxrg3Crnmsu0ubkdCNqD5HL
 Jl0+dN7Ll/3PuCUYICwqLtRUH7urrvNhKNcn4Sgm/6fUyrp9xRzGrHZNXF1Jh1DZDnHB
 7zV2HM/sGLK8UiRPEvtNuvz72Ll98YDVgrvOSR4vB/+VeYI9sWqZLGukZwNEofqxVjSG
 tJhUy+7Tga40FDPdQ8RKJ9YYb1W0bk8JfEe5QW8BJR91pbK1gWxDIx3jpItPBNChktmy
 TPsoN6poUCPEGa0Djxxc4ZUXjDVgblLYVEOTl2oqu13ExuL1eHD0B7ga5CSvrQiPqvga
 HjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541925; x=1778146725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ouV2EmJ5IxGHRV6V1ycMGgG0OzUDMtn6AyWeuat9gA=;
 b=Sl/Od8Wu+dGLoPkX6f1NLsHQ2nBustyiAdc3FUEhJBWbcwvL/q22D2Wt1rjIsDzxxK
 jJMlnkJhL28fb0DUyao7X+88b6KSYkYXUQF5HprXzA7Lb2Uqii6SsjYD52u+vAdDaXwC
 59fEAT2B+852lBFzUVvxO+oCE3sWTuAXazT4P2zGv8O0/WGx0YzcF+ihHzwWkWDBotTo
 qxXilYnEx/vnABTU9/BKfUFuGVYRkuP5LSLSb1zLKJj6fh1y319PC5ggsfWz21P2sAQo
 tavxXTdX4OhRqO5ewGU6jy/8H6cbcIfDdAGqHlXS0MMpZn5wj0lP7pcjNuH7Fk8Zcvv6
 Cwtg==
X-Gm-Message-State: AOJu0YxEzpOWTWtykKHyph4BWZR56TD7YPoD3ZsEj9m6hoRe63fal9Hk
 WJ6g4JVATg0N8XUeFQgcsnDsCXLw6p4dERFncWmYRkKp0u3gXwwHaqaGWEiwaohqDeM1wcZ2oAc
 Wh1iH
X-Gm-Gg: AeBDiesLt+qwnwiorYyldsZVz6rvTXd+TsM7GBbf8A6yU63gglXQ7A3j+uA2lFdDeue
 Tv1g6VCAqyeO1L642CN6Ez6ylOzs2McrhN5hFFn9Wve6GOL3n6ehTwMqBRPFu725p+bFwI/j0TS
 j0TdzpmFfWspnAwRksx6qM9PWWDAmoEb2u1diPWn1PIsuEH5oDHvN85jazyu5R2SRwxZMC86jEQ
 ixV7tkfKUbqRhUWXwdKpMOdB4nb8ae4Et7RFnqpdmiFLNP3fXmoWFCj/V21/F/DiZoffDuQZ0Ta
 EaJbMi03M17OHleuhjcwDkTWwGdKpZVnVJKDpeoafsYjg6VcOeypII7AP/4keoQ+CPsIzemfOYR
 ZYDcE9Tr3UUB+AV8IZB3zKgPvngmMT5dR/u58hbRle+DI1XFDmEypKIP9Xvvel/RhX8v4FQ4axB
 Yd5pOcvERQ5uRLCrMuVG3K5atlrrXR0Ex1CBvCc2E2roPFVikF1mt4ZPQg97tbBLp28+wNRiqlg
 e53Jthh/i2F2PwrxcCPdD7/CX4XgfuP0sKnmBk9+A==
X-Received: by 2002:a5d:64e9:0:b0:43f:dc54:9493 with SMTP id
 ffacd0b85a97d-4493f42dacamr3521529f8f.21.1777541924665; 
 Thu, 30 Apr 2026 02:38:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 25/25] Remove cpu_get_phys_addr_debug() and
 cpu_get_phys_addr_attrs_debug()
Date: Thu, 30 Apr 2026 10:38:10 +0100
Message-ID: <20260430093810.2762539-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

All the callers of cpu_get_phys_addr_debug() and
cpu_get_phys_addr_attrs_debug() have now been updated to use
cpu_translate_for_debug(), so we can remove them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/cpu-system.c  | 20 --------------------
 include/hw/core/cpu.h | 34 ----------------------------------
 2 files changed, 54 deletions(-)

diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 954b81931d..16f048c956 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -87,26 +87,6 @@ bool cpu_translate_for_debug(CPUState *cpu, vaddr addr,
     }
 }
 
-hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
-                                     MemTxAttrs *attrs)
-{
-    TranslateForDebugResult result;
-
-    if (!cpu_translate_for_debug(cpu, addr, &result)) {
-        return -1;
-    }
-
-    *attrs = result.attrs;
-    return result.physaddr;
-}
-
-hwaddr cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr)
-{
-    MemTxAttrs attrs = {};
-
-    return cpu_get_phys_addr_attrs_debug(cpu, addr, &attrs);
-}
-
 int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs)
 {
     int ret = 0;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6a6b78af31..eac5329889 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -744,40 +744,6 @@ enum CPUDumpFlags {
  */
 void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
-/**
- * cpu_get_phys_addr_attrs_debug:
- * @cpu: The CPU to use for the virtual-to-physical translation
- * @addr: The virtual address.
- * @attrs: Updated on return with the memory transaction attributes to use
- *         for this access.
- *
- * Obtains the physical address corresponding to a virtual one, together
- * with the corresponding memory transaction attributes to use for the access.
- * Use it only for debugging because no protection checks are done.
- *
- * The address need not be page-aligned; the returned address will
- * be the physical address corresponding to that virtual address.
- *
- * Returns: Corresponding physical page address or -1 if no page found.
- */
-hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
-                                     MemTxAttrs *attrs);
-
-/**
- * cpu_get_phys_addr_debug:
- * @cpu: The CPU to use for the virtual-to-physical translation
- * @addr: The virtual address.
- *
- * Obtains the physical address corresponding to a virtual one.
- * Use it only for debugging because no protection checks are done.
- *
- * The address need not be page-aligned; the returned address will
- * be the physical address corresponding to that virtual address.
- *
- * Returns: Corresponding physical address, or -1 if no page found.
- */
-hwaddr cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
-
 /**
  * TranslateForDebugResult: gives result of cpu_translate_for_debug()
  *
-- 
2.43.0


