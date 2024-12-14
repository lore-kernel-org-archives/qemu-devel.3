Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90952E77180
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 12:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMRWw-0000Zr-4r; Sat, 14 Dec 2024 07:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMRWi-0000Z3-Sb
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 07:45:45 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMRWc-0001pV-Nq
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 07:45:41 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3863494591bso1396949f8f.1
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2024 04:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734180336; x=1734785136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=487mrID2d41wYPTl50QjHD+lNgf9qPw4UegTf1MKqcw=;
 b=mlyVUS/A6YaPaAuGR/h7zdN4IonnCXsHbnWUvEv5fmXEJ0bY+MA6jsHeFG/kj42knU
 mBcXOJPUcEQpUfivGR69CoRnS/R60MEpLlcaJeHWVYMAiukODx5/gK9Wgry+S9rGGTZd
 IOGD3p0ffyEtLJ/DS5OvoqcKFHAhHpHTsMPDM28DVN74eaDwnyz7KTNd6JP0LtdNQNTp
 TClV8eB3EXmhMa3/YHJdNtg0xyZgM9iM24M3ja/qsL7NLgasdSt7HffXKELAx5C9RaaE
 UnsXiN4xUcGzoPUtSM8RUsER3X1wnxKa5uyxbywrXPL73pCNerXfz5xLCyHz3485pav5
 hSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734180336; x=1734785136;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=487mrID2d41wYPTl50QjHD+lNgf9qPw4UegTf1MKqcw=;
 b=wJ6ZgDz0MLyM8Ay4E8wrd2JOVHIXSmlVkTyEpvIuYGBxeGTeXqANnFuOfjKswmj6vt
 4ieG9zB8bBD+rAaRWOG1ukPeilPeba1hn4WintlNcQTfQTGMl5NGPx9l2bdmImPRY/Ev
 ytnnD3GnGi99tAsljR2DLO3b2EEqOpewQhJV5Rt/Vh6UgX63Pbo1qoEeuufsuUtDvsEt
 lSLBWunTlo5dEyK5hhyk4OfPpuTjHS0ZROxsW0cKPXm+0l3oNZHCYa+hTFilNASLd0m6
 01cKZujhPD2Yf0WZvKeJexrDaJ8ShlVzYSFpaSfv8MprjmTmh0EP4iyKtRko7Z52/LTL
 jLRA==
X-Gm-Message-State: AOJu0YxNFeGf0fXyvNVm9QFojgitaFEGKIA9nV+HhNspTWyvpKovm0sY
 VSnPLFE77RgTWyhWMdFVk/KDsZwul7OWRJ4wfwvM2Hgam7yr151+WWVLqHo3TxSsR05FTmepIKx
 eyxE=
X-Gm-Gg: ASbGnct9oZDqNKlXCEtntxUvVVb36bXanUdP4tQRCrT0cYYb9e4edPcht5i8KdapsDI
 qhJ5Malj0jfBPi2SNl/erHnCe0DGtsFmq4m++nbQ4yXnyE8oE5HHMTAKFnKNYjn2W0YFepvg51J
 joSavSHy0LRTRYz9V6yhU4c5aVeKZ6fn/up2ALyNgW5bRUQ9vMCM1Ca9p8haFsO9blBbvGivtAs
 lZuRbV7IPbzv6qyODXiSO8EuVpO6LY70vfKXLEJxJ21+Ap3CuIfspruwBJ9YZ58823jFFLDD2HV
 Ukh50edvbNe9dnG1IDv8vwCDTkLbSusbhYe4uHbA8O5Y5A==
X-Google-Smtp-Source: AGHT+IHjBUezK6/KL98NpfzYYRNUBygh7vdyc3sc8ukSQ1E3ery5yAFLZHCldbqmSUWYww6STyDGAQ==
X-Received: by 2002:a5d:64a8:0:b0:385:f349:ffef with SMTP id
 ffacd0b85a97d-3888e0b8723mr5426587f8f.41.1734180336491; 
 Sat, 14 Dec 2024 04:45:36 -0800 (PST)
Received: from [192.168.224.213] (196.red-95-127-57.dynamicip.rima-tde.net.
 [95.127.57.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80613a9sm2468230f8f.101.2024.12.14.04.45.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 04:45:36 -0800 (PST)
Message-ID: <8e3fcde0-1199-488d-8acb-e324deac415b@linaro.org>
Date: Sat, 14 Dec 2024 13:45:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/34] next-cube: move ESCC to be QOM child of next-pc
 device
To: Thomas Huth <huth@tuxfamily.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-12-mark.cave-ayland@ilande.co.uk>
 <20241214071058.7097e28d@tpx1>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241214071058.7097e28d@tpx1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 14/12/24 07:10, Thomas Huth wrote:
> Am Thu, 12 Dec 2024 11:45:57 +0000
> schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
> 
>> Since the ESCC is part of the next-pc device, move the ESCC to be a QOM child
>> of the next-pc device.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/next-cube.c | 54 ++++++++++++++++++++++-----------------------
>>   1 file changed, 26 insertions(+), 28 deletions(-)
>>
>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>> index efbb11e74b..20a0b073e1 100644
>> --- a/hw/m68k/next-cube.c
>> +++ b/hw/m68k/next-cube.c
>> @@ -124,6 +124,8 @@ struct NeXTPC {
>>       qemu_irq scsi_reset;
>>       qemu_irq scsi_dma;
>>   
>> +    ESCCState escc;
>> +
>>       NextRtc rtc;
>>   };

>>   static void next_pc_reset(DeviceState *dev)
>>   {
>>       NeXTPC *s = NEXT_PC(dev);
>> @@ -1043,6 +1020,28 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
>>       /* Floppy */
>>       memory_region_add_subregion(&s->scrmem, 0x14108,
>>                                   &s->floppy_mem);
>> +
>> +    /* ESCC */
>> +    d = DEVICE(object_resolve_path_component(OBJECT(dev), "escc"));
> 
> Can't you use s->escc directly here instead of taking the detour via
> object_resolve_path_component() ?

Indeed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


