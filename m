Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B0DCAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 15:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwj4A-0003Ez-Vp; Thu, 11 Sep 2025 11:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwj3x-0003Bj-G5
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:18:17 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwj3v-0008NY-IC
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:18:17 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e96f401c478so537810276.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 08:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757603894; x=1758208694; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=knG17Yq8OEl51CMsovL2EtZQpAt43iivBldwrOwPUGA=;
 b=No10FFGv0dZy1RssbQT1krSN4vvFQyA8REu63FzbrCoQzkQXE2MVUxLvQhoBkhdMAu
 Zx2t/udtGvnhmabxt65T+bXiBYYkrMDR/iyMUZss6MJT3WtQyHmdaxxFsrSK/6pgrXIj
 kcThH7HFvmxWoXV3uH+uSwu0OlNsESzBlISQziBljEjGTUJUwtNUM6AJjjKabiDpFgSO
 fX1NKI5RAMyYF/anMEWdBXITQP4xlZrtF/Re1x4rwOkzUoXRG5Y+IAUz97ifgDIwnDaF
 Rjm4T6zpD5SMzVNLIYzkTB6cBSPrNLr7jhguxGt9Q9WCZEsFJsvp1N2pn1emauQ/+WcM
 Azxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757603894; x=1758208694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=knG17Yq8OEl51CMsovL2EtZQpAt43iivBldwrOwPUGA=;
 b=CskhO8/V8PmbEpsZIbvX9SigxDBeal3lyLfgGhNaE80+BAsDTYrwwlQw6IPrf7N0Ea
 Ore1cmzmjyH9IWU3Oc5vLdRkU7kIewZwl3j3/j/NO4D2rp6GeVEwaT5sM4TDQrSgayIJ
 0XaMFmYfA5kLbMltdsBhTl6xdtKG4+CaRVMNVLJ3EWUHhx4qFH3stSXqjRAyjEq7DzXE
 NNGyoBsjDsXmM76J3IfYMfU/MBfjZBT+S0CcKeFUh7uH8cNyOgh0GSqBP6MbaS3y78Cq
 1nqQQ+UjpMxzZ34p6r1bCdQdbVgr4zruEWnf1I9TCNM4cFxu4carriHzpmb4txb6M0KU
 cSBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCcbVo6OfLJpPdIeHJhzEYwL6rs+N4JXwf3+JqoyXvvaaaXbQ+0WclBTafjWKH1MUoREtSUTtiqGvQ@nongnu.org
X-Gm-Message-State: AOJu0YwI5EY+lo/XxauKwI6iLW6J1H3o5e8QIa34lgs1L8K0NfNp6Z1Z
 q5JNkCZ/j7Z3sT+cycRDXez54sMF/lnnrHAnyjIUkn2wDTKRIG327jT4/5oMzm1yoCQ305Ywl+t
 eibqNeYsDON/RACoOK7NIlZzYNoEghzUIb4WoBgwcFA==
X-Gm-Gg: ASbGncs5ThkWXDzYMhWx618fi4LOQxaoJcbnDSucVGMDCaFFryj4dlvrjkgozYAYiEN
 k1911aOUW9Su+x39Q8B7MbLZ1fiaP8Ubtatb4/D7/NdT7HM/0IlDDE/77b6d8ZIgRo62BH/g10f
 +1uOWLDSWfsgvVFtaEXyl/4vWRC563Cf5QuIwRmuefxLRo8yXjWOfnlf0KXm965WFDpbd+7oiMC
 x7EeKgmL+2NzHSDfZE=
X-Google-Smtp-Source: AGHT+IF3H557iKfUovfqwt2gL5bCvaJImvBqsOCUlSfE7rbWLqZkyw3UKcIFfROpG6jQIj6ebdJJMvpqUVlLx0flUXw=
X-Received: by 2002:a05:690c:b9c:b0:722:8611:7979 with SMTP id
 00721157ae682-727f534c628mr212302917b3.26.1757603893463; Thu, 11 Sep 2025
 08:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250911144923.24259-1-sebott@redhat.com>
In-Reply-To: <20250911144923.24259-1-sebott@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Sep 2025 16:18:02 +0100
X-Gm-Features: Ac12FXz6fXkfCmLnxnecWlBKlTxswjmrip5hHL8mvpSj6aSPT4PhMhm5w4RtkfM
Message-ID: <CAFEAcA8EDJT1+ayyWNsfdOvNoGzczzWV-JSyiP1c1jbxmcBshQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm: add kvm-psci-version vcpu property
To: Sebastian Ott <sebott@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Thu, 11 Sept 2025 at 15:49, Sebastian Ott <sebott@redhat.com> wrote:
>
> This series adds a vcpu knob to request a specific PSCI version
> from KVM via the KVM_REG_ARM_PSCI_VERSION FW register.
>
> Note: in order to support PSCI v0.1 we need to drop vcpu
> initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
> Alternatively we could limit support to versions >=0.2 .
>
> Sebastian Ott (2):
>   target/arm/kvm: add constants for new PSCI versions
>   target/arm/kvm: add kvm-psci-version vcpu property

Could we have some rationale, please? What's the use case
where you might need to specify a particular PSCI version?

thanks
-- PMM

