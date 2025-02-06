Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10EEC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 05:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfudW-0006wr-RY; Thu, 06 Feb 2025 00:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tfudV-0006wE-5M
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 00:41:13 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tfudR-0001jU-Uf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 00:41:12 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f2f1181f2so13911355ad.2
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 21:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738820468; x=1739425268;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tk+whhgQdU2crP21b52SML7lDrcn2Y0NC9ahdwL/208=;
 b=qlMIGVjOYuaMbkiO6XuL+A0WQ71HsoS5g/NHXeJvZpG1qxo56O3N8lXhD5OU8tfivV
 xl1Mihg3LI8S48fojq6yI7gX98Sy4xSAH8ai9Q/zWHdm0QNyrtSVbkWC++DMJ9/EfMCf
 6pBiw8hfwhyZSKcg/p/zS+QFpQeGF02qI/ic37R89x/wt49NuoJVi9k+hGfoR75zIi3G
 F1uZ7DYh2KDWJHBTF5cW/3Q1bTxLJ0Aq1GXrHsjVD7df36v9L6tOXoCPK1+F9o7LQx62
 /kNQh0yX2bATdahmw9wTcSHh12hsiZgVNrSiwLmEPKIY+o8RyLoF62N4vf6J/zrec+zv
 1Kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738820468; x=1739425268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tk+whhgQdU2crP21b52SML7lDrcn2Y0NC9ahdwL/208=;
 b=uGjnxEoJzbth0GFd1jzvkDkgLTEOfFmaZw73Qg489LFrF0iCRYsQ//UbrFa0aaDuBW
 6GPOs456t+e5t/JS6RgmrwWbNzdoVfJJ8zbljRXPxpOr6QWqsAh+ao+/A47ixwlXAbG7
 Fe3GCO1GMdAy+05WhWn0bWn8ILvCz/WKQoRIWKNL87FMRCxZMOVTeSahmHwdoSpmc0cq
 jfM3ZpsxKypmgAqxr0OJz7G/S/zRLxTc/d+zPPb3hS1i3c6Z3uxh4m6sRDnZMI+pdgDA
 QqFwzefbfHLcc3/v5wnkt1bxkOm5CqO8/Tr3nSEaCfn8Pk/VFIzzZRYpvhOkZWygb65v
 vLvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWqcqIa4sM6KsD1YDqBEPXY8ipxyPC8Rea9S/eLhyb/l4fPubNh0ls+2Zyi5Pny+aEQEA67Ov4Jrdz@nongnu.org
X-Gm-Message-State: AOJu0YzIzH95THwjYeV9ttTQfjSKALAfXhfNtwJwM97cq6WyvDDsJC10
 XluGyODslgKgLOoSNBpWpbCuBojbgbghRjrLXKoL5s/PvRn+W+JaxWeBQ+5CFMA=
X-Gm-Gg: ASbGnctmb7RK0U/8QLyvnYiSE1+JtnzBt59+rpBG93yl8VMGntn88P3f2Z537hD015h
 nGK0bv9O+ydJ9wGeEbgsC1ghGthbF+0hqL1pyBhOvjI+Vfu0lEml0dBl5wCtKjStO9m9IL9uSa8
 anJRs0a7G0u/kHiF87IruI83FDWI4nrOoKPH7n0axLtrxGuHAlLjYIT1dtZ/aVx3ZJKfEVy7aTY
 0O+MbmvbMr++fT59M06MxhvIeR50dGcrPRar+wVxLl9qAwwPJ+85gcCA/M5QLGvGy221eBswUL1
 cr+HUMES/7kXpe9+FHZhs4Hva7Q7
X-Google-Smtp-Source: AGHT+IFWxH0Xo0pgjcc8/5dB4vTnZ4/hD5puMRnUss8SjXcMymfQLusS20x9mzj3ycRMN1Zg3TSckA==
X-Received: by 2002:a17:903:18f:b0:21f:75c:f7d3 with SMTP id
 d9443c01a7336-21f17ec7bd9mr99856615ad.38.1738820467900; 
 Wed, 05 Feb 2025 21:41:07 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f36561397sm3690685ad.89.2025.02.05.21.41.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 21:41:07 -0800 (PST)
Message-ID: <fdd8b7ca-e4ad-405d-a58e-fbcb82183ec8@daynix.com>
Date: Thu, 6 Feb 2025 14:41:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] docs/system: Expand the virtio-gpu documentation
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
 <20250119220050.15167-9-dmitry.osipenko@collabora.com>
 <c2e1c362-5d02-488e-b849-d0b14781a60f@daynix.com>
 <87ikq9r7wj.fsf@draig.linaro.org>
 <171b1cd3-1077-438c-a27c-3b9b3ce25f0f@daynix.com>
 <ea866d19-90f6-4bb9-a3f6-f84b2ea2c457@collabora.com>
 <86dce86b-03bf-4abe-b825-1341e93eb88d@daynix.com>
 <920043a8-9294-4b40-8d8e-3611727e4cd2@collabora.com>
 <0f88994f-1a93-4049-addc-a62e8ca49904@daynix.com>
 <d85f6669-8c46-4678-85d6-59240935d197@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <d85f6669-8c46-4678-85d6-59240935d197@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/02/06 2:40, Dmitry Osipenko wrote:
> On 2/3/25 08:31, Akihiko Odaki wrote:
> ...
>>> Requirements don't vary much. For example virglrenderer minigbm support
>>> is mandatory for crosvm, while for QEMU it's not.
>>
>> Is that true? It seems that virglrenderer uses builds without minigbm
>> support to run tests on GitLab CI.
> 
> CI is running in a headless mode using software renderer. For a
> full-featured crosvm support running on a baremetal, minigbm should be
> needed, along with other downstream features.

That makes sense.

Based on your input, for QEMU, I don't think we need a separate 
documentation to describe libvirglrenderer's build flags though crosvm 
should have some documentation saying it requires minigbm.

> 
>> Anyway, if there is any variance in the build procedure, that may
>> justify having a separate build instruction in QEMU tree to avoid
>> confusion. Otherwise, it's better to have a documentation shared with
>> other VMMs.
>>
>>>
>>>> I'm not entirely sure the documentation will stay as is for that long.
>>>> The requirements of Intel native context refer to merge requests that
>>>> can be merged sooner or later. Asahi may need more updates if you
>>>> document it too because its DRM ABI is still unstable.
>>>
>>> The unstable parts of course will need to be updated sooner, but the
>>> stable should be solid for years. I expect that about a year later
>>> requirements will need to be revisited.
>>>
>>
>> It will be some burden in the future. Now you are adding this
>> documentation just for QEMU, but crosvm and libkrun may gain similar
>> documentation. The DRM native context support for Intel and Asahi is in
>> development, and I guess nvk will support it someday.
>>
>> So, a very rough estimation of future documentation updates will be:
>> (number of VMMs) * (number of DRM native contexts in development)
>> = 3 * 3
>> = 9
>>
>> That's manageable but suboptimal.
> 
> I don't mind deferring the doc addition if that's preferred. Either way
> is fine with me. Yet it's better to have doc than not.

My suggestion is not to defer the addition, but to add it to Mesa, which 
does not require deferring.

> 
> In my view crosvm and libkrun exist separately from QEMU, they serve a
> different purpose. Majority of QEMU users likely never heard about those
> other VMMs. A unified doc won't be a worthwhile effort, IMO.
> 

When evaluating the utility of a unified documentation, Whether the 
majority of Mesa/Virgl users care VMMs other than QEMU matters more. And 
I think it is true; libkrun and crosvm are excellent options for 
graphics-accelerated VMs.

If we have a unified documentation, any VM can point to it for the build 
instruction of Mesa and virglrenderer. Once that's done, QEMU users who 
want graphics acceleration can take the following steps:
1. See docs/system/devices/virtio-gpu.rst
2. Figure out that they need Mesa and virglrenderer
3. Click the link to the unified documentation
4. Build Mesa and virglrenderer accordingly

No other VMMs will bother them in this procedure.

Regards,
Akihiko Odaki

