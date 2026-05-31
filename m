Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D10CD6E55
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTnac-0005CW-IL; Sun, 31 May 2026 17:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnab-0005CN-Be
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:20:57 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnaZ-00076h-3D
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:20:57 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4905e190c71so85382965e9.3
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780262453; x=1780867253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AW0e3sjMRBnQFlG1DhxuEdzH1OfQNGsJtSaHsouDHI0=;
 b=QLaEOkYh9sKepQU/wprEbkXzT0wrrC8n8R7t6l4z5YdVyUk3unM/KTE7UXdlrG2Cd4
 6cZmSCrxeB4dimL6C0rQzQyr8XlT1nx8N/hZfQ0VkfxJBuPhDgI0MOKUb+LJWJ2FlqtC
 Uxz9Scyc2VeFLSYINETo8dzneFNvKQ8TVNPakJ0j52bRjjXVXx991Q/1P0x3hYafDA+Z
 iMeYTy9NznkDX/cOZ9YLlqAHsGz4r7MgywqVqZ/3t6vqtlQp82QKhAJgI17mjJsfy+pq
 Av3eAT0bRnKFXNDov0C++AtSvblxQs97xR6YS702KyxQgsl0rvsYBFiP3WhFUptKpNyv
 W3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780262453; x=1780867253;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AW0e3sjMRBnQFlG1DhxuEdzH1OfQNGsJtSaHsouDHI0=;
 b=aTffW0aW+zdiDQgRvzgu4l6fIvuBHKYomQUxP6TWQKNby9aj8TCjytHaWLang3RCoq
 IO7G0iZNQkmP2Y1AKTm3gJNqsM4ijATIk/NEgMIG9XKjXU1+TKyEsOsVH9IcQkqvCatI
 TN5C/rSCDgArng9pvc0vZNDuG939dsd/Cc8rwe5TK7BGbwjROk9+KyxnrVoum4IrTRNK
 ZvlHF0UX1XVLomj1NcAcpHYrISPYl3dIoqnBPXaYEuorsAnfwdA8+mqU0FU3FF2UGKFa
 sxrWdM87MA2AWAfD15D6zUGpjVDbRnvY/XioSRt7D3p4DkXmzNDXyW0dWC4B4LO5SPhy
 DlGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mid30x7M+A4PDETEU+Hk7u73GIxWsbwEQ+T3bNyOgI+EJbV0F7EDj+a4eothCFMmelsIM9RUbPq2k@nongnu.org
X-Gm-Message-State: AOJu0Ywvlpl32J3/UXR1RxXhv9AujV5xhk+w8ZzLxdFEyoFmdh8GHYF0
 S69UMLnuNGmNZ5AEkaIHlj6tm+MrH3l7bZotdQNltN/sRda3MzWX6h9/WLr60uhpHkA=
X-Gm-Gg: Acq92OH/1+JK5i3ZDhnx9ewUTBQ9NjZLqFUVk1KEy/l6N0NoJQBW/l2MXt4cTLdxajX
 JIpNOBS8Kzg6w9TicQ1uK34L+QGnNQu3NbJoCSfb9hNQS58CRgCFDJmT/8AJgqct7COTb0MaulM
 Ck/pRJ8nQGodxSqbw8O5tiM5X7Pxv3Zej1SBuIRpycinEdjxgR+LwV4RG8A0uvVIeGM9/SzzDar
 2q8ip0Faoa65iNrMoDYa+qabugEUARyupTwiKDugkjosfZFVzxtrwD6u7wmWv9tYv22vGG7tPnW
 dJCCnthkJwDBtRPe6OG7QA6UxRmNArWgYmPUrX7Cq4ODrgJlMGJ1+o6+soqWPW6qACQeoK8mJdr
 cHcifGrGa7ayTtOYnX1HSspvMvCfskwGfi317Zl0V/ztva7r+HJ/QyhbTjpFVAp9r/nfeNBFRWd
 KYjxY+kjsFI7HG5HdpEKgykGzS0+u+prLaNWX/jU5plFe+Mh6AGS9BJfLvcbUjUh/qr/7F8Avof
 JVv
X-Received: by 2002:a05:600c:41d6:b0:48f:e230:72fc with SMTP id
 5b1f17b1804b1-490a294b94bmr90513885e9.33.1780262453556; 
 Sun, 31 May 2026 14:20:53 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c13d018sm80589455e9.8.2026.05.31.14.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:20:52 -0700 (PDT)
Message-ID: <4566a588-7224-4fe6-8ffc-c0b772a310d2@linaro.org>
Date: Sun, 31 May 2026 23:20:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/38] target/hexagon: Add TCG values for sreg, greg
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, Brian Cain <bcain@quicinc.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
 <20260529215554.606133-14-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260529215554.606133-14-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 29/5/26 23:55, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/translate.h |  5 +++++
>   target/hexagon/translate.c | 16 ++++++++++++++++
>   2 files changed, 21 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

