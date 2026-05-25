Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B243CD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRMvT-0007Md-K6; Mon, 25 May 2026 00:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wRMvR-0007Ke-9J
 for qemu-devel@nongnu.org; Mon, 25 May 2026 00:28:25 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wRMvP-0007Cl-GX
 for qemu-devel@nongnu.org; Mon, 25 May 2026 00:28:25 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-30455f77e0eso4631796eec.0
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 21:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779683302; x=1780288102; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=33J20/6r07FKIZokb7U4QqRC2bN29qsLA+s5n3cTmBY=;
 b=ofVzv/BgUh5j+hxpSXJFN4CCklLfCpr1dIx/8aoAH2QwcP+wwiywLZ7FJUF2JmTWP2
 gdv53m2vRloeoE7n25U8A7Hgf953Wh5/qnzQS4YI7xx9PeMszFl6hcP6rwrOO632mvln
 ThZ4PXNZopvsK/ea9WMNjYZF1Trz/plkyGb+W9g7bkHjHhnKFkgNXf32RcUmL674ySMP
 mgK1fEIk8YWe4aDEuM2TFeJgJNAl8FN4G0rLIRcwnVCcZr3ew5aJBlUxjnLUGw0s1KQX
 l7i0T+b5ShCGD6Lwpi6wBGQEixnPiEtgQaFwVVkERVKl59qxG1bEJDn+0cGm6dzn+eIe
 83GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779683302; x=1780288102;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33J20/6r07FKIZokb7U4QqRC2bN29qsLA+s5n3cTmBY=;
 b=IdeUZhTThHqzGvAjKYlL/myvJzeXUgw79ypiz48IHd10tE4y/PDy30Strr2d2MF2+z
 LqVBvoX0T4LtVQBdhmVBDYcygTTuHJr4tjcjqntMAdq51ed1NnsbW2fNYnr3cqyluJF6
 XZ9I0PaRah76eNzuROY3WYBcm+UbWEgpIZ+WaQjluoTMlwCU9z0yySsfB5tn+8Rbe8/j
 f6xtCebg7OPHfB7F1YqLwcZK0ZZbIhPPtFyb97kJ1ml3sDXvUyB6DoeKUn9Ds9TKTIKK
 9arXAUQR3ohgV2j8ILVbAJcFmmguE1A1OLiW5L4rC9EoMj0I3cdDoOrrw/Y3tmBD9qjl
 t5rQ==
X-Gm-Message-State: AOJu0YyWKVsJv+cnLii+XSZwFWsU9PhAQfnjWVo/IfreZDubWD6oKntX
 BalU2uz9BrG38ON0AG+dcxvlGSXGOSV6FScAzHbjXq7dFt2NWy2gvzHE
X-Gm-Gg: Acq92OHJCZH4Mag9jJ0MF4VeVQkwP0fex1dC72tnZmA5ggF3f1XaaPB3hhelOkWJLr1
 yABnf6OJ8plBP0Zixn/eQefn8v9XQrXeXEdVvEbVP180Ul8IorpAgTtxZItudSo8Q7hcSxZgTnw
 KqP+KuAykdH1cpmzWwYsC8QRLd+/IvrnI0xr6YtfbaoGhZeB5tr8uzqcvCnUbu8s9BnogCKPttc
 2jfPUQ+fAJJ0GbJbrqXPzAoXAmHyj4V3uTf+zqF2urQNNPiYryca/leuFJfIy3rEsi0UYnTAKBA
 P2MOYrf4qxAHcWmKzgmxaf62mbp6gLGdHuyhE4b40N4xgqoi31k8YJLs9y8H1J6eHk0y3bgf8wl
 gwrXNwQxV2B8k3ymTzP+GF17CKHAnbBCWom7JWcfc02fMyUu7vpDugcjthooslTKYaH4X7AC1Ib
 56BotzMG7zxATZkwA2+g2AFKQ6gff1T+dafYqrEJPLN+FQg2UZxqTDxno6bq41OW+Fa0C4HQ==
X-Received: by 2002:a05:7300:e424:b0:304:819f:502b with SMTP id
 5a478bee46e88-304819f518emr1407113eec.9.1779683301892; 
 Sun, 24 May 2026 21:28:21 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef4af0sm6875913eec.3.2026.05.24.21.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 21:28:21 -0700 (PDT)
Date: Mon, 25 May 2026 12:28:17 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Zephyr Li <fritchleybohrer@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 daniel.barboza@oss.qualcomm.com
Subject: Re: [PATCH v2] target/riscv: Reject Svinval instructions in U-mode
Message-ID: <ahPP11q8WEK9_vI5@ChaodeMacBook-Pro.local>
References: <20260522033145.17850-1-fritchleybohrer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522033145.17850-1-fritchleybohrer@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
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

On Fri, May 22, 2026 at 11:31:44AM +0800, Zephyr Li wrote:
> The RISC-V privileged specification requires SFENCE.W.INVAL and
> SFENCE.INVAL.IR to raise an illegal instruction exception when executed
> in U-mode. Check the current privilege mode during translation and reject these
> instructions in U-mode, so they are reported as illegal instructions.
> 
> Add a helper to reject these instructions in U-mode during translation.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3493
> 
> Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> 
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  target/riscv/insn_trans/trans_svinval.c.inc | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/insn_trans/trans_svinval.c.inc
> index a06c3b214f..4614c1489c 100644
> --- a/target/riscv/insn_trans/trans_svinval.c.inc
> +++ b/target/riscv/insn_trans/trans_svinval.c.inc
> @@ -22,11 +22,19 @@
>      }                                      \
>  } while (0)
>  
> +/* Test if priv level is M or S. */
> +#define REQUIRE_PRIV_MS(ctx) do {          \
> +    if (ctx->priv == PRV_U) {              \
> +        return false;                      \
> +    }                                      \
> +} while (0)
> +
>  static bool trans_sinval_vma(DisasContext *ctx, arg_sinval_vma *a)
>  {
>      REQUIRE_SVINVAL(ctx);
>      /* Do the same as sfence.vma currently */
>      REQUIRE_EXT(ctx, RVS);
> +    REQUIRE_PRIV_MS(ctx);
>  #ifndef CONFIG_USER_ONLY
>      decode_save_opc(ctx, 0);
>      gen_helper_tlb_flush(tcg_env);
> @@ -39,6 +47,7 @@ static bool trans_sfence_w_inval(DisasContext *ctx, arg_sfence_w_inval *a)
>  {
>      REQUIRE_SVINVAL(ctx);
>      REQUIRE_EXT(ctx, RVS);
> +    REQUIRE_PRIV_MS(ctx);
>      /* Do nothing currently */
>      return true;
>  }
> @@ -47,6 +56,7 @@ static bool trans_sfence_inval_ir(DisasContext *ctx, arg_sfence_inval_ir *a)
>  {
>      REQUIRE_SVINVAL(ctx);
>      REQUIRE_EXT(ctx, RVS);
> +    REQUIRE_PRIV_MS(ctx);
>      /* Do nothing currently */
>      return true;
>  }
> @@ -56,6 +66,7 @@ static bool trans_hinval_vvma(DisasContext *ctx, arg_hinval_vvma *a)
>      REQUIRE_SVINVAL(ctx);
>      /* Do the same as hfence.vvma currently */
>      REQUIRE_EXT(ctx, RVH);
> +    REQUIRE_PRIV_MS(ctx);
>  #ifndef CONFIG_USER_ONLY
>      decode_save_opc(ctx, 0);
>      gen_helper_hyp_tlb_flush(tcg_env);
> @@ -69,6 +80,7 @@ static bool trans_hinval_gvma(DisasContext *ctx, arg_hinval_gvma *a)
>      REQUIRE_SVINVAL(ctx);
>      /* Do the same as hfence.gvma currently */
>      REQUIRE_EXT(ctx, RVH);
> +    REQUIRE_PRIV_MS(ctx);
>  #ifndef CONFIG_USER_ONLY
>      decode_save_opc(ctx, 0);
>      gen_helper_hyp_gvma_tlb_flush(tcg_env);
> -- 
> 2.43.0
> 

