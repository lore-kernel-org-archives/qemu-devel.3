Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D27DC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 23:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufRzX-000348-J8; Fri, 25 Jul 2025 19:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufRzT-00032w-Ch
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 19:38:16 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufRzQ-0006S8-D7
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 19:38:14 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-31c38e75dafso2158699a91.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 16:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753486691; x=1754091491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ha3DrFl4U6QPqwJ3Kd7efkOpaf9bsTsDGDz91R6u030=;
 b=LXbZzULixbq18OysbAWjY3nO3AcjIRcG/EPi8fMGmCU42dofEb/zmrb5EPwbrWVaX/
 1QNg/TDBskxMaoOU/ZS+clRwBGB5Z4u7w+QNIcmY9CmfENoGSL7CnMNx2UdDFAeAJL0d
 6HJz3LuJ2hhMeUCCIBnfuC75owehQx31C4DuipsKM3plNg8doPWO/YdydQwyzLudVCRZ
 pyE23y1TQGbzT8TMK7Uk8xC5KqbYnBXwF6K0nHuPpxscRw+gYAf/UBN6HedtaH6MEwH5
 hwdfSBROVw/okE+qrOPVs/0DaReT9zci8Lz6IOLk9kWbPmqQ+RWR+w2CVvW7X5kbipfG
 fiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753486691; x=1754091491;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ha3DrFl4U6QPqwJ3Kd7efkOpaf9bsTsDGDz91R6u030=;
 b=dMlVkKTl3OpG+odDeK3Y83wq+/fpJO6v2OQYITLUOipDLpblH/U69QB1Kfd1+k29U3
 8GnaRpJpRR9tLm+FV3+XJEjEsqJHhJVl/wGarvyNVfiOSFYQovNdlEL/8vR1EHK6YwJ8
 T1OPr4JjUO+i72HCQuE8bxQicPAb6m8VT7HA3ya9mbtsta1Ed6mYJKFMMzHU2EzpmTW0
 0jTqHCtC8pT4lIJE0SQ4P0nbXoSXQ4vL7DQdhVbsctfxfOjz3MUDmW3kff6SNSZAJxew
 0WHev1BGEoJCuMa/c1ntOpSH3SXIVR2Wpc3p62o5VLGTa6KzgRwT/k2khAToroPuLdZ4
 3NBA==
X-Gm-Message-State: AOJu0YyoovzSNNxa8Jj5yXm6u7MAK5uVYYn/ylXCi25ace3MMPeu+IGE
 iHySl7EkouEjcHNqWUVgLjNPpdBHF9FsOEUX+VtBjlevCedexiwUq5yltZrLVTKbXPTnTfjG7+s
 XGhah
X-Gm-Gg: ASbGncuxlMSAvZQX2UZrZJoG87D9/yW39AsUh9qMbuydQFz8M9Lhp3vWoxPaIuf2Na6
 NzB/kT2lhcYxWYX1FvvesxfE14mUW/WqV38G9RC4G+tbzGGYgrX7Vd1xgKiGKWlHK1R/VWpWOUm
 HYX1yFdeucpPDY/AVFutCQVTa0qZ56yeI3vwaEWImvk7/a8jVwm3Sqo4pkaR/amyP5SQucbMKPb
 XozjQpg+HdvhAEEs1s1wPn1uRkgJoGxnLipPcc34auFiJMBWXd8DeoAyoIXpe/gxbt61VPfxukO
 cbUHetKD1It/Wb5dzGbXWsQ6RqcAnwmiCifeRuYlK5zQvRhkkBoNmhnxWc2saL4DAp19opWzR+1
 De53j/NAVxfo4XEin65+3ZPwDyUDEjfij+R5Y1KRvxwwE4M0Mh3blARYp2XO+g2JELPGLhAvTHk
 A/bw==
X-Google-Smtp-Source: AGHT+IGwactT6WB6ojHSZ61wGje/I2rd/NEoyzn5jBNKo0VlOV1T8B8w+YiWTywRPCDNj9LNzSjSdQ==
X-Received: by 2002:a17:90b:4e87:b0:312:f2ee:a895 with SMTP id
 98e67ed59e1d1-31e77a19c6emr5252730a91.31.1753486690812; 
 Fri, 25 Jul 2025 16:38:10 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e6226adfasm3038037a91.2.2025.07.25.16.38.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 16:38:10 -0700 (PDT)
Message-ID: <ec18def4-5f3d-4bbc-aee0-19d0b8eab033@linaro.org>
Date: Fri, 25 Jul 2025 13:38:08 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/17] target/loongarch: Define function
 loongarch_cpu_post_init as static
To: qemu-devel@nongnu.org
References: <20250725013739.994437-1-maobibo@loongson.cn>
 <20250725013739.994437-3-maobibo@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725013739.994437-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 7/24/25 15:37, Bibo Mao wrote:
> Function loongarch_cpu_post_init() is implemented and used in the
> same file target/loongarch/cpu.c, it can be defined as static function.
> 
> This patch moves implementation about function loongarch_cpu_post_init()
> before it is referenced. And it is only code movement, no function
> change.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c | 180 ++++++++++++++++++++---------------------
>   target/loongarch/cpu.h |   2 -
>   2 files changed, 90 insertions(+), 92 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

