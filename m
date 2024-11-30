Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6212CD7360A
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 19:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHT0c-0003iR-9u; Sat, 30 Nov 2024 14:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tHT0Z-0003he-VY
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 14:20:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tHT0Y-0006GT-6S
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 14:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732994394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wwBRPw6dmprPCr5EHe7pOwjlNzbyaA+pfoy7alAN5/A=;
 b=B+jxfnnXnVnjkUkH/6j8rRRwfyiS9dJtxcKHUVLiOSj1KhtdKLXgGxNd3gbRdoixDcDSqP
 lRwgl5jsxRkDJHShEO95gAJqpGvF4GtYPrQoNZVHSP6EotYK9hiyCh2REGuUkx+WkSlFME
 z4UkxC9ng/1c+s9YZ/DR8ufs86PC7r0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-7jsDDTuJNJOy2Smsoldouw-1; Sat, 30 Nov 2024 14:19:51 -0500
X-MC-Unique: 7jsDDTuJNJOy2Smsoldouw-1
X-Mimecast-MFC-AGG-ID: 7jsDDTuJNJOy2Smsoldouw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385eb060d4fso70791f8f.1
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2024 11:19:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732994389; x=1733599189;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wwBRPw6dmprPCr5EHe7pOwjlNzbyaA+pfoy7alAN5/A=;
 b=R9zBqDTOT7r+gvHSwD0gGn2VTKeAJmiWqOUqvv+oSbXKrdpYh52HLfC7xEs4oSLWUY
 wQXiMPOb/MTWpILoQ9t2bvyH0YwIFQaxEKtf5J5TLjHFab+subhbXjbpJ4LgVfdBYCLo
 2U3ntskhQG6sF7hb35/T0ajQVdcpqgrWJ1sHccG/9D6Qe/dAeKQKm+wjJ+lWz2p0MimC
 cKG7GUSlTbqYTaG/oGnYjTM7ksffMu0sreQ/vg8k2XhDDQWOB0abgZf5n4NZ81yUKZD1
 CFxi9bUZdU/DBbvCEBACT2IiV6LFDOWC+mnBXFYDtoP8T6UOJjCDnLtawbQO6yMnxTdR
 sCbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiTXNsDs1yKmTiECJCtFvkYrkObvarJ+CvLKid8pifrIZqEkMgv7L0P48aEGSbzKGqfy7O/Msxvzjg@nongnu.org
X-Gm-Message-State: AOJu0YzmhIVCAqWgFp0O3n3+6G7mo1UYm/S896P/13S70a+4wMlyQLyp
 Z6iadDM8PmkatAPvNFT1mtxUWc5mi5sk2OZYxzXAPrANyNRODuTzFG58GL0JLh29A26dPV1u7ps
 D3mZxzn4sduMIq8Ei7y6mkHvFTLrHb9jd7xPsuqP2nD7vPZFv9gO3
X-Gm-Gg: ASbGncvzJDSFVDb0TsXytFGrB+7QKeKpweVGByMUECk7FV2HuuVHmM5aJt6I0SJBqI9
 PUWdy3GLF8YKZVmbqKBuYTor3m1gYRmJDETwPXywcbM+x2dqoSXEnDVCqYBWoBkVZrtzGGVIOL9
 niMhr0ngHo+0L7fGSay9jHFZxG4fBFKXtpPy6l2XQsKeQF5YoXydYNXXFtbg5plw2mWhDwegZlC
 09QgQvKcjbc97avFokBM+gEiYA6c/dKm5CO4WUrwhJBo59S0eK021X8EfXrf/9Pb1uB53Flb/S+
 fzulJ8CuLQXUb9ZbtltoeDrZCPYU+rux0a0Z2ySX6URNCaNsnm8UENLKCc10HTOeboOtOIFhuNK
 7Kw==
X-Received: by 2002:a05:6000:156e:b0:385:e45b:92a2 with SMTP id
 ffacd0b85a97d-385e45b940emr2149777f8f.7.1732994389695; 
 Sat, 30 Nov 2024 11:19:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGgE8/TvNbFLKax47PaGOuIjh/ep85Q9weN5dMonwWzRD6KQqS5BW2DxsfFYVFyD5colE7ig==
X-Received: by 2002:a05:6000:156e:b0:385:e45b:92a2 with SMTP id
 ffacd0b85a97d-385e45b940emr2149764f8f.7.1732994389349; 
 Sat, 30 Nov 2024 11:19:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c727:a000:5482:8177:775a:49c4?
 (p200300cbc727a00054828177775a49c4.dip0.t-ipconnect.de.
 [2003:cb:c727:a000:5482:8177:775a:49c4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa781200sm124678205e9.25.2024.11.30.11.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Nov 2024 11:19:47 -0800 (PST)
Message-ID: <27aefc68-28bc-4411-8292-6ae346b6ca3b@redhat.com>
Date: Sat, 30 Nov 2024 20:19:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/virtio-mem: Prohibit unplugging when size <=
 requested_size
To: Wei Chen <weichenforschung@gmail.com>
Cc: zhi zhang <zzhangphd@gmail.com>, qemu-devel@nongnu.org, mst@redhat.com,
 yuval.yarom@rub.de, genkin@gatech.edu
References: <20241126080213.248-1-weichenforschung@gmail.com>
 <2ac194a7-9790-4aa7-bb41-65f8bb21f616@redhat.com>
 <f02565f6-c584-44d0-944f-26c062cc2be9@gmail.com>
 <553cf07a-a603-402d-8e86-b4ada42a2dcd@redhat.com>
 <93616a1e-3614-49ca-9515-697f1c9205b6@gmail.com>
 <9eafe8fa-de09-40e3-9687-573255ce37de@redhat.com>
 <CAD-9bcdm+gupZQ91Q-JMjuPikVmfVhCdJuwq=ptfaipL7Peevg@mail.gmail.com>
 <a140606e-5f86-4e8b-a818-2db2493ab8a6@redhat.com>
 <CALOevrNCBHRKYOKcBftssHPOtoY1HVy3xz4DFfYZ4_e99hLrHg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CALOevrNCBHRKYOKcBftssHPOtoY1HVy3xz4DFfYZ4_e99hLrHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

On 30.11.24 13:48, Wei Chen wrote:
>  > That doesn't explain the full story about MIGRATE_UNMOVABLE. I assume
>  > one precondition is missing in your explanation.
> 
> I have double-checked the source code. My initial description of the
> process seems somewhat imprecise. vIOMMU does not convert pages to
> UNMOVABLE during pinning, it is that pinning causes page faults, and the
> fault handler allocates UNMOVABLE pages. (vaddr_get_pfns() calls
> __gup_longterm_locked(), who then calls memalloc_pin_save(), and it
> implicitly removes the __GFP_MOVABLE flag.)

Ah, that makes sense! I forgot about memalloc_pin_save(), which we 
primarily added to avoid allocation+immediate migration during longterm 
pinning IIRC.

> 
> Therefore, there is no requirement of ZONE_MOVABLE and MIGRATE_CMA.

Indeed. On systems without that, one workaround would be driving 
virtio-mem in "prealloc" mode (prealloc=on in QEMU on the device), 
whereby we first preallocate the memory using MADV_POPULATW_WRITE, to 
then longterm pin it.

-- 
Cheers,

David / dhildenb


