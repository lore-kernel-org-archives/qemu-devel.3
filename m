Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5791ECD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP17u-0005xE-5m; Mon, 18 May 2026 12:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wP17C-0005lZ-F4
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:46:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wP17A-0007Sm-Nd
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779122807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yUROuqmfqDJ1TjIlpPHC8LVoh6TGZtVCmx8V474eWHs=;
 b=huz/CfH0VfVypqyOZSLqh/xNmY/b8giucj+0ce0X4IJjVc5fxyhzYmx6u2hpvdmjhBdOi/
 0LGFwoxN5TAXSqeNVGockuVZy3FlJBpOVLK29QWhlZ7L65OeAOTbdV75hQvgSBFhzU4zhi
 5ZV+j2fQnJ1pI4lJYC9aowUVf+rodkE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-qVfk5zyRNCK45jBZb2UfIQ-1; Mon, 18 May 2026 12:46:46 -0400
X-MC-Unique: qVfk5zyRNCK45jBZb2UfIQ-1
X-Mimecast-MFC-AGG-ID: qVfk5zyRNCK45jBZb2UfIQ_1779122805
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44696b11265so3740968f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779122805; x=1779727605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yUROuqmfqDJ1TjIlpPHC8LVoh6TGZtVCmx8V474eWHs=;
 b=T/kefpep+fWlEMNlKKN0p8Xg9czd5HOQS3125H4vBN6WuZa1hXsL3lJkPGceSNFHwX
 TyYw8lw2v/HvHf14MHj6n7AHPaROq9pCcBZKBQuqpylyogmuUylMUtg3vmLgXyIS+J3k
 arzw2pTqzsZ4JmAwhVe1wcJ7w22BIiBg20CVCgLNLy6PFQsLfLvKDdkrkydreccb7rm6
 u535LGvFkbD6a1qrCV3kWrgTC1iSeHDyPyndTBaWDysxgEwpp4+AfoyBScbrUsh7PeQv
 kwWkhIy2QFFhLAOllIV1nVdX5GGsGDhaYQjbwr3OsZS7rh4feQnjDd4oWEmotFC0Rea0
 cW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779122805; x=1779727605;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yUROuqmfqDJ1TjIlpPHC8LVoh6TGZtVCmx8V474eWHs=;
 b=Iiy1rqgApKI0Ewt5cIG0zjXNNCEQPCdu/T3UaTtZDQZTgwkyXCf/V18chJiTCmkg62
 Te9wreCD1q0Dgkf1aPmzUfn+veR+P4BAOsufVIY9UWndOs+OJQy1wUkUwZp0X0K/o5ex
 oHqVYAOFeqEI3UIwCXsQmVn+kz90qID/ZKIegoUa0GPXZ4S2q8s3Ux2G8J8XhoVqct6i
 82h4KInWT0Eho345CjHuIw6vN6FLV5yJR8pyqRl4Fyd2ZX6xfp5xSYo/mOMD+uCmchwS
 vWNO4tmyDKk3RuvDw3sl6LFc5Dhid51G+mCCKd9H2FyoaHMDQHdtzRocgfhWoADLt4FX
 E/eg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8B3HUKWkgWDh7gl0+P/QtVwxjs5W0al5oVOXISg18I9PpXta4XR3Pl3O1N8yumuLF/YDhD3dAaJwoz@nongnu.org
X-Gm-Message-State: AOJu0YydsFR0FMlkCi7w3BZ6p6OlzWGiBEIoUz/RVsekkiEl4hLlJ/e/
 6Fyfmb6Jv5mxO9PaEiaJqHOVxwcrkxvTgxxUAUAUDL+yaU6wU04el5OFEOx7k7moKlY1QN+OC50
 YJw9IvhxO/fDZ7vWHDPX0ivMW4tea9QEeJlEkj041YLCJJm4BKQtwVu+nH+uezI4y
X-Gm-Gg: Acq92OF5G/agoREOE40cBP64dZnPubXnFkAwcGU0XWcpeOkp1Z9cNwLrbH/qBIfINMh
 N8QXU7neS6ik47T5gTpKfPLOCIFheXXhgXJNPb1x2MhVjLIWfe/GJvFBaBaPlh0jeADWavXUO6h
 YeOlk3Y5ytzCHP0N4741+NUS7Rcn008fhOJMjDe5B9BIBtdEpgZNHL8mw0IsmPCnQuHpvPLBlcS
 cJPKK5vMPKy8tTOuOMjPDSqA4bb05uk5C93rVZupsceHm1BCHl75WDtfbzjbi++gBn7JQAyZtXx
 sWihJN18MI0SOZtjaIQl69+zau/K7GDLfecf3FhFbMsEY7uVwDG659XThiWCu7TvxwkxUo61JYA
 3QC5uR1Gw8PJ/+1c0Yw==
X-Received: by 2002:a05:6000:230d:b0:45d:b14b:2412 with SMTP id
 ffacd0b85a97d-45e5c362c56mr25416252f8f.6.1779122804714; 
 Mon, 18 May 2026 09:46:44 -0700 (PDT)
X-Received: by 2002:a05:6000:230d:b0:45d:b14b:2412 with SMTP id
 ffacd0b85a97d-45e5c362c56mr25416211f8f.6.1779122804332; 
 Mon, 18 May 2026 09:46:44 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.83]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45e7c22d8b7sm9558470f8f.6.2026.05.18.09.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 09:46:43 -0700 (PDT)
Message-ID: <0d152a0a-a387-445f-b359-19d23504083f@redhat.com>
Date: Mon, 18 May 2026 18:46:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/aarch64: Bump up timeout on vbsa
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260518160440.1037245-1-peter.maydell@linaro.org>
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
In-Reply-To: <20260518160440.1037245-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18/05/2026 18.04, Peter Maydell wrote:
> On a debug build, the virt_vbsa functional test takes about 2 minutes to
> run on my machine, so it tends to time out. Bump the timeout to 4 mins.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/functional/aarch64/meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
> index 9803f66299..e81afd6c39 100644
> --- a/tests/functional/aarch64/meson.build
> +++ b/tests/functional/aarch64/meson.build
> @@ -17,6 +17,7 @@ test_aarch64_timeouts = {
>     'tuxrun' : 240,
>     'virt' : 360,
>     'virt_gpu' : 480,
> +  'virt_vbsa' : 240,
>   }

Reviewed-by: Thomas Huth <thuth@redhat.com>


