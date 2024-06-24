Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5C1C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgql-000704-3g; Mon, 24 Jun 2024 06:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLgqj-0006zX-PM
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:23:01 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLgqi-0008WI-8j
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:23:01 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57d20d89748so3829837a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719224578; x=1719829378; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yjKwqTBZuRWyXGMKA+q1H3o6bPPGQ4T7HsJKT/DWL4s=;
 b=JGNmkdaaFstKFf+4g+ONhUVWqV26PUfluHOcGKQklMnIHfH5G87xBWezZfoyRjvenb
 1YPLYlqOy7PpGQGyW5SHDGiBNPpKFfLoSJGkyHNsLQAhgTFHR/AHhaA9Oa5pUEn+BPRF
 bbY7qHWYnJlggU3ks1grIvidgHlLYwMNVOqFw4PLUuw8F9bxtc45vzEMDQFyBLKVCSak
 VlNT+eE7cMNr05+IKVk6V90yb5CkhYjSybWYZ9Mr8IDyksuWsDSF96zA2cP83yby3UR+
 /tjOtU6/Bzx45yOhca6EiIxSLk2SUpx6Bash4ZaT68a14b+7hh/y7KtAQzNhkNISS4h3
 V45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224578; x=1719829378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yjKwqTBZuRWyXGMKA+q1H3o6bPPGQ4T7HsJKT/DWL4s=;
 b=CrfL7/kxkRAK5r5wWOJAhw785WDPf6aEHBaVTEPh1SkOP/NcVGmgTu+z3XWU2ShBvS
 l5Zl4Rj7ZALDWtekOpCk0Bft3sQi5VPPBEinMRVRSLI3/f5krLxl3pV609dYA3h9hiS7
 AimajPs5tJ25lOiTLX7KxQqjWFieM53dU12gugq4LXZt69agD2ElrYsmSGFIzGLFhXCZ
 FkpHaqn90fYmiVaYCSjt6B+G+sue1nqlvBWszWavokY6v9wikaFR2r4K6I00J+L2AU+L
 R5zn0Pa3JO8M5DPCFChiwxHSl64Uwrq/QdEBq38nhdgSgHp9U99NgDS3quZTI9V4dZGW
 rAIQ==
X-Gm-Message-State: AOJu0YzFWiRkUAgCUa86oaPap/1XHLFV/EbtoQgEjeejed+0JihGMPlX
 nEoTJKykhUebaURp3wHpyNuHDrAszytHqGO+xLn5bHfBm1q/hInMha4hAXupLX5826/vMsLo7aR
 DX0BpeAS8oTVYe/+HvroPSjHZfyjm8O3Efd5gBA==
X-Google-Smtp-Source: AGHT+IGjDHcPTGyk/CgITVV+S5ljM96Z7DX8VyJigxcPPDtiVXA+5x88K7yWiO0I8PX/yRaIyjwpAmz08U2hxZCQrc0=
X-Received: by 2002:a50:cdc2:0:b0:57d:2207:a55 with SMTP id
 4fb4d7f45d1cf-57d49cb2f8emr2497841a12.15.1719224578415; Mon, 24 Jun 2024
 03:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240519094106.2142896-1-rayhan.faizel@gmail.com>
 <CAFEAcA_zBhe+HxOqtAzWSCbzApEhknr+NeheA1uLj641EXMM5w@mail.gmail.com>
 <CAKUh+QfrT3SjxHA0Y5fERwnTnqKKbJg9SFb=5J5pfbci0asjLQ@mail.gmail.com>
In-Reply-To: <CAKUh+QfrT3SjxHA0Y5fERwnTnqKKbJg9SFb=5J5pfbci0asjLQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jun 2024 11:22:46 +0100
Message-ID: <CAFEAcA82+-=piy0skykKk7pSKU58FmXqiv2hTWv8-sXDB_qEmw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Initial support for One-Time Programmable Memory
 (OTP) in BCM2835
To: Rayhan Faizel <rayhan.faizel@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Mon, 24 Jun 2024 at 10:12, Rayhan Faizel <rayhan.faizel@gmail.com> wrote:
>
> Hi,
>
> The patch series is still not merged.

Oops, sorry about that -- not sure how it got lost. I have
applied it to target-arm.next for real this time...

-- PMM

