Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA79F8DFF9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 17:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDn35-0007Mc-9j; Fri, 17 Apr 2026 13:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2X-0006pY-Ff
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:42 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2R-00028A-C6
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:36 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso624540f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776447089; x=1777051889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFWrqlCi1brlfW31yiVLg0YS3L4+kwC499WIseYpmfU=;
 b=EkhlXqQxl91BNjaPFUB/EqPS9Z+Mxu12h/ijCLv8uf545cW6KH4FpNgfNaR+3e6BS8
 n2VO5PaSdwAHTN8J8FU5TonrFUH/yp3gPRPplxcL7wM1LMUAYse3zlKK77jrSoMBhv6w
 Zp3vSifIWerB7Lw/MGLudoAc8KKmDsfHlzs6lprFO/O+y5hTrDkXMTScxXzh4EQ4/v2l
 cUbqAsfxYYj3eALiGi9HdCcV+VIis10Uz4f38uXxpfviVx8VraqsIp598KlMSiAZ1uiM
 v89DDhmUBPqBOSORuHdNf7iWf3Dbu4tbXCbb2upzPj0IOeNOqBFxWigyFNZ9poOBtsDu
 ahVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776447089; x=1777051889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oFWrqlCi1brlfW31yiVLg0YS3L4+kwC499WIseYpmfU=;
 b=G0/Dt9wn3tAMA+YzkwWaeL/Dh6wD88cQ280eCk5VZBgPoKRunvfbEMcd7okVwdiSZY
 fZd4n8ZMOXVejjrOvY2XMFX4K59oAHIIbXlXBQQMcD32sBQ6MstEAGmTdOn5aFb3j6BU
 m9R3OZsXIWJ6JJ6+JI6fHyWN33XY9E4etmO6i4qsTb2GLJ7jo1AHR6Z9sTq6Fr1W05af
 yZazs8IAN1w9AhOcMTEs0toya+TOgnYIc3xdEc4wQXHliINz0Sx9ltawI7W2FQMa0rIR
 guDAcwwzKQhVMjjZJD4qbUJmEwhegQUiN3nax8ZcCoWeFWsgXgAPqpKYufln9hKE5cXq
 TT8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9g/i5G+51xEef06aNXYzNNF4XmaT/K1JteMBc0SlDDtn+ErKE5PfXJJra71UvE7WmZmXIjMcDEoeas@nongnu.org
X-Gm-Message-State: AOJu0YwaM7E4xY/DtqAXC/HkhBoQbBbp4McjBVO1hdKrXDuL20+1ffEL
 QrsHdlKHNkZNt8ryckDHMpiaiFpzUEGBP8WNVOEmjAPjK55dLZngG+kO0cV6QaBomRlPhBxqktY
 GPxx+ZRo=
X-Gm-Gg: AeBDievjmlb1FMvw7efKYbnuSARvMcra8gPDm95fUCKMBqxf41Bzc1qlTdhbSxJWe7S
 +MmAK19xSCJsRLvXR2lNEdjAMyBbEL9EZ3G7hvM2pql2oih84RbctgbXO/319tlb7XV+zP+0iWM
 j8FNTsTqVGNGoF69I7iQncNxEcChgxpBVUpAR9/eojJE5I+vLFIiENYAkflKC5MSex68EDZpw7r
 LDGRvvEbh9JJwSNv+zSSLvoZJGOm5sT3S3E8EX4TM0/G9oaJi+ZpRHJX1m9lIOmpOjD7oj1USil
 tdedRf0sGt3ot1p/Y16GXJLYb21jKeqFHMT9T9awytiSpkOOrfhJVwFz5KD7yxKRzxg5hg1xJw6
 0vGZvPoy3IPAh6/8RvNUFC4ctaFygHx8hVN6/fR0n4WiVbQJ5+o+T1HN1vT8wksExiQjsw71Suc
 Seupsa4LspJQlYvsNSKMQ5wVOZ7FiMMLLa0jdgxqHdlKt95HXwSKf8ARYlsxsF3tG+ejzARPtZz
 0VKtN2c+9KNM7BcSunBqtCMArLk/2Cwmn9sTpsNJg==
X-Received: by 2002:a05:6000:250f:b0:43d:68ad:3b7f with SMTP id
 ffacd0b85a97d-43fe3dd397dmr6094046f8f.21.1776447088991; 
 Fri, 17 Apr 2026 10:31:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm5819650f8f.35.2026.04.17.10.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 10:31:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
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
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 10/17] hw/core: Update docs for get_phys_addr_{attrs_,}debug
Date: Fri, 17 Apr 2026 18:30:58 +0100
Message-ID: <20260417173105.1648172-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417173105.1648172-1-peter.maydell@linaro.org>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Update the documentation for the get_phys_addr_{attrs_,}debug methods
and wrapper functions to state that they can handle non-page aligned
addresses and will return the corresponding exact physaddr for them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/core/cpu.h            | 16 +++++++++++-----
 include/hw/core/sysemu-cpu-ops.h |  4 ++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6dedad535c..0941757c55 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -746,15 +746,18 @@ void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
 /**
  * cpu_get_phys_addr_attrs_debug:
- * @cpu: The CPU to obtain the physical page address for.
+ * @cpu: The CPU to use for the virtual-to-physical translation
  * @addr: The virtual address.
  * @attrs: Updated on return with the memory transaction attributes to use
  *         for this access.
  *
- * Obtains the physical page corresponding to a virtual one, together
+ * Obtains the physical address corresponding to a virtual one, together
  * with the corresponding memory transaction attributes to use for the access.
  * Use it only for debugging because no protection checks are done.
  *
+ * The address need not be page-aligned; the returned address will
+ * be the physical address corresponding to that virtual address.
+ *
  * Returns: Corresponding physical page address or -1 if no page found.
  */
 hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
@@ -762,13 +765,16 @@ hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
 
 /**
  * cpu_get_phys_addr_debug:
- * @cpu: The CPU to obtain the physical page address for.
+ * @cpu: The CPU to use for the virtual-to-physical translation
  * @addr: The virtual address.
  *
- * Obtains the physical page corresponding to a virtual one.
+ * Obtains the physical address corresponding to a virtual one.
  * Use it only for debugging because no protection checks are done.
  *
- * Returns: Corresponding physical page address or -1 if no page found.
+ * The address need not be page-aligned; the returned address will
+ * be the physical address corresponding to that virtual address.
+ *
+ * Returns: Corresponding physical address, or -1 if no page found.
  */
 hwaddr cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index a4fc330bea..a87c55d922 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -31,6 +31,8 @@ typedef struct SysemuCPUOps {
     bool (*get_paging_enabled)(const CPUState *cpu);
     /**
      * @get_phys_addr_debug: Callback for obtaining a physical address.
+     * This must be able to handle a non-page-aligned address, and will
+     * return the physical address corresponding to that address.
      */
     hwaddr (*get_phys_addr_debug)(CPUState *cpu, vaddr addr);
     /**
@@ -39,6 +41,8 @@ typedef struct SysemuCPUOps {
      *       access.
      * CPUs which use memory transaction attributes should implement this
      * instead of get_phys_addr_debug.
+     * This must be able to handle a non-page-aligned address, and will
+     * return the physical address corresponding to that address.
      */
     hwaddr (*get_phys_addr_attrs_debug)(CPUState *cpu, vaddr addr,
                                         MemTxAttrs *attrs);
-- 
2.43.0


