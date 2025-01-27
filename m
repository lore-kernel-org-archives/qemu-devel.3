Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD672C0218F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 09:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcLgA-0002Eo-EJ; Mon, 27 Jan 2025 04:45:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tcLg3-0001tz-Sd
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 04:45:08 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tcLg1-0005eu-KJ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 04:45:07 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so5509369a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 01:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737971103; x=1738575903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2YhXRxF07equpWKaBrM/2/y5eLn1X09jZ+vQRzpRl0g=;
 b=b2u9jQzd/adnZ/18XUvFRc3Ct3gOxJDNFyf+2SIzpgNg0TgVpSOVzlXt1rPeyCkFIR
 mD5sUF7srHdxs4RqXRdflX/QyNxlGthBVpaJARSxY40OTLofMid0Dqm29sToES2rSs7B
 ACi5KMvUJjkx3XYYwOQZgKI9WBPsS0o6+NBu+BkuXj2hJHnmIjn20q8vkzIvD4t/7Pvl
 Rlm526dOCQdqrko5CVQ2HhR+qqpEN7oZke6AHLjWLnhMMDJj+t/ggb3OelA4JgHRLoRe
 ND8H/wTPtQI3OXEE9sWIg2d55UsEstvWYi3YZgtyWfQhpzZuoMIcJpOcWkgoKyZCx0of
 sR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737971103; x=1738575903;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2YhXRxF07equpWKaBrM/2/y5eLn1X09jZ+vQRzpRl0g=;
 b=WMWb3W0CfYhM0LoVCwhbTP8HRMu8A90jSMgPhiEpoCctM5cLwoZjvoR0wW2Fhdo5BI
 Yf99HSQWJWmzvHngvv/l+idjbHRluwGuSpgkXzJ8l8w+4RkPBpwJHSqL3MN1GuCNklXS
 g2gEp7sh3ERnnR3HoD2o2wJ+VB2QhFkkAuQRPaBCAz53kyqWIb5MAhINoZWoC2zB8anm
 B3v7/QEKEin7GG6r9To+LaNpMrp8oSAchp6eq3FhO5VPKSdUMRaqYvoWPhd5vsKnSjWt
 OI4WxtjGUaj1tg3RGVIhEi/gnKsJEtJogs3d9SEnPBWh3vnfArVuIpqbym2n6grLRc/S
 4dDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXOzGWTr+cQJkZfX4rrddcn8RA2zC2KfjaN4HzfUeSS+Wn4m3T0eo1kgoeK+YHoPPznjkjMbw9V9Cj@nongnu.org
X-Gm-Message-State: AOJu0YzA0KLqz1cYTSpUwOo5nfKKvYtWGO+YgzA+MMdKMFYEGnHblYlQ
 3tBNBoZmDQwpye25bIa8qJEKNq4AtnPUi+kydOHKiQJC1I0fA4PUL+Y5EtTT26s=
X-Gm-Gg: ASbGnctWkA4ISwThwnux7oPKLFzlOYZNEP0czjvi03f2Qq2Kf00V2zyc1lr3Mq77NcA
 SZxCQIv+VoKHXFYQy64t7bcCa0+1Uq9CxgCmLn01KAYpVofRjPiKitrXmtuJsP9+6y1Jrn0BAwY
 wxS0lt98iXIaMqwNZ91OAevE6EuMYmNXqtnofR9fhJ6nV3wrmccK41SSkAT2Bp+IyXtYBt0gzm4
 65zVkicadXBz5mSNgHIMFg4r25I7ijjLXFBQcxz9r1UgiZVutYs2uF1Pei+tjNH79HBYUBLcMFx
 gzo=
X-Google-Smtp-Source: AGHT+IFW718WvLWbx6sezTr9s2Ri1ybV0/nPflsyGZtWYQMybvJF3oYKRZNfDOjbt1GV8Xhd7lvXuQ==
X-Received: by 2002:a17:907:7b81:b0:aa5:44a8:9ae7 with SMTP id
 a640c23a62f3a-ab38b3d64e3mr3483028366b.47.1737971102831; 
 Mon, 27 Jan 2025 01:45:02 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6760b70a7sm556154266b.116.2025.01.27.01.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 01:45:02 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 253675F950;
 Mon, 27 Jan 2025 09:45:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Gert Wollny <gert.wollny@collabora.com>,
 qemu-devel@nongnu.org,  Gurchetan Singh <gurchetansingh@chromium.org>,
 Alyssa Ross <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?=
 <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Rob Clark <robdclark@gmail.com>,  Yiwei Zhang
 <zzyiwei@chromium.org>,  Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH v6 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
In-Reply-To: <42646f72-c2c8-43c5-abe1-e8e1b3c9d31b@daynix.com> (Akihiko
 Odaki's message of "Mon, 27 Jan 2025 15:28:10 +0900")
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <20250126201121.470990-11-dmitry.osipenko@collabora.com>
 <42646f72-c2c8-43c5-abe1-e8e1b3c9d31b@daynix.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 27 Jan 2025 09:45:01 +0000
Message-ID: <87o6zs4mle.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2025/01/27 5:11, Dmitry Osipenko wrote:
>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> This attempts to tidy up the VirtIO GPU documentation to make the
>> list
>> of requirements clearer. There are still a lot of moving parts and the
>> distros have some catching up to do before this is all handled
>> automatically.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Sergio Lopez Pascual <slp@redhat.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> [dmitry.osipenko@collabora.com: Extended and corrected doc]
<snip>
>>   virtio-gpu rutabaga
>>   -------------------
>>   @@ -133,3 +218,23 @@ Surfaceless is the default if ``wsi`` is not
>> specified.
>>   .. _Wayland display passthrough: https://www.youtube.com/watch?v=3DOZJ=
iHMtIQ2M
>>   .. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutab=
aga_gfx.html
>>   .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
>> +
>> +.. list-table:: Host Requirements
>> +  :header-rows: 1
>> +
>> +  * - Mode
>> +    - Kernel
>> +    - Userspace
>> +  * - virtio-gpu-gl (rutabaga/gfxstream)
>> +    - GPU enabled
>> +    - aemu/rutabaga_gfx_ffi or vhost-user client with support
>
> Let's omit the mention of aemu. It is a dependency of rutabaga_gfx_ffi
> and referring to dependencies of our dependencies will make the
> documentation too cluttered. Users should also see rutabaga_gfx_ffi
> needs aemu anyway in its build guide; the reference of aemu here is
> effectively redundant.
>
> I don't see the vhost-user support in Rutabaga. Does it really exist?

vhost-device-gpu supports gfxstream although the 3D acceleration parts
of that are still WIP:

  https://github.com/rust-vmm/vhost-device/tree/main/staging/vhost-device-g=
pu

>
>> +
>> +.. list-table:: Guest Requirements
>> +  :header-rows: 1
>> +
>> +  * - Mode
>> +    - Mesa Version
>> +    - Mesa build flags
>> +  * - virtio-gpu-gl (rutabaga/gfxstream)
>> +    - 24.3.0+
>> +    - -Dvulkan-drivers=3Dgfxstream

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

