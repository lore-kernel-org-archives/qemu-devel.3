Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE43D70DEB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 20:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGlMN-0007ys-Pc; Thu, 28 Nov 2024 15:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGlML-0007yb-BD
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 15:43:33 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGlMJ-0008Cl-R6
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 15:43:33 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7fbbe0fb0b8so789097a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 12:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732826610; x=1733431410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YEgnz4LDHoycxkm56teE7uf6HIwUU1q3lt5ISgYJLL8=;
 b=jGlFHfNbJWnufqfguShMOn53L6AvWrCDHEI7hkBiHBmm9HTsGM9rACw0NFXA3hHDwZ
 ybfnCpYQG0UCQ/KmB3z/VfxmNvXm8fBF21gbtM/u9tWh2EwamwnqdHM6eDqa/wSuA7qG
 gpGUbM/Ef3Wi+9TjnOaDB99/T8ETmzAlTDIAZSfFRgyvA8YL7qIk2t9PHA9k8xgsFbVQ
 vC0CAFnEOtjnTTX23WtpAeYBmhuXn8feSpRqGBeqZCmP4BN3vlTwCT3wDetzYc8p/CWe
 w0XL/gAFu8sVrfWWh0lnJ14hfUDhKWUXQMcjWYYTRAclY+KSYWxTGjxh79rQOjlLY/Le
 YBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732826610; x=1733431410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YEgnz4LDHoycxkm56teE7uf6HIwUU1q3lt5ISgYJLL8=;
 b=p9nyNIHjBrk7l1u/dsn/esU5/cYk8R3DUsFwa7WUG/cz+DiLubo//ao0sadjFZHKk/
 BJM65O/9NDJdg7yyToyxgf6SWhL59Gau4+OFjI3z8cYFASY3h6KZ2HiNzd52xFknIaoL
 zPiMXIggm75eh5vXV2g/wpHTmM/+HZ/bNpQ2yTi5GFEeMNoUAS31YINxVnyBcH1GR2c7
 gkcO2PAIy/wnHmgHyt4jMSchZPqpfNFefbdUMSgo21tkSkTxb2D991NbsMIBfJlpbblv
 0r8wWHs0EqnUK1s5IIcmJQQIT1ep7ZL6Y5/WDKQcyllD5z6vExdSwgiENHxzegCAfdAj
 J5lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlmt5CYxxWXbRng/6aw+l7kMj3CNRKe4aKGik5mIF39G3ZINOfT96yG2mJ138b3azqZWpDiHDfC+4l@nongnu.org
X-Gm-Message-State: AOJu0YxStD7fcSi9T1I5902ZNbO0HW/SbYd2T8NCuGzG7SjNYNiiazJ1
 8Y3M5r8dBtWxoLvf9078vnr1wC8MST9UHc5cyJNlUwZNkwGO3qo+dm7LWu+TeIfCCcGTLCuhvv2
 6WEk=
X-Gm-Gg: ASbGnctW5SCJLAEhMSzf2rp56Gx0YS2SLXE59HKzIddWuqXpYE2jFe0Tp+EWP83d6Cq
 COBSB1p41SOnlPYm8K5vvNmKDlxMPDrhENN3oI/lLm5gsFQBjHhAzrRQ+BB3Q+DH94hQmQnfLF0
 jtV+dGiE9z5x3kAbhlRTZ9k7STmSP9xKJ3iImje86+iuRCA8nwd1MXOpofYXU2FRScmrKfecuCw
 ykBvHIOom1grXTg5KN5qzfiUIELpNXfnFDm7bWzyZC17j2A9b55e3+5OpraH19RA6qZsfbIdGTU
 tuOV67l7Oa7gJOzjC8Lx+g==
X-Google-Smtp-Source: AGHT+IGifS/r/GZ47aL6E3SKeNZ9wYqRipeGECA1ZB1NWhutpbBFfHxmAuIz3IBf0otCf9oP09X07w==
X-Received: by 2002:a17:90b:3a84:b0:2ea:59c6:d6ed with SMTP id
 98e67ed59e1d1-2ee097bafb9mr10927586a91.30.1732826610095; 
 Thu, 28 Nov 2024 12:43:30 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee0fa30736sm3907957a91.7.2024.11.28.12.43.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 12:43:29 -0800 (PST)
Message-ID: <584ed0f3-c237-4b1d-b023-2674952746a2@linaro.org>
Date: Thu, 28 Nov 2024 12:43:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: optimize cpu_index code generation
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20241126190203.3094635-1-pierrick.bouvier@linaro.org>
 <e5c7e738-3650-444a-bfa0-af6fff4e586f@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e5c7e738-3650-444a-bfa0-af6fff4e586f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

On 11/27/24 09:53, Richard Henderson wrote:
> On 11/26/24 13:02, Pierrick Bouvier wrote:
>> @@ -266,6 +266,19 @@ static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
>>    
>>        assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
>>        qemu_rec_mutex_lock(&plugin.lock);
>> +
>> +    /*
>> +     * We want to flush tb when a second cpu appear.
>> +     * When generating plugin code, we optimize cpu_index for num_vcpus == 1.
>> +     */
>> +    if (plugin.num_vcpus == 1) {
>> +        qemu_rec_mutex_unlock(&plugin.lock);
>> +        start_exclusive();
>> +        qemu_rec_mutex_lock(&plugin.lock);
>> +        tb_flush(cpu);
>> +        end_exclusive();
>> +    }
> 
> We already did this when creating the new thread.
> Though we're using slightly different tests:
> 
>           /*
>            * If this is our first additional thread, we need to ensure we
>            * generate code for parallel execution and flush old translations.
>            * Do this now so that the copy gets CF_PARALLEL too.
>            */
>           if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
>               tcg_cflags_set(cpu, CF_PARALLEL);
>               tb_flush(cpu);
>           }
> 

After removing the explicit flush, and relying on flush to honor 
CF_PARALLEL flags, I ran into random errors on values expected by 
'inline' plugin, when running a program that spawns multiple threads.

It seems that, when spawning them at once, we may execute old code 
waiting for the flush to happen.

> 
> r~


