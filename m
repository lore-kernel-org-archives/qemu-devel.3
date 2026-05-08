Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0F9CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLP2O-0002Am-Da; Fri, 08 May 2026 13:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLP2M-00029N-CP
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:30:54 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLP2K-0006KC-V3
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:30:54 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-42fdab683b7so1219352fac.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 10:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778261451; x=1778866251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PcCGFKSeSDiFKHXeL28dhI/b+093mcZfYC74ymBxegI=;
 b=SU1mo472h5cNFt/5bYom6qnPMTBxQNTKvL+JFjYJ7fwCASyDTQrUTb9W4RzM9KL49D
 1gwHzzCPANVYxCrzk5Wt0UKWDlxvk5PjRK7CfzGI9VUD5rwsGGlS09o4Vy5BDaM1kTKb
 6zeF1OfbAl6Id2MZX8CyDrmzXKgxCtTD6b05P3uLzHc+f54Jl5wJ5MM/CaIdcV21txI3
 x6/fToWe238+kmYnYisfw0cKi0WtfTGRSzjc9lNreVqgRtwCKhG1jRv+/MzypFj0l1bP
 cg/fr2wwaQN21W+pwi9WQFVSHmJ5R/HzlUViG1f/eRGUST95iNmgo3S7Qruc6P0Cqchq
 +Y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778261451; x=1778866251;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PcCGFKSeSDiFKHXeL28dhI/b+093mcZfYC74ymBxegI=;
 b=tRFxdmC+uPI0bx7CV5r9QyNchxTqPkhogmQLXtE1JeNAskKYlQL8dr+XrRZ/6lNlBP
 3r+uEIF1rBTc9vcRmY7IJEPWu0wixTOqRnAU4eod5pd313eNZv5REKC+3mAj/utSDzJF
 v4E1Hicm+uPWzZPO0gTBfErE4ROTxZSDaFmxwZrYGNGNrQcgbJQo5xlFcoThqMlDMM1I
 7q0Z59Hd2K0rsOO5nEYn/s9bDDCBHQXRJZt/MAyNYP6glQu14fqxHLGPBrkrq9rjQ3AB
 Sft/bnOUX3NG4VX1z9YLDTenC++GIyjDGbzO5SjVP5Zvtkydo70GKSdYMSDNu5IU31bB
 S+7A==
X-Gm-Message-State: AOJu0YwkzzQ5hnyexUTTtNEPuUVOpzEi+96/f6bvmyZurBLUTXis1gAe
 VWoDztsY1wUras6kjwCFbSToWfhQZabHjhaYaK9e6FdKxzhzTX+E8opFRiKr7mC0BfJGcLS+bfF
 ZnDDc
X-Gm-Gg: Acq92OHCvLGaU5XiridlvKRAky/JKzcchoeqOVV7+rFPRbdBg8yFB8tcSQ9URHUvdle
 8Ly/2o71+JgsKxDxEmya1hwdkAH6j6a1LCKyQsHS9wOfAGOk+3LCFjKVa2iIwlTg4WC91zJcmKT
 uRIgxHhyPiUiSMf6ez/rTjdBPEF+PtANMa5n2DnZJvu/oXTUEy2IAntbtFlvAn1zWg3B2TkfDrn
 brwVvIOTTkwyAlMpNKxNhvAKrz7eTjC4VCSMDZTJezjnpmLbfkLgoeoEqMkjnQsrZoeecWbP9WP
 o8wupGACUIiXHddpJunyHn+q+2w7fCKpSphcxejY6Hztx2pJ7M2UY7EUgsefOJyQf2Em7KWsIWL
 S25XnSM076tNN8r9tvcQksJW7qYySEV6qs/7+wRqiefUwZf0tMHjbWfLp58Ja3haPEKsm+825Fo
 oBrypoZPht4tSmdtkOqTXmAOfo0djrizr6xkqtTZbz8WwUMerG3h0+osW33yoof/duSQhCgNYPQ
 pfsDjRayy150gPMtUxD
X-Received: by 2002:a05:6871:4b10:b0:424:5b7:65e2 with SMTP id
 586e51a60fabf-434f659b726mr8596770fac.39.1778261450995; 
 Fri, 08 May 2026 10:30:50 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:4b0a:aabe:cbe1:bd0c?
 ([2600:381:c938:6375:4b0a:aabe:cbe1:bd0c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557371c56sm2132381fac.9.2026.05.08.10.30.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 10:30:50 -0700 (PDT)
Message-ID: <cda2fca2-3b8a-4c28-9ab5-266b36ca6ff5@linaro.org>
Date: Fri, 8 May 2026 12:30:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/32] target/mips: drop Octeon zero-register fast paths
To: qemu-devel@nongnu.org
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
 <20260508-mips-octeon-missing-insns-v2-v3-6-bcbec96357d9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-6-bcbec96357d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

On 5/8/26 10:12, James Hilliard wrote:
> EXTS, CINS, and POP route their destination writes through
> gen_store_gpr(), which already discards writes to $zero. Remove the
> remaining translator fast paths for destination $zero so these Octeon
> instructions follow the same shape as BADDU/DMUL and the generic MIPS
> translator helpers.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Remove the remaining destination $zero fast paths and let
>      gen_store_gpr() discard writes to $zero.  (suggested by Richard
>      Henderson)
> ---
>   target/mips/tcg/octeon_translate.c | 15 ---------------
>   1 file changed, 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

