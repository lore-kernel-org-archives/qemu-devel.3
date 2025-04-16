Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0E1C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4ysF-0002Bo-3m; Wed, 16 Apr 2025 05:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4yrP-00022Y-C3
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4yrM-0007Zu-3v
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744794894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S73o+5gdR+idz0e6i/LO+q57mH3U211Z2J6LdwxR3Fk=;
 b=AHmttaG5QFs/AGbCsBSjstuXWEMdnaPPmCyGDe6YQu/SxesLFCKSYga9O3jPZ57LVg4AJW
 RtlvLIJkqtIxeQxksPzbJOuW/R3EItVIrbKIvIbyK9cy8YTciVM07uSTGcgoK5HsPqtpRc
 0NXXnpIBduhllmmEsA2pq7OvzGBqygs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-ccAvQQeaNQiyG7tctItoyA-1; Wed, 16 Apr 2025 05:14:52 -0400
X-MC-Unique: ccAvQQeaNQiyG7tctItoyA-1
X-Mimecast-MFC-AGG-ID: ccAvQQeaNQiyG7tctItoyA_1744794891
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so49654955e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 02:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744794891; x=1745399691;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S73o+5gdR+idz0e6i/LO+q57mH3U211Z2J6LdwxR3Fk=;
 b=VAuEgsFbCUvSIZFJkFCT5ub2uQD3adRil5ku6WyYrYp5YgSuOiO6z5Tka0cyKHkWiu
 vR2+gezfColS2c+8sTmpsAQdJOk2UgD9SUmvEv344QWAp1h2fdVmRFVdxsGLkAx+MuZG
 nINFoiYLonFKYh0nyTMKEHVxLVxOwKmWdCp3H2buTdv5JShjNY3uCPxph2m7bKdcR/yH
 6kNxHdAwm1HFEb7RBgeLknds9DXHZi2R7yJ4sbln/21WC8EXZyNUh7RiBji230iBOIH8
 X1MPG++qxHn9yKhiggWrkflmDSXr7UjtRWrH19g/77SNNUaTE1v7JgBxoco96DQ7CRe0
 Ybhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4vLo6WeeNNpxpclih31gBiR2yZ+62yeRtOHS1NbY2+GdLdbkLDDEQeqx4FAk7ISEjSSuWLIqmaCbg@nongnu.org
X-Gm-Message-State: AOJu0Yz6cSzZpVvziQSPShY3EBmTmfK962NTaxUs9vQc5KkFUEhU4eod
 EiASw5DF3WW3AfX3tbSMdb1bdmU9JXJAx4iHpk8poqt+ozlsl9ssHpH1bPqbFYG+aFdg8nDEnft
 uGuljRZMfXHRaEWZlZAAerY9dz11iRYrHtvnVfH9tNQwVccI1FlL0
X-Gm-Gg: ASbGncuIDupFCMQUyax7UXPIwZm6e6d0ft92nMMbsz4lqRNVc9PDiiP8a1zqj46VOCw
 QRFWbmmqnSOGaw8VyrjioK57UekVX9q4BUkdn4M0r/1ftnsSSjxLI5tDjTg8uRJgiUmLW6fLp7M
 CgKKi9Oef9w5f5o19s81cXvsHHRT00Zyso5kLN6zdAsWClOs0KN55bv5CXHaqX2QpGXrIYjdJpN
 7c9uJ+Yy3JjHJ9KbiJbW8gmm5EOloY9CempOaLPWrhr/Ok411SPycaY+43j2eFlTYezCYZWHhpZ
 XAsAhz1zJLw4mAX8BD6JfRNo7ElOWT8yaxQPXdBiJG8=
X-Received: by 2002:a05:600c:5025:b0:43d:988b:7732 with SMTP id
 5b1f17b1804b1-4405d6255aamr11632675e9.14.1744794891079; 
 Wed, 16 Apr 2025 02:14:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKWtxCbN5IBksVVgxNarUHxMreu+r5QJ2UMMpb+3nYl/hMq0p4coi8lQy3GYV08xu1dvF+lg==
X-Received: by 2002:a05:600c:5025:b0:43d:988b:7732 with SMTP id
 5b1f17b1804b1-4405d6255aamr11632415e9.14.1744794890747; 
 Wed, 16 Apr 2025 02:14:50 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-176-89.web.vodafone.de.
 [109.43.176.89]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4c8263sm15485835e9.4.2025.04.16.02.14.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 02:14:50 -0700 (PDT)
Message-ID: <307e2854-4320-4c8b-b6f9-b8ba2627157f@redhat.com>
Date: Wed, 16 Apr 2025 11:14:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] hw/core/loader.c: Fix type conflict of GLib
 function pointers
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 "zmta06.collab.prod.int.phx2.redhat.com, list@suse.de"
 <qemu-ppc@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <44e9ef95ea6e8aa33560ca8580db0033623f0e91.1744787186.git.ktokunaga.mail@gmail.com>
 <Z_9qIQhjsI5zOwXA@redhat.com>
 <CABgObfaj0ycyc2jVSJEVvQJ1m+uLf=_HYiOafn2MECgU36aspw@mail.gmail.com>
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
In-Reply-To: <CABgObfaj0ycyc2jVSJEVvQJ1m+uLf=_HYiOafn2MECgU36aspw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 16/04/2025 11.00, Paolo Bonzini wrote:
> 
> 
> Il mer 16 apr 2025, 10:29 Daniel P. Berrangé <berrange@redhat.com 
> <mailto:berrange@redhat.com>> ha scritto:
> 
>      > -    secs = g_list_sort(secs, sort_secs);
>      > +    secs = g_list_sort_with_data(secs, sort_secs, NULL);
> 
>     I don't see what the problem is with the original code.
> 
>     The commit message says we have a bad function cast, but the original
>     method decl is
> 
>        GList *g_list_sort(GList*list, GCompareFunc compare_func);
> 
>     where the callback is
> 
>         typedef gint (*GCompareFunc)(gconstpointer a, gconstpointer b);
> 
>     Our code complies with that GCompareFunc signature.
> 
> 
> The cast is inside glib; g_list_sort casts the function pointer and calls 
> g_list_sort_with_data.

Did anybody already report this to the glib people? I guess it should get 
fixed there in the long run...?

  Thomas


