Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7F0CF34AB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 12:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLhlw-0000RF-LO; Wed, 19 Nov 2025 07:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLhls-0000Ps-DN
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 07:58:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLhln-0001mL-Jp
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 07:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763557126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PKrHYwTLx/ubuEoCR8bb3vPMaRTTEdloZ0mb6lweoCU=;
 b=RTSyJwf2nZJrsuA6H921+XvHaNFv5ZqWOIGHYf/Xhd508rtv1O38mAozdNcCVhALFI5wWL
 hLOB0DwEj+gJAxazyw44PgsB2qflyDu9UvbxLrvk+Sm0aWJbTSsKAftKwCyuWxvQ0n09+Q
 D2cwMpUTQxzQ7+tD78NERzPx0jpv6k0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Ozqpj3CnPF6JVKV7afRwlg-1; Wed, 19 Nov 2025 07:58:44 -0500
X-MC-Unique: Ozqpj3CnPF6JVKV7afRwlg-1
X-Mimecast-MFC-AGG-ID: Ozqpj3CnPF6JVKV7afRwlg_1763557124
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429c76c8a1bso4043511f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 04:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763557124; x=1764161924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PKrHYwTLx/ubuEoCR8bb3vPMaRTTEdloZ0mb6lweoCU=;
 b=em8AQFp4DiSdUz2sZffrzUEx/fRy+YH+XK3+mMRVmDi2Zz6VqXHQGxaZ2J8dRTccx7
 C7v1wx8KpjS8hPs4hXwUoBXXTkg9s6LCEqZEfAZZqcgtUKq9JG/sgK5JuBX82kfxbx/3
 8shTBl7RAn8iFbLZvKU/LTzO7hKcbGI3ccGDxrts/o5q0iGiKURh8X7UYWFe9HEsbhg6
 yZOzeam4cjiDjhMxb/4EIfzw1qrWu6ACm9TUuzytrTUXuJpjXU6vNY+9kX2iWPVeVTSw
 EyYTJfbV8KQ+JvDk9AIrj9tLvcsXCvRKIuxS1luLq9JCFbas9g+n7ySXSHsGFtiMbtCC
 CFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763557124; x=1764161924;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKrHYwTLx/ubuEoCR8bb3vPMaRTTEdloZ0mb6lweoCU=;
 b=tqLTjgSmxPayKJ8nK4AT15aAPUY3qkQlaQlpsNPK2AZgTGd8rgMZrm612j9S29ncGk
 Tx30Zj/6XhF1ZuTnnKZsp/XSh6UQyPG5tiCDstdl0MXtZ1xKK3x41C8QMPQV3TRUnwF3
 HmAaXXHolq7VCy4lUMeUOuIufq7Dx4W4fb1If4o9brza1rEJ4tZDLIjEz9WtfqxFKK2A
 WwTjk6Gww1/Xs7eAsar5mdK8GylCDYo/CXYecjMrdsxPKHU9EmuWSgmil/EApGM0YRS2
 Y+jpuuSPtP+ecVBHs1872ImbmgrLYIxdJJoAy/NSGZkKtVjxAwld7BmUvSLLPoc+N3yN
 Kg4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU5GyFQPB/S+D2drdzFP7cp79lSgimhgOQ4mr9fS29DyCeiAnc5d4lpPuDAQG8X2iR2N9k2oNC8qRW@nongnu.org
X-Gm-Message-State: AOJu0YyE/zVgqPT5Tgom/a9NsVU/E5YQdOPR6FUbfbvLExiqyy2gXDRB
 Szg61qeERNSr6ekFlt6RBGGOmqwPsWuYd814aPjUQJGSHomVV+u0t8GurAXyYq4iG+WwsbjedLR
 WNd8SVVseMgczcwOkUTjYBh7CbO3Xyz2cHZxonPwjS6+i34+D5jP80Zz3
X-Gm-Gg: ASbGncshTu2dMCm3vFxZtMjmfBoN5zljMMIceYqIXj8NW9ZF0HiMxUKeIZXfeIeoviU
 hXPN225i3TvA+YlJUBbQHYI0sXj/fdEAyH2dkN6QGeSy5xoKPmH1i5P8sgcpK+bk5onSUW6LCDV
 QA72heehQICorPEQlKw3O2ebPu8nSWZVXg9S2TQkE1kEKsoWGGfi4a3Y4Z5eLUcPrt0vp4Ilzf+
 UyJeKVksLld0KtWE92T89llnaGcmNiBjY6TAz+AyFb7CfeIAhi6KSXrmlmgovzdPsdZ/OuVGwvy
 4y+5wdvEQv2TIigrVQbQUvBa+W71XYwb84uBXFp3SLW8keVKPVrPFZGB87G8P7DyolCqOy60TDH
 tRYXFkBcUW83ww9KwPuh0Y0+V/n70Pa3UhwI=
X-Received: by 2002:a5d:5f47:0:b0:42b:3d9d:c5f8 with SMTP id
 ffacd0b85a97d-42b59328f50mr18910760f8f.6.1763557123775; 
 Wed, 19 Nov 2025 04:58:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqPSQtSQB0zI9lRSxkIbSRUyflinpBi5VKclmY0lPQAwRk7ZBVYgKcsb3IAVaUjqEaZ31N9A==
X-Received: by 2002:a5d:5f47:0:b0:42b:3d9d:c5f8 with SMTP id
 ffacd0b85a97d-42b59328f50mr18910740f8f.6.1763557123415; 
 Wed, 19 Nov 2025 04:58:43 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42c97745f79sm23791071f8f.23.2025.11.19.04.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 04:58:42 -0800 (PST)
Message-ID: <a3435c3c-6f1b-41f8-86a9-ed082a6e6db6@redhat.com>
Date: Wed, 19 Nov 2025 13:58:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0] hw: add compat machines for 11.0
To: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <20251112130031.2484181-1-cohuck@redhat.com>
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
In-Reply-To: <20251112130031.2484181-1-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 12/11/2025 14.00, Cornelia Huck wrote:
> Add 11.0 machine types for arm/i440fx/m68k/q35/s390x/spapr.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/arm/virt.c              |  9 ++++++++-
>   hw/core/machine.c          |  3 +++
>   hw/i386/pc.c               |  3 +++
>   hw/i386/pc_piix.c          | 13 +++++++++++--
>   hw/i386/pc_q35.c           | 13 +++++++++++--
>   hw/m68k/virt.c             |  9 ++++++++-
>   hw/ppc/spapr.c             | 15 +++++++++++++--
>   hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>   include/hw/boards.h        |  3 +++
>   include/hw/i386/pc.h       |  3 +++
>   10 files changed, 76 insertions(+), 9 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


