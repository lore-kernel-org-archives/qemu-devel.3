Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062EF109E53E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5alg-00013B-3t; Wed, 25 Mar 2026 22:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5alf-00012t-4O
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:48:19 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5ald-0001O8-I6
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:48:18 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9910707d82so54150566b.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774493295; cv=none;
 d=google.com; s=arc-20240605;
 b=GuwBuvzJeYwJhjb+hsoMPbHtz1ckgZb/hxZ7jyTXgA+Z8vcht6hNY79aW/DU7YvKjJ
 EJ7BSSC7HCO0xTQo6JhGTzIShCQWR7kSiQ3iYE81zk1KwlttmP8r82n6a5aMI6ioH6Tz
 0GjjNwZ9/RsqRC9kRdMNWUfzQPAc97orjq4K1VfpIMOoZhW50k7xRH4CvWmWzIcZAlf1
 Aj7udv2uKIQX+vfOq7CaEOpJgyU6fIFRMQRgToyjNXH5w/GU6ayhYHJVSBOydVErWA6e
 LVNbYLixM+jW1rvKdd0SIHmKEKalFAMSNiDoL4Bg9VnEdOqnkuIgUywKcGkboS+RJfkI
 2jSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vWNS3p8bWLurtX6/wqZ3gd2nDXsOPh8a6oo84f8Exr4=;
 fh=NokLSKbBIcHnZiWsRp7GMka+7e5aTghM88tAdvBbFnU=;
 b=C3KxbOSkIwM1x4eGanzgYwgenGsUXoFaCmG9SA29Dky1KuCcSNA9plz3AMBv9xWwYb
 0TNJTtM6Z/GzYydSDxacLtIhg7Tr/N5jXCSZH6WJoh+ypqKl5XBps/t9xd+JqNV6A97n
 r6okUz0N2aoxv/eYwcGjTil+9vWSYySgvov8DWDkoaB32MXwZstxTw8WbwYISYCFdG1D
 TPFdilXP/cCXtyiR3CM16SrvOILeNExaEuDbnVGfmYuv+h78NmcR371H/Iki1nSksCk5
 bFmQCIPlVNXx4hwv2n7LLOLm0qmjh9f98WBRg14AucafgDt0LrRp1RfKYxrP6HEq69fl
 k+1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774493295; x=1775098095; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vWNS3p8bWLurtX6/wqZ3gd2nDXsOPh8a6oo84f8Exr4=;
 b=O8P2eRFqn/FWuztCMMfrW6356G+z0K5b+1/sIOdp7Onsb3D385n3vQbJXpL1LQFDR6
 1B0zno+N5zF3yyuDEK3j2I6CPLS2wRYluSrgpsl49AxOHbysuv1kJMl9MGYn2FQ8xnDV
 7YlCxeCVmHUAVAyr0MG9jEjH5u4+soGR6KW5M2ow6xr3M029nl4wUvNcIYaDwSU/Sp72
 BvmIDs8qFRQfe10IveKu4s7NtoB4ihe1buvSsPpvX98diQjiP8T2XEg4w/yn8oLHSZz6
 ITfXk+af4Hc+IMMYWqdZoJx00hD8U6d8rX2FNsVgRwAvyYACUxOfhibbAV3fym/NjWUq
 9pDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774493295; x=1775098095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vWNS3p8bWLurtX6/wqZ3gd2nDXsOPh8a6oo84f8Exr4=;
 b=f2Ta19C7tSWlbFZ1vtnCmr+wZnGIXek812/cdaZgmSEtpyAGZMfjLaztoaPmsjPbHg
 tVJ38KWhoAUurCfbtt1tZPKBJjX1GMiZJIM3DWTwX9tg8CL953fkL4375tusa3wryhve
 BxaGizc9+fYd4HrDOhkR6Z5v97zcsUUk5FU2mhjMLbf81G0mlsBl96HqUS2ne1XxW5Vt
 llu7WgUNqjWzWfw+D0zAm8nOH0VMuFPcXLIUFfaBl2kpELFoRioUTIHbCwi39aqBAH4g
 M6qVp+vhc7slY2bel+01hZfydThOBYm2smnaaSx1zSkfay7Tw8pWnXjW4Ya7u1TwWVrt
 pN8A==
X-Gm-Message-State: AOJu0Yzox2Wied7VTAd3+MB2esR/oK0BU9jTjpbciyyW2JgM6w3f2PSI
 eXoN+J/AkNx6ZwBJyp7BzP6x2ZEIUX4trOcVgAKhs5QXQU3JdELAw3lS6P3azbzQ4Wxm/UHlaoA
 SVnK8EGfECI5OEFCRk5ejdyxAYoIB+Rs=
X-Gm-Gg: ATEYQzwTeq6L19FkLf+lAtoVcad/6v6gJoNrOCyshb1BBJCukD1/j/LYjjLNxNb5EHb
 Dt+FyDF3iOYztdje4F6AR0I30uMPnf4K+cjuJkb/w880XoM7oKd3u/Br+dlImF4p8fKi0KOv53Y
 DbzkAL2qh4X9bsmCTwJhVJu+ax/+4aN1mXvh0AVvru1ehcC5libofP+BhA/W3ADyqb9Vxyfn58S
 tmNmL4ZmOaCBuNOQCYlrZPaEEdaxUC+EMVkti6JEc1YXt30ssZfTuQvp2/mk95T31QIu45CQgBJ
 ILR3VMFdK4XTP8fDF/a04Yi7tcmMrO4rgr35JA==
X-Received: by 2002:a17:906:5999:b0:b98:443:6f33 with SMTP id
 a640c23a62f3a-b9a542b92cdmr247957066b.51.1774493295318; Wed, 25 Mar 2026
 19:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <177393172713.10003.9577410064303581086-0@git.sr.ht>
In-Reply-To: <177393172713.10003.9577410064303581086-0@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2026 12:47:48 +1000
X-Gm-Features: AQROBzCi4jimSuK-mETvRCj5gfkffguQPAvKgOTfAPcSy47VBPv9s2RkfdiPAvw
Message-ID: <CAKmqyKPPeHOoHoLJhcf85UPrE=sWxjTrW=njz_pQ-+h8+3nWnA@mail.gmail.com>
Subject: Re: [PATCH qemu 0/1] Update opentitan uart (part of supporting
 opentitan version 1)
To: "~lexbaileylowrisc" <lex.bailey@lowrisc.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, qemu-maintainers@lowrisc.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Mar 20, 2026 at 12:50=E2=80=AFAM ~lexbaileylowrisc
<lexbaileylowrisc@git.sr.ht> wrote:
>
>
> This commit is part of our efforts to get support for opentitan version
> 1 in qemu, it replaces the previous proposed change, and incorporates
> some requests from review comments.
>
> The changes are now being made in the existing opentitan machine,
> instead of in a new machine. We have also avoided adding any new helper
> units.

Great! That's a good improvement.

Now when submitting patches you will want to try and have small self
contained changes. So instead of deleting the current code and adding
an entirely new file in one giant commit can you please make changes
to the existing code one change at a time. I suspect the UART probably
hasn't changed that much, so there shouldn't be too many commits to
update it to support OT 1.0. That makes it easier to bisect issues if
regressions are found and makes it a lot easier to review.

>
> This updates the UART device to match our branch, and to match version 1
> of opentitan.
> This is not where we were going to start previously, but now this is the
> easiest starting point.
>
> This commit adds a file that is a substantial copy of code already
> published under the MIT licence, and we aren't able to relicence it as
> GPL. (unable to get unanimous author agreement)

You might need a lawyer to review this. The new code says:

"""
* SPDX-License-Identifier: MIT
*
* Based on original ibex_uart implementation:
*  Copyright (c) 2020 Western Digital
*  Alistair Francis <alistair.francis@wdc.com>
"""

So it's based on my original GPL code. So I don't think it can be
relicensed as MIT. As such it should probably keep the original GPL
license. I am now a lawyer though. This type of thing will need to be
flagged in the commit message as well

Alistair

>
> Lex Bailey (1):
>   Replace opentitan UART device with newer version (opentitan 1.0)
>
>  hw/char/ibex_uart.c          | 569 -------------------------------
>  hw/char/meson.build          |   2 +-
>  hw/char/ot_uart.c            | 635 +++++++++++++++++++++++++++++++++++
>  hw/char/trace-events         |   8 +
>  hw/riscv/opentitan.c         |   3 +-
>  include/hw/char/ibex_uart.h  |  73 ----
>  include/hw/char/ot_uart.h    | 133 ++++++++
>  include/hw/riscv/opentitan.h |   4 +-
>  8 files changed, 781 insertions(+), 646 deletions(-)
>  delete mode 100644 hw/char/ibex_uart.c
>  create mode 100644 hw/char/ot_uart.c
>  delete mode 100644 include/hw/char/ibex_uart.h
>  create mode 100644 include/hw/char/ot_uart.h
>
> --
> 2.49.1
>

