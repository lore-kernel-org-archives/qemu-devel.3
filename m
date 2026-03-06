Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8481BF01827
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 11:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyT8H-0001ge-De; Fri, 06 Mar 2026 06:14:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyT8F-0001fj-IH
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 06:14:11 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyT8D-0006jO-Qh
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 06:14:11 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64ca2b32f46so6875059d50.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 03:14:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772795649; cv=none;
 d=google.com; s=arc-20240605;
 b=I/01pRugBR7c0vnIKFtMvOaoroCuwV1zlXaXvCqwnRj6MDcEz4rskZ3yyBxWVtdVdp
 Y0RguBLPY5NldOJone03HbzSmYXabDwg4BMGwMJxnc2lVXXjbTOECbfYjVXJ4YzPuee8
 DQH/I05my34A1lag2AHaxlX/udO1Wvda6O/gJDcMU4JFRuneVi/7GTM+sRh3n29Qh04L
 WWgBf3PU3YoEC3mizkZBsXGTgyMAgysbzwCcYP30mE0yZnXO/3sFUcNNSb2j+xtBkNFg
 hPfkTj5BviztUkYDvX7nD/dcvGArEnEasUQgKeIhnkOXjxtnXuKj7Uet7gyICZzG9EOV
 zXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U28BL5+lwC9NiM/UwqkBnc3U9ps/l6bCSJUVodsJko8=;
 fh=ZPpeIskpfOPTs/VPKapufuAmIzFLAn4M+I4pBsqFnGw=;
 b=YyPijCEsSnkGM7bxXXlF96xBEob71jkqEVmDLYc6wSEgHh8iIEKCuf1BUdIHiwKIgP
 OG3JC6GMfMYdY+NYc5HK5g+C96LM4lzmlrKgtlXjch8OdPal1ooFhV40SQAmBZIBnl2X
 7b3miKLeD3ZwQjjwXYI/+axlEofrv0Cl5qIp+wajHOfMofKC8oZFPhVaQx7yej/zkWXk
 SpInfzIqq9ODqf1sSkt/wUGxcQHwTQaL4UoihsN1LjwrboWViDL14uLVRmTfcL3jGqI9
 tjV6sx7bvzEyouy0vdJhEsQ3w+wKvW59KQHvAiDpjjDQVGgbU2NW0WvGv5PuDCCo6b7j
 Ilvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772795649; x=1773400449; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U28BL5+lwC9NiM/UwqkBnc3U9ps/l6bCSJUVodsJko8=;
 b=PqM5Ce0HROqSsC4QiLfY2Pf3AQn4RzrV4+RVb6e+fnfyUd3kQceCjo9NEUqCh7FLv2
 C6Dnc8i8uev9KgDmoxkooWLg9zBDjV/6AFT/v7x7OwchXPL09C3Fd27JGQEWyAQu+Yn5
 muu46vFNP2vBynnnpp399wB6h2K7gflrcQQKnrtrQZReiLbBycu1xNtnDPHD5CM4tPf8
 URoFPi07g6eiamTQw0gBJML8McVnJkPgVIw6H89LaJCPBwDEcJE6T2s+j8150Mq6Ykxx
 +kcx88BQMhaq2WkQnzk39SPPYDDMVlOV3y+Jdkzw3SDopHBt6rEPn8+fkR9kGwpBAbGj
 9mxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772795649; x=1773400449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U28BL5+lwC9NiM/UwqkBnc3U9ps/l6bCSJUVodsJko8=;
 b=B2wpy4ZCZo7s7gjElJ22Zdu1cPjH3B7yfADMrw/b4qx4m44VQHSpukvcVPWmG0ckPv
 kicBb24z/Iu70aNVyqiNpki0kRa+jCskEGEQOJIPRTAD/25WUrbzdPfGf+MHX2rqRqWE
 alpmUZxVk3byEer6Hz44cFcg5ROD9PR+8HS0l707mtQHIq5qQJVvQ0vof5EizUt65FOj
 pXCNSPXzOs8oofcpyzfnhPxx1je7t6Xd1Qd0uTM48l7whci4tk0arF2ZpRPJY/cDb7m4
 5IPa0JVdNHgsWyhPYdPqgunG+2viRafkbuUQYPzOsMToc1SrMG+oWCJlfpbM6wyg6gCE
 cOYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmjewVldB/RBhcLAISqNsF6JBqo1Q4u1R7QFK4V4oAc/HL8oPXeDcfA8JzIqVk+yF0GFzkgMqt2PGx@nongnu.org
X-Gm-Message-State: AOJu0YwE7ac4cU8Yl4lLJhp/uJZRExloYocFmiZO2dHN0s4o2URN/bsY
 K0iSWLZRMbxMpHrYe+PRDSEDk1e9QK5ufP+z7L/czuJfvy7YY2iFeZxM9qeXvrtVQFsFu4+CHpn
 2v8SqJL/C778WIMdeErEXPZv6hQTDSr0dzt1YmqDUDA==
X-Gm-Gg: ATEYQzwYnxQFH1Q6USMc+jml1n0SHNXjKFYhRJo3pbgb5no9x8mfBKjZ6br/4frmA7f
 TIplvE7uLbZy4FDRcX+t/xf7oQucWmnHSh+Lx2MPLuoJmryIbtf01Vn8T8Ne4+UosXj4Ytf8o7+
 YlZrBowXMqOwN9jX1wzKes1QEz3qdxtCHh6bpwmyhE/d4958X3A/Hdo/IIkdCx3dK9qVVuB6RZv
 SvyS6BtfSYd7ifxBesXbHSbQcDjmT07xeUoD2wcfptkAJY+XrSb5gvTHT9mLnzX31/dDglr3p0S
 tx3SwxcUwQWthbnLChKiRjenOUBxUio5ea51zC6tBw5Z8+sooUPpogm7vQ3CTdAiJrQ=
X-Received: by 2002:a53:e198:0:b0:64c:c1b6:7150 with SMTP id
 956f58d0204a3-64d1429ae1dmr1122960d50.46.1772795648662; Fri, 06 Mar 2026
 03:14:08 -0800 (PST)
MIME-Version: 1.0
References: <20260303-sme2-hvf-v6-0-b473702d8287@linaro.org>
 <20260303-sme2-hvf-v6-1-b473702d8287@linaro.org>
 <CAFEAcA8zTkc4pyHQKoDkTMhGPLQmxBaJS3bZiGRrPgux3rDLzw@mail.gmail.com>
 <CAAjaMXbXdrW9N1xLMPxL9OmjLqti6A3rqAmYipu6OkdBY8JPNQ@mail.gmail.com>
 <CAFEAcA_MuZH8d=Z=NfrNQ78k+Kv9mSx+=DLLt8AxZeEjccN8yw@mail.gmail.com>
 <CAAjaMXbq9A1NCO4jnF4aSL0XM2pzHsPsPyWfmqSCg_+2ZQpEHA@mail.gmail.com>
 <35FDE44D-63E2-426E-912C-6EB6CDA52116@unpredictable.fr>
In-Reply-To: <35FDE44D-63E2-426E-912C-6EB6CDA52116@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 11:13:56 +0000
X-Gm-Features: AaiRm52iM5T4V2oISvd27EDnJFJCO1yOBP6XZR7gYjkP1eVqqHBisLwM6om8dYw
Message-ID: <CAFEAcA-Zgq43KW9EC-pteOqxHcZg==GE=1TAURZP-DGRh3OoHQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] hvf/arm: handle FEAT_SME2 migration
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Fri, 6 Mar 2026 at 10:19, Mohamed Mediouni <mohamed@unpredictable.fr> wr=
ote:
> > On 6. Mar 2026, at 11:05, Manos Pitsidianakis <manos.pitsidianakis@lina=
ro.org> wrote:
> >
> > On Fri, Mar 6, 2026 at 11:48=E2=80=AFAM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> >> While you're retesting, could you also look at / test patches
> >> 17 and 18 in Mohamed's series
> >> https://lore.kernel.org/qemu-devel/20260306083113.74177-18-mohamed@unp=
redictable.fr/T/#m2d1e3dfbfa5aecd41af6c0aa9e3b574a72c6f04d
> >>
> >> ?
> >>
> >> They look to me like bugfixes that we should be squashing/including
> >> in the "enable SME2 for hvf" handling.
> >
> > Had a quick look, 17 seems to be nested-virt specific so not a bugfix
> > if nested-virt was not already supported in the first place, right?
>
> Hello,
>
> This part isn=E2=80=99t:
>
> @@ -1370,16 +1373,22 @@ int hvf_arch_init_vcpu(CPUState *cpu)
> arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
> }
> }
> - if (__builtin_available(macOS 15.2, *)) {
> - for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
> - hv_sys_reg_t hvf_id =3D hvf_sreg_list_sme2[i].sreg;
> - uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
> - uint32_t key =3D kvm_to_cpreg_id(kvm_id);
> - const ARMCPRegInfo *ri =3D get_arm_cp_reginfo(arm_cpu->cp_regs, key);
> -
> - if (ri) {
> - assert(!(ri->type & ARM_CP_NO_RAW));
> - arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
> + if (hvf_arm_sme2_supported()) {
> + /*
> + * Clang doesn't allow us to combine the two checks together.
> + * -Wunsupported-availability-guard
> + */
> + if (__builtin_available(macOS 15.2, *)) {
> + for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
> + hv_sys_reg_t hvf_id =3D hvf_sreg_list_sme2[i].sreg;
> + uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
> + uint32_t key =3D kvm_to_cpreg_id(kvm_id);
> + const ARMCPRegInfo *ri =3D get_arm_cp_reginfo(arm_cpu->cp_regs, key);
> +
> + if (ri) {
> + assert(!(ri->type & ARM_CP_NO_RAW));
> + arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
> + }
> }

Yes; the patch is doing two things and really ought to be two patches,
so we can put the bit that we need for "make SME2 hvf work correctly"
before the "enable SME2 HVF" patch, and the bit that is nested-virt
specific in the nested-virt patches.

thanks
-- PMM

