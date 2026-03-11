Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E171125857
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0N0C-0006Eu-Ha; Wed, 11 Mar 2026 13:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0MyG-0004kt-TN
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:03:45 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0MyF-0000tq-3q
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:03:44 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64ca2b32f46so63218d50.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 10:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773248622; cv=none;
 d=google.com; s=arc-20240605;
 b=Fwgn8PjknVqpC303HrWQUrGF8oWLWA1cXpo166dhKCcGaT+9MVkYGWJ/u5v7ENhevB
 KYDfYoV46ejfC2cGLmNbyhGWsWdt2qK+HXuZdIZVqZ3mLrM4DCAWhJlwUHydPmtq+tKw
 6dL7OLdmwYnnHIzKsN4nF1pj0JVa60mydORhbU8JfFbmG91e+0QpsYHaXvrJGrW6K+lR
 6YDhdE95vNatKUffMY0lf7SgfuZ6hVgiLQMKU8A230BCjI0XD4AYI/h5Ijgwu4tAsQl4
 BT3bqbAk+2+wU4YH4MByeqmPxQyrM4WxO83jCaqZUFh0yITUHCYITASyUl0Bmr4AmRCk
 d/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RJnkcIquPOFwO8qegqW/YJg1YrDqow8L+C0wncK6ATU=;
 fh=z6j9M87EymxnsgtjPJeI9rpgOf3JYcAq+ll2+QME55o=;
 b=K8Zw2j0ZcH3WyztHugq9lvramg2JRgDRogao/oN1BH6OuL30Li1v3WeeYVna42+izb
 f1x4lR3CcAdK4kr2Ox8J9vwzfg0c+6Yj9zhwpfM5g2oU8vA/bIW1WfwyTL2PqVOIIlWv
 tImSVkD2Q6vlssUuY1/Lz2UDMuZ3y19JlaAC1JXwm2/266K75y9EEN5AvC8oFwuGBN7V
 7DBbTuzlKn3dq/wzVv8W9c+1TZ0tQDy7HkXcmGvcx7ZQtpoc0fzHFg80MuPhx4XR4FDR
 23G72wYvIKU6ezmsvZZqOnysqwVupUXzKZbRaKRBPAVTtGz9QMfnS5LDAJZHIoMwf9pv
 j11A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773248622; x=1773853422; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJnkcIquPOFwO8qegqW/YJg1YrDqow8L+C0wncK6ATU=;
 b=W3CnMoSKklnRqR+iruEfCNj4gyJCi46xf2ry1qhzWlb34kczSrNBdeO6ksGrEgmm7b
 /IjT1P8vhktbYBFNapB3tnH1KoijJmYjDCD7J9OHp2yR7ZdLaOTq0FBTkTwJZ/K7/NbL
 EoTws3uCXRmty23STn6HjZVnQHFZjcwS/ONyFLjr2ROXtaQ9+xIYPxARoAfz831/JW7O
 KSOGcsV9BuOjyTze0ks7t4VfcBM81phLmkaM0cLyzm4yI3ulgmBhqVK8DvVUem5qcDk0
 Cou9KNHSlyoomE5Dzu7wCz1Y+jn6MhaKsvGy9PhaWOdaZIZEGUuvHbr6N+df5Hr69Yx3
 R6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773248622; x=1773853422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RJnkcIquPOFwO8qegqW/YJg1YrDqow8L+C0wncK6ATU=;
 b=I+V+hQ9mo/S7hUW5ZXo3Hpb5dMutAzMajsgEQ3p4w/uSQOQ7gO2F2F46Zl8K9ax92i
 gENz+aAzrAGUcn+eMJNinxVGfnfklt7ikZticBPTatK4b57528GF67sU15nRVLTF/ylU
 sxEGTcK9rGlMIs11vBe4xt5QraHIQAyGBHbLfr1Gl9sYx7hOmoQ+ZzmWuJ3OPbbfKAkd
 xg5xKttUNZfAYS3o7B+Q+stskjTruzOru70BScMWCtjy16TAsMc4CUxK5zeGW6XQMU1c
 qxVTkWmpZ133JCtv27PxQ9b+kJ2jB7qZfqHyiGSG5Qx6JohLzg+qJjncPtBdAXzrbPYH
 hkhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/7JZaO/r/Uqcxtj2ygWfMexArVcVkJ6lArSntc9Z5a0D17YlYuKbq+zri763tP8sM4A532JrTIZZR@nongnu.org
X-Gm-Message-State: AOJu0Yxs/+P3YzYbSgjqC2IR4uYVlS0I2rgC0jQbUY0oiwrp8oZKpcsz
 T5sq88+M7WRnNgJQaMoaty4LWUT0HyYjcjuP9HZL6B00NeW9hpZPR3b54R1jkSs8HagPLpnF6t7
 cvsOHdGqlzF9wAB3a8adokDm44EiogZCgA+cgLSzkgA==
X-Gm-Gg: ATEYQzz6C3/S7o2tnBbMfAQ4/FORkeNnF5y5CJCfS3Q7l64KG8c1gv28wzTaaOC7ONp
 uxPxnoqym+V965jMHPKOKVy07LJclvPAMhKM484pXQ3IIx91MoVyrRZZnHelyWp4a6Cd9BKtaEr
 wj9L3rz2MkUVS3gUNr9hsZZmaFDOdID1tLe/e3I7CU5PHZVKsiHgmcjx0mkJfHeBoyYtePJo0TG
 JWmjWWQRvwvpG2mfcrB60JcfyHatoCl5jOtB/OspPbempBATunpnSBvcduyhNJbcY8x0C2iRw/Q
 +doNUXxjF40bJXZ1o1umTj28ZkRqCkalHc61fygGm0SAgGS2e1UaZKqZzEM7Q1mnvM4=
X-Received: by 2002:a05:690e:d09:b0:64c:ed9e:2e22 with SMTP id
 956f58d0204a3-64d65823d64mr3091544d50.80.1773248621603; Wed, 11 Mar 2026
 10:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260311095405.26297-1-hi@alyssa.is>
In-Reply-To: <20260311095405.26297-1-hi@alyssa.is>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Mar 2026 17:03:30 +0000
X-Gm-Features: AaiRm53fXzB5o-jO-zwjARu-4kwiJI74QwIG80HyHBOohcZT9gDOVcJOmSsF_wg
Message-ID: <CAFEAcA8GCz2c18e3+bwFooAxYZzBrX3OjjQ58CWJOdLfTYL_dA@mail.gmail.com>
Subject: Re: [PATCH] target/arm/kvm: fall back if nested unsupported
To: Alyssa Ross <hi@alyssa.is>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
 Miguel Luis <miguel.luis@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Wed, 11 Mar 2026 at 09:54, Alyssa Ross <hi@alyssa.is> wrote:
>
> If I create a machine with more CPUs than KVM supports, but specify
> multiple accelerator options, QEMU will fall back to the next
> accelerator.  This is great, because if I've explicitly specified
> multiple accelerators, I've told QEMU I'm fine with any of them being
> used to provide the machine I want.
>
> When I create a machine with nested virtualization enabled, though,
> this doesn't happen.  KVM often doesn't support it, but TCG always
> does.  The nice thing to do would be for QEMU to fall back to TCG if
> KVM can't provide, like it does when too many CPUs are requested.
> This patch adjusts the behaviour to do that.
>
> This is very helpful for OS development scripts that run an OS in QEMU
> =E2=80=94 I want everybody to be able to run the script, always with
> virtualization enabled because the OS requires it, but for it to take
> advantage of KVM acceleration when available.
>
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>  hw/arm/virt.c    | 6 ------
>  target/arm/kvm.c | 8 ++++++++
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7456614d05..0b63b2eac3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2372,12 +2372,6 @@ static void machvirt_init(MachineState *machine)
>          exit(1);
>      }
>
> -    if (vms->virt && kvm_enabled() && !kvm_arm_el2_supported()) {
> -        error_report("mach-virt: host kernel KVM does not support provid=
ing "
> -                     "Virtualization extensions to the guest CPU");
> -        exit(1);
> -    }
> -
>      if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled(=
)) {
>          error_report("mach-virt: %s does not support providing "
>                       "Virtualization extensions to the guest CPU",

I think there is a bigger problem here. The code in the virt
board init assumes that the accelerator has already been
selected: based on whether kvm_enabled() or tcg_enabled()
it decides things like which GIC version can be used, whether
"-machine gic-version=3Dhost" is valid or not, and so on.

This bit we're deleting here is just one of multiple checks
we do that assume that we know the accelerator already. If
we actually don't know if we're going to be using TCG or KVM
then all this code needs to be rethought.

Paolo, can you unqueue this for a bit while we think about it?

thanks
-- PMM

