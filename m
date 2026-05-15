Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EA1CD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtVN-0000nd-Jv; Fri, 15 May 2026 10:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtVI-0000NG-9K
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:27:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtVF-0001co-Uw
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:27:03 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso106238705e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778855220; cv=none;
 d=google.com; s=arc-20240605;
 b=cd2UFz7BOdXmO0ZLsSiRsaEowz9eGWiWxb2Kosc3Gm03R1o1ta0h3Qs8zQxAMzrSeX
 wyNuGk7hO2nhAqxqoOPeRRPM6vRle0pbktAMAu66yw0KyNd/Biisj8wsDJ/jYeArr7b1
 nDvXjWpbW+qe0V4pMlD7lILBuxTFsisrgTo/MjqDsMkiFuF06lNb6GWSrA2WjclPVtQz
 m/BN0hrW+ntCbCPCUxbitF90oLmD2ljkpY1w5JJhX1ltUZDtIzeHDQHQKYGrVoQ5zUEy
 X4z4hNHRGLpD1/LV19i5kvMEcojGYP83wVFkaccMlwGLC/y+MfviUSMoWbHRPDrQRBEJ
 CnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=r+OPeYtnjVAwulfMkaBJo0TXzswXscHBEQPnsT5w7/o=;
 fh=G+JBw2Pu6hUZ8zKsXx/FXyHuhiws+/jrNByUetwlSSw=;
 b=AdMfBUk9b2dAoocxx6X4oOStnXEE9F7gSEVqga48e+Ev6jD2oGwdhYz6a2yb/Hj/r0
 hroFgwdb7XRB/S1VV0SFLs5Nq3rCtFyOQqUcuGKHUdIrAUvEjpWPSWX2Nzu7XS+QdvRg
 aCIy1ghRyuXIeTEOBszVtNVL7/k1l/60aII9EZbBckngf0llD62/dlwC9WSm9YmuZAXd
 HA/QCVX1y52YQVGINx+zicc2AmO2+m2lQbinq4XxEjDvZyUpUkF3ICGkDJRjioK8Gj+k
 eE+heeRKDqGJtdyV+/Sofat2QZbmtF0UTWXGZUbG+V+TPTpPqJR4FoLatz6jh1m0NPGA
 ym8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855220; x=1779460020; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+OPeYtnjVAwulfMkaBJo0TXzswXscHBEQPnsT5w7/o=;
 b=OYVIIBVCzPe2QbiH90zCQksBYfMQtyh5kczp0CfyzSvMpLZcR61hx3WtdJYgIDi59B
 W4JA5J82FwsDQ0T3EiB7hacfhXpU9qHfN+VQCPNe4nhjHiB4S0UTNGvPaUFsTVvrCZDk
 MhTGZHFHUne+IRMafwu05HHenop215vXSt9+8Egk19DTYm7jkDU5stmvC31CsWVuJMLX
 elZxdyh3TB+DFJTwvDlVI8Pl7+RwRfDZFwSUsxTsrvPWpG1+R3gWXoUdfu4lfCZ0H2zE
 paXhqxEGoAOI56pWn0/7kYba2z3iO7G+lKyHyDWsP+EjPHvJh1ZdisuiAs+cZqQDbjvv
 /7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855220; x=1779460020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r+OPeYtnjVAwulfMkaBJo0TXzswXscHBEQPnsT5w7/o=;
 b=RDZw52bF8zscefJSF9267q2w0wrcWi0RyTK1ANEcbKtHUNU345DcPz9e0zJcjEGQfp
 IIYxDahCqVBgRkiyYp8A2yTAIc6Tl/+V0XI6uN0ZS8RvYFJ0ghfHBX+sjgzkiqSY8Crq
 zLgXkw/lWPTmcjmSK9oN/ShyVHWlITkJfSLCfa+mMoOuDBuZuzmy3SzPJbAeqd7rjll3
 7zhV0iftfN3PAEbORH29tySJjYpV1gLj59q3/5qUFP0cG3KR6srkusiFddI9tQRRmhTK
 vsH3rwopdcnyIrqoaqZNcF/5m8GRSaMIMasGQYg4c5FQo0Vzm93/ZrDOn6C7E05pXwln
 d7hA==
X-Gm-Message-State: AOJu0Yzx+L6JHwZeoDbE+89xFw6AiILs3lj9Kzs1Q9JC9wBwQ3gAA6kY
 4Jz40yN1WDUjiVUIpLeJq8lJ5Ztvxb7MlfA54Be38tZWLdTPdl4yqVEaiazhEPTathDggw+KRgE
 ci7NERdHBElPCfIyYRANsWjbianCm/hOgfr31r4+y2Q==
X-Gm-Gg: Acq92OFaFK3f4O/U54D8S/erNTngS2D1IL5zC2BmbvLH/HeGasbUjHei0zHGFW92tSq
 GyeG2umGJNJ0XSXP66JHUdLxOCgESYaXbCT8sTlbtTU5tj585ibx+ycQnKc896fs7Yh70tHzp9Z
 NMGyjtdlnqrzv5qQtTcj2nj0khSMWWg9YDDmUafJyPw7P7g0u0kOczeuAw762f4L6rjgFD2GSED
 vcesYRgZOtaPvKCmBGp0T5e5hccXhyiUkIc3cssGFGfNuAkSNG3Hai0mhcdA6R0EOq1QWY3e4yl
 m8IGDvIglbN+Sgk6iDren1Moic6QSy0mNj5OrHDulXn3FG0sIw==
X-Received: by 2002:a05:600d:8:b0:48f:e6b9:c740 with SMTP id
 5b1f17b1804b1-48fe6b9c811mr56771145e9.30.1778855220222; Fri, 15 May 2026
 07:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-16-philmd@linaro.org>
In-Reply-To: <20260515141032.3271-16-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 15 May 2026 17:26:33 +0300
X-Gm-Features: AVHnY4IOVe2TuJk0qecob8y1iCMOMIo4za2mj-OsBCB5Gq2L92DoJPcgG4zvgio
Message-ID: <CAAjaMXYWZwvBOVQ_qepOMVfMaATqBTf2z5cKfvfjEsGKQ_zzQw@mail.gmail.com>
Subject: Re: [PATCH v6 15/20] target/arm: Only set %kvm_target when KVM is
 enabled
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

On Fri, May 15, 2026 at 5:12=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/arm/cpu64.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index b38a78aac3f..7b2f09cf8ec 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -701,7 +701,9 @@ static void aarch64_a57_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_EL2);
>      set_feature(&cpu->env, ARM_FEATURE_EL3);
>      set_feature(&cpu->env, ARM_FEATURE_PMU);
> -    cpu->kvm_target =3D QEMU_KVM_ARM_TARGET_CORTEX_A57;
> +    if (kvm_enabled()) {
> +        cpu->kvm_target =3D QEMU_KVM_ARM_TARGET_CORTEX_A57;
> +    }
>      cpu->midr =3D 0x411fd070;
>      cpu->revidr =3D 0x00000000;
>      cpu->reset_fpsid =3D 0x41034070;
> --
> 2.53.0
>

