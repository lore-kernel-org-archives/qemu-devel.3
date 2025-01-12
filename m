Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB14AE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 17:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX1PI-0002US-3v; Sun, 12 Jan 2025 12:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tX1PF-0002UA-Qi
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 12:05:45 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tX1Oz-0005Km-K1
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 12:05:31 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d8c1950da7so6137442a12.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 09:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736701527; x=1737306327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAcaUxXuXIQo/NUGAMu7QNAnr587rWuEYR4aC51luBw=;
 b=KzluiTZA8XB4e60ztWGhgSfjy4CLHFps+aYZW/PMLskj1LVNIBnvU+tBg2PSF+iKbr
 OqkO0dEdHnri1A77EZ1OJlCSCKmYHeVk2BFnS7puVB3bwVLPeuWSvUiJ5S0tfaguRDRO
 1DZMLd5WKag/p6xH8RPCjpQeeJigQzjybuk6n2j45EmAMcdVtrZa3NprY6xMZRQxeKIq
 Pd1PST4ZFW6aCU9tyHX7pjvMiH+EXXO7NkXKWC4B5oGTCGNKc5iWUkcvZQ6ozSRa9WOw
 fkVCU02e8o3ZNpOfwo6FZ/mpNTzlUh/k0s5j0pBgot+5RcFnoQvonRYIQrtdceBunM9T
 EDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736701527; x=1737306327;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SAcaUxXuXIQo/NUGAMu7QNAnr587rWuEYR4aC51luBw=;
 b=FVVsi8ej6Fkzk71aXeKQkylWOJl2DnAeWjekAYig1Zw98Ce8d8jpshK1PyiL2sXY6V
 gMOu3Oa7qrIpShwr9z65ufFavpBXUpUtlbcsbFrH7osQkuR1w0WtJP2P1P0O8BSwJEKS
 9uLUjcNUf78A8jkfwObdSmvGl041BvBZXTheCExr8o8FeDjuIfcoXQCnkh3a+BdCdLxM
 mLOAyjxXTiFipG8YupuwM6fK7nhfD/Vh/WKqUYT36liA99lTBFs3+Ba8aBa3M3PEgfgQ
 qmbIlM8dDBrndkU32EIc2DSX7dELgs/zK7b7i21cWRiZ0PlMFupbhq+t9kTtTM3nRMz9
 Cd/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSLZfcGebm8NqZ+wYptSOWry6RZ/JIiPOrhMai0Gj/8E6kt6UjmbwsJJ3fkSAeqkPAD51WXjDKa7fP@nongnu.org
X-Gm-Message-State: AOJu0Yxu8Wv8dH6jUaF91uq7My9KKbxS/dMl6gfId86kxsRCBgG1Wyk0
 gni/5gUp+M8J0V+GIccSP7LDZcvEFXmAx8Rl+koKB65OLYDeKPQkM/aWlhOYb54=
X-Gm-Gg: ASbGnctH9gSWxx9GAtC0+B85VdSPo8cg3tbnzw3Bw7UGlbcoAGfs74pugZ0sd1uWKAf
 EAfxd73Lo2uWR/rwfZu5L/JggVDMQmfHs3bOv0xNOZjBc3kfWeLEHr21MvxfeaSDmF7qCxpOREn
 3DWbNmHV8MQfm7SAVWwJd4cz2qpy3KW92sN8yB9CIkeLp1HlZTKSMJJ903w9iBOT7KIZRU4S59a
 XRDcxsV4V0oqCty98/O6H6ADRS+unhIf086zIgcZIhtcb721bQGpq0=
X-Google-Smtp-Source: AGHT+IEiUZDU3enD5VsAl8DQ1/EWHUdSFn488Fzt3yRJeTTIK2BZAdB5fBzvsxNcsmpnnBDcCe1X4g==
X-Received: by 2002:a05:6402:50c6:b0:5d0:b2c8:8d04 with SMTP id
 4fb4d7f45d1cf-5d972e147famr18637436a12.18.1736701527293; 
 Sun, 12 Jan 2025 09:05:27 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9900c9f4bsm3900678a12.34.2025.01.12.09.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jan 2025 09:05:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 046D85F929;
 Sun, 12 Jan 2025 17:05:24 +0000 (GMT)
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
Subject: Re: [PATCH v4 0/5] Support virtio-gpu DRM native context
In-Reply-To: <307120fe-c950-42d0-a775-a64d847a3b00@collabora.com> (Dmitry
 Osipenko's message of "Sun, 12 Jan 2025 19:46:56 +0300")
References: <20241110221838.2241356-1-dmitry.osipenko@collabora.com>
 <87ikqm4wmp.fsf@draig.linaro.org> <874j24vwku.fsf@draig.linaro.org>
 <307120fe-c950-42d0-a775-a64d847a3b00@collabora.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Sun, 12 Jan 2025 17:05:23 +0000
Message-ID: <87y0zgufn0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

> On 1/12/25 19:14, Alex Benn=C3=A9e wrote:
>> So this goes away with:
>>=20
>>   Linux draig 6.13.0-rc6-ajb-00144-g8c8d54116fa2-dirty #27 SMP PREEMPT_D=
YNAMIC Fri Jan 10 16:57:29 GMT 2025 x86_64 GNU/Linux
>>=20
>> So I think is an artefact of the PFN page locking failing. I guess
>> native context is more prone to issues? It is a bit odd as I have loads
>> of memory and I think the intel graphics are unified memory but I don't
>> know how you would check.
>
> Native context is about same prone as Venus. For Intel GFX it doesn't
> matter much whether it's dGPU or iGPU. i915 driver would use huge pages
> for UMA which is affected by the same KVM/PFN issue. In a case of UMA,
> you may explicitly disable transparent huge pages to work around the
> problem, but this is no necessary anymore using 6.13+ kernel. Glad it
> was an easy fix!

I still can't get vulkaninfo to see anything (Error
vk::Instance:enumeratePhysicalDevices: ErrorInitializationFailed).

I've got your mesa native-context-iris set up with VK_ICD_FILENAMES
pointing at the virtio_icd.x86_64.json

VK_LOADER_DEBUG=3D1 doesn't show anything


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

