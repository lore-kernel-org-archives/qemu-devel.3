Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C79CED270
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 06:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy44W-0001cn-6v; Tue, 08 Oct 2024 02:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy44P-0001VX-5R; Tue, 08 Oct 2024 02:51:46 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy44M-0006Tu-He; Tue, 08 Oct 2024 02:51:44 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20bb610be6aso58818155ad.1; 
 Mon, 07 Oct 2024 23:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728370301; x=1728975101; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fs2T5aemAwUQjxlzySNlhtARr619PiArBECUknV2tyU=;
 b=K6UAIqvmYPqeK2+6RQmXtrsk6bckAp0stw99pKxv/ZCC/Si7zXg/pLOFaGRmsfee/u
 YtmC7B/ZF8HFMr3X13nutWaLuWpoIKpKUNrfMslMe7v/ut/0G+q1ZXjYk0IAwskYJUim
 MF/SCAb64u9iwcZiwjDAQaEEurcW25wOljkFO/MyW+6LTeJESZhPaXvTEi8BBbqxV+lq
 2G6bb8gszafwqziTc2qXnb5dJaubEILrqZS3f8PkpH0F29Hz9gIZOc2EOYD3Ismmn69T
 hLEk50fr9Ce+bQihpCyjHU0uglogy4VKGbIfY9c0FdYG/gPzSvMRdXcAQiyfILB8a3Zl
 aohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728370301; x=1728975101;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fs2T5aemAwUQjxlzySNlhtARr619PiArBECUknV2tyU=;
 b=a0GcJEcPx49lOgslXKOsjB5kBGsvILHlPmTQzfrCKRZnZdSx2VXXbaPa8ts3fVoD3A
 WgLvGzcVpNUilb9IoVjM5ojgt3x0IMEtTxlJ5NYhjmRVdq4ue31om4/qIRxTN2u1xop9
 0HpWvbYal07yxsIGNuPDBjFbMlEx5KtPfi+zRe0TKopAlQnGODDzzDmhQDE1gOc4ZY0m
 a+KXO7i9Bi5ysCsFf2ztF6E33q9o7R0LOl5NVYfGWp19X4fY7nmp2OiOrsT4RRJ7POfM
 kOCxRUHzX6/m81ZUzJSZfPfBQFpAKb803MKICxXYrLrOoMqtEIc3hbgtr9TnKCZj9e9t
 kPOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6mJvgGupO7ykSDUVxhbzGxRsUf7bU0VNYA/cwSGvNMqQVMu6463aZj8fpAA1Y1C0XxS0yGXb3wyMV@nongnu.org,
 AJvYcCVrtc+igsutEIV6gm6fw7b50z5Wm0tQtmOcmOiQQnIprdzzs2b64V20DHTgjkULOrZaj43HV7RtfM4=@nongnu.org
X-Gm-Message-State: AOJu0YyKL7dc/AmNlPItrK1iJuZgCALoQ+N/R4K1bDUjTcqy1lUAjzND
 6bRs5hzSrvzEDzPSr+kwkeNtz863vaSQkqCVRIWjqHGK5gmFptES
X-Google-Smtp-Source: AGHT+IEoscTVdiqDJ8TTBcAA9ikMeRY57exEDxA6jI+ZUwZQ62//UWNj1ft0fUBy+/06TPD6vjDeKA==
X-Received: by 2002:a17:902:d4c6:b0:206:adc8:2dcb with SMTP id
 d9443c01a7336-20bfdffa041mr155748025ad.25.1728370300632; 
 Mon, 07 Oct 2024 23:51:40 -0700 (PDT)
Received: from localhost ([118.210.103.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cba18sm49945745ad.83.2024.10.07.23.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 23:51:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Oct 2024 16:51:36 +1000
Message-Id: <D4Q84WQYGJ7N.1P7N35Q235DPQ@gmail.com>
Cc: <balaton@eik.bme.hu>, <danielhb413@gmail.com>
Subject: Re: [PATCH v3 09/10] target/ppc: simplify var usage in
 ppc_next_unmasked_interrupt
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20240913041337.912876-1-harshpb@linux.ibm.com>
 <20240913041337.912876-10-harshpb@linux.ibm.com>
In-Reply-To: <20240913041337.912876-10-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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
> As previously done for arch specific handlers, simplify var usage in
> ppc_next_unmasked_interrupt by caching the env->pending_interrupts and
> env->spr[SPR_LPCR] in local vars and using it later at multiple places.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/excp_helper.c | 54 ++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index d0e0f609a0..4eeeedff5b 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -2022,31 +2022,31 @@ static int p9_next_unmasked_interrupt(CPUPPCState=
 *env,
> =20
>  static int ppc_next_unmasked_interrupt(CPUPPCState *env)
>  {
> +    uint32_t pending_interrupts =3D env->pending_interrupts;
> +    target_ulong lpcr =3D env->spr[SPR_LPCR];
> +    bool async_deliver;
> +
>  #ifdef TARGET_PPC64
>      switch (env->excp_model) {
>      case POWERPC_EXCP_POWER7:
> -        return p7_next_unmasked_interrupt(env, env->pending_interrupts,
> -                                          env->spr[SPR_LPCR]);
> +        return p7_next_unmasked_interrupt(env, pending_interrupts, lpcr)=
;
>      case POWERPC_EXCP_POWER8:
> -        return p8_next_unmasked_interrupt(env, env->pending_interrupts,
> -                                          env->spr[SPR_LPCR]);
> +        return p8_next_unmasked_interrupt(env, pending_interrupts, lpcr)=
;
>      case POWERPC_EXCP_POWER9:
>      case POWERPC_EXCP_POWER10:
>      case POWERPC_EXCP_POWER11:
> -        return p9_next_unmasked_interrupt(env, env->pending_interrupts,
> -			                  env->spr[SPR_LPCR]);
> +        return p9_next_unmasked_interrupt(env, pending_interrupts, lpcr)=
;
>      default:
>          break;
>      }
>  #endif
> -    bool async_deliver;
> =20
>      /* External reset */
> -    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
> +    if (pending_interrupts & PPC_INTERRUPT_RESET) {
>          return PPC_INTERRUPT_RESET;
>      }
>      /* Machine check exception */
> -    if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
> +    if (pending_interrupts & PPC_INTERRUPT_MCK) {
>          return PPC_INTERRUPT_MCK;
>      }
>  #if 0 /* TODO */
> @@ -2065,9 +2065,9 @@ static int ppc_next_unmasked_interrupt(CPUPPCState =
*env)
>      async_deliver =3D FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sr=
eset;
> =20
>      /* Hypervisor decrementer exception */
> -    if (env->pending_interrupts & PPC_INTERRUPT_HDECR) {
> +    if (pending_interrupts & PPC_INTERRUPT_HDECR) {
>          /* LPCR will be clear when not supported so this will work */
> -        bool hdice =3D !!(env->spr[SPR_LPCR] & LPCR_HDICE);
> +        bool hdice =3D !!(lpcr & LPCR_HDICE);
>          if ((async_deliver || !FIELD_EX64_HV(env->msr)) && hdice) {
>              /* HDEC clears on delivery */
>              return PPC_INTERRUPT_HDECR;
> @@ -2075,18 +2075,18 @@ static int ppc_next_unmasked_interrupt(CPUPPCStat=
e *env)
>      }
> =20
>      /* Hypervisor virtualization interrupt */
> -    if (env->pending_interrupts & PPC_INTERRUPT_HVIRT) {
> +    if (pending_interrupts & PPC_INTERRUPT_HVIRT) {
>          /* LPCR will be clear when not supported so this will work */
> -        bool hvice =3D !!(env->spr[SPR_LPCR] & LPCR_HVICE);
> +        bool hvice =3D !!(lpcr & LPCR_HVICE);
>          if ((async_deliver || !FIELD_EX64_HV(env->msr)) && hvice) {
>              return PPC_INTERRUPT_HVIRT;
>          }
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
>          if ((async_deliver && !(heic && FIELD_EX64_HV(env->msr) &&
>              !FIELD_EX64(env->msr, MSR, PR))) ||
> @@ -2096,45 +2096,45 @@ static int ppc_next_unmasked_interrupt(CPUPPCStat=
e *env)
>      }
>      if (FIELD_EX64(env->msr, MSR, CE)) {
>          /* External critical interrupt */
> -        if (env->pending_interrupts & PPC_INTERRUPT_CEXT) {
> +        if (pending_interrupts & PPC_INTERRUPT_CEXT) {
>              return PPC_INTERRUPT_CEXT;
>          }
>      }
>      if (async_deliver !=3D 0) {
>          /* Watchdog timer on embedded PowerPC */
> -        if (env->pending_interrupts & PPC_INTERRUPT_WDT) {
> +        if (pending_interrupts & PPC_INTERRUPT_WDT) {
>              return PPC_INTERRUPT_WDT;
>          }
> -        if (env->pending_interrupts & PPC_INTERRUPT_CDOORBELL) {
> +        if (pending_interrupts & PPC_INTERRUPT_CDOORBELL) {
>              return PPC_INTERRUPT_CDOORBELL;
>          }
>          /* Fixed interval timer on embedded PowerPC */
> -        if (env->pending_interrupts & PPC_INTERRUPT_FIT) {
> +        if (pending_interrupts & PPC_INTERRUPT_FIT) {
>              return PPC_INTERRUPT_FIT;
>          }
>          /* Programmable interval timer on embedded PowerPC */
> -        if (env->pending_interrupts & PPC_INTERRUPT_PIT) {
> +        if (pending_interrupts & PPC_INTERRUPT_PIT) {
>              return PPC_INTERRUPT_PIT;
>          }
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
>          /* Thermal interrupt */
> -        if (env->pending_interrupts & PPC_INTERRUPT_THERM) {
> +        if (pending_interrupts & PPC_INTERRUPT_THERM) {
>              return PPC_INTERRUPT_THERM;
>          }
>          /* EBB exception */
> -        if (env->pending_interrupts & PPC_INTERRUPT_EBB) {
> +        if (pending_interrupts & PPC_INTERRUPT_EBB) {
>              /*
>               * EBB exception must be taken in problem state and
>               * with BESCR_GE set.


