Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B28CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAn0B-0003OQ-MH; Mon, 20 Oct 2025 06:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vAn09-0003O5-3R
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vAn03-0006V3-BV
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760955620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9aAOu89RQaC9i6mQzQHXCnOK9LydpJ3P0459VtviWM0=;
 b=GL/OCFafENpBuBlk49tPr7vFcv/sqz6bnXhgbwB1+32tHPRHSeZ8ZpwSo5OzwkgooE8/XU
 dqjwQLVMERutFyeX+iIRs2jPUnuwiZMuHvhGRSVbj5XB/aE/bXx5x/K3lFdsfg41qUFRRx
 hYbw4xocavIRiXIPl+d8ikl8DzsY8A4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-uAT3u3zOMHyO8b9UttGVUA-1; Mon, 20 Oct 2025 06:20:18 -0400
X-MC-Unique: uAT3u3zOMHyO8b9UttGVUA-1
X-Mimecast-MFC-AGG-ID: uAT3u3zOMHyO8b9UttGVUA_1760955617
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-471144baa6bso24979815e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760955617; x=1761560417;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9aAOu89RQaC9i6mQzQHXCnOK9LydpJ3P0459VtviWM0=;
 b=Qc2Tq+FODTe/0vLAy8VI9pMd6OQb5It/RRnCF3JCl9axhW17dIdkIONK/maQe9H2HQ
 YiQ1xJ5l9z54u6NvMjY6j22ifXMqr5Drrfs3RFUZrIQdEbiqflDdydViMNh3mW22/fi1
 Ac5nNeCIYTUckaL/aU2QW1EmJkq+4+CqN9ORuson0j+LFiIgsa+qm9+J0v5xji75XLkW
 j40/2BRAk6M2GzG7vCw2IiET5EhP4/UBpFiq98hBCDWRhLbzC8l+V9DqSOrgv4qOE1LR
 UxGpa23YKJIMFWjLJ4ONiibbIXn+C/IqeFEeM1t4JFn0Vm5eRoYIznVDufVpqdhhbEXM
 9ITg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3Fm8U1JegCH53BNHL040R9JTP0nUWadMtZQNqYU7BOwEIPQf4Gp2AqExIEXCsyf9yNcfqBhSvRZ5r@nongnu.org
X-Gm-Message-State: AOJu0YxolYpHa2rMdP3YpQZjMSLDICUufdlTH6Kkblrg0xIalAdYl7GX
 1qmP31f88xsndR5vrqxKp2bwjqb5Kq7i3BAT9RjVOIe6uJlMeN73AR1FBYbeu+CoXlfvKbf07d2
 SupQlHTS8/LNkaNqs5lNjOHlBbEAEgCobd2wTqUCD0liSpbRIZ0vABZyj
X-Gm-Gg: ASbGncsAUcSGWW8hgeI3bpmWo3joOvLDBv87rQ0RIbmnlOI00EWzl/0Xs3U6F8qPaDm
 bruvVX5aUERAfEVmTBWeSWl8tf9+pOW1/88Tw1iWzDsX+nlA1Sj00/ANCfE4awdfJLDsrRMH5g7
 2Xo+dwi6KQOV5c4nDit02W/anQNHlaJp+GvfQwnwFuo0uVInOicI44PNFjK0oLpBqGgmPWenXrH
 KbKLljPsgVXdzqGAHuE3iSPPXYzWgsXh16hVuV5zM1OQvweImyEbyBgZnLdqOVPgzYpNKiHIhar
 sqJH8Qc0U2Nf5KvaUbsaTsF0jpqMwOt2x7XkGRvA8AMmsbBAlU/1nmMNsZFjOx7UStuV4+2IFQR
 440NbJcFMuqxdjSvENsuNP1pLkW+jW532aUfHAEqV
X-Received: by 2002:a05:600c:3b03:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-47117874978mr89721475e9.3.1760955617188; 
 Mon, 20 Oct 2025 03:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoJ5Pu99e/J+gOAfGwlq7I8lfozHxbCA+llADW/ig4KtLDbyEsRjsXxY7+5kJQxzoHKwqxiw==
X-Received: by 2002:a05:600c:3b03:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-47117874978mr89721295e9.3.1760955616832; 
 Mon, 20 Oct 2025 03:20:16 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-135.pools.arcor-ip.net.
 [47.64.114.135]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9fa8sm14757545f8f.38.2025.10.20.03.20.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 03:20:16 -0700 (PDT)
Message-ID: <0b7cb54e-3bea-4989-8c7e-77e910d2f3c6@redhat.com>
Date: Mon, 20 Oct 2025 12:20:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/s390x/ccw: Remove deprecated
 s390-ccw-virtio-4.2 machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20251020094903.72182-1-philmd@linaro.org>
 <20251020094903.72182-2-philmd@linaro.org>
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
In-Reply-To: <20251020094903.72182-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 20/10/2025 11.49, Philippe Mathieu-Daudé wrote:
> This machine has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") it can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/s390x/s390-virtio-ccw.c | 33 ---------------------------------
>   1 file changed, 33 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


