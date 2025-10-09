Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40608CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rjM-0006Vy-Oy; Thu, 09 Oct 2025 10:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rjC-0006Oj-Cz
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:34:47 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rj8-0003Jp-TH
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:34:46 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-421b93ee372so573676f8f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760020477; x=1760625277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kgMwGkd+Ax0NoqUH0H8flhJ/YusPGA+qr4CkKTY9Z3g=;
 b=MEJBwFYI8IjMMevarfWjV7wEPkKRRlg9dhdYX7M8RSQXIooxABDES7DQk7zRG4BdcB
 sPcxuMn1PZAo6SgpBB4nY5/rwUjzA8Go8w6hDvBFd84g0Vw0CPV9WmwXeBKk2xomlr8D
 ify01R+OWmvhI9ucUnLQyAlzr5sgGWqBIxjBLw8v1786CmcxqPyrJg8aiEX5R2OMjUY1
 eUS1pwkw/phyzlDpPqDwaCyfRCsXTyBxYtm2O0yxYwfm3i66En8vSuFpILTT/ab/4lMZ
 ATs9F8cflKbGE2EFBP1Ah9T/DwEBQ9dFmDHVlCO99bl9iduSVxWdZsKxKPwuOwAEdCJG
 it9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760020477; x=1760625277;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kgMwGkd+Ax0NoqUH0H8flhJ/YusPGA+qr4CkKTY9Z3g=;
 b=FqORT+Euv6a0ha5VfxqfnaziroinCKZRtk7tZzpJzo3TRxOC52dtx28ShybzUeMOsg
 1z2sIEZGOOkSm+jQ4y9RLtc44KMiUa66uiB2/dsuf6FbCuFYlgj6cM6kttXueKFVm+tg
 W1oyGTLQ6+vJ01IekaVlkjE/LlqNCCzZBmlJdISfw5d/l7O5/qek+4BVfXv3n4sL8UPj
 JhnaeX7viwkqvTtZTb908s25sryM93GXclhFtQVwN2WgSj8shZDrZvKiTvrrRAsZFrHY
 KdED+On2iJghWlxrQFM/lKEMS1cXL4qqXtH1OJdh47aklHDTJFcOG68J5KJcuVSnhByr
 qODA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbDP9c9dGUCXfrIY6NO2U9smTvvFM3XWthu7vSCgEWHuuZ9S7if4H6Go+TRjv1020HPKQ0I9lEfdRR@nongnu.org
X-Gm-Message-State: AOJu0YxKGtpF2yhqa7RLSYek3sumEVpRqGx1UUGbiQ3z9SzbTkjKzlZe
 Aq3VHUmwRXj3A2VdxTQ5HxMABAlqtSiHLBuYHi7kmzYoCtxI7ETgIm3x35tiEZx8SP5EFD+FeqO
 yE+DBZCEBEw==
X-Gm-Gg: ASbGncv2y/FwrUh5clwcbP3d1VijwmTAtvDmnU0sqE9Ym/SzOyhhPBJ5Q2Tnr4n8h2J
 P5iWHpNCicNO1uXayT/JAgU4KR9WIDzVWAGkJkcpGyAyCBYhNU9IZp6RVTqXT+QoGkzn0e3bONU
 njcqahd+yGJNuV17ftoa6x2JPczqIeGlLijtTjdGlIydzW0OwsM3yDwrR3OVVKTz0dCzkvSccmw
 iT8HuIX7aBlw+VeETpO3hXx9P9lhZwJlraxWRBdtY0PSdhOnwUR29HQc8IIEe2eJ5DA28uc2akI
 ATFEHeKzAMIM710WEU00v8fzEkEKORkPcCXjKlUAENon2+U5TDmzC6vuURgWPzhs3606ZtZOXJH
 9SF+nyRZkGYeLEkDT6etwZhVpHzsNzxIfmW4xbrakpKGAsf/r2dgnL7x69Cl9THlCO2XezCOgON
 +ZzUFeoLmf17cKfgewQQ==
X-Google-Smtp-Source: AGHT+IFdbQ5nDGQHn3QprqsYdtQSHh/EGeTPw0GnpFcNPnI7RUrhJBGzPjQHm8QiNFtiwOIECbFpZw==
X-Received: by 2002:a5d:5d03:0:b0:3d1:6d7a:ab24 with SMTP id
 ffacd0b85a97d-42667177c28mr5237002f8f.17.1760020476750; 
 Thu, 09 Oct 2025 07:34:36 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482b99fsm568695e9.3.2025.10.09.07.34.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 07:34:34 -0700 (PDT)
Message-ID: <3a320d0a-215a-40fb-8d8e-eca99703a264@linaro.org>
Date: Thu, 9 Oct 2025 16:34:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 38/73] target/arm: Add arm_hcr_el2_nvx_eff
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
 <20251008215613.300150-39-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251008215613.300150-39-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 8/10/25 23:55, Richard Henderson wrote:
> Implement the pseudocode function EffectiveHCR_EL2_NVx.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h    |  1 +
>   target/arm/helper.c | 10 ++++++++++
>   2 files changed, 11 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


