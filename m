Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991CCC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU1PD-0004cC-MG; Wed, 17 Jul 2024 05:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1PB-0004TP-Hi
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:57:01 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1P5-0004oG-2K
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:56:57 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-368313809a4so234209f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 02:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721210213; x=1721815013; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DymZZfEuiqyot04rPe6TESE71wjhZ5IaIWQ6zW63uLY=;
 b=e8isf2cpkOxxmdKh8yNvMJFieof5bKm8UZE8rTTpTQ4WwAD90rBeSMih7VIwvigpR9
 uK9lWw1/lLO55cfENWdh/L6+f1lIt3BLJsCDuc+A4z9iUo6aLbNi4GjF7YmZfKfAaeYA
 nh3JtLFuqMaCEYaNucbpcsuaY5EXLPFgD6vSvdS0YMJjVY37ys5/jmhIR8eh48Fq5CE/
 3iSC6tIkPoFMvDdkbxnLl5LufuM6yqhBvo42esL+rcmIMO304o4R5UwDm/e85zMmzP/a
 ksCxkNQFH6vyS9NL6YmVcFjZw9jNNptfdPdASOW9k80/tS3WNH1MegfdLRg2MmTvAWhh
 czGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721210213; x=1721815013;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DymZZfEuiqyot04rPe6TESE71wjhZ5IaIWQ6zW63uLY=;
 b=Cwsq36C31OT+VGQt5YqHV1Z1G+s0w24eu9c+OT1GwdnZKbHmtZlL86yR7lkcKMkv6v
 UT8iGFp9lXhC2fpZ/S1AIKNGsXy3uAxSm1R/V7NmFq8aIDzHuY+vAfa2ixyyL5M2YxVk
 CeYtdG9zLBoGWz9SskTBEFcItaBpUdgLIrUElRlJtrg2YYSt6RZIwG4bi/hkiSKWDw08
 JN6gI63AyNvxlp5J1+aghXUp8KEeffNFxCFk8/BQfMB/pH5ynAVm3KcqZ7IdZ7yQ7kHT
 4I6/6+jnLyhPO5llmO7hFl4CTQp2yyVIWNSMF8Jj4IJAvENILnlS/KmJA/3IX/vbgqLJ
 n3jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvPVHnQRxKOC4ezZFtcApiYV7RzdIRtByiD8HZXdAs6u//qfr+PcN17vyydn6TinhQYs+kLS56x3OvpZjaCuskU6rffEE=
X-Gm-Message-State: AOJu0YyDdhvPb31L4M1vw/6Atcz0pVd3D0fpEhumn0Yxn16FplZK2/vg
 zTT9LBNPD5haBNs88ViSYeQMtwoszn2nyrqHcErxL4tiPQtyCyZb4szR1e4y+kg=
X-Google-Smtp-Source: AGHT+IF66WkX0vXzlcP7RLHoduRWLcoxS+qbZeQt6JwdE8N+rHN91JlIFqwMUXK3gqSY8rLwbtdXHQ==
X-Received: by 2002:a5d:4583:0:b0:368:377a:e8bb with SMTP id
 ffacd0b85a97d-368377aea6bmr686164f8f.28.1721210213178; 
 Wed, 17 Jul 2024 02:56:53 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2d7489sm198199985e9.44.2024.07.17.02.56.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 02:56:52 -0700 (PDT)
Message-ID: <37096dc8-7827-4a4c-a27b-4f8343aa9c6c@linaro.org>
Date: Wed, 17 Jul 2024 11:56:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] target/arm: Convert TBL, TBX to decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240717060903.205098-1-richard.henderson@linaro.org>
 <20240717060903.205098-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240717060903.205098-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/7/24 08:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 47 ++++++++++------------------------
>   target/arm/tcg/a64.decode      |  4 +++
>   2 files changed, 18 insertions(+), 33 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


