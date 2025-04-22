Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BF5C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Fgn-00074z-FX; Tue, 22 Apr 2025 11:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Fgl-00074F-CE
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:37:35 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Fgj-0002Fi-IM
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:37:35 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39d83782ef6so4495986f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745336251; x=1745941051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y/ir8a0mO9VupBKppoo9HMeK2zCRJpMhWNhJitudq0c=;
 b=eSJritjmOCryn7NheRZWDOqFonDYgB9bg8ZIZIPWxPpV3vT1pHnfnLL+DHVK0adlFI
 Z3TdAYCY+m6DNUETWBitYbDIXuePitBhW4z8sCBCq3UjOgbvdkszid/my/UU0822D+rJ
 S5nF0dfcWa9wOPmojeC4z7emNSKjVPNhkHhrwfky8l9V1AWwrOWyZtVnKOa+gC7KNKPn
 uOECdOqs0Gdm51aeu/Xd9Dxvm4ZtEhvPx3tNOvPqaRdirlmZXkjiS/H0J3tAB/cGIX2y
 7mZvmg6s0GWmlSXXgoSa7UKlP2QFtH1oFQUDy9+jkkJ1rlOAl1x6HfnRsfBu5XT99vN8
 sw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745336251; x=1745941051;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y/ir8a0mO9VupBKppoo9HMeK2zCRJpMhWNhJitudq0c=;
 b=l55R1zoPP09q0wGIH1lyvGJPtTZOgQyq1OrEvgI4D6PFGd09f92+7OxM4OHt6/kWpj
 uQeEwollN6IGUCBDHTSAkosvAwomPHdZ+2JordE6MpxenbZklfIB1SsyRfij0OTgFaBh
 QJFcsLu8Wqj4Lmu4IP3Z/Gf30K1o2VnZNmXAF7gSr23ekMgqlbu0e/ClNJ81Tw6iDBcy
 OG3OSWHZqGF6xLLPWfSWehN9ERAADMbepBEKoknf73chqoCa0YMNYkKDZOvLZiy8KfMn
 Vjodxb3AY+am4HBVuBGpIm4YsdVWw3LlvNxJC7r+A/pEDx0Kpn7jyURI0PK1AE+GmGpo
 bbiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqwKAOHRF9XO1/NNB4lqAJolgS9iYlh32LoADr22FdvgNg6BTp/xL0vufz6eeMcERlsazU2VAqb02U@nongnu.org
X-Gm-Message-State: AOJu0YwILyrVk2Pnpa4ImJpouQFLU1H4JdPOFRNmpdJ/1fZcNcoBNJwg
 /3lbvYnuFWl4o0ayHHK4kiNX+rbiXQbLNKWudkRNoYUmUGeYhoW3Hwe4bWaee79ghOLJ+vgrFEb
 Z
X-Gm-Gg: ASbGncsq10c/ciEGREF11ZfFAL3cTtvKr0Wn6i7DB7zk4nlN/PnYFbGacQhNsAaCD6V
 NFoWajK1LcovCB18BIPisvGMdrZQcY4XMPtKoRx1CXZBmkkLMRrTStGhDRNF3vg0U3KP3NmMyHJ
 S8FssUxKsTtBZilg/I9VJPt74Wex54gFS0Zdf9FK4hSJiBRpiIQOGuRfahsO44FpzspuBKJiztX
 J0lBYFQOyQ2yqZo6kgOd0d4mUWwqRj+/o/qikM+KCYqOZuN0IgIRIeJBBAa4yQcDcJf9nkeAlJu
 vywFR4A8LTDB7Hxv7PhAiN8XqmKMy/d8FGlEiKF4f3t/fdo4a/sivdGr51MpGRLPNM32aR/N3DW
 LdUsO+o/K
X-Google-Smtp-Source: AGHT+IF2VuxtBpysDIUDxjJOPzXIgs4JvJyBQzuloJ1DSzELifBlGd8C1LmdnYVrqPsv4+R5FOuKYg==
X-Received: by 2002:a05:6000:4211:b0:39c:2673:4f10 with SMTP id
 ffacd0b85a97d-39ef9091616mr16060327f8f.23.1745336250685; 
 Tue, 22 Apr 2025 08:37:30 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbd12sm176126895e9.20.2025.04.22.08.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 08:37:30 -0700 (PDT)
Message-ID: <ce48f90c-862f-4887-9a03-dd08e864b9ef@linaro.org>
Date: Tue, 22 Apr 2025 17:37:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 083/163] tcg/arm: Expand arguments to tcg_out_cmp2
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-84-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-84-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 15/4/25 21:23, Richard Henderson wrote:
> Pass explicit arguments instead of arrays.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/arm/tcg-target.c.inc | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


