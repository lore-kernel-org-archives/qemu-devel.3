Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BF4C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebD3-0007IB-7H; Mon, 26 Feb 2024 08:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebD1-0007Hu-LM
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:39:55 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebD0-0004t3-2b
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:39:55 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-565ef8af2f5so1227467a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 05:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708954792; x=1709559592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rC3P+W4wqVxCncQBckjSnkNhvyA0AMFODdFc4zadIGY=;
 b=ux1MCq98o9kfRZlvCeXnIR3wUzKfM7TbjHD23k+z1JXP5156Le+V4Ff8UDsawjYGKZ
 61xK+nfLRYNJ7KCcsUhlhRkKn9hw682wpeeOPLKv268jp7YfepgnapMm+hfX3wQmfvo9
 H59P/XpJ/OGw4s3havLD7h7LYUOC1aqwoeHURzIaXpsAPd1LZz0/vYhZBhpfyeFnl8sZ
 96yoihkBHXrtXaXz1zWCuAledubVCxGTAdIlu6GdcGaqnnOBJCjVFvmwTckm02wF4kv3
 U3k10g7jdlEDAboSu7hN/PhDfVE89HhpYef87RhOUCMOo56SJ39nQ2mOnwwtxafRZDQW
 Wllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708954792; x=1709559592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rC3P+W4wqVxCncQBckjSnkNhvyA0AMFODdFc4zadIGY=;
 b=ZImZfNF35D21U3+/4SX/kf3ODsJRnbWJBmDLRf2WklwlZCk+Uacfd3J4wEmeA22c54
 s7/uxC404xp96DlJfx+Rosul3zldfNocU24It3aLBpjJb3GxZK2KuCUMxk5AjTMWvpWt
 4D2ZBQWTZq0ZZvj5gMaxvKbzTyQTlZEVGycOeUuEsPgZelAaYwU/sx7pescKFz1EQRYA
 C8ulS023zEX3eUE0i+xUEoXnwPw6I5Mgg/29ZgtQJYWbFGwSgvMRR++c6TFvzc4OhviL
 jhGcmdtPSOKUJzmKWC90IRj0S8rCmEfrhnPfVcN5E13lFJvxoZMUGRflLzO3g5Cpq25M
 RFag==
X-Gm-Message-State: AOJu0Yw7rhBhxcS8UX68XVyGlzNlcfXb9L1dU70CK4hse6jvz5FgKFC+
 xXrAJat9eHYULMoQsm0LnxJ6Mn2kqGhaQi8LiexcTRPg+vpOBVXDSc0k1mFqdw03Iav0YBKcseo
 o
X-Google-Smtp-Source: AGHT+IGLfTqeZfC1nWyYZxu/jsPnH8vpkWLl+upu0fTeNuIbgfwoRqCcnjMn9RwyIAwTrwrDogpzJQ==
X-Received: by 2002:a17:906:4e90:b0:a3e:389b:caa3 with SMTP id
 v16-20020a1709064e9000b00a3e389bcaa3mr4823186eju.53.1708954792559; 
 Mon, 26 Feb 2024 05:39:52 -0800 (PST)
Received: from [192.168.69.100] ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 lb10-20020a170906adca00b00a3e6e8dbebfsm2429855ejb.30.2024.02.26.05.39.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 05:39:52 -0800 (PST)
Message-ID: <0925a53b-bd37-43c4-a4e8-ec031fb5de23@linaro.org>
Date: Mon, 26 Feb 2024 14:39:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] hw/pci-bridge: Extract QOM ICH definitions to
 'ich9_dmi.h'
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-block@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240226111416.39217-1-philmd@linaro.org>
 <20240226111416.39217-9-philmd@linaro.org>
 <5bab87f9-aeee-3aa5-d695-4fa2128130a1@eik.bme.hu>
 <e8389171-1ae7-4955-9b5b-ac0ad261654b@linaro.org>
 <d65ee3cc-70f1-b0f4-0fd2-8c50b369556d@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d65ee3cc-70f1-b0f4-0fd2-8c50b369556d@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 26/2/24 14:23, BALATON Zoltan wrote:
> On Mon, 26 Feb 2024, Philippe Mathieu-Daudé wrote:
>> On 26/2/24 14:01, BALATON Zoltan wrote:
>>> On Mon, 26 Feb 2024, Philippe Mathieu-Daudé wrote:
>>>> Expose TYPE_ICH_DMI_PCI_BRIDGE to the new
>>>> "hw/pci-bridge/ich9_dmi.h" header.
>>>
>>> Since this is effectively an empty object (that's not even 
>>> instantiated by default) I still think that instead of adding even 
>>> more files for it all this could just be moved to hw/isa/lpc_ich9.c 
>>> and define there as an internal object and drop the 
>>> OBJECT_DECLARE_SIMPLE_TYPE(I82801b11Bridge, ICH_DMI_PCI_BRIDGE) and 
>>> just use the size of the superclass as it's instance size. That just 
>>> adds the realize function and a type definition and gets rid of 
>>> boilerplate scattered around the source tree which just adds 
>>> complexity for no reason. But I don't care too much about it, just 
>>> wanted to say again that if something can be kept simple I'd prefer 
>>> that over making it more complex and for this device it looks already 
>>> too complex for what it does or used for.
>>
>> My understanding was project coherency and style is preferred over
>> simplifications / optimizations, so we prefer explicit TYPE_FOO
>> and corresponding OBJECT_DECLARE_XXX() in a public include/hw/foo
>> header -- because it will end up copy/pasted --, but I might be
>> wrong.
> 
> For classes that are actually used that may be true but this class isn't 
> used anywhere just defined for the user to be instantiated from command 
> line or config. So you won't even need a type name in code currently. 
> It's also an internal part of ICH southbridge so no need to be exposed 
> outside of that as it's only useful within that chip. Finally it has no 
> functionality, just an empty boilerplate so that the device appears in 
> lspci output but it does nothing. Therefore, I think it's simpler to 
> just move all of it within the same file where the southbridge is 
> implemented and define as empty object there like the via-mc97 device in 
> hw/audio/via-ac97.c which serves the same purpose to show the part to 
> the guest but its empty device without function. That would save half of 
> all this boilerplate that just adds complexity now. If sometimes in the 
> future this device gains some functionality then it can be split off and 
> add all the defines and stuff around it but that's not needed yet so why 
> not keep it simple?

Like you, I don't care much about the ICH9 device. However it seemed
a complex-enough chipset worth trying to model it right with QDev so
we could then split the code in QOM Properties / QDev API / real
implementation to prototype a DSL, generate the QDev boiler plate and
keep the implementation part. Again, price worth to spend a bit in
order to get something simpler later.

