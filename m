Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7157CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 04:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Lgk-00036p-7f; Wed, 08 Oct 2025 00:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6Lgi-00036V-7J
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 00:22:04 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6Lgf-0007SJ-4G
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 00:22:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e34bd8eb2so77201465e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 21:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759897317; x=1760502117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u2ajPmm+eRUp61Y6Id+fOTEnJlRwOUyL/tHC3b6C1Fg=;
 b=Eh/X9Y0lQ4jrAAfmh15/4snByFs9zSihcRYN7E1AIlGDUW/T0bYAL5ce1KS+p9rpsC
 pZ0ezbotTlKEymrjk6u2QHGw8qPQvmuevfdxNB0Rw3b8bAkrtmYtz8XATfHq1IX5E0Yz
 w2IoRowtyhKJAWxLfnf26I0Nk5bPu27p4DJTrEIeLdeXnyWh4Y1NHvyYmkiz+WDTPqks
 J+0EXZpPNJxE9wN9dv6HDWntLNV6vMLH9mYYwj2u/GmWW80tY68etACpzCaW4OEl+cZL
 BmWzt4Ew6UzZ3xs7M9yDywgz2XO2AdyhfvhkH0Zw/8UefVMWojW6QjUp2nHqVrHrhB7a
 alYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759897317; x=1760502117;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u2ajPmm+eRUp61Y6Id+fOTEnJlRwOUyL/tHC3b6C1Fg=;
 b=aKHQNcljeMDWrtepYLCxsnGISOEFOK9vYa3arSyCEyFU6o/aG9aqTQiTBwrHq04DBe
 el7oI7i8CN44s7o5ULPOGMV6t7j+bQnzNMJc6UvSgpqHl6tGpy1VtcjLsHwt0rl0PrfE
 L37pIH2tvq/oVspoYazdRRchS5Sv/Y38DccmLPZM1N6GGW6JvtoZFc4FVmwnRjbvAOmy
 a4VCHe/nGztNWf1A7QlrfYoJF8nAHzyfdlqusdZ3QaPuS7nIUw6EEe2bekQjXcI+hh3p
 doAdBH2hmu4M1DwJwJ75WqF6+RoTGzN4LgnlyC6jCDYDh9p5TC6cTwxVLRcCG7anVIRs
 HnKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgMbiZuRk34qaEOg6WFHah46VKCgtyDVqhKT+gDoP86B3SU1aUdCd+sKeRd7uTUHFmi7D6UX7jFdqE@nongnu.org
X-Gm-Message-State: AOJu0Yya5WQK84um2zsnmRsWW/dhJdduFYWMux57QZLqcpZfQdmImK68
 5DSv4gn/Fp2ETXkaAmw1g9K9Ea8lp2dWa3yLBewhlBLy9tviuHfNMXz2xVjZQnvvSZE=
X-Gm-Gg: ASbGncv4H+wRoWm4RK+2X+U7FHz1og5coEknFn5mAV4sbEc5kpDqTgSByA7PJioNnJO
 NjaXRQRTMi/oy5HA/9JmS1NT1twZkyk3hoHD11DCCDMFLhdY2sZTUuwZFjHCSwY86Zrjg3eq2hI
 KUqZP8GURWtiC4iO0ygZUDkqhY3mQPnrRguPPW5YylTRavaJ85ToF+9fESRX7tRRFVeChl8ed5u
 tke5glH1H435DhU0HazXtqeMcWaDgPOaw0psiZFFnXmZCPR9AtsLvO5mOH7v/vUwlzmMQqB1VEf
 y6uswJMndzmPDuHl+/5zRGZNzQcA6VBvRdR6hOyGBa16PxDFSJlV76K7H8KKdYg8UhwUdOHnXIo
 cLRf8UD/o246PjXNnh+UNwDvHjkk36fuxLwdfySKjlSrkD6BG2JsWvta2I23oDlOBREQJQlJO2L
 VL6P5wIA2UT8rWYdVQSA==
X-Google-Smtp-Source: AGHT+IHZSQLZkkNaeWB4/oBFuJ2t0364K6H4BCVVUmclQQZtKBubym6NBZtTAzcWraw8jE4k2lrnnw==
X-Received: by 2002:a05:600c:3b11:b0:46e:4c7c:515c with SMTP id
 5b1f17b1804b1-46fa9b182e2mr11776665e9.34.1759897317395; 
 Tue, 07 Oct 2025 21:21:57 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f01absm27804078f8f.44.2025.10.07.21.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 21:21:56 -0700 (PDT)
Message-ID: <7beffd85-5800-4935-a95c-cd9a4c831b53@linaro.org>
Date: Wed, 8 Oct 2025 06:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 3/4] vmapple: apple-gfx: make it work on the latest macOS
 release
Content-Language: en-US
To: Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Peter Maydell
 <peter.maydell@linaro.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20251007203153.30136-1-mohamed@unpredictable.fr>
 <20251007203153.30136-4-mohamed@unpredictable.fr>
 <1e873f0c-3e1f-4d78-b61b-909443510191@csgraf.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1e873f0c-3e1f-4d78-b61b-909443510191@csgraf.de>
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

On 7/10/25 23:19, Alexander Graf wrote:
> 
> On 07.10.25 22:31, Mohamed Mediouni wrote:
>> Follow changes in memory management, and enable process isolation for 
>> a sandboxed GPU process when on a new OS.
> 
> 
> Please detail here why this is necessary.
> 
> 
>>
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>   hw/display/apple-gfx-mmio.m | 56 +++++++++++++++++++++++++++----------
>>   hw/display/apple-gfx.h      | 13 +++++++++
>>   hw/display/apple-gfx.m      | 42 +++++++++++++++++++++++++++-
>>   3 files changed, 95 insertions(+), 16 deletions(-)


>> +        FlatView* fv = address_space_to_flatview(&address_space_memory);
>> +        flatview_for_each_range(fv, apple_gfx_register_memory_cb, 
>> memoryMapDescriptor);
>> +        iosfc_desc.mmioLength = 0x10000;
> 
> 
> Why 0x10000?

Maybe we want qemu_real_host_page_size() here?

