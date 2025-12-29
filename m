Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379D0E92FDE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 21:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaKg7-0003na-L3; Mon, 29 Dec 2025 16:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vaKg5-0003mz-Uz
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 16:21:21 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vaKg4-0000bs-HH
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 16:21:21 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-657509d761dso5191749eaf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 13:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767043279; x=1767648079; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPxfSM5/WIj4rg1zaR3SotCvTyqjGa96Y7OUTxJ9MgM=;
 b=BgPfzaWOxfFpMQWhOfztyxlN2zkhdZYHNqRE5q5O0kau7WUhguYNwXKylv66jynEgD
 9QlGoSHk27cZtS6Q/+sxuidxb8sOWb933zXyXJzS7EcN6MXWBM66qBQPWY3cN1LxStJM
 swY54mJAYQTy173GdYvkugshkpjPVZR5pByvFBdJbbWiqwh2sBvhe2P9if3Yos7nokSA
 hfqJ4aiwwdgcPxvWA+fJr+/sM/iF/mhGzs4GeO5bQ8IAy8U9kX8caDuHMrhyU/219q8d
 OXt03PTyx23e7TfJKsx8MUv/h74NO5MBVE6u+ndaJ3fcMR2HsDc6AJvkPoNSXfrKhNzK
 BbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767043279; x=1767648079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VPxfSM5/WIj4rg1zaR3SotCvTyqjGa96Y7OUTxJ9MgM=;
 b=LHI18mMZKa0DMCsUmPeyCt7KExe/J/WkYm4130Q1iqBjQZfeqQHl//JfOFCvqQDgI3
 p/6zj5ML9tIbffle/wzcHQMQ+gftcGstYMx8PHrnJNFoncJXAhaHrCJbXF7QvyuxYf1M
 hjXK8+r0xAm7FeFyQ0pTO2gZ/Fv2cUbxVg7ZygjgRB/6Mz0cZv6xvoeVUqYcJyN4TNj3
 DuY9KpVKeB/sf+Ev2c3XLyDHiTG8oXRl2JU/QmVZBllOJBPDpnFyRJEdeUvkCzddlyPN
 INdNJV4g/VoFhXN2H8lNPcuCgbVgbIHe8gWgJ3gwLdG7gogy8wtUCODiJvj9KEquvjxi
 ncWg==
X-Gm-Message-State: AOJu0Yz4Vq7epkl6QDAdKqdvh4EpJNj7kXgunvUmFDFt93/imPcY35A6
 TA2hGnhHfPsjGLM/sGQ5OMM3BqI7f6cp39Xk+maglkka1P9bMgHkrKObya9zEohrrsJWX3KdWfC
 fKV38PTNkkb/RAhMO7e2M2ywbxrKZUmc=
X-Gm-Gg: AY/fxX6Q0qlhgRFbQKyy9A50x0X97VnBQHUrhNTJY5quDloX2LemU4yQ3T6sfqbYGqk
 HdCUb+fLkr4JpLT9/mmtQ2rXe90+sNuZ/mJVBYJaN6tu5QN+XT+g0LP1MOjlVcn/HdD/108TLGl
 Z9jF3goxjNCT3H/oQevvWzN6910MFeUVM6HN8pFtrVUnGZf2YNtyUvRV7FZo55mjIDVR28iDc7B
 TLuUG2wkHGLyhG5upOmF0DRZ2af7sM3GQaWj1Yv8+/PbCdq94brQWQrYVL/zo91GzUrajFC
X-Google-Smtp-Source: AGHT+IF1jTaw1x+iOGBGYFpMphxF+gudnjnWnQ6m0xhXIBQQExRvkqNqHNbjuJLM7A9Velpqtrhu4SlhW1yFDdqOVug=
X-Received: by 2002:a05:6820:602:b0:65c:f3ac:2206 with SMTP id
 006d021491bc7-65d0ebf2924mr14967074eaf.73.1767043278921; Mon, 29 Dec 2025
 13:21:18 -0800 (PST)
MIME-Version: 1.0
References: <20251223223712.17047-1-ruslichenko.r@gmail.com>
 <CAFEAcA_SSnwo0N8j_zz4jRrzcewAiRaVCENj1_gzdBVCthNVFg@mail.gmail.com>
In-Reply-To: <CAFEAcA_SSnwo0N8j_zz4jRrzcewAiRaVCENj1_gzdBVCthNVFg@mail.gmail.com>
From: Ruslan <ruslichenko.r@gmail.com>
Date: Mon, 29 Dec 2025 22:21:06 +0100
X-Gm-Features: AQt7F2rfk26_H5Giyj4Ttk_6nq6FZxlN3iazRL2SNqi0PQi8Iy0CuBpVzZolWl4
Message-ID: <CAN-aV1E3Od-ZNy=SFK4XSQfcAFBr=953Vwujne=qmKfxNt5bcw@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm/smmuv3: add support for combined irq
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>,
 Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun, Dec 28, 2025 at 6:08=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 23 Dec 2025 at 22:37, Ruslan Ruslichenko
> <ruslichenko.r@gmail.com> wrote:
> >
> > From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> >
> > Some platforms use combined irq type, in which case
> > only single interrupt line is used, instead of 4
> > different irq's for each type.
> >
> > Add emulation support for combined irq mode.
> >
> > This mode can be selected by platforms by setting
> > 'combined_irq' property.
>
> Which platforms?

As I can see in ML Linux there is currently at least one platform
using such mode:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/arm64/boot/dts/xilinx/versal-net.dtsi#n1010

In our case we are working to emulate Renesas R-Car X5H SoC, which may
also use this configuration.

>
> The other way to approach this would be to have the
> relevant SoC/platform models create a TYPE_OR_IRQ
> or gate to wire the interrupts together.

Thank you for suggestion! We will try to implement this approach instead.

>
> thanks
> -- PMM

