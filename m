Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EF4C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 19:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAZFV-0003EY-Pq; Thu, 01 May 2025 15:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uAZFQ-000347-S6; Thu, 01 May 2025 15:07:04 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uAZFP-00057z-5Y; Thu, 01 May 2025 15:07:04 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9eb1eso2141667a12.0; 
 Thu, 01 May 2025 12:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746126421; x=1746731221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LOiS96/YFoA/3dv3hclRFweNC2tP3NjHeiMtLeMONes=;
 b=BHSIrfss+6M1bqJ36OJZXw+8f46odGk1S95HKZSe3XaqCd11XFFxm2CkVLkJBmx2i0
 xvOeSbpoUXObnd1feo10sYwtr5DJdfa88BoynQ/CAPLvUwzvhgbpMcxINWLgg/wAm4cf
 /37P2lVDYZcWiZoicIhYrmB6RKDUUsrRJRBTjE1ixI0PvcCEOGHQUtxOJ4W3yiGEg/c9
 0fOiV12A8GenEKi5rwq4B9/Wh53zlAVzvMMWdVnWGQU9mypPEKrioJywIkWxOku89FFi
 lVXcoa5abEG+0BKl+4yOz7tU0F97gV3vzuPQu9Z5Zpo6wRIl9LUH3TvZSKppex+8gRQr
 QjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746126421; x=1746731221;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LOiS96/YFoA/3dv3hclRFweNC2tP3NjHeiMtLeMONes=;
 b=HAsBNrgZO9i6MdBI/TGz5MdXiQOu9HDoHS26AgrdgiHfGHvZG+Cm7J9Bo56E0ZF1ij
 UTUUXb/ZeAgz0oiRKQsmd18EwjT8gY53A1TxL3m8YLtWqFhLCeo6vLGF7qVIQoEKdTF3
 itafl0UOPa7DbmkLqxwZyhkMDAI0eOJciZhUWni2pzkf2/usfWX6r6vXJqFd6A30w+SC
 k7KzIQlNWfp1FGG1WNnUEummh7sSvMUyIwgG8lOCVc6gkp0Xsh8Xk0bQX7qMc2LwW9Db
 hLvILsfyz0hmMVdgS1OqSAuEaWHsxI+N412PmUrNdHfhPlC7lA+Sw5WU3c2LxufRKR1u
 FWFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiQJE5sdwFzKrubp+66+PwW7p9j5aP3raLaYxJmntRCAgxGzAX1+j3ZKvcJah3AEG7dHc6ahdzZHgJFQ==@nongnu.org,
 AJvYcCWvD9ZdaQR4xsAHVrSF9f9IM5CPO2ys7Ew4CC3MES3LOBokCcCI7Sl2jhQPWXuJiBh8kIAwr4T/8A==@nongnu.org
X-Gm-Message-State: AOJu0Yy5PPxml865SSPIsGAPFc8FebdA/uT6SP6lUgtFW4RPVURduDL3
 Aw9wTUYeAoy05RtGPvQk/BvCn8jjo854tv3pCAkS2Ktsuvk+w8eY
X-Gm-Gg: ASbGncu6Lp+0mglulUkuC1Uq4g8m63CF7YzbxyXvxmC+crGVW8eM0PlfCAsAkv11jX2
 N4ZB72FCVyUA6+u//fJlZLhn6jT+aGhRqjCc+cOELa8L/aZforxEKxWceB0F39ZhT/tlhqbGC/g
 Qb7QGSrMaILJujqaxSbamR2b+Bn6a/Nk74S3UBnnzCB16A1UNdmLthyxylKT8hxm+sTsax8FYOH
 NV2yTnFA2UhjMursOIOu77zZtF3dVCD4JM+yOpSZRcMYzemsRTYknDeu5Sy98D/fAc1Xda/qCeS
 gNeK0JMRZN7vWgt53s2LxTGWlBfEc28rPUWtzNX6A/WNIYmKgRVN+tjRWToOoUXZpVs7pSvYg5t
 Rbj5e72m/VprPeXqyIMDwbR5wBRi8Y2u+saeI+/TxlG43GV8Rg/ib9AZQmdA=
X-Google-Smtp-Source: AGHT+IFIBs/fyth6znOxx47q/w/dBkOSKma+AFvGXcxHsBoZ5dK76COOASlVwy6g9i3DKvjo64VdGA==
X-Received: by 2002:a05:6402:2793:b0:5f4:3976:66c5 with SMTP id
 4fb4d7f45d1cf-5fa73291384mr348722a12.7.1746126420747; 
 Thu, 01 May 2025 12:07:00 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2980-eb00-a8d7-7173-cc26-fcbf.310.pool.telefonica.de.
 [2a02:3100:2980:eb00:a8d7:7173:cc26:fcbf])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa7781bf5fsm12448a12.36.2025.05.01.12.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 12:07:00 -0700 (PDT)
Date: Thu, 01 May 2025 19:06:58 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 1/3] hw/pci-host/designware: Remove unused include
In-Reply-To: <e7088647-aa76-4f64-b443-0ca354df8f24@linaro.org>
References: <20250501183445.2389-1-shentey@gmail.com>
 <20250501183445.2389-2-shentey@gmail.com>
 <e7088647-aa76-4f64-b443-0ca354df8f24@linaro.org>
Message-ID: <6B3A2B2C-BD60-4F02-A7CF-BC865E5655E5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 1=2E Mai 2025 19:02:35 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <philm=
d@linaro=2Eorg>:
>On 1/5/25 20:34, Bernhard Beschow wrote:
>> The DEFINE_TYPES() macro doesn't need the qemu/module=2Eh include=2E
>>=20
>> Fixes: 13a07eb146c8 ("hw/pci-host/designware: Declare CPU QOM types usi=
ng
>> DEFINE_TYPES() macro")
>
>The 'Fixes:' tag is for bug being fixed=2E

I see=2E Thanks for clarifying!

>Here I suggest:
>
>  Since commit 13a07eb146c8 ("hw/pci-host/designware: Declare CPU QOM
>  types using DEFINE_TYPES() macro") which removed the type_init() use,
>  we don't need to include "qemu/module=2Eh" anymore=2E
>
>(I can do the update when applying if you agree)=2E

Fine with me!

Best regards,
Bernhard

>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/pci-host/designware=2Ec | 1 -
>>   1 file changed, 1 deletion(-)
>>=20
>> diff --git a/hw/pci-host/designware=2Ec b/hw/pci-host/designware=2Ec
>> index 183f838392=2E=2Eb4bff14579 100644
>> --- a/hw/pci-host/designware=2Ec
>> +++ b/hw/pci-host/designware=2Ec
>> @@ -20,7 +20,6 @@
>>     #include "qemu/osdep=2Eh"
>>   #include "qapi/error=2Eh"
>> -#include "qemu/module=2Eh"
>>   #include "qemu/log=2Eh"
>>   #include "qemu/bitops=2Eh"
>>   #include "hw/pci/msi=2Eh"
>
>$ git grep -L type_init $(git grep -l qemu/module=2Eh hw) | wc -l
>      50
>
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>

