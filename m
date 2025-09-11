Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB42CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwjlD-0001s4-NE; Thu, 11 Sep 2025 12:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwjkr-0001a0-7R
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:02:41 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwjkm-0005VK-RU
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:02:36 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71d60501806so6466867b3.2
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 09:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757606550; x=1758211350; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7dRGjVVwpjU1/n+vvstizJLUX8chlCa0TZSJ83N8d/Y=;
 b=bYqQx48aVb8wKkqnke1773eFpc/NVszQfKqkG/7I7AxSIqiq5qHAIcY/qV3QRRTkZ4
 yCiSUM+WQLFx7f1S5pUpRP9F5NP1PFhaePZXhjIp/+nGTuYvW+nJhzdPX8Tuci0JmCIK
 aggtsdw7yiPGfmxB/MmvmfBGcS4N8PJJDBap0sc+rj5afdn+EBYbC3H9hIqgEwPukdO9
 hcSGSR4cSggEpkaTjKW+biuks+10f1NbLSwI03yI2JrU8xqUVUZMYevila15I/gA2a0A
 W8+z+FCzxouJHnzmXblg5wQFRWUTKf+4f6iw1fGZXHvum4Vk/Z960x/3tMnjUrH1vVsL
 wqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757606550; x=1758211350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7dRGjVVwpjU1/n+vvstizJLUX8chlCa0TZSJ83N8d/Y=;
 b=s9YFMZNPv9I63sIsBshue22m+DEzUcg9rWdYmvQ/ouNqjnR3Sf7wlnX2NDCyKtv5xM
 jsjH4nI00UiIH4Eq1HYNSAXQ/BbXFVQ0/TDUtO+i2f34Bkc2yvFRvS4xqSmhCTAOdwim
 VMme1LVr6mdQn9SnabNIGHteeSzrd+LHLRsxg9BSTx6qFv+LSQkJ7Ipr57vuTYRACYbh
 NXVExpZipcwaoWccBm9vNpBehp6USNTb+rwzORwKOzkrLRqxb59VkltgFrAVUBNKHmCz
 WZpo0l/AuT2cMnZX2guPiKienCcd7kxgez1LFXAXRO6Db2ZT4twH8S3nVEoecyma8Cmc
 QFPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEfY4xOvx+RObRpVxe6bRAVJcU9GLWEg4eYqsFzs7S0j4y2hjxXijftb8Z6LTCX8oyUJtiC4coVKN7@nongnu.org
X-Gm-Message-State: AOJu0Yw8hD4SJ4k1t/TmgQp110DQhQ5u+OI5zQguj9kLq8t+Ia6RV2wm
 06XuHiQvMI82jJay8dT6fvbBIyWYxcxuLBgibNUgMG1IRjV5uBJ6fiGyg9Bd07Is4E+L9x1Bh1V
 +e7tAMkY6am99mB+eoL9Q5Hpvugbp5clT+KHqD/MAsQ==
X-Gm-Gg: ASbGnctA8jNAQVHbREKRgZ6C+mKrVzah9IlvXWeTVm/97glP1jpqmNeumXSbEO7Plrh
 31dVajS7NhuNP3UlT+gQ7J76Hjxmq3hQqT2yJ2HKN89azfCO3pbdGnneiyctbcZkbde19ijimed
 o8uWyhCB8Y0mZjfJs1KNw07GtcKA9fR+S1xWZ1YKnpuN+MuXakrvAIfgD/evENNmmKcTaBBOWFh
 Leo6Ieo
X-Google-Smtp-Source: AGHT+IEcRWg0Ibv9La+c1AHa5/EwzBNdLFmIeSpsqfPLBULrqQYCnbKIvwEz11pcW5Z0PxHmVsBAk1FKJbGhiL4pVXI=
X-Received: by 2002:a05:690c:e1a:b0:721:1649:b070 with SMTP id
 00721157ae682-727f5648a22mr172576627b3.44.1757606549654; Thu, 11 Sep 2025
 09:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250911144923.24259-1-sebott@redhat.com>
 <CAFEAcA8EDJT1+ayyWNsfdOvNoGzczzWV-JSyiP1c1jbxmcBshQ@mail.gmail.com>
 <8bca09f1-48fe-0868-f82f-cdb0362699e1@redhat.com>
In-Reply-To: <8bca09f1-48fe-0868-f82f-cdb0362699e1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Sep 2025 17:02:17 +0100
X-Gm-Features: Ac12FXx96W2Z904Fh96vP6TMP44uauq6yyDdA3EE2iGnUzJEwgpWwDS7kISm_EE
Message-ID: <CAFEAcA8hUiQkYsyLOHFQqexzY3u4ZZZBXvi+DuueExGdJi_HVQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm: add kvm-psci-version vcpu property
To: Sebastian Ott <sebott@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 11 Sept 2025 at 16:59, Sebastian Ott <sebott@redhat.com> wrote:
>
> On Thu, 11 Sep 2025, Peter Maydell wrote:
> > On Thu, 11 Sept 2025 at 15:49, Sebastian Ott <sebott@redhat.com> wrote:
> >>
> >> This series adds a vcpu knob to request a specific PSCI version
> >> from KVM via the KVM_REG_ARM_PSCI_VERSION FW register.
> >>
> >> Note: in order to support PSCI v0.1 we need to drop vcpu
> >> initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
> >> Alternatively we could limit support to versions >=0.2 .
> >>
> >> Sebastian Ott (2):
> >>   target/arm/kvm: add constants for new PSCI versions
> >>   target/arm/kvm: add kvm-psci-version vcpu property
> >
> > Could we have some rationale, please? What's the use case
> > where you might need to specify a particular PSCI version?
>
> The use case is migrating between different host kernel versions.
> Per default the kernel reports the latest PSCI version in the
> KVM_REG_ARM_PSCI_VERSION register (for KVM_CAP_ARM_PSCI_0_2) -
> when that differs between source and target a migration will fail.
>
> This property allows to request a PSCI version that is supported by
> both sides. Specifically I want to support migration between host
> kernels with and without the following Linux commit:
>         8be82d536a9f KVM: arm64: Add support for PSCI v1.2 and v1.3

So if the destination kernel is post that commit and the
source kernel pre-dates it, do we fail migration? Or is
this only a migration failure when the destination doesn't
support the PSCI version we defaulted to at the source end?

thanks
-- PMM

