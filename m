Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF491C02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 19:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf2AB-0000xZ-Pf; Mon, 03 Feb 2025 14:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tf2A3-0000wa-7x
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:31:12 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tf2A1-00018C-Fq
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 14:31:10 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso942147866b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 11:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738611068; x=1739215868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2uzMVsyqHJZjXyRwSimA4zzh4ZwpwjzmtUnkhXdsDlg=;
 b=TR07fjDtuFKNnqOHOOrxj5ZaJzD5pmI74Rppe8YYTJ61f/2Jb1JZD8O4ATCw4DyvXL
 2sO5rhatvEiR4ckyxv7eqCG18j7lVGOF4qP6szVx/hgC0BILTHMFlyi3fpF/M/C7Vg/g
 QkrzdqLD0yy5tccoWrUCVqqXz8fFe8JIEgbNbEM5qTX1gPIeMU6oJiFL/gY9xMpSmDjb
 7rL7Sn2aJUcQLm/qyWxY1b2LOu2wJwNvIBumfPT5MDbhrflkqevfAGIikglAAVkMi6Kj
 135WhaJy12PLOoWO8uoZ+Vv0svwwb5e9627siqoUrFoI2bek6LCYJBty0CPEwLl2+jgn
 S8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738611068; x=1739215868;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2uzMVsyqHJZjXyRwSimA4zzh4ZwpwjzmtUnkhXdsDlg=;
 b=AXjkvyHW0BNPgPMYz8o/Aa9IlI+D897LIsNiBMFDQ7uiTmDIOXR2wuG5xazrLga6cf
 jtnB8I3tFcSl13St7SbVFPyWTn7AhP0b4iU6W0FTmRsS8UzoMchAGHe5Djigmo9xjl+p
 2RxBnQE7nYkab5BEAHVL5XNu38cWgdGiuBNJBHtqmrSoiddCehiPUfdvt+kTML8it+jz
 YAkckOUj5LSh2CEfQNDldGNBe+Hl5+Xhlqkrx2KPxLwucdP2YyPGyN2JFSDBie9xsFRH
 OYlvMdeMnWv53fEbZvWj5A7EPs6CHBW+30CGtEZ4yM2LjbPIFBje3CrvgVD7/Ek/c7co
 vuKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj9pJ+6thX9Sq0zu49tdfW6K35S7hr7Knh0JyFpxO9EjD+e2xFpjxkbW6+xu6b0i6aq2JS3OLwfB+2@nongnu.org
X-Gm-Message-State: AOJu0YxdznOhXl5pPGwvKZR2tTHds8Bw4uuxnbpzKfdFBUFcifBG5H0T
 L4Ah8CowE7CNXHm/tYZXb3xrEMuL/hTmJSBXnR/Izl2EOMQzyL0Gi8VQqmMbA7Y=
X-Gm-Gg: ASbGnctOWCaFxoqopbh316fZKAaMTGQikGYmOMvUJXOuPKqPgqoAqesEJOk3TmAdq5R
 mQOh0iExtAPhuutBdNINGVmsDetljRw9fNK+irYNso2+j7c4W/YiMqO2qtXTrYN84aHg/KBnNmB
 MyjBsfqw981nZKxL2hhrqNwU1IcIHIgWhv4I6BJu2RQnG/nmuZfQFB/VVZqf+JnyXlEcmQg7PwN
 J8uPOwz+ZYu/JnqeZvpjTbtTUT/HkvkjyXya0oHTAoeB4sQWIesKKHglhsK0VNNOY7/shAdNkaq
 lznDOP95xPJgovga5w==
X-Google-Smtp-Source: AGHT+IHFX5ixcv3wYwLkOVI6RFNzlWKkQoErT5NYQQNA60EHGhNzqX7oTzObEdQHQ9Nma3xjkBoHbA==
X-Received: by 2002:a17:907:cb87:b0:a9a:bbcc:5092 with SMTP id
 a640c23a62f3a-ab6cfdda479mr2879523066b.39.1738611067771; 
 Mon, 03 Feb 2025 11:31:07 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47f1da8sm807394766b.77.2025.02.03.11.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 11:31:07 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 35DA15F8BF;
 Mon,  3 Feb 2025 19:31:06 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,  "Kasireddy, Vivek"
 <vivek.kasireddy@intel.com>,  Akihiko Odaki <akihiko.odaki@daynix.com>,
 Huang Rui <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  "Gerd Hoffmann" <kraxel@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  "Paolo Bonzini" <pbonzini@redhat.com>,  Gert
 Wollny <gert.wollny@collabora.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  Gurchetan Singh <gurchetansingh@chromium.org>,
 Alyssa Ross <hi@alyssa.is>,  Roger <roger.pau@citrix.com>,  Alex Deucher
 <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 "Xenia Ragiadakou" <xenia.ragiadakou@amd.com>,  Pierre-Eric
 Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  "Rob Clark" <robdclark@gmail.com>,  Yiwei Zhang
 <zzyiwei@chromium.org>,  "Sergio Lopez Pascual" <slp@redhat.com>
Subject: Re: [PATCH v6 00/10] Support virtio-gpu DRM native context
In-Reply-To: <PH8PR11MB6879D81CAA931B0718DF3B1EFAF52@PH8PR11MB6879.namprd11.prod.outlook.com>
 (Dongwon Kim's message of "Mon, 3 Feb 2025 18:15:06 +0000")
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <87cyg844fr.fsf@draig.linaro.org>
 <5aedf1ad-d9b0-4edb-a050-f3d9bee9bccb@collabora.com>
 <87ikprflbb.fsf@draig.linaro.org>
 <PH8PR11MB6879D81CAA931B0718DF3B1EFAF52@PH8PR11MB6879.namprd11.prod.outlook.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 19:31:06 +0000
Message-ID: <878qqmbzb9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

"Kim, Dongwon" <dongwon.kim@intel.com> writes:

> Hi,
>
> The commit below could change the timing of drawing by making the drawing
> done at refresh cycle instead of via drawing event. So it looks like eith=
er dmabuf
> or client's framebuffer is being written and read at the same time. Hey, =
can you
> describe how the corruption looks like? Is it just garbage image with ran=
dom noise
> or the actual frame with some defects like tearing...?

The terminal gets mirrored upside down and the mouse creates damage as
it moves about.

>
>> Subject: Re: [PATCH v6 00/10] Support virtio-gpu DRM native context
>>=20
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>=20
>> > On 1/27/25 19:17, Alex Benn=C3=A9e wrote:
>> > ...
>> >> I'm still seeing corruption with -display gtk,gl=3Don on my x86 system
>> >> BTW. I would like to understand if that is a problem with QEMU, GTK
>> >> or something else in the stack before we merge.
>> >
>> > I reproduced the display mirroring/corruption issue and bisected it to
>> > the following commit. The problem only happens when QEMU/GTK uses
>> > Wayland display directly, while previously I was running QEMU with
>> > XWayland that doesn't have the problem. Why this change breaks dmabuf
>> > displaying with Wayland/GTK is unclear.
>>=20
>> Ahh that makes sense - I obviously forgot to mention I'm running sway/wa=
yland
>> across both machines.
>>=20
>> > Reverting commit fixes the bug.
>> >
>> > +Dongwon Kim +Vivek Kasireddy
>> >
>> > commit 77bf310084dad38b3a2badf01766c659056f1cf2
>> > Author: Dongwon Kim <dongwon.kim@intel.com>
>> > Date:   Fri Apr 26 15:50:59 2024 -0700
>> >
>> >     ui/gtk: Draw guest frame at refresh cycle
>> >
>> >     Draw routine needs to be manually invoked in the next refresh
>> >     if there is a scanout blob from the guest. This is to prevent
>> >     a situation where there is a scheduled draw event but it won't
>> >     happen bacause the window is currently in inactive state
>> >     (minimized or tabified). If draw is not done for a long time,
>> >     gl_block timeout and/or fence timeout (on the guest) will happen
>> >     eventually.
>> >
>> >     v2: Use gd_gl_area_draw(vc) in gtk-gl-area.c
>> >
>> >     Suggested-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>> >     Cc: Gerd Hoffmann <kraxel@redhat.com>
>> >     Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >     Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> >     Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>> >     Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >     Message-Id: <20240426225059.3871283-1-dongwon.kim@intel.com>
>>=20
>>=20
>> Maybe a race on:
>>=20
>>     QemuDmaBuf *dmabuf =3D vc->gfx.guest_fb.dmabuf; ?
>>=20
>> --
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

