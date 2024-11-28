Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6376CD66BA0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 05:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGXVy-0005uT-Ot; Thu, 28 Nov 2024 00:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGXVw-0005u0-BD
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 00:56:32 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGXVu-0007SQ-Q6
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 00:56:32 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-382588b7a5cso346577f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 21:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732773389; x=1733378189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H3BXALnEdBpezR5ooHd3A8l+sflJjR5GewzPJet6mbw=;
 b=Zpu/2OVO+GtCL+IeeEq9Vwwy6HPlDTUsr11qcQVCtCzJXzMZNqNlFphmaSfuxM6Yun
 dBIw18XX6hz3q0jeLykfrtCJaeS5Pc+u8e28SMut4FtX3eacyKQn2dUtBvOX8ErbVMIl
 h0ClxVy1eREAA6Xd0W0Ub/SZ1pEaBjCW4cULkxWwROGWPl83sDK/RxixMroHYeZ3F3BQ
 mLHY7NV4J+bzk4kiH6AU7l/8/FGTHZlUAtgH5K21b3DzhvbR4WbQZFk2PX+WN4ca+Y9d
 lomn+n15D2g+DbhZxXD/vrqYtza/l0jU9QVYWPLgkpa2S5YX36wNolmC4PlNFknqtigx
 d94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732773389; x=1733378189;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H3BXALnEdBpezR5ooHd3A8l+sflJjR5GewzPJet6mbw=;
 b=MfwJ9hKDyg/Jsr0Kp2qkDz6H5NegCdJfA9yeYgVTdx5rSpdBGHCjbAMYvCDWgqZije
 WFD4X2v+TzAG2VTcEliTrat4641DYRYo40jnVmlPiuODVqH1qn5ANM6holvrCFHzrKkF
 9e7EVOIwVSkNQE8wmwdBf7RJ0pPjkJCQ4WD/UEf0fcgrVwVsxBIjZF+TQInOy0EDg1ad
 bGj9ZIQCUQeB/RzPc/78AJTOVxUauVv+cNuQbYQHpq3GwAJve94KxpdEqUVv+B7hZla+
 vwc/70bOlqdl5LEvSRzttjNU26BYppudabPH6UvwBq3/LUq+Xup51oALRblmIgI22rJY
 SCWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW++/h3Xkt9AoHaohtiTeHUxE75SV7qsT5IVWjxPQNvo3qO447ynaRAmVHx2U7w8RPdQLC+QOshhws5@nongnu.org
X-Gm-Message-State: AOJu0YwfLjAha0XB0R8zCiZsecbmFJHWTqg6ihe6+a1H7ptHumHoIUkJ
 qhJ6fcYtPdjZgHbJar7VxaOx1Y12GsixRGdQGuVZpqZy6bBtg20mcQB3DYcFjeY=
X-Gm-Gg: ASbGncsxkP+0JCWZmESTWSY2x/Vd8v/u4jXg4IwC7YcjwbrqIaZecLjbMM+4J6znrYF
 n9eQnpLVl2Qg2kQ1r2vJfUQlgRBdxSRi/xZ3a7jS7pdCU3SlbDPbZU1b+w1jwVX//XLZ0IQXT81
 q8C4zn8p+jh/pa/fuAegq2Hs3W/X+HZwMt1rZ3JSVNWg2YP8ggtV2J2YzobNRHoTJTzHIbxB6K+
 pL0rQNAMjSMwf61S3PpDZHIx9G2tNtgIvi9mqFdtimpGcqHklAGOZ5IFk8MItbU+0cL60z7u20x
 8kehatN4Swjyp+0P5jib/F3nvjEZ7r4yJwIINSY=
X-Google-Smtp-Source: AGHT+IH8AEK7Fbdq33p5HzSbY3POvsuwE4ChHEwOB7owyKVXuyDFVYU5+Dpm6GJLgy+nCVetLtM/rg==
X-Received: by 2002:a5d:5888:0:b0:382:4378:4652 with SMTP id
 ffacd0b85a97d-385c6edd47bmr4206674f8f.45.1732773388638; 
 Wed, 27 Nov 2024 21:56:28 -0800 (PST)
Received: from [192.168.69.146] (vil69-h02-176-184-48-210.dsl.sta.abo.bbox.fr.
 [176.184.48.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm690059f8f.67.2024.11.27.21.56.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 21:56:28 -0800 (PST)
Message-ID: <82f7fc8e-d0b3-4d2d-af70-b724955de19a@linaro.org>
Date: Thu, 28 Nov 2024 06:56:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0] system/qtest: Access memory using
 cpu_physical_memory_rw() API
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20241127191914.34146-1-philmd@linaro.org>
 <6f265a48-eaa3-4e2d-b6d2-26e4935693ba@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6f265a48-eaa3-4e2d-b6d2-26e4935693ba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 27/11/24 23:35, Richard Henderson wrote:
> On 11/27/24 13:19, Philippe Mathieu-Daudé wrote:
>> There is no vCPU within the QTest accelerator (well, they
>> are stubs doing nothing, see dummy_cpu_thread_fn).
>> Directly use the cpu_physical_memory_rw() API -- which
>> amusingly prefixed 'cpu_' does not use vCPU -- to access
>> memory. This reduces accesses to the global 'first_cpu'.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   system/qtest.c | 42 ++++++++++++++----------------------------
>>   1 file changed, 14 insertions(+), 28 deletions(-)
>>
>> diff --git a/system/qtest.c b/system/qtest.c
>> index 12703a20455..a2de9a7d5a4 100644
>> --- a/system/qtest.c
>> +++ b/system/qtest.c
>> @@ -18,6 +18,7 @@
>>   #include "chardev/char-fe.h"
>>   #include "exec/ioport.h"
>>   #include "exec/memory.h"
>> +#include "exec/cpu-common.h"
>>   #include "exec/tswap.h"
>>   #include "hw/qdev-core.h"
>>   #include "hw/irq.h"
>> @@ -514,23 +515,19 @@ static void qtest_process_command(CharBackend 
>> *chr, gchar **words)
>>           if (words[0][5] == 'b') {
>>               uint8_t data = value;
>> -            address_space_write(first_cpu->as, addr, 
>> MEMTXATTRS_UNSPECIFIED,
>> -                                &data, 1);
>> +            cpu_physical_memory_write(addr, &data, 1);
> 
> This just calls address_space_write with &address_space_memory.
> I assume we'll get rid of address_space_memory too, at some point.

Certainly, but one thing at a time ;) For the first prototype
I'm focusing on being able to instantiate vCPUs from different
target architecture in "any machine we have now" (even if it
doesn't make much sense). I'll then move to HW modelling, likely
starting by vCPU Clusters and then address spaces.

> But I suppose that's good enough for qtest for now.

Little win: less first_cpu accesses. What really bother me in
this file are the endianness mentions (and tswap calls).

> 
> r~
> 


