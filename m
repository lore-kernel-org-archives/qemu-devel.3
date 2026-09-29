Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144A9CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBakv-0002Bc-Ky; Tue, 29 Sep 2026 12:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBaks-0002BT-Id
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:32:35 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBakr-0005Vo-3v
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:32:34 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0f64df6a6so1541789a91.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790699551; x=1791304351; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bybYEK6pYA+dBkjrB2nDXDUbwFfCebRai4GNmCJz4ck=;
 b=SppGW9sPxWVm8q/2Tg1iigsaqh8gTuokxRdZcF0gVG24U79kWIlGAM7wrg58WV3f5j
 dKd3pgCDMnJcDT+W16VrCN9PD0UERFfnrSk29182WUDInH28Gq7sxJNaHP7VBYerSqDK
 Yx1XWmKYnQagpZgDuqkOu0v3nvmyo/T4du/qppq9PYqJUdf9MtFveDrsWwo75V3GIOKV
 75tconfzHLcB9BCzyCc5On8bXUjYbAJbG2HhZLUPLav26gkbv2DmAdla/YWbKqgrpuDb
 MSyZzkUO6ZtrZsP3k+G8I+qV9g8NLupRI3fTbhswjuvkUrs7wiQ07oxWUBRtXMHzAIrs
 crdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699551; x=1791304351;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bybYEK6pYA+dBkjrB2nDXDUbwFfCebRai4GNmCJz4ck=;
 b=zcZiXw3CYK8hijWo0UPsnZ868A8XdZ3cDtemWNezpjhvAZwIWNgwphQKjazGKJFS6I
 aYxGhiP20pbQA6qd13AjgPLXsE1g7V5oBJ9Jhj4R/AO9796Sec4DFbHm93XPr+LXYTBf
 p3ja2zaX48WVVvl+XEu4ydKvyhlkimTzy7V+EKIQfWAnOdl6R4xHrLou6voiY7YSWoCV
 5Ki4QqK7LPoJnwAemQBhJgJcl0c6WXQZ9MpTThoihom6OAX3m7LMEb2t7O6H+9XIQl+D
 Rsc35V7b/8YKb4tplpgRaPb/9YQVw2lOHSZAPqqD1B4+cKKE7bC4L97ObdOthgxasKyT
 4aCQ==
X-Gm-Message-State: AFq9FYJHyfnuvS4XbcFTYRtU4wa98HLhoSL5GQjFBocOnPT/Qxi/KWw4
 gadYoIwepT8IKIe0NhOvZDrZSvQDIhEimuq8jnqCywlG0xv407zzHV0csMh6wtyJcXI=
X-Gm-Gg: AYBFou1YWWnUyMCDScaTKYIyIOrRxOdNJMOtnh50UnOs1+40LdS4L+gphf1FQHcLJs3
 LHIIEOaeg1pC4NP+1R4Pkj7TgtcnBUNthwDgwvSyuLOUFs6fiKVgSpo6m5sbmkC0Obnx45AIn6L
 CBoq2+CoHU0wjTSRTsspk5duNn44gkyE0Puyb9VT6gt0cISA3prKxsbUd89TzfDKtogwy6bYCkV
 Ames+7Y4uGyX5rHIThQ4nI2pFFHH3YauzGaNIklhZUkrJ3ON0ZFJqC6HyQvkDrfhWCMDLmDI3xS
 5DPCIsWxfm3EWjZUeQtqNzhYfRTaYZEcA1oFklFQ4IaL3osta0Jp4ml2Y2i2wYoaFO2M3aauu5E
 tg5LO8TQ/vt9JrVJFUr+WTTtQvIFFgbok5opU1486w+D8v3pWfU/ZilrqupKPV7dgvvKpdritAM
 vOGASQ7pZMBY1r4dYEjSkYiQf0fu5Amj3Uylqrk6P++Kj7qRJ/XsrEElKdpybeU96lZWzTWk8Kb
 8sySAM+NmiE8+ZSL9hYA7Y=
X-Received: by 2002:a17:90b:3a44:b0:3a2:aec0:6bc4 with SMTP id
 98e67ed59e1d1-3a2aec07038mr6263993a91.50.1790699551516; 
 Tue, 29 Sep 2026 09:32:31 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a497f1b13esm6486361a91.9.2026.09.29.09.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:32:31 -0700 (PDT)
Date: Wed, 30 Sep 2026 00:32:28 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, 
 daniel.barboza@oss.qualcomm.com, Alistair.Francis@wdc.com,
 philmd@oss.qualcomm.com
Subject: Re: [PATCH v3 10/11] tcg/riscv64: Validate AUIPC relocation range
Message-ID: <arvoDcqs6m0AMxTs@sifive.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-11-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914000814.785155-11-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=max.chou@sifive.com; helo=mail-pj2-x0c.google.com
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

On 2026-09-13 14:08, Richard Henderson wrote:
> From: Max Chou <max.chou@sifive.com>
> 
> reloc_call splits a PC-relative offset into a signed 12-bit low
> immediate and an AUIPC contribution. When the low immediate carries
> into bit 31, the existing 32-bit arithmetic can accept an unencodable
> positive 0x80000000 AUIPC contribution.
> 
> Keep the split in pointer-width arithmetic and reject it unless the
> rounded upper contribution is representable as signed 32-bit. Factor
> this validation into split_auipc_offset so reloc_call retains its
> existing failure contract.
> 
> Fixes: dfa8e74f9463 ("tcg/riscv: Add the relocation functions")
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> [rth: Pass target as intptr_t to split_auipc_offset.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/riscv64/tcg-target.c.inc | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 

Reviewed-by: Max Chou <max.chou@sifive.com>

Thanks,
rnax

