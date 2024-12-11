Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB2DE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLOy3-0007Vt-Vu; Wed, 11 Dec 2024 10:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLOy0-0007UL-Cg
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:49:36 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLOxv-0003GX-O2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:49:36 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-71e2766994bso119034a34.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733932163; x=1734536963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lDVuyVJyNQw2/FltZOvlwaiwB/VPuWOiRAkQTVOYEcw=;
 b=RmCwqAeA+ZVcczAA04SpV7D4Fr9upU2AuL3qgXVTY6l0yvSIk3a7ud+ljSqZ90eO7J
 mnWwxANl58jXmTw078FiKWfozx/Fide6pb4BJ9DSviCM6IfreT6Hhv5HaQVFfhIObTxr
 d2wPRv0l1bVe5gVat08gVmzOkrLmpX8vdJKMBZ3ObQa0sKekz0u5fVvPKw3SaGRc4sgR
 Isq1eyol+iSw3Q5fmd/cpoGjZ61P+qdFVjDQjTyVhTEBvckcrYITyAdrMJ9Ms8Qi9a80
 W/83XUXggg5Hij2gsay7D3lB1bB1jmT3yuMufHWFR3gO5H72nH1R0BJRzRQUVngp25ts
 yVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932163; x=1734536963;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lDVuyVJyNQw2/FltZOvlwaiwB/VPuWOiRAkQTVOYEcw=;
 b=iQXiFv6fPvpXQ2cGWOOhTjNwBFB2pbrgZMkjLsi/bdK7ZWnpt9qkCDKnC1YsWGHuOP
 kNeSz4Ru0RmT8vBeTinfzgbnULaBfSIMdFXMexIHDU88pnMGu2c0oPlv03zdqRyhodLD
 ysJNr52TxKmw+VcE6F+xFgQ5XV6i/TQXdB3Qu+m6/PgFGwzv83FIlLP1YfvHNz2vb+Mt
 ME/lBdfvXyqM6s6Zf979KUNYUduiImjHc85TsUXjXgHwmxAaGYeKSlFasVPj0WS15iBC
 vINjCphH2RGYLEG7mzqk4L0GlXKTe8fwEDm6vMUkIXsL+rjn12lUMNYPWXC6qn+Owu8/
 Ee0A==
X-Gm-Message-State: AOJu0YyM6FgSleKav5VBeK5WR100UNWn0Bz6c799vdfeTCrHYyMhe6Ty
 OkVUK0uqZyDJedauO2OCzrSlFSowJrgkMkfBefpgdHpuU2yKRaJk4rzScomeCr5VnFVnKKD5NpG
 aB8oTrcSd
X-Gm-Gg: ASbGncvilxCc8sBOhnLbA1lxl16gBo1V6BBsM0OnU5Y8grcHrTT+EINWwKJJWsa3oDb
 KQlR/PNr8X3yKqKVki7azzVfhBTGFfuj/7CxB62w4E9MDGwWfbJSvLSA7qdJhUXkJWoFWP0N2zq
 ZKciqP8Yh1GGhFEkw6djOm0aQPw0BZ8etBiYKkzxQ9PtoarVlaVIYUzG5aDCimk8lGG6tn8JxMK
 Si60glC7tBBk6YG6pXG/FkvAk6ouqz7+evFjsmvMm9zaRuYoVpxx9zK5Q/QncQcg7sF/oU=
X-Google-Smtp-Source: AGHT+IEe75eWu6zNh52aSIwq29zrUKV5oI3kw17nqqGyxGUbuDNFU4rUP1xdjQHFC4vRZjSvxG/JPg==
X-Received: by 2002:a05:6830:6dca:b0:71d:f429:7f95 with SMTP id
 46e09a7af769-71e19b6061amr2128909a34.29.1733932163006; 
 Wed, 11 Dec 2024 07:49:23 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e08622768sm791346a34.13.2024.12.11.07.49.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 07:49:22 -0800 (PST)
Message-ID: <1933d447-ba4f-47ac-883d-bd0ae10da2ed@linaro.org>
Date: Wed, 11 Dec 2024 09:49:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] target/arm: Add ARM_CP_ADD_TLBI_NXS type flag to
 TLBI insns
To: qemu-devel@nongnu.org
References: <20241211144440.2700268-1-peter.maydell@linaro.org>
 <20241211144440.2700268-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241211144440.2700268-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

On 12/11/24 08:44, Peter Maydell wrote:
> Add the ARM_CP_ADD_TLBI_NXS to the TLBI insns with an NXS variant.
> This is every AArch64 TLBI encoding except for the four FEAT_RME TLBI
> insns.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/tlb-insns.c | 202 +++++++++++++++++++++++--------------
>   1 file changed, 124 insertions(+), 78 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

