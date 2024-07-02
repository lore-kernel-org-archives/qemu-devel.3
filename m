Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129B9C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfu0-0005nK-Oi; Tue, 02 Jul 2024 11:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sOftx-0005fP-SP
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:58:41 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sOftv-0004bU-EL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:58:41 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a727d9dd367so471956566b.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719935917; x=1720540717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mm4apseHDj4tJVI9Su72iBDMHNZAfsDlJYJOnF2K+Ko=;
 b=N9fkcN3Mu1SRxoV22qRyw6QhYkRwZaWPrpwkO7tx1AXPr1G+yi2PoRKhUUPqGN2Yyu
 r9N9KSrcyJHQrcTOxvk7ork54elYRLjLKmn2lzx/doAKdfZJDJv4vBPYwFsJ7mj2FPM7
 qJBT+El0DYKdC2cn4JQCVyUidE/hs5cxRrEJsURJ/phQChOkDP7FEFMh609lgHkexTRa
 q2Yoz32zdWm51p+ztGkyAnAgUvbU2Eh85IKI71GFlzFnpZvmcVrxJ7f/4BYgZfiPHtOP
 GBLk5k6DbJUkqOsTOJfFBuXK+QjV1i/h8THUikpxhN08ppN5ntR4gSKak0tE/kDFR4A9
 MQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719935917; x=1720540717;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mm4apseHDj4tJVI9Su72iBDMHNZAfsDlJYJOnF2K+Ko=;
 b=C8a0DWWgFY2+TftvFxDeNczy1SrcPins5ftkCoNjBKq8CaHYTF4684k8Ww9BMm8XMT
 z71FL5BEvPKICDFtktg4gbTqh1ppbV0PN8v93wYaLZ3Tw03ejnR6cWS2ipFia1jqh8VP
 RrfXSQw5QFK030mDqqePh4IjPEiC8gsDssG4Tf05pcttvQZhlR7MNfkFHlvqy8e77rnl
 gGwIfKHyfEho2wnuq5Lfibzq9nxcUrTkUiWzcvJj5IVCK2+AlQ0HGKBG67APDXYD3W07
 h66/7l97QL1sPF2ip0FDQ8904axYDNgUMUAwYR6dunM8oFpbU2Gr6ci7f0DIEVoKIKOy
 qbLQ==
X-Gm-Message-State: AOJu0YxuxR2Yrm0AbQRURm56tF6oLnfZZqWf4NEqcL3Az2R3jrBcMepF
 pzb9dXHc0dY2n98cq4bbu+m/yvEdVx1KOdwNZW6qAIFh8XC0RWRY1O1zlnWNtS6D9ljQCZgXIV8
 i
X-Google-Smtp-Source: AGHT+IFvaRmll0zS77ZL07LCquSC8Q5+PAiP8gVicbR7EuUomT28eG3nhhHZULPNuOnYZM9AlaFaWQ==
X-Received: by 2002:a17:906:c359:b0:a72:554d:82af with SMTP id
 a640c23a62f3a-a751445468amr541836666b.20.1719935917295; 
 Tue, 02 Jul 2024 08:58:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf6295csm431507566b.72.2024.07.02.08.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 08:58:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C642E5F790;
 Tue,  2 Jul 2024 16:58:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH] target/arm: Use cpu_env in cpu_untagged_addr
In-Reply-To: <20240702154911.1667418-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Tue, 2 Jul 2024 08:49:11 -0700")
References: <20240702154911.1667418-1-richard.henderson@linaro.org>
Date: Tue, 02 Jul 2024 16:58:35 +0100
Message-ID: <87ed8brdjo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

> In a completely artifical memset benchmark object_dynamic_cast_assert
> dominates the profile, even above guest address resolution and
> the underlying host memset.

We seem to use ARM_CPU() quite liberally for a number of helpers so I
wonder if its worth codifying this anywhere? At least all the direct TCG
op helpers take CPUARMState *env directly.

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index d8eb986a04..ccfb9349a3 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3309,8 +3309,8 @@ extern const uint64_t pred_esz_masks[5];
>   */
>  static inline target_ulong cpu_untagged_addr(CPUState *cs, target_ulong =
x)
>  {
> -    ARMCPU *cpu =3D ARM_CPU(cs);
> -    if (cpu->env.tagged_addr_enable) {
> +    CPUARMState *env =3D cpu_env(cs);
> +    if (env->tagged_addr_enable) {
>          /*
>           * TBI is enabled for userspace but not kernelspace addresses.
>           * Only clear the tag if bit 55 is clear.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

