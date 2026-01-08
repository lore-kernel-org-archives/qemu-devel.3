Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7456FD185D5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdo6K-0002az-5F; Thu, 08 Jan 2026 06:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdo6E-0002NH-UC
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:22:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdo6D-0004C3-Bh
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767871360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Qzb9Fe4h1VXTg02jLT5Jhol+oNnc6kYRI3HeGWayGKc=;
 b=RMfIxCkdVCnuFcqibOCFBtfEe4q5+MNAFj/MFB0hEFxcaER0rgqqyukE5cei0mgUCDApbK
 HxIBlKTmGGXaqk5QXjzf8GB+8gP9dDEku1qI6EFLsQaUlDYF4fPcc/2HIp7DtAgtgVwEHK
 yCGmYyzVjjDrMVOJzLcjG/o3JcSXeCw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-_9XdZ-4OMA-6DkubiL8upA-1; Thu, 08 Jan 2026 06:22:39 -0500
X-MC-Unique: _9XdZ-4OMA-6DkubiL8upA-1
X-Mimecast-MFC-AGG-ID: _9XdZ-4OMA-6DkubiL8upA_1767871358
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477cf25ceccso28462645e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 03:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767871358; x=1768476158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qzb9Fe4h1VXTg02jLT5Jhol+oNnc6kYRI3HeGWayGKc=;
 b=pyHTNMIRG7D5aka+2UkKAecpWcKRBbkQnSydlUeJBb5EeaJblAj2PXyYQSsRSCdqqV
 6P3VNFDGVZAecm3xPCUVOyfpK6yZyrRNyB90tCfnt8B6+mysENhtwJUwjwhcLcdRWDxb
 mzlxk9TemNQPIkhYdD5IFlqR4l9LI8ZouTGG3bTYFq7ZUiYB1smpidR5rOil65/2kYwO
 o40xieZrS1X3HUsh8i2UHnj1sHlO9ho48pxtYG1+NHdfdpKb4nL7F9MKuy75K7ZBiH5e
 tmPUodmb90tj33cY4WuDg1c1Xf3InHjJTtetdoHGjkVasrrvvYs2eZs5YtM0L3Pnh9CE
 Y0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767871358; x=1768476158;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qzb9Fe4h1VXTg02jLT5Jhol+oNnc6kYRI3HeGWayGKc=;
 b=pebGG1C4Lu+qiyxnecbqFK+uM3LTUPZYFv83a4b/T752aJreglycDS2oWF2ktlTfcD
 sxiOU8pKTTUYieyh8PNQEpvEhuC8cb/m/Q8084CA3yMpCgwpOJ0PXBXj31WfbxapdrIb
 kEJ0yHWEnp2uIh0f3mLdOuoXhGyYw4iXrOkdw8LoAIWznIPeoj2BndNpNnsc6S7kicAR
 7aH4wSM53Vund6oiBR3m9/aBiZuvDJeunlEO7UMmkuE7cIOuXkW1ZIIYGPncbSNE8RfF
 WUk9VJD3MdxuL56Z4uPn+PkFCYyrbum3Mi5mecNDA1hWHWcvKfjonJEQvE30ACL7eowP
 /FPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmXFcrgIN4TyK0BcOuOC2DbObMPCGFKFzoASqZbNCL0rOU7mYKZsVncJ2YEonRUtHQ4YJXA4q9HoGs@nongnu.org
X-Gm-Message-State: AOJu0YyrY3sfelCy1yGHrrmqLQ9iefODRaAMKHw6AVkA36vnQpQPnuen
 tpSFnWJrXUqwBHWsQH0a8D2dlE1WZjscE9HyQKDCSX3LzXxbx8NMGg3ylUc7D3LkYM3Z68ycACc
 Hg2RORo3EVayWsKY1ydn+vn0ACCe9e0lcjSsRWRr8sgzXK/5SWQBSZnU0
X-Gm-Gg: AY/fxX5rCrBcu9mJ5YvX/mvsZL1Rjvdi4v6aNSySF1BkHHzLkNztbf4NFsoIIhFOjEc
 Yb5BeVc7YhR6w6bgnxVAXNZXubu1t580MozroA1l/Y2PGvMlu82KXmJSgJC3tBYJVlItHaZ31na
 2+fOy17qF2zaRieXAI1nOZH0bdMmDeDZ/bkPyQmVDwMnKpqsTqNgbcaPVMm9If8S70J4qsZlnqC
 YrZYAedo0ZifXXuhRb3L2LFl1/C6zUKeV0McbYS43BxYUJtVNYSGpeTNEsmaXnXG4RMxYhTR+5M
 W7flMFqZTdmA0FUxJrDBwVbP5RbQ7ICdAXfg/2S8hal1e7CtK0lpYhlnJy/lIR2Xhhtl+HktAXu
 B9G7R9y0=
X-Received: by 2002:a05:600c:1d0c:b0:471:14b1:da13 with SMTP id
 5b1f17b1804b1-47d84b1fcf9mr65536665e9.14.1767871357751; 
 Thu, 08 Jan 2026 03:22:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMKEPXJRMPu7fYpRfhzE1MdFBqsLSvQtlsKxVnZlK7vwtAuX8cZvETzoxLt0UKZ2Re9Ha3jw==
X-Received: by 2002:a05:600c:1d0c:b0:471:14b1:da13 with SMTP id
 5b1f17b1804b1-47d84b1fcf9mr65536505e9.14.1767871357369; 
 Thu, 08 Jan 2026 03:22:37 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff1e9sm16589133f8f.41.2026.01.08.03.22.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:22:36 -0800 (PST)
Message-ID: <6e517642-bc64-4bb3-b92f-bb1ae044e86e@redhat.com>
Date: Thu, 8 Jan 2026 12:22:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/50] meson: Remove cpu == riscv32 tests
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-16-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Cc: qemu-riscv@nongnu.org
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
In-Reply-To: <20260108053018.626690-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08/01/2026 06.29, Richard Henderson wrote:
> The 32-bit riscv host is no longer supported.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   configure   | 10 +++-------
>   meson.build |  4 +---
>   2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/configure b/configure
> index 2d9a603ee8..06a1b441ff 100755
> --- a/configure
> +++ b/configure
> @@ -403,12 +403,8 @@ elif check_define __s390__ ; then
>     else
>       cpu="s390"
>     fi
> -elif check_define __riscv ; then
> -  if check_define _LP64 ; then
> -    cpu="riscv64"
> -  else
> -    cpu="riscv32"
> -  fi
> +elif check_define __riscv && check_define _LP64 ; then
> +  cpu="riscv64"
>   elif check_define __aarch64__ ; then
>     cpu="aarch64"
>   elif check_define __loongarch64 ; then
> @@ -1269,7 +1265,7 @@ EOF
>       test "$bigendian" = no && rust_arch=${rust_arch}el
>       ;;
>   
> -  riscv32|riscv64)
> +  riscv64)
>       # e.g. riscv64gc-unknown-linux-gnu, but riscv64-linux-android
>       test "$android" = no && rust_arch=${rust_arch}gc
>       ;;
> diff --git a/meson.build b/meson.build
> index b0fe798ee2..a18b3a5657 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -50,7 +50,7 @@ qapi_trace_events = []
>   
>   bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
>   supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
> -supported_cpus = ['ppc64', 's390x', 'riscv32', 'riscv64', 'x86_64',
> +supported_cpus = ['ppc64', 's390x', 'riscv64', 'x86_64',
>     'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm32']
>   
>   cpu = host_machine.cpu_family()
> @@ -279,8 +279,6 @@ elif cpu == 'ppc64'
>     kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
>   elif cpu == 'mips64'
>     kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
> -elif cpu == 'riscv32'
> -  kvm_targets = ['riscv32-softmmu']
>   elif cpu == 'riscv64'
>     kvm_targets = ['riscv64-softmmu']
>   elif cpu == 'loongarch64'

Reviewed-by: Thomas Huth <thuth@redhat.com>


