Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3089EC02192
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 18:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqfs-0004va-Q8; Tue, 28 Jan 2025 13:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqfj-0004u2-Uw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:50:52 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqfi-00007Z-EG
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:50:51 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2166360285dso102622645ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 10:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738090249; x=1738695049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xSSf7IgQXK6gMQWAfO++aq3NKrjLxffUMT4/QUlqwg8=;
 b=kV9f52K7Z/kkHGxXh22JkOSBgtOebbMX2I0ceQF2VMtz8Yjeyb+ATMn2H5amcPJ/bE
 JceKHEA4vydE/VyZLXALSVNRCWY01QCzUxJ55SZUPoXRwAN3+gdg31mhb8EYRtM8IP/p
 fdjpIzwMD0zhLPK2T/qEPb3yx8zEER5h+QhDvP1lRZCR+pN9TkQSr/PdHhy8DzSpWPCZ
 vQ0BwOdZiOhmWAd7IR5MGDbJhG8iqWCstcg7xtKSfEoAxuxkSMO9SjdWhXIvLvM2zy17
 rPNiSYi/nvEVsUWOpf3SGGNMHCHZ6QHSQ3M1xmh6uw2OLtM7q6LcquZe00+6v8IBCPYE
 VC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738090249; x=1738695049;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xSSf7IgQXK6gMQWAfO++aq3NKrjLxffUMT4/QUlqwg8=;
 b=weFdanyzcLD4Q1tPDB0a6elVsYT1I3HiZNq6cNJWM4MqLzfDqxor5VWP0D29z9f89I
 RnIYbkNEgNt2WV0pDPhWpm81gHinUflDpf7ln7FIj7Z/lvoxJeg9QhajRllwPOZj3hrC
 VGjB8cOALXwJuqbkBhMI8LLSTMbhPbntY1lt1Ep1qplYc8ksEGuRSspbyN6VyrMvPE6E
 8TskC8UNZ8/UpnDLOw48fv3FBxIoAb4eB2uM1A6ae9tL4XCKXjOC1Lol9qDywFBgUagO
 4AcST/Vcv9Fa7xJ/BF//80U2xxb8pKNbeknASIkGegMEpum8jHJ5QABsfkYvlHvOQK3b
 DX7A==
X-Gm-Message-State: AOJu0YyOUZbNGotQOFLZ938TCKT2K2MUVFtPSX65B5mRyJjNQRCYm5Um
 LH7bC8/3MQALoxARAHK3NLw313Xx4LGuSV2Q8OuNErpvax0ebK4xVi9UHd9Gtg5Q4JdSmbGB3LT
 V
X-Gm-Gg: ASbGnctVq+8aIQBYRO3w4Zp10S1A6i4/USMNih9nTygzzaSJDpJ+hyF8O2PQNvAcEzJ
 Dyb74tVrNC9YhL+ka4RnMTNfqFAJij2/z8n6d8ps0XeCR/RTUXuqTvVYDagv+OFo0Z5zEgdQH5J
 MJEzA8A776N3y/GkIN3TIWpF9zteTIgUDHgo7Vm6Cfuo0VCFjl5+1LmezBtAamRzQbVkySxtveU
 JzG2oMu8+D5/Iz+Sk/Qy7fjlcV7J7KVgTQtyqgCxlz8Z4lJX8HXIT5gQyMxO77hVJ/ELFwY8PtR
 zHEdFE81e5MVCt3mNBJ4UP2i6JdSMeozcMuwx1AArsKGsDFePzY6XrAHRg==
X-Google-Smtp-Source: AGHT+IGz0l6yF+DP+mrQhEf+McyqpABUkpUoFcRawusVg41Cui8jbKHnGx1PawlmdHl+K0BBwkAVoA==
X-Received: by 2002:a05:6a20:7fa8:b0:1e1:ae4a:1d48 with SMTP id
 adf61e73a8af0-1ed7a6e1696mr609126637.40.1738090248783; 
 Tue, 28 Jan 2025 10:50:48 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a78ee49sm9937925b3a.171.2025.01.28.10.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 10:50:48 -0800 (PST)
Message-ID: <e47672f6-5788-4322-aa0a-230fe1161ef4@linaro.org>
Date: Tue, 28 Jan 2025 10:50:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] hw/sd/omap_mmc: Do a minimal conversion to QDev
To: qemu-devel@nongnu.org
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-2-peter.maydell@linaro.org>
Content-Language: en-US
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128104519.3981448-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/28/25 02:45, Peter Maydell wrote:
> +static const TypeInfo omap_mmc_info = {
> +    .name = TYPE_OMAP_MMC,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(OMAPMMCState),
> +    .instance_init = omap_mmc_initfn,
> +    .class_init = omap_mmc_class_init,
> +};
> +
> +static void omap_mmc_register_types(void)
> +{
> +    type_register_static(&omap_mmc_info);
> +}
> +
> +type_init(omap_mmc_register_types)

Phil seems to be moving everything to DEFINE_TYPES now.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

