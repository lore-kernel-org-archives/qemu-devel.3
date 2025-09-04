Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3398CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 04:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu1On-0007U4-Cj; Thu, 04 Sep 2025 00:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uu1Ol-0007To-MN
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 00:16:35 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uu1Oh-0004EP-Lv
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 00:16:35 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b04163fe08dso97067766b.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 21:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756959388; x=1757564188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gt9mkf1NpEjMQenTbi8kXaqUvXiyFIuizNiEJ7lRJb4=;
 b=ps5DzX/Ul3qVn0a0vu6Q58b9/bqqgia4+lqouvmrURS/+saeA8cRXq8q0e90aOSCDW
 wA+jVuWUyJoaCPe2ucBuzlJl4jezan4CJE4amCyCuviQGJJ6pTboQtIPazW0QGcuhum2
 P9U1wylVskGVvvl0O+pU4JWdblJlA40VfVaPNgx5QW3vKJ+dszXA5CWqPtD8UZOV0kZO
 8GwqBPL0bPC9ldvPlOMI/oEC2G+nzfwM8Owt7JLggSN8ck19b+aQ9WJqSPp5TmNbnp/W
 hxbHun6r62Ldqf41waFm77Ekyi4KSID7G15D20ymtQb/UvYLffOGZBxUJQuEhN2Gs8QG
 z2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756959388; x=1757564188;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gt9mkf1NpEjMQenTbi8kXaqUvXiyFIuizNiEJ7lRJb4=;
 b=Lnv1T4fK9/hw4/vUxNNw/OkHaPpmFWVCMh94znn03sEnGDz6Tu7TeMs7krKRlGttVE
 PPv2lLpvRzHOumnWT4iRmT4zgU9/wpy8l9nyiFBSb69p9YySmuzwfXNzPhRylJbkQrUN
 PgcyPydhOcWixoprkwZSyyQoCaYyhqTWmfeeFr/RZ5xDr0GtBbdn9gAKzFlfFJxntUZj
 pA37LzP/TziMv29Bz2SD1V3tg73eg++CYlYBwpuzl+8mcb22IAhifipnpX7vCYNCzJYl
 7whKU2P2VXj+jRzi+HKmiSGhNWGWVue7967GXrxMTS8UHxVLGhYGC2GZhIs6d+ZETNdY
 AJ0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzttXGgiz6/Dg6H5sMicRodpbglDUyQsxvJJsqsDyaNpWRJlDGkA5uZBhPWTRx+XH9qLfPaFHraiH4@nongnu.org
X-Gm-Message-State: AOJu0YygPC/X82uqMnghx7HVrs5oBPxTXc7v+I+GJiKHuwSpE1DcEnP3
 PwAKvKjVZj0PQtgjmAePaJerwrHZg8PE6zx5X46bw1CiSUcDgiwQ9GZxAXixGNCdScI=
X-Gm-Gg: ASbGnctCvqF1YLqZCmL9NzkyJ60G4VL2TE2IJOFX8xNLAXSWlv0ydgJbfUeypF8Km3I
 He9329UNWbnJI9WwGdLV5qPjr8Fa8xZsnfFGD2eKlFQKx17mCRmf38KvetPN7E0XkKsk1adZuWF
 HnT2lKuGCUKdaLGNwYfOzUufWNYJR2kmeHovY+z+Wz9JXE2StFvH9K2u4lOtV5XPg75Guytd6IA
 89mZfTPWlXgogXsyxy0HfcSiMhTp53F7GYZ3HP9KVqcBcz6IN/0EKpXLa/X0JRLFvs9xj3PbUYm
 ANVzjMMbK6KBPfMqO/yYumy2bdl0rdA1YMSKi80aWisGKvq40Wpy14XYuR4l+d/XDhARa4rLWS2
 h+BS1x2cLsDt019Jeb+Olmwa/OBABx6+nyqB3h70dBI1cnuMGhaIVd1Ex+Omjp3bYiASdQ7AhAp
 pplZb/Cg==
X-Google-Smtp-Source: AGHT+IEczdrf9XAgNWScyppaJFJ8OgaN9kz4GGsu6OZ3PBBPxlyVOGDBYPHv59CcpJird0YeaESj+A==
X-Received: by 2002:a17:907:94c9:b0:b04:2f81:5c35 with SMTP id
 a640c23a62f3a-b042f817f8cmr1260264566b.34.1756959388220; 
 Wed, 03 Sep 2025 21:16:28 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b046e6c630fsm259765566b.55.2025.09.03.21.16.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 21:16:27 -0700 (PDT)
Message-ID: <487e743d-9028-4909-83d3-dc30a2afa0bf@linaro.org>
Date: Thu, 4 Sep 2025 06:16:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/3] target/riscv: rvv: Add Zvqdotq support
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250903140308.1705751-1-max.chou@sifive.com>
 <20250903140308.1705751-3-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903140308.1705751-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62c.google.com
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

On 9/3/25 16:03, Max Chou wrote:
> Support instructions for vector dot-product extension (Zvqdotq)
> - vqdot.[vv,vx]
> - vqdotu.[vv,vx]
> - vqdotsu.[vv,vx]
> - vqdotus.vx
> 
> Signed-off-by: Max Chou<max.chou@sifive.com>
> ---
>   target/riscv/helper.h                         | 10 +++
>   target/riscv/insn32.decode                    |  9 +++
>   target/riscv/insn_trans/trans_rvzvqdotq.c.inc | 61 +++++++++++++++++++
>   target/riscv/translate.c                      |  1 +
>   target/riscv/vector_helper.c                  | 57 +++++++++++++++++
>   5 files changed, 138 insertions(+)
>   create mode 100644 target/riscv/insn_trans/trans_rvzvqdotq.c.inc

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

