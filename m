Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262A2C021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 17:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmG70-00027k-CW; Sun, 23 Feb 2025 12:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmG6y-00027Y-57
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 12:49:52 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmG6w-0000YH-HU
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 12:49:51 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-221057b6ac4so67428875ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 09:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740332989; x=1740937789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l/fzek51TB+hRVn7KCa5F0VmnmkwmaExBIWfaxgM2vo=;
 b=gcw2k3vRK8kR3IAO1Rc9fiVa5TPxd9kqJNmkb7oCYyXDFCt92aBy4ux20Y2enlhQww
 fjroMbpNktDNfylpd+An/HABgyq8JAeOtKKAQDgWk6gx2CZgXHmBnoUCs1VjeQwLiBYc
 KL18kJU1kqSGJc6fObF6555kjXgmvVAn3i5xA9bfbCkSR1/dSZu/pll7wKi0/BlX88ND
 TC9NwfNuaR1JBcYz8nImiRaYcbJN6fnvhAW4TYVx2c7sK/Wuz+4+erq3bHgqa5djqpz9
 iD0w1Rby7tnfQP0IepL5cBeFaQcfyyyzmXnxH2yrq2+ZKFDzlbrt7ohd0ctxHS8S2D3u
 s25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740332989; x=1740937789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l/fzek51TB+hRVn7KCa5F0VmnmkwmaExBIWfaxgM2vo=;
 b=QlxqbaVLJVd/Jv9kFM5xibQxoX/hnyqnQ6vNhy9HR8ogyFeteCf9yzZkwfNRwDzmiv
 ln/MrhlgFdWSqwY+/LrO+nLfYrgRkuMUm+y+YCZYLWuHUDvRRe4RLTIqgJmsDWZptT3K
 iW/w7TtPCfYIWy3MuQWFCfcx2Ye0V5yxspndOqd0SVRrg7XAM6+F2m2HjiHcX+jF/TXB
 llm3IVL7DcDdkClWQN/7sJfnHtHcjZNwa4fUIBzguE19EzDYkTryzwbiEOcLrpIpmgtO
 FGsaX3kN6hS91hys1WO+7HgYFXFzDcAjHTnEaXEu1bTYXXAR3N+F7u+27Zswu5SFBPCo
 27wg==
X-Gm-Message-State: AOJu0Yz57OrcaclWqPvmlQuBke8VKItmvZC8bRH3kjG3mHrl8t2If2y6
 EdTKIr8Hk8/c+0o0LTmjAzBnJvys67CnD5pqCcmS3LHVzsJXMNjB0Ix7bLcLN//AhaFsMMynGO8
 E
X-Gm-Gg: ASbGncsFaHhuaTYr3aP4KyYuIcLStrdnDgJ/2tE6CmdwGi+np/m2+tQMmPPizsop7os
 46zU3fYUceAwX+0jK4nfiOBAVc5ry5kbhOMuRaYCjTG+qW129Ah+ZEGx7h4/KBvgxMS+QBlfgTx
 8VRU77Uv6uwNoJ3TuCUTSFvOCo5Tt43OTBY/UuY5hUELb9Jjv/J77wLS6SVP1XVzndgPYtAwxLy
 KihYE2zYD3UrSNbed79Xt11ZYoKjzEByD0sraP34HtSXDS42EYG49n92lMna//pMe6nbaM+p1aN
 zP9bhYdSA15IOUhD8myG3LtpxTkZW2GjUGM0Huh0gt8oENmLi+q2iLn8lz7Q0ugWw979YblidKP
 XD281sog=
X-Google-Smtp-Source: AGHT+IG6x30kVY41BJE1A5l7vScdSWIF+N9y9UN0cv3KCObHlNBwH+IRn/+79T4l7/0BSFB0qwWL9w==
X-Received: by 2002:a17:902:f543:b0:21f:6c81:f6c with SMTP id
 d9443c01a7336-221a118da6bmr165310875ad.41.1740332988794; 
 Sun, 23 Feb 2025 09:49:48 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556dd64sm167980315ad.189.2025.02.23.09.49.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Feb 2025 09:49:48 -0800 (PST)
Message-ID: <93bdf1ea-9b41-4122-a09e-9c1d86d439ed@linaro.org>
Date: Sun, 23 Feb 2025 09:49:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] hw/char/pl011: Improve RX flow tracing events
To: qemu-devel@nongnu.org
References: <20250220092903.3726-1-philmd@linaro.org>
 <20250220092903.3726-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250220092903.3726-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 2/20/25 01:28, Philippe Mathieu-Daudé wrote:
> Log FIFO use (availability and depth).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Luc Michel <luc.michel@amd.com>
> ---
>   hw/char/pl011.c      | 10 ++++++----
>   hw/char/trace-events |  7 ++++---
>   2 files changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


