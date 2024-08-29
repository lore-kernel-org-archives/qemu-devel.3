Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2598C83F2D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 15:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjhO0-0002AG-Cc; Thu, 29 Aug 2024 11:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sjhNy-00029k-Q5
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 11:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sjhNv-0001zz-G2
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 11:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724946509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vAYOr3c8kAOiX+b7fYPI/8X+NEy8JkqKLKZyrEqgK8I=;
 b=Pnigi5SP1wPpX2r7VWF+qKmJhntaLO/gRhNj6Q680v0y8Blm0gtXEX8Sqgd9/7PSrtJLz5
 0KoIPstW8FW0s6nEGSjqjvzYQS3YESA/j3en64oE7gWwqMSvqGHdVR4rdv9kElNQQr0aq/
 ia9FLKYq4lgV6tlYG+wzkzw+hUArM50=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-HjZpcmztO3W6J2ss0yM-Ew-1; Thu, 29 Aug 2024 11:48:28 -0400
X-MC-Unique: HjZpcmztO3W6J2ss0yM-Ew-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-371a1391265so504392f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 08:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724946507; x=1725551307;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vAYOr3c8kAOiX+b7fYPI/8X+NEy8JkqKLKZyrEqgK8I=;
 b=bxeE6UfY6OKowLPa/BZR2X5/LEBP74UpmEsLVmqZGd0j+EUGtUd8vg6yVKasJ9Jnjg
 k8P3ozehNopsDx4ZrPZn6Co+HqbIUK08HKD8OGibJKPtYLG3O6B4Q9tLw8AtkR7kHpAy
 E2qlLXKF6W80RAm9XRums53i0+QbsNRplJ6GlYRtUzOYluIz5WpKJZUvrSigkijWbvHj
 PxELXFAmjxgxZbTh/Yv04PeYGnkGjubHRxPHFbtpCFBUZi17fnVI5fdqsMXQFSmIerLi
 1ZPIvt0gxYiafczIt1qwqD9un0PpRcAz+Zs/phV3CqKb/LgONyXdZyftsiZHh62L0Isc
 ZmIQ==
X-Gm-Message-State: AOJu0YwvNPvYNNwLwHjPbCcB4RSEg4DBAKBUbZAXuRdk4pfbiwoFehtu
 mNnysJSUGj4YYfkDatt+zvloNvPOu+5OnQLfRlyYozlbva0ml4NwHuctjDR/kkvt4kJq92bPgiS
 AOliCytG5sp5b7pcTE87X7rVvVbTyAVZA/7MHjzIYSAy+IrlLbtvQ
X-Received: by 2002:a5d:6685:0:b0:36b:5d86:d889 with SMTP id
 ffacd0b85a97d-3749fe45fa7mr1699958f8f.6.1724946506807; 
 Thu, 29 Aug 2024 08:48:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjZ1ESm9IGKvQ6Q7/h/icOxvub4ypieibxjLE3WzP6nAaxRKMgciPM/b79K8ykPzmWn+xYSg==
X-Received: by 2002:a5d:6685:0:b0:36b:5d86:d889 with SMTP id
 ffacd0b85a97d-3749fe45fa7mr1699954f8f.6.1724946505923; 
 Thu, 29 Aug 2024 08:48:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c711:c600:c1d6:7158:f946:f083?
 (p200300cbc711c600c1d67158f946f083.dip0.t-ipconnect.de.
 [2003:cb:c711:c600:c1d6:7158:f946:f083])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ef8adcbsm1727270f8f.71.2024.08.29.08.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 08:48:25 -0700 (PDT)
Message-ID: <fe5dbb5b-d744-476b-a574-65c5860faf28@redhat.com>
Date: Thu, 29 Aug 2024 17:48:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] reset: Add RESET_TYPE_WAKEUP
To: Juraj Marcin <jmarcin@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240813153922.311788-1-jmarcin@redhat.com>
 <20240813153922.311788-3-jmarcin@redhat.com>
 <CAFEAcA9BWOkSmNh_b7HcNgfD429L1iLrjYTHWBJKDP2dJYCjCA@mail.gmail.com>
 <CAC2qdxAfvKubvO7fs4KF8dy_+Ad5kbAaxyn2P0FCDL-zkhEiMw@mail.gmail.com>
 <6ab58af7-3584-40b5-b56c-45544a06c7af@redhat.com>
 <CAFEAcA-NogX_8Phq_7YZuL1eGKeHbnowPzQoTo3P+8Sur=Xbsw@mail.gmail.com>
 <CAC2qdxCJ3=OzAsnM-paMUmvGAMau2Mc_OxNjxpP3T-F=69Boaw@mail.gmail.com>
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
In-Reply-To: <CAC2qdxCJ3=OzAsnM-paMUmvGAMau2Mc_OxNjxpP3T-F=69Boaw@mail.gmail.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> I have rewritten the documentation section to make it more explicit
> that the reset might not happen. I would appreciate feedback if some
> part still needs some care or if it is clear now.
> 
>    If the machine supports waking up from a suspended state and needs to
>    reset its devices during wake-up (from ``MachineClass::wakeup()``
>    method), this reset type should be used for such a request. Devices
>    can utilize this reset type to differentiate the reset requested
>    during machine wake-up from other reset requests. For example, a
>    virtio-mem device must not unplug its memory blocks during wake-up as
>    the contents of the guest RAM would get lost. However, this reset type
>    should not be used for wake-up detection, as not every machine type
>    issues a device reset request during wake-up.

Sounds good to me.

I'd probably generalize the virtio-mem bit to:

"For example, RAM content must not be lost during wake-up, and memory 
devices like virtio-mem that provide additional RAM must not reset such 
state during wake-ups, but might do so during cold resets."


@Peter, WDYT?

-- 
Cheers,

David / dhildenb


