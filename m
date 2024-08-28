Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBB6C5474F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 07:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjCzH-0007bf-5w; Wed, 28 Aug 2024 03:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sjCzF-0007aj-U8
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 03:21:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sjCzB-0002Wg-L4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 03:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724829656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+UlQWMuDSPFkQU58/7kHu/8TAloY2huQtCJkmUTkQJs=;
 b=N3yos0GcM50Zc8GVrfbIe0pF0pR4itz9pXmLmDazxgaQVG5ZSgOwl41IawaNQU1EgCQhv9
 hDrniovgVIdmzEkRyEKeg0xyIoi3CDW9/cTTgjgVCB5LTXTPvYv4yWH9QFRfueo7LsKsSS
 hWcKidJx6q8uMpDnirvkoxzS88hRlqE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-KbsuMLCbPqyqSzEz8CvNiA-1; Wed, 28 Aug 2024 03:20:54 -0400
X-MC-Unique: KbsuMLCbPqyqSzEz8CvNiA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37193ed09b2so189146f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 00:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724829653; x=1725434453;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+UlQWMuDSPFkQU58/7kHu/8TAloY2huQtCJkmUTkQJs=;
 b=sJQNcbbF/SeznJrnabjE7R3jwYS4kZHtJuMThT+CRljXYeqOpJZ9kvEm8nY0y+6cZy
 83t17d6oIuGB2pkWSQI+SCmCv+Co/U25QXhsSUcrJ0hMoBcHCZKOOT62azYqHTdvF3o7
 EE0AHlyYhNvgJuWJRag5NTZNGV2RWuBczx1QgOEuBqoxhJ95vuSL6vnkO+oXtFP4WrsV
 L0JrBuIDc0c0Aca0kZfMjSqAGEN7Wngmmtph/YyT6zaS2akkhEd9BEjBr5kTw0KxdqXl
 ZSf+Z5CbfOt6OPucnDKS7OweBZXgX4UHTFtEHN5Y5bUOBwecyns6LlbPAHtL54qfoWuG
 AE6Q==
X-Gm-Message-State: AOJu0YzvG/711m4hqj4jmtWc2aeT8Vm8z5oK1BQvGxkjGvOTRFjRU9kB
 dZCZvW5A5K5MaFO2uMutb2hiHIXi3OLHDoXD+u/kbfMt1Aa6Uwnp05/F6AirXZuGYFRjcfG/8Ip
 2Iq79NLBCI1ryNyj3fY83PixskH+xf2Rm9e8AyFP9H7ows+0bx9vy
X-Received: by 2002:a05:6000:dc7:b0:371:6fcf:5256 with SMTP id
 ffacd0b85a97d-37495f49a63mr632410f8f.18.1724829652973; 
 Wed, 28 Aug 2024 00:20:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ81erZkaHbDzJhLmEjWu1fj3Q+gKZsxUU2ly/id+iPEpJBvKjM0X1b6iJzM9IdCEJHvfoZQ==
X-Received: by 2002:a05:6000:dc7:b0:371:6fcf:5256 with SMTP id
 ffacd0b85a97d-37495f49a63mr632382f8f.18.1724829652102; 
 Wed, 28 Aug 2024 00:20:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:1700:6b81:27cb:c9e2:a09a?
 (p200300cbc70617006b8127cbc9e2a09a.dip0.t-ipconnect.de.
 [2003:cb:c706:1700:6b81:27cb:c9e2:a09a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37308141dc3sm14926110f8f.41.2024.08.28.00.20.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 00:20:51 -0700 (PDT)
Message-ID: <867871d8-890e-4859-9c5e-20d816d97539@redhat.com>
Date: Wed, 28 Aug 2024 09:20:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] softmmu/physmem: fix memory leak in
 dirty_memory_extend()
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240827083715.257768-1-david@redhat.com> <Zs4TcHvfwhBFSWvQ@x1n>
 <03dfba8f-19b3-4ff4-9de7-9211c2a26f56@redhat.com>
 <Zs4dwmYdZ8wmu8WE@x1n>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zs4dwmYdZ8wmu8WE@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 27.08.24 20:41, Peter Xu wrote:
> On Tue, Aug 27, 2024 at 08:00:07PM +0200, David Hildenbrand wrote:
>> On 27.08.24 19:57, Peter Xu wrote:
>>> On Tue, Aug 27, 2024 at 10:37:15AM +0200, David Hildenbrand wrote:
>>>>    /* Called with ram_list.mutex held */
>>>> -static void dirty_memory_extend(ram_addr_t old_ram_size,
>>>> -                                ram_addr_t new_ram_size)
>>>> +static void dirty_memory_extend(ram_addr_t new_ram_size)
>>>>    {
>>>> -    ram_addr_t old_num_blocks = DIV_ROUND_UP(old_ram_size,
>>>> -                                             DIRTY_MEMORY_BLOCK_SIZE);
>>>>        ram_addr_t new_num_blocks = DIV_ROUND_UP(new_ram_size,
>>>>                                                 DIRTY_MEMORY_BLOCK_SIZE);
>>>>        int i;
>>>> -    /* Only need to extend if block count increased */
>>>> -    if (new_num_blocks <= old_num_blocks) {
>>>> -        return;
>>>> -    }
>>>
>>> One nitpick here: IMHO we could move the n_blocks cache in ram_list
>>> instead, then we keep the check here and avoid caching it three times with
>>> the same value.
>>
>> yes, as written in the patch description: "We'll store the number of blocks
>> along with the actual pointer to keep it simple."
>>
>> It's cleaner to me to store it along the RCU-freed data structure that has
>> this size.
> 
> Yep, I can get that.
> 
> I think one reason I had my current preference is to avoid things like:
> 
>    for (...) {
>      if (...)
>         return;
>    }
> 
> I'd at least want to sanity check before "return" to make sure all three
> bitmap chunks are having the same size.  It gave me the feeling that we
> could process "blocks[]" differently but we actually couldn't - In our case
> it has the ram_list mutex when update, so it must be guaranteed.  However
> due to the same reason, I see it cleaner to just keep the counter there
> too.

I'll move it to the higher level because I have more important stuff to 
work on and want to get this off my plate.

"num_blocks" does not quite make sense in RAMList (where we have a 
different "blocks" variable) so I'll call it "num_dirty_blocks" or sth 
like that.

-- 
Cheers,

David / dhildenb


