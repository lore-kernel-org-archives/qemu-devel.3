Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA5FC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 19:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thZKh-0001Bu-89; Mon, 10 Feb 2025 14:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZKf-0001Bh-2G
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:20:37 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZKc-0006YE-RF
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:20:36 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21f6a47d617so38411615ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 11:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739215232; x=1739820032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hLTBQ1FbhpFci5pB1IYQg4zSOBIWt3tKh5YiQ2aGiao=;
 b=DMJCnr7lO7y52E5OuPQbDpme5vliP/dTE+eh1/kZQ5KlmUSSlXbbBHUnbdYoXj76zC
 Ar/JnLujchvfqgwTk/bnmagCzhTiC5SY8dR4O7ZAAtRIDSoUwr1AhFHKrswe7HsRzh12
 7OLzqtNBPFK/K+Jqf4M0HAmWus8aB1zd53NGtUTv2qJPUrHb5gMUY/SCx85n5CbhS3ZC
 ZwPGZ2DTpuBkHc5QS9wNixqjYEZeS4CZWLbfqdn6fsctc7T1dCko+ZzUdXxMoqktgZMF
 M9x91PMeD4Dl2MuP3epFJOIYzR+VgI1HCwzwBUG6byzjnNTmm8MavjdEKiTATtsy1uZ0
 TpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739215232; x=1739820032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hLTBQ1FbhpFci5pB1IYQg4zSOBIWt3tKh5YiQ2aGiao=;
 b=uN/aeBhggkMU1n+M0t+1jOvtXS5NsOMy6/qJWqYjPuobSDoct+ucYRzdFbkt1armPs
 3N0TaMI4ofBJ8UKOcqS9dSRJ8vmrx5D+sZ2siJHo7QV+SydwvjnL8H+7gutL0l3kd0U8
 VJwsrj/vVE2wiiHOH8NN2G6VB20Ovqx84U/N+XKy/HPERNaMtKts2mPEvRqXeOwvdqLS
 DHDOb3K2Ev7xOt3SYPCaXS5DYQ2OTDlija0Db5sPbJOTQj/M2HxnztQ/usJy8AyD0MEi
 uRGFmjBk1FQbkp0RJL0F2pZsmZkHHwAcc9zMfowVImbju5bVYYdvQlqcUwPhySTnudlz
 EPoA==
X-Gm-Message-State: AOJu0YzzMdDgWODF6UX4J4JBqd6EpD4N6I7QVr6gdylZ4nZqPFyQR7HR
 YZQV4K7N+3T4UYZHNqpMRS3Ui2SynbDR7iZkBXR+21a5bkT/XUDYmcuhgi9emFoO0Z0EC79V0Uo
 /
X-Gm-Gg: ASbGncvugA83nh+3joJhAVPn89NFWxYKAXfsOuXSiXzWOdlA0C3oqorsNJKY+FFNvh/
 Kg/3ZpxBG1idzd9d28HCKxQ9qffu1gqAm8RlTzOHfjH8JKvjjfWv0AQ6tmxrYYtr1CtDMUGqx3g
 c4yu9n0xOVaqbe9/D/cXJuzda8ihJA0Ok8GB//hoZob/WQAKAbtCz+T5KdrbhfDuu2y4N7PvSGL
 DsVAAja+J5SycKl+hjtbPELIoRqM0cJEQd5y8kLE/HHkmGk3MDihGFWsKnlxSckuQhNmiN1j7Yo
 R9tGsG6jd/YsZ8+jLDPzletPbBtBw4tVtmNHng1PEFeksFfgXUb2zFU=
X-Google-Smtp-Source: AGHT+IGyn98/+GdOA0nyd/K/uWMPj9jtKDbzYpUdxbOU1DvqPfoMBoq8b6hKxxIY8a+MXpY9znvdoA==
X-Received: by 2002:a17:903:19ee:b0:215:a434:b6ad with SMTP id
 d9443c01a7336-21f4e759766mr212527045ad.33.1739215231680; 
 Mon, 10 Feb 2025 11:20:31 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653c98csm82390625ad.75.2025.02.10.11.20.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 11:20:31 -0800 (PST)
Message-ID: <58ee93b9-2b98-4738-ae4d-c87d8f6a5cb9@linaro.org>
Date: Mon, 10 Feb 2025 11:20:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] target/arm: Honour SDCR.TDCC and SCR.TERR in
 AArch32 EL3 non-Monitor modes
To: qemu-devel@nongnu.org
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-8-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250130182309.717346-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/30/25 10:23, Peter Maydell wrote:
> There are not many traps in AArch32 which should trap to Monitor
> mode, but these trap bits should trap not just lower ELs to Monitor
> mode but also the non-Monitor modes running at EL3 (i.e.  Secure
> System, Secure Undef, etc).
> 
> We get this wrong because the relevant access functions implement the
> AArch64-style logic of
>     if (el < 3 && trap_bit_set) {
>         return CP_ACCESS_TRAP_EL3;
>     }
> which won't trap the non-Monitor modes at EL3.
> 
> Correct this error by using arm_is_el3_or_mon() instead, which
> returns true when the CPU is at AArch64 EL3 or AArch32 Monitor mode.
> (Since the new callsites are compiled also for the linux-user mode,
> we need to provide a dummy implementation for CONFIG_USER_ONLY.)
> 
> This affects only:
>   * trapping of ERRIDR via SCR.TERR
>   * trapping of the debug channel registers via SDCR.TDCC
>   * trapping of GICv3 registers via SCR.IRQ and SCR.FIQ
>     (which we already used arm_is_el3_or_mon() for)
> 
> This patch changes the handling of SCR.TERR and SDCR.TDCC. This
> patch only changes guest-visible behaviour for "-cpu max" on
> the qemu-system-arm binary, because SCR.TERR
> and SDCR.TDCC (and indeed the entire SDCR register) only arrived
> in Armv8, and the only guest CPU we support which has any v8
> features and also starts in AArch32 EL3 is the 32-bit 'max'.
> 
> Other uses of CP_ACCESS_TRAP_EL3 don't need changing:
> 
>   * uses in code paths that can't happen when EL3 is AArch32:
>     access_trap_aa32s_el1, cpacr_access, cptr_access, nsacr_access
>   * uses which are in accessfns for AArch64-only registers:
>     gt_stimer_access, gt_cntpoff_access, access_hxen, access_tpidr2,
>     access_smpri, access_smprimap, access_lor_ns, access_pauth,
>     access_mte, access_tfsr_el2, access_scxtnum, access_fgt
>   * trap bits which exist only in the AArch64 version of the
>     trap register, not the AArch32 one:
>     access_tpm, pmreg_access, access_dbgvcr32, access_tdra,
>     access_tda, access_tdosa (TPM, TDA and TDOSA exist only in
>     MDCR_EL3, not in SDCR, and we enforce this in sdcr_write())
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

