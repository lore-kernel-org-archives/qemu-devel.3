Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA0ACAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yRQ-0002O1-Vg; Wed, 01 Oct 2025 11:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yR3-00023i-3R
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:08:05 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yPe-0000kY-QD
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:08:03 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3f1aff41e7eso5518917f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331188; x=1759935988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HoIBFbfrsz0t0Xevzl+WovcI4TEmiT7XaJGhm9ak06U=;
 b=nlRfxxewELkEOoBWYOA6cRJ89bc1Z59JARKf3fadJUd/Ph/WL0EPsLYlsO1spmPER0
 yJ+trwz4rBlfLMd/aHhbNnzGrPq1gfW7EF0kRB4L5uehy7ciqhqRXjrjEeIrAvI9Yvtz
 h5sGzM98beDX1e5FiUhRZC4f/V+mRO05sbvgWxJ/mJ6hykC8tbvEs7TplkBJHAGCvaLT
 4nJ2aGANSuliJWXHgiavbtgdYnOazKL10ga6ieuLpWFjxLUr/2bJDFL5VrWcxqBcjnch
 MavihMDuj8OvI3r9oVMkSZkbaaKS0IpUHTfeL6ExoXrbGxx4R9phWaMMl9kILfurr4eC
 rzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331188; x=1759935988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HoIBFbfrsz0t0Xevzl+WovcI4TEmiT7XaJGhm9ak06U=;
 b=URbWs/Av9Jksf4FiMZ11Sku05UqAq2MykQDJoy2bR4CX7JQGyN6gVceCBzy8xnlhVo
 KaqoIkhMad06jmASegNtPIA33nfTX0QFCv8++vbLVdXA7NcWqRdeRF+V/Zi9UDvLjuLK
 BGyLcKU7PygHTL9aPm2urYAeI44TdMnNsHZS+Fv/rm4R2ixP/77pbdjYwElrBiMUtkLx
 MNoppDtJqcRVn5yKmXYT/G9d1/PpyqTYNzVq6HG3pcwm73xUyFC9GT3NixY8SFwghvyy
 DdPhkYUFnyMWVwFtUJnVEVea5wqRt+Z2A323uUZWZuWF8JUswOCzK1AUi+fsX5q7R893
 fbOQ==
X-Gm-Message-State: AOJu0YyhiyzbJD2MbKfeDOAc/2ni54rJG9YLZm5HgzTpS03+N//a/Ind
 PrrJxlNeziEQC/Dr2V87Y3z3vt8EivpwnC/3ZSOnQwSgnisxUweDo1ileyaCpLOZzVhnjSd2TPq
 SFvjwHs5ntg==
X-Gm-Gg: ASbGncuaEHwDHW8LUQ240n4LRY4qI5Sh3vATo98MXp1TG7aj0GTtZH4Q5tL0FuWWXMM
 4wqY0SNEhZgt8DqBHVqRtSdyZvI7RjqPC6Z+qcLSdweITFF3ZRY3na9KWoDPUDPGaBYKQ9iYfsF
 twcGYwJP6fKFJXS76bCVzK4DNRP/vxpEFK3xzsYPOMecwQbG8aVpFA7qrwWWSqQftaSWfpUyIER
 4uHVvRjThgrlMU/SfAoiUN5dEmORXnx2gWFiI9/gi5STis0FTWhGbE+qSJ1L3jgegtH8UUvZW91
 gu1t85PG6ncVqFU1kG47epGILOLVjymto5O9XEEY1R991TnSULWCCVIxQZxKnZ2vaGNAi74HbjJ
 6sHtRM52wzsvI6nL9axB3vanLRAyTYSfKpfI6wzaHMzE+VhjWV3jPXixTQV23EkdUgtAYANBvkt
 ZTp4geqNLb/DVBM47gbXSX
X-Google-Smtp-Source: AGHT+IEJ81qtfG04DHe/4mEazGBmhdqjREcWngyjsG2pu87Vb24G+7/Rah+ejZND5Mr0zO8mHcd6Fw==
X-Received: by 2002:a05:6000:2907:b0:3e0:2a95:dc90 with SMTP id
 ffacd0b85a97d-4255780b9dfmr3190951f8f.35.1759331187866; 
 Wed, 01 Oct 2025 08:06:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb9e1b665sm27390018f8f.27.2025.10.01.08.06.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:06:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/22] target/arm: Get cpu first addr space with
 cpu_get_address_space()
Date: Wed,  1 Oct 2025 17:05:16 +0200
Message-ID: <20251001150529.14122-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

In order to remove the convenient CPUState::as field, access
the vcpu first address space using the cpu_get_address_space()
helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 30e29fd3153..f781d1cfd80 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -371,6 +371,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
 
     if (arm_feature(env, ARM_FEATURE_M)) {
 #ifndef CONFIG_USER_ONLY
+        AddressSpace *as = cpu_get_address_space(cs, 0);
         uint32_t initial_msp; /* Loaded from 0x0 */
         uint32_t initial_pc; /* Loaded from 0x4 */
         uint8_t *rom;
@@ -439,7 +440,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
 
         /* Load the initial SP and PC from offset 0 and 4 in the vector table */
         vecbase = env->v7m.vecbase[env->v7m.secure];
-        rom = rom_ptr_for_as(cs->as, vecbase, 8);
+        rom = rom_ptr_for_as(as, vecbase, 8);
         if (rom) {
             /* Address zero is covered by ROM which hasn't yet been
              * copied into physical memory.
@@ -452,8 +453,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
              * it got copied into memory. In the latter case, rom_ptr
              * will return a NULL pointer and we should use ldl_phys instead.
              */
-            initial_msp = ldl_phys(cs->as, vecbase);
-            initial_pc = ldl_phys(cs->as, vecbase + 4);
+            initial_msp = ldl_phys(as, vecbase);
+            initial_pc = ldl_phys(as, vecbase + 4);
         }
 
         qemu_log_mask(CPU_LOG_INT,
-- 
2.51.0


