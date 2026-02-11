Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E679E9E31B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCNY-00054L-CV; Wed, 11 Feb 2026 10:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqCNX-00052t-9z
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:43:47 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqCNV-0001dk-Qj
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:43:47 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-790884840baso66241907b3.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 07:43:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770824624; cv=none;
 d=google.com; s=arc-20240605;
 b=KSbyDRxx5aYN6RHy+OOlC6WsiAL3Ro/pOF24+gPOQxZWxu9RFSFVpslaHt6EJSb6K/
 gakFkn31lXRVQShe99b12jBcCQCLwSL4JR1XxCYIrocjFEs5kbZscKcsFZ/fVCRq2pNg
 CxtgCl/xHQS++X/BbmZMdiiBs6lgEtNL8tr8hre03qU679DbhMFqA5/2MpE35OVn0dxn
 UbGe6jeXvrQQWdElbUARZoRIIb70wbuM5oiF77gsuP6N55V0wrRXzU6CQ/y/l+b+Tyiq
 TKCWZ6PMfPBiK946XqqzPjiO5ONR/54VG1O0xWTgZJXC+A4YvECf/IHCE6gPPzxXBqRX
 BDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Cwx4TMtV0+2MBlJylAWyBlGUsmVcRjrhOwzbBX1NFZs=;
 fh=wDPrO862J/o14wSOl/ZfXuBCnESuGxKC3mZZOO/MpJI=;
 b=jYtII+76pjccIy1nBxV3iXJOn7ugUwSSv6+WGWWb3feK8AJ0pafC0TLjXH1OVHcboY
 zgRCDPc44WUuaH5BtNDyZlOKcfAOZpST2mCFafKOnhzrz+NMrbI9DkZfxToTtwVLoRFe
 ypg0EX1pfOqTBCwFUJUNKXaH2vzK2LQzzl2MgFG3ik/fy3qbpT0OtXmwjXxiXM3u+y4F
 wOvkpn2svbMzOQFUojvp6OD/p7rkP+ebhJ9aB5xev6ovp7TlA9SpSRz4v6AmmAFdZJPf
 rfr0/ZHaVurRpEEbLB/QtSqVXbDo7Bto/oYHv5Q783965b4uhjG4jBthoUPfsqnqxp0M
 BnjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770824624; x=1771429424; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cwx4TMtV0+2MBlJylAWyBlGUsmVcRjrhOwzbBX1NFZs=;
 b=J+go+BYiUlEfq5lvKDJRYMwEuOqYkQA471J+L+Vaa8w+vwstKbRS/+q+TMQdiy27wE
 hYFNTAKX/FJfqDHQH3Z/2uIkrBA4J4VAo+BGKoxxIy1HAiqeSBZI5um30G3uKf+abF4o
 r9DLDc2HYFW/6yg0CQgPv+gCScUUE6cPg6yKQnPPoo6sfcX2SVkLilNWG8Hkytu60llQ
 AnD8UIB6s1YyZaC1j3lIEwDl7SP+7Ek2QbexteHacEoT0J80MKLFnOUyRNcoOZEgqN2X
 73MKG54KqTsiMjU6eoEewDFXt5KfbYjh31brG5FxIUfUkCpRkfiSOLBdxY3K4Y7RPBrZ
 e/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770824624; x=1771429424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cwx4TMtV0+2MBlJylAWyBlGUsmVcRjrhOwzbBX1NFZs=;
 b=QQnPTuz3ufMazYxzoX573PbtFnCaccEkA+ZpA6RHv+OKmT0avhaHBbIMErlk5ov7sL
 U7CS3mVzYHSfpcxsYGiC1/pzZ0T+FXilFLMGg0+xFYZzW1yIvupQOUuan/INLzqnUFvz
 ekyXYkIIc+AJEQlmf+KvpQvVGEwrbEM6IXlFGo70c/NXHJ5QV0kBY4S8kZl2+xb8kxbT
 GPKskihJvPPPRt244w4la8PSH503SRz/zSQcPevg+adoLVXbiR3hejsn1AzN64BPK7wa
 +hjkROAVzgdR7UQ+F92jN32W2f+x0UUfzRj9Pz5q7zv+/YMWmTskIibHJc7xcU92vvIY
 aRTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9SgA1oZjeoHfx5PGdArGFmwewRNF3jG5pkt9+LgqzLVLoIuGcF2MO0ubWN2pyY5uNz6GLG11icb3e@nongnu.org
X-Gm-Message-State: AOJu0Yy66o64dROotfhh9a16woXaFbYzS9uc6bMbhvyxYCK3yMuhe+tA
 BxAeQAI9M381EZrdil/iJ14o83VRPaWMAVqjgyLgEjMLNLhuR/GboCyK5wi4POyOVSIZpELr8QZ
 9E2Kxe5nA0v3mIIqs4jZykQdD5ByOrk0Jp2de5Kvyyw==
X-Gm-Gg: AZuq6aLlTdk0A5iuruOXxIDtJNA4RrQXA5FSckAA/82YuNdRwQmFOmFC+weDVfUSwWq
 FjuCnX/P0kTinr19AgOAx/2W/tJPS3TeVlqRGYvexC5g8iOsUcH2nEYqG+C9iUd0SPkpuiqgc9M
 rEN9xLp0EZee94mJFDubLdVD51yq+X7eXnWCPpLOs/y4I+JME2jnBFSn5hF3KCA7Msu3/tVwiyD
 moFMEWWAGgir+rRspFd/en7nzxTfRnHdn6fJ+yLkX6l7kjI9x4+ylu3UztZRTCzLiSbgUB7aXXp
 /1lNYOUs5Q25ccpi6FnNhaAqI3OaSAy6RjDnSY4HhLlTs5bI+fIFyTLjAVCIVkirefs=
X-Received: by 2002:a05:690c:6006:b0:796:2ee6:3f87 with SMTP id
 00721157ae682-7965f08a3a8mr55352367b3.67.1770824624573; Wed, 11 Feb 2026
 07:43:44 -0800 (PST)
MIME-Version: 1.0
References: <20251202160853.22560-1-sebott@redhat.com>
 <20251202160853.22560-3-sebott@redhat.com>
 <CAFEAcA8oi1Xs2kv66dFV9NZore+Q2vHUsgMikveVdN1c+3SBJQ@mail.gmail.com>
 <9b04a20f-b708-208d-1e4e-466ec30b7bb9@redhat.com>
In-Reply-To: <9b04a20f-b708-208d-1e4e-466ec30b7bb9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Feb 2026 15:43:32 +0000
X-Gm-Features: AZwV_QhbMQtjgAAFsQMaNKMcmBgssEikN0rK-YFZ8G0l_cRA-hB9h8zVvJqu3SM
Message-ID: <CAFEAcA-A+zW=QFdCY7z==+Z=xXfhJvPeyHhbG_MpEmpkQfrmaw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] target/arm/kvm: add kvm-psci-version vcpu property
To: Sebastian Ott <sebott@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Wed, 11 Feb 2026 at 15:37, Sebastian Ott <sebott@redhat.com> wrote:
>
> Hi Peter,
>
> On Fri, 6 Feb 2026, Peter Maydell wrote:
> > On Tue, 2 Dec 2025 at 16:09, Sebastian Ott <sebott@redhat.com> wrote:

> >> +static char *kvm_get_psci_version(Object *obj, Error **errp)
> >> +{
> >> +    ARMCPU *cpu = ARM_CPU(obj);
> >> +    const struct psci_version *ver;
> >> +
> >> +    for (ver = psci_versions; ver->number != -1; ver++) {
> [...]
> >> +        if (ver->number == cpu->psci_version)
> >> +            return g_strdup(ver->str);
> >> +    }
> >> +
> >> +    return g_strdup_printf("Unknown PSCI-version: %x", cpu->psci_version);
> >
> > Is this ever possible?
>
> Hm, not sure actually - what if there's a new kernel/qemu implementing
> psci version 1.4 and then you migrate to a qemu that doesn't know about
> 1.4?

Oh, I see -- we're reporting back cpu->psci_version here, which
indeed could be the value set by KVM. I misread and assumed
this was just reading back the field that the setter sets,
which is kvm_prop_psci_version (and which I think will only
be set via the setter and so isn't ever a value the setter
doesn't know about).

That does flag up a bug in this patch, though: if I set
a QOM property via the setter function and then read its
value via the getter function I ought to get back what
I just wrote.

thanks
-- PMM

