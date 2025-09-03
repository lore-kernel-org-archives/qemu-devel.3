Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3B0CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utnPh-00036U-Ok; Wed, 03 Sep 2025 09:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utnPe-00035z-Fk
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:20:34 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utnPS-0005OD-6W
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:20:23 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b04679375f6so118425966b.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756905619; x=1757510419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dkvogMwXSsy2T9zMaOlvSWZf/W9NZy6GihKzIwxJFdM=;
 b=P7UVC6IQIx6mmFLM33sZWWwecOKnxbQo67aoYGtgg5R+05xLhzRoAtjXPWcv8sXGSJ
 gAyqdhkIHTR+mvBTKp5w0zonEzy7FXl91SmkIBdjEHQqENXmkCfhcmPQKOZSPAVp+HFO
 cxck09Sc69/mY7bHQ5pzPfcwmqhPMVyo+h4+4dAPii/rweiSPmZA+OHroMgTjfllZRIq
 bdklA3tyUvDAV7JN8I6+y2a8YiqIWOC4nqlcNnrhjZqsKJ65/JzwIc3ht7yiFQxH/UHp
 wQKi6wXXFSzI8J2ROOozd6YKZpGapG/OCHFcU9n7PQBi0IvT1xItZA3u/FTxtjFC7M8J
 WrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756905619; x=1757510419;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dkvogMwXSsy2T9zMaOlvSWZf/W9NZy6GihKzIwxJFdM=;
 b=ghd78PVy3MwIuVkDXyBGn9xbELPX+y03cNKMkgQ8MsS+yO9Xpiiktpi4f1UiTNRVBD
 P5w0PHA0JFyLREjpcMIvSmmrn2dDxN9fg9xqmwZDrLaqEmBcpNCBpkPZEfAwcsO7jFM2
 ubyfb45jOtzagk3wAyl5V0r2/Y/WTe7WKcaz0mryCVlpz8W40Sez50MX97i0MUvHLrrQ
 1LVuWPo8ofAe/U5O1WS5ftxQ7asSBvQ3kSlgoOlaJ6ukrQNwTiF+HaRIepYhvd+lRJZx
 h6xvpMYLbt1HPweaR+2GMPcNVx0G4o2BXxpt5wwwBkDrvz2LMd1xdQ0+ZCecdRg1Ttu9
 m5ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3JMueIcfVxuX1IcHVlBMs7TwbLp90uyi5GTTi75FDahgplz4gpAoGI6x5Z6YBOMAmy8qkveotCa3+@nongnu.org
X-Gm-Message-State: AOJu0YznZURxziBltWfdh2iqcEQLDe+cShQOD34wy6eDG+NtTzRKVv2U
 RB8uitNaAdPuywQZ9cMTdXr6y+MONRFDg34IpRGSKV4/12vhQY24Ns3LdzqvPD9HETv4zVT3sUh
 wP2Ja4ig=
X-Gm-Gg: ASbGncskF6a3voN7SqExCtI0K1LOsSNLnVag4H9vZbP6hj1BqhF4jyk7WJSwLn1HA/9
 yb5odTM2ML6DniCN1cYcaPLGF/KiyU7iRA009faAU+4sFK1lvxmbatbZVyuv+cqn3IxPsh+X8DR
 8QMt/PfwNCMkWmENMSAfoVDH9KVqLKrQ6zKbSU69C2cKZpsqaEW8YJqmWESGQc0R4gCC73GK+Lj
 nC0HpPhwZ2yZBYczEnvP++dksaV4ggAsYajIRbFqzSo5fuBzHUNDIwb+xAVaHquLzrdW2WOpjyx
 GWl4ajev+uC7fZ4nMjaa8OuK7j1E5Wc7oH4FJoV+/00lXOfB0SHB9Rvv2wrwFBgVlaDPm0gM6vD
 xii8s4DjYUt+WPPaN/wt0CWM1GI7hxlgG8KFER7I6u3/Tm5bdGeHbpK6aRQnOCqINgEL/1ME=
X-Google-Smtp-Source: AGHT+IGikQ+346rVMpYpeSkbN3PUtF51kwNfaE2OeY8FybkzyyuuNbd1y4jj6sR+awVSRGugKV7iJg==
X-Received: by 2002:a17:907:6d08:b0:afe:8c69:4c3a with SMTP id
 a640c23a62f3a-b01d9743c4dmr1413919766b.37.1756905618839; 
 Wed, 03 Sep 2025 06:20:18 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff0681aefdsm1317262766b.8.2025.09.03.06.20.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 06:20:18 -0700 (PDT)
Message-ID: <3002fdb0-35cf-4146-8451-7690064a1460@linaro.org>
Date: Wed, 3 Sep 2025 15:20:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] target/loongarch: Use loongarch_tlb_search_cb in
 helper_invtlb_page_asid_or_g
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250903084827.3085911-1-maobibo@loongson.cn>
 <20250903084827.3085911-9-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903084827.3085911-9-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
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

On 9/3/25 10:48, Bibo Mao wrote:
> +    ret = loongarch_tlb_search_cb(env, addr, &index, asid, func);
> +    if (!ret) {
> +        return;
>       }
> +
> +    tlb = &env->tlb[index];

Perhaps it would be better to have loongarch_tlb_search_cb return the LoongArchTLB 
pointer, or NULL for no match.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

