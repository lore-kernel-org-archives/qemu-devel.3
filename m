Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AECC9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 17:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAshl-00067o-Ou; Sun, 27 Sep 2026 13:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAshd-00063r-LB
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 13:30:18 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAshb-00043Q-Vh
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 13:30:17 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4aa0f1766so1265005a12.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 10:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790530214; x=1791135014; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ExM/NyBUH8tQ7JkKWySPHwF4vo78dAuWgItqjp9ykiI=;
 b=hFS4DkfZkiJfbz1c5it6pV626Tpqz5+lwdvdk5L86SkNpYxJCftZ1fEVtmzeVB5Rfv
 5BGZRg6CAotR2DqWcpLwqPxe/ZMAUOxwX5nJLFEmw86JNRzCZXxxngw3F99aoBZeDBAu
 oz4RuE+TlROaY8gxgkQzyS6K5ApvR+GjB0AUeCiXu903fQNpeAUpyW3IKgKftYLH9BIk
 WdruHDckPEAZ6rXizY++aZpYjhW+Tw9mg6alK7kS9bBR9x8ShPHQEM4+3der9vpWIGS3
 ituUqiUiygXDfY3hRkzmNd4w8bymz6YbAZcC9vXQ5NXGGEmfF6isNg/6GFNKjLa9BzlL
 qVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790530214; x=1791135014;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ExM/NyBUH8tQ7JkKWySPHwF4vo78dAuWgItqjp9ykiI=;
 b=PDLQhwUeWmJbIOojNvIFDyz/hyQfXcKoU9wHKpeea1tXq97FubUnRmrLiyMAuSvuAN
 72qiFIZemiPWwFOM9MPGMaMupZKIxBTnZyk5OnfYCgYjuC/AOgIUETmKUYETwhnkI9Qf
 BUoye+3tipfLR0nxiF1nFOcBi2WzsFKc781VAJNFGXT8S31CoGPiD9TzTvlaDkEbtD7b
 6UnFZs/S1St6xcJK8cbrSOJvfcULGbhKp4TOixsoJ3g3WcBrQU6k6og9OhFQm1+0NK1h
 E15Q8WSLdF5P8EvZX9rwWP3/fGeY0g31Y43pKhtrHpT3lXIOEdPFTDrS8Zdo0CHObeDj
 3k7w==
X-Gm-Message-State: AFuF++mu78pssYGdUAhQ3Sx5XXmx7rx57c0ySP68Ls9Nxq/QEiLOfFRo
 JQcPmckMYzQpkQW63jjlC05daEslum5ePyVUdAR5E0rtQo83AiXLQopglE0rJLpoqAtYEXX5tze
 xfDr2
X-Gm-Gg: AYBFou2BHnFDSeRsPRjjhVYOG1tdeFbtxhiM59Jga6CII8zTbHSKS4Pq+T1O40/5XEY
 9MeJNoB/QfXQTuWSFIF1jJyCapkTZWtEjGhUHS1+PK9o02y/3CNk/Cej9qVNuUHD4xn8d5jICyH
 WYuWbcHMkHvX5gOpgMgNQAUWS03wd/8rX+/hJ8K9eJJaiORj9iOQZuJbtC8XVHnVn7OSTby3Sm3
 MpoFvlrcptOwmqwuVOEJs9VuswWaVINQJ3o99HNLbHTVM9ZGTDH1CKX9C3SfM7SmXsgNr2RLNuh
 yjWs3M44cV2tK2scmb+oBi5RvgdCjUPw8YjNmCvp+7B8w5RJ/tSEmsLZk/KQdZEbzCiHWSivxB/
 bCKOlNSiSeOZTe+0mn5IM6KgFoEl7Y5BcDa/h9lobUhmDSZzfSHYH5Si2fip8N7poTVFlLg91kf
 79glQ97sjboWfu899LR8WS1IACPJtwLOzuA3DfFfa5P6AciToUiXAgKUPvWsHTIqLDgVE2znx39
 vDaLto3jns1jUBRrRQoaUIh5nZuYfgjgrcFc9cr
X-Received: by 2002:a05:6a20:4321:b0:3de:6338:cfb5 with SMTP id
 adf61e73a8af0-3de6338d6cfmr670209637.33.1790530213901; 
 Sun, 27 Sep 2026 10:30:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87feb583422sm3145267b3a.50.2026.09.27.10.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 10:30:12 -0700 (PDT)
Message-ID: <983581aa-ffbd-40f9-8a9a-b6fbc066a1cf@linaro.org>
Date: Sun, 27 Sep 2026 10:30:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] tcg/riscv64: Fix AUIPC pair range validation
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com, palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com, 
 Alistair.Francis@wdc.com, philmd@oss.qualcomm.com
References: <20260914000814.785155-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260914000814.785155-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Ping.

On 9/13/26 17:08, Richard Henderson wrote:
> Hi Max,
> 
> In v2, the change from int32_t to uint32_t is pretty much
> the opposite of what should have been done, since all of
> these are logically signed values.  I've adjusted all of
> the encoders to take signed inputs and assert in range.
> 
> In the process, I noticed tha the branch range tests were
> off by one.  Now all performed in exactly one place.
> 
> Finally, tcg_out_ldst needed updates for AUIPC as well.
> 
> I've tested this lightly so far; full testing on a rather
> slow riscv machine is still on-going.
> 
> 
> r~
> 
> 
> Max Chou (2):
>    tcg/riscv64: Validate AUIPC relocation range
>    tcg/riscv64: Fall back when AUIPC pairs are out of range
> 
> Richard Henderson (9):
>    tcg/riscv64: Return tcg_insn_unit from insn encoders
>    tcg/riscv64: Rename sb-type to b-type format
>    tcg/riscv64: Rename uj-type to j-type format
>    tcg/riscv64: Use signed type for encoding immediates
>    tcg/riscv64: Adjust sign of lui immediate in tcg_out_movi
>    tcg/riscv64: Assert immediate in range for [isu]-type insns
>    tcg/riscv64: Return success from encode_jimm
>    tcg/riscv64: Return success from encode_bimm
>    tcg/riscv64: Fix off-by-one in branch range tests
> 
>   tcg/riscv64/tcg-target.c.inc | 230 ++++++++++++++++++-----------------
>   1 file changed, 121 insertions(+), 109 deletions(-)
> 


