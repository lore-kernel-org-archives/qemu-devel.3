Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0B9C7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 10:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUNKx-00071S-DK; Wed, 25 Jun 2025 06:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uUNKv-00070m-Js
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 06:26:37 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uUNKs-0006VZ-FP
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 06:26:37 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-70b4e497d96so62802647b3.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 03:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750847192; x=1751451992; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NSXeXYYzfwYyuvQlnP/dxqPNFRa7HWdTUao3PH64I3E=;
 b=S6NWXpsufcYb02oedlRJBymZCnmoC3l1JqAgChZj/TDX76PwwPjknflSoX0hEIoOi7
 +eHsZY6hpKKMwEXymi4O9HNbEJNM7HCZP3yR30D8lFajXhwaO/0PoL32yP2J942w3f8j
 WX7E8sByehj3ICZtxxE11JKqOuHq23lQ+IaHQAzgCWjp5eK9OQrhaujJN+4hwCY4mSep
 rjhW52IKAuojSpBK+csb5F9O5AQD1UQbfyyjm1+4D1bKkBfG2x1jEVANmT1MFDSU8RMh
 +/IBam6njKi6DOWXLGLv1Trn6Tw6sWRzAtMZ0p56bW4SSsC82DCU2hHwpbE0jHbxg6LP
 sg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750847192; x=1751451992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NSXeXYYzfwYyuvQlnP/dxqPNFRa7HWdTUao3PH64I3E=;
 b=KnNYOWCdZaWmJRvbiWBV5HOtcmkt2+JRjyT2aXFtH6czoS4+mM/Meu4is/Tl3LsPFW
 nEjJL38y8hGakK0PS2jhih3gkqmi15cxDdm7ARcKCXhzNKDuWDUfpxTt9ScJ3tZgTj87
 YjNmttOkO4Y0lWknZ/aw77ZAsxCZOzWdABoWoUJ2C2aXwdyWBnuZuOGlqdnQLjw9m3j/
 LOcn9EHbGUREMkKspOgpHFibYn2J1WqOONrEMKDQATlFlhsHf7JH19rIqHMNEYywnyyz
 ice/BfAeBiEdNl5xCcOuNhUcXXoia9k6Ot0zO3MlvAWiCIBgl0EYKw/kBF2R50RdniZ0
 XhPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3mz2TwB/kwqflLGLBtk69e6XI80pfWtadxOk4bBVCxty3BuHyzVgc75OuQ36E+ouMFMaBSjaS/3nW@nongnu.org
X-Gm-Message-State: AOJu0YweYUOqvwQuwN7YA7WoOO9PpHCxw28uc9cmO+FPYOT0VH/mtrAX
 sfh1b0nuy8Ihh32Ymz3dohdqz3lE2zt1NiTpYuwt8k0OQRTBluvWQpEpycnga0L8Nh+VIrYqq33
 r+G2fyFE4+VNxnwT5f/UJvPDYZWlperGYsgZg4JjgaA==
X-Gm-Gg: ASbGnctCNUbooasr8pRz3xYTnQHLN1csd1kAkkZemDt4+rR3GErymRoRnWEu/xJUA/C
 MW7Yu7DCogj4PHZ+MO2cuvEbtZ3DWGkQZDSIearyOJVyZ3Jz3A5KS/ud5CECptlyEc1jWhSkRec
 OA4e0kUO16I5rauc3ZUfSm/RM8HF2lzWwN9YhgjN49Y7FwttpLqbCKq0k=
X-Google-Smtp-Source: AGHT+IHuDGuqE2Ijdgs25Cd4t9LT5hT8oiPaIlig0JCc+Q4mzJW1JSlw60u2LF9sTuupX/m3MujT9TUMTUhkSz2L9/M=
X-Received: by 2002:a05:690c:5506:10b0:70c:bb54:cd05 with SMTP id
 00721157ae682-71406d9c227mr23704047b3.19.1750847192050; Wed, 25 Jun 2025
 03:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250624022219.3704712-1-kane_chen@aspeedtech.com>
 <20250624022219.3704712-2-kane_chen@aspeedtech.com>
In-Reply-To: <20250624022219.3704712-2-kane_chen@aspeedtech.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Jun 2025 11:26:20 +0100
X-Gm-Features: AX0GCFuwqyXAweUMPZQdbzrRBYG3pm7MInO6RuM1zhrLLFPhuBWUUFzF84WFzPw
Message-ID: <CAFEAcA-Kpg1YjdQ9toU6cYmhpo+6GRgAxxF2ny1SG8C2wFz29g@mail.gmail.com>
Subject: Re: [RFC v6 1/3] hw/misc/aspeed_otp: Add ASPEED OTP memory device
 model
To: Kane Chen <kane_chen@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Tue, 24 Jun 2025 at 03:22, Kane Chen <kane_chen@aspeedtech.com> wrote:
>
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> Introduce a QEMU device model for ASPEED's One-Time Programmable (OTP)
> memory.
>
> This model simulates a word-addressable OTP region used for secure
> fuse storage. The OTP memory can operate with an internal memory
> buffer.
>
> The OTP model provides a memory-like interface through a dedicated
> AddressSpace, allowing other device models (e.g., SBC) to issue
> transactions as if accessing a memory-mapped region.
>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>  hw/misc/aspeed_otpmem.c         | 85 +++++++++++++++++++++++++++++++++
>  hw/misc/meson.build             |  1 +
>  include/hw/misc/aspeed_otpmem.h | 33 +++++++++++++

Our other otp-type devices are in hw/nvram/.

You should probably look at whether there's any kind of
already existing conventions for these types of devices
that this one should follow. (There may be nothing
appropriate, but it's worth a look, so we don't end up
with half a dozen devices that are all fairly similar
but all do things in arbitrarily different ways.)

thanks
-- PMM

