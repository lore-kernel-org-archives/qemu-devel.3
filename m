Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D254C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0Wk-0005uB-Kh; Tue, 12 Mar 2024 07:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0W7-0005Qc-8N; Tue, 12 Mar 2024 07:42:01 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk0Vs-00044J-91; Tue, 12 Mar 2024 07:41:59 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2222c0462a9so94134fac.3; 
 Tue, 12 Mar 2024 04:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710243702; x=1710848502; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZUCdBkiJmEIAP8T6yAMN/ukiFegh1KzR6z+mphLX+sw=;
 b=GaobxEGON3eSG7EyG58BBLJt/j3Daw6spvdGqf8PqMuX4kb3EkmYBgRV7mDpc7UNpM
 YPrOO0s+KQTKYX+dBTZziwv+x2Z52p7GyFEh5kb8thyAm40e66B6wKfGdxjhmMoEphqs
 l3r3sRcGMi/V0s2Cc7JR19cpx4yjjtLM2MUk7sPJvUOvxxA9Bg0FHlXy1FUvvCMHJWOW
 qpo+J5E+sCsLxiLURqMUx6EAisd6in9QX90DuTZi8xEpHlpFSdyfvCpafvsAeLsBhVBv
 fh3TiXagn3a46K6zK2DMBkfwfPRRgvLaNDRwh7X5fzq+GVEm6DaP3zORoSE/vwqbIN02
 mZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710243702; x=1710848502;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZUCdBkiJmEIAP8T6yAMN/ukiFegh1KzR6z+mphLX+sw=;
 b=Q5XfZupxGmeQoRNGsVX1xUUcC/AyZhH8bPLg0ODtK+u8/rG8Sr74n+atTHB4Py5SVw
 00Yhe/bg5ncF73T2sIh88mp1fY0IpaiAvPxrQPbu6voTnYN4jvbdk+36CumejnzP6H0E
 wH7vg150ruzHvmX/aFm/D/TrfM81mGpT/MfHFBaf/Lk3mS3vaP1lw4vugPxRhfguBsyq
 S1doEXd9yA9q8vdWbFuvuYlsiHLC92jgjspYH8K4b7/mxX8s6I/7wRIs7oeIEN1SzX8f
 +WfSlJjlwmpgmiP/sn+C/HYm0EMeHv/AQEjTP5UfaNyJrw7gvzuvXtA/KZMPuFpQZ7iO
 SKfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVaRjl+4k/BbYTC+Vem/FAd55tv26anb0aWUizJIgp7s/fi446UBWuG5kcEVND6Hsdu9Ucpw2ys3g2B06/RHmAgV6vXPE145WFwgMMHX10GXp5ASZMo62c+Qo=
X-Gm-Message-State: AOJu0YyW24GAR5DJTKmGQR+vGGP3zklzvuiksCPf0t1foykVsH8wrbnx
 dpAjK9T7LHjqvevLp18tLU3/8lfLALokvvPQDK9TCb8WZd/n7rXc
X-Google-Smtp-Source: AGHT+IFvtYXcVg5gNBydIapjXq+PUJewWu2XXGcOmLth8md1r+QK0U79pohCdLtr7MCCfMhEZVtiSg==
X-Received: by 2002:a05:6870:d8d3:b0:221:bbb6:5511 with SMTP id
 of19-20020a056870d8d300b00221bbb65511mr10262093oac.14.1710243702609; 
 Tue, 12 Mar 2024 04:41:42 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 ei14-20020a056a0080ce00b006e555d40951sm5890056pfb.188.2024.03.12.04.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 04:41:42 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 21:41:36 +1000
Message-Id: <CZRQSJXJRBEV.3LTQFO71EUU1O@wheely>
Cc: <clg@kaod.org>, <mikey@neuling.org>, <amachhiw@linux.vnet.ibm.com>,
 <vaibhav@linux.ibm.com>, <sbhat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 12/14] spapr: nested: Use correct source for parttbl
 info for nested PAPR API.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
 <20240308111940.1617660-13-harshpb@linux.ibm.com>
In-Reply-To: <20240308111940.1617660-13-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> For nested PAPR API, we use SpaprMachineStateNestedGuest struct to store
> partition table info, use the same in spapr_get_pate_nested() via
> helper.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  include/hw/ppc/spapr_nested.h |  4 ++++
>  hw/ppc/spapr.c                |  6 ++++--
>  hw/ppc/spapr_nested.c         | 22 +++++++++++++++++++++-
>  3 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index bd43c6b6ef..152019fe3d 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -518,4 +518,8 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spap=
r, PowerPCCPU *cpu,
>                                target_ulong lpid, ppc_v3_pate_t *entry);
>  uint8_t spapr_nested_api(SpaprMachineState *spapr);
>  void spapr_nested_gsb_init(void);
> +bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cp=
u,
> +                                target_ulong lpid, ppc_v3_pate_t *entry)=
;
> +SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *=
spapr,
> +                                                     target_ulong lpid);

Why is this made non-static? Doesn't seem to be needed in later patches
either? Other than that,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>  #endif /* HW_SPAPR_NESTED_H */
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a08ffe55b6..54fc01e462 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1376,11 +1376,13 @@ static bool spapr_get_pate(PPCVirtualHypervisor *=
vhyp, PowerPCCPU *cpu,
>          entry->dw1 =3D spapr->patb_entry;
>          return true;
>      } else {
> -        assert(spapr_nested_api(spapr));
>          if (spapr_nested_api(spapr) =3D=3D NESTED_API_KVM_HV) {
>              return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
> +        } else if (spapr_nested_api(spapr) =3D=3D NESTED_API_PAPR) {
> +            return spapr_get_pate_nested_papr(spapr, cpu, lpid, entry);
> +        } else {
> +            g_assert_not_reached();
>          }
> -        return false;
>      }
>  }
> =20
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index ca99805ce8..e0b234c786 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -58,6 +58,21 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr=
, PowerPCCPU *cpu,
>      return true;
>  }
> =20
> +bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cp=
u,
> +                                target_ulong lpid, ppc_v3_pate_t *entry)
> +{
> +    SpaprMachineStateNestedGuest *guest;
> +    assert(lpid !=3D 0);
> +    guest =3D spapr_get_nested_guest(spapr, lpid);
> +    if (!guest) {
> +        return false;
> +    }
> +
> +    entry->dw0 =3D guest->parttbl[0];
> +    entry->dw1 =3D guest->parttbl[1];
> +    return true;
> +}
> +
>  #define PRTS_MASK      0x1f
> =20
>  static target_ulong h_set_ptbl(PowerPCCPU *cpu,
> @@ -540,7 +555,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>      }
>  }
> =20
> -static
>  SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *=
spapr,
>                                                       target_ulong guesti=
d)
>  {
> @@ -1585,6 +1599,12 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *s=
papr, PowerPCCPU *cpu,
>      return false;
>  }
> =20
> +bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cp=
u,
> +                                target_ulong lpid, ppc_v3_pate_t *entry)
> +{
> +    return false;
> +}
> +
>  void spapr_register_nested_papr(void)
>  {
>      /* DO NOTHING */


