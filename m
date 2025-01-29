Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE23C0218F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdC0T-0003BV-8h; Wed, 29 Jan 2025 12:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC0O-0002tE-DV
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:37:38 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC0M-00038e-Un
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:37:36 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso51835685e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172253; x=1738777053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OmYPK9+t29dsXg0p+YjjgOKRJivedUaoe18P3QisnuE=;
 b=OMMeEY0lgeaczoP3yvlXUP4RwI09gF9oAQybhUkC23qpxXNhYNs+sNjS6fcm+3b5h6
 q2NfM9wPwMIK8FsoJAVyvMDk3ogoy6GqkQ7NXV+RNO8DE2ahS2gO3xSgqWL3A3y7l4bl
 1n+Kzv7/zZGO982pkqYy0jZemgMwFCfpmvxO6K1ELZrtgX8flmUcU0vQC4uqGG0/kPU/
 3E4AKVjGoZgAM+7wINhTzemYT3op8YdAHLW1lo16UsCSeGCr0SVk3qT0KjxV/2hD2CsO
 78ZSNuLD4jk+ACK6LEMJAYFIB+pfTdYKfmwr6i8fU46zW+ZcJMZhqoRidqkaxMyjopOe
 cRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172253; x=1738777053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OmYPK9+t29dsXg0p+YjjgOKRJivedUaoe18P3QisnuE=;
 b=R1FFnrU4AHWBKZuq0jhOXbcPm11DRMq+N2Om4yVTtVVM+D2RZj0sLikeh8UhTELNJt
 D+2df0FEdm2PdvhuoPbrCBomA7SKvAEfaDBsp2eYeUW1mNCyC3rVDVFUGvA43jc57jJm
 KmlxNfkjb7G/DKGViqBT9+KzOaz05vp2lhGGwEnjyH6SZCAonYJmRF0kiqJa3rY7cKSM
 1i1nmtyZSvjpCh5YYEdIsIw5wnWFF/ebcg7TxC4TBg2+nvZLLheP+A0+xuOCzg8ej/z+
 jtl9+4TZmUBpsB77c4wAEHJ4SCpr/zblWQqoKRuEmZxBEjKqTE7xc0rcixOyt/PH4+kP
 G4ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQDCli/kwzMW2ivAhiX40CnGXXoAdUZ3DkC+ISytL/gNA3mPrQPWgvqbdJv+pAvK6oYgQLV1CAkNru@nongnu.org
X-Gm-Message-State: AOJu0Ywp5x+XZgyvw9hkZbBDP7MbQfTqQvmUxXJfvu5zmQzsOqM06lI9
 fdylVegTYcVF2hP4b04WfXxiplVq+GWLpf6Bsxpubl42H5Uzr24hAJyqUsI6X+j7TRGPHbu6zM/
 GqT0=
X-Gm-Gg: ASbGncv8cDb4dv0UUCXJgi++es4lsnqwtG+zpPsSPvH431sDonnLjrqtIk/Lo3d2cN4
 z7Q3Jy5+ZECgKtYv39Yq2r1jbGltZ9wy52WEtiMK3YJobvMb7pUgKc0f+g1IAgGGt4fjETH46ja
 UcyhGh2ONjPAxJQIUKEmBAFAd6Idnx7rpVg3RX7WwU4rTISz4VeAorZjPCW4rS66mnpWaA+K0YJ
 MJwUWGq+jGwoIBPQWe06sULI/iVSpAVh4TaX5qpfsg0044o7+VOiNaj/Mc+FkNiHGX4QuKS4M3e
 7l+tz6OsxBAPA5JhVn5pDHJe5qVfpOKBcbWTANUMM+YwbUHEkB2NSFjGdPc=
X-Google-Smtp-Source: AGHT+IEQNBZ1PCUCIoUJQnXwWHAwpNcEMEy5Dw4TvpVRpfreURe/o1XaQmaC0wYl6sj0KCgKBFO/Dg==
X-Received: by 2002:a05:600c:3b94:b0:434:a929:42bb with SMTP id
 5b1f17b1804b1-438dc3cbb71mr35886555e9.18.1738172253119; 
 Wed, 29 Jan 2025 09:37:33 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc1317fsm30718885e9.8.2025.01.29.09.37.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:37:32 -0800 (PST)
Message-ID: <a8e4295b-7f61-4949-85b0-b7c6dabe6a10@linaro.org>
Date: Wed, 29 Jan 2025 18:37:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/34] target/arm: Remove fp_status_f16_a32
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-13-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129013857.135256-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 29/1/25 02:38, Richard Henderson wrote:
> Replace with fp_status[FPST_A32_F16].
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h            |  1 -
>   target/arm/cpu.c            |  2 +-
>   target/arm/tcg/vec_helper.c |  4 ++--
>   target/arm/vfp_helper.c     | 14 +++++++-------
>   4 files changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


