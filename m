Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64FFCAC59B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 19:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uybG4-00077p-AW; Tue, 16 Sep 2025 15:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uybG2-000770-UF
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 15:22:30 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uybG0-0003vw-7g
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 15:22:30 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-329a41dc2ebso5012736a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 12:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758050547; x=1758655347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkJviBm1TR0HPu7HdDNcN3dOjlTQDPq0Bx01Q/yg5AI=;
 b=fu3b0e2hym4nUNqDEcp8dcUAkIZuRQmM96wS53QRfa+45s8jegADsIar0yxC4u7OHv
 d/HIboo0Bx3+zwzKvWK9Thyt+ngzl/PUqWnXUdCSqnradlVy5gRWMZEzxfNINiJS9CNd
 9PKAweYNVhPmcINgqZ1N9Mk8AN1hwnuSeXjxifvWPMnzr1AnVfc8VzSQ1mKemEr3usZD
 byAQEy3CMSilu3wVz7wbqM6Ie7IqiFVZUSus1tbSYirj0UjzQ0Ew3hznGBj3PyFqW6b/
 SyiQYn4H65iKBiA+sDkjWSoqQ6r16UhgoFbzG+xPLrXPPFHgWNsis5QiQd3oRPfb99eT
 YjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758050547; x=1758655347;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KkJviBm1TR0HPu7HdDNcN3dOjlTQDPq0Bx01Q/yg5AI=;
 b=vQpZkaQM1MqD85qkoclA6YB0EiNtrNeu4dpY3ZckR6/3xUpnX7hjWQGiOsJflV2LDf
 AKP6uXZbYUNjQR3ewaiU2GYqH/+LKVaCkoVFCxzypw2IGvIt2yEexJtcJyJOQlBHaT/S
 XgNShh0QsZRebyMFE6WAEn3V2czxjXKxwXCATeOhllJuLi3yShP1Y5P4UvDFrJn+sDaD
 XWS5+fyAc8Vg0npNV00zt2rbEtU7SOL8ECSzR5BslmHuWIBI8ql8tbi06mKjoIh1axtL
 ZB7F1cwIRhRcBvYal35VsFLNdEXIONCUMyi17W3VEowg4BXlhdEjFcFWmtJRvRr6Pzs4
 /5IA==
X-Gm-Message-State: AOJu0Yww8MHfAG8Fh/BpyYTvwysrH5DKNI44euwLB+p+XX5JQG+2sn+5
 UivYTc2c+EvzOJM1FEBuyzdiINknLv2QFUppvTsMDwXUaNWgO6lrhJ/mgQ4kgvvqAfPtXzU2CVJ
 WVd1Z
X-Gm-Gg: ASbGnctf4I2s9Cxdr9iVkKhAQwgdA07ah7rarwJQI6EeIPxp0ubbKguS9hJ8pLwbmLQ
 hj+xM/9doRm5BZ90J5kF0iykYQGXAGnvptgDAkwLExM73jzsM91E2JQ5bNLxZLlq7YD1CU8y9wI
 6s5oOT0JNI01Ik4/VDIqOGZFdFc4sTwkQNUuwppbNKf4TPbcE7wMKXSqveWIWOqll0RF121WoAQ
 A7PVxZpC8tIcX2soBDIAeJ84FxXPqp7+DWENtvfeaEB3vblP0ID4oeOvj//QXiMproHkSEsf0ZT
 V/0H9FDPBPy0mE9tdUyK9VsDMxeiTisNDPOGhPqNPZwU/IjE1j6TAToLB7QSpa4nT0AF/dv4oYE
 xNIvYLLx5mdQE2xqfcikuJNHinHsEfbmU5buO
X-Google-Smtp-Source: AGHT+IGy7qMNjkaTf49KXTbaGowdyt0wP+VHHqLEYrHJwfAXzmB86wucbMhmbctRJW+aNT4SwoSfXQ==
X-Received: by 2002:a17:90b:2243:b0:32e:1b61:309 with SMTP id
 98e67ed59e1d1-32e1b6109bcmr12748180a91.23.1758050546634; 
 Tue, 16 Sep 2025 12:22:26 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32ed268a9b6sm335248a91.8.2025.09.16.12.22.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Sep 2025 12:22:26 -0700 (PDT)
Message-ID: <d8d3b5aa-41ba-4c44-a96c-4479d34b2a6f@linaro.org>
Date: Tue, 16 Sep 2025 12:22:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] misc patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250916170912.706610-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250916170912.706610-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 9/16/25 10:09, Richard Henderson wrote:
> The following changes since commit 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d:
> 
>    Merge tag 'pull-request-2025-09-09' of https://gitlab.com/thuth/qemu into staging (2025-09-11 12:41:01 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-misc-20250916
> 
> for you to fetch changes up to a11d1847d5ef8a7db58e6d4e44f36fec708f0981:
> 
>    .gitmodules: move u-boot mirrors to qemu-project-mirrors (2025-09-16 09:58:20 -0700)
> 
> ----------------------------------------------------------------
> .gitmodules: move u-boot mirrors to qemu-project-mirrors
> tests/functional/x86_64: Accept a few locked pages in test_memlock.py
> 
> ----------------------------------------------------------------
> Alex Bennée (1):
>        .gitmodules: move u-boot mirrors to qemu-project-mirrors
> 
> Richard Henderson (1):
>        tests/functional/x86_64: Accept a few locked pages in test_memlock.py
> 
>   .gitmodules                             | 4 ++--
>   tests/functional/x86_64/test_memlock.py | 3 ++-
>   2 files changed, 4 insertions(+), 3 deletions(-)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

