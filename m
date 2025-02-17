Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6110CC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 18:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk5xi-0002k6-MY; Mon, 17 Feb 2025 13:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tk5xg-0002hL-VB
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:35:21 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tk5xc-00014w-37
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:35:18 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-abb8e405640so235532466b.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 10:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739817314; x=1740422114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhjjqBmmFcj//UL5xXzH7A++Em7l3G5ZP39B+OjCIr0=;
 b=Q9Sb/VUyLVquwx8zk4OrqWhBJ46Socsd7cQNEO+oDSdEyIJKmjW6BNhdNqyVr/Gb/9
 A8s8fyiJ6baNJgRYthVmVOkv6dNwJ03feRw3dClztGoVSB5MZdjay0fpEjwNB1HzgdF6
 R62yFfthfd3wO59c7RXqj+qIxe/B9jbqkdvND9u6HfXEekAfrA3WA97OVMUyzfXPvW7T
 2IxmNBUS93mLCjChI12qMgY22VU3XJrV9QcaazKmiXxlrxCOajTgs6oXkDOc3zixE5ZP
 YR813h7AiPjaHlTWZpYHnN8ptZCku8J1t15UVUPHNucIAeB6B6hH1AYFe8xKPeRDN3wX
 6e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739817314; x=1740422114;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MhjjqBmmFcj//UL5xXzH7A++Em7l3G5ZP39B+OjCIr0=;
 b=NjBRSe41QeceWDRiLOnc6I+nYFTgpdELbPhgL34KpmLGl/UZVxHQLS1S+LrNv0Sr6z
 nW45byV4pJ72sTkvOBkSDg1ZsJQE1dK4oSNqfWtkgGrYp1i0DjvgHQwWu+ZtG4lLhfvD
 17XisFmeN5ZySxMdjuciIzzzGNTZ88uegGL3aFIvj8fJFv0xpFbZG/H/Jo+RkQJKHJ/e
 QwVdyFEZqC/AW2Mk8XaseqZQQIRY7aLoPYWA+jrBkYF9Q27CGXZ3cxCqMNEi6Bz6K99A
 AMnC61xzdCqGHS7if3RdLkgPVZnHyrjVPxRKJv+LoAhu3UVIMflxY4QTt36JXcYR5Qvq
 iQ8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+B1sLepezI5cQpyEwAQLywvrS1XQa3H2aTZG23Eh4NuOrSWOL9c+jm6jSSi7/i+zGi7kU+wJb26DK@nongnu.org
X-Gm-Message-State: AOJu0YwwfaA3NnXQvT0dFyjUVvJrP3a+XO+Zd63rCDhJnYFCnizov/EV
 gP+ewxYJ1eO53fN1Un5Vk+88x5E+O0gobTxZL9TSTW5mucVZ0Blyhom2t73G1NA=
X-Gm-Gg: ASbGnctPuXL5ivIE4rRrq+//FCdqTRU4TMHPuHwIw67PhQpXtUbnloL65OmVhz4orrA
 IkzxLcbvgPXdBHujXa6bX4gcGePSrdCn5DNmKWgnu6e34Zdg2uLTfZi7+mtW5SNiWSbRVb+axja
 QfkY+OPzMMtIwQrLIOpfGMe2SVqoSqyjdksmKVv1SZm3m4GGNTO0/qKRIMTuXKU1tOfrPe40t3R
 L/u84aYTcaoGsQKG0XBfo5kpFt/GajCfupZC6FuTlTHbOnqF75E8rK1XS+oXelxU4RO6t1WtVJp
 ulIkAKCj96y5pDW32g==
X-Google-Smtp-Source: AGHT+IEqYzKwOOeEVnpo5E7GeJaeWimPFwcTPwszKebzDSZmagokI2jT6j7kvpeyR+9KmSOiqpGpGA==
X-Received: by 2002:a17:907:3e0a:b0:ab7:86b6:beeb with SMTP id
 a640c23a62f3a-abb70e5caecmr1129561266b.57.1739817313828; 
 Mon, 17 Feb 2025 10:35:13 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb7200144fsm530548566b.184.2025.02.17.10.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:35:13 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 53DA95F942;
 Mon, 17 Feb 2025 18:35:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
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
Subject: Re: [PATCH v6 00/10] Support virtio-gpu DRM native context
In-Reply-To: <c6e5b341-12fb-4580-a9df-2a016f2571b3@collabora.com> (Dmitry
 Osipenko's message of "Mon, 17 Feb 2025 21:02:59 +0300")
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <8734ggpped.fsf@draig.linaro.org>
 <f58d250d-3831-4ff1-a018-f62f9aeb2527@collabora.com>
 <87bjv0lhok.fsf@draig.linaro.org>
 <c6e5b341-12fb-4580-a9df-2a016f2571b3@collabora.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 17 Feb 2025 18:35:12 +0000
Message-ID: <87zfikju73.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On 2/17/25 18:22, Alex Benn=C3=A9e wrote:
> ...
>>> This VK_KHR_display problem is only reproducible with your rootfs that
>>> you shared with me. It could be a trouble with your build configs or a
>>> buggy package version used by your rootfs build, more likely the
>>> former.
>> So you have built that latest vkmark? This is a recent addition to
>> vkmark for the 2025.1 release.
>
> Yes, latest 2025.1 from git/master.
>
>> Does vulkaninfo --summary show the extension available for you? It is
>> certainly available on the host side:
>>=20
>> VK_KHR_display                         : extension revision 23
>>=20
>
> Have it on guest with my rootfs, not with yours. I'd suspect problem is
> with the your Mesa build flags, maybe you haven't enabled necessary
> flags related to WSI.

I can't see any reference in the buildroot recipes. What is your mesa's
build flags?

>
> ..
>>>> With drm_native I get a lot of stutter while running and barely 100FPS
>>>> (compared to ~8000 on pure venus). IMHO we need to figure out why there
>>>> is such a discrepancy before merging because currently it makes more
>>>> sense to use=20
>>> If you'd run with Xorg/Wayland directly without a DE, then it should
>>> work okay. This should be a problem with unmapping performance that I'm
>>> thinking about.
>>>
>>> That unmapping problem is partially understood. Unmapping code works
>>> correctly, but we'll need to optimize the flatview code to perform
>>> unmapping immediately.
>> Why immediately? Surely if we are unmapping we can defer it. Or is this
>> a case of having stale mappings making the life of new allocations
>> harder?
>
> Unmapping currently works synchronously for virtio-gpu in QEMU, hence
> deferring it blocks whole virtio-gpu up to 100+ ms. And if multiple
> unmappings are done in a row, then it's 100ms multiplied by the number
> of unmappings.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

