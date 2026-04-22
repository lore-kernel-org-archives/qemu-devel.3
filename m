Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E99F94CDE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSpM-0005BP-V6; Wed, 22 Apr 2026 04:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFSpL-0005B0-AM
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFSpJ-0006BX-Rm
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776846051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rwAeUnPXPs7tbfquhFrFhHTviUFr1oZS18IkfKlLjkU=;
 b=aum+k7swcMK066hMK5wvWDqdGqlpav00zDL3smBCb49ov++jmFEHm83kETok7hMXbJagai
 vwQaDSmPhPr+t1+OFhcV8nbrzv+VLIwL7rE4a4wpKnfz7Jswkav1HjTX7BAnOYduUxYZLF
 WV2biekf2ahq/Pcs9GxC2ju8L3f20BY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-EZzXIlO3Nd6LB5AqVmsb7Q-1; Wed, 22 Apr 2026 04:20:49 -0400
X-MC-Unique: EZzXIlO3Nd6LB5AqVmsb7Q-1
X-Mimecast-MFC-AGG-ID: EZzXIlO3Nd6LB5AqVmsb7Q_1776846049
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48a5952c635so7011825e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776846048; x=1777450848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=rwAeUnPXPs7tbfquhFrFhHTviUFr1oZS18IkfKlLjkU=;
 b=aTgzJnY+cVFjzJMeNWKiF4KsBUmQ1IFSO5XnvImlle9rR7gzMjMEAWGB8u7ZErorVE
 utAaAHEk6IIxFWjA1yzF743yAC0PCKkR5K3Y06Wr8JH85Q7CW8+mNeNN7xdwDv8foaDH
 V1vq45r3pIZk+IoqCHzO0JFuK6YBUOqSalWyAjHcsfmVfX5dCBMmsNzG5y+vCU2eAbIP
 bU3DqKj8Q8ruy+FDdpjRNbXoCVE4IZ9T6ECpyofGFRQ+i7ssjJqLCcDsRIVTJgYhw1XG
 RG3199S2o6Vvl5cN45VN++fP4O9k6XiMCrK0yW3NMlYvvSRKOfUNN8KVsSoR3vVlh/iR
 G0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776846048; x=1777450848;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwAeUnPXPs7tbfquhFrFhHTviUFr1oZS18IkfKlLjkU=;
 b=ciwhDyajnQPfBNJ7AD67F8vM4BN5Q/Q/E+jEximKqJUc8u6KNVOEndx0CtoIXMw7nm
 cccfuNkcrHAVkgdwRIQxuxbjwnFs22g36MiZqxHikebuj/L74FGJ7ofeYAVcKuU4Cjzq
 gVr4qBXeXAo8DYB1ntL84kt5oq7d3nxMH9eJnoYBomXI6z+1FePtJAgXyJcn4s7lwX1l
 e5JZnR0UGEg2mqfbfl1gTaCNUOiGlek7nuReeWJI2Q1qpTGFEHrEjtSFVPWiER2HlJVj
 YPpkQme8Xi5JLRGxWeI7vMjyZ6ULVDxxkpCgneazQNQiPemsUC+P8fjuwMQFMchsyXvc
 PwHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NX62XxQtfwrcw+5UzsBZO6h+6qKsMUFg0UBsGjz16Ug7ameZwEp5KKxG05YMWUGJaD/sy2/ARPDgH@nongnu.org
X-Gm-Message-State: AOJu0YwNIW9m5/MNWOnKpAQzDZhAsKUxRp7hVyVXXxz3z7uHtPOAF6vn
 ivsjEz+fgEBd12yskNAglIJvT7im03O2Fo5Z4MwhogVJCcYVxl/HhSlFIdhIiWu44wOmjNJNfGW
 v5WWhRZPCq1gfTB3sJIkleVnXehY2MRmqVmsAqT9dKGL/prvsigco1nLJ
X-Gm-Gg: AeBDievBvmTCQCoLMv4xv8MQCc0MvfZmFzML0m8VHwbeDuKA8yU1S4erBx+5zALXygM
 unom1iFr1bbCIZO4q9EO1u3tf2lmY2GwO+rzNGSU5sZXhRRKDK6nSYrdMOPHIHbzRk8/6YH/DbU
 oYr8RVOXYWcJ4vOIDdAStlI7EBAZ46XGIcx2opy2im8E2YmvkOVb7n67FSLy3jkxpLf4TzY7YVI
 Z6WcqqGR4HdjNtALbDy7BWCs7uLE+a1UrsNAokJJG5vrRpjPVYLg+5jZomonnieA2W46kwws2fA
 5J7XcYCuPUn37neKBiNKWgi6So8e3U8XUTEnriX+R8OENP7jmv1xA54ZmHpdL6h2eZcjQ79XDwF
 uGCwC7KXa7qcLVHPYsY3NiArm8/o96Q==
X-Received: by 2002:a05:600c:628c:b0:48a:52d4:888c with SMTP id
 5b1f17b1804b1-48a52d48985mr130800265e9.3.1776846048470; 
 Wed, 22 Apr 2026 01:20:48 -0700 (PDT)
X-Received: by 2002:a05:600c:628c:b0:48a:52d4:888c with SMTP id
 5b1f17b1804b1-48a52d48985mr130799745e9.3.1776846047989; 
 Wed, 22 Apr 2026 01:20:47 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb77b001sm199755425e9.3.2026.04.22.01.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 01:20:47 -0700 (PDT)
Message-ID: <2f90163c-7437-4939-9c03-a5f7bcdc68b0@redhat.com>
Date: Wed, 22 Apr 2026 10:20:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] MAINTAINERS: Step up to maintain core machine
 code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260422080406.62638-1-philmd@linaro.org>
 <20260422080406.62638-5-philmd@linaro.org>
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
In-Reply-To: <20260422080406.62638-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/04/2026 10.03, Philippe Mathieu-Daudé wrote:
> The 'Machine core' section is orphan. Being acquainted
> with the code, step up to maintain it.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Yanan Wang <wangyanan55@huawei.com>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 520b92826a2..d4dac985b5c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2016,9 +2016,9 @@ F: include/hw/i386/nitro_enclave.h
>   F: docs/system/i386/nitro-enclave.rst
>   
>   Machine core
> -R: Philippe Mathieu-Daudé <philmd@linaro.org>
> +M: Philippe Mathieu-Daudé <philmd@linaro.org>
>   R: Zhao Liu <zhao1.liu@intel.com>
> -S: Supported
> +S: Maintained
>   F: hw/core/cpu-common.c
>   F: hw/core/cpu-system.c
>   F: hw/core/machine-qmp-cmds.c

Reviewed-by: Thomas Huth <thuth@redhat.com>


