Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56F2C36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtEY-0001YC-3v; Mon, 24 Mar 2025 21:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEQ-0001WB-LA
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:31 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEN-0007Q3-Ow
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:30 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-225477548e1so93982975ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 18:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742866646; x=1743471446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EJWH1JQ3QOsizwZm+yB1jnOQjFplJCPNhPrOKRo7MRc=;
 b=tOmiZG2NJ9h9JR85+PZdd079n1mFQv7WzlyzHQ3Iywjj1AB7Sv5ad/bhkhqIVPzD8B
 nBBJJEuzBRX+iv9QgIjBPuYfePXkKQ2a3JltEyRWtLRUL3yJH1w0JGuw8LrovnxlOLtk
 qq1tSv0IDLsdBEslLY+7GRPxmf8yopL3kL1G0ir3arCItI4gDHiWpoHFzPwvGIBJmgm9
 22Bo9I3J/svt5zcAV/7Z6yGvqMVqlqJ6lHPDZak1IHMktStLgDlG3kVfp3Doqq88nFCf
 VROMWg51yUn61bZ2l6UTFz9I/VNoXU0Ha0MMdo9nu4L2+Gklp7DAPppPfOgTjh+/hhG6
 zkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742866646; x=1743471446;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EJWH1JQ3QOsizwZm+yB1jnOQjFplJCPNhPrOKRo7MRc=;
 b=vnzK3Lv0ShCv+7UGcwcykA3H94abPeDPNE9mN2HOgMiJ23RBfWoMvXTmXK5ZnpZxz6
 z02g5pAlhkus5rqQtqr+Whydb+7P0xpYQxPdIKx0vJ+f6D2xm+W/QpqvFPOwaDz2jSE8
 Owh1SQGuj2y/ob+AEP2uSB9NELhhtRC63Mj8uRm5ODh7dOWTk3K3c3nc0Ex4pjrXL2CA
 jCUIRPDUhokjeAJUZWBLH1xXxLC8tpWy4IbbjiAoLMQ6GcW8AdoY7gz9YEka6onZac/r
 Yl3AhVJDPmiONlfLOpwKlZ3wuS215Qn85A4EzQG94oewuBGHALWASAKPF8poqxuo7UIC
 IiXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIP9Hv8Sv++tA8rFkltBbzkhkr69YkAQUnWb758KVfGA7jGmNJO6ylZaFvcpcE4mnJWkRlZonn2QbL@nongnu.org
X-Gm-Message-State: AOJu0Yz6tDt2jVf+PYy8kaM3CkAtDwJRskmsgvhwIHgqKPAXAm/BU/ZF
 1Saax4jd11fnb3aSfEyprAucvE9NcPTRkwCJGNwyQzQSF7sWun2tKJlg7qGhXOk=
X-Gm-Gg: ASbGncvMxlzyLsnE5JPwww9f4JTs5X4Mr7k4N5qZqDLaBHrxHzbh2vQ5IeiV5b+qfGE
 e9ULqJ7JoC8AuA1/gFG868oA7oIHdzl1gbhHXEFIXw72sjqvtPwegXflsjqIjsdIkpmzb65Oo0W
 IPJ/8ZkvYoV7/lv2zJliynbbvEYanNragPet2R1MfZ0F+Xdm8JQ6Z5F2exe0YATCS3Q3Z0MnmGp
 NMJiWfmfPjAeAp+Z9VVwf1uVHhIxz68vT9OduDr/LAhHm/YHWWBXVr2l8Gpxv9ZNVHEyBCqNZDG
 QyYq3prDR5ezJ1m4YG31281N1fU+VdRwYme3LXw9tqBt/n99RWSWVrTLeg==
X-Google-Smtp-Source: AGHT+IHQVL5P0tb1UfuO+Eo0NH00Psvv9pqc8tos+3iEM+D2zVNr93jTENHvuGDRSzVzlu4yUC/+IQ==
X-Received: by 2002:a05:6a20:6a1e:b0:1f5:70d8:6a99 with SMTP id
 adf61e73a8af0-1fe42f08ea1mr23781170637.4.1742866646223; 
 Mon, 24 Mar 2025 18:37:26 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73906158ef2sm9090422b3a.141.2025.03.24.18.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 18:37:25 -0700 (PDT)
Message-ID: <d76e4f0c-bbc1-48a4-a841-a38fecc07fcf@linaro.org>
Date: Mon, 24 Mar 2025 18:20:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] target/avr: Handle offset_io in avr_cpu_realizefn
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-14-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323173730.3213964-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/23/25 10:37, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/cpu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index e4011004b4..538fcbc215 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -161,12 +161,14 @@ static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
>       memory_region_init_io(&cpu->cpu_reg1, OBJECT(cpu), &avr_cpu_reg1, env,
>                             "avr-cpu-reg1", 32);
>       memory_region_add_subregion(get_system_memory(),
> -                                OFFSET_DATA, &cpu->cpu_reg1);
> +                                OFFSET_DATA + cpu->offset_io,
> +                                &cpu->cpu_reg1);
>   
>       memory_region_init_io(&cpu->cpu_reg2, OBJECT(cpu), &avr_cpu_reg2, env,
>                             "avr-cpu-reg2", 8);
>       memory_region_add_subregion(get_system_memory(),
> -                                OFFSET_DATA + 0x58, &cpu->cpu_reg2);
> +                                OFFSET_DATA + cpu->offset_io + 0x58,
> +                                &cpu->cpu_reg2);
>   }
>   
>   static void avr_cpu_set_int(void *opaque, int irq, int level)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


