Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96105FED3CB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 13:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGGPk-0002hw-DL; Fri, 24 Apr 2026 09:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGGPj-0002hn-K1
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 09:17:47 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGGPh-0006Rl-6K
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 09:17:47 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35d99bae2ebso7028969a91.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777036663; x=1777641463; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=04RJJLzAs0m+0ZWMVWTdVcIpX4oXGvTaQxcIMiXfMN8=;
 b=X0uu4gkTtsx/JC+g1SJggPOt5+kNSLobgq2wS01bOTTQ6SMFgUk8V/+NH8dOJERDMs
 eiKYFwRqQ/p+ASaVseEno3AFpugvdlcy0afFdBWPG0/PTHwgnl7irVrK4b2T3MNu4/Ba
 DKu2yKL+HsW3BFQpq6BMODYxZqaxzuv1ctJfPd9reS3WP0t1P55VlsoCfIUK1kxpvbNG
 N05zWz0YcTzVP2Jr+oPX4VfakHW1YR/qPXcFSkeY4rGRs/suCTvCbe3YBxS5tNd1jJNr
 TGyshd0ot/A3Y/uA5WzAH8OM1z3KDXndSaED89KaUU66868XsgmrCGBvFisPcTrY2PIa
 4lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777036663; x=1777641463;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=04RJJLzAs0m+0ZWMVWTdVcIpX4oXGvTaQxcIMiXfMN8=;
 b=RUfl7uAf8Oocs1w8t0njNJ4rXQYGp1yT9WZQ3LppJgKsFVZMzgf/ON7CY9KMI+wxoh
 Puz5rqxGGFo+0ZwqtNKrVqWw2e1GJ7XjA2DICzfC5rKqIg63cfFlUknn1l7iA4UyYjNV
 x/k0dXBtT9EaRcPVNF8OUfhKTeV7bTZ7SXWlJbHcosvo0twmo5X19O6dpHaBfZLEDQq7
 vqBiP8lDhSIUOef34rASYu0m2WVSm1BoSs2OxWaoT7kwHpzZPruqmQGSCIG/3UV7+1b5
 /UHutKzHv5iEB3u0tMSo7m/uArW2hcaxHRqmGHA1Fv6oc2NxkpgxJ7o4Ik4coJ1vrskq
 Ufaw==
X-Gm-Message-State: AOJu0YxDPFfwpgym0tZzLQPrwNrb8P1MIZeiaFs4xJvsh3HYeFbtNLDS
 YaxQiunZiwerTLwsxu46pSa2a8X0FWYISyej8eJqEfurAedfZIM0fQ+RcfICyX3EEHjVhT1xmVz
 zoeN6KeM=
X-Gm-Gg: AeBDietHtQztBBKCaDa26vc7t2FUs3VkaqqzuHSB4GSY3f9tX+1YO9bSJvGoQyl9F0A
 qTkntyo9jewa4fFvDFsMrPdvUH4I5/imHIGfh712GTmpNPHN0RCfHQAIPZZTpY1IL4RGUgEguCV
 xCC4u5+53FBFmLsejLFO+37S5EPx1YMrd6Ir8zKU/ZvEoV99L1PQ31DRgE2aOAnUFn9eOTZJiik
 jjfKl5VfGR8zjUSoz9M30ekeWeCf7cqanmubSTjsmSvJSuxog1exFzNi847ulad/xSBcFyN0ETd
 9s//5kite4C0UPRoe24BZIRh1T8oktW4T2CLMteBfyhm9bB1Scd1Ceos8DgemFHHz+MeYykRzvX
 Gl7uYX5IFihXB2f/7tfFBLprb5kHjFwrp1Sbe5cMw/8urA1A6a9EG8nbJGEg1IYngmmniQQ60gr
 yCoxBdYBF9B+pNfCVEccmsMjGZBQI8KJrH569tF/j9OqH+b3SdASeBD+L8YndlHsU=
X-Received: by 2002:a17:90b:2888:b0:35e:58d3:329f with SMTP id
 98e67ed59e1d1-36140468b1emr35331027a91.13.1777036662957; 
 Fri, 24 Apr 2026 06:17:42 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3614189343esm23215604a91.6.2026.04.24.06.17.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 06:17:42 -0700 (PDT)
Message-ID: <5794be46-6755-4216-a57b-9a94172ec2b3@linaro.org>
Date: Fri, 24 Apr 2026 23:17:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/riscv: Support raising misaligned exceptions
 for vector loads/stores
To: qemu-devel@nongnu.org
References: <20260424102800.24022-1-frank.chang@sifive.com>
 <20260424102800.24022-4-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260424102800.24022-4-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 4/24/26 20:27, frank.chang@sifive.com wrote:
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -1190,9 +1190,10 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
>        * Update vstart with the number of processed elements.
>        * Use the helper function if either:
>        * - vstart is not 0.
> +     * - Zicclsm is disabled, so misaligned accesses could trap.
>        */
>   
> -    bool use_helper_fn = !s->vstart_eq_zero;
> +    bool use_helper_fn = !s->vstart_eq_zero || !s->cfg_ptr->ext_zicclsm;
>   
>       if (!use_helper_fn) {
>           uint32_t size = s->cfg_ptr->vlenb * nf;

There is a whole set of MO_ALIGN_* values you can use to select the alignment of the 
vector element:

   log2_esz << MO_ASHIFT

for log2_esz <= 6 (aka MO_ALIGN_64).


r~

