Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B82CC5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwLV1-0000Xm-7g; Tue, 18 Aug 2026 11:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wwLUz-0000XX-LW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 11:13:09 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wwLUw-0004pp-KW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 11:13:09 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cc11a30a259so3716187a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 08:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787065985; cv=none;
 d=google.com; s=arc-20260327;
 b=aCYmGCDjHSL5iMRgqBv4sNCTrR/opKo4TDkabuySbSVgyNtvA9kckwQKdWkoOcTe6S
 QYLfZygdFnDt+Jq2e1YFFUXL5MHkPhsa+rDwaSf945W9MlPFHEWD4Iikx5OT+lImTT0d
 xdyuLkVY4S2Acrsn7bggSYEd6rl9Njn+sdypYidDGlLQLns0PX01WuQmtbqOWNL5kF6w
 cBZBXSEwF62ralrlblSDDvJHsohLEWoL3QRXQjw2wmC3s2b4Xzv7ZVhUc3mqyEivGGrm
 knsz2msC0VPbFb9i1L3qdHxtiS/tDm+xgfCwBfjJHS4W8Sr4O7lv8u47LxSkUbc8J97v
 ShKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n9dra484eFFrJAW+MTWlSyEw8aV1V+k+o2HT4CQDX9E=;
 fh=abX2eQd+UvXyqA7GwHdySKxIihrEb63mZN4rxDNEz9o=;
 b=Zm9ZjwBEnjUpXv3zkfdwcgTL5tx8C7+WBHVQDlG4zxPuze7nOvLBZ+bek/OAGHlHmQ
 C0npSsBnv+LDFy+nl/zJZ3Xqt+cQfaGxZj050Ee5COHZfa1iv4F5Tiav38mMMHCg61Om
 hrlGQnKk7/EoeMMkcpqlreui7oJZnHTZNxzIJV+XKsVaDn1tC2f2y6GLQAI/Wl5vU+/Z
 OxfHj4rXYdMgDEsZYpXPi9D3HEfHfY9uzPpRu/W8KRwy4nT6cAmKivqg62a/ofVIlIM1
 SRJ8wJLYMmSytBtsF8u55P0jTVxxb9bwZSKYsV+L73UH0dn5C5x/bgm/PUSAXxf3+b0M
 Q5KA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787065985; x=1787670785; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n9dra484eFFrJAW+MTWlSyEw8aV1V+k+o2HT4CQDX9E=;
 b=WajNQU+prwoCe7lswHezWGfmXG5twORjjl7ZI1U2Z4uHN2QZggXN28NRilAecW6qr1
 PyCzuv9MM1EekeIp3g0T7VK/j6nUVccymtaxBYRkBECiGoylEcKaJa5FLL7eDgdgvVq6
 HS7rQZiq77YFVpYfnDMj+nqgYnBewcqhSnzFB/VmLMXBKtuUP9pIPlOQcanekHxB/3Lj
 VNCYGtuMoT94oMNRlnBajM5M0otY8sNEraaldb8h8xkNUR/WMoDZ+ZclIEoH/rgI4UHt
 nw1j1Cx6A2SEEVS3A0ApV1GCVUo6pdBivYPzJpAkcR2LsL78JcdW2s8heEV54dBD2Rl3
 PGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787065985; x=1787670785;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n9dra484eFFrJAW+MTWlSyEw8aV1V+k+o2HT4CQDX9E=;
 b=aaaXPSGxTQFu6Vyfm9RVScwuBA1DIERLP77zxT6KPO50OqPEM/RV0iep6syC5bAnpq
 V0/AK1Htq08E9iwLgSs32c+HN5q9ooe3Gc3Py5HfcJJbhzq5meSsK7RNZIr2yZSvAW4c
 ejxXXGg8SOsv7dMHZ4y/UNf9jUf9VY97xoHBHsrRPV1nq4fnom9kLr10nnX8JnQ/ud8n
 Q4PY1FdMEzjW+ZmfM3xi20VGf72Vyamfg47EGHSJNfXU/rvFxj+e7TqWPmxa8eVOX8g3
 WpyfkhRs+rn9t0aEO0ygEwm7JiSFJSoIuPum7xzjjvwISiQZd1sJ/mQj0Ivokczvohas
 W1Iw==
X-Gm-Message-State: AOJu0YyA9Jw2Qe8hkS5sGa83+r99OI3hFwpU2r2TyqUNbZTM4tfjq1Zv
 CbUFsGGyFl8GQgYPGVvJvtt6buP7biHqz3lFGsQMp+TNxn+oCNbnXOYWq2lo0Xnaon0zD9sCap5
 MnZ7N0kZ45L+RYLpYQ7UCUKKw/F8NnQU=
X-Gm-Gg: AR+sD10R+1QudDBc7MH+oT8dQKMprMZ1d4VKZ9MXC/7Fu6c09N7LdHvIfyllnqkoxOE
 kEf6TFaZjs6RMhzSQNpWCsv1CBIGQrNKGqdyttP2fOz7uZCm18fg3cNgYB2mnHGGcq25enPrX+P
 sRfPxi7n6NTVzxMCuoEClLaiVKYLxtkVwJgjooQWEYTxzEo86pxlIjkA/sIcgMi9+hJdBIcxTK7
 kG1KK6SeDRLyAEu8H14iYQWcfsPTElmQbSjPYlnQ77jXjdTtzd6GKd8ZV4sd7IywF4pabqV5tN7
 DpPq1mAM51KjFM0tRzUbw0GvHfb2Dg5ZB4uFFcJsf4z5vqcMyU/pxMlx77S5ueTKlGhtIiPX4To
 o
X-Received: by 2002:a05:6a20:728c:b0:3c3:89cf:f3a with SMTP id
 adf61e73a8af0-3cc71af37e0mr38821455637.5.1787065984479; Tue, 18 Aug 2026
 08:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260818132519.186010-1-AlanoSong@163.com>
In-Reply-To: <20260818132519.186010-1-AlanoSong@163.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Aug 2026 19:12:51 +0400
X-Gm-Features: AcwNN1VW3rGX903y6ZzI5hhlEthI5cTc-KjS85r17WkRxtUCks8GUIzEKu66bTs
Message-ID: <CAJ+F1CJ7swW-JWMoRT8=v4hsdGk-O5eFsD=n8XBCirjBHJWAgA@mail.gmail.com>
Subject: Re: [PATCH v3] monitor: Refine 'info tlb' command
To: AlanoSong@163.com
Cc: qemu-devel@nongnu.org, dave@treblig.org, laurent@vivier.eu, 
 zhao1.liu@intel.com, atar4qemu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52c.google.com
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

Hi

On Tue, Aug 18, 2026 at 5:30=E2=80=AFPM <AlanoSong@163.com> wrote:
>
> When booting an i386 target, the 'info tlb' command
> may walk the entire page table hierarchy and emit
> an enormous amount of output. It will take dozens of
> minutes to print all the info, and
> The same situation also occurred on sparc32 and
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

lgtm overall

- m68k print_address_zone() used to be called with page-aligned zones,
but now it is clipped to arbitrary user ranges, which may not be
aligned. 1 byte range will be reported as 0kb. We may want to handle
the case for small ranges. Btw that code could use the macros KiB for
readability

- A later patch could prune non-overlapping ranges during traversal,
not just during printing

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
> index 82134eb6c2..f907edf273 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -188,17 +188,26 @@ ERST
>
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
>          .cmd        =3D hmp_info_tlb,
>          .arch_bitmask =3D QEMU_ARCH_I386 | QEMU_ARCH_SH4 | QEMU_ARCH_SPA=
RC \
>                          | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M=
68K,
>      },
>
>  SRST
> -  ``info tlb``
> +  ``info tlb`` [*start* [*end*]]
>      Show virtual to physical memory mappings.
> +    The output can be extremely large for i386, sparc32 and m68k targets=
.
> +    Use *start* and *end* to print entries located in virtual address
> +    range [start, end] (end is optional). Note that the range argument i=
s
> +    only supported on i386, sparc32 and m68k targets.
>  ERST
>
>      {
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index a536712c75..8db9ab0576 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -48,11 +48,9 @@ static hwaddr addr_canonical(CPUArchState *env, hwaddr=
 addr)
>      return addr;
>  }
>
> -static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
> -                      hwaddr pte, hwaddr mask)
> +static void do_print_pte(Monitor *mon, hwaddr addr,
> +                         hwaddr pte, hwaddr mask)
>  {
> -    addr =3D addr_canonical(env, addr);
> -
>      monitor_printf(mon, HWADDR_FMT_plx ": " HWADDR_FMT_plx
>                     " %c%c%c%c%c%c%c%c%c\n",
>                     addr,
> @@ -68,7 +66,25 @@ static void print_pte(Monitor *mon, CPUArchState *env,=
 hwaddr addr,
>                     pte & PG_RW_MASK ? 'W' : '-');
>  }
>
> -static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *a=
s)
> +static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
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
> +    do_print_pte(mon, addr_start, pte, mask);
> +}
> +
> +static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *a=
s,
> +                        hwaddr start, hwaddr end)
>  {
>      const MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
>      unsigned int l1, l2;
> @@ -80,15 +96,16 @@ static void tlb_info_32(Monitor *mon, CPUArchState *e=
nv, AddressSpace *as)
>          if (pde & PG_PRESENT_MASK) {
>              if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
>                  /* 4M pages */
> -                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1));
> +                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1),
> +                          0x400000, start, end);
>              } else {
>                  for(l2 =3D 0; l2 < 1024; l2++) {
>                      pte =3D address_space_ldl_le(as, (pde & ~0xfff) + l2=
 * 4,
>                                                 attrs, NULL);
>                      if (pte & PG_PRESENT_MASK) {
>                          print_pte(mon, env, (l1 << 22) + (l2 << 12),
> -                                  pte & ~PG_PSE_MASK,
> -                                  ~0xfff);
> +                                  pte & ~PG_PSE_MASK, ~0xfff, 0x1000,
> +                                  start, end);
>                      }
>                  }
>              }
> @@ -96,7 +113,8 @@ static void tlb_info_32(Monitor *mon, CPUArchState *en=
v, AddressSpace *as)
>      }
>  }
>
> -static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace=
 *as)
> +static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace=
 *as,
> +                           hwaddr start, hwaddr end)
>  {
>      const MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
>      unsigned int l1, l2, l3;
> @@ -114,17 +132,19 @@ static void tlb_info_pae32(Monitor *mon, CPUArchSta=
te *env, AddressSpace *as)
>                      if (pde & PG_PSE_MASK) {
>                          /* 2M pages with PAE, CR4.PSE is ignored */
>                          print_pte(mon, env, (l1 << 30) + (l2 << 21), pde=
,
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
> -                                print_pte(mon, env, (l1 << 30) + (l2 << =
21)
> -                                          + (l3 << 12),
> +                                print_pte(mon, env,
> +                                          (l1 << 30) + (l2 << 21) + (l3 =
<< 12),
>                                            pte & ~PG_PSE_MASK,
> -                                          ~(hwaddr)0xfff);
> +                                          ~(hwaddr)0xfff, 0x1000,
> +                                          start, end);
>                              }
>                          }
>                      }
> @@ -136,7 +156,8 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState=
 *env, AddressSpace *as)
>
>  #ifdef TARGET_X86_64
>  static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace =
*as,
> -        uint64_t l0, uint64_t pml4_addr)
> +                          uint64_t l0, uint64_t pml4_addr, hwaddr start,
> +                          hwaddr end)
>  {
>      const MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
>      uint64_t l1, l2, l3, l4;
> @@ -159,7 +180,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState =
*env, AddressSpace *as,
>              if (pdpe & PG_PSE_MASK) {
>                  /* 1G pages, CR4.PSE is ignored */
>                  print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30)=
,
> -                        pdpe, 0x3ffffc0000000ULL);
> +                          pdpe, 0x3ffffc0000000ULL, 0x40000000, start, e=
nd);
>                  continue;
>              }
>
> @@ -172,8 +193,9 @@ static void tlb_info_la48(Monitor *mon, CPUArchState =
*env, AddressSpace *as,
>
>                  if (pde & PG_PSE_MASK) {
>                      /* 2M pages, CR4.PSE is ignored */
> -                    print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 <<=
 30) +
> -                            (l3 << 21), pde, 0x3ffffffe00000ULL);
> +                    print_pte(mon, env,
> +                              (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3=
 << 21),
> +                              pde, 0x3ffffffe00000ULL, 0x200000, start, =
end);
>                      continue;
>                  }
>
> @@ -182,9 +204,11 @@ static void tlb_info_la48(Monitor *mon, CPUArchState=
 *env, AddressSpace *as,
>                      pte =3D address_space_ldq_le(as, pt_addr + l4 * 8,
>                                                 attrs, NULL);
>                      if (pte & PG_PRESENT_MASK) {
> -                        print_pte(mon, env, (l0 << 48) + (l1 << 39) +
> -                                (l2 << 30) + (l3 << 21) + (l4 << 12),
> -                                pte & ~PG_PSE_MASK, 0x3fffffffff000ULL);
> +                        print_pte(mon, env,
> +                                  (l0 << 48) + (l1 << 39) + (l2 << 30) +
> +                                  (l3 << 21) + (l4 << 12),
> +                                  pte & ~PG_PSE_MASK,
> +                                  0x3fffffffff000ULL, 0x1000, start, end=
);
>                      }
>                  }
>              }
> @@ -192,7 +216,8 @@ static void tlb_info_la48(Monitor *mon, CPUArchState =
*env, AddressSpace *as,
>      }
>  }
>
> -static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace =
*as)
> +static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace =
*as,
> +                          hwaddr start, hwaddr end)
>  {
>      const MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
>      uint64_t l0;
> @@ -203,7 +228,8 @@ static void tlb_info_la57(Monitor *mon, CPUArchState =
*env, AddressSpace *as)
>      for (l0 =3D 0; l0 < 512; l0++) {
>          pml5e =3D address_space_ldq_le(as, pml5_addr + l0 * 8, attrs, NU=
LL);
>          if (pml5e & PG_PRESENT_MASK) {
> -            tlb_info_la48(mon, env, as, l0, pml5e & 0x3fffffffff000ULL);
> +            tlb_info_la48(mon, env, as, l0, pml5e & 0x3fffffffff000ULL,
> +                          start, end);
>          }
>      }
>  }
> @@ -213,6 +239,18 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
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
> +        monitor_printf(mon, "Invalid address range: start > end.\n");
> +        return;
> +    }
>
>      env =3D mon_get_cpu_env(mon);
>      if (!env) {
> @@ -229,17 +267,19 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  #ifdef TARGET_X86_64
>          if (env->hflags & HF_LMA_MASK) {
>              if (env->cr[4] & CR4_LA57_MASK) {
> -                tlb_info_la57(mon, env, as);
> +                tlb_info_la57(mon, env, as, start, end);
>              } else {
> -                tlb_info_la48(mon, env, as, 0, env->cr[3] & 0x3fffffffff=
000ULL);
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
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 7cf3791108..b129cb150f 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -606,6 +606,6 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr=
 physaddr, vaddr addr,
>  #define TB_FLAGS_TRACE          16
>  #define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
>
> -void dump_mmu(CPUM68KState *env);
> +void dump_mmu(CPUM68KState *env, hwaddr start, hwaddr end);
>
>  #endif
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 5f91d206f5..1b854c912b 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -461,27 +461,46 @@ void m68k_switch_sp(CPUM68KState *env)
>  /* MMU: 68040 only */
>
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
>
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
>
> @@ -610,7 +631,7 @@ static void dump_ttr(uint32_t ttr)
>                                 M68K_DESC_USERATTR_SHIFT);
>  }
>
> -void dump_mmu(CPUM68KState *env)
> +void dump_mmu(CPUM68KState *env, hwaddr start, hwaddr end)
>  {
>      if ((env->mmu.tcr & M68K_TCR_ENABLED) =3D=3D 0) {
>          qemu_printf("Translation disabled\n");
> @@ -675,10 +696,10 @@ void dump_mmu(CPUM68KState *env)
>      dump_ttr(env->mmu.ttr[M68K_DTTR1]);
>
>      qemu_printf("SRP: 0x%08x\n", env->mmu.srp);
> -    dump_address_map(env, env->mmu.srp);
> +    dump_address_map(env, env->mmu.srp, start, end);
>
>      qemu_printf("URP: 0x%08x\n", env->mmu.urp);
> -    dump_address_map(env, env->mmu.urp);
> +    dump_address_map(env, env->mmu.urp, start, end);
>  }
>
>  static int check_TTR(uint32_t ttr, int *prot, target_ulong addr,
> diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
> index 3e0df40a6b..bcb528d8e3 100644
> --- a/target/m68k/monitor.c
> +++ b/target/m68k/monitor.c
> @@ -9,15 +9,28 @@
>  #include "cpu.h"
>  #include "monitor/hmp.h"
>  #include "monitor/monitor.h"
> +#include "qobject/qdict.h"
>
>  void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  {
>      CPUArchState *env1 =3D mon_get_cpu_env(mon);
> +    hwaddr start =3D 0, end =3D HWADDR_MAX;
>
>      if (!env1) {
>          monitor_printf(mon, "No CPU available\n");
>          return;
>      }
>
> -    dump_mmu(env1);
> +    if (qdict_haskey(qdict, "start")) {
> +        start =3D (hwaddr)qdict_get_int(qdict, "start");
> +    }
> +    if (qdict_haskey(qdict, "end")) {
> +        end =3D (hwaddr)qdict_get_int(qdict, "end");
> +    }
> +    if (start > end) {
> +        monitor_printf(mon, "Invalid address range: start > end.\n");
> +        return;
> +    }
> +
> +    dump_mmu(env1, start, end);
>  }
> diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
> index 7c88e0e2bd..753ed6b93d 100644
> --- a/target/ppc/monitor.c
> +++ b/target/ppc/monitor.c
> @@ -10,6 +10,7 @@
>  #include "monitor/monitor.h"
>  #include "monitor/hmp.h"
>  #include "cpu.h"
> +#include "qobject/qdict.h"
>
>  void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  {
> @@ -19,5 +20,10 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "No CPU available\n");
>          return;
>      }
> +
> +    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
> +        monitor_printf(mon, "The range arguments will be ignored.\n");
> +    }
> +
>      dump_mmu(env1);
>  }
> diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
> index 50324d3600..c804824bab 100644
> --- a/target/sh4/monitor.c
> +++ b/target/sh4/monitor.c
> @@ -25,6 +25,7 @@
>  #include "cpu.h"
>  #include "monitor/monitor.h"
>  #include "monitor/hmp.h"
> +#include "qobject/qdict.h"
>
>  static void print_tlb(Monitor *mon, int idx, tlb_t *tlb)
>  {
> @@ -48,6 +49,10 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>          return;
>      }
>
> +    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
> +        monitor_printf(mon, "The range arguments will be ignored.\n");
> +    }
> +
>      monitor_printf (mon, "ITLB:\n");
>      for (i =3D 0 ; i < ITLB_SIZE ; i++)
>          print_tlb (mon, i, &env->itlb[i]);
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 5f583ed9de..11f94b6bd8 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -601,6 +601,9 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, =
int size,
>                          bool probe, uintptr_t retaddr);
>  target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmu=
lev);
>  void dump_mmu(CPUSPARCState *env);
> +#ifndef TARGET_SPARC64
> +void dump_mmu_range(CPUSPARCState *env, hwaddr start, hwaddr end);
> +#endif
>
>  #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
>  int sparc_cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index 07ba25dfce..65a30b438b 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -354,7 +354,32 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ul=
ong address, int mmulev)
>      return 0;
>  }
>
> +static void print_tlb_entry(target_ulong va, hwaddr pa, uint32_t pde,
> +                            const char *indent, const char *kind,
> +                            hwaddr size, hwaddr start, hwaddr end)
> +{
> +    hwaddr va_hw_start =3D (hwaddr)va;
> +    hwaddr va_hw_end =3D (hwaddr)(va + size - 1);
> +
> +    /*
> +     * Print current region [va_hw_start, va_hw_end] only if it overlaps=
 the
> +     * requested virtual address range [start, end].
> +     */
> +    if (va_hw_start > end || va_hw_end < start) {
> +        return;
> +    }
> +
> +    qemu_printf("%sVA: " TARGET_FMT_lx ", PA: " HWADDR_FMT_plx
> +                " %s: " TARGET_FMT_lx "\n",
> +                indent, va, pa, kind, pde);
> +}
> +
>  void dump_mmu(CPUSPARCState *env)
> +{
> +    dump_mmu_range(env, 0, HWADDR_MAX);
> +}
> +
> +void dump_mmu_range(CPUSPARCState *env, hwaddr start, hwaddr end)
>  {
>      CPUState *cs =3D env_cpu(env);
>      target_ulong va, va1, va2;
> @@ -373,8 +398,8 @@ void dump_mmu(CPUSPARCState *env)
>              } else {
>                  pa =3D tres.physaddr;
>              }
> -            qemu_printf("VA: " TARGET_FMT_lx ", PA: " HWADDR_FMT_plx
> -                        " PDE: " TARGET_FMT_lx "\n", va, pa, pde);
> +            print_tlb_entry(va, pa, pde, "", "PDE", 16 * 1024 * 1024,
> +                            start, end);
>              for (m =3D 0, va1 =3D va; m < 64; m++, va1 +=3D 256 * 1024) =
{
>                  pde =3D mmu_probe(env, va1, 1);
>                  if (pde) {
> @@ -383,9 +408,8 @@ void dump_mmu(CPUSPARCState *env)
>                      } else {
>                          pa =3D tres.physaddr;
>                      }
> -                    qemu_printf(" VA: " TARGET_FMT_lx ", PA: "
> -                                HWADDR_FMT_plx " PDE: " TARGET_FMT_lx "\=
n",
> -                                va1, pa, pde);
> +                    print_tlb_entry(va1, pa, pde, " ", "PDE", 256 * 1024=
,
> +                                    start, end);
>                      for (o =3D 0, va2 =3D va1; o < 64; o++, va2 +=3D 4 *=
 1024) {
>                          pde =3D mmu_probe(env, va2, 0);
>                          if (pde) {
> @@ -394,10 +418,8 @@ void dump_mmu(CPUSPARCState *env)
>                              } else {
>                                  pa =3D tres.physaddr;
>                              }
> -                            qemu_printf("  VA: " TARGET_FMT_lx ", PA: "
> -                                        HWADDR_FMT_plx " PTE: "
> -                                        TARGET_FMT_lx "\n",
> -                                        va2, pa, pde);
> +                            print_tlb_entry(va2, pa, pde, "  ", "PTE",
> +                                            4 * 1024, start, end);
>                          }
>                      }
>                  }
> diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
> index 36f3d8d58e..993e411a37 100644
> --- a/target/sparc/monitor.c
> +++ b/target/sparc/monitor.c
> @@ -25,6 +25,7 @@
>  #include "cpu.h"
>  #include "monitor/monitor.h"
>  #include "monitor/hmp.h"
> +#include "qobject/qdict.h"
>
>
>  void hmp_info_tlb(Monitor *mon, const QDict *qdict)
> @@ -35,5 +36,27 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "No CPU available\n");
>          return;
>      }
> +
> +#ifdef TARGET_SPARC64
> +    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
> +        monitor_printf(mon, "The range arguments will be ignored.\n");
> +    }
> +
>      dump_mmu(env1);
> +#else
> +    hwaddr start =3D 0, end =3D HWADDR_MAX;
> +
> +    if (qdict_haskey(qdict, "start")) {
> +        start =3D (hwaddr)qdict_get_int(qdict, "start");
> +    }
> +    if (qdict_haskey(qdict, "end")) {
> +        end =3D (hwaddr)qdict_get_int(qdict, "end");
> +    }
> +    if (start > end) {
> +        monitor_printf(mon, "Invalid address range: start > end.\n");
> +        return;
> +    }
> +
> +    dump_mmu_range(env1, start, end);
> +#endif
>  }
> diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
> index 2af84934f8..df572cba42 100644
> --- a/target/xtensa/monitor.c
> +++ b/target/xtensa/monitor.c
> @@ -25,6 +25,7 @@
>  #include "cpu.h"
>  #include "monitor/monitor.h"
>  #include "monitor/hmp.h"
> +#include "qobject/qdict.h"
>
>  void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  {
> @@ -34,5 +35,10 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "No CPU available\n");
>          return;
>      }
> +
> +    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
> +        monitor_printf(mon, "The range arguments will be ignored.\n");
> +    }
> +
>      dump_mmu(env1);
>  }
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

