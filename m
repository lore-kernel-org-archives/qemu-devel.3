Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF92E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 17:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTlOl-0006if-Ml; Fri, 03 Jan 2025 12:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlOh-0006hd-4X
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:23:43 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlOc-0001UG-Ve
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:23:42 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43618283dedso123824395e9.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 09:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735925015; x=1736529815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k3jWifUuqeP1feEf9SFINLpqfhPOd4o6l2XX2flqvIk=;
 b=nudlXNCBeVK/4Rpf89YJnX9vjVsWb8XwHQwd1CqYVYxXN4OX+qyTrf941bB4IonqYx
 CsDzV+d1Poh2OtASuWjplC5P8kahAgG5e+IrlXiYWGg3fUgLD6lgocDjo4H9seOQObYB
 OAuQDDD2+KzdAWJPnUQVF58xMc0NrGth6oQ3ZhzSzM65odzRxDh4Ut8z/6m3Pivtkwud
 +zrr5Fys2ygoIbxXyAhxBK1VakhtaFCPZ0TbSfjt8PUSvynJ1zrqKadNtqCQQBWuZHGh
 KQaem0rqyLP6MfzATyVIAOeagBwRYBuQTLkDu6POswMD6Rs6Pt4qD2T7g2Pjq30KxZ7i
 7qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735925015; x=1736529815;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k3jWifUuqeP1feEf9SFINLpqfhPOd4o6l2XX2flqvIk=;
 b=s9G+zgedGA03mJum6cRt3fuS6bS5noQ/kRnQC7gq+frUtn48mYwQvL8c5e8ofgyXPh
 llDLLlh4tnXPWVd+h8HEhnRpuDKjse6KoBQhvr6HWsMHkjKOZzV1aWz5g0oW6venH+bn
 XWI2MGMz+98H4Vo4IHb1jCwQoC7AurlCuhlbpA7AqFCdYDW794PgyMPjzNZhbFZkfQko
 4E5H4Co5LTQZv97ifPeOllAhb2l/s7rKhZU+J6qZ4G8eyOMQGljJT3oQQ76f8eGSBEVs
 vlQUJCoOYOYEAkQ6iojd1DdTJS1gejdHCSVGwhxjNFWXRWw7TOvFyFKzH8ZNiebVQrjz
 mahg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLOjMDbr4r/HCdEoqCqdC2BCBSFm0ufLcXrAujdfHFRI9g9jmNhGlZNAs6vAYZQfFGWKREbMiM8x9V@nongnu.org
X-Gm-Message-State: AOJu0Yw8Crk4/TQWg0aKXMJcL+raXCEgorGVLcCYUKefGBX/2S2lT1/d
 WYCxwZ77zeFRT8C70NZCKZ7F7GjLX58uBSUnf5G8X6qWDl2IHbyEA4KoyFGBYjA=
X-Gm-Gg: ASbGncvvTH5ZVxgyvuaUVMcbYjdr1A8v9QECxQkFMoiCNaneymW8TJTrHdmlfZiqIMb
 S0qRUO2V6M+UVS79Y8bsEiHX5QAmFl8gOEyOu0tbB0deGPwlsL12kVsj+M0lhGCzHEELxz5Y80j
 e3tcQ1xe6ldYIErqmWk7N7KwzdXDfprL1niEiJCXloQlsPE9/cXxi7pGq6+X2QoIzwkaahCTXI/
 j+9QtK+aSJH7V6fW83A3wZdc+Pc5KZrrS4RYUeFk4U1T01ZRMgcCI9pIb/LREtWCdf1XxDr+/Bt
 aphIRPNQDzuyTiCVdJAvByK1
X-Google-Smtp-Source: AGHT+IGJvVt7VDI7jaemSYiP89o3oIeiiuI6FLH5oN8k1VVONF02cTBT6FXXfBsRyt8VdJLeXFl23A==
X-Received: by 2002:a05:6000:460b:b0:386:4a24:1916 with SMTP id
 ffacd0b85a97d-38a22408c69mr44788837f8f.55.1735925015522; 
 Fri, 03 Jan 2025 09:23:35 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e1c0sm41838441f8f.77.2025.01.03.09.23.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 09:23:35 -0800 (PST)
Message-ID: <c9b250a1-64dc-4735-a503-b965d9011958@linaro.org>
Date: Fri, 3 Jan 2025 18:23:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/s390x: Declare loadparm as char[LOADPARM_LEN]
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>
References: <20241120085300.49866-1-philmd@linaro.org>
 <20241120085300.49866-2-philmd@linaro.org>
 <d005f227-cf46-4a62-a152-668030ad7e49@linaro.org>
 <d4d352bf-35f9-413b-a495-8eb8db7da3f2@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d4d352bf-35f9-413b-a495-8eb8db7da3f2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 3/1/25 18:17, Thomas Huth wrote:
> On 30/12/2024 18.02, Philippe Mathieu-Daudé wrote:
>> ping for this single cleanup patch?
>>
>> On 20/11/24 09:52, Philippe Mathieu-Daudé wrote:
>>> "hw/s390x/ipl/qipl.h" defines loadparm[] length as LOADPARM_LEN,
>>> use that instead of the magic '8' value. Use a char type for
>>> char buffer.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/s390x/ccw-device.h               | 5 +++--
>>>   hw/s390x/ipl.h                      | 2 +-
>>>   include/hw/qdev-properties-system.h | 2 +-
>>>   include/hw/s390x/s390-virtio-ccw.h  | 3 ++-
>>>   hw/core/qdev-properties-system.c    | 8 +++++---
>>>   hw/s390x/ipl.c                      | 6 +++---
>>>   hw/scsi/scsi-disk.c                 | 2 +-
>>>   7 files changed, 16 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
>>> index 4439feb140..94a9b35714 100644
>>> --- a/hw/s390x/ccw-device.h
>>> +++ b/hw/s390x/ccw-device.h
>>> @@ -15,6 +15,7 @@
>>>   #include "hw/qdev-core.h"
>>>   #include "hw/s390x/css.h"
>>>   #include "hw/s390x/css-bridge.h"
>>> +#include "hw/s390x/ipl/qipl.h"
>>>   struct CcwDevice {
>>>       DeviceState parent_obj;
>>> @@ -27,7 +28,7 @@ struct CcwDevice {
>>>       /* The actual busid of the virtual subchannel. */
>>>       CssDevId subch_id;
>>>       /* If set, use this loadparm value when device is boot target */
>>> -    uint8_t loadparm[8];
>>> +    char loadparm[LOADPARM_LEN];
> 
> I'm not sure whether changing the type is such a good idea ... some 
> spots that handle loadparm include EBCDIC encoding, and the unsigned 
> type might have been used here for a reason? I'd better keep uint8_t 
> unless you've double-checked all combinations...

OK, no problem, thanks for checking!

Regards,

Phil.

