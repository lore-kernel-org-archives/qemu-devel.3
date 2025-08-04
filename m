Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BA0C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 20:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj1zV-00019O-4z; Mon, 04 Aug 2025 16:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj1zN-00017i-O3
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 16:40:57 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj1zL-0005TG-Pi
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 16:40:57 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-24041a39005so24431355ad.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754340054; x=1754944854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DIqNgHd7Qfr/99sqjRrIS07CWF70FR9fAXJbsoWq+Hk=;
 b=kmnyt9TyrxNEnrgaZgoRNYhLJaK8Ek8mkFGF7QEtLHYc8utEGDXa9a/FstAVIi/8gL
 Q83GQb7RDTgTpg1llH06FN6gmFCsxPsNRy33fS3kMYpfQ0PSvgGfukXxi2o6eIEIA2u0
 uEfGmTaZxphk+BE/lHSlEW2lrRMq24cyk1Buk4+Q3rzZP7pp4szGG4B6v+SJX+CAitm0
 55wk4akmuKJMj92vXcwyQ0/FNdvFhJnhP1uVM2nK0rcL4RYsDTpGbDO99sYjrA3s8TpJ
 rVngxhlpQkrrC01db4v5vKxtjNlHVSdgC5A5cg8ChHOvp1Nm2wjBNjnH1pPnEGH1BUOL
 IVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754340054; x=1754944854;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DIqNgHd7Qfr/99sqjRrIS07CWF70FR9fAXJbsoWq+Hk=;
 b=RUtMJDlPYmaiwNcdI5Uc6jj9ea6GtlIi737cBBnfMXMsmKiFKocBWgEflnu55v3Lu/
 w9jTfuM7IVggxetUgxMqSwwWvWAGsJBzoL4U3TElEATBtU0usRbE2CJP7wnOlKjrNnu2
 ohhtcjTBRJAmOnQHNkHXRVLU+h0pKT20SyXDBzr8K3CQZBGbN3NGly7qGfcBWulLbFRL
 RTU7YNj3RtoPzZRNmPsszblmtZJlix5B4XmEbHY7xsk96aRQqdsl53NoQLKO+88GCqjn
 Ek+6N8tkqOus/XlRvMBw+pXvXz1PE4UM7bfkhysU2er8asKkxHOqCuct3JlzxPxpFHCn
 Bglw==
X-Gm-Message-State: AOJu0YzT6cAH8xtrZN4gW7HO6zSajp4yvO+p9lG8IZGreF5nI/bOGjKA
 ePXC3ZCrkDHqPecVyMMIGv2No1slHtISkijd+oiphIw7tfa4MVMeCUs3UBGVUEJxC8w=
X-Gm-Gg: ASbGnctSk3lorEqr8Z6H0u/9D36VGX/B942ErMnGwLfn+H3e57c+W5PuACRoiGgJPBj
 ReM48Rw8iSjPupnGHtFy0wjOI1Lx9e2dCwGxlKoy49kQbwZX/8uGdFrWSu8+bxEGhoJjPD3+wkV
 AwfnU/6PkLW+RcEpRulyNevR1yU0ajYnbiuCwlb7QD1lAgxtSdqiji7ikw7T+yS/nGX2p5cSXp6
 9l5vQk+pTMRluXFgFgm5APb4dPruwDJ1R0wQDKmfkLUxcgw7msP0PZ3CXwfLRxe5QBJ3whqobJv
 IFIOhIsgMxUDzPgaoISPDz8QCUNDLRTzWrWFIzWO9seIoyAzBgEJQ0zsW+YsnTiH8hIleCLg8+g
 WRyEALIOtXfaLwMegzqwSY4ZYOh9h2Z0AUYE=
X-Google-Smtp-Source: AGHT+IFamTuQBRUrx54k//XF32AinKYedJWM1tRSSm1V8diCMG9PoMVz4ZsHBh+DaOpzFnnK1tf+4A==
X-Received: by 2002:a17:902:db11:b0:235:7c6:ebdb with SMTP id
 d9443c01a7336-24246f30406mr153639145ad.10.1754340053697; 
 Mon, 04 Aug 2025 13:40:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8976879sm118180175ad.76.2025.08.04.13.40.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 13:40:53 -0700 (PDT)
Message-ID: <2bb26ff6-8ee5-4255-b8df-27aec29b56a9@linaro.org>
Date: Mon, 4 Aug 2025 13:40:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/17] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-13-mohamed@unpredictable.fr>
 <a8239e8e-37ad-415c-b13a-4b4ce8fa2a36@linaro.org>
 <2BF73501-00C6-4194-B75C-CD50A8807314@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2BF73501-00C6-4194-B75C-CD50A8807314@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 8/4/25 12:56 PM, Mohamed Mediouni wrote:
> 
> 
>> On 4. Aug 2025, at 21:50, Pierrick Bouvier 
>> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
>>> Windows Hypervisor Platform's vGIC doesn't support ITS.
>>> Deal with this by reporting to the user and not creating the ITS device.
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>> ---
>>>  hw/arm/virt.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>> index 98a1c74c42..0039f6a12b 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -741,6 +741,16 @@ static void create_its(VirtMachineState *vms)
>>>          return;
>>>      }
>>>  +    if (whpx_enabled() && vms->tcg_its) {
>>> +        /*
>>> +         * Signal to the user when ITS is neither supported by the host
>>> +         * nor emulated by the machine.
>>> +         */
>>> +        info_report("ITS not supported on WHPX.");
>>> +        info_report("To support MSIs, use its=off to enable GICv3 + 
>>> GICv2m.");
>>> +        return;
>>> +    }
>>> +
>>>      dev = qdev_new(its_class_name());
>>>        object_property_set_link(OBJECT(dev), "parent-gicv3", 
>>> OBJECT(vms->gic),
>>
>> Is it equivalent to simply using its=off, or is there a difference?
>> The info_report seems to imply it's not the same.
> 
> Not equivalent.
> 
> Regular system: GICv3 + ITS
> This configuration (for the newest machine version): GICv3 with no MSIs
> And its=off explicitly: GICv3 + GICv2m
> 
> It became not equivalent since the intro of GICv3 + GICv2m in patch 2 of 
> this series.
>
> Thank you,
> 

I see. It could be worth adding this information to commit message.
With that,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Slightly off topic for this commit, is there any downside to always have 
GICv3 + GICv2m setup enabled? Do some systems don't support GICv2m?

Thanks,
Pierrick

