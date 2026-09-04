Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B97C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2R7g-0004OJ-41; Fri, 04 Sep 2026 06:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2R7a-0004Jx-Pn
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:26:10 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2R7Z-0001fw-6K
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:26:10 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-86cba60d4f2so6622227b3.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 03:26:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788517567; cv=none;
 d=google.com; s=arc-20260327;
 b=QZz3Iz/gMf5wK2/4nqVshrVw63gyXYOwLX34OW9NVGHK5EpzWse/DFAtxqYIhtUBM8
 fL28dsQ6jT2jklLQ1HgLoMBrsPlTtrM1xKKBG3s/ntJrZ5AKSJyG08iyyO9CXoNss2wy
 fuCyiHMpCuWAUAFstjmnHUJKoY2ep4G79+vK1NCRAut4SHuCq6z1Uh/9a11wymi3pGNd
 MKFiPlM5N0yncEMVNclaomHjilIRbC8Gkl4t/B2RyCiapsTICCd67UKI5afCKXYyIFqF
 FPRw+6aLHBJfypvblo1geCfnPQkNFZzYyuObImZIptOXydrZfbbAmVwx7F6l3bFtTiBn
 AiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Oi37ui2jtTv/W9Qpr4OD39SEYTDwVCyUeFHL7g5vmEM=;
 fh=fBjAtw2sHQSlP/HQgPLf4B2O3LB7DfkaNuvzUIAMQok=;
 b=Gpj4VYByqRx1T0I+Vi3+zBJq0zG7i0dmX4zPinH/CHPbmKHEeDnS5tGLhFICpOAi14
 aSAAHyA/4aifnI3xs9D0zIWNo3Aa1JGxdsyeAqwLVqNNgJYVAU6V4l+jzN+zpC7USBXG
 YEWSxl5n3iXDJ69CUP9f9OpC+dXLkbhJcETnJhFTuUsrYMZvrzA6/+QtnEOGMUrkH4ct
 alXNDM8AsdCRBb8srccTX3Jdhc5NAZf8gRWsedDq83RD/Cja1Zl46VOzKyF20SznbxnF
 BX87ArhVfbFAgfQHEs7TMGPC2YKfqMr646WayXiYgAToZwQ72bxDE22VSdkxbD9tR+bx
 zS5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788517567; x=1789122367; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Oi37ui2jtTv/W9Qpr4OD39SEYTDwVCyUeFHL7g5vmEM=;
 b=awPyc9B86pCxqmROvMk/DYu5B6wO7FTTTaHHXSD+6D3M57owmZSMDnJ3SgL3M/oEWt
 mCkvTKFFFyGoSELK9nJ4GSx93ZoP1PicsYK6tlUjiFW2KUNprL9Hr2q4sbz4hIanfRFI
 OLUDkOGjFUcydQ6gJSiEb8Fb6WFITpKDIKZaboBikJGJ9XPJDHey5w0hLx72IwTEShP1
 CH7OaOucvG6kdSVV/89LxtIqMV3/qOYu0m8pShdus/k6phXde5a4vaxwpO2mYu5lPCQB
 2fp9zTmAQoFDDVJMZdbf/5hDfNECbMoxwQ6qUSEMia3aZ1ou0s0paDEygKAq4zeccvOI
 OMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788517567; x=1789122367;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Oi37ui2jtTv/W9Qpr4OD39SEYTDwVCyUeFHL7g5vmEM=;
 b=ilzsjWa6+tkBIidcdrmhTVVQFrPwXJp3mPCqAJGBnJO6kgi5My42Q/1hp6+RB0SFHb
 Dh9aR+IzjNrrEfkvVKSi6RQdbWvjnTb44MWOcwyLf+N/i2naejmGXj99FCyc6dnOrgwX
 f42mWJrYezaXcHNoYnP7iEkAiEZQkBAxl7C8CuTR6QumbHv1cd+KYYy8mvWzSRNjSyVl
 kHSvpVHNXv6L22xcDwtmzLNRyaMvW8Oypf1IDIeC4jkDutoIrK5hV0LqH8nlJSrb+A/u
 xXU6LMvQBzv1IR6pnuvd44psBkZYe+yZhSOcs5DUXVNcG3mtdUNDIROVWGA0SLzfrtkU
 yRUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzesCk+uPVs4cGBnAx4nm35UEJBxIeGj4FFgUQMKqDwRLXiWetkC4ffvYmEhHu3+BXIz3ioyC/JRd22@nongnu.org
X-Gm-Message-State: AFuF++k9r7YRLFrBS7nb+D1e+tGbB1gjlq25U8r9NYMnuHw/0tJznFdb
 qFKiq7dQydkzUF19uA5DEfOVMMpnxDWsezd1MR+GTfxW/4hGRGLm6qorD6A5BdgMKGFIy4wDsJ/
 zAlKd53Fun5+xpbmjBAtkchR9m7WKOOIRquU+zqezflsh8jjPOMlOC+Q=
X-Gm-Gg: AYBFou0XfcVtIpTw2VI1bAsbWLa6AOrWeklfHViZozvy2DytJFMy7qA6qncfEaWZ0vf
 odkvC5DL5NZSSaRAD8/nUk+v7aW3Sk908fbLJfh+4hOEyCqA8l3P6icTGO4799fSs5irdj7vUHU
 /hOQmkwKiDnhcE+ViuGJDJoRpcTjtmpRxOEM/a5p1zWe/FEeOVD9qOprOApNu3ILbrZyRO0neuN
 6P4qkTtufZPLcRaWlnvNnfEbyJBRV4LnPvbXYdQRKNdyBEPT+h6e18NABjxEsZzLg36SNPSKxI8
 DwLwNtOerBMbUWb1XEPhwAamtKPI1VrSwC61A3p/BEZl78Vckvz5yF4V+dPILOimF7Q6U2B002/
 uPmpPj5XW7rMsLXMPsyroImDYlsCY
X-Received: by 2002:a05:690c:e3cd:b0:873:17c9:b054 with SMTP id
 00721157ae682-87317c9e831mr1050437b3.21.1788517567299; Fri, 04 Sep 2026
 03:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260903112532.3276678-1-bin.meng@processmission.com>
 <20260903112532.3276678-3-bin.meng@processmission.com>
 <0795176d-4580-4acc-a3cf-c40f8d221661@oss.qualcomm.com>
 <CAEUhbmW4h_-az5iBsztzy8Yuu06+WMjOYcrL51sW8VEgyAaSMw@mail.gmail.com>
 <881be57e-5496-41f2-af0b-e21087fa5e54@oss.qualcomm.com>
In-Reply-To: <881be57e-5496-41f2-af0b-e21087fa5e54@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2026 11:25:55 +0100
X-Gm-Features: AcwNN1WimCD3hNUwZUbwn_TqBl72IryMsMCfuzUzn6NxoqPvPf3pq9HujJqMB_E
Message-ID: <CAFEAcA_4uJymq8FM+4QHkeg-m+gkOSXbrmnWLNTEznLNZwgNhg@mail.gmail.com>
Subject: Re: [PATCH 02/33] hw/arm: Add basic Phytium Pi machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bin Meng <bin.meng@processmission.com>, 
 QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 Yonggang Luo <luoyonggang@gmail.com>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Fri, 4 Sept 2026 at 11:15, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 4/9/26 09:57, Bin Meng wrote:
> > Hi Philippe,
> >
> > On Fri, Sep 4, 2026 at 12:56=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> > <philmd@oss.qualcomm.com> wrote:
> >>
> >> On 3/9/26 13:24, Bin Meng wrote:
> >>> Add the base topology for the Phytium Pi board built around the
> >>> E2000Q SoC, with two FTC310 and two FTC664 CPUs, RAM, GICv3/ITS,
> >>> and PL011 UARTs.
> >>>
> >>> Describe the CPUs as three non-uniform clusters matching the vendor
> >>> Linux device tree. Preserve the board CPU slot order so firmware
> >>> MPIDR 0x200 maps to QEMU CPU index 2.
> >>>
> >>> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> >>> ---
> >>>
> >>>    hw/arm/Kconfig         |   8 +
> >>>    hw/arm/meson.build     |   1 +
> >>>    hw/arm/phytium_e2000.c | 406 +++++++++++++++++++++++++++++++++++++=
++++
> >>>    3 files changed, 415 insertions(+)
> >>>    create mode 100644 hw/arm/phytium_e2000.c
>
>
> >>> +static void phytium_pi_init(MachineState *ms)
> >>> +{
> >>> +    PhytiumE2000State *s =3D PHYTIUM_PI(ms);
> >>> +    int i;
> >>> +
> >>> +    if (kvm_enabled()) {
> >>> +        error_report("phytium-pi: KVM is not supported");
> >>
> >> Why is it relevant?
> >
> > This is because the machine relies on heterogeneous named
> > FTC310/FTC664 TCG CPU models and Arm KVM generally requires the host
> > CPU model. KVM is rejected explicitly instead of failing later during
> > vCPU initialization.
>
> Hmm OK. Cc'ing Pierrick to add to our list of things to think about for
> heterogenous emulation. I'd rather have this handled in a generic way,
> not per-machine. Hopefully TypeInfo::is_available will be sufficient
> to not expose the machine if KVM is not available. No need to think
> about that now.

Explicitly checking for KVM is something we do already in
the sbsa-ref board. But I think you should only need
to do that if your board type accepts arbitrary CPU types
rather than hardwiring the CPU type.

-- PMM

