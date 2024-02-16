Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA40AC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 19:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb4Hy-0008Fx-9y; Fri, 16 Feb 2024 14:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rb4Hw-0008F8-Kp
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 14:54:24 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rb4Hv-00008B-06
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 14:54:24 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5118d65cf9cso3062864e87.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 11:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708113261; x=1708718061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fTvzKYXRxk2Xk+NKT9N6TKpQ1vRzkheOt6rJHqBctwc=;
 b=JO8xhbf9uw11OkWK800PuED/v1mi8OcCt/hUWeHUAyAoaKsDqRGDzQmXskaUx6mo/K
 JbaXq9pjoCN3TxbYJAGvrVD5G046bnz3GrjPiIX/OcDV2Jj/2Z73XE5ZdJZ8mkIdzwJ1
 lJuP/5nPwd15xeD1+etOAlq5OSH+Jcfu1kfx5THUGZLIHLlaRzSVnCJka/npVkxx9BAk
 qUHEzIWHCVvpJR9xQc47zr5G87Rr6l+yZIjnu/+oIW/gUmRQB8+u5QBl3a3u4q8eJB7l
 +zaIARyZaAfbkERduiFZBNrtxtrfgFQF8dgmYMq1JGTp4jsK3/pkyQ+5lP6PKrktHTLb
 F4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708113261; x=1708718061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fTvzKYXRxk2Xk+NKT9N6TKpQ1vRzkheOt6rJHqBctwc=;
 b=ryBQ9ZWWm1vtknlm88o9RfQrEK8w4NmVBzbqOyZx9l1kNU0Yvp6KEMa9tcrVkgSBEm
 PvzvGNKPJiVFsz9YPOKqyyC3iWNipjl0/2jJu2cgav7tHqqAZ7vW4bcG4DOtCGBsJKYC
 9KYR/IcJZ2EKAtikZgsA0gQV5aq6+2z6K2ZtZrUFRQqvkdWHcXaAyEdtxw05AICPte5+
 dAt6vFBsZQK2VEbtugd0i0Tr2t7PsR6TRzl/0zVUJtuJxv9wWGZ3xmybu6R2vSGtwv8T
 9/VmVZqgEmc9U9Ok9K0fyPmyoZZQOKqySVBdlWtLarKh7VdXHb60uDfiXtkhor21EuMy
 XYqg==
X-Gm-Message-State: AOJu0YxvONVjsGu3P59wTr1A2OszL5cPXWhiYG3DXwv5b3nyHckPtBIx
 P7yjp5L6hzIb0d2rxvg4awucqc3mE5Q07X4vYqU2BKOcHQ48b4wemKBYBTvf7UI=
X-Google-Smtp-Source: AGHT+IFzjk+5T9BmuEZRICqcvnwesA2RMuuDU+Whj7S6bON3OfQ97tljdqKynRbPhDdS0PqMyMTtMg==
X-Received: by 2002:ac2:4209:0:b0:511:9250:1ba5 with SMTP id
 y9-20020ac24209000000b0051192501ba5mr3733969lfh.36.1708113261126; 
 Fri, 16 Feb 2024 11:54:21 -0800 (PST)
Received: from [192.168.69.100] ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 b26-20020ac2563a000000b0051178d2f592sm55689lff.236.2024.02.16.11.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 11:54:20 -0800 (PST)
Message-ID: <2f8ec2e2-c4c7-48c3-9c3d-3e20bc3d6b9b@linaro.org>
Date: Fri, 16 Feb 2024 20:54:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/arm: Inline sysbus_create_simple(PL110 / PL111)
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240216153517.49422-1-philmd@linaro.org>
 <20240216153517.49422-2-philmd@linaro.org>
 <bcfd3f9d-04e3-79c9-c15f-c3c8d7669bdb@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bcfd3f9d-04e3-79c9-c15f-c3c8d7669bdb@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

On 16/2/24 18:14, BALATON Zoltan wrote:
> On Fri, 16 Feb 2024, Philippe Mathieu-Daudé wrote:
>> We want to set another qdev property (a link) for the pl110
>> and pl111 devices, we can not use sysbus_create_simple() which
>> only passes sysbus base address and IRQs as arguments. Inline
>> it so we can set the link property in the next commit.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/arm/realview.c    |  5 ++++-
>> hw/arm/versatilepb.c |  6 +++++-
>> hw/arm/vexpress.c    | 10 ++++++++--
>> 3 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
>> index 9058f5b414..77300e92e5 100644
>> --- a/hw/arm/realview.c
>> +++ b/hw/arm/realview.c
>> @@ -238,7 +238,10 @@ static void realview_init(MachineState *machine,
>>     sysbus_create_simple("pl061", 0x10014000, pic[7]);
>>     gpio2 = sysbus_create_simple("pl061", 0x10015000, pic[8]);
>>
>> -    sysbus_create_simple("pl111", 0x10020000, pic[23]);
>> +    dev = qdev_new("pl111");
>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x10020000);
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[23]);
> 
> Not directly related to this patch but this blows up 1 line into 4 just 
> to allow setting a property. Maybe just to keep some simplicity we'd 
> rather need either a sysbus_realize_simple function that takes a sysbus 
> device instead of the name and does not create the device itself or some 
> way to pass properties to sysbus create simple (but the latter may not 
> be easy to do in a generic way so not sure about that). What do you think?

Unfortunately sysbus doesn't scale in heterogeneous setup.

