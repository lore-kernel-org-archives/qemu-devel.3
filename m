Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BEAFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINrE-0005Hc-3n; Thu, 30 Apr 2026 05:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINr0-0004nT-4R
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:42 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqm-0002YX-4f
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:40 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-44261378651so1184183f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541907; x=1778146707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hDGJjejJYZxkfE0DV0hYtPp8LwTrheCF0WqZXFUQHA4=;
 b=TxeOGuD3E5KgcgP+BnJ63T7UE/NZsucjmCCp7TXOFsHkZiMgAIupRadKNV6BekFvZL
 d9J2CCfYPHtECqpc0DIOJefGltlG+d7luLihLV7eJj3jv9oQ0c4SRbl6i/2IEjGraGRk
 Nwjnn2SxJxCUPNWMV5avPKKg5UZTZqkDIKOvaY6JSyd/60+8dlSPO/ZfkD6BWyTbotVs
 HimEMISjLU8z5N0Vs3SwlD67i+UgB/lNIz+3nFb3w3EDkWh8IlsT84877hObveZnUPFy
 4Ty9kvS6leD5m8usVpmsAV5MwOey5ZP619pOlauLa0qQ3maW4CuVKupjfhf3ZWD7+PZ0
 qWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541907; x=1778146707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hDGJjejJYZxkfE0DV0hYtPp8LwTrheCF0WqZXFUQHA4=;
 b=eROw1mggUQy9uVLHXFWYdZ8nae7kd1TAJyUCwb8IXP5wM2Y0IzVkDsRRWfAHSAtuwn
 cXcpNrCKq4ay5QbzAkdZnIkNdZ6+ISm0UYPFTLTlVdzGtYeGS6U8NukjKs3J4PGTZxgS
 ufYQi1b030OY3Og0X90zG/csJfslP6n5wAFXrhyXExSqi1nUUmaQ1wEZMWPso5vAzqzF
 FMYnbcTY3f6I1Wokzj8GSobkfG/XGW8iKL8EDqyDH45Nc6DbTfxfFhizRaNP0ZHp2Vb/
 aGT8y/WVy1gHAXfD8ossx9x05Ris2PsZ9kbZyeQ82pG3Cx6ZP20llmna2NZwEnUtzvi4
 d1FQ==
X-Gm-Message-State: AOJu0YwpUem+u7wZ61+yXanm3+Gt9yzJfWg7pMNGPtLY3JPtoNW1Pzqd
 soRJTpZ/ijKKmyIs9Y8Y1pvc/04dGUlFozz3dPIAvvg8ThNb7RXAvDiLuTSKD9u3YHTFpqCZcQn
 GRvGG
X-Gm-Gg: AeBDietljqVYHEaYOttV5NhfN6iqw1oa6L0MtefsJvZ+g81GEPf7SZc3lCpOfOoapOM
 d4jDaOBfyinbebkzoQzfh1vNBNwzzB0iIH8eIAZ7sxlcPp7Ir2Glj96AtDY/CbN1QcCFjSsZpXf
 bx0ztui54pcBZQ1Bm7JM4OzPp7wcR63hLgwy7Cr2JMvX7UJ3JUXL9vKB6T/Ermvq6iWqQBGzkN2
 VBx5849hsTJQKEZQPw+49qO+MDJxKrcKcMklx7/XVnfrvTnw1cr0OkhqNs1FU0OYtqZ2OrO44jX
 bNoXIJbx/pc6nTAv07qiqzhM9HNUUs2kcwfuoTQsmls+zYWeXcFGl191VcNJe+65VW4CfHozAQd
 oxrijHA0e2FrOP50DBNxAmVunI86JNzOggTWa0PIto/BM/WYkfrFPLJAXV7WpQj4pp+jzSjKzKa
 WbubjAK2AnvfaSed1/O2AoGl/fQU1NUeAlqdEyQzQsTsBGllCZi0+QhjmDWG+DBFvLSp+Zx6C1o
 rHCq1iRlnfF4vHtpQsQAZAJ000miL6olx0Qlmuwaw==
X-Received: by 2002:a05:6000:18e:b0:449:8650:954d with SMTP id
 ffacd0b85a97d-44986509648mr1390332f8f.12.1777541906355; 
 Thu, 30 Apr 2026 02:38:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:25 -0700 (PDT)
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
Subject: [PATCH v2 11/25] hw/core: Update docs for get_phys_addr_{attrs_,
 }debug
Date: Thu, 30 Apr 2026 10:37:56 +0100
Message-ID: <20260430093810.2762539-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260417173105.1648172-11-peter.maydell@linaro.org
---
 include/hw/core/cpu.h            | 16 +++++++++++-----
 include/hw/core/sysemu-cpu-ops.h |  4 ++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 9d6b4fd697..730876b7b8 100644
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


