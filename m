Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1BEC83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDlr-0007hk-EC; Wed, 30 Jul 2025 16:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDWT-0002ni-Fy
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:35:37 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDWR-0005sb-FR
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:35:36 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7698e914cd2so283822b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753907734; x=1754512534; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XoZsf6gRdluiDWkEnu+z+RV/F7cALktBWlef/NsKBBQ=;
 b=YxF/OW9bRVFEZveCtp4iApa1XEXFBtOmRoveCnlRlxIHYUeMiMYf8+6TdtzSsEfqGH
 yumT2WUPE0gLRYHMppgd4T56AuQheAoJvXrmWRcnZjblQcS25yNHSd2fZBlBHSsnHQHh
 zRtuTAdFKOWw7w8tzV6/YGAmwvBSASMcVqTFfI7Zcm8d/mPUPZ15CgDZiqTvCx/4HWoV
 OlJurd6OEgUXdKUoVNzFlkSlo95VJiyU47Jx0rSMcbh58sCPhRhPPxM/hVQCmWWFrjDB
 lrYWYYuYeyI7sdMHPpQBC89bLvuv1nyzMJvtt0KhcPkLwEI1u3YjLMdxjyncP8kmQ8qW
 1Abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753907734; x=1754512534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XoZsf6gRdluiDWkEnu+z+RV/F7cALktBWlef/NsKBBQ=;
 b=jF9PWflBmA80dNmNszV6Rs5DeArslgQiJEyuy6gbkXehwwYohvNPMB2Ez5MTzQAezT
 +IW+5px5QeycDvqaQp0h+nzMpIrW6aNep2MsEwfpD6DjPP5j+YR4l4z2h7frUNuLlGiZ
 THCSbWNLrr2p36E9hrgL7nyIhko1psYPNVSKfsiy0BbA+QPchf3zIG7+PrCEpuJVwRUv
 fTYMuxhuGt+55ShOBY0rJjnzevD12+9PqJJhFdDjvd+olJg0hdBRFhMYic8OHA6mSKQT
 cEz3CIAS3lCj6NX/b4dm4FDYDgiCzVUKRPnbk6/q3evV7Q8O6++F78i+FbT07Br6mb5U
 M4KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsNboZD4LiQH3ylOgP2GOtftAVxDSXJCDa3GOlhsqyTGFXWCiznPjbUAD20TuRSHR4SYFYaoPfUzKT@nongnu.org
X-Gm-Message-State: AOJu0YxNsy9wbwlA9YNtDWM9EYH5e9hFjYq3tH+RtIz7A8Bcj8DRKjXi
 4z1KW7jg7/3QEwrtGT+KW4iwEjTuNXLcthHODEWKkGWg8Q6/ES4fS4xVXRCX7H83ZpPV3SYYt1+
 SEk9u
X-Gm-Gg: ASbGncuwRya5M6adxwBlwuiDd2IiMd4m0LRdwhGaIQcN+/B8k/QJOmXcARs0J+MPEHF
 m9ckccswurs3+myLewTr2VYcPxwXSagLClXpNMKLR36F1AgV1sJ1xx0e0nAuXCp+MSBA2Wo6vvf
 muJ7D3tpZ6ej7CRxj2v8f6mEkvQp6O5NS4R8MOKJYms7CAAhIYiSHE4ou16vtRivRjVVH4iFAGj
 9VVCUU/x3uqQXLSmYHO87+O3b2r09vhE2dojYRS+zEHDiItI8Hf/zT5fdATJOUPi8+2sERl9VPF
 B17+e14C5vUonF2sSZWXOE39v3klhKkA3sPd3bx2PcC3klW5CgJ7xPWNd596Rd2iaki680jH1Ps
 d/+CJ3KpRGM1arCG5MtdPjeJsERLF/WdVTgVijLZe60RZ/Q==
X-Google-Smtp-Source: AGHT+IE/h0tbzIXXdbOzjFCkjfvzj3KrD8cJ9Xr4t1EU6lSabqvWd9Ar6EMuTJzTyIo4AYaEI3Xsxw==
X-Received: by 2002:a05:6a20:1590:b0:230:f847:6586 with SMTP id
 adf61e73a8af0-23dc0e92791mr7246151637.29.1753907733996; 
 Wed, 30 Jul 2025 13:35:33 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-769b53591d3sm5138677b3a.49.2025.07.30.13.35.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:35:33 -0700 (PDT)
Message-ID: <4ffc8b87-2548-4c59-974a-2ef966e05553@linaro.org>
Date: Wed, 30 Jul 2025 13:35:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/82] target/arm: Fill in HFG[RWI]TR_EL2 bits for Arm v9.5
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h | 28 ++++++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


