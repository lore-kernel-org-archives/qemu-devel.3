Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A56C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp8za-0003hc-Ix; Tue, 26 Mar 2024 11:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp8zZ-0003hQ-6O
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:45:37 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp8zX-0001AK-NZ
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:45:36 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-341c7c8adf3so2024958f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711467931; x=1712072731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDGvrX1ZbW/accSdyb5WOkWj9+BF/HkrY2XWDQDRR/o=;
 b=CrKUvdeHFUIn/1DnLxGPmmixXaab6TmnvtqQbb2v0FB3q0WBtRyWJqUDO6rnR/u/jA
 DUnHO4XfvAckIOmygLFv1bqwDwnY3zTFvHbz47o+UoqnrX4rtXeJQ+zkIPp5sQr3Mj+H
 Ra1gsq2hkB6v8YHv+rGKlXADiZzdGuGHSzIv6ksgCynriOa4+2uYP6d1x60SSFW+V3HS
 x1v43Tbi5CRej0jpmdadwJvILvzUjoWV5l88i80iob3Hgjtg7BZuA4FPxxpiwO0Ow4K6
 wvQ3aZio4/CmgkufCmTG31VG2k+yCD2bDXV0T/9/s7V+638p82/PsONUEzwyFpZ6yvWe
 GaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711467931; x=1712072731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IDGvrX1ZbW/accSdyb5WOkWj9+BF/HkrY2XWDQDRR/o=;
 b=C88VWTVGtvH/b+TzrzVs2TG390coQS954b0Y8GkZuJvVxzNASg4yAcKqdq31Xak6CC
 M52rROC0sY23li6PYaWzVumy13lwaV0+t3dmJNee7pLv3/eg4NaiYHRq9E/lsO2voV18
 c7sz0QuIwH24XXiMccVZokS/Ga7etoEZNu42XZnCEy831fR4rKUxT1/5HDr/Rtjfx32I
 QvwJF7xe8U+11A6Li3g74NkMRfNDmkO/kZSVG0pazZCkiUEOJkgFS8TpmfJyaO++fWP0
 bo9jRcbv687mMyuKbdlSjPe/s8s8QaFHA1LYx/H5SfKt2UK1TgOGjzWRKYlbWP4M/hTt
 xrbw==
X-Gm-Message-State: AOJu0YzJJiq4IJFBHKYmkbHyzR0RjtBEvV8VeTr8NyL2r2NTobOM/O0M
 t+rJbIktJzKLwrWluGyAZheBa0Ke7Bz8O6A2CzHGN7FI+5oHNnhs64l4I3FwBka7kUKLeTnqc+p
 c
X-Google-Smtp-Source: AGHT+IFjCgXQ0kboXlIItHE5pn4+DVJBuuH9FSd4TH1/vwbksJnhtefvws+bYIlE+GEq+/vOocYLvw==
X-Received: by 2002:a5d:67cd:0:b0:341:c000:5f02 with SMTP id
 n13-20020a5d67cd000000b00341c0005f02mr31090wrw.7.1711467931613; 
 Tue, 26 Mar 2024 08:45:31 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 h8-20020adffd48000000b0033e9d9f891csm12447332wrs.58.2024.03.26.08.45.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 08:45:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PULL 04/13] target/tricore/helper: Use correct string format in
 cpu_tlb_fill()
Date: Tue, 26 Mar 2024 16:44:55 +0100
Message-ID: <20240326154505.8300-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326154505.8300-1-philmd@linaro.org>
References: <20240326154505.8300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

'address' got converted from target_ulong to vaddr in commit
68d6eee73c ("target/tricore: Convert to CPUClass::tlb_fill").
Use the corresponding format string to avoid casting.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240319051413.6956-1-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 6d9e80cc0c..76bd226370 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -76,9 +76,9 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     ret = get_physical_address(env, &physical, &prot,
                                address, rw, mmu_idx);
 
-    qemu_log_mask(CPU_LOG_MMU, "%s address=" TARGET_FMT_lx " ret %d physical "
+    qemu_log_mask(CPU_LOG_MMU, "%s address=0x%" VADDR_PRIx " ret %d physical "
                   HWADDR_FMT_plx " prot %d\n",
-                  __func__, (target_ulong)address, ret, physical, prot);
+                  __func__, address, ret, physical, prot);
 
     if (ret == TLBRET_MATCH) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
-- 
2.41.0


