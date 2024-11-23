Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4699E6ADFF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 13:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEqbU-0007Wj-GT; Sat, 23 Nov 2024 08:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEqbN-0007Rw-3U
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 08:55:10 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEqbL-0002rl-8k
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 08:55:08 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-295d27f9fc9so2388995fac.0
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 05:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732370106; x=1732974906; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AJc25+dSQHUILeCA4jN1qnTr+e5ECOoGf7XJSWsiFZo=;
 b=JMgGpf10tu+H1AllFTGFTSfHUKnMnRfIDBxQkZgRMQF8mGkedWBGYum3ffeMDNRFMU
 YztIkyYOhAvb1SJR7/ZzHvKsT6+yg3DNkRPnEgYnuO0ACek28E7dlxS3J9qnMAJtaUfY
 lwQZThWDx1DP8QjQ/7PVoZhFsQ7T0sKSh1xOFje1caeHNneX2MzGXvkl2DOI7xnKHWpP
 tvvVh2sCq2IJHaW2inEADIYwtFHEt+d9fjGL0q/ACEnM11a8KuKGw9PMc69b1euhvY0m
 C2BuIZ0/QpkDLqjXyp7rrQuy8eCc92d9fMKGMrYinbw9tkuXJeqS09tULohB7YDLFcmo
 SSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732370106; x=1732974906;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AJc25+dSQHUILeCA4jN1qnTr+e5ECOoGf7XJSWsiFZo=;
 b=thuUnV9I563VngofkgjScIJSwR6UbHd+B2PA3sCfKUF2Mk6IsJDUj57QN26GtCqdxI
 RVJ8b62XtWBBpyfLHWf1+mQtHt/plo92LMMi+B5faWALOkfRz3g3dit4qEX03EM8AqC+
 ZPNuwM7yDl9bSNywPo94L4NhpnlssEvuXREDEuVuszHv2FVPPd+W7NNRWjst4scxdZzc
 H7fYuncvqAtUzApxBLMSpq9I58G4WvR/vEkxF/eB2pNp/hIaSRfkRaXSmog3ElcTKU5y
 76qPhNrmitc/s9U+zfR6NcWfq2apGPeSmSoDjFjACPlCt1IhY5vGaGvvIGVD1Qf5WyaX
 8YMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtalOSl9qCKnubTTultgHrsRRNYti2v5/FTqyUwnEcnHpOvGJ8AEBGxRpieHhg23cfEepqjQnH5cSr@nongnu.org
X-Gm-Message-State: AOJu0YyjMEeVcngiyGbmJhl1eBALGxe+RqmwrE4tJwfcCZIq6D7fVbcx
 D7gLrdZMLb6SOEsuAFwvzAr4oFB5tFR1hmYjgieuumbRtXj7wztszorESNeQAKo=
X-Gm-Gg: ASbGnctuo1Su+AH2Pu7rPJJVTfdP/Id2HW2A06uY8wo0zPQbs/ibwVtL7jiL2aqDjGf
 0jOsvhiecLr1HGApF86RAlGXIS3mNmJw8FTmwAJJpMAa4hYnLjrdhxmr8V8mwQHCRz6ekhrN0LK
 +FV1REYASQQ/2opAu6OSjE3QcTtKs9NEHnUAIfQucF+5CZ/rphB3ilO0D3FAITAMegX2E4XeItU
 mnAvShWcAhZQrfXcOXfRpDmIAcx6RJy3zzRMjtGV7vJeRmjWTOhFz2TOIFro1jAuw==
X-Google-Smtp-Source: AGHT+IFSWTpCWaBvKjRInTxMTGUorbedv6Hc4u+ZbV6Dkm9KWPTYSESypqg6by15ZjEMzgDDMCMhDg==
X-Received: by 2002:a05:6870:168b:b0:296:e5ef:6b4e with SMTP id
 586e51a60fabf-29720f79e30mr5825569fac.37.1732370105781; 
 Sat, 23 Nov 2024 05:55:05 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29724490f17sm1211665fac.6.2024.11.23.05.55.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 Nov 2024 05:55:05 -0800 (PST)
Message-ID: <6fbdbe5b-f592-4426-8136-9e04ef770a5c@linaro.org>
Date: Sat, 23 Nov 2024 07:55:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] target/arm/tcg/: fix typo in FEAT name
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
 <20241122225049.1617774-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241122225049.1617774-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 11/22/24 16:50, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/cpu32.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Oops.  :-)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> 
> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> index 20c2737f17b..4e589b747e4 100644
> --- a/target/arm/tcg/cpu32.c
> +++ b/target/arm/tcg/cpu32.c
> @@ -71,7 +71,7 @@ void aa32_max_features(ARMCPU *cpu)
>       cpu->isar.id_mmfr5 = t;
>   
>       t = cpu->isar.id_pfr0;
> -    t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CVS2 */
> +    t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CSV2 */
>       t = FIELD_DP32(t, ID_PFR0, DIT, 1);           /* FEAT_DIT */
>       t = FIELD_DP32(t, ID_PFR0, RAS, 1);           /* FEAT_RAS */
>       cpu->isar.id_pfr0 = t;


