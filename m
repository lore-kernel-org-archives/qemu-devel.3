Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D566CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvcy-0001pL-CW; Mon, 17 Nov 2025 04:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKvco-0001m6-R3
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:34:22 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKvcl-0005d1-Gx
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:34:18 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42bb288c17bso951291f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 01:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763372054; x=1763976854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=glDp4zuei7O84V5vL+aNjOCLHI1cx437CxFfd/K92oM=;
 b=lSyWlPOSh5EiJPwNv/vusWmIzbDeQpN0P0rFqQ1hp7iQ+vy75JJ2EkHyUHGIFkbH0+
 9Wl1EIS75Mtxb+DlqPv210mX6Xm72I7+xnDqIQOHu5zjVy66SY3u15XIBOS9dSOiabJM
 sAGHTQ9KNNUwBfRaLuWe/zigUpwhvvaWxSTC+wt67XUCypljpu9pbqHEqd2i48y5r0RW
 5tXHJ/XU29gibAXJ5AuHfeE4oXiI2ZqZCbljyXusyVM/+Nu8modV0wKHVp/l/figwx9K
 anM9pvLOSwn0Z/LkXZNU2mLy36HHNSyxEwD2mDIv2eqI8k8ksxW8WL9xetjqD4XhDhVM
 71DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763372054; x=1763976854;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=glDp4zuei7O84V5vL+aNjOCLHI1cx437CxFfd/K92oM=;
 b=FQJYOJaGEL5aT39LrB4HvMIwJhfVwjNJooXBxGFWg95x9b+iqmiFj1Y1EmbZ8CdkWI
 4wyb1Kg/lRhbqngQnb1MSB3fz2uhkxpx6IMbDB1myHz2y9W9jRie6VxYDc0NTl0qYheF
 mHODVFz2S+QEjEzCAA6O55XDPZEUem6cfU7HF/EjON73kt31WXeV6sdANM7ijEjfMama
 uLer+VRbmVDBvvkWTD7hu46vmRD94EwU/F0e5EozOlLjgH+/hmrfRdXJLp+TsbOGoRWs
 6u5G6ql6gbZBzI8VCXasDPhfHw3ouW9ThbrNTpSOFNwrpTcRaYOvO1ESTJQJdmiukwdZ
 qEeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk7LnYkkG7JfRSNv8O3J1VGHtnPjhmIN8CmtJpAgVRSgaJEyuVmYw1xvnZVaZ821nrEsbnOo+SWpuK@nongnu.org
X-Gm-Message-State: AOJu0YztbSRmtULsil8o+MU9ktk0gL67dm3rELyNnJxDuNoM6Ec+RxSo
 7/qI3SVsXdoDo6Oz/FCWOQOE3CBm6rCeRWQtCienYSGgNYdNRJDcb88D0lx5fg8Ho30=
X-Gm-Gg: ASbGncsvd+crj6cVwg6qX3c2mW1en+XKbGSam1J4Xn97hxKZBLPcSdvqMaPEkY8J1hJ
 grZCQcnkCz6M0xmmPRjH/AnMwwo2XWYzQwrwsNEJZycO2txF9FahIlYysZ/7o4KjsOnwzKzzNhn
 BjIhdhgftNVWhpvKRvWJsnmdn3Fv8O0Px98JDXhdbdlgaOJjGXeeqHjd0UjB5B3bnjj5CvBRCpP
 mJmUYqsWjkyAlkxePjC/J1NpV5bH0U5IV/DMGCVQ+PiMrl/GveehpMsnCMaWXVNxK12xgTiuBDq
 vBPt0+dPq3Fx7rRLBFBNjGG7mVtnFxCg6+rROaJGhRi+9vAyU3h/fhhlTMFjKYdFLTKtbhX9zzo
 APpYIAWGH6r+4dsQ742vydAlMXX2eedlc7BxOEbGyXYr6A6uNqd5jVl1lhkiueUuoBhOW0TYB3C
 K/KpCSb8jCplHSZYpGh6zVnNRO4IZXQQvsaN6XiVFEkGgsPrsSiNmSO7PqQNq1
X-Google-Smtp-Source: AGHT+IGalx5pDr5TwAytP5acwAeaPZH+N6JcEa73Jlqe+a2/PKOvlbJIiwm7Synf42nxN4UNaZoDeA==
X-Received: by 2002:a05:6000:2509:b0:42b:4803:75e8 with SMTP id
 ffacd0b85a97d-42b5937335fmr11267875f8f.43.1763372053691; 
 Mon, 17 Nov 2025 01:34:13 -0800 (PST)
Received: from [192.168.8.105] (66.red-37-158-132.dynamicip.rima-tde.net.
 [37.158.132.66]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e846afsm25234779f8f.13.2025.11.17.01.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 01:34:13 -0800 (PST)
Message-ID: <0a071db1-8e0c-4cdf-a062-38b27c1b7097@linaro.org>
Date: Mon, 17 Nov 2025 10:34:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] cxl: Clean up includes
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
 <20251104160943.751997-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251104160943.751997-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

On 11/4/25 17:09, Peter Maydell wrote:
> This commit was created with scripts/clean-includes:
>   ./scripts/clean-includes --git cxl hw/cxl hw/mem
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/cxl/cxl-mailbox-utils.c | 2 +-
>   hw/mem/cxl_type3.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

