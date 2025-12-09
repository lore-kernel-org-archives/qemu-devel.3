Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3BCD3B981
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0Zy-00066x-Mi; Tue, 09 Dec 2025 11:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vT0Zt-00064R-6d
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:28:41 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vT0Zn-0001rF-3A
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:28:38 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso29819985e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765297713; x=1765902513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orxGf9vqJHAjjzl/pLsxIBSrWtr0DnP/NmbqdtgUE7o=;
 b=i12Ooo7HiwEvUbBevwS05vbspaMdzDWMNOEXsO+LF58RdyYAPgp/nif/N3/XB9AW8F
 dFh3JPREtTyj8hnPOeqXXfyDPIdIBiINqD3E2Pq2FnKEbFPmlhAeK+NGvpYASEMgX7oZ
 xJn8wrOFL4Tx1F8iC2gdjbqS+Ea2+Ae7H0OHl72IAG4vzfj0fj/m1SZMMhIR9JNe2Z01
 gr9M8pZ5zwxzwMB3WGpWINJTCVsS/SdBDPRbhrH3ir7fOITNtKEVmhGhk0gt9o9ABw2k
 TTYzTjqxJ75yF97a63NxrhQOdONHrfevoMNEJ/XDFYQKtFkReJjlI0d/PzF29bba+cTz
 8m6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297713; x=1765902513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=orxGf9vqJHAjjzl/pLsxIBSrWtr0DnP/NmbqdtgUE7o=;
 b=U2u//icl4eUQN/skZ9bqGm78mlAz81e36iyHvv7DfI09n27xqTV1iwS7BUbbNq4vih
 U/S49KywP6gqG4XViS8yvE8+5i4bDlKAl0N1KKZzne+sdVUKIW0y1Hvk031w/OCONsLY
 /HV5NIF2ulkSK3GJ5aSlHWI8I/GY6nsaVJ7waJwEH7YOqoWWwPq1ayq0w+NBqtf2pQFE
 6RBGXzcs03keomBZdnFgkClXcpxFbqSFajN2uMWK7pndks/qbkkqct14VaAP/j8less2
 gmTy0qFf0XXT7r32VFGZYsjhZyw+XvQxPJEI2Z1xaiVjcpeNYokaLQdoJxs+tltT+cRt
 8Gug==
X-Gm-Message-State: AOJu0YxsQrGOiwg/9C9pKtVn3CAK1UpPNhJ0IYF2Q+UJ0vaeqTE8qa/i
 TmNBDNE6CORikZ2HnvmS9/noaxro+JQiebDO3htKWzBNKsmzxIEHdcAtvqHkPbIc+W8=
X-Gm-Gg: AY/fxX5nCSW3YbIRDCBU4wc1gNILSSedqwm7OmW4fodXvAP4p40xBGeRW0bKdTDZtHe
 N/XjCukimNoU73RBz3ihA8Vu18u4A5AE02xSSOUUSGhUn3Sl6sD8IEgsejN9xmfwCNvqe1nr7OY
 KI70ixOE7WkXrIA93CGjXrQ1ahVXoS2J7569Xfu5c66+FuuC88fYlpPJuQVAzN9L0/vnkvTHfyl
 yOJ0A6zE+RqyArGiJG85Rsro8cqZ0NE3j/K22vLdCGQv/XdtDfQXTVtJ/230IHkXU9Wz3x1jG0r
 +yiY2AXEDi4cw2rgI9vVu+puzdMjmrec363c9ZX4tVHnLeafH0x6dotIeGYIW/g1ATcB+oDIvqT
 28EyHjIX+xgRAGdqkw9OlEM418pxBMN+AAn+5ajRyRQjVmH4nvcqd4tBaIW4kzrrJf4cnugtaLw
 GI/bnSjOZYghk=
X-Google-Smtp-Source: AGHT+IFpeqFSFRZ+WdAMqTiKKsbd5C9blRgmZwm8adPxB8bexth6KqJm6E56vYwfVEWPjB2fY7W9Pg==
X-Received: by 2002:a05:6000:40cb:b0:427:8c85:a4ac with SMTP id
 ffacd0b85a97d-42f89f54bdbmr12554927f8f.47.1765297713459; 
 Tue, 09 Dec 2025 08:28:33 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90f0sm32753005f8f.9.2025.12.09.08.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:28:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2A11F5F898;
 Tue, 09 Dec 2025 16:28:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 4/4] target/arm: handle unaligned PC during tlb probe
Date: Tue,  9 Dec 2025 16:28:29 +0000
Message-ID: <20251209162829.1328559-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209162829.1328559-1-alex.bennee@linaro.org>
References: <20251209162829.1328559-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

PC alignment faults have priority over instruction aborts and we have
code to deal with this in the translation front-ends. However during
tb_lookup we can see a potentially faulting probe which doesn't get a
MemOp set. If the page isn't available this results in
EC_INSNABORT (0x20) instead of EC_PCALIGNMENT (0x22).

As there is no easy way to set the appropriate MemOp in the
instruction fetch probe path lets just detect it in
arm_cpu_tlb_fill_align() ahead of the main alignment check. We also
teach arm_deliver_fault to deliver the right syndrome for
MMU_INST_FETCH alignment issues.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3233
Tested-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251209092459.1058313-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index f1983a5732e..5c689d3b69f 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -250,7 +250,11 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
     fsr = compute_fsr_fsc(env, fi, target_el, mmu_idx, &fsc);
 
     if (access_type == MMU_INST_FETCH) {
-        syn = syn_insn_abort(same_el, fi->ea, fi->s1ptw, fsc);
+        if (fi->type == ARMFault_Alignment) {
+            syn = syn_pcalignment();
+        } else {
+            syn = syn_insn_abort(same_el, fi->ea, fi->s1ptw, fsc);
+        }
         exc = EXCP_PREFETCH_ABORT;
     } else {
         bool gcs = regime_is_gcs(core_to_arm_mmu_idx(env, mmu_idx));
@@ -346,11 +350,18 @@ bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
     }
 
     /*
-     * Per R_XCHFJ, alignment fault not due to memory type has
-     * highest precedence.  Otherwise, walk the page table and
-     * and collect the page description.
+     * PC alignment faults should be dealt with at translation time
+     * but we also need to catch them while being probed.
+     *
+     * Then per R_XCHFJ, alignment fault not due to memory type take
+     * precedence. Otherwise, walk the page table and and collect the
+     * page description.
+     *
      */
-    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
+    if (access_type == MMU_INST_FETCH && !cpu->env.thumb &&
+        (address & 3)) {
+        fi->type = ARMFault_Alignment;
+    } else if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
         fi->type = ARMFault_Alignment;
     } else if (!get_phys_addr(&cpu->env, address, access_type, memop,
                               core_to_arm_mmu_idx(&cpu->env, mmu_idx),
-- 
2.47.3


