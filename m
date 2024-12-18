Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A510CE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwO6-0002RN-9E; Wed, 18 Dec 2024 10:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNwNf-0001zc-GB
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:54:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNwNS-0007L0-1g
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:54:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734537256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BYIxrVRBO1ZFqiOvSjzqbq9o8XrcxFx1fWOC/Jr1xOE=;
 b=BD5GalgAYhVtgCaKIyNi3P2g57gaPzlMVEylvN2qs1j+QysxaHrqLerLGEqp87fDtBUFce
 FD0WeH6x0E1+DGIvVBpBh77pDMTuvDOi/M6yUzR8C+QVYVjxSUGnViAtvgTWlzLKVoLR3C
 jhjhZplqjwBlAV1Tgtc+pRtqD/L7eOo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-tYaXrgCqMRyR7Y9y9shMkg-1; Wed, 18 Dec 2024 10:54:14 -0500
X-MC-Unique: tYaXrgCqMRyR7Y9y9shMkg-1
X-Mimecast-MFC-AGG-ID: tYaXrgCqMRyR7Y9y9shMkg
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d884999693so108794446d6.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734537254; x=1735142054;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BYIxrVRBO1ZFqiOvSjzqbq9o8XrcxFx1fWOC/Jr1xOE=;
 b=eQdZTL5t5RIZsWmeGS2Hv1FRTAVkR/CKTY42xfiU77N+FDih/q2y0/pVIQC6KlTYgZ
 UKrXy+voixo3yrrCmi4/6geMK+FWqwn20LJMG7ENklxW0X6sN/5lDcsGEEm1E5fxvWKC
 VtFQ4Ko1fGzhonNGBAQpRuKqvYpbNxnNh8/exsrUwMKQ1ahOu+COx/ycvGKMWMjVzq34
 crPy+xyvTGa7YcOEBUzPNvNWakGB2esh47TrjTVFFm17agQkc4GLX/t1z9iiJJqXTBkV
 OmSQJWMiC0pXT/fxEIT8EY2f6OVv//+PBMkIScpgvTFmyHV6mfCCOfXXJF0CsowPngqS
 FJ/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3SwC8df3y9WZcJNUpH/xayosKMxdhzTVl/EgcGMwfCrUROEXlJUlS0DAHFftZIk7f9lvZ8fEZf5/t@nongnu.org
X-Gm-Message-State: AOJu0Yw80z3R3slN8RW5inntUjm2x12RerFPvH57oxSwJpVUUEipfoHU
 2EE1eP7Onb7mYwlBIgfD55+8BrnNy2aGLXVjq4uzHAaLl0MF3rOyzU4zWrHZgl0vIhYR+vYDy1r
 9tRFzsPC47CVZYNiLEpJf26Jx+gFhc5fMJcJjRabUAAfwiyTTTJf/
X-Gm-Gg: ASbGncsrWKqDi38OXWGZ/hS4tWHKUx8cVn0RPOL1TTW536Fgb3UZlR+2HWOkPgJdT71
 HPx73bUOUh0er7XseUGdX6UHndG+SV45v8EQIX0IP1blYbZ3LZjaMNF5LjRdyDcfyC0lZ9aimdx
 VWKXl7/vcfPFcfBPJ7aDOee1d2dicCT4lwKVkwWkpbdFIfhbvE9UQGuVV/8unkbYgNYc5PRPFgv
 2L3BBk6t0iQg3HAv5uMyMdVGY5EODr4l/OsDxJ4JO4FwM1+7ZUdrxgVlyu7/i9/bMcUyerSrW4g
 1xYNSf6ZkwMR
X-Received: by 2002:a05:6214:1d09:b0:6d4:36ff:4356 with SMTP id
 6a1803df08f44-6dd091b26e3mr65609706d6.19.1734537252339; 
 Wed, 18 Dec 2024 07:54:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFm5fbPd/gAPw0Of4+336L+Qtl6DgbVbHFFR+S1AXlrxyEv7sCUeWreyNEddhkigMcnznT7jg==
X-Received: by 2002:a05:6214:1d09:b0:6d4:36ff:4356 with SMTP id
 6a1803df08f44-6dd091b26e3mr65608606d6.19.1734537251251; 
 Wed, 18 Dec 2024 07:54:11 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-49-186.web.vodafone.de.
 [109.42.49.186]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd26c852sm50909576d6.53.2024.12.18.07.54.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 07:54:10 -0800 (PST)
Message-ID: <1d4faf8e-b2cd-42b8-a6a7-9034b9512b86@redhat.com>
Date: Wed, 18 Dec 2024 16:54:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Convert the kvm_xen_guest avocado test
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>
References: <20241218113255.232356-1-thuth@redhat.com>
 <9B5DDDDB-769B-4654-BEF1-D3F853EA05E5@infradead.org>
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
In-Reply-To: <9B5DDDDB-769B-4654-BEF1-D3F853EA05E5@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 18/12/2024 12.48, David Woodhouse wrote:
> On 18 December 2024 12:32:49 CET, Thomas Huth <thuth@redhat.com> wrote:
>> Use the serial console to execute the commands in the guest instead
>> of using ssh since we don't have ssh support in the functional
>> framework yet.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Hm, but serial is lossy and experience shows that it leads to flaky tests if the guest (or host) misses bytes. While SSH would just go slower.

I now noticed some issue with the serial console in this test, too.
Looks like the "Starting dropbear sshd: OK" is not print in an atomic way by 
the guest, sometimes there are other kernel messages between the ":" and the 
"OK". It works reliable when removing the "OK" from the string.

  Thomas


