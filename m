Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D54AC79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3uqf-0008QY-9X; Tue, 08 Sep 2026 08:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x3uqc-0008Pv-Dn
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 08:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x3uqY-0001ZL-CR
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 08:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788870159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VcfVwqEeWZMdRshiTtibpjs1fx63i4GlcDQ9y8olyd8=;
 b=Oc2R0mOHaDtSJJ2Ji5ycC9fTpARIqwvY9C9t9xLF6Aw8Bc+4SKi3OKkjfTBggam0IQe2Ar
 PP7Evya/7rgrXCFXS6+p7fMrhuEwcV9m8bVqLN+yecexYjEoXokT4B+tiTAAhAcd8wOX+L
 DnRf3FcD7sAqLvzWo39WSOQcYC9Li9I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-i7Y7RiEONWyerzygV4vsyQ-1; Tue,
 08 Sep 2026 08:22:36 -0400
X-MC-Unique: i7Y7RiEONWyerzygV4vsyQ-1
X-Mimecast-MFC-AGG-ID: i7Y7RiEONWyerzygV4vsyQ_1788870154
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A999519541BC; Tue,  8 Sep 2026 12:22:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6481362; Tue,  8 Sep 2026 12:22:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5C5FE21E6A04; Tue, 08 Sep 2026 14:22:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alano Song <alanosong@gmail.com>
Cc: qemu-devel@nongnu.org,  dave@treblig.org,  marcandre.lureau@gmail.com,
 philmd@oss.qualcomm.com,  laurent@vivier.eu,  atar4qemu@gmail.com,
 zhao1.liu@intel.com,  marcandre.lureau@redhat.com,  Alano Song
 <AlanoSong@163.com>
Subject: Re: [PATCH v4 1/1] monitor: Refine 'info tlb' command
In-Reply-To: <20260907134115.15193-2-AlanoSong@gmail.com> (Alano Song's
 message of "Mon, 7 Sep 2026 21:41:15 +0800")
References: <20260907134115.15193-1-AlanoSong@gmail.com>
 <20260907134115.15193-2-AlanoSong@gmail.com>
Date: Tue, 08 Sep 2026 14:22:30 +0200
Message-ID: <87ik4grkzd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Alano Song <alanosong@gmail.com> writes:

> When booting an i386 target, the 'info tlb' command
> may walk the entire page table hierarchy and emit
> an enormous amount of output. It will take dozens of
> minutes to print all the info.

Reproducer?  I'm asking because my quick test shows just "PG disabled".
Cryptic, but not your patch's job to fix.  Oh, after the guest runs for
a while, I do get a lot of output.  But printing it takes maybe a
second.

> And the same situation also occurred on sparc32 and
> m68k targets.
>
> So this change do the following:
> 1) Add a address range argument to help user control
>    the number of output items.
> 2) Add warning note in help message that such address
>    range argument only supported on target i386,
>    sparc32 and m68k.
> 3) Print ignore warning when user add such address
>    range argument on other targets (sh4, sparc64,
>    ppc and xtensa). Those targets only print limited
>    tlb info.
>
> Signed-off-by: Alano Song <AlanoSong@163.com>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hmp-commands-info.hx      | 17 ++++++--
>  target/i386/monitor.c     | 92 ++++++++++++++++++++++++++++-----------
>  target/m68k/cpu.h         |  2 +-
>  target/m68k/helper.c      | 55 +++++++++++++++--------
>  target/m68k/monitor.c     | 15 ++++++-
>  target/ppc/monitor.c      |  6 +++
>  target/sh4/monitor.c      |  5 +++
>  target/sparc/cpu.h        |  3 ++
>  target/sparc/mmu_helper.c | 40 +++++++++++++----
>  target/sparc/monitor.c    | 23 ++++++++++
>  target/xtensa/monitor.c   |  6 +++
>  11 files changed, 206 insertions(+), 58 deletions(-)
>
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 2695ff04ff..b836a8396e 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -188,17 +188,26 @@ ERST
>=20=20
>      {
>          .name       =3D "tlb",
> -        .args_type  =3D "",
> -        .params     =3D "",
> -        .help       =3D "show virtual to physical memory mappings",
> +        .args_type  =3D "start:l?,end:l?",
> +        .params     =3D "[start [end]]",
> +        .help       =3D "show virtual to physical memory mappings. "
> +                      "output can be extremely large for i386, sparc32 "
> +                      "and m68k targets. use 'info tlb [start [end]]' "
> +                      "to show a range of entries. Note that the range "
> +                      "argument is only supported on i386, sparc32 and "
> +                      "m68k targets.",

The .help value is rather long.

The help command prints a line

    {.name} {.params} -- {.help}

per command.  Here's one that's easy to read:

    object_add [qom-type=3D]type,id=3Dstr[,prop=3Dvalue][,...] -- create QO=
M object

Kind of bad:

    migrate [-d] [-r] [-c uri-cpr] uri -- migrate to URI (using -d to not w=
ait for completion)
                             -r to resume a paused postcopy migration
                             -c to specify a CPR URI for cpr-transfer mode

Worse:

    info tlb [start [end]] -- show virtual to physical memory mappings. out=
put can be extremely large for i386, sparc32 and m68k targets. use 'info tl=
b [start [end]]' to show a range of entries. Note that the range argument i=
s only supported on i386, sparc32 and m68k targets.

Please consider limiting .help to the bare minimum.

If the resulting help output is still wider than 80 columns, consider
line breaks.

>          .cmd        =3D hmp_info_tlb,
>          .arch_bitmask =3D QEMU_ARCH_I386 | QEMU_ARCH_SH4 | QEMU_ARCH_SPA=
RC \
>                          | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M=
68K,

The command exists only for these architectures.

>      },
>=20=20
>  SRST
> -  ``info tlb``
> +  ``info tlb`` [*start* [*end*]]
>      Show virtual to physical memory mappings.
> +    The output can be extremely large for i386, sparc32 and m68k targets.

Such lists tend to bit-rot.  Is the sentence useful here?  It is useful
in the commit message, where it justifies the feature.

What about x86_64 and sparc64?

.arch_bitmask is about architectures, not targets.  Are you confusing
the two?

> +    Use *start* and *end* to print entries located in virtual address
> +    range [start, end] (end is optional). Note that the range argument is

"(end is optional)" is redundant with the square brackets above.  It is
also misleading: start is also optional.  Recommend to drop it.

> +    only supported on i386, sparc32 and m68k targets.

What about x86_64 and sparc64?

How hard would it be to implement the address range feature for all
architectures?

>  ERST
>=20=20
>      {
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index ce61132e0f..d59e67647a 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -50,11 +50,9 @@ static hwaddr addr_canonical(CPUArchState *env, hwaddr=
 addr)
>      return addr;
>  }
>=20=20
> -static void print_pte(MonitorHMP *hmp, CPUArchState *env, hwaddr addr,
> -                      hwaddr pte, hwaddr mask)
> +static void do_print_pte(MonitorHMP *hmp, hwaddr addr,
> +                         hwaddr pte, hwaddr mask)
>  {
> -    addr =3D addr_canonical(env, addr);
> -
>      monitor_hmp_printf(hmp, HWADDR_FMT_plx ": " HWADDR_FMT_plx
>                         " %c%c%c%c%c%c%c%c%c\n",
>                         addr,
> @@ -70,7 +68,25 @@ static void print_pte(MonitorHMP *hmp, CPUArchState *e=
nv, hwaddr addr,
>                         pte & PG_RW_MASK ? 'W' : '-');
>  }
>=20=20
> -static void tlb_info_32(MonitorHMP *hmp, CPUArchState *env, AddressSpace=
 *as)
> +static void print_pte(MonitorHMP *hmp, CPUArchState *env, hwaddr addr,
> +                      hwaddr pte, hwaddr mask, hwaddr size,
> +                      hwaddr start, hwaddr end)
> +{
> +    hwaddr addr_start =3D addr_canonical(env, addr);
> +    hwaddr addr_end =3D addr_canonical(env, addr + size - 1);
> +    /*
> +     * Print current page [addr_start, addr_end] only if it overlaps the
> +     * requested virtual address range [start, end].
> +     */
> +    if (addr_start > end || addr_end < start) {
> +        return;
> +    }
> +
> +    do_print_pte(hmp, addr_start, pte, mask);
> +}
> +
> +static void tlb_info_32(MonitorHMP *hmp, CPUArchState *env, AddressSpace=
 *as,
> +                        hwaddr start, hwaddr end)
>  {
>      const MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
>      unsigned int l1, l2;
> @@ -82,15 +98,16 @@ static void tlb_info_32(MonitorHMP *hmp, CPUArchState=
 *env, AddressSpace *as)
>          if (pde & PG_PRESENT_MASK) {
>              if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
>                  /* 4M pages */
> -                print_pte(hmp, env, (l1 << 22), pde, ~((1 << 21) - 1));
> +                print_pte(hmp, env, (l1 << 22), pde, ~((1 << 21) - 1),
> +                          0x400000, start, end);
>              } else {
>                  for(l2 =3D 0; l2 < 1024; l2++) {
>                      pte =3D address_space_ldl_le(as, (pde & ~0xfff) + l2=
 * 4,
>                                                 attrs, NULL);
>                      if (pte & PG_PRESENT_MASK) {
>                          print_pte(hmp, env, (l1 << 22) + (l2 << 12),
> -                                  pte & ~PG_PSE_MASK,
> -                                  ~0xfff);
> +                                  pte & ~PG_PSE_MASK, ~0xfff, 0x1000,
> +                                  start, end);
>                      }
>                  }
>              }
> @@ -98,7 +115,8 @@ static void tlb_info_32(MonitorHMP *hmp, CPUArchState =
*env, AddressSpace *as)
>      }
>  }
>=20=20
> -static void tlb_info_pae32(MonitorHMP *hmp, CPUArchState *env, AddressSp=
ace *as)
> +static void tlb_info_pae32(MonitorHMP *hmp, CPUArchState *env, AddressSp=
ace *as,
> +                           hwaddr start, hwaddr end)
>  {
>      const MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
>      unsigned int l1, l2, l3;
> @@ -116,17 +134,19 @@ static void tlb_info_pae32(MonitorHMP *hmp, CPUArch=
State *env, AddressSpace *as)
>                      if (pde & PG_PSE_MASK) {
>                          /* 2M pages with PAE, CR4.PSE is ignored */
>                          print_pte(hmp, env, (l1 << 30) + (l2 << 21), pde,
> -                                  ~((hwaddr)(1 << 20) - 1));
> +                                  ~((hwaddr)(1 << 20) - 1), 0x200000,
> +                                  start, end);
>                      } else {
>                          pt_addr =3D pde & 0x3fffffffff000ULL;
>                          for (l3 =3D 0; l3 < 512; l3++) {
>                              pte =3D address_space_ldq_le(as, pt_addr + l=
3 * 8,
>                                                         attrs, NULL);
>                              if (pte & PG_PRESENT_MASK) {
> -                                print_pte(hmp, env, (l1 << 30) + (l2 << =
21)
> -                                          + (l3 << 12),
> +                                print_pte(hmp, env,
> +                                          (l1 << 30) + (l2 << 21) + (l3 =
<< 12),
>                                            pte & ~PG_PSE_MASK,
> -                                          ~(hwaddr)0xfff);
> +                                          ~(hwaddr)0xfff, 0x1000,
> +                                          start, end);
>                              }
>                          }
>                      }
> @@ -138,7 +158,8 @@ static void tlb_info_pae32(MonitorHMP *hmp, CPUArchSt=
ate *env, AddressSpace *as)
>=20=20
>  #ifdef TARGET_X86_64
>  static void tlb_info_la48(MonitorHMP *hmp, CPUArchState *env, AddressSpa=
ce *as,
> -        uint64_t l0, uint64_t pml4_addr)
> +                          uint64_t l0, uint64_t pml4_addr, hwaddr start,
> +                          hwaddr end)
>  {
>      const MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
>      uint64_t l1, l2, l3, l4;
> @@ -161,7 +182,7 @@ static void tlb_info_la48(MonitorHMP *hmp, CPUArchSta=
te *env, AddressSpace *as,
>              if (pdpe & PG_PSE_MASK) {
>                  /* 1G pages, CR4.PSE is ignored */
>                  print_pte(hmp, env, (l0 << 48) + (l1 << 39) + (l2 << 30),
> -                        pdpe, 0x3ffffc0000000ULL);
> +                          pdpe, 0x3ffffc0000000ULL, 0x40000000, start, e=
nd);
>                  continue;
>              }
>=20=20
> @@ -174,8 +195,9 @@ static void tlb_info_la48(MonitorHMP *hmp, CPUArchSta=
te *env, AddressSpace *as,
>=20=20
>                  if (pde & PG_PSE_MASK) {
>                      /* 2M pages, CR4.PSE is ignored */
> -                    print_pte(hmp, env, (l0 << 48) + (l1 << 39) + (l2 <<=
 30) +
> -                            (l3 << 21), pde, 0x3ffffffe00000ULL);
> +                    print_pte(hmp, env,
> +                              (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3=
 << 21),
> +                              pde, 0x3ffffffe00000ULL, 0x200000, start, =
end);
>                      continue;
>                  }
>=20=20
> @@ -184,9 +206,11 @@ static void tlb_info_la48(MonitorHMP *hmp, CPUArchSt=
ate *env, AddressSpace *as,
>                      pte =3D address_space_ldq_le(as, pt_addr + l4 * 8,
>                                                 attrs, NULL);
>                      if (pte & PG_PRESENT_MASK) {
> -                        print_pte(hmp, env, (l0 << 48) + (l1 << 39) +
> -                                (l2 << 30) + (l3 << 21) + (l4 << 12),
> -                                pte & ~PG_PSE_MASK, 0x3fffffffff000ULL);
> +                        print_pte(hmp, env,
> +                                  (l0 << 48) + (l1 << 39) + (l2 << 30) +
> +                                  (l3 << 21) + (l4 << 12),
> +                                  pte & ~PG_PSE_MASK,
> +                                  0x3fffffffff000ULL, 0x1000, start, end=
);
>                      }
>                  }
>              }
> @@ -194,7 +218,8 @@ static void tlb_info_la48(MonitorHMP *hmp, CPUArchSta=
te *env, AddressSpace *as,
>      }
>  }
>=20=20
> -static void tlb_info_la57(MonitorHMP *hmp, CPUArchState *env, AddressSpa=
ce *as)
> +static void tlb_info_la57(MonitorHMP *hmp, CPUArchState *env, AddressSpa=
ce *as,
> +                          hwaddr start, hwaddr end)
>  {
>      const MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
>      uint64_t l0;
> @@ -205,7 +230,8 @@ static void tlb_info_la57(MonitorHMP *hmp, CPUArchSta=
te *env, AddressSpace *as)
>      for (l0 =3D 0; l0 < 512; l0++) {
>          pml5e =3D address_space_ldq_le(as, pml5_addr + l0 * 8, attrs, NU=
LL);
>          if (pml5e & PG_PRESENT_MASK) {
> -            tlb_info_la48(hmp, env, as, l0, pml5e & 0x3fffffffff000ULL);
> +            tlb_info_la48(hmp, env, as, l0, pml5e & 0x3fffffffff000ULL,
> +                          start, end);
>          }
>      }
>  }
> @@ -215,6 +241,18 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdic=
t)
>  {
>      CPUArchState *env;
>      AddressSpace *as;
> +    hwaddr start =3D 0, end =3D HWADDR_MAX;
> +
> +    if (qdict_haskey(qdict, "start")) {
> +        start =3D (hwaddr)qdict_get_int(qdict, "start");
> +    }
> +    if (qdict_haskey(qdict, "end")) {
> +        end =3D (hwaddr)qdict_get_int(qdict, "end");
> +    }
> +    if (start > end) {
> +        monitor_hmp_printf(hmp, "Invalid address range: start > end.\n");

Scratch the period, please.  Same for all the other error messages.

> +        return;
> +    }
>=20=20
>      env =3D monitor_hmp_get_cpu_env(hmp);
>      if (!env) {
> @@ -231,17 +269,19 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdi=
ct)
>  #ifdef TARGET_X86_64
>          if (env->hflags & HF_LMA_MASK) {
>              if (env->cr[4] & CR4_LA57_MASK) {
> -                tlb_info_la57(hmp, env, as);
> +                tlb_info_la57(hmp, env, as, start, end);
>              } else {
> -                tlb_info_la48(hmp, env, as, 0, env->cr[3] & 0x3fffffffff=
000ULL);
> +                tlb_info_la48(hmp, env, as, 0,
> +                              env->cr[3] & 0x3fffffffff000ULL,
> +                              start, end);
>              }
>          } else
>  #endif
>          {
> -            tlb_info_pae32(hmp, env, as);
> +            tlb_info_pae32(hmp, env, as, start, end);
>          }
>      } else {
> -        tlb_info_32(hmp, env, as);
> +        tlb_info_32(hmp, env, as, start, end);
>      }
>  }
>=20=20
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 7cf3791108..b129cb150f 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -606,6 +606,6 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr=
 physaddr, vaddr addr,
>  #define TB_FLAGS_TRACE          16
>  #define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
>=20=20
> -void dump_mmu(CPUM68KState *env);
> +void dump_mmu(CPUM68KState *env, hwaddr start, hwaddr end);
>=20=20
>  #endif
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 5f91d206f5..1b854c912b 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -461,27 +461,46 @@ void m68k_switch_sp(CPUM68KState *env)
>  /* MMU: 68040 only */
>=20=20
>  static void print_address_zone(uint32_t logical, uint32_t physical,
> -                               uint32_t size, int attr)
> +                               uint32_t size, int attr,
> +                               hwaddr start, hwaddr end)
>  {
> +    uint64_t zone_start =3D logical;
> +    uint64_t zone_end =3D zone_start + size - 1;
> +    uint64_t zone_len;
> +
> +    /*
> +     * Print current zone [zone_start, zone_end] only if it overlaps the
> +     * requested virtual address range [start, end].
> +     */
> +    if (zone_end < start || zone_start > end) {
> +        return;
> +    }
> +
> +    physical +=3D (uint32_t)(start > zone_start ? start - zone_start : 0=
);
> +    zone_start =3D zone_start > start ? zone_start : start;
> +    zone_end =3D zone_end < end ? zone_end : end;
> +    zone_len =3D zone_end - zone_start + 1;
> +
>      qemu_printf("%08x - %08x -> %08x - %08x %c ",
> -                logical, logical + size - 1,
> -                physical, physical + size - 1,
> +                (uint32_t)zone_start, (uint32_t)zone_end,
> +                physical, physical + (uint32_t)(zone_len - 1),
>                  attr & 4 ? 'W' : '-');
> -    size >>=3D 10;
> -    if (size < 1024) {
> -        qemu_printf("(%d KiB)\n", size);
> +    zone_len >>=3D 10;
> +    if (zone_len < 1024) {
> +        qemu_printf("(%d KiB)\n", (int)zone_len);
>      } else {
> -        size >>=3D 10;
> -        if (size < 1024) {
> -            qemu_printf("(%d MiB)\n", size);
> +        zone_len >>=3D 10;
> +        if (zone_len < 1024) {
> +            qemu_printf("(%d MiB)\n", (int)zone_len);
>          } else {
> -            size >>=3D 10;
> -            qemu_printf("(%d GiB)\n", size);
> +            zone_len >>=3D 10;
> +            qemu_printf("(%d GiB)\n", (int)zone_len);
>          }
>      }
>  }
>=20=20
> -static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
> +static void dump_address_map(CPUM68KState *env, uint32_t root_pointer,
> +                             hwaddr start, hwaddr end)
>  {
>      int tic_size, tic_shift;
>      uint32_t tib_mask;
> @@ -550,7 +569,8 @@ static void dump_address_map(CPUM68KState *env, uint3=
2_t root_pointer)
>                          size =3D last_logical + (1 << tic_shift) -
>                                 first_logical;
>                          print_address_zone(first_logical,
> -                                           first_physical, size, last_at=
tr);
> +                                           first_physical, size, last_at=
tr,
> +                                           start, end);
>                      }
>                      first_logical =3D logical;
>                      first_physical =3D physical;
> @@ -560,7 +580,8 @@ static void dump_address_map(CPUM68KState *env, uint3=
2_t root_pointer)
>      }
>      if (first_logical !=3D logical || (attr & 4) !=3D (last_attr & 4)) {
>          size =3D logical + (1 << tic_shift) - first_logical;
> -        print_address_zone(first_logical, first_physical, size, last_att=
r);
> +        print_address_zone(first_logical, first_physical, size, last_att=
r,
> +                           start, end);
>      }
>  }
>=20=20
> @@ -610,7 +631,7 @@ static void dump_ttr(uint32_t ttr)
>                                 M68K_DESC_USERATTR_SHIFT);
>  }
>=20=20
> -void dump_mmu(CPUM68KState *env)
> +void dump_mmu(CPUM68KState *env, hwaddr start, hwaddr end)
>  {
>      if ((env->mmu.tcr & M68K_TCR_ENABLED) =3D=3D 0) {
>          qemu_printf("Translation disabled\n");
> @@ -675,10 +696,10 @@ void dump_mmu(CPUM68KState *env)
>      dump_ttr(env->mmu.ttr[M68K_DTTR1]);
>=20=20
>      qemu_printf("SRP: 0x%08x\n", env->mmu.srp);
> -    dump_address_map(env, env->mmu.srp);
> +    dump_address_map(env, env->mmu.srp, start, end);
>=20=20
>      qemu_printf("URP: 0x%08x\n", env->mmu.urp);
> -    dump_address_map(env, env->mmu.urp);
> +    dump_address_map(env, env->mmu.urp, start, end);
>  }
>=20=20
>  static int check_TTR(uint32_t ttr, int *prot, target_ulong addr,
> diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
> index e8b1b25a43..879a005342 100644
> --- a/target/m68k/monitor.c
> +++ b/target/m68k/monitor.c
> @@ -9,17 +9,30 @@
>  #include "cpu.h"
>  #include "monitor/hmp.h"
>  #include "monitor/monitor.h"
> +#include "qobject/qdict.h"
>=20=20
>  #ifdef CONFIG_HMP
>  void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
>  {
>      CPUArchState *env1 =3D monitor_hmp_get_cpu_env(hmp);
> +    hwaddr start =3D 0, end =3D HWADDR_MAX;
>=20=20
>      if (!env1) {
>          monitor_hmp_printf(hmp, "No CPU available\n");
>          return;
>      }
>=20=20
> -    dump_mmu(env1);
> +    if (qdict_haskey(qdict, "start")) {
> +        start =3D (hwaddr)qdict_get_int(qdict, "start");
> +    }
> +    if (qdict_haskey(qdict, "end")) {
> +        end =3D (hwaddr)qdict_get_int(qdict, "end");
> +    }
> +    if (start > end) {
> +        monitor_hmp_printf(hmp, "Invalid address range: start > end.\n");
> +        return;
> +    }
> +
> +    dump_mmu(env1, start, end);
>  }
>  #endif
> diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
> index 5a21c01593..0409e38481 100644
> --- a/target/ppc/monitor.c
> +++ b/target/ppc/monitor.c
> @@ -10,6 +10,7 @@
>  #include "monitor/monitor.h"
>  #include "monitor/hmp.h"
>  #include "cpu.h"
> +#include "qobject/qdict.h"
>=20=20
>  #ifdef CONFIG_HMP
>  void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
> @@ -20,6 +21,11 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
>          monitor_hmp_printf(hmp, "No CPU available\n");
>          return;
>      }
> +
> +    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
> +        monitor_hmp_printf(hmp, "The range arguments will be ignored.\n"=
);
> +    }

When the user requests something the program cannot do, it should fail
the request, not change it to something it can do.  Make this an error,
please.

Same for the other architectures that don't support the feature.

> +
>      dump_mmu(env1);
>  }
>  #endif

[...]


