Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C38C3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANSM-0005e9-8f; Thu, 01 May 2025 02:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANRy-0005QZ-Lg
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:31:20 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANRw-0000Io-Tv
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:31:14 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so710833b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746081071; x=1746685871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FMf+w7lACJBDSar8wvYivI4Byy04n5QoYQXG7ytixQw=;
 b=l0df9QqjbXOun1s94xExx5nt9zZ3XiTHW+Y/5u9EBavj8ewwdLwBCBxZUiFcLn0saz
 PBf7J76/ucoFtZMS2wlCiBq3LNpEM2y1t5+P2s3gES0/Fn13o0d79WAORN6SewGzJL/V
 8JFyG8fRYOrgJHGP66VyBHtspHNzfDxs0VRo282ptkzNSSKXesAR7as2h4E/ZyDjVOdZ
 g0OTqXAafQBslvDCKdnRAKPHkI4PCQ/M4wHwyGcmoHdwPwEELuxnWa5zsrxAFcYzCF9b
 OtdnvOEeUVKNuxYOVeWq+/frSCrJdFT/9LhpLBoF67zqt+o+MJl7mh421jPFfW7V4dtH
 WMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746081071; x=1746685871;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FMf+w7lACJBDSar8wvYivI4Byy04n5QoYQXG7ytixQw=;
 b=HG4fV1qmeWpvHQV144/f2W50cp5Rdq/IG3l707WZVc4FRyYzUTtTaCaEjBIFDGL5Vx
 IhNfm/XPU2ytqF75E2n6b3g6JVdoeUB/9ihhsgCVW7F7SIMmSpqJdvzA/KvXEAcz4vTZ
 XMIi8VgyU8fuoVvciGkVjLRrYIFR+9pJOSxaAx6Mk+HSDqsqaesfdvB6Oq3URhIx8Oj4
 aBkZ14NOdv9yyekzBTs98o6A4ekrpow5HEoAv/YEGCmzDCZ2R4Zwb3IZNeFq5FCrOvZX
 MEUOK4+h06W5oTc6Luahj3jv53tojsycDcYZk/TG9PUmPGTwGVtjaxDjSd+69Md35bAP
 wdyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSXKAhHmkH5ldvPaVoSHgEZ095WIt8Y7s0m/EYTpmXL1TPvT5LgCBfJQbYViwu7gj2PSWKrNKca4hz@nongnu.org
X-Gm-Message-State: AOJu0YxnJgQB+6es2BkF+auIF1e5zU+BzhdE3cigKwVasc2w6fFwhBpe
 nSAAclwZMkPCMEl30HAgtU1G6MxOZAGxRzpqpwNqgWyD611jEEuDd53BvP85gTg=
X-Gm-Gg: ASbGncuzTNvFxOxAPZDKPERJaSJqKwIYxwtyCuTTUpXTtv5I2Qz/XAzJhGmJ1RAzL24
 ijN7G/RfbMr3J1Rc0KHktlXNxPCaz6nY/XrR8zTz7mCaWejvS+cOlNIPHdnG4mrEt1GbFcA7eYH
 KgNRh1NMlqrVC7h5UmVfu93H7j4WIk/zUd+8edqUnpgowjbeQxPk3loVKRWoJn9X/qsJJqZjFCn
 9NzKXvcxeCf0gtY8nmzxms6AMhhMOmwJgeYKZwae/UtTZ/T3lq4DOWqs6HboRfdBCeI+9okDeLD
 7xm+qmzckerN/McBkVghFrH08rxVCn6Jw47S9GaDpVHFraXFhbWotA==
X-Google-Smtp-Source: AGHT+IE+sDulaWbqphU5azlmg0+ta3qPhTwGMiEjAC9L+EhJpt2CHN1MOhCd1lU75IoVWBk0kcDj+w==
X-Received: by 2002:a05:6a00:234b:b0:736:34a2:8a23 with SMTP id
 d2e1a72fcca58-7404925ad93mr1788796b3a.15.1746081071541; 
 Wed, 30 Apr 2025 23:31:11 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fe96csm120281b3a.103.2025.04.30.23.31.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 23:31:11 -0700 (PDT)
Message-ID: <e70be9b0-d469-449b-907a-1ac0d00eca7b@linaro.org>
Date: Wed, 30 Apr 2025 23:31:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] tcg: Define INSN_START_WORDS as constant 3
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250430230631.2571291-1-richard.henderson@linaro.org>
 <20250430230631.2571291-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20250430230631.2571291-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/30/25 4:06 PM, Richard Henderson wrote:
> Use the same value for all targets.
> 
> Rename TARGET_INSN_START_WORDS and do not depend on
> TARGET_INSN_START_EXTRA_WORDS.
> Remove TCGContext.insn_start_words.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/insn-start-words.h | 11 +++++------
>   include/tcg/tcg-op.h           | 17 ++++++++++++++---
>   include/tcg/tcg-opc.h          |  3 +--
>   include/tcg/tcg.h              | 12 +++++++-----
>   accel/tcg/translate-all.c      | 19 +++++++++----------
>   target/i386/helper.c           |  2 +-
>   target/openrisc/sys_helper.c   |  2 +-
>   tcg/perf.c                     |  5 ++---
>   tcg/tcg.c                      | 12 +++++-------
>   9 files changed, 45 insertions(+), 38 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


