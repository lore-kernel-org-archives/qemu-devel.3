Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8557C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT8Rk-00005v-EI; Sat, 21 Jun 2025 20:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8Ri-00005h-4X
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:20:30 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8Rg-0002Lq-IH
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:20:29 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-23633a6ac50so41743865ad.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750551627; x=1751156427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uedV25qU7hChUzPnTGAL2UvRwhuScRmO1vypVE+IrHA=;
 b=mWAKJx0LhPaCoJBiBPLZcMSZaXsbTKW2FwINIJf27f/ETvGoNiXDEf2iNrUWFeYqNI
 iv7GT6M/C8TczVwMV9xKmwMaPoSNyMvwAkTDNH4O+SvV1sh1jXoBgBR+HSBg4i37FDmV
 j7vA0jePFS5SYkDHFTLhsp8RhsBEV43e/evHDM/gJtcITGWGx9gwOZWXrtJxixu3mIQH
 KS4aH8sXOE6ZKQhxCFRCkepweBfSyZoXDnBbUFQG2tcwfuQm/ROZhqA3SM10iPCt/LMZ
 r8bl2BiMMAjyugtWm3sEtKsZ9VmdP+HT5XDInsIIOiNLq9NbY+dY7bewN928gV1i7nMG
 9HMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750551627; x=1751156427;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uedV25qU7hChUzPnTGAL2UvRwhuScRmO1vypVE+IrHA=;
 b=sjfpQ/NDN4/JJJVrSv7nB3p05PxiBa6nw6wLsIyb7UiRv4kxsXOqzdeg1QC4EokxX8
 Hkld0CNBqqlAPTEA2M+8WzDuoRO5Sc/lXbYT5Hu9ebdQPj/rjAQvwO5obN+O7eaqA666
 eIkAuSxsEFrdRhEQvZHX2QtPhy9rurjkWfVz7u8YhIady8E7FFFpVtEDppTfqmXB8+GK
 G4y87FKjIk7eehPvFe4luLigHfyWMTswnOGpbG7SoyaBQBjSid6CfxUo2AnIJ7OvrRsY
 hZlk4zkaWV3jLrtoOsIFJ4SlOUP3Jb0bdyCJD3Bt9rZsMqJsXMRyW2+YKOV1f+MMAKHE
 X/NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0nM5Sv5ML18Chk5Q6SX7RGh+rRg92Dqk3n4wjkuywLRsmUj6kX8rkUCvVFx5fBBcNA6LijYUTAqe+@nongnu.org
X-Gm-Message-State: AOJu0YwcctjzmILYPeak/ltkeVWAkgv4DhI2SBuAa5Nzd9nj/4K46Lmj
 gKn/F/wmLBpje2sB9xUkPgtPCdZEALZrzU2P5R5HBwFkg7J49HMVOqNHOj2OPo0+BSpzUn8Pnhk
 k8FbGkPM=
X-Gm-Gg: ASbGnctzOyrcYbVXt538YBx8csD3hhs0Y0w6WuaIdV1u/FD5h81oP/oohPUHSZs5rCP
 wwvktBHagAKb990z0kOm3VXAyXceRVTLAx09G86xLeFXRflXlA33J2ZWBkKPuDEqYDhucYpjcZ0
 M+P55AJAd27U2bb2BF2+lfW/FVJYwvuxQQUsJlH5wW/NrUhTXDduE8LlhsnoCpu81djo2OO4ylj
 cwrg3a9oYymLQDA6HmNRInSOJiWIqkIK69uhqNqHQj4MWHbq0mw+zIfaW41YtTdbWlmkcvlwpKk
 DWq6FdUDKWvwqPID6fZS1ZmbGiJ+ozzQXgcumPL/n8rtDI/jy+fNJsPsfvC/PQEyNbVb6b5V274
 8Cuycgug0FSO+HdlZG0jSD/uiKYiyp5eSb4k7r58=
X-Google-Smtp-Source: AGHT+IEnAkC4CM6lTiH5yWAASsKVwLRFnO1lqsbP4ykNvpxBJPjXXZwz43qHJ8uyMqFwU4Gdj3FSKw==
X-Received: by 2002:a17:902:db12:b0:236:6f43:7051 with SMTP id
 d9443c01a7336-237d97a0078mr114398065ad.23.1750551627080; 
 Sat, 21 Jun 2025 17:20:27 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237ee6e8c9csm9684325ad.190.2025.06.21.17.20.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 17:20:26 -0700 (PDT)
Message-ID: <ab9c01d6-db75-428b-8b69-6a4a66aefb7d@linaro.org>
Date: Sat, 21 Jun 2025 17:20:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/26] target/arm: Restrict system register properties
 to system binary
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620130709.31073-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 6/20/25 06:06, Philippe Mathieu-Daudé wrote:
> Do not expose the following system-specific properties on user-mode
> binaries:
> 
>   - psci-conduit
>   - cntfrq (ARM_FEATURE_GENERIC_TIMER)
>   - rvbar (ARM_FEATURE_V8)
>   - has-mpu (ARM_FEATURE_PMSA)
>   - pmsav7-dregion (ARM_FEATURE_PMSA)
>   - reset-cbar (ARM_FEATURE_CBAR)
>   - reset-hivecs (ARM_FEATURE_M)
>   - init-nsvtor (ARM_FEATURE_M)
>   - init-svtor (ARM_FEATURE_M_SECURITY)
>   - idau (ARM_FEATURE_M_SECURITY)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

