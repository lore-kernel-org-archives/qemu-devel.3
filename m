Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0705AFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIOc-0006QH-EA; Mon, 27 Apr 2026 05:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHIOZ-0006Pb-UQ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:36:51 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHIOV-0001TW-Sb
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:36:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so131475405e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777282606; x=1777887406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gUtLMTp1VVoYmJCEI83vJPhbSQ/45E8v9vR8XyLJMUE=;
 b=iM4riVqdA5ZOFKnqrs6iy4rKQeI1iluBsoCj/KukQuK+yKOgWmIyleCR6a90pdS4K+
 zXL9UUa/YKLAU82APkpapixQxA4RLjAAne/fFMjF/dwfCc1pvqMya3fSGuiaNQBv6eGt
 1SBWbJlxOodCxYr/Y/xNMhWDV3JiZmkOLJANYrHW7lkUQIOr2nCL0yHFl88m1hhmVysN
 0do1sDXDMQp7yrs9rL4FAYUQl7WwY2DJEAweiXXSWJ9Si4E/7MEI7zwbWWVIjnxG86Ml
 gaT8XJmTbhIF47FVGwRDJlfmFRvZsHh4BPO31ADaLNBSylBV+1BRUTBp8DV++3v1uF81
 p7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777282606; x=1777887406;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gUtLMTp1VVoYmJCEI83vJPhbSQ/45E8v9vR8XyLJMUE=;
 b=YwYCwfGhJo9Hi7qhMM83fxceRUdvg3NPAuuyxUbZaX0bKBvLZYb5ElcWEDwjJaJX0A
 mVxGkPzNbcWcPvX7UctldK3IJzLvEbH5LfMpqQeRhNEeUGaXnHjAD5orbDNk4fxpcCH7
 GMEImf3LO6QHPeMWPXUsA+Faj+EBKCPqJUoQASGshAbg96x6sPhH8PSDRWjqyJaYEeDP
 L9ePrUYlVViyCEpxxdM4RAEpJd2mHR+EA6YllNPSktQqP1QL5ntj5/0PO+LoQHtfQxtI
 pwm6R4W15QlyXh5Q/t5C2gPcgdR+BdGgaIODTcyXmjptAv3B0l1bXeWjPAS4emmNAQe0
 nRpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/L06hr94PzPscWSaW8pl/QxylyyblPJN1iu+EST4V6VSx1YEfWllYjFN2PyNfp5NMn4D9d0POzAY+@nongnu.org
X-Gm-Message-State: AOJu0YxkBhENif3xgX/80z+r8YX/ScylY0+qv35N0nfXOwv0b+lBhTeC
 54a4bTtJTStzFevDnCe68CqrQqzZpsx+CKg6xYtvxNt52/ApFgSv5xqfXS6lzbMxT8A=
X-Gm-Gg: AeBDiesiK5EeuFh4IGvP0/Kv7FRybjGpxlxH3pOFRki11Q8yLiqfwNzQnkxy+8sWNa+
 hil9l/wKOg6UaGni3X4zd5LwS/B98z/mUdNB8O6yl6n1/DdrK+JQVo76rCBw1HuoQ0udCxQdoH+
 lVWPBFiaU9knmOLo5M2Tlk0pM9LATXl5IfU6SULMHvXb3jIiuhJPNvRLR/hpWM4MhPOe8PI9aW/
 vzPRg2BnyjA7YVJ+koTsyCX9oVFs3qnZxUV4CeHQNLlsRmlU99nHerqvxT8+TpbLgL/MaEHnCnN
 pk/C6H8TwzROt0iqaIrh9OjhWF6ePto3oa8MkX13vDPO0ZMfCXK13HDLxdezvM6pIsBB2bIjDrw
 HN0GP+HXdmhKBn+ryt4Gn2Nijo0ICheRx37uNNGjvEZ5fqAC5KhNFTvTRJxjgOsly16vVQa8tq1
 kNOU1TDgoIhkJaWpr7ZEBFXHVZ0blRa8lyNfhDPaz7mNiDBzKocRS46SU4rf6IOTEofCcu0kOuq
 cQjNekXgxApF58=
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5b with SMTP id
 5b1f17b1804b1-48a55743d05mr374823345e9.27.1777282606079; 
 Mon, 27 Apr 2026 02:36:46 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891df9e50asm475030285e9.0.2026.04.27.02.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 02:36:45 -0700 (PDT)
Message-ID: <1c0fdd4c-d2f9-4013-8411-ab73f74e815a@linaro.org>
Date: Mon, 27 Apr 2026 11:36:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/84] fpu: Drop parts_uncanon
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/4/26 15:38, Richard Henderson wrote:
> Use parts{64,128}_uncanon at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 44 ++++++++++++++++++--------------------------
>   1 file changed, 18 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

