Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE87CD4F4A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOfJH-00030m-1N; Sun, 17 May 2026 13:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOfJD-00030Y-C1
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:29:47 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOfJA-0004yc-JC
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:29:46 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b941cd869cso7992155ad.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779038983; x=1779643783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pEC6GZlIeT+2IeLhjPazygf3J3fWbD08RjQbZEUO11A=;
 b=DgnTViZqzYYmiPBGMDL3zjtzo51DhBxGnZ++Pdg7Rila/X4Uj3Gg0UzkjoId4Ug18s
 nA0q//eW+ywLZPYj5cn13EbqWJcDUCPk7L4CuWUHIaNh731BKeUIG4TmA8NJcQktE1ta
 Nhs4I2QViMrcGRSvaeseyPa1581IjpMmIJf5O5NRryGRuL5vVDgRLu/JDnXNZPh1wInM
 vabPqgqcqDd87zKQo9IvOpilaVURutkOIbm+S1RWNKBdTfj+FRfnuLlTAOlHmt2g5XMB
 p4brysv8QGXJEU84EggOg1yQbNDjM5iqNbrwak23krwQUALi8PcX7EHhyyfbdk14bq5n
 MZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779038983; x=1779643783;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pEC6GZlIeT+2IeLhjPazygf3J3fWbD08RjQbZEUO11A=;
 b=hhjid5d0pavoBxQqTIJ6Ix0sPfw/OaRAtAK0LLJNpI+FGIrokE6nzAGsT40QSGplRn
 4F/4gpbsg+WzBq543y/kXoS8FTVq6a/MqQJ0jSRm6JnMZVZe2YHV8SNp0ZKEBm92Obca
 gdIF+t+5i+u8p6CpkjXT/bxmKLkzVEa/dyQF5I/QpNZE001TXw0cn8+6jUD9lPy8Q0SY
 rDkg4VrWq2U7Vc520A9Dg4zvE3j2yoF7p4f/+hM8xzRVdejmGugxikoIO/kfteefY6aR
 YJgWF+cJJN9AVsqgSWR4VnX9/DVdg1H8NpbIqArEV/4DUEe8q1Cg7ib+ZO4e4IG8Uuwg
 aZLg==
X-Gm-Message-State: AOJu0YwAzfmaalaZUx8aqNjnQIdNo1PHEg0H5COdpxKTWiL5D68H3Dr2
 MixJyT3b23JcDus4fppVKFjN6JxQZAMML7ZXmFMvsfHwocTKewKM59ewu16OxdL8SFa4Rss5UAx
 Gxgde
X-Gm-Gg: Acq92OFA3NXmzWobX/V8egV0v0isOUd3gLB2PBT5ODsO1x3B4fhBaVKlfwwYb3tpy75
 rpCyiJFKYhS58Nl2+fho1vhi5ZIwjPbJgJwo80iO4SenKc+ow9CVwjTBLdTxfn+rnySb4TnuktW
 EO15D5wPVifUfkF0linaMmyT7jongjNGrxBefxq/SdgfAto6tEEqvu3EoTYnCt7bnv1Z/ToI8Sg
 zK8IUX7Ox0VaBD9xWVjvFtKTpXSD9u+XOlpzxSJ/jC2PQe5lcHuuI4tTn8wH6idSMJR7Ne4P/qO
 uPHMSTsw/6J/I9aCOvmlZhkC2oi3ZCOxZJI5MkLlhyOza0xFdvZ+ZA8dNmMbw8rKUiDHrQ2vYeU
 DxwKoGBVwvfPwYsGpmTYafwgP64OIfyjNedl98Cts67AlxvmGm/neKvfv3K77YQEwwLPWARzY5C
 ImErtyxvnTHOkUcnJJpRaWA9UvHzoC19mCTsYb
X-Received: by 2002:a17:903:fae:b0:2bd:a5f:1d04 with SMTP id
 d9443c01a7336-2bd7e8aad34mr129078175ad.9.1779038982840; 
 Sun, 17 May 2026 10:29:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe6492sm116184925ad.45.2026.05.17.10.29.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:29:42 -0700 (PDT)
Message-ID: <a9adcc21-12be-4401-be77-db819bd4cd1d@linaro.org>
Date: Sun, 17 May 2026 10:29:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 17/35] target/mips: add Octeon MTP1 instruction
To: qemu-devel@nongnu.org
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
 <20260514-mips-octeon-missing-insns-v2-v7-17-226686be4ce1@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-17-226686be4ce1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/14/26 10:37, James Hilliard wrote:
> MTP1 loads the middle Octeon3 partial-product pair from rs/rt into P[1]
> and P[4].
> 
> This completes the second guest-visible partial-product slot used by the
> Octeon multiplier helpers.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split MTP1 out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> 
> Changes v3 -> v4:
>    - Describe the Octeon3 rs/rt P[1]/P[4] pair handled by the shared MTP
>      translator.
> ---
>   target/mips/tcg/octeon.decode      | 1 +
>   target/mips/tcg/octeon_translate.c | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

