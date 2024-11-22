Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34203E69189
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 18:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEYUZ-0005UK-0E; Fri, 22 Nov 2024 13:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEYUX-0005U2-5U
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:34:53 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEYUV-0005F0-C3
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:34:52 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3e5f968230bso1213079b6e.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 10:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732300489; x=1732905289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ul/vCWK6yU1xNEGcZ9rNK6i6HuuD/mK1RfN6imGIrqI=;
 b=oOuVAt+XE1OzzCW+lliBCdv/g32EtXLgz133kjRneW3PhC/xrrKsubfepnQw7Yb52N
 Q5qEP/0HFqsdxRbGnJ/Aso891LB++/mYI76dOsnPi3zATZr0/FY8PzngiVOjexjShbaI
 YmyqbrJBwRW7QLkQt6s/CGr6w5pY/LECTDyrsM1ACDbOyhJLcae7Rk0Oe7Jd6E2PNejh
 btXQOIgeySWn6a/lXG5Hp7mQZ85rMEdOOgUVz5pdMvZZts69R7RorIsbcOZeaHitc45k
 BZ14lzBKxlUfrZMKApWwL0PkMyWQdjG6BcIQ8pg+lTrNo+TE/VxjthUAGsgwOEwC0hdq
 p7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732300489; x=1732905289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ul/vCWK6yU1xNEGcZ9rNK6i6HuuD/mK1RfN6imGIrqI=;
 b=Pc319gOjRkbufeWV1tkA0Js4TESlJQRpLRp9wNbzegelVcWuwLlLCeu9CIpLAepwrP
 BNgVGPQ0ourIDZNFc7hSCoTBxE0GU8xnVBD9yJaWPuvv0l+dD1ORNS/23US/VEYsulPq
 iilnbwjy8nFHWoOopB1xekGeiyy5hd67GdbyyFAz/njkU6gMbJ3+HbYS34gAxRAOx4cS
 btPKd2yioJrIYOQZvxOc3xcmxJQoPnYGJqDeJXca3js6qZ2Mr941HnzAB2ZZHo7pQW/w
 OUtPd9DTXFsrdwXQVCfmDtQXmeMs75Ajh3LonUE92/gkWtv4SmujOktp5erh/l6q0fIK
 KEaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3JhUM9kdPagqDWfvRtXj8qjxtOVbV/NknGmYgf2FK2pUB1OFHgqB0TVJR5tKuodv7Jzm0LWzZtpL4@nongnu.org
X-Gm-Message-State: AOJu0Yyakz1GLzVk6KC6y9rLB6O0/gfMtg6Bfo8qpgxLKE0nbFoKD1I8
 6rXJeMLNAVzPXAnAcwT5rzAeyDMM2+QRcBRt3KJKr2W+k9Y9SAfw/t17Ka7/Jfo=
X-Gm-Gg: ASbGncsruReQVO0KwCTRHAPYdevNEbmDu2LC6DU7XATN2w2YCazvDe5G/AINO/4Yj7s
 +kPsWDTM3iXA8szPHQYZEBUg2Q7BFZpt7Vo8MlwKp7zLgDKfuHpDgX+Clm5x4LZ0XbiLrR/ct5b
 ztwm02PhnIBn1XXQqiC8wKtC9BoVdr3xGJ2TmhR1QUeVh+CpFZ2Jc/RLzBjanyY4nh0ss/MCntA
 73jdPJO/u1Dqlt9ns7ZeCeaIlBxBCpHJl3d/OQcEBlGGbSj7Ewp9N5mA1ON7EXoQDzuVl8=
X-Google-Smtp-Source: AGHT+IFpf/NgkKTiqx0fZpv79sTqMu4k+exBMmxm9pTyJtNtooqswsqiqAEpMgFeOdm2TgeZ/0PCdA==
X-Received: by 2002:a05:6808:170c:b0:3e5:fd5a:d3cc with SMTP id
 5614622812f47-3e91581c560mr4889391b6e.16.1732300489670; 
 Fri, 22 Nov 2024 10:34:49 -0800 (PST)
Received: from [192.168.170.227] ([187.210.107.181])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71c037590a3sm542423a34.8.2024.11.22.10.34.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 10:34:49 -0800 (PST)
Message-ID: <cef19610-7578-4e5f-809e-ab449fc7b710@linaro.org>
Date: Fri, 22 Nov 2024 12:34:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 34/43] target/hexagon: Add get_tb_mmu_index()
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-35-anjo@rev.ng>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241121014947.18666-35-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

On 11/20/24 19:49, Anton Johansson wrote:
> Adds a functions to return the current mmu index given tb_flags of the
> current translation block.  Required by helper-to-tcg in order to
> retrieve the mmu index for memory operations without changing the
> signature of helper functions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hexagon/cpu.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 764f3c38cc..7be4b5769e 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -153,6 +153,18 @@ static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
>       }
>   }
>   
> +// Returns the current mmu index given tb_flags of the current translation
> +// block.  Required by helper-to-tcg in order to retrieve the mmu index for
> +// memory operations without changing the signature of helper functions.
> +static inline int get_tb_mmu_index(uint32_t flags)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return MMU_USER_IDX;
> +#else
> +#error System mode not supported on Hexagon yet
> +#endif
> +}
> +
>   typedef HexagonCPU ArchCPU;
>   
>   void hexagon_translate_init(void);

I suggest placing this somewhere other than cpu.h, as it's private to the translator and 
its generated code.


r~

