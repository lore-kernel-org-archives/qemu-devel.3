Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC0CC369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58F6-0004YE-LO; Wed, 16 Apr 2025 15:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Eo-0004T5-QV
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:16:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Em-00066b-OX
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:15:58 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736b34a71a1so8423517b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830955; x=1745435755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EDP7JqDEuNIVrsG84kq5lfPSq2oG392d2a/CG5IAa40=;
 b=f1LSwYFMj83gSuDwnFrxX08S/iZAHVa8Joh9/B8wiCTyI/O4J7OcP1Luv3LUmwRugK
 5Bup/n5xhg3Em6XTJDelne+e10jBBRhGI5uqk0x4HiAst5iulKEQNInUh0Qv6o8UhANR
 PnKIItLIzk0bW/h+fJKNHhWl8XNYrySlJ4eO9QREOposOR8+Rf6W/3VPWNBMX1VJhkSf
 kfQhfbYqqTjarrmYHP+jTMaYO+BcRkGtNyjz/By688ZTZPYwjq4FDPx+jssODKcEQm8W
 NY9FDCltjl0K+E5592hVihXF6Vm50H2GVj47D0KbAQOyvzk5JaV+Gr6FSAw1IUwktWEu
 CVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830955; x=1745435755;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EDP7JqDEuNIVrsG84kq5lfPSq2oG392d2a/CG5IAa40=;
 b=MXeitzsp5DUNHQe4h4idqRnkA4t5iEaDdPsD/mSD3+L0j4hyTUdIxaid9NwAR/M0aO
 5BpcFQBIjhrpRncq0p2RL/hQrWIa6slTt5+ABpDLIyvsjut86MNBNKj1gkkC0z7Jr9Ua
 VxwPqXfxsNdIdBsU4qm7NTrHdRyQPRqWerLid8qKVMRXEX05M2HoC7pRnuxLpwb2Arch
 Az8yKF6XFm9PvyKmEYyV8U/r/lY+KZ1D8OpqGX6zZS6HfxSkH766bs8mME9E31ai7QVA
 DCgCbsT41NMoF4BVamxwHBUHTQtm7RqrfJ69aZBeTRyh5ofY/QhqdfnvVGqy2VhvGzY1
 +t7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU77rjOJhL+gW6rZ4wuj8q/mxHKbN9rGL22qfaBFqyjSTiq5+Exz2W1L5qAkRWGluKrTTtwZRZao8Hx@nongnu.org
X-Gm-Message-State: AOJu0Yxq5OiKjkZDO8mv+JYmYokKCwqNNGj7jqRhZLVVC3roLIk4Znle
 JooTiIGw2a3cR8L5V92mwzfEi6TOTeAM3tw/GpjtjnGbflvnNLrk20XTajx5BOs=
X-Gm-Gg: ASbGncudPdyerwrxu3BQSTG6vih+fkq6MXx+LTsnClBnbuPXH9NA3ozEWlg0X7LHmyj
 Q/F81EL2hj1i1uS9PD1R5C6GbAsZL7aILELnHDDaWRP12nsO+A4aBMDdd5r35fnLT7I2jmvI7Hd
 2oelhmZEY/xsJB+2v9Ud2NYV1/5J7roaYIerNa+Ryq4PXxFv/oAZKqJMWYaE/cSsQAoIqjqVxVc
 PWmodmvUeZlEtBrFxwhzAijhp7p/sF8e0RABXNGQ//lZNKcoOGa0PJ6/TqaFRJTa+IHkdDDMQkc
 FtzyUoSYmeMCdaBhKw6mYretMHMenH5h3NRdZIudBsiac4dqUinsJ6y57BUZanZy
X-Google-Smtp-Source: AGHT+IHsnYWpl/xC0WNB4czYfqUw8Qje2Q6jGM2olvZYgDrAEcDHhiPXNo8Yz6rf/hor6qXNjuDzpQ==
X-Received: by 2002:a05:6a00:8087:b0:737:e73:f64b with SMTP id
 d2e1a72fcca58-73c266be237mr4250684b3a.1.1744830954945; 
 Wed, 16 Apr 2025 12:15:54 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21e1957sm10761832b3a.78.2025.04.16.12.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:15:54 -0700 (PDT)
Message-ID: <3d77b565-7e66-45d5-817f-f25d12002619@linaro.org>
Date: Wed, 16 Apr 2025 12:15:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 139/163] tcg/s390x: Honor carry_live in tcg_out_movi
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-140-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-140-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> Do not clobber flags if they're live.  Required in order
> to perform register allocation on add/sub carry opcodes.
> LA and AGHI are the same size, so use LA unconditionally.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/s390x/tcg-target.c.inc | 35 +++++++++++++++++++++--------------
>   1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index a30afb455e..e262876614 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -951,25 +951,32 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
>       if (pc_off == (int32_t)pc_off) {
>           tcg_out_insn(s, RIL, LARL, ret, pc_off);
>           if (sval & 1) {
> -            tcg_out_insn(s, RI, AGHI, ret, 1);
> +            tcg_out_insn(s, RX, LA, ret, ret, TCG_REG_NONE, 1);
>           }
>           return;
>       }
>   
> -    /* Otherwise, load it by parts. */
> -    i = is_const_p16((uint32_t)uval);
> -    if (i >= 0) {
> -        tcg_out_insn_RI(s, li_insns[i], ret, uval >> (i * 16));
> -    } else {
> -        tcg_out_insn(s, RIL, LLILF, ret, uval);
> -    }
> -    uval >>= 32;
> -    i = is_const_p16(uval);
> -    if (i >= 0) {
> -        tcg_out_insn_RI(s, oi_insns[i + 2], ret, uval >> (i * 16));
> -    } else {
> -        tcg_out_insn(s, RIL, OIHF, ret, uval);
> +    if (!s->carry_live) {
> +        /* Load by parts, at most 2 instructions. */
> +        i = is_const_p16((uint32_t)uval);
> +        if (i >= 0) {
> +            tcg_out_insn_RI(s, li_insns[i], ret, uval >> (i * 16));
> +        } else {
> +            tcg_out_insn(s, RIL, LLILF, ret, uval);
> +        }
> +        uval >>= 32;
> +        i = is_const_p16(uval);
> +        if (i >= 0) {
> +            tcg_out_insn_RI(s, oi_insns[i + 2], ret, uval >> (i * 16));
> +        } else {
> +            tcg_out_insn(s, RIL, OIHF, ret, uval);
> +        }
> +        return;
>       }
> +
> +    /* Otherwise, stuff it in the constant pool.  */
> +    tcg_out_insn(s, RIL, LGRL, ret, 0);
> +    new_pool_label(s, sval, R_390_PC32DBL, s->code_ptr - 2, 2);
>   }
>   
>   /* Emit a load/store type instruction.  Inputs are:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


