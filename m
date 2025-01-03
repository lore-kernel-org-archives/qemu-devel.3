Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44F0E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 08:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTdRq-0006bJ-FD; Fri, 03 Jan 2025 03:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTdRn-0006b3-5J
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 03:54:23 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTdRl-0001zJ-Hj
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 03:54:22 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436202dd730so86312845e9.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 00:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735894459; x=1736499259; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M/vrVnKGguT2zwDY9nmJV61avrsULPSZMb7t0qIDlAg=;
 b=coLzCP8gnJHbqrsHHf/NsIDXwS5WqjsDEsqixRSOrFFjC9wQU8Xrx5J+Zc7o5uvxsV
 wrOJLoxwf2z6sWd621dlyAomwiatwd8snSZ+l1fqs2lji4hyoOruzIAZEGTJLEW+2s3t
 kH2qs+gWx6TxXwaYj6D23+pi6vJ6vpKe16Kk6BFQLFhz9tMLVy42coP1VRBb6lo/rZ7r
 Y5Xx7dzP+e81IPf79T5ELI6v0iUZ5buzLUHuwDQq9joX4DufUkSePOq3wvwGToeAd0vD
 eDgEUWS7n+l7l06cieyxbOEMAa9BUMBXPZqGU2Cv/ddLfBUuBcBjiIIjfUQXayYQmIrO
 xwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735894459; x=1736499259;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M/vrVnKGguT2zwDY9nmJV61avrsULPSZMb7t0qIDlAg=;
 b=TjLJYXzRUbMO+364xd1NVl5eLHTehpM1BY0/5njLB1ZO3kcLmnKoBRAizjFpVWompv
 aMaZ7E8u9sdBK9QHMZaXAU8OktZCYcL+Ld2yt4ZBBxAmdthCpUVXm15WVVGXCCTC68PM
 qhVLjdeibDk0jxSsj/a6hTIZ6XfxGRRRu7YaP06Ctjqb59iRpdeGTsVn73UD3xg4BRYc
 cCN2l6nO0NLOIrlFuEQSNMFD/YWlJGrgWu1QZJhOlQtZuPW69lU53LZbjdU1Og25sjMZ
 +KFHJ+qrGhxqshPi3aGiHlzU/htlnU0Lkcahb8tiDvnQ3gUBTuQk58Vd5p16JSqRdWfd
 Wwmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlXFpOzxoHtUirOLTSIuXk75dGp7gU6QqSv80c3Mc4lNhceRlQNT18fBRwe+z9SCTD05IrZC8kWqwN@nongnu.org
X-Gm-Message-State: AOJu0YwT5PfoxkGGO+kEXUEBUKWMPuhvvVEZo1n0d0VbbhnK/Dkjx36H
 Ushgox04FcSdGZCZFzEp5ziJ9CmS1uijA2YMb28bOfPnTsc5M4JxSmvEJezHSJlP1KiU1BBJpmP
 6UseJZg==
X-Gm-Gg: ASbGncvoMf4PrP39jYzZS4gVQhMrqRPV0AsmybEiAy+LUA+1GD8itQ0p/zkS1Oitp3X
 T6blMuRjqAX7E12Wh03dH1nQZKRYSqOjk5+4/omllyois7SWaidtsSrR7AAtHQwfuNdXx/aFC7V
 CMJVXFdnArzlqXmSmMqLoHUHNslExEykzfpW3USuL4MXXYzaHZxnw41w2USZPcPa33uNw3Zd9qF
 K3LeKOScSwXQabzaRSPrH5XYr4IR+mfCdwVc1yJRrQOEoFXAeu9L7t3s6iEzjAW7FtlqBc14eJO
 6dWMkw4BZDqoJ+9tkNoFrUk3
X-Google-Smtp-Source: AGHT+IG8sC9gfoFFkBWQE3brg6lwf+bFdm2My1oVRF4SXX+/TSbv7mlvawXSBdBqIPedHAbmS32DPQ==
X-Received: by 2002:a7b:cd98:0:b0:42c:de2f:da27 with SMTP id
 5b1f17b1804b1-4366b2f9323mr368269195e9.2.1735894459496; 
 Fri, 03 Jan 2025 00:54:19 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4364b1516bbsm374783215e9.1.2025.01.03.00.54.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 00:54:19 -0800 (PST)
Message-ID: <38dd5f72-ce63-4bca-9d90-8a481ab096b2@linaro.org>
Date: Fri, 3 Jan 2025 09:54:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/loongarch/virt: Checkpatch cleanup
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250103064514.2660438-1-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250103064514.2660438-1-maobibo@loongson.cn>
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

On 3/1/25 07:45, Bibo Mao wrote:
> Code cleanup with directory hw/loongarch/, removing errors from
> command "scripts/checkpatch.pl hw/loongarch/*"
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/acpi-build.c |  3 ++-
>   hw/loongarch/boot.c       |  4 ++--
>   hw/loongarch/virt.c       | 10 ++++++----
>   3 files changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

(and queued via hw-misc)

