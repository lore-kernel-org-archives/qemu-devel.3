Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72770C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 18:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfkWU-0004JZ-23; Wed, 05 Feb 2025 13:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfkWS-0004JF-27
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:53:16 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfkWM-00054p-CN
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:53:15 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso585235e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 10:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738781587; x=1739386387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hxtMWXCuO+7WMlBZ19JRx42xZmCJLYHIpazOdHWhO74=;
 b=Qmy6ZC85Cdl54UlxkPV6pE28bQeiQAYKojWlI1F+TalKuIzYz/5OG7iGNfvi7fJif8
 b8wUzSyRrWTuzrK0rujbaPEMdAnLvdHbzwHA4LBaDbs2Fk8zahIOe9MSN7qsl0ZXWoLu
 elzA5FvSZR3FYJYZ+7Bp7McoYFCnDs+mUjq3neOBmOaq9vtBPL31pOrdromy1WXEAf4T
 e3Pk/b1tyqlkBLzfJbLcCJE0RSyr3Qa4X7i39yV3DAaIXY1FTA/dd3AF4Skg8Q/rbZW4
 9kYLvN0TSYxzpDeB34DJliXJbQn2QZuBg3LU02Nclu4G1NobDtt+QHLK6b/rEMmHhxkM
 vKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738781587; x=1739386387;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hxtMWXCuO+7WMlBZ19JRx42xZmCJLYHIpazOdHWhO74=;
 b=hQ0LI0Rjy65yc2/osgdRNk9Nv6/wM6uOMsUVMA2Iew6xD+Z/WzHYwNt0u3FCz5gT9s
 5kbZodEIsHTaE3becA1AlWjjyF7FSkrmC/5ngKWoghqSFn+XU0qa/x72mPvYw6iGOv54
 F6kAtYFJ+uNfme+vkATWrJzzzzFp5REDXUk9s/XjS1D9cTjQdwLGXH7wisgOdyV2SGzF
 r6GNEGBIyDhkMhmsaaGFEAXXfhHwQjy389LDstHGDKhMjcr57uAyCoGLmvGS6jb8cUnK
 kPWfAwin+jdMVqubye548SCKQcwgPsZwOD1643Wof85z0XAois6OI6D9L+0sbMsR6utj
 wJtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM3XXuMcensImY5F6N8MVnL3MAagIzWUL6dABW5Xg/1PZW05C6cpZ8/UZl77JchAZcgr1MZ2ED2sNC@nongnu.org
X-Gm-Message-State: AOJu0YzY2n44c6zq1Kxwq6yyrCQO3kNfPr469TZ1LccMZ4qjQxxpo2/r
 dhjL3jA/N3MqApkB0wgVdbIYHacs20KiNFfjUSy45IwK5qsq83P+3RbbO1zYsy0=
X-Gm-Gg: ASbGncvoQjEFMt/sTCXEWoHc0jGLLZTdC8dHr3hzMrDFMyLI5UGJjTDfzqWYArh1JHg
 VHwQzLVLEvhN3uAFQDjiXwDVfnB77s9q+cxfzsUoRG5rFEt+xo6Dm9Rd+jqIe34kbKwDlMu22lg
 hHs7huebkZYhrr/NQKlTiLuxV45FitCi6nlRras5zYmiIhJafq1HD39HPQxxyU4sYG8Ue1Hp4Uw
 88D9wWj5a7/wn3cLoDcOMdKLk/b8Y567UDjoDXECicBM0wlJop2bX1XjLchGyiGNjNyZJQhNUBa
 ds1A2U1KljnQ/p+QBY4oZw0kww/Hnqt5lhGqJQBnvm43sqei558oxrFb7RQ=
X-Google-Smtp-Source: AGHT+IFV/7Hj5D4qE11uKqx+4NTG0YLLpnpL6+/MnZCkk5zE4PxjRBRgxf7kDqmZLX7pW//HfJeGqQ==
X-Received: by 2002:a05:6000:1fa7:b0:382:450c:2607 with SMTP id
 ffacd0b85a97d-38db48866b0mr2619642f8f.4.1738781586994; 
 Wed, 05 Feb 2025 10:53:06 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf44f3sm30304525e9.29.2025.02.05.10.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 10:53:06 -0800 (PST)
Message-ID: <56da1b10-345d-40b7-a6c2-03f910d9440c@linaro.org>
Date: Wed, 5 Feb 2025 19:53:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] meson: Deprecate 32-bit host support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 berrange@redhat.com
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, thuth@redhat.com,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
 <20250204215359.1238808-12-richard.henderson@linaro.org>
 <adce8772-d473-4b1d-b0f4-1f921ce89932@linaro.org>
 <502c72da-9079-46d8-9d1c-4a63d2da86c4@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <502c72da-9079-46d8-9d1c-4a63d2da86c4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 5/2/25 19:12, Richard Henderson wrote:
> On 2/5/25 10:05, Philippe Mathieu-Daudé wrote:
>> On 4/2/25 22:53, Richard Henderson wrote:
>>> We deprecated i686 system mode support for qemu 8.0.  However, to
>>> make real cleanups to TCG we need to deprecate all 32-bit hosts.
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   docs/about/deprecated.rst | 7 +++++++
>>>   meson.build               | 8 +++-----
>>>   2 files changed, 10 insertions(+), 5 deletions(-)


>>> diff --git a/meson.build b/meson.build
>>> index aa1ca8355d..3347b0a553 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -4843,14 +4843,12 @@ if host_arch == 'unknown'
>>>       message('configure has succeeded and you can continue to build, 
>>> but')
>>>       message('QEMU will use a slow interpreter to emulate the target 
>>> CPU.')
>>>     endif
>>> -elif host_arch == 'mips'
>>> +elif host_long_bits < 64
>>>     message()
>>>     warning('DEPRECATED HOST CPU')
>>>     message()
>>> -  message('Support for CPU host architecture ' + cpu + ' is going to 
>>> be')
>>> -  message('dropped as soon as the QEMU project stops supporting 
>>> Debian 12')
>>> -  message('("Bookworm"). Going forward, the QEMU project will not 
>>> guarantee')
>>> -  message('that QEMU will compile or work on this host CPU.')
>>> +  message('Support for 32-bit CPU host architecture ' + cpu + ' is 
>>> going')
>>> +  message('to be dropped in a future QEMU release.')
>>
>> This change still allows us to remove 32-bit mips host support before
>> the other architectures, right?
> No, bookworm goes into LTS in June 2026, which would match QEMU 11.1 
> release.
> If we add this now, we could (selectively) remove 32-bit support earlier 
> than that.

Great.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


