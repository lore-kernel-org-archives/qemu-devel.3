Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6212CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkGd-0008Ii-O2; Mon, 05 Oct 2026 11:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDkGP-0008G5-FM
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:06:02 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDkGM-0005oL-Rl
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:06:00 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8ab37e44643so13239567b3.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 08:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791212757; cv=none;
 d=google.com; s=arc-20260327;
 b=iwzEYBJqgJQj/lZnnSTNdgCDTl8C1hfVUFCY3eG9d7qLp+3ld+BepxYfHmbkjZ1AB2
 b7DV6k2Y7WbOekj5YfICWvoYi7BT6Oc52uy/JoKLkfsEY75BDqIuHTDxRN52vAGyWk94
 I5zDdzEM0A/ui0Tr9WtUhkAO3TUfFt7S/Ztc5CVg7YVTaOTkBW1xPu7YNrdx7HD2c9nq
 /u+aV7wyz0AUqzBDKl1Y5Hy358IF45WovRVmKJ+ISI7u6owMw4ziwHrIBiWOjBvOGG0q
 Z7hFUJUUrY/jkvXiRZsHf+9JsI4d1rmagUyZpJjW/bGGchb8VMQEcWN6s7CxxXalYgva
 +sew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2sGFBf4wmaMheBhnmNd1s3L4v+PoOPdqTDVFowvlh94=;
 fh=n5bJ3LyX3XR59/fqwiCDFYXcbJtA8CwqKfaF7j3v2Ic=;
 b=jsxDuBfl5bhOqlHlUpblRiOjHaYUTsA51pG3B+AvhsyZaU8n1DbltmA6qjnfBUamZb
 2iUrZayx7vEm9UJy04kUw7GHOyhpWXsTXHMG7N98HzsQJN+wjplrDFGAFcuXtC0xqrCb
 COw106jx32zrSHNW7dDWvXnx8bSWehGyGrc2xx1cTbGSdC28w8Cz9cfcz1rj2HgKVjaf
 o1URDoDmie9YZ7JziTETidxb0VYkZWqZeaW4bsPg4y1UWzaeeTVoUN7R+vw4Rr+8i+oh
 4Y0mXUTdIMC9+6+kUZCYjAyqejcxOihGbnFdR2ipEr/eJVAgvNr/zAx18v0uiPVsFGx/
 x+sA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791212757; x=1791817557; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2sGFBf4wmaMheBhnmNd1s3L4v+PoOPdqTDVFowvlh94=;
 b=LjX8/2xxAe1qbkCphuG3D0tNlXGh5czmBymHtGZya84pQNtshrAu226LBvE26lF2XK
 8HIqRMniTq8qdOq5QbNgCclzBuDp5FUvuNBb8/gYMixE/4+RdAo3jio2O3fPgpefqa9y
 jz5ac/RXshNji2GA7izRXJQ3mmqxfAbOpX3igqLgby7nFt/kCwYSMam4MyybUPP0pdmV
 otBB89WUO8frqYuducN8DM94kliqCl7g/XM5YNscjENmdsF6RNKVMWRIY33qqUnZ/C7Z
 x+hGB7oCvqb499r2XU6yd5HPXfNqihr+h72I4SRGhMB9Kst5yNQGcsYb+QU9ZDOQHHC0
 rvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791212757; x=1791817557;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2sGFBf4wmaMheBhnmNd1s3L4v+PoOPdqTDVFowvlh94=;
 b=kb7+HTdjddKPKhV+A2wMx7VEZuE7umC+fDglcqaj0OU0XF3FVumu4TZ2dH7tj36Icu
 08Oe4vXX+SLSnd5Bj/OozvlbVPQZADxjpBMHFuJkt4M+qVFZufVk1knLsvYIhtF8De6V
 vjoxX7eAyvUEkhAbfXFbd1xP4q09h/EZ6xN/8ikWGYbwZxMkpukXpHYwhPzJvCMPir3z
 C3NoTU/xHa3kN8ycJurfsUTfH3KGl9HRdY2CmNCrJB2fY9ksq7ErQJt1fdz4WbySoLTT
 ZnKdnd898aA1PpQJ/uSucjkdgmvHLXTAYcuW/OnJZnagTCzYr4parSBM0qJUCy/JuckZ
 CSmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSKUDID0m1nmqrof4mIwYkPuH1Issy/zGq1QnkE+oIO1x4ctDG19Yia2gsc3SM+YZxBTgb5BDupfTd@nongnu.org
X-Gm-Message-State: AFq9FYKv+X6Uy7s3xwsLUpHByMHm+etG1JeTz0dAlnF0qjlX6XwoBoso
 3zC1rXz7MDapNkz3yXELqAsBJPpx6dKIC8Pc0iD9giVyOWd4rNXrJrvKUtcEkNtqVj3NFI73jqt
 QT9clsifYwqJONJoTash9t0wx2KD8hWgsNnLPUaw+EA==
X-Gm-Gg: AYBFou1kjmd/sn+yhflhN0U+VjLxpCFM1fdOh+RUXaDpXgiVaEX0cs7x3oCn9mH8k07
 ACcQ7cYxypyzZX0xzR65tZ3adCIMJVGiYcbPYnGySqG7fss+Fn9EcX0B4ioQL/NAq/AODuTLKjL
 Sl8+ORuIyf6B+swrUK8xGCnAKpbTzrneSdvZxdnR9NKexLaTawXtDQU+F5uM6jxnYsWJKYMlVSY
 m4Rg2w18CwRAkBAsTdMAloBD1yGqiLX0j9OXn6rgYpM7HlSIZFdHt2bruF4rBKlcrQBp4RRaerf
 uDgUwr5PyEW1lmGkaKXblc3kY4crafo3qCHzfkjNwuiSsov8vbs0HXn+rklqGwVyRtuQ0pvzVKU
 iWUEICZxGlwn61154DeXtcmbACUDHDj/NZzJPRndk
X-Received: by 2002:a05:690c:67c3:b0:8ac:c329:67c5 with SMTP id
 00721157ae682-8ae94b38657mr28701737b3.6.1791212757349; Mon, 05 Oct 2026
 08:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260921214710.29422-1-shentey@gmail.com>
 <8affd0bc-1c2f-488c-88b9-af3fd7a6571c@oss.qualcomm.com>
In-Reply-To: <8affd0bc-1c2f-488c-88b9-af3fd7a6571c@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Oct 2026 16:05:45 +0100
X-Gm-Features: AclHuK81bz4IOIA3wj40cqGVFSp18As7_4HqW2WIzAYWDo7oZVVP788ziGIl4KQ
Message-ID: <CAFEAcA8n73edkk2PNJO94_yO28Un5w_AYuHU5UW4yNe33P+qtQ@mail.gmail.com>
Subject: Re: SysBus reset and heterogeneous emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>, 
 Alexander Graf <agraf@csgraf.de>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc@lmichel.fr>,
 Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Mon, 5 Oct 2026 at 15:35, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi,
>
> On 21/9/26 23:46, Bernhard Beschow wrote:
>
> > Patches 11-15 turn the remaining i.MX SoC device models into SySBus dev=
ices
> > which fixes their reset behavior.
>
> > Bernhard Beschow (42):
>
> >    hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE
> >    hw/arm/fsl-imx31: Derive from TYPE_SYS_BUS_DEVICE
> >    hw/arm/fsl-imx6: Derive from TYPE_SYS_BUS_DEVICE
> >    hw/arm/fsl-imx6ul: Derive from TYPE_SYS_BUS_DEVICE
> >    hw/arm/fsl-imx7: Derive from TYPE_SYS_BUS_DEVICE
>
> These patches are described as:
>
>    ```
>    Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be
>    reset upon machine reset.
>    ```
>
> This is correct for the current state of the codebase.

Yes, and I think that until/unless we sort out where we want
to go and can merge TYPE_SYS_BUS_DEVICE's features into the
base TYPE_DEVICE then we're better off having devices and SoCs
inherit from TYPE_SYS_BUS_DEVICE than from TYPE_DEVICE.

> However
> I'm foreseeing a problem in heterogeneous context, having 2
> SoCs (like some Aspeed boards), if one SoC is locally reset
> (i.e. a software reset), then sysbus will also reset objects of the
> other SoC, which is unlikely expecting that.
>
> CpuCluster are not impacted because CPU types are not sysbus
> based.
>
> Sysbus API was designed for centralized memory bus and
> non-heterogenous machine. It is good enough for whole-machine
> reset but does not adapt to per-SoC reset domain.

Yes. Even in the heterogenous context, if the only thing
guests in practice do is "reset the whole machine" it will
continue to probably be good-enough. If guests want to be
able to do "the BMC CPU resets the application-processor SoC"
then this is one of the things we'll need to fix.

Ideally our reset API would both (a) allow you to model an
SoC's reset handling correctly, whatever it was and (b) default
to something that is at least vaguely sensible behaviour
if you don't write any reset-related code. (That is, I would
hope we can avoid "every SoC object has to write extra boilerplate
to handle reset of its child devices, and if you forget it then
reset silently doesn't work right".) Figuring out how we get
from where we are now to where we want to be without breaking
all the existing machines is then the second half of the problem...

thanks
-- PMM

