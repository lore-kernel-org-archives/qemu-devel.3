Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DAEFC9EF8
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 13:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyrso-0005x5-2g; Sat, 07 Mar 2026 08:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyrsi-0005wi-NB
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 08:39:48 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyrsg-0001Kf-Fs
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 08:39:47 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64ca423ad53so9013396d50.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 05:39:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772890784; cv=none;
 d=google.com; s=arc-20240605;
 b=khbgv30BCw3TOhDxHfw42h9xubDS9r2Pujqj9RR/+P0JypQL/0V4j0F5K/9kKKMpce
 HMfA1Pf5VyOTsCqAtSLxlL3yRH1TlVoSGCDKVueNWb7v93SPTWVRNYoAnM7cgi1iukZV
 Hyr34mT+5rHFogi4WIFBojTa/stPYTc0ASJSMfDK4UxJ1+23pXZ6FIcr58ISlJuxVRsS
 +9Uo0c5f6727nIf46/TqZoZZzYBquch88I84EpZBYyxqiqt7/Q8pMHk5egMEJVb4cvoP
 JPZQ1Awd4wtWi5pg35ebilfafIQvGNWwoLFzbFXGrF10jVcmrcAxhw3GdSoMhLYIrL/4
 ZyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HB3dDlxQtomq6yCpxU8XqLsGS/PgsQKprOHy4Shkngw=;
 fh=jqTfDgkR7vwn64q2Vaa4q9YOuWghh5CT9PFUDCOnVTY=;
 b=TRjcL/iX50QdaTV/JnRX45+bkF9TEgHwZ4wAZhB6XD8cownblO7N5OiK++jq3SyuE+
 88Cs2HONLrEW1CARTahZS8zKN1AJ7o522mSzeXg84BxSisxaLxWMbYFUlZf8i959FAsQ
 kNmGgFLkjd0cR0Q1I4d0a4BOBYbeu7b4XgyhKu7ejWgMLmwr7fvkLnhiwFQ9kvub2NK4
 y1isiuyifHAt7f0PCDuwcJ/ttfb/KY83n24Q4PvLc1AYPBwevXjukqhVvdfhehf7jmJJ
 gs3lmEycZgGWXhOrlCGp2ygWkx87bXGbA9goW9qFwANpqDOUuO/KXU7h2ZZSRyQXA4qf
 6b0g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772890784; x=1773495584; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HB3dDlxQtomq6yCpxU8XqLsGS/PgsQKprOHy4Shkngw=;
 b=OFr2+cCFnxirjDiZZGOpr42In6Rwi7t/nWN+7glK/iFpHwZXyng6bM5I4OXeJ1JEao
 6lTm6KtaYSMoUuOBKdpDUBx+Bb4dEV4qUSh/53UaSxyOaVVhIN20l3DGeCdHr+WFojgP
 cVrHQESmeNf9KCSDzHUlWCegdACnwHkIJanFiICcB0sLlEQ7T6WYAIoBFNMQW/KZ7lFF
 R/6b8Ygdhh3aO/qHRtH/+rqrBRr+Ny7+0ZxA6jACmfvmpf5AAAOpdTMBUGc7k8XzBq5u
 JPfGxd9lcBIM51ZYXLFFI6rW8VMxL++U2Vcj7o5t3brjY918Af0Wbcm5c5Me4l6hp5pj
 L8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772890784; x=1773495584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HB3dDlxQtomq6yCpxU8XqLsGS/PgsQKprOHy4Shkngw=;
 b=DvrmAIL4PQww8gSrXWj2xSdkanOQF9J8dq3qwZAs7PkkhSI6adaxpaYS3239MmglLR
 lKdqqTBofa7IgmG1QjRAoxzF5baKO1PQAnND8HAdsDkdqXs7RNz3jpc5MNyiMN0KFmRM
 5hN9s0Gjey4iHayMDMXwB9uioh4zQ0FTVhHraQwYBQHm2cQmqFgZl4ZoL/VadfpSVuLL
 LroX5a2neQZsA5fre12nquQ7RV8yuZT8kfkOHlHXmKhoWhks4uBLfOiWBtvLgyIIO7F6
 5fBCv6Tyn5rSL71qgaRa6IXd465dU/QPrUguYHWmJOPjS9g+BDYjLFdNh82/tfLDEe2o
 45xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnYCn3hak7L60r8wmSdHu2VF2bWX2fVWHI3OD1yHDIf+R2fp2NdYp9l+XIPewuYCV9uD+1zcC2p4Qi@nongnu.org
X-Gm-Message-State: AOJu0YxmEQzFJoGfisiJmjIXyhh0B/hebhxn8Dk5QYWlR5ayktyH/IFf
 y/QMFmGxtHeWyqQoZYCycsFoCt5EK32P3FqfZdhq5X5N6YFOTgW00LXj57/JhHthcocEH3RU5Zu
 0G64VEvU64MZ0GjyDLwLqpSMW1+MEoYoAfB0HIhb6Eg==
X-Gm-Gg: ATEYQzxszHw1GxxZG57cewMEv54xqdJXHNIVlWMdBUyq/nkxfjwOv7eJGe9X3l6iTod
 Tt8Fflqi1sq2PZLzgjchi3HbS09xifGjs3+6/59ys3KmSBmej0xnQlU5OOxtIDn21rGKT9okiAS
 W8uKgZKxHL/9lI3N+ZbrjP1K5tpAnv1HDF20kex4b9HGmCbMF/idMJlYS7hU96ijIcb5PWh0Gww
 qZGTXSMMHJgw3FKNd9LAPdlAHSmZU+sKqOC2xbQ8Mv0M9kgq9sFxK34dRKwKMjNUNgOOkgJRwfc
 Ym+4wphfB0wicijwEldB63v0C7JPDN+nwARmU3jtkMr+2Fx+SlZd50d5C4IfApJV4Qp0giSQ/56
 ZpQ==
X-Received: by 2002:a05:690e:12c1:b0:649:b00e:6930 with SMTP id
 956f58d0204a3-64d1427cc0fmr5101164d50.48.1772890784470; Sat, 07 Mar 2026
 05:39:44 -0800 (PST)
MIME-Version: 1.0
References: <aNLIHOwcGB47qbUY@redhat.com>
 <20250924093138.559872-1-alessandro@0x65c.net>
 <20250924093138.559872-2-alessandro@0x65c.net> <aNO7J7Y6wsk1-wyw@redhat.com>
In-Reply-To: <aNO7J7Y6wsk1-wyw@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 7 Mar 2026 13:39:33 +0000
X-Gm-Features: AaiRm53QvxubNR_MnRcG0Ghq1zE76sDtznkach23HBHIaV3vdaeYGVDa134RWuY
Message-ID: <CAFEAcA9oKbFi7hBvKcz_v_xWtHaPz4n3Q_cVEai1F1kZnr5PiA@mail.gmail.com>
Subject: Re: [PATCH v3] virtio: improve virtqueue mapping error messages
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alessandro Ratti <alessandro@0x65c.net>, alessandro.ratti@gmail.com, 
 alex.bennee@linaro.org, armbru@redhat.com, mst@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 24 Sept 2025 at 10:37, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Wed, Sep 24, 2025 at 11:14:04AM +0200, Alessandro Ratti wrote:
> > Improve error reporting when virtqueue ring mapping fails by including =
a
> > device identifier in the error message.
> >
> > Introduce a helper qdev_get_printable_name() in qdev-core, which return=
s
> > either:
> >
> >  - the device ID, if explicitly provided (e.g. -device ...,id=3Dfoo)
> >  - the QOM path from qdev_get_dev_path(dev) otherwise
> >  - "<unknown device>" as a fallback when no identifier is present
> >
> > This makes it easier to identify which device triggered the error in
> > multi-device setups or when debugging complex guest configurations.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1919021
> >
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> > ---
> >  hw/core/qdev.c         | 29 +++++++++++++++++++++++++++++
> >  hw/virtio/virtio.c     | 15 ++++++++++++---
> >  include/hw/qdev-core.h |  1 +
> >  3 files changed, 42 insertions(+), 3 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Hi; I just found this commit (now e209d4d7a31b9) in the course
of finding a memory leak in it. I'm about to send patches to fix
that, but in the meantime:

We now have two different functions for "give me a nice string
that I can use in an error message about this device":

 * qdev_get_human_name(), used only in hw/block/block.c
 * qdev_get_printable_name(), used only in hw/virtio/virtio.c

Can we please have *one* function for this purpose?

I see from the thread that the criticism of qdev_get_human_name()
is that "it often returns opaque paths like

   /machine/peripheral-anon/device[0]/virtio-backend

which are less informative in user-facing logs compared to PCI IDs or
user-specified names".

So could we instead make block.c use qdev_get_printable_name(), and
remove qdev_get_human_name() ? It also is using the result only
to construct an error string for the user.

thanks
-- PMM

