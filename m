Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3875E1099B32
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 18:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3eGZ-0004tS-QJ; Fri, 20 Mar 2026 14:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1w3eGY-0004t9-6s
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:08:10 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1w3eGV-0002gC-1S
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:08:09 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-89c55a0a470so10728216d6.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 11:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774030086; cv=none;
 d=google.com; s=arc-20240605;
 b=lkSADdqqTzluP45pThynVakTQ1cQ5MNTMKjxm/XnVe5qKd9/6RDRzoQFEB3cEFdVf5
 i0ZiOYrRXcHgXiVwTmVSNVu71EpF7HMa1YFDA+fV9lE+uf1Nul6K2nik6sQcNVg6jkyx
 dlz/XLFSfrRJFuy/mELdhjzLoZprfIfeTFmror+SFenpxiueBmeGM9sx7m9Ft47cxXFj
 iTFzNM+rMqOxzqK2x15nhLOoE6Z2aq3WxCkv8ELMWVdiAmnswjWhFm21X0LrW4F1JMPv
 hMydwY5WyH348ZlFppaDfcm6e4bonwn77ifWdYpEyS0V1+5iF5HpHX7pqW4ktxIALyna
 XjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g2xZ9bOYx4kRaDIY/YzgU1RfVXRlgdKdqn4QiR+ZT1Q=;
 fh=c0erNo+sJ29Z5IwzOrma4WhJmO9gKlXEZkjXKP7KWY8=;
 b=ORBCZyc0uQE1jPb09ifd84XRT5mdam/hLLNFLp5dqKFBrAEJIt6LldU5Aktloi+/Yx
 PD4JfZGlbbMJzkTvXMuR9Uag7Mm+ViXGVVJ7hutcTe0uPQ2q12EE4IoH6wv487JpQZdY
 wJeSqc4x/HFDsKd/bjStiLrGx1mPy3Y8sSAd8ps/BYtjq3jpGfzSYiXzWqwkzcD3iW40
 vKePZ+19g5RBPibQ7LGkzjjQJ6ljNt1tOgN4TIAcmLLKF8Ef0Vl6OllM6jfXjXl8t994
 G+q6CCYg5Tt5SgLnPHK1V16Aa104+5FAvUuT9YhPh7zC6wmfaTRDm7eVdBsYnb9iXi2+
 MSoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774030086; x=1774634886; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g2xZ9bOYx4kRaDIY/YzgU1RfVXRlgdKdqn4QiR+ZT1Q=;
 b=nNyuSla3nPwbGuJBTMB+kCiq+CBRFI8OzhjJcHO0tobi5qmGQEnJq9Lq9hPkbPQwmI
 uB7GT4cbXGkKXzAr84nR1ZV/9U3r7d52quQHVWLPQwkLqCPH6PA3sUlLExn1dILXPOvL
 s2i7Sfhx+j9Eu8ASk+FJdyjgN4BuYBGowY2YFcD0IF5pBOWcV7RjPmE4MVsDkgk+Albc
 MlxZfPPBqQ0E8k6iGdvVA77wAGHGUmiZ1F1Y58EJtLs5zA2Y60y9BEBfg1Av62HvPGfV
 J43LKhxI30eZKrP7FDjw6kvT9HCsj3n6e34VLIdISnn/FEe0uD7s1uVkJzZJ0K+jfBdS
 VIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774030086; x=1774634886;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g2xZ9bOYx4kRaDIY/YzgU1RfVXRlgdKdqn4QiR+ZT1Q=;
 b=WSuhjoKakHtmAI2upySY7hi7XC9dglPTaf+zrco5HtKfpIU2aif1IVIKwtBc9JyMxM
 1eyQ5cqxwzo8rWVVrHyUdoqvjGYbUzu81jGnhgofVp9LwjcCQAFvRobJ7Kn6GaLIG2y+
 oFPeon4FqJSDdyJ+lcz/YeZlZKdseT24+2Wl7zO+Y71TcoS4s+QYZHFYESD7Mn6jsCid
 VjgTq8KcDDatMngzpXyp9nVm9tS9ChIEAiKTOAgAkDiVLSRAbMzRON7Xrayj7Yjli6BH
 GFTvlfFE9DtxnB4197PbyCXwov4eMFIZiBzzUJxuEqRHRZENlRDPgIIp6RGLoMRIH2r/
 TzYA==
X-Gm-Message-State: AOJu0Yzbab3/FqDWRA2QHmZvjEPifyyOVcW5QWKwejDA0d3dc0U/gzvQ
 aJj40Ludv8N3sskm/4M8LRyxzcSvY9WhWOdZboV6dxUTGGs9EvoZG642KEznWjPHgIo73fBxEBZ
 hOs/+i7+nZYY5md0H3xuBDBSwi6awBSI=
X-Gm-Gg: ATEYQzxrFLGZXfq9pGBTuiwRVMSZifIzvYpM6sMSvQsP7aIy319k2IInbSoVMGpw4VZ
 fgeOYfpo+h3jmRQVTpBAw3KqheZfODE/+Dz3cwE1UBws4oPfZLaW5Oiva1FRFbsKUlNsezvHOtq
 S+lSvK+TlT7PnJzzd4ruyLweWYBYgPgeV539n54El3mt+3E8biNcwJciQuBlkiXUoq1yOJ6r3OO
 XYcIZcGhpcQceaLpxQiVY2kZbgLwnnXBpgoz08K0eKQaBru/6fFoVeLS00G/gfruK5yIPg0Y5dZ
 deRvAdhqTi+gCT2buWfXM6/f2P4PtNObzwIiA0yX0R+Gg025hB6bBz0lIMt8cvbXFaI=
X-Received: by 2002:a05:6214:4603:b0:89c:5963:b2ef with SMTP id
 6a1803df08f44-89c85aa5b8bmr62505516d6.63.1774030085514; Fri, 20 Mar 2026
 11:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260320165021.39521-1-philmd@linaro.org>
 <20260320165021.39521-4-philmd@linaro.org>
In-Reply-To: <20260320165021.39521-4-philmd@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 20 Mar 2026 11:07:53 -0700
X-Gm-Features: AaiRm52BJ9YTD-53j0QXs6khrctgL-_9ZPfSDZif1Z3_hZA7_qf6pozFQRVdW7c
Message-ID: <CAMo8Bf+EOsfMk4=Ari2-jsHO6-Py_YVKmGEent49Gov65dTB3w@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 v2 3/7] target/xtensa: Have 'info tlb' dump MMU
 information on monitor
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Glenn Miles <milesg@linux.ibm.com>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-qv1-xf2a.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 20, 2026 at 9:50=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Currently 'info tlb' dumps the MMU information on stdout.
> Propagate the @Monitor argument and replace qemu_printf() by
> monitor_printf() -- or monitor_puts when no formatting -- to
> dump information over the monitor (which is not always stdout).
>
> Fixes: d41160a3e64 ("Sparc: implement monitor command 'info tlb'")

This commit reference doesn't look right, as none of the changed
code was introduced in that commit.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/xtensa/cpu.h        |  2 +-
>  target/xtensa/mmu_helper.c | 44 +++++++++++++++++++-------------------
>  target/xtensa/monitor.c    |  2 +-
>  3 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index dfd2ceab7cf..caec22bb742 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -693,7 +693,7 @@ int xtensa_get_physical_addr(CPUXtensaState *env, boo=
l update_tlb,
>          uint32_t vaddr, int is_write, int mmu_idx,
>          uint32_t *paddr, uint32_t *page_size, unsigned *access);
>  void reset_mmu(CPUXtensaState *env);
> -void dump_mmu(CPUXtensaState *env);
> +void dump_mmu(Monitor *mon, CPUXtensaState *env);
>
>  static inline MemoryRegion *xtensa_get_er_region(CPUXtensaState *env)
>  {
> diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
> index 71330fc84b9..9dbf671228b 100644
> --- a/target/xtensa/mmu_helper.c
> +++ b/target/xtensa/mmu_helper.c
> @@ -27,7 +27,6 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> -#include "qemu/qemu-print.h"
>  #include "qemu/units.h"
>  #include "cpu.h"
>  #include "exec/helper-proto.h"
> @@ -38,6 +37,7 @@
>  #include "exec/page-protection.h"
>  #include "exec/target_page.h"
>  #include "system/memory.h"
> +#include "monitor/monitor.h"
>
>  #define XTENSA_MPU_SEGMENT_MASK 0x0000001f
>  #define XTENSA_MPU_ACC_RIGHTS_MASK 0x00000f00
> @@ -1082,7 +1082,7 @@ int xtensa_get_physical_addr(CPUXtensaState *env, b=
ool update_tlb,
>      }
>  }
>
> -static void dump_tlb(CPUXtensaState *env, bool dtlb)
> +static void dump_tlb(Monitor *mon, CPUXtensaState *env, bool dtlb)
>  {
>      unsigned wi, ei;
>      const xtensa_tlb *conf =3D
> @@ -1121,11 +1121,11 @@ static void dump_tlb(CPUXtensaState *env, bool dt=
lb)
>
>                  if (print_header) {
>                      print_header =3D false;
> -                    qemu_printf("Way %u (%d %s)\n", wi, sz, sz_text);
> -                    qemu_printf("\tVaddr       Paddr       ASID  Attr RW=
X Cache\n"
> +                    monitor_printf(mon, "Way %u (%d %s)\n", wi, sz, sz_t=
ext);
> +                    monitor_puts(mon, "\tVaddr       Paddr       ASID  A=
ttr RWX Cache\n"
>                                  "\t----------  ----------  ----  ---- --=
- -------\n");

These lines are aligned in the code same way as they are aligned
in the output. It'd be nice if this alignment could be preserved.

>                  }
> -                qemu_printf("\t0x%08x  0x%08x  0x%02x  0x%02x %c%c%c %s\=
n",
> +                monitor_printf(mon, "\t0x%08x  0x%08x  0x%02x  0x%02x %c=
%c%c %s\n",
>                              entry->vaddr,
>                              entry->paddr,
>                              entry->asid,
> @@ -1140,12 +1140,12 @@ static void dump_tlb(CPUXtensaState *env, bool dt=
lb)
>      }
>  }
>
> -static void dump_mpu(CPUXtensaState *env,
> +static void dump_mpu(Monitor *mon, CPUXtensaState *env,
>                       const xtensa_mpu_entry *entry, unsigned n)
>  {
>      unsigned i;
>
> -    qemu_printf("\t%s  Vaddr       Attr        Ring0  Ring1  System Type=
    CPU cache\n"
> +    monitor_printf(mon, "\t%s  Vaddr       Attr        Ring0  Ring1  Sys=
tem Type    CPU cache\n"
>                  "\t%s  ----------  ----------  -----  -----  -----------=
--  ---------\n",

Same here.

>                  env ? "En" : "  ",
>                  env ? "--" : "  ");
> @@ -1157,7 +1157,7 @@ static void dump_mpu(CPUXtensaState *env,
>          unsigned type =3D mpu_attr_to_type(attr);
>          char cpu_cache =3D (type & XTENSA_MPU_TYPE_CPU_CACHE) ? '-' : ' =
';
>
> -        qemu_printf("\t %c  0x%08x  0x%08x   %c%c%c    %c%c%c   ",
> +        monitor_printf(mon, "\t %c  0x%08x  0x%08x   %c%c%c    %c%c%c   =
",
>                      env ?
>                      ((env->sregs[MPUENB] & (1u << i)) ? '+' : '-') : ' '=
,
>                      entry[i].vaddr, attr,
> @@ -1170,19 +1170,19 @@ static void dump_mpu(CPUXtensaState *env,
>
>          switch (type & XTENSA_MPU_SYSTEM_TYPE_MASK) {
>          case XTENSA_MPU_SYSTEM_TYPE_DEVICE:
> -            qemu_printf("Device %cB %3s\n",
> +            monitor_printf(mon, "Device %cB %3s\n",
>                          (type & XTENSA_MPU_TYPE_B) ? ' ' : 'n',
>                          (type & XTENSA_MPU_TYPE_INT) ? "int" : "");
>              break;
>          case XTENSA_MPU_SYSTEM_TYPE_NC:
> -            qemu_printf("Sys NC %cB      %c%c%c\n",
> +            monitor_printf(mon, "Sys NC %cB      %c%c%c\n",
>                          (type & XTENSA_MPU_TYPE_B) ? ' ' : 'n',
>                          (type & XTENSA_MPU_TYPE_CPU_R) ? 'r' : cpu_cache=
,
>                          (type & XTENSA_MPU_TYPE_CPU_W) ? 'w' : cpu_cache=
,
>                          (type & XTENSA_MPU_TYPE_CPU_C) ? 'c' : cpu_cache=
);
>              break;
>          case XTENSA_MPU_SYSTEM_TYPE_C:
> -            qemu_printf("Sys  C %c%c%c     %c%c%c\n",
> +            monitor_printf(mon, "Sys  C %c%c%c     %c%c%c\n",
>                          (type & XTENSA_MPU_TYPE_SYS_R) ? 'R' : '-',
>                          (type & XTENSA_MPU_TYPE_SYS_W) ? 'W' : '-',
>                          (type & XTENSA_MPU_TYPE_SYS_C) ? 'C' : '-',
> @@ -1191,29 +1191,29 @@ static void dump_mpu(CPUXtensaState *env,
>                          (type & XTENSA_MPU_TYPE_CPU_C) ? 'c' : cpu_cache=
);
>              break;
>          default:
> -            qemu_printf("Unknown\n");
> +            monitor_puts(mon, "Unknown\n");
>              break;
>          }
>      }
>  }
>
> -void dump_mmu(CPUXtensaState *env)
> +void dump_mmu(Monitor *mon, CPUXtensaState *env)
>  {
>      if (xtensa_option_bits_enabled(env->config,
>                  XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_PROTECTION) |
>                  XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_TRANSLATION) |
>                  XTENSA_OPTION_BIT(XTENSA_OPTION_MMU))) {
>
> -        qemu_printf("ITLB:\n");
> -        dump_tlb(env, false);
> -        qemu_printf("\nDTLB:\n");
> -        dump_tlb(env, true);
> +        monitor_puts(mon, "ITLB:\n");
> +        dump_tlb(mon, env, false);
> +        monitor_puts(mon, "\nDTLB:\n");
> +        dump_tlb(mon, env, true);
>      } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_MPU)) {
> -        qemu_printf("Foreground map:\n");
> -        dump_mpu(env, env->mpu_fg, env->config->n_mpu_fg_segments);
> -        qemu_printf("\nBackground map:\n");
> -        dump_mpu(NULL, env->config->mpu_bg, env->config->n_mpu_bg_segmen=
ts);
> +        monitor_puts(mon, "Foreground map:\n");
> +        dump_mpu(mon, env, env->mpu_fg, env->config->n_mpu_fg_segments);
> +        monitor_puts(mon, "\nBackground map:\n");
> +        dump_mpu(mon, NULL, env->config->mpu_bg, env->config->n_mpu_bg_s=
egments);
>      } else {
> -        qemu_printf("No TLB for this CPU core\n");
> +        monitor_puts(mon, "No TLB for this CPU core\n");
>      }
>  }
> diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
> index 2af84934f83..2761735f112 100644
> --- a/target/xtensa/monitor.c
> +++ b/target/xtensa/monitor.c
> @@ -34,5 +34,5 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "No CPU available\n");
>          return;
>      }
> -    dump_mmu(env1);
> +    dump_mmu(mon, env1);
>  }
> --
> 2.53.0
>


--=20
Thanks.
-- Max

