Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D62C36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtEL-0001V6-K7; Mon, 24 Mar 2025 21:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEH-0001UC-J9
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:22 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEF-0007P5-TP
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:21 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-225477548e1so93981335ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 18:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742866638; x=1743471438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m2kcMhLkXfr1+xL7Lnur2IyipeyBh+tcsM/KZq+OGss=;
 b=XiFvU7DQL79TwnaUsj244qgin6fCYO9YDRCDl17aSmsPvnoCMawXf+ANx/lz18eivS
 3cB9onZoasE/RDMnKO6eyYckRltjTlXGoYPsev64pKtzk35GwZ1suePKdGmocTchW31n
 ZycQ3MKKAx6M1x07c1hVm8nGKc4hZfybCVASBC0BGB+7FQYPCQKX9Vb+JPRtd944psCP
 Y0STejWa3qyiatneZzcIzSwHdt2rk+6qEnjmsYHrhKOtyhCXK+RCfOXtNjQkxPzyVAm6
 ub8IPMKDRC5rBm/9z0iViF/VXJlLWYoS9p1soc3t24HngGzbKn1/J/wTP9q4pG5MTxgW
 oxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742866638; x=1743471438;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m2kcMhLkXfr1+xL7Lnur2IyipeyBh+tcsM/KZq+OGss=;
 b=L45r7Va62RSKrqjjep27pILlz+DH8Ggc7y5J7t0y/tB+d2cg33VkSgfjCb/62o6MHB
 XUUUBAiLiON08rTXZ5boa2BZQ2cMeQdIjKDmcuMwD9QTtDtSPlPZZdBzHyvSQgAntLVD
 Jhl67KMYtEiP5kP9uFQ3TLhovNy4S4RpnIX/+6Em9i4C64V8cPExE8MP0SmsFFetIV8Z
 BeSBVh6AzUabOZhtuPZBzwgD+yzqQ6FDrMZrh2lp/oz408Vv5zpqEehd5PC2q36Fu+r6
 nBXxgEGoPLW7ejO6Yfv+4CCTVW1jLQFx44acyUc63684K4BsN89a/oIS6QyphGGoQDE7
 JlJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRc/E6AMfrvqEU2Yskw4zdpU604LxUsUJHk4J7cSIVulHC3jGdlZW8R99NxOaIAZTdrO5o32Iofkg6@nongnu.org
X-Gm-Message-State: AOJu0YwrnoMbyYlbmHXWjaMuthxgkpZblGwp+tKU8X9B3vdFkBdkOaL7
 oLGS5PuBFHOtqknAdj6gz+Htg4QhXcuvtrDGbo7uTZGp1egpL6+qTNVUsSQqTAM=
X-Gm-Gg: ASbGncuEY1AyeSJcF/UxzTQfFVvXv9GPjIx2UgDzvKdB4xE5SdjUFLtasUwaODb9xx+
 IQUDpTiYxw9mqdjao+vJjxd2qGXVzlPnt6dwUIb6X/bzpSlMnpMaKAHKcABe+IPAgv3o0j0YHu6
 aW1gWnY4uUHQPGOlgLixId3KeKapgtRp1Cr+6fYztLQzu914R8L1tp0E/nspVnv6RucUD54XQeE
 BGnxC6amtirs1fF2LOhha6Ace0ilIb1D38gaGyDVo6l4+yxOpjAWaFsALzL81Ezd1bCJNyLNbVZ
 NXehpnXqw5cXqALscXQmA5ee5+hNeRtfT0XNpAssx0dSS2/ByLgm4k15JQ==
X-Google-Smtp-Source: AGHT+IGNRhoQBuWycnH9ZlJu6zMFYOB1Uba/r+NK6/6Ee8w+Z7ZBDCQmBcAaNoSLQHmX+yW2wgpffg==
X-Received: by 2002:a05:6a00:2c98:b0:739:3f55:b23f with SMTP id
 d2e1a72fcca58-7393f55b36amr3591241b3a.14.1742866638435; 
 Mon, 24 Mar 2025 18:37:18 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73906158ef2sm9090422b3a.141.2025.03.24.18.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 18:37:17 -0700 (PDT)
Message-ID: <7180ef28-7a5a-4225-b854-11bde419915e@linaro.org>
Date: Mon, 24 Mar 2025 18:08:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] target/avr: Use cpu_stb_mmuidx_ra in helper_fullwr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323173730.3213964-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
> Avoid direct use of address_space_memory.
> Make use of the softmmu cache of the i/o page.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/helper.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


