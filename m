Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A732C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 07:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXAt-0005NS-MB; Wed, 24 Apr 2024 03:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXAp-0005Mv-OZ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXAm-0007Pr-MU
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713944167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pqXPdpx97BSzFQ7gHWn6BaMdsthAefXUokU9dQIKBZc=;
 b=M+tLEQrIfM8kMxw4E7eK5mD/KY3IkM4Z65pgdBRhJKuKzoy770L87yXf+wib3ums6K758b
 GHI0NG59m/njb6vemgDfToFAu0lCGM7FmN7DFbt8J/7c6ZM16nIYxIhbzzlSqrn3ssaaf5
 Vo7YJM6g504FBTVLWu7RoBFRH2KiFnA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-G7xM3ulTOLmon69cnr1YNQ-1; Wed,
 24 Apr 2024 03:36:02 -0400
X-MC-Unique: G7xM3ulTOLmon69cnr1YNQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 214D03C1014E;
 Wed, 24 Apr 2024 07:36:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C56B3543A;
 Wed, 24 Apr 2024 07:36:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 524A221E6811; Wed, 24 Apr 2024 09:35:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Artyom Tarasenko <atar4qemu@gmail.com>,  Chris
 Wulff <crwulff@gmail.com>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Marek Vasut <marex@denx.de>,  Max Filippov
 <jcmvbkbc@gmail.com>,  "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,  Nicholas Piggin
 <npiggin@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel
 Henrique Barboza <danielhb413@gmail.com>,  Yoshinori Sato
 <ysato@users.sourceforge.jp>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-ppc@nongnu.org,  Laurent Vivier
 <laurent@vivier.eu>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH-for-9.1 05/21] target/m68k: Replace qemu_printf() by
 monitor_printf() in monitor
In-Reply-To: <20240321154838.95771-6-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 21 Mar 2024 16:48:21
 +0100")
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-6-philmd@linaro.org>
Date: Wed, 24 Apr 2024 09:35:58 +0200
Message-ID: <87sezb43hd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Replace qemu_printf() by monitor_printf() / monitor_puts() in monitor.

Why?  Here's my attempt at an answer: because this runs only within HMP
command "info tlb".  Using qemu_printf() there isn't wrong, but with
monitor_printf(), it's obvious that we print to the monitor.

On monitor_printf() vs. monitor_puts().

qemu_printf() behaves like monitor_printf() when monitor_cur() returns
non-null, which it certainly does within a monitor command.

monitor_printf() prints like monitor_puts() when monitor_is_qmp()
returns false, which it certainly does within an HMP command.

Note: despite their names, monitor_printf() and monitor_puts() are at
different interface layers!=20=20

We need a low-level function to send to a monitor, be it HMP or QMP:
monitor_puts().

We need a high-level function to format JSON and send it to QMP:
qmp_send_response().

We need a high-level functions to format text and send it to HMP:
monitor_printf(), ...

Naming the functions that expect an HMP monitor hmp_FOO() would make
more sense.  Renaming them now would be quite some churn, though.
Discussed at
<https://lore.kernel.org/qemu-devel/87y1adm0os.fsf@pond.sub.org/>.

HMP code using both two layers to print gives me a slightly queasy
feeling.  It's not wrong, though.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/m68k/cpu.h     |   2 +-
>  target/m68k/helper.c  | 126 +++++++++++++++++++++---------------------
>  target/m68k/monitor.c |   4 +-
>  3 files changed, 67 insertions(+), 65 deletions(-)
>
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 346427e144..4e4307956d 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -620,6 +620,6 @@ static inline void cpu_get_tb_cpu_state(CPUM68KState =
*env, vaddr *pc,
>      }
>  }
>=20=20
> -void dump_mmu(CPUM68KState *env);
> +void dump_mmu(Monitor *mon, CPUM68KState *env);
>=20=20
>  #endif
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 1a475f082a..310e26dfa1 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -25,7 +25,7 @@
>  #include "exec/helper-proto.h"
>  #include "gdbstub/helpers.h"
>  #include "fpu/softfloat.h"
> -#include "qemu/qemu-print.h"
> +#include "monitor/monitor.h"
>=20=20
>  #define SIGNBIT (1u << 31)
>=20=20
> @@ -455,28 +455,30 @@ void m68k_switch_sp(CPUM68KState *env)
>  #if !defined(CONFIG_USER_ONLY)
>  /* MMU: 68040 only */
>=20=20
> -static void print_address_zone(uint32_t logical, uint32_t physical,
> +static void print_address_zone(Monitor *mon,
> +                               uint32_t logical, uint32_t physical,
>                                 uint32_t size, int attr)
>  {
> -    qemu_printf("%08x - %08x -> %08x - %08x %c ",
> -                logical, logical + size - 1,
> -                physical, physical + size - 1,
> -                attr & 4 ? 'W' : '-');
> +    monitor_printf(mon, "%08x - %08x -> %08x - %08x %c ",
> +                   logical, logical + size - 1,
> +                   physical, physical + size - 1,
> +                   attr & 4 ? 'W' : '-');
>      size >>=3D 10;
>      if (size < 1024) {
> -        qemu_printf("(%d KiB)\n", size);
> +        monitor_printf(mon, "(%d KiB)\n", size);
>      } else {
>          size >>=3D 10;
>          if (size < 1024) {
> -            qemu_printf("(%d MiB)\n", size);
> +            monitor_printf(mon, "(%d MiB)\n", size);
>          } else {
>              size >>=3D 10;
> -            qemu_printf("(%d GiB)\n", size);
> +            monitor_printf(mon, "(%d GiB)\n", size);
>          }
>      }
>  }
>=20=20
> -static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
> +static void dump_address_map(Monitor *mon, CPUM68KState *env,
> +                             uint32_t root_pointer)
>  {
>      int i, j, k;
>      int tic_size, tic_shift;
> @@ -545,7 +547,7 @@ static void dump_address_map(CPUM68KState *env, uint3=
2_t root_pointer)
>                      if (first_logical !=3D 0xffffffff) {
>                          size =3D last_logical + (1 << tic_shift) -
>                                 first_logical;
> -                        print_address_zone(first_logical,
> +                        print_address_zone(mon, first_logical,
>                                             first_physical, size, last_at=
tr);
>                      }
>                      first_logical =3D logical;
> @@ -556,125 +558,125 @@ static void dump_address_map(CPUM68KState *env, u=
int32_t root_pointer)
>      }
>      if (first_logical !=3D logical || (attr & 4) !=3D (last_attr & 4)) {
>          size =3D logical + (1 << tic_shift) - first_logical;
> -        print_address_zone(first_logical, first_physical, size, last_att=
r);
> +        print_address_zone(mon, first_logical, first_physical, size, las=
t_attr);
>      }
>  }
>=20=20
>  #define DUMP_CACHEFLAGS(a) \
>      switch (a & M68K_DESC_CACHEMODE) { \
>      case M68K_DESC_CM_WRTHRU: /* cacheable, write-through */ \
> -        qemu_printf("T"); \
> +        monitor_puts(mon, "T"); \

Not wrong, but I'd stick to monitor_printf() to keep the transformation
as simple as possible, and to sidestep the need for explaining the
subtleties around monitor_printf() vs. monitor_puts() in the commit
message.

>          break; \
>      case M68K_DESC_CM_COPYBK: /* cacheable, copyback */ \
> -        qemu_printf("C"); \
> +        monitor_puts(mon, "C"); \

Likewise.  Not going to note this again.

>          break; \
>      case M68K_DESC_CM_SERIAL: /* noncachable, serialized */ \
> -        qemu_printf("S"); \
> +        monitor_puts(mon, "S"); \
>          break; \
>      case M68K_DESC_CM_NCACHE: /* noncachable */ \
> -        qemu_printf("N"); \
> +        monitor_puts(mon, "N"); \
>          break; \
>      }
>=20=20
> -static void dump_ttr(uint32_t ttr)
> +static void dump_ttr(Monitor *mon, uint32_t ttr)
>  {
>      if ((ttr & M68K_TTR_ENABLED) =3D=3D 0) {
> -        qemu_printf("disabled\n");
> +        monitor_puts(mon, "disabled\n");
>          return;
>      }
> -    qemu_printf("Base: 0x%08x Mask: 0x%08x Control: ",
> -                ttr & M68K_TTR_ADDR_BASE,
> -                (ttr & M68K_TTR_ADDR_MASK) << M68K_TTR_ADDR_MASK_SHIFT);
> +    monitor_printf(mon, "Base: 0x%08x Mask: 0x%08x Control: ",
> +                   ttr & M68K_TTR_ADDR_BASE,
> +                   (ttr & M68K_TTR_ADDR_MASK) << M68K_TTR_ADDR_MASK_SHIF=
T);
>      switch (ttr & M68K_TTR_SFIELD) {
>      case M68K_TTR_SFIELD_USER:
> -        qemu_printf("U");
> +        monitor_puts(mon, "U");
>          break;
>      case M68K_TTR_SFIELD_SUPER:
> -        qemu_printf("S");
> +        monitor_puts(mon, "S");
>          break;
>      default:
> -        qemu_printf("*");
> +        monitor_puts(mon, "*");
>          break;
>      }
>      DUMP_CACHEFLAGS(ttr);
>      if (ttr & M68K_DESC_WRITEPROT) {
> -        qemu_printf("R");
> +        monitor_puts(mon, "R");
>      } else {
> -        qemu_printf("W");
> +        monitor_puts(mon, "W");
>      }
> -    qemu_printf(" U: %d\n", (ttr & M68K_DESC_USERATTR) >>
> +    monitor_printf(mon, " U: %d\n", (ttr & M68K_DESC_USERATTR) >>
>                                 M68K_DESC_USERATTR_SHIFT);
>  }
>=20=20
> -void dump_mmu(CPUM68KState *env)
> +void dump_mmu(Monitor *mon, CPUM68KState *env)
>  {
>      if ((env->mmu.tcr & M68K_TCR_ENABLED) =3D=3D 0) {
> -        qemu_printf("Translation disabled\n");
> +        monitor_puts(mon, "Translation disabled\n");
>          return;
>      }
> -    qemu_printf("Page Size: ");
> +    monitor_puts(mon, "Page Size: ");
>      if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
> -        qemu_printf("8kB\n");
> +        monitor_puts(mon, "8kB\n");
>      } else {
> -        qemu_printf("4kB\n");
> +        monitor_puts(mon, "4kB\n");
>      }
>=20=20
> -    qemu_printf("MMUSR: ");
> +    monitor_puts(mon, "MMUSR: ");
>      if (env->mmu.mmusr & M68K_MMU_B_040) {
> -        qemu_printf("BUS ERROR\n");
> +        monitor_puts(mon, "BUS ERROR\n");
>      } else {
> -        qemu_printf("Phy=3D%08x Flags: ", env->mmu.mmusr & 0xfffff000);
> +        monitor_printf(mon, "Phy=3D%08x Flags: ", env->mmu.mmusr & 0xfff=
ff000);
>          /* flags found on the page descriptor */
>          if (env->mmu.mmusr & M68K_MMU_G_040) {
> -            qemu_printf("G"); /* Global */
> +            monitor_puts(mon, "G"); /* Global */
>          } else {
> -            qemu_printf(".");
> +            monitor_puts(mon, ".");
>          }
>          if (env->mmu.mmusr & M68K_MMU_S_040) {
> -            qemu_printf("S"); /* Supervisor */
> +            monitor_puts(mon, "S"); /* Supervisor */
>          } else {
> -            qemu_printf(".");
> +            monitor_puts(mon, ".");
>          }
>          if (env->mmu.mmusr & M68K_MMU_M_040) {
> -            qemu_printf("M"); /* Modified */
> +            monitor_puts(mon, "M"); /* Modified */
>          } else {
> -            qemu_printf(".");
> +            monitor_puts(mon, ".");
>          }
>          if (env->mmu.mmusr & M68K_MMU_WP_040) {
> -            qemu_printf("W"); /* Write protect */
> +            monitor_puts(mon, "W"); /* Write protect */
>          } else {
> -            qemu_printf(".");
> +            monitor_puts(mon, ".");
>          }
>          if (env->mmu.mmusr & M68K_MMU_T_040) {
> -            qemu_printf("T"); /* Transparent */
> +            monitor_puts(mon, "T"); /* Transparent */
>          } else {
> -            qemu_printf(".");
> +            monitor_puts(mon, ".");
>          }
>          if (env->mmu.mmusr & M68K_MMU_R_040) {
> -            qemu_printf("R"); /* Resident */
> +            monitor_puts(mon, "R"); /* Resident */
>          } else {
> -            qemu_printf(".");
> +            monitor_puts(mon, ".");
>          }
> -        qemu_printf(" Cache: ");
> +        monitor_puts(mon, " Cache: ");
>          DUMP_CACHEFLAGS(env->mmu.mmusr);
> -        qemu_printf(" U: %d\n", (env->mmu.mmusr >> 8) & 3);
> -        qemu_printf("\n");
> +        monitor_printf(mon, " U: %d\n", (env->mmu.mmusr >> 8) & 3);
> +        monitor_puts(mon, "\n");
>      }
>=20=20
> -    qemu_printf("ITTR0: ");
> -    dump_ttr(env->mmu.ttr[M68K_ITTR0]);
> -    qemu_printf("ITTR1: ");
> -    dump_ttr(env->mmu.ttr[M68K_ITTR1]);
> -    qemu_printf("DTTR0: ");
> -    dump_ttr(env->mmu.ttr[M68K_DTTR0]);
> -    qemu_printf("DTTR1: ");
> -    dump_ttr(env->mmu.ttr[M68K_DTTR1]);
> +    monitor_puts(mon, "ITTR0: ");
> +    dump_ttr(mon, env->mmu.ttr[M68K_ITTR0]);
> +    monitor_puts(mon, "ITTR1: ");
> +    dump_ttr(mon, env->mmu.ttr[M68K_ITTR1]);
> +    monitor_puts(mon, "DTTR0: ");
> +    dump_ttr(mon, env->mmu.ttr[M68K_DTTR0]);
> +    monitor_puts(mon, "DTTR1: ");
> +    dump_ttr(mon, env->mmu.ttr[M68K_DTTR1]);
>=20=20
> -    qemu_printf("SRP: 0x%08x\n", env->mmu.srp);
> -    dump_address_map(env, env->mmu.srp);
> +    monitor_printf(mon, "SRP: 0x%08x\n", env->mmu.srp);
> +    dump_address_map(mon, env, env->mmu.srp);
>=20=20
> -    qemu_printf("URP: 0x%08x\n", env->mmu.urp);
> -    dump_address_map(env, env->mmu.urp);
> +    monitor_printf(mon, "URP: 0x%08x\n", env->mmu.urp);
> +    dump_address_map(mon, env, env->mmu.urp);
>  }
>=20=20
>  static int check_TTR(uint32_t ttr, int *prot, target_ulong addr,
> diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
> index 2bdf6acae0..623c6ab635 100644
> --- a/target/m68k/monitor.c
> +++ b/target/m68k/monitor.c
> @@ -15,11 +15,11 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>      CPUArchState *env1 =3D mon_get_cpu_env(mon);
>=20=20
>      if (!env1) {
> -        monitor_printf(mon, "No CPU available\n");
> +        monitor_puts(mon, "No CPU available\n");
>          return;
>      }
>=20=20
> -    dump_mmu(env1);
> +    dump_mmu(mon, env1);
>  }
>=20=20
>  static const MonitorDef monitor_defs[] =3D {

In addition to replacing qemu_printf(), the patch passes the current
monitor around.  The alternative is monitor_cur().  I guess you pass
because you consider it cleaner and/or simpler.  No objection, but I
suggest to mention it the commit message.

The patch is not wrong, so
Reviewed-by: Markus Armbruster <armbru@redhat.com>


