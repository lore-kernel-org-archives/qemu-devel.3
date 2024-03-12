Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A589BC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0Zh-0000cu-Re; Tue, 12 Mar 2024 07:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0ZZ-0000bt-W0; Tue, 12 Mar 2024 07:45:34 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0ZX-000587-D6; Tue, 12 Mar 2024 07:45:33 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dc75972f25so38084945ad.1; 
 Tue, 12 Mar 2024 04:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710243928; x=1710848728; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+RK8+/bwNT7IFbmJCbolKcxtGC+Ki6EBs+kK9aX8+0=;
 b=cYXtwg0SS5hGThbthuhfD6df/x7VKTRBn5RMrzom5Tod+hmNQRX2ERenT9oAM9/mBD
 IwnSuBfZ+BH+oH5JEqfaHQ5s38FBXDJklUSMyHdkhHAbzgPLblVBwVAsL1t8gR3qKJBW
 3P9QIDmxweWf3MmMJN4ATAomXp/tZkRzvzFvEiy/40yI624UzM2HtCfm88oEDiqKGBc6
 6NukcyAj1qoMJgO2GdyJTIGcnogWxr+G6ZF+FrhckZmMjp+qSZOk0zO9Ea/Bcc3WTGms
 OIZwzEv//XHmWluyf58e/3IsotfFNYRoO76lu0u1EcWL+ZnDjauIYtT0IUyDk6T/nQ86
 QYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710243928; x=1710848728;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m+RK8+/bwNT7IFbmJCbolKcxtGC+Ki6EBs+kK9aX8+0=;
 b=RSxfDlzoxwYpDrYZvZc0E01tBlbd3W688gKI32yFnWqXt/L6iCtsJxy6wq0XVJ/LIB
 CyruJtdLul6o/YJfz4Qp0S6vXYBiHlDBwvBD1ahiavm1wNxAdJAk0fMfpYgeUk09s9N4
 UR+MB8MbDi22cFhmpzA9SvWZJKYkMiCYCkch6+7xoJ1N58jtIiW++AuozLj04d8YxCWI
 pWFK5tLJnfyHp81/6i72/Jfvh7VQkgfV/8w7dePf3RonDhOlxNpzSLk5I4YAyQdktMvS
 9iD/PPHmDzg8WllYXV8wJ58Hcq2jQ1Y2+MKxNCbEngf1bKipEkfAU0n4SgmMR1AbL4JD
 qyaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3Ze+Ug5gcU38WGwaC5ZM/9PEr5Yv0hSf1IqVUBN0tIP5VTnTK7YdTv1UEDKNICg9I4uyawlsz/vObZ3lPiyhm7j9Y5v46z8UPEq2YiJZu6T4645s/dVv5/KQ=
X-Gm-Message-State: AOJu0YyFIfEGJQFjzYfVTzoS/gmZunPkUaaymkYIs9J50RYzb8m3fQHE
 Gz2OFdRtedcmLrArT9zzW93IgMcSx+a9wq4qJZQCtJxyYLmKKFJ1
X-Google-Smtp-Source: AGHT+IGBleqitbg5W9I70+jWuXgYIxQTwx68ehaJnXEQRylF9aHbfpus8slGsyip4zNcrNEiAqenWw==
X-Received: by 2002:a17:902:da8d:b0:1db:e453:da81 with SMTP id
 j13-20020a170902da8d00b001dbe453da81mr3696887plx.29.1710243928611; 
 Tue, 12 Mar 2024 04:45:28 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 ix14-20020a170902f80e00b001dca3a65200sm6516762plb.228.2024.03.12.04.45.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 04:45:28 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 21:45:22 +1000
Message-Id: <CZRQVFPAGXNX.3UTCWD0G0DYX5@wheely>
Cc: <clg@kaod.org>, <mikey@neuling.org>, <amachhiw@linux.vnet.ibm.com>,
 <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 14/14] spapr: nested: Introduce cap-nested-papr for
 Nested PAPR API
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
 <20240308111940.1617660-15-harshpb@linux.ibm.com>
In-Reply-To: <20240308111940.1617660-15-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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
> Introduce a SPAPR capability cap-nested-papr which enables nested PAPR
> API for nested guests. This new API is to enable support for KVM on Power=
VM
> and the support in Linux kernel has already merged upstream.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  include/hw/ppc/spapr.h |  6 +++-
>  hw/ppc/spapr.c         |  2 ++
>  hw/ppc/spapr_caps.c    | 62 ++++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_nested.c  |  8 ++++--
>  4 files changed, 74 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 6223873641..4aaf23d28f 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -81,8 +81,10 @@ typedef enum {
>  #define SPAPR_CAP_RPT_INVALIDATE        0x0B
>  /* Support for AIL modes */
>  #define SPAPR_CAP_AIL_MODE_3            0x0C
> +/* Nested PAPR */
> +#define SPAPR_CAP_NESTED_PAPR           0x0D
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_AIL_MODE_3 + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_PAPR + 1)
> =20
>  /*
>   * Capability Values
> @@ -592,6 +594,7 @@ struct SpaprMachineState {
>  #define H_GUEST_CREATE_VCPU      0x474
>  #define H_GUEST_GET_STATE        0x478
>  #define H_GUEST_SET_STATE        0x47C
> +#define H_GUEST_RUN_VCPU         0x480
>  #define H_GUEST_DELETE           0x488
> =20
>  #define MAX_HCALL_OPCODE         H_GUEST_DELETE
> @@ -996,6 +999,7 @@ extern const VMStateDescription vmstate_spapr_cap_sbb=
c;
>  extern const VMStateDescription vmstate_spapr_cap_ibs;
>  extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
>  extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
> +extern const VMStateDescription vmstate_spapr_cap_nested_papr;
>  extern const VMStateDescription vmstate_spapr_cap_large_decr;
>  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
>  extern const VMStateDescription vmstate_spapr_cap_fwnmi;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 54fc01e462..beb23fae8f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2121,6 +2121,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_cap_fwnmi,
>          &vmstate_spapr_fwnmi,
>          &vmstate_spapr_cap_rpt_invalidate,
> +        &vmstate_spapr_cap_nested_papr,
>          NULL
>      }
>  };
> @@ -4687,6 +4688,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_WORKAROUND;
>      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB *=
/
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_NESTED_PAPR] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON=
;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_FWNMI] =3D SPAPR_CAP_ON;
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index e889244e52..d6d5a6b8df 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -487,6 +487,58 @@ static void cap_nested_kvm_hv_apply(SpaprMachineStat=
e *spapr,
>              error_append_hint(errp, "Try appending -machine cap-nested-h=
v=3Doff "
>                                      "or use threads=3D1 with -smp\n");
>          }
> +        if (spapr_nested_api(spapr) &&
> +            spapr_nested_api(spapr) !=3D NESTED_API_KVM_HV) {
> +            error_setg(errp, "Nested-HV APIs are mutually exclusive/inco=
mpatible");
> +            error_append_hint(errp, "Please use either cap-nested-hv or =
"
> +                                    "cap-nested-papr to proceed.\n");
> +            return;
> +        } else {
> +            spapr->nested.api =3D NESTED_API_KVM_HV;
> +        }
> +    }
> +}
> +
> +static void cap_nested_papr_apply(SpaprMachineState *spapr,
> +                                    uint8_t val, Error **errp)
> +{
> +    ERRP_GUARD();
> +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    if (!val) {
> +        /* capability disabled by default */
> +        return;
> +    }
> +
> +    if (tcg_enabled()) {
> +        if (!(env->insns_flags2 & PPC2_ISA300)) {
> +            error_setg(errp, "Nested-PAPR only supported on POWER9 and l=
ater");
> +            error_append_hint(errp,
> +                              "Try appending -machine cap-nested-papr=3D=
off\n");
> +            return;
> +        }
> +        if (spapr_nested_api(spapr) &&
> +            spapr_nested_api(spapr) !=3D NESTED_API_PAPR) {
> +            error_setg(errp, "Nested-HV APIs are mutually exclusive/inco=
mpatible");
> +            error_append_hint(errp, "Please use either cap-nested-hv or =
"
> +                                    "cap-nested-papr to proceed.\n");
> +            return;
> +        } else {
> +            spapr->nested.api =3D NESTED_API_PAPR;
> +        }
> +
> +    } else if (kvm_enabled()) {
> +        /*
> +         * this gets executed in L1 qemu when L2 is launched,
> +         * needs kvm-hv support in L1 kernel.
> +         */
> +        if (!kvmppc_has_cap_nested_kvm_hv()) {
> +            error_setg(errp,
> +                       "KVM implementation does not support Nested-HV");
> +        } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
> +            error_setg(errp, "Error enabling Nested-HV with KVM");
> +        }

Hmm, if KVM is enabled then we don't support PAPR nested at all, do we?
Because the KVM cap is only for v1 nested.

Thanks,
Nick

>      }
>  }
> =20
> @@ -735,6 +787,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .type =3D "bool",
>          .apply =3D cap_nested_kvm_hv_apply,
>      },
> +    [SPAPR_CAP_NESTED_PAPR] =3D {
> +        .name =3D "nested-papr",
> +        .description =3D "Allow Nested HV (PAPR API)",
> +        .index =3D SPAPR_CAP_NESTED_PAPR,
> +        .get =3D spapr_cap_get_bool,
> +        .set =3D spapr_cap_set_bool,
> +        .type =3D "bool",
> +        .apply =3D cap_nested_papr_apply,
> +    },
>      [SPAPR_CAP_LARGE_DECREMENTER] =3D {
>          .name =3D "large-decr",
>          .description =3D "Allow Large Decrementer",
> @@ -919,6 +980,7 @@ SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
>  SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
>  SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
> +SPAPR_CAP_MIG_STATE(nested_papr, SPAPR_CAP_NESTED_PAPR);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>  SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 597dba7fdc..8db9dc19e3 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -13,13 +13,15 @@
>  void spapr_nested_reset(SpaprMachineState *spapr)
>  {
>      if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV)) {
> -        spapr->nested.api =3D NESTED_API_KVM_HV;
>          spapr_unregister_nested_hv();
>          spapr_register_nested_hv();
> -    } else {
> -        spapr->nested.api =3D 0;
> +    } else if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_PAPR)) {
>          spapr->nested.capabilities_set =3D false;
> +        spapr_unregister_nested_papr();
> +        spapr_register_nested_papr();
>          spapr_nested_gsb_init();
> +    } else {
> +        spapr->nested.api =3D 0;
>      }
>  }
> =20


