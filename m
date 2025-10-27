Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA989CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 19:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDSk3-0004rQ-Hp; Mon, 27 Oct 2025 15:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDSju-0004qX-7n
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:18:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDSjl-0005FF-CF
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:18:44 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so38432395e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 12:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761592710; x=1762197510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9HKp2yg/DZV39UfA2Dur6nn6mJkBI4zDfwSONB9qI6c=;
 b=vfFhI0nv8nCNMkQkTihlZd2vg+rW15ZjQj3l25Jbe8r9uzXjvTfjYnKaS61kwI6o58
 ItcA2GPKRfLVZaIZm6IHN4o5n8mT8RbCuca76VjpjnT3NwpLgNI0ArkvuaQz3eDa52Rf
 lLswkRkqYgpY92f3v0tFLdG7YXYwLiPeniC5jfaReSXj70cXFDl5PNWBQJEJ/huRmgmJ
 ZeDxQNpPsu7WMTaNKKS9Pk+ShgYQmlLyd4YDN/05TU3mPUv3R9TAUbLZdgirsv/RXuXC
 e+W6w9LnasOeqfF3pdE9wufsxYoVLwg72cUw94qr0Mfl47ttJnA/LNrWL2qD4pSv5TL1
 gT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761592710; x=1762197510;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9HKp2yg/DZV39UfA2Dur6nn6mJkBI4zDfwSONB9qI6c=;
 b=IoRmRF+kBTyqqIiE+qi1o/GijhiDAnnbt6rsiDjoHJGM5OISHPoAL6CQNe0YwcqFGz
 KYLeNqJE7GLb6Xa/dOmvpfVHUbJdFL98cJEuCp0dzPg+cBhveXNqrR6/t+VTT6PodVCP
 pMYrCEtiTLzIt+k24vHrErTH5xeATI93iYRujcKT4+mAkuFR8eUMvfevh6R2HkSHnF1I
 uitVKuPBbHIfwAZkJSD5StVs2FWpEg8JLpQc1JEYJtq+xjfRNCuRk8MvUTlAHjZIz6Ik
 ySJHhGNFf4qIos8ybmZAOkkbtMHcCpOpqY5cx492JNMowWkGNpIcd3M+0KUxC5rMsNiy
 P2+Q==
X-Gm-Message-State: AOJu0Yz2fXXIBLzOrLMMJYV+UIDA9q+J4bl/QW+yKqCQZTL1qkMHM7rh
 ifgPYvLEO8gTUEe4UyKRoe9RSete/P7UMXLtKCp2LogumwGnLTHc8GRIxRBGYnpkkhbaOgCYHq8
 HrDmZfps=
X-Gm-Gg: ASbGncsoTIYN+Ln/XBbphhKk73RYkc9w8VPyDwzFG9uyV5vtEjCMa0dk/szenwpT4TF
 wWGsBP1nGaiS8SgMMMdvhb5/0qmAPaerUdTLo847UUEM5ChlD3H9YmUJG6GA+cYnsECU52DsnVJ
 cIhOZeLDPBAMEI6H9Upf/nG6CKzWW95a3k4WQ6fIHbVKRWYYBMlnlscTNJT6ldp0Qs6UbqFt4CV
 wcLpuMRrzG2hs41RrHmGEaq6IIj5960kRPRBk9Gvte4W1luwxbvQRPj7VjEMqeKtFuFfogTUB8r
 ZBIVDC2f+VHsKaO3DwPFzR2QYTnr31MswGkKR5upMzWsvMkufNXSu6+IKSU0BI+sNPHXBXKW5Pj
 NMHw/oGKJnyc8u0m3KH2J16y+L3WjaILyGjCtuGV2RFn+oxnW47+NXahIhXiWwZb+xmuCrrO7Tx
 sHaecEUOm+ZnASu+JEhAn/PNMgO0oLHE0wNFEX/pv0hHdFUKXN+gAe6g==
X-Google-Smtp-Source: AGHT+IEEoJ2H7nrcaNH4jtBvC/x4UMaDq23WYjl/UcaQZMIQltT+04vpL3rTPs5fzshCvG4gOO8bWA==
X-Received: by 2002:a05:600c:34c4:b0:46e:4246:c90d with SMTP id
 5b1f17b1804b1-47717dfa47bmr6980475e9.11.1761592710496; 
 Mon, 27 Oct 2025 12:18:30 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d9e80sm15814669f8f.28.2025.10.27.12.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 12:18:29 -0700 (PDT)
Message-ID: <89384089-94f5-4dea-8746-29e479290210@linaro.org>
Date: Mon, 27 Oct 2025 20:18:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/aspeed: Remove ast2700fc self-aliasing
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, qemu-arm@nongnu.org, Troy Lee <leetroy@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>
References: <20251021110427.93991-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251021110427.93991-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 21/10/25 13:04, Philippe Mathieu-Daudé wrote:
> Remove pointless alias to the very same machine:
> 
>    $ qemu-system-aarch64 -M help | fgrep ast2700fc
>    ast2700fc            ast2700 full core support (alias of ast2700fc)
>    ast2700fc            ast2700 full core support
> 
> Fixes: a74faf35efc ("hw/arm: Introduce ASPEED AST2700 A1 full core machine")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/aspeed_ast27x0-fc.c | 1 -
>   1 file changed, 1 deletion(-)

Merged as commit d7bd42a740d0e8887540d7b450d0bdb2d6ba31ea, thanks!

