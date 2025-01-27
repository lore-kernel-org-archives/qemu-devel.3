Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7936C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 05:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcHFC-0001Bu-M2; Mon, 27 Jan 2025 00:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcHF3-00013r-SU
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 00:00:58 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcHF1-0000dm-5K
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 00:00:56 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2eeb4d643a5so7151937a91.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 21:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737954053; x=1738558853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=km1qSIPFoL2GspGAwukkzMeF70ydciwBc2wD8XKhPNs=;
 b=v0Afzu2N14Axpn8LBxo8b2WY6OIYPYlLp7iy30xwqbkOb5V5UAw77dhuVXAcmgKYKE
 lV3mcmwbvnDgQJ7tocp6Hl6QpiRBB7z8XgP/koRF3x/43xnp6c/NcZX1KXYwBGQAvsgY
 BzKwyLaRbPr8UQL56y+zeOL+0QWVb7Cy9htSeqLoly+UTATh8GL7zo73lXsbF6hLoYJx
 BMpcOUaIhr0L2Z9/8dYcF4xwFK0C47siclQ0iaZ8JUph6MiTpq+a+hi+hdcZS81sXAMc
 j+IU7i5u7YQKPnB29J/ve2po5Ka/2RJZMDpxHLXpsTxzhvQ2JM884cBNJ+0RLsBlshiI
 KvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737954053; x=1738558853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=km1qSIPFoL2GspGAwukkzMeF70ydciwBc2wD8XKhPNs=;
 b=xHggNgQ1/FUExs/SBVvgqWtx4BNeUSVqLRGGpDxpE30/kFaPKqvzCsZLuOvRpGBcVf
 7bYdzsOWKLGTdvVQTcz2rmyRAgdf92wXfUUd+enxJnImSe9ZgO6lvauFr5ygYlgEh/24
 cOrSzUXKQezwr7to/OJA04qfMPO1NqoXRGmCMoAvXkWMcsrIAk7UMUUaOgOKi14CQp3Y
 +EP4UDKqURdM27QOEHravVHoCNxBIaFRj3tneWIyv+7umn8BNEuMpV7KlTkhQ3K1MBj+
 jhgA4KuBp/KqzMc2lGj12v0qZZO5RRYStcxehmEoDbfRAligyJ89FGGkrqmITdT/oH37
 HirQ==
X-Gm-Message-State: AOJu0YzkhhQfA1yl3HevLXp+VO9HF8G/5PT0bGjw24BvinhQP2t6QW8P
 AllO6/mrlHEo4xgiNuqpxENqdUrjdU4r+T+miE/9T5rwcUlxuL4yTzXyaoDmmOgw8GBvXip+LUf
 e
X-Gm-Gg: ASbGncupOsti49a7XwpYFn3x1iXZgIY1K73+jU0SQLp75epDRB7qnS3ek23uYpfxWfY
 ejRRQ7YZKoQBDKkK73yGYH9UzCONZCamfu5GXTi4dbdKP7bf4Ah2goizSdT6wNMSuqxCwpWfV1d
 aI29x3DOr47aox2JC91QXEU2iytmSN/euHO/WHoB/HGoHlNSRsE6yECi3ESgozwUJtv5yZfdlqF
 uXTtIKe/sRXSEelRoKauwRFfWtFMtEkzrj1MPT81iNiCwWT/CTdm6OoAtvmXwYdvIy+D0v3d8NM
 yAc/omcMo8KeTS+iTydQ0PMzFr1uSGokNpl+T6/PaV3mxJQ=
X-Google-Smtp-Source: AGHT+IGqR4QH3Mb4YgwbxQf02nNvZG36v1IpYy0/FTBTmDAhFixdweAsu8epaZAqF5SDPXSjLGAmLQ==
X-Received: by 2002:a05:6a00:84e:b0:724:d503:87a1 with SMTP id
 d2e1a72fcca58-72dafa018f1mr54135053b3a.7.1737954053488; 
 Sun, 26 Jan 2025 21:00:53 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69fb3esm6082551b3a.23.2025.01.26.21.00.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 21:00:53 -0800 (PST)
Message-ID: <78fdb94b-2147-4418-b1b3-dbff906073a1@linaro.org>
Date: Sun, 26 Jan 2025 21:00:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/76] target/arm: Define new fp_status_f16_a32 and
 fp_status_f16_a64
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-14-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:27, Peter Maydell wrote:
> --- a/target/arm/tcg/translate.h
> +++ b/target/arm/tcg/translate.h
> @@ -673,6 +673,8 @@ typedef enum ARMFPStatusFlavour {
>       FPST_FPCR_A32,
>       FPST_FPCR_A64,
>       FPST_FPCR_F16,
> +    FPST_FPCR_F16_A32,
> +    FPST_FPCR_F16_A64,
>       FPST_STD,
>       FPST_STD_F16,
>   } ARMFPStatusFlavour;

May I suggest calling these FPST_A32_F16 and FPST_A64_F16.
This matches FPST_STD_F16 and FPST_AH_F16.


r~

