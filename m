Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC654ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 12:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sndCD-0001GX-6k; Mon, 09 Sep 2024 08:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sndCB-0001Fq-F6
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 08:08:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sndC9-0004nt-N2
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 08:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725883716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gwDgPdxGKPNd6tju7GNdoPGP/+VxNcQql+ZPtivw/5s=;
 b=b8kW3KmuM6odWvIYvXmwAmdpvsfOYikU+0+Tu10iB4xgz6vQfw+yN5MaT5yuW7O0+GY0yb
 oYaK0Kj8s1tCSHw8nEwGWyU7YZxiDFHm/CUWGRG9kq49XrSBFP9iDv+MdHMS96Z5iISoJe
 SE3Uw4rW8PVDrgu36w6PqKFoso/9OhQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-Npzamg_MPYqaVvlejch3Cg-1; Mon, 09 Sep 2024 08:08:35 -0400
X-MC-Unique: Npzamg_MPYqaVvlejch3Cg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb374f0cdso6743345e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 05:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725883714; x=1726488514;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gwDgPdxGKPNd6tju7GNdoPGP/+VxNcQql+ZPtivw/5s=;
 b=l2L0AK39SnZOP8jNKnVKjm506j2HCr2VDP+lRy1/7aJEWSG0wT5IrAKdjAdezg6o5j
 WAJPxL5Jkpn3EY9cBWgKVXwN87rv/YLtRyuXOW8cPVfZm/xyJYAw5SAR6rRk/NJFB+JL
 Erzxy6XLVYgD/GUxG7yb7ypyraPKt1Za1sE4Wtsg3EYWxEiACaPLqj1YSaNzqL8OZrnt
 2ecbq2afD1hYNS0RK1AE4kFQa+Y7cncGWZXcV3iJe8XCX016rq7uIJO94hXCm8RdO0r6
 s2bV7VgFFE9pxeyiwkSoub6Q/z/iFcuVYKBXw6qO2M88VuNYkNmiouI9Lu0CVQqXo4ac
 77gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeCW5JZHpcA8mr1mBnSicDjC5siZ9j0QptBGbEq+hphHBWm9YP2CXF9BgcLNN0nZpccXqZZp7jY+W6@nongnu.org
X-Gm-Message-State: AOJu0YwLMXdsMkBn0TUFqFT17iauBL5fBUTmnspogKeUq6XoEMn1kUp6
 UPrLlUg0fHAb+PHIAy6J1zaTTxogxSCBRHx8C5YwP+XrDZfKY4xcBYfgrEx2YPby1/b73+FyTCa
 MRumvDmAe/fbAxK5BOddXS24qFj/5w9wfTO+CiwVBe9eP+52aKYXh
X-Received: by 2002:a05:600c:1d19:b0:42c:b991:98bc with SMTP id
 5b1f17b1804b1-42cb9919abbmr11009915e9.0.1725883713873; 
 Mon, 09 Sep 2024 05:08:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMjh1BGrpn9AT8aNccMo//CPkIQI1UQ0fE96uj64iK+ivfTVK74EOj5fZwYiduYPDduS9+vw==
X-Received: by 2002:a05:600c:1d19:b0:42c:b991:98bc with SMTP id
 5b1f17b1804b1-42cb9919abbmr11009585e9.0.1725883712945; 
 Mon, 09 Sep 2024 05:08:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c729:d800:d3b6:a549:7878:a6ee?
 (p200300cbc729d800d3b6a5497878a6ee.dip0.t-ipconnect.de.
 [2003:cb:c729:d800:d3b6:a549:7878:a6ee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca8cebd35sm90698815e9.0.2024.09.09.05.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 05:08:32 -0700 (PDT)
Message-ID: <5ff32b7e-0db7-4f10-8a8d-2c4f1f3a95df@redhat.com>
Date: Mon, 9 Sep 2024 14:08:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] virtio-mem: Implement support for suspend+wake-up
 with plugged memory
To: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20240904103722.946194-1-jmarcin@redhat.com>
From: David Hildenbrand <david@redhat.com>
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
In-Reply-To: <20240904103722.946194-1-jmarcin@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 04.09.24 12:37, Juraj Marcin wrote:
> Currently, the virtio-mem device would unplug all the memory with any
> reset request, including when the machine wakes up from a suspended
> state (deep sleep). This would lead to a loss of the contents of the
> guest memory and therefore is disabled by the virtio-mem Linux Kernel
> driver unless the VIRTIO_MEM_F_PERSISTENT_SUSPEND virtio feature is
> exposed. [1]
> 
> To make deep sleep with virtio-mem possible, we need to differentiate
> cold start reset from wake-up reset. The first patch updates
> qemu_system_reset() and MachineClass children to accept ResetType
> instead of ShutdownCause, which then could be passed down the device
> tree. The second patch then introduces the new reset type for the
> wake-up event and updates the i386 wake-up method (only architecture
> using the explicit wake-up method).
> 
> The third patch replaces LegacyReset with the Resettable interface in
> virtio-mem, so the memory device can access the reset type in the hold
> phase. The last patch of the series implements the final support in the
> hold phase of the virtio-mem reset callback and exposes
> VIRTIO_MEM_F_PERSISTENT_SUSPEND to the kernel.
> 
> [1]: https://lore.kernel.org/all/20240318120645.105664-1-david@redhat.com/

Thanks, I'll queue this to

https://github.com/davidhildenbrand/qemu.git mem-next

@Peter, it would be great if you could have another look at patch #2, 
thanks.

-- 
Cheers,

David / dhildenb


