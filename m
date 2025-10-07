Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B1BCCD184
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 07:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62T9-0000TR-Cc; Tue, 07 Oct 2025 03:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v62T7-0000Sb-FY
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 03:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v62T5-0007bo-AC
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 03:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759823440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dlXlFCEtQALY8njlGrYqQHJkWVUbncS5aRyoZuIZr9M=;
 b=VhyImHIjvyuDVy72sf6nhzkbnrEfUzCxTY01YSSZVMGx71dm86HQ+zXP+FBKZMPiqZg7Zb
 y9X55NWqe3s8vTYYCpkTccOPWHhDDOUA7TC9J3If4ukPzoRKOJYkb1OaiJQ8HNzItXLYJk
 xg5trpFr38JxV+IcClcBOLtxBZcWwOs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-EB_LeKpHPv-7BUvphFHQIQ-1; Tue, 07 Oct 2025 03:50:38 -0400
X-MC-Unique: EB_LeKpHPv-7BUvphFHQIQ-1
X-Mimecast-MFC-AGG-ID: EB_LeKpHPv-7BUvphFHQIQ_1759823438
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ecdfe971abso4275343f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 00:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759823437; x=1760428237;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dlXlFCEtQALY8njlGrYqQHJkWVUbncS5aRyoZuIZr9M=;
 b=qeKMsZDMOqWsM9tPiWHQi6zTKoEndZoRFtxb/x7tjCE74NB31uW9E3bRdR40/vbvBZ
 +/3sRl0wPrAMkDPQ4KPONyOtKHQkOSUViozN/3NN47u6YHXUhYHtmKIkAHsIWfSEYnsx
 xBhLnYIpKD1neT84dKzPfxg9cqv1vEJv9p/tTbc7BTHCOirz1tgY5yMakOAzUHxTJCHI
 Qfkqu8ohVYQRDWlmL8x4gBVm18daDq2MobTV/KFttZY1r8w1uOKI1r6eDjXN8SVriOnk
 wOy90zNhKh9dPRS3GCq2Z9R+l8s6YFDk962MWnfpZPKXX/LsQBpMING7cUjxLwfS3Zz2
 3/5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIFwyAhF+fKe7Vs33vqFfKIlLDvGtxUCztP/l13MmlDUCq4q5Lbn35ZjY4fP94IgmOa3nMBFpV7bQd@nongnu.org
X-Gm-Message-State: AOJu0YzzsO0uip1bujmETAwho/vYf7w7zKOKEy5b+0I4pQGQKZdzdrsb
 /U1cFMUdK4a37wi++9MyIg0anS4oAU+O/BYUpDgmhg4AmdFnl9ZKVGZ/voXhbsn6Mi/95FMFRKw
 MK9dsSnTPNDP/k61BZV1X9YjFdN4o+qr8fVenh/9ipMA24OTJ9HUXVUyH
X-Gm-Gg: ASbGncuEF1z+0lpKK9J6U/RYbJD14KRW4EJNhgd0sGlHZWR0zshsJRNEcD0RHlQhzn/
 TVQYr60AWP76Vmf+3Tx09gaYdOpuXQEgUjY33hjBiFO9RGnEVQJjpbkX+HmB7N1G3V/xkNChefP
 R/JLf/r89YIgGczzxkefcPrYb7uDuyGszufvzs3SV6QXBVI3mKsmo8wRfQYhwHWnckGAFpk4Rc/
 ZUUivUvMAuZRjr3J9bOSHH3vFyfF8WRNgpOWsmYfKhUPFjGAhWvEXwNM267A89vb5DS/YeOmixf
 uUDIiMj01xt44ZvN6l2boQDSDvYQBsMMUjjQnZJZIeChjlmJ5yPxAooHw/mF/LATIPxIxoo=
X-Received: by 2002:a05:6000:2087:b0:3ec:d80d:e59b with SMTP id
 ffacd0b85a97d-4256713ee4bmr10652771f8f.10.1759823437707; 
 Tue, 07 Oct 2025 00:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIsIsSbGBHQ7Ji2JU8LpY5keuf/u5KcnIIAaVT6A6IT2MWOyHcXnudBaHADnpArnFljsLC5Q==
X-Received: by 2002:a05:6000:2087:b0:3ec:d80d:e59b with SMTP id
 ffacd0b85a97d-4256713ee4bmr10652754f8f.10.1759823437348; 
 Tue, 07 Oct 2025 00:50:37 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619c3b75sm286126975e9.7.2025.10.07.00.50.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 00:50:36 -0700 (PDT)
Message-ID: <b8dc032c-3396-4329-bed3-171e63f87b06@redhat.com>
Date: Tue, 7 Oct 2025 09:50:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/functional/arm: Split the ast2600 tests in two files
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20251006173451.528310-1-clg@redhat.com>
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
In-Reply-To: <20251006173451.528310-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 06/10/2025 19.34, Cédric Le Goater wrote:
> The ast2600 test file currently includes tests for both the Buildroot
> and SDK images. Since the SDK image tests can take long to run, split
> them into a separate file to clearly distinguish the two sets of
> tests, improve parallelism and allow for different CI timeouts.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/arm/meson.build              |  6 +-
>   ...00.py => test_aspeed_ast2600_buildroot.py} | 74 --------------
>   .../functional/arm/test_aspeed_ast2600_sdk.py | 96 +++++++++++++++++++
>   3 files changed, 100 insertions(+), 76 deletions(-)
>   rename tests/functional/arm/{test_aspeed_ast2600.py => test_aspeed_ast2600_buildroot.py} (57%)
>   create mode 100755 tests/functional/arm/test_aspeed_ast2600_sdk.py

Thanks!

Reviewed-by: Thomas Huth <thuth@redhat.com>


