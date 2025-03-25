Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359F8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtEW-0001Xb-Ot; Mon, 24 Mar 2025 21:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEP-0001W7-IQ
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:31 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEM-0007Pr-FM
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:27 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22403cbb47fso96023825ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 18:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742866645; x=1743471445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=73eju5b8PAtVZfnFlHNygTriKdBR5WLNyrjR3QHF0ZA=;
 b=tZhzaiTo2jzCq9rGnjGJvhJlV666Vod6wmDXY6cU27FJHTkI60RGFdee4CAk6TJJlT
 rIpqVBuwa+xY0MIZR/btfJ1mvw7WEQSOA3vhfzE9fmoRs3qPEMXBRIP2UK9b8jNeaJie
 qqa5ZECAuFMHmHCla5OkWtvPYHfyA7iC314RElIBhF34uHXvnHZ03HW2zbTXwGbGVeV5
 xIQT0DURQCPujDLJSbhMS9Ai3LeMb/h1tNg8uIzJuy6VL+fbjeCIW+D7W4H0cIafTxvM
 q2jNK1++ogZ+yuu9WAIpqBvRQGBTHAsVSWu4Ud4FLA8d8KEKr0NUWq87clQvc29fk5Ru
 y5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742866645; x=1743471445;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=73eju5b8PAtVZfnFlHNygTriKdBR5WLNyrjR3QHF0ZA=;
 b=SMiophc+ppBSRLwHKwqi3HIXCcPexWPO8nejiLU9xMKhpTbSJCkmgiKZY9DLz5aiCU
 9ZZyUzRoOaboGIkwDc0DMvCW4+RpNQAp+3Ndge6lioAbBPQaMzTmOjhqRrDd9wx501P+
 fGMD1v9F+TxenjRHH7k/Y2dltr9V2aAO+7OdPpxr/pVZTGlFg57yEVbTsQTvbTkFm0jX
 rXkLigXJJXAuVojdK/e+A3ZbgP4DBnqiqvy8fEVjPsA5TWm+OUMydo0uIRNnpAcz3Gb4
 WC7XcKBOO9Vr2y/jx0d1zBO1fHI+g+JCf4w0XfDxn0F9RJgr+8oNz2wVFTyH573IbWnq
 ZOvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVALxw/gwM+AKoKGMpY0CciNkExClo3qxlEtlSfCo+q5dSk6NdB8tb7Z+mH2QGpPVvr3yScl80+f09G@nongnu.org
X-Gm-Message-State: AOJu0YxpFtZljL0RO+jXEg0p69u3x9Pb4/vHqR7ZhbPAzC6xYvOGxZX4
 mx6l1YEjRxYcnyYSKIQSzmU7AnHn77NpKapoguoGFPcCfA4Z2uJLqNzPsUrarCE=
X-Gm-Gg: ASbGncs1NAVDAo9jp8fZOYAuDQnJtR56GZf5otB6GIFzY7+nSd5ZmG44tXzfHtuOQTU
 1TlHq1TY7dnu6op1eFbQkHqoLymcbha3ZrgrDWjdzyoBuu3Jt/PLb6GIkXYi6LGAPyEeTt+CVPx
 8Kp1x76WLXzth5xXLxh5Ai2fEzKklRS6XXPHms3cX4lsuwuJkaQtlJMr5BS1g9ZzddBOCUf5aCB
 2buKNFhK0Zqda3J695XMih6DR6c5sg7f4XQqHOsDcRIvu5etBJN6F6XVs7IorsV1EmvcYCuillc
 hizYKEZyaGslV70zA4fLmW2DnL8cdqRx7upZhKfiA0TKyWnSOMRP48x+Jw==
X-Google-Smtp-Source: AGHT+IHfDbroOS1ZoUL1OayUMtVUZKYQWW/z735eNg/g17WHhtISdjS64F/4Vz3lewH3oj7sLRwJdQ==
X-Received: by 2002:a05:6a00:3d43:b0:732:2923:b70f with SMTP id
 d2e1a72fcca58-7390599ea49mr25946966b3a.11.1742866644872; 
 Mon, 24 Mar 2025 18:37:24 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73906158ef2sm9090422b3a.141.2025.03.24.18.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 18:37:24 -0700 (PDT)
Message-ID: <7f12053e-b9cf-4182-bbfc-bb96040776ae@linaro.org>
Date: Mon, 24 Mar 2025 18:20:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] target/avr: Handle offset_io in helper.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-13-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323173730.3213964-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/23/25 10:37, Richard Henderson wrote:
> Prepare for offset_io being non-zero in do_stb.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/helper.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> index 9608e59584..3323f32c22 100644
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -69,7 +69,8 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>   
>   static void do_stb(CPUAVRState *env, uint32_t addr, uint8_t data, uintptr_t ra)
>   {
> -    cpu_stb_mmuidx_ra(env, addr, data, MMU_DATA_IDX, ra);
> +    cpu_stb_mmuidx_ra(env, addr + env_archcpu(env)->offset_io,
> +                      data, MMU_DATA_IDX, ra);
>   }
>   
>   void avr_cpu_do_interrupt(CPUState *cs)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


