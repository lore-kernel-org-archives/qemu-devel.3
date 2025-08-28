Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82D3CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOh5-0005Z2-Ul; Sat, 30 Aug 2025 12:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urkng-0006Px-Or
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:08:56 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urknd-0004jN-W6
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:08:56 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-248a61a27acso11555425ad.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 15:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756418929; x=1757023729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yTeUFN5//J9p2+jkIE73D0Qq2fiCq5Y0YOl43PavdRQ=;
 b=zG4zLiLox1cgemMNjDKkaAIkdC0pZcQyy8DSCTw87+0X5EnJx/9BhzEU9kVIfN6yaD
 UDs5iZwjdfUNY+A6RKNprwByKLJC1AGJOd+j0W8NG5Gyayuhpxm4UunBHUZ7Kkjc0tGw
 e6wzMBSKVBh5B2flrvl3jPf2OlSWGdP9P9bQ9DRrsqfoC8EUlBeB7745qnBtltXOjxSm
 2eK+hOzExM9mTa01KfRsN0Ihr7GtinR3Ly+WVUHlCivYKVxTYdI6vqIvOJ1GvZZ7kq+n
 pVAlf6l8sM4Xe37UQ0RrN0BMKBpqG/4Xvj59p8oyV5bfwHWRtT95gEi+885s1N5S/0/1
 OYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756418929; x=1757023729;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yTeUFN5//J9p2+jkIE73D0Qq2fiCq5Y0YOl43PavdRQ=;
 b=DfoZzqmMlJr0Nt7FTqYhiKXXjWzOu/E513XvuYKJbvoJceuNCYutF13DTCde1UmBg/
 APhmZ/hABuymFjlOjt8MUwrw1c3Q0WDlB1VKJDZkvkCZbT+gF0T8NqgUhwdmzHgY/WYH
 ZeUtTeYMEovdR5XqSS3Hs/1WRDVDZpHyVAUQf6x28ksXWWW5vAn67qnNX8Po9BiEQo1V
 XRsw+OuQ0FsaQZnU21bzMrxEvOvHdBSJ/tUfZDyh8D/LYV1WCKKBQ+X/TgPntgRnJEpx
 JY0bG1vimR6HQTJI4l+7g6CertVOcuOOjJBWnWjY4T55HqdP8UF8kC69Fb1NMi+Nk/jj
 gvrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg3Ncg7afRwZtb6RywZ7m+2AUlS0ebZRbwGl9QwSdBgq+g/rU5hyakwJE/H3eHyM4KZDQZT6bY2TxL@nongnu.org
X-Gm-Message-State: AOJu0YxKWAduFPfpiMY5T2u3DRWXJ19SAOnWy5o0YR8S9XAp4STJqMky
 DAp1wa56wDdGQtMWgBG0wpekJaXvKYz1WtVtRzwPH0HGGKzJvGJCkL0uy/oICVZzoac=
X-Gm-Gg: ASbGncudYpSmEdwGoLOTtrp4GB9NdWX9KtFFfKnKIp8vLf6de08PLrKN/0j8oxYHWEe
 3ShehbxXEARMepqbbSsiwLgRnGNaFAKfvVoRTgr8dsNjlACV7BSZg/kvlS9sUeWkfnw5E0MZIpX
 buYTbEZlAGYgt/VVSLfrMCZDCThjlay5IUeBRoXYROZzcdrzO4R1PmB+SsyIm8eFYn6/cYo9J5D
 Z9bAuDCSfHeYmXSwjY7WUlmRtJuv2cWgjPStw+b8YMuzQ4ssuRjuXEDtcbUOykKdgfwMYQ/yvmL
 4jT+ivhm4NkcZSIzzvNYsjKp0tOaBJPx/tmCAfUTatVm4/hs2iAXlFo/ksZrRB0aSHdg1/HIUNN
 6wKARph/qzBZG6TzqZFOVPR3vEXUbsurrRzaL
X-Google-Smtp-Source: AGHT+IG503sJOwEaOHopVj2DXiwKLBBkvWpTbVRcS6Bl4sWpWVTzV7/BfTo3luOtaWlsdIvyXYzG1A==
X-Received: by 2002:a17:903:238a:b0:245:f860:80b1 with SMTP id
 d9443c01a7336-248753a264dmr141217015ad.11.1756418929437; 
 Thu, 28 Aug 2025 15:08:49 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249066dcb44sm5087145ad.138.2025.08.28.15.08.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 15:08:48 -0700 (PDT)
Message-ID: <889ec17c-2f3b-4ca0-ae45-dbb16df1c468@linaro.org>
Date: Fri, 29 Aug 2025 08:08:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/mips: Remove mipssim machine and mipsnet device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250828143800.49842-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250828143800.49842-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 8/29/25 00:37, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (2):
>    hw/mips: Remove mipssim machine
>    hw/net: Remove mipsnet device model

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

