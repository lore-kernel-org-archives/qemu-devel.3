Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2122C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 06:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcexL-0003li-EW; Tue, 28 Jan 2025 01:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tcexK-0003lK-7y
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 01:20:14 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tcexH-0005dR-T6
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 01:20:13 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so125852595ad.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 22:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738045209; x=1738650009;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mjsCUZaDl0yzpolexEoh0zQSspxNLCnIR4s0Hae1izA=;
 b=tQfG5sT2JZMvlEVsoWQ+0m42EBoyoOHd4Su30ae+dOg3RnkuH3N8J4uiQYQ+pPEDel
 kgHVWO/O0QoCtuabJf6VGR/MmkghxfXb0YwURBaOGnEG0ru8FnAIhM3xTvTWcQTdavp9
 hg+2hcFf/6pxDsEvAnhKu690pXpxS9ConrHh3ShY6LQyKQpTQLSciv6EEW7Llz19OPSt
 mUooiR2WdBoEXYoXDqMpVZFcO9QAQydap6NsFfFXSr4gVcBnUB7HeHf/mwrimLN1F6et
 QyZETZAv3zczOsT7nIgEoWj584Fp8e23OPj5EZmHF36EhSjDnIm5N4lWVHGS5ST3c1XJ
 yzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738045209; x=1738650009;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mjsCUZaDl0yzpolexEoh0zQSspxNLCnIR4s0Hae1izA=;
 b=XzxS1qcWkzYVaOHNM7wvne0FeZp/IOgc6M4kUzypPz16tto2Jd9nnT+xDyV2k3PKck
 1jz3A9BmB8CjI75FRGyerZDRjQil/IbkLQUdA7JFIhnGPkIY/7TsLwrkkk5E0M+pvSLM
 jxlxFqwrkdhF53hn5LvZFq3De0TC4zCAFVhKZw1PzaC5JGuKuwj65B8Q2fLAWVVbF2LN
 ZYBSib+k+nclMuPm26aJrSoN47HvVS6w25S+wACxflG7gLXm6U6Ug6kzQvrGTqgYovXg
 cfx6Tz5CxzIroX2GLdI4IKdtTdaH/+gcwWztqWudUfNahtWa3x5bMNDj7sVK9qIXS8pZ
 zY5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwbqs3DQuZohbi4zdkoyZhU6M756emMv1joe5Y5KJGfVodxgQE+teclyT6FRT+O7jQoE3rrwC6azc7@nongnu.org
X-Gm-Message-State: AOJu0Yy8xwm2poI+0OBlgEMIaeUE/qy6+mp+NY0vhqhpSP+fScgAHOVD
 KJ8z8SsQQxs/X7Oj84DriLRshj6iBFjJCeHipnzQPdXV9Kh75RKkOnYdacIxZRI=
X-Gm-Gg: ASbGncuT0ad3FJ/LXQB3L3QtBE68dtToIaQaAE+B8CLmNtnu8tBx0umlcTfuuYSjqpV
 +tiTv+fTeyVNI2wJd6EnFVz1tr7DFHGXor3EKcwyuZCBeH0jPA3uoOuiWs/IXhWSg4s0DxMOv8V
 bPu5/cKO2fiJpyBym4hhaGiAHIOfs3geNvaVBHcV8OVxJ9ZGJKR6UTCQlurSFJ3abapDIgH7Xgb
 6RhrqUKERgI5UbIawzINjobbaR8LZrnNYkeoRBKkvy0U11LSzqSuEMuIb7lle97QMj1XmMhgMdI
 YNwloAJyP8utYieP/wU4bflXTQ/B
X-Google-Smtp-Source: AGHT+IFJD7IW2qh+kO/WNcje5OChbVzh2FbTpcqICrvBxpZiAXx2364Iol4X+a8jcs7qNUUnsUcPJA==
X-Received: by 2002:a05:6a20:72a3:b0:1e1:dbfd:1fde with SMTP id
 adf61e73a8af0-1eb2157fba4mr66829952637.27.1738045209174; 
 Mon, 27 Jan 2025 22:20:09 -0800 (PST)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6b2c07sm8338087b3a.40.2025.01.27.22.20.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 22:20:08 -0800 (PST)
Message-ID: <0c9ce831-8b81-4cd2-8544-54b62fa81624@daynix.com>
Date: Tue, 28 Jan 2025 15:20:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
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
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <20250126201121.470990-11-dmitry.osipenko@collabora.com>
 <42646f72-c2c8-43c5-abe1-e8e1b3c9d31b@daynix.com>
 <87o6zs4mle.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87o6zs4mle.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2025/01/27 18:45, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2025/01/27 5:11, Dmitry Osipenko wrote:
>>> From: Alex Bennée <alex.bennee@linaro.org>
>>> This attempts to tidy up the VirtIO GPU documentation to make the
>>> list
>>> of requirements clearer. There are still a lot of moving parts and the
>>> distros have some catching up to do before this is all handled
>>> automatically.
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Sergio Lopez Pascual <slp@redhat.com>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> [dmitry.osipenko@collabora.com: Extended and corrected doc]
> <snip>
>>>    virtio-gpu rutabaga
>>>    -------------------
>>>    @@ -133,3 +218,23 @@ Surfaceless is the default if ``wsi`` is not
>>> specified.
>>>    .. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
>>>    .. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
>>>    .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
>>> +
>>> +.. list-table:: Host Requirements
>>> +  :header-rows: 1
>>> +
>>> +  * - Mode
>>> +    - Kernel
>>> +    - Userspace
>>> +  * - virtio-gpu-gl (rutabaga/gfxstream)
>>> +    - GPU enabled
>>> +    - aemu/rutabaga_gfx_ffi or vhost-user client with support
>>
>> Let's omit the mention of aemu. It is a dependency of rutabaga_gfx_ffi
>> and referring to dependencies of our dependencies will make the
>> documentation too cluttered. Users should also see rutabaga_gfx_ffi
>> needs aemu anyway in its build guide; the reference of aemu here is
>> effectively redundant.
>>
>> I don't see the vhost-user support in Rutabaga. Does it really exist?
> 
> vhost-device-gpu supports gfxstream although the 3D acceleration parts
> of that are still WIP:
> 
>    https://github.com/rust-vmm/vhost-device/tree/main/staging/vhost-device-gpu

It is nice to know the project.

vhost-user support is implemented with virtio-gpu-gl but it has its own 
device variant so it is not a right place to describe it. vhost-user-gpu 
is not documented at all so if you are going to write its documentation 
it will be a great addition.

> 
>>
>>> +
>>> +.. list-table:: Guest Requirements
>>> +  :header-rows: 1
>>> +
>>> +  * - Mode
>>> +    - Mesa Version
>>> +    - Mesa build flags
>>> +  * - virtio-gpu-gl (rutabaga/gfxstream)
>>> +    - 24.3.0+
>>> +    - -Dvulkan-drivers=gfxstream
> 


