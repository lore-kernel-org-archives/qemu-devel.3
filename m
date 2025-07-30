Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A879C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 19:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhCe5-0007qu-Sw; Wed, 30 Jul 2025 15:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhApR-0005BA-0I
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:43:06 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhApP-0007hz-Em
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:43:00 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-31f1da6d294so102283a91.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753897373; x=1754502173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZDUTFPPxGD6yliM/6vrdn7s0tOtLSLHwAk45epr4Ul4=;
 b=ubDz6WiyCai7bHkFXz0fMYZKRYt1o+7hTye3UBtLCNzcne2IokoXJ11+qevMnxN1qQ
 Psc05qcO/hKGnWbwy8Kp8rV8carU7DZFfhe506xbjA9LERrPcPYjgItiG9qToRehIKji
 LvqNaoNesLQMHa1GrOoBigk78lwMnlkBgwLNo++Y0LZgneq5qINNPt3KLYyWYNMiF+BR
 zV4l63ZtmZM/YbBFdJ3zvru5U3rdcKJdWL1l+9V+fMDqXzuI/a4r3W4Ae6m/FI95UVMb
 dFTb73K/h8zdXlTEXWuLC49wyFTmDHfFH9EgJe+ow0W6U5gIyo5lmIbJxCgUXHl4n/xl
 iOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753897373; x=1754502173;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDUTFPPxGD6yliM/6vrdn7s0tOtLSLHwAk45epr4Ul4=;
 b=Fjg1l7Gham+SI4SWXFKdFoqFj/NxRgd1oH5ZJRB9yIpwKyQ1V4Fx2Tvyr2vGInHUOh
 zCwzjweylo9KEBcMQukdxYE6/5t3akbiw8gglyOLdlaKkISwevIKMXEO/JWBJ5tq0qDS
 FNk2BuzQXRZTbu6kadtOvKrMpalsqKpneOkuS+aya3wlCLpdcfkI/ZZkEIqabOxwiLzO
 g8mo3vFRSmKfXN8dWJySbx6MaSeaq9k3xQ2uD6K8JaHR/pbNCpXb8bVRlXwkvOQ1uicg
 WHlkN50XWsq99rJ14rMQgB0+W8MBxyHRwl5ETOrqx3jz6td+QKHYTvOcjpg5UyXqovJj
 3mMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvaERoUFyydn2azSMgn2oyEcv1UUNiti5HctqzoOLdS6U97EZsLW1jTmWMOlYwLgq9BvuJ/Ny1rQ/M@nongnu.org
X-Gm-Message-State: AOJu0YwlLEC2PqL9dWAuMkK08Nfu1XaPq7+vz/CeHH1vdazrITbLpbb2
 PsN22BSRsfaiAJGDH3p0k43kvKIzw4/leiZQX1CEfGK5YS4WOUUflsL+WnPoJuVcZNQ=
X-Gm-Gg: ASbGnctadw776g1SDfP2uXKhcjkyaP9LpxutIyHWzmVq5davwv0COEUajYd+61yJo5R
 zLStGOzqvzS7CF4kGfMxecwenTLHlIpsa1sz+YaWqfFaXMP1XMl5UtQ3u19ucV1aBG+PyVeEKs3
 ZEVGmAq5ZK/BU7YoeIG2Lfd6+GSkGvWN6xcxBR9O5PV9rsCNZ+y3BVysCh9dToz1nlE3Z24dyT0
 qoYYWCGHVM2vtNvyegvFa6hAAslD93eB5UyUIywmB3LgUcA7PRq3O8+EISQOMcGl+lWlcdHWeOp
 DhMxJ220cal3FIY3EM43xYv1srDkLUvTy14s+eLDc/Ak3CgrZvLchHoPy2HV+eWOEQcdma20W9G
 Ob432iv9ZzC6sEPgpC1O7TA6+dy79xxq4EDAH3iMg9IflZQ==
X-Google-Smtp-Source: AGHT+IEV4zf4IrYhjz1tWooIklmCRbNBG5QIMQC/i3/DtqKZzTtFrj570VuyujMAHayAIR1YdzbVSA==
X-Received: by 2002:a17:90b:57e6:b0:313:d346:f347 with SMTP id
 98e67ed59e1d1-31f5de58642mr6092344a91.35.1753897372812; 
 Wed, 30 Jul 2025 10:42:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63dc4ef0sm2533488a91.14.2025.07.30.10.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 10:42:52 -0700 (PDT)
Message-ID: <fabe48a3-4368-442c-8a45-9a3a5c2cbb33@linaro.org>
Date: Wed, 30 Jul 2025 10:42:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] linux-user/aarch64: Check syndrome for EXCP_UDEF
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250725230849.13026-1-richard.henderson@linaro.org>
 <20250725230849.13026-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250725230849.13026-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

On 7/25/25 4:08 PM, Richard Henderson wrote:
> Note that we have been passing the incorrect code for most
> exception codes: uncategorized (do_el0_undef),
> systemregistertrap (do_el0_sys), smetrap (do_sme_acc),
> btitrap (do_el0_bti) and illegalstate (bad_el0_sync).
> Only pacfail uses ILL_ILLOPN (do_el0_fpac).
> 
> Note that EC_MOP (do_el0_mops) ought not signal at all.
> For now, preserve existing behavior signalling ILL_ILLOPN.
> 
> List all other exception codes and document why they do
> not apply to user-only.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/aarch64/cpu_loop.c | 66 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 65 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


