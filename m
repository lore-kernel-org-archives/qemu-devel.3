Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C06ACD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 12:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLK2f-0000bz-LE; Fri, 08 May 2026 08:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLK2W-0000bE-JC
 for qemu-devel@nongnu.org; Fri, 08 May 2026 08:10:46 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLK2N-0007Wj-4Z
 for qemu-devel@nongnu.org; Fri, 08 May 2026 08:10:40 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-651c366f7efso1993871d50.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 05:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778242233; cv=none;
 d=google.com; s=arc-20240605;
 b=lyCuPlmT98G4zgfq7jFqSrsrxAfif9xTCoOY78lc8vbx9p8iFXAJSSX88ASjBwuwuB
 vOI1UoFP+RWWXMQGP2AWEceFYCd56fODsgf1ehy6VNHbD+ydi6yvQcWJmijmugx2ct21
 iOwne9o2RZBElHMpYt8no5LUFbHbSDpt75nuhL/JNHyYUDxEPuAAMlmxWXydbI9sY9tG
 /0YaaBt8ErgUDcxtld387Dg7TD6cTiVuGTOiQ2zJrkJEY+rsxrYvD5NqeFVHHJofT//E
 xSSqlzWH9xvwArYzTIdClc2LpYd6MYKiAX1J8ugvAxLW8W/jraBav40VYzOBDwyVNlxR
 jFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FCnMFxPWcz83WnTu6jqJklTu3YcuzvxcDSZE9YHOY4M=;
 fh=AVu3RYwucn/eu+sAIgNML/anFII4a1bVzPPlkmENQ84=;
 b=ZwUlLe2W/9hZGq5XJSVu4be2Xoe+MYK1e+n8p5PJglO5298+2O7wtuOfL+2lhj+mxS
 zVXkaGPZPcj3iyG3DJ3q3viMlC7gKiYlFvyx0D0dMWA5z1KRTm/xr8aUKuqHMd5Ai51A
 2/B+FAkWPYVDeO9PxUIDwlvEmp+zYkjDLTJzuK8ZDKYTCms2C/qmKU+CQ+jGfdebBmT2
 xcsSjcWgGXWyxr5/qmx3nVIVUdcr1lzxzTgSMuzpxmjAVleu1PORNhsTgTDp1JODfmyd
 8CWUYFWp1QehDy+WvU712JM3OIRC0M3i26MAFHYbIDcyPPTns62RW7fddCtvYcbZZBLr
 eFsw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778242233; x=1778847033; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FCnMFxPWcz83WnTu6jqJklTu3YcuzvxcDSZE9YHOY4M=;
 b=qkT5+GFpWGGZeJegeeJ4rCZ1zKvn5n0XX2kbvRBbg15bGEkxai3L4YR/y/f+qEo/a7
 Hy4fZUtnJNIMj8vLsnLzjLuLmsNtpvzx8OO1IJlpxeyDMNRqdZCoitdC95sjiGIsTLP7
 AuvP8tmqWZHu1eoX747jc561xGNtLYTF6gWaXDaVQOBNeTpNFRT+S1+T/f4V1IiNCfte
 l0f81gmwYoBRiOTWVsUuCPL9E+2sKM3yrq8j4D3J94ddwIFsw9nlo5ue6m4LF2kZSFdR
 /Z6X1macNhdBwoWyRdGCPX8ogtYQUmDaYHDN+PVyVHXbCCJgYrY/YiKiGjpdP1uM4Wo3
 TtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778242233; x=1778847033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FCnMFxPWcz83WnTu6jqJklTu3YcuzvxcDSZE9YHOY4M=;
 b=ReZSacMZBKySAZK9vyB64J2/9BseHKSxLFyGR86N1+gdCkI/bAmV9bjNebEgZIbCQu
 f5Zg/1poTC5+Gc/NW4eX0h78AEanh4MvAAcQm4tvaMyqsrVE+vEysSi4h3ybDstlYO8K
 ila4Tj3j48NTo3wmnElIIfNLl/W2ZRIyjY7OqIlznNKyg1UnaPVmABw2vKI4yhqSFcw1
 NML6O/Tg+pUgKI9vU/8vC5+TEAWeJK9tgSZJGmQ4vxiqlcLs6A/F6SYpWXhDbe6pZ04w
 dHhy4tnU0YFwEGNLEdnisDwmxGdqRTIPhC0fTfR1BZU+GVy63gWCxV/5DWx6D031UXBP
 cLVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rDVXeiTd6JBvParYNa22F9QcX4pSJKrX1VcLZFi/L1OMmQftSpzcwunmcHp4ghBAj1ySX92dnWA2Q@nongnu.org
X-Gm-Message-State: AOJu0Yx+WouNR3koeUiXRNH3lmUx/2z21uzVzZh+T/k5RJ3ZGcBQeWz7
 8JSJGnwIlKvGRmK6Uv0Ah/ZGvCs0CIf00JsqysO6AA4zGHf7/0MCvuAdywgtPQzQ6tC4xvW7w/k
 x91n5AIv7UY+w4ca4tQrNjrRdv3FcrsgiWNXdRcMG0g==
X-Gm-Gg: Acq92OG3KFgLJ2/+Wk0EVmH1Vv3IhR586Lv5IiZom3seDq8N8W68GxXjUg1+XwoInfo
 It5Hg3bqf/b8qMTkKK//+QDEldKuTkQbgkQtMcCEH3DITzAJI6uguMauM4Pt/+DWUpiGDo+qD0L
 PREMbL3SuvWXUBBvejXv9NA8SWu8ygttXKq/S9MkbnWL7inQhw/RXUn1BJLVYWhKsaZ9D+U+0Za
 HsBv13KrzWI2b/Gy9x3BURryaKAE1QZlMrt9kU7/YfFsv068OdgonqE6cUImJnJjq72zzIdsvc/
 PE98s0Z9LCG9jq4otpVuWN1GwuLsR+QpcIhJ8d4XH0Sd6SYHOsUc5nGK1ipJUbwaLrkjSvGFxBz
 6xw==
X-Received: by 2002:a05:690e:120b:b0:64e:f106:60ee with SMTP id
 956f58d0204a3-65c799d57c0mr11671279d50.55.1778242232406; Fri, 08 May 2026
 05:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777571962.git.matyas.bobek@gmail.com>
 <1B6ED5DC-6808-4A41-B8FA-B2C97C5C8933@gmail.com>
 <CAFEAcA9kQNdx=gwSd_Ec=R2nwegT1R-BEiC9yXvfr23VJHDZiA@mail.gmail.com>
 <936E6AF6-32BA-4236-B8A2-0A8E8748D9C1@gmail.com>
In-Reply-To: <936E6AF6-32BA-4236-B8A2-0A8E8748D9C1@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 May 2026 13:10:21 +0100
X-Gm-Features: AVHnY4JrGTYDc7zOIr6E9sjhStbzmsKbno1e2DoGqljKofnwcHTBRxQAsVlNITg
Message-ID: <CAFEAcA95RcGhhN8ZqVeOgRyhRqSar23EnJhCjVgKBwoqXBJwjw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
To: Bernhard Beschow <shentey@gmail.com>
Cc: =?UTF-8?B?TWF0ecOhxaEgQm9iZWs=?= <matyas.bobek@gmail.com>, 
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, 
 qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>
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

On Tue, 5 May 2026 at 21:21, Bernhard Beschow <shentey@gmail.com> wrote:
> Am 5. Mai 2026 18:41:52 UTC schrieb Peter Maydell <peter.maydell@linaro.o=
rg>:
> >On Tue, 5 May 2026 at 19:03, Bernhard Beschow <shentey@gmail.com> wrote:
> >> I guess the only open issue is the licensing of struct FlexcanRegs [1]=
 which originates from Linux? How do we proceed here?
> >>
> >> Best regards,
> >> Bernhard
> >>
> >> [1] https://lore.kernel.org/qemu-devel/202603211316.18181.pisa@fel.cvu=
t.cz/
> >
> >Could you say what the problem is? In general there is no problem
> >with taking header structs from the Linux kernel, as they are
> >GPL-2-only and that is a QEMU-compatible license. The relevant
> >source files or pieces of source files would need to be noted
> >as 2-only rather than our default of 2-or-later, but that is
> >doable -- we already do that for other things we have borrowed
> >from the kernel.
>
> In https://lore.kernel.org/qemu-devel/f3cb3166-c3f8-4ed8-8c9a-cbf48b071d1=
e@gmail.com/ I raised this review question: "The following structure looks =
like being based on Linux. Does this affect the copyright of this file?" I =
was just asking for advice and I'm glad the solution is that easy.

If the struct was copied from the kernel, then it's GPL-2.0-only,
and we should just note the license and where we got the code from.

If the struct is just very similar to the kernel's one because
it's the obvious representation taken from the datasheet, then
it's not related to the kernel code and we can treat it as
GPL-2.0-or-later like the rest of the file.

Since Maty=C3=A1=C5=A1 says in the cover letter here "the headers (struct
FlexcanRegs and flexcan_regs.h macros) were copied from the Linux
kernel" then we're in case 1.

You can mark this up by having the file's SPDX tag be
"SPDX-License-Identifier: (GPL-2.0-only AND GPL-2.0-or-later)"
Then have a normal comment in the file next to the part that is
2.0-only that says
/*
 * [This struct / the macros X, Y, Z / whatever ] are borrowed
 * from the Linux kernel, and so (unlike the rest of this file)
 * they are GPL-2.0-only.
 */

thanks
-- PMM

