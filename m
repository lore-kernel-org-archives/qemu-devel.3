Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA35C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 17:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuEPA-0002pc-8n; Mon, 17 Mar 2025 13:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuEP8-0002pO-D3
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 13:37:34 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuEP6-0003pd-1t
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 13:37:34 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4766631a6a4so47690451cf.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742233050; x=1742837850; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9mOuqXKun01F04BN3HX7j+CBoxZIHG2hV5VcBc0giaQ=;
 b=H4WGa8sBQelK+FRTkp0bFRsXWYzXYj/NeRtBVqad1Rs8mHFcMnZ6nCf6Sz++vDkT0J
 EEduQ2q9sle9f2F9qYQ20S27F9LY1t0gXPGp1Z7GKW8KIxsHhr0ooC2GNQsKO8x1jik3
 R5wjgblxpRnb2KvpVpzlafUk+qUF/VEhmxN3bJQJbzfLsTnGGEkZ35/gkoqzcNSLTeRW
 apAJDlqz29PReof+8MgcUl9aJ0A2k6yIVDIDVjbnAfDxuN7+61e74WoacoU6YH0rir45
 D5DZgQFUfLF45pJNRQc8LsNEPICelddQNGY8FDTenG6oTjR2YDqGCfKd9MtASQNSy2pL
 E1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742233050; x=1742837850;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9mOuqXKun01F04BN3HX7j+CBoxZIHG2hV5VcBc0giaQ=;
 b=CZye4INcQ7QUI4QuHYsogxOeLAkk6LhUYgyymmIzRL030oSrwAzHrUQ3gQBWtZpvn8
 URvT0Tgjcj231dgE7t35ECMkHkiA/MS7+AKzT9e7MCShBGd5MnmEH9GVi/hDER8FCRUN
 qo1Xwl2EANecYhVXWYrbigKyEB9kZYQQtoWpZjYacrZ1XV6b401tSzVfr5x4n4Th/wg8
 dDAfUe+gvh2qa/qUqzK87ky4jN9ZSw6pS4tej2MF+6BTcDsgjvrQD6kQkj/QGVpHeKEg
 ILcyLcNw4lSvTdu2cXBzkdGq0mMg6afQwFdhr3FQpkGES76MINh/rkrR+gaW1KgxX0FD
 GWIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURUHW4GDEPeSqNseNlPXjQEW+AkGrrouNBWkkAPYB2DItTOeR0XjYaaStBP9nQ16ykixbJVIQEec4p@nongnu.org
X-Gm-Message-State: AOJu0YwmKUaqBx+Mo7xgIqSdOF9uv7nhpqU2avC4GcgSngNcQLzSWkJq
 0UVsqnxXCkxZ0e8YJP/dTnR6wmAfmU06wQRWh0MMFQpepHKeYU3l
X-Gm-Gg: ASbGncvsjtljTeBx+Sye9JLLja5KPryfnv6LSzzbEAbIxXpBDHbBuMWQz47tvfAPnDY
 v+YUUZKn3jZdWlCZNf4zK4N1Utuf9U7aFKiIjOZpkXrLykpVMf8J9bxtr8Wm1k57pSxG0pxyymj
 b3klAJeal1ZsmzOT1rLVhkXKz4KG1tKwGiH23E6YWME9fVEeH9U5ibBcOwI/vf8dKCS8yEctF20
 0VPa9lnvA2aRVPEP7QKU/kXZfoPVrh4b5/OCnt6XwOWBQjzS1rW0PtiWe0HXUgZCfVnQGdGYqrD
 uowijAlu8ih3eTyjTQZaYTQMNw69vzLftzaWjPaZI5VWzLpVwiC4vfhIBDAXB1s=
X-Google-Smtp-Source: AGHT+IHhSXXc4eL3wc4AfnsaeJcbxFvIvce63n5moBn+arf/aulm6XoiRU8OZ86ETxvrIXQ0ReHPSg==
X-Received: by 2002:a05:622a:4a8f:b0:473:8698:de12 with SMTP id
 d75a77b69052e-476fc970535mr6646001cf.4.1742233050476; 
 Mon, 17 Mar 2025 10:37:30 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb673824sm57856881cf.45.2025.03.17.10.37.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 10:37:29 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-6-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-6-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 05/39] target/hexagon: Implement modify SSR
Date: Mon, 17 Mar 2025 12:37:28 -0500
Message-ID: <017101db9763$41ae4ca0$c50ae5e0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQH/in6LsvITJWA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x832.google.com
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
> Sent: Friday, February 28, 2025 11:28 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 05/39] target/hexagon: Implement modify SSR
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> The per-vCPU System Status Register controls many modal behaviors of =
the
> system architecture.  When the SSR is updated, we trigger the =
necessary
> effects for interrupts, privilege/MMU, and HVX context mapping.
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.c | 100
> +++++++++++++++++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
> index e151c6335a..3e2364a7b0 100644
> --- a/target/hexagon/cpu_helper.c
> +++ b/target/hexagon/cpu_helper.c
> @@ -14,6 +14,8 @@
>  #else
>  #include "hw/boards.h"
>  #include "hw/hexagon/hexagon.h"
> +#include "hex_interrupts.h"
> +#include "hex_mmu.h"
>  #endif
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
> @@ -69,9 +71,105 @@ void
> hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t cycles)
>      g_assert_not_reached();
>  }
>=20
> +static MMVector VRegs[VECTOR_UNIT_MAX][NUM_VREGS];
> +static MMQReg QRegs[VECTOR_UNIT_MAX][NUM_QREGS];

This won't scale for a system with multiple Hexagon instances.  See =
discussion on how to handle shared resources.

> +
> +/*
> + *                            EXT_CONTEXTS
> + * SSR.XA   2              4              6              8
> + * 000      HVX Context 0  HVX Context 0  HVX Context 0  HVX Context =
0
> + * 001      HVX Context 1  HVX Context 1  HVX Context 1  HVX Context =
1
> + * 010      HVX Context 0  HVX Context 2  HVX Context 2  HVX Context =
2
> + * 011      HVX Context 1  HVX Context 3  HVX Context 3  HVX Context =
3
> + * 100      HVX Context 0  HVX Context 0  HVX Context 4  HVX Context =
4
> + * 101      HVX Context 1  HVX Context 1  HVX Context 5  HVX Context =
5
> + * 110      HVX Context 0  HVX Context 2  HVX Context 2  HVX Context =
6
> + * 111      HVX Context 1  HVX Context 3  HVX Context 3  HVX Context =
7
> + */

This is different from what the HVX PRM says.  It only specifies what XA =
values  4, 5, 6, 7 mean.

Here is what it says:
The HVX scalar core can contain any number of hardware threads greater =
or equal to the number
of vector contexts. The scalar hardware thread is assignable to a vector =
context through per-
thread SSR:XA programming, as follows:
- SSR:XA =3D 4: HVX instructions use vector context 0.
- SSR:XA =3D 5: HVX instructions use vector context 1, if it is =
available.
- SSR:XA =3D 6: HVX instructions use vector context 2, if it is =
available.
- SSR:XA =3D 7: HVX instructions use vector context 3, if it is =
available.

> +static int parse_context_idx(CPUHexagonState *env, uint8_t XA) {
> +    int ret;
> +    HexagonCPU *cpu =3D env_archcpu(env);

You should assert that cpu->hvx_contexts is in { 2, 4, 6, 8 }.  This =
will future proof against changes to the hardware as well as protect =
against bad command-line settings.

> +    if (cpu->hvx_contexts =3D=3D 6 && XA >=3D 6) {
> +        ret =3D XA - 6 + 2;
> +    } else {
> +        ret =3D XA % cpu->hvx_contexts;
> +    }
> +    g_assert(ret >=3D 0 && ret < VECTOR_UNIT_MAX);
> +    return ret;
> +}
> +
> +static void check_overcommitted_hvx(CPUHexagonState *env, uint32_t
> ssr)
> +{
> +    if (!GET_FIELD(SSR_XE, ssr)) {
> +        return;
> +    }

What does SSR_XE indicate?

> +
> +    uint8_t XA =3D GET_SSR_FIELD(SSR_XA, ssr);
> +
> +    CPUState *cs;
> +    CPU_FOREACH(cs) {
> +        CPUHexagonState *env_ =3D cpu_env(cs);

This underscore is confusing.  Use a full name such as thread_env.

> +        if (env_ =3D=3D env) {
> +            continue;
> +        }
> +        /* Check if another thread has the XE bit set and same XA */
> +        uint32_t ssr_ =3D arch_get_system_reg(env_, HEX_SREG_SSR);

Ditto

> +        if (GET_SSR_FIELD(SSR_XE2, ssr_) && GET_FIELD(SSR_XA, ssr_) =
=3D=3D XA) {

The comment says check the XE bit but the code checks XE2.  Also, note =
the XE check on the current thread above.

> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                    "setting SSR.XA '%d' on thread %d but thread"
> +                    " %d has same extension active\n", XA, =
env->threadId,
> +                    env_->threadId);
> +        }
> +    }
> +}
> +
>  void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t
> old)  {
> -    g_assert_not_reached();
> +    g_assert(bql_locked());
> +
> +    bool old_EX =3D GET_SSR_FIELD(SSR_EX, old);
> +    bool old_UM =3D GET_SSR_FIELD(SSR_UM, old);
> +    bool old_GM =3D GET_SSR_FIELD(SSR_GM, old);
> +    bool old_IE =3D GET_SSR_FIELD(SSR_IE, old);
> +    uint8_t old_XA =3D GET_SSR_FIELD(SSR_XA, old);
> +    bool new_EX =3D GET_SSR_FIELD(SSR_EX, new);
> +    bool new_UM =3D GET_SSR_FIELD(SSR_UM, new);
> +    bool new_GM =3D GET_SSR_FIELD(SSR_GM, new);
> +    bool new_IE =3D GET_SSR_FIELD(SSR_IE, new);
> +    uint8_t new_XA =3D GET_SSR_FIELD(SSR_XA, new);
> +
> +    if ((old_EX !=3D new_EX) ||
> +        (old_UM !=3D new_UM) ||
> +        (old_GM !=3D new_GM)) {
> +        hex_mmu_mode_change(env);
> +    }
> +
> +    uint8_t old_asid =3D GET_SSR_FIELD(SSR_ASID, old);
> +    uint8_t new_asid =3D GET_SSR_FIELD(SSR_ASID, new);
> +    if (new_asid !=3D old_asid) {
> +        CPUState *cs =3D env_cpu(env);
> +        tlb_flush(cs);
> +    }
> +
> +    if (old_XA !=3D new_XA) {
> +        int old_unit =3D parse_context_idx(env, old_XA);
> +        int new_unit =3D parse_context_idx(env, new_XA);

Check that old_unit !=3D new_unit.  Per the table above, different XA =
values can point to the same unit.  For example, if cpu->hvx_contexts is =
2, the XA=3D0 and XA=3D2 both point to context 0.

> +
> +        /* Ownership exchange */
> +        memcpy(VRegs[old_unit], env->VRegs, sizeof(env->VRegs));
> +        memcpy(QRegs[old_unit], env->QRegs, sizeof(env->QRegs));
> +        memcpy(env->VRegs, VRegs[new_unit], sizeof(env->VRegs));
> +        memcpy(env->QRegs, QRegs[new_unit], sizeof(env->QRegs));

What does the hardware do?  Does it clear the context, or is that the =
OS'es job?

If the hardware leaves the context alone, the above should be
1) Copy env->{VQ}Regs to old_unit
2) Copy new_unit to env->{VQ}Regs

Should you check SSR_EX before doing these copies?

Do you need to do anything when SSR_EX changes?

> +
> +        check_overcommitted_hvx(env, new);
> +    }
> +
> +    /* See if the interrupts have been enabled or we have exited EX =
mode */
> +    if ((new_IE && !old_IE) ||
> +        (!new_EX && old_EX)) {
> +        hex_interrupt_update(env);
> +    }
>  }
>=20
>  void clear_wait_mode(CPUHexagonState *env)
> --
> 2.34.1



