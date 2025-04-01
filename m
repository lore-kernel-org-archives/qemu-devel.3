Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9B6C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzcrZ-0006qO-3G; Tue, 01 Apr 2025 10:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzcrG-0006kY-7Y
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:44:54 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzcrE-0007P5-HA
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:44:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso2534630f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 07:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743518689; x=1744123489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ro3FAJfYM4sVjFmJ48owJm586vBhmRdfy9DHaw3s8Es=;
 b=GXwfJRBXxcS3TFYAQMzl+ata6nhLt2Bx0KDUtXT7uo6nREHavPFM2hg/n4Be3AoLuM
 I6Lyahaunc1u4ZvyCDmvl/9fl91z3PL/tJmdR1pVoNfM1NCXgs78VJKb+14k8oojGvTW
 RdrV06mKdInIx9a9fGUyjIgsBlIhb3M3/ct7eBZ4YU8DtVIiy55aN9fKrGFVrRUEIPrd
 cDL1MbEEpuVZrxVbJUZBVMrVPsgOzdHfx4uZllXKhU8Br9YC3TClGFV+WUWkyBCBbP3q
 XyXQ0sOQPzl9HsPYx5PDz1DQK1cGAMqp9fnQoh1izS8gMkBGML4PHntNixUHLAA5Y4jm
 C87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743518689; x=1744123489;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ro3FAJfYM4sVjFmJ48owJm586vBhmRdfy9DHaw3s8Es=;
 b=RE95w4ByX9/kdCA2PW87yG4czYGL+Ya93sAjUvqdZz+Vymyha2DH3TJs0W145Kiu86
 Qh1+UNqD5RgzJIGU3JSVuFHtwJAqNOkoB1RABu9woMXdoRIMyFXVUtZM2WhzWAGmWWTD
 obbv5GaxvZTRKgD2BCkk0N7Ux9Hffrt1Mk5Q/DvhSZzHyCxDJhK0JuY3wnKWSonHKD5v
 tyaWHjhGDRww6qz7f74FzQfLQWndFX+7Cdoq5Z/bd139iCnNt02LFq8/W8F+UWAsCXXd
 AII9MubFQRCZAJQ/Hyg/Umti8qqWBO8thue6ISFc3dbtk3C8SM3BQdJtFBlZ20Rct6X3
 jgZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC7Ta2H513POM33t/myfaN4uhM+WOP/PwvnSM2Us5fU00TVMr53F0XCgFpPlsoWfxjgBhbaRAm+kGj@nongnu.org
X-Gm-Message-State: AOJu0Yx+KaGMPuiyBYLsfKYvf3tp770Y7+oFULz3CVnRjCYVN3fbKDPa
 4xDbDLtGXnSW6h8ltOVCFyHJb1/Sa5x5AHLhEx9WuPQ1ZHEet4RfcHhHEMWj87Y=
X-Gm-Gg: ASbGncttQ+6fTDs6mS9lDfIvIBGLNkBTQ1ibfqdGdGbyq1yvXxasVj85IM6onoAfd1l
 jixxdt2VTSm3wrzEALOMdAb4o2V2n0mAJkmPy6oIc4uOVyzcFB0SObDt5kwJCIDKT+UHBEu2LrF
 3mhXTzRJhJQ2j+QJisjrTIKwIuozcnJTofrGkstoKaSaDw/mc9dJzRSUbsPOP8qp3hfEnoCGYjB
 7HFnFhuAJEJs59Yleu612VOg+jDWjZGGrp/UjGHpAViftWY5EDeMWpCAjp9Mkfd/7vMsXIswkwl
 j4rnMuL7GWdnosC8uD7pOAQgzMfnxYIDwsdTn+KHn7xhwMcX9DInFYl/UjR9i0ITdQRUnHOw5Fu
 53wlO+yIgal6z
X-Google-Smtp-Source: AGHT+IFi1oRY77BW5kcTSCc0DC1xPGcCFnB8+VfkAXX1CNmT7KgEOCvRvo/OwlCc7wo8R0K75WIVLg==
X-Received: by 2002:a05:6000:4025:b0:39a:c9ae:9efe with SMTP id
 ffacd0b85a97d-39c2364b4a5mr2913431f8f.18.1743518689149; 
 Tue, 01 Apr 2025 07:44:49 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8ff02e84sm157604095e9.32.2025.04.01.07.44.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 07:44:48 -0700 (PDT)
Message-ID: <5f5f280c-34a5-4961-a9c0-74df5e0b0387@linaro.org>
Date: Tue, 1 Apr 2025 16:44:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsd-user: add option to enable plugins
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, richard.henderson@linaro.org,
 alex.bennee@linaro.org, Kyle Evans <kevans@freebsd.org>
References: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
 <a2907212-feef-407f-bc2d-03667aaae174@linaro.org>
 <c474f845-3d3b-4060-94c2-0d7b5f044d82@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c474f845-3d3b-4060-94c2-0d7b5f044d82@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 1/4/25 16:33, Pierrick Bouvier wrote:
> On 3/31/25 23:15, Philippe Mathieu-Daudé wrote:
>> Hi Pierrick,
>>
>> On 1/4/25 01:42, Pierrick Bouvier wrote:
>>> Nothing prevent plugins to be enabled on this platform for user
>>> binaries, only the option in the driver is missing.
>>
>> Per commit 903e870f245 ("plugins/api: split out binary
>> path/start/end/entry code") this is deliberate:
>>
>>       The BSD user-mode command line is still missing -plugin.
>>       This can be enabled once we have reliable check-tcg tests
>>       working for the BSDs.
>>
>> Should we enable this without test harnessing?
>>
> 
> Thanks for pointing this.
> 
> However, I don't get the argument, as the same could be said about 
> system mode, which runs on BSD also, and already has plugins enabled.
> The coupling between user related code and plugins is very low (just 
> options parsing and init code), so I don't see why we could have a bug 
> related to a specific platform only for user binaries.
> 
> So either we deactivate plugins completely for bsd binaries, or we take 
> a leap of faith that it works for them.
> 
> @Alex, any further insight on this?
> 
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    bsd-user/main.c | 12 ++++++++++++
>>>    1 file changed, 12 insertions(+)
>>
>> Ideally we'd have helpers for common user code in common-user/...
>>
> 
> Everything is already common for plugins, except adding the call to 
> plugin command line option parsing function.

Yeah, I mean the rest of main() ;)

>> Anyway, since this patch does what it says:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
> 
> Thanks,
> Pierrick
> 


