Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48400D44C73
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 16:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgQNp-0000gj-0I; Thu, 15 Jan 2026 11:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vgQNM-0000Wo-Qd
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:39:16 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vgQNH-0000xa-S5
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:39:11 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-50299648ae9so415311cf.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 08:39:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768495146; cv=none;
 d=google.com; s=arc-20240605;
 b=WrxynN7xIUt1jH8ekSbp2bjZKda4sDmJxZxBALcvZFrHCQFK4FLCOLQeJKSm3n1ya/
 ms8qarwZZIad5qDTLR5lp9GTMPQmzWtH54nkmolxDzRlxW8btvmMFuIBZDvAdwGOQ6Vj
 Owol6ZoQg+AKwbe/uFQqjPotcxkZajKYKK8oxRB5WYxxcJqurIlW8dSp9qetP4njIxhs
 /mPruUfHU7ypjsNPnp0erDNIsYWFNK1POta5NNxU/QZ1UF60BQriG7EZlGVRC+7AdBll
 f+8DrAqWVLGC4+nHUd6l3xYVyqsY1aw8LTDqxUbH+xWIRGPtiTLhYCGGFboSe6y7ChF6
 rBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oK2WVjc+wwnUjPsvrBzcMPY65EU7hp/7IhhSgu3vwgg=;
 fh=MTg3cpKNU16Psj8OTgZ6XuS1+p/YgnCppbxX4PEdnY0=;
 b=fDxHJW//HWEHBpYgITZ3fNxUWhvG7xIuA5Bx+Ap9AYb7NeVhAFpD8cpvc1U81gdYb0
 ETh6hCJ7nldiVYVe16wVcvbuUkubbDFih/S1MaaruiD/LQPK0HS4nCvc4buKm0VVXVTA
 XADPegpRBZCmoX/gRnWVY/MJELq7jnVUcnzQEg+h0blQTQhvPEbXd5cbqVdFOOF8CzlF
 UiLLs86/sZZ/WTTsSia+oX8uhyc8HKjSIE75pBTgcjDTaU4/lUU3HrhdUHaFfILZkgJE
 xoAtQ4s6ZQE3ABWMHRxuYAIGy5HYXna5IMQ3YYWcUZ0H13t1VEXrMNh2dRcz6N9pwtFr
 hhZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1768495146; x=1769099946; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oK2WVjc+wwnUjPsvrBzcMPY65EU7hp/7IhhSgu3vwgg=;
 b=T7SM6sFkPtLO9MRfCTfuDENbjFoLHXBu+i714KZyvb5AQbUfitP/j5I3bJA/xS3N0E
 wD9RaniUlCO+go4aReLeE3o4062oANdCGMK+QWy4vjTAcpe8UD8vBzjozLe8uuVjMXkn
 W3g6JxEYKVt3ZYUEq8BjGTwLWvLDWgC9TNYFi1fFMqEiVxySnOB1pKJsIugiU2VJE61D
 IktpADvvWrANVnVzehhBdCRPem3/WeJllhu3iaFBiOrJiNlJ+L+eFM48rw8dcLC9vPRT
 Wv4HwrIqHiE/njeS++sgPLWA2oNed1b7LQsJ1jxg3azi3a+zLh2ehq1dXdCqR8Cpa74s
 hN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768495146; x=1769099946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oK2WVjc+wwnUjPsvrBzcMPY65EU7hp/7IhhSgu3vwgg=;
 b=Ac2OQ5GgCgIFVk1kbz4sIwpz0fxghAleBGKhdc+geT+U4HoA7PBA/WvQxYo/T/+lAu
 WnjnMZ1XN82a64U4gUFZhhFOgA0cZFsS5XiL4353ccLOxfxYh9DH0VyaLc984a2382tb
 nlGtfgrvSTeqK6VaGfMuYnhWdTFNo7w5ASk0yCxs5Q0RiP8AGHOW8tEV0R8C9zGxCWpU
 atDCbl9MUAU4CwTz6KMi6GjnaL64la0Z0irc0exL+Q61kDbmxwcR6RTsE+DSpki43V2x
 KeEUzD2OGGTi76iQhil2FUplyXJSfkxBRqiAg1DxZk71Rnba5xDsQwoq3gdaiaOD+7Ht
 Qa3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWErGg3L6fLKeurzeFhDnoU+rff8yqlWZ+auKMnXG+KosqnHJlvlNQxdNqr5iJAtxdMtYKpYev/jZQi@nongnu.org
X-Gm-Message-State: AOJu0Yx64UKnQSKwYMNtov886JnGlGASNwkbHGW2JtRxFFgzYEH0+j7O
 nBCiP4yxyMavCv7N5IkmD+vqQ0MRLapoDLtme1IL/9mob0SZ2benUwHHaLyDoGxRk4nggeKfL5a
 chtQF4Mvoa03Htg0is5JEDNgl/4CHQksxNjPn1+XP
X-Gm-Gg: AY/fxX5W9cEOIAnA/VyePLizncY2WCzQcCgSz6hr0/jYEJvEGCGBg6yKNnCuv0Xse9H
 lOVqdnr97r2JyNXYwCu5O0ERObvoOZXFCEjod11ak3EyMmHWWEZIE3e6OdH1vMx31ShW1I0hZ/f
 OjEknivXxP2ZtFYDyPmKXmOSbjaam7oWR1HtdiVhYGVRbuSx+bVGpuEJa7V5tp1B/jhi5JqQbNb
 YLf7JIotFqdCi1WbTfxjpzaRYyxxZpUWq9FYekJoIrnkZx1XMfrdk8GSmjuPdGeqck/65QkZAGe
 gDc68gg7KDYXClvq9fkP31OEQw==
X-Received: by 2002:ac8:5854:0:b0:4f3:5474:3cb9 with SMTP id
 d75a77b69052e-501eab81fc6mr10677151cf.14.1768495140279; Thu, 15 Jan 2026
 08:39:00 -0800 (PST)
MIME-Version: 1.0
References: <20260115023758.3600447-1-jamin_lin@aspeedtech.com>
 <20260115023758.3600447-2-jamin_lin@aspeedtech.com>
 <CA+QoejUkn14qq49A5RF5iVUCrcdBN077Ce0FZSw8sWAQ+vU3EA@mail.gmail.com>
 <157bdec0-64f9-43b8-b42c-cf29a34d083b@kaod.org>
In-Reply-To: <157bdec0-64f9-43b8-b42c-cf29a34d083b@kaod.org>
From: Nabih Estefan <nabihestefan@google.com>
Date: Thu, 15 Jan 2026 08:38:48 -0800
X-Gm-Features: AZwV_QhtqCM1UF8_0GsKPZhLPUKCcOOl-uOdhPmDBSM9ANRyZK6NLmokHJ1tMVU
Message-ID: <CA+QoejWGVptDvMQmQywX5N19mdyWM0bWVkM12U7GR79L8Y4sPQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pc-bios: Update vbootrom image to commit
 1c8e9510b22c
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, qemu-devel@nongnu.org, 
 peter.maydell@linaro.org, troy_lee@aspeedtech.com, wuhaotsh@google.com, 
 komlodi@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, Jan 15, 2026 at 8:21=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> hmm, I didn't receive the initial email.
>
> On 1/15/26 17:19, Nabih Estefan wrote:
> > On Wed, Jan 14, 2026 at 6:38=E2=80=AFPM Jamin Lin <jamin_lin@aspeedtech=
.com> wrote:
> >>
> >> Full changelog since last update (183c9ff8056b) :
> >>
> >> Joe Komlodi (1):
> >>      npcm8xx: Fix u-boot copy size
> >>
> >> Jamin Lin (3):
> >>      ast27x0: refactor FIT boot loader into fmc_image.c for future Cal=
iptra Manifest support
> >>      ast27x0: Add Caliptra Manifest boot support and MCU runtime loade=
r framework
> >>      ast27x0: Fix compilation issues on Ubuntu 22.04
> >>
> >> Compiled with gcc version 13.3.0
> >>
> >> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> >
>
> Reviewed-by ?
>
>
> Thanks,
>
> C.
>
>

Yup. Did the same mistake in two separate places.

Reviewed-by: Nabih Estefan <nabihestefan@google.com>

Thanks,

-Nabih
>
> > Thank you for updating the QEMU binaries for the bootroms Jamin!

