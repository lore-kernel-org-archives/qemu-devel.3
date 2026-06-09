Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605A9CD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsGX-0008UV-Mv; Tue, 09 Jun 2026 04:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsGV-0008Ta-MB
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:56:56 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsGT-0005SR-Ca
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:56:55 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65eb226b1ceso4615894d50.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 01:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780995412; cv=none;
 d=google.com; s=arc-20240605;
 b=Fp2lDxpKMKMpLIkkuSEntlQVqKYuWivr7Ah/9/4qUMNLrdJaJ2XaYndq/KMxvm/1HT
 IJF4iNOlxEsVdv+yTzOS7SQyEXoFZFIjbz3bfH1LzS9GD1zCDPb7iFGuGE179a01ZP4Q
 XPOTQ7/H+AHPo724iZEcctrSmlaFnfrK3zUintEYGCYfA8iLSQzWD5m5BzmZRK1EV87Y
 F8ehE8zwhlCVCR7+xw6pMB9osy/z9a3BEkTxBpIQ1ux7witVKECPUyCdhLYmQmVDrBRQ
 2NxlRcqLf5SYyMGiyqHKMmXUzujLswc60Kdwwic7huumFrAIseSmy4+WPhC4MkPOQ1oQ
 6ayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=92SeObi6wNJU5QD/bOreW+PE6wSzLnu/KemMCuXLPnM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Hae27dasOiu8XtY4uZCOMZH0McKKS9o9f5tZunEdAD8BoDWeBO3+WXMUlr+TIPXt6e
 BJ34/YpYWEco0E4aQ3rmUbG0j3fL/XWUnsZf3h6cOn1PY7XE7wHBfzIMDDonYOAz4l2f
 9hDWJcaXXCsXRtPbyp+GqWH4ER/2ebAObQGny3utSXuntaiHtnXH+LTjXKbgZBRXcxKP
 77RreeLmT5q/gIsoJrpXRqqiusVGPpcFJtepdeYzNMt1bKLoM6PZEo7HbXliBdjaXAPw
 HEONZbVXaUPbjpZF4G3IdZlHKVMIz8DXL3HoDc2mh/B9PpeIUz6M0CyGgCmvogTp7mDF
 oWeA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780995412; x=1781600212; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=92SeObi6wNJU5QD/bOreW+PE6wSzLnu/KemMCuXLPnM=;
 b=ICSLptdrh4nDS2ezu6+T4PpOsZyacadcW674XPgOKXy4cQijvYSFUxW7J1gknabS0j
 yAtmUhvjicq4l2pX5aus8WQREolTD+IJx6FecfPvhzFpJ+Y8OTBuGXHiPsDW1ezdzMIi
 NAd8eggNjVCbEwCTagAY7ZAs+WOMTPh0k3PVQjr0WGeMlz689o1U6KMUYCmARSEpS/x9
 qMjpP2CBOne1kxaujfVRIkDqSwOqfVA5TnQzUc2Z1Vlezww/NZG/w56cKvKYiW2i/vT0
 YYrBrf0LZgo1b5rlvuQSL3fZji0/8+wpb0effFHE6Dx1emqRk2OwLL0fRIt3K07IH2qC
 8e7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780995412; x=1781600212;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=92SeObi6wNJU5QD/bOreW+PE6wSzLnu/KemMCuXLPnM=;
 b=Pyb4urhkBBReL6sM0eGhHLPouEj9udGWHLvcBVpPSJPnGxSgiY/8jj2T8gET61S1Iq
 D9D+7E9D9dp1qxbn64C6VSjCYb79IChtaTL+xz6VlxOdtOwA/tGdruKRecEi9Yv+ov5B
 OBc8cNSVoZSx9RnpD0n83VEZEia9AaLX3RiT0qPCgKxudBnN1T4gsvnqHs9dLopAPQMv
 XFtVuqK1800y9t5lA4jvxQT8+cGggwFDRhrBtQyAjlso3eGxxVxR5QHG1K3m4rjhK970
 xmrMZDwex9GlSF3ndCiWfBAQ8LFNaCXWOFeMZyusRE5tdQGetVfbPmOzlo9ofb2Ao+m1
 TqnA==
X-Gm-Message-State: AOJu0Yw0LAGT7Jmuum02HA2Wkl+Jo/nkdIOuWp/2Vbcqq1MVGTCKFPQy
 3Wntd51y/2G+y6aJGoSp0EJuwaB9srTgWJ7RwuDK2QgpuYYkyldMok/WhWsiXnT6ihdl+d7BGW/
 mTgSX1sI1aNrz9+I2GiKqivqLpIGBsTSlF/BeUGMkgA==
X-Gm-Gg: Acq92OE2SXsdpnGfJ95mr/rlnoog8AOooPa66s/9PXFF/iSisAQg6TFI7uQG00MEsOU
 WTH2eJHzhRbWAV9yN961OCA9+8+OlMXVRfZaznXIiz5QpqItSBhNXxxDuDAhvfrkHKTyfBW/a4D
 jMHBhwg8gBWJSFdajnM66s//H8KwljYkmGqvlv5TVWyqEgXcLYivxUAIu9nPdTtnBIqcJjG+SuD
 tJKI4WyDYxMnvfMv2IDDB/s86bKQI4+iHsyqMqhJ1Ub+9siHTakFc943iGFTj0TLtWDmhLKM+Am
 OM+08tdVaj3WJB5nhKKjcgrN3X6vP20JByeOisB+QChkUHREZtS/sF8h+YZINkriNE5XjqV0+Dz
 lOA==
X-Received: by 2002:a05:690e:bc6:b0:660:41fb:672a with SMTP id
 956f58d0204a3-6610692194cmr16674649d50.0.1780995411943; Tue, 09 Jun 2026
 01:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-16-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 09:56:39 +0100
X-Gm-Features: AVVi8CeEY0_eDK2REmLejQkLuKhTNWgKD_rAjWH79HJvwUDBomNjqhh9Xcoa-J4
Message-ID: <CAFEAcA8Wc9AoxT899UpbPKRcf_D72GjVt9oa2QunfqE9A74icA@mail.gmail.com>
Subject: Re: [PATCH v9 15/45] target/arm: Implement FCVTN (16- to 8-bit fp)
 for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Wed, 3 Jun 2026 at 04:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-fp8-defs.h |  2 ++
>  target/arm/tcg/fp8_helper.c      | 37 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-a64.c   | 15 +++++++++++++
>  target/arm/tcg/a64.decode        |  2 ++
>  4 files changed, 56 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

