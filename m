Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF98C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0Kq-0001JC-95; Tue, 12 Mar 2024 07:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0Km-0001Ib-VJ; Tue, 12 Mar 2024 07:30:18 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0Kk-0001VD-Sx; Tue, 12 Mar 2024 07:30:16 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dbd32cff0bso40656295ad.0; 
 Tue, 12 Mar 2024 04:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710243013; x=1710847813; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+oOTZ3+k767paO2ZWmMwt1IfpMrA/GhtNkSkYph7lbg=;
 b=EE88r+dv0wW+OaO6Z9Gc4b8d3v2lHi2ys6SRBspCZGr3LkR79AFcnNsvHCxTW38X3W
 sn+StcB/+fIWjVaFA7r7HPk7QdiQxfAuJlELN9waYiP/KBCMKe0zTfWFIzt3YTuvORjZ
 EC18uqnfSAP1wPvOgXs0MdxHBPYyAqysuu+Ff74z+O376Pzp2gtc+9zoK2UScoZLZgRb
 Uyl7fcI+cO9XweNWcr0/xeDFIers5XoEl/PmwUKAf8TzZDWf6eXL/TGL5xKyj52kN6BO
 beyxmLywMhrM96SQeGpfdF6VhpLEHlQ3Wgiaoa2VQwlwWJwRa1FsyZTBXvbVvM4Ob9zs
 1sGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710243013; x=1710847813;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+oOTZ3+k767paO2ZWmMwt1IfpMrA/GhtNkSkYph7lbg=;
 b=KjeVRySCfQw6PnyxR3HkWtuDRlLjK4bxYlRSczYRhct60N/WiJHZ0Y1FktHMmDWzUk
 XLzgKw6ARbL5cUyEHH7+LxgifA21MtS87QAShRIG4/psW7+VrjXWQZV6KLov3SvGlwv3
 2ehyPxJemaQTk4bibKtkRbuKLYmstwqxxzryAhyFDzYWoOy9Gc84ge+cJQTXbOoNJxJ0
 FgNn4TC+7BCnV48CA/Zd1dlam3kHOQM0vVpp9NrT5aEIC62BNplVivysHTM8kagIA4GZ
 raA4TdAoaHKvLy529Zhx7rUsSo80N4HNiEkqBXCBqrZNtc+wfRbJNnlPVQfZgfr3BZIJ
 BPBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJoHM0+rtXm2mRuNw33WUsOfqSW2rtXpHcFCXW8l+F82gsJfqqgLZp3sxuOPbcFBjdAlKknYn42fB6s0aLJ9VfBjxtwv+jhunCr4C9ij1oAk+FlL7fJmHV8sc=
X-Gm-Message-State: AOJu0YyTfrkzjQeBr2kBJsOpkwzDmsIM4x9jpQx3tR7NawcUFIKstF4U
 AqmK9EFStKsUhWhp9Lb/HgOA5h5HG1NIlbTg1tUDZhaRd3wcV+QI
X-Google-Smtp-Source: AGHT+IEO38WHKdbau550x5RIB7/M49ZVJQ6plSpF3HnBVdGdYH747R4g2oAme150SusKacQVUHmR1Q==
X-Received: by 2002:a17:902:ce8d:b0:1dd:916d:771f with SMTP id
 f13-20020a170902ce8d00b001dd916d771fmr7949285plg.39.1710243012802; 
 Tue, 12 Mar 2024 04:30:12 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 c8-20020a170902d48800b001dd8cf4170bsm4929537plg.230.2024.03.12.04.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 04:30:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 21:30:06 +1000
Message-Id: <CZRQJQZNBJHX.BWVREWGW4VI2@wheely>
Cc: <clg@kaod.org>, <mikey@neuling.org>, <amachhiw@linux.vnet.ibm.com>,
 <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 04/14] spapr: nested: keep nested-hv related code
 restricted to its API.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
 <20240308111940.1617660-5-harshpb@linux.ibm.com>
In-Reply-To: <20240308111940.1617660-5-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri Mar 8, 2024 at 9:19 PM AEST, Harsh Prateek Bora wrote:
> spapr_exit_nested and spapr_get_pate_nested_hv contains code which
> is specific to nested-hv API. Isolating code flows based on API
> helps extending it to be used with different API as well.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  include/hw/ppc/spapr_nested.h |  3 +++
>  hw/ppc/spapr.c                |  6 +++++-
>  hw/ppc/spapr_nested.c         | 25 ++++++++++++++++++++++---
>  3 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index 2488ea98da..bf3a7b8d89 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -5,6 +5,8 @@
> =20
>  typedef struct SpaprMachineStateNested {
>      uint64_t ptcr;
> +    uint8_t api;
> +#define NESTED_API_KVM_HV  1
>  } SpaprMachineStateNested;
> =20
>  /*
> @@ -103,4 +105,5 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp);
>  typedef struct SpaprMachineState SpaprMachineState;
>  bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
>                                target_ulong lpid, ppc_v3_pate_t *entry);
> +uint8_t spapr_nested_api(SpaprMachineState *spapr);
>  #endif /* HW_SPAPR_NESTED_H */
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 65d766b898..a08ffe55b6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1376,7 +1376,11 @@ static bool spapr_get_pate(PPCVirtualHypervisor *v=
hyp, PowerPCCPU *cpu,
>          entry->dw1 =3D spapr->patb_entry;
>          return true;
>      } else {
> -        return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
> +        assert(spapr_nested_api(spapr));
> +        if (spapr_nested_api(spapr) =3D=3D NESTED_API_KVM_HV) {
> +            return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
> +        }
> +        return false;
>      }
>  }
> =20
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index c2a33fc3a9..12fdbe2aba 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -11,11 +11,19 @@
>  void spapr_nested_reset(SpaprMachineState *spapr)
>  {
>      if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV)) {
> +        spapr->nested.api =3D NESTED_API_KVM_HV;
>          spapr_unregister_nested_hv();
>          spapr_register_nested_hv();
> +    } else {
> +        spapr->nested.api =3D 0;
>      }
>  }
> =20
> +uint8_t spapr_nested_api(SpaprMachineState *spapr)
> +{
> +    return spapr->nested.api;
> +}
> +
>  #ifdef CONFIG_TCG
> =20
>  bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
> @@ -310,7 +318,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
>      return env->gpr[3];
>  }
> =20
> -void spapr_exit_nested(PowerPCCPU *cpu, int excp)
> +static void spapr_exit_nested_hv(PowerPCCPU *cpu, int excp)
>  {
>      CPUPPCState *env =3D &cpu->env;
>      SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> @@ -322,8 +330,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>      struct kvmppc_pt_regs *regs;
>      hwaddr len;
> =20
> -    assert(spapr_cpu->in_nested);
> -
>      nested_save_state(&l2_state, cpu);
>      hsrr0 =3D env->spr[SPR_HSRR0];
>      hsrr1 =3D env->spr[SPR_HSRR1];
> @@ -413,6 +419,19 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>      address_space_unmap(CPU(cpu)->as, regs, len, len, true);
>  }
> =20
> +void spapr_exit_nested(PowerPCCPU *cpu, int excp)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +
> +    assert(spapr_cpu->in_nested);
> +    if (spapr_nested_api(spapr) =3D=3D NESTED_API_KVM_HV) {
> +        spapr_exit_nested_hv(cpu, excp);
> +    } else {
> +        g_assert_not_reached();
> +    }
> +}
> +
>  void spapr_register_nested_hv(void)
>  {
>      spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);


