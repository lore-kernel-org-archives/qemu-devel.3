Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91AFFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHHnQ-0001gV-5D; Mon, 27 Apr 2026 04:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHHnH-0001fn-0x
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:58:19 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHHnE-0004aD-Kf
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:58:18 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6501418152cso9247851d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777280295; cv=none;
 d=google.com; s=arc-20240605;
 b=do5xuYtq+kwHquR39852Ih6tISe6tSfEjBcygtrtI0PDedw+XGQNtKWD/5pRumfSX8
 bD5rcvWkCsM+jCKmk3zuuJrwexFYe4CPZ0KGngKj1Oy/wNMdZJE5g1qmA/ilVGBYHkcb
 N0k6lTc0oAg2NuSxWaoON5CDePUZ78lOyRFH0XyebdkwOSuJsHlG5j827U0D83wxP47b
 KeJhAeby/R1ald27SG1p+iIdMGVRUIfHplrY0kdzztHZilT3SVPXTmWrqCqOoRaZUVSE
 SDJPbr/O/4WQlTnQm5HZPKA9s3EJj1HkwyxW5KK7bHJrUaHjCdAZRGtc8BvuLHWJRMcD
 Qxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gGYUzp9buDQOti67WGxT2EMWbPkkEoKE2zmm1YvBsJ0=;
 fh=R4ICwLqqLoRGx9KpJH2L+RpE8XRID83H1PerdS4nzwo=;
 b=PKq0BLhidG1nvKrthnMkdTs9UE5P3lZf1axXOg04Md8t+ICV+Ze7hOVp1+5GGWehoz
 68hcIyEFll1X8M9Lob8PgF82Qh0hBz3R0TEfVQKxx9vUjwDaCAqfUl3A6U0QcBayyBEw
 doqfLEalsBVSbReaswChAsFN5RqhbQoDXzwVsR6Oqk/iallVjTip9oDYBj23+t8iHPGV
 FkrHI8ud85TX+Vy47GXP8Ou1D8CyoHtrh1yIvv/YaR7Bi4vgGpJWYjjUlPkIZnqxWAGP
 /1pRkCMW3IDXacmttC3NKzhISavRdNAd4bxIMY4o1KzoD/sxonHUjGOtta9QopbkboBy
 Y5Fg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777280295; x=1777885095; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGYUzp9buDQOti67WGxT2EMWbPkkEoKE2zmm1YvBsJ0=;
 b=hOxwYLGHmVzFfT4rtypjGhNjXN+C+/wSl9ZmL4WgtmNABu7e4hSldPDv/1WI/2AnuM
 Y8QPFmOVLT55ZKUMluoOilMxsyw5smYW5sz+VJtfUSbxJfqF85d0YkbAOURrBUHbKdLc
 Rfrgcz6xu3L957CRecl/NDyGczlxnUqhJszGtk9rkUaVXZ4WGb3X0KGLRJm7+K0Xwnxw
 FbyZkKXiJDIrgoTMVstYq/BYhFX8KsC1/yqG6Gs5IwHCXOZQHqkEbD5HoKvGw2o2DAIu
 HMTw+zEyUAH2PkRgMiOKdMC802dDmctjWeZE8KiluAfsVedfFDZdJjNiPcyLgKKpZW/X
 n1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280295; x=1777885095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gGYUzp9buDQOti67WGxT2EMWbPkkEoKE2zmm1YvBsJ0=;
 b=hGSXkGycDbsBjh+V6G9UqPIyKOmqRIwJDlz2IQmgswMXxX+pcKoRL3mR3xA5acDakz
 ucfnHxKG4RMUDVlRa+kMYEEBwREBvvTzciSFCSlmAXtqiEDKk1NGptSv1PegYW6rLOuK
 m2/aYCjtmXDryBKts9IXozosnOFa4jbOQCjrxJvnYhwKc0MOoWvmSndRo5OHHd0PpkaO
 oQjp/Kp55KNd4ri257yMZWv5pcSZyHzLiza01spfj8jMg1dr0rxsLw/9zlG1bL0i16n+
 SXFvdbSwGo1xNiw1npWeHEFxQXj1W9VeSJ0HiFULrU2c8KFdVW5D+HlB7lREGX490TaZ
 lXgQ==
X-Gm-Message-State: AOJu0YxD0+CZtTC68PR6byrX4oC3A41CXrDmb1Xx8SGecU2pPFGqVx4f
 Gyl9hEWzCzry0pq5HGg18kVxcvakRwA5w6u/ElaWExQXAPdNPmumlBe9EU0l5+XKBr9sYrefICu
 ehLlSSAmJkmPiePUj6kJRKXy32f5xG1ruWVJMXnOYaw==
X-Gm-Gg: AeBDieufd+3lMfakFWvfq9e93FnCNJlhRAZkp67fxGjNvgdpi871Mm8s089ZEyjyD2F
 kyTs2NjygBbGgwvgT1GT1TdaiggE5QxX+/VBDJQZra9ZIDiEwczj5qErQhadR8ToInctzzzieqW
 NB+D46iCh2cpiGBENOnCvb15ODUxLri/VatgpCrR8UmGJZVvceeMfrcv0n9B2rhA6/R/67WPnru
 uVnZmPyIJwiT+fcIFTb/V12u77Qg/ZU+geuMnEENUXM+jc46kHLn8RwdubO7uPdjlOI9mKGjEFJ
 ZA6BzFbrNHhBhsnZNhl6Ob56lsRp9+GxpwUuHYl4CNLABFnHL5aWeyORWjCDKe1VHv+iKKOg/HX
 Ypg==
X-Received: by 2002:a53:df50:0:b0:64f:c830:1e45 with SMTP id
 956f58d0204a3-65310afd6e0mr27530851d50.50.1777280294200; Mon, 27 Apr 2026
 01:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260414005348.4767-1-philmd@linaro.org>
 <4a4ab25c-aad9-4383-bf39-00a22cd5d287@linaro.org>
 <54fa03d8-f1cb-4510-bc57-e18b6a048cb3@linaro.org>
In-Reply-To: <54fa03d8-f1cb-4510-bc57-e18b6a048cb3@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 09:58:02 +0100
X-Gm-Features: AQROBzDAPu5zehDOS6TSeVrWBHRuLcJqW_yLhnupRvMAJtB_vFlW6cUBXoJKd4I
Message-ID: <CAFEAcA87F45dRkDrmR8b6wihdHMiiCWxqLjoN9U8rqk7jWRCqw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] target/arm: Remove MO_TE to compile MVE/M helpers
 once
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Mon, 27 Apr 2026 at 09:15, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 17/4/26 05:58, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 14/4/26 02:53, Philippe Mathieu-Daud=C3=A9 wrote:
> >
> >> Philippe Mathieu-Daud=C3=A9 (9):
> >>    target/arm: Ignore endianness when setting MTE tags
> >>    target/arm: Explode MO_TExx -> MO_TE | MO_xx
> >>    target/arm: Hoist MO_TE into mve_advance_vpt()
> >>    target/arm: Hoist MO_TE into MVE DO_VSTR() macro
> >>    target/arm: Introduce mo_endian() helper
> >>    target/arm: Replace MO_TE -> mo_endian() for MVE helpers
> >>    target/arm: Compile mve_helper.c once
> >>    target/arm: Replace MO_TE -> mo_endian() for Cortex-M helpers
> >>    target/arm: Compile m_helper.c once
> >
> > Series fully reviewed.
>
> Checking as of master=3Daa15257174d, this series still applies cleanly.



Applied to target-arm.next, thanks.

-- PMM

