Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCD3CE8E6F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 12:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3xDa-0003Fz-HY; Thu, 24 Oct 2024 08:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3xDZ-0003Fq-8V
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:45:33 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3xDX-0001gf-HV
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:45:32 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9a0472306cso109140666b.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729773929; x=1730378729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7SHOViy4gQGzhNx9jgIFHlyv7Wx4RrOxEErfctHO1kc=;
 b=I5EKo1hObeIUTFnkAm96JjNJNsSyk0z00/w+3Y9Lcnbi1Aj/XNg1n7g19y88kOLfaP
 9dczp+FV6xx7/ARgJ5u6zcP3SFX74+7EhX+bK8sZQ9C2K5vrlGkLHusJySUzYzTYg5rI
 X64LwWL8+aaimReo1n34U56WP8fvleU2KPMrjuh3BuJ2WP5uXx/zAxgjrec9wxXqd00U
 onX/ryILgJw61SHwbvItlZU7VlIscUmIpG+7CqNdT1cYrOTEoCpkk28zLbuh/GoLbagn
 i3bbQop0veM6YX3pKItYvWpGFExYvkuCiWA1M0AlTNYkvUCnr7kKbHZeGZjP83xkz4Lt
 bzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729773929; x=1730378729;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7SHOViy4gQGzhNx9jgIFHlyv7Wx4RrOxEErfctHO1kc=;
 b=QRpKVu6VC2ig8ZiMrr8ZB8MS1XydFQwruBUrflX2v5pfGwqiHVGoNMMDVtz5G1+8Ci
 TsyPOS0X5xYRYaUbnj8GeoHsW5b3v9h/Qr1cEEwedtXKbLXTxjlk6/icsjGY0xbwSmut
 WtjsbxA1OS9ENu0XC0MLur38iAgeqGzD0iqHs191QQtir0fTaLBJVQEy3nFrolvfSkDM
 mzdxqEy16JGiYVAmq+QVFX3jclBQ+YBBujew884RzQlYp9A31F0xwesQi9csmAPrHKPb
 co3gQFxfD+Duo7sM/eFyMlIc5NnHR2aHSDyFCugVwg6tHyymI43RjV+qRRl/WtPirwPO
 2Ocw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFGlw6gYoG+qDnEtwq8SXIUT5m4llcK97vRAk5C4RypOwzWc+pbczKZ5Oflacxi9EdRD3lnvoTOTaw@nongnu.org
X-Gm-Message-State: AOJu0YxsSyNkBC8iAM2hcZQU78K0RHIo6KtYIYGKMQ82Rpj5z7fDKenu
 bvMiBIZwBeqwX+vcDbRe4JXQifyh92fIciZeSukVCLuvoQflA3HN0FH9uiYiXiU=
X-Google-Smtp-Source: AGHT+IF0HOnbjI9nSxmIwkpnD7HP47STsav2XucPuOsVV+2Y4G7Qf1+ir5qCKmKkm6KNZWQ6EODxww==
X-Received: by 2002:a17:907:9406:b0:a99:e850:deb3 with SMTP id
 a640c23a62f3a-a9abf890eaamr585049966b.18.1729773929411; 
 Thu, 24 Oct 2024 05:45:29 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d62e4sm611623466b.7.2024.10.24.05.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 05:45:28 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D4ADF5F786;
 Thu, 24 Oct 2024 13:45:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>,  Huang Rui <ray.huang@amd.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?rc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Gerd Hoffmann <kraxel@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Gert Wollny <gert.wollny@collabora.com>,
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
Subject: Re: [PATCH v2 0/6] Support virtio-gpu DRM native context
In-Reply-To: <999ae767-41ab-49aa-a3b6-bbe2d63164d8@collabora.com> (Dmitry
 Osipenko's message of "Thu, 24 Oct 2024 15:21:05 +0300")
References: <20241015043238.114034-1-dmitry.osipenko@collabora.com>
 <87ikthke2i.fsf@draig.linaro.org>
 <999ae767-41ab-49aa-a3b6-bbe2d63164d8@collabora.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Thu, 24 Oct 2024 13:45:27 +0100
Message-ID: <87v7xhis9k.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

> On 10/24/24 13:09, Alex Benn=C3=A9e wrote:
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>=20
>>> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
>>> It's based on the pending Venus v17 patches [1] that bring host blobs
>>> support to virtio-gpu-gl device.
>>>
>>> Based-on: 20240822185110.1757429-1-dmitry.osipenko@collabora.com
>>>
>>> [1]
>>> https://lore.kernel.org/qemu-devel/20240822185110.1757429-1-dmitry.osip=
enko@collabora.com/
>>=20
>> Now the tree is open are you going to re-base with the tags and get it
>> merged? We don't have long before softfreeze for 9.2!
>
> The Venus patches apply cleanly to the latest base. I'll re-send them
> today in a hope that it will speed up the merging process. Thanks for
> the heads up.
>
> Patches should be waiting for Michael Tsirkin to press a button to get
> them merged. On the other hand, I now see MAINTAINERS says that
> virtio-gpu status is "Orphan", thought Michael/Gerd are in charge of it.
> Does it means that any QEMU maintainer with a commit access could help
> with applying virtio-gpu patches?

In theory although it would be better if we could find someone to
step-up to maintainer duties. Could that be you?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

