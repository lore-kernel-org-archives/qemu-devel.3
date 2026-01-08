Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8196CF6BE5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 08:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdl8h-0007b6-5Z; Thu, 08 Jan 2026 03:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdl8d-0007Xv-P4
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:13:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdl8Y-0001m4-PF
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767859971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Qr+XpiIDAPtAldS04OVaR9l5cVcw9eG6wrlD33scbv0=;
 b=Ckikn7WzwxvLkahUY6zRZNs+ZlQo4HHIwDnl6wak+yZTUbuaqVDBziBhOBxqOE/AyUgwBN
 UVwZhuV2H0KiQ55UzbfMl+O4snTRvrQBp2TwKWdqjZfMh6ar8zeJcwPT6m7RvXwESsYokh
 AwInJyeZ9ib1KBdIQJso+t651x+skdE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-FmEg087rMhKiqnTC3vBlUQ-1; Thu, 08 Jan 2026 03:12:50 -0500
X-MC-Unique: FmEg087rMhKiqnTC3vBlUQ-1
X-Mimecast-MFC-AGG-ID: FmEg087rMhKiqnTC3vBlUQ_1767859969
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43102ac1da8so2062271f8f.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 00:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767859969; x=1768464769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Qr+XpiIDAPtAldS04OVaR9l5cVcw9eG6wrlD33scbv0=;
 b=fxT8l6NSTju2zWsxHwGSsewYif5gVXSIPKu3FJtkYjWyi5wcT8ul0z6FiXZPm+wOsD
 /i0CeKlaTk7eZASaMkyTvRXF6TVYYeHsruo1sJeok8ttgOo+0miSVdRvqBqzzq/XcXbL
 JZhb1RFKp7IuInW3i5T8fXGHtrQi8CZlPDMhxC7g7mm3Wv5TmaMAJcLSezpVSSm7PsDi
 zBhWJoAgony2ngsg0LO9OF9lGd3FDKMRzVk5c1Bi/eDD2eofjaJCbwHCFgJ+wgyz9uNo
 eKJjkLoI6KGV7NnXduAlLnSKeYeg4pywPziKtOgEwy8me2OsI/+t1idTfHwVU+djwy3/
 0S7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767859969; x=1768464769;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qr+XpiIDAPtAldS04OVaR9l5cVcw9eG6wrlD33scbv0=;
 b=tq2YvvafwYvlZm36zze7dD6p/s/WV5tu0vvD6xoFceRnfNbZgSkMtb/hlpqJL98STC
 vSw2Hj5xTf69MpoTn0f7ETHptUBoQtzn63kT9FWnXyfHkSG/ETiBSsN0T0GlTbahoWLp
 FOJDa4TErft4/sVcE7XpDcsyLw7BILUosIi6gaO2R4PmrlRIdb0yvIFL+wG6VI3bbsSk
 p5eIsuaTm3nAq7SVIqGZ73QzQ5i4a2bx3+OVWOMlSBK14j2ZRW6EKR1/d9IsU3cx7ubI
 OQz4GNp/D9wFXNJ2O4Lbx0lkORmnd2Woh86Nth0H7SVOmz+TV1xfSkIK3iZhgT7j0Snu
 fUYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+JLVTtvrZbAbgGygDw/mLwlmYRxDatfLfK5zMc2axTyy/CsUChmj9oBnrttB/MzF72HIrGE+bnGKj@nongnu.org
X-Gm-Message-State: AOJu0YyzBas8nuaJLaxOJcojzOQ9/l8GTZGVAG3FQVL8oQxQUP7nIF6s
 ve8PRug2diL1ij4wg2pTDizYIr0F+qR3zocM3xwOP27HfLAOX+/LLUIwDjTNii9boVkmGegrbKC
 +nOu6JQYyokO0TLeRdaOxY/aVa4yozXEzSLNjwOoEWiE6I6cEUoJrrngf
X-Gm-Gg: AY/fxX7mgvEjCZYWjsyqMcXL+uGX9a5IUA0R6SGHkwtxtWaxQRfY9Q+eilKX2r/N4Ks
 FdYUagpxf9YE7b+h3fI+KuQyNHjaiTajphE01QC0SZ81sQuq4P9eurq6a1N3Fw6hWWmwk31/42I
 zvYe3Lap8jeket7xzPNlTWLtMaZUMy3POjP7xNi+fnzbYPkM7KiR4hxrllAdSGamx/+uE0XR/5h
 5S8zsNxfRF6uovsAZso1pDNe/HhbS5GTYkzL2xlMQtZmE9HaqvYY4KLV7tOok08izw0rg5fi65l
 2ojcbBvbcB+SmFn+BdQQbXFRiQw822VnSVZlZFJT/wMXkPIWC0M3pj5WgSaB5OvhsvytUJWweUF
 3yMiSkwA=
X-Received: by 2002:a05:6000:1290:b0:430:fc0f:8fb3 with SMTP id
 ffacd0b85a97d-432c379833dmr5756690f8f.38.1767859969354; 
 Thu, 08 Jan 2026 00:12:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoiBIF/3z0sIu4Vs2jC1lOVyAO/6bOpHo1eR8MqCmSvQpXP3K27negE9SPYA57Rftggkl7zw==
X-Received: by 2002:a05:6000:1290:b0:430:fc0f:8fb3 with SMTP id
 ffacd0b85a97d-432c379833dmr5756661f8f.38.1767859968916; 
 Thu, 08 Jan 2026 00:12:48 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e1adbsm15477713f8f.17.2026.01.08.00.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 00:12:48 -0800 (PST)
Message-ID: <e79c622d-5ae9-49db-84bb-54db2588ba69@redhat.com>
Date: Thu, 8 Jan 2026 09:12:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] target/s390x: Un-inline s390_is_pv()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-16-philmd@linaro.org>
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
In-Reply-To: <20260107130807.69870-16-philmd@linaro.org>
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

On 07/01/2026 14.08, Philippe Mathieu-Daudé wrote:
> Inlining a method which use a static variable is really a
> bad idea, as it totally defeats the point of both concepts.
> 
> Currently we have 12 + 4 = 16 static 'ccw' variables...:
> 
>    $ git grep -wl target/s390x/kvm/pv.h | fgrep .h
>    hw/s390x/ipl.h
>    $ git grep -wl target/s390x/kvm/pv.h | fgrep .c | wc -l
>          12
>    $ git grep -wl hw/s390x/ipl.h | fgrep .c | wc -l
>           4
> 
> Fixes: c3347ed0d2e ("s390x: protvirt: Support unpack facility")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/kvm/pv.h | 24 +-----------------------
>   target/s390x/kvm/pv.c | 18 ++++++++++++++++++
>   2 files changed, 19 insertions(+), 23 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


