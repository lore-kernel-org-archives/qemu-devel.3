Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601E4C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 15:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Llr-0000e2-OS; Mon, 14 Apr 2025 11:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4Lll-0000c6-M2
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:30:47 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4Llg-0005Ww-47
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:30:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-224100e9a5cso49881015ad.2
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 08:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744644638; x=1745249438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4SqoqmvVYlXEDRZUedwlOctIZe+hPz1e3t31K5AGbao=;
 b=OlpKuW/qcVOJZo07lpE8ZAQv1sPSBfhTJ1uq/Xva6nIezXpdHNchFP+YFciM+GNPyE
 mehP4HgEa5O32ASMhEySa3GMEPdVC3dIQOHVwuHMEyk/O7oVinbhDoyQEdwhSEfCrpTY
 wbrgmjF+cGeWClJx6IvBKRs4FsvUoxj3MqvMsHCMfmd3pWrJjlfrrGaAe5DP3NUORPd2
 gHgeM+K8MqGzYBrM4OPaV6NOszRczcKAwSo+UiBIjGnbeE7SpkLlwqlg3U76EsYqEp/H
 haz+ZfRvWD9XZNwzKSpjyzbmZdh5khtzgGaE117iVKRPxAH1jpcNZ+v3DFvCC+H4Dq2w
 NqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744644638; x=1745249438;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4SqoqmvVYlXEDRZUedwlOctIZe+hPz1e3t31K5AGbao=;
 b=PCttENQiOc1B2IQH/V4aLXaoEPYA9deMWtL5FDbWvOqfn4VHJys/G0snUCPOEFozna
 Uk+uJgO4MFuJweyXKB6qqnWR1g8NMIcJbhyApJqeVNwt0V2jteYu6Bb1/mevIQf3Xon/
 ea8CrMRUyhUzWjMAzn0IT5ae3ptuhSvxcnWDL/ZjM5CahpaAZj6x6IAWS0q1dG0eyaI1
 57ovTfUDcTKTO8d/KEDaPIabF+3OXVmU+bwRZqCNJPAXNp4vi2Z6D+Pt06oFwOSWl9RQ
 G2LDygHxOXfCfW52tQuwAXq/L5W3x18ruosI8XjNjlBN5xPW6IfT2gHAcspMUZaALvBX
 Pq0Q==
X-Gm-Message-State: AOJu0Yy3ECubX+DZswULmV/Z4zf1hO82LnnvhkznnvTRfEqZNM/tlN1Q
 SY0eLOvPtmPNvutxB7eFreDcVztIoe0eJSqVTpRc1FeVYk+07d9t4Vp5GxOPF1zVSqe/s3SdH5j
 i
X-Gm-Gg: ASbGncvZYBSIInM277dXEr08t4YCJqqSvxdtPH4lUMOeROStZzdY0/a5RpuMp0iflWF
 Uy1lN1cYcIWzgBMT11Lo1p5MHZTLlVlSQ+Emni4fPFb3+lC1p7mVh9wSVy0/VGCknIt9mBP2ulk
 5mGBc569SwxjHbWCZWoFB7bReZfiHY/tjDGksWa0PM/H7jZzHtUGyeqSU4WZh6Az0xgqrUIzUYk
 H1IMwBpI63sPPLUl2U2LqLLFt3ooHtwvhf7GDI+mrLqIstcEGhUWQ56LOAqhAM7fwJhq9Ltd5MI
 2SFf7+XOsiXBjve9w0ToMfm61XHdEEZFgTw/bqEIynObvUQ6JJA=
X-Google-Smtp-Source: AGHT+IE+WThX3iTgzLGFWycKu9s66OhSD+U0uZaflp9uYDQ89fxzN5FXdyPxmZmpAd91a7//Qj6vQQ==
X-Received: by 2002:a17:902:e886:b0:220:e362:9b1a with SMTP id
 d9443c01a7336-22bea4bccb2mr190376515ad.25.1744644636183; 
 Mon, 14 Apr 2025 08:30:36 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm100735235ad.248.2025.04.14.08.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 08:30:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 Yannis Bolliger <yannis.bolliger@protonmail.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 0/4] target/arm: fix arm_cpu_get_phys_page_attrs_debug
Date: Mon, 14 Apr 2025 08:30:23 -0700
Message-Id: <20250414153027.1486719-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

It was reported that QEMU monitor command gva2gpa was reporting unmapped
memory for a valid access (qemu-system-aarch64), during a copy from
kernel to user space (__arch_copy_to_user symbol in Linux) [1].
This was affecting cpu_memory_rw_debug also, which
is used in numerous places in our codebase. After investigating, the
problem was specific to arm_cpu_get_phys_page_attrs_debug.

[1] https://lists.nongnu.org/archive/html/qemu-discuss/2025-04/msg00013.html

When performing user access from a privileged space, we need to do a
second lookup for user mmu idx, following what get_a64_user_mem_index is
doing at translation time.

This series first extract some functions, and then perform the second lookup
expected using extracted functions.

Besides running all QEMU tests, it was explicitely checked that during a linux
boot sequence, accesses now report a valid physical address inconditionnally
using this (non sent) patch:

--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -997,9 +997,7 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
     if (enable) {
         address |= flags & TLB_FLAGS_MASK;
         flags &= TLB_SLOW_FLAGS_MASK;
-        if (flags) {
             address |= TLB_FORCE_SLOW;
-        }
     } else {
         address = -1;
         flags = 0;
@@ -1658,6 +1656,10 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
         tlb_addr = tlb_read_idx(entry, access_type) & ~TLB_INVALID_MASK;
     }

+    vaddr page = addr & TARGET_PAGE_MASK;
+    hwaddr physaddr = cpu_get_phys_page_debug(cpu, page);
+    g_assert(physaddr != -1);
+
     full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
     flags = tlb_addr & (TLB_FLAGS_MASK & ~TLB_FORCE_SLOW);
     flags |= full->slow_flags[access_type];

v2:
- fix style in first commit (philmd)

Pierrick Bouvier (4):
  target/arm/ptw: extract arm_mmu_idx_to_security_space
  target/arm/ptw: get current security_space for current mmu_idx
  target/arm/ptw: extract arm_cpu_get_phys_page
  target/arm/ptw: fix arm_cpu_get_phys_page_attrs_debug

 target/arm/ptw.c | 65 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 17 deletions(-)

-- 
2.39.5


