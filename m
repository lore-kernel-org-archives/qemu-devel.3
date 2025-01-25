Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69D4C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjXl-00070i-L8; Sat, 25 Jan 2025 12:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbjX4-0006L2-3P
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:01:24 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbjX2-0000MN-CQ
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:01:17 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso54706935ad.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824475; x=1738429275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kcOPA6Q2QvRKaH5kJijY1WM9qcLftyp6JJQkKS9scFo=;
 b=wK29Tf/AAAmUkuO1GXlb3apwVUDmN6CPBxFCOmSUPMUBARbqW4mIjVMitk4wR3MjV2
 HQlJXDJaBcfUMQ2Jx2mE9DK8n6ZSIwRO/uSV8uKpoy79bq+Gy4NDLDT/hd3s3lWX5eQ8
 xIJ1ci1SWPxAygTBXg5hOQigOHCKqIbvPQcGg8JBuQ9/WFVYBBsaCQmSZz98QvxirPdV
 bSvIje1bKz9zt9PMvvyxGTzzL4sneKQsTfR/Ys/hgTTeiXdiIx1DzjFrVsDr55dpJUT5
 eq5kvthcAeggLV2MCCl13gIxyyI+sqvLhGlzLk41uHVQV2074RMONcA/G9dveXxpKQqY
 HW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824475; x=1738429275;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kcOPA6Q2QvRKaH5kJijY1WM9qcLftyp6JJQkKS9scFo=;
 b=GSLAO0fzAdLczKNixRtnkmiOGDqqoKxV25S+zSWMioyP+cvqn0vbvrtN8DrMo82AXp
 RVw6QPgtmDpl8n+cOzEPr2hOwywu5Z77YN6d0rHhQF+7ocYDprN6EvJP8WSh5H6H3Bvz
 /LRW69fLFppz816RSNp2vcUUS5fOyvHI6txgBVsfBjmMvnfRM98ThixH0Car36+O9nPY
 fVgdxVmEWbC/igL683uR4iZ0XpVNuCeoHubgd0gp3fhwFi4xJz5Rs+t/Euj3UN1AC/ur
 WHQmZODcWuJ+gSB0+flmLW0yVprGLay7QmCOp1cUd1FtUBihDifByH+bPkpV1h3Ntisf
 xxsQ==
X-Gm-Message-State: AOJu0YwCDCFo/YUtN/fvWv3xWkNo4XR96ApYOH6i7JO97B5eUm1ITRPR
 LfOGM/ZrEfs+uERG5OqAPdipzRqS4UwDs7MTnKcc66IoAp6vc7lUqcC3Jx4EdBjBFomIYBGE3Zg
 /
X-Gm-Gg: ASbGnctp1ABa8W+7PLj8tcwIxxK/PYk7mRnY/I8Ii5dhyOkt8zs8acGvMacZonseaN6
 h42YTgFUyjEOkoJCuLZ8AmMPPKKi4Zqfykip9rN6r519Xu6TTLN547f/Dpj2d6WzsbhfuJ4z6n3
 9KEuTLc7k8oVKDGvWUK3/Vthibi9bjhxCnyL7hEsqEbZFQojAtoGoynDNr9Q4LZyJ1zQ22rQHQd
 PqySw7UtrrvwrHgw+yXAoX/E6dlv5prRyNrlIuHUT6z0klgkrWXsaNQ//DYdqiD6ml4mlBMQ4Pj
 VS9GEEpf3StTXHDif0EUhQ==
X-Google-Smtp-Source: AGHT+IHpCcK7HXz0egktvN57ZevMY0z1wAUomrj+/H5MtjwYUKLV41T3kx+a/Dywo8vO6WiPqPHp2A==
X-Received: by 2002:a05:6a00:8e09:b0:725:ef4b:de30 with SMTP id
 d2e1a72fcca58-72dafa6b436mr55028584b3a.14.1737824474495; 
 Sat, 25 Jan 2025 09:01:14 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a77c560sm4033651b3a.142.2025.01.25.09.01.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 09:01:14 -0800 (PST)
Message-ID: <cf98fa32-9507-414a-95e2-83e682db349a@linaro.org>
Date: Sat, 25 Jan 2025 09:01:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/76] target/arm: Use FPST_FPCR_F16_A64 for
 halfprec-to-other conversions
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-27-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-27-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
> We should be using the F16-specific float_status for conversions from
> half-precision, because halfprec inputs never set Input Denormal.
> 
> Without FEAT_AHP, using the wrong fpst here had no effect, because
> the only difference between the F16_A64 and A64 fpst is its handling
> of flush-to-zero on input and output, and the helper functions
> vfp_fcvt_f16_to_* and vfp_fcvt_*_to_f16 all explicitly squash the
> relevant flushing flags, and flush_inputs_to_zero was the only way
> that IDC could be set.
> 
> With FEAT_AHP, the FPCR.AH=1 behaviour sets IDC for
> input_denormal_used, which we will only ignore in
> vfp_get_fpsr_from_host() for the F16_A64 fpst; so it matters that we
> use that one for f16 inputs (and the normal one for single/double to
> f16 conversions).
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 9 ++++++---
>   target/arm/tcg/translate-sve.c | 4 ++--
>   2 files changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

