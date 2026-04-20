Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3AFF5A8B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEupB-0000Kb-Lx; Mon, 20 Apr 2026 16:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEup7-0000Jp-B0
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:02:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEup5-0001X4-JD
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:02:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso32029635e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776715342; x=1777320142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DNK/6OiYSLow+J5DqIwYDNWlozekN59wMWam0DB7108=;
 b=isoFXka3OXoPSJLiHHQWmQ816Jq4r4soAOngcBSUm0RDHB/cBPN014aPs9mO1JOl0w
 pQlj+VcX5/Tr/YZEGKpM25EFVX6oH63JvQXJxNu8OY0M9yhiz3H0+jezrgOQK3lI84MN
 yOBtwMwkU5LR+y5uWGDmedHZPcURiJJ2yfTRdYRikiRmzX5IRwBxB0gLWjz06WDzFAKK
 EMRRdfUEtIoltFT0f1Bias/DUiqhTRajg3fGqgygFdxHOzdto1+cwcAv5FU+RxTqmLmJ
 bIk6T08G3/WeVXhqYrJnaOOrkjgErXj9doDQH1M8SRXk9X69eZsKnr+dodoCFDe27Uw2
 r+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776715342; x=1777320142;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DNK/6OiYSLow+J5DqIwYDNWlozekN59wMWam0DB7108=;
 b=IsFX34XYSgYkjeNZMOsZEqRpPR+1mTG1nLCZsnCLPI8HcN4Q0wHDNGbJpTj9ogo0Us
 tEihQmPpZWecsWhs9VCq4XvhirRThkF4YTpCul0Lg3ppLnQsMxkEwDQ2DQcUJl4M8RlT
 nn+UPZ0wfhcNJpWIDClVxuzN4h8vAnGyMJVaAnz3Jw5JR8Xu1zqRy0hSdOlujqSoxygn
 86Oys6bWybiPaiT3eENi6nm11bpVyHPl5JRphHepgmjxG9vdpkQ1fHmCcXbi/hQjEpsT
 RF9DMHnuHIBfQsR0a87UxdTcD1ptqx976sFhW5HH1xeAJfEecSKOc3/TyNmFtDjlEAYZ
 ycpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Mre30LVSXFZX+XW+7AVvX3FoMy2l3ZIjxd8YfpGqdJ8U3goVOaCPsWXodkjfmBFCnunjF3bmy7adS@nongnu.org
X-Gm-Message-State: AOJu0YzRxWSzJdq23flevpUsqQIW8qwtoadsR/XPuVzulEkCLLOV8Aov
 4G0FPOzLOnAS8Rmi7hiOV78pV34r3SJo4KB85jJqqXRXXCWzT0t4CZJ15tAuWky6lOQ=
X-Gm-Gg: AeBDiesEa2wElZcZ7UK+8rECiEHyL2Aj2THSgC6giEIFi0TOOptpfOPkzPvsG3dhSgN
 ouWvmXz/xOK8A2GbY8iUZf86dEd2fKPEXePWWgiRZ6p1HM3PNjOWj7mmnLVblbZSYZII8IwbER/
 +M5l3+iBBzHKWxYShTedMAJuq1LBotgdtSIwCOiF5r+Px5kBmgJVDp9Rz2337RBao958Mjta0ao
 WnqY+1ES720rVJa0keZm7N5RGiV6wf4e5nDOdvMRNMn7WnVOcDF+1ojsJFNMz7KseIgSezEDmMj
 TWi9WzCvD1n5zDh3xvmBsxP5UNzdSgomU1Q3+o76K7QRtp7ooceb8AvhV4Vu19dcwvvyWeyV26p
 JBL63fFhSbn8JDcLqbgl0xn2ElMORp73Cb6Pz37gSGXd8RsC08z8JzRbieJBZMJC6k+eNJ8HHrw
 EsS4zuX7sasm4ynQSlK1mLCCOFIqDe9SyruFzaJ2H39hHccMb+naKzHUl5ZANXFKp/KRweNoOEs
 5wMWNR7zGsKkVU=
X-Received: by 2002:a05:600c:1f94:b0:489:1c2d:211e with SMTP id
 5b1f17b1804b1-4891c2d2213mr77675005e9.5.1776715341939; 
 Mon, 20 Apr 2026 13:02:21 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7c0eacsm98383715e9.35.2026.04.20.13.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 13:02:21 -0700 (PDT)
Message-ID: <72569ff3-528a-4bb5-a2f0-5cf6eb061f33@linaro.org>
Date: Mon, 20 Apr 2026 22:02:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc: remove duplicate include
Content-Language: en-US
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, "open list:amigaone"
 <qemu-ppc@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
References: <20260420164058.335872-1-osama.abdelkader@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260420164058.335872-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 20/4/26 18:40, Osama Abdelkader wrote:
> hw/ppc/ppc.h is included twice
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>   hw/ppc/amigaone.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

