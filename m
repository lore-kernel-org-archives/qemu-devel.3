Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202FFCD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 10:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSXtR-0004Ah-M4; Thu, 28 May 2026 06:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSXtP-0004A8-NW
 for qemu-devel@nongnu.org; Thu, 28 May 2026 06:23:11 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSXtO-00067Z-56
 for qemu-devel@nongnu.org; Thu, 28 May 2026 06:23:11 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6603e24a7f9so494905d50.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 03:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779963789; cv=none;
 d=google.com; s=arc-20240605;
 b=gh5JQ9GMbWNv0NTh1w8Pw7nuZZYLf6L9c2FpkB/aU3nXCJqkdUPAfoqQ1/i0l86fZp
 43Ofk7Fm7l0t0hEYnOJoIevoxX0iRwv40GlbEYOSXh7g8kxvHdV13gRQTRNwQF3TUhba
 WRbWEwZN3IeiO+CNE31k+C/nr4/7HFXYs3/uKzipOuj2z8Kg78slUEdnFyMi8tZdijN0
 dhOCCDQkRE/8ziHXgqZWmyaKiGXHWbgimfth0Sl0OgAtZgfBn4ZNPIVrMxOOlGoS20Dx
 siJ6gj3jyKZ75vrEgd9T5Lxdu2OjF8E2lGyvNSDuYYENzqbbhjKGHNhP4mk27TGcSEPg
 m6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ih0tAGC2oD+ODfyMV7mnUd5xBZ1bDG8Oxezd/MEAjeM=;
 fh=FWtyXIX1K30Gh1JIPWWinn1E8IuOwxOeZI6Shz32Tr4=;
 b=FAXDvJ8JxyWLkmdpWpK8uRzU38JcT1Jg7WcVFJMrWOPPFLXhaSChayIJuc+cOcdZPk
 igzAI7OfY0Lxi9YiRbNTC8dpd9mlZfNOboRwKUroXAChP2/1+Q7Ru4ZYdgfGOhgBR0tS
 B3zkuLH1H76l4Y7eXpWyQ70v/pX+dSeIAaNBrX7HqtaVgNWunc47cJRuhDUvcigfOW8n
 ao8AVikE+W/RNLj04rchskgRQFklGuiRySBpVGM85qiBcz7uGi77sMmk8iXDe0tuMe8y
 gETEgdrxC4x87r46ymiVjQOhlwMd83XaH/S1lujf7BasIHC77hvVJlTvTNnal2GCpjlF
 mrEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779963789; x=1780568589; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ih0tAGC2oD+ODfyMV7mnUd5xBZ1bDG8Oxezd/MEAjeM=;
 b=nbAfmwllpdqt6R6FbbG5mlNf68PXMCe3hJHi+FL/a6MKcvZiyVd6SRxrXGsFDGONqN
 yIiSdBPAIXT8SuBgoHOBzhEUZxTWj4YCIez/YWHl5JegXTerhYiJFBUEv6WE10DeYobB
 Ve0fLIWTRfx0ydpF2QyUaMu2H5GCQHFb0rsZud7ro46vHZLE5t3j0ECJXmqk1AyRVS9m
 FqDoCqobh+IdUReANkocGc3Iu49z+WntxZH2DQ7wYKL+wtfkhWOr+cyv5dw8bBc5EL3d
 MJfYUHwM4D8ZFmWo0mfQ3HD9sXOqeG3LaMLFdZQIP9W3NKVJAtK5Pz7tUULZ1EO9JBEw
 6cYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779963789; x=1780568589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ih0tAGC2oD+ODfyMV7mnUd5xBZ1bDG8Oxezd/MEAjeM=;
 b=STOuGFbe+/bTt2QbHHjvWgFqfyqRk+rgCIEicjkWJgbhia2WsxUjSuir+2zs6mfva/
 Sw/eFhGhO2/KBG4Vkv3FJ3hwQ0EpHCiA99+YgB9L44tEJkAP2vBo0knL141bApn1GRz0
 JJ6WZ6pZ4RD6O505m5BcKiEKspCww+FfFH4hLP6XsA9rdzVSS1fBKqC2NA6ekZ+bf0fL
 FsgXQ9rn7TCbiH85kcNysv24e5lUKlXItpOiOr5aZSM1vM6a4jADxhjA0JI4bEeNV/RN
 90HIB1FiK0X+o8pwwTLX2C0wl+5fqSl9PazgOgBo0ls1gJVt+9OKV2a7uvRLF91RMp+z
 //GA==
X-Gm-Message-State: AOJu0YwcgKzAHyqTIUXYJt0Oq/oHBi8MWdyCIIxUzIl6KyoZFGhQwnCy
 agMK5hLhaTiGNB+LjNU7dQrj81FbOQUslFcZJ/ipzjPb/oVTjm426uW5EzZt/F9ZVoT5Iu8Z3q9
 2hCI/X4TkUc5AjZGpmy7HrYyZ47aySqt/aYUOjzT4kw==
X-Gm-Gg: Acq92OF2sy6K2azA5BkslvuS981Ge3PtIXSoMTfZD7FqY7+DI31QDp9ZHwXjZ3Uu2mu
 h4qHGg0M+51MY/vu3tk92GWL1VruVs+rrm1CoSS27R7whJ+jcTvdBUuOBK7KSHmP0mdJUcmCq83
 gyFOcuqtdFZIH62jxgihfdvk8ZbZfT6bm9BmPqHq03fQZ3nfdq/1WxPryfbUKPtSmg6rI6uJG1K
 VYZBn29f+EhtYJCCUXzFTj0ajgqc3vSvpI8WgkTwGFaBwLTmpRBQNN3PCfw/IzTlWe1KBbuL44D
 Y91YkhgMiRlW2nVChW36bvyZr8yaTxc5PE25En+yiGhYaxSolJSIzYOd0iUAnJIlCI75Qhiu1Dn
 KKEPTv1bdDTHs
X-Received: by 2002:a53:ac83:0:b0:65d:6f10:d42a with SMTP id
 956f58d0204a3-65ec98a9bbamr25888606d50.39.1779963788854; Thu, 28 May 2026
 03:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com>
 <20260518-pr-pacbti-v1-1-8932a885b03d@foss.st.com>
In-Reply-To: <20260518-pr-pacbti-v1-1-8932a885b03d@foss.st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 11:22:57 +0100
X-Gm-Features: AVHnY4LaMlxtA_Q4sNPBjupH8IL1E5jUJirlGtiw_jqw0bNDL6TKUDmhL6jJDXs
Message-ID: <CAFEAcA_LcEO1J8gC5kpAVeiQ-pNEr2oNsdmx_NeEZhLgbstjNQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/arm/tcg: define cortex-m85 cpu
To: =?UTF-8?Q?Torbj=C3=B6rn_SVENSSON?= <torbjorn.svensson@foss.st.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Mon, 18 May 2026 at 17:16, Torbj=C3=B6rn SVENSSON
<torbjorn.svensson@foss.st.com> wrote:
>
> Signed-off-by: Torbj=C3=B6rn SVENSSON <torbjorn.svensson@foss.st.com>
> ---
>  target/arm/tcg/cpu-v7m.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

This patch should go last in the series -- first add
all the new features the CPU needs, and only then add
the new CPU, so there isn't a window where the user can
select the new CPU type but it isn't completely implemented yet.

> diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
> index dc249ce1f1..5cfda232cd 100644
> --- a/target/arm/tcg/cpu-v7m.c
> +++ b/target/arm/tcg/cpu-v7m.c
> @@ -237,6 +237,44 @@ static void cortex_m55_initfn(Object *obj)
>      cpu->ctr =3D 0x8303c003;
>  }
>
> +static void cortex_m85_initfn(Object *obj)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(obj);
> +    ARMISARegisters *isar =3D &cpu->isar;
> +
> +    set_feature(&cpu->env, ARM_FEATURE_V8);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_1M);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
> +    set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
> +    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
> +    cpu->midr =3D 0x411fd230; /* r1p0 */

The most recent release is r1p1, so we might as well model that:
0x411fd231.

thanks
-- PMM

