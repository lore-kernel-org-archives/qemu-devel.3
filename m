Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995CFE7BDB4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 13:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vryi2-0001i2-8I; Mon, 16 Feb 2026 08:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vryi0-0001hk-Vc
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 08:32:17 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vryhx-0000kO-BM
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 08:32:16 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ad019bbd4so3067186d50.0
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 05:32:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771248732; cv=none;
 d=google.com; s=arc-20240605;
 b=BrGfLAPUVyM9YIkeRL40fOJ2BZFKsAsV+KID3YkcroMkjvhXs7WTcrYZkZMEmxyX3D
 J+DtOqeFUZZo/k2c5wL+Oolrh4LeTJ0aWscqsMtxmrjiRp7avakkMJAKAEAtGIrc4uFp
 7RkLqCG00MFXE2b4uu/VUV/9WLh5m73DlFEvFutsayAajEXB/nJhwYJNC3m7O9fHLwJK
 m5rTG3qm11EeeGEM5ju3Pdb7KW0gaB6o22w5WqSLdtkO9JlUtS4qvzIHEQDpFENNEjFI
 uFf/mALN75Gbr+1uMOgLZv5/WN8MJDZIT/Ir8lgOww0BeldCIPXL90MoOwrcc9yijWxU
 HSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LmGbuBMM9mMPZgC9VCrTZN3o5Iw2RZSVYw2EZg7byTw=;
 fh=WcQL1limp1IjLCB+D6e+TZYhw+fx0UdUs1JejDNw2gs=;
 b=eXLXXtgkCZFZho5YSQAtHi+SDT10wuZXpOm29adJAjrA+i24/LFv+Gq1LxCvR9dwJd
 Yj5r0Yvv9OB4LzW0OOkLe5Pb2Up9BgAhq1mS7nzR5qGfmBG+k+FzO8aL04ZmEE49cHDo
 dELn0hOgFyfW3Yf/23+skwjLkq4UvsHoGyJSFm9Mm+F9D9yFXhr2afJdNFhZr+0PzWPK
 r7leMF8rN1LU0ppGjuEN6pUdIkLT13cxx/S++ljIivtRNSW3ne6GgcywwFjN50wKZPOU
 YPpDmNr+PTJOxtAqyiN4Y9hVWh+9ynRrFv8nNIfXRJ7pj5MEc6UL55XHF4hXi6JaHwC4
 0RsQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771248732; x=1771853532; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LmGbuBMM9mMPZgC9VCrTZN3o5Iw2RZSVYw2EZg7byTw=;
 b=Rb8e/mX9ug4DnfURwsTG3FQijpLRGvDDbHif+dBN7CyhciZHHwimKP2QmguyVj/pQY
 DKfUmd8hfEN30cAzgRIXllnBEGnbIZLgc5MWpLortOww8Gf8UAXkrN2D2SYCSa50x9sZ
 9XlAhJN09QuIUWLRgV8klxRIR9J55lO1CVT+lLf0UcMdgU3eAorvFxHz6NopuPD1vQls
 Iq+oEscScvA+f2lsGB5GA26X4Nxxt5a+H5cdQ1HO2D+ttjbpMFJRgLHGqiKjHePFYi2X
 7RYEvHd7bY3A7XLsy7U+Hveto+QAfEvETLkFNxzcnpUO0Qo+8GJRakFRjZA/sVOiYhRj
 kQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771248732; x=1771853532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LmGbuBMM9mMPZgC9VCrTZN3o5Iw2RZSVYw2EZg7byTw=;
 b=wcQQT7VE8G9cwcqQ1OxEdOiTgebXumNScfMPAWMqLG6//I0i9xDGlYLFSx4b0VsOfQ
 6UpePA9HTJvoCl4cie3N4PqaUYNHObXb8rE2g4qenAZwmITqW19m7gLszLbYIbazBpvw
 COxb+Ksb4lqiFhIwqOMkagwU41czMBamUQKsNB6SoAoLVnes5sCBQCiD1Qo/OcZ+ITzA
 yEjHAmfH2DofeHXwAeFLPByvrN+1uEKnaBRujlwVtyztCE3sSuoFW7sVOzihAwAowL5i
 z0T/YOSSemws8uqIxIkMorPuiYdsHUz/zg0YGXQaO4LKJw2KzeFpQCirGo0PBbnFGIdu
 HAuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ/EoecQJnzGbK8pUuvnTbjOlyATpC3RXD/MeEtfHct62Y/h9BUGmOzaTGfFSWlnblui9E7GT2LIr9@nongnu.org
X-Gm-Message-State: AOJu0Yx4MOuFr065xb9SsmLSaBwNh56voubLRJEwWrtR1I3AScwDYAeO
 XRRx87GzaU2PiiROinr5+ylQFqKOxWRweFYXdDzoGxpgUe2XePw0a7ThW0RZwxDB019pxU6jno9
 oJaoxjuNmirn5A28+quOrhu/aXjxuVRXZdDH0i4PmFEb/cX4wNJP3
X-Gm-Gg: AZuq6aLZ48G3pi6fQ9hpW/2ri5F4uBA/9OFHBF84xtOhAJJQjp+gHaqz1bavsGsMcJn
 a/oUi6WSWVoPm94LaS6F5j7RIEees9A4v3tY7G6+Uv5MmSwmxv0YmVou4mbi8i+j+SbaQO91w6A
 Yb2Wxzs/V3zC0RJ88wQe54fib3ww/f0jM8tjQHw7lBts+iFGKb0xBMY5Mv2mrp33fJU1boogiCb
 7nzZkuDfI4MU5uw+sUmpfBl1fPqEzwkUZCwKDckl7MwvDUZldzXBbMrBYjDLJz8ZZ1bP7BOrMgA
 3R06QGyr6yhd+Rj1aSdHtu8UsiVzVznLb2SaU/FU06aIOMnDOJZhuCRqZvjqONzcRkA=
X-Received: by 2002:a05:690e:118e:b0:649:6a9b:9902 with SMTP id
 956f58d0204a3-64c21b5b3c2mr5216445d50.65.1771248731837; Mon, 16 Feb 2026
 05:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20260211153032.19327-1-sebott@redhat.com>
In-Reply-To: <20260211153032.19327-1-sebott@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Feb 2026 13:31:59 +0000
X-Gm-Features: AZwV_Qik7Hb9tvNVxNdB7PyGF3aH47GzKSPZsyoH50sfvOzAKc1pDMKbuGM6PI0
Message-ID: <CAFEAcA--EaA9sGFXRdit0uV-H18u2zpuCAXa-ZczEN66TTWoFg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] arm: add kvm-psci-version vcpu property
To: Sebastian Ott <sebott@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 11 Feb 2026 at 15:30, Sebastian Ott <sebott@redhat.com> wrote:
>
> This series adds a vcpu knob to request a specific PSCI version
> from KVM via the KVM_REG_ARM_PSCI_VERSION FW register.
>
> The use case for this is to support migration between host kernels
> that differ in their default (a.k.a. most recent) PSCI version.
>
> Note: in order to support PSCI v0.1 we need to drop vcpu
> initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
> Alternatively we could limit support to versions >=0.2 .

Patch 1 already upstream; for patch 2 the review discussion
has been on the thread for the v4 version of patch.

thanks
-- PMM

