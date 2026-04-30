Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F0FFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINr2-0004uI-Jd; Thu, 30 Apr 2026 05:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqn-0004dw-K3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqi-0002Tc-7H
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:29 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so612042f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541897; x=1778146697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFFUBwd5+aMPX9c8MeW3RKBPUCvj4D64vvXRmnvq3Ag=;
 b=wYzPFoAUVZgvi4uNGx7brV4+KhEelIRb5GY/M9EDbdZotK73VFGZQyeAhsNUMhj0bH
 CkB7t2+4QMUgaEGbYuGu3eR3R+Q+AmiNgPtJcoP4P62B+iBqy9VDPWERholB1SVtLi6G
 h1dlnjTVJsL7kY5J5+fby4Ha7zJy0sS7oPTjcIijShZ/j/cwNcX7gkLdBhMO510HxBS3
 I5oAJBvNHkIkpHRpGn9iN4tuoqIgaVMvt+sUeQr8rTtm6dMz+oFajiF0nNJqky6Lbg0v
 efJ9IgPUFbq4dtmrAZ5DRZ0kP2GLtty7TZUM4YSXqlwmkasYvh0f05M7XDjhAy6NLyJL
 iK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541897; x=1778146697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KFFUBwd5+aMPX9c8MeW3RKBPUCvj4D64vvXRmnvq3Ag=;
 b=AVu+uPyZDvlEnJaaAN11v4xm0scDDmdASjmWJjPVvJW/0YkHCt2898OUzNqf8xJEpN
 g+QghO6O7s1lOUgd+2S7hWvX5MVdqyuVnVIo0l7TV2CtSkEtvRJyj3AU5nusDcfhf/Fp
 +dF9GNSFBIHzd0DH8fEXdyWstVe/2ONzM0t+CHaAWZLBnuVjEpS86w3tiJXTUTa2WmBJ
 WfxKavVi4kmHZm5kDnwT12nzmBwcLfBZHtAijV5QQ/uUzcSrG56KMRpH5eKg8AC9URX7
 lvxZPz8VIzMjztHl86vbSpaDlfL/8HyKBlsHX3Bp/6AjBPxybDxizk3w7DTOYkG9bsdo
 llAg==
X-Gm-Message-State: AOJu0Yx4bgduG2O7QBGxg50I3wtb59B+YKCtZh2rU35slYJztN0E3WNa
 11p4ru0DJY9ajaE29fbZNvqT/z9BE2L7ZVP/8V1E4Qru8ubiMqoP+nl0uD/tRJJA8XQV05XJ+qv
 K/vhi
X-Gm-Gg: AeBDiesq3Kody4fI5WK/3wvZUPrMO9/gNhuVEg5DlHGVGzx5FkoQYjWXYfitSXLZdE0
 aGy17mmGsn7yhFp97dzinjirCnwD1ULnCbT7SBIwOs1BjJ6BlB+rqK7RQyj8tRD0c+Con6QDNvQ
 RohHtczXoIkpkk5iv255EsQsKxqZySkBG+ztKfcYFZpvsm6VWTOm86yF+DG9t9T+XmzqlWbBemN
 GCr+Mr9sAtsK5OFDFcMTUxhiaT7XTDx5L3Vxx+RBd21KSJ+fLb6fzYlEtYkhifOtIWIShNjOnWW
 wFS4XZk5VbJgOHIUUtal3KGW9/p3xYWmdko+5SGM3pG/aDnqL8II5xrpxMPT5nUjnG+bas5Tu2s
 qVNRfNxvJzWTelSyBahL4n8SUR9e8cKVOvNq+ktc/todqEs1dOetjSh4/PQHmK9LZl3NnPzIrV9
 op+rmglc/fy1tFRAOeKra4lkXp/6FNIZAY0VSfIrP5jRdDurSgOtxAhyLk4XAIhE2O7ixJdLpDM
 8lj/FC23w2qgaB2tAxKfeOaJ0lQYEGaQw0tm1i52Q==
X-Received: by 2002:a05:6000:2681:b0:448:69c0:8da0 with SMTP id
 ffacd0b85a97d-4493c28a81amr3534235f8f.7.1777541897052; 
 Thu, 30 Apr 2026 02:38:17 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:16 -0700 (PDT)
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
Subject: [PATCH v2 04/25] target/microblaze: Make get_phys_page_attrs_debug
 handle non-page-aligned addrs
Date: Thu, 30 Apr 2026 10:37:49 +0100
Message-ID: <20260430093810.2762539-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Currently our implementations of SysemuCPUOps::get_phys_page_debug
and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
non-page-aligned virtual address and returns the corresponding
non-page-aligned physical address" and "only returns a page-aligned
physical address".  This is awkward for callsites, which in practice
all want the physical address for an arbitrary virtual address and
have to work around the possibility of getting a page-aligned
address, and it doesn't account for protection being possibly on a
sub-page-sized granularity.  We want to standardize on the
implementation having to handle non-page-aligned addresses.

For microblaze, we just need to remove the explicit rounding down to
the page boundary that we were doing in
mb_cpu_get_phys_page_attrs_debug() when calculating the output
physaddr from the results of the MMU lookup.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-4-peter.maydell@linaro.org
---
 target/microblaze/helper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index a1857b7217..da8abe063e 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -284,7 +284,6 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
                                         MemTxAttrs *attrs)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    vaddr vaddr;
     hwaddr paddr = 0;
     MicroBlazeMMULookup lu;
     int mmu_idx = cpu_mmu_index(cs, false);
@@ -297,12 +296,12 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     if (mmu_idx != MMU_NOMMU_IDX) {
         hit = mmu_translate(cpu, &lu, addr, 0, 0);
         if (hit) {
-            vaddr = addr & TARGET_PAGE_MASK;
-            paddr = lu.paddr + vaddr - lu.vaddr;
+            paddr = lu.paddr + addr - lu.vaddr;
         } else
             paddr = 0; /* ???.  */
-    } else
-        paddr = addr & TARGET_PAGE_MASK;
+    } else {
+        paddr = addr;
+    }
 
     return paddr;
 }
-- 
2.43.0


