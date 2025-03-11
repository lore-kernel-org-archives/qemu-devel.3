Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96835C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 23:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts8vb-0004ws-VT; Tue, 11 Mar 2025 19:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ts8vW-0004wb-2c
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 19:22:22 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ts8vJ-0005Y9-Pg
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 19:22:20 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-47653f15260so43579241cf.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 16:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741735326; x=1742340126; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=osJXK/s21AkUStwir5SrDuucOQGwJFK8WQnUK5eewSU=;
 b=h0GRBGAFXKVTWS6OXhW4lyOXt4xM3GkID2lZmiPOHGOJUX80WixdlVsxulBokaUQw9
 VRzpBZtkpb4l6gy0LeWt/bCNdpE4Nk60MzZnuX1iBpOISqZ5LpAXWY86FYWaPbMx6oIT
 ALq0qddsHSXl9LsWtpxnm6/lg6u2U2PFfmXnSNaYDL+2uAaf0iTopM0u81QA7hFLCPOl
 TL5+SEOMRBTuHQQ5Szgw4KRUu6idCKj5VCJbZTtTcrAz8P4OQefW64JbrWHte4Ek5Smv
 0Pmz5czy3aSB0Tzi1k3X27AW6ennjmyo5shEvNdNpi26A1t7MUDKvFrGK8yLjnlkotib
 li/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741735326; x=1742340126;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=osJXK/s21AkUStwir5SrDuucOQGwJFK8WQnUK5eewSU=;
 b=NyfU+Oq9x/9RRVQJEsnG29JsJoTtxINtAtkONfRj0QkRh3E6mH6pacWOrMW1Z2hptc
 2Emej8vh26CaqBCSC2JmDbRAVgfbxkj84opCmU5NUNblMquNCnXtVVfwbS+lYfPxiiDw
 dnKOSo0HDNdqWDmtCHW3Cz+Ekgq4ADl6tmWFI0o3e3Rq06tj21iJry0obsAJqtDrAywx
 KOm8XNQ3TEkTbQY3Zwpjxd8mZoQdsKfLRwGtEUIgfFHNsqTc0m9yxpUndePlL123sGKU
 TLi/dIVl/waLUZVORqW0cGcKIh+0AGHLKqhxmPbwoWX+t86cb0T2nwp46IIWowj+rKzm
 XU8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9HGHRzrxi0+49/UrkI14/0G23hhoYafCzS09bPZj4yNdrh4OdqSsTlg0LtVUqUghUrV87KgFa/WYC@nongnu.org
X-Gm-Message-State: AOJu0YzPYQE7uECqWgiIR2sd2xf7tTEW7n98dY6UNQJR0GGEpaufrQIT
 8un0goDX61fcaUe2bf8X0b4YM9fr59B1cmiwOjM0nwvXsrTOVNnr
X-Gm-Gg: ASbGncube47Fb/OwnrOuSxfBB66bRrAf5vH2MFU+p4vR/Njmt0nSIHQjBGs+mm4WwWg
 Dt06VN4rdGUkUF61IiPNt8TDGOWInumyHahNSIwHTLxuCs6ZS4OD9AiKWN7+iotstn9atEwSZmj
 Oei2Zqrdny+8GIiF6KRkWPERRc4YQFjBQazRkUOdxMnXVyLT+s2O9o0zHkXc9eljqisWY7VJ52r
 bn2P0UTwZqdvmK224IFDrj63BeJLwEqZ/5assswM3MEOmbH8UKXU6ReDD3qcmWiciDkPJLASCYW
 8orsVVL+IHRciEi4R30BOBboi0a0UxYo0y5ahlA508R2HI3cv7tzKQdlZvF4WCI=
X-Google-Smtp-Source: AGHT+IHFJNMsO4TXPxGAGA5xGLY2pWPz2+0g54CXAQKvZB/GYYSh15mnUvuPoy1Vbvxx4zms6ZuhZQ==
X-Received: by 2002:ac8:7d91:0:b0:472:1406:69f1 with SMTP id
 d75a77b69052e-476994cc7c0mr74914731cf.18.1741735325611; 
 Tue, 11 Mar 2025 16:22:05 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:a832:3b35:d71f:4119])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476905e344esm29602291cf.46.2025.03.11.16.22.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Mar 2025 16:22:05 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-28-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-28-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 27/38] target/hexagon: Add sreg_{read,write} helpers
Date: Tue, 11 Mar 2025 18:22:03 -0500
Message-ID: <00a201db92dc$66add3d0$34097b70$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgFOAlLKtPh7MPA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250311-4, 3/11/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Subject: [PATCH 27/38] target/hexagon: Add sreg_{read,write} helpers
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.h |   8 +++
>  target/hexagon/cpu.c        |   1 +
>  target/hexagon/cpu_helper.c |  37 ++++++++++++
> target/hexagon/op_helper.c  | 114
> ++++++++++++++++++++++++++++++++++--
>  4 files changed, 156 insertions(+), 4 deletions(-)
>=20


diff --git a/target/hexagon/cpu.c
> b/target/hexagon/cpu.c index 0db91a936a..36a93cc22f 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -322,6 +322,7 @@ static void hexagon_cpu_realize(DeviceState *dev,
> Error **errp)
>      qemu_init_vcpu(cs);
>      cpu_reset(cs);
>  #ifndef CONFIG_USER_ONLY
> +    CPUHexagonState *env =3D cpu_env(cs);

Is there a use for this?  If it's in a later patch, move this =
declaration there.

>      if (cs->cpu_index =3D=3D 0) {
>          env->g_sreg =3D g_new0(target_ulong, NUM_SREGS);
>      } else {


> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 139a0b5ab2..76b2475d88 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -17,6 +17,7 @@
>=20
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> +#include "qemu/main-loop.h"
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
>  #include "exec/helper-proto.h"
> @@ -1397,25 +1398,130 @@ void HELPER(setimask)(CPUHexagonState *env,
> uint32_t pred, uint32_t imask)
>      g_assert_not_reached();
>  }
>=20
> +static bool handle_pmu_sreg_write(CPUHexagonState *env, uint32_t reg,
> +                                  uint32_t val) {
> +    if (reg =3D=3D HEX_SREG_PMUSTID0 || reg =3D=3D HEX_SREG_PMUSTID1
> +        || reg =3D=3D HEX_SREG_PMUCFG || reg =3D=3D =
HEX_SREG_PMUEVTCFG
> +        || reg =3D=3D HEX_SREG_PMUEVTCFG1
> +        || (reg >=3D HEX_SREG_PMUCNT4 && reg <=3D HEX_SREG_PMUCNT3)) =
{
> +        qemu_log_mask(LOG_UNIMP, "PMU registers not yet =
implemented");
> +        return true;
> +    }
> +    return false;
> +}
> +

Poor name for this function.  It's not *handling* the write, it's =
checking for a set of registers.  Until PMU registers are implemented, =
it's hard to comment on the correctness of the check.

> +static inline QEMU_ALWAYS_INLINE void sreg_write(CPUHexagonState
> *env,
> +                                                 uint32_t reg, =
uint32_t
> +val)
> +
> +{
> +    g_assert(bql_locked());
> +    if ((reg =3D=3D HEX_SREG_VID) || (reg =3D=3D HEX_SREG_VID1)) {
> +        hexagon_set_vid(env, (reg =3D=3D HEX_SREG_VID) ? L2VIC_VID_0 =
:
> L2VIC_VID_1,
> +                        val);
> +        arch_set_system_reg(env, reg, val);
> +    } else if (reg =3D=3D HEX_SREG_SYSCFG) {
> +        modify_syscfg(env, val);
> +    } else if (reg =3D=3D HEX_SREG_IMASK) {
> +        val =3D GET_FIELD(IMASK_MASK, val);
> +        arch_set_system_reg(env, reg, val);
> +    } else if (reg =3D=3D HEX_SREG_PCYCLELO) {
> +        hexagon_set_sys_pcycle_count_low(env, val);
> +    } else if (reg =3D=3D HEX_SREG_PCYCLEHI) {
> +        hexagon_set_sys_pcycle_count_high(env, val);
> +    } else if (!handle_pmu_sreg_write(env, reg, val)) {

This should be
    } else if (handle_pmu_sreg_write(...)) {
        qemu_log_mask(LOG_UNIMP, ...);
    } else {
That leaves a better spot for you to come back in the future and add the =
implementation.

> +        if (reg >=3D HEX_SREG_GLB_START) {
> +            arch_set_system_reg(env, reg, val);
> +        } else {
> +            arch_set_system_reg(env, reg, val);
> +        }

Why the check when the two conditions do the same thing?

> +    }
> +}
> +
>  void HELPER(sreg_write)(CPUHexagonState *env, uint32_t reg, uint32_t =
val)
> {
> -    g_assert_not_reached();
> +    BQL_LOCK_GUARD();
> +    sreg_write(env, reg, val);
>  }
>=20
>  void HELPER(sreg_write_pair)(CPUHexagonState *env, uint32_t reg,
> uint64_t val)
> +{
> +    BQL_LOCK_GUARD();
> +    sreg_write(env, reg, val & 0xFFFFFFFF);
> +    sreg_write(env, reg + 1, val >> 32); }
>=20
> +static inline QEMU_ALWAYS_INLINE uint32_t sreg_read(CPUHexagonState
> *env,
> +                                                    uint32_t reg)
>  {
> -    g_assert_not_reached();
> +    g_assert(bql_locked());
> +    if (reg =3D=3D HEX_SREG_PMUSTID0 || reg =3D=3D HEX_SREG_PMUSTID1
> +        || reg =3D=3D HEX_SREG_PMUCFG || reg =3D=3D =
HEX_SREG_PMUEVTCFG
> +        || reg =3D=3D HEX_SREG_PMUEVTCFG1
> +        || (reg >=3D HEX_SREG_PMUCNT4 && reg <=3D HEX_SREG_PMUCNT3)) =
{
> +        qemu_log_mask(LOG_UNIMP, "PMU registers not yet =
implemented");
> +        return 0;
> +    }
> +    if ((reg =3D=3D HEX_SREG_VID) || (reg =3D=3D HEX_SREG_VID1)) {
> +        const uint32_t vid =3D hexagon_find_last_irq(env, reg);
> +        arch_set_system_reg(env, reg, vid);
> +    } else if ((reg =3D=3D HEX_SREG_TIMERLO) || (reg =3D=3D =
HEX_SREG_TIMERHI)) {
> +        uint32_t low =3D 0;
> +        uint32_t high =3D 0;
> +        hexagon_read_timer(env, &low, &high);
> +        arch_set_system_reg(env, HEX_SREG_TIMERLO, low);
> +        arch_set_system_reg(env, HEX_SREG_TIMERHI, high);
> +    } else if (reg =3D=3D HEX_SREG_BADVA) {
> +        target_ulong ssr =3D arch_get_system_reg(env, HEX_SREG_SSR);
> +        if (GET_SSR_FIELD(SSR_BVS, ssr)) {
> +            return arch_get_system_reg(env, HEX_SREG_BADVA1);
> +        }
> +        return arch_get_system_reg(env, HEX_SREG_BADVA0);
> +    }
> +    return arch_get_system_reg(env, reg);
>  }
>=20
>  uint32_t HELPER(sreg_read)(CPUHexagonState *env, uint32_t reg)  {
> -    g_assert_not_reached();
> +    BQL_LOCK_GUARD();
> +    return sreg_read(env, reg);
>  }
>=20
>  uint64_t HELPER(sreg_read_pair)(CPUHexagonState *env, uint32_t reg)  =
{
> -    g_assert_not_reached();
> +    BQL_LOCK_GUARD();
> +    if (reg =3D=3D HEX_SREG_TIMERLO) {
> +        uint32_t low =3D 0;
> +        uint32_t high =3D 0;
> +        hexagon_read_timer(env, &low, &high);
> +        arch_set_system_reg(env, HEX_SREG_TIMERLO, low);
> +        arch_set_system_reg(env, HEX_SREG_TIMERHI, high);

Why handle this here instead of relying on sreg_read?

> +    } else if (reg =3D=3D HEX_SREG_PCYCLELO) {
> +        return hexagon_get_sys_pcycle_count(env);

Why isn't this handled in sreg_read?

> +    }
> +    return   (uint64_t)sreg_read(env, reg) |
> +           (((uint64_t)sreg_read(env, reg + 1)) << 32);
>  }
>=20
>  uint32_t HELPER(greg_read)(CPUHexagonState *env, uint32_t reg)
> --
> 2.34.1



