Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB039CED62B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 08:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syRoi-0006bO-63; Wed, 09 Oct 2024 04:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1syRof-0006b7-Gt
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:13:05 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1syRoe-0006Kl-0W
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:13:05 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a999521d0c3so27854366b.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 01:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728461580; x=1729066380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mesQ/2M2pyVdRG4o9NIYSguDCI0S1chEWuiV5bm5mxY=;
 b=ZhznnD2454JSiHDqOA38dkw23SrWcazy4k7RxE7Y9wRlhvxdGuIDrlxJTDA1TTpZqw
 8PVtVBzs7Lb6zdqkpIS0yVBn1dZEWF772MGcNIFt12Zl75UzRfm/KAko8ehl5QEIRqUA
 d0AqMEW3/3jwl9CSqK/R7tfLY3R58Z4fB6ALJSLXqHfMOQNvZBO+M5Fi5V3U/sz5Qa6E
 n4rEBl9hcaj9gHtfX1/G+auxF9CR2E4MFizK9cdFCkb2+rfiJFZK4LCKiy3XES3ik2wp
 xEAIwuBpTpcG7QuBi1BtEn9sqxQR3jEkZ2OT9okYlcRe+7iRoGb7BzjsCxzaRp2pT154
 mZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728461580; x=1729066380;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mesQ/2M2pyVdRG4o9NIYSguDCI0S1chEWuiV5bm5mxY=;
 b=qCN992uSrhsNQanYcZXAhANPgjfhOarNoxviUuFgj2y1zrUJyuGg61wTqFvk1VdqN6
 qhr2RLrZCB0VXLs7F/UhAv1llNjcQ6yeyZ3f9kp4n9Q68b1nlJ2E4URPtd7kpSvITSoX
 egMH5tOWt53HGBPJ5akPgN0f4m68mQOPvm7i03NqCL2NxieIVBxzSHgfqOsoDmIGqWlY
 WUihJEGluFLoWPev7NnrkKRVt86Bn34lth922tqDECV8sqrUrdnF4YrB22JXRf5MYvfa
 kmqT+tGsS67AZlQcK6XYV+0eEnbvfCrzPXnGkFFZ7pJ9T5V0i0+DmV34fX3349pPMQax
 uabw==
X-Gm-Message-State: AOJu0YwqoPAekI0OojKTkVXds9OO7n9NungAiSB22lTaKlLPCw38qJP6
 qASCKZGrjfnvS531fneqIR+qKTLE9wbhCSPLOFt7mZR35LbeeAQQlxPTOCfb7Zc=
X-Google-Smtp-Source: AGHT+IEig8qFTKClo7VIz1kzsC2Cd0VrrXUJAXrTtZ87/frAJAisno0MoZoN7ldWGNDUM2HyVahTjA==
X-Received: by 2002:a17:907:9803:b0:a99:5f5b:1391 with SMTP id
 a640c23a62f3a-a998d1b27a1mr130638466b.20.1728461580446; 
 Wed, 09 Oct 2024 01:13:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a993a7cfcfcsm575305866b.143.2024.10.09.01.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 01:12:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E1D085F716;
 Wed,  9 Oct 2024 09:12:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  qemu-stable@nongnu.org
Subject: Re: [PATCH] target/i386: Use probe_access_full_mmu in ptw_translate
In-Reply-To: <20241009002029.317490-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Tue, 8 Oct 2024 17:20:29 -0700")
References: <20241009002029.317490-1-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 09 Oct 2024 09:12:58 +0100
Message-ID: <877cahvgmt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> The probe_access_full_mmu function was designed for this purpose,
> and does not report the memory operation event to plugins.

I note the kdoc for probe_access_full_mmu has the wrong title. It might
be worth referencing the fault and instrumentation behaviour in the
probe_access_full() kdoc as well.

>
> Cc: qemu-stable@nongnu.org
> Fixes: 6d03226b422 ("plugins: force slow path when plugins instrument mem=
ory ops")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/tcg/sysemu/excp_helper.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysem=
u/excp_helper.c
> index 8fb05b1f53..8f4dc08535 100644
> --- a/target/i386/tcg/sysemu/excp_helper.c
> +++ b/target/i386/tcg/sysemu/excp_helper.c
> @@ -62,12 +62,11 @@ typedef struct PTETranslate {
>=20=20
>  static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
>  {
> -    CPUTLBEntryFull *full;
>      int flags;
>=20=20
>      inout->gaddr =3D addr;
> -    flags =3D probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
> -                              inout->ptw_idx, true, &inout->haddr, &full=
, ra);
> +    flags =3D probe_access_full_mmu(inout->env, addr, 0, MMU_DATA_STORE,
> +                                  inout->ptw_idx, &inout->haddr, NULL);
>=20=20
>      if (unlikely(flags & TLB_INVALID_MASK)) {
>          TranslateFault *err =3D inout->err;
> @@ -429,9 +428,8 @@ do_check_protect_pse36:
>          CPUTLBEntryFull *full;
>          int flags, nested_page_size;
>=20=20
> -        flags =3D probe_access_full(env, paddr, 0, access_type,
> -                                  MMU_NESTED_IDX, true,
> -                                  &pte_trans.haddr, &full, 0);
> +        flags =3D probe_access_full_mmu(env, paddr, 0, access_type,
> +                                      MMU_NESTED_IDX, &pte_trans.haddr, =
&full);
>          if (unlikely(flags & TLB_INVALID_MASK)) {
>              *err =3D (TranslateFault){
>                  .error_code =3D env->error_code,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

