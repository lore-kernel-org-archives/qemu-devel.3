Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA54C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQda-00070r-7t; Mon, 14 Jul 2025 17:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubP1r-0000KX-8e
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:40:05 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubP1o-0001ol-8p
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:39:59 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4561a4a8bf2so14441765e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752521994; x=1753126794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AYDsqCZbbKRVXIcGD0Th75rw6R7pwd0G284BdPZrU50=;
 b=DPG8rbwgEecZXr+usZxENV877vZiSdxYvRN602lL9EmHnjB/xwVbTOlZiB7nyjYrla
 x8ci+bReD5vAS9aGbFlGwBIiFtE9S8UJg/sCwLorv45hh7aXY9aMXuGxe5rHEW4EgkqI
 G0eKpX6oR+koLQuIwVFm7LPmv+tft3qg2QjDrnqzgZuCuBtLBwlxe22mHFQYgOby6QXM
 L9lyfVBJIHEmJwu2otV4538fwbQ8023O9Uod6fM0YzMT6YE1E8cjQkXLITsOD0VNmtYy
 8zzVclXs7kpxtV5HITF27B17HRgL3EwBfoa3BJhQD0WFz/a12NHUNE14gz9ID7NGGRMo
 hQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752521994; x=1753126794;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AYDsqCZbbKRVXIcGD0Th75rw6R7pwd0G284BdPZrU50=;
 b=Rp0SG2VpVMIgRmwvg7OkAWBAjv6sKsMkC97b3ztFtkcdh6O6984uo2DzdKdCzeBGtY
 upmzv1La+AiJzElN9AwVioy6eHLD5y6RFbBExx+wh6R0ATgT+LxxxKqpTjV/FWvwcDwm
 60LdLOioFTJVoLWgMdcpZubKLkjcpRz1VzCqXMT0NSDRmWhBa2yKQSNOJjmh0xZbAjuK
 wY3pCy/ECGAxvnuxCnVVYRJsrG4Er2+Kw+Jnk/jwGzVpCoAi1IMJss4Y9q3kEhKmapYi
 sHuZUdEQYqLwoZri466Nfu/NdU69ZmzODm+I+25AAH9gC4nPOn91dR9oix0Nwed98obB
 8jpw==
X-Gm-Message-State: AOJu0Yz9UgRTEq/ePehU6Q18ekb16pSgAtWPz33Td7v0OKJn/th84egd
 IcAA01YkBdj/QoqFKXDesAWbrauR4Tra1XybgfIpxNua9Bf45HY6vP937GqvkWeH3zU=
X-Gm-Gg: ASbGncsaNk1mM7K6YeJ7uWstDabs7Sg+CdSdTL7W7ZRh+cj34vbXy2yVzegQGbnsW9s
 M9rZOuJqB9IkPtoOqPF/Q/2VEsVhnGcFvmAaOq5kxbIHvoKB9rcrS19RmgvRrkHaOqRuqkHTKsz
 KDZqBjShyYFQhOYtlBV+X3gjU7ajmezGC9cZ119rYgWimZdl+iUxVZccN20KqU24X60TtENfu40
 +/5Waf1BjRn5nzKDyO7eQfPMcwvP1T3pKeVIjTf+LGzk0aNRLsVwzjiD6p1Yejy5jnK22U/IkRH
 o5J2Guh6o7Dpnw8935KRxveo5u6x6qcJH1Jm7en1gkoGqNFXnvCHAIQEXWcHWFpxAcE1GwbkhOW
 hiIHWb8JWZbKyLmJ5tn0HggBl5kuVCU0vYYWXk7uujsndeXutWqhTUYMCpaXbSNg57w==
X-Google-Smtp-Source: AGHT+IF8A4P7ufgns2DRXYYrVgvrp3BY2Zac9qPAIbYYB5fdRLWJ37QhofYWOJjeAUeMkeryksI9MA==
X-Received: by 2002:a05:600c:548b:b0:456:11cc:360d with SMTP id
 5b1f17b1804b1-45611cc3924mr68490555e9.9.1752521993886; 
 Mon, 14 Jul 2025 12:39:53 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561dd90af8sm28898255e9.15.2025.07.14.12.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 12:39:52 -0700 (PDT)
Message-ID: <06db4d26-f12e-4589-977b-750311c92bea@linaro.org>
Date: Mon, 14 Jul 2025 21:39:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 25/26] migration/postcopy: Add latency distribution report
 for blocktime
To: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
References: <20250711141031.423-1-farosas@suse.de>
 <20250711141031.423-26-farosas@suse.de>
 <CAFEAcA-_2a5CUspXhy8UErA86EnZ3_s=P2DQ9DPdrMDwNWF4FQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-_2a5CUspXhy8UErA86EnZ3_s=P2DQ9DPdrMDwNWF4FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 14/7/25 12:47, Peter Maydell wrote:
> On Fri, 11 Jul 2025 at 15:20, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> From: Peter Xu <peterx@redhat.com>
>>
>> Add the latency distribution too for blocktime, using order-of-two buckets.
>> It accounts for all the faults, from either vCPU or non-vCPU threads.  With
>> prior rework, it's very easy to achieve by adding an array to account for
>> faults in each buckets.
>>
>> Sample output for HMP (while for QMP it's simply an array):
>>
>> Postcopy Latency Distribution:
> 
> Hi; Coverity points out that there is a bug here (CID 1612248):
> 
>> +static const gchar *format_time_str(uint64_t us)
>> +{
>> +    const char *units[] = {"us", "ms", "sec"};
>> +    int index = 0;
>> +
>> +    while (us > 1000) {
>> +        us /= 1000;
>> +        if (++index >= (sizeof(units) - 1)) {
> 
> sizeof(units) is the size in bytes, which in this case is
> 24, as it is an array of three 8-byte pointers. So it's
> not the right thing to use in bounds checking the array index.
> 
> You probably wanted ARRAY_SIZE(units). Also, the ++index
> inside the comparison here seems unnecessarily confusing.
> I would suggest something like
> 
>      while (us > 1000 && index + 1 < ARRAY_SIZE(units)) {
>          us /= 1000;
>          index++;
>      }
> 
> which puts into the while condition the two conditions under
> which we are OK to shift down a unit, and keeps it
> clear that we maintain the invariant of "when we shift
> down a unit we also divide the value by 1000".
> 
>> +            break;
>> +        }
>> +    }
>> +
>> +    return g_strdup_printf("%"PRIu64" %s", us, units[index]);
> 
> Otherwise this units[index] access could be off the end of
> the array.
> 
>> +}

As a follow-up, this method could be declared in "qemu/cutils.h"
along with size_to_str() and freq_to_str(), maybe timeus_to_str()?

Regards,

Phil.

