Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DC3CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 13:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6TpA-0000wo-Ho; Wed, 08 Oct 2025 09:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v6Tp8-0000wN-W4
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v6Tp0-0001wh-JB
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759928588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7Yaeo8ONDHu8yBQPVDyWe11THAIJItb6+js7md93Gng=;
 b=eBS0HD4x7OBFfGKivrITKLdFoxz3CfpVY8uN9XnWr5Rq6jLpsqltPPiscXdPHJ6FLbxGT6
 VdgAGleK448dDUg3fsBQ0snoJiliv2k79J4QsRHZt4Tv3U9BwOYikGdJN1uD67Is7AB5LI
 skINotOUc30oKp5wG0Y+2xwW8hxcbkk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45--0r1uxEINz6v_qS_7B0WYg-1; Wed, 08 Oct 2025 09:03:06 -0400
X-MC-Unique: -0r1uxEINz6v_qS_7B0WYg-1
X-Mimecast-MFC-AGG-ID: -0r1uxEINz6v_qS_7B0WYg_1759928585
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e41c32209so36043165e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 06:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759928585; x=1760533385;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Yaeo8ONDHu8yBQPVDyWe11THAIJItb6+js7md93Gng=;
 b=eR/aPSB+J5JeIHdIU+Ypd4O4mevL2HUhcmhu00LKl37sHULA53f1M3pQAWSNRfOg38
 QdJfX+NAuVwdiVVdYgWCq5pvvx6DR0WekrJ3yd9jZ7/haE1VXj548tmpDhp97cRennUm
 /fawgpcU5houc9f1gpfCIUplrGPzG+CZA2+FSOMj1/BWoPOAarco1Xbxk4yrhSwzH8U4
 7J761wP7jvq3OjeIoXvcj2evRutqULfHciga6SQcPlcijdHRt9VcnQCgKAS4PSaKCuor
 aPic4Hrf4Q9tSGSZUFfSZ7iFIIikok/lOEdW/DuzYSbCivviHnTcKFa/Ffi4HFYbyQsP
 UbqA==
X-Gm-Message-State: AOJu0Yw7gUT/ajCiJEcN94Y2Xz1lAFIuylK53hNGnm4wgP+bd/uZX5zn
 Gvx2Q39SpwWqD76XDEkDGg7J0fUm91JDPJ9KCIx1GkJLwsPquMx77s23YuGMN2AA2g1ziSKneD5
 DzAcKiMaA/eSMgCYKkgiAIMoSpRsvb7DEng+htqgxZgv/8uyY9kJJIV4R
X-Gm-Gg: ASbGncvOS3sVrIJQ5d0oSvg5fln2e7aRvV6VvnS/q0iQusi7jvQwoJNoA8H9tDu59jl
 KZxJBIpLbEYTJIqx6koL2hvvjqrAMmg+VILPExf9BMk8XHa0HurE6z+DNf6xWP5xuWsrbDyK5qg
 X2mWETEC4AEymObCdqOLvh7oBU5poZV8R9LKFYRPw9g+zbzgcXR/y0M28z+yOSxUa7uH4EadJhW
 OzRboxxEcfhMtH4e283VmaehVrZaKLY8G4zCL+C9QU6QtKj3ct086x5LOy9w11888TOX9tmZBPF
 1xdVbkIezuX3ayJ38OjWpfP9UKko5L9m5JtFKRc/xw534W2aDggY4QdvnsY6Ggh2jsrifIez7OU
 X7QAl4nPIRw==
X-Received: by 2002:a05:600c:6383:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-46fa9a8f146mr22189845e9.7.1759928584974; 
 Wed, 08 Oct 2025 06:03:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkoLhN6Ur9RqwmSR2vHVN3qHInGnNr7kNFFKP+ThIjRimz8efVDCdERhs/qxeTdS/zLNefXw==
X-Received: by 2002:a05:600c:6383:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-46fa9a8f146mr22189435e9.7.1759928584381; 
 Wed, 08 Oct 2025 06:03:04 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9c16af7sm35514845e9.11.2025.10.08.06.03.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 06:03:03 -0700 (PDT)
Message-ID: <cc64c0d6-dbf0-4e78-993d-01f9dd865463@redhat.com>
Date: Wed, 8 Oct 2025 15:03:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests: add nbd and luks to the I/O test suites
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20251008113552.747002-1-berrange@redhat.com>
 <20251008113552.747002-4-berrange@redhat.com>
 <bc904027-5b58-4057-8ef5-15e4ebcca767@redhat.com>
 <aOZfLYcJZ-6dslcK@redhat.com>
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
In-Reply-To: <aOZfLYcJZ-6dslcK@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 08/10/2025 14.55, Daniel P. Berrangé wrote:
> On Wed, Oct 08, 2025 at 01:55:12PM +0200, Thomas Huth wrote:
>> On 08/10/2025 13.35, Daniel P. Berrangé wrote:
>>> This introduces new suits for running I/O tests on NBD and LUKS
>>> drivers, giving new make targets
>>>
>>>    * make check-block-luks
>>>    * make check-block-nbd
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    tests/qemu-iotests/meson.build | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
>>> index 939a14ffae..5735d67c8c 100644
>>> --- a/tests/qemu-iotests/meson.build
>>> +++ b/tests/qemu-iotests/meson.build
>>> @@ -23,7 +23,9 @@ qemu_iotests_formats = {
>>>      'raw': 'slow',
>>>      'qed': 'thorough',
>>>      'vmdk': 'thorough',
>>> -  'vpc': 'thorough'
>>> +  'vpc': 'thorough',
>>> +  'nbd': 'thorough',
>>> +  'luks': 'thorough',
>>>    }
>>
>> Before we do that, I'd first see a solution for the problem that I described
>> in my series here:
>>
>> https://lore.kernel.org/qemu-devel/20250910153727.226217-1-thuth@redhat.com/
>>
>> which, by the way, contains a patch that is very similar to yours here.
> 
> IIUC, the problem you're concerned with is that 'make check SPEED=thorough'
> is running too much, and you want to stop running skipped tests directly.
> 
> My view is that running "make check SPEED=thorough" is undesirable in
> general, even before either of our patch series. I'd say it is almost
> never what people actually want to use, and is only picked because of
> the lack of a better option. That's why I thought 'make check-block-qed'
> (and equiva for other formats) was a better option, as it gives a make
> target that matches a specific testing use case. With that in mind, IMHO
> it is less important if 'make check SPEED=thorough' waste a bit of time
> launched irrelevant tests.

Sounds like you're only thinking about running iotests here. But what I 
generally want to do: Run *all* tests at once, in parallel, on as many CPUs 
as my host system provides, i.e. also qtests and functional tests in 
parallel with the iotests. That's what you get with "make check 
SPEED=thorough" only right now. And the output of that list is quite 
cluttered with a lot of skipped iotests, which will only get much worse if 
we add more formats to qemu_iotests_formats without any other patches.

  Thomas


