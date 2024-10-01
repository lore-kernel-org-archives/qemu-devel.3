Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB28CEB2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 00:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svQSy-0004Xs-ME; Mon, 30 Sep 2024 20:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1svQSw-0004WL-Bv
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 20:10:10 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1svQSt-0007GZ-Mr
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 20:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=dKxwabnYx9JJYY9VxENDiRo3ZMsGGYc7XBW5vtH4Ysw=; b=FZLmATalMg3rUenG
 QRVEkJSskxDYbW7/QDQJqD8LqMUEJ60G+dZz4rOapdaHu9cm6SxcM06GaQHpi35S7qxHUhLVqRvyE
 RzMaeeP20snCu66hHNTFtsFvTPFCiFNjaDMjgsbJcuJgvjhwVEMISgZ3RvK+6IBR3OwntjgugxeVt
 5EuAgi+7iZ/tu0dMSg/mgkw2PDoK7Jm1853CUnJ6oeX/s0IHTwHchB8MJLgPAchY052IUyGKNXmDa
 aLJ/AXgv0PpTZmPJ79+y3Lkgjx16Rd66UxmLDsxcLrkPyVbJpJ4Hg/hiKBTKXRaHe4knEm8qY7uCt
 6Vj8v0LWBy561S8sxQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1svQSr-0086io-04;
 Tue, 01 Oct 2024 00:10:05 +0000
Date: Tue, 1 Oct 2024 00:10:04 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Josh Junon <junon@oro.sh>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 armbru@redhat.com
Subject: Re: [PATCH] hmp: allow filtering `info tlb` entries by address on i386
Message-ID: <Zvs93PoHm0imx-r4@gallifrey>
References: <20240824083423.9332-1-junon@oro.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240824083423.9332-1-junon@oro.sh>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 00:03:22 up 145 days, 11:17,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
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

* Josh Junon (junon@oro.sh) wrote:
> This change adds an optional virtual address parameter
> to the `info tlb` monitor command on i386 targets,
> only printing a specific entry if found.

Hi Josh,

> Signed-off-by: Josh Junon <junon@oro.sh>
> ---
>  hmp-commands-info.hx  |  5 +++++
>  target/i386/monitor.c | 45 +++++++++++++++++++++++++++----------------
>  2 files changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index c59cd6637b..e42427b738 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -199,8 +199,13 @@ ERST
>      defined(TARGET_PPC) || defined(TARGET_XTENSA) || defined(TARGET_M68K)
>      {
>          .name       = "tlb",
> +#if defined(TARGET_I386)
> +        .args_type  = "virt:l?",
> +        .params     = "[virt]",
> +#else
>          .args_type  = "",
>          .params     = "",
> +#endif

I don't think we've got any other case where we only define a parameter
on some architecture; and it feels best to avoid adding it now.

>          .help       = "show virtual to physical memory mappings",

The meaning of parameters should be documented in the .help;
you could add a comment there saying 'only some architectures'

>          .cmd        = hmp_info_tlb,
>      },
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 2d766b2637..f54d400c97 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -50,10 +50,14 @@ static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
>  }
>  
>  static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
> -                      hwaddr pte, hwaddr mask)
> +                      hwaddr pte, hwaddr mask, hwaddr *filter)
>  {
>      addr = addr_canonical(env, addr);
>  
> +    if (filter && (*filter & mask) != (addr & mask)) {
> +        return;
> +    }
> +
>      monitor_printf(mon, HWADDR_FMT_plx ": " HWADDR_FMT_plx
>                     " %c%c%c%c%c%c%c%c%c\n",
>                     addr,
> @@ -69,7 +73,7 @@ static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
>                     pte & PG_RW_MASK ? 'W' : '-');
>  }
>  
> -static void tlb_info_32(Monitor *mon, CPUArchState *env)
> +static void tlb_info_32(Monitor *mon, CPUArchState *env, hwaddr *filter)
>  {
>      unsigned int l1, l2;
>      uint32_t pgd, pde, pte;
> @@ -81,7 +85,7 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env)
>          if (pde & PG_PRESENT_MASK) {
>              if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
>                  /* 4M pages */
> -                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1));
> +                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1), filter);
>              } else {
>                  for(l2 = 0; l2 < 1024; l2++) {
>                      cpu_physical_memory_read((pde & ~0xfff) + l2 * 4, &pte, 4);
> @@ -89,7 +93,8 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env)
>                      if (pte & PG_PRESENT_MASK) {
>                          print_pte(mon, env, (l1 << 22) + (l2 << 12),
>                                    pte & ~PG_PSE_MASK,
> -                                  ~0xfff);
> +                                  ~0xfff,
> +                                  filter);
>                      }
>                  }
>              }
> @@ -97,7 +102,7 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env)
>      }
>  }
>  
> -static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
> +static void tlb_info_pae32(Monitor *mon, CPUArchState *env, hwaddr *filter)
>  {
>      unsigned int l1, l2, l3;
>      uint64_t pdpe, pde, pte;
> @@ -116,7 +121,8 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
>                      if (pde & PG_PSE_MASK) {
>                          /* 2M pages with PAE, CR4.PSE is ignored */
>                          print_pte(mon, env, (l1 << 30) + (l2 << 21), pde,
> -                                  ~((hwaddr)(1 << 20) - 1));
> +                                  ~((hwaddr)(1 << 20) - 1),
> +                                  filter);
>                      } else {
>                          pt_addr = pde & 0x3fffffffff000ULL;
>                          for (l3 = 0; l3 < 512; l3++) {
> @@ -126,7 +132,8 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
>                                  print_pte(mon, env, (l1 << 30) + (l2 << 21)
>                                            + (l3 << 12),
>                                            pte & ~PG_PSE_MASK,
> -                                          ~(hwaddr)0xfff);
> +                                          ~(hwaddr)0xfff,
> +                                          filter);
>                              }
>                          }
>                      }
> @@ -138,7 +145,7 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
>  
>  #ifdef TARGET_X86_64
>  static void tlb_info_la48(Monitor *mon, CPUArchState *env,
> -        uint64_t l0, uint64_t pml4_addr)
> +        uint64_t l0, uint64_t pml4_addr, hwaddr *filter)
>  {
>      uint64_t l1, l2, l3, l4;
>      uint64_t pml4e, pdpe, pde, pte;
> @@ -162,7 +169,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
>              if (pdpe & PG_PSE_MASK) {
>                  /* 1G pages, CR4.PSE is ignored */
>                  print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30),
> -                        pdpe, 0x3ffffc0000000ULL);
> +                        pdpe, 0x3ffffc0000000ULL, filter);
>                  continue;
>              }
>  
> @@ -177,7 +184,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
>                  if (pde & PG_PSE_MASK) {
>                      /* 2M pages, CR4.PSE is ignored */
>                      print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30) +
> -                            (l3 << 21), pde, 0x3ffffffe00000ULL);
> +                            (l3 << 21), pde, 0x3ffffffe00000ULL, filter);
>                      continue;
>                  }
>  
> @@ -190,7 +197,8 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
>                      if (pte & PG_PRESENT_MASK) {
>                          print_pte(mon, env, (l0 << 48) + (l1 << 39) +
>                                  (l2 << 30) + (l3 << 21) + (l4 << 12),
> -                                pte & ~PG_PSE_MASK, 0x3fffffffff000ULL);
> +                                pte & ~PG_PSE_MASK, 0x3fffffffff000ULL,
> +                                filter);
>                      }
>                  }
>              }
> @@ -198,7 +206,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
>      }
>  }
>  
> -static void tlb_info_la57(Monitor *mon, CPUArchState *env)
> +static void tlb_info_la57(Monitor *mon, CPUArchState *env, hwaddr *filter)
>  {
>      uint64_t l0;
>      uint64_t pml5e;
> @@ -209,7 +217,7 @@ static void tlb_info_la57(Monitor *mon, CPUArchState *env)
>          cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
>          pml5e = le64_to_cpu(pml5e);
>          if (pml5e & PG_PRESENT_MASK) {
> -            tlb_info_la48(mon, env, l0, pml5e & 0x3fffffffff000ULL);
> +            tlb_info_la48(mon, env, l0, pml5e & 0x3fffffffff000ULL, filter);
>          }
>      }
>  }
> @@ -219,6 +227,9 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  {
>      CPUArchState *env;
>  
> +    hwaddr filter_addr = qdict_get_try_int(qdict, "virt", 0);
> +    hwaddr *filter = qdict_haskey(qdict, "virt") ? &filter_addr : NULL;
> +

I'm a bit confused about the format of the parameter you're trying to use;
can you add an example in the commit message please.

>      env = mon_get_cpu_env(mon);
>      if (!env) {
>          monitor_printf(mon, "No CPU available\n");
> @@ -233,17 +244,17 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  #ifdef TARGET_X86_64
>          if (env->hflags & HF_LMA_MASK) {
>              if (env->cr[4] & CR4_LA57_MASK) {
> -                tlb_info_la57(mon, env);
> +                tlb_info_la57(mon, env, filter);
>              } else {
> -                tlb_info_la48(mon, env, 0, env->cr[3] & 0x3fffffffff000ULL);
> +                tlb_info_la48(mon, env, 0, env->cr[3] & 0x3fffffffff000ULL, filter);

I think you're over line length there.

>              }
>          } else
>  #endif
>          {
> -            tlb_info_pae32(mon, env);
> +            tlb_info_pae32(mon, env, filter);
>          }
>      } else {
> -        tlb_info_32(mon, env);
> +        tlb_info_32(mon, env, filter);
>      }
>  }
>  
> -- 
> 2.34.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

