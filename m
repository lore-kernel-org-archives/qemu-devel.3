Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD63D24450
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 17:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRDPc-0005iz-KU; Thu, 04 Dec 2025 12:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vRDPW-0005iI-Tt
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 12:46:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vRDPU-0000is-Sy
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 12:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764870392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6qCohf1FHCJOT7TF1rKQltt3q9X3gI+PxYQcThK9+7o=;
 b=YN3XFrZaFsVDxrO3CGR2Gub8anZc+oIvKM4ZTTG9iZE+al9E4rnzhRIFs6cUjVZtpZjtBm
 fTz1XwPpPrq7UwJMTRV+/Kc626mknrrm0mSY6zZe1uJNXQIabj/rPqdUnoynl3nXuKh21+
 +2TKLd0tyLZlTCmzabWJ4lyF8sXWA74=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-7TqzRyr_OeKZ_8AAQDPUGw-1; Thu, 04 Dec 2025 12:46:31 -0500
X-MC-Unique: 7TqzRyr_OeKZ_8AAQDPUGw-1
X-Mimecast-MFC-AGG-ID: 7TqzRyr_OeKZ_8AAQDPUGw_1764870390
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779edba8f3so7862155e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 09:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764870390; x=1765475190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6qCohf1FHCJOT7TF1rKQltt3q9X3gI+PxYQcThK9+7o=;
 b=XpL6oEn9PYk9uj/s4xBJq4WT0Z6QP/3xeKR8SUnrN+8VNYjZYC3G0MFJciIOE0rTet
 Ept+PpWsyD25aFCj4yigXEEK3vrQwzd8tq940SFcVlacVdbJ5j2Euis9CAHAZ6JQ5aOt
 889A5jmjQHmMKf5pD6wdJCjBJ8Sk8VjJEKUkYnm3ZDcqpXUHz0Vo7pGVyMxKeux+Y0yC
 9Ue7oZj3O25b1hNlYJklLDmB3U+QHbHleoXmLg0YbNHIfesU65q8xxJBEU5Y/WfxwDkP
 mHoAUTrOi7jVByga5RIRVudsoySHlaglhBxqQQGzQ8aGWMcewB0l3PtL5Q3JYcHOmqx5
 OnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764870390; x=1765475190;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qCohf1FHCJOT7TF1rKQltt3q9X3gI+PxYQcThK9+7o=;
 b=UWJ4/4VvCLtl8gzAat3UM1x3qQXrISv0LlX7VQPzr7Jw1yVeQYhfG5FnevKB/oCcgw
 B8hIrVMTdksdcwD81sk1iBtDheO2/kDiAETo4VC607ZuxO/hAKneCphuSUmVkBphc0hF
 Xt2A5u+qFKb0oGvcR1aALNFWjuaTPY/q4t8bxUqUGY4DqVfJMosl7OwmYr6hx8mZURJl
 sH5JCrP/liQ4Cx0Yg9Doxgso6lFjQQRarAEMCh6Ov+G74gN59U1pJpl6Jo35PHIX3VLM
 wfwKxGuIgut+wCJvOYkceHxQler/n5DvRY+0v/X45ljGPABbXj32OJZ6ttwK7e4+fZ9e
 +UFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/PKgY2q+s+FPMBX7T3MFdaVTBnafIHqiT3ECIH0paqg/bdHSXYcpukDJ3Rb3C+G0JGpK/rSwCr/kL@nongnu.org
X-Gm-Message-State: AOJu0Yy6Pmk3guoIlInquV6rVSmVL1/vF9SQmJhmfL8sK/tG5HH2IMWD
 01h3VQC5ltrkR7fWyRjdCcL0gkBzbe1ykBXWutqbQsxzy1Io8opkVz3dDmpa11s9orfBqotZV3r
 p9Jrcke8pJRILJyC2Ubv1RGv5469gAlv8kcsvwoflIm3Fd5oWq67GeKDr
X-Gm-Gg: ASbGncsrzGY155z/MCSTK7Qoc7CbK540srCYb9PBv0JaRdsZ8syNvqBmttOgKQ8B3iq
 hDnyJd5Hog60L6X2/y2DioW/XoagQjHK0rGmtX0OJqlrsTwSWmRCRQDN65pr9rKNvMeNfteIw9/
 +eXjz0iqCLqexP/a0gz//jf1YoTzTqljLEKsMS47kP5HLJUMvCJpE/NkzGgoiCUDM81Y+pq1MT4
 r8EZGQvArd8Lb8ZJs0p3phuJwixwp23KGj5ZMl3HFDK+UIreBL1I7uOyxM3PDYI2KUKXEKQrJJN
 g5cLsmJosJvN0q+Hcb07u86Tni4VFys6OQrGbEajFF6lhD13e8GfqzE46+BzofhyldLYWtwLmZ8
 IixpZZ22RCEk+JKK75ANHHTlt78P0tQyX6r9d0MoV1Lhzt9EnfRDeSY4GwaSoAf6dVW2g11M4YE
 RZlwrAitiWnNk=
X-Received: by 2002:a05:600c:45cf:b0:477:a1a2:d829 with SMTP id
 5b1f17b1804b1-4792aef361dmr62442705e9.13.1764870389799; 
 Thu, 04 Dec 2025 09:46:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgP6TGyZ08z0jfmF8M+L7+tH+lRmHMvuwbl4p7VtLrs3awYGmqXtrsitf+68Gfu44XZ1abSw==
X-Received: by 2002:a05:600c:45cf:b0:477:a1a2:d829 with SMTP id
 5b1f17b1804b1-4792aef361dmr62442565e9.13.1764870389434; 
 Thu, 04 Dec 2025 09:46:29 -0800 (PST)
Received: from [192.168.1.84] ([93.56.161.42])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4792afd3b31sm62983695e9.0.2025.12.04.09.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 09:46:28 -0800 (PST)
Message-ID: <bce5cda9-ff60-4e1f-bad8-862063831123@redhat.com>
Date: Thu, 4 Dec 2025 18:46:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] block: reduce files included by block/aio.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.omc
References: <20251203185133.2458207-1-pbonzini@redhat.com>
 <20251203185133.2458207-4-pbonzini@redhat.com>
 <bbbf42c5-98c6-4f24-929b-7bbb2853f5c9@linaro.org>
 <19f01d31-01f5-458e-873b-4859e2f8b3d9@redhat.com>
 <38f73101-4f2d-4e62-8ea3-fc42cc90e8f3@linaro.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <38f73101-4f2d-4e62-8ea3-fc42cc90e8f3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/4/25 18:03, Philippe Mathieu-Daudé wrote:
>>>>   QEMUBH *aio_bh_new_full(AioContext *ctx, QEMUBHFunc *cb, void 
>>>> *opaque,
>>>> -                        const char *name, MemReentrancyGuard 
>>>> *reentrancy_guard);
>>>> +                        const char *name, struct MemReentrancyGuard 
>>>> *reentrancy_guard);
>>>
>>> I suppose these changes were before you move the declarations to their
>>> own "qemu/mem-reentrancy.h" header?
>>
>> Yes, but also qemu/mem-reentrancy.h is not included here.
> 
> We want to also include it instead, right? (No need to forward declare)

Why?  The struct is opaque, and as a general principle avoiding 
header-from-header inclusions reduces compile times.

Paolo


