Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32BBC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 08:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCxCa-0003OA-8p; Fri, 31 May 2024 04:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sCxCZ-0003MY-GN
 for qemu-devel@nongnu.org; Fri, 31 May 2024 04:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sCxCU-0001AR-Ul
 for qemu-devel@nongnu.org; Fri, 31 May 2024 04:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717142479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aezv3zFsS0hsoo4igr3TlwxEKznEcEaOmp4qkEzQPGQ=;
 b=bnf+BdecvUHVICe07WViprD19XNC+MAHN79FZnpJZJA6G0q5QUyPOPg1or6DIUGpWxga1C
 vlRPAzhwCs3OgPxh916A7JQbRKXBrzD0QzE1tqfjZfwfBohVnjWGi+yuzRjZDaOhNCImSw
 FE8YD6jX5QMXoDFOGyroFk2alEdowDs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-ramhE2U-Os6soOFlOUPg5A-1; Fri, 31 May 2024 04:01:17 -0400
X-MC-Unique: ramhE2U-Os6soOFlOUPg5A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35e0f069ad4so294357f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 01:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717142476; x=1717747276;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aezv3zFsS0hsoo4igr3TlwxEKznEcEaOmp4qkEzQPGQ=;
 b=cdXkYy5MZYSWd1K+drJ7VrmO2Kne/Q1edHHtJ+AgL0B+ONYGqLwfiY9pdCZTilB5kD
 9JMi7MS92YE/3QpW1H4hpeNWU3+cBf2tCLBFap9LXGT99h9aK/+2YkEMbivfkQ+Unghy
 ubsmqb5uBjrZbOoNzrXfVkZxo0UWARe/A5/6tm0LSF733KwHhiTPNQKK1/zvg7u6ET8u
 /2akfrM6NIoha020vK9U1wow1EpzULMlnzUa8m5mhzFmzOFye2S6n9gkQFCtiTsMMdB7
 OyxU+AYqz2CTGTtppw67Z2a+qZ+Ft6fPLAgLz3M7NU6w+QYKrXmyIx4YoIQ/Vnd8Dnb+
 z4lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1+J9qbnlP1sYGOzit/ne6MLJ7t5CHOWuIR/YQJBY5aYWHrSNDPy/06LI7CrxmoX8igRhtlkRopIWKBttElHMGNlYzvyg=
X-Gm-Message-State: AOJu0YxBiT7JRnCYxQtUEmNzaX/Y1MWRnNk6KuwuIWW+hYYTPLhzV5nY
 dhNTy67rELjkcKtDgw5t+nwkssmF4RvepHeWk3JHziZG+1yhQWKhl4wJAWdKgS3Y9DB3KKve+FH
 2t6laqKlUtbho/s0U5LMYQ1dHFc7efVGKMXM66yl4DstxXh2MdYpd
X-Received: by 2002:adf:ecd0:0:b0:35c:5202:face with SMTP id
 ffacd0b85a97d-35e0f2550b6mr968858f8f.9.1717142476296; 
 Fri, 31 May 2024 01:01:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdDoUNvPreIzGSCa9R4AGa50gMzmwlBRsXtgy2Pu6W+IXYYOlM8BrB7koffvHfFKF6auneQg==
X-Received: by 2002:adf:ecd0:0:b0:35c:5202:face with SMTP id
 ffacd0b85a97d-35e0f2550b6mr968781f8f.9.1717142475264; 
 Fri, 31 May 2024 01:01:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:a000:d4df:4b8f:37d4:59e4?
 (p200300cbc717a000d4df4b8f37d459e4.dip0.t-ipconnect.de.
 [2003:cb:c717:a000:d4df:4b8f:37d4:59e4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b8b76f3sm16623875e9.47.2024.05.31.01.01.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 01:01:14 -0700 (PDT)
Message-ID: <12cba30e-4034-4d3b-a0b4-5e25dbc5d094@redhat.com>
Date: Fri, 31 May 2024 10:01:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] osdep: Make qemu_madvise() to set errno in all
 cases
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com
References: <cover.1717140354.git.mprivozn@redhat.com>
 <e2250aa1d69faffcfd12b6d809d98b0c8157ce36.1717140354.git.mprivozn@redhat.com>
 <81f8c7f8-a4a6-4f74-894f-be3ffbf25f9d@linaro.org>
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
In-Reply-To: <81f8c7f8-a4a6-4f74-894f-be3ffbf25f9d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On 31.05.24 09:57, Philippe Mathieu-Daudé wrote:
> Hi Michal,
> 
> On 31/5/24 09:28, Michal Privoznik wrote:
>> The unspoken premise of qemu_madvise() is that errno is set on
>> error. And it is mostly the case except for posix_madvise() which
>> is documented to return either zero (on success) or a positive
>> error number.
> 
> Watch out, Linux:
> 
>     RETURN VALUE
> 
>        On success, posix_madvise() returns 0.  On failure,
>        it returns a positive error number.
> 
> but on Darwin:
> 
>     RETURN VALUES
> 
>        Upon successful completion, a value of 0 is returned.
>        Otherwise, a value of -1 is returned and errno is set
>        to indicate the error.
> 
> (Haven't checked other POSIX OSes).
> 

... but it's supposed to follow the "posix standard" :D Maybe an issue 
in the docs?

FreeBSD seems to follow the standard: "The posix_madvise() interface is 
identical, except it returns an error number on error and does not 
modify errno, and is provided for standards conformance."

Same with OpenBSD: "The posix_madvise() interface has the same effect, 
but returns the error value instead of only setting errno."

-- 
Cheers,

David / dhildenb


