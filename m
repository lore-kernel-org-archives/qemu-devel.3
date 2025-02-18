Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBD1C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 11:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkLsO-0001Nm-3g; Tue, 18 Feb 2025 06:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tkLsM-0001NG-1k
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:34:54 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tkLsK-0008Ne-7v
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:34:53 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e5dcc411189so1431240276.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 03:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739878490; x=1740483290; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dCxxmzLztkSmSoJ8j9LmPgMtj5EStxkwMuRxquLRua8=;
 b=cUjwdq4qMAlFkTh4TdXQgb9kSuACK7JKhyGCGMLmIbe+ccz3pyktUkl3to1cT8kV2M
 T2infUnGLW2sRSRGYXJq4M5zn5aZiz8ZGJ+wor45uM/HNROktkEUcX2kdZIuaT/zhpIy
 d3oOJ0nL3UazT8qRnptzeBpipQ5NL/Wbto0ffiH+BvZrJ3oxspP3GPNPJ8NCnSxeJi+w
 cuwnjFqnS+WtLyrjPb4qY/8oeNT3J/cyvIedHQ2mIB2ZSCLE29BgC8Zujcpx98Cxd6dj
 ZmqXaFVecP1/zImO/NGjZoaLknhHtRWpHWcsIdHwzFmTFbzQ/NG/KgOpNFoAAdt9Y39j
 RGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739878490; x=1740483290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dCxxmzLztkSmSoJ8j9LmPgMtj5EStxkwMuRxquLRua8=;
 b=OExQIjrHfaijvO5asCaECLUe4y4hz/3QvXrG7rN6eiXitqbMRA+7u6Bq0UKy74ULuU
 F2RfsIZwHWHNMqkm70LUOvRg8pq7P/mSgJi+E3zKL+CmWTcR+WUZGnFTaSJMC9vc6UhC
 eiyYrarsuaWVTWoNldDBuVtMJCTvbyeJoyabrtq/DNR2KDqjWeHLI1qYKN8IISic9YsB
 oyefnvkC+2RhSmkByeJWVc8b8+yJKvt3xl34ixpqN62ad9q6Awds0jLmkOGjLQFqGw0S
 nRzF29cUtUgfYD2sVzih7JdLTY806v9SMWqSYmp849Z+ThihkdysQjZ5AlaYi9BWbXKD
 QAfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1SpSh7lcQytcInC05AOQby6ON5I2W5jZzjv6c3WyfMlunyoW9fVyPSbOf2cEhX56/OqAXtmLhkoQM@nongnu.org
X-Gm-Message-State: AOJu0YwXlYqJlbHsrNzBhjJxgjGzACskgrSsKIHq93OHmANXhwUTL/c3
 KamN/HQ5nkW7GrYIgj+xOBxRRBZppiBzme5+4wU9tnTbm+nVQFelXhoxXSA9nxAPiWejTFlFmC5
 3o5woEDXfYqQdoGEFCw1wmWgcuGcMS7zqDvnDCA==
X-Gm-Gg: ASbGncs40a83TWBF8j0akZKXZh+RcT1y/+vwOQGye9pve8DQVE4/46Jp64NXfXBBnlV
 OendJhBfDAnrTiaLxFP8HiApDWWoxS1wdEmznzeFuVRLrf3JAplThxGYM6OgJuIv6OXcwDDPZfA
 ==
X-Google-Smtp-Source: AGHT+IH/qISOe5WuHOSfMc6TYfzVK4kQWakJQ/qH3tR6yO7jfs1QIsreQJi91qafrrCYFW1kOrUKQKSZ988AQs+7HSY=
X-Received: by 2002:a05:6902:230f:b0:e5d:b2c4:7cbf with SMTP id
 3f1490d57ef6-e5dc901f488mr10347903276.7.1739878490533; Tue, 18 Feb 2025
 03:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20250217163732.3718617-1-kchamart@redhat.com>
 <20250217163732.3718617-3-kchamart@redhat.com>
 <ff481ffd-545f-4d0c-b53a-3cf9e0f8f388@redhat.com> <Z7Qnsm02w6gao_ui@gezellig>
In-Reply-To: <Z7Qnsm02w6gao_ui@gezellig>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2025 11:34:38 +0000
X-Gm-Features: AWEUYZkKRqFZeUgKLswIbgec76XzM4VNRtISsi2zkh_MaIAen2OmGkos6ghDuwI
Message-ID: <CAFEAcA8H0P14JaAtpcwG99SYkqAdhoNzyQBuO++YjJjM1rUbPw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] docs/cpu-features: Update "PAuth" (Pointer
 Authentication) details
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, qemu-devel@nongnu.org, 
 Ninad Palsule <ninad@linux.ibm.com>, sebott@redhat.com, maz@kernel.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Yi Liu <yi.l.liu@intel.com>, 
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Tue, 18 Feb 2025 at 11:29, Kashyap Chamarthy <kchamart@redhat.com> wrote:
>
> (Cc: Richard Henderson; context: "SME" and "RME" feature discussion
> below.)
>
> On Mon, Feb 17, 2025 at 06:43:01PM +0100, Eric Auger wrote:
> > The resulting header layout seems weird to me.
> > Initially we had at top level (assuming ===):
> >
> > KVM vCPU Features
> > TCG vCPU Features
> > SVE CPU Properties
> > SME CPU Properties
> > RME CPU Properties
> >
> > and now
> >
> > TCG vCPU Features has somehow disappeared giving the impression that
> > there are none.

> > Maybe we shall
> > - rename KVM vCPU Features -> KVM only vCPU Features
> > - Add a TCG only vCPU features including both SME and RME ones
> > - introduce a top level KVM and TCG vCPU features with below:
> > PAUTH, SVE, detailing potential different semantic for both KVM and TCG mode
>
> Yeah, it can be done.  Would you be okay if I do it as a follow-up?  As
> this a re-work of the entire doc with several features.

I think personally I would favour not having the split of
"KVM only", "TCG only", etc sections. Instead document
all of the properties in the same format, and have each
property say whether it is TCG-specific, KVM-specific, etc.

Some of these properties may at some point in the future
change, after all -- SME is currently TCG only but may get
support in KVM and HVF in future; "aarch64" is currently
KVM only but we might some day support it in TCG.

thanks
-- PMM

