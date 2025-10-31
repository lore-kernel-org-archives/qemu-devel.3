Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECF4CCF9EE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 07:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEjen-0005fP-39; Fri, 31 Oct 2025 03:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEjej-0005eT-Sd
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 03:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEjeb-0002mj-1D
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 03:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761896064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=akiF4oBE2qsgnrZUhTYY1F04EhuN7YoEIN+FVxlDo90=;
 b=gCZg/sp2xuxBev5W9aHDvxmxUeW8N75kpTIq5TaKW2v4vLUH7Nz7Jvbp86wqyaOpIqeDW9
 X3TBr0gofwRx7qrJ2Iag+GZbB/GrLqgNF9g7NaGH7qfZ24r8C65YlwQwbfix9jtcB41CBY
 2kUxg/D+vAwQFTj+amBYStRg1c5wK8M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-Bdn5u6U8Ntm2ZBTB34ogbw-1; Fri, 31 Oct 2025 03:34:23 -0400
X-MC-Unique: Bdn5u6U8Ntm2ZBTB34ogbw-1
X-Mimecast-MFC-AGG-ID: Bdn5u6U8Ntm2ZBTB34ogbw_1761896062
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47111dc7c5dso10071455e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 00:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761896062; x=1762500862;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=akiF4oBE2qsgnrZUhTYY1F04EhuN7YoEIN+FVxlDo90=;
 b=LqxnGaj5DRCxp6DdoTujXEScQpJgLOsr7+z6JbB9Ba7VQk5DoigN4qdOC0epHzTPES
 MxOcf7tpRdZU4GQYS8SF+61j8SCoP+679/lZn+uy1gjz7A86LUDy5qqPAWS6Wd9/XIke
 k3WTFU9qhIX0FVnsny4JGDM4ni2JW8XnRf+uwDswbOSSg0h/KPNOYFoFPGXIgifelHag
 A6KAbl9OErbTL9fGiZqABtK+TDZD9CkJtameeLvzBnWHoHnTFcfKWhe8bExZXO54RgPm
 O5sY+z0nRJDi5GUr1Ks9N87RTlkMn4MGLJeily7T8nG1yeMOOS8JNz85ZPRZCbyO1YdB
 yYmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTYvh5SyAeTdgG8Khr74ihrNelmK5FiSEdE2wOC6nqIFMnyRHTrxFpKA0PJdVXrnv0jw3rS5moJ5+m@nongnu.org
X-Gm-Message-State: AOJu0Yx/gcyGoCF5Jsz/83O6ghpNchb8DfxNy38LmKUeQ19tMvXTR5RQ
 yEgQOTUWLUER8eeWKC0nk/0itjKc1QzO70wnn0eki4B036lOItSc0UlXQ16HlXFvFZbeBguJRY3
 hqoH3SY/io7szMakIz89knGLMK2DWPrbDdzH+q/X00zn7If0xSJ0i41ml
X-Gm-Gg: ASbGncsIpW+xdbGUax3Nv66LdyBJQeHIyGmZKuit6CUUAZUwuvk0xn/hovpx5/XLFx2
 LrSOOP32Fo1qJTLkkYIEVNGEuhyeSwS7YegMwcSe6ACtovUunR6gEJ/HmyYV21qDPndov+ZNDQ4
 0mgk5vJhBIVqw+/9NZSns7glO6mY+QXv7eZZb8rL4nBbsN2Fk0d36a8VlJm+UL4I6YFPrEpdUkV
 Sh90qtJkPCOP18gI91Bf1zbLOmtKFfl1iplaQEYvpDtGz9i6kbKHAWOOBTf3G8hEUFB87EBFC5D
 i9zXlP+DLmkQOlp8r043BWCt2zsIScXk/iFWDogtnpfv3EC5hUgpqRsUdENFwTasmHzShaE=
X-Received: by 2002:a05:600c:420c:b0:477:115b:878d with SMTP id
 5b1f17b1804b1-477262baebfmr34490815e9.15.1761896061740; 
 Fri, 31 Oct 2025 00:34:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsRuleA7iVuorJC/vE/qMyS8pRtHhelD+Lfhaxz0+5tu+RRZAyGEPxaXSIupPxvK7OXk9WRg==
X-Received: by 2002:a05:600c:420c:b0:477:115b:878d with SMTP id
 5b1f17b1804b1-477262baebfmr34490615e9.15.1761896061371; 
 Fri, 31 Oct 2025 00:34:21 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732cb7f41sm18310775e9.0.2025.10.31.00.34.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 00:34:20 -0700 (PDT)
Message-ID: <f8d0b5ff-983c-463a-bcc5-c21010069f40@redhat.com>
Date: Fri, 31 Oct 2025 08:34:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rx: cpu: fix interrupts check in rx_cpu_do_interrupt()
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: yoshinori.sato@nifty.com
References: <20251030165932.138512-1-imammedo@redhat.com>
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
In-Reply-To: <20251030165932.138512-1-imammedo@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/10/2025 17.59, Igor Mammedov wrote:
> Commit [1] broke interrupt handling, replacing interrupts fetch with a bool
> and then the remaining code attempting to check individual bits
> on that bool value, which effectively masked those interrupts.
> 
> Fix it by checking individual interrupt bits directly instead of
> old 'fetch then check' approach.
> 
> 1)
> Fixes: 87511341c30d ("add cpu_test_interrupt()/cpu_set_interrupt() helpers and use them tree wide")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   target/rx/helper.c | 41 ++++++++++++++++++-----------------------
>   1 file changed, 18 insertions(+), 23 deletions(-)

Thanks, this fixes the problem, indeed!

Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>


