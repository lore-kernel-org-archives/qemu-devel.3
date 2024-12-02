Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D37D78333
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 16:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI91G-0008Bl-Hz; Mon, 02 Dec 2024 11:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI91E-0008BF-9U
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:11:28 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI91C-0002aG-KJ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:11:27 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5ced377447bso7133293a12.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 08:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733155884; x=1733760684; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTOShgMxc1do1rbnQyBaJRzHgSVOE/MEzat5aT5BnzM=;
 b=P/73W1Y4m5IPINc5kCfo6QSRdSt5JaG6hyXEkdwwBSnU6KHz90V9wyVdW+bdP90JT+
 O/8CRnuAQUr96hA0QI/PwtAZxFfS05OrU1/MdYft8z9TE19nCIy/kta5+46o7toU6ACq
 KK2Pm6Zch+f58zDb8K05BvN2irOO5+3A9NP/TVM16mRQ3Rb//+ujX1ypA4ArcvwjPtj4
 cHIP3i4eDxpXI2z+LywKDPY0PG+r643R7HywzXVyA1zRgj7cIPi66MqGafPCBtuqBfJM
 F/M2oM+LLr7+h8+v0tJLlgpl2ROoYc3pgzN4FnEBF9gLHMgyhR8GsOLuOyMl/7uUoqJA
 cVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733155884; x=1733760684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BTOShgMxc1do1rbnQyBaJRzHgSVOE/MEzat5aT5BnzM=;
 b=ixPyEQF+eaMZWy1HCLYWQkjZdC7TS/VLjlnkAzZ1FKGEY3e6LlCGjcHTYh9kRZP0iE
 eL2xLVAZMZgZ/4L02+8pglBdWCLyOE7grYzqgNyv6vb1Xf94jVYyEK24bnf30fRdUxZe
 awmdZZG/yZQXS+ywwh59bAZvBXsFY04dgCfKeY9cshYU2MIiLPUXCTP4DzgMTQmE4/L6
 3tTjswWIZxB8qQG6BNLpWmQv4rf6XLKMUf8r+XTliamb/d3yVWqO92FJ+mknutgBY4w6
 jEVieXbk2WPLsZLCl46EYZ7pjjWc/OpLX7VVgjtgRywwSoH7VnirEg5fu8ezpAAAl8/K
 s/Iw==
X-Gm-Message-State: AOJu0YyNTh9k9m4AocKHY5ujM1dZqz8BNsdIGGaHmhTnlfrN1POw0DTH
 3lZD5qOcllr0pEJCsmtCYA4ojdZP/cvyLZHILcCbLPDtj+bIu4eiGEDAzPOZz95K1aqXyLRFUAT
 6HhIevqT74aQDiH+Hz5ZOsukb62l2KS5OQi32Z5Rdkw7aLfC7
X-Gm-Gg: ASbGnctoDE14MxTVaezBxedHvP/npQLMs1uBqc/dcGSX7j43N70kQ9cHwo5v3wXxx+A
 8Hm5OZizz8KScKNMYxQDjg1wDOtUZRXe2
X-Google-Smtp-Source: AGHT+IH20MGVU35qgmUWpFFgLg/3sWPKAgBoWQpPuIHaYDb+V4zg4GCbORrThCkRnLJG9qCJ+I6Vi/xPnyZcOcmLvd8=
X-Received: by 2002:a05:6402:1f0c:b0:5d0:c9e6:309d with SMTP id
 4fb4d7f45d1cf-5d0c9e6323cmr12203095a12.1.1733155882814; Mon, 02 Dec 2024
 08:11:22 -0800 (PST)
MIME-Version: 1.0
References: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
 <20241117225643.768322-4-ioan-cristian.cirstea@tutanota.com>
In-Reply-To: <20241117225643.768322-4-ioan-cristian.cirstea@tutanota.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 16:11:11 +0000
Message-ID: <CAFEAcA8bGnF97Xd5FRQpaEbQTx+5whJoBaqvWSuVWFYhrSL1fQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] [BCM2835 AUX 4/7] STAT & IIR registers
To: =?UTF-8?Q?Ioan=2DCristian_C=C3=8ERSTEA?= <jean.christian.cirstea@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?UTF-8?Q?Ioan=2DCristian_C=C3=8ERSTEA?= <ioan-cristian.cirstea@tutanota.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Sun, 17 Nov 2024 at 23:02, Ioan-Cristian C=C3=8ERSTEA
<jean.christian.cirstea@gmail.com> wrote:
>
> This commits implements the required logic for STAT & IIR registers. The
> STAT register is an extension of the UART 16550 that provides useful
> (more helpful than the base state register) insights of the peripheral
> state. The STAT register is intrinsically related to the IIR register,
> so this commit implements the logic for both of them.
>
> Interrupt status logic has been updated accordingly.
>
> Signed-off-by: Ioan-Cristian C=C3=8ERSTEA <ioan-cristian.cirstea@tutanota=
.com>



>      case AUX_MU_IIR_REG:
> -        res =3D 0xc0; /* FIFO enables */
> -        /* The spec is unclear on what happens when both tx and rx
> -         * interrupts are active, besides that this cannot occur. At
> -         * present, we choose to prioritise the rx interrupt, since
> -         * the tx fifo is always empty. */

This explanatory comment seems to have got lost in this
refactoring.

thanks
-- PMM

