Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA07C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 21:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttD2L-0006E2-Py; Fri, 14 Mar 2025 17:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ttD2I-0006D4-PP
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 17:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ttD2F-0006K4-PE
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 17:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741989461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9pT5BRsAj6fVJm0fRE2PN8znv0kXu8M+62S72gwnHlc=;
 b=KaZS28lGdWcbcGeSxurH4pVKlYyjaE/W0iJwuj9hrn+47zdxq7gMJJqvkLFmWXQaByXRt6
 0LyOMa+CiM5+XhI/lInrtyC31Kn/SEfDEWBQku3uLCf4ZznlNkvLtyfsZ9NoKdj9jimchL
 EcjZec0WQ9fS6oy7rT6/M8KceRruAVo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-QaAJc8GtMRKFmTWdO143eQ-1; Fri, 14 Mar 2025 17:57:38 -0400
X-MC-Unique: QaAJc8GtMRKFmTWdO143eQ-1
X-Mimecast-MFC-AGG-ID: QaAJc8GtMRKFmTWdO143eQ_1741989457
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43935e09897so1108175e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 14:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741989457; x=1742594257;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9pT5BRsAj6fVJm0fRE2PN8znv0kXu8M+62S72gwnHlc=;
 b=tu6zHmH0hnDGNVo9KJ0kT+SstNNE2Z+ttMgZlkCut5l+tQfEtNGIId2wliJy6CR7AY
 lnacowPIalj0fCi2hGdz6Rw7iXEiI3FZYvxFZ5GOTTF0M35XegLQ/67pPG3w7nDKUlgc
 pfv/YouC+8pQvMGqMvBKBmawCOdri9sarzQiDejhXHpQzv9jvOYXXo+xOoG5mfXfCkgv
 vpjX52RiUEpc7eCDvOmlR+2EZrEQNJmSiwJn7golYHqpeIu+QVWe3GacsA/xJg/CIrFO
 GrZh/9B9Q4w4qnr4GizFxdJ0C+UPWtVwMQNDTWPNQnaYKlBW/7otv5UPYsz9R++Rrg4/
 3Rew==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6PK5Y82VXiubqOg9azkw7vbgL2FXOxmZTWLPYJQLQFH1WQjV7Z+y81GHavVBPMN43JVFTXgatTEdO@nongnu.org
X-Gm-Message-State: AOJu0YxCROESbl8T2ynoxt8gYSqxFEZ7+EwdDdn3sntP2QLJiKAHV00l
 VV83yMmz8eOAO0M99ZGWKg6CQL10oam3qpAq36YpFdNEVh94OmhpCS2YB2AajDOcSiIcE6W/fRX
 kteKvoT42IKlvJhfxihtYbCYIMuxLO0DQc8mUhO04BxN8sOIbvooN
X-Gm-Gg: ASbGncsHpeuPzTVhxQaZWwlI7yIEGJuL2YlEVYj3BvronhOEM/drBJtSRUUMYOsxaRp
 MRTLYwTlS4P1ClRINP6LNVAqBYtuEedzA5JdzCdUGmYhbVfcrf0TU3AtOPVD7FIzQe8x4vMaW0l
 h9IwaDWXIvp9dkY4vlVS8AqzrC5ehJHMKj3Ztvt1ylc0/Dkuhv9X7eWaFZMSxmrq80mUcfuVsB2
 YHlbK0M48OWMnwaV4B751RPGB1KcVZoRM8WutK0OZ75VCdTwcgl4oTJ+4bAVzFVhsqJQ8udBLN7
 6ee18wFnDtlqvtGPqiMalOXuR3jjawHetWbYAS5RhMhb+LQYfTKFD1HIs3uLRhAmFVKZCzE3lQK
 HM+Pak8lwFl/R9qFVvWEDmm0aQqcDDifhB3on2LN52IU=
X-Received: by 2002:a5d:598c:0:b0:391:476f:d3b7 with SMTP id
 ffacd0b85a97d-3971f510ec0mr5211720f8f.49.1741989457481; 
 Fri, 14 Mar 2025 14:57:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFReHxCri6t4wLo4YbQ1BqPQIH2jNRLTbQ43c0LQCe4zR3ZdEE2N0WUD70LJw+qFJTYlp9kHA==
X-Received: by 2002:a5d:598c:0:b0:391:476f:d3b7 with SMTP id
 ffacd0b85a97d-3971f510ec0mr5211704f8f.49.1741989457188; 
 Fri, 14 Mar 2025 14:57:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:2000:5e9f:9789:2c3b:8b3d?
 (p200300cbc74520005e9f97892c3b8b3d.dip0.t-ipconnect.de.
 [2003:cb:c745:2000:5e9f:9789:2c3b:8b3d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1ffb626esm28987405e9.8.2025.03.14.14.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 14:57:36 -0700 (PDT)
Message-ID: <08313a74-25c8-4e55-b9f1-40fd27461fd2@redhat.com>
Date: Fri, 14 Mar 2025 22:57:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] gdb invalid memory access handling improvements
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20250314074107.992163-1-npiggin@gmail.com>
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
In-Reply-To: <20250314074107.992163-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 14.03.25 08:41, Nicholas Piggin wrote:
> This adds .debug=1 attribute for GDB's phys mem access mode, adds
> memory transaction error handling for it so it reports cannot access
> memory instead of silent success, and silences warning logs for
> invalid memory access coming from the debugger.

Nothing jumped at me, with Richard's suggestion of keeping the new 
function limited in scope

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


