Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC95DC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reXgV-00089n-E4; Mon, 26 Feb 2024 04:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reXgQ-00089W-T8
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:54:02 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reXgP-0002so-7F
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:54:02 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33d7b8f563eso2417485f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 01:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708941239; x=1709546039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5XWituQf04KJDE8spGWGxo8ogwe4I6409rOOZOhxXsQ=;
 b=KADZzG+VvZ4l0hcoVQfx9Td8PJVjLT5U5NgUvh+0BXLdeGeHltVrpZxehsH88F9V0q
 c3sobYasHMYRZZ0aUwYgi1lQfPlGKipnw8PlTG3eI6TmE+xBJ1vuM3PPvC6WABNeThwc
 yFSQ8u/lqEOQpFSNQBzYgG4n8NKWngOd7BwjGOoxzeXkW5vlNNkKsyv79UYtuSMCxDUi
 8t5cQ5Z3RjyTpK/TaiRf/yBHLK/Py9T0ud3ROobViZ/KdXkT4/6cvZxACeYtK9+h+DCQ
 j/AjX0yqtHay+ghNbE+XHIkJfxzINmOFRAUA2ozh+U8Ebpb6v4COp0o5Jo6BdVT760OS
 7LEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708941239; x=1709546039;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5XWituQf04KJDE8spGWGxo8ogwe4I6409rOOZOhxXsQ=;
 b=BsxnioOlpRQuO0zYDURepnJUWR1Dkojmj9QaYyxlwK9yrllPwbAxrJyp2LRbj9kFZj
 FEa1hKEN5ILEqO8G6AziDq4ocmbN8OaPHX12ryAvrpB1jBFzxFKA5ZCUaNJCReP2Igui
 XzAa0DeHAsN8+W3NTEdEz4nouKRSw9m5ylivKFHil+7Owa1lZyOVzJaQbipMsoP8EXRE
 3xuV1SbhhRc40k1g8rKJR56A5xcHNa3EMhuZETa1eh2jQlHSoGF8JZrJ2bUDFdjsH9xn
 hZ5wWeGsS5ifdMmiUsGO74di4ntXHMl3kQPPd5sl4HAvii4ao5T8CC6W4Q5y3bD3uMhX
 YXbQ==
X-Gm-Message-State: AOJu0YweD1KcSma4eflFIRm8TAte7GNxS8peyhsvVdBPEQLYvYqk82r2
 V0DgFLFqhxxYXqPBGmDpSJXauDC1S0+3tqgaed045H2fMFkGzHlthEVRdaEttaxj+p1/AsSiYnC
 2
X-Google-Smtp-Source: AGHT+IEro5Vdl0Bz/XqcdelVSiwMUJBdq+ON/iIjPVXYTjvDjbEE0itxjNJsy1oSMzDGxL0YTW8TBA==
X-Received: by 2002:adf:f390:0:b0:33d:afbc:6c76 with SMTP id
 m16-20020adff390000000b0033dafbc6c76mr5198692wro.1.1708941239148; 
 Mon, 26 Feb 2024 01:53:59 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a056000188700b0033d926bf7b5sm7863904wri.76.2024.02.26.01.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 01:53:58 -0800 (PST)
Message-ID: <b0e25d2b-5d72-4074-a346-4546e1eeefd7@linaro.org>
Date: Mon, 26 Feb 2024 10:53:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] hw/acpi/ich9_tco: Restrict ich9_generate_smi()
 declaration
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20240219163855.87326-1-philmd@linaro.org>
 <20240219163855.87326-6-philmd@linaro.org>
 <d90dd6b2-92fc-4440-a546-bd3f558a425c@linaro.org>
In-Reply-To: <d90dd6b2-92fc-4440-a546-bd3f558a425c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 20/2/24 07:32, Philippe Mathieu-Daudé wrote:
> On 19/2/24 17:38, Philippe Mathieu-Daudé wrote:
>> Only files including "hw/acpi/ich9_tco.h" require
>> the ich9_generate_smi() declaration.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/acpi/ich9_tco.h    | 1 +
>>   include/hw/southbridge/ich9.h | 2 --
>>   2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/include/hw/acpi/ich9_tco.h b/include/hw/acpi/ich9_tco.h
>> index 1c99781a79..68ee64942f 100644
>> --- a/include/hw/acpi/ich9_tco.h
>> +++ b/include/hw/acpi/ich9_tco.h
>> @@ -76,6 +76,7 @@ typedef struct TCOIORegs {
>>   } TCOIORegs;
>>   void ich9_acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent);
>> +void ich9_generate_smi(void);
> 
> Bah it is only used in hw/acpi/ich9_tco.c, I'll declare it
> statically there.

Unfortunately can't do that now because I really don't want
to add a x86 specific dependency here:

../../hw/acpi/ich9_tco.c:35:30: error: use of undeclared identifier 
'CPU_INTERRUPT_SMI'
     cpu_interrupt(first_cpu, CPU_INTERRUPT_SMI);
                              ^


