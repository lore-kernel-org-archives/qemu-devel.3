Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2E2C36018
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 17:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u17Hn-0004NT-TU; Sat, 05 Apr 2025 13:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u17Hf-0004MV-Dl
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 13:26:20 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u17Hd-0008Mm-DQ
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 13:26:19 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-30332dfc820so3047032a91.2
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 10:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743873976; x=1744478776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=IOLqRi5jZQXjcwuD5/mA2YIO3K21dEOYkIiqFo71rsQ=;
 b=h0YfPFsXUD4B28BEntUZno/WPpCjbK3Diew4hl1PORzOtEEF/CMO5xbizYjGoTI33g
 OVycEgZKTmrfmDA6ZjKCHWBa3H0KmpHYceXnYxTW8kQa+scvDKLfxfwZzNbiHJJLyd2Y
 if3TdKidiPC7EpygSDNCaZjShc+JnWbbieI47fS6O+3/Xd4KT9v8Nj0McvQX56akf5Fw
 ipzZWe3i/rKwt4Vtn4fdcbWtusx771TpkVce/mRWitVjskEroVcTJrPVTJgzEYQ2N+uV
 xPHJITDs3wg1Ir7PGiVXvB7uHDchZYSM70TiycOGYw8yaSp9oawZTIAx1nFTQehQojvq
 dkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743873976; x=1744478776;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IOLqRi5jZQXjcwuD5/mA2YIO3K21dEOYkIiqFo71rsQ=;
 b=ig0nI0y7E4Qb4kv+X5rvXazVeU909jvhnGLYtZdmWqeJe7IhbR8nwNjh7kUF05WlUP
 q73N+3nUCHgKsJsE1Ej5TDXvqqwOLTiqYfdbXwQd8eH9nPnOhPeo1r2LqbLIyFGRhFbW
 SdscKMwMntYyV3KEAGhjOSx4qUUrBRe63TBnIlGDCKYc7gEie1DaXN0DZwcW+mTH9Gav
 hl6JagvDSiEpij6XgIdXqFUawX8hGcQV8MxvpFEW1MQHxH3bR3H8FxB6pOOQ8FHvhY9T
 r2o6WhH9geCpZc/ssP2acT6dKxatEG6a/+u82aWTl3x52Tp8X/nZdr3EUFdxZETeXy40
 qTAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwzf688EojrrWlYwRHnIMEwjBs4OA3pn8pde5ows/5ySkjW0+PcGGorYYjsHQE09YFbuZtt5iP5/fu@nongnu.org
X-Gm-Message-State: AOJu0YzAV0ZfD/ZHdYMZgK7jDDvHr3lg1eGZeWlSbc2pIYI82cp5OO5Y
 PhCpLbE69GjLKzXgeJ2IblWURWf3R9oc1GKAQwGAMfi1OOG/sQWN
X-Gm-Gg: ASbGnct5Ydn5w2kfJ4M4xmTZpC9d9vp2yqaymQtTOH+bwdqnPqOTcTw2LqTvfeEFqdk
 u9Hihv3qr6yMS1IZFZYwliHUhcqF/UgWhwT3PnsInpXpl2z1+wdhebcVDSVYQP9EkblVhgeKqJI
 AqWe2f5g7haiS1UBEuwn0oIiDhr5MKVr1PZGYx3+MkZlzs7dPLzR8+TeCIzgBkBTHSJ7UZXuQVy
 v8/kzdKBGA+aftfp1rc9fJFqwbNhuC2Yl2vyFQu5vmRFVk6IUa5gpWQ2QyVVVtX8Am5iPeOYM3h
 FhW1ComBj/c7Y70pfdsdmR9rCLdg52pyAIfh3lDp8RHOlYXPMTBMdrquH1/SBCFNrzfKdvc7Yiv
 C3h34oX13AzCXAUM+iw==
X-Google-Smtp-Source: AGHT+IGTuQSDkJOxliUNFXNzieYvaAlYtNATeqctzTAljzFlKWs+8z+mY0eIcCZ2COdDkVTJ8/M4vQ==
X-Received: by 2002:a17:90b:51c8:b0:2fe:b174:31fe with SMTP id
 98e67ed59e1d1-306af6f938bmr4766539a91.2.1743873975803; 
 Sat, 05 Apr 2025 10:26:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297865dfd7sm52246225ad.136.2025.04.05.10.26.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 10:26:15 -0700 (PDT)
Message-ID: <7ed5d213-9429-45c8-bbf3-6f3f841a2299@roeck-us.net>
Date: Sat, 5 Apr 2025 10:26:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add property to support writing ERSTBA in high-low
 order
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <ae8cd367-8580-4476-9a75-3fa4f7aa2536@linaro.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ae8cd367-8580-4476-9a75-3fa4f7aa2536@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/5/25 07:25, Philippe Mathieu-Daudé wrote:
> Hi Guenter,
> 
> On 5/4/25 16:00, Guenter Roeck wrote:
>> This series is needed to support the USB interface on imx8mp-evk when
>> booting the Linux kernel.
>>
>> According to the XHCI specification, ERSTBA should be written in Low-High
>> order. The Linux kernel writes the high word first. This results in an
>> initialization failure.
>>
>> The following information is found in the Linux kernel commit log.
>>
>> [Synopsys]- The host controller was design to support ERST setting
>> during the RUN state. But since there is a limitation in controller
>> in supporting separate ERSTBA_HI and ERSTBA_LO programming,
>> It is supported when the ERSTBA is programmed in 64bit,
>> or in 32 bit mode ERSTBA_HI before ERSTBA_LO
>>
>> [Synopsys]- The internal initialization of event ring fetches
>> the "Event Ring Segment Table Entry" based on the indication of
>> ERSTBA_LO written.
>>
>> Add property to support writing the high word first. Enable it
>> for dwc3.
>>
>> ----------------------------------------------------------------
>> Guenter Roeck (2):
>>        hw: usb: xhci: Add property to support writing ERSTBA in high-low order
>>        hw/usb/hcd-dwc3: Set erstba-hi-lo property
> 
> What about using .impl.min_access_size = 8 instead?
> 
> Could you try this patch, or provide me with a reproducer?
> 

You should find everything you need to reproduce the problem at

http://server.roeck-us.net/qemu/xhci/

Please let me know if you need anything else.

Thanks,
Guenter


