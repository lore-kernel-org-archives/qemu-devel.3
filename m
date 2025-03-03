Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36536C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp74V-0007Rt-HB; Mon, 03 Mar 2025 09:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tp74Q-0007Ov-6d
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:47:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tp74O-0005ZM-BV
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741013219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G+B17IuXkn6LuQRjFqIfgufnVO9B1tTYOKjg3o4OoK8=;
 b=KiW7sUedJ0i0m/m9PE4cLNfvJdFFoRFgbxXNbrdrdeZQsJ7LDAWYliFtSADR+RCFMjByXm
 aNQKordvXzMQE0JksdodBxN+ySfp9KkFV4xlcIUt4LMd3GR2ZhHUmCHILVhWbtnsqGHB7N
 nlKnSwhMZ7EbBiOG4bjFyoQC+Jo3RzA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-DRwEmJJSOX6FhDbIUDTcBg-1; Mon, 03 Mar 2025 09:46:57 -0500
X-MC-Unique: DRwEmJJSOX6FhDbIUDTcBg-1
X-Mimecast-MFC-AGG-ID: DRwEmJJSOX6FhDbIUDTcBg_1741013217
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-390de58dc4eso4237299f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:46:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741013215; x=1741618015;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G+B17IuXkn6LuQRjFqIfgufnVO9B1tTYOKjg3o4OoK8=;
 b=JLUZ+/9cQfeWQN7NBjnTk8RtvhyUW/1gknuZympneHfN/m3He90sOalHkxK/mHCkbN
 eYGKbDveaFKXLT00t4WuLet6133uj/Lv1tA6QtRRbPN0gJ5WlyMFdhGf5FBvmXEAIE4z
 KrNlnGnWZeBdzijUKad3eowItE9TjUgr9uR1H2ANydLRlBZjNftq5CjodLdwzdhgFxIF
 1UMIi2D4eyIqBhBCW/o10z1GPu7HU9bxYepcyLKF1X6hn663ZgcdbjLKrpNwUkFKi1DI
 hxPP0dJ8ospbQq7mbg3XlB5/CPKV8/raQq/VXxQ2HxDxl6ytEq3kNRZ9KygonGWW94nC
 Dbcg==
X-Gm-Message-State: AOJu0YwDdydqx65hSvyRVZuSBoWJoFFn3euC5I04FNhh6BeU7HWtUPjh
 FaUNSiWJxufzr8Ri2RYrgzsUnlcRzfcPJ/b0BYbhPKnkJbBYbCaWHojIROcwFmDhwyGeYtklCFz
 Ia3fzshzykuYvbMYBAfGHk3hNW6eC2SJy2xVtkUkcX5BL3/SR7UrERwMXXZ2xJRI=
X-Gm-Gg: ASbGnctQk5gq5sLZG8XC9Cn3l/uFHsus8u0gctsxffZ5hQzV8F+i909M83WpoYdAlG9
 n9tJs3yaxI8MxJZGpMBWvZyZUfaPa5/Og5Q/5FSGXal4nzeX2IDrvrcXyQI6oFdMIzXk1OJ4Vl8
 gXqnulW3nFnv4nFwl6n6HhdIONYj+Q0CjBePWFQLfEe78yH5n9Cza1aEkwGRVCnyr7hlNotI6+n
 1FgqbeOxoweADv4ovBqOj4+csrpOsh+pVihxeuzi4o6wjJONZ98w9ncVCD11jW5Pj0VhknxfXSU
 uup+q8RzEs27RtzGh9A=
X-Received: by 2002:a5d:6da2:0:b0:390:e9b5:d69c with SMTP id
 ffacd0b85a97d-390ec9bbba2mr14993399f8f.25.1741013215179; 
 Mon, 03 Mar 2025 06:46:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjNoWvDH3yDS4tVLAlEkG5ZRRmi9nQoybhiDVCzZQ/rG6JD4u/v9sjJ1mBbQondZtWKuINmA==
X-Received: by 2002:a5d:6d09:0:b0:391:4f9:a048 with SMTP id
 ffacd0b85a97d-39104f9a5d5mr3941285f8f.4.1741013204194; 
 Mon, 03 Mar 2025 06:46:44 -0800 (PST)
Received: from [192.168.10.48] ([151.95.119.44])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-390e485dbe7sm14813858f8f.93.2025.03.03.06.46.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 06:46:42 -0800 (PST)
Message-ID: <270cc189-e3b2-4bf4-b32b-8655be51bcb4@redhat.com>
Date: Mon, 3 Mar 2025 15:46:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host
 platforms only
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
 <bb7c2adf-f146-50c7-7716-c1ee7b606b01@eik.bme.hu>
 <aa01f3dd-e3ac-4ee5-87b4-8133103bd000@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aa01f3dd-e3ac-4ee5-87b4-8133103bd000@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On 3/3/25 15:30, Philippe Mathieu-Daudé wrote:
>>>> I see PPC is defined in target/ppc/Kconfig so I think these mark the 
>>>> target not the host. Vfio-pci works with qemu-system-ppc 
>>
>> I've seen people do this on x86_64 host
> 
> Since this patch does:
> 
>    LINUX && PCI && (...  X86_64 ...)
> 
> these users won't see any change.

This is wrong---clearly this patch was never tested on the 32-bit 
platforms where it was supposed to have an effect.

For VFIO_PLATFORM, no objections to deprecating this.

Paolo


