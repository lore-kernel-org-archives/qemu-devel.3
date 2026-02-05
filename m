Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10249ECD994
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 18:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo3tI-0005QV-RA; Thu, 05 Feb 2026 13:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vo3tG-0005Px-Q2
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 13:15:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vo3tE-000278-IH
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 13:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770315339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oQeVWXA3OyvkJj7wgnmS2blodzltsFatNDpPE8JKc4I=;
 b=TZxC8MfX732TWNrcGN2wFYMdF9PICn+Kx33ZQU+0M6QohSdvoALOw05AyhVRRHqM1IWPyY
 re9jpkAlPN9RCrkjd634KeQ6tqXgCEW+JJ2iy+w7u/4NfrzdY3qJu2yoIf4smCoSHi29oQ
 YySv+PGcZXyMdbWzTPQXVLgzGJvRSr4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-90DRbG6INairzsWQ55DLnw-1; Thu, 05 Feb 2026 13:15:37 -0500
X-MC-Unique: 90DRbG6INairzsWQ55DLnw-1
X-Mimecast-MFC-AGG-ID: 90DRbG6INairzsWQ55DLnw_1770315336
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-435ab9ed85dso1046628f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 10:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770315336; x=1770920136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=oQeVWXA3OyvkJj7wgnmS2blodzltsFatNDpPE8JKc4I=;
 b=WZKtIxMcQR1OvCSQd3uHXXPcDnpFO8IeQj37ClS+QbUmcawH4hTdNMqoqyR5w5dKLq
 mcbI+idDafk2xeBg8SHAJ0tlBXAroQYWVJo+Cydpfh0FucT8KoUokNKCGN7boCmByyiN
 haYAremjXtOJhkuXswuNFGAru53S7csGgXXfE33VrJUwPcUngHkFS26lE+vqdFlXMXBS
 SufRqrzqmCHGkXxcf0QksDd/Z7grnAYwSJqyrTs+WNLZKtIACLM2Hzsw8ooAJFH0U10X
 meMAktr9NGUZExPVBz1PY/W5tHWjVyFzIGh021dx2Fn88Crk3+tkgp69D7JQcYJVKwgF
 QNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770315336; x=1770920136;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQeVWXA3OyvkJj7wgnmS2blodzltsFatNDpPE8JKc4I=;
 b=sxxpp6IaBkjO0IrPmlntSO0raMvKD6H4ATV+NY3b/8BTY1vnA3frf1X/yUltLe2fBZ
 yTRMD7k1Odw/E4UDJKg/vAnWuiC7X9tFwr8gLEL2AbMzxLuQw8NBW+KwrT/MSlLNm1XF
 HOeHml7i7aF5pc7gaYFxT1QHVCJ/rq8On3wxphbRVw3x152wz5ikNpvAG5A3S0WAdovz
 Nl8uY2vSDTmnwKPOO6973uFvCeJjKlUqm7k/4ilf5qpoCYS3Tf9UnjDmv2unF2ho0UPk
 +iQSjjEUFnzG6QUJpxAlAhp9vbvUI3Kh/0Af4OuFkhv02dVw9jNhRhX7jdPFGjjUDWX4
 Kbqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWCoko5zZB/PORWO0NSURsghKjc4sbfDXaDYdtnshC4PYa5qilTjtu3WFWbsbxulKrQVZ3PY6K4/B5@nongnu.org
X-Gm-Message-State: AOJu0YyQ8+PgMHsbn99F9dgk3Dx+JFpjYtzu5N5205c6Rzy1pHBQ3JOA
 jq9Y70RQZhdvsDjC6PDOsy8Gmfev9LmQ8pq0lheFhv+XL4B3JRQWEPgQPpUX1H1msDgXl7MioEn
 l1CahhICXy0giucGOG0GqMdwB9WlhM+zLE522+sAqdzPtWCg9F+pyQhXm
X-Gm-Gg: AZuq6aJIjO/K5XAf2Vzh62DMwaBS2QdIp1w2qj8R2LTa6HE8osXgqgn+A61JXGdKBgv
 Sv6VYLBatXUpR3+cSNOedKwmSbu31LRpE6Rdd7OZNZbf4VCPvVGPMfNoVvGam0jcSVNfTMNcFih
 WC82PoqgGbiRlEKxTaCcHkBl29Kczo/TtCgKkTVY5+FHs6Td1uUCuHC9LWk8rsVuAAdmLApO7Vv
 v4/1RFEWowNDNgK9y3mq0TXm3PxRxuLVWpIuwB/OlmNXV05+JdeV/kgWRvrmgdAtVRvk4MgQdt9
 rSWR9FjfklObFPJJb/9CUdO9ZpFUu9b7DN4qf+YJR8U/8cOfoj7kSHxZcuy/9fAfpY0srGazUbF
 hxhYjFXM=
X-Received: by 2002:a05:600c:470c:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-483201daa3amr3955165e9.5.1770315336392; 
 Thu, 05 Feb 2026 10:15:36 -0800 (PST)
X-Received: by 2002:a05:600c:470c:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-483201daa3amr3954775e9.5.1770315335938; 
 Thu, 05 Feb 2026 10:15:35 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830fc1744dsm104479265e9.2.2026.02.05.10.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 10:15:34 -0800 (PST)
Message-ID: <cc2993bc-b69f-463c-9159-0b254dbbb7dd@redhat.com>
Date: Thu, 5 Feb 2026 19:15:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] target/s390x: Rename get_phys_page_debug() @vaddr
 argument as @v_addr
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260204182722.44062-1-philmd@linaro.org>
 <20260204182722.44062-3-philmd@linaro.org>
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
In-Reply-To: <20260204182722.44062-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04/02/2026 19.27, Philippe Mathieu-Daudé wrote:
> In order to use the %vaddr type in s390_cpu_get_phys_page_debug()
> in the next commit, rename the argument @vaddr -> @v_addr.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/helper.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
Reviewed-by: Thomas Huth <thuth@redhat.com>


