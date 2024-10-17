Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0771D2F7D5
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 05:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1JFK-0004GE-1k; Thu, 17 Oct 2024 01:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1JFI-0004Fu-BJ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 01:40:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1JF8-0000XL-Fu
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 01:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729143606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pbbQ+7ML9egukfRgZQz7Hc1c22Vw/5wmnsdjGEAr8i0=;
 b=h/7Ju0r986GhWR9gRCW2ZiqWMqwd6ED15QEOz/LMuylG9w7CvVxfIibr8jDn270vbQmriE
 d2R1G47yKZowvFylA+I+w6VTnWl/8/d0vwJnf8St3+64+KuXQgBC+qXsmocHvvTABAcK29
 pQ9eHWzDxc5cdCJSjKdDjBSJM22F2WQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-OXpm9-4mOz2Cw2i83_enDA-1; Thu, 17 Oct 2024 01:40:03 -0400
X-MC-Unique: OXpm9-4mOz2Cw2i83_enDA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7d2d414949so27252566b.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 22:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729143602; x=1729748402;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbbQ+7ML9egukfRgZQz7Hc1c22Vw/5wmnsdjGEAr8i0=;
 b=DOjh8pwB/ofzfmkyEpNZETle97T5Q7TrLfnf9RI767Mhn7LANYrnPGV+GR2n0VYd/H
 NHNeJiFRO2j8IozhTgkafcmvPaftYwmXMAfJdkM3gQ0rjWJkAsoMEfpqFuStfW7TGF4M
 YTwcQv9DhwKTqhQird+TdspkWZldpBYN6BSCNamesb8cvCXcmIDV5Ecn9SMmZhMHGhV5
 x/lnlJMDi6t+qLY/Yf9Jt4NAukmPkPoysWHDZgl/G+Ch6rXa+JtIW//iNm1FZlh38dTG
 OrJeA55AvXDLtqeNzOob55eUHvQIj2XoT8YnBbOU3ObI5qh54cxjfSzMDaUbisIn+CCE
 zNAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSA56EQaVhdjQXT/jjGir//cRC+4M8XWWTDVRQgl/T7E7hhsfR7hrZAC2OOs4p4meOoMZB7V6fwIng@nongnu.org
X-Gm-Message-State: AOJu0YzafozHaQd60ddUdZEUQxdnlpBGHY9yNy8viBVyn71/3b8+ezAn
 kHHDwbjwC+xvAwdFaBD1/T5JaVQ59DIaC/lFwWpQTsbHzA7wtwHIUEVXoGXmfxBDrO7HjCbnDyI
 CrTOahDjRSbPvkdCT+ne85Gg4lo3JyRK3QXJ9O6nlczsvbTnjNVVD
X-Received: by 2002:a17:906:d7c2:b0:a99:4152:1cb4 with SMTP id
 a640c23a62f3a-a9a34dfeb58mr513958766b.42.1729143601929; 
 Wed, 16 Oct 2024 22:40:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4FA8khXgPV4LUeHKInB/D9R8xF85gtIDA1XZQoMw+9HSJENAELgjY12N6rLuSnJ9c8RvRdQ==
X-Received: by 2002:a17:906:d7c2:b0:a99:4152:1cb4 with SMTP id
 a640c23a62f3a-a9a34dfeb58mr513956866b.42.1729143601506; 
 Wed, 16 Oct 2024 22:40:01 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a29716d5dsm250478366b.15.2024.10.16.22.39.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 22:40:00 -0700 (PDT)
Message-ID: <32d9779e-d531-4451-af2c-c76e86f5b921@redhat.com>
Date: Thu, 17 Oct 2024 07:39:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration/dirtyrate: Silence warning about strcpy() on
 OpenBSD
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Hyman Huang <yong.huang@smartx.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20241016160712.962407-1-thuth@redhat.com>
 <Zw_oM-RStF4QhWik@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
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
In-Reply-To: <Zw_oM-RStF4QhWik@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 16/10/2024 18.22, Daniel P. Berrangé wrote:
> On Wed, Oct 16, 2024 at 06:07:12PM +0200, Thomas Huth wrote:
>> The linker on OpenBSD complains:
>>
>>   ld: warning: dirtyrate.c:447 (../src/migration/dirtyrate.c:447)(...):
>>   warning: strcpy() is almost always misused, please use strlcpy()
> 
> Is that the only place it complains ?  We use 'strcpy' in almost
> 100 places across the codebase....

There are only a fistful of other warnings. I guess most of the spots are 
turned into inlined code by the compiler, so the linker never sees those 
other occurrences.

>> It's currently not a real problem in this case since both arrays
>> have the same size (256 bytes). But just in case somebody changes
>> the size of the source array in the future, let's better play safe
>> and use g_strlcpy() here instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   migration/dirtyrate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index 233acb0855..090c76e934 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -444,7 +444,7 @@ static void get_ramblock_dirty_info(RAMBlock *block,
>>       info->ramblock_pages = qemu_ram_get_used_length(block) >>
>>                              qemu_target_page_bits();
>>       info->ramblock_addr = qemu_ram_get_host_addr(block);
>> -    strcpy(info->idstr, qemu_ram_get_idstr(block));
>> +    g_strlcpy(info->idstr, qemu_ram_get_idstr(block), sizeof(info->idstr));
>>   }
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> 
> Is it worth also adding
> 
>    G_STATIC_ASSERT(sizeof((struct RamblockDirtyInfo){}.idstr) ==
>                    sizeof((struct RAMBlock){}.idstr));
> 
> at the top of this file, since both of these fields are expected to
> be the same size by this code, to avoid truncation.

... or alternatively check the return value of g_strlcpy() ? ... but that 
wouldn't work if pstrcpy() if we switch to that function instead.

I don't mind either way - Peter, Fabiano, Hyman, what's your opinion here?

  Thomas


