Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25724FC5922
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYdT-0004Zu-DR; Thu, 26 Feb 2026 05:30:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvYdG-0004Qx-5H
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:30:11 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvYdE-0005pF-RZ
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:30:09 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64ca09f2056so435881d50.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 02:30:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772101808; cv=none;
 d=google.com; s=arc-20240605;
 b=M1YsKsJUmbhdcDLoEe0TaAYXTZF1tVZutwVwFW8vrO8e5y3+RSgQeiZj5uy4JrpWlG
 ts0EA/UgIWnewob9jY+9DO+Z0pXiyojUVoBy4XNOAaw4fOq0zL43AQ8PMVJZHfmzO5jm
 dxd/5rlpPioaNG4uRZTcxFQnmLvbrgpRTIpOL5zaHIcsmunOoM8VEJvIx4813Gkgw1JH
 USrVMYnLDByCRx1XRtYafXArzOXNplXBAbkGu3X8Zrl4odbQFNL/UQkCZwArX98rgPzA
 ZWhoVDMH+22NlLj4gun1T83Wyb8er1oHDc92Fnx2VlwD2WozJMnZ6VVAuV5GqstQpqMR
 2aLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uwliuucL0KOD/ELHr9dIgi1S2N2clXrGO4EYwIzujPg=;
 fh=qDEitYY2TPRRMZ4OARbMiUT09q8rCCMKzcZWPtML1Tk=;
 b=NIgsgou1auuulbP1fgFGpJRAWohDsvEmhWpN8o1VnXYdOdlxP+eFtmhTrzyEGW/0ov
 KPPNuT5YDdUUwyGH8L0209GtLhH1R7/MQS1VbrONASqZ8SKBeJZqmdSvePBMEMf3HwQi
 dVTAe/9hMg56InWAHC+TDxG14c3hBz+Tx5nPdd0BfR5CpSEdKXsXHDAVGhCIkfFs8QgR
 Byfyy4vQie6AYvnTJ9UGOGUcg0KXD75XWYABgMJv2/nVfFQAqFQcOXjco3WXJPk7nffq
 n8moizToJ5RmCnY51sHkt88l5m0EOE0fir7V4GpXwse+bsJz1aHvrcTRYWQhKLzmJdMt
 /xHg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772101808; x=1772706608; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwliuucL0KOD/ELHr9dIgi1S2N2clXrGO4EYwIzujPg=;
 b=hkPeH33gy4NT3xfklfOBC+jVZ3Qn8kXhlv0Jrl9wqRfsax5c2KbgSPBHU06DqwwAZJ
 itwRxpCw7C352PPJe99i1QqqcxnaUIBxdHoteQTNrqRzKOQLQlCYwpSoBYNWlbnrD5N+
 vEnFoBVnsYtZEHmqee9C5kv6oMUkLx8QytpCo/QHn2NAx0EQGLguRTatN9IF+nnnTeQm
 41v6X3qwh8zMFZpLaTZhgIdcQq7e0/alxghiXQgz1WLIKTiyXFgfMyuYEr8g4I1iai9W
 bP+9V23ZpzdUcdCVCF6h901/A8HFtX8r/aQyCxeYIC+y/MczNE28AWY+trg74Ti9mb/A
 tVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772101808; x=1772706608;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uwliuucL0KOD/ELHr9dIgi1S2N2clXrGO4EYwIzujPg=;
 b=SQs5zcLVUjtkTaFUdJi8eLnmidcxtMg9uZVYt8tX6gtkdlVJoD0mPbd/vBR0aMtq50
 Cu2Xkv3dHqBw2npt2JH1n5lL1w8+9O3zBZEr1AAcjTrEzm/J9FHMpFTIUP7tdQZo+Rgx
 VMldWjnGin2dLJv0r/0fEi7L3h30V1kJcvrBdh8hcvgLu+2QwtTv47mTxDPpmCxwhm+d
 7pjqpAHEZCOsneJAD/8vEBi9OQd00WIGpT7B9wAR/02kiVRObI4sRYHuKIkw37WOnNH0
 y1U1JiwjdUmcHE26Mba7SJNXCVP8+xgfcv8Ss9mkAjHdwXT+JWisId7xO2mLyEpsEz1k
 AwaA==
X-Gm-Message-State: AOJu0YzfJTZYplJ8pZJr4FFVBogjIXfZiQrbsRcYR+mDzA1OzX8jvKJ3
 ZApv5m6FkRbKvNJN3PJAuYjAWbD5CxFwzumV3U9ChLoKHjSKGfFsFnri3vg579I1h3LDQHW4cG4
 CmIPNhLHExmYnGzRchcMmUNJNuxeFKrzZ6Gsa4eq9Hg==
X-Gm-Gg: ATEYQzzlKF9fdM/qCTflifJbJihCsLsuJ8DPj3A5ggyEIFAncTtG7r1JhdZ5iP+dFHt
 oxbDlKdwCzCqb8+s/7F3RRLax51ASvd6U+Y1EAz+/PMSWYTt9F0Oirgt2iHYPwNYC5/fYifuIid
 Wmx7dIhLIj17LAN7MQu1j3X06v1q/8zboQey3IdjJB7tGuZOh+PelpmKISiBaakqNrkIu7e8HMG
 +AWSm03M3baWZgZ7NA3665t3sYh0aCCU6rwNEB/0H9ses4J4BO85htEk/kljxkQd0wPKfeay/FM
 ZwS2ysB13Vmx1A97PhVOaIXz9d/QSniRevH2gphck7Bd4PmA1JAaInoKc2QI9HwIbC1PC1W73PJ
 UwQ==
X-Received: by 2002:a05:690e:343:b0:64c:9aa3:b241 with SMTP id
 956f58d0204a3-64c9aa3b6c7mr6332174d50.66.1772101807633; Thu, 26 Feb 2026
 02:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20260224154347.344219-1-alex.bennee@linaro.org>
 <20260224154347.344219-5-alex.bennee@linaro.org>
In-Reply-To: <20260224154347.344219-5-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 10:29:56 +0000
X-Gm-Features: AaiRm52tAKbDJ_VbkHcj2VyrZbdSxZCT6J5lSiYGWKpbuR8xR5h8XXrxUwRAU-I
Message-ID: <CAFEAcA9qrNt=ZrGUFJhdCiT+AX0OVmG5jWXGmaupCLV4p2TVZw@mail.gmail.com>
Subject: Re: [PATCH 4/4] target/arm: report register in WFIT syndromes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 24 Feb 2026 at 15:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Now we have the register number we can report it in the syndrome.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/syndrome.h      | 4 +++-
>  target/arm/tcg/op_helper.c | 4 ++--
>  2 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

