Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AEEC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 09:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tesQi-0002xQ-6a; Mon, 03 Feb 2025 04:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tesQg-0002ti-8I
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 04:07:42 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tesQe-0005uT-Lm
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 04:07:42 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso3416889f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 01:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738573658; x=1739178458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+u7ieSnHPzhbS8BcsPNz7O/BKqonuuqUUAPrQD84W1Y=;
 b=m+kRg/d9kqZmtSYKEBD0J9KImYyXzvZ0wjZ3EvP4KYR4MeIPMU2QmX9kr/AKUbOmK9
 0oeKpxRmIGKE7DEZMW8KyTGQOxfKchM7mGpqwx5UhDnfHYfkyPpV5mUGspmBM4cbhezJ
 jY7jK/RrwzrbE0bRQAYra5rhh3NKjnuC9FLKVHX1UKzgmI6pnLxV5DK547UNW93KIBib
 NJAUGOuOHZMV/JUR7VNLygYAYvRtBRB4dRwOskhmwy4cFDCdvfFoEXeOyIZ6MfkMB1ED
 F5e9zKQ7nW38YH2UI9EJQwi8mqNOuA5WdLuOaUx74MfO1rouYIO7zl6PkfcJmhF1FtXi
 hntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738573658; x=1739178458;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+u7ieSnHPzhbS8BcsPNz7O/BKqonuuqUUAPrQD84W1Y=;
 b=OquFdERCEruk+FlctNIb4HPR+wI7dMhrtHyKZfUr0yKLiALjSKa6EJIOUeLqzYNpRv
 jk2qwL6VQoltgg5/mqWkAvKUSDU7O0Ki9Z/QO2F+emhVr3gxlktDXS1fGWnxLFig5NBh
 P/Eze2++inRpkTJi+fPjzvIP6829ikpUYI1WxBuBawZSco+jUg3HHQwijbAB/Dqveulo
 Lxwf0hHaVSxKa1XXuIicvncNfdE/hyQsdtsejbEYwBX/D4oMZ/C8qKjqOy9ClitIN4Tj
 LRXUP+L/sFZL1ZtaKfdGfD1GaswXnKiIDz4aYOVvNXcbK0eymZ2QhyyYyIsN3Ois0V84
 nEkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd2ZO+a10cBlU03UDnfug6YuAJPBxlmdyRnRiYa83k8y/05/g/yWuLYbBC1uVtIWK/sRV/Vmd2Lpg3@nongnu.org
X-Gm-Message-State: AOJu0YxcZMnhrrPrO3gZY2SG679GBCkIkCnVNNecCjtpxG+QYRDLfBJP
 8elSF1s50uJiLE5EZ+f1xQRJ5QyKJ505iBW/3xNUQhcLS5aT93HEB1cioTW+iZo=
X-Gm-Gg: ASbGncuzsDyhWXfWqsRBJHXzRSmtzchU/A0sjEQHYGLusyhyyoE6+zcHLaCYqHe2jUK
 SInIKZYJsla0MIRPWaGPpaxZqD8W7TCwgiHzmGqWEWgJUtztuXWBcFJ3t6PEznhLOAHYhPIQj3l
 sBv1j6//F2Hb4K1FfCAKCHE+wyhzmR0vmgG0K/GJPnBTtEp1bYAlIzn+AuaJCTY5il4yc+bXm1O
 PUuIlr+feCIhV41glFX7f79h30HqjDPzDThSJ2bhAXhduyJ1rT6NyxthsD/VxmG8gu0RPa4sHsj
 GPkUdnRAzm/2vhp8RQ==
X-Google-Smtp-Source: AGHT+IFAZ5dFeik0mrVs5ZR7N3uhfSOv075Eg9jc80RUuJCDaX48FJymoGDlLWrvO19ByDc87Ds5kQ==
X-Received: by 2002:a5d:6c65:0:b0:38c:5cd0:ecf3 with SMTP id
 ffacd0b85a97d-38c5cd0efe3mr13470807f8f.11.1738573658573; 
 Mon, 03 Feb 2025 01:07:38 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6ffc9eb9dsm516085866b.27.2025.02.03.01.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 01:07:37 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EA9665F9DD;
 Mon,  3 Feb 2025 09:07:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>,  Vivek Kasireddy
 <vivek.kasireddy@intel.com>,  Akihiko Odaki <akihiko.odaki@daynix.com>,
 Huang Rui <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Gerd Hoffmann <kraxel@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Gert
 Wollny <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan
 Singh <gurchetansingh@chromium.org>,  Alyssa Ross <hi@alyssa.is>,  Roger
 Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,  Alex Deucher
 <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Rob Clark <robdclark@gmail.com>,  Yiwei Zhang
 <zzyiwei@chromium.org>,  Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH v6 00/10] Support virtio-gpu DRM native context
In-Reply-To: <5aedf1ad-d9b0-4edb-a050-f3d9bee9bccb@collabora.com> (Dmitry
 Osipenko's message of "Sun, 2 Feb 2025 18:17:43 +0300")
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <87cyg844fr.fsf@draig.linaro.org>
 <5aedf1ad-d9b0-4edb-a050-f3d9bee9bccb@collabora.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 09:07:36 +0000
Message-ID: <87ikprflbb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 1/27/25 19:17, Alex Benn=C3=A9e wrote:
> ...
>> I'm still seeing corruption with -display gtk,gl=3Don on my x86 system
>> BTW. I would like to understand if that is a problem with QEMU, GTK or
>> something else in the stack before we merge.
>
> I reproduced the display mirroring/corruption issue and bisected it to
> the following commit. The problem only happens when QEMU/GTK uses
> Wayland display directly, while previously I was running QEMU with
> XWayland that doesn't have the problem. Why this change breaks dmabuf
> displaying with Wayland/GTK is unclear.

Ahh that makes sense - I obviously forgot to mention I'm running
sway/wayland across both machines.

> Reverting commit fixes the bug.
>
> +Dongwon Kim +Vivek Kasireddy
>
> commit 77bf310084dad38b3a2badf01766c659056f1cf2
> Author: Dongwon Kim <dongwon.kim@intel.com>
> Date:   Fri Apr 26 15:50:59 2024 -0700
>
>     ui/gtk: Draw guest frame at refresh cycle
>
>     Draw routine needs to be manually invoked in the next refresh
>     if there is a scanout blob from the guest. This is to prevent
>     a situation where there is a scheduled draw event but it won't
>     happen bacause the window is currently in inactive state
>     (minimized or tabified). If draw is not done for a long time,
>     gl_block timeout and/or fence timeout (on the guest) will happen
>     eventually.
>
>     v2: Use gd_gl_area_draw(vc) in gtk-gl-area.c
>
>     Suggested-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>     Cc: Gerd Hoffmann <kraxel@redhat.com>
>     Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>     Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>     Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>     Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>     Message-Id: <20240426225059.3871283-1-dongwon.kim@intel.com>


Maybe a race on:

    QemuDmaBuf *dmabuf =3D vc->gfx.guest_fb.dmabuf;
?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

