Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9749ECF45A8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLZa-0001al-Oe; Mon, 12 Jan 2026 12:19:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfLZE-0001Xm-FU
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:19:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfLZ6-0000Mo-F9
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768238326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UR73GItwGZ+h6dAws7Y3+TQz2xfjAWQasIyXkRgJXqA=;
 b=YT+bpid9fXW6XfdGRc2Tbtw9/1CO/ropz22avX2wFP/rlzV3uMb6wF+udnSO+8D3mshUcI
 ngjUXL7/mEM7PuewS3PEOS/k6haLGpGQIBpVVchzB0TexCnhWmO9Elda+FbLMpPR55ENXn
 kYWBMhCIIdEUzjIWSbDgoR5cr1978tw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668--DvgMPetPYyYHyX1nlS5JA-1; Mon, 12 Jan 2026 12:18:29 -0500
X-MC-Unique: -DvgMPetPYyYHyX1nlS5JA-1
X-Mimecast-MFC-AGG-ID: -DvgMPetPYyYHyX1nlS5JA_1768238308
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fb8d41acso4350465f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768238308; x=1768843108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UR73GItwGZ+h6dAws7Y3+TQz2xfjAWQasIyXkRgJXqA=;
 b=VuNftW2npx2e9FgbOtHUkSiOm8iRC6oEEpz15j5RT5bYbpivFAzZ7xu3la15UohSHl
 HUc9VifL9SqywRTBRdn0BguSEwhEdEDzbczxmouAgVBwXGdGULplYup55ge55m2SksNZ
 lt6/AyF5Tua3ZN7+8z+g2gZibWnBIEWyFtGgn7zvgenSPAksoKLR1C3d6+1HwrhGPnI7
 y4vSeovCbh5icC4kG0/ozTAaF+UIZkVXR8Q59lpGVhZwfbXjwkmqsbcj9flCPaY0iu9R
 WZW2nPS4wGz9EI7gych5EKhA1OMXvKQqlSsOvekvQ3d6Ld/UcmzFPJ9DP6kUA8ysIQ8M
 SRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768238308; x=1768843108;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UR73GItwGZ+h6dAws7Y3+TQz2xfjAWQasIyXkRgJXqA=;
 b=DA8iSz0Z6+y4TpL6hEFQ9BpNiVtN9p1IF8GjM8LZQg0FINAsirKjBnZiC7Xh6Ljq48
 4jbpYP4ywzOcoHa0YNqkR6+rXH/1Jp3ChELTnjkcl5TAsTPbxJWsk/AqXkiOtN0kxy2c
 5gJctDndf/iP742BZF4wjlqzy/EOtxBX4OEc7n+ziE6jpQcu3Xq+u5P615gfM7UE7E6/
 qVvh0AZlKKa3oil3UfcYs4QaEn8V19GGQ93bg7jwGys+VTbU8fujxN4vFJcmntUMZe3A
 6c2HZ4iNF+94vEcT+ttE+H9VgAjzp9Z1ZBvIYL/u2pkiapu1OkFJk82ypXNJlbSjFtjm
 79uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwRKE+MzqjD86YSsmhZSfBwW9a9+2APaxuHkW601tIOQ6jROIqwBr7pTTntikWzt1u2zr9ahGmYdwD@nongnu.org
X-Gm-Message-State: AOJu0Yzo4wftMAFnfvAL+zeQpETvDQzQgGJM3m+2HCbLO7IBLJQiAl7l
 iakxHNelDzsTUcSLsa5GKDIjviRPzxNbfEf7PqehCOLnZ442eMD9scqsVsxB8CQl97ccl00vWHA
 MuU/N+UQ2CAKJk1EJAhWMFufX6sA1ziCToPLVWNU7/imJyXG86NtE1maH
X-Gm-Gg: AY/fxX6oQxw7iTXcmJhIh4uMVLsJ74B733itD92benFt7gOycglg2JiKNCTYRDVR4Fx
 yXNVRTeOHwuZ2ltGXEeGFk35NWIztN/9bVTmRDwV5O1OLVa5Dt4xPdnzQLQzkHNCU+6CrpBYFEA
 6Myc4GrET7IbuZ5IMyv6TAfS3RBmuJRDfAgQxcFbxCNDJdXiMta01QLiVWXdeq6m/0vDHji4tBB
 rME9dChtUDc6i0oZZU8IyIRfKaqS7+q0NBbaG/fqTAuU81md24xNnib5MoKXplI4eF9VYIDIE/N
 UuctptXm4wTQUJN+0vE92cfgcq4ud7nDgv+EW6qANpqwJnHSY0qKU/LgVbP7aq+79DhljDQ9aKl
 +2siAR5g=
X-Received: by 2002:a05:6000:1a89:b0:430:ff0c:35fb with SMTP id
 ffacd0b85a97d-432c3761740mr23786327f8f.52.1768238307748; 
 Mon, 12 Jan 2026 09:18:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHANmirJQ3Wbu8tRxrccHW5C5629onpcE08R6N41w4S7g/obqw3IiX4AKHMNc5A4AhARE5JOQ==
X-Received: by 2002:a05:6000:1a89:b0:430:ff0c:35fb with SMTP id
 ffacd0b85a97d-432c3761740mr23786295f8f.52.1768238307364; 
 Mon, 12 Jan 2026 09:18:27 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacc5sm39491146f8f.5.2026.01.12.09.18.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 09:18:27 -0800 (PST)
Message-ID: <c4fde7d7-8467-4a07-8a06-d0f1e310fa35@redhat.com>
Date: Mon, 12 Jan 2026 18:18:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] update-linux-headers: Remove "asm-s390/unistd_32.h"
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260112155341.1209988-1-clg@redhat.com>
 <3b167280-ce21-42ce-8b7d-18c60ff39509@redhat.com>
 <c44881ae-76f5-469d-a62d-c7de8cac5ed2@redhat.com>
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
In-Reply-To: <c44881ae-76f5-469d-a62d-c7de8cac5ed2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/01/2026 17.38, Cédric Le Goater wrote:
> On 1/12/26 17:07, Thomas Huth wrote:
>> On 12/01/2026 16.53, Cédric Le Goater wrote:
>>> The "asm/unistd_32.h" file was generated for the 31-bit compatibility
>>> mode on the s390 architecture and support was removed in v6.19-rc1,
>>> commit 4ac286c4a8d9 ("s390/syscalls: Switch to generic system call
>>> table generation")
>>>
>>> unistd_32.h is no longer generated when running make header_install.
>>> Remove it.
>>>
>>> Reported-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> Cc: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   scripts/update-linux-headers.sh | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux- 
>>> headers.sh
>>> index 
>>> 844d9cb9f5e430dcb4833e6225b57173f4befb8c..d09d8cf4c6f0f6a109e899f5c8671f64373d9c6a 100755
>>> --- a/scripts/update-linux-headers.sh
>>> +++ b/scripts/update-linux-headers.sh
>>> @@ -154,7 +154,6 @@ EOF
>>>       mkdir -p "$output/include/standard-headers/asm-$arch"
>>>       if [ $arch = s390 ]; then
>>>           cp_portable "$hdrdir/include/asm/virtio-ccw.h" "$output/ 
>>> include/standard-headers/asm-s390/"
>>> -        cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm- 
>>> s390/"
>>>           cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/ 
>>> asm-s390/"
>>>       fi
>>
>> I think it would make sense to remove linux-headers/asm-s390/unistd_32.h 
>> in this patch, too, otherwise this will stay around as a stale file, I guess?
> 
> AFAICT, it will be removed at the first update of linux-headers. See :
>
>    https://lore.kernel.org/qemu-devel/20251222135357.143339-2- 
> skolothumtho@nvidia.com/

Ah, perfect, that's fine, too!

  Thomas

> 
>> Anyway,
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Thanks,
> 
> C.
> 


