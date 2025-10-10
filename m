Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF080CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7GUu-00057U-1X; Fri, 10 Oct 2025 13:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GUp-000571-GG
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:01:37 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GUg-0003Gw-3O
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:01:33 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-781206cce18so2489008b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 10:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760115681; x=1760720481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZRVRlgeyqN4QE4UycvFrwHiMl/3A5jx9xMTVxs+1USE=;
 b=eCWKYyaR5MhN1b06p0RB2RFbW8x968zSrT7CS8yT+f7d4TBozQFgt/mEF5ONTb9yXs
 3ULw6dSVb0CCd1wfewGun2kBIIrZZlUuM+V/SMtzIIYYefjIgz6wzPN+8LQJZQ2hSQx8
 zG+PZPLTm3UvItwundrSprUm+jV0xxq0MFbzpLunAQW/T2mzhg6tDuHt2TNVtbibNEfU
 lFr3JQuPUXAzkc2/LdA4krAfGWYSNBDeTwrgSLe4bH76UtxcFaR2DRNbfu7tsW2H0JX8
 QSs6gh5SkMJThq0RLVgeHvxFK8NSQQolYxHxPImwt8rN3qpG9Kjarw80T7F4lkozypA4
 QQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760115681; x=1760720481;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZRVRlgeyqN4QE4UycvFrwHiMl/3A5jx9xMTVxs+1USE=;
 b=fD6RKguIJzUEkGHfHl61qwVXcUcKK3CbydsHoCypwP9Kioq4wHPmmRMuHcB+V57EnT
 2l4Wmok+gEB2/Y621c4SPnz6RZ63cmBa2cTLCIpxwfs5qw3T01HnU5w1f93y+mZAyKir
 VrQmVVppzdF8ZLWetBrWdJcaGLwO0BpTbUVt/bIIYD7Rb46/+8nOe/QWDDjmQJfenqB8
 B2RbaE9+ryaIlyVQ7QtqQfIe+L4u79Y94pWD0D8VSi6lOSMWr6KlW/OEUyT6Flo9l5y4
 FbwVyeJ4gRFnrbnT8dO1O+Q9TZk5bYWoKY0rflxYp7f7lU6RjZ3KaRXAEXHQrXeItM+i
 /1Iw==
X-Gm-Message-State: AOJu0YzZkxvC8AD6a/eJp4v9dJJUhQLnf5tdLdBSORart4O3wkEdNoNI
 W8OeMY65deoOuCm95ZkMetvFsQo00ahAczB8+c4skQ00gCPOBVu6y92yWaYxWS4DsrlKJ3JYY+K
 4sm8fyyY=
X-Gm-Gg: ASbGncuiykIZ+JQ1DS+LC10revhEnAdgirV5PwNhCqraVifyhDQVROYtRONlUHPTT7o
 8H5D5BI7CQUMq3BD4pGpd7khbrEX/McZU9BpMh8LPhTi6HCPiHcwFRjSfW70WdgVrMVrakgmvUy
 z4HxantiLp/9y1G0UE0KB+G2bVYZ66eheAfr4PaPC0amv0wQHebKufOYUTPA7wSUU3CpRJn/SOd
 lHb+Uh75jwlLmPW/U4OZ4dG9JBhezq3cnCRu/bckvhhFK0wU+0L2hdRLBmaVgAf8n9T0yqaonAW
 /nDRqIuLG7ejV6wzdG1t0H0tZXI3WhJwDDBq/V/kyHBJakRtfE34sYWSM068oq5YdcRvENzjRPh
 WAKmjD7P50hiGOlYA5oR3MmAeqC1HgrKo8xpuHOjPrYWI1LbiDb/oVbdU3TI=
X-Google-Smtp-Source: AGHT+IEAR7ftH9zL004Flh63N1NHPOwDrgpC6J6irJYB7CUg1hV095oFX7KefWuHPg6vGSZJJo/y0w==
X-Received: by 2002:a05:6a20:2594:b0:263:4717:559 with SMTP id
 adf61e73a8af0-32da8fcce0fmr14035008637.20.1760115680479; 
 Fri, 10 Oct 2025 10:01:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b678ddc9f8esm2854188a12.10.2025.10.10.10.01.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 10:01:19 -0700 (PDT)
Message-ID: <84f69f82-ccdc-42c0-9b85-6c0d57c7d00a@linaro.org>
Date: Fri, 10 Oct 2025 10:01:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] target/tricore: Replace target_ulong -> uint32_t in
 op_helper.c
To: qemu-devel@nongnu.org
References: <20251010052141.42460-1-philmd@linaro.org>
 <20251010052141.42460-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010052141.42460-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 10/9/25 22:21, Philippe Mathieu-Daudé wrote:
> The TriCore target is only built as 32-bit:
> 
>    $ git grep TARGET_LONG_BITS configs/targets/tricore-*
>    configs/targets/tricore-softmmu.mak:2:TARGET_LONG_BITS=32
> 
> Therefore target_ulong type always expands to uint32_t.
> 
> This is a mechanical replacement.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/tricore/op_helper.c | 219 +++++++++++++++++--------------------
>   1 file changed, 103 insertions(+), 116 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

