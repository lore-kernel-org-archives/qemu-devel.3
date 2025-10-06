Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33696CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 11:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5jDt-0007en-6M; Mon, 06 Oct 2025 07:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v5jDr-0007eP-LO
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 07:17:43 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v5jDp-0007Eq-Ph
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 07:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=khAOIaauBeR+O3jbynXg1dh4aA0ZuZPaE9PZVgRHy+Q=; b=GKqAkkqgwmUmXxv
 n7mrWkrYL01L5N4gK/1K56kDx50bGFNGTSfhmM/bS8NbUODquXb3AGow1a8EOBUi1OYlT7Dg+iTYb
 h/Xbmj5kBa246P2+j12kqxksUuIinNU8UptZWedTkv1c5wTArQmssrIfwW7bwKQQTyDwFqSLsJmx5
 5I=;
Date: Mon, 6 Oct 2025 13:20:18 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] target/alpha: Replace VMSTATE_UINTTL() ->
 VMSTATE_UINT64()
Message-ID: <3okrfvyb22ozfxfywb6uusgyblkvmpte62ueqqojxfbjhosazi@r2gbatph5zzu>
References: <20250925005137.59378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925005137.59378-1-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/09/25, Philippe Mathieu-Daudé wrote:
> All these CPUAlphaState fields are of uint64_t type (except
> the @fir[] array which uses float64, expanded to the same
> type definition). Use the appropriate VMSTATE_UINT64() macro.
> 
> There is no functional change (the migration stream is not
> modified), because the Alpha targets are only built as 64-bit:
> 
>   $ git grep TARGET_LONG_BITS configs/targets/alpha*
>   configs/targets/alpha-linux-user.mak:4:TARGET_LONG_BITS=64
>   configs/targets/alpha-softmmu.mak:2:TARGET_LONG_BITS=64
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v2: "target is" -> "targets are"
> ---
>  target/alpha/machine.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/target/alpha/machine.c b/target/alpha/machine.c
> index 5f302b166da..6828b123ca1 100644
> --- a/target/alpha/machine.c
> +++ b/target/alpha/machine.c
> @@ -25,8 +25,8 @@ static const VMStateInfo vmstate_fpcr = {
>  };
>  
>  static const VMStateField vmstate_env_fields[] = {
> -    VMSTATE_UINTTL_ARRAY(ir, CPUAlphaState, 31),
> -    VMSTATE_UINTTL_ARRAY(fir, CPUAlphaState, 31),
> +    VMSTATE_UINT64_ARRAY(ir, CPUAlphaState, 31),
> +    VMSTATE_UINT64_ARRAY(fir, CPUAlphaState, 31),
>      /* Save the architecture value of the fpcr, not the internally
>         expanded version.  Since this architecture value does not
>         exist in memory to be stored, this requires a but of hoop
> @@ -41,27 +41,27 @@ static const VMStateField vmstate_env_fields[] = {
>          .flags = VMS_SINGLE,
>          .offset = 0
>      },
> -    VMSTATE_UINTTL(pc, CPUAlphaState),
> -    VMSTATE_UINTTL(unique, CPUAlphaState),
> -    VMSTATE_UINTTL(lock_addr, CPUAlphaState),
> -    VMSTATE_UINTTL(lock_value, CPUAlphaState),
> +    VMSTATE_UINT64(pc, CPUAlphaState),
> +    VMSTATE_UINT64(unique, CPUAlphaState),
> +    VMSTATE_UINT64(lock_addr, CPUAlphaState),
> +    VMSTATE_UINT64(lock_value, CPUAlphaState),
>  
>      VMSTATE_UINT32(flags, CPUAlphaState),
>      VMSTATE_UINT32(pcc_ofs, CPUAlphaState),
>  
> -    VMSTATE_UINTTL(trap_arg0, CPUAlphaState),
> -    VMSTATE_UINTTL(trap_arg1, CPUAlphaState),
> -    VMSTATE_UINTTL(trap_arg2, CPUAlphaState),
> +    VMSTATE_UINT64(trap_arg0, CPUAlphaState),
> +    VMSTATE_UINT64(trap_arg1, CPUAlphaState),
> +    VMSTATE_UINT64(trap_arg2, CPUAlphaState),
>  
> -    VMSTATE_UINTTL(exc_addr, CPUAlphaState),
> -    VMSTATE_UINTTL(palbr, CPUAlphaState),
> -    VMSTATE_UINTTL(ptbr, CPUAlphaState),
> -    VMSTATE_UINTTL(vptptr, CPUAlphaState),
> -    VMSTATE_UINTTL(sysval, CPUAlphaState),
> -    VMSTATE_UINTTL(usp, CPUAlphaState),
> +    VMSTATE_UINT64(exc_addr, CPUAlphaState),
> +    VMSTATE_UINT64(palbr, CPUAlphaState),
> +    VMSTATE_UINT64(ptbr, CPUAlphaState),
> +    VMSTATE_UINT64(vptptr, CPUAlphaState),
> +    VMSTATE_UINT64(sysval, CPUAlphaState),
> +    VMSTATE_UINT64(usp, CPUAlphaState),
>  
> -    VMSTATE_UINTTL_ARRAY(shadow, CPUAlphaState, 8),
> -    VMSTATE_UINTTL_ARRAY(scratch, CPUAlphaState, 24),
> +    VMSTATE_UINT64_ARRAY(shadow, CPUAlphaState, 8),
> +    VMSTATE_UINT64_ARRAY(scratch, CPUAlphaState, 24),
>  
>      VMSTATE_END_OF_LIST()
>  };
> -- 
> 2.51.0
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

