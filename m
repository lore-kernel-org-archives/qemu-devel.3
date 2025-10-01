Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA76CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yRs-0003Ef-UJ; Wed, 01 Oct 2025 11:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yRR-0002O7-2y
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:08:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yPn-0000lq-C0
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:08:24 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so50916465e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331198; x=1759935998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKIJiurQy11fAb1+UubMdJKdkBS0bnFi1raQMLM9p9c=;
 b=AhH6UJyKzJ4WpArAUUL0U1vvEImeSuuIptLL2G+HK53UsIuyW0sYHTZaIFiFQSeh3Z
 z+fRb5fPBvaRCDJZgfAez62yhwxKSBsAvO9y7CR/vgr9zX+WKARq8y6J5/Jd7KVD6Lry
 cRJPOzHmfWHpKmEzgO6fHDlGwhg/EPQ2R9RMUEXYRQTAhZaenPRhTn8NICz6koEjAHmn
 TX1rkz35Inj4mPIDJ+6IA3RyCQ7fCEl4SmunH0mVPd/IolfGt/Si53Rcc796uffMMJWH
 3dBIRKxNu1C4rRzKhy34unlLH4C5WMqQFRctZwjArlfcBnGnm0z8MRsPJuH0d2vr1zkz
 cY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331198; x=1759935998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xKIJiurQy11fAb1+UubMdJKdkBS0bnFi1raQMLM9p9c=;
 b=LuBuvTVcZW6rhKsvi2phIEhfm0tcEfx7B/CX2+bjIr21JmOcLknjA6/ThLPXxtiT2B
 BNQiawIS3BMBjw+EYKtuVZMmmxE5ZldHbxZKQiFrvSy2TCcJH4xdT6rY7GoNbAH5fPDu
 Jcbw4A4Faimf/dl/hythqKQz8/yZ3RTBRTvc++zXq17aLz0UHq0DVims3VT02d8kQq3K
 kVYrIOy0zNxBfGj2gRCicBgWuH9k3nhyw0JGYwsIbllBBF25+YXY9TBQdGA0DezIsPt5
 LaOHfZnL/UIdernG9Xnqckn45ECTui1ONmEnahpe3UzgQp4VNFFhHAQOH75/BE/KwOqB
 K3Nw==
X-Gm-Message-State: AOJu0YyXXXrbYnWrmn2bS8rqypPprTA49zOmlk/ea1MCQTZxhSzAJQ0t
 GK50yMcds+lEOtZ7jiCNxcs8qu8sXTiOrNILH5kb6AWTwF31Q3Z4zF4G16iVHQVvKM7+T48EZZi
 HnOFNucBxDg==
X-Gm-Gg: ASbGncsWI7XQaGB6G+2DluI/efOp5QpLT/AkrZsfBUhZtGR4t2tkIGU1/Em5r3fI/0q
 Z9i9qhU4GRwjK3XHu3XvqHaGQuB0XoP9GGZMCdIKfgk6d/yVMx0mFHlvQxVzsEm6MBhZYUtPP7H
 ToqnLXud+GdZxhs8WyQOUASR+6ix4h9O1TuMhOrgKUo3nvJedkw5eNgEXmmWkfaVG0BciYfnJ43
 HpI0eQFA9Oyz4F+N1zXscQh68ZKwm85i6pKPIrLuKVbFe4KeseqoSZsviRzHcBpaHA70ndTfp50
 386grSjRV4t4Q1vHYxsI3ydV2jIpb27c8lj8kZwSpX8ItEoVlzgQRrDsccmLpcGsZ6xEt94EoN/
 b8+qyIGzb6GhEur1iM8+rHtmNLFwxJHTemWZdqBGpmuLlCXgR+gyt5EkfIFXjyzMGS08qD4Do06
 tsn3uYBHY/tm5VSSncPcMZ
X-Google-Smtp-Source: AGHT+IFyi3wB+ED6O52P0EVUdsoFZprWN7mLrwrybDjTk8VfikX41h8QHP87F214i0CStGpv2q5UhQ==
X-Received: by 2002:a05:600c:6094:b0:45d:d88b:cca with SMTP id
 5b1f17b1804b1-46e6125cf67mr30485905e9.1.1759331197898; 
 Wed, 01 Oct 2025 08:06:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a0241bsm41643575e9.11.2025.10.01.08.06.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:06:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 13/22] target/i386: Get cpu first addr space with
 cpu_get_address_space()
Date: Wed,  1 Oct 2025 17:05:18 +0200
Message-ID: <20251001150529.14122-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
 target/i386/arch_memory_mapping.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
index 560f4689abc..809c4cb0298 100644
--- a/target/i386/arch_memory_mapping.c
+++ b/target/i386/arch_memory_mapping.c
@@ -273,12 +273,14 @@ bool x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     int32_t a20_mask;
+    AddressSpace *as;
 
     if (!cpu_paging_enabled(cs)) {
         /* paging is disabled */
         return true;
     }
 
+    as = cpu_get_address_space(cs, 0);
     a20_mask = x86_get_a20_mask(env);
     if (env->cr[4] & CR4_PAE_MASK) {
 #ifdef TARGET_X86_64
@@ -287,12 +289,12 @@ bool x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
                 hwaddr pml5e_addr;
 
                 pml5e_addr = (env->cr[3] & PLM4_ADDR_MASK) & a20_mask;
-                walk_pml5e(list, cs->as, pml5e_addr, a20_mask);
+                walk_pml5e(list, as, pml5e_addr, a20_mask);
             } else {
                 hwaddr pml4e_addr;
 
                 pml4e_addr = (env->cr[3] & PLM4_ADDR_MASK) & a20_mask;
-                walk_pml4e(list, cs->as, pml4e_addr, a20_mask,
+                walk_pml4e(list, as, pml4e_addr, a20_mask,
                         0xffffULL << 48);
             }
         } else
@@ -301,7 +303,7 @@ bool x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
             hwaddr pdpe_addr;
 
             pdpe_addr = (env->cr[3] & ~0x1f) & a20_mask;
-            walk_pdpe2(list, cs->as, pdpe_addr, a20_mask);
+            walk_pdpe2(list, as, pdpe_addr, a20_mask);
         }
     } else {
         hwaddr pde_addr;
@@ -309,7 +311,7 @@ bool x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
 
         pde_addr = (env->cr[3] & ~0xfff) & a20_mask;
         pse = !!(env->cr[4] & CR4_PSE_MASK);
-        walk_pde2(list, cs->as, pde_addr, a20_mask, pse);
+        walk_pde2(list, as, pde_addr, a20_mask, pse);
     }
 
     return true;
-- 
2.51.0


