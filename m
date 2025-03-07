Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF43C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdUD-00083e-Ua; Fri, 07 Mar 2025 14:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqdUB-00080p-TE
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:35:56 -0500
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqdU9-0007Py-7H
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:35:55 -0500
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7c08b14baa9so209429885a.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741376151; x=1741980951; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ycctTW06qGrEkKea1+bkwaO3VvbZ9JtvQ0uzpXePlqc=;
 b=isu/CyDQOoZVRn4AHqHaGIAJdZqkQnuDyFTtJxvG1/C+tcdjiYtKqwJMCPaSNgBgGQ
 9qLxVlHhvKwlxfThxYHEVq4vKLZ8ekRXfa6AHqgDyk+A2dzAix6hSvb1HZ8Nx6pK11TJ
 6Yza472amI017dTHi/VQcF3Zqu1KSi3pbHYWqLqe1ByCbuXCEMZ7faZ3WEUfyo2JBe5a
 n8s0sAfAlXiDhjSB4UmAHqOnd/7e7gVsGKikzW8CoFLZVhqGYQ7f6y6s9d+t4yP+9Bzo
 2s2FeE3CE93bf66JReGvXn7uSzRmS0jyN0sILhvSQvJsOjpW0UwNgZTjomzyRK2ju9nG
 hB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376151; x=1741980951;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ycctTW06qGrEkKea1+bkwaO3VvbZ9JtvQ0uzpXePlqc=;
 b=h8qBQV6UE75I/CTfaKQe475Y2r74maOb6oFudnMRGUG+PQFlWGI+mWhVmfbqrdgYls
 C+kEGwbLObR2AXuVfRipKnCB3oxymDfjiF0hB4eK2Gi7sw5WJDrvWu/8J28GTiJJbqPE
 rv+qOByMCsPpg9R3hQ80ukFwSypREn0a4zMC8wS6cbkIjC8w4hsx8iWvnh0u+UAVcH8t
 nLckV4k39m0m6b17chgOdd7k4F2gUZWIUowCsUHlQk4MY9V4ZfP+Z5sLtKsNWk22YVzb
 8+SA0BHQKfXZW0SiNcnvNcNnnHmHdUFM58PrneAGYQZc1FU8c1TLWW5qsbpxvRvSgkpW
 Vzjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeQ40fKPcS2AfNDwfW9RRpiMcyoI6UwExaOZQ40DhVc2PjtmQlzaLgmGlTgcbt7DZRF17V3UseQwMm@nongnu.org
X-Gm-Message-State: AOJu0YznBLTdc41QyKcHRY/N/jmbhFx3GNhH1nlfgBFxmmeI8oXay/is
 xWwFfDCUAgcp9OgNatbzL9LDA+vd8uEX3gfm1g5eIat65qbxxsy5
X-Gm-Gg: ASbGnctV3PJcG15N+Pd17knxuBA4KEkv8H37cfJi6g3TWGxB4iaNUM6Ud7GiS8nEpmE
 vCqZVv3K9dk3Ux8FpVzeayLS8UQvv+lAttyMXu1sSNMXDhmTFaUo8yjiEc6nE5GROYpwZntN8HL
 +3wXcdTCj/WBeaK2pi9zuxZ0NKeJRP2q40gXDXloFVqOQLQX/dsbszRXUmKLe8jkDoJ5iPttcy7
 PGeocVBcUZGo8FilMuelz3pXRWR9M3AHZMct02iUN33vMrVBE4yCjNkXHKKAzPVsNDTKpoGMWsS
 VIE2WOv3dgTyyG2fzICiQdiGFvpDGdB8ijt53Op0WlwY+GxRhqWzpxORGiqTIIo=
X-Google-Smtp-Source: AGHT+IGptEyi4ofFGRWLVxVzUU0YX06RSDxuM8Sj0eGd2+xxn9ItrOHRmSMaJChOB7XQWgGTbeg2MA==
X-Received: by 2002:a05:620a:2605:b0:7c0:cc94:46c0 with SMTP id
 af79cd13be357-7c4e167d7ccmr658105185a.20.1741376151469; 
 Fri, 07 Mar 2025 11:35:51 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:f449:4838:1970:9d05])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c3e538ae70sm278996385a.61.2025.03.07.11.35.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:35:50 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-15-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-15-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 14/38] target/hexagon: Add new macro definitions for sysemu
Date: Fri, 7 Mar 2025 13:35:49 -0600
Message-ID: <029401db8f98$22248020$666d8060$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgI+GfugtOp4wFA=
X-Antivirus: Norton (VPS 250307-6, 3/7/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x736.google.com
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 14/38] target/hexagon: Add new macro definitions for
> sysemu
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Also: add nop TCG overrides for break,unpause,fetchbo,dczeroa

dczeroa is modelled by QEMU.  It writes zero's to the cache line.

>=20
> break: this hardware breakpoint instruction is used with the =
in-silicon
> debugger feature, this is not modeled.
>=20
> unpause: this instruction is used to resume hardware threads that are =
stalled
> by pause instructions.  pause is modeled as a nop, or in RR mode as an
> EXCP_YIELD.  This instruction is safe to ignore.
>=20
> Since cache/prefetch functions are not modeled, dczero and fetchbo are
> safe to ignore.

dczero is modelled.

>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg.h    |   9 ++
>  target/hexagon/macros.h     |  28 ++++-
>  target/hexagon/sys_macros.h | 238
> ++++++++++++++++++++++++++++++++++++
>  target/hexagon/op_helper.c  |   1 +
>  4 files changed, 272 insertions(+), 4 deletions(-)  create mode =
100644
> target/hexagon/sys_macros.h
>=20
> diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h index
> 8a3b801287..71f8a0e2d0 100644
> --- a/target/hexagon/gen_tcg.h
> +++ b/target/hexagon/gen_tcg.h
> @@ -488,6 +488,7 @@
>=20
>  /* dczeroa clears the 32 byte cache line at the address given */  =
#define
> fGEN_TCG_Y2_dczeroa(SHORTCODE) SHORTCODE
> +#define fGEN_TCG_Y2_dczeroa_nt(SHORTCODE) SHORTCODE

Is there a Y2_dczeroa_nt instruction?  If not, remove this.

>          ctx->dczero_addr =3D tcg_temp_new(); \
>          tcg_gen_mov_tl(ctx->dczero_addr, (REG)); \
>      } while (0)
> +#else
> +#define fDCZEROA(REG) ((void) REG)

This isn't needed because all the instances of fDCZEROA are inside =
QEMU_GENERATE.


>  #endif
>=20
> diff --git a/target/hexagon/sys_macros.h b/target/hexagon/sys_macros.h
> new file mode 100644 index 0000000000..3c4c3c7aa5
> --- /dev/null
> +++ b/target/hexagon/sys_macros.h
> +#define READ_SREG(NUM) arch_get_system_reg(env, NUM)
> +#define READ_SGP0()    arch_get_system_reg(env, HEX_SREG_SGP0)
> +#define READ_SGP1()    arch_get_system_reg(env, HEX_SREG_SGP1)
> +#define READ_SGP10()   ((uint64_t)arch_get_system_reg(env,
> HEX_SREG_SGP0) | \
> +    ((uint64_t)arch_get_system_reg(env, HEX_SREG_SGP1) << 32))
> +
> +#define WRITE_SREG(NUM, VAL)      log_sreg_write(env, NUM, VAL, slot)
> +#define WRITE_SGP0(VAL)           log_sreg_write(env, HEX_SREG_SGP0,
> VAL, slot)
> +#define WRITE_SGP1(VAL)           log_sreg_write(env, HEX_SREG_SGP1,
> VAL, slot)
> +#define WRITE_SGP10(VAL) \
> +    do { \
> +        log_sreg_write(env, HEX_SREG_SGP0, (VAL) & 0xFFFFFFFF, slot); =
\
> +        log_sreg_write(env, HEX_SREG_SGP1, (VAL) >> 32, slot); \
> +    } while (0)
> +

READ_SREG and WRITE_SREG look like a hangover for the original generator =
scripts which have been rewritten.  Are they needed?


> +#ifdef QEMU_GENERATE
> +#define GET_SSR_FIELD(RES, FIELD) \
> +    GET_FIELD(RES, FIELD, hex_t_sreg[HEX_SREG_SSR]) #else
> +
> +#define GET_SSR_FIELD(FIELD, REGIN) \
> +    (uint32_t)GET_FIELD(FIELD, REGIN)
> +#define GET_SYSCFG_FIELD(FIELD, REGIN) \
> +    (uint32_t)GET_FIELD(FIELD, REGIN)
> +#define SET_SYSTEM_FIELD(ENV, REG, FIELD, VAL) \
> +    do { \
> +        uint32_t regval =3D arch_get_system_reg(ENV, REG); \
> +        fINSERT_BITS(regval, reg_field_info[FIELD].width, \
> +                     reg_field_info[FIELD].offset, (VAL)); \
> +        arch_set_system_reg(ENV, REG, regval); \
> +    } while (0)
> +#define SET_SSR_FIELD(ENV, FIELD, VAL) \
> +    SET_SYSTEM_FIELD(ENV, HEX_SREG_SSR, FIELD, VAL) #define
> +SET_SYSCFG_FIELD(ENV, FIELD, VAL) \
> +    SET_SYSTEM_FIELD(ENV, HEX_SREG_SYSCFG, FIELD, VAL)
> +
> +#define CCR_FIELD_SET(ENV, FIELD) \
> +    (!!GET_FIELD(FIELD, arch_get_system_reg(ENV, HEX_SREG_CCR)))
> +
> +/*
> + * Direct-to-guest is not implemented yet, continuing would cause
> +unexpected
> + * behavior, so we abort.
> + */
> +#define ASSERT_DIRECT_TO_GUEST_UNSET(ENV, EXCP) \
> +    do { \
> +        switch (EXCP) { \
> +        case HEX_EVENT_TRAP0: \
> +            g_assert(!CCR_FIELD_SET(ENV, CCR_GTE)); \
> +            break; \
> +        case HEX_EVENT_IMPRECISE: \
> +        case HEX_EVENT_PRECISE: \
> +        case HEX_EVENT_FPTRAP: \
> +            g_assert(!CCR_FIELD_SET(ENV, CCR_GEE)); \
> +            break; \
> +        default: \
> +            if ((EXCP) >=3D HEX_EVENT_INT0) { \
> +                g_assert(!CCR_FIELD_SET(ENV, CCR_GIE)); \
> +            } \
> +            break; \
> +        } \
> +    } while (0)
> +#endif
> +
> +#define fREAD_ELR() (READ_SREG(HEX_SREG_ELR))
> +
> +#define fLOAD_PHYS(NUM, SIZE, SIGN, SRC1, SRC2, DST) { \
> +  const uintptr_t rs =3D ((unsigned long)(unsigned)(SRC1)) & 0x7ff; \
> +  const uintptr_t rt =3D ((unsigned long)(unsigned)(SRC2)) << 11; \
> +  const uintptr_t addr =3D rs + rt;         \
> +  cpu_physical_memory_read(addr, &DST, sizeof(uint32_t)); \ }
> +
> +#define fPOW2_HELP_ROUNDUP(VAL) \
> +    ((VAL) | \
> +     ((VAL) >> 1) | \
> +     ((VAL) >> 2) | \
> +     ((VAL) >> 4) | \
> +     ((VAL) >> 8) | \
> +     ((VAL) >> 16))
> +#define fPOW2_ROUNDUP(VAL) (fPOW2_HELP_ROUNDUP((VAL) - 1) + 1)
> +
> +#define fFRAMECHECK(ADDR, EA)  g_assert_not_reached();

Add a FIXME or comment on why this is not implemented.  Or is it =
implemented in a subsequent patch in this series?

> +#define fSET_TLB_LOCK()       g_assert_not_reached()
> +#define fCLEAR_TLB_LOCK()     g_assert_not_reached()
> +
> +#define fSET_K0_LOCK()        g_assert_not_reached()
> +#define fCLEAR_K0_LOCK()      g_assert_not_reached()

Add a comment that these are implemented in a later patch in the series.



