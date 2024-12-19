Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52B7E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 11:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOEZv-00020B-VU; Thu, 19 Dec 2024 06:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOEYG-0001Wn-Vq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:18:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOEY3-0005cJ-AO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734607108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qgq6u54+LIAun8eVsmjIKrL5rRNqeBlE8tD0ygJhjto=;
 b=EEVPqOAaYMsuK2r/VtkWmZ8qEx6Glq2DEokSOlp+qYsvnkurVqrn7nERsM1/RRoobucn33
 kEvUF1V0xgWrQ8hXFkof+TL3oNNLUkcphhrOFrsZ1XePE4S+q+eHby5GQogjcHWIy91LFb
 N8afCGbczzCEOhwQKxAS3DVZ3WQtgzE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-VHeQRHXwMqaByHb3Ky38ug-1; Thu, 19 Dec 2024 06:18:27 -0500
X-MC-Unique: VHeQRHXwMqaByHb3Ky38ug-1
X-Mimecast-MFC-AGG-ID: VHeQRHXwMqaByHb3Ky38ug
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4362b9c1641so3751735e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 03:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734607106; x=1735211906;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qgq6u54+LIAun8eVsmjIKrL5rRNqeBlE8tD0ygJhjto=;
 b=E/95H62TY/S4Iljt7tgPYUFa3tnw2EqhGQSBL0FW3X6vHFWxx0UKyKKMhdEl7p2cD/
 yBRGTxNs53T2cRoz2Irpn3FjPIjKwvTIlMzmdzVzKtI9Vl4+lOtSAXog4jV0l/bVShIR
 50RxADIZHMIYOnu6SsqCgNXCPHgDO+o65uN4wf/7zu/t4/UdEWzbRHNh25xz9LEjAtbw
 +RJ2eOqRB3pwTui3UM/MHW+8/5l2LW87+yoKsDhcEMMzJmPpK7VUBDfBbMml1dtShLjK
 gqft/dO0twDvjqsFG6BXIwM4OY2oVxKn56teDIROyupUXgRXzqjtW1y1BB7UPVycNhL6
 pszw==
X-Gm-Message-State: AOJu0YxXtg9KqH9q7mnTRp+L9pGKaXNUGJq18FgJuOve5IAfftPS1uQ0
 v+Oxd5w/+oFf5jGCx5EnOzH/N6UIvOkswb/+uDzoLnCJ/yaPFfdj5gnAK7GrfYGealA/ni6RrUO
 bzrNbwCUgGGsZHiOGt+GAQxkIZ+BhN0jw8frrYiDS/0NuO0pETjiv6gqqSplPsuU=
X-Gm-Gg: ASbGncvSbywPg/0GJRVw1pxY/IfyBEzsQff5wdRCOTd7j5DcqA71gpHICfUMFW1yYAN
 HVcp1TK7RXUYpGTLygxrTIK3SkdpI8tMlpJdXAcp9FY2Clrmnvbgxd7JX8l7vmUF6al4A0NVIhN
 aQ3b46Hf4DzzRd0gMH+sv0mbJrtSklmyvn5wT1hcEnoUeaYfGJXC+KxYbQH8tR5KQjR1kYYJqbg
 T25vAV8fO7EqARD3TRD1FX7fTBu3pOBDBzW66wepUFmy+g1JXFE4YvLPIie0Lo0Xq5nk4T2b4/8
 aLENFnGf+a/bi0XAKsnG0/L5ytnQ2hXulKer9QBHcMyUkiVmM9uqRI8EYbpTEvjnTSHQWnLhWom
 qB7ERlg==
X-Received: by 2002:a05:600c:35cb:b0:434:a386:6ae with SMTP id
 5b1f17b1804b1-43655347ed6mr51886995e9.7.1734607106141; 
 Thu, 19 Dec 2024 03:18:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETwM1AfPtLYOU/hDRdcIpPwFcQ3phZpuX9Qt1qCiyHM764uoA+yib6FCBpLuov3zev0gYwFQ==
X-Received: by 2002:a05:600c:35cb:b0:434:a386:6ae with SMTP id
 5b1f17b1804b1-43655347ed6mr51886845e9.7.1734607105743; 
 Thu, 19 Dec 2024 03:18:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686?
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b00cf6sm50259295e9.10.2024.12.19.03.18.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 03:18:24 -0800 (PST)
Message-ID: <d19ab3d3-737d-4faa-a7d7-639b4ea3b172@redhat.com>
Date: Thu, 19 Dec 2024 12:18:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] Host Memory Backends and Memory devices queue
 2024-12-18
From: David Hildenbrand <david@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
 <CAJSP0QUoerckBWX=0PD_82jFwVbmtvftWf5QqSWxpK0Ttc+uvQ@mail.gmail.com>
 <2e6400d9-6fee-41ed-a317-329f275912c6@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2e6400d9-6fee-41ed-a317-329f275912c6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 19.12.24 01:04, David Hildenbrand wrote:
> On 18.12.24 22:09, Stefan Hajnoczi wrote:
>> On Wed, 18 Dec 2024 at 05:55, David Hildenbrand <david@redhat.com> wrote:
>>>
>>> The following changes since commit 8032c78e556cd0baec111740a6c636863f9bd7c8:
>>>
>>>     Merge tag 'firmware-20241216-pull-request' of https://gitlab.com/kraxel/qemu into staging (2024-12-16 14:20:33 -0500)
>>>
>>> are available in the Git repository at:
>>>
>>>     https://github.com/davidhildenbrand/qemu.git tags/mem-2024-12-18
>>>
>>> for you to fetch changes up to eb5c5f1ab479e9311d8e513e3eeafaf30f2b25b3:
>>>
>>>     s390x: virtio-mem support (2024-12-18 09:50:05 +0100)
>>>
>>> ----------------------------------------------------------------
>>> Hi,
>>>
>>> "Host Memory Backends" and "Memory devices" queue ("mem"):
>>> - Fixup handling of virtio-mem unplug during system resets, as
>>>     preparation for s390x support (especially kdump in the Linux guest)
>>> - virtio-mem support for s390x
>>>
>>> ----------------------------------------------------------------
>>> David Hildenbrand (15):
>>>         virtio-mem: unplug memory only during system resets, not device resets
>>>         s390x/s390-virtio-ccw: don't crash on weird RAM sizes
>>>         s390x/s390-virtio-hcall: remove hypercall registration mechanism
>>>         s390x/s390-virtio-hcall: prepare for more diag500 hypercalls
>>>         s390x: rename s390-virtio-hcall* to s390-hypercall*
>>>         s390x/s390-virtio-ccw: move setting the maximum guest size from sclp to machine code
>>>         s390x: introduce s390_get_memory_limit()
>>>         s390x/s390-hypercall: introduce DIAG500 STORAGE_LIMIT
>>>         s390x/s390-stattrib-kvm: prepare for memory devices and sparse memory layouts
>>>         s390x/s390-skeys: prepare for memory devices
>>>         s390x/s390-virtio-ccw: prepare for memory devices
>>>         s390x/pv: prepare for memory devices
>>>         s390x: remember the maximum page size
>>>         s390x/virtio-ccw: add support for virtio based memory devices
>>>         s390x: virtio-mem support
>>
>> Please take a look at the following s390x-related CI failures:
> 
> Thanks, most of them seem related to this PULL.
> 
> 
>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972912
>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972809
>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972931
> 
> ../hw/s390x/s390-virtio-ccw.c: In function ‘s390_set_memory_limit’:
> ../hw/s390x/s390-virtio-ccw.c:138:9: error: ‘hw_limit’ may be used uninitialized [-Werror=maybe-uninitialized]
>     138 |         error_report("host supports a maximum of %" PRIu64 " GB",
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     139 |                      hw_limit / GiB);
>         |                      ~~~~~~~~~~~~~~~
> ../hw/s390x/s390-virtio-ccw.c:130:14: note: ‘hw_limit’ declared here
>     130 |     uint64_t hw_limit;
>         |              ^~~~~~~~
> 
> Looks weird. Without kvm_enabled() ret = 0, so ret cannot be
> -E2BIG and consequently that code won't be executed.
> 
> Anyhow, I'll simply initialize hw_limit to 0 to silence the warning.
> 
> 
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972861
> 
> /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-skeys.c.o: in function `qemu_s390_enable_skeys':
> /builds/qemu-project/qemu/build/../hw/s390x/s390-skeys.c:256: undefined reference to `s390_get_memory_limit'
> /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-hypercall.c.o: in function `handle_virtio_ccw_notify':
> /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:46: undefined reference to `virtio_ccw_get_vdev'
> /usr/bin/ld: /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:47: undefined reference to `virtio_queue_get_num'
> /usr/bin/ld: /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:56: undefined reference to `virtio_queue_notify'
> /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-hypercall.c.o: in function `handle_storage_limit':
> /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:64: undefined reference to `s390_get_memory_limit'
> /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-hypercall.c.o: in function `handle_virtio_ccw_notify':
> /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:52: undefined reference to `virtio_get_queue'
> /usr/bin/ld: /builds/qemu-project/qemu/build/../hw/s390x/s390-hypercall.c:52: undefined reference to `virtio_queue_set_shadow_avail_idx'
> 
> We're building with "--without-default-devices' '--without-default-feature".
> Consequently, we won't even have CONFIG_S390_CCW_VIRTIO
> 
> So we won't compile s390-virtio-ccw.c, but we will compile things like s390-stattrib.c,
> s390-hypercall.c, ... which to me is extremely odd.
> 
> Is this maybe a leftover from the time when we had the old machine type? What value
> is it to compile all these files without even having a machine that could make use
> of these?
> 
> So I wonder if most of these files should actually only be compiled with
> CONFIG_S390_CCW_VIRTIO, which is the only machine we have.
> 
> 
>> https://gitlab.com/qemu-project/qemu/-/jobs/8679972894
> 
>    98/976 ERROR:../tests/qtest/migration-test.c:36:main: assertion failed (ret == 0): (1 == 0) ERROR
> ...
> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> stderr:
> Traceback (most recent call last):
>     File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 688, in <module>
>       dump.read(dump_memory = args.memory)
>     File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 625, in read
>       section.read()
>     File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 461, in read
>       field['data'] = reader(field, self.file)
>     File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 434, in __init__
>       for field in self.desc['struct']['fields']:
> KeyError: 'fields'
> warning: fd: migration to a file is deprecated. Use file: instead.
> warning: fd: migration to a file is deprecated. Use file: instead.
> **
> ERROR:../tests/qtest/migration-test.c:36:main: assertion failed (ret == 0): (1 == 0)
> (test program exited with status code -6)
> 
> 
> Cannot reproduce it so far, will try again tomorrow.

The following on top seems to make everything happy. I wish the
CONFIG_S390_CCW_VIRTIO stuff would't have to be so complicated, just to
handle odd configs that don't really make sense.
  

I'll do some more testing, then squash the changes into the respective
patches and resend.


diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 094435cd3b..3bbebfd817 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -12,7 +12,6 @@ s390x_ss.add(files(
    's390-pci-inst.c',
    's390-skeys.c',
    's390-stattrib.c',
-  's390-hypercall.c',
    'sclp.c',
    'sclpcpu.c',
    'sclpquiesce.c',
@@ -28,7 +27,10 @@ s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
  s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
    'tod-tcg.c',
  ))
-s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files('s390-virtio-ccw.c'))
+s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files(
+  's390-virtio-ccw.c',
+  's390-hypercall.c',
+))
  s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
  s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
  
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 248566f8dc..097ec78826 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -127,7 +127,7 @@ static void subsystem_reset(void)
  static void s390_set_memory_limit(S390CcwMachineState *s390ms,
                                    uint64_t new_limit)
  {
-    uint64_t hw_limit;
+    uint64_t hw_limit = 0;
      int ret = 0;
  
      assert(!s390ms->memory_limit && new_limit);
@@ -145,13 +145,6 @@ static void s390_set_memory_limit(S390CcwMachineState *s390ms,
      s390ms->memory_limit = new_limit;
  }
  
-uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
-{
-    /* We expect to be called only after the limit was set. */
-    assert(s390ms->memory_limit);
-    return s390ms->memory_limit;
-}
-
  static void s390_set_max_pagesize(S390CcwMachineState *s390ms,
                                    uint64_t pagesize)
  {
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 5a730f5d07..599740a998 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -35,7 +35,12 @@ struct S390CcwMachineState {
      SCLPDevice *sclp;
  };
  
-uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms);
+static inline uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
+{
+    /* We expect to be called only after the limit was set. */
+    assert(s390ms->memory_limit);
+    return s390ms->memory_limit;
+}
  
  #define S390_PTF_REASON_NONE (0x00 << 8)
  #define S390_PTF_REASON_DONE (0x01 << 8)
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 3732d79185..be1870b07d 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -44,6 +44,7 @@
  #include "hw/boards.h"
  #include "hw/s390x/tod.h"
  #endif
+#include CONFIG_DEVICES
  
  /* #define DEBUG_HELPER */
  #ifdef DEBUG_HELPER
@@ -117,12 +118,14 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
  
      switch (num) {
      case 0x500:
+#ifdef CONFIG_S390_CCW_VIRTIO
          /* QEMU/KVM hypercall */
          bql_lock();
          handle_diag_500(env_archcpu(env), GETPC());
          bql_unlock();
          r = 0;
          break;
+#endif /* CONFIG_S390_CCW_VIRTIO */
      case 0x44:
          /* yield */
          r = 0;

-- 
Cheers,

David / dhildenb


