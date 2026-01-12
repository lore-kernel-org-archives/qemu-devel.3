Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E33C9EC63
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFMF-0001CO-CT; Mon, 12 Jan 2026 05:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFLn-00012H-2C
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:40:45 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFLl-0002xH-4R
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:40:42 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so4409634f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768214439; x=1768819239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5+3Z14vB+A//iARqNyHueM0P1K0Ffaa/6or4Y2UKcmI=;
 b=d2PDHwCMpTb1/29k+/YgelVqKTTWAQqQsHYOKelkzYk71d+ElWlBfr+rONdr7uX42l
 +l5iwE/dx0nHjK2G5StimR+e+oKEv524MmMX6VjL1fADCxqwnmYF45DCwqI2Tsby5a0P
 uO/Fy9FWAdLQoo1pj10uaoa27Li62DnEPcRqJAdyBVyqlledlfa38wheHuaZ80S+nlJJ
 /SBdwnziX2WVxP1d85Pwyc0xI4djumGop0BPVsF6s6LI3lb1Zmza3bwmua4mKSA2/gDx
 AnMo8AdUlRCgSlDv53BYbUJ2RbhWyV8yBoy+x5vNkqErI9twM/2l3JZr8ztbLNtvdJHJ
 rhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768214439; x=1768819239;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5+3Z14vB+A//iARqNyHueM0P1K0Ffaa/6or4Y2UKcmI=;
 b=p4LzTwH5edfLSLBWyJ2APj5dj3xxH7c+v15VJ/y5RiduyNHpNid+TZTKJ4v25pAPI4
 bPZIQo0s6MV85UPoU14LKDW8uEunN2KZZwHmHTn45mpPoYd5cOTu0S2bxT5nWjadstiZ
 UYaRmk4P9URi+hhtnUgznUIf4tuMrqWQYu1Znt8GmSH5zIiPnCWAWBuL4RjM1p/Zt5Iq
 Z4NOlrJAat7rq/GodWvOg0xYjinUdTXV9mDmttSaUTVZJhbT72c1PgtZ0flsOnJ/kMs7
 sqJ5eWDF8MNH/1uWeKDgRSMv9xZmnzn8WcCe9ECi5touGuypmgW0zp+8H6aa9FK4j5zW
 bgFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ1830kJE5kpPUjRjyOE2GX01Xo5gvIz6pCx+ip3b4//riIyr5PHiSa4zYYfC+SK6bpBFYP2PrMLAn@nongnu.org
X-Gm-Message-State: AOJu0YylWiZqVFj3yQI0ywghU+Nm+faxa49A040klJLJD8FkNmkU9cBK
 0ea9ip6vDxXU3lreKGTRarix2Gv0S9bmE7fjFlVU37U8tKOYCbF0jMisYmDzdYRiYL0=
X-Gm-Gg: AY/fxX5nOKtQO9YuIQOg+N/WnosCa67fdY0Mmvk3UcvadHeMJhTaXMYzwxIEwVK4qPz
 yZDHSW2WeytJt/KgWifZUfCU1bD4pL2Qza3NwDKlaECmy7LdL4K+4qkRJJGz/etBcHRsiL3whkA
 cRFxwuJsQRGPmqzxLEO7VNGypBHcofHSe2iAxBAMQbUdigpUNor45es4WQH43wmHRY9e4AntaK2
 tBBKblbH1fmynJi/LVFmwPagNBxzY1OJ3kd/LwgE+PiTc8YLlpXEQIYbNgzdMjdqyG6Q4JhjIXY
 vmp3wGktveOXJ5Fq3O3pt0p8UzkEDGYI6i/8xuVhcjQvTUrPuiCYhuQCGBfxDQopXasSeZB1DLO
 wmOixXBG9dm4ygnT5emjM73UfkaGOgwJPGQ8eJK+9WkTMJwgQreCb++D5ngZEEs9PvsvLp7tzB+
 kqcRH/SbCQAbNQi3lmW/xbFjh/95ndWXhvtIuJkPegZwPI2PGOXDVeyw==
X-Google-Smtp-Source: AGHT+IH+3c/sqeawTkauZxZLJSnd1lxq3nQowrf3kbE5Ua2zPPWG53T3KJbH9VlUOnkJ19xKS5TYzQ==
X-Received: by 2002:a05:6000:26ca:b0:430:f5ed:83fc with SMTP id
 ffacd0b85a97d-432c3760facmr21974104f8f.11.1768214439177; 
 Mon, 12 Jan 2026 02:40:39 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee5e3sm37563299f8f.35.2026.01.12.02.40.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 02:40:38 -0800 (PST)
Message-ID: <1cb8ea3c-4b6f-4d9a-bbd3-52f8d820a764@linaro.org>
Date: Mon, 12 Jan 2026 11:40:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 1/2] virtio-gpu: fix error handling in
 virgl_cmd_resource_create_blob
Content-Language: en-US
To: Honglei Huang <honghuan@amd.com>, alex.bennee@linaro.org,
 dmitry.osipenko@collabora.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 armbru@redhat.com
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com
References: <20251126020208.2449414-1-honghuan@amd.com>
 <20251126020208.2449414-2-honghuan@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251126020208.2449414-2-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 26/11/25 03:02, Honglei Huang wrote:
> Fix inverted error check in virgl_cmd_resource_create_blob() that causes
> the function to return error when virtio_gpu_create_mapping_iov() succeeds.
> 
> virtio_gpu_create_mapping_iov() returns 0 on success and negative values
> on error. The check 'if (!ret)' incorrectly treats success (ret=0) as an
> error condition, causing the function to fail when it should succeed.
> 
> Change the condition to 'if (ret != 0)' to properly detect errors.
> 
> Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-virgl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


