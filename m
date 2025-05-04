Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CA8C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 07:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBTea-0006VH-HK; Sun, 04 May 2025 03:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBTeN-0006TQ-Ln
 for qemu-devel@nongnu.org; Sun, 04 May 2025 03:20:36 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBTeL-0000YX-DT
 for qemu-devel@nongnu.org; Sun, 04 May 2025 03:20:35 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b0b2d1f2845so2408344a12.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 00:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746343231; x=1746948031;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=klhim48JAtRn+YzgbF8ISmg1WnEvPFtNfMRMCjm6AqI=;
 b=Drz/6cDw8ADA082igFZTzxObPeVA4tO6pmO/YX+Pzw5Pmlypmvtq+EM3MImZuF9BOw
 xs8cpPhw886EHT2u+G97+M39JkEwqIf42+oeWSz4obm10yskGe2bugdz9USEBgSq+1px
 AHpJmd1hT6SX0AxfbIn5acH4+JBNyE8H9/5fvKoTsJ/v4lWDSeaAnBOut7zRU9eFcJrI
 4WqKTiCqriMBRgEFJxo1hoXFNivrMTAu9FZNDQwO+cLuvH5sJtAeq2xcx1S4bNWMIYEM
 A2gd7ophgQfpPgeOhOD4XLnhIl+sjo96zrq3RYlnb8tW4Jj/bA8orgMwy4/Mq9Gl0kGc
 PVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746343231; x=1746948031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=klhim48JAtRn+YzgbF8ISmg1WnEvPFtNfMRMCjm6AqI=;
 b=GIgCy6cE/n2tSQfDZK5VXdmPqE9EptkZ7EvqXkiKgi+TslC3Eduqb0X23isgPN63o7
 I4KjxUErVlamhxrEtwDcoFV3xhpVzM9aiMIuMCt2C44Z3770BqDEgWtBqERWdz6Yqp72
 Z8cK3YhIJi/WCXOu4M3mOWf1kF9EglJV2Ysw74ywH5T2Tl+CkcwGVkuRa40MqXTEUVFh
 pSOsiKGTa+pnjRPTcV8ilKopQeZLQC+XkwEsvEHLSC19Qk7I40U0fECX6OEqyooHsi5+
 kPGRm3g4rD6e8HQxoLkbzc2CzHQNEeKMqfvkSdplA7kpI8vNHQVUQEijO7TtF2zAM+jG
 mbwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZWNDxwxVeez0wNnZHHjZpFuLCgUnNI7waZeyQpYVVALvrdx3j/BliguF0xdR8UwjDexpj3M09XkhP@nongnu.org
X-Gm-Message-State: AOJu0YzSRjPE+mS6ouGTbU3k2MJdhrg8svV59JL0+4laa8JkdsY6eKBn
 haLv9YXVYhublKIpfwLNwPG/q3n/hCe0LdZLIdIXRFeIx14cVf5YHrWTMLWhkNo=
X-Gm-Gg: ASbGncujDqVjz3gzNpLFU/AZ8DmFJK5e4fvqAVVXkNNAFT++L5OkkXe7SowgADQGBIF
 PywUlGc3ByBMEzHdJR8Ywymzv65+zSu2ofcwZnBq0/w00CzKHtFqzHhAr+zy6ASJY11rl7o3Zir
 x+090ZtPIRwJIFZmIw0b/vFDjF2x7A4DjQszDQuI8K//u7COLHfbuhKEfgKTt3pQSUvBwtLfRXz
 Ml1RfGssfRMocsgD2QWVBhaLrdhBS1K8ySobhuFpRqeAze7tMBEsvnkNySo7FsPMrbYvG13QgWc
 lXaise0+SwcmfiUHNQY2bmHxl0/l2Ogi67MUTeBoT6vVexM2uP526g==
X-Google-Smtp-Source: AGHT+IEvnN5gmBvK/h7zKWBCj1UzCVE+Vcgk2ChyTHmZn6CSFOJVGZtqauCU3yDlscfs2CG6QBwvPA==
X-Received: by 2002:a05:6a21:900e:b0:1f5:6a1a:329b with SMTP id
 adf61e73a8af0-20cdfee9a76mr15210766637.32.1746343231532; 
 Sun, 04 May 2025 00:20:31 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590a489asm4542774b3a.170.2025.05.04.00.20.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 00:20:31 -0700 (PDT)
Message-ID: <cdc4d710-2b7a-44fc-b58c-78a81ca83b36@daynix.com>
Date: Sun, 4 May 2025 16:20:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] MAINTAINERS: add myself to virtio-gpu for Odd Fixes
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250428125918.449346-1-alex.bennee@linaro.org>
 <20250428125918.449346-7-alex.bennee@linaro.org>
 <9115fa7c-ed94-449d-816b-a13125275dac@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <9115fa7c-ed94-449d-816b-a13125275dac@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/04/30 3:56, Dmitry Osipenko wrote:
> On 4/28/25 15:59, Alex BennÃ©e wrote:
>> Seeing as I've taken a few patches to here now I might as well put
>> myself forward to maintain virtio-gpu. I've marked it as Odd Fixes as
>> it's not my core focus. If someone with more GPU experience comes
>> forward we can always update again.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   MAINTAINERS | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 661a47db5a..f67c8edcf6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2636,7 +2636,8 @@ F: hw/display/ramfb*.c
>>   F: include/hw/display/ramfb.h
>>   
>>   virtio-gpu
>> -S: Orphan
>> +M: Alex Bennée <alex.bennee@linaro.org>
>> +M: Odd Fixes
>>   F: hw/display/virtio-gpu*
>>   F: hw/display/virtio-vga.*
>>   F: include/hw/virtio/virtio-gpu.h
> 
> Thanks a lot for stepping up!
> 
> This reminded me that I wanted to propose myself as reviewer for the
> virtio-gpu patches. Will do it soon.

Thank both of you for stepping up.

> 
> Akihiko Odaki is also good at reviewing virtio-gpu patches. Wondering if
> Akihiko would want to be added as reviewer or co-maintainer of virtio-gpu?
> 

Yes, please add me as a reviewer.

I guess it would be better if Alex add you and me with the next version 
of this patch or add follow-up patches to this to avoid change conflicts.

