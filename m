Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05389CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 15:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0iHH-0003WN-Ms; Mon, 22 Sep 2025 11:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0iHC-0003Sr-0w
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:16:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0iH7-0007Vr-Mm
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758554179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7jt6/Lw18XsV6fxTQmj/ZWLW2X3qjUANRxI5WbDF2IQ=;
 b=PkGEIy9atxPNl7c9cj9QxECneJfJupwC81UYt7wqR3S7//kLLNHrIo2w0LB9a+pp+PII8f
 dUBk0ByCwSFC6Ji42KcUZu5XMsGIZ3phudtztQ78IHWs5iqQGilrpwhmL3og0hewfd5Nm0
 rdnFRYA2ZLJtdBElZQZO5xINB8a3imI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-nWDgr0lSNGSmsmL8nbBkIg-1; Mon, 22 Sep 2025 11:16:17 -0400
X-MC-Unique: nWDgr0lSNGSmsmL8nbBkIg-1
X-Mimecast-MFC-AGG-ID: nWDgr0lSNGSmsmL8nbBkIg_1758554176
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46c84b3b27bso10670975e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 08:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758554176; x=1759158976;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7jt6/Lw18XsV6fxTQmj/ZWLW2X3qjUANRxI5WbDF2IQ=;
 b=EMqtu1GadpjhN9PAtWSNbV4EGadJ/7yei3exHniFwzbXV/1VVkob24s13PtJy6faxH
 9DRg/pQzQpCoWhr8OgXzU0z49+546hxB4IeyRYEDXZzv20ef+GRE7tgXzj1d9E6jMrQu
 asl5ZBOj34iKV4F8woSR+ThrN9699RRsfM7TxQYubNoul8HMn0dPMxJwDIEGpO2Qp+vu
 f6+d0lXuQLXhj49jWM30G+eCgO8g0Ieb7VI21NZTKQqbimAi2tgPSzH++h2FPJlTxpIt
 kuzjeLsQlW7q6hh1RVBGHQhqUOIdpa/OBPIJerSo57SA5CGxbpBrfox6r7Ik7mflYHd7
 60OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0B3Iqze/IgWMmprp7kZolgHnPJaGX4K7oaWuvYm8WOHHcc6dAN3skqiZLWe6GmExkZ2ehGHVs3D+C@nongnu.org
X-Gm-Message-State: AOJu0YyEo/LgjYJ3kH3dYRu3oMzeb4QgBseOyx5Al7eVLLfzzMez4c7f
 8nJmKZnbtniZFbDMmAseWIuCXlnOxKtmix7SK6uCYGzcUKnNIMCfv5HHNODCC9BtJWrsqDk7RbP
 D8FoZDLGbxD5zp886TA+eZvW0DqXbjTVaXKt/6cGK+UNCCEwDPbqTrnaC
X-Gm-Gg: ASbGnctjrjwgcmTSLR+PRd8oyswLtmHcG3JzIe3LKlgnSokhT8awSaLINEaMVIaaCTx
 QkYZ4Fj+rj1y32Zp1rPFmIQqP7wWaRectWyDhcK9sln7V0+nkujWsU+848hfSgzRD3ZagU5VF3z
 jyr8ZKi7zmHP+kvCK7q5OcCa2TjoWsW3rcCe+l0qPmQ6WRfRnl+CvKjAX/1Vq+U8Y7fLQ1LibsK
 h+wZ5/jUgwgufMpxkN8XPT8W662il142wZFLEVlvwwgz/QfQYPX4dsW79iEqj7lFUWgvmIoliUA
 84YUzk19a2tzlYZ1TBJ/341udfscQbP53GuXQBUE/g023TWJJVWKpMae6CE8bBjAIac9ci5dHOh
 lfUFJIuGG6bJ4mn4AtaixqDvKnl2/lBN3yO0StDhFfhQ=
X-Received: by 2002:a05:600c:450a:b0:450:d37d:7c with SMTP id
 5b1f17b1804b1-467f205a5acmr102801365e9.21.1758554175980; 
 Mon, 22 Sep 2025 08:16:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYKLKs8lHccjmwlfp1O1WzT2qIBgvqWlj6khK1+UMv56r0P8cbXNelrX9P/wmd6oJHCB6oUw==
X-Received: by 2002:a05:600c:450a:b0:450:d37d:7c with SMTP id
 5b1f17b1804b1-467f205a5acmr102801165e9.21.1758554175530; 
 Mon, 22 Sep 2025 08:16:15 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.47.123])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4613dccb5e2sm244592305e9.17.2025.09.22.08.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 08:16:14 -0700 (PDT)
Message-ID: <3c72ec87-9e95-4887-8432-b88f26d29510@redhat.com>
Date: Mon, 22 Sep 2025 17:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 54/61] i386/cpu: Enable SMM cpu address space under KVM
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Kirill Martynov <stdcalllevi@yandex-team.ru>, Zhao Liu
 <zhao1.liu@intel.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20250913080943.11710-1-pbonzini@redhat.com>
 <20250913080943.11710-55-pbonzini@redhat.com>
 <d871768c-ebf3-4b63-be81-ed1418373e92@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <d871768c-ebf3-4b63-be81-ed1418373e92@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/18/25 18:24, Michael Tokarev wrote:
> On 13.09.2025 11:09, Paolo Bonzini wrote:
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>> Kirill Martynov reported assertation in cpu_asidx_from_attrs() being hit
>> when x86_cpu_dump_state() is called to dump the CPU state[*]. It happens
>> when the CPU is in SMM and KVM emulation failure due to misbehaving
>> guest.
>>
>> The root cause is that QEMU i386 never enables the SMM address space for
>> cpu since KVM SMM support has been added.
>>
>> Enable the SMM cpu address space under KVM when the SMM is enabled for
>> the x86machine.
>>
>> [*] https://lore.kernel.org/qemu-devel/20250523154431.506993-1- 
>> stdcalllevi@yandex-team.ru/
> 
> Hi!
> 
> Should this one be fixed for stable qemu releases too?

Yes, good idea.

> Also, what are the possible implications for migration
> of guests between qemu versions with and without this change?

No, this only affects code paths in which you would crash before.

Paolo


