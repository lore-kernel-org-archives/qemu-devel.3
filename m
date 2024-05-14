Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45314C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 14:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6smj-0003a3-O2; Tue, 14 May 2024 10:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6smi-0003Zu-JQ
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:05:40 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6smW-0005W4-77
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:05:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4968D61286;
 Tue, 14 May 2024 14:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D2EC4AF09;
 Tue, 14 May 2024 14:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715695524;
 bh=5XOSmHbe75ciM3OBtjNAl6s2LeV79qvu7V5jR2L5pq4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U6m0L1Sin6iqzj1hDsxLbOki5Q/yInhnWFyi2dwEa/PWeOU+flv5SGuYDEkMDpYuU
 E7B26JjeZLk79C++Ackownqrsraxawb7V+PNE6cgrX/F5ef93KqKHd+IyO+NdUjYSv
 /s7x5mOb31nVY7aliTR5aW3SoAWj2gnhscD4fds2r6FzqzswfDXkS3dHjciYhO1s5C
 EFFZ4JrE2eoLR0JwsJlBsDKdIx8t684thl0rbWRPeUdKuM+4OMVlvtM4WCpsB41/wk
 tF1Lt+gb//ez/PeQZ2cA3nK80CdyG+pOKmJTiGjGLd7xuFNJuct210jPma35IrrA9Z
 bgmJ7Gf3XbjxQ==
Date: Tue, 14 May 2024 16:05:19 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 02/45] target/hppa: Use hppa_form_gva_psw in
 hppa_cpu_get_pc
Message-ID: <ZkNvn_Y1OfPKs1GW@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-3-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

* Richard Henderson <richard.henderson@linaro.org>:
> This function is for log_pc(), which needs to produce a
> similar result to cpu_get_tb_cpu_state().
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Helge Deller <deller@gmx.de>

---
> ---
>  target/hppa/cpu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 582036b31e..be8c558014 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -38,9 +38,10 @@ static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
>  
>  static vaddr hppa_cpu_get_pc(CPUState *cs)
>  {
> -    HPPACPU *cpu = HPPA_CPU(cs);
> +    CPUHPPAState *env = cpu_env(cs);
>  
> -    return cpu->env.iaoq_f;
> +    return hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
> +                             env->iaoq_f & -4);
>  }
>  
>  void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
> @@ -61,8 +62,7 @@ void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
>      flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
>      flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
>  
> -    *pc = hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
> -                            env->iaoq_f & -4);
> +    *pc = hppa_cpu_get_pc(env_cpu(env));
>      *cs_base = env->iasq_f;
>  
>      /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
> -- 
> 2.34.1
> 

