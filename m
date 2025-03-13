Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E444C35FF1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 18:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsnLl-0004fo-OE; Thu, 13 Mar 2025 14:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsnLh-0004bG-4D
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 14:32:05 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsnLf-0001q0-2O
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 14:32:04 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so2937615a91.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 11:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741890720; x=1742495520; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WmRDnfS73qXz7SwFKhSsDOk/q+mwLA6FR8HRmY9vOBk=;
 b=ZO1ZhKl67GMIi5FNRNSwK9QcNON2usI1CdrsHYafgHgqBVtFTPHJ40h1mh0pblblxq
 92HUR9VcrSjyO3Gw+murpEXon1XAUt9XtuI46xu7muIzPQIl4OlYdt5xfi/B229l5GUv
 l9cXtZV2RnmsVdsaN17PXwmIKM6f3T0tj8Xsgnt71lZBie7cA7v6aWB06GULYr+J56mO
 or/oarBWidbegz8ekr9AlTqaD4l3NzZ6wGlhGWlRF0pDh6FRmbMIaIiSYp7/JbjW7I1E
 fjViBJh23tgV9M5y/kmH153brgxIobO/er4XWXRrHFKHgW8DPHjD6Y4E0MKOYknGC1e/
 zm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741890720; x=1742495520;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WmRDnfS73qXz7SwFKhSsDOk/q+mwLA6FR8HRmY9vOBk=;
 b=TQYbNrV429EPtB7U2kMP4N+QAWx3EJF50B50gKON778KXBDnL9HEMvjFUEfGht7kMB
 liG2Kn2dGsvRfVyXmmCw7IfCvcP8zF+rLwYnzRitXKF7zDkbm92ujYVEUxaZfV1d3Pci
 cWT2iWdKhV0Xq6aFnbF6brnUQoaqBB1PS0m36U/Yqi4jSswnCMOKNiJq31nGPusyCu6H
 IsO4XPryuu0XcLzsAuM2vyp+1ObLR0ghubvBbOwL2ojBOz6r+c0y5TzfFE44Bn9M1h1J
 auHyw+RrfNi3ye4L1W9ShvhlrUJsKpshViA+I7vC55Ci1nKSeuXagnYfcIMoz2cH7aOO
 hXEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkHx211VeabKZysPGAjkJsysOCFne8K59m0T8BvKMQgjtplrDbnpEPEdQf51YX+TnxuL1jFQ7o6uq5@nongnu.org
X-Gm-Message-State: AOJu0YyXup22H8USla+tED4ms1AZBYcx7b1DlVObmEJDSUJQj2MKqu09
 2plVUHfk8FI0VbmKh7kDkqz58kOPcf1TZkMNhR6Zvs2sBW/zK1ySgNoLe6/5nKo=
X-Gm-Gg: ASbGncubdPxrX7zLbTqggNmDin+4HQ3ZOdoGoQorgbLR+PUhHqUth0WN9JvxA3VGPm1
 N9hQTdAYdmd3IbuV24PNWnIyezIFfubdY9+FOKPI6/nannP2AWEKBpiJCUhIjd1d1M6PcS2XyvT
 EuQj2PHmnT+iLbvGDp/D8mDPhVFS4sVU46MGLjU8j00NDtBYYEIlcrWZXxdzau0QC0KUYhuGp8a
 VCwgxWmcKiEdyVOSAa0aeoBo9eTO7gCxJvBf/db/hC3ElSbV9f534UBChBDY2BracyqctW6+sO1
 aRmZdOb6wHXhGyfSa3BvyVotgfY7lRdaPkQwIO1LTD9DB6nwyGXrrnHuFi8CsGWosRVEGHTveLu
 IcRUjUl5X
X-Google-Smtp-Source: AGHT+IGM843pm1u3AgW1YUccbf0FYpvpbkwmutLqbhgPo7aab6Fj3UUqU+M4QFaDYk2aR8pZXjbnaw==
X-Received: by 2002:a17:90b:51c2:b0:2ee:e945:5355 with SMTP id
 98e67ed59e1d1-3014e861b88mr652055a91.19.1741890719785; 
 Thu, 13 Mar 2025 11:31:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3011926575bsm4184293a91.30.2025.03.13.11.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 11:31:59 -0700 (PDT)
Message-ID: <9947cec0-6316-4e5f-a836-a1e5a5be156a@linaro.org>
Date: Thu, 13 Mar 2025 11:31:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/37] gdbstub: Move syscalls.c out of common_ss
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-19-richard.henderson@linaro.org>
 <ccb46ae9-5e94-4f9c-acad-16844c37f952@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ccb46ae9-5e94-4f9c-acad-16844c37f952@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 3/13/25 10:46, Pierrick Bouvier wrote:
> On 3/12/25 20:44, Richard Henderson wrote:
>> Copy to libuser_ss and libsystem_ss.
>> This file uses semihosting/semihost.h, which has separate
>> implementations with and without CONFIG_USER_ONLY.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   gdbstub/meson.build | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/gdbstub/meson.build b/gdbstub/meson.build
>> index 0e8099ae9c..b25db86767 100644
>> --- a/gdbstub/meson.build
>> +++ b/gdbstub/meson.build
>> @@ -7,15 +7,15 @@
>>   # We build two versions of gdbstub, one for each mode
>>   libuser_ss.add(files(
>>     'gdbstub.c',
>> +  'syscalls.c',
>>     'user.c'
>>   ))
>>   libsystem_ss.add(files(
>>     'gdbstub.c',
>> +  'syscalls.c',
>>     'system.c'
>>   ))
>> -common_ss.add(files('syscalls.c'))
>> -
>>   # The user-target is specialised by the guest
>>   specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-target.c'))
> 
> So it fixes an existing issue if I'm correct?

I think it currently works accidentally, because semihosting_get_target() expands 
differently for user vs system.  But we provide semihosting/stubs-all.c which has another 
copy of the user version.


r~

