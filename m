Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F266C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBry-000430-Ru; Thu, 22 May 2025 15:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBrw-00042d-Kz
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:46:20 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBru-0005Ty-QU
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:46:20 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-30e5430ed0bso8258634a91.3
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747943177; x=1748547977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QRQvRcGWje8aYe7d9iXGg7V2ptAjM+lXsSFvmidvhkY=;
 b=GNa3zSevmVsFhW7ZIyPsrkUhpCkAaB+i28g+F4oizLd5Ut2KdezpWh5ck73rWctjAo
 jZ7wMknFykcnA2W5/dNaFzJW2Gydscu8YkWs8VLSL3SsUdo6DfurqHeYyUCWYoZw5V0S
 OVkXEbtQCCYTXqL3FnkvPJBJ33+AdFWUa3BJob2sE3Xv0Fj6WplOTUuoy/20o9r+AgX3
 2BPsVrXZthEFOCANgn/mqY38gJhwdloF7Jvsm8mtLnaHI79q6C7Dy48ywTTPHpX22XEM
 B0AWp6HCBeesN0+SqkhNZn+orwHTn1/T+mvhOTU92wIrg+TO6BdAHtFVHASAhRKrht46
 0Zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747943177; x=1748547977;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QRQvRcGWje8aYe7d9iXGg7V2ptAjM+lXsSFvmidvhkY=;
 b=gkcgQKzlv/Xy3fKHT/8io08+cz3ghwoyl9nZ2D1Jqh2teXPVS2LADle/21eySFX4qL
 SeBnklk125Ll62m+BveDIFjD5wUWKWroe9aJrVFTNulckU0u0E5xnh+ZtU9hvaljjXEB
 sdMwkB6xaM2HmxQE54hMSoWX74rYqgw+QlopO9mlGxsUZvX0AVobew1wYG5NibuqGeRa
 DypjJLjHP+S1eZtrnSPsOpsocGfsOTB/+2lTek8Uiovqf7Eao/nBsE8ZcNNgS0xxmkJj
 jUvX9H1qZuBGUOA75dMlMV0/2XR8gpvUupfvxlgGcyPCEuMjfAwPNdC4jmkd7cGWmi5E
 HUeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd5gizSAPHNC3QSvQxgqAQrSl/7AZ86JY28/CmoB/WcAjDsEubObRl0+VP7W2zVC2iLTn7TreUXcY3@nongnu.org
X-Gm-Message-State: AOJu0YyC3G7Sf1pgdeEcSUcvT8Zj9Ip2u2dnO95g9ftde5G0sw3MRdhq
 pfQCmp+SD/ggIEjJ9mLlQLSQsUonHvPiMG1DvkkrJHLLBDC4b2t7+hhi2oAXDAiaxq0=
X-Gm-Gg: ASbGncvOBgduUg7Iu6hf0nySQWZPWADZkO+TK972pKqvnSVtlkSpSVnhgvgO4okFGei
 OQJa2LT0NuDQFhprmyaI+xjq11WLDSCy4vqiVIXt0nS5dZvqFCyycJL9pVhyCaUdRIhFWkm4tam
 7/O3oSN5/I4CdP99TysUPBht7+0cAXNkNeJQ3t9Ge5RwWmOtPyex1/COw/0WGenStSoB8ZMh1xu
 P2HL8fbLmXvNSAFruC37IfE2AQSR3ULixAViKKD1iY3qI1CuILpQD7vlR/16n04SYe8TJDZ+5M+
 ZMeB+4n66T1Qq3fLnEJTqkPfNo5IlcIRA9JUrwVSPo+jtWs+LBLEUULl510pK6WW
X-Google-Smtp-Source: AGHT+IGW5Aq+SpOsTVeh/sdWXtsmz6NoW86s6U2Url5E92qbHtv2L//Ox2tELfTyJyj3BN2i5K6nTw==
X-Received: by 2002:a17:90b:51c2:b0:310:8d7a:cfe0 with SMTP id
 98e67ed59e1d1-3108d7ad020mr13025504a91.16.1747943176635; 
 Thu, 22 May 2025 12:46:16 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f365e545asm5900212a91.31.2025.05.22.12.46.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 12:46:16 -0700 (PDT)
Message-ID: <39d3cfdf-10b6-484c-824a-fe84377acb54@linaro.org>
Date: Thu, 22 May 2025 12:46:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] Add memory hardware address read/write API
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-6-rowanbhart@gmail.com>
 <348a6c09-3c8d-471f-af6c-e8201760614e@linaro.org>
 <9e1ebea2-bfbf-4ba6-85fa-c068d627d9e1@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <9e1ebea2-bfbf-4ba6-85fa-c068d627d9e1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

On 5/21/25 8:34 PM, Rowan Hart wrote:
> Well, first I just noticed that I left a debug print in this function!
> So I'll fix that.
> 
>> Reading this patch, and patch 3 (Add address space API), I am not sure
>> AddressSpace is something we want to leak in plugins interface.
>> It is a concept *very* internal to QEMU, and not reflecting directly
>> something concerning the emulated architecture (it is related, but not
>> officially described for it).
>>
>> The same way qemu_plugin_write_memory_vaddr is only valid in the
>> current page table setup, we could assume the same for current address
>> space, and return an error if memory is not mapped with current AS.
>> Eventually, we could read/write a given hwaddr in all existing address
>> spaces (starting with current mapped one), if it makes sense to do
>> this, which I'm not sure about.
>>
>> What are your thoughts on this?
> 
> I definitely see the arguments for not exposing it even as an opaque
> struct, internality not withstanding it also adds some complexity for
> plugin authors.
> 
> My thought with exposing it is kind of twofold. First, there are
> specific address spaces like the secure address space on ARM or I/O
> memory on x86 that plugins might like to access and I think it's easiest
> to facilitate that if we just let them choose which one they want to r/w
> to. Second, I wanted to lean towards being less restrictive now to avoid
> having to go back and remove restrictions later since even though it's
> very internal, it doesn't seem very likely to change.
> 
> That said, if you think it's more trouble than it's worth I'm totally
> fine with just defaulting to writing to the current AS (or to
> cpu-memory, whichever's more reasonable). Your call, just let me know
> which way you think is best for v4 :)

I understand your point, but to the opposite of registers, I think we 
should refrain from exposing all this.
For now, we can just use the current AS.

Later, we could consider to add a new architecture specific parameter 
for that need (being a union, with fields per base architecture). So 
people writing architecture specific plugins can have a solution.

AddressSpace as = {.arm = ADDRESS_SPACE_ARM_SECURE};
qemu_plugin_read_memory_hwaddr_as(addr, data, as);

>> qemu_plugin_translate_vaddr is fine for me.
> I did have a question about this -- one of the test plugins prints out
> vaddr, haddr from qemu_plugin_insn_haddr, and the translated haddr from
> qemu_plugin_translate_vaddr. When running with direct memory mappings in
> a system test, the vaddr = translated haddr, which is correct, but the
> haddr from qemu_plugin_insn_haddr was incorrect (it was 0x7f....f<actual
> address>). Is this expected behavior?
>

qemu_plugin_insn_haddr returns directly a pointer to instruction in 
(host) memory, which is different from hwaddr, thus the void* signature.
Name is pretty confusing though, qemu_plugin_insn_ptr could have been a 
better name.

> Thanks for the feedback!
> 
> 

