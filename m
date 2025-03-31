Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339B6C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 22:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzNls-00085l-3T; Mon, 31 Mar 2025 18:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzNlq-00085E-MW
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:38:18 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzNlo-0001tT-IH
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:38:18 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72c173211feso1692762a34.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 15:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743460694; x=1744065494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JFmeFNv5b+sarSdFqM1KTgUiqCF+rgnpm9YmSX1XlyA=;
 b=Y66G5axT0122mXddGeI10oLCBPckkyOed2p5go5C7jXbyRsFSj8HgEvz+B1oaMOC4s
 K3DH1CREQGGmMyS7h2xslr4BzKkDW0IkneS0tjKJ5ghcj8ZQ4XA1iJyhjWgkSu6eP4DH
 RaNKeP7ycxCwXUe/eu61G9g0GrtRsYU7etG4TeFIsQIRRJCIK7i78GKsRRjKSoD+dY6c
 wxyeHn/6BQrKoTEi7RdPrkmx2/KuLEwzT8b5ey7sXcYv0YQJ0wZJpCd61CpdV4gGHOxA
 8gCepzXjUdYNxp4PlwDIiK3DGMGr5svhQ4wGKXa7lsfbtVVEnYk+3sdYGU+dZFOeCqNg
 NXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743460694; x=1744065494;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JFmeFNv5b+sarSdFqM1KTgUiqCF+rgnpm9YmSX1XlyA=;
 b=dzwTBzVtTIjieFKq/pJkgt3zQ8ZylGFqbetg///b0y0yjsNvfKIgsZ4F6Jq6eZouF8
 38FZo3ZR498+lk8UmF+Ci1x4WOsaCvWNg4rAdQ4FPCMTNYd6SqueSZgEud4Kos71NCzZ
 unWgguWQ3TYDvKV/cRzKjL74j60ty0ds6p6PoiXEtVn8gNyfvYGP5gcgW2OtEf67QGUf
 Xk5ITjuvYPAbyVWsVDriX7aASfJQM4yYM/gixqY00HVwhJjx/Y65XOf96sWJT+LlRhTc
 3WrAi01kQEgjLaRENJsdg8FIPw7PFAqeTuEWK5P1pBk2C0n9i0u/G//sZUdEWQV0mB5z
 vtPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpaHTnMSlGbakEup5onHPw9Zm5hLHZ+OgKBf8lmNDWl5VnzKaYDjLNn1U6CZfsNHbWFiHsPq/eaz4R@nongnu.org
X-Gm-Message-State: AOJu0YwPM3oNqLV6pdFGEReYXMhWNBhDXgRUa/OuZ9Jz4RElpxZKzRGK
 yE47YdOzpOeuHYwTTkCLVBjNmPAbngLYaM9Q6fiCkUWKWwQnMarUuT+KyPkM3FE=
X-Gm-Gg: ASbGncvWsuATNuxIt9U2Jt2qjtZk2+63rReDs29/79FdjsCxT3FcEOT8t0MrZs2BXbm
 2mY9UFJRX7sl1BfLx8lk+3Yo3g6vdmq5tY/a3mKnwW68m7OrD/CRDaZcVM2nZj0iWw1c5YvM1Ba
 3sTVXlh40HX2MPor3No5q92V2L6oRRuTw+I7QhRCRBJP5b/PXo4upLy/JwDu7xG0FNDXSQffkNx
 QPAnA2wSO2pZ/DCM7tW/UmrDU4IuLY0ATs+vMNAfXxHgEVZVEN9qRXLUNriEdGgP7i+SVuycgOb
 qqynT/fj0hOd2kqrg78l9SI47mvGuczHEoKMuXY/JxJNHvAarkraHV+0GkK4VI5shXWmtfmlPgC
 PkKJCoDW6Ereduxg//KyEcg==
X-Google-Smtp-Source: AGHT+IFp4S0sxIEStKUL2jwfRULRLxxT9HOP1p+IccXKEUBs1mtFo8GXdZCPU0pP0z9l1XZXK8r0rg==
X-Received: by 2002:a05:6830:6105:b0:72b:9e3b:82bc with SMTP id
 46e09a7af769-72c637a4ccamr6064468a34.11.1743460693940; 
 Mon, 31 Mar 2025 15:38:13 -0700 (PDT)
Received: from [172.20.102.85] (syn-071-042-197-003.biz.spectrum.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5828ae93sm1634203a34.63.2025.03.31.15.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 15:38:13 -0700 (PDT)
Message-ID: <22353929-7c53-4c96-b751-90cbaff82d7c@linaro.org>
Date: Mon, 31 Mar 2025 17:38:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/29] single-binary: start make hw/arm/ common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

On 3/24/25 23:58, Pierrick Bouvier wrote:
> This series focuses on removing compilation units duplication in hw/arm. We
> start with this architecture because it should not be too hard to transform it,
> and should give us some good hints on the difficulties we'll meet later.
> 
> We first start by making changes in global headers to be able to not rely on
> specific target defines. In particular, we completely remove cpu-all.h.
> We then focus on removing those defines from target/arm/cpu.h.
> 
>  From there, we modify build system to create a new hw common library (per base
> architecture, "arm" in this case), instead of compiling the same files for every
> target.
> 
> Finally, we can declare hw/arm/boot.c, and most of the boards as common as a
> first step for this part.
> 
> - Based-on:20250317183417.285700-1-pierrick.bouvier@linaro.org
> ("[PATCH v6 00/18] make system memory API available for common code")
> https://lore.kernel.org/qemu-devel/20250317183417.285700-1-pierrick.bouvier@linaro.org/
> - Based-on:20250318213209.2579218-1-richard.henderson@linaro.org
> ("[PATCH v2 00/42] accel/tcg, codebase: Build once patches")
> https://lore.kernel.org/qemu-devel/20250318213209.2579218-1-richard.henderson@linaro.org
> 
> v2:
> - rebase on top of Richard series
> - add target include in hw_common lib
> - hw_common_lib uses -DCOMPILE_SYSTEM_VS_USER introduced by Richard series
> - remove cpu-all header
> - remove BSWAP_NEEDED define
> - new tlb-flags header
> - Cleanup i386 KVM_HAVE_MCE_INJECTION definition + move KVM_HAVE_MCE_INJECTION
> - remove comment about cs_base in target/arm/cpu.h
> - updated commit message about registers visibility between aarch32/aarch64
> - tried remove ifdefs in target/arm/helper.c but this resulted in more a ugly
>    result. So just comment calls for now, as we'll clean this file later.
> - make most of the boards in hw/arm common
> 
> v3:
> - rebase on top of Richard series and master
> - BSWAP_NEEDED commit was already merged
> - Update description for commits removing kvm related headers

Thanks.  Queued to tcg-next.

r~

