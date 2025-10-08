Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA8DCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NF9-0000q5-31; Wed, 08 Oct 2025 02:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NF6-0000or-Ec
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:01:40 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NF4-0000Zv-OO
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:01:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e6674caa5so2725065e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759903296; x=1760508096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JDjZ8U4cTaxg8aqx2zZG6gVloPONIY9wFGLLwdhXBOY=;
 b=h4nuItB7lV/tMDDiQeN/TsLdoZluzoFDICU2Somtxh3gOYVrF+ftVJVw66ejB2YfZs
 j3D9pKeTx/CTxuwkjtOPFN1GzGBsV8YRQOwV+g901BzNQFMSKNyCq0mo1FT6FyIKXxOk
 d5enc4TuXPgOvYly2CEx+uNQQAERxKViNAtQVYJkQIpFGbMJyjT0LATry51LhNopf++y
 AROWIe8L+jR+WqK7Ky9KJbFX95AqjSfoqTe05gZALAp0xhhhACYgIN9KC1y9+276vDpq
 ay48A9HhX7vNV2yy7OS0nbpz70BGozCPEGhisqXzFd18CEdGUqrtC9TQc486N+gwrGKk
 fUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759903296; x=1760508096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JDjZ8U4cTaxg8aqx2zZG6gVloPONIY9wFGLLwdhXBOY=;
 b=NxGAdux1o3ULWIXUcsiM0R/UnpmOb6YdA1enlAyiJ73NMKKqRSMUDJaOPAzzf3gv2g
 JQlFv3na7ZbJkMzSyDnRc3Tfdj5nJtNykdzauzdassT3n+es7v3pzcH4rcxNS5mOfWFu
 JJV29MZVbDer+IIhTrirtm5jFlaN4Ojm40uX4S0crxsLN5//qG84iHo/bilMdNhM/P/L
 tpzjSZ82zsXPzRDStwaaFuJaLGnn08Pg5/TXZZu2Ln1W9ysxTyu06Zs4U8RxslGT+s8N
 AP+hmev0j5qmo99/yLgG0V9Ujp4ogA5GqI1s7tFpiIFEfeHa5rlwowoi2GnVD7ryg37S
 yahw==
X-Gm-Message-State: AOJu0YzhB4gZMHy+UH0ACZWi2/73MgAH0tIEDYBdkZORhIX/B5awOKo7
 F6O+BSGTW18MSI5kdfRLazfzQGTpAB6osCIPtYZXNsx83BOCI18nvf6HcEcGUXR1Wn3zbgcIUOE
 WuHd/U/00mA==
X-Gm-Gg: ASbGncvWclOQhbu2X4D84GdvL8gjwuuV1S/AtPWRB/qpGHc/XnDgFVDbdIV5uavgXc/
 V3pKybirhGxeQki5/veUUSOMz/8ybksIfREZ0V9q8jmMjV/Snak29prz1bLEuqzuexkNOEIiK/R
 APf3CHnoHLrEusHUIYqjLmvFe8cRdrkHQYhv6QY/L8NvUP1rNQBAIsweqdUpUskrjcauOTqP+HQ
 R8/O20y91vOGHAe6kp7uqXDuyP3SPDAwUW+AHUS3OPliU1uWPtzJK1VWZIGqVn5xUs7vWRdAwiM
 iyCcQy5FOKDHNEexABkCZ78gLrpSujXR0Qg/1HAGenaPTrpU5Pr0hk2h8SgK2E24/j1SCP2QMuv
 GqeqSseDwzpqrf5R+82wBuDad+tmst3U0mjpI9Ato1imy3rn30RyBkArfXcMWa1KhoaR2bi4hr3
 z4ugNpUdXKgVJF7ZD7nrfKrdAV
X-Google-Smtp-Source: AGHT+IHoxOTGeMTYS+ZRcW8wNxZDTkxNrX/qIW+HqcPnHGBOtByIpdsxs79Tg/Z2oz5rMUwspPLezw==
X-Received: by 2002:a05:600c:a105:b0:46d:83e7:45ec with SMTP id
 5b1f17b1804b1-46fa29e1e0amr30050495e9.11.1759903295881; 
 Tue, 07 Oct 2025 23:01:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9b622cdsm22729895e9.0.2025.10.07.23.01.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 23:01:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] target/microblaze: Remove target_ulong use in
 cpu_handle_mmu_fault()
Date: Wed,  8 Oct 2025 08:01:25 +0200
Message-ID: <20251008060129.87579-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008060129.87579-1-philmd@linaro.org>
References: <20251008060129.87579-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

cpu_handle_mmu_fault() -- renamed in commit f429d607c71 -- expects
a vaddr type for its address argument since commit 7510454e3e7
("cpu: Turn cpu_handle_mmu_fault() into a CPUClass hook").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/mmu.h | 2 +-
 target/microblaze/mmu.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index 1068bd2d52b..2aca39c923b 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -86,7 +86,7 @@ typedef struct {
 } MicroBlazeMMULookup;
 
 unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
-                           target_ulong vaddr, MMUAccessType rw, int mmu_idx);
+                           vaddr vaddr, MMUAccessType rw, int mmu_idx);
 uint32_t mmu_read(CPUMBState *env, bool ea, uint32_t rn);
 void mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);
 void mmu_init(MicroBlazeMMU *mmu);
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 8703ff5c657..db24cb399ce 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -78,7 +78,7 @@ static void mmu_change_pid(CPUMBState *env, unsigned int newpid)
 
 /* rw - 0 = read, 1 = write, 2 = fetch.  */
 unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
-                           target_ulong vaddr, MMUAccessType rw, int mmu_idx)
+                           vaddr vaddr, MMUAccessType rw, int mmu_idx)
 {
     MicroBlazeMMU *mmu = &cpu->env.mmu;
     unsigned int i, hit = 0;
@@ -172,7 +172,7 @@ unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
     }
 done:
     qemu_log_mask(CPU_LOG_MMU,
-                  "MMU vaddr=0x" TARGET_FMT_lx
+                  "MMU vaddr=0x%" VADDR_PRIx
                   " rw=%d tlb_wr=%d tlb_ex=%d hit=%d\n",
                   vaddr, rw, tlb_wr, tlb_ex, hit);
     return hit;
-- 
2.51.0


