Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1755DE7717D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 00:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLWgh-0006nt-4p; Wed, 11 Dec 2024 19:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLWge-0006mr-Hq
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 19:04:12 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLWgc-0003Zb-S3
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 19:04:12 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-29f88004a92so18556fac.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 16:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733961849; x=1734566649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3knoNcxwCUKI8eh4Orst1pBB7RV+WEfi8TnkBIo+Pss=;
 b=BVcjMEYGW6agXWjw3CAy1gUAMVinRFjK+ZFP4Ld3vNftXXBsa6dElF0EnM7pYy6RGC
 TzcnHa3SGHeVCQthLv56w3KJTaeboARUFSPGMfNuyXo2FZUmGVGwzb4rt7OEyLWemJxk
 LBZajfB6Dh9+RofrMGhMb8YMzrPBKncRIT/zEzinpAWYQwq7wCI+Z1IIND4DeUK7cPF1
 Fw1vACi1qh9GQZQJLPqQo4h/M5PwO8g90QkP88TP1QxJSws5yPRMkN5lOCu+fQg+gJgR
 KxiLcE8P1fvDcODPeANLlP1gX5tumFECn6Qx9pP7SxGnDpmHH7aYJE7FsVYYFdiqqLxC
 wRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733961849; x=1734566649;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3knoNcxwCUKI8eh4Orst1pBB7RV+WEfi8TnkBIo+Pss=;
 b=osOlNfjMgxQ68FcrttlfWYx1S4AZcLUzkulcs3h1TOocRPmQUa8eJJXA8FSJqqsnkJ
 9Mb4bEi+TwhvS7CZ9aLN93GG7JJ6VsNOnwiDqPbe8KROGp5KDP59tlmjT9jqZUrcEwAn
 psC/3vxJAWKLJPaw3MSB8sZ4uPHxZW95oFg/pAglKRNPoxoRro0bmO2mMcsjHr5eCbCk
 la7d7Rj45Om+1GihbQNiCClCdlxxMLg0a8+6ARWrIx24SZyTmph7R90W6Bn3WX9SW6be
 rpjk9H0fq1z7sFjH/XLxSPVuXMhL2AsEqbHlZviJLd+M4bW4eOXO1shdN3HfLlQg5ry/
 qiOQ==
X-Gm-Message-State: AOJu0YwF6U560LbR7LBSgNMQNr19p9wwHm8nwJOzIvyiNmsA72FT/sVe
 HuNtd7u9hiQ67fPu5JiZ1w3e+ozMtrPVhREb7uDcXVJP/Eqt9nRcIrw+R2rw434DoK6y2NPw1gv
 emtBG45nT
X-Gm-Gg: ASbGncsazY6y8la1yD3cQrMgsn9GYdOxay8WTGJdpAlf854P0EFGELX4cHj/CxQ3DaY
 8PUxQxLt0n5kn4xUr+C5lvv5iJUNfDzsz+TtAWFRJ1uZbwWMOi1GhsV1V39tBiMjqbuC34gjkSm
 lrtv0GqSNFSC1+auLsQ30qS9C/lNvlLSZmwzDy7ra1AHthww+uVd2WA/woiEbdP+iip+mAcixOT
 LJHcKs1RMISPeZl84zDtf+w13izA8bcclQEt7Udsp5eVyhJQSuVaIsKNRk6L9HOvWde8haWyQxj
 pTPMXFiL1o2P4sCSm8RIfjhrfcOlFX+T
X-Google-Smtp-Source: AGHT+IEWnIwG4dxYy5874WFv884WoBTsKtGU71MAitkfkRnpu4vkTXnCoLDbB5jc6jHFA2A8308GGQ==
X-Received: by 2002:a05:6870:658d:b0:296:df26:8a6e with SMTP id
 586e51a60fabf-2a012d85269mr2930031fac.35.1733961848866; 
 Wed, 11 Dec 2024 16:04:08 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f56666e51sm4131556fac.1.2024.12.11.16.04.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 16:04:08 -0800 (PST)
Message-ID: <a0ce2f59-3479-4a6a-af8f-3dda78fa4b03@linaro.org>
Date: Wed, 11 Dec 2024 18:04:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] qtest: Remove uses of 'first_cpu'
To: qemu-devel@nongnu.org
References: <20241211233727.98923-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241211233727.98923-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

On 12/11/24 17:37, Philippe Mathieu-Daudé wrote:
> Replace first_cpu->as by address_space_memory.
> 
> Philippe Mathieu-Daudé (2):
>    system/qtest: Remove uses of 'first_cpu'
>    qtest/fuzz: Remove uses of 'first_cpu'
> 
>   system/qtest.c                    | 53 ++++++++++++++++---------------
>   tests/qtest/fuzz/generic_fuzz.c   |  3 +-
>   tests/qtest/fuzz/qtest_wrappers.c | 53 ++++++++++++++++---------------
>   3 files changed, 56 insertions(+), 53 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

