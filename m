Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF71CCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjTc-0006JU-UV; Mon, 19 Oct 2026 05:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIjTa-0006J3-09
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:16:14 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIjTX-0002It-L1
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:16:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so7418205e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 02:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792401369; x=1793006169; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/qQefFFGLYZu6otAuLTo/hYtsr8+bw6w89hpD6t4Hmc=;
 b=I1t2Wzv+JscQ4VmYmxRZxvyc+9VvhnytlUCcrhtcYzI48WxQl7hJSumgXJdWc2EzN8
 kWTmI2tvt4PcuuziUxx8Dw/ZrgIp9Ev6Pk0uy2fHtLhOA87a9yunVoY4kq4y/NBfRoqd
 gNy6GnyXddlh6TGmIc0k2Dss/Yc45sTQdjhOqIGzdaF3DoIxryskOUdu00Hm3A462Bn4
 6gZ5PvuRzIXeoOEfEN1l232x7wfSupKkQPYlvi5m5efYl7mwlaTCBKCIkM/4czq4ZB+a
 UN1o4UIUGfRSFK7dKTl4UpW8PRX7Mlkmd35HuFLCdKSk+oFRo27sy8+luWfIaLqzoxFm
 Vbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401369; x=1793006169;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/qQefFFGLYZu6otAuLTo/hYtsr8+bw6w89hpD6t4Hmc=;
 b=vtCvcoNIDmuncxLFQNvkxpaW9pE+bUmJqovHMjzcKzIn+pf+VpBZVBy4cU+XJFHIds
 3lH86GF/LNxiqei0BbXzZayPXSSuWSzxH+v1Wxu+cxPrYtlhKIL6/lGYsY5QIoUQn1uv
 vlwx4kyaxATP11klF+gJJc+e++7DVgrcC/E/uKur5xhzCuYHLk1aX4Qh43956fxmX6Td
 UEmP/28FfRvHi4WRblWUxBoo5bEjURWoQs66SZlympHy1tz50PU2eruvnBQfGI/cEZjf
 f5N5dBQxilH+D6lbJOT7qCROdiJjodndQoU6LdpOBwIg/F5HWZohVm/Xe/BYcY96Jjfj
 Dy6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1nbw9FehxhniC3dE/3Q+IZ7Yhd21/dYjI2NUL6SzK+NXSm5UXTXVz86AbkDrIdAHOZ2dQzDu1j4tc@nongnu.org
X-Gm-Message-State: AFq9FYJoT+5OuVgLm5eh3vKhOpCRHYyeoU8rdfJHlQN12QSbGQ1+T8b1
 iJOnN4WIRSTS8MQC/HMSmahwBzw4r9QnqJiQ2iGpn1hKBNX4Rqcwh5Wecu70eftW/To=
X-Gm-Gg: AYBFou28nuCKKaHskLPoraRpMiy+g7nzgD3kxxsDpCzJcryrG3hqkFJ4Yy8MsVNbpV2
 islHnfS+1JEmEOGf5SvdmZo5ErBoqlGifLu4OZdnqji6jN06YmnMgWpj6B2wX6vj64UlWeFFT7m
 +Sx18aGLNEGlK1zpMfrdjS2e2djNuADjRk59aWh/f9to/5shK4wshJa0T2nbWVoul9Y2RFAZyJT
 aLr1L/XP9jZa2kP4IlaQcWt4c4wk2MSKk4i778ECR0D8YYoS66kytTqtscXCjkCNFDDGYOPahd2
 J6jNRh3gkKk3Fb2U7Fwzw1X7QecPZThMV55+j5i5zF1aN3+qhSG5SkNcNMJSeuP2MCCMZ/ErArm
 TCoCHvt8VaT9FYmYTZSg6IgcWD1puN3AfwGcTfL/kjKeUpJYjdmuspbpRJC+pleTi1SKoIMh4MQ
 JP8MLTqJwW5MvbGMYdaFMXgl/GmZmcgiiDd/+V2bKLZYwdl36ROG4u3u3GS0pm3xtv0cBPyg==
X-Received: by 2002:a05:600c:1d04:b0:4a1:7f96:9b42 with SMTP id
 5b1f17b1804b1-4a1d76121a2mr166900265e9.15.1792401369082; 
 Mon, 19 Oct 2026 02:16:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cc642573sm214098465e9.2.2026.10.19.02.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:16:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2BE9A5F87D;
 Mon, 19 Oct 2026 10:16:07 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com,  armbru@redhat.com,  eblake@redhat.com,
 imammedo@redhat.com,  michael.roth@amd.com,  mst@redhat.com,
 pbonzini@redhat.com,  peter.maydell@linaro.org,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  ruanjinjie@huawei.com
Subject: Re: [PATCH 01/37] target/arm: Add support for MPAM CPU registers
In-Reply-To: <tencent_0D8D61C20611EC56598A6F86E7B869052E05@qq.com> (Jinjie
 Ruan's message of "Fri, 16 Oct 2026 17:46:55 +0800")
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_0D8D61C20611EC56598A6F86E7B869052E05@qq.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Mon, 19 Oct 2026 10:16:07 +0100
Message-ID: <87fqy23vag.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Jinjie Ruan <2118537295@qq.com> writes:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Add the MPAM system registers for TCG: MPAMIDR_EL1 (RO) reporting 64
> PARTIDs and 4 PMGs, and MPAM0_EL1/MPAM1_EL1 (RW, of which only
> MPAM1_EL1.MPAMEN is architecturally reset). Advertise FEAT_MPAM via
> ID_AA64PFR0.MPAM for TCG CPUs.
>
> It is common to support MPAM on CPU cores, but not in the rest of the
> system, so there is little disadvantage in always enabling these.
>
> Based on an RFC series by Jonathan Cameron, adapted to the current
> idregs[] storage and access_tid3() naming.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Something is wrong with this thread, when I was reading the cover letter
I couldn't find the rest of the thread. How did you post this series? It
looks like the cover letter, first 16 and remaining patches where sent
in separate batches?

> ---
>  target/arm/cpu-features.h | 11 +++++++++++
>  target/arm/cpu.c          | 10 +++++++++-
>  target/arm/cpu.h          |  3 +++
>  target/arm/helper.c       | 17 +++++++++++++++++
>  4 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index a9eebb4..4b7d47b 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -459,6 +459,17 @@ FIELD(DBGDEVID, DOUBLELOCK, 20, 4)
>  FIELD(DBGDEVID, AUXREGS, 24, 4)
>  FIELD(DBGDEVID, CIDMASK, 28, 4)
>=20=20
> +FIELD(MPAMIDR, PARTID_MAX, 0, 16)
> +FIELD(MPAMIDR, HAS_HCR, 17, 1)
> +FIELD(MPAMIDR, VMR_MAX, 18, 3)
> +FIELD(MPAMIDR, PMG_MAX, 32, 8)
> +FIELD(MPAMIDR, HAS_ALTSP, 57, 1)
> +FIELD(MPAMIDR, HAS_TIDR, 58, 1)
> +FIELD(MPAMIDR, SP4, 59, 1)
> +FIELD(MPAMIDR, HAS_FORCE_NS, 60, 1)
> +FIELD(MPAMIDR, HAS_SDEFLT, 61, 1)
> +FIELD(MPAM1_EL1, MPAMEN, 63, 1)
> +
>  FIELD(DBGDEVID1, PCSROFFSET, 0, 4)
>=20=20
>  FIELD(MVFR0, SIMDREG, 0, 4)
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 10ac6c9..e7529d5 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -439,6 +439,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType=
 type)
>          /* Sample rvbar at reset.  */
>          env->cp15.rvbar =3D cpu->rvbar_prop;
>          env->pc =3D env->cp15.rvbar;
> +
> +        env->mpam1_el1 =3D R_MPAM1_EL1_MPAMEN_MASK;
>  #endif
>      } else {
>  #if defined(CONFIG_USER_ONLY)
> @@ -452,6 +454,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType=
 type)
>              env->cp15.rvbar =3D cpu->rvbar_prop;
>              env->regs[15] =3D cpu->rvbar_prop;
>          }
> +
> +        env->mpam1_el1 =3D R_MPAM1_EL1_MPAMEN_MASK;
>      }
>=20=20
>  #if defined(CONFIG_USER_ONLY)
> @@ -2333,7 +2337,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>          FIELD_DP64_IDREG(isar, ID_AA64PFR0, AMU, 0);
>          FIELD_DP32_IDREG(isar, ID_PFR0, AMU, 0);
>          /* FEAT_MPAM (Memory Partitioning and Monitoring Extension) */
> -        FIELD_DP64_IDREG(isar, ID_AA64PFR0, MPAM, 0);
> +        FIELD_DP64_IDREG(isar, ID_AA64PFR0, MPAM, 1);
> +        cpu->isar.mpamidr_el1 =3D
> +            FIELD_DP64(cpu->isar.mpamidr_el1, MPAMIDR, PARTID_MAX, 63);
> +        cpu->isar.mpamidr_el1 =3D
> +            FIELD_DP64(cpu->isar.mpamidr_el1, MPAMIDR, PMG_MAX, 3);
>      }
>=20=20
>      /* MPU can be configured out of a PMSA CPU either by setting has-mpu
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 06ebed4..51a36fa 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -757,6 +757,8 @@ typedef struct CPUArchState {
>      struct CPUBreakpoint *cpu_breakpoint[16];
>      struct CPUWatchpoint *cpu_watchpoint[16];
>=20=20
> +    uint64_t mpam0_el1;
> +    uint64_t mpam1_el1;
>      /* Optional fault info across tlb lookup. */
>      ARMMMUFaultInfo *tlb_fi;
>=20=20
> @@ -1121,6 +1123,7 @@ struct ArchCPU {
>          uint32_t dbgdevid;
>          uint32_t dbgdevid1;
>          uint64_t reset_pmcr_el0;
> +        uint64_t mpamidr_el1;
>          uint64_t idregs[NUM_ID_IDX];
>      } isar;
>      uint64_t midr;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ff0b766..896ac0e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6907,6 +6907,23 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .access =3D PL1_R, .type =3D ARM_CP_CONST,
>                .accessfn =3D access_tid3,
>                .resetvalue =3D cpu->isar.mvfr0 },
> +            { .name =3D "MPAMIDR_EL1", .state =3D ARM_CP_STATE_AA64,
> +              .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0xa, .crm =3D 4, .opc2 =
=3D 4,
> +              .access =3D PL1_R, .type =3D ARM_CP_CONST,
> +              .accessfn =3D access_tid3,
> +              .resetvalue =3D cpu->isar.mpamidr_el1 },
> +            { .name =3D "MPAM0_EL1", .state =3D ARM_CP_STATE_AA64,
> +              .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0xa, .crm =3D 5, .opc2 =
=3D 1,
> +              .access =3D PL1_RW, .type =3D ARM_CP_ALIAS,
> +              .accessfn =3D access_tid3,
> +              .fieldoffset =3D offsetof(CPUARMState, mpam0_el1),
> +            },
> +            { .name =3D "MPAM1_EL1", .state =3D ARM_CP_STATE_AA64,
> +              .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0xa, .crm =3D 5, .opc2 =
=3D 0,
> +              .access =3D PL1_RW, .type =3D ARM_CP_ALIAS,
> +              .accessfn =3D access_tid3,
> +              .fieldoffset =3D offsetof(CPUARMState, mpam1_el1),
> +            },
>              { .name =3D "MVFR1_EL1", .state =3D ARM_CP_STATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 3, .opc2 =
=3D 1,
>                .access =3D PL1_R, .type =3D ARM_CP_CONST,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

