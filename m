Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1C9CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXsT-0004SQ-DM; Fri, 22 May 2026 17:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXsO-0004IZ-Fs
 for qemu-devel@nongnu.org; Fri, 22 May 2026 17:57:54 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXsK-00017K-GV
 for qemu-devel@nongnu.org; Fri, 22 May 2026 17:57:51 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-367cbac9c37so4474371a91.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487067; x=1780091867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5n8IQx7EY0CJn6G/bV7CipFELrrWflkQjUXgLKBAuYo=;
 b=Pr51OvTnb/ByMcPVUsvMR5aF9lH6MCCDPjADTDkRzX87//BrlUdixFKt1auNjy0NDN
 mOaXaWmdrC3clLH32ZKEMsR9T5QXmoil5U0HFjpkv4Sk+j1XuV6c+eECmnJ/qIJ4nTHX
 GXTV1jmXsokKThqtyiwm/x2g3Ju6rB14XktnMEPm0g8GnHo752N98vllDbQ8cyBDrsgG
 GywFlx1vklXPu9QR6Azo4TWu7D7CZCV3hDdKwNbjG9yIUY11WWJ4H43GEBwa81ueH6lm
 OSR4oEMHfh0UBrtXUYsCtqvatXWg9nty1qm6uGVVy11zFNfgHtb/N82aG5SZ0AIl9iJD
 JnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487067; x=1780091867;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5n8IQx7EY0CJn6G/bV7CipFELrrWflkQjUXgLKBAuYo=;
 b=RUYBJFO2gcHT8OzJFQFznRmbtfTEx2uP8Q72bHhXuYIfE7ETdb/pYPR4zWJ/9NQ0Rh
 DtmdLlZ/Wyt1+ydKg31ZB0+aaYY4TB3GjALeZjXi6k9qwUmDuy3lLpq0AOTzoDBr44CA
 mq+KnfkWp+ClGCWKJYvPHzOJxsZPYduk3GJlbqEW6lztSukmAhxBBEq/OyGgSztM1xQm
 3yqPsKnBWFJAm7gqqIVWF0hUPydq4/mla6PHjH6MDdqPm3buugCfANFt1+SbpbH1g3RJ
 bNvDshG7LBBlTfbU+j7TdPLaO32Lye83t4UxSYRex/SMWloX5SVuOzsEaE037v5Z0REC
 gJ0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/IY+at5kl7gqahYc8YVGEzee98AyPvojz6jPGvGOHbfJnLZ2fc4sUykow91KKXL9Kgmu9ckrfyNeYU@nongnu.org
X-Gm-Message-State: AOJu0YzPFpw+B3s0gZ6vrz4B6exukJoZ3KYMel41M1BSp7qUIZkCjeUO
 eeYCqvvMI49emt6Qf2Zc01ePX66HWjLI0UfGkl8TobV1NuFUIA+lhM4kgfpa8Egqjtw=
X-Gm-Gg: Acq92OHKDpwDTbx50XLo49DuC4o8gz6+2wTxAMNjFUEEYvkEFgl1MJY9eTSw05zXoK4
 WOnFZTD0eiLpBzJIXEESDQV2kV+2mnqEcB/kJMaWeFr9dLh7UMHnzFcWSZBk/APOFh+Lrhc3TJL
 HKxvOH3YXURhtgTkQAfeVgJlykZxwwf7Dxsu2+DHEDv5bvHLcCANmEyM+ljCvZjzS+ZIdXEa9Hw
 6Ua2XDIGp+EUrlAfz9uYMKoJMR2EBAWFz3AxNI9DW2UwmjWhbzjs/ozEQMZDhDsPfYeI0CCQVye
 tiG94eLSsmfjM5G8P7CcCDZ/mNyiD8K3q3ijthVYVK2FzyxblgfOzn7EylUEpbtEA59/ig7OAM3
 o6Y+dpDbqN0zp3xXmVCgw7O+K2zABZnlGB9oTQk6Z5iNnKq8z0LlJToQW4/tCIpcCXjZ/xB2Ezb
 AL01SGfEY1Wm3rxR+3xz8xgjJ4hxkE3D0hV9o4tzDs
X-Received: by 2002:a17:90b:3bcc:b0:368:f179:ba07 with SMTP id
 98e67ed59e1d1-36a6746d070mr5128110a91.9.1779487066777; 
 Fri, 22 May 2026 14:57:46 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85202901e6sm2259406a12.2.2026.05.22.14.57.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 14:57:46 -0700 (PDT)
Message-ID: <53e498ea-1110-42f5-aef1-b1233677954b@linaro.org>
Date: Fri, 22 May 2026 14:57:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: SME BFCVT, BFCVTN have "Alternate BFloat16
 behaviors"
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20260521180854.1744788-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521180854.1744788-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 5/21/26 11:08, Peter Maydell wrote:
> The Arm ARM A1.5.10 notes that some instructions have "Alternate
> Bfloat16 behaviors" when FPCR.AH == 1.  We implement these using the
> FPST_AH and FPST_AH_F16 fp_status words.  The list includes the SME
> BFVCT (single-precision to BFloat16) and BFCVTN, but we forgot to
> make those use FPST_AH_F16 when we implemented them. (We get the
> ASIMD and SVE insns on the list right.)
> 
> Add the missing logic to select the right FPST.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 465d36db0e1 ("target/arm: Implement SME2 BFCVT, BFCVTN, FCVT, FCVTN")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> (There will be a minor conflict with the rename of BFCVT to
> BFCVT_hs in RTH's FP8 series.)
> ---
>   target/arm/tcg/translate-sme.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
> index 08254b088e..8e56dedaa3 100644
> --- a/target/arm/tcg/translate-sme.c
> +++ b/target/arm/tcg/translate-sme.c
> @@ -1419,9 +1419,9 @@ static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
>   }
>   
>   TRANS_FEAT(BFCVT, aa64_sme2, do_zz_fpst, a, 0,
> -           FPST_A64, gen_helper_sme2_bfcvt)
> +           s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvt)
>   TRANS_FEAT(BFCVTN, aa64_sme2, do_zz_fpst, a, 0,
> -           FPST_A64, gen_helper_sme2_bfcvtn)
> +           s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvtn)
>   TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
>              FPST_A64, gen_helper_sme2_fcvt_n)
>   TRANS_FEAT(FCVTN, aa64_sme2, do_zz_fpst, a, 0,

What is the difference between FPST_AH and FPST_A64 when AH is set, given that 
vfp_set_fpcr_to_host does the arm_set_*_fp_behaviours dance?


r~

