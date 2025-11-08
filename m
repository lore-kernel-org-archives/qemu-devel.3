Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68792CCFA13
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 10:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHgWr-0000xi-Rm; Sat, 08 Nov 2025 05:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHgWn-0000tF-Mf
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 05:50:43 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHgWm-00086J-9U
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 05:50:41 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-63fd0bf1f4aso1142756d50.3
 for <qemu-devel@nongnu.org>; Sat, 08 Nov 2025 02:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762599039; x=1763203839; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QaOJv3F4WfXiPMVAF7ScO2qntDffQNE5gJ1ppLtW/ak=;
 b=hBu4A4hYnJMWIWM9SbgVgInjGJJ3MhKISN5/51tLkbyFZp0dHa3tgiIaacMSAM2uFl
 zlSvO2932i1sCEbmejmbt6LlyjD5booovnTqWETOlrDYIeZZwHkrGw+1ksbLx999HBnU
 zGHMIEDM5XPJwttJoEUSMTAWsKN5nXe7Jtl8vA7jym/uYMbMXogSfM7mVgfz8RZSy/8E
 pfatxqqybDa3IBO+UV8hFxy2LSf2uP+A4VIXLenyweoMoTS+YfyA4tOS3oQV77acBXZO
 /EA0URLe8CLW8iMKS8GTouF5JChA1eZhfKMRqGK8YswVdn9jK4FwiScd0kRgv/gLYbNg
 aafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762599039; x=1763203839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QaOJv3F4WfXiPMVAF7ScO2qntDffQNE5gJ1ppLtW/ak=;
 b=T10sXSg7TBPAuKsNrClhy5mlWfHWAGBMBCyxgOoLgMzJwyrCmxoHwvHHlKZniLyuAO
 fyhMxRZaOmkGUQAYu/gQ1c11ejRXcOBaD+q3hokG5XsbIhnKc8Q83dHCgkHItlMiCt1B
 ovdj/n2HqiTwOZ4lummaG2PkVQWSUST9OEFCuZnn63JCnM3i6OQUvszV2Md9msq+oT/a
 ii1n8INolzkv7z+vZRQSujWUK+FEA7ehOCWceAFbKkkwKQBT2yHuctt1fkbedxWCRkk8
 K4Pbx1XgYxGHBFxJaK3pwXOkoxrfoilN43Gyp4fPUX0EPAXt73VKE++4CqUkcutUYSNL
 DYVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFLlWLOhrcA9fI/zddaMEynkzPPI1jkk5SWA6g5OmWdPaySbY8hfnWvGmXY4g4hgTf/1E9rio4iIYL@nongnu.org
X-Gm-Message-State: AOJu0Yyms+GzLIPKEiY/kbe+lwWExX2iBFWNVyV4Sf0c6moVA34/YSlo
 eNrK5E1dIAfLcHxKqzKs9V8Pd/sX8+vJtTwj2WNxhmBprXwl196xSAnaJpLhfclLqdwygNnUr04
 00vDO1xtMmpxFhbUSD3F019SvH3jSak56c9XB5m8IWXzD0LQ2WZmunbc=
X-Gm-Gg: ASbGncv6xpPBGmlZmTDePlZVTx0+CXIFJNS6uip9GcJsPBja2mvjLgjG48TNiGucjgc
 XGfw3rPP4BT1ENx+gP0WBtHCwLr6/jeyIz0aEdEMU5Dii5JAIhiYuXUAbd6xgTOXmz1BsHbjiuO
 U5luVhZvdq60iVH7By+QhLZdLw/6abLlotrLkEOyGddV00EKOQt5ZbCLk1LJWU2rM0Ktew7ebR4
 qfX4xPEY89mINDCSOtTpWJSZ7qGOsZwLPUVfzu4ESYiGlwKRwFm2d2ghZJB1Q==
X-Google-Smtp-Source: AGHT+IErxe4tHk07vkEKbgyd+9hBu64SEsrWtu+Bfboy8iZWXu584NWh3wv3I9cJRpIB0i3zj5IvHfuENAvLAXUkMjU=
X-Received: by 2002:a53:acd0:0:20b0:63f:9897:f544 with SMTP id
 956f58d0204a3-640d453abbamr1322713d50.19.1762599038870; Sat, 08 Nov 2025
 02:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20251104233742.2147367-1-nabihestefan@google.com>
 <TYPPR06MB820663370307D783EA2AF733FCC5A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <SEZPR06MB76199F82F5B0D106C85E3080F7C5A@SEZPR06MB7619.apcprd06.prod.outlook.com>
 <CA+QoejVLkP6g43PJYpJacqVcNB+VRkQwSa3HYQbA1zJxT1d9Cw@mail.gmail.com>
 <db898f19-da96-4ef1-97ef-b8226a8b4065@kaod.org>
In-Reply-To: <db898f19-da96-4ef1-97ef-b8226a8b4065@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 8 Nov 2025 10:50:27 +0000
X-Gm-Features: AWmQ_bnOpk4ABYBxdi0cpFQ7nQjw65vwTb7f0SpzMiXFgyYt6nTSDQa7NGJYsUg
Message-ID: <CAFEAcA_d=C5S++dpGzkibyEjcLDv=VyD27EgN2e+uCzYb1ufpw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/ast27x0: Fix typo in LTPI address
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Nabih Estefan <nabihestefan@google.com>,
 Kane Chen <kane_chen@aspeedtech.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Sat, 8 Nov 2025 at 07:36, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hello,
>
> On 11/7/25 19:28, Nabih Estefan wrote:
> > Given that 10.2 is closed for features,
>
> We are in the soft freeze period :
>
>    https://wiki.qemu.org/Planning/10.2
>
> Features are still possible if reviewed.

Softfreeze means "no new features". The exception is
that if you got your feature into a pull request on the list
by the softfreeze date then it's still OK to go in even if the
pullreq didn't get applied before softfreeze or it needed
a v2 to fix some minor issue.

thanks
-- PMM

