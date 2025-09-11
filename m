Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947D8CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 13:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwh5z-0000q5-Bi; Thu, 11 Sep 2025 09:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwh5Z-0000km-4y
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:11:56 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwh5W-0007PC-D4
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:11:48 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-62ec7fe6e35so995437a12.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 06:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757596300; x=1758201100; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZJID3uERFj/PvPGMZcv5OuEQ2JjN1qe8JRx1oBn3nI=;
 b=D3ZrmJkRGlk+ZbhepGV0j0/50J1Hv1Ao/uNHk901erEOFv2CZYdZTYO2q8ODufs/jO
 1Fdlh0Cm36gqFg02dIwwxxLPjuLD0zojp0aYVVyR4hos8DTW+xxwDTvGVQlDrHaR1c9y
 lsNuYzaVJwDVdtJMbJV+JRXDgwBAnyskx+tiBStwerjLi7AGM5gYQQ+5T5ZvgF8FVg33
 KL5guSpjKn0+x4VuIYXQBobleGKpPS2S9tkAS9gnkeCnzR5L6aGsCLhIgtr3AxBwwYwX
 N4LTfPXhVJEZelpkkCGM1OpLa+8OUqIfWao98xLagU/JhcZWw2LO33EOPbkhPT9WbhjX
 aQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757596300; x=1758201100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZJID3uERFj/PvPGMZcv5OuEQ2JjN1qe8JRx1oBn3nI=;
 b=mvk2J+I07ugz5XnLyYJYB9GGUegA5vMiTa4+7AXLx58gCItXzZoz9gcIo42WCABkI7
 xIsBJ5McP+XFlGEnMIa7PO4evDxvjOZLKztFvKX2wEDDBq1fuvRO6Zp2IXM5olUpJfHG
 wLSFrJ8sWixKEWqncAEv/IJpilrioUZnSQu6ZAxdfpXXlTRufzTc/lgClQcc9vIeVi/+
 AxpGwVnIqcRYBaEQiW1/0mDSKEmK60CeiTKsyQ6AtxzqHYqMBJsuQosLHc9r8ggYV6er
 ef+L5IOJwlF9BrXDeJsVz0+oQOetvxmRIUbPPXJAFfhorQoyhn5UfCK6dExlicSvZKfo
 5uDg==
X-Gm-Message-State: AOJu0Yy5bTp5gKGX8WmePDyvLMGxo8h2AQWj7OUfcL6veSVzdncCCdhC
 tTHOp/69UaA7dZjMekAW1Q8/6AmoautdFTNIkIh7qs0hv9N3DDKN1qm1aXZ8678a26Mls5cTm0q
 uDnR4TgGi4B7/xxl6Vn/hJogY63QKv0JgGTLCy/r4ww==
X-Gm-Gg: ASbGncveo3qV9IQ+mjc50IxqnAUKuratBqUlGXhAbj1W3BWwD/7fo34RBqPrNV9+dRZ
 C1XxkI3i0/RW/ObDtPWTTwhQ4U9JT2M/SFLy1SHf1AxRVYwZpDke/+xkRPgxUh+oLMES7l1OW3Q
 vXQHFKYw++jJS6t/J3EcsMdENRXyJLm28Rj2z4mKJUQo2JBX78cnNnZhvTHy3vuHJ1DlUqvrbGA
 hU8cUme
X-Google-Smtp-Source: AGHT+IHuHD1i2gbFk3tmzRxN/1d1mHPo5R88aZl9RTETDvS33zEdqNzi0TO0jqgSNc+miytaVkhDP1meZ22q6oP+7IM=
X-Received: by 2002:a05:6402:5242:b0:618:196b:1f8a with SMTP id
 4fb4d7f45d1cf-623725ed8ebmr15968518a12.4.1757596300161; Thu, 11 Sep 2025
 06:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250908165354.1731444-1-clg@redhat.com>
In-Reply-To: <20250908165354.1731444-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Sep 2025 14:11:27 +0100
X-Gm-Features: AS18NWCQAfMRTDxHt70BD1JKmtbbZ7EFgX1FeiCjKA4lYXTRvF4gwzL9dY3_MiU
Message-ID: <CAFEAcA8s-ThHaC5WF3ut+O_hQQBypKqjzY2Du9QAffRLb2ax=g@mail.gmail.com>
Subject: Re: [PULL 00/31] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 8 Sept 2025 at 17:57, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit 6a9fa5ef3230a7d51e0d953a59ee9ef10af705=
b8:
>
>   Merge tag 'pull-tcg-20250905' of https://gitlab.com/rth7680/qemu into s=
taging (2025-09-05 09:51:27 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-vfio-20250908
>
> for you to fetch changes up to bb986792a968ee51cda72cd4cc05822198495375:
>
>   vfio/pci.h: rename VFIOPCIDevice pdev field to parent_obj (2025-09-08 1=
6:46:32 +0200)
>
> ----------------------------------------------------------------
> vfio queue:
>
> * Large refactor of the VFIO code to use QOM casts and follow the
>   current coding style guidelines
> * Removal of the deprecated vfio-platform, vfio-calxeda-xgmac and
>   vfio-amd-xgbe devices
> * Fail with error if dma_max_mappings limit is hit
> * Added 'x-pci-class-code' property to vfio-user-pci device
> * Added a new helper to retrieve a VFIOPCIDevice from a VFIODevice
> * Fixed IGD OpRegion detection
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.2
for any user-visible changes.

-- PMM

