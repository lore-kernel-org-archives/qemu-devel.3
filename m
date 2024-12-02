Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00CBD78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI77X-0005cw-9e; Mon, 02 Dec 2024 09:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI77K-0005ZK-3B
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:09:38 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI77I-0005By-Cv
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:09:37 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa5ec8d6f64so12029266b.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 06:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733148575; x=1733753375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/kB1IHMxp8iRwo+CK0qNdpbRDF2EAisKa/YauKytlNs=;
 b=IstovOhR8YvLXZBJeO+17x2PJmh3+RZ6fBSVyVcCbPeq0MHeSTwIXgSjm/cv7jg1Yk
 g2taS0CM40tRVTlW6xWZCsBgjJ52ge7QeccGVRgf6ixaZadjfjcGJ1hG6Tw67QagWbjZ
 XXgT/610EwsUtikii+NacWop4odm+zrWhQk27HSRMH7vZwO0WxKYiALGfWxn8z6E3R9f
 TAmBkxITwV0l9uVnQPLmPsAPPqBk3oC9IG7wANFftwoR64QAatyELZzY+oGr8Dqczxl3
 waZeluq5KsBxtianWRokiNrrJnSMQd1O0NghSmYBQAvpN7trko/UBe5Boi5GWiM+UdSe
 djBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733148575; x=1733753375;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/kB1IHMxp8iRwo+CK0qNdpbRDF2EAisKa/YauKytlNs=;
 b=Ca9cntcPq2wdQn4Gn66l++yc7yGVQrQ0orDGbdsVOWblIsHk3K8yJj1hBcYEg+P8fT
 LIsNjHo7seZVkj8BswQRP0htwTgRrhxYuR0G82uaF81+ST3mV/8q7XHHVFEhFMtCe/fk
 T6k+fsGaDxdSr1iMcFCHWf1rkWPlR7plZBva4EBwcMArMHd+c6PfJdxqSRGvBxXgMnm0
 i+OFn+cnFix6NGuiXKUDL88DemXt4PutNVQ4v89LtqPMHtCP77ILXPq0Px8JmTp79bIK
 fstPcSg9tK4Z5nDtxzUMWf/LExBWmVdTqBUnQpTDHHk69ZuhTE0taQ6C1xzCdcsMt1DO
 2lsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg6S8BHieOYiZUwCGnSoQYEnDGpWRVRDLlRY15NGKkR5vd/QyOq4mAPNKSe/PjfJP5urhh8zja8VNV@nongnu.org
X-Gm-Message-State: AOJu0Yww3G7bTigGU31JHioFRSzP6WMn2Ensl1SNbCMSq7dbPEh5rtHA
 A2ZbfgEfPfGEyF9zEkI/kFDW0RHssuAEoPr6bMqlB2pPSYSm5sx+/ggdz8/AHJtF4FqnIro7spR
 cU+E=
X-Gm-Gg: ASbGncvqN3Dy5EuFkfjlRSjb0lbF6MQ1z8I4HQSBSI0+QboyUW3RzzhyEmfPxGSLLCO
 wef/F19l5GiN+iZQZVstubgeEPEejrX8SuWmim5ElatwDvI/qsew/iU7zIfBDzi5O5Kz2q066v9
 n/HE1JErquq1QpwP3x2nJgCRlm9wtuZqZFz1mrCTyxsx3610ZCFTpBuzFbO20Jn1Czz7vx/DLln
 td+0FQGWyvKbIe0uK4xA0QKX8rVgI8R9sq1eSHnMK8Bq9bi6oKYfwzAEgYR2UftOGBP9kjKZ2cD
 os/YLpIIx3G9P2rc6yWaXXAVhWpD9w==
X-Google-Smtp-Source: AGHT+IHyEMqVqAzjlgfkfy7X7vIVBbf+rvu13JU8abLm9Iln5XYRaBmosLSO1sko3CneShVZp6kdFg==
X-Received: by 2002:a05:6000:4020:b0:382:40ad:44b2 with SMTP id
 ffacd0b85a97d-385c6ebba51mr25523045f8f.34.1733148093134; 
 Mon, 02 Dec 2024 06:01:33 -0800 (PST)
Received: from [192.168.68.213] (72.red-95-127-54.dynamicip.rima-tde.net.
 [95.127.54.72]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e230b283sm7813306f8f.106.2024.12.02.06.01.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 06:01:32 -0800 (PST)
Message-ID: <59d6b035-8be3-43bb-849d-5664bcd34795@linaro.org>
Date: Mon, 2 Dec 2024 15:01:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/67] target/arm: Convert CRC32, CRC32C to decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241201150607.12812-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Richard,

On 1/12/24 16:05, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 101 +++++++++++++--------------------
>   target/arm/tcg/a64.decode      |  12 ++++
>   2 files changed, 53 insertions(+), 60 deletions(-)
> 
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 8b7ca2c68a..22594a1149 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -7592,6 +7592,39 @@ TRANS(LSRV, do_shift_reg, a, A64_SHIFT_TYPE_LSR)
>   TRANS(ASRV, do_shift_reg, a, A64_SHIFT_TYPE_ASR)
>   TRANS(RORV, do_shift_reg, a, A64_SHIFT_TYPE_ROR)
>   
> +static bool do_crc32(DisasContext *s, arg_rrr_e *a, bool crc32c)
> +{
> +    TCGv_i64 tcg_acc, tcg_val, tcg_rd;
> +    TCGv_i32 tcg_bytes;
> +
> +    switch (a->esz) {
> +    case MO_8:
> +    case MO_16:
> +    case MO_32:
> +        tcg_val = tcg_temp_new_i64();
> +        tcg_gen_extract_i64(tcg_val, cpu_reg(s, a->rm), 0, 8 << a->esz);
> +        break;
> +    case MO_64:
> +        tcg_val = cpu_reg(s, a->rm);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    tcg_acc = cpu_reg(s, a->rn);
> +    tcg_bytes = tcg_constant_i32(1 << a->esz);
> +    tcg_rd = cpu_reg(s, a->rd);
> +
> +    if (crc32c) {
> +        gen_helper_crc32c_64(tcg_rd, tcg_acc, tcg_val, tcg_bytes);
> +    } else {
> +        gen_helper_crc32_64(tcg_rd, tcg_acc, tcg_val, tcg_bytes);
> +    }
> +    return true;
> +}
> +
> +TRANS_FEAT(CRC32, aa64_crc32, do_crc32, a, false)
> +TRANS_FEAT(CRC32C, aa64_crc32, do_crc32, a, true)
> +
>   /* Logical (shifted register)
>    *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
>    * +----+-----+-----------+-------+---+------+--------+------+------+
> @@ -8473,52 +8506,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
>   }
>   
>   
> -/* CRC32[BHWX], CRC32C[BHWX] */
> -static void handle_crc32(DisasContext *s,
> -                         unsigned int sf, unsigned int sz, bool crc32c,
> -                         unsigned int rm, unsigned int rn, unsigned int rd)
> -{
> -    TCGv_i64 tcg_acc, tcg_val;
> -    TCGv_i32 tcg_bytes;
> -
> -    if (!dc_isar_feature(aa64_crc32, s)
> -        || (sf == 1 && sz != 3)
> -        || (sf == 0 && sz == 3)) {

We are not checking the sf bit anymore, is that intended?

Should we add the 'rrr_sf_[bhsd]' format?

> -        unallocated_encoding(s);
> -        return;
> -    }
> -
> -    if (sz == 3) {
> -        tcg_val = cpu_reg(s, rm);
> -    } else {
> -        uint64_t mask;
> -        switch (sz) {
> -        case 0:
> -            mask = 0xFF;
> -            break;
> -        case 1:
> -            mask = 0xFFFF;
> -            break;
> -        case 2:
> -            mask = 0xFFFFFFFF;
> -            break;
> -        default:
> -            g_assert_not_reached();
> -        }
> -        tcg_val = tcg_temp_new_i64();
> -        tcg_gen_andi_i64(tcg_val, cpu_reg(s, rm), mask);
> -    }
> -
> -    tcg_acc = cpu_reg(s, rn);
> -    tcg_bytes = tcg_constant_i32(1 << sz);
> -
> -    if (crc32c) {
> -        gen_helper_crc32c_64(cpu_reg(s, rd), tcg_acc, tcg_val, tcg_bytes);
> -    } else {
> -        gen_helper_crc32_64(cpu_reg(s, rd), tcg_acc, tcg_val, tcg_bytes);
> -    }
> -}
> -
>   /* Data-processing (2 source)
>    *   31   30  29 28             21 20  16 15    10 9    5 4    0
>    * +----+---+---+-----------------+------+--------+------+------+
> @@ -8590,20 +8577,6 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
>           gen_helper_pacga(cpu_reg(s, rd), tcg_env,
>                            cpu_reg(s, rn), cpu_reg_sp(s, rm));
>           break;
> -    case 16:
> -    case 17:
> -    case 18:
> -    case 19:
> -    case 20:
> -    case 21:
> -    case 22:
> -    case 23: /* CRC32 */
> -    {
> -        int sz = extract32(opcode, 0, 2);
> -        bool crc32c = extract32(opcode, 2, 1);
> -        handle_crc32(s, sf, sz, crc32c, rm, rn, rd);
> -        break;
> -    }
>       default:
>       do_unallocated:
>       case 2: /* UDIV */
> @@ -8612,6 +8585,14 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
>       case 9: /* LSRV */
>       case 10: /* ASRV */
>       case 11: /* RORV */
> +    case 16:
> +    case 17:
> +    case 18:
> +    case 19:
> +    case 20:
> +    case 21:
> +    case 22:
> +    case 23: /* CRC32 */
>           unallocated_encoding(s);
>           break;
>       }
> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> index 3db55b78a6..1664f4793c 100644
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -45,7 +45,9 @@
>   @rr_d           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=3
>   @rr_sd          ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_sd
>   
> +@rrr_b          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=0
>   @rrr_h          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=1
> +@rrr_s          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=2
>   @rrr_d          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=3
>   @rrr_sd         ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_sd
>   @rrr_hsd        ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_hsd
> @@ -663,6 +665,16 @@ LSRV            . 00 11010110 ..... 00100 1 ..... ..... @rrr_sf
>   ASRV            . 00 11010110 ..... 00101 0 ..... ..... @rrr_sf
>   RORV            . 00 11010110 ..... 00101 1 ..... ..... @rrr_sf
>   
> +CRC32           0 00 11010110 ..... 0100 00 ..... ..... @rrr_b
> +CRC32           0 00 11010110 ..... 0100 01 ..... ..... @rrr_h
> +CRC32           0 00 11010110 ..... 0100 10 ..... ..... @rrr_s
> +CRC32           1 00 11010110 ..... 0100 11 ..... ..... @rrr_d
> +
> +CRC32C          0 00 11010110 ..... 0101 00 ..... ..... @rrr_b
> +CRC32C          0 00 11010110 ..... 0101 01 ..... ..... @rrr_h
> +CRC32C          0 00 11010110 ..... 0101 10 ..... ..... @rrr_s
> +CRC32C          1 00 11010110 ..... 0101 11 ..... ..... @rrr_d
> +
>   # Data Processing (1-source)
>   # Logical (shifted reg)
>   # Add/subtract (shifted reg)


