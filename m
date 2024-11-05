Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78F5D3E779
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SNz-0002mK-MB; Tue, 05 Nov 2024 17:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SNF-0001Nh-Up
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:50:15 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SNE-0004hv-3X
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:50:09 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4314b316495so51667775e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730847006; x=1731451806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TbSSd/840jPsVgWX0pStPW0nEJn+X/GCmpvm44win24=;
 b=EECfkcwkAxNCMR/MiHY3N0aJlXQsRYlUAph1wFlbcDVKJRmZ3cg53oOVen73UOk6I9
 uTetepSB2EbH/voDpoyoV4RQR9EzUifcNo9gTX8EmghoBBIFYegLamLiQ0gyauvDzpJv
 Z6/YfwKPWStxeXBBXKcIYJCGRZ3saroxIKZxbQdI9e4uLDw7ALKn1hz5J6eQJvR5kH10
 8FvGd34kBk5Hw/ZKORpQlkILuHgk0/LslFMuYG2Iw1kOrO8Dor9GOTGTyPOrWST+KLVz
 grYFc9ZCth6JqXeiLrh63JDdzrS82HUi3pN0tixefiqI9h01rCfv5V2y+hCtVqy2agNM
 nDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730847006; x=1731451806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TbSSd/840jPsVgWX0pStPW0nEJn+X/GCmpvm44win24=;
 b=ap1SOo0EkHAXdUdNs55HMG0HIwvCEJhxcWzVjuiyxv8yz9jyPtlFeYvhJsCBVAhQor
 qEg4pERot+TBQUQXnyqjuQPEjPU+fKDQdNiUM4U6fLKC6r4AEVrrRk57fo6V5zm6NYvo
 E/tln6u0ytt4k2S5iNqO9MvR00kVDxF+7YCx88NVslK9XNkf6n4IYBO36XAA2idj9nfy
 yKvU2ymNXEYH8/bVSfDXmKP9ZVb4UaeJAi5algAFUH9DlfUdctdqSqxS8OTLFtw7XcIg
 vNN4T3q9BzlRJFzNv9l3XOeGqErsNBBPTFcfuIy7hE5KpuFiVQIhEzMi27t1AdyesopM
 S7zw==
X-Gm-Message-State: AOJu0YyMTm6lZeyoEk4xsTo/RrN4ovTTv5wcpxlSbmzmFQbhVAp4JOLY
 Mw75yvARYbkb1ynC6lOzfbgPGAVhk247oWUSkdESP31PZB5Sw/SByqJtuWnCkNLujUzmH6Pcuch
 omgE+dw==
X-Google-Smtp-Source: AGHT+IE0QnRg8tJh19IChvu2LEOfF69pmeuNDGgYY85CMiegX36PG+Ty5YBayIz6STykUCqThONM6g==
X-Received: by 2002:a05:600c:548d:b0:431:60ac:9b0c with SMTP id
 5b1f17b1804b1-4327b6fd376mr175516275e9.20.1730847005796; 
 Tue, 05 Nov 2024 14:50:05 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7e2dsm17338602f8f.11.2024.11.05.14.50.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:50:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/29] hw/riscv/iommu: fix build error with clang
Date: Tue,  5 Nov 2024 22:47:27 +0000
Message-ID: <20241105224727.53059-30-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Introduced in 0c54acb8243, "hw/riscv: add RISC-V IOMMU base emulation".

../hw/riscv/riscv-iommu.c:187:17: error: redefinition of '_pext_u64'

  187 | static uint64_t _pext_u64(uint64_t val, uint64_t ext)

      |                 ^

D:/a/_temp/msys64/clang64/lib/clang/18/include/bmi2intrin.h:217:1: note: previous definition is here

  217 | _pext_u64(unsigned long long __X, unsigned long long __Y)

      | ^

After a conversation on the mailing list, it was decided to rename and
add a comment for this function.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241104222225.1523751-1-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/riscv-iommu.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index feb650549ac..12f01a75f5d 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -183,8 +183,25 @@ static void riscv_iommu_pri(RISCVIOMMUState *s,
     }
 }
 
-/* Portable implementation of pext_u64, bit-mask extraction. */
-static uint64_t _pext_u64(uint64_t val, uint64_t ext)
+/*
+ * Discards all bits from 'val' whose matching bits in the same
+ * positions in the mask 'ext' are zeros, and packs the remaining
+ * bits from 'val' contiguously at the least-significant end of the
+ * result, keeping the same bit order as 'val' and filling any
+ * other bits at the most-significant end of the result with zeros.
+ *
+ * For example, for the following 'val' and 'ext', the return 'ret'
+ * will be:
+ *
+ * val = a b c d e f g h
+ * ext = 1 0 1 0 0 1 1 0
+ * ret = 0 0 0 0 a c f g
+ *
+ * This function, taken from the riscv-iommu 1.0 spec, section 2.3.3
+ * "Process to translate addresses of MSIs", is similar to bit manip
+ * function PEXT (Parallel bits extract) from x86.
+ */
+static uint64_t riscv_iommu_pext_u64(uint64_t val, uint64_t ext)
 {
     uint64_t ret = 0;
     uint64_t rot = 1;
@@ -528,7 +545,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
     int cause;
 
     /* Interrupt File Number */
-    intn = _pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
+    intn = riscv_iommu_pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
     if (intn >= 256) {
         /* Interrupt file number out of range */
         res = MEMTX_ACCESS_ERROR;
-- 
2.45.2


