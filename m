Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85C7D6910A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 13:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGeXt-0007xi-Ti; Thu, 28 Nov 2024 08:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeXi-0007uH-Ni
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:26:51 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeXh-0002eq-9O
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:26:50 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-29afb4ab611so408209fac.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 05:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732800408; x=1733405208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tq0MXRtExZOr+Ret9bpxEjXx/ga6SNtoZEJTk6h68Gw=;
 b=C1Vnif2Mx6hZHNsmTwJvb36AE/FoIS2wArDwEx7MRem+TSgC1N4MT5gJKvBm8gxSgf
 CTaPasIm2a6fUi+fd0TlBPIhcaX2b3hEyvy+Rlv+6Wauw9NqQDbpZ3OAtqtLi0YhHHcO
 3YmLPGULm91Q+3PjQuPW+3t2hriNzkvZ9THkREaLKyyOpqM1ox2MmqMMNGXM78Hn1xZh
 OdNkGOAIN7BVUqmaV0UNSoU+wExk/PLDbGVNaVr+fNkRlLuMn3bUNM94ylR66F4J2KDf
 IT547f23NbA2+jVkzfcDtgsIUUjYOsx5L4szeg+0fXiAC+4rttCJzWjlI8W8FnAs0Q0G
 N2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732800408; x=1733405208;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tq0MXRtExZOr+Ret9bpxEjXx/ga6SNtoZEJTk6h68Gw=;
 b=DTQj/eKcDHLaCwMGFUk99jFue256hRPTdFGCfqlXrckrhadzxMbKgFaL3ck+HnOgNs
 1vSbccL6VbxeHHjp+A51NPebIDl/9hZ3v8veZtmlAfgVuYk94nnc36dbLH08zdLNxN8e
 Fp2CYnFnGfp7FoK4B0SRfRASu+8UwZ9IK3JSYvoQzgQ9kTcrHAiN8fODX2e78aPJnlQw
 pimW8Gk8qWOF9c4pYb6C4IkTlS310/e7NuwIwyt1MbKhMEtJ+Kyy71J8Zsuw6VWrt28Y
 raVeCecDBIo9cE2XQMt9WajZQ7mTKg886o8IZ1ONvQc06J7I31pGbix4PGW0XCFBnJH7
 1kbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVKYfmi8M5AaY+g/XjhQaHDWU/nSB5o14KOnCKtUyLjW9A7J+9pO0E3QIT8iTk+F2Luf/omYgOFeXk@nongnu.org
X-Gm-Message-State: AOJu0YyxU8CID5R5f5WIqGv58zFqM1VyF9h1uWYhPZ9siBE7Hbpj9WR8
 72j/goWDFokJh9GXDsORm6rNFS2gbwuN60bNjFj7vT0S2nT0NzB52y4cxiOQSTveHomlOWkCQkJ
 PWhw=
X-Gm-Gg: ASbGncufNfii9Kjub9GojiVV7PerPFy9E4H3iGEg8d4LryZstwRps8IOV1hVwjo6AIl
 uFcp8WRlJLBmAWzSASumHgYuOOiPf6vd1YNqXXWexl3pWwcEK17Bbni7R6A66TtvSZYHnGy/nnK
 aJ41jK98DOVuxwQ1L6RuMuZPtWzsr/H0ReNQYv0NUxAeduOzfQuPtNFEISS9fwFgl5uzKeq07Kv
 +0vb8TueABH05dE/U8QD8msOmFW7/dYvOKUydeVUf6rZO2HZxJZwMmIfiFaSY3RF6Zvg3Ubr4Jq
 RiKpx85Z+OIjWZH8runlbr3Wivzs
X-Google-Smtp-Source: AGHT+IEUmQBhJZND9aPrWD6clhdeoE9cfM862/n2/IbF2+c+hjmWsRyFB57dRsqAhdiMwjQCJknBmg==
X-Received: by 2002:a05:6870:a7a1:b0:296:7b65:2fac with SMTP id
 586e51a60fabf-29dc3fa25b4mr6327859fac.3.1732800408069; 
 Thu, 28 Nov 2024 05:26:48 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29de8f24b1bsm402091fac.4.2024.11.28.05.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 05:26:47 -0800 (PST)
Message-ID: <f9a1d7c1-c01c-4f2f-a5e3-02dcf3edce70@linaro.org>
Date: Thu, 28 Nov 2024 07:26:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 04/25] tests/fp: Explicitly set inf-zero-nan rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-5-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

On 11/28/24 04:42, Peter Maydell wrote:
> Explicitly set a rule in the softfloat tests for the inf-zero-nan
> muladd special case.  In meson.build we put -DTARGET_ARM in fpcflags,
> and so we should select here the Arm rule of
> float_infzeronan_dnan_if_qnan.
> ---
>   tests/fp/fp-bench.c | 5 +++++
>   tests/fp/fp-test.c  | 5 +++++
>   2 files changed, 10 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

