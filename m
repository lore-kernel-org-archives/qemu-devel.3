Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D609C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbi43-0003M4-UG; Sat, 25 Jan 2025 10:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbi41-0003K8-5X
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:27:14 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbi3z-0004EX-Ko
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:27:12 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso69935615ad.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737818830; x=1738423630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zkri0av4dmFIUYziAd8LpklsSDvQNlTrsQ4T56OsuHI=;
 b=bYGlCe2j/a6aYbjhxefJMySppCcq8YIxgbGEjIhGBNkVnGfqej7OcfBWPZ5WdOhMby
 XjGKr2A8662q3vtwXnpuvnAj664EeKhET0lOTkxt28es4NBVdwyqh9N+kfyo7nI2C77k
 /6Qz3NIlroyTgWnORxSyk9+VLGye0GCbef+njro8XTq81IIc5Czx8nftLNO9irNISg9O
 daYeOmiackTsRlL+FssHbiwvkbqvafbfbHVCZ5x3LW37KVF/IpNQHCUR9AaROOKSTqnr
 ZbdLjYoziXFjZAMkyZn6iw1FTP5/mV2kSATcdTbQpdmpbwlJnGMGJI4iDDzzlTKUzf5X
 f91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737818830; x=1738423630;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zkri0av4dmFIUYziAd8LpklsSDvQNlTrsQ4T56OsuHI=;
 b=fm17MKOTeUdm+2znjk0U0LC0jJyQeGYCM/iXfXgdaGbLZaSQwJIR4S7YkUp4hzTATu
 TxE82w9+q5eQb03odsX+XkTLBSR0JLjaETMCXMLDRV6TH3LgDQCx5ADwm5pO+iq5izew
 dpxA+H3X5eA4WuKpaKPUmnVPaT1zBHuJjttmSER7CIG1F36FFdjgQ9bgUlpN5D7ntdi6
 okH5c+fNNz+qCTPBY4jSD8pMmMKDJDpxxXW2K3W0eUIydDzGdzej5Kh1oJGs+TqDbgFN
 fWJxt95Q2E0vhHUfJi0ngB2DfTBwZbkPH7YE7p3AuXfQTseVML86KvBmeEirDT2ushiw
 SKDg==
X-Gm-Message-State: AOJu0YzRzrPadbf1XqAeXqwJ8HC2Mh7qkxagJ6dnNax8SxXc/17tWrzJ
 +357gV1rly+vpUIUleh2uGJeTXMmpwWPURUDb9ZWmujkbS2P1dqlJHXXwLC1aZzMfrYEKceccuD
 z
X-Gm-Gg: ASbGncuB9StN00Bm1YguOxSt5Ehu79YHnRdJgPgnF7RebbxBwoA53RgUObYNbOB4NcS
 X1WVTlHEplhb6h+mmxeBRogpvPtSyOPVzi/pTKWTF6J+EAsZqHWPk2Z/jebgbSJVIbPTVFRrQoa
 Vw5VDjyUMU/nzETqZxnjnVoxOfiQTGDQonzxKIl9ToktlxTHsu3t1fPr455pk3m87rG0kSDqrXi
 u4zgAP74ctmKB9Lc/pzZLCvZXiRJQ1c6E1fD4RgK5EZTmgDZRYp6D0hbYNUkj2UvJ/K/SXqn3Ht
 sPbnuD18bA7lPowH/5PyWZDEfDYAsVmh
X-Google-Smtp-Source: AGHT+IGk2NvXPbnDO8DQOoYEZxHf1dU3zJ2/q40On1QpyGPEFMaYE4NkO6I+1iXJD8/NNG1lwNUHRw==
X-Received: by 2002:a17:902:db12:b0:212:4ac2:4919 with SMTP id
 d9443c01a7336-21c35501869mr513099945ad.17.1737818830175; 
 Sat, 25 Jan 2025 07:27:10 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da424eb4esm33403545ad.220.2025.01.25.07.27.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:27:09 -0800 (PST)
Message-ID: <f8ae0dfe-e409-4464-8e82-45ebe5e0b408@linaro.org>
Date: Sat, 25 Jan 2025 07:27:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/76] fpu: Fix a comment in softfloat-types.h
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-22-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-22-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:27, Peter Maydell wrote:
> In softfloat-types.h a comment documents that if the float_status
> field flush_to_zero is set then we flush denormalised results to 0
> and set the inexact flag.  This isn't correct: the status flag that
> we set when flush_to_zero causes us to flush an output to zero is
> float_flag_output_denormal_flushed.
> 
> Correct the comment.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/fpu/softfloat-types.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

