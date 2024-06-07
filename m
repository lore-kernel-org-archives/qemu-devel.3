Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2217EC27C55
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:44:51 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFbnI-0007Mq-Mk; Fri, 07 Jun 2024 11:46:20 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFbnG-0007MM-6V
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:46:18 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFbnE-0007U1-JE
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:46:17 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7025ca8bebcso2018356b3a.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717775175; x=1718379975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uac6KoO32L9+6czhV1pDuA7BLZcZKuuVRVkct3+TYlM=;
 b=ndqnHeub7WbKTOSvIkc8cbXpQzqJV67xwn25GhbpGZWfRpUGiaMcoQ+9pXflf6TPSc
 sLL03OvHJM/lTEjoTVFr5sP8ufOH0pu9RlEjMGWmJ9Eo9rsatnduzTmFxGW/R1tk6j2m
 6ViDPUv+xcoqUaRrkBaVPSYqy53LRlQgQWyNlEWB9nr53hYTjvLYicn8B6IwP0P335ya
 CUH4jGAPAeLsQ1PCpRdlxkQ50nIJiBucmUvrBA4hKeo4QDnjPUnQKLF2GYe8PCxcVFI3
 o57oFzWDeKMf9wi1riYheKM8K3c7epPXXdNa/yp0JIh8ROo2LZwlZq8xcnJlncydbXWG
 zvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717775175; x=1718379975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uac6KoO32L9+6czhV1pDuA7BLZcZKuuVRVkct3+TYlM=;
 b=LAJz99bnOf7/MJPYMri8SmCackOrG64GB3Jp8RmIacD47TJ3opXWcEwqdx2P1/wqow
 3U6maLsRQree6VYMZqM3DvT2EBtLCLSIuU8rgMA5avkw7Nh4F9qIcvfbR2M4wmPsXcFL
 326lM+LjWu++6DAvIvfxsu3yvuLp1ofyhSZ0UNMvxldtcfPKch9kcuc2aj+mDywwhAVk
 tGryzk6QLvSlLuvZvgqSojtSQzCaj2EEwa+TbpYjx9AwwXLLVPhAxIKbOjjeXbURzExh
 L6Lm1pMtWOBasKe+CLEaRVfUGBqGtmUYrQcaGMrOK2HeTMmT+ewH00kczDeNCna/ti08
 AL6A==
X-Gm-Message-State: AOJu0Yz1lBsOuBBiIEGLljvmkNMDPNB25JeoLOnJYzFMUFU+jvuO3Z62
 wnXMIajk7n4NADCZhwJpe5/rIUbm7L8/GOeSmwJNAzQ6o1/lhE3u+EmdYlKop3s=
X-Google-Smtp-Source: AGHT+IH/IkRv47Uw7bD3fbuFiqA8CtP+MXPdtVSMAXnVbjOFhevKSLsZZ6unYY1ezOD9wVy2I8Tkjg==
X-Received: by 2002:a05:6a20:f397:b0:1af:f8b5:9c13 with SMTP id
 adf61e73a8af0-1b2f9c89d16mr2485851637.39.1717775175252; 
 Fri, 07 Jun 2024 08:46:15 -0700 (PDT)
Received: from [192.168.223.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6de2760b076sm2907550a12.84.2024.06.07.08.46.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 08:46:14 -0700 (PDT)
Message-ID: <28ea359e-fdbf-4a4f-b004-19e558d8d96f@linaro.org>
Date: Fri, 7 Jun 2024 08:46:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/ppc: Move VSX vector storage access insns to
 decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240607144921.726730-1-rathc@linux.ibm.com>
 <20240607144921.726730-4-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240607144921.726730-4-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 6/7/24 07:49, Chinmay Rath wrote:
> Moving the following instructions to decodetree specification:
> 
>    lxv{b16, d2, h8, w4, ds, ws}x   : X-form
>    stxv{b16, d2, h8, w4}x          : X-form
> 
> The changes were verified by validating that the tcg-ops generated for those
> instructions remain the same, which were captured using the '-d in_asm,op' flag.
> 
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/insn32.decode            |  10 ++
>   target/ppc/translate/vsx-impl.c.inc | 199 ++++++++++++----------------
>   target/ppc/translate/vsx-ops.c.inc  |  12 --
>   3 files changed, 97 insertions(+), 124 deletions(-)

Because the ops are identical,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

But you really should update these to use tcg_gen_qemu_ld/st_i128 with the proper 
atomicity flags.  This will fix an existing bug...

> +static bool trans_LXVD2X(DisasContext *ctx, arg_LXVD2X *a)
>   {
>       TCGv EA;
>       TCGv_i64 t0;
> +
> +    REQUIRE_VSX(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, VSX);
> +
>       t0 = tcg_temp_new_i64();
>       gen_set_access_type(ctx, ACCESS_INT);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>       gen_qemu_ld64_i64(ctx, t0, EA);
> +    set_cpu_vsr(a->rt, t0, true);

where the vector register is partially modified ...

>       tcg_gen_addi_tl(EA, EA, 8);
>       gen_qemu_ld64_i64(ctx, t0, EA);

before a fault from the second load is recognized.
Similarly for stores leaving memory partially modified.


r~


