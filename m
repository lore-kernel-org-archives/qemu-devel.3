Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B90D1D484
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdu3r-0002cl-ID; Thu, 08 Jan 2026 12:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdu3q-0002Wz-1J
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:44:38 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdu3o-0007MJ-Do
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:44:37 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so25586375e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 09:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767894275; x=1768499075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BkQ/L4b2tBb2U8N2kfA9HUWTFje39++5WYvtIHmVMqU=;
 b=fh5NHBh5XYLBD7f8mZSj2OKt4levCjYjp44ixHrztEeH9zUfijq6yrk+dXv+GQwxtN
 6IfV1Izhn57pSpHLzTYTBe+7sIjkWGMrYQX1tzwnWSNa85uwbdEzlhvpgyxDH8/q1hfR
 R5Zvt7BNfEJ2HnVGJE232JoLhV/VGvwEjafN30TGzgGygNc0hM4Dls1+94s8qGkGJfmL
 ZEiI4JEvqftwitPNbX2YvjzF/AKQX5gDOXzXcF2TugtP+/DIbNdN9RHZOIkn9E+4/gEU
 il5dw5ltilBuqs8jO08eXk+1gC+6naMlVz1TmGEX5ySC4BuC5ColBnT5/X5oJ53a3/To
 pG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767894275; x=1768499075;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BkQ/L4b2tBb2U8N2kfA9HUWTFje39++5WYvtIHmVMqU=;
 b=PaRZ0J/qc9h/lGrBJTvrt1UqGHBc0Y2G9HekV3otWyjXAdDnFoJoH/4PicjwO5HIkr
 IDDo9EhxFwnjVmrYqWXjiU+L3ZhehIw75VNV7U/Rx97Mw4Jl8vpycwaGYKE0mOaE9+IE
 3tGuhKX8MUR1jf0klQfdt8PokCz6qyht8DvP0BDlWZoNmBJQitG9rAXnzhoMn4peiBy2
 iKQLg0fcNm1xuMbXBF9/cabPkSH4DssF5wDNXFVMKctD6qL6WfZumPfP0zosdfdY4u5B
 K+0s7mVthROJJqQoVTKJUYIk4rVE61IY7Fu5cTR8YcM8HU+MpgbE7Kbe6AJADWGMQYcg
 xr8Q==
X-Gm-Message-State: AOJu0Yw1ILhjJ1Lw8bLvkNgLg81Ahg5mlI2/3j9rGQu1A8qG0wLfkoCs
 2QKZcyOz58/4J6iVwV9oh41VjorIXxltw4dNU8Fsmr98E7HG+By8232e3/iTr/hPItw=
X-Gm-Gg: AY/fxX7JrR9yXJY9BO4ls5XMX3WM6U2d+0IKMOdy3rHuaN2gF3u/VdXU9b82zmoIrFn
 JVdhyaeq582bUXIv+9dVNDRfOyaHTh0bpEmNNbLmbIMmo1Qy7V2Tflm0F6tuWgZPh81+NsJGA+e
 Q8YYAh9b3j7YStQ0ATQRr2Lih/GLGt5PfN7gqmb6Mvm1l6pD3GxuqZ3Vp+u3XR+53E1Kvs4QIDs
 nJKcsXd9g7z71izqvVv+nvsWv1FvvSqyrAjY76boblm4hqnrerqTSBvNvu/WtmMCiVkw9D1nuGJ
 8YpqjKneHxOdHyFtJMSRV5x2hivTIQLxhkrA9MxtVyYdBbi9AthC7dsbD2ZdVF3AQ5ImuhWBjfX
 0aTVRsbLLfmAfRf1dnkecDlRAkcpsFvucGKzD+BMOd+vk3qF4DVSjR6Ibwn1S7X3KPyhI59lp8Z
 kElo/mLCv9IT839fOgE7kJ1w==
X-Google-Smtp-Source: AGHT+IFXC7Hptw/ezkbHA5AQQQn2ErfhWtJyj4JHkMq98vUntWJuxdWuRzQTVObdAGWCm/b3aShVKw==
X-Received: by 2002:a05:6000:4301:b0:430:f704:4ef with SMTP id
 ffacd0b85a97d-432c3776a9cmr8561205f8f.61.1767894274585; 
 Thu, 08 Jan 2026 09:44:34 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e175csm17451605f8f.14.2026.01.08.09.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 09:44:34 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3F9D35F804;
 Thu, 08 Jan 2026 17:44:33 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,  Aurelien Jarno <aurelien@aurel32.net>,  Jiaxun
 Yang <jiaxun.yang@flygoat.com>,  Bastian Koppelmann
 <kbastian@rumtueddeln.de>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  qemu-arm@nongnu.org,
 Yoshinori Sato
 <yoshinori.sato@nifty.com>,  Yanan Wang <wangyanan55@huawei.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,  Thomas Huth <huth@tuxfamily.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [RFC PATCH 02/12] target/m68k: introduce env->reset_pc
In-Reply-To: <7361d961-6dbf-57af-b5e6-93f32c1b2b4c@eik.bme.hu> (BALATON
 Zoltan's message of "Thu, 8 Jan 2026 18:14:57 +0100 (CET)")
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-3-alex.bennee@linaro.org>
 <7361d961-6dbf-57af-b5e6-93f32c1b2b4c@eik.bme.hu>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Thu, 08 Jan 2026 17:44:33 +0000
Message-ID: <87cy3k80e6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Thu, 8 Jan 2026, Alex Benn=C3=A9e wrote:
>> To transition CPUs to use the multi-phase resettable logic we need to
>> stash some information for the reset handlers. Arm does this with
>> arm_boot_info but for m68k all we really need is the PC we should
>> reset to.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> target/m68k/cpu.h | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
>> index d9db6a486a8..fda015c4b7b 100644
>> --- a/target/m68k/cpu.h
>> +++ b/target/m68k/cpu.h
>> @@ -155,6 +155,7 @@ typedef struct CPUArchState {
>>
>>     /* Fields from here on are preserved across CPU reset. */
>>     uint64_t features;
>> +    uint32_t reset_pc;
>
> The m64k CPUs are 32 bit but should this better use some other type
> like vaddr or hwaddr here?

Possibly - but the underlying env->pc is also a unint32_t so I didn't
see the point of adding more churn.

>
> Regards.
> BALATON Zoltan
>
>> } CPUM68KState;
>>
>> /*
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

