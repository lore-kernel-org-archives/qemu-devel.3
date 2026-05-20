Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CD8CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPk2z-0008EU-9E; Wed, 20 May 2026 12:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPk2q-00087t-Ax
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:45:23 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPk2k-0007aG-BF
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:45:17 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65c305f381eso5447290d50.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 09:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779295512; cv=none;
 d=google.com; s=arc-20240605;
 b=UPDFeDmZRtgyHTuNvZyNEDX55uWXqM52bdy5W6BbPIVIFN1ASDFP7tDfJsCs0NijMa
 wP8mqBJ8vJMb1r5T05tkv7qmnciu/1u2GB6ZDYksMYQwnZrLb4qHr2mJCyRuMxKRtakQ
 nEHinaIs0nSX6ldA7Xth5KmYzf5TeQwPf1bVAGD4owiKFKmijK0A7WG11vERKn8Vfy38
 IVGb8xekxRR2ksK30vImyzS95Ct7Kdr/OGadGjh/kpW1jXIsMLLiG5MUfcVN3LtKO3TE
 DcRlZJjR7sIxAGS8N/27tZPIrzrH3w2vZ+SEgkj8HLHQ89cLZqfkTZTmJBcvFgOP5Bw3
 bENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=droMZJx7pXfLSThUKILFkjDK3IIj2NmJDNd7MmlvQFo=;
 fh=N29p/FXhNwoOx4NbE3K0Gis3hJqX3VFCNNP3tboacQ8=;
 b=gjIrRHvGOm2mqZO/vOlSQQmLeyDyXUxWFbEiMHHzw8qy+LwL4BBQ91G9a5MjCLrbVb
 /XwrNilg/wT8ITvN1hM6Jzlei/HWfkIHbpnxGzKWUD8qdbey4xMDmD5ISDaTR4e1alsb
 JBpyjRcNIlB8NG4mBo2jaMRuIxQ8K8cap/IL80x5t+Bje7hMTktGBuL+YpYns9iZnwAi
 zDse9LFI0vzZG1AMcBtaFzlW9xzVzsaRkei6JpJU7FfUkyn4syA02NyeqzXfZwKgzKU6
 qJG43TmRmfRTMN1LtjgCmxwcAucjElXrp8I+UlKXD3RmsIAkzUT84I7vJmkZDeIA3oGh
 64FA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779295512; x=1779900312; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=droMZJx7pXfLSThUKILFkjDK3IIj2NmJDNd7MmlvQFo=;
 b=UBCxhLm7Wgnb6ZiN3EtpYYI6b1u2OtuthENROn5jVLcVl3mhzW1WItBKU8qyDz/12V
 lK6T965QxYsv0IP9j1klSI8EG3HiDuv5cITgVOt9GpWwTISTR23WJJJSDQl3OBe9gGr8
 QoYnyswMcfPYqMYX+aG/rNCXQKFcgCYe2g29kD3/mtvMvcNj8pGT9il2z570IiLH4hrw
 OIMzNucNmm01G14BBOIwIwMGGUw2xgCi2F8szLiDv3G1jbf83/PgGcfvsFiYkkafm1ME
 jfpu5jjGxqZ1OQAHN79/SNyiVVssjPl/FzUkQYzonsczH9BuswxJpoaky0op4JbUgcXa
 iBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779295512; x=1779900312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=droMZJx7pXfLSThUKILFkjDK3IIj2NmJDNd7MmlvQFo=;
 b=UytvPvnyF/MTBw1MDeoDtXH/Vf4o5GDvs7OUQb9wMYEAGLMGrypcLa7iHFKV5vDwrW
 VeS/Ew0kjmO57K/p6KVptalZ+G7RtoWDYtYkVuX/fMYbsrLZXUn3/i+Fx6DChH5uCadh
 6VGO7Dk7Rr99RXWVIZaoB4EB3ewK4Cm0JnAdlI3fuVeOFE6nyMWkUhczeHOoPMEkfVNt
 z35pUCo0NGldh1ZnJxY35bAGp6js0wAXI2A7bcnDpWylLLZX1ePQorzRdsLtMZXw6YEg
 F20CtIefe0GnpASFnuIeNRrAkdwQWKAoDwk5qw9Y2Q114rJRoNw0mpdxW0G7NW9JOgPQ
 WjSQ==
X-Gm-Message-State: AOJu0YyO7ONuuEesX/kneURBtu/uxVeUZSp2ZtYrnFHVHEI6plL4DwFg
 ApHlt0eODZ4j9M0pfE90R8wG0/QmundgDEVMP/+sb99U+pcvILvKTZcjkn1NYoDqvLSYzgr+jSz
 t6l831G1umonph7uvrtykEpz9Jp6elQAwMabDctDz3w==
X-Gm-Gg: Acq92OG/PTZgibhBHhZ/1LPMtZIwbAJ5GNWm07o0Q6OjHRZ02BlHHnjhmBpc6klLZnl
 UixAnpa/TtEDPcNMo13N63mzXREAjdbtZ3Pur/W9gjn1Zm1MDn8DqSRCEOgzfiVhRgOSQzGeQa+
 sZ8VvxjgmgWBbdwTDUgxoej2DwCPNx8WkEEz9ENkCdeq6IEkSiCT+0D4yH4vapiQ5Ty0kJY7FGd
 fLehpQ13ddk0oK9yEXHeqo8sqxSQ9yjFezyjnjWPMZ+Mo+At+JiThSrqhnYkRIWa1CKWySHUuXv
 ZpMDGCBLg4UgsFvfELjXYFsoOuniZ5VakGi1RY8gur417t9BTaLMj/Go066R4NfsxRRml/U9zD3
 tHQ==
X-Received: by 2002:a53:accd:0:20b0:651:97ba:8507 with SMTP id
 956f58d0204a3-65e2289b759mr20898368d50.59.1779295511815; Wed, 20 May 2026
 09:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260427124738.966578-1-peter.maydell@linaro.org>
 <20260427124738.966578-40-peter.maydell@linaro.org>
 <574480d1-49db-4ee9-981c-580d4c2db3b1@linaro.org>
In-Reply-To: <574480d1-49db-4ee9-981c-580d4c2db3b1@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 May 2026 17:45:00 +0100
X-Gm-Features: AVHnY4L7dDkuxP0IiFoZt42v0be-JW7tgHrvvno9aN6W31I6t79EruzWT1PVMYs
Message-ID: <CAFEAcA8SN=H+d1OzcRWBZ6kBnhFqVAY0_77Z+PsjdxwAnT4gEw@mail.gmail.com>
Subject: Re: [PULL 39/63] hw/display: Add i.MX6UL LCDIF device model
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yucai Liu <1486344514@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Wed, 20 May 2026 at 17:33, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Yucai,
>
> On 27/4/26 14:47, Peter Maydell wrote:
> > +static void imx6ul_lcdif_class_init(ObjectClass *klass, const void *da=
ta)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->realize =3D imx6ul_lcdif_realize;
> > +    dc->unrealize =3D imx6ul_lcdif_unrealize;
> > +    dc->vmsd =3D &vmstate_imx6ul_lcdif;
> > +    device_class_set_legacy_reset(dc, imx6ul_lcdif_reset);
>
> Please do not use the legacy API. See for example this commit
> to convert to the newer API:
> https://gitlab.com/qemu-project/qemu/-/commit/ce788d3740f

There's not really a problem with continuing to use the legacy
reset API for this kind of "leaf class" device. It has identical
semantics to just providing a 3-phase "hold" reset method, the
compatibility-code is trivial and not a big maintenance burden,
and we're unlikely to convert all 400+ existing users. (Unless
somebody figures out a Coccinelle script for it, in which case
it's just one more file being autoconverted. IIRC the hitch
I ran into was that you need to determine whether the reset
function is called by any other code -- those are probably
not autoconvertible in the way "function only used as the
argument to device_class_legacy_reset()" could be.)

thanks
-- PMM

