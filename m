Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B13CE8340
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 13:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svGF3-0007T3-64; Mon, 30 Sep 2024 09:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1svGEu-0006sM-2M
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 09:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1svGEs-0000Q4-Ll
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 09:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727702098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W9q8/mgYlBpZXlPledIxbSeUoSpiFMU6QCVLd7lqafk=;
 b=FXdgOL2BJK5y5+P2gCth1M+S5RuH81B5z6uYv9tcph9Z3bQ/yRVf3K16QI2xJ86RBZRZct
 l70TLlwdLKB8x9PbFZz44vt8foV2kmxDFIZeYdfUbgabYJSjhBWXADJGgGp3w/G/I4cbT2
 q31On3mGZpnL0YI+cEl/GFaSh3uwV2s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-oxalC-3DObG1JRCk5tNc0g-1; Mon, 30 Sep 2024 09:14:57 -0400
X-MC-Unique: oxalC-3DObG1JRCk5tNc0g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37cd18bd0d6so1282401f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 06:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727702096; x=1728306896;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9q8/mgYlBpZXlPledIxbSeUoSpiFMU6QCVLd7lqafk=;
 b=EkLM1+C+pjKnaq2lB+GFiOvoOhry+BYcv2Hu0LKnKbsE9KeWLAYxbvwjqp5iYi+spr
 Pu3pZ61tbWJ6skj7E6/E86pnYJLLDzGndcONaOLG9qmQPw/Hj7KguY1cHUUYFDVPq1zs
 /4/8HeGunM1RVr+K4TWPnvBxnShnA44DWME6mRy6KBXR4n1K37L1t//gv1CqAip/Fa8N
 b9q3P1wkrBNGJtwlDvqscGpN2kYbq6y7hIubKCGnBPMvPvgleZiVpNqn6PaRVvdPTB4i
 TXOOOZK88LsbMK3FcbaE90hyqnlYAWnAYXOVRtYbeBjGobXM/g4cq6HrvNukBkOsMxgT
 iRmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAOTeF9b4XYhrQhPUMtgIjXeXC20f2QBR3g/zML0zT1rsmWJSxhYCVWakuuh/UTKykHwckzj4lrixE@nongnu.org
X-Gm-Message-State: AOJu0YwLxlH5TAkzV2VsbScbP3M52um5ypvsJmRVDbuuaSEMtKzkQHWA
 lX4euFox6GCTpT++ToAXPzw6XFUcozyEM5j0w07AUyX7BGXAjOxxm14yEdaEtyKRIxEY4BqQsM/
 4FIfZ0DexO/qc/yStEPKCgTVP+zjCroWEXRbi/IpXUTuUyynUE0/S
X-Received: by 2002:a5d:4808:0:b0:37c:d55a:38a5 with SMTP id
 ffacd0b85a97d-37cd5a69225mr6463515f8f.11.1727702095634; 
 Mon, 30 Sep 2024 06:14:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXZW1EIibIa0BfkBH8DBwzTtY0UrrCJVWYDRJPJId+WkIoNdVla6i6ULUSd3zwFGUZyQG/og==
X-Received: by 2002:a5d:4808:0:b0:37c:d55a:38a5 with SMTP id
 ffacd0b85a97d-37cd5a69225mr6463490f8f.11.1727702095146; 
 Mon, 30 Sep 2024 06:14:55 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969f23d5sm152743355e9.13.2024.09.30.06.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 06:14:54 -0700 (PDT)
Message-ID: <1e5863d9-eeed-40d0-9aa8-e5fe586339c4@redhat.com>
Date: Mon, 30 Sep 2024 15:14:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/14] s390x/pv: check initial, not maximum RAM size
To: Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-11-david@redhat.com>
 <c6d51e5a0bd3e222a1fb3354e31bf2edcc3a59d2.camel@linux.ibm.com>
 <72e7a377-60ab-45ed-9136-327fa4dd9e4c@redhat.com>
 <8938437c-dd89-4c9a-bb53-7949c5fc3a67@linux.ibm.com>
 <20240930133739.5fed4790@p-imbrenda.boeblingen.de.ibm.com>
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
In-Reply-To: <20240930133739.5fed4790@p-imbrenda.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 30.09.24 13:37, Claudio Imbrenda wrote:
> On Mon, 30 Sep 2024 13:15:52 +0200
> Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
> 
>> Am 24.09.24 um 22:17 schrieb David Hildenbrand:
>>> On 24.09.24 18:22, Nina Schoetterl-Glausch wrote:
>>>> On Tue, 2024-09-10 at 19:58 +0200, David Hildenbrand wrote:
>>>>> We actually want to check the available RAM, not the maximum RAM size.
>>>>>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>
>>>> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>>>> Nit below.
>>>>> ---
>>>>>    target/s390x/kvm/pv.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
>>>>> index dde836d21a..424cce75ca 100644
>>>>> --- a/target/s390x/kvm/pv.c
>>>>> +++ b/target/s390x/kvm/pv.c
>>>>> @@ -133,7 +133,7 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
>>>>>         * If the feature is not present or if the VM is not larger than 2 GiB,
>>>>>         * KVM_PV_ASYNC_CLEANUP_PREPARE fill fail; no point in attempting it.
>>>>>         */
>>>>> -    if ((MACHINE(ms)->maxram_size <= 2 * GiB) ||
>>>>> +    if ((MACHINE(ms)->ram_size <= 2 * GiB) ||
>>>>>            !kvm_check_extension(kvm_state, KVM_CAP_S390_PROTECTED_ASYNC_DISABLE)) {
>>>>>            return false;
>>>>>        }
>>>>
>>>> If I understood the kernel code right, the decision is made wrt
>>>> the size of the gmap address space, which is the same as the
>>>> limit set for the VM. So using s390_get_memory_limit would be
>>>> semantically cleaner.
>>>
>>> I wonder if we should just drop the RAM size check. Not convinced the slightly faster reboot for such small VMs is really relevant? Makes the code more complicated than really necessary.
>>
>> IIRC there have been functional issues with small guests and asnyc. Claudio, do you remember?
> 
> if we are <2G, KVM allocates a segment table as the highest level table
> for the gmap ASCE. there are pointers lurking around in the reverse
> mapping prefix_tree, which point directly into segment tables.
> 
> if the ASCE is region3 or higher, that's not an issue. if it's a
> segment table, then it's an issue, because those pointers will end up
> pointing into freed memory, once the old asce is freed.
> 
> in short, we have to guarantee that we will never set aside a gmap ASCE
> if it is a segment table.

Thanks for the details, the kernel seems to properly safeguard against 
that. For now, I'll turn it into a check against the memory limit, which 
directly translates to the gmap ASCE used.

Thanks!

-- 
Cheers,

David / dhildenb


