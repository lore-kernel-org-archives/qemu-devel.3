Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711B0CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 15:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo246-0005xp-5z; Mon, 18 Aug 2025 11:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uo243-0005xG-TN
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 11:46:28 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uo242-00064V-6o
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 11:46:27 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b9dc5c8ee7so2743208f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755531984; x=1756136784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dds0tn6MRRRHYDemz5yb23FIvqxeCiaggXHXIfIXy/w=;
 b=zZ052KzHOJHnT4RI27AheL7I43aSGoP/rgyaj/wREbxyLi30eHx3yer6b/w5+yBHjV
 GlJIx7/TF6nzyk94ba1u73eKd5j0MJ6b3XiK1lPu0eUbXdomd4z/7GIoW0h8LfHEbjFQ
 pn9rqZraXTKWLlKZ8bfdPTO8tkOPpeLf5cf/2SpZ9LiEi7Vu94fCWNi6VCP+n/8P4IMI
 r4MpkJZcdDXCPAuJMoaMrRhkOLOVAyVIf1C8FxHwufI9da+1Op0ujF1zjMT9x1lS1V6U
 PyM/ZcZufNzhy+Ymp4qrDNY0Wu33BiwFX5JwMCGIcLH8Vsbl6DlxOw7agdTMQHTyUVIi
 YPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755531984; x=1756136784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dds0tn6MRRRHYDemz5yb23FIvqxeCiaggXHXIfIXy/w=;
 b=iB+ctuO9jCkD6lFgTwg/v0aoyf9levOLlUpOfiG89samn4ErRMZNZneHiXy519CfJE
 G+kr7TgY0Zz5cFJjM4VQd+ijtsXzsT5nuDqbpVRdO9YBAyUZE3ou61PPO910/AqYTw2Y
 uJyR4Xzsp6Ojs3S5XiS0PgMBy9JmHVluHLWEsvBn3k/cNXFUfXCh5pSkuJUVEdxizXVv
 +7WdMqRe1IsqJyP2tOdJX0TuXfhD6gxXTZO2KI2DFk6fAKosX3WlaHYaNKn09kShBJ2h
 2f4wKeRVFKWcFIEmiIIgA65ggnvaB8512O59prmTQNbSKJdPX+GOgrnX1pIk3ahpscND
 b75g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp5zxLnkZRcMWol0iB5hAMYfXDWGSwIuqVvyINIWA6Xaf/mTcGd0p0z9003+0paIzWY92gMFlDbPIF@nongnu.org
X-Gm-Message-State: AOJu0YxsoUwsdJvlhPVJ3OO8U+4pRtUusYANS8VXt0Pe3X3KeFpcmYso
 NfSH9S6cpP86QaduZiBpx+SEAujBP2MjOkTMWesjosO7c+IYF3nYYFzcqGqPX1WugCE=
X-Gm-Gg: ASbGncv9/jnClm7fySEmaRa7yYAaEcnt9v8E9B/abfxYAQREvFNRzOjK3MWOON2ZhUX
 z2ZfjXlfb1Jz4y6ArgZ0q9GiQiVmQFGxLOuhrgX6E+RQdwDMrH7/6SLzCAa9xeYaABgC+cBPhSY
 6tNh3XYEYGE7kEd+kBwNb5Gnh4yjG0TE70EcGzfEdBl2H2cdCiAGw4RzbtcyOib4/RMTYnJybsS
 seJMkIj7n6pkcCuOTOduaeUCPEVGvGNWOQ0G4ZCixTvUHENfeVmIHRLi8qwA3v1MQ2YoHCnVYyB
 9ZkiexkfiIVnJsqvJu47Ozn4YRptuMmex+R/37TQNPBIILvclU/lvOpaCqJP4yIqD86cP2BZLF9
 40mPTooEHGb342OjxT3Xmedlhm2bjDmIAVmtc3TtyDVtLH2HBGvfAK4Q9eIx9McJgLA==
X-Google-Smtp-Source: AGHT+IElxPhcBMub/KW7iLfcciicK1l0BKF/LNK+x+gtk96LRLCdB7szCsRnVi9zWAl+VQUUGSiFrA==
X-Received: by 2002:a05:6000:4383:b0:3b8:dabe:bd8b with SMTP id
 ffacd0b85a97d-3bb68a185bdmr10218004f8f.27.1755531984285; 
 Mon, 18 Aug 2025 08:46:24 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074d43bc6sm21410f8f.25.2025.08.18.08.46.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 08:46:23 -0700 (PDT)
Message-ID: <a4a4c7a8-df35-4bd3-9de1-b22ca7bcca22@linaro.org>
Date: Mon, 18 Aug 2025 17:46:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mads@ynddal.dk, agraf@csgraf.de, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Danny Canter <danny_canter@apple.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <akihiko.odaki@gmail.com>
References: <20250818041354.2393041-1-richard.henderson@linaro.org>
 <20250818041354.2393041-5-richard.henderson@linaro.org>
 <4312974c-9b7e-48c2-a190-071ea72da33f@linaro.org>
 <5b9e5f5a-b434-479c-8840-dbb4cda1365c@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5b9e5f5a-b434-479c-8840-dbb4cda1365c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cc'ing Apple folks hoping they can forward or directly help :)

On 18/8/25 15:21, Richard Henderson wrote:
> On 8/18/25 22:41, Philippe Mathieu-Daudé wrote:
>> Rebasing Mohamed's work I'm getting:
>>
>> In file included from ../../target/arm/hvf/hvf.c:413:
>> ../../target/arm/hvf/sysreg.c.inc:156:1: error: static assertion 
>> failed due to requirement '!(HV_SYS_REG_MDCR_EL2 != (((((1 << 28) | 
>> (19 << 16) | ((3) << 14) | ((4) << 11) | ((1) << 7) | ((1) << 3) | 
>> ((1) << 0)) | 13510798882111488ULL)) & 65535))': not expecting: 
>> HV_SYS_REG_MDCR_EL2 != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(1, 1, 3, 4, 1))
>>    156 | DEF_SYSREG(HV_SYS_REG_MDCR_EL2, 1, 1, 3, 4, 1)
>>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
>>      HV_SYS_REG_MDCR_EL2 = 0xe019,   <----
> 
> How odd.  It should be e089, if it were encoded like all the others.
> 
> I wonder if this is a manual typo that's now baked into the api, or if 
> it's an OS bug.
> 
> 
> r~
> 


