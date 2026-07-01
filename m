Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84DAC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 21:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf28I-0002GH-Kg; Wed, 01 Jul 2026 17:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wf28D-0002D2-8V
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 17:06:05 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wf28A-0000TA-R7
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 17:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=ZwMiIrnEBn6Lw5gldt20yAi+Dp1bQe2Zk8PgC3ppiE0=; b=iE+bawn7p9++1Xu6
 7FpSv8K6fi0h6MSZSq57kPJUFqZ6Bsr7YODEvuVw6A+/DsnWEAhO2Xsa2iVk146ZuQFPZr9UNbc8r
 rwwRH3ebLd+FIfCcYyoqBxqMuge4K9e9KLoEYjVccAFVwWBnuPwDavmeM42GVr/Wm+GLwDCS0bQzw
 GnXIH2nxpkvySuVwOu84vlIHOWMAVyt5bANjzo8lcROaC+xa726Xqpbpq4vPi2I9/wv8fbwjHpqqs
 2Kv2ij35CivorU+nCVhdpdndGjxLEoGu4xDlfA4I9lVuGrjT/CEXTDBOlBZ5U29oKWGGqoCWGzotJ
 cdTCE5NDHyJoBBp7Qg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wf286-0000000BZoh-2qCG;
 Wed, 01 Jul 2026 21:05:58 +0000
Date: Wed, 1 Jul 2026 21:05:58 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: AlanoSong@163.com, philmd@mailo.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, zhao1.liu@intel.com
Subject: Re: [PATCH v2] target/i386/monitor: Refine `info tlb` command
Message-ID: <akWBNn45ADv1V7ns@gallifrey>
References: <20260619125602.17077-1-AlanoSong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260619125602.17077-1-AlanoSong@163.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.88+deb13-amd64 (x86_64)
X-Uptime: 20:58:09 up 47 days, 10 min,  3 users,  load average: 0.04, 0.05,
 0.01
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

(Added Phil's new address in)

* AlanoSong@163.com (AlanoSong@163.com) wrote:
> When booting an i386 target, the `info tlb` command
> may walk the entire page table hierarchy and emit
> an enormous amount of output.
> It will take dozens of minutes to print all the info,
> because each monitor print function will holds 'mon_lock'.
> This effectively hangs the qemu monitor.
> 
> It may be better to add warning note in help message,
> and add a address range by argument to help user control
> the number of output items.
> 
> Signed-off-by: Alano Song <AlanoSong@163.com>
> ---
>  hmp-commands-info.hx  | 12 ++++---
>  target/i386/monitor.c | 82 +++++++++++++++++++++++++++++--------------
>  2 files changed, 64 insertions(+), 30 deletions(-)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 82134eb6c2..3189e20de3 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -188,17 +188,21 @@ ERST
>  
>      {
>          .name       = "tlb",
> -        .args_type  = "",
> -        .params     = "",
> -        .help       = "show virtual to physical memory mappings",
> +        .args_type  = "start:l?,end:l?",
> +        .params     = "[start [end]]",
> +        .help       = "show virtual to physical memory mappings. "

> +                      "output can be extremely large for i386 target. "
> +                      "use 'info tlb [start] [end]' to show a range of entries.",

That can be;
> +                      "The address range can be limited with the optional parameters."

Now, is that the *virtual* address - because it feels like that needs specifying.

>          .cmd        = hmp_info_tlb,
>          .arch_bitmask = QEMU_ARCH_I386 | QEMU_ARCH_SH4 | QEMU_ARCH_SPARC \
>                          | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M68K,

You have added the start/end params to the help, but only implemented it on x86.
That seems odd.

Dave

>      },
>  
>  SRST
> -  ``info tlb``
> +  ``info tlb`` [*start* [*end*]]
>      Show virtual to physical memory mappings.
> +    The output can be extremely large for i386 target.
> +    Use *start* and *end* to print entries located in address range [start, end].
>  ERST
>  
>      {
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index a536712c75..c0e0c3e405 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -48,11 +48,9 @@ static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
>      return addr;
>  }
>  
> -static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
> -                      hwaddr pte, hwaddr mask)
> +static void do_print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
> +                         hwaddr pte, hwaddr mask)
>  {
> -    addr = addr_canonical(env, addr);
> -
>      monitor_printf(mon, HWADDR_FMT_plx ": " HWADDR_FMT_plx
>                     " %c%c%c%c%c%c%c%c%c\n",
>                     addr,
> @@ -68,7 +66,20 @@ static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
>                     pte & PG_RW_MASK ? 'W' : '-');
>  }
>  
> -static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
> +static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
> +                      hwaddr pte, hwaddr mask,
> +                      hwaddr start, hwaddr end)
> +{
> +    addr = addr_canonical(env, addr);
> +    if (addr < start || addr > end) {
> +        return;
> +    }
> +
> +    do_print_pte(mon, env, addr, pte, mask);
> +}
> +
> +static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as,
> +                        hwaddr start, hwaddr end)
>  {
>      const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>      unsigned int l1, l2;
> @@ -80,15 +91,15 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>          if (pde & PG_PRESENT_MASK) {
>              if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
>                  /* 4M pages */
> -                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1));
> +                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1),
> +                          start, end);
>              } else {
>                  for(l2 = 0; l2 < 1024; l2++) {
>                      pte = address_space_ldl_le(as, (pde & ~0xfff) + l2 * 4,
>                                                 attrs, NULL);
>                      if (pte & PG_PRESENT_MASK) {
>                          print_pte(mon, env, (l1 << 22) + (l2 << 12),
> -                                  pte & ~PG_PSE_MASK,
> -                                  ~0xfff);
> +                                  pte & ~PG_PSE_MASK, ~0xfff, start, end);
>                      }
>                  }
>              }
> @@ -96,7 +107,8 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>      }
>  }
>  
> -static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
> +static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as,
> +                           hwaddr start, hwaddr end)
>  {
>      const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>      unsigned int l1, l2, l3;
> @@ -114,17 +126,19 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>                      if (pde & PG_PSE_MASK) {
>                          /* 2M pages with PAE, CR4.PSE is ignored */
>                          print_pte(mon, env, (l1 << 30) + (l2 << 21), pde,
> -                                  ~((hwaddr)(1 << 20) - 1));
> +                                  ~((hwaddr)(1 << 20) - 1),
> +                                  start, end);
>                      } else {
>                          pt_addr = pde & 0x3fffffffff000ULL;
>                          for (l3 = 0; l3 < 512; l3++) {
>                              pte = address_space_ldq_le(as, pt_addr + l3 * 8,
>                                                         attrs, NULL);
>                              if (pte & PG_PRESENT_MASK) {
> -                                print_pte(mon, env, (l1 << 30) + (l2 << 21)
> -                                          + (l3 << 12),
> +                                print_pte(mon, env,
> +                                          (l1 << 30) + (l2 << 21) + (l3 << 12),
>                                            pte & ~PG_PSE_MASK,
> -                                          ~(hwaddr)0xfff);
> +                                          ~(hwaddr)0xfff,
> +                                          start, end);
>                              }
>                          }
>                      }
> @@ -136,7 +150,8 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>  
>  #ifdef TARGET_X86_64
>  static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
> -        uint64_t l0, uint64_t pml4_addr)
> +                          uint64_t l0, uint64_t pml4_addr, hwaddr start,
> +                          hwaddr end)
>  {
>      const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>      uint64_t l1, l2, l3, l4;
> @@ -159,7 +174,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
>              if (pdpe & PG_PSE_MASK) {
>                  /* 1G pages, CR4.PSE is ignored */
>                  print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30),
> -                        pdpe, 0x3ffffc0000000ULL);
> +                          pdpe, 0x3ffffc0000000ULL, start, end);
>                  continue;
>              }
>  
> @@ -172,8 +187,9 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
>  
>                  if (pde & PG_PSE_MASK) {
>                      /* 2M pages, CR4.PSE is ignored */
> -                    print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30) +
> -                            (l3 << 21), pde, 0x3ffffffe00000ULL);
> +                    print_pte(mon, env,
> +                              (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3 << 21),
> +                              pde, 0x3ffffffe00000ULL, start, end);
>                      continue;
>                  }
>  
> @@ -182,9 +198,11 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
>                      pte = address_space_ldq_le(as, pt_addr + l4 * 8,
>                                                 attrs, NULL);
>                      if (pte & PG_PRESENT_MASK) {
> -                        print_pte(mon, env, (l0 << 48) + (l1 << 39) +
> -                                (l2 << 30) + (l3 << 21) + (l4 << 12),
> -                                pte & ~PG_PSE_MASK, 0x3fffffffff000ULL);
> +                        print_pte(mon, env,
> +                                  (l0 << 48) + (l1 << 39) + (l2 << 30) +
> +                                  (l3 << 21) + (l4 << 12),
> +                                  pte & ~PG_PSE_MASK,
> +                                  0x3fffffffff000ULL, start, end);
>                      }
>                  }
>              }
> @@ -192,7 +210,8 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
>      }
>  }
>  
> -static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
> +static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as,
> +                           hwaddr start, hwaddr end)
>  {
>      const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>      uint64_t l0;
> @@ -203,7 +222,8 @@ static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
>      for (l0 = 0; l0 < 512; l0++) {
>          pml5e = address_space_ldq_le(as, pml5_addr + l0 * 8, attrs, NULL);
>          if (pml5e & PG_PRESENT_MASK) {
> -            tlb_info_la48(mon, env, as, l0, pml5e & 0x3fffffffff000ULL);
> +            tlb_info_la48(mon, env, as, l0, pml5e & 0x3fffffffff000ULL,
> +                          start, end);
>          }
>      }
>  }
> @@ -213,6 +233,14 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  {
>      CPUArchState *env;
>      AddressSpace *as;
> +    hwaddr start = 0, end = HWADDR_MAX;
> +
> +    if (qdict_haskey(qdict, "start")) {
> +        start = (hwaddr)qdict_get_int(qdict, "start");
> +    }
> +    if (qdict_haskey(qdict, "end")) {
> +        end = (hwaddr)qdict_get_int(qdict, "end");
> +    }
>  
>      env = mon_get_cpu_env(mon);
>      if (!env) {
> @@ -229,17 +257,19 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  #ifdef TARGET_X86_64
>          if (env->hflags & HF_LMA_MASK) {
>              if (env->cr[4] & CR4_LA57_MASK) {
> -                tlb_info_la57(mon, env, as);
> +                tlb_info_la57(mon, env, as, start, end);
>              } else {
> -                tlb_info_la48(mon, env, as, 0, env->cr[3] & 0x3fffffffff000ULL);
> +                tlb_info_la48(mon, env, as, 0,
> +                              env->cr[3] & 0x3fffffffff000ULL,
> +                              start, end);
>              }
>          } else
>  #endif
>          {
> -            tlb_info_pae32(mon, env, as);
> +            tlb_info_pae32(mon, env, as, start, end);
>          }
>      } else {
> -        tlb_info_32(mon, env, as);
> +        tlb_info_32(mon, env, as, start, end);
>      }
>  }
>  
> -- 
> 2.43.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

