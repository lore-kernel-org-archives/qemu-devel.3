Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10BBD3B988
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 12:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFuh6-0005BL-JT; Tue, 26 Nov 2024 07:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tFuh4-0005Am-2C
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 07:29:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tFuh2-00029l-Cm
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 07:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732624161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=s/RN7ccGeoKBRl+DiZG9HqLuzmc7Jqc8Ep1sgs6gWIg=;
 b=bo+L4l3qKcBa2Ajh3YrXU//d6VHweDk6dzgMLiGQfiLocxTlRUWSF/MFrCSWQkEQXe2nhR
 +FpcoubPGgMpa2co94Nz22g9HvMyuXC48nJtSuxVRmo51T9bWZy5KJe15/Ep7111jKFsYD
 3fbRJhJiBOCupXnBoDln/CuWZUkIGII=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-vCRt0dYJN0SHg_c_2At6mw-1; Tue, 26 Nov 2024 07:29:19 -0500
X-MC-Unique: vCRt0dYJN0SHg_c_2At6mw-1
X-Mimecast-MFC-AGG-ID: vCRt0dYJN0SHg_c_2At6mw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43498af7937so24116235e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 04:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732624158; x=1733228958;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=s/RN7ccGeoKBRl+DiZG9HqLuzmc7Jqc8Ep1sgs6gWIg=;
 b=OhRZcpRm8GUEnL3L/arjQxoBKhdky6I+d6rywJuKqrpuIywXC+GVIypxa5WrMsu69o
 yevcnobhhzexhlEuGnGM7hxZKgQQO5fkTwYZ55p+lwTd/ULo5jIqa0yMPpTLVZXBvjXw
 5qrUaL0dX/SzW5aBfmI2O3AJPVzp0Z6W7E22olVnL1XMgkQogc0vmAaHMqTehcs6a9fU
 wAiH4ElnB5FycHBvPLBeOtgUHzE+TXTHhyfSmfrgTjAEwUkSl5mRvNoDHgEFN9Qy0+C/
 GoJAhnKEAKP4Ofz3e7tyWA1eWYfa1JABOkB2jdIudWPFRdUI9bO5ON38BlnizRKX5uZ2
 dZig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCWAKBX9D5EmUEFmSXO51JP7ZQsgbqH6FzJZ9kNwxy31rYCDJtNfLVcDpOV2qOU6c3TiC9ZBfRj00w@nongnu.org
X-Gm-Message-State: AOJu0Yx+SCuSEkvfHYlGDhroqaCkGd94Djqc28qzJWo2Cg8Aco2HEMSe
 8QOP1J1qEBkBGbeKp+zUUuaRa8yz5RGeYcNt0A9CBXY3igHROjnHBzrXjKySQzguk3o5gR2gfLT
 hOHCjXS+MzegFGQq3YLgATpioXv+MtItU1yjMQ7cg7BjE4banOLI4
X-Gm-Gg: ASbGnctK8A01wAGQnURC93p5k9O/fRXH7+ptqr4gIbVZV6XNRM4fl5mnquqSNqP/4Z2
 2dnLtwJ8hhertHVucK6G9QhOgA25BmXoBGwAM2PqIKWq5CkHPKp8gW2ZDkbU+eYrO39CovbaXOK
 dk0Uj5mmFlLbp76ecDsZAEvtzzd96yB1j3JvLXa4z4bfoxLGROms+KAe/ZRCPoAdnVScSzDM/LY
 G2kmSInka+uP7anv+eWp03AzFkQh8M4TG3+sWSrbOfGDwOjyxtFPBpEkzfeA7W5mWPqwZJ+OAFL
 KcKdu3HtKtH3wzZLKV6h5J1gsu68Q33uyW+zR3ijxSWhqZ2QWes0vBSNHxG9ZSQ61K8ac+HCbfR
 zig==
X-Received: by 2002:a05:600c:1383:b0:42c:de34:34be with SMTP id
 5b1f17b1804b1-433ce410f5fmr159096655e9.3.1732624158695; 
 Tue, 26 Nov 2024 04:29:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwnEtUay10AR6AaKMRpcImexWy1dNKWFSbSjGdBHsS/t1FGbco53bSvz+pyStHd8uxRK+f9Q==
X-Received: by 2002:a05:600c:1383:b0:42c:de34:34be with SMTP id
 5b1f17b1804b1-433ce410f5fmr159096505e9.3.1732624158377; 
 Tue, 26 Nov 2024 04:29:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c72d:e900:38f3:8bdd:52f7:5e83?
 (p200300cbc72de90038f38bdd52f75e83.dip0.t-ipconnect.de.
 [2003:cb:c72d:e900:38f3:8bdd:52f7:5e83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349ea54e13sm81741705e9.34.2024.11.26.04.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 04:29:17 -0800 (PST)
Message-ID: <2ac194a7-9790-4aa7-bb41-65f8bb21f616@redhat.com>
Date: Tue, 26 Nov 2024 13:29:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/virtio-mem: Prohibit unplugging when size <=
 requested_size
To: Wei Chen <weichenforschung@gmail.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, yuval.yarom@rub.de, genkin@gatech.edu,
 Zhi Zhang <zzhangphd@gmail.com>
References: <20241126080213.248-1-weichenforschung@gmail.com>
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
In-Reply-To: <20241126080213.248-1-weichenforschung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 26.11.24 09:02, Wei Chen wrote:
> A malicious guest can exploit virtio-mem to release memory back to the
> hypervisor and attempt Rowhammer attacks.

Please provide more information how this is supposed to work, whether 
this is a purely theoretical case, and how relevant this is in practice.

Because I am not sure how relevant and accurate this statement is, and 
if any action is needed at all.

Further, what about virtio-balloon, which does not even support 
rejecting requests?

The only case reasonable for
> unplugging is when the size > requested_size.

I recall that that behavior was desired once the driver would support 
de-fragmenting unplugged memory blocks. I don't think drivers do that 
today (would have to double-check the Windows one). The spec does not 
document what is to happen in that case.

Note that VIRTIO_MEM_REQ_UNPLUG_ALL would still always be allowed, so 
this change would not cover all cases. VIRTIO_MEM_REQ_UNPLUG_ALL could 
be ratelimited -- if there is a real issue here.


> 
> Signed-off-by: Wei Chen <weichenforschung@gmail.com>
> Signed-off-by: Zhi Zhang <zzhangphd@gmail.com>
> ---
>   hw/virtio/virtio-mem.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 80ada89551..4ef67082a2 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -671,6 +671,10 @@ static int virtio_mem_state_change_request(VirtIOMEM *vmem, uint64_t gpa,
>           return VIRTIO_MEM_RESP_NACK;
>       }
>   
> +    if (!plug && vmem->size <= vmem->requested_size) {
> +        return VIRTIO_MEM_RESP_NACK;
> +    }
> +
>       /* test if really all blocks are in the opposite state */
>       if ((plug && !virtio_mem_is_range_unplugged(vmem, gpa, size)) ||
>           (!plug && !virtio_mem_is_range_plugged(vmem, gpa, size))) {


-- 
Cheers,

David / dhildenb


