Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6677ECD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruByw-0005fQ-7y; Tue, 09 Apr 2024 09:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruByn-0005dn-Aa
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:57:43 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruByj-00045C-TV
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:57:40 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e2e09fc27so7932554a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712671056; x=1713275856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DpPtgaJcjFXwsxDaNzG15doAKh5G5dtClezuwm6CYTo=;
 b=mQ1yalKoqpD3Io/HbMHyiUarkiFvjc6ewsrksx/QirqS9WnAgOf97WzfF1qquWBASD
 uoWl6v6WKjxW62JJ+vn1ByaqsIFGhc9IG41hUmSlVrdx0fsUzgpT3IrqEchDC29W7mT5
 TD2skndCuzbUOQf6oCAeb5BUFTYrypE3JGilGdap/t+YD1dL8Ah0vBVgfIaz3d6nc/dS
 AbohH26VkRxLLwwP3K+3MRJt5MxKqnyzzFJlVW9HcADYwfSRtCTFgVwW0UgIYCSMLNne
 VKYsbmP3TzTCfe50yvTyD83azJHrqc9S/jQCwLN6r9OlAnXraquT8VZ3vfkFip8a1GKI
 Ov0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712671056; x=1713275856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DpPtgaJcjFXwsxDaNzG15doAKh5G5dtClezuwm6CYTo=;
 b=ldZYx9lwYx85Maw3/CiCcO0ilPAowpbZ/AjLoSlSwaPkNZ5Eyxz4PEX7emaV4Qqy+V
 mRSUhY3GR2dpMnw1n6smxfygxn7LqcNOVvDh5HNV9+NF/WDM0XlRgcRCTLMDRA8GCZgj
 /y4hFlM+PW7pVG8kr2Da+ihbK25uGkwf3dQtEAFHJnGjwQKlrWyOu1HQ48bt6zFE69hE
 X47RClXTj8J/6hRUxG2mPZGYhXlbVg92HNn/Gz91jY3P/ftUx/XXssxmypJz/JNLjI6C
 4NyFR/ihRK+vNKxkAt0CAEqkIXcHz7NIaFAtbND+L7SOa+uj+vFSwMz9/s3xaeY2Yemi
 754w==
X-Gm-Message-State: AOJu0YzB/UIdUGNGFdH05UoQwF1TqR2q3KyO4cz0L/uwq0OV+8RtFwOS
 4F7BK58XimiwIOduyJoQaXA+2E+MJQt6uZuyu9yMWZp80DVBgGg8W4htS+Vth83mUgVPHJiv/0p
 q
X-Google-Smtp-Source: AGHT+IGyHcTUL7sAZnUuWkiuTLGpvZjbgw9l5kn5BRDRx4ZyQKx3GtQJ2QUMkDKeR+enD9/Qmuimhg==
X-Received: by 2002:a50:d514:0:b0:56e:1e47:c0b2 with SMTP id
 u20-20020a50d514000000b0056e1e47c0b2mr2815935edi.4.1712671056288; 
 Tue, 09 Apr 2024 06:57:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 j7-20020aa7c0c7000000b0056e5306ca11sm3288538edp.53.2024.04.09.06.57.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 06:57:35 -0700 (PDT)
Message-ID: <6c308332-70c0-4bb8-a17f-f657037b59e7@linaro.org>
Date: Tue, 9 Apr 2024 15:57:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? 0/3] hw/block/nand: Fix out-of-bound access in
 NAND block buffer
To: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: qemu-devel@nongnu.org, Qiang Liu <cyruscyliu@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-arm <qemu-arm@nongnu.org>
References: <20240408083605.55238-1-philmd@linaro.org>
 <CAA8xKjVPBu2LgsZzJhUM5Yjp1z36=w012-Nea+qPtDopkXeJRw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAA8xKjVPBu2LgsZzJhUM5Yjp1z36=w012-Nea+qPtDopkXeJRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 8/4/24 17:45, Mauro Matteo Cascella wrote:
> On Mon, Apr 8, 2024 at 10:36 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> Fix for https://gitlab.com/qemu-project/qemu/-/issues/1446
> 
> Does hw/block/nand meet the security requirements for CVE assignment?
> 
> => https://www.qemu.org/docs/master/system/security.html

I don't think this device model is used in virtualization,
so I don't think so. (Cc'ing qemu-arm@ in case).
Thanks!

> 
>> Philippe Mathieu-Daudé (3):
>>    hw/block/nand: Factor nand_load_iolen() method out
>>    hw/block/nand: Have blk_load() return boolean indicating success
>>    hw/block/nand: Fix out-of-bound access in NAND block buffer
>>
>>   hw/block/nand.c | 50 +++++++++++++++++++++++++++++++++----------------
>>   1 file changed, 34 insertions(+), 16 deletions(-)
>>
>> --
>> 2.41.0
>>
> 


