Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0653CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDiWY-0003Jn-Q5; Tue, 28 Oct 2025 08:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiWV-0003DO-JY
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:10:00 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiWM-0001Rb-R5
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:09:58 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b6d855ca585so197276566b.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 05:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761653386; x=1762258186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U7hSbiGQ8zB1GdCfwOxii0U9V40aj1PzEYLIaXABMmU=;
 b=xG7EFdMm42RB4dOkYN+UGet/naI1V+Mg5iV5Ft13qH70a3h8ZTKjKwkOHcW1MMVFPm
 eooFye6HRlC6p0ac8fT44OLOlBTBkwHNNueT0sKuci9yNpZ2LsNfAyewJh1aAgkDi5dz
 6xtjfg4YMirkYKlRXTKgKx+dKmCtYomdsc1bjW27KyxlYFSn6vW+ci5dP946hTiulfpa
 ENLildI7IPh11JDv8mdSgpEBKO7YQNF3goiHqPbOsYN1Ln6veiPMMGZj33olmn6i9WT0
 trWYkuQuTuDG+TJlSe49MGYQSFGPEH2s43BtZgjbVtDVh/cRq8LCfsGmDBA0ocBN+mSS
 i2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761653386; x=1762258186;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U7hSbiGQ8zB1GdCfwOxii0U9V40aj1PzEYLIaXABMmU=;
 b=UyWiI2wPtHV0uQ0+Yssa9z5IrpPYroZjN4nuqqslI3JZ+lmppo9WpgIBqljV7vVDdQ
 aH2JQkWOc4yAAJf+pPueORk5RIaCxSj1xPMn2QGVqvgOwDQv/vOkkCHg7bhQZQidnxeM
 tpMkLV6dScpwyM2/pAekhttVBR07p3AJh4421NIKtuhi9Ei8SRPaQ7fTudBq/uZfyeFf
 RP9l2uxk3RUhGR5qJXuWod2wVFqiClwjFQn9EdBKxFawYnJVtuW3hhqqeuBhwo/EQKIZ
 fj+56PKt21zG8wt1bPSdrJvqDAp52bYjlzH5rcq0rUnTajp/l9gtQPYTgaGVEnkHAD/S
 c81g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9wXbA3Lmlv3M7mftD+yb38davjgBvMGnI1APmf3IcAuYSFXEeL4RF5Lah4V0NR1m7bd9rpFCumOvq@nongnu.org
X-Gm-Message-State: AOJu0YzeaSOJjG5NQhOpf7HQ/HQNevgBpUAJWKlLZJ+KQHD48ekYC3gp
 Wrt59SfxrYYp1SbPfVZT9JM36Irz9BPkbsTAwhcsofGQaZA73oT0iPqgZRGXRnHUyvo=
X-Gm-Gg: ASbGnctJb2S52lq+YcuUECEJ7Q2T7CErp0X4RezQ/ZMxt2a0TzStWzJjmkiVxkF0D3+
 AWbRJJfGyYmBFz9e24oa+7gjNITkywWjb/PUU+OqYEJFIR5bhwZSiODTBCh7INlMMpZ5U/TrqnW
 LT8U+iM7ZCVTaUuoiwhhhHBkXRT52eBgP2nwAxzUCX9wIbzcNges703iiy+vTD3NveHSNt5M4G2
 rsF0BzPi6VilmH4THMQwUkxkTaLeJZ5NddnqGvzshLr9yaMkI3fK/qnycRpzbMvPa1QdohQJogj
 0h8/bHTr8jeMGV/Lb97uJMxmhatHZoHcE5wL3XYSttJayCKZW1vtXO1ttR04HlAk4uOzYZ1zr2h
 dj9yyRqSN7FBT9Wm72nnLWOqBZjh0tA/LoJpCPBn9rg7Upv/mvmXFmTi1yYq89J+guMC6O0G9TH
 zsD4TbsIMXXhZ7ILB0
X-Google-Smtp-Source: AGHT+IHWn0A8Qduac6I8HNJQufIm69Ue/9eUk/DmXtF9Elho6XY5jTsErg1XzPj0xHtlukYQ+Bdu2g==
X-Received: by 2002:a17:907:3d0f:b0:b6d:7db1:49aa with SMTP id
 a640c23a62f3a-b6dba65b0dbmr361748566b.63.1761653386348; 
 Tue, 28 Oct 2025 05:09:46 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d854550f2sm1064231766b.70.2025.10.28.05.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 05:09:46 -0700 (PDT)
Message-ID: <57042456-f65a-40e6-a5ff-bb0e5fbb93e6@linaro.org>
Date: Tue, 28 Oct 2025 13:09:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 53/59] target/i386/hvf: Flush vCPU registers once
 before vcpu_exec() loop
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-54-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028054238.14949-54-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 10/28/25 06:42, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/hvf/hvf.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

