Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6883D19502
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 18:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkRaN-0006rD-0p; Mon, 26 Jan 2026 13:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkRaG-0006jx-9E
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 13:45:08 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkRaE-0003rn-Gb
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 13:45:07 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-793fdbb8d3aso42276667b3.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 10:45:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769453105; cv=none;
 d=google.com; s=arc-20240605;
 b=TJ1oSRDhQuK0gx52IiLPvBSW41qRrQm6Bvphpo/JKxCXvgQrkY8UaOvIZ8FPq3ox2K
 aPQUmn4v1zkWjO2F/Mfiuqj3jgnbhjRm1ghwz3Uk2gSRMvlrZrGxK8KyOO4sTpUBWBjZ
 Fp+QI1Gh9xY3qXBRo0cCxPp04mAKDdHalnvOlY3/Va3Sdh8z957he4i43JWnssizddYi
 wPhhEiyUU+YOpvxwloUYVOKddLITUC5s6yjyOkSauHZN277Vgwz7VpQrmn8TEo9pL5oK
 79V4Z47OVAB6KhzzY7njrdC1VQmKbQaGW+trQNcE17JK4kPM1c4CiR5axcwYXN4DLstB
 4zsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dx8DOA5ERXO6I9VP5BJw659kgsNsvOpRIe4S1zXDoWo=;
 fh=xe6fwwXs2fWbvByI7aBEdlS7gPfwF09QxiIPYteJuuM=;
 b=CgCNmFdQgz46DzVsIXgFk3ZHU+iNCtO9HnbihSRQHyhPxE0GKa4r+gb6RN8piI6dpn
 N97qSuN3TsptuTvNNBeLmIA7ERaw7QFVecxdOTzWBGGIwRH3eMtacktWlTn2bBbGk3nC
 PHGNUZRA/vYJdi06Z2dOjSvkVZ/Oidu/GDGT2GLADVXwUYtNhbzRZojJ0QK8cXKBAHKX
 5xct0n8h1Fd7trSJgI3lM61ihw+koAZKj0L3WQKTfyKn9zrxBhPNBYdQ1KMBIv9bU06I
 WnW3Lvc8wtMkrBFO0OOcnbcB017ZRM/2W1gvABi0sZ2D3gjbR5TrMikhFnz1a6iuseOf
 ZGFA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769453105; x=1770057905; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dx8DOA5ERXO6I9VP5BJw659kgsNsvOpRIe4S1zXDoWo=;
 b=AKt9K80xsckd8mbaA29yKTk4tDPv6PowH45bK3kzh7pkPAZERtdrv+d0/FFV/U6nRZ
 McAoOEwj+vH9bUouihEAOqdDJQ7ufKmRkrQI2YIkeMnp2ETA/3gtn+kVeZFfkH+SOpIq
 XOYwIDHC1qOzpmIAvBjMln1L5z7/cbdZOZVfZ4XLUsofgqYjOEqORHzhhSzaiOz1Yjpx
 Ad99n64VRxAYOVW1kFlV5UTG97xh0sHiRmYKc9vgi2boMEiXXEwDml5cIsZBrfsapaBt
 u/T5YOU8m+dq4M00hDnXTWT+dD/oC7VROmQ6BkGyDOE15zq/76ZvX29YgyBkWS3pgEoy
 mu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769453105; x=1770057905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dx8DOA5ERXO6I9VP5BJw659kgsNsvOpRIe4S1zXDoWo=;
 b=eI6AvXJ/xO5/UBx3cjQ9phRNFG+5c4AyByv6L506xgIaYpW9jY3ExbxA+FtKe8loYp
 BjVHKVP8WGO5S37hR/fuU1Kzw/sVCn5VWy8ES+dMnMVQrN4ch3CaGcFdezgUqCrsHavH
 fHWmOphxVUqBzv+BqC3ar/PWEyMB9ZEsKVQIvus7tOK42OkNmb6WACdsdIL1kbxT8jnV
 /e9SmtLLazoBNx65COlRNCvBt18H61J14hnN4Ky89YATKgQ/yG5O26+486TrYr6KDHi0
 uNJuFKw+YjT786YkAM7x3vEUH3vtIXLuY3NhChW0zpiMQZZLnvq7hLqJRLRTOOMMi5zw
 18Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/8/sOYpZz+WiCNtdql8qF2sbfm8giiAInLlzIUGldhY9N0lrWP+141dPYyTasQGftwpVapMUFhohv@nongnu.org
X-Gm-Message-State: AOJu0YwciKPWEOUTXqIiSdNbkl2Idk3Xv+xf37Qz+aDrB8xfnhgHYBu4
 OXLNkhEzWE/OEE+dX328GrDUyUC/PJpUXYh7fEIHfKCGOrD6+IqLBuR8Co+1Y5RC7c+rNinXPND
 lSRlHs551c3oqTmD21guWJ7uQkRWVI6h40++0xOe9uA==
X-Gm-Gg: AZuq6aIvhlXb9NYJihNsG2tGIIV5/0dIUfsjCVbumJijUs0xCphcjNRrfyMyNB+TKA/
 QscX4upAcUUQnY9UOTWaKgS5BLE6D2wQRFqZs7D5IbCA0vPRIQYLp5gkKuSxGgb4X2+VNSRPGMl
 bMN0n3u3MuD82EkPzHvj+2MyntWWpS4p5D9TnvQe6WKaWM/+h7EvEa2mQa1WehiZztVxyNReIRy
 HXzjHOd0MVyxyU5iqNyR4ocgmgbzxxwE4N3msBRbjedN5wm2fBsoMXkiquL00gecrAcRA==
X-Received: by 2002:a05:690c:e04f:b0:78c:6a2b:c6aa with SMTP id
 00721157ae682-7945a9cf7ddmr37881357b3.58.1769453105232; Mon, 26 Jan 2026
 10:45:05 -0800 (PST)
MIME-Version: 1.0
References: <20260126141820.719492-1-clg@redhat.com>
 <CAFEAcA8xQmUa7DyR7+Nw255e_DW=uzZ-gQT5G6cd-uuWgQBaUg@mail.gmail.com>
 <e8a6032d-cf06-46e5-a7d5-c2e9b8d248ef@redhat.com>
 <CAEEWBQPci_=gDhJS8m7erJeYu7C4-eioD0ks=_WReFQiOVDNiw@mail.gmail.com>
In-Reply-To: <CAEEWBQPci_=gDhJS8m7erJeYu7C4-eioD0ks=_WReFQiOVDNiw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jan 2026 18:44:52 +0000
X-Gm-Features: AZwV_QjoFp7D_MD2apweAR6D1b3Ck-4VL7EoNOpKkUR3QmTn1xijnS34oYHcsJY
Message-ID: <CAFEAcA_7y9uAznaY+PAA9LpMOG3NSiNKFoQXdfvZKyrsms+C8Q@mail.gmail.com>
Subject: Re: [PATCH] hw/adc: Fix out-of-bounds write in Aspeed ADC model
To: Elhrj Saad <saadelhrj@gmail.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 26 Jan 2026 at 18:22, Elhrj Saad <saadelhrj@gmail.com> wrote:
> Is there any possibility of making an exception and assigning
> a CVE for the issue ?? (It's my first ever found vulnerability :)

Hi; this is not a security vulnerability according to QEMU's
security policy, which you can find here:
https://www.qemu.org/docs/master/system/security.html

The board that uses this device is not one usable under
the "virtualization" use case, and so we do not consider
that bugs in it are security issues. So it's not a
"vulnerability", just a normal bug, and we would not
issue a CVE for it.

thanks
-- PMM

