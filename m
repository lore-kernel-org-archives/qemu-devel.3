Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8E2CEACCD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sve1M-0000Jm-JZ; Tue, 01 Oct 2024 10:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sve06-0007AJ-8h
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sve03-000267-SK
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727793434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1cYVmJyayBXwgGhnFV/fyQchLGZQEWnktyIkhyKrXCE=;
 b=bTlJLqCgT2oPqLSJIgQmT6RvvryZsMdcgmAKjaNImnTrMg/y/SgKYW4KkeZXYBksSa0hcR
 jenqvkGaDrLd6KByRgZi8/SO30WTSYvB+QyBK74lesxhcTy5yqVaaW2hBfUQzZIh2QGP+8
 07s6L1O8azD2rYN0MzK5cg1beW8pcts=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-VR_sfKJ6M9CPJWskgxyHOA-1; Tue, 01 Oct 2024 08:33:59 -0400
X-MC-Unique: VR_sfKJ6M9CPJWskgxyHOA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb236ad4aso31056385e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 05:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727786038; x=1728390838;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1cYVmJyayBXwgGhnFV/fyQchLGZQEWnktyIkhyKrXCE=;
 b=Cczz3s9STRRUDYzv6UbR40bmspj44EzOEHzUZepOT+za34WPKCk61o/QbbgdcFdGed
 Um8cDU0pb2burof6sH2UZLn4xj3Nb70a7Sq3ClSZbKI78vvSdtynPQ34t/SURP9gQTaE
 PQuabIgL5GHkWb3lFXKgfaT6yIjaI66dHdMF+BPcD8SWHomP7gvYZKNv8fPkGV/yY3v4
 wXKBn4NE9gaDfon7QBhMBVPdHiH7qNDRjf7H4bziv+XTh8SpHxdJ8lpP0x02D2ZGOkwO
 rPBSD9pVzYIA7RUMQzsd7iRygaqbcQjrZ/hru5anhZ1lU4CLrAabHLzgroNW7vpdcUY4
 ml2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMbiHPeTpJzqxGqSmlumqOhbPwfRYT3XAMz2caBTphzRbGuI/v1m/TYMvy12q9YPvOSDdckaKnvMsW@nongnu.org
X-Gm-Message-State: AOJu0Yyy6HHtGYOYpGynHufD8n9WmmFKDV9iCmw6uHtXF4KvL3CD4c6C
 kPi5jH8Jn/uDXMTGXJDoWWTQHQ85FKDfdpuZlmFzHVaooTseUSrWOsZbUDN9w8TsW0y5VZeCsnh
 uXFaJPkyyytF5eLcCVa5dstpQjTtFYdcJ+UsSMm9cJoPQ6Yk1b2xH
X-Received: by 2002:a05:600c:3552:b0:426:6eac:8314 with SMTP id
 5b1f17b1804b1-42f5840ef00mr124073525e9.1.1727786037791; 
 Tue, 01 Oct 2024 05:33:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS3KcIwBOmjmW15hB2I1hL/9nRj2q7gk4pZIowDe4NsXIYGDP+iFoRMNQnlebHmPd9USyjAA==
X-Received: by 2002:a05:600c:3552:b0:426:6eac:8314 with SMTP id
 5b1f17b1804b1-42f5840ef00mr124073345e9.1.1727786037418; 
 Tue, 01 Oct 2024 05:33:57 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57debe51sm130778435e9.20.2024.10.01.05.33.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 05:33:57 -0700 (PDT)
Message-ID: <f8c8d67e-3ad1-421d-b23e-8203608c79a2@redhat.com>
Date: Tue, 1 Oct 2024 14:33:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] testing: bump mips64el cross to bookworm and allow to
 fail
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20241001105148.74182-1-thuth@redhat.com>
 <87bk04nkar.fsf@draig.linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87bk04nkar.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 01/10/2024 13.18, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> From: Alex Bennée <alex.bennee@linaro.org>
>>
>> The mips64el cross setup is very broken for bullseye which has now
>> entered LTS support so is unlikely to be fixed. While we still can't
>> build the container for bookworm due to a single missing dependency
>> that will hopefully get fixed in due course. For the sake of keeping
>> the CI green we mark it as allow_fail for the time being.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> [thuth: Temporarily remove the problematic packages manually]
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   Removing the packages that depend on mesa manually helps to get the
>>   job green again:
>>    https://gitlab.com/thuth/qemu/-/jobs/7961678029
>>   That's of course just a temporary fix 'til the next update via lcitool,
>>   but hopefully Debian will have fixed their distro by that point in time.
>>
>>   .gitlab-ci.d/container-cross.yml              |  3 +++
>>   .../dockerfiles/debian-mips64el-cross.docker  | 20 ++++---------------
>>   tests/lcitool/refresh                         |  2 +-
>>   3 files changed, 8 insertions(+), 17 deletions(-)
>>
>> diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
>> index 34c0e729ad..c567926182 100644
>> --- a/.gitlab-ci.d/container-cross.yml
>> +++ b/.gitlab-ci.d/container-cross.yml
>> @@ -49,6 +49,9 @@ i686-debian-cross-container:
>>   mips64el-debian-cross-container:
>>     extends: .container_job_template
>>     stage: containers
>> +  # Currently waiting for Debian to fix:
>> +  #  libgl1-mesa-dri:mips64el : Depends: libllvm15:mips64el but it is
>> not going to be installed
> 
> Peter if you merge this one then it might be worth using the bugref
> instead: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1081535

I just sent a v3 where I added the URL and disabled the packages in the 
lcitool's mappings.yml file (so we won't get the packages back by surprise 
when someone runs lcitool the next time).

  Thomas


