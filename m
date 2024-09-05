Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06F1CD5BB6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smB2d-00075v-Gu; Thu, 05 Sep 2024 07:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smB2U-0006uC-KJ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:52:43 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smB2S-000220-2q
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:52:37 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42c7bc97423so6917665e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725537153; x=1726141953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7T//60NGXw2YF4AoxiwDSZ7IGD32GmFjqE/qhKsrZB0=;
 b=u7DtZJCJcU0KgfQBsFcE/gq/6r0rw+HVK7WUY3iOgAzQF/DZQ+Cqi7CJ/1ZLlS2ekr
 4kpiC6wQCSJ5wgVkcl58QpahfYI4pWBXi4ut/o62c1+ESz56QG/JT4D4ziowVZXHWtls
 rLY/FbB8uKCfMs4acz4lbZW/zgFisz3bil78r9NpyNwEripUJaMsPlx/m3aa4ahFUR65
 sFUapOq5FlzP/2w+I4IMu+x0P7mGrTyeywz4yqu0MNFAivIWhOEWuCS2dlNh3sorsSfW
 1R2iLmEmBzArU6kgCTKb0BrjKXO5pWgI3LEf/stwsnUQkUOn69xu57tPKwkn2U7vZLIL
 sI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725537153; x=1726141953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7T//60NGXw2YF4AoxiwDSZ7IGD32GmFjqE/qhKsrZB0=;
 b=Bo0Vt0T2/IYXUqKA6SS/3WCd7FJAeNXGICjzbTVHB8JqAwQx/JukzaejNL50tBw+Sp
 hFtr2D5VIKEn58mWVab6dhOlAfMvWUPpUOFfo9nGKyKs1p+f6a/XLW3DNVOtNGH6BqJV
 C4ClaaVrMmavIcV6+v/gJk6Fj3G4+at+HtquiNZ39LYaGp0vzMg/WrLmnaz2/q/rhYUI
 VG/M/m8d+NAQH7vy8bXAGNLOL2Zcp6w/Z0lQgj5CYveYk4fBekfQkk7wM8e3XEaupsNX
 v7Hptya3aAC2aG7SDQ/8LOtAvcTn76Bm7zXEwa60LzkGRIXtdkR2jKRBbmiteYjscCg6
 1dEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4dYEUnK7zPsTcj68tZ5f/2CzKg2sOyxT1ZjLikWR/gDb1+uVlexCl+o/fZ9WMTCHW8K1hjJqmsX6i@nongnu.org
X-Gm-Message-State: AOJu0Yxs19os+QYs4wLe4y4c2Eh2LHKHq6mcKOF5AG6qcCl2kx6goFBV
 BCBAWoxR0O45a7nvxHzI+S2idBtFL9H/xTqqBDpEY939cZXgcSaCLFELPX2LoNU=
X-Google-Smtp-Source: AGHT+IEAMwzNFLlOaXDmdJVFyb+11mEDABSv2XUAOEyk12pHtonmMp7FjWZccl0kBG+tMDIRkD1ByQ==
X-Received: by 2002:a05:600c:4fc2:b0:426:545b:ec00 with SMTP id
 5b1f17b1804b1-42c9a36dad7mr18013395e9.19.1725537153399; 
 Thu, 05 Sep 2024 04:52:33 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374d1dd1e76sm8234487f8f.113.2024.09.05.04.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 04:52:32 -0700 (PDT)
Message-ID: <11fc4dfa-5f2f-4d9b-8085-9bf8129538ae@linaro.org>
Date: Thu, 5 Sep 2024 13:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 11/53] hw/misc: Remove MAINSTONE_FPGA device
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-12-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/9/24 18:07, Peter Maydell wrote:
> The MAINSTONE_FPGA device was used only by the 'mainstone' machine
> type, so we can remove it now.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS         |   1 -
>   hw/misc/mst_fpga.c  | 269 --------------------------------------------
>   hw/misc/meson.build |   1 -
>   3 files changed, 271 deletions(-)
>   delete mode 100644 hw/misc/mst_fpga.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


