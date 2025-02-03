Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC7FC02195
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 05:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tep65-0008Kt-Dv; Mon, 03 Feb 2025 00:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tep3s-0006DU-PI
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 00:32:00 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tep3q-00079G-8M
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 00:31:56 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-219f8263ae0so70529595ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 21:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738560712; x=1739165512;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zqx3EuVvg+YtifqQIKTiL0Yq5mCZ/UpbJfEaQOA2L0Y=;
 b=E6gmCPhTFo8Rl2Aj6k9T3n1XpaU46BV7XZLbGe82fLB0snChuJJRtqNu/NhwNwSKO8
 PwkM7sfbD3UiPUW3mMnzCGbROjUDSW+DudHqoxeLuYqPp1NY0LLylgGvh5H4zJnrH0hx
 9Gg4h6NfqNSjZ7iQVz+fgL9IIVdgwYyTXHlFGTzGlsi/Mj2I/4R1JKy/cV2QjhG/E6g9
 +cx8bRJKeM1qmgiEWFXoAI9q3yJOX5WIXYiRSWBn/H9Gus57eN96VOHl+fVvJ1Ts77RL
 mSGzTt8uQP/gyg7QJtbkPTvWJWNvTccPH3XwzMlYFhI9GPBV7kE81bmTUvj1BfMb6mE5
 nIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738560712; x=1739165512;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zqx3EuVvg+YtifqQIKTiL0Yq5mCZ/UpbJfEaQOA2L0Y=;
 b=SgXcYX7g8pNWqbD6uWDN34pM4hSZqIzEYUSxFaVyJy+Xi+mc1Bmw1IkZ1UaTvbcPou
 QVG23M24p3Le8vJDx1GAU3eJxlfWyfupoc+yqA8l9PMiQH2pwD2QUvIdHGeF9XU6J7iM
 QGJivJuDIJfwt9Cw8rFtBiHE/iBKrZMjPc/kAQ/XAEx80zqiL/SKKueF5EUjzbZb8tiO
 by12NHAUoymNA4n0kxwLiPquAm6lNLjGm1enpwRQq6Q8zN1bX8mCGUI1i5z0+q8tpWQe
 21MATnOZ6ceV1b+vh4QVoGCj7rVtlwgV/gLZc2TYSQpPyUuagfOy7EqFigUdxMiV7Lku
 G12Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMX+qAh+KCkGJS3AsaX7v1p2bnCxx3lEBjLlFQQQ2q3rFOdo818dG7OLsoi3cn5beWVybK1heTNSQb@nongnu.org
X-Gm-Message-State: AOJu0YwnuVdlRbB1PS8hwbcepvF2yDVi+DeuMGAGhVJaMy2QU6UrLU6W
 zzzMH7zp2JzQprqqUjx2fwI67zYEEqZZQTwSqskR9SzEWSUj76nkDEMmTqhxEXI=
X-Gm-Gg: ASbGncvobOhkr7oJPEEaDYK92kf6AvyNRHcHbxfC2Di6sIXiE0Scsg/rEN2TD26Uh2B
 rRUrstd8xu0+2l7B8S6XSXWkPF3ad7xfcRfB5J4YeCR4clHmArqwCOajO8rDc4UggBHbYPo7p5Z
 lKnp0Jac6+soqOe4LX1XWtgPWVtNioA93UKMFl2ZUM0Hi6anSUTcSaDVvffEBYoJ67IVnP7HdU5
 8mRHi7QEQUHsSPOcETgExk08WntYQy2aHssBQ+Na3OtkBAuAVK1YVidpLyhBa+A8tH3bH52Ae2l
 K8JXkMj46Beol0M3e2PHXCJS66cS
X-Google-Smtp-Source: AGHT+IHOYMeyoJqQlxdMp60VDHEklXDx5NJ7NhG09oNvbZzvHj7CCVi68ru/ypGnA8vKGm5GFsoaXQ==
X-Received: by 2002:a05:6a00:180b:b0:72f:9f9e:5bc8 with SMTP id
 d2e1a72fcca58-72fd0c74655mr29902786b3a.22.1738560712099; 
 Sun, 02 Feb 2025 21:31:52 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe642b218sm7621543b3a.57.2025.02.02.21.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 21:31:51 -0800 (PST)
Message-ID: <0f88994f-1a93-4049-addc-a62e8ca49904@daynix.com>
Date: Mon, 3 Feb 2025 14:31:44 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <920043a8-9294-4b40-8d8e-3611727e4cd2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

On 2025/02/03 7:08, Dmitry Osipenko wrote:
> On 1/27/25 07:57, Akihiko Odaki wrote:
>> On 2025/01/27 3:06, Dmitry Osipenko wrote:
>>> On 1/21/25 07:26, Akihiko Odaki wrote:
>>> ...
>>>>>> I feel the dependency information for virglrenderer and Mesa are more
>>>>>> suited for the Mesa documentation as they are not specific to QEMU and
>>>>>> potentially useful also for e.g., libkrun and crosvm.
>>>>>
>>>>> I think while everything is in so much flux it doesn't hurt to include
>>>>> in our docs. I don't know if mesa currently has a dedicated page for
>>>>> GPU
>>>>> virtualisation.
>>>>
>>>> Mesa has pages for VirGL and Venus, which can be linked from the
>>>> respective parts of this documentation. gfxstream is not documented but
>>>> I think most people will use it only for Android anyway. A documentation
>>>> for DRM native context will be a nice addition for Mesa. I will not
>>>> object if you put this information to QEMU documentation though.
>>>
>>> Adding native context doc to Mesa indeed will be a good move, as well as
>>> adding links to the Mesa virgl/venus pages in QEMU.
>>>
>>> RE requirements documentation, it's also a valid point that stuff like
>>> build flags should belong to the relevant projects. On the other hand,
>>> it's a common headache for a newcoming people to figure everything out
>>> from scratch and having more centralized documentation helps. The build
>>> requirements aren't cleanly documented anywhere AFAICT, and the
>>> requirements also differ based on VMM. I'll update and keep this patch
>>> in v6, the requirements info should stay actual for a next couple years
>>> IMO. Let's discuss it further in v6 if more objections will arise.
>>>
>>
>> I think it's fine to require one click to reach the relevant documentation.
>>
>> How do the requirements described here vary with VMM?
> 
> Requirements don't vary much. For example virglrenderer minigbm support
> is mandatory for crosvm, while for QEMU it's not.

Is that true? It seems that virglrenderer uses builds without minigbm 
support to run tests on GitLab CI.

Anyway, if there is any variance in the build procedure, that may 
justify having a separate build instruction in QEMU tree to avoid 
confusion. Otherwise, it's better to have a documentation shared with 
other VMMs.

> 
>> I'm not entirely sure the documentation will stay as is for that long.
>> The requirements of Intel native context refer to merge requests that
>> can be merged sooner or later. Asahi may need more updates if you
>> document it too because its DRM ABI is still unstable.
> 
> The unstable parts of course will need to be updated sooner, but the
> stable should be solid for years. I expect that about a year later
> requirements will need to be revisited.
> 

It will be some burden in the future. Now you are adding this 
documentation just for QEMU, but crosvm and libkrun may gain similar 
documentation. The DRM native context support for Intel and Asahi is in 
development, and I guess nvk will support it someday.

So, a very rough estimation of future documentation updates will be:
(number of VMMs) * (number of DRM native contexts in development)
= 3 * 3
= 9

That's manageable but suboptimal.

Regards,
Akihiko Odaki

