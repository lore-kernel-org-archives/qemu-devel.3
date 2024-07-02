Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124C6C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfzT-0003N8-Oj; Tue, 02 Jul 2024 12:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOfzP-0003Lc-UX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:04:19 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOfzM-0006RM-6u
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:04:19 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52cdf9f934fso4588973e87.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719936248; x=1720541048; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IdsF1XEmlCmkej4/bGhPlpa/GRX9nD8oxSkZZm4exzM=;
 b=T/OfLiDf2WbbznDJoQ+nrEZrFmKW6BrhiZJq6cIlMxGdfDeFku6RYVuq0E7huHhy5l
 WxlvkvLbKxPG4/usuqi0x5Ouju/2mAq0sFDgsp0gdvnJ6vRtGXEo8mT/jdPvyTce6gMb
 I0BzBHx8eoN/Ku/jDpOjHcgtPk/F73RvgjOHXwkVVpbZrpCdWj5LFjdOWi6jLxLlPTOj
 mOtOj3RtFYh6IvPryQhdvY/Z2CZw8CooxY0JxSkyPILYYq2tUUzr6zFKb1wbHuiVzYwW
 14BG2KX8rt7KqRYkgAXdrHNbKrIcDf2sFNkBHduk17hNo+0LOXKm8gp3w73BOSaePxZ6
 tzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719936248; x=1720541048;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IdsF1XEmlCmkej4/bGhPlpa/GRX9nD8oxSkZZm4exzM=;
 b=dU5M7ftX48I90hcFQttn7momJ+6BVFwO+42d+hZ4T3MOVJIo64C6XK2kOoEfjmJC3E
 hWq86nuwKRS469r1uFB41QCrNk6G3bl9U1G7aqoxEdUAr/uhVBv5NdX3lStioDFs7igJ
 uYcvdvidWOW9DAjF33n319YzcT6LtXbqCJoD/1uv3BEe/pT32tZT/sWycgCVb2NAy3Vv
 3+6JUHQbvLA7eAtdi1sYcFKfO39ICjcf4AlBthM72gejWI/8+flTp3Dkdtm7TAIaI37c
 tKTGTH1KlOF26RG3tgAPyVE6v6YKqEGPuONQokgHw49eabOGOxrJJg94CNKREOkMMerB
 j7+Q==
X-Gm-Message-State: AOJu0YxZA1EUYsH5Q3+CxMv/0frMXcQONlIITI9DsUnbJKQFPMX+8ar/
 wrkZO+79V32Y/SPr/zQkwReQJ0GjS5jVLWsl+G8zv94LmHU1g8pouwFKgB9YTi4=
X-Google-Smtp-Source: AGHT+IGT4qDnOagKjgQ2PIEMU25Iu55suGjmQmkbgqXRGD4t+2L+MPga50PMEOrqqlyv5a4uJNY2pA==
X-Received: by 2002:a05:6512:3091:b0:52c:d904:d26e with SMTP id
 2adb3069b0e04-52e82678ceamr6530881e87.21.1719936248115; 
 Tue, 02 Jul 2024 09:04:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257a4d4cd1sm140824335e9.28.2024.07.02.09.04.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 09:04:07 -0700 (PDT)
Message-ID: <9be76565-45e5-48dc-a3c6-e0546786fee7@linaro.org>
Date: Tue, 2 Jul 2024 18:04:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 06/98] hw/sd/sdcard: Do not store vendor data on block
 drive (CMD56)
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-7-philmd@linaro.org>
 <ZoJiTdo0yr6V_rgN@XFR-LUMICHEL-L2.amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZoJiTdo0yr6V_rgN@XFR-LUMICHEL-L2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

On 1/7/24 10:01, Luc Michel wrote:
> On 09:00 Fri 28 Jun     , Philippe Mathieu-Daudé wrote:
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> "General command" (GEN_CMD, CMD56) is described as:
>>
>>    GEN_CMD is the same as the single block read or write
>>    commands (CMD24 or CMD17). The difference is that [...]
>>    the data block is not a memory payload data but has a
>>    vendor specific format and meaning.
>>
>> Thus this block must not be stored overwriting data block
>> on underlying storage drive. Keep it in a dedicated
>> 'vendor_data[]' array.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Tested-by: Cédric Le Goater <clg@redhat.com>
>> ---
>> RFC: Is it safe to reuse VMSTATE_UNUSED_V() (which happens
>> to be the same size)?
>>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Fabiano Rosas <farosas@suse.de>
> 
> I'm not sure about this migration question.
> 
> But IMHO you can simplify your implementation to avoid having to store
> and migrate this vendor_data array. After some research on this command,
> I came to the conclusion that it's used by manufacturers to return
> device health related vendor-specific data. (E.g.,
> https://images-na.ssl-images-amazon.com/images/I/91tTtUMDM3L.pdf Section
> 1.6.1). So I guess you can simply discard writes and return 0s on reads
> (or "QEMU" in ASCII or... :)).

Thanks, very interesting datasheet! Note the argument filter:

   To query the Health Status register, CMD56 with
   argument of [00 00 00 01] is used.

Since we can program this array, I'll simply add it as R/W (KISS).

> 
>> ---
>>   hw/sd/sd.c | 17 +++++++++--------
>>   1 file changed, 9 insertions(+), 8 deletions(-)


