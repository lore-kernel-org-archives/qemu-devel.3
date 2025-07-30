Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBF8C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 05:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugzp0-00034e-Me; Wed, 30 Jul 2025 01:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugzot-00031q-92
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 01:57:43 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugzor-0006Gw-LS
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 01:57:43 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76a3818eb9bso1019647b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 22:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753855060; x=1754459860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LZeFEm0XwcwW+c9k2+IvB3dCXHECRg4yxK1ujeMJ8Qo=;
 b=g1XkowKoDIZaKVK0weditKdo6tUev395bNfLwT8klzw5LGiTYEp0a6yg2MV5vm4tRE
 fAn92mBcdm0TLXMtIIxkwNs1fU6SQYCWMdRrFG8HnnQf7NARwKgj7No7zfdywRrJM5Lf
 TvA/2Z4YamHJc5rDBbuBRuxa9N14OFDqtlyDLl5Cp7jFgZQB0t9baRiU4OgoXjTox/7K
 VHkEvnWHu3wh8qr+ckL6NzOtbo58PqbcyDOG3Ry6VB2dNEti8ekVzwG+/de0/fg5BJr+
 CPy+BVqQwBvcV1cL1X1gnKjCCHBjDKKSylmVKnlvKIDbwLjkpb+TfaBtX6Tb5i/t1Ubx
 Cegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753855060; x=1754459860;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LZeFEm0XwcwW+c9k2+IvB3dCXHECRg4yxK1ujeMJ8Qo=;
 b=bzVdkCl8uFG+4NeEFgLUav0TNDTkfssRvTAWIXo41UANjO4KOnPHX3FebzPrIt3NsU
 yHkoL/07o5UZcv+Ka7G/qtwQi8KtcdSYyDH444haTsGhavpOMyoFSNW36uNAMSGtidy7
 xyUfXQJl46jzu90jHkT3oHOWEA2Z1wfWXduDLlRqyzJ2AXLvPhFiVVuKXT/K3ZB4Kse0
 38I7P+92F1lpYDmZ1cGuyjlrrF1N4q6uRbiwwTCfoxqYgOZ2RTG6iuiYSBm4exK8s3Pm
 P7vL2Df1QmVViJJZFRtsyILhYvCu/rnd63JGk+YBw/IiY1ab0Jz0F46i/sWhlo74DBh6
 P6uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViE+s8J5/0jgWo4ghYOsu2ZRSpgH7UxoFMtw943v7ktHKPyDaeWKnVbaNL8RzNCpiz/YIuFrNzV9tt@nongnu.org
X-Gm-Message-State: AOJu0Yz8Go3GHUKka9hIJ8+0N56uZf0WdUSyxn3PSIgeRjWNvi0ohzmw
 Rpp0ResSmt05+8v9gmwPd6/SrhzMqlvjB/LhgizkpzPUEKZ2YGu4UBgh6kiIGVAhQwk=
X-Gm-Gg: ASbGncsP0EoN+gp7N5kfwZbcBWmLB9odwScwqJKC45zO8Om+OizeoxQiogmlBthMbyO
 0fQy99oP56y7YjTDpOz4CbumccEGJLxMRPKHTKTxLtSDVRoXg5RlR5RbmoQCQyJWCoprNJp94B+
 c7rEx6+lBY0ytEXRcBcK5pNMd39BmlkksUONJzNO/lR1Mn/eCgwNryjjjFD3Bi+rCuNs9KSC3N1
 et2daNhh3Y0gFEMF1jFYKhXcqnuNDXny7a14vQcyFuMhY+FsDXOJYBq2d80Jci9wTUe5O58gQFG
 FK2ni6g1kgozkMFU4/V5P1y/bstp5Z7caEsK5L17jeED96iCPTRgfhKisUhE4Ajholeojt3eee6
 PzQ7AR1WBY4AFLPvy8sW2b8tZMHE/nVo71nW7UeixwA/7c02qtglY6k5/U9g7UgSYCTIYXmyNeg
 0OVg==
X-Google-Smtp-Source: AGHT+IERasfK0WPA6PXEHbbiYexLDHzWRlSGLYg5BJGXJa6OapDSlKyiiI0fDBFFuQypznjmw2lvwA==
X-Received: by 2002:a05:6a20:7d9a:b0:23d:7c59:c7c1 with SMTP id
 adf61e73a8af0-23dc0ed7aeamr3103242637.44.1753855060172; 
 Tue, 29 Jul 2025 22:57:40 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640b8b2868sm8995135b3a.128.2025.07.29.22.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 22:57:39 -0700 (PDT)
Message-ID: <d79defa5-ca03-47f3-9402-f885ae6bc973@linaro.org>
Date: Tue, 29 Jul 2025 19:57:36 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/19] target/loongarch: Use MMUConext in
 loongarch_map_tlb_entry()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250730030202.3425934-1-maobibo@loongson.cn>
 <20250730030202.3425934-11-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730030202.3425934-11-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 7/29/25 17:01, Bibo Mao wrote:
> With function loongarch_map_tlb_entry(), parameter MMUConext is added
> and remove parameter physical, prot and address.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 33 +++++++++++++++----------------
>   1 file changed, 16 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

