Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9A3CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 22:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpxmc-0008Fl-Ox; Thu, 28 Mar 2024 17:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1rpxma-0008FQ-9I; Thu, 28 Mar 2024 17:59:36 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1rpxmX-0005wi-PZ; Thu, 28 Mar 2024 17:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=yNESvkBVoSHRH3YoU1wGRD7iw4TctuQg/72UBZ0YPyo=; b=WrCw2/Kjr/ldXrwV
 CmerDb6XaI2sL7CKr9pNlirjSjs3hD46KfwDd7BjZ2XaXa74rS9MGp52NHL8eu8/0+6t2C8TFMjEG
 ZXBJ1rmkysNiM4Xeg/km4cNp424UEFL4+VCCmn/V/W71dCcLWKJJq8TvslVwjyWhTkYBqM5HkI6Jk
 XlckdEQ1kMozAptAszMoTL0bnFK2b8t0gv+qwLxI7D9IJyPaCouxKBZxbS99D4VCA2kcgfGQJyHYs
 fGbDqa6lJcmiYBH/BJyvJBfTVbRCGLaQdg5NuXt7DJfIyu1d2tFcwWidtddVvBJEVpi6XNBDvZIt4
 cNTM+ENvuuo0CmgKRA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1rpxmG-00FaoF-27;
 Thu, 28 Mar 2024 21:59:16 +0000
Date: Thu, 28 Mar 2024 21:59:16 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH-for-9.1 05/21] target/m68k: Replace qemu_printf() by
 monitor_printf() in monitor
Message-ID: <ZgXoNN43Izq4SQhd@gallifrey>
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-6-philmd@linaro.org>
 <ZgC6iTKCqG-LX4Sf@gallifrey>
 <2da27069-e767-2bb7-f108-473294dcbef6@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2da27069-e767-2bb7-f108-473294dcbef6@eik.bme.hu>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 21:58:37 up 86 days, 48 min,  3 users,  load average: 0.00, 0.01,
 0.00
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

* BALATON Zoltan (balaton@eik.bme.hu) wrote:
> On Sun, 24 Mar 2024, Dr. David Alan Gilbert wrote:
> > * Philippe Mathieu-Daudé (philmd@linaro.org) wrote:
> > > Replace qemu_printf() by monitor_printf() / monitor_puts() in monitor.
> > > 
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > ---
> > >  target/m68k/cpu.h     |   2 +-
> > >  target/m68k/helper.c  | 126 +++++++++++++++++++++---------------------
> > >  target/m68k/monitor.c |   4 +-
> > >  3 files changed, 67 insertions(+), 65 deletions(-)
> > > 
> > > diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> > > index 346427e144..4e4307956d 100644
> > > --- a/target/m68k/cpu.h
> > > +++ b/target/m68k/cpu.h
> > > @@ -620,6 +620,6 @@ static inline void cpu_get_tb_cpu_state(CPUM68KState *env, vaddr *pc,
> > >      }
> > >  }
> > > 
> > > -void dump_mmu(CPUM68KState *env);
> > > +void dump_mmu(Monitor *mon, CPUM68KState *env);
> > > 
> > >  #endif
> > > diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> > > index 1a475f082a..310e26dfa1 100644
> > > --- a/target/m68k/helper.c
> > > +++ b/target/m68k/helper.c
> > > @@ -25,7 +25,7 @@
> > >  #include "exec/helper-proto.h"
> > >  #include "gdbstub/helpers.h"
> > >  #include "fpu/softfloat.h"
> > > -#include "qemu/qemu-print.h"
> > > +#include "monitor/monitor.h"
> > > 
> > >  #define SIGNBIT (1u << 31)
> > > 
> > > @@ -455,28 +455,30 @@ void m68k_switch_sp(CPUM68KState *env)
> > >  #if !defined(CONFIG_USER_ONLY)
> > >  /* MMU: 68040 only */
> > > 
> > > -static void print_address_zone(uint32_t logical, uint32_t physical,
> > > +static void print_address_zone(Monitor *mon,
> > > +                               uint32_t logical, uint32_t physical,
> > >                                 uint32_t size, int attr)
> > >  {
> > > -    qemu_printf("%08x - %08x -> %08x - %08x %c ",
> > > -                logical, logical + size - 1,
> > > -                physical, physical + size - 1,
> > > -                attr & 4 ? 'W' : '-');
> > > +    monitor_printf(mon, "%08x - %08x -> %08x - %08x %c ",
> > > +                   logical, logical + size - 1,
> > > +                   physical, physical + size - 1,
> > > +                   attr & 4 ? 'W' : '-');
> > >      size >>= 10;
> > >      if (size < 1024) {
> > > -        qemu_printf("(%d KiB)\n", size);
> > > +        monitor_printf(mon, "(%d KiB)\n", size);
> > >      } else {
> > >          size >>= 10;
> > >          if (size < 1024) {
> > > -            qemu_printf("(%d MiB)\n", size);
> > > +            monitor_printf(mon, "(%d MiB)\n", size);
> > >          } else {
> > >              size >>= 10;
> > > -            qemu_printf("(%d GiB)\n", size);
> > > +            monitor_printf(mon, "(%d GiB)\n", size);
> > >          }
> > >      }
> > >  }
> > > 
> > > -static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
> > > +static void dump_address_map(Monitor *mon, CPUM68KState *env,
> > > +                             uint32_t root_pointer)
> > >  {
> > >      int i, j, k;
> > >      int tic_size, tic_shift;
> > > @@ -545,7 +547,7 @@ static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
> > >                      if (first_logical != 0xffffffff) {
> > >                          size = last_logical + (1 << tic_shift) -
> > >                                 first_logical;
> > > -                        print_address_zone(first_logical,
> > > +                        print_address_zone(mon, first_logical,
> > >                                             first_physical, size, last_attr);
> > >                      }
> > >                      first_logical = logical;
> > > @@ -556,125 +558,125 @@ static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
> > >      }
> > >      if (first_logical != logical || (attr & 4) != (last_attr & 4)) {
> > >          size = logical + (1 << tic_shift) - first_logical;
> > > -        print_address_zone(first_logical, first_physical, size, last_attr);
> > > +        print_address_zone(mon, first_logical, first_physical, size, last_attr);
> > >      }
> > >  }
> > > 
> > >  #define DUMP_CACHEFLAGS(a) \
> > >      switch (a & M68K_DESC_CACHEMODE) { \
> > >      case M68K_DESC_CM_WRTHRU: /* cacheable, write-through */ \
> > > -        qemu_printf("T"); \
> > > +        monitor_puts(mon, "T"); \
> > >          break; \
> > >      case M68K_DESC_CM_COPYBK: /* cacheable, copyback */ \
> > > -        qemu_printf("C"); \
> > > +        monitor_puts(mon, "C"); \
> > >          break; \
> > >      case M68K_DESC_CM_SERIAL: /* noncachable, serialized */ \
> > > -        qemu_printf("S"); \
> > > +        monitor_puts(mon, "S"); \
> > >          break; \
> > >      case M68K_DESC_CM_NCACHE: /* noncachable */ \
> > > -        qemu_printf("N"); \
> > > +        monitor_puts(mon, "N"); \
> > >          break; \
> > >      }
> > > 
> > > -static void dump_ttr(uint32_t ttr)
> > > +static void dump_ttr(Monitor *mon, uint32_t ttr)
> > >  {
> > >      if ((ttr & M68K_TTR_ENABLED) == 0) {
> > > -        qemu_printf("disabled\n");
> > > +        monitor_puts(mon, "disabled\n");
> > >          return;
> > >      }
> > > -    qemu_printf("Base: 0x%08x Mask: 0x%08x Control: ",
> > > -                ttr & M68K_TTR_ADDR_BASE,
> > > -                (ttr & M68K_TTR_ADDR_MASK) << M68K_TTR_ADDR_MASK_SHIFT);
> > > +    monitor_printf(mon, "Base: 0x%08x Mask: 0x%08x Control: ",
> > > +                   ttr & M68K_TTR_ADDR_BASE,
> > > +                   (ttr & M68K_TTR_ADDR_MASK) << M68K_TTR_ADDR_MASK_SHIFT);
> > >      switch (ttr & M68K_TTR_SFIELD) {
> > >      case M68K_TTR_SFIELD_USER:
> > > -        qemu_printf("U");
> > > +        monitor_puts(mon, "U");
> > >          break;
> > >      case M68K_TTR_SFIELD_SUPER:
> > > -        qemu_printf("S");
> > > +        monitor_puts(mon, "S");
> > >          break;
> > >      default:
> > > -        qemu_printf("*");
> > > +        monitor_puts(mon, "*");
> > >          break;
> > >      }
> > >      DUMP_CACHEFLAGS(ttr);
> > >      if (ttr & M68K_DESC_WRITEPROT) {
> > > -        qemu_printf("R");
> > > +        monitor_puts(mon, "R");
> > >      } else {
> > > -        qemu_printf("W");
> > > +        monitor_puts(mon, "W");
> > >      }
> > > -    qemu_printf(" U: %d\n", (ttr & M68K_DESC_USERATTR) >>
> > > +    monitor_printf(mon, " U: %d\n", (ttr & M68K_DESC_USERATTR) >>
> > >                                 M68K_DESC_USERATTR_SHIFT);
> > >  }
> > > 
> > > -void dump_mmu(CPUM68KState *env)
> > > +void dump_mmu(Monitor *mon, CPUM68KState *env)
> > >  {
> > >      if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
> > > -        qemu_printf("Translation disabled\n");
> > > +        monitor_puts(mon, "Translation disabled\n");
> > >          return;
> > >      }
> > > -    qemu_printf("Page Size: ");
> > > +    monitor_puts(mon, "Page Size: ");
> > >      if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
> > > -        qemu_printf("8kB\n");
> > > +        monitor_puts(mon, "8kB\n");
> > >      } else {
> > > -        qemu_printf("4kB\n");
> > > +        monitor_puts(mon, "4kB\n");
> > >      }
> > > 
> > > -    qemu_printf("MMUSR: ");
> > > +    monitor_puts(mon, "MMUSR: ");
> > >      if (env->mmu.mmusr & M68K_MMU_B_040) {
> > > -        qemu_printf("BUS ERROR\n");
> > > +        monitor_puts(mon, "BUS ERROR\n");
> > >      } else {
> > > -        qemu_printf("Phy=%08x Flags: ", env->mmu.mmusr & 0xfffff000);
> > > +        monitor_printf(mon, "Phy=%08x Flags: ", env->mmu.mmusr & 0xfffff000);
> > >          /* flags found on the page descriptor */
> > >          if (env->mmu.mmusr & M68K_MMU_G_040) {
> > > -            qemu_printf("G"); /* Global */
> > > +            monitor_puts(mon, "G"); /* Global */
> > >          } else {
> > > -            qemu_printf(".");
> > > +            monitor_puts(mon, ".");
> > >          }
> > >          if (env->mmu.mmusr & M68K_MMU_S_040) {
> > > -            qemu_printf("S"); /* Supervisor */
> > > +            monitor_puts(mon, "S"); /* Supervisor */
> > >          } else {
> > > -            qemu_printf(".");
> > > +            monitor_puts(mon, ".");
> > >          }
> > >          if (env->mmu.mmusr & M68K_MMU_M_040) {
> > > -            qemu_printf("M"); /* Modified */
> > > +            monitor_puts(mon, "M"); /* Modified */
> > >          } else {
> > > -            qemu_printf(".");
> > > +            monitor_puts(mon, ".");
> > >          }
> > >          if (env->mmu.mmusr & M68K_MMU_WP_040) {
> > > -            qemu_printf("W"); /* Write protect */
> > > +            monitor_puts(mon, "W"); /* Write protect */
> > >          } else {
> > > -            qemu_printf(".");
> > > +            monitor_puts(mon, ".");
> > >          }
> > >          if (env->mmu.mmusr & M68K_MMU_T_040) {
> > > -            qemu_printf("T"); /* Transparent */
> > > +            monitor_puts(mon, "T"); /* Transparent */
> > >          } else {
> > > -            qemu_printf(".");
> > > +            monitor_puts(mon, ".");
> > >          }
> > >          if (env->mmu.mmusr & M68K_MMU_R_040) {
> > > -            qemu_printf("R"); /* Resident */
> > > +            monitor_puts(mon, "R"); /* Resident */
> > >          } else {
> > > -            qemu_printf(".");
> > > +            monitor_puts(mon, ".");
> > >          }
> > > -        qemu_printf(" Cache: ");
> > > +        monitor_puts(mon, " Cache: ");
> > >          DUMP_CACHEFLAGS(env->mmu.mmusr);
> > > -        qemu_printf(" U: %d\n", (env->mmu.mmusr >> 8) & 3);
> > > -        qemu_printf("\n");
> > > +        monitor_printf(mon, " U: %d\n", (env->mmu.mmusr >> 8) & 3);
> > > +        monitor_puts(mon, "\n");
> > 
> > That one is a little odd isn't it; still, generally
> 
> Doesn't puts append a newline? Then this would add an extra empty line.

As rth said, apparently not.
But what made me more curious in this case is why not just flatten it
down so that the printf has a second \n rather than needing the second
call to puts.

Dave

> Regards,
> BALATON Zoltan
> 
> > Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> > 
> > >      }
> > > 
> > > -    qemu_printf("ITTR0: ");
> > > -    dump_ttr(env->mmu.ttr[M68K_ITTR0]);
> > > -    qemu_printf("ITTR1: ");
> > > -    dump_ttr(env->mmu.ttr[M68K_ITTR1]);
> > > -    qemu_printf("DTTR0: ");
> > > -    dump_ttr(env->mmu.ttr[M68K_DTTR0]);
> > > -    qemu_printf("DTTR1: ");
> > > -    dump_ttr(env->mmu.ttr[M68K_DTTR1]);
> > > +    monitor_puts(mon, "ITTR0: ");
> > > +    dump_ttr(mon, env->mmu.ttr[M68K_ITTR0]);
> > > +    monitor_puts(mon, "ITTR1: ");
> > > +    dump_ttr(mon, env->mmu.ttr[M68K_ITTR1]);
> > > +    monitor_puts(mon, "DTTR0: ");
> > > +    dump_ttr(mon, env->mmu.ttr[M68K_DTTR0]);
> > > +    monitor_puts(mon, "DTTR1: ");
> > > +    dump_ttr(mon, env->mmu.ttr[M68K_DTTR1]);
> > > 
> > > -    qemu_printf("SRP: 0x%08x\n", env->mmu.srp);
> > > -    dump_address_map(env, env->mmu.srp);
> > > +    monitor_printf(mon, "SRP: 0x%08x\n", env->mmu.srp);
> > > +    dump_address_map(mon, env, env->mmu.srp);
> > > 
> > > -    qemu_printf("URP: 0x%08x\n", env->mmu.urp);
> > > -    dump_address_map(env, env->mmu.urp);
> > > +    monitor_printf(mon, "URP: 0x%08x\n", env->mmu.urp);
> > > +    dump_address_map(mon, env, env->mmu.urp);
> > >  }
> > > 
> > >  static int check_TTR(uint32_t ttr, int *prot, target_ulong addr,
> > > diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
> > > index 2bdf6acae0..623c6ab635 100644
> > > --- a/target/m68k/monitor.c
> > > +++ b/target/m68k/monitor.c
> > > @@ -15,11 +15,11 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
> > >      CPUArchState *env1 = mon_get_cpu_env(mon);
> > > 
> > >      if (!env1) {
> > > -        monitor_printf(mon, "No CPU available\n");
> > > +        monitor_puts(mon, "No CPU available\n");
> > >          return;
> > >      }
> > > 
> > > -    dump_mmu(env1);
> > > +    dump_mmu(mon, env1);
> > >  }
> > > 
> > >  static const MonitorDef monitor_defs[] = {
> > > --
> > > 2.41.0
> > > 
> > 

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

