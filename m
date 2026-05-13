Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EF1CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 06:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2eC-00023z-AF; Wed, 13 May 2026 02:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2du-0001xh-T3
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:00:28 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2dr-0008Rn-DH
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:00:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso58168765e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 23:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778652021; x=1779256821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ns6MCtODmXZSYd8YBAUpxgBlpH5HhJGBU0DEIuO4yz0=;
 b=TShUU8L3lNZfgUoUEp1y74+j+fkxT1NaDC5dl0VCxmAG+PW/kpJHPjrA7GkEfs37n5
 9V5BcGBNT9hq6wvKyljXLNI4ZCpjJ1uiPCTurusg6Zbjhti88XWHR0iZpQK14Qgldovl
 b5G7/e0T76IZdKtnAHin1JRXZg3AwVYsXB7RlvgV8c5v9xayue6popNblxSi3BPFipNq
 5pOTU7Z3VyH4UG9ubjwpFfrg91EFv9XQ0mG/hKlHoV5zm5cVUN3mOIyMTGyemAiHjpwk
 TKMZ4a3jN//KhalR4ivltIjbdfKePODcibTja1ilcOZFak2dk0E0C9UUl9HckE4O+Pfg
 1YJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778652021; x=1779256821;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ns6MCtODmXZSYd8YBAUpxgBlpH5HhJGBU0DEIuO4yz0=;
 b=F7fsVW6GvQyyqTB7vxPZKmadX3F4ROX6a3Ncxa0XEfihH611RklTmp6DJ9bFtnsRn2
 UbXuel7bWDfQWm60RM7vPikzp3G6JpaaR7V7nqOk5VzvNqbKUZjEkoL7yoFtmtW+VDoW
 PHU6I8UkMYriexLgr43o1wZSwySVsnoDikdJtYb4g86kVlCV4vIo9qWp1ZIx0UEubsAq
 1W46QHRNlWSGKV1l2ik19+1i63wgwfPPTmVyx+IxdDDA7cfiVRqDML9lAwSkVvI4iKsz
 Ac3h9p6brPDTEwunc0v6OTmZ3Y144Np1tBc3VcYS6v73F5GMPBwYxF51J5kqgpIQH4a9
 TaFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jJOzV2pxmNvdrtHCj6oDhf8AhNOAG8iiuo/0RZwTii+p9HCsInR2Dw4ZCWvvbSUJMuM2NEcciHS0s@nongnu.org
X-Gm-Message-State: AOJu0Yw7LkBvIRwmM9luELhjfFw3t7jMiXc3V3sS3VdzOyW81Xjr6f0I
 KcHGhAamzQVt6HGDFZS8MupIIzTBEML2l9fx9ETTxwBbMmscZg6DoGERh2Fzflei6a4=
X-Gm-Gg: Acq92OGO7LErBk6uKwoORAxbr7TquuLQ5MB02LEzoDmZ0vhhXRN3YLtF2UCsiZS2MLb
 yPggLL8eGS/qjS3hZ2836QmhOaCbT5mjFpZVDVbryPW3eEmXBnnog4RgBtO15ey8J2iKmT7NMyy
 qY5fkfM9EOCvMDCq8EFE9T0LAc6cIPRbSCOYEPWx+o6MGZ+A+pQ942fMH/aEzusNBio1W0L35os
 8yXftWsFnwYvwY8cndTWIuRElCtHwGc2NYA4nD7Es8XKnlSjCgLlxFmkD9rG6AQmORQiy5okF6L
 I9jNtMLBgKx0zf1OWIR3+WnZTtkkODF/4s8Q+w+2Sm4VYFBU/88Gg9RFuCy1G7WfLsYCLNdOgO4
 RsOSNqf7h3lNdeiHIQB3tf5QeexVYFe+A9/RYcCmGMCBPBIdIl5volECfoPficVSvAemYJmsGk8
 VXppWrAbtDGkn2uABLmV538YYg6EPnOW1c3INuvrIIsWWWDj+hv0rOcxK8shsTr2k2Dw==
X-Received: by 2002:a05:600c:45cd:b0:488:ffb1:494c with SMTP id
 5b1f17b1804b1-48fc9a1bacbmr22414915e9.12.1778652021426; 
 Tue, 12 May 2026 23:00:21 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e913469besm27160005e9.14.2026.05.12.23.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 23:00:20 -0700 (PDT)
Message-ID: <29c175bb-5ec6-4108-b6bb-04c8b7cf5c2c@linaro.org>
Date: Wed, 13 May 2026 08:00:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/loongarch/kvm: Include missing exec/cpu-defs.h
 header
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, Qiang Ma <maqianga@uniontech.com>
Cc: maobibo@loongson.cn, qemu-devel@nongnu.org
References: <20260512131107.2388663-1-maqianga@uniontech.com>
 <24783c35-9a09-2f45-3ddf-0c743c13752a@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <24783c35-9a09-2f45-3ddf-0c743c13752a@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 13/5/26 03:11, gaosong wrote:
> 在 2026/5/12 下午9:11, Qiang Ma 写道:
>> After commit 71cab1a42d2 removed the indirect include of
>> exec/cpu-defs.h from target/loongarch/cpu.h, the TARGET_FMT_lx
>> macro is no longer visible in kvm.c, causing build failures:
>>
>>    error: expected ')' before TARGET_FMT_lx
>>
>> Add the missing #include exec/cpu-defs.h to restore the
>> TARGET_FMT_lx definition.
> Hi,
> The commit message does not match the changes.

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>> ---
>>   target/loongarch/kvm/kvm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>> index 9d844c4905..4af4ab2ed0 100644
>> --- a/target/loongarch/kvm/kvm.c
>> +++ b/target/loongarch/kvm/kvm.c
>> @@ -6,6 +6,7 @@
>>    */
>>   #include "qemu/osdep.h"
>> +#include "exec/target_long.h"
> Reviewed-by: Song Gao <gaosong@loongson.cn>
> 
> Thanks.
> Song Gao
>>   #include <sys/ioctl.h>
>>   #include <linux/kvm.h>
>>   #include "asm-loongarch/kvm_para.h"
> 


