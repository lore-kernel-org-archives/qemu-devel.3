Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CECCAC5AA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1huu-0005mL-T0; Thu, 25 Sep 2025 05:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1hum-0005iu-9w
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:05:25 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1huZ-0007Yu-Fn
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:05:19 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-ea5c1e394a8so576116276.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 02:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758791104; x=1759395904; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h66SD38oB0dkdG6b7wl+RTVHaMu+AZzeyIwTgD60NQY=;
 b=firjYk+tBxlfNyDD0DjzPImBbSljp8ICB+BEvpTW4lJpDnL1tswjiSLW0NaKGUeWba
 cEc5R55SJRHPUqOb4tU0leLDuJlJJFOQrelUwGT4hrfcyxho8/1QEgowquK1Lp+ysJwt
 EIWqhaL43xLQk9rDqZPqh0xwGd+M5IuesmvZdPMqmNSWnnYgJdp0dUC4Js9KNTYSQEDH
 t7pJvYJB2MZtny3G1X4WUXaUvIMfDcIEOv6qI3Qf9222+qFnwnguYjn+yMeSo+TrTfiV
 zPU870ob2sAdz19xf2yg7PD8Njf5VEXwdFF0MRrxdXARKOVG3MhnYoKk2dPWK4bvL2Bz
 hGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758791104; x=1759395904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h66SD38oB0dkdG6b7wl+RTVHaMu+AZzeyIwTgD60NQY=;
 b=e+juUgiOhIAQrAr5tQNSlbxGrRLXr+znJQw/ghsc96rLXThRH68WZlXLrOStjew+BN
 zHeU+T0JKn8f5UMmwI76EJQ9MTbqkYPfzy3cq9v2CeQgcqUXQaSVuu2fCrF/e6nfLdlH
 /+96fVDWXmQuY5pnnix7kt8Hf0wpI8aNVQgNCOPp6FZWhlQWY3jO9cy/li4ONL9Xk55l
 fdE3YIxMcJB6GMJBxQ7raT/zaPreIpWC2WGVhIqhC34sNmo19PcD6pztEvYV1KJ5y+l0
 xOmxmffZQpnNlrOyHz3yOmFOHrgqHhT9/gDs8wDtSq0rFWP/wmAH9tByiYhMYN/E4pDC
 ticg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjvakDhfhpCVbe17+XSKkK2WB1+P7HtJae+hN4q/hZTYwrw8uNpreZnIvWcefFkhLufB8QF6xjzddW@nongnu.org
X-Gm-Message-State: AOJu0Yz7HU9yWwdLRV5LfN7bOMDJV2lTxlHLhsi+Iaar0NqQrl/tCEc2
 R5SAhyckqJCFkdI18Kp1w9786YWNVlnIX6bIzr+ww1h5ReyZJU1zzPXTE+ydmzWJELLrQcAlUyu
 w6kF6JgfTwUohQmlxC/Phrjco2n3RVP0dpB8FnXlzvA==
X-Gm-Gg: ASbGncs4+EDpiqrPfOmupb0ztWIez6pjRALanFTfP+/DVizSUf3a7qSv44OfO8IJrmr
 gMLxfOK8yg05cRlcSh/Po1z2CDOVMbBMg+PtYn1x9XwsMRSaWwiuR23PaaA/9J4D9Pob1xdCo/o
 Xz689sRMnuNdxrG3I3THFL15hWRnfGvfv4QovrE4SzSBfIQVsTI4owSgIzfOfX4IKF/iodiBPHS
 wytcHih
X-Google-Smtp-Source: AGHT+IHYNUqY1w1yxAZxY4JZ9sPSoi7auwgEpfyi/Lh/lwTLsuTWVD729wWkDDlFVnmqweBQjqjzOqJg5kHjrJkKPaM=
X-Received: by 2002:a05:6902:6087:b0:e9d:6ab4:92ee with SMTP id
 3f1490d57ef6-eb37fbf35b5mr2111313276.3.1758791103951; Thu, 25 Sep 2025
 02:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <aL7xrilR-gyByKEM@redhat.com>
 <CAFEAcA_wt3HwDq=sJ+VuLdx_RFFwB6E9FjrbT1zgNXGGvfQ9YA@mail.gmail.com>
 <B5215A1D-C8F5-44FD-B19B-70D78B7FD4F5@gmail.com>
In-Reply-To: <B5215A1D-C8F5-44FD-B19B-70D78B7FD4F5@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 10:04:52 +0100
X-Gm-Features: AS18NWCn8mDla7U_Kyce7k8yJErhdL74rOpNdo2vQ92dRbfrJwVI-oZSfIe9xaM
Message-ID: <CAFEAcA8s2xSYpdJne5eZ-jrFfOcQeRff-wjRe2mqGwzffguCGg@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/system/security: Restrict "virtualization use
 case" to specific machines
To: Bernhard Beschow <shentey@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org, 
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wed, 24 Sept 2025 at 19:23, Bernhard Beschow <shentey@gmail.com> wrote:
>
>
>
> Am 8. September 2025 15:15:43 UTC schrieb Peter Maydell <peter.maydell@li=
naro.org>:
> >On Mon, 8 Sept 2025 at 16:09, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> >>
> >> On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:
> >> > Currently our security policy defines a "virtualization use case"
> >> > where we consider bugs to be security issues, and a
> >> > "non-virtualization use case" where we do not make any security
> >> > guarantees and don't consider bugs to be security issues.
> >> >
> >> > The rationale for this split is that much code in QEMU is older and
> >> > was not written with malicious guests in mind, and we don't have the
> >> > resources to audit, fix and defend it.  So instead we inform users
> >> > about what the can in practice rely on as a security barrier, and
> >> > what they can't.
> >> >
> >> > We don't currently restrict the "virtualization use case" to any
> >> > particular set of machine types.  This means that we have effectivel=
y
> >> > barred ourselves from adding KVM support to any machine type that we
> >> > don't want to put into the "bugs are security issues" category, even
> >> > if it would be useful for users to be able to get better performance
> >> > with a trusted guest by enabling KVM. This seems an unnecessary
> >> > restriction, and in practice the set of machine types it makes
> >> > sense to use for untrusted-guest virtualization is quite small.
> >> >
> >> > Specifically, we would like to be able to enable the use of
> >> > KVM with the imx8 development board machine types, but we don't
> >> > want to commit ourselves to having to support those SoC models
> >> > and device models as part of QEMU's security boundary:
> >> > https://lore.kernel.org/qemu-devel/20250629204851.1778-3-shentey@gma=
il.com/
> >> >
> >> > This patch updates the security policy to explicitly list the
> >> > machine types we consider to be useful for the "virtualization
> >> > use case".
> >> >
> >> > This is an RFC partly to see if we have consensus that this change
> >> > makes sense, and partly because I was only able to identify the
> >> > machine types we want to cover for some of our target architectures.
> >> > If maintainers for the other architectures could clarify which
> >> > machine types work with KVM that would be helpful.
> >>
> >> The split of "virtualization" vs "non-virtualization" use case
> >> in the docs was always as rather a crude hack.
> >>
> >> "Virtualization uses cases" was more or less a code phrase to
> >> mean "the subset of QEMU that we traditionally shipped in RHEL"
> >> as that is approximately what we have reasonable confidence
> >> about.
> >>
> >> Personally I wouldn't assign strict equivalence between "machine
> >> can use KVM" and  "virtualization use case".
> >
> >I agree, but this is effectively what our docs are currently doing,
> >and what I'm trying to decouple with this patch...
>
> Ping
>
> Anything left to discuss?


This got derailed by proposals to encode the security
status of devices etc actually in code.

Personally I would prefer us to just update the documentation
as a start, rather than blocking this on designing and
implementing the code-based approach.

-- PMM

