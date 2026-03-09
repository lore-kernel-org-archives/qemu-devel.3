Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A1CEFCD9B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 12:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzZI2-0000Ps-MT; Mon, 09 Mar 2026 08:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vzZHm-0000O4-Fo
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:00:34 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vzZHf-0004UQ-Od
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:00:31 -0400
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-829a9d08644so1530175b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 05:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773057621; x=1773662421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QzsSx1R6vPjdv8Ri3UXiAIf0LMCISoCtlDVAxaqIELM=;
 b=IK60pU3Gd0m1EY0wzd2dbqxOGAzim5bMT0AGRRYZ/mIhinE9bXxcvEfGqQslViM9Rv
 HSPh4Scg2xTw7LD4xk7RkD+8WGfF6WScr/6ClwQ8y79VxBve6SrgoyEZPKnLfkAyrNJX
 WQ3aai24V18rz/SufXd6lzVTFqBmsqYPLLSY9ueegGUZ9q9kpEXC4tPHXUEFcz72t3s4
 wvKKALzhw72XLYlseXCw8Xn7JmYhSEcE7ikr+/i4tmJjsGwo9uKBVOezOgX3Huvpdnzo
 ts9Ny1jjm6x0zYT1Fg2MLTePrgvfcBDB+W+Eerqs29My7R0mqT9Zhd9R1r0FLeH6SeSL
 8wEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773057621; x=1773662421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QzsSx1R6vPjdv8Ri3UXiAIf0LMCISoCtlDVAxaqIELM=;
 b=e9yJS2nwfbpVYiEkZ7g71dB0PJ3B1i/lFjqIjULASlzLYRJPm8clyIwOaTAm+lrOTX
 E242P9PCydKSxyoOjKmOjTilTx5VU6BCBOt4mBYrgmV2T2kKUMT5BSpKBfLVyFRf8E1U
 xIO2P8A8zbSX+/xFgq1tQ17jGB+PfEAEaDNj2jo4LR2g/rlU1cdpUQWF/HHisjohImW1
 KJl1v6TrfhjHz/WpO0GsVopPKqA1RtPTSwzkaR9tLzv1inJKlJwygQr3rJ3QEe2uvkD+
 QdSj60TtuLToLsjZFaz7yRQPOH0axrvI4QnoZDgmv6sALQkOM8yn+AfEkl9wKRl8v8jk
 8S5Q==
X-Gm-Message-State: AOJu0Yw+vHyMBhw1h8VoMdVlxIePNB0adzGMxnrqze0d1JT7aaBaYp7p
 A6pivHW394fVHN9/c/fTuS+SMMhe9Ng3rzhFT9umojIynEy5G3PpnowdfgwRY7AIWDA=
X-Gm-Gg: ATEYQzxVjDD2t552IoQPtGBwhychF8ObYzY9yFKgBbRTPlTwdt7Sms2ynWPDHPS38Tf
 U/nfvk8Q74a4FgwkJhxRZmOYvoj5G8vNsBviAAIki2Tcy3jkYgAP7YbmnbmNDRhpwF7tJsAKeep
 /wwlMLEDz24gc/wGvFr20hMHxlv3Yz3y61HxObzHk2NorafXI0XMjsKfnLwqh83SdwXcPqfoWqB
 HoiKgn1lk7JXZcVhfaBuhhxU2LiWPr0W6vZlnaZu7kRfpwhQQ/PAaQfTerwIrAxyp7aOGaUVFRP
 bzLR+HKXv8SLqst27IzYIosLZpY5weydiFb9Wg/OdNhiirJOshwGwkthNw2DmclbDy9A6dEy28m
 RaRorIMfgO3PT+npLrGtGfLA1JKQbumbfDc0HKeiXlTsQivmFe0E+zj9OorWRdaf2yvrCD5g+gV
 NyxKg/L52YJfRoRxwT9qyroXSXCIgRXa6IaiL53xzG2rS9QMFG4qCxJMmKnQp936q8D0kTu9s=
X-Received: by 2002:a05:6a00:1acd:b0:81c:c98c:aeb7 with SMTP id
 d2e1a72fcca58-829a2d92f11mr9089752b3a.7.1773057616419; 
 Mon, 09 Mar 2026 05:00:16 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([183.195.21.154])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a465b6d3sm10422314b3a.18.2026.03.09.05.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 05:00:15 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Helge Deller <deller@gmx.de>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH 1/2] accel/tcg: Pass access_type as an argument of
 tlb_set_page*()
Date: Mon,  9 Mar 2026 19:59:27 +0800
Message-ID: <criew-1773057567781894384-3050942@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260202075358.2137740-2-jim.shu@sifive.com>
References: <20260202075358.2137740-1-jim.shu@sifive.com>
 <20260202075358.2137740-2-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x441.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On Mon,  2 Feb 2026 15:53:57 +0800, Jim Shu <jim.shu@sifive.com> wrote:
> Pass the access_type so that we could know CPU will do the read or
> write access. Then, CPU can fill the CPUTLBEntry[Full] of the specific
> permission (@prot).
>
> It is fine for address_space_translate*() to return different section of
> read and write access. tlb_set_page*() only sets 'CPUTLBEntry.addr_*'
> for specific @prot, so access from another @prot will only get TLB miss
> and start to overwrite 'CPUTLBEntry[Full]' with new @prot.
>
> It is the preliminary patch of next commit to pass the iommu_flags
> to IOMMUMemoryRegion from access_type.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>  accel/tcg/cputlb.c                   | 14 ++++++++------
>  include/exec/cputlb.h                | 11 +++++++----
>  target/alpha/helper.c                |  2 +-
>  target/avr/helper.c                  |  2 +-
>  target/hppa/mem_helper.c             |  1 -
>  target/i386/tcg/system/excp_helper.c |  3 ++-
>  target/loongarch/tcg/tlb_helper.c    |  2 +-
>  target/m68k/helper.c                 | 10 +++++++---
>  target/microblaze/helper.c           |  8 ++++----
>  target/mips/tcg/system/tlb_helper.c  |  4 ++--
>  target/openrisc/mmu.c                |  2 +-
>  target/ppc/mmu_helper.c              |  2 +-
>  target/riscv/cpu_helper.c            |  2 +-
>  target/rx/cpu.c                      |  3 ++-
>  target/s390x/tcg/excp_helper.c       |  2 +-
>  target/sh4/helper.c                  |  2 +-
>  target/sparc/mmu_helper.c            |  6 +++---
>  target/tricore/helper.c              |  2 +-
>  target/xtensa/helper.c               |  3 ++-
>  19 files changed, 46 insertions(+), 35 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 76546c66515..2a0f4cfff62 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1022,7 +1022,8 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
>   * critical section.
>   */
>  void tlb_set_page_full(CPUState *cpu, int mmu_idx,
> -                       vaddr addr, CPUTLBEntryFull *full)
> +                       vaddr addr, MMUAccessType access_type,
> +                       CPUTLBEntryFull *full)
>  {
>      CPUTLB *tlb = &cpu->neg.tlb;
>      CPUTLBDesc *desc = &tlb->d[mmu_idx];
> @@ -1185,7 +1186,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>
>  void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
>                               hwaddr paddr, MemTxAttrs attrs, int prot,
> -                             int mmu_idx, vaddr size)
> +                             MMUAccessType access_type, int mmu_idx,
> +                             vaddr size)
>  {
>      CPUTLBEntryFull full = {
>          .phys_addr = paddr,
> @@ -1195,15 +1197,15 @@ void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
>      };
>
>      assert(is_power_of_2(size));
> -    tlb_set_page_full(cpu, mmu_idx, addr, &full);
> +    tlb_set_page_full(cpu, mmu_idx, addr, access_type, &full);
>  }
>
>  void tlb_set_page(CPUState *cpu, vaddr addr,
> -                  hwaddr paddr, int prot,
> +                  hwaddr paddr, int prot, MMUAccessType access_type,
>                    int mmu_idx, vaddr size)
>  {
>      tlb_set_page_with_attrs(cpu, addr, paddr, MEMTXATTRS_UNSPECIFIED,
> -                            prot, mmu_idx, size);
> +                            prot, access_type, mmu_idx, size);
>  }
>
>  /**
> @@ -1245,7 +1247,7 @@ static bool tlb_fill_align(CPUState *cpu, vaddr addr, MMUAccessType type,
>      if (ops->tlb_fill_align) {
>          if (ops->tlb_fill_align(cpu, &full, addr, type, mmu_idx,
>                                  memop, size, probe, ra)) {
> -            tlb_set_page_full(cpu, mmu_idx, addr, &full);
> +            tlb_set_page_full(cpu, mmu_idx, addr, type, &full);
>              return true;
>          }
>      } else {
> diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
> index 3a9603a6965..47fa4302a9a 100644
> --- a/include/exec/cputlb.h
> +++ b/include/exec/cputlb.h
> @@ -41,6 +41,7 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
>   * @cpu: CPU context
>   * @mmu_idx: mmu index of the tlb to modify
>   * @addr: virtual address of the entry to add
> + * @access_type: access was read/write/execute
>   * @full: the details of the tlb entry
>   *
>   * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
> @@ -56,6 +57,7 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
>   * used by tlb_flush_page.
>   */
>  void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
> +                       MMUAccessType access_type,
>                         CPUTLBEntryFull *full);
>
>  /**
> @@ -65,6 +67,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
>   * @paddr: physical address of the page
>   * @attrs: memory transaction attributes
>   * @prot: access permissions (PAGE_READ/PAGE_WRITE/PAGE_EXEC bits)
> + * @access_type: access was read/write/execute
>   * @mmu_idx: MMU index to insert TLB entry for
>   * @size: size of the page in bytes
>   *
> @@ -81,9 +84,9 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
>   * used by tlb_flush_page.
>   */
>  void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
> -                             hwaddr paddr, MemTxAttrs attrs,
> -                             int prot, int mmu_idx, vaddr size);
> -
> +                             hwaddr paddr, MemTxAttrs attrs, int prot,
> +                             MMUAccessType access_type, int mmu_idx,
> +                             vaddr size);
>  /**
>   * tlb_set_page:
>   *
> @@ -92,7 +95,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
>   * as a convenience for CPUs which don't use memory transaction attributes.
>   */
>  void tlb_set_page(CPUState *cpu, vaddr addr,
> -                  hwaddr paddr, int prot,
> +                  hwaddr paddr, int prot, MMUAccessType access_type,
>                    int mmu_idx, vaddr size);
>
>  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index a9af52a928f..cd6c380e542 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -321,7 +321,7 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
>      }
>
>      tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
> -                 prot, mmu_idx, TARGET_PAGE_SIZE);
> +                 prot, access_type, mmu_idx, TARGET_PAGE_SIZE);
>      return true;
>  }
>
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> index 365c8c60e19..563df1e8a5b 100644
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -143,7 +143,7 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>          prot = PAGE_READ | PAGE_WRITE;
>      }
>
> -    tlb_set_page(cs, address, paddr, prot, mmu_idx, TARGET_PAGE_SIZE);
> +    tlb_set_page(cs, address, paddr, prot, access_type, mmu_idx, TARGET_PAGE_SIZE);
>      return true;
>  }
>
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index cce82e65999..710259b3cde 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -475,7 +475,6 @@ bool hppa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
>      out->prot = prot;
>      out->attrs = MEMTXATTRS_UNSPECIFIED;
>      out->lg_page_size = TARGET_PAGE_BITS;
> -
>      return true;
>  }
>
> diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
> index d7ea77c8558..0fdae83f0a2 100644
> --- a/target/i386/tcg/system/excp_helper.c
> +++ b/target/i386/tcg/system/excp_helper.c
> @@ -628,7 +628,8 @@ bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
>          tlb_set_page_with_attrs(cs, addr & TARGET_PAGE_MASK,
>                                  out.paddr & TARGET_PAGE_MASK,
>                                  cpu_get_mem_attrs(env),
> -                                out.prot, mmu_idx, out.page_size);
> +                                out.prot, access_type, mmu_idx,
> +                                out.page_size);
>          return true;
>      }
>
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index b6e9a3a3c7f..a9e44d82ff7 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -669,7 +669,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>          prot = context.prot;
>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
>                       physical & TARGET_PAGE_MASK, prot,
> -                     mmu_idx, TARGET_PAGE_SIZE);
> +                     access_type, mmu_idx, TARGET_PAGE_SIZE);
>          qemu_log_mask(CPU_LOG_MMU,
>                        "%s address=%" VADDR_PRIx " physical " HWADDR_FMT_plx
>                        " prot %d\n", __func__, address, physical, prot);
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 15f110fa7a2..aab2ea8d191 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -969,7 +969,7 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
>                       address & TARGET_PAGE_MASK,
>                       PAGE_READ | PAGE_WRITE | PAGE_EXEC,
> -                     mmu_idx, TARGET_PAGE_SIZE);
> +                     qemu_access_type, mmu_idx, TARGET_PAGE_SIZE);
>          return true;
>      }
>
> @@ -989,7 +989,8 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                                 address, access_type, &page_size);
>      if (likely(ret == 0)) {
>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
> -                     physical & TARGET_PAGE_MASK, prot, mmu_idx, page_size);
> +                     physical & TARGET_PAGE_MASK, prot, qemu_access_type,
> +                     mmu_idx, page_size);
>          return true;
>      }
>
> @@ -1461,6 +1462,7 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
>      int prot;
>      int ret;
>      target_ulong page_size;
> +    MMUAccessType qemu_access_type;
>
>      access_type = ACCESS_PTEST;
>      if (env->dfc & 4) {
> @@ -1468,9 +1470,11 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
>      }
>      if ((env->dfc & 3) == 2) {
>          access_type |= ACCESS_CODE;
> +        qemu_access_type = MMU_INST_FETCH;
>      }
>      if (!is_read) {
>          access_type |= ACCESS_STORE;
> +        qemu_access_type = MMU_DATA_STORE;
>      }
>
>      env->mmu.mmusr = 0;
> @@ -1480,7 +1484,7 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
>      if (ret == 0) {
>          tlb_set_page(env_cpu(env), addr & TARGET_PAGE_MASK,
>                       physical & TARGET_PAGE_MASK,
> -                     prot, access_type & ACCESS_SUPER ?
> +                     prot, qemu_access_type, access_type & ACCESS_SUPER ?
>                       MMU_KERNEL_IDX : MMU_USER_IDX, page_size);
>      }
>  }
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index a1857b72172..2bdf8c3ea03 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -101,8 +101,8 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>          /* MMU disabled or not available.  */
>          address &= TARGET_PAGE_MASK;
>          prot = PAGE_RWX;
> -        tlb_set_page_with_attrs(cs, address, address, attrs, prot, mmu_idx,
> -                                TARGET_PAGE_SIZE);
> +        tlb_set_page_with_attrs(cs, address, address, attrs, prot, access_type,
> +                                mmu_idx, TARGET_PAGE_SIZE);
>          return true;
>      }
>
> @@ -113,8 +113,8 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>
>          qemu_log_mask(CPU_LOG_MMU, "MMU map mmu=%d v=%x p=%x prot=%x\n",
>                        mmu_idx, vaddr, paddr, lu.prot);
> -        tlb_set_page_with_attrs(cs, vaddr, paddr, attrs, lu.prot, mmu_idx,
> -                                TARGET_PAGE_SIZE);
> +        tlb_set_page_with_attrs(cs, vaddr, paddr, attrs, lu.prot, access_type,
> +                                mmu_idx, TARGET_PAGE_SIZE);
>          return true;
>      }
>
> diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
> index 566924b079e..bf08ba29d02 100644
> --- a/target/mips/tcg/system/tlb_helper.c
> +++ b/target/mips/tcg/system/tlb_helper.c
> @@ -934,7 +934,7 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      if (ret == TLBRET_MATCH) {
>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
>                       physical & TARGET_PAGE_MASK, prot,
> -                     mmu_idx, TARGET_PAGE_SIZE);
> +                     access_type, mmu_idx, TARGET_PAGE_SIZE);
>          return true;
>      }
>  #if !defined(TARGET_MIPS64)
> @@ -952,7 +952,7 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>              if (ret == TLBRET_MATCH) {
>                  tlb_set_page(cs, address & TARGET_PAGE_MASK,
>                               physical & TARGET_PAGE_MASK, prot,
> -                             mmu_idx, TARGET_PAGE_SIZE);
> +                             access_type, mmu_idx, TARGET_PAGE_SIZE);
>                  return true;
>              }
>          }
> diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
> index 315debaf3e5..c14f03081e1 100644
> --- a/target/openrisc/mmu.c
> +++ b/target/openrisc/mmu.c
> @@ -127,7 +127,7 @@ bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
>      if (likely(excp == 0)) {
>          tlb_set_page(cs, addr & TARGET_PAGE_MASK,
>                       phys_addr & TARGET_PAGE_MASK, prot,
> -                     mmu_idx, TARGET_PAGE_SIZE);
> +                     access_type, mmu_idx, TARGET_PAGE_SIZE);
>          return true;
>      }
>      if (probe) {
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index ac607054027..8b55a9e4ddf 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1369,7 +1369,7 @@ bool ppc_cpu_tlb_fill(CPUState *cs, vaddr eaddr, int size,
>      if (ppc_xlate(cpu, eaddr, access_type, &raddr,
>                    &page_size, &prot, mmu_idx, !probe)) {
>          tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
> -                     prot, mmu_idx, 1UL << page_size);
> +                     prot, access_type, mmu_idx, 1UL << page_size);
>          return true;
>      }
>      if (probe) {
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index dd6c861a90e..ee0292e3423 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1874,7 +1874,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>
>      if (ret == TRANSLATE_SUCCESS) {
>          tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1),
> -                     prot, mmu_idx, tlb_size);
> +                     prot, access_type, mmu_idx, tlb_size);
>          return true;
>      } else if (probe) {
>          return false;
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 0437edca1ba..11e9e607279 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -194,7 +194,8 @@ static bool rx_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
>      /* Linear mapping */
>      address = physical = addr & TARGET_PAGE_MASK;
>      prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> -    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
> +    tlb_set_page(cs, address, physical, prot, access_type,
> +                 mmu_idx, TARGET_PAGE_SIZE);
>      return true;
>  }
>
> diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
> index 019eb4fba1f..38ded3b9c78 100644
> --- a/target/s390x/tcg/excp_helper.c
> +++ b/target/s390x/tcg/excp_helper.c
> @@ -181,7 +181,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                        "%s: set tlb %" PRIx64 " -> %" PRIx64 " (%x)\n",
>                        __func__, (uint64_t)vaddr, (uint64_t)raddr, prot);
>          tlb_set_page(cs, address & TARGET_PAGE_MASK, raddr, prot,
> -                     mmu_idx, TARGET_PAGE_SIZE);
> +                     access_type, mmu_idx, TARGET_PAGE_SIZE);
>          return true;
>      }
>      if (probe) {
> diff --git a/target/sh4/helper.c b/target/sh4/helper.c
> index 5d6295618f5..d850d90b5ad 100644
> --- a/target/sh4/helper.c
> +++ b/target/sh4/helper.c
> @@ -812,7 +812,7 @@ bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      if (ret == MMU_OK) {
>          address &= TARGET_PAGE_MASK;
>          physical &= TARGET_PAGE_MASK;
> -        tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
> +        tlb_set_page(cs, address, physical, prot, access_type, mmu_idx, TARGET_PAGE_SIZE);
>          return true;
>      }
>      if (probe) {
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index 5a58239d65e..a2e3fb2145c 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -234,7 +234,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                        "Translate at %" VADDR_PRIx " -> "
>                        HWADDR_FMT_plx ", vaddr " TARGET_FMT_lx "\n",
>                        address, full.phys_addr, vaddr);
> -        tlb_set_page_full(cs, mmu_idx, vaddr, &full);
> +        tlb_set_page_full(cs, mmu_idx, vaddr, access_type, &full);
>          return true;
>      }
>
> @@ -250,7 +250,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>             neverland. Fake/overridden mappings will be flushed when
>             switching to normal mode. */
>          full.prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> -        tlb_set_page_full(cs, mmu_idx, vaddr, &full);
> +        tlb_set_page_full(cs, mmu_idx, vaddr, access_type, &full);
>          return true;
>      } else {
>          if (access_type == MMU_INST_FETCH) {
> @@ -775,7 +775,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>          trace_mmu_helper_mmu_fault(address, full.phys_addr, mmu_idx, env->tl,
>                                     env->dmmu.mmu_primary_context,
>                                     env->dmmu.mmu_secondary_context);
> -        tlb_set_page_full(cs, mmu_idx, address, &full);
> +        tlb_set_page_full(cs, mmu_idx, address, access_type, &full);
>          return true;
>      }
>      if (probe) {
> diff --git a/target/tricore/helper.c b/target/tricore/helper.c
> index 7ee8c7fd699..a7173dc73f0 100644
> --- a/target/tricore/helper.c
> +++ b/target/tricore/helper.c
> @@ -86,7 +86,7 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      if (ret == TLBRET_MATCH) {
>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
>                       physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
> -                     mmu_idx, TARGET_PAGE_SIZE);
> +                     rw, mmu_idx, TARGET_PAGE_SIZE);
>          return true;
>      } else {
>          assert(ret < 0);
> diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
> index 2d93b45036d..2cd51ba0cb7 100644
> --- a/target/xtensa/helper.c
> +++ b/target/xtensa/helper.c
> @@ -282,7 +282,8 @@ bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>          tlb_set_page(cs,
>                       address & TARGET_PAGE_MASK,
>                       paddr & TARGET_PAGE_MASK,
> -                     access, mmu_idx, page_size);
> +                     access, access_type, mmu_idx,
> +                     page_size);
>          return true;
>      } else if (probe) {
>          return false;
> --
> 2.43.0
>
>

