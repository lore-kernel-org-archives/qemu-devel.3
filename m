Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B323C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVVj-0007HB-JX; Thu, 01 May 2025 11:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVVZ-0007Ag-7L
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:07:30 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVVV-0000Z0-Gv
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:07:26 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so1378456b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746112044; x=1746716844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XClG0j609Ch/oadVNHfG3f0UoE0M/4F3xd1IWkCnl1s=;
 b=gmtQsKxtE0Gtso/SkfcfCs3maB/vp1hea0G3Kqc1ciN3qQPv/WAWL7j5PE01ntEtXz
 tY3/CMlAmkyTHp7kjA8zcionx90vAsyWZ4bbfR7J62dWq4dbjN1yXjPiUcKcs0fWvQJh
 NwBMc2JHYeILqVkmBta+WgLumYxuLA9ffgZd40rBiYcfyCRHEXg9AtqU2OM++1wJNY+5
 uPQp0bVpMhakzkLd6SW2oc8SWt1EntojgfhBiJXVW1aGTxfB3ZQfPMdMtyJj6VyjZlIg
 CZ+V4NEGcwSWX2icH9Jfv9BereJ/EJdV28etYUTJfxT0jMgmwYk65tF8fPEKA48TlyH1
 f2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746112044; x=1746716844;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XClG0j609Ch/oadVNHfG3f0UoE0M/4F3xd1IWkCnl1s=;
 b=eKUMAbIWddQxLLE+A0C9yn3dQ7HMJaF/2qHs1Mj0EPC+H8Q2QHF4BN6AeuUpos250n
 CI1mbQ3Mq8jQu8pJfy6FXAe30+TKWFFFlzgukGTxqSshfuxlkFG2on8MRnDXUzjQAGUr
 VOa7RprpEmetjPzbVOb8YvT8dwqvDmsmWe8wxvuxD+zzcSHdE8t66XguM9LatgieQsPq
 /7CtGnUI1hAtTU2mn6N0CygtxDxzPj3OOoclnmIDGyro6GFnEtf6/2Ln0NGcGgMIIX/l
 SbA8UHT84/DLb6rJaCj1B70IN2jhS70nnXAB/KMTHmbl2zESpdq3o3PtWRlsr/R8ZMDK
 Cs2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWktROwRv4B9mbelRCIirVhcwvdNF7K1qzu1n1JHhZeFmecDjPY/adKrgJ1P4KLCfvALDO73z3d1mFQ@nongnu.org
X-Gm-Message-State: AOJu0YwMl4pa8YzfsY5bHIUxkm/QwqZ5krHEQymvkzISr8WJOqjkuNdg
 0tOAtDShDzNPg6iobYuMHfpvCfMfXHSTePoYgPcHLe0FOli3H4KlC/r89EoCCuc=
X-Gm-Gg: ASbGncvVP/ITg2cIXRoQ3jJI8i1pGQ6zjx+ev6w4m+/GN/CuABpjD42OTC3VzweZl5S
 IhzxQlmD81YsDhRhBqIzFRnB9YjWjz4fWrqaTdnNdxH2tJbr3/QHxZDtdTacvQZv6c8VWY9/vgA
 218XFo0ml9T1j9TnMACR9Pxu1w2evDHhjc8yPDTR/OKE/q6Hw9zsG3iRGilsJRFROyd5sHARHfk
 DtgLbh4zjqAWEEpr/8yeHsNDbNH7Xs3H337EcBIcz0g5Vp+RnsvBN4NaaMYDEzGkX3zsjniwM0Z
 yjp/eWlJ+jnxZfHguX4QHhtAvcfoKJBKyR7ZBfy+P9FZ+Uu4eOUD2/LMy1oCDFscXZoIwI4RyBj
 wlOuOw24dAS2Y6vWl1g==
X-Google-Smtp-Source: AGHT+IEhCJO2/YFE9tld0EaF8WnZ+0c1QN8mVDJtPzIdzFiUIxr07ToxwDiFnRR3//WFYEWpPhHmuw==
X-Received: by 2002:a05:6a00:3a09:b0:736:3e50:bfec with SMTP id
 d2e1a72fcca58-7404777ecd5mr5240803b3a.8.1746112044099; 
 Thu, 01 May 2025 08:07:24 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404e5a6fa2sm929983b3a.0.2025.05.01.08.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:07:23 -0700 (PDT)
Message-ID: <3fd9ef2a-c6eb-4d08-93a2-4eed78cacaa4@linaro.org>
Date: Thu, 1 May 2025 08:07:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/33] target/arm/helper: extract common helpers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-16-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-16-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.h     | 1152 +-------------------------------------
>   target/arm/tcg/helper.h | 1153 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 1155 insertions(+), 1150 deletions(-)
>   create mode 100644 target/arm/tcg/helper.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

