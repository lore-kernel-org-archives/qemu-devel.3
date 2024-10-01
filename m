Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90655CEACDD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveuR-0005mN-Jr; Tue, 01 Oct 2024 11:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sveuQ-0005mF-HW
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:35:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sveuO-0006QO-VS
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727796928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+x+E0y0UrZV20b8IG32AEOJa7Q11s6yghgFTqSqvMsk=;
 b=d516DIMz2LuxMpPrHcdMKnioeWhJrAjZGud5M6Nlfnt3gteLwkJIabj1tsDjQkYQbG1jic
 WN6eQXlGFYGMa+Q09WRU43Plo8TvAX4r4qDkaL891XiwDdlXjL9tYd/EcFil6xDqeENF23
 eV/k8LlFjPRDDgl7TgQOyJIR2WgsfxM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-2o0B_30ENeKodnikVFOwLQ-1; Tue, 01 Oct 2024 11:35:26 -0400
X-MC-Unique: 2o0B_30ENeKodnikVFOwLQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5398dde92f4so2541647e87.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 08:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727796925; x=1728401725;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+x+E0y0UrZV20b8IG32AEOJa7Q11s6yghgFTqSqvMsk=;
 b=vcSAI6r2uVHWxnKCYuaH8E/iPUm7hV0Gf127CMWv1P6nYLO7Tfwisr3QvsQpUlAb8/
 KLsyYfmREsNoevSPVhT9E77qhPYVKduIPFlvf4M9NoiPqrp4bJvdHOfiPChPUxhMl64K
 jSsTzO/09fB/2YIzCjr0qsV7Qr+h4L5eGgKgSu+l6G+h8bH0kbXpY2RUkm40qygAXHVc
 +ilN6aIpcbrSRn+vngP/F4QRowoPVk4Y8Y0pB0gFzq5RDsQk2W/zrdLrZqxAgAM04P6a
 BMcvEzVns1AcMl5+6DV7mKgqzCmLBzQhYtYY/hrmb+HwFfmE0gQSBs03esF2TPnQVG/E
 3A7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMLKU2XNSjHMxStFL775rY9NvXr+Uj6pHG+CG5vSb4eKIuuVv7/fXhS08mqknOjtwr1h2EGwIZc6Ux@nongnu.org
X-Gm-Message-State: AOJu0YwpXJkXm2aAyNPKqCVBZkt9t2kphlpyc+MVEdPsh+x+gjXHjTuj
 NvnM0owtII8L/7gtTugReP9P5zf28mZUe/KlyKtSHjJmYmNv3VgwtUEB3P+Pak/BeX6pHGeljCO
 tWE6Iz07B1pKwZv5On4vJOH8CRz2OG4TseyDV5NreEiK8qFEo5Msv
X-Received: by 2002:a05:6512:3052:b0:539:9510:117c with SMTP id
 2adb3069b0e04-5399510129emr4673367e87.59.1727796925276; 
 Tue, 01 Oct 2024 08:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhBKJqIyPtFOrHmePEARikpOceZhnsmuyJeDP4QUhlfaRG0tYur/IxqWHvaq7DpoKdQVzoyg==
X-Received: by 2002:a05:6512:3052:b0:539:9510:117c with SMTP id
 2adb3069b0e04-5399510129emr4673345e87.59.1727796924774; 
 Tue, 01 Oct 2024 08:35:24 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57e3008bsm136494655e9.43.2024.10.01.08.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 08:35:24 -0700 (PDT)
Message-ID: <0e07d490-78a7-4489-9246-74d5d3c3155f@redhat.com>
Date: Tue, 1 Oct 2024 17:35:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] testing: bump mips64el cross to bookworm and allow to
 fail
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20241001123247.85610-1-thuth@redhat.com>
 <ZvwLeTUbCs4VWiFD@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <ZvwLeTUbCs4VWiFD@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 01/10/2024 16.47, Daniel P. Berrangé wrote:
> On Tue, Oct 01, 2024 at 02:32:47PM +0200, Thomas Huth wrote:
>> From: Alex Bennée <alex.bennee@linaro.org>
>>
>> The mips64el cross setup is very broken for bullseye which has now
>> entered LTS support so is unlikely to be fixed. While we still can't
>> build the container for bookworm due to a single missing dependency
>> that will hopefully get fixed in due course. For the sake of keeping
>> the CI green we mark it as allow_fail for the time being and disable
>> the problematic packages via the lcitool's mappings.yml file.
>>
>> See also: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1081535
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> [thuth: Disable the problematic packages via lcitool's mappings.yml]
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   v3: Disable packages via lcitool's mappings.yml and add bugs.debian.org URLs
>>
>>   .gitlab-ci.d/container-cross.yml              |  4 ++++
>>   .../dockerfiles/debian-mips64el-cross.docker  | 18 ++++----------
>>   tests/lcitool/mappings.yml                    | 24 +++++++++++++++++++
>>   tests/lcitool/refresh                         |  2 +-
>>   4 files changed, 33 insertions(+), 15 deletions(-)
>>
>> diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
>> index 34c0e729ad..4fdd0b2e77 100644
>> --- a/.gitlab-ci.d/container-cross.yml
>> +++ b/.gitlab-ci.d/container-cross.yml
>> @@ -49,6 +49,10 @@ i686-debian-cross-container:
>>   mips64el-debian-cross-container:
>>     extends: .container_job_template
>>     stage: containers
>> +  # Currently waiting for Debian to fix:
>> +  #  libgl1-mesa-dri:mips64el : Depends: libllvm15:mips64el but it is not going to be installed
>> +  # See https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1081535
>> +  allow_failure: true
> 
> Since you have removed these packages in the mappings,
> the container build shoud now work, making this piece
> redundant surely ?

Yes, let's hope that there won't be any other breakages with this target in 
the near future, then it should be fine to drop this hunk. I'll send a v4.

  Thomas


