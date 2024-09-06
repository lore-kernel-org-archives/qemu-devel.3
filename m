Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F2FCE7AE0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 07:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smTaA-0003aR-EC; Fri, 06 Sep 2024 03:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1smTa4-00035o-RI
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1smTa3-000124-2P
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725608429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Wp/BkZaC5QjmOD1SZUnZwwD/jhWo/H+MSiUHmr0p7ac=;
 b=dSEhf3Xz1R5Jn6zYlZB4o9Vz7j8227lh6Nzqq1C8lyQPN67ne8KIhfBdbjFVbWqW9+eJIm
 LK2XQuuCHVgLPddwwoEVCNMUtr1HRi531dVBPeBC6rvA0H7rXByoqxym1i1bR/FCklhtuH
 irDAisB4YfhzFQA+tUaSUhNvCoxyofg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-prbBrbPNMuSSdvBmEC10eQ-1; Fri, 06 Sep 2024 03:40:27 -0400
X-MC-Unique: prbBrbPNMuSSdvBmEC10eQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-377a26a5684so904065f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 00:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725608426; x=1726213226;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Wp/BkZaC5QjmOD1SZUnZwwD/jhWo/H+MSiUHmr0p7ac=;
 b=KkVYOXNs+K9esbzZH41rsJccCBBDUqsy8fPDtKBaJbCjjUlrQzAm+F27zjTAZDFdtf
 pQzfllbvCw60wGSUqFEvoER562xO0J0xR/WFra/ovpG+pnWw9GaSk7Ak1wAD+zBIfMyn
 23HfQf0z3ajLJ9RAm4ZH+l4RvHbBLrrecQ63RD/kJSHgBuBweqVfcgNm84K1C2vsLwiV
 m02wvG5b+YeFiV4h3GkWyIS3PNp9TXYKy85Nn4rWKCWA/DZx18PLwmffnM4kfxh9yoFb
 vP/9S2zmuBrHk9a25zGjj6B/km7CH4sJSfzeT0T/5GJo7TT7xo1c9ekj65PWpU7JVdWT
 AT8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW58jB2l/srUKJZLLqqND8beN+H/r7ZyJrLy4ADaxGLcsp1R3oI1hXNHKtXGevDletVc1O0BiQxo0Ii@nongnu.org
X-Gm-Message-State: AOJu0Yx8uF34DAR6E6gx64NP5gKE1C2U3Kujm8homZC4elGVRL0mPuex
 ceWJfrqHPXmYRvwY3hp2sSKTJwvOviwBLlaxoKIJUeIleM1FUeoFUUytkwuguHTNeyEMNJRS722
 yr+2Z61xdq1DT8oaIlR/FJ3h0yyp6tKncy7/P4T4Gluwj/Tl+rQ2h
X-Received: by 2002:adf:f584:0:b0:371:c518:6f54 with SMTP id
 ffacd0b85a97d-378895d4f82mr948138f8f.29.1725608426118; 
 Fri, 06 Sep 2024 00:40:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzyCwCfFMJoUkvxQ6P+ObFK1wL9lo6bGafvhcxuvSc+s7D4+Rqp5b4dETmrZiROw0odl0fPQ==
X-Received: by 2002:adf:f584:0:b0:371:c518:6f54 with SMTP id
 ffacd0b85a97d-378895d4f82mr948104f8f.29.1725608424891; 
 Fri, 06 Sep 2024 00:40:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:5900:804e:d067:935d:cec9?
 (p200300cbc70d5900804ed067935dcec9.dip0.t-ipconnect.de.
 [2003:cb:c70d:5900:804e:d067:935d:cec9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374ca94e002sm12651677f8f.72.2024.09.06.00.40.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 00:40:24 -0700 (PDT)
Message-ID: <be6dfcb4-b1a4-4dff-a08b-e79e303960dd@redhat.com>
Date: Fri, 6 Sep 2024 09:40:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: kconfig: memory devices are PCI only
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
References: <20240906073737.493254-1-pbonzini@redhat.com>
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
In-Reply-To: <20240906073737.493254-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 06.09.24 09:37, Paolo Bonzini wrote:
> Virtio memory devices rely on PCI BARs to expose the contents of memory.
> Because of this they cannot be used with virtio-mmio or virtio-ccw.  In fact

Guess what I am working on at this very the moment ;)

> the code that is common to virtio-mem and virtio-pmem, which is in
> hw/virtio/virtio-md-pci.c, is only included if CONFIG_VIRTIO_PCI is
> set.  Reproduce the same condition in the Kconfig file.
> 
> Without this patch it is possible to create a configuration with
> CONFIG_VIRTIO_PCI=n and CONFIG_VIRTIO_MEM=y, but that causes a
> compilation failure.

Right.

> 
> Cc: David Hildenbrand <david@redhat.com>
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/virtio/Kconfig | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index aa63ff7fd41..7c554d230d8 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -37,6 +37,7 @@ config VIRTIO_CRYPTO
>   
>   config VIRTIO_MD
>       bool
> +    depends on VIRTIO_PCI
>       select MEM_DEVICE
>   
>   config VIRTIO_PMEM_SUPPORTED
> @@ -45,7 +46,7 @@ config VIRTIO_PMEM_SUPPORTED
>   config VIRTIO_PMEM
>       bool
>       default y
> -    depends on VIRTIO
> +    depends on VIRTIO_PCI

depends on VIRTIO_MD ?

>       depends on VIRTIO_PMEM_SUPPORTED
>       select VIRTIO_MD
>   
> @@ -55,7 +56,7 @@ config VIRTIO_MEM_SUPPORTED
>   config VIRTIO_MEM
>       bool
>       default y
> -    depends on VIRTIO
> +    depends on VIRTIO_PCI

Same here.

With CCW support, I can unlock VIRTIO_MD and VIRTIO_MEM_SUPPORTED and it 
should fly.

-- 
Cheers,

David / dhildenb


