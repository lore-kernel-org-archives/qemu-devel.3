Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72572C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 10:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVSPS-00044P-OL; Sat, 28 Jun 2025 06:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uVSPR-00044G-AY
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 06:03:45 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uVSPP-0007Ar-Kj
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 06:03:45 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-40791b696a2so960707b6e.2
 for <qemu-devel@nongnu.org>; Sat, 28 Jun 2025 03:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751105022; x=1751709822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6AzfETaTiDOVr/1Slta5f+ZDoCyULP7okI2yn11ncUs=;
 b=LZAlXxkGpIQVPR59BZSdmUbWd5A+4gS0mJqp2rbx9qCjm0K+0CXms5zfnjr2AOV3md
 WbRVMUgXdO6MthCzeXCqj/SdNtCLPWliH2IlPFsxATUEZV7LSGTjhT9Ef0xFPN5+LJCO
 oN3m2ywiemU7136YSX3otrqqb/va0v3gHPGi70VOav5MV5/8sbSllvj7BfcMFAyNkgHL
 XEwHxkuH9rdQLtPl2M748cbsC3IJsS1ogOvRg59zEUdSG7kDv/Yl/xFM+4cHjrwh4Ps2
 y/A8QUQNUwW0pjmL3eTPQiNW0VId3Ukxek85s0PyiD0gVIpDQ/DKhj5Wb429WBZ+rbRZ
 SUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751105022; x=1751709822;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6AzfETaTiDOVr/1Slta5f+ZDoCyULP7okI2yn11ncUs=;
 b=sfchg7IypMwgFgwuRvoMhzvqblJJ6O0i5Fm3NiuW5wgttBCrtftSZAJQ10l7AXTTpp
 clVAVSQjRFoOm+8msUJI/9RBdMJJXRQPmd5RjnbzF3SA41jpFke8sjVyBS4fjTXG3sT3
 br9n8iKU/8oPAypC4tp0jAcr5PwUlFY6uqHuUGeTFYB3L+PeSMMyns7Rcgpi8QuVIjCJ
 7s1OMYR/J55menzBrogCck0ERf8useImIpgnRv228DcH5cJn2+/3mKocBLUySzlaAol5
 xgjHP6gFyn7lfGT4mVWBSBHNT8v9OnbSjVfLY8hvdAzmRujNHKolcv73ZByaizw6P6P1
 43mg==
X-Gm-Message-State: AOJu0YzGrvYwIkOI9hOQDNBw7CtBU9IpIWsOUdWovb480G3WNempOV8a
 2dwLNxfWvoOgwRwAZvPGOW1r8uWwawBezJQTvBl4hTTOZVE4Kel+3xc4yvPn7RX9SFN68+mQyyE
 1K9OoiXo=
X-Gm-Gg: ASbGnctxpCFp4BYREN/AYpgIzUxbjTIZ1cX6iSq58rfIX3/twkfToyu0RAee7Nl4bCN
 iGtPiXA27FnfbByXAWTg1P9LiUSi++A3If5a0LblFiHt8X6JKaMYfth57IjeB8/jpTVWDMunc9e
 /b+/aceq6l8XKMlQTixC5cfh76xe7IMpd3MZicNAYlhxpMcA9Va2L8GgepVnKqTtgQFJq5irIp5
 syQXJrrxh3vOBdtGb7jgFG+qLf6nlCb9G9ek7sEAvS61rVdYcPCkp2PDsIOQ5lpEZPHZBNAd9n6
 V8JO8+f701ud88eczv43F3kyKBzipT1cQTr35ZXyIOheh5L8/a1gDcGUkfUVDZGJI9GgSfSuA5u
 5
X-Google-Smtp-Source: AGHT+IHvYahxxo1os4XHzvc9K1GTFCYEn2XCpouhMeBQqKvgtuoGOUceJ4pkiimE7FhVU4gSRaqe2w==
X-Received: by 2002:a05:6808:1921:b0:40a:ba8b:ee61 with SMTP id
 5614622812f47-40b33c5d605mr5204111b6e.10.1751105021679; 
 Sat, 28 Jun 2025 03:03:41 -0700 (PDT)
Received: from [10.25.7.25] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b322ae48esm754362b6e.13.2025.06.28.03.03.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Jun 2025 03:03:40 -0700 (PDT)
Message-ID: <b9f5cc76-1fdc-4363-826d-ab45f58c3e73@linaro.org>
Date: Sat, 28 Jun 2025 04:03:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: rvv: Fix missing exit TB flow for ldff_trans
To: qemu-devel@nongnu.org
References: <20250627133013.443997-1-max.chou@sifive.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250627133013.443997-1-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 6/27/25 06:30, Max Chou wrote:
> According to the V spec, the vector fault-only-first load instructions
> may change the VL CSR.
> So the ldff_trans TCG translation function should generate the
> lookup_and_goto_ptr flow as the vsetvl/vsetvli translation function to
> make sure the vl_eq_vlmax TB flag is correct.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 2b6077ac067..4cd030c7eb3 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -1361,6 +1361,12 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>       fn(dest, mask, base, tcg_env, desc);
>   
>       finalize_rvv_inst(s);
> +
> +    /* vector unit-stride fault-only-first load may modify vl CSR */
> +    gen_update_pc(s, s->cur_insn_len);
> +    lookup_and_goto_ptr(s);
> +    s->base.is_jmp = DISAS_NORETURN;
> +
>       return true;
>   }
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

