Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9D6CED272
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 06:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy42w-0007mS-8p; Tue, 08 Oct 2024 02:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy42t-0007lR-LO; Tue, 08 Oct 2024 02:50:12 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy42r-0006Np-Bs; Tue, 08 Oct 2024 02:50:11 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20b95359440so44423285ad.0; 
 Mon, 07 Oct 2024 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728370208; x=1728975008; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ed3+SJvYlg3r/rbcPJ8oS0Yb8vznHmRmnBc4+Q6igfc=;
 b=UTRl1RFkHmsMTXOXGny2q7uKE0YMcRHeRjOUaZXUi5/32o3YWbfu0iW+0GqYcb0W3y
 kEyt5o6mESI6A9WzP1nESypvCSzH5pQJxQa3cf+xoyNguypWvkAoJqZrD8dH7hGKhinm
 Hb2kcPNMu40XeBHJ7qIoscvqnjNc2DK9m01YR5BpNuWHRiyVTSyR3+MQ68y4ivIhiGk5
 rs7Fk910A6/cnp6LwBomU4I90ZegmuyshGEX2n3xgbVJL9NHvpfvDviTlVB27l3WqKp4
 F6GGRBmUH5rft13kHiQ6EolcECYupaiovwQk7NhzFfUJzFUt0m8GLbyEZ15TBHYgcCrz
 2WOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728370208; x=1728975008;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ed3+SJvYlg3r/rbcPJ8oS0Yb8vznHmRmnBc4+Q6igfc=;
 b=GKbpjAAnuA3JKcz/xAYT90nSfyoHyocb0CD+32hMgFFhVVRKk6uh/DkGw6TU2c3GYi
 +nAEk0TJPIobpNk3LuTuXYfkEVcRkEsSM/jUOYhuYvx+zE8a4Q4Ffq/yXpxaQWc+XQ4a
 /UgYedu9aQZj0ipX28Lga1780YORosnHiRCvVOBz+KR8ijh5juH6vYLl27KZCCr/gKEN
 vS1oclyIP5UrO2nduraa7BMcAYmti+V5TWZ14YMXPcxJtOPM6hTtt5VLltP9bAIa8Rlw
 ven92psRxHj2DUpwKwcPxbE0ZTQgQhRQIikNIYQefP9Mzi0ugw8JAmqWREBmaMRSsHMw
 d+tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ/VJrBRAMg+DJFMTu1y045E+DwNb1x86jpk3PR6Fp+X3zFKGmqE25DzEW7svFJBuJe4NfI2MYicE=@nongnu.org,
 AJvYcCXtQMVEM8SDWBcz6mJTkAlUnw4GQDm5E1Tu9pApuSdweQvm8fABosxyjLMIPXN9vr+254yD7PvnXjoz@nongnu.org
X-Gm-Message-State: AOJu0Yxrr4nYNXq6bvZYvwh2hf017rw/8xH+LRMv22Xi5OdP6Ay1sSzC
 931KbvzX/G/K3+6ncUPvdeXD0vuJ+2UGmFGboQOc0cRz6kS7glnE
X-Google-Smtp-Source: AGHT+IFHcB7OVlREQG9XErXs/epgB5JKfSeJb9W1nP+lejY1FupwrBiLORLypBt30WlOed7wxYnmyw==
X-Received: by 2002:a17:902:e74e:b0:20b:ab74:f560 with SMTP id
 d9443c01a7336-20bff054cf5mr192716695ad.52.1728370207653; 
 Mon, 07 Oct 2024 23:50:07 -0700 (PDT)
Received: from localhost ([118.210.103.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c139893bfsm49681485ad.266.2024.10.07.23.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 23:50:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Oct 2024 16:50:03 +1000
Message-Id: <D4Q83Q215J3H.3KJOV06MZV11D@gmail.com>
Subject: Re: [PATCH v3 07/10] target/ppc: optimize p8 exception handling
 routines
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
Cc: <balaton@eik.bme.hu>, <danielhb413@gmail.com>
X-Mailer: aerc 0.18.2
References: <20240913041337.912876-1-harshpb@linux.ibm.com>
 <20240913041337.912876-8-harshpb@linux.ibm.com>
In-Reply-To: <20240913041337.912876-8-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

On Fri Sep 13, 2024 at 2:13 PM AEST, Harsh Prateek Bora wrote:
> Most of the p8 exception handling accesses env->pending_interrupts and
> env->spr[SPR_LPCR] at multiple places. Passing it directly as local
> variables simplifies the code and avoids multiple indirect accesses.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  target/ppc/excp_helper.c | 60 +++++++++++++++++++++-------------------
>  1 file changed, 32 insertions(+), 28 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index c7641898ca..c0828aac88 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1765,39 +1765,42 @@ static int p7_next_unmasked_interrupt(CPUPPCState=
 *env)
>      PPC_INTERRUPT_CEXT | PPC_INTERRUPT_WDT | PPC_INTERRUPT_CDOORBELL |  =
\
>      PPC_INTERRUPT_FIT | PPC_INTERRUPT_PIT | PPC_INTERRUPT_THERM)
> =20
> -static int p8_interrupt_powersave(CPUPPCState *env)
> +static int p8_interrupt_powersave(uint32_t pending_interrupts,
> +                                  target_ulong lpcr)
>  {
> -    if ((env->pending_interrupts & PPC_INTERRUPT_EXT) &&
> -        (env->spr[SPR_LPCR] & LPCR_P8_PECE2)) {
> +    if ((pending_interrupts & PPC_INTERRUPT_EXT) &&
> +        (lpcr & LPCR_P8_PECE2)) {
>          return PPC_INTERRUPT_EXT;
>      }
> -    if ((env->pending_interrupts & PPC_INTERRUPT_DECR) &&
> -        (env->spr[SPR_LPCR] & LPCR_P8_PECE3)) {
> +    if ((pending_interrupts & PPC_INTERRUPT_DECR) &&
> +        (lpcr & LPCR_P8_PECE3)) {
>          return PPC_INTERRUPT_DECR;
>      }
> -    if ((env->pending_interrupts & PPC_INTERRUPT_MCK) &&
> -        (env->spr[SPR_LPCR] & LPCR_P8_PECE4)) {
> +    if ((pending_interrupts & PPC_INTERRUPT_MCK) &&
> +        (lpcr & LPCR_P8_PECE4)) {
>          return PPC_INTERRUPT_MCK;
>      }
> -    if ((env->pending_interrupts & PPC_INTERRUPT_HMI) &&
> -        (env->spr[SPR_LPCR] & LPCR_P8_PECE4)) {
> +    if ((pending_interrupts & PPC_INTERRUPT_HMI) &&
> +        (lpcr & LPCR_P8_PECE4)) {
>          return PPC_INTERRUPT_HMI;
>      }
> -    if ((env->pending_interrupts & PPC_INTERRUPT_DOORBELL) &&
> -        (env->spr[SPR_LPCR] & LPCR_P8_PECE0)) {
> +    if ((pending_interrupts & PPC_INTERRUPT_DOORBELL) &&
> +        (lpcr & LPCR_P8_PECE0)) {
>          return PPC_INTERRUPT_DOORBELL;
>      }
> -    if ((env->pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
> -        (env->spr[SPR_LPCR] & LPCR_P8_PECE1)) {
> +    if ((pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
> +        (lpcr & LPCR_P8_PECE1)) {
>          return PPC_INTERRUPT_HDOORBELL;
>      }
> -    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
> +    if (pending_interrupts & PPC_INTERRUPT_RESET) {
>          return PPC_INTERRUPT_RESET;
>      }
>      return 0;
>  }
> =20
> -static int p8_next_unmasked_interrupt(CPUPPCState *env)
> +static int p8_next_unmasked_interrupt(CPUPPCState *env,
> +                                      uint32_t pending_interrupts,
> +                                      target_ulong lpcr)
>  {
>      CPUState *cs =3D env_cpu(env);
> =20
> @@ -1808,18 +1811,18 @@ static int p8_next_unmasked_interrupt(CPUPPCState=
 *env)
> =20
>      if (cs->halted) {
>          /* LPCR[PECE] controls which interrupts can exit power-saving mo=
de */
> -        return p8_interrupt_powersave(env);
> +        return p8_interrupt_powersave(pending_interrupts, lpcr);
>      }
> =20
>      /* Machine check exception */
> -    if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
> +    if (pending_interrupts & PPC_INTERRUPT_MCK) {
>          return PPC_INTERRUPT_MCK;
>      }
> =20
>      /* Hypervisor decrementer exception */
> -    if (env->pending_interrupts & PPC_INTERRUPT_HDECR) {
> +    if (pending_interrupts & PPC_INTERRUPT_HDECR) {
>          /* LPCR will be clear when not supported so this will work */
> -        bool hdice =3D !!(env->spr[SPR_LPCR] & LPCR_HDICE);
> +        bool hdice =3D !!(lpcr & LPCR_HDICE);
>          if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hdice) {
>              /* HDEC clears on delivery */
>              return PPC_INTERRUPT_HDECR;
> @@ -1827,9 +1830,9 @@ static int p8_next_unmasked_interrupt(CPUPPCState *=
env)
>      }
> =20
>      /* External interrupt can ignore MSR:EE under some circumstances */
> -    if (env->pending_interrupts & PPC_INTERRUPT_EXT) {
> -        bool lpes0 =3D !!(env->spr[SPR_LPCR] & LPCR_LPES0);
> -        bool heic =3D !!(env->spr[SPR_LPCR] & LPCR_HEIC);
> +    if (pending_interrupts & PPC_INTERRUPT_EXT) {
> +        bool lpes0 =3D !!(lpcr & LPCR_LPES0);
> +        bool heic =3D !!(lpcr & LPCR_HEIC);
>          /* HEIC blocks delivery to the hypervisor */
>          if ((msr_ee && !(heic && FIELD_EX64_HV(env->msr) &&
>              !FIELD_EX64(env->msr, MSR, PR))) ||
> @@ -1839,20 +1842,20 @@ static int p8_next_unmasked_interrupt(CPUPPCState=
 *env)
>      }
>      if (msr_ee !=3D 0) {
>          /* Decrementer exception */
> -        if (env->pending_interrupts & PPC_INTERRUPT_DECR) {
> +        if (pending_interrupts & PPC_INTERRUPT_DECR) {
>              return PPC_INTERRUPT_DECR;
>          }
> -        if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
> +        if (pending_interrupts & PPC_INTERRUPT_DOORBELL) {
>              return PPC_INTERRUPT_DOORBELL;
>          }
> -        if (env->pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
> +        if (pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
>              return PPC_INTERRUPT_HDOORBELL;
>          }
> -        if (env->pending_interrupts & PPC_INTERRUPT_PERFM) {
> +        if (pending_interrupts & PPC_INTERRUPT_PERFM) {
>              return PPC_INTERRUPT_PERFM;
>          }
>          /* EBB exception */
> -        if (env->pending_interrupts & PPC_INTERRUPT_EBB) {
> +        if (pending_interrupts & PPC_INTERRUPT_EBB) {
>              /*
>               * EBB exception must be taken in problem state and
>               * with BESCR_GE set.
> @@ -2021,7 +2024,8 @@ static int ppc_next_unmasked_interrupt(CPUPPCState =
*env)
>      case POWERPC_EXCP_POWER7:
>          return p7_next_unmasked_interrupt(env);
>      case POWERPC_EXCP_POWER8:
> -        return p8_next_unmasked_interrupt(env);
> +        return p8_next_unmasked_interrupt(env, env->pending_interrupts,
> +                                          env->spr[SPR_LPCR]);
>      case POWERPC_EXCP_POWER9:
>      case POWERPC_EXCP_POWER10:
>      case POWERPC_EXCP_POWER11:


