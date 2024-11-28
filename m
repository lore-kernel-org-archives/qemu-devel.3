Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33387D70DEB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 18:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGj0u-0000nm-FA; Thu, 28 Nov 2024 13:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGj0p-0000nJ-3h
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 13:13:12 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGj0n-0007YV-Hj
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 13:13:10 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5ee9dbf1b47so1003527eaf.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 10:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732817588; x=1733422388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HWVhMHKiHIZ4cMOKLHT1DDD/tII1X73lG8ZIYKCTD58=;
 b=L36NMelMDLb/iZYFokdCOVPHP3kl6JQLP+ukPttbVyKjXxMZDCyoNrc+mODK5BqT0F
 rVWeKlI8VnGkiQDGroXefXYFl5oxbSfje8zDKE/hktsT/FzOPkyaDmIsXlSu7BBzfIKv
 TxDjBjji8VsRjmbo2fsRgN5rgnngFa4wiSy2SAh8zNcDPe+UWAhUASmklfUQXGNd5ACz
 5ax8wx5rBywx+QlYKcIcg+zWYGEVrqdvx1/gJXmrCfPiYLSd2awQ/q1ujzugdSYZYX5W
 m6gwSDlvTpilNfUH3nnRFmcZPHdQNJt49q1Uy31E1h4fQYbFS1ZE1+ewnWMyvkwVnZOB
 hE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732817588; x=1733422388;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HWVhMHKiHIZ4cMOKLHT1DDD/tII1X73lG8ZIYKCTD58=;
 b=hOErQzuIc18rCUGzOabymisV7S9S1fTaA3lxGrrYkCLfs1L71e5mc5GqN7On6OT6cH
 xeHYNrsOIabRkl2P3nqGDv9WkDzmoaHvnYkDrRWDinKEyNRvryNtBkzpEbql6Fu/VWn9
 FdSlI2pipGX9bWlQ58lpxAyF5wNt0/mwAkowPC2R9aMsHN91vqd9L1hQM7FwDksjydcz
 +QA+SiZWgC0CyqBxGRkDum4Pft4S+28M4Sm8KfHAV+U86ka74jnqWgO7FL40EQjA4749
 J57tZOg0La/gFHTMuc0sI7UTBblGHcGG87uYtGiY/6rUzfYlm5BEX8LvUkWa5rplRxa2
 /e2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfm/NWKTENtwtokM3uqZg9DwOUwYTtAL35fBoVyWic2BORb/7vaoaBm1ZvCsCvQyktmQY5rt+VVz4W@nongnu.org
X-Gm-Message-State: AOJu0YyfO7pcNP2kjnyk3dfF+A4ecgrt7lzenqD8Rwwa4TpthDK7aByn
 x775yK2HhYmiqM67MANKcoBKq2JigWJ3DpaXU7DuAgNN/85unttBUESROiNoEI8=
X-Gm-Gg: ASbGncvE3H9j25/c6UCuV5sR08nF8viIR1fY30zbk26ZTej6h1FTHdfDl9DQZcodd/n
 LTDok9TaZ8bG1STq9OH/h39kk2Gg/N+95GHNfFc3TuzvVk1uQe+YMOOjfX8zFGTCi44U9Vj3HnQ
 bIa3HFE5Kw2CT7M6czPhFEbLGUyTzfSxmIx+wMn9PG/TxegnfidsfboocYZMpJDwlm3pcjUIXps
 Jq/4qXL8fLWMHQFh6qUgnRc2UpD0O4Adu217vRUBMQhErLKnj3LXZSVpsh096WfbtQ=
X-Google-Smtp-Source: AGHT+IF5f9v8LKLbJ69XF5/9FR/sat8j2yettNvtdFpwj1uYH5i5lhEhxXYdIEA76jxkRQBSubhonw==
X-Received: by 2002:a05:6871:e7cd:b0:29d:f773:6f24 with SMTP id
 586e51a60fabf-29df7739d04mr1614261fac.13.1732817587996; 
 Thu, 28 Nov 2024 10:13:07 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7c820850sm37578a34.73.2024.11.28.10.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 10:13:07 -0800 (PST)
Message-ID: <bd910b04-b05c-4325-a82e-ed864fe46d82@linaro.org>
Date: Thu, 28 Nov 2024 12:13:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] softfloat: Allow runtime choice of default NaN value
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128145455.3742294-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128145455.3742294-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/28/24 08:54, Peter Maydell wrote:
> Currently we hardcode the default NaN value in parts64_default_nan()
> using a compile-time ifdef ladder. This is awkward for two cases:
>   * for single-QEMU-binary we can't hard-code target-specifics like this
>   * for Arm FEAT_AFP the default NaN value depends on FPCR.AH
>     (specifically the sign bit is different)
> 
> Add a field to float_status to specify the default NaN value; fall
> back to the old ifdef behaviour if these are not set.
> 
> The default NaN value is specified by setting a uint8_t to a
> pattern corresponding to the sign and upper fraction parts of
> the NaN; the lower bits of the fraction are set from bit 0 of
> the pattern.
> 
> This is an RFC to ask for opinions on whether this is the right
> way to let the target set its default NaN. I can't decide whether
> I think encoding it into a uint8_t like that is clever, or merely
> too clever :-)

I think that's perfectly fine.

>   #elif defined(TARGET_HEXAGON)
> -    sign = 1;
> -    frac = ~0ULL;
> +        /*
> +         * Sign bit set, all frac bits set. This is an odd special case,
> +         * where our value doesn't match up with the snan_bit_is_one setting.
> +         * This is because for Hexagon the returned value is always -1,
> +         * not a real NaN value.
> +         */
> +        dnan_pattern = 0b11111111;

It's a real (signalling) nan value -- the oddity is that the default nan is not quiet.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

