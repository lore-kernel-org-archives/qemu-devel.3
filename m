Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C729C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 20:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY9eV-0004Qh-SC; Wed, 15 Jan 2025 15:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9eR-0004QO-5N
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:06:08 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9eP-00062t-Dp
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:06:06 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so571245e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 12:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736971563; x=1737576363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8emTbjVDE1D94QAH0R7cjkil/5g/cKX8xmsvjUr4blo=;
 b=Yr9dXeeXEPGCbPeJnS7aT010IV90vjUEVYulRpiwxQ/YUGHX06T7nWHTRW0DDi9QFS
 HTBEAqGGkC0HxiLaIC4Va3QxhXbtm6dQJ9lmoa0EKEXqAl4hzOPrQThKrZ3vvZxDggCq
 MM6pbvXFyXhoocUDnfZMmQbQGujepHixPPGn1IpTVUfsM3OhSyt+XwPHM7Rk8QnmpKH+
 CId113/8E3P+312CDuno7Ll8gm471Cz9NbupnmrB4pMi9aMwsuQ0nSU2D3MyjQXagVIE
 QSvQQO8PDJ+k/Uov4vkVrY4lVfzXrwRstPmf865RSTS+AdKuQOUXMiKgyOUxzDamFVgB
 Yc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736971563; x=1737576363;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8emTbjVDE1D94QAH0R7cjkil/5g/cKX8xmsvjUr4blo=;
 b=Nv2IKYy4pLWaeCil4W5ZIMrap47A0oNSTrFdQsnKGHuzeRJdBYXzQvytN/uqV/UH5v
 +wDTGPY+HDNEdh+1e5xyDwHP8jg1rvHft8jIEGXU+okhMVwF6Y5ghJBXWAVjMGEPg5IK
 z2S+v0vD2yuU2FKb5PxgULvuc3HmVLFLsKvF31XKOsyEoWvAUE3bDrej865SpjmvVss6
 sgbg22x14PqNVMYYOZv/XIj/Zdsm3Han9X9Pxy/yXwiwALCETXJ26wPF0GRhGavkq6cI
 RyXdGVVCvz2764o3F3kV/UNUfB8l+mEQIUObUX1kt9P+cHUZmezmSWXMxxPJh2bgdAaI
 pAPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYKCDGMbNK0K9g2JNf7HYgCtejKsha71d25n9HdRDAcZMUlOUp7rLGoz78OUvtB5pZFvSyDlWW8BPb@nongnu.org
X-Gm-Message-State: AOJu0YzVZMT9Cpv/UD642uFFcRUCU0W1XfY4/UfPnqs7kZurE5BkYjB1
 Sbk61zOo0IlXShWP1r7eioBIPJuCBIr79IfRaLSxR9ZZJeDJvQmyo6kmNW5OijQ=
X-Gm-Gg: ASbGnctRsDAKrswDxHTgK0dr7kPw8iD2zle/bfhxJjCQXfi3xwhwil8zQStMtUH6gZo
 l8dxflGJDx9RbrPmDhuGbaupHIsoV2BcYd8xIQiW+iKWau0ACa9VvYxtSR4pdKh2TvRal0Cd8bT
 NtJJPMuGOuSCwIR0PzVC9dL/VTUu0TCPTZTfPiUrA7UVaBWFg7p9VX14dSRkAW7miqxq5RIxM7Y
 xW+CCLZ/hNgt2hXEJnUNgEHdxd2YyaVHIcwKbu7Ly5ec0jWY0V6TG0B9Gw9WI+qzVOFxUNho5m/
 5yMlF/jAgBXjWShHfbeNvQzS
X-Google-Smtp-Source: AGHT+IHGy+8rDFrkyCMpigfwCZW27U193sFQC8DkYlo02zntm6Ni9Z8AJTOXZBEkW4QCsYCbO62OFg==
X-Received: by 2002:a05:600c:a01:b0:434:9c1b:b36a with SMTP id
 5b1f17b1804b1-436e269715amr269104755e9.13.1736971563350; 
 Wed, 15 Jan 2025 12:06:03 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74d7640sm34918945e9.25.2025.01.15.12.06.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 12:06:02 -0800 (PST)
Message-ID: <9a226233-a290-4945-87b3-061ba4adfa57@linaro.org>
Date: Wed, 15 Jan 2025 21:06:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 37/81] tcg/arm: Add full [US]XT[BH] into {s}extract
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-38-richard.henderson@linaro.org>
 <5312f830-c530-433a-a000-4c9ea1cc16d4@linaro.org>
Content-Language: en-US
In-Reply-To: <5312f830-c530-433a-a000-4c9ea1cc16d4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 9/1/25 23:57, Philippe Mathieu-Daudé wrote:
> On 7/1/25 09:00, Richard Henderson wrote:
>> The armv6 uxt and sxt opcodes have a 2-bit rotate field
>> which supports extractions from ofs = {0,8,16,24}.
>> Special case ofs = 0, len <= 8 as AND.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/arm/tcg-target-has.h | 17 +++++++++++++
>>   tcg/arm/tcg-target.c.inc | 54 +++++++++++++++++++++++++++++++++++-----
>>   2 files changed, 65 insertions(+), 6 deletions(-)
>>
>> diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
>> index 316185500d..d6ca35ed1a 100644
> 
> Missing:
> 
> -- >8 --
> @@ -41,8 +41,8 @@ extern bool use_neon_instructions;
>   #define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
>   #define TCG_TARGET_HAS_ctpop_i32        0
>   #define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
> -#define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
> -#define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
> +#define TCG_TARGET_HAS_extract_i32      1
> +#define TCG_TARGET_HAS_sextract_i32     1
>   #define TCG_TARGET_HAS_extract2_i32     1
>   #define TCG_TARGET_HAS_negsetcond_i32   1
>   #define TCG_TARGET_HAS_mulu2_i32        1
> ---

With that chunk squashed:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


