Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35426D5E38D
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 13:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA8Oj-00084h-FC; Sun, 10 Nov 2024 08:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tA8Oh-00084J-Fv
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 08:54:35 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tA8Of-0000FF-Qi
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 08:54:35 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d49ffaba6so2470830f8f.0
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 05:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731246871; x=1731851671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=97TAfi8o2a0gLebk3yL8+YXPBNBslEYUE4GF2zvNkVE=;
 b=foMqpY0/F6l7wTZ+1cA2pThAfIBn/x/W3ee35nleijrFulz2bn1XOoA437n9I4DwOT
 Ew/ZAJd9X0uTJwHpVJcf6bIkMu1a1HlzoL6iK1H8Q8nZQpNAde6g30yzjoS10Wf/QD8l
 wgF1VpQ//hg7jdeB1P2Xsv+BOO4i0a922lrpSyfgzQ9jakLHPQLONw5ZsTa4mqjgZsGv
 eJchzRJC29LnNiW3xN3RVcUYxtclR/TRg1h6MgUbZI1iwzlJSNx9nUWyqhif0fVFKrEq
 kafmeV9RX/ZCmoOMufJIqIb9Co5WB7PX7+3kONr1TqjtEoUuPhMZ4tl5Pqfsx2yvmeP+
 qt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731246871; x=1731851671;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=97TAfi8o2a0gLebk3yL8+YXPBNBslEYUE4GF2zvNkVE=;
 b=LWf2KmPnchGaG16l8W08WdypnkP97gWw1gGqAqXdN9tNL6+LjMGyz1k0BW0+9b3mEI
 qRgajqli4AKAUnS+nc0u44wJhCKt8evzBpPROgTXhGRaKKnimYJCK+4aKMjxqE607Pal
 GT515YZc6J8EMZDCQxAdpuvewRrprFIRe+6o1IrSeIl4mwEz0HPhDaQ8tF5Vqaj4GNq4
 Ted72L/CJrKWhyH3qwD0Bhr3pewr5EWgRn5KnCryNxpd3ufe66DS30aEnig/NantUkep
 2OL4iMewdD9/E3/81i1ZnbKCOKgL86F/ELviba04xw7z9IOfINfvO2xXs62SKySHomRz
 3y5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJBCpQOSeASQJlNOwcBLO28yhoDI6dHzXmaoUBiHQl0olyUO+m9yVOqOPi4K9xTUemUIlQ7Vf+lvcp@nongnu.org
X-Gm-Message-State: AOJu0YzEazOVMobX/t8Z9vV4NuwXPBK9yvhEnmLxvyzf7DYbArsWNtMC
 i8687IponoCg4t+rSGRdUXYEPhhY7xPc4V/OKepbC4UR2vZQoGSTt3cXHaE9z04=
X-Google-Smtp-Source: AGHT+IEgUwtTyuwlNFcf6uaYwdvUQeDUiu/3sZsQOb9s+1q4w9Y7W6ervoh6NE+SdaZkbiQ8zMhXvQ==
X-Received: by 2002:a05:6000:1867:b0:37d:33a3:de1c with SMTP id
 ffacd0b85a97d-381f184c65amr6988958f8f.38.1731246870697; 
 Sun, 10 Nov 2024 05:54:30 -0800 (PST)
Received: from [192.168.69.126] (cnf78-h01-176-184-27-70.dsl.sta.abo.bbox.fr.
 [176.184.27.70]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b3de8710sm124626175e9.17.2024.11.10.05.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 05:54:29 -0800 (PST)
Message-ID: <1dc240cd-c35e-46da-959d-cf93783ee87e@linaro.org>
Date: Sun, 10 Nov 2024 14:54:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [CAUTION - External Sender] Re: [PATCH] target/riscv: Add
 Tenstorrent Ascalon CPU
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241108230709.1466634-1-antonb@tenstorrent.com>
 <4e7a4a10-bea3-4f43-b091-6a30c400b8bd@linaro.org>
 <CAN7m+mCqXz1YaBZpA-TFWz_TX0HiRorzXbaadn+L3fnigWBR1g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAN7m+mCqXz1YaBZpA-TFWz_TX0HiRorzXbaadn+L3fnigWBR1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 9/11/24 22:46, Anton Blanchard wrote:
> Hi Philippe,
> 
> On Sun, Nov 10, 2024 at 5:21 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>> Generally speaking (I'm not objecting to this patch as is), for
>> DEFINE_VENDOR_CPU() it would be nice to have reference to some
>> documentation -- at least to review whether the cpu features
>> announced make sense or not --.
>>
>> For this particular IP I'm not finding anything on the company
>> website...:
>> https://docs.tenstorrent.com/search.html?q=Ascalon
> 
> This has some more details, including a 1 page PDF. Should I add the URL to
> the commit message?
> 
> https://tenstorrent.com/ip/tt-ascalon

This seems a sales presentation, not very useful technically, so better
no IMHO.

