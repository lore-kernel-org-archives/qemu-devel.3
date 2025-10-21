Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A446CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 14:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBDFB-0003zL-JI; Tue, 21 Oct 2025 10:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBDF9-0003z1-Hf
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:21:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBDF7-0002y9-9L
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:21:43 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4711810948aso39202795e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761056499; x=1761661299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TbDfCBsg1ewIRXAuyiRlLRo57QfPgJYdnTBew9UVKu4=;
 b=K55u4TSZzxK7QRYClxnKHJZVDrrTPz6PAKqHhm2FShE0LAMOrFyne0NzRwmrItMG2Y
 3QqJVQfvXgJqwb1kG7KOnImrGK3ZqCZHrre48LLhSrAwGo/k1Q2h/T2xQ73CdtkmeKmb
 6uwmlrwmowlFRi+w63vsgBsW4VxigFdBGTo9VRnHUpnjRWyCcoZ+INquITYlwjOMspHq
 3LeqEWCFT/NiQflJJbkMpwk+u9845ItiveKFTA8LkcGc7MNp26YEV2IclvO96fupcFXf
 75xMh08LdCuI7xz9092z+ZvCS4/kDjNAYsk5rOaKMdVN1AYN3B1SFLzzUyvFluy6VAUB
 xlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761056499; x=1761661299;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TbDfCBsg1ewIRXAuyiRlLRo57QfPgJYdnTBew9UVKu4=;
 b=XomjJw9Vra0WYKFJQ4efh448F7szzt/L+6QZbYVhv6N9rEgtO7RKr/d4C8Sr+XC9pl
 eXMJEXqIUvkEcHkdaDJZHcHxxQH8cim0Rk8LAVjLU2JPbACjAz3gTjKWf1zXR+SMQ6kW
 YvVImQC57oShymHeHdVZcuXzjOXOVQhtlhLaragLW7P0WQVNcDR72AZGYEifKXjhVWKY
 jVLnp+eQ5ii88jE1LuBdB52jnJX4pmSYu8q998BDePIHT+UTReLHQBcGNPZ6rCeZvrX1
 4w+sxOpRSKZgNdf48JDvbzQbLof0yeM0Hkcv31T+apPweexjXTCDJqqZou8rlTxc8WRa
 YlfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAWb1ZcgiIy2Ko9m/n/IRDF9s0boWXGLW5PsvOPIKvHftN3aEt9Aoi7BZt8wmeM1VMq5jv7QgeOZwu@nongnu.org
X-Gm-Message-State: AOJu0Yz/yHI7JayIbtprJdxSbQx38+W2a7T+ke6Le4tMD2oiVNP+0dv6
 fKE6npES9kpjgk9PQ8T5XZYz7fo26NL/jtWWX0XvczO/l83K+qTsmyPAMcZswxOSLBo=
X-Gm-Gg: ASbGncv5L3A2wMDH1/zXJWV8MnCFQQM/Q34iJdkOfjy0RYwN2eVMB8qKmX6WKREQJOE
 uRqURoH7TfEaL29A6LzfdpFg78zyMXrGjLBYsuMz9r8oo3nsiIW+IQ/qBdOiJ8nK/BxpE6daGej
 xirGS6wstwfZxIPKrDxpC/m9FvFRdvmzXgSAVNC2HwlwhxO4Bgr8/076PmwdasPveqxsNvBtQMa
 NEfzCV7Cga0OTPkI413mLGFcZeyo1U3SM00g9zRb5MEJLIpzsMBlvIN0OuSXp3SPy8IGaZibb4l
 lzP7ehqOFuZDrPmhYyLLFEgqumW+8yfkzUCmbvsfx3fZFW5dIeJdhXn1ijT0G9mvszjDVVn/5nl
 q5b5gjuAG+C7g2uv5EEDYO8MFfZVT4vlTJbUGzlQA6sioADRV/VTiVzOlUphJ3DarZuXfrEnlkD
 Dg0ACjt7/lKTCfc8p3h65m+fPopF1IYELcJFgfYb2S3Wo=
X-Google-Smtp-Source: AGHT+IFEizekRvWtYb0p6De8rFWOEeTQOsDv4QI5SV5e4hWTGxEDcjnyTvXlhwsnfp48OL5LAvw3Lw==
X-Received: by 2002:a05:600c:64cf:b0:46e:45fd:946e with SMTP id
 5b1f17b1804b1-4711791ad90mr128608015e9.31.1761056499582; 
 Tue, 21 Oct 2025 07:21:39 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144c82b8sm284071655e9.15.2025.10.21.07.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 07:21:38 -0700 (PDT)
Message-ID: <d264c81b-119e-439f-a4c2-68a7336d6ba6@linaro.org>
Date: Tue, 21 Oct 2025 16:21:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] hw/ppc/spapr: Inline spapr_dtb_needed()
Content-Language: en-US
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20251021084346.73671-1-philmd@linaro.org>
 <20251021084346.73671-5-philmd@linaro.org>
 <602c19bc-bed9-43c2-b98c-491b75921604@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <602c19bc-bed9-43c2-b98c-491b75921604@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 21/10/25 15:25, Chinmay Rath wrote:
> Hey Philippe,
> The commit message says that this commit is inline-ing 
> spapr_dtb_needed(), but it is actually removing it. I think it's better 
> to convey that in the commit message.
> Or did I miss something ?
> 
> On 10/21/25 14:13, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/ppc/spapr.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 458d1c29b4d..ad9fc61c299 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2053,11 +2053,6 @@ static const VMStateDescription 
>> vmstate_spapr_irq_map = {
>>       },
>>   };
>> -static bool spapr_dtb_needed(void *opaque)
>> -{
>> -    return true; /* backward migration compat */
>> -}
>> -
>>   static int spapr_dtb_pre_load(void *opaque)
>>   {
>>       SpaprMachineState *spapr = (SpaprMachineState *)opaque;
>> @@ -2073,7 +2068,6 @@ static const VMStateDescription 
>> vmstate_spapr_dtb = {
>>       .name = "spapr_dtb",
>>       .version_id = 1,
> 
> Does this version number need to be incremented ?

No, this is a no-op.

> 
> Regards,
> Chinmay
> 
>>       .minimum_version_id = 1,
>> -    .needed = spapr_dtb_needed,

Here is the inlining, as '.needed = true' is the default.

Would "Inline and remove spapr_dtb_needed()" be clearer?

>>       .pre_load = spapr_dtb_pre_load,
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_UINT32(fdt_initial_size, SpaprMachineState),


