Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE78CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHL1h-0003re-JG; Thu, 15 Oct 2026 08:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHL1f-0003rB-85
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:57:39 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHL1d-00025S-Fw
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:57:39 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso237682f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 05:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792069055; x=1792673855; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=icBl1a9YwtkLuxGKxiRCtuo2xp4KBnE8B4wMN7OlSkg=;
 b=tZ5zQrbJaxj22gwK9fFgToDcG50X06he2khDuy2MaAvzvFlUVNBaGuUtI+VXQ6YAER
 S/0xxDZKwaSRom105fXwlBkVrnC7wuu0Pnz1hJeSqT4SjRnSXIaWcwNMitq/CmwvXX9r
 t6AsgIIRQudVKCRM7zO3bakfo1g5QlNLYFo/sf5INL8mnOSVDi1r1dLtbSQgcVOkRYhk
 KgXQ029K6uD83tMHldtTahvEnTwdS5gRcB/qRQggAiLV118JvkOHor/olAS96cVEJ06T
 ScGR7CjTtOXDpeF03MJ8LpcVKLTLIQ3zRDgS11qEj9dZMFNYl5XnOw3ieEuix17Rak4P
 uXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792069055; x=1792673855;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=icBl1a9YwtkLuxGKxiRCtuo2xp4KBnE8B4wMN7OlSkg=;
 b=0EP/u9Tj1m/t/sTxJKqBUFfxjaVSko+AmCdz2S3AGA++UZhOS++QMKGim8t7dGHTX8
 9bB/hGQVrDrMJjKpIP4M5QsBzuKPCU3KDXemgxmIzToZsA6nmQwRyz/t+IUs9/zNRMDv
 AmKJ3NMkMBiYb5sBz7y2ft/o/bE+Knn8stNlMJUoGT2E9PRrDDf7JrrQBUcTSETz3vhn
 iHVKO+NWW9HVfF1kTYsqWP1KbcZHkc1Rp7z/6PJdqrJOyCKQcO5H5zmZh1/GcLn/NbhL
 5vrgPvwdf4tLCJihR0yLfFMkq5ssVF5/AUfiU1ZvOi1ytkkePk1iutHz/S5yHfmX8OF8
 edyw==
X-Gm-Message-State: AFq9FYLFcqnizt8W6X9sZXiOs+rJ4YvZF6uCVO3xNXtbzSBWwbU9WXnb
 Au7f/XD7aTlWFPrzf0U6IQXVyE/i3NtXtFJno5KMeyN/k+z1VjJBQKtLr9XCF2o/dToYqsjZc+0
 EHwReHt0=
X-Gm-Gg: AYBFou0AqEl8QwIuiJASjLTbFbJii2Cr79fdk/P9B9N9xlLlBbv9aJq7QE2/E/A9HHp
 VCSZxqRutgxv//AskFFK2EDs/I8sBC5vHJckXT3KBBnPqSjTGjVgveJGB+C0yWQ+eBLFk690T7Y
 gF2YSDJElcmiIa/xZHNj1+bbZ2rTQGToSt9jmiwJsKcR8QhC1xAhc6QOzNQtpTsy3PMSqXl7ZVx
 fkzcVN2+hqsjsahVH2xs+9ZU+isE/zTj3FVBfnVqUpkwnVAmBkEE0xCiGi2IPoJ/8J6CVJjygAk
 Y9Xjv8LAkpqGXAbee5jP/4QEaQ6VeOOWu7ICbWJZfungh6UNb9GzWz68k1tGU3/0KpjzKpSmPE+
 /vIYwli2WOTFb41SMVrPYNNWam/9lhup8AtOI48IlkUL3sBNSwbLxVCu7Utr/YP5aDT0SNeB4gX
 c2DeHoE4+DhmRfW+9LzUEqMXJuGhlf+HWN+aQmcxV5eib3uiXBkCR52AhbvrS764fdskLBIpUwB
 nBjUZC0Vkj9W2mR/ywKBkpkxdq+hxwwc5g+ShQLRVUxAFOeQ8v8MIWJ1VtCqhna/Myb1GTCp+Kv
 jRPS+HGxeCdDjbxw4kP9N2PtAWImx+VTGnQ5WXHaAnU=
X-Received: by 2002:a05:6000:46d3:b0:48c:45ed:2425 with SMTP id
 ffacd0b85a97d-48dba789373mr25159164f8f.4.1792069055395; 
 Thu, 15 Oct 2026 05:57:35 -0700 (PDT)
Received: from ?IPV6:2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860?
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df8f9ee47sm1797061f8f.45.2026.10.15.05.57.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 05:57:34 -0700 (PDT)
Message-ID: <7d17b3b4-1892-4233-b474-1e239e2d2712@linaro.org>
Date: Thu, 15 Oct 2026 14:57:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] tcg patch queue 2026-10-15
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20261015105212.356392-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

On 10/15/26 12:51, Richard Henderson wrote:
> The following changes since commit c61ea024f6d58261394b1b408e0f220e30c136a4:
> 
>    Merge tag 'qemu-macppc-20261013' ofhttps://github.com/mcayland/qemu into staging (2026-10-14 10:04:07 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20261015
> 
> for you to fetch changes up to 512b06299114d08458019a6c3944f73ae26cb5fc:
> 
>    tcg/riscv64: Fall back when AUIPC pairs are out of range (2026-10-15 11:54:47 +0200)
> 
> ----------------------------------------------------------------
> tcg: Introduce tcg_type_bits() helper
> tcg/riscv64: Remove vector min/max ops with immediates
> tcg/optimize: Do not derive s_mask from rotated s_mask
> tcg/aarch64/tcg-target.c.inc: Correct register MIN/MAX instuctions
> tcg/riscv64: Validate AUIPC relocation range

Applied, thanks.

r~

