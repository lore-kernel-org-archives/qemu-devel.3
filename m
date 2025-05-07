Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45980C3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgKG-0004YT-PA; Wed, 07 May 2025 11:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCgKF-0004VZ-FO
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:04:47 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCgKD-0002YU-T8
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:04:47 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-227d6b530d8so68889435ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746630284; x=1747235084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6gJURbY6ep+V9uB5VHEC7U8S+al3pil7qnZvouDe92Q=;
 b=ruJYMfwws7g8P2QSoUFBbycU3qWTiXWLyUqBJfKUF2pksXnddQprm4NrHQmcwVaU5i
 hoaeMQBp7eMqZZZF5C27Zdoep/jnuVtZRwkDtSKTDkJDc6MsttvwDRAdxjbEn6Xt92w0
 5Ld454OVMLZR7SkC50NHNGcGE5Ah6yPpJfK+ToTSoZ+YqEkwPQbrvHZjf6qb58uNj1b0
 4hcUgTzeNWWnjFhcNHv6l+YAZaLG7GJTNeoZTu1qfoF8poQ5NIHXZjxE7SINEcHGNXqy
 7LgBB1DTOhNH8U5eTav6QQrkNSP9US9y+/WnDqBlmy5bLDKN95r1Lt02N2jhApyNHocU
 HCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746630284; x=1747235084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6gJURbY6ep+V9uB5VHEC7U8S+al3pil7qnZvouDe92Q=;
 b=L8jtKSTbAteITckDuhXq6THf3NT/cfiA/oEzSS6KeIkDpW/cCIxGLfb0xb/7vaW8pt
 xdjkAIUlasFeGubyBEl6iKDHL3X5+eXpCiIuO+WgNPbqVhikeM6rjsD26gdU/5MKNmpR
 L6ExrPhH/zvDhiB/zUxqruwPC6UMVNh67JQBGC2WHQqsTtVRvtmWqQbeiM3g/WQp72t0
 0fZf3YCrdQhTNCg9UxuY4DpvYq/LqDWKaP9dgg7zuQ3rNqHBkOpoUj/26XMVo1dvcl0V
 SErnDFD5T93U3HGd31UVoW5je8wfRN6pcVKeLVuOV1gKBY4fCSXEpAP4Xze45lp5g6KI
 bSSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT41Nor/eUprJpHQW5HRbgf+mdmLYCEXOg/hfpTYkVK0FHSh23hSVrWrhabipUm28zHri8Ak8cY6N0@nongnu.org
X-Gm-Message-State: AOJu0YxWEmQHnetzX9RjvRn1CNHM1g9M1B7f5LONTrEWB4xYwnoRsNYM
 WrruIr2kRPnxavn1gIwgca6/lJFSAzrMMOhLsRAeAZfZsx3dkEs1flpkG0L/KpY=
X-Gm-Gg: ASbGncvdKzvIP4tzRrUq2m7B7kyD7NC9XxlKmsvLQwHa6jMIPMMI6n4TjhxXkNO5pu3
 fftfaMKnUJxNttsvxjYVhu/d6a2FBQLJtmGWbDrDAyf72OJDiUw7en1eV/Aqle25KEjnamFHrWQ
 UScLSgQthCBzVY+nD9mWbMLgeTNwfmdH4s/Cu7Iam9hen2Hzu9OOWStG+ZSwDTEWh7EeBBHZuS8
 9WrBsuhiaC4m4gYgQGLMaixvS6U6PcXb+Tq3ivDG7t/QWYD1THfGHg1P5tdE+nLzZbwOyTIs7tY
 YB1IxRq0emQ0YDpkZMikT6ceuIe5qJvcxYRcnd1hTSLeWst6x0qnvR6ZhkKc18AXIisbfaxWA8d
 Zl3cwbCA=
X-Google-Smtp-Source: AGHT+IHRiztExaV/PTIpc0lf42Un4luX9kZoqfq2oSwEXPU4EuMbyIBVviHXZiNQDPMQvdUgG0h4ag==
X-Received: by 2002:a17:903:990:b0:22e:39f8:61fa with SMTP id
 d9443c01a7336-22e5ece3f6emr61747235ad.34.1746630284378; 
 Wed, 07 May 2025 08:04:44 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e95c3sm96190065ad.68.2025.05.07.08.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 08:04:43 -0700 (PDT)
Message-ID: <f92c8c65-8fb4-4cfe-b793-a5aa17f11c1d@linaro.org>
Date: Wed, 7 May 2025 08:04:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] target/loongarch: Fix incorrect rounding in
 fnm{add,sub} under certain modes
To: WANG Rui <wangrui@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu@hev.cc, mengqinggang <mengqinggang@loongson.cn>
References: <20250507091455.3257138-1-wangrui@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250507091455.3257138-1-wangrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 5/7/25 02:14, WANG Rui wrote:
> This patch fixes incorrect results for `[xv]fnm{add,sub}.{s,d}`
> instructions when rounding toward {zero, positive, negative}.
> 
> According to the LoongArch ISA specification, the result of an
> instruction like `FNMSUB.D` is computed as:
> 
>    FR[fd] = -FP64_fusedMultiplyAdd(FR[fj], FR[fk], -FR[fa])
> 
> Here, `FP64_fusedMultiplyAdd()` performs a fused multiply-add operation
> compliant with IEEE 754-2008. The negation is applied to the fully
> rounded result of the fused operation - not to any intermediate value.
> This behavior is specifiec to LoongArch and differs from other arches,
> which is why the existing `float_muladd_negate_result` flag does not
> model it correctly.

Loongarch does not differ from other arches; we got it wrong for everyone.
There's no need for a new flag.


r~

