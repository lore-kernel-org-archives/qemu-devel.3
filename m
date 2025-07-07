Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2690CC8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 16:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYoNc-0006gU-Bf; Mon, 07 Jul 2025 12:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYoN7-0005lP-KX
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 12:07:17 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYoN4-0000Pg-W6
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 12:07:13 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e81f311a86fso2526039276.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751904429; x=1752509229; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gI1NaEdiD3UCtdd4/givRGsziakR5o7SzMY1WqWAiyY=;
 b=g1yBMVQBTGP1iNBqavHVjaY2Xy6/NhofkhD830v6UOB4IP7L52xUIa8rb4zb1WgtRV
 3o7XYUO3XR7PxAx8SflQctI7vi3404cOzZErGssJQH09j5Ztb0LrQlOXbwYn5rm1PgOE
 dSBoNJLfpDEKvmZYG/VrT5sQ2iB1BDmIK9UrIoL6+rJlpEeORN9r9GPzVaFuTTg3FPJx
 KsWew7D0O1k2WvnsBkk8+1+ha2wLvi+vgEFFB554SuXb4+/q8zQ/nVJB604n1vwBOM0P
 uaZZlRX+QXLQRFs1IDKwnbTpGgscox9TA1/HxgcY/CnJQcQKhcayWkOm+eyikscKRamt
 yXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751904429; x=1752509229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gI1NaEdiD3UCtdd4/givRGsziakR5o7SzMY1WqWAiyY=;
 b=l3sQtTs5rdKLsW+tt5+QGqcE7RiJ5BRLhpInllKXk65fUl8BWVaDcLss7Kl4UU2G1q
 vQKOWxEcHnR5ZeWmDym/Mo0EZoYwV9bs5oB7//siFbfUpSdpTYNWUGPal8ixIYxG+sU/
 T0gANUQZOCuppCUJNf9INuAgRw2Z/jmFHHLtXsleq87S4pwDuJ8BaETozEnncy+vI5Sa
 tFaOE9E4kF+Ocq3KHw1xetJPlDb0izAXVJQkcuGuKxjo2c3ANLIUB8JJdfgKDrOZznXZ
 3Svda0yChEDgtKEjXwCq3KvcxMOjKS0hqWB3da9Lwn14OhSK+JoykJz6iUou2aJYnKKq
 sFpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyCmBJwQlXIcAXGdWg7HUNMhLXwiHripjw8hi/4KbfhnSXXhh+3sfKsaQ1WXfDOw3XWOCP7dxwxfrW@nongnu.org
X-Gm-Message-State: AOJu0YzCyG6oyWJM8km8qUzheLbif26pGEuvCpURGadsbh4wVNrRuYtv
 Wrpg3jiuo8rALDO/km9QMpDHbgy/iMWjeHWeuS9ESknSYH7NMPwvhnjPAhj5azR52u8OpoRoO0/
 XjFng4pXfMQJQKtyXiGB5uEshxJnWJDleD4FCO2/jKQ==
X-Gm-Gg: ASbGnct7aU14DUrre6x9EHDkacgtNiL5LwzY+73mBJ4eGty3y5STmkjAMP1urMoy24x
 VEKWwRP7siTqDOUVFJwk/bwj5FTAeZ1MdsvhQabbp3s16YqxDCKdv41TdRyinu6UhGOW1/nj5D7
 NLS4tJqhGuUlMilP8/qNv6Vf3FXZixi74qXohQLZ+K5lP8
X-Google-Smtp-Source: AGHT+IEQABQCCOXJ07L81DhzGDCLOUuWK3z5NZsAT6/B92P3SpagvN5tLKVZdZWhGvBo/4qsXZkiaFU4ctlC62wLzW4=
X-Received: by 2002:a05:690c:6e08:b0:6fb:a696:b23b with SMTP id
 00721157ae682-7179e4a6233mr548297b3.33.1751904429206; Mon, 07 Jul 2025
 09:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250702163115.251445-1-eric.auger@redhat.com>
 <20250702163115.251445-5-eric.auger@redhat.com>
 <CAFEAcA9hhdwHNrBfEqO4GD6kSb3Efcw-Rztq=CqvcOGMG3+z6A@mail.gmail.com>
 <9c78f7c0-88ce-4c4d-b6c0-5b77b4d83367@redhat.com>
 <CAFEAcA-qh5zPUY6q-TH3T8CCrD2KEfXNDrZbVzr2H-HX5n7sSw@mail.gmail.com>
 <86y0t09im1.wl-maz@kernel.org>
 <CAFEAcA_fNzm1w_vccMv8q6QhyPFu+qSSq23+EyP==LCV0xWWSQ@mail.gmail.com>
 <86wm8k9fb0.wl-maz@kernel.org>
In-Reply-To: <86wm8k9fb0.wl-maz@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jul 2025 17:06:57 +0100
X-Gm-Features: Ac12FXyNPRiN4FXd84VRSygmlkJyWQBpj9q_0BOzyKTqI-L8FKFuUZur895ctuc
Message-ID: <CAFEAcA9qsGak2HY5n8F_kaxE4+anyLoOthKuXRfRBeV7gUEmAA@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] hw/arm/virt: Allow virt extensions with KVM
To: Marc Zyngier <maz@kernel.org>
Cc: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, miguel.luis@oracle.com, richard.henderson@linaro.org, 
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com, 
 hi@alyssa.is
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Mon, 7 Jul 2025 at 16:44, Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 07 Jul 2025 15:46:04 +0100,
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > Speaking of GIC ID registers, we never updated QEMU to
> > handle the GICv4.1 GICD_TYPER2 register, so we don't try
> > to send and sanity check that on migration at the moment.
>
> KVM only exposes a virtual GICv3 to the guest, even in the host can do
> GICv4.0+. The only nit is the "nASSGIcap" bit, which is always
> advertised to the guest when the host if v4.1-capable. We have a patch
> series in progress to address this and make it controllable.

Isn't that out-of-spec? If the GIC the guest sees is a GICv3
then GICD_TYPER2 should be RES0...

Anyway, I have some lightly tested QEMU patches that
migrate the GICD_TYPER2 value, which I'll send out in a moment.

-- PMM

