Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59D0C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reW3q-0000Ks-J0; Mon, 26 Feb 2024 03:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reW3m-0000F7-8M
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:10:02 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reW3k-0002Hu-Ct
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:10:01 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a34c5ca2537so364088966b.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708934998; x=1709539798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6KTu94ApO0yIdxKXWWYSfCBDITcDdBmGOkZCWUjAx+I=;
 b=UgZep0yg8Bj7qEqEie6C5PebADbJZmxBsFyjYc50s0NfTamzm21YU6qej1W7/2DKsr
 YjumGzJsB955dF+tDcbmDcVztQnw3PAM6upT7u4ZgV9f5Sreod6AH9uSeKc+W19zerp4
 yWmtI1sS7BJtmp+zNA8hCbwi8oHqm9a/Z9y0B/wvKjAFQpXzZIO2NB2bDZpE6UNbNBqH
 BKqIVWqZ56wsXI1elnR6nulSe7M6Ll58iGRnjvjq1dY8L3mGhd2TO7kNHhs+Dr5NXHsP
 UGn2aepPiipI2B8rocxtLJICqUw6cOTQG3qyCqcEmLwzRR1A059w0S/WXYZC696XRW14
 tyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708934998; x=1709539798;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6KTu94ApO0yIdxKXWWYSfCBDITcDdBmGOkZCWUjAx+I=;
 b=wcxDSCC4FHM00VRrFKnTmPknQojsARUXCKpn3M5hclQOu1cExKeJ4sEQrowV9AvcSO
 GBQXy+ycT9SL/VMUlT65Msbpts40PrG3hAIEoLy+ZYkK5D7pOGvg1S5IFc4zIG2kl+SF
 E29xVRXGtK34D9zwPHwt3kARliKLOAXXgstYMnRSjsxk58WGsZ2DnFo/oxVH2hzPuEjf
 Bep0DOzQ9snpnQcUH59yQJyEd+OWNLjtTOH4VzEEPSc2t3tpn7cvz6VqsGxCOmzsykHo
 Wgc+mDRNXQrd9hvOgSFtAR7i1uGbxzHjBCVGfd4PMZ33ANvMdu9lh3rmaOC2sS/mEpXD
 2rCg==
X-Gm-Message-State: AOJu0YyBsL17pH9BTnxH8I/Z/Dk2cioqNf9Tw2slNOjzTZGrg43NC2Fl
 QKQecT+GU74cyGeCDRslrkaMJzZe1YWWzgGfkahMaki4KqTd1QmScJyQIFoc+0rF7HzZnKt3J86
 z
X-Google-Smtp-Source: AGHT+IHvsse/rDZAfawaJhBkgtmoAsFpFuu1wmAKSLYhLMo1HxYDJOUEaYLHTnmyXMNB39dAJCQ0UA==
X-Received: by 2002:a17:906:ce30:b0:a3f:bd94:4d80 with SMTP id
 sd16-20020a170906ce3000b00a3fbd944d80mr3974881ejb.76.1708934998279; 
 Mon, 26 Feb 2024 00:09:58 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 tb24-20020a1709078b9800b00a42fa329ebfsm1948745ejc.54.2024.02.26.00.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 00:09:57 -0800 (PST)
Message-ID: <fded510c-88d9-4bbb-8a80-08898c5850b2@linaro.org>
Date: Mon, 26 Feb 2024 09:09:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw/ide: Include 'ide_internal.h' from current path
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240225171637.4709-1-philmd@linaro.org>
 <20240225171637.4709-4-philmd@linaro.org>
 <feffd329-59e0-0291-0dd6-76a625da190b@eik.bme.hu>
 <878r37lll6.fsf@pond.sub.org>
 <fd0fba89-cd93-4113-9f3d-2ee20f2217d9@linaro.org>
In-Reply-To: <fd0fba89-cd93-4113-9f3d-2ee20f2217d9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26/2/24 09:00, Philippe Mathieu-Daudé wrote:
> On 26/2/24 08:40, Markus Armbruster wrote:
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>
>>> On Sun, 25 Feb 2024, Philippe Mathieu-Daudé wrote:
>>>> Rename "internal.h" as "ide_internal.h", and include
>>>
>>> Is there a convention about using underscore or dash in file names? 
>>> The headers Thomas added are using - as well as ahci-allwinner.c, 
>>> only ahci_internal.h has _ (but there are others elsewhere such as 
>>> pci_device.h). Maybe we should be consistent at least within IDE and 
>>> this series is now a good opportunity for renaming these headers to 
>>> match. But it's just a small nit, thanks for picking this up.
>>
>> This is one of the many unnecessary inconsistencies we're inflicting on
>> ourselves.
>>
>> We have more than 3600 file names containing '-', and more almost 2700
>> containing '_'.  Bizarrely, 68 of them contain both.
>>
>> I strongly prefer '_' myself.
>>
>> Zoltan is making a local consistency argument for '-'.
>>
>> Let's use '-' here.

BTW by "here" I understood "in this patch". After v3 only a single
file use '_': "ahci_internal.h", but Zoltan said he is uninterested
and doesn't care about it so I'm not renaming it.
(https://lore.kernel.org/qemu-devel/3e576d33-1973-3f44-afd1-9224609f89a6@eik.bme.hu/)

> 
> Fine, patch updated.
> 


