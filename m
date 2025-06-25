Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0EEC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 10:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUN9H-00052R-RU; Wed, 25 Jun 2025 06:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uUN9G-000527-2J
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 06:14:34 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uUN9C-00028p-Vu
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 06:14:33 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-711756ae8c9so13114857b3.3
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 03:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750846468; x=1751451268; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WHpZf1BrPFAlqXFuHdOtTQ7ioXief2ue4zEdYR2QIM4=;
 b=Rm2UhVH6cjuVWCA6+RiDmcUe3HpylqMIf3DZN1TB1dXzTEX8zeaFpBNK1xM3QRX8J+
 mEN0SL+ngeeAQVv6JuIzUMyumPxIoiHdgjzNMe5ga/uR5dIGXFC7OTJeQGEdAZWQ7AKK
 SPlf75j5lHclJY2PJitc6yqOdgNpG/c0xeOPhYLqtISq4k+iXnJO0PAzpZ7gkdUR9dys
 f/Ld5F0hc2V+36P33QQnRfUNjf56g51fDds6qRlfxbVfZvMYkiJS+ATCcb+vnPvXnLla
 zboEY5L3O3yJqE1KZBzdNOEVJEAE2fhgJZtiG4xFNjA/Ztnlx71joJJFLIduXfrHgFUS
 Q6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750846468; x=1751451268;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WHpZf1BrPFAlqXFuHdOtTQ7ioXief2ue4zEdYR2QIM4=;
 b=CxKTvq0fxhvm/xeAI0p1zz7C1LEqr9rpKO8F/Nvwky7Rf7iHzfbiIVytV4Ka4kwADY
 dgChz16PVPEnrgZlbAfi441qHTJmgOyu6hEqhysag8R2ncMRlZAFMZeGDTvD9fieCYUK
 Sk37q/BrUpwb/7fxHuEXViqi0KAfu2oU/B1Zff1tcAFD5BlFDoG5e0gdoIJ6M3UdI9i7
 w7BQlmpTei2IbxU4qaY2+3iz3zZfUdVKaAf14Zcb9wXGPjMs1LVOT4G9TdHKmvzUdAES
 hk5lLWJfgXaqpSqLVOn4AB0ukwIZfftZL0a7NW2+HYjkKIZtuCZ6gRRt07HkTfbvkwHY
 NrIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4mpvljsC66bgK1m4lbiNM4Px0bB98B1PxDaBj/HdERIb456Bsvew+6TDIjhJwhRQ6ti1iJFSbO6kw@nongnu.org
X-Gm-Message-State: AOJu0Yyol1KLE7yFXdfzEyfKXNchfAglbjLAwboGD7rqmsXKqStSRxeL
 vftTAHMQcPMqYCy/lsoQTReWJWUZSle+uqAFCe65GRVMeyddkqj2ovAFlD8SX1S9Oq/3UC/mg+R
 9PS8Nr3G+TRInGu2aCNCf7b6pgGCx+Sl51xuoc9u5eg==
X-Gm-Gg: ASbGncvf1nvK3kKicxEu6cX0ofzAK9B4TLaBPeuhEuDylQyR3jR9MrpAh91jD0mN+R/
 9V6b6aEKYqjly4R9JqIXWNbRn6mcXKTT+v2+1Wuu6q61QfBA8e5ylhvSSbZEUaFkwSK3O/tIQJs
 9VZj+AQ1x5GNP2A0c720AzJg2Paw8a9PZfH/T0vRWXDRXZ
X-Google-Smtp-Source: AGHT+IE1SVnC+PVyHxDE/ir8P+FbDaCZU32E1YBr9BGc5xKyUSgOrtzXwikzEk8hRx34R5EMJ5iKsQAo35GChbuPeag=
X-Received: by 2002:a05:690c:3682:b0:6fb:1c5a:80ea with SMTP id
 00721157ae682-71406dd8d3dmr34791687b3.32.1750846468296; Wed, 25 Jun 2025
 03:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250617153931.1330449-1-cohuck@redhat.com>
 <05e903b3-02bf-4c04-ac2b-cdec0b45fe3f@redhat.com>
In-Reply-To: <05e903b3-02bf-4c04-ac2b-cdec0b45fe3f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Jun 2025 11:14:17 +0100
X-Gm-Features: AX0GCFvttrY59WLT4gA3ZgqOqf9rMqxv_AGCgjo_0gmHPt678YKqjDvK8cpzp6o
Message-ID: <CAFEAcA95vCKpk1wXQh49xAWnqY=JZnKdr8NEQuYaRJr=jrKWyA@mail.gmail.com>
Subject: Re: [PATCH v8 00/14] arm: rework id register storage
To: eric.auger@redhat.com
Cc: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org, 
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev, 
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com, 
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Wed, 25 Jun 2025 at 10:10, Eric Auger <eric.auger@redhat.com> wrote:
> However there are other checkpatch errors besides the one you reported, in
> 52873a54ad arm/cpu: Store aa64isar0/aa64zfr0 into the idregs arrays
> ERROR: line over 90 characters
> #388: FILE: target/arm/kvm.c:225:
> +    return ARM64_SYS_REG((sysreg & CP_REG_ARM64_SYSREG_OP0_MASK) >>
> CP_REG_ARM64_SYSREG_OP0_SHIFT,
>
> ERROR: line over 90 characters
> #389: FILE: target/arm/kvm.c:226:
> +                         (sysreg & CP_REG_ARM64_SYSREG_OP1_MASK) >>
> CP_REG_ARM64_SYSREG_OP1_SHIFT,
>
> ERROR: line over 90 characters
> #390: FILE: target/arm/kvm.c:227:
> +                         (sysreg & CP_REG_ARM64_SYSREG_CRN_MASK) >>
> CP_REG_ARM64_SYSREG_CRN_SHIFT,
>
> ERROR: line over 90 characters
> #391: FILE: target/arm/kvm.c:228:
> +                         (sysreg & CP_REG_ARM64_SYSREG_CRM_MASK) >>
> CP_REG_ARM64_SYSREG_CRM_SHIFT,
>
> ERROR: line over 90 characters
> #392: FILE: target/arm/kvm.c:229:
> +                         (sysreg & CP_REG_ARM64_SYSREG_OP2_MASK) >>
> CP_REG_ARM64_SYSREG_OP2_SHIFT);
>
> WARNING: line over 80 characters
> #396: FILE: target/arm/kvm.c:233:
> +static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
> ARMIDRegisterIdx index)

The last one of those is probably easily fixed, but note the general
remark in style.rst that it's better to have an overlong line than
one with an awkward and unreadable wrapping. (We ought to fix
checkpatch and style.rst to agree on whether to warn or error and
whether that should be at 90 chars or 100 chars, but that would require
reopening an old style argument and it's too much effort.)

> 5f15ebdf3f arm/cpu: Add sysreg definitions in cpu-sysregs.h
> ERROR: Macros with complex values should be enclosed in parenthesis
> #56: FILE: target/arm/cpu-sysregs.h:21:
> +#define DEF(NAME, OP0, OP1, CRN, CRM, OP2) NAME##_IDX,
>
> ERROR: Macros with complex values should be enclosed in parenthesis
> #64: FILE: target/arm/cpu-sysregs.h:29:
> +#define DEF(NAME, OP0, OP1, CRN, CRM, OP2) \
> +    SYS_##NAME = ENCODE_ID_REG(OP0, OP1, CRN, CRM, OP2),
>
> ERROR: Macros with complex values should be enclosed in parenthesis
> #203: FILE: target/arm/cpu64.c:40:
> +#define DEF(NAME, OP0, OP1, CRN, CRM, OP2)      \
> +    [NAME##_IDX] = SYS_##NAME,

This is checkpatch not being able to cope with more complex
uses of the preprocessor; the warning only makes sense for
"acts like a function" macros.

-- PMM

