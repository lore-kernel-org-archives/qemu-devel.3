Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134A6D32D83
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 10:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAnqm-0002e6-IB; Tue, 12 Nov 2024 05:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tAnqd-0002Ta-9O
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 05:10:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tAnqa-00080f-LA
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 05:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731406207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uOlPu1uR6BMshuRA9RSTlabpnlI4Be5pGvXZI+eqNMc=;
 b=dYmXzIwgJ5hBpilca+5SZTdt5RE6wddYccSafNoL8Ui20J2K8sf8jw1xaZ4aAhDPa5J+Qa
 jwtJOfIXVX0+DQH1cbVfKbNAYdfBPY2e5d2pc+lcW11EaXYIVDfE+ZGWFllklJfOGxT/u9
 wuRqubfUwgEvbhF11KAQ73BugDx1PQs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-TlcsG1nOOAebNSBL2PlfDQ-1; Tue, 12 Nov 2024 05:10:06 -0500
X-MC-Unique: TlcsG1nOOAebNSBL2PlfDQ-1
X-Mimecast-MFC-AGG-ID: TlcsG1nOOAebNSBL2PlfDQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315af466d9so38978565e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 02:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731406205; x=1732011005;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uOlPu1uR6BMshuRA9RSTlabpnlI4Be5pGvXZI+eqNMc=;
 b=DBY+6PgKsux1gT+bgrbKIYCAuE0GD0xiTQSe9JxAUbBviXPR7s1JycgQtIYsWe+i6c
 rOFX7kZqophRL1jqTr5hUYxcBR/Ojwek2CJT2bq9NEszrwwcOygZwXey9i4uaeWX/ovo
 aygPnjsXjgxC7YvUo84swYL+To5VSwK5K1hhMZV+UYwsrkr57WOf3ZFBtm0lPYxkuRyv
 Z87qkZVT6S5C5NWGQp5t9zU1uBMYKVEZWFeJXBhS+Ju/5hiqTA0tB7eoMgq/lq2+YOAX
 NMp34HSVH+LgWYZDrmshENmkorrqi4I6koKqtT2HK/TGUoUiSkI8DgFrl6jfNPFEao8b
 ax3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmcC/b43qGaAI2P0gJUXJela1PqZU0zLbv9rEkNy9+WnMUaSd7MfiHoKRoBUCj8O2t/pkF9n3lXRMS@nongnu.org
X-Gm-Message-State: AOJu0YyAyb6m1KI1aPf/j/u++47y5qUq7a56hj1keG0Sm5Eq/rCcRYCT
 HQZWamER8UDGO4xwijLDomgzf5OrjkSdwK1JU8KvKNgAj8/ATxDXJqiBqpCQg9MGQyo4eLljr3M
 OkDl+NkqwJaN1ZSSIgkGFiaxaX6cAXKkRjVcXvOddwFmpgoDyGQEQ
X-Received: by 2002:a05:600c:1d0e:b0:42d:a024:d6bb with SMTP id
 5b1f17b1804b1-432b7517ac2mr122455495e9.20.1731406205290; 
 Tue, 12 Nov 2024 02:10:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxdmTb31TatCbDSNeLhpnsI96z0E/vN5VxwfcJwlq0AnEbFsjPMIWkgscdLbQvG6wJgvyQsA==
X-Received: by 2002:a05:600c:1d0e:b0:42d:a024:d6bb with SMTP id
 5b1f17b1804b1-432b7517ac2mr122455335e9.20.1731406204980; 
 Tue, 12 Nov 2024 02:10:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:8e00:7a46:1b8c:8b13:d3d?
 (p200300cbc7398e007a461b8c8b130d3d.dip0.t-ipconnect.de.
 [2003:cb:c739:8e00:7a46:1b8c:8b13:d3d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa523a0esm235788255e9.0.2024.11.12.02.10.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 02:10:03 -0800 (PST)
Message-ID: <b9b795a0-487c-4750-b4ed-31c79770c8cb@redhat.com>
Date: Tue, 12 Nov 2024 11:10:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] virtio-balloon: Enable free page hinting during
 PRECOPY_NOTIFY_SETUP
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Wei Wang <wei.w.wang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <cover.1731128180.git.yong.huang@smartx.com>
 <c799b1f96e55c5eb9c07e5a70a51b8ba67e7bcc9.1731128180.git.yong.huang@smartx.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
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
In-Reply-To: <c799b1f96e55c5eb9c07e5a70a51b8ba67e7bcc9.1731128180.git.yong.huang@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
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

On 09.11.24 05:59, Hyman Huang wrote:
> PRECOPY_NOTIFY_AFTER_BITMAP_SYNC was interpreted by free page hinting
> optimization as an indication to begin freeing pages. But there's no
> assurance that a sync is required when beginning a migration. Therefore,
> during PRECOPY_NOTIFY_SETUP, as well as PRECOPY_NOTIFY_AFTER_BITMAP_SYNC,
> enable free page hinting.

But what does this change bring us in practice? How was it tested that 
this makes any difference?

-- 
Cheers,

David / dhildenb


