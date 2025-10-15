Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD0CCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v96Bb-0000Zi-W0; Wed, 15 Oct 2025 14:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v96BP-0000Xa-2C
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:25:08 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v96B8-0001fm-QN
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:25:01 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-78af743c232so6283515b3a.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760552686; x=1761157486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kbmCMOXcwnMPOYFq3NXY+SpNbaeXzC7bUV2sRJWg2KA=;
 b=JVXkjLVzF96+ZpZMIvQSMqyFZHrqWQ/Et+VbfUVUEWr9aOGmyPuWt7d2wRUg30aZOn
 i1EKN4Q5GveqY5aSMuT4T2s7OD+ey8N9N34IrJ6hscIe+8xaq1WpAYg1fAh12eR/0YOE
 s88QAeAkJ/asO6qVj3U2ZpO4Kgzh4bS9OX5PzE/mxTWthS5NK4SiD3oEV0YmHddWT3JI
 7QimJ/VnIhMF1q+KjNO0fL0OODoS21hunO5Aw0LR7USUMhKMxXIc2w7RVDjxT1Rx/b1D
 54fyP0Mw6+CZz13Uh85PoX5gmc29WLupY2m/XvmPVnQFjlHEZdvFdcr43/M4WlusP8uU
 LuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760552686; x=1761157486;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kbmCMOXcwnMPOYFq3NXY+SpNbaeXzC7bUV2sRJWg2KA=;
 b=CKjXqUhfo0+mp09HjentToxkpWCTcJ3sWjmax5N3kH5E3E2stadIpazYAtqxQkcp7b
 sU6EU9SryNjQ7aUHCBH9loRWnyu71K5dh8Wty4QoHkMFKX7PLo3ORpdQQ5SIrjXq5RA2
 3vb1l/ShMyfURky77H0ufhha0DZC0011+p2IKDDbSGoM1WImFmybvsbCDvx8C9O87VyZ
 SZIZNXKuzqn2CIt5f7TJObKFvXKtx2hI+Msmx0KSEDdLhd4kkv1MRLcYXn1C12cISMi1
 7O1vVBkz6yGk2GpeFwWYGmqyGtBI9BdSqD358U6ijCHtZiuACB/ZWE1/pJPaIb+CZDGM
 SdFg==
X-Gm-Message-State: AOJu0Yyxc/wOjx6BN3QJ2rmuwX96Qyn9k7JYUcoZjGm0QVzwXph2X92z
 An+bcUlVdUsF0kVbxsdFfVZsNSa/LDH0faQBPZvcaS2JCAX0bM6nRvWlKrGTfiun8uMAkaIooAH
 wfrnKUT8=
X-Gm-Gg: ASbGncskcO1Qi748j6QvJnwys5aHt9CiD4oprTA0pmGCZrrQ2KRNUGXiCBVgYGEeflz
 Xsa26+Qc7rYHLXuOiP60R8PyBIw6PyJs92XINDv8Fo34cBLeQbQ9KwCLJpvsNcamf/T23EJ0XIH
 FdDhv/1GpBVeR1iJ+mCuw217QZh4xSq7TKurfV5cEgtKMy5rR8qqLxMy/D57sPx0xrM3zXdmtpz
 jIeHuPk334R0TkfdXAp6/rO+WySWGoJqlLap5f0qKPbPF5Yj61uYNyPLCX1Qqw4AUcgyty4TbrE
 vJF89BU229H5J2hXLOxqlfd560I+5IKxD9bRUvbgh74Rh1Vs84CU1mlHhYx7ayV+XkNnXeG4bjt
 P2E+MWQ3e7oFYxBa6BSlXUd82FNoRD1CBC8jRPOraNXaBF9T5FsXBcy8+qBwCfqDRmXsqWg==
X-Google-Smtp-Source: AGHT+IEfMGDbmjY06lHOR+Q3agLnpEk8Dnj4ZV4lfuDzZkferMS4Mg4ehTSG4fJUUY+SZ6nWkzSwUw==
X-Received: by 2002:a05:6a00:2e03:b0:781:e9c:2178 with SMTP id
 d2e1a72fcca58-79387c1ace6mr36643200b3a.31.1760552685831; 
 Wed, 15 Oct 2025 11:24:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d0e1336sm19342406b3a.59.2025.10.15.11.24.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 11:24:45 -0700 (PDT)
Message-ID: <ae76fa52-da2c-4011-ac20-bfcce7c6d9f1@linaro.org>
Date: Wed, 15 Oct 2025 11:24:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] target/microblaze: Have do_load/store() take a
 TCG_i32 address argument
To: qemu-devel@nongnu.org
References: <20251015180115.97493-1-philmd@linaro.org>
 <20251015180115.97493-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251015180115.97493-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/15/25 11:01, Philippe Mathieu-Daudé wrote:
> All callers of do_load() and do_store() pass a TCG_i32 address
> type, have both functions take a TCG_i32.
> 
> Suggested-by: Anton Johansson<anjo@rev.ng>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/microblaze/translate.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

