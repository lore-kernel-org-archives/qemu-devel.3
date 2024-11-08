Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9AFD5C0E5
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9QcT-0003Kc-67; Fri, 08 Nov 2024 10:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t9QcQ-0003Jx-3o
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:09:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t9QcO-0000XO-Fh
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731078587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=p/cf5x2Wzi7ZcGyVWvsnK9wKuW7fEebRo5DbnCsGfrg=;
 b=hPJezN4h/Bk9bscoL/FYOBdeVIAa6x2O83ah5/74enuufeEI0xAS5kHi81G4PdbplFPcYw
 93PcU9+2IHHulR56JB83ceTa7VVlyeKMbqBC6zqA3uk1cye9iV9314lWVct269cZtq3HpM
 Df1WKcIIJ26z2kW40pjqqekJDsNdQhU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-FrB_YAiuPJSaJsICEE3-JQ-1; Fri, 08 Nov 2024 10:09:46 -0500
X-MC-Unique: FrB_YAiuPJSaJsICEE3-JQ-1
X-Mimecast-MFC-AGG-ID: FrB_YAiuPJSaJsICEE3-JQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315cefda02so16127805e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731078584; x=1731683384;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=p/cf5x2Wzi7ZcGyVWvsnK9wKuW7fEebRo5DbnCsGfrg=;
 b=TIhr6bVeARWvCCSzVluOrvkH1QJGPue+CikUX0EGqY5bHerav8q3FrBX4nA7q+S4oq
 Zz2Egb1Kmj/JmKbQIo5l7zdP0MuCE/sCQujtKwHxCxW7amT4/ieE1xxQKVKTDVqFTNCS
 eS05/zLUxhTbrMvJYBeBXMKz5WqmiEFapriux9oMVwOj3o5Zgim8upQUkcxRx/NwpFhn
 FxC+nKIByzFYAs3UccEURoST9qNdlH3VuuRPklzJywMQmq4/Rv/YTZ99Cmy1b03hPPPD
 ufWjRDAvBqptmPB+sFt4ap4lPAXROiP0mFKC1WN/AoG+pXki36xp1O5KjWYJYoPcujDS
 X/Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0aSWxVg3bv3Wf3VwI8iC+q0ewukLH15SjltN/JJNvz8UMa44v3AAA9bdsTOTahLzMwJ/+94Qb/jmO@nongnu.org
X-Gm-Message-State: AOJu0YwDZBW+VOlAQw9WJ7xN1gtqZI+5TMEFWTcCOCYH8TvoJnkMbczN
 bi/63mvGcGMRs5pNmgY2xOemFG3f2KCVQwwWyV7X57u3Qn3pbYJdFqm9v7WlnLlXR85S4W7w6Xx
 cTsjguZXqXFueyYWjeHOjUgiLRE/r1qMfsCLmcMk3pQcA9iRbyHd7
X-Received: by 2002:a05:600c:a41:b0:431:6153:a246 with SMTP id
 5b1f17b1804b1-432b75032ccmr26300925e9.13.1731078584466; 
 Fri, 08 Nov 2024 07:09:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS6/mfse6bkREOyakubaBkFXYNtAgHFBYYEl+VLjBYGge0S78IuR2F2d2VILFqMBdv5N++XA==
X-Received: by 2002:a05:600c:a41:b0:431:6153:a246 with SMTP id
 5b1f17b1804b1-432b75032ccmr26300535e9.13.1731078584072; 
 Fri, 08 Nov 2024 07:09:44 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3a:cb00:3f4e:6894:3a3b:36b5?
 (p200300d82f3acb003f4e68943a3b36b5.dip0.t-ipconnect.de.
 [2003:d8:2f3a:cb00:3f4e:6894:3a3b:36b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa70a226sm112706715e9.28.2024.11.08.07.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 07:09:43 -0800 (PST)
Message-ID: <fe86f33f-4d34-48e6-be9e-efe6f71b5784@redhat.com>
Date: Fri, 8 Nov 2024 16:09:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
To: Peter Xu <peterx@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com>
 <053dd9b6-e4f7-41c8-abe9-ed02214f0639@redhat.com>
 <cce158c4-3bb1-4771-b2c5-f3ae8a2285d5@oracle.com>
 <5b192b5e-943c-4b2f-ab40-ef54ea578363@redhat.com>
 <00261b15-3eef-439a-8501-574e3bb50d95@oracle.com>
 <d00ab1a4-2b72-4202-b810-adeb53a16f01@redhat.com>
 <44b15731-0ee8-4e24-b4f5-0614bca594cb@oracle.com>
 <99c6d0df-4ced-4fe5-bc87-2682d1ceaa5b@redhat.com>
 <29d21f54-38e7-43a9-86fa-586bd6f957be@oracle.com>
 <115da88f-e3aa-4bfe-8842-530c06c39da2@redhat.com> <Zy4pHEY8jBLfJmBO@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zy4pHEY8jBLfJmBO@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08.11.24 16:07, Peter Xu wrote:
> On Fri, Nov 08, 2024 at 03:54:13PM +0100, David Hildenbrand wrote:
>> Likely AUX is everything that is "neither explicitly specified by the user nor
>> very special RAM"
>>
>> So I think hw/misc/ivshmem.c would also not count as "aux", and similarly
>> hw/remote/memory.c; both use memory_region_init_ram_from_fd(share=on).
>>
>> memory_region_init_ram_ptr/memory_region_init_ram_device_ptr are similarly
>> special: we cannot possibly turn them SHARED. But that's also what your code
>> already handled.
>>
>> So maybe, really everything is AUX ram, except
>> * Using memory_region_init_ram_from_fd()/
>>    memory_region_init_ram_from_file() users.
>> * Using memory_region_init_ram_ptr / memory_region_init_ram_device_ptr
>> * Created via memory backends
>>
>>
>> Note that hw/m68k/next-cube.c is one odd RAM_SHARED user. I don't know why
>> it uses RAM_SHARED to get anonymous shared RAM. Likely a mistake when that
>> code was introduced.
>>
>> CCing Thomas.
>>
>> commit 956a78118bfc7fa512b03cbe8a77b9384c6d89f4
>> Author: Thomas Huth <huth@tuxfamily.org>
>> Date:   Sat Jun 30 08:45:25 2018 +0200
>>
>>      m68k: Add NeXTcube machine
>>      It is still quite incomplete (no SCSI, no floppy emulation, no network,
>>      etc.), but the firmware already shows up the debug monitor prompt in the
>>      framebuffer display, so at least the very basics are already working.
>>      This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at
>>       https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-cube.c
>>      and altered quite a bit to fit the latest interface and coding conventions
>>      of the current QEMU.
> 
> This might also imply that our current RAM_SHARED is already not crystal
> clear on when to use, not to mention RAM_AUX if to be introduced..

Likely not. When the code was introduced we used magic boolean 
parameters and likely "true" was set by accident.

There are not that many RAM_SHARED users at all ...

Anyhow ....

  Please
> see my other email, trying to define RAM_SHARED properly.
> 
> IIUC after we can properly define RAM_SHARED, then we don't need AUX, and
> everything will be crystal clear.

I think I still prefer RAM_NO_AUX, but I'll leave it to you and Steven 
to figure out, it's been way to many emails at this point :)

-- 
Cheers,

David / dhildenb


