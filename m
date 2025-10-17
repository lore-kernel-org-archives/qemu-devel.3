Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E437CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9m9X-0006xC-O9; Fri, 17 Oct 2025 11:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v9m9T-0006up-Il
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v9m9K-0006Ha-7n
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760714015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xVN8f8R8T4gn6xaP1K/aIHTuIQ68aBGTNHD2wpSKBW0=;
 b=CLhB4ND42KZs9TbP2j1EHvsnisnJ5HMPhqM8sNOPCo5gE2jPllEq3Wsd7ew8YGd1IyJ3Vg
 KfwjWhRMcL8PSzelqYrW5jc8FL2r1ikvl8m5+zAvleyLogWy03zPPWQN599pKToIApw80Q
 a89GXFUkf89D+sPwwkC+g/k2EYNVtNA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-oT33gPHZOgiAJy-HjLj9Jg-1; Fri, 17 Oct 2025 11:13:34 -0400
X-MC-Unique: oT33gPHZOgiAJy-HjLj9Jg-1
X-Mimecast-MFC-AGG-ID: oT33gPHZOgiAJy-HjLj9Jg_1760714013
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4256fae4b46so1377012f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 08:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760714013; x=1761318813;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xVN8f8R8T4gn6xaP1K/aIHTuIQ68aBGTNHD2wpSKBW0=;
 b=JmT9QKMT8WDdM73cSbIJu6jKmQJL7ApZ2/23P+yTjmdGpvW8aSv/CJCAux6S63sblj
 73N5agpvk5DXL2N8ntGCC+pHHmiggfJ1VhOCWedqwL6dkxjncw4GrUE/nPUO3n7ikkSI
 3g5IFDnW5S1Duu4As345O06JszI82R4haq21BgKPFUHwtaon7mnAuPSpEsQ8IR3zX8dQ
 REA24IaxBE75LbmKINvAp2PNpZhI7I/St1TbU97LuEUrzwPhchfdzKJxCxgmiU0rfJS8
 shOlLVlFJMp0OnQazr88dSaGu5UFT7KNT+DEcjsqx7TWxBQ1/EVOImd5/yulGzgSuOzI
 zhCg==
X-Gm-Message-State: AOJu0YwC5IuOcMB11wFlhxBEAcdgqaaRQ6b2rJVg8B7GdhE0PN4nKNbx
 T6o61SRuKIwnzb6vms8vgrJdBnwcbFNfdUMBdkUCwyZUzi54vAE9jxzynFHuXjPblVSAPzKd37z
 5N08swOhkHPUOCikUl1FMEocVOm+/Z2EAFZf3X1CiuivkLn47gANApoJz
X-Gm-Gg: ASbGncvhnOD3FP7tuKZcnqzIpu4mLGh0VXSTUufd6fls0L20AvVHlyGzDoukL28Jm1D
 EDkSZ3peu+04S1od/iaR7gWeZ+aakgOnL3TaDR0oIJ/QODkb3BIDYn/sicyoBNT/6KfblqqLjQ2
 zlMurni1Xfs5Cc9OSz/5uW5UQMe4ryPFxAv4PnHGNZywEG3OA11dJbOVEqnuJ1cwvCXGZeb1QG8
 izTB3NZqf8MWK+2rcAkkQyiwW8CL/gYQkxkzwaDE01yOV2AI7r8asYIDi5gWNXD5xJQqNHiwyoA
 U3LJ6H1zQTaHExWVeqPsRRT8H75PU5QphaJlT1xF4q0mYJFJ15FjmIAEbJyWX4rnBCl6VdR3BeK
 nih4ijLjdmzAKyP8bxQMCjDac22CJZ3qSWn7RZE7NWv4WB3S4D55m3ec/HGnI6YkJHnUx5iowv+
 m/RbQVnLcWgkfX1XGjFFh+d11Cb1o=
X-Received: by 2002:a05:6000:4021:b0:426:d836:f323 with SMTP id
 ffacd0b85a97d-42704d7e928mr3160677f8f.13.1760714012948; 
 Fri, 17 Oct 2025 08:13:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIBl1XeaEYHKohWYcpJg+IwlXwqt5T2/xqMZX6V5bamgpOEU2Z4LqldG+vCTgR4qFG6XAhlg==
X-Received: by 2002:a05:6000:4021:b0:426:d836:f323 with SMTP id
 ffacd0b85a97d-42704d7e928mr3160648f8f.13.1760714012485; 
 Fri, 17 Oct 2025 08:13:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce?
 (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de.
 [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cf6b4sm41693295f8f.25.2025.10.17.08.13.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 08:13:32 -0700 (PDT)
Message-ID: <bc7c734d-28c4-4abf-8049-a93e2e5e0b1f@redhat.com>
Date: Fri, 17 Oct 2025 17:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ram-block-attributes: Avoid the overkill of shared memory
 with hugetlbfs backend
To: Chenyi Qiang <chenyi.qiang@intel.com>, Peter Xu <peterx@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gao Chao <chao.gao@intel.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>
References: <20251017081445.175342-1-chenyi.qiang@intel.com>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20251017081445.175342-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 17.10.25 10:14, Chenyi Qiang wrote:
> Currently, private memory and shared memory have different backend in
> CoCo VMs. It is possible for users to specify the shared memory with
> hugetlbfs backend while private memory with guest_memfd backend only
> supports 4K page size. In this case, ram_block->page_size is different
> from the host page size which will trigger the assertion when getting
> block size. Relax the restriction to allow shared memory to use
> hugetlbfs backend.
> 
> Fixes: 5d6483edaa92 ("ram-block-attributes: Introduce RamBlockAttributes to manage RAMBlock with guest_memfd")
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
>   system/ram-block-attributes.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
> index 68e8a027032..0f39ccf9090 100644
> --- a/system/ram-block-attributes.c
> +++ b/system/ram-block-attributes.c
> @@ -28,10 +28,11 @@ ram_block_attributes_get_block_size(const RamBlockAttributes *attr)
>        * Because page conversion could be manipulated in the size of at least 4K
>        * or 4K aligned, Use the host page size as the granularity to track the
>        * memory attribute.
> +     * When hugetlbfs is used as backend of shared memory, ram_block->page_size
> +     * is different from host page size. So it is not appropriate to use
> +     * ram_block->page_size here.

But are we sure everything else is working as expected and that this is 
not a check that prevents other code from doing the wrong thing?

I recall that punching holes was problematic as the VM shares/unshared 
4k chunks.

-- 
Cheers

David / dhildenb


