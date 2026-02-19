Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485AAE9A056
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7nS-0004ih-Si; Thu, 19 Feb 2026 12:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7nR-0004i9-Pw
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:26:37 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7nQ-0002Sq-95
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:26:37 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82418b0178cso710225b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771521995; x=1772126795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P745p+6NIT+f3j3D1Mggjhfp31uHrC5pChbm/mXobjI=;
 b=kgWMltiRug38/QLgJlJnVpeLtjUoYGghORIQgSg0bR66jfr/J8NuGM4qIg2K1T9PUz
 YGhS0ZKAY4eU9/gZxLhyZy/8HVzCP4R2soTKLpddk8vE80w7syR1DFUFyslXwswLTOej
 YkdgHGzyz3KX2jYXI0njH+RsbOWbA2RvRYnDeepiFT8HLgrnc352PFMH+e6BrtZeqaYh
 GTSioFHrgRls5fuUYsTf43KuWE8S3/VMxNaxfRUTWHzBJvGf68feVuU2hYnmAvKAi0wy
 zPq1MSyA31U8EajPltGlxydulZEQIpforS/jhn1x3TLw6iHAXHLaINa5V7A/r8q1Xu8Q
 1zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771521995; x=1772126795;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P745p+6NIT+f3j3D1Mggjhfp31uHrC5pChbm/mXobjI=;
 b=vQziaXFnt8bNeVP7abdqyjmIvAtk3/2uKWbW9xT98pdxDGFBbdBbdXcV7Vbt72VbLu
 4phL/50sQxL/9mG28DyVgq3U+Dq4aTPyeVsrIB8NVp5P++gmbQLQOCnH+LOP7dzYdWqD
 PCFKhJ07yfFqYOQ47jrwDjgtNRFxrywkeAmgHrEExRgm8+SvfwsLq4Vs0NraA0EdIBTp
 +rc4t8E98NmEasopN9iSIDTme8qySusboRcfyUs/mzNJO4RxmS9E/20WOsnH322BXVYn
 uZDQKG1ioJtXR4RpH3Kv/RtIrRhAg6oh63WSI1xiP1aC6UDqxFmccZeMH2ktltRHIUIX
 upiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfPVS2YvVaf0AqoJNy8f6TflmT/G3ifC+m9AnBFwoFt9S6JSkSe4aJKhwke6MmLLjtMQFOQMK3t3vl@nongnu.org
X-Gm-Message-State: AOJu0Yy5Qt9n9M4XOX6pvJPrALecHNRypyjqRqXTqjFPoHI96r2PXmpY
 6umur7oAhF7fXPSyJ0CmCITgsinpDTFlY+SLo+7LjvlBiTdNEh3z4469BCyNglnsKcI=
X-Gm-Gg: AZuq6aJRQPuXXNl+o9Pn7TJlVoVL3oiM/mNwfsF4vwpgpNGRm4b5bhqWTysnmC7Ru+8
 sya7ElECzI1gzJUOuUawN8anZybRK8Rnb8X3kEoqrycEKVHY/OSDcRu+x7yMeC5IUEHnt888U0j
 ZJ/KvAhIGU4pe+4QoilBNBtbX4JE59icj4lwxJCWYe91bfgOEHDC6GNHkhOTDMAuVEsOoWFCDp4
 ZaMkaWhxvw6daCF9CrC1d53WMxFiAwP8v6+TsgYUCZoEXBu3RJsCYXkwqc6eSFyBq2rUdzR6YZx
 XEWkPCe7QWQhlrG+1UXGt84rkfER88R4BpvRZdWI2kqbDconEjFVh8kiwyua/vhv4IbZIJwvmob
 YfE6nleYomsrelqVuFfOXkI+vSyRuD3QDt3Utc5dH6VpBAetX8N39qhzHpRiMsPCtxd1WfCqt7n
 T5WYlfiGKskVFtL5oxOTljlQOFMVWmkEB4kDHCt4Z/PugiokD1nYx4TiyMj2KXr+lKpJ81
X-Received: by 2002:a05:6a00:27ab:b0:7b9:ef46:ec61 with SMTP id
 d2e1a72fcca58-825274f12c1mr5244245b3a.26.1771521994676; 
 Thu, 19 Feb 2026 09:26:34 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6b90b9fsm22761615b3a.46.2026.02.19.09.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 09:26:34 -0800 (PST)
Message-ID: <19620399-2891-4605-b884-44a8aea2a12a@linaro.org>
Date: Thu, 19 Feb 2026 09:26:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/14] target/m68k: initialise pc/sp vector during
 reset
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
 <20260219171810.602667-3-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219171810.602667-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 2/19/26 9:17 AM, Alex Bennée wrote:
> All 68k chips should be able to follow the architectural behaviour on
> reset which is to load the initial sp/pc from the first 8 bytes of the
> address space.
> 
> To avoid any potential issues with un-reset memory controllers we
> punt the final setting of the register to the exit phase when
> everything else is guaranteed to have been through the hold phase.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/m68k/cpu.c | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

