Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48CFD6ACFA
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 17:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGMHv-0001VD-8D; Wed, 27 Nov 2024 12:57:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGMHt-0001Ur-GT
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:57:17 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGMHs-0004Zd-0O
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:57:17 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21210fe8775so9786195ad.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 09:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732730234; x=1733335034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vdZlD9NB2xYXVFjy0+o/KWhM2VuxzZXpl7hl6+ZRDEU=;
 b=kyhTMsBx/14CiF87UboijEXeIizQ/8ugKSJ+yOLCBFpb8Mikn0WFKL3nrMUJ7Y/Tt1
 IsL5XqzYraGm3hp/shdMopgmdY4Q1wZLEmlIWjN9O+zQq8M/IwwoxV6nMhbpAK2HX55E
 muZ+7btyarLFR1Vi1KjZaSqcqvJcpzaG0Cv/3PpnmTiIwESQQHY5i/kzntYOoqricVcH
 GaSGtu67EtTS+3cuSuxeWZERzMT8IX0GYP81edJC3/EMX3Djbvsw79OjnqOFrjGGtyBp
 IhSrut/KjgftQMwqO87OlNJVmcGa/rW0zQjW1lwYE7L1w/Mp8fAK/HanOZu9Uz8xtnxt
 HPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732730234; x=1733335034;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vdZlD9NB2xYXVFjy0+o/KWhM2VuxzZXpl7hl6+ZRDEU=;
 b=hg93GQchCnW22e+9zkS641R1Hicu3IHM3bXzCCKVF8I0mTNn1CXiqqH1uzTafaTtHr
 isfTNgqftosAZLqkF+LkdIyhMNlvI43f2qzt9RJ9M5D7xsVPQF8snz03vUeHvyAGlDZZ
 264KYAZ/uDyN3SgSV9fX2ZvW3q4yAdN0ylgE/mmmsiMzxdD5+1kl7WfyZ7c4MGW8LUX/
 dRyvd99CQv67stO7BqjyApAT8OKoAZEuhNuFeklDcICY1riuO9fL8jn+b/g63Pvt1z9B
 YQ0xsxawDMRVQ7eTue5zffPjc7KFosuufqTPLsTPtw0C8Wb+U/hV8kaFwLl4HY8zFwQM
 DYyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF3cPvZ+yOsi0usgZJdiLk1bD7HyW8hNYZVFvjj8kGlj74eyISPnR89mNIAVhDn0vq6fAWinO7v/VF@nongnu.org
X-Gm-Message-State: AOJu0Yx6ppPyO4GnlDQZriVySVYEui4FKF8Jbmy0nkkXdiPKySpRSvkB
 i14D9QFGIYpR06dkPyV2G7A3VyRLNJMwKLW/TbAGYuhckkl2HDhFkj7eVAK1Ohk=
X-Gm-Gg: ASbGnctf8Veop9Ul5iTgUq9Xo2j3fs/TGYRLp+kreuFHgWlFTeXpWNy8Sc56NHACoDo
 4ydf8Ec3daBrMijb7u1S2o/XNhHVkYxogM7zHbhJ+6lfZAF9uwS6OyZVeXPhS936zWwTQAZEZOv
 ft+akEqJpaOpoksFnCpac+xkYv0ZPQP5Jx3VKOFC1YpAkVddAdW/VVQ4JJVQZpdkXs5DvCgMidF
 PZQSfwEHg83e2Kt3/5jaLEbiVX5gviZSB42Z07Nn5kxVtjolb8bn1bsHIom4CLt7Oq3I5yYJy7Y
 BhZ4ZzIlqkidFriqci5X6g==
X-Google-Smtp-Source: AGHT+IEFUtLSLs0Bm87YoL9paLAh7tAYruGRjONjKhgkkQvnadYrlwgajZpkNKYqwvad0e8uSNuVQQ==
X-Received: by 2002:a17:902:f541:b0:212:9ac9:e3e2 with SMTP id
 d9443c01a7336-2151d32fa20mr3885575ad.14.1732730233813; 
 Wed, 27 Nov 2024 09:57:13 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc20ac2sm106016725ad.231.2024.11.27.09.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 09:57:13 -0800 (PST)
Message-ID: <7355ede4-390b-4870-a59a-a611350e9e3f@linaro.org>
Date: Wed, 27 Nov 2024 09:57:12 -0800
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Hi Richard,

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
> 
> r~

I noticed that it was redundant (for user-mode at least), but it seemed 
too implicit to rely on this.
As well, I didn't observe such a flush in system-mode, does it work the 
same as user-mode (regarding the CF_PARALLEL flag)?

