Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE68C3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 18:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0lPT-0003j1-Gm; Fri, 04 Apr 2025 14:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0lPQ-0003fx-77
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:04:53 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0lPO-0005jX-7U
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:04:51 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso1458389f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 11:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743789888; x=1744394688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PhOvOgV+iEW3Y2/gsk17coF+DjwhEtkXBbD6pNWwevA=;
 b=B28JBe8Yf11hrAZF7Si7UF6GMMhfugNBFeaubTOqWydHtvlY1mZuvV8YD56x1TWH3t
 wdbcJ+n6ChuffugjIiP+8lJsZPMC7SRwnQ4TIUheArR+0I862wHbH7fviUvaiOPNmJqm
 nB8cdfSES4UTIWrPdRx6ebIRfcc4b0jXilHOaq/aHRPngZGcyaTAW3K3DITMBAtyOJ68
 wsIFIo7gWWgHKct8kpjFJeNZi0Sam5FbGYIeSz677m4ST+7zaNhBTJv1I7Nv17jvwa26
 Ed27A0Io/Urwx4/bLOa+nr2s/hSUC66JZVpl+ReL/QIN8lA9YLRqJcFbvjP82uVs5DPs
 bK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743789888; x=1744394688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PhOvOgV+iEW3Y2/gsk17coF+DjwhEtkXBbD6pNWwevA=;
 b=YjUsyQSUDC/NqCmrk3IbV/TECrJyUMvklBu50ZySIMA/G67kzixLK4KfcRq/6ZxdGp
 Eimq/P42BB+gAjpdSkHTv6NZl2nRn+4O+3kyRQPFpIdamIpyMRlW0AyCJMjW0NhOB+Xy
 /Kv3jcoH2i9/auCV/VVDbOc9D6LJuZN1pcctdaZrHjAP7CWNGS47ZJ9T/fThPv3ARMAi
 1uO9Wcw02mHs8clKSueDRXg6cOXMeHOWDRl0DdlPkWF/uI4JH162QyEcJ+gnBD08kcrw
 RZeTEgT6TpQMwBM5zIKAYQix3EJBx+J0Wjx6JQh4vmxWAqvb8gw7lbCvsAq+SIr3MOfd
 RAHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKw8hwBDZVUS5uufWiBOmY7qKEPRFJf/PFipTumpo6VRY18aXwsIhTEvkU/17n7qIfLJ3b2InSf73E@nongnu.org
X-Gm-Message-State: AOJu0YzwFGmFsiYAmV1qaYD5nB02wHi3Ek6lzzOBAHgCUPaOKHe5UTOX
 uyJhW39g0xghpN4XnVO4z/70dO9G2u7TNVTYYYS69UpfLhOJApytu8uqZaPlM8o=
X-Gm-Gg: ASbGncu5Ayif+M/JfrIhvGHpNiEpYL9hNLmG91hi0ujVGV83jDIYNXEiCjZoxcjhAKd
 kKQ5WLgoXkostOTFut6hxe0nqXss7CEsmd0sMi4zAfTSwhJm2/p4XoiYO9krklv3UfRcy6BcMti
 PGtznYPo5ktLUeCst82LvRO9CC7y5Lq8Px7M95SxwUznrRo0KT2aHYiQBX9Q0zAH8TxfV2Km1A/
 oC84k+s3akHbJ2p8/acjlDKPm2WxWe0cFl9epEn8IW5ba3npHn9ZwI7UIgMaMh+rJMX/5IktRAy
 vTZAZEhEOFaI+Dp7jYROMNxUh27fUk+ASJVGppM1VVjRg5RN/ETv52773UW/tmvi01rdS19GyEu
 uD9jOAMDgms1F1f7vsA==
X-Google-Smtp-Source: AGHT+IFqcqgJm8RZ1nQtnEivY8HY4KzSd9IZC9qnpNvS3yaGK4q4ACcGrejdknRqjVDbe3lL0Fhaig==
X-Received: by 2002:a05:6000:1788:b0:39c:2688:72a0 with SMTP id
 ffacd0b85a97d-39cb35b251cmr3545117f8f.6.1743789888253; 
 Fri, 04 Apr 2025 11:04:48 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d68esm4948647f8f.67.2025.04.04.11.04.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 11:04:47 -0700 (PDT)
Message-ID: <4c9a7757-cb6c-4cbe-a9c8-56e1f97d3988@linaro.org>
Date: Fri, 4 Apr 2025 20:04:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 00/39] single-binary: Make hw/arm/ common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <bf47e696-f63f-44b1-8451-5f00c4fa7a1d@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bf47e696-f63f-44b1-8451-5f00c4fa7a1d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 4/4/25 19:12, Pierrick Bouvier wrote:
> On 4/3/25 16:57, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> At this point this series is mostly a draft for Pierrick.
>>
>> After introducing the generic TargetInfo API [*], we implement
>> the ARM variants, then use the API to remove target-specific code,
>> allowing to eventually remove the target-specific arm_ss[] source
>> set in meson.build, having all objects in arm_common_ss[].
>> Various header cleanups are necessary before getting there.
>>
> 
> As there are some changes asked on this API, I think it's better if we 
> review this series later.

I think I misunderstood your comments in my series [*] reworking
arm_cpu_has_feature(), I thought you wanted to see why it was for
(completing your 'Make hw/arm/ common' effort).

> I'll still comment a few commits here that point some problems in the 
> approach.

Thanks!

[*] 
https://lore.kernel.org/qemu-devel/cecbab0f-56f2-434a-8508-8a4df2992259@linaro.org/


