Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FF1C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqexK-0007pL-7Q; Fri, 07 Mar 2025 16:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqexH-0007j7-Ca
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:10:03 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqexF-0007UL-Ku
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:10:03 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bd87f7c2eso13313455e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741381800; x=1741986600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yPUzrQmVgpMctDrSpFRSESnTaQkuvVdeXuRLeKa3WkA=;
 b=mSi3aPmP+Dmt55SEyKaNgEUoTkJUPxEr0ZXWcHDuEaMslShTOGKMgWl+Xf/lUw0u4O
 ZP6nzb6m7Wn1orTVLKKVlkrSGg+UgLfjO984VpBq/VeiNFf9VwImFrhPE7QLctvehqde
 G4ZwlcQebiKDfT/S6+N9vK8kfqxPjWVyWMlWorYFHYwM3bXlBkni9sCoX9EzwgYJaTRm
 RuAOaeS1TzY1GutVKybdsl7RFj2KvyDAiTXi45hlmwA9VFrypL3cAt6kQFDwePDk6AL2
 CRqh8FIi2XaC+k8wk7R1wpGnF8HfBpmLbdlTCJ7OGjW6im/FT6PD5c4mcR0HOSyrsSCg
 v+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741381800; x=1741986600;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yPUzrQmVgpMctDrSpFRSESnTaQkuvVdeXuRLeKa3WkA=;
 b=ZxUTUrr9UDx5WnoDYKgFTzJYkITX+YWPLeS2L5fIYs1UkqYxbKsNXFlxlxsTx+5On+
 hKpDENtsCs7CLCQYe4IqPvlbZUMGgTIJ0OOfAfT/PDEYdokVTHDJ5ae8cxdbdKVfZkyK
 fAqkX0aQI2IhCeHryA6O6ozYtpWHRorDU7o7+AUYS2NIP6gtfgpPajPVEo4465p9Xyop
 f7Od9t9s/Qk9Lf6GnL8zJoSlZW0kaEAW6FYDAI+jzTrX3J9qWqCDAsnVF50zDYOB143s
 UWxy8I6BuViH/NxCuK+pdgSm+2LFGwdO6VTga4UgLi+diRAx0jv+OPb290fX6oDhbJ6P
 Btyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaQm14gkXZ7gWjF4PJvFMOXtdvbsUbaWJCbZ629wmQaMIP1pL5NUlxD+g7V5unOKb2aMCdw2Po+P/C@nongnu.org
X-Gm-Message-State: AOJu0YwwGXW/nK28H/xE4myPg1Chs819xlrLWnHKEwjwoYRx9z9sD2Fp
 PqoODH7CExqOaSB8WfF0nqfslnVzeiiyp1KlEx1RMOhtEt5NdNvQy1GXTW2SbE7c+PgWM5jBbMr
 VESo=
X-Gm-Gg: ASbGncs2whnk394k7YGnKEr/nOl1or7BjGWiJt0Fni6m7/3Yc1VOeE5ICBOs/Rf85bk
 Q2Lv8GIIQtMKLIp/slsjZ94asSsWv0WWrLVY8YIJLUX2OV16Y7kNjSJvuqVKX7XwIu77zIviiWD
 ymTZJuiPLG8FGj1SF1448zOGy/PCGD/b7y1zf3H+bQ1qfTME/UFpmxXJhXGjydmzK5Fykg1O1CR
 kLFMJiQlrCvba+FENTjubSUH/CqjqSbAY7nKo1MHndu6a9obIKMyD450/yB8meXOdmk+eOZmTdX
 r0McQIVZ/wyk9wlO0diSKa8n9EpmTj7C+cyAeVUwN258C4iXo1bPccWQzdLbLo+NG8lVCmEa8Z7
 McxFpCWkHzWQI
X-Google-Smtp-Source: AGHT+IG+PudE/g48yen2/kOFXeVCb8pColtDBzVoT9pLv3xA3oWOis9a5NaYDzOOA/vrlwhwDNyn9w==
X-Received: by 2002:a5d:6c6d:0:b0:390:f641:d8bb with SMTP id
 ffacd0b85a97d-39132d98b62mr3015659f8f.36.1741381799690; 
 Fri, 07 Mar 2025 13:09:59 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd426c33asm96587205e9.3.2025.03.07.13.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:09:59 -0800 (PST)
Message-ID: <c3ef10ba-175e-4c62-8e49-9054dacca28d@linaro.org>
Date: Fri, 7 Mar 2025 22:09:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] hw/vfio/ccw: Check CONFIG_IOMMUFD at runtime using
 iommufd_builtin()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-14-philmd@linaro.org>
 <77ee5a00-05f7-4163-ab0c-d0cd3202c8d4@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <77ee5a00-05f7-4163-ab0c-d0cd3202c8d4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/3/25 21:45, Richard Henderson wrote:
> On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
>> Convert the compile time check on the CONFIG_IOMMUFD definition
>> by a runtime one by calling iommufd_builtin().
>>
>> Since the file doesn't use any target-specific knowledge anymore,
>> move it to system_ss[] to build it once.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/vfio/ccw.c       | 27 +++++++++++++--------------
>>   hw/vfio/meson.build |  2 +-
>>   2 files changed, 14 insertions(+), 15 deletions(-)
> 
> Again, separate the changes for iommufd_builtin and meson.
> This is an s390x specific device; it really can't be shared beyond.

I wouldn't be surprised if someone try to emulate a s390x+riscv
machine *and* use VFIO, human creativity is limitless!


