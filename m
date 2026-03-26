Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868F910AB82E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5u9o-000764-1h; Thu, 26 Mar 2026 19:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5u9j-00075a-KS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 19:30:27 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5u9i-0003el-1Q
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 19:30:27 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82c70e4654eso669845b3a.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 16:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774567824; x=1775172624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZPDDHhudNQXMh6zAqQ0mAej9aSiebB1sLlzHOIiSes8=;
 b=Ht8tXFQ7faC6A/8LmZ8aUKVYUYBvOdxGo96K79MNfvgalA5pWbVhXIs3FgkCEF3IoA
 dRf8XwW4x2MCCb0jyQUn25U54Cky9fGGgq6mFGxykmefhxUdOLdbJcTQZ8Eflr+vYjEH
 A6iAKRHq7nhxQx0VViRQ/HgshfxSfMQ/lV2wo3tMN4SLD5ApTRYWJeJwZlxl6W+GynNh
 FLUmtUpB6kXbaYqAnG417u0WyxuLj9wcTPe6qQ4dIMLqCp+0jXKlnx1TcLK0QaLiEkCM
 ayHfl2avmahjbWjQuxE1C2oVYH9q0lPOu4SGENV+HzpNsvKNDXvcPSh/qF/Sv9Q1cult
 orvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774567824; x=1775172624;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZPDDHhudNQXMh6zAqQ0mAej9aSiebB1sLlzHOIiSes8=;
 b=bvevVt/gkHzT2pnmhTylOB+QBhq7BB83Z9YAwu1e4rxZSPb/9pgQMafJpC93FnpPDU
 tqnwjxu85vQByjtXh0U5+Ui45zVaqDLo8wMlc76BBt5PBvPTtva05xUeflEkxFTVZtcL
 2FNvbpfZprHWttGQ9f19Kcw0y56aNJh05vnwivI7GsFncb8IGOEOI8s5Vgur6S/HPoIM
 glV0zTfOUUVSvP+cYYJ1TG4dD7dOmaZlMLlOSJtYCaTb1IbrK3WbcDV/Ka3no/z3Jt4h
 P2uT1FSmN7CNZ3KvVdujl7jibTZoOHbWS8OpqoybbxLBJL+x4TkT8sRaCpm0YM2J+Q4Z
 Zf5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwFlS/Em6B9XyaIEU34Qpj1DJNpy05xxl0F2+yw+AkQ2e6MrLMfzOKmPQRmI45BBfeJHIVzK6liXlH@nongnu.org
X-Gm-Message-State: AOJu0YzRg1cfZEgewcfyPLFSZaJ0xeCIN8rr6U3GlPLnnFGtwCp4FS3c
 i4NI6Js/j2Q8gJgtcdmzoT0BADVnm+OFp2PVopOLURo/WpiG+pGZ/nzLZAk6ZNFMwWo=
X-Gm-Gg: ATEYQzxCdqbq55pC2wFOnVn4y77nF9wgmOVh7mzrCKtDFXjBU5utC0tq/dwOgz+hI40
 a1u4wIi4LldNNAnY9ykYQ2a+9EY8zC8ctitIGkiTruAlwftuZu8n3gCIvndU0XyropxtuzS1KRN
 ZVQ7tNJx3EuTfw1CfD/vpZ3WwMoJ6+4oav90WwKN8LtNXhI0/BHxxAZk074GztDWVDgKISE3MZ8
 Dfrf8OlcLVyQC2w/CdrUZmnpHeOoWw7EEoy5hIipCKXyKfwyGf3nBS+ci7tGLZR7u2k7ljpwIEj
 E14At9qfWTvY2Gqekief4IeUc1ipZGny3BunYUw0O6HDul+VADsAt3arNHogKSxqZOqPmrrB+dn
 fTiNIvgA04CGEnAwX91oBCCbc7J1vGo7Q5Ax/6VYAAPFoLSYtumHfky9095ibsDkNE8JLkBrewZ
 Gba7sKJxAj6oDT4DM7fDfy8dutoEBT+njdM9Mwszp2QA==
X-Received: by 2002:a05:6a00:17a7:b0:82c:6f7f:53ce with SMTP id
 d2e1a72fcca58-82c95e44b12mr291988b3a.16.1774567824421; 
 Thu, 26 Mar 2026 16:30:24 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d20fc0fsm4425427b3a.19.2026.03.26.16.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 16:30:24 -0700 (PDT)
Message-ID: <8a54ee95-6b50-4fcb-8d2d-54775b387ec5@linaro.org>
Date: Fri, 27 Mar 2026 09:30:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/7] target/cpu: Add two new address spaces for
 FEAT_MEC
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org
References: <20260319022335.22523-1-gustavo.romero@linaro.org>
 <20260319022335.22523-3-gustavo.romero@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260319022335.22523-3-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/19/26 12:23, Gustavo Romero wrote:
> Add two new address spaces for FEAT_MEC. One is used to store the
> substitute encrypted page, which is returned instead of the actual
> encrypted page in case of a MECID mismatch. The other is used to store
> the MECIDs themselves, associated with physical addresses.
> 
> Signed-off-by: Gustavo Bueno <gustavo.romero@linaro.org>
> ---
>   target/arm/cpu.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 657ff4ab20..87c1787c9b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2364,7 +2364,9 @@ typedef enum ARMASIdx {
>       ARMASIdx_S = 1,
>       ARMASIdx_TagNS = 2,
>       ARMASIdx_TagS = 3,
> -    ARMASIdx_MAX = ARMASIdx_TagS
> +    ARMASIdx_MEC = 4,
> +    ARMASIdx_MEC_PAGE = 5,
> +    ARMASIdx_MAX = ARMASIdx_MEC_PAGE
>   } ARMASIdx;
>   
>   static inline ARMMMUIdx arm_space_to_phys(ARMSecuritySpace space)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

