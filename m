Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19500F5A8C5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 21:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEw1p-0003sa-MC; Mon, 20 Apr 2026 17:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wEw1n-0003qD-UZ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 17:19:35 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wEw1m-00070H-G7
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 17:19:35 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c76b9efc299so1347594a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776719973; x=1777324773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4AwPcikX7nZl4Ety17yDKIrv0ejV11biieEs5qDjQ/w=;
 b=TtqC2io8e/8680eXTCyh7X8iqZUOhmFEpuWbl+unyFQZwhkWhIEWfcSkOFWQzWepfk
 qmu+PgJVszrAcQ9IvofgNO/ivBgXjmCD9Ru1ZO2OrL7Lx+npuKwUaozmQYm3KiJ67mnF
 JWVWrtxDI5AGyq/kKlMkpg5NlsJ4ZXRCcvlv0gJ8IlYS7e+stOBL2BtnpeAJdZuZSROY
 1YLdOepGqMB9rMMceg2Ibu3mjKPikI1kE6DduTg7Y4O0CnSCvunUS4loJHnjrwO6orIY
 t/AFLi0I7od8OZ8nPiGjkuW2DfwEPhrMeZTDGV2FqYRx8wNnUcYZHk0lzCUxTdo1BzoR
 q9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776719973; x=1777324773;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4AwPcikX7nZl4Ety17yDKIrv0ejV11biieEs5qDjQ/w=;
 b=eiO7RVLOnT7ojGUJqXkkUxMIoH1Rz51r1197HZmLZaNugVBHQGWEJsOO2wgdvMrYKm
 gEVbuDV6I0aZCVYn221VRP0snZ9VQUrb9uXXL0wQ80lT0FZ1pPoZJ9IPCLWAyCgMmSe/
 C7yWg/8kOW4LLl7nQJqV1nb8n28H2rIP1GJinNihLcjscrL+GxfQI3enLGhOghhT7s35
 yrTZQfQbx7QG31v1f/b5os7haz80k4htaaRJEB8XDw30w4pPxiFHmSZifrmFPuu8WjdT
 tCoN4P5JccoGNB9fePyDjnhmrevsPG0qddB8dZ6iDutRcNAPPzp0W9b7NzAPHqj1XnFL
 lb1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+l1ZYbH8b1N5uBTEwoU0l1KxELuLU9XA4CsQzm7CtcKEJ6+rUY3ukIGMT7WVd1V/7lpJSfTyzmoXQu@nongnu.org
X-Gm-Message-State: AOJu0YwvZ1Cdo5FtpDV/WEtO/8qNE+1tQx7RFrE9btIga1cL4AzW7PhE
 A8uA03RxKtlTVrCFTekUZfySRgAZU7Tok5wrn1e9o7ipQN6Yn6PUVdBnUVEouS0iZ+W0FBbSkkr
 6jo4dAtA=
X-Gm-Gg: AeBDievvbuECwNasY0oe8hi14qTUyCdr/dYpARrjQ5E8D5U+r/WrmHrytTf/uWQJE+J
 DV0WeGDFBSt7JzntjaZQ/wp9dPEKWqpu3ZoCEqPL9U6h+zFJ5MFTSwtKSCkQsSlzvDDet6osWvB
 vbO1nYxWcET7UMI7NS9X1XRrHVLmn6rO62coKn8d8pJK1KaKXZlWkFRaHWUe+VW766U/AeOrxqE
 j2zwNcgSgrSGL0121pUSvWpc+rE7/rnybDOJU2DyaCHhjAo5Qzrf7A501T5IGohmKtRJTX3nqHf
 +M+TOf2alJ1PieI5fWQaml6RwdM7ODP4PeGaAI/TQcIZQXD3y69OOcRodaHLQ9mx2ScPbGmxrw6
 4a/dVBcmpRkffzA1Blr3DuJWNrJbU8blxbwwKnvSmlcsTnokn0xBhx6ikvjUuHPzt+PBBglsk7l
 KRDNn3aUAaUpIXdBdxyxNGKHqFviOYWJ/FegMsND4H8Lx0L3HOL6/g
X-Received: by 2002:a05:6a21:9995:b0:39f:24a5:3065 with SMTP id
 adf61e73a8af0-3a08d68e9eamr17079431637.7.1776719972997; 
 Mon, 20 Apr 2026 14:19:32 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c797702faaesm8469799a12.23.2026.04.20.14.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 14:19:32 -0700 (PDT)
Message-ID: <7859bec0-5455-443e-8dc3-ae741c04a24b@linaro.org>
Date: Tue, 21 Apr 2026 07:19:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] target/mips: Remove last MO_TE use
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260417042620.35329-1-philmd@linaro.org>
 <20260417042620.35329-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417042620.35329-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 4/17/26 14:26, Philippe Mathieu-Daudé wrote:
> Unfortunately commit 54821ff6e90 ("target/mips: Convert mips16e
> decr_and_load/store() macros to functions") got rebased on top
> of commit 2803e24694c ("target/mips: Replace MO_TE by mo_endian")
> and we missed the replacement. Fix that.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/mips16e_translate.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
> index beb5b04ea29..e83587971d4 100644
> --- a/target/mips/tcg/mips16e_translate.c.inc
> +++ b/target/mips/tcg/mips16e_translate.c.inc
> @@ -293,7 +293,7 @@ static void decr_and_load(DisasContext *ctx, unsigned regidx, TCGv t0)
>   
>       tcg_gen_movi_tl(t2, -4);
>       gen_op_addr_add(ctx, t0, t0, t2);
> -    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_SL |
> +    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
>                          ctx->default_tcg_memop_mask);
>       gen_store_gpr(t1, regidx);
>   }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

