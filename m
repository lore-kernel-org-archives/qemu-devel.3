Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8B5CD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRMvA-00072w-EY; Mon, 25 May 2026 00:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wRMv3-0006zm-RZ
 for qemu-devel@nongnu.org; Mon, 25 May 2026 00:28:02 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wRMv1-00079M-0e
 for qemu-devel@nongnu.org; Mon, 25 May 2026 00:28:01 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2f7020a928eso13358221eec.1
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 21:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779683275; x=1780288075; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=98hG2LjurcoyBDog7AEq9lxKP6OiJbF4+snXfpW3dqU=;
 b=ljy00Siz2UQadjC0lSwxowtuyxSlMKIqhMZBOS7p7Tdz6YS3m8gci/Prgf3MbcOOA5
 uGD9ijI7jJMVzJ5AGFihv9/uV3OuR8Zr3zVRK0fwz7DoUUrFg0X5Rba0WS4fJdHYIF/+
 cFoekoj1J5UqlVakPsrUNtUDGSxAvqhFydKNxbbkQeuHz/MAg4+/u5c5Vd0aa1VUNUVY
 9jYgpFIA4RCW25fds/6goJT2aogkbN/npLX/rk39G5hgjCI6rwRPlXj69deA+/CIlptX
 jBcxoD+yTIicOZXd0g+eFeoBMdLus38TVw2QoRLLjEK+gvr4DTevOoihyILHrfmsjcU6
 /ZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779683275; x=1780288075;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98hG2LjurcoyBDog7AEq9lxKP6OiJbF4+snXfpW3dqU=;
 b=rsLL5wfeYL44ARqp19zgGuLXoK0LyHr4VIdNqZRA+pGAQPbAAA4e59S9pcDsXMIXwA
 M25eLM7jQ7SQ7HmtsKbpYy7kucBazON2wjbanhZwviEUrDSW/xoMv5PJq2gbbK49Eee4
 Xxg3z4Ch6wBU1F7LWPfAuRLNjXfE5hqwhyiZMACsM+mQjDINircGah9moJ6HBTjvyrGO
 cbP7O5rVL5EmudjKldT+Q53DiM+Zbi/ItKSLamdGlI43Z1vG5dJ44pTC3fkaT7pOrl6A
 VOAy0Q0Tg2I14S68EPruW6nBDap5pc5Ob0Gk0trl5hy2MUap6g6YUswsd7z8eKLigLXa
 KtVA==
X-Gm-Message-State: AOJu0YzjP4i78AbjYj3CPp1Vo77kUscJ2gInUW4OdTBcwOb1Bl2Jf3N8
 s837RiaJjOVBShyD7PkIXAA3m5bRbhmG6eesZHSIm/T53X4TFW0HLV2+
X-Gm-Gg: Acq92OFmJtI/U4vbN6CoYojJMKD9M+pUrDukf1cM9vJ1Hk1B+piMEZ1rr55pgqcxeyA
 Wp+NdkEopQeasG3ZAvLnA1QpeFk0LirzmpnwxEQSuU55/9ZSpJXYorQHdxWfY+1Nqsy1ghzo59r
 tHhQH2MV3OKIq4XDV/O+fbvBzvz62ZdBlpaBncyyloenKXClnKdukJUA1K75qM22FutbnwxuPag
 jEhRJSBUGgN3azzeqzxxWWs0UcKA13rdgzAlNz0HWlXFWWV633/7KRNRDUi8kV/vU7ZatvHKNfJ
 spJVIvzOz5UVQdPfaWV2CtFeTiSp0cLtB65mp2j2WM1aj3xTTWjUdEzDfBEUEy/LiD3lHfc4nFx
 0Urtw4ztDefaFcKblYBgJhdIv0cDIke9ye32s/2qki7VnuiPf51qNeOMuzoeTPi4Xk6jQh3B4+Q
 yE16NdeFg2UPMhwu4kN7RJLhjYkYUzKFIVdakFLXvZf3r+Yv8CqCIf0/zvuwU=
X-Received: by 2002:a05:7301:2a24:b0:2de:aafb:feff with SMTP id
 5a478bee46e88-3044904e1dbmr5611825eec.2.1779683275243; 
 Sun, 24 May 2026 21:27:55 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045223103bsm6733914eec.16.2026.05.24.21.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 21:27:54 -0700 (PDT)
Date: Mon, 25 May 2026 12:27:51 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, qemu-stable@nongnu.org
Subject: Re: [PATCH] target/riscv/cpu_helper.c: allow LOAD_ADDR_MIS promotion
 to AMO fault
Message-ID: <ahPPun_mYalcBmhF@ChaodeMacBook-Pro.local>
References: <20260522181353.429782-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522181353.429782-1-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 22, 2026 at 03:13:53PM +0800, Daniel Henrique Barboza wrote:
> promote_load_fault() is missing the promotion of misaligned AMO load
> addresses, i.e. RISCV_EXCP_LOAD_ADDR_MIS should be promoted to
> RISCV_EXCP_STORE_AMO_ADDR_MIS when RISCV_UW2_ALWAYS_STORE_AMO (i.e.
> always_storeamo is true).
> 
> All other load AMO faults are already being covered.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 98f21c30f5 ("target/riscv: AMO operations always raise store/AMO fault")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3503
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>


> ---
>  target/riscv/cpu_helper.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 17305e1bb7..aa4cbfcf40 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -2174,6 +2174,9 @@ static target_ulong promote_load_fault(target_ulong orig_cause)
>  
>      case RISCV_EXCP_LOAD_PAGE_FAULT:
>          return RISCV_EXCP_STORE_PAGE_FAULT;
> +
> +    case RISCV_EXCP_LOAD_ADDR_MIS:
> +        return RISCV_EXCP_STORE_AMO_ADDR_MIS;
>      }
>  
>      /* if no promotion, return original cause */
> -- 
> 2.43.0
> 

