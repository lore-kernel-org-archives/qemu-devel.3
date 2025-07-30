Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53026C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDrR-0002C1-4c; Wed, 30 Jul 2025 16:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDQt-0002U5-OO
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:29:51 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDQr-0004eS-P6
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:29:51 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-76a3374b143so310170b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753907388; x=1754512188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eGHDQF25joYQG8LGG7iGSytW5LjvWIxXMVxdggBFcI8=;
 b=BOHwymgt57Pidcr4oyVq+KdKxVND73UiD+thy1THQuCaq4DD1Dw1P45DQZS38Ani1l
 yHFMEZCNgML9uMTWTLDi+i87IBEpjps2YyEvtWvO1XFxcsn2QEiKUNCKiE/WDViJ27m1
 GCsbaWUz85mHlGYLCcccpr3wx2yuq2CmoY72ivtgM+kXG93zRSd65sUbwdbJFfIjGW0F
 n+BaJaXuXM8Qu4tl8eDTRLbw31QTJ6wI+j6h5+IqXoilKnq/2zKFAM1/AyocZUI8W3ma
 v4Xp43jriLx9fsmgIbAilNYY8Njv76QxJ+FH35Eb2tlp+KTAckMKtM2C2XLA3PZ1Ag7G
 F6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753907388; x=1754512188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eGHDQF25joYQG8LGG7iGSytW5LjvWIxXMVxdggBFcI8=;
 b=p82t3vM80XPqor528M2tlDG8grhQUoY+WkZTTroJHO188zCZrsOA5UXsNw3gQNOq0A
 Xrwu6jnkJBByaBuEEOgg1ArfV1jxRX3w6jCaigVLHr/hlyvWGnE2vxvq/1ZzlgLpv2Au
 hF9+PgBOJxo/juve3aEsksgkUQZagXEwwHhfM/SOyQ09UvGqaF8j+MTsDyhmFzfxXunQ
 gtDHsp7NoAaB5Sr+2g5P2ywmqA1tDhNOqE+nQcvvimJE4XdYA5wdR7mEtQZ31nLUO5Zd
 HinUH8qzkERuz3+JYIMCN6pl874mfjlSMEIAIRFOAAG71/ckt5LSeflpgBS1T2hXQc50
 4tiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHGBNKv+aoKMeIQRQwcoY3CgD8iQH+4Lhvk4LyEEIy3X4u888ccRwSJLSzHsEPzEkE4BJaaSD9693g@nongnu.org
X-Gm-Message-State: AOJu0Yw7j89EkifKj8xqFcHlQ4QpVPn3OlDIDX1h+jYOS1/6xFeacEQK
 0PH1+Gt3K9aCMUuRu6hllo5KHh5DIxPPZdlZzzwRoKCEwO2yCXnNVdOYQzhxP6pCDvM=
X-Gm-Gg: ASbGncuXSrpJZaVCKp7Otoqd7QnCFTILMzihELd2FQfAJhcX0heCDIVQh9HUHemkeq/
 borsNa2BZTluHUGS4kBMqKJSgqXhXMCv1jWvVKvmP2eRZm9LIq6Jj1QKZAvrKdLYpxhSxIhEIuP
 JPc0eyiEEmfj4Cb5QObCyEr6WCa2xdhnQFURAsBSQeCL61c758Gg7Sr08TbriWFEe9scj5ETy7X
 LeeGPY8Ach23PnbfAd+vYldTuVZDrDo3kxMLr/+EtVUSyvlYR1iagNLi1eLZpdBb9ok2sJqwtXg
 Fq8GlE/OPgewYrc4gh00mRE8ReS5gKsj7TTZVjblfUJV5P7wIStCnIENuNW1LaWRezQUtQWXxdK
 SoXt4T5SszO0CJIH1dxR8fk3hxmEdYN97Lto=
X-Google-Smtp-Source: AGHT+IFECb6SqwznjplMi3I4Y/JdJx75oaIx/kNehFBisdyeY/kXIk4zeBvR9TlHr01QSVt82o6Vrg==
X-Received: by 2002:a05:6a20:a109:b0:224:c067:66f8 with SMTP id
 adf61e73a8af0-23dc0ec1f9emr7996516637.37.1753907388155; 
 Wed, 30 Jul 2025 13:29:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76ba34f5078sm1440655b3a.53.2025.07.30.13.29.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:29:47 -0700 (PDT)
Message-ID: <87c3ed32-21d1-41e4-b35d-038916d3b900@linaro.org>
Date: Wed, 30 Jul 2025 13:29:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/82] target/arm: Introduce get_phys_addr_for_at
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> Rename get_phys_addr_with_space_nogpc for its only
> caller, do_ats_write.  Drop the MemOp memop argument
> as it doesn't make sense in the new context.  Replace
> the access_type parameter with prot_check.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h     | 18 +++++++-----------
>   target/arm/ptw.c           | 21 ++++++++++++++-------
>   target/arm/tcg/cpregs-at.c | 11 ++---------
>   3 files changed, 23 insertions(+), 27 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


