Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED0606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nongnu.org header.i=@nongnu.org header.a=rsa-sha256 header.s=lists1p-gnu-org header.b=CQ5zwCAb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=liyBGlOD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nongnu.org;
	 s=lists1p-gnu-org; h=From:In-Reply-To:MIME-Version:References:Subject:To:
	Date; bh=UeX8SnOllnOdDr9UCEyqkUkQd5UOG8RMpCIk+3lBRd4=; b=CQ5zwCAbDKJzwiIJ6bBt
	I7Lg0tfPEONPY7AoBzNURGTSfB0p/xSjoigMRUXHECMdW1X9mTagBzutGvG2ipziv2/SyrU5P4jWD
	8ff+akeMZnI9Z3XG9UYbWfGwqD6fTsDJEIc7OwqQ0l8diLlzOHVP0NNOryR3paqj0GbxVH2gb9/M9
	hJlBr9o4jca61AlIXlmv5q0HMH61FZWK+xdCRhzkUcAqR/AAXEAt7PNumrt+70NBPMyYanL6b2O/V
	0ujl5bqmgPgDBrODorhNzq1qkrbccBjmQ+sIqpb0csZqwgCaqXkyd69rwZwsqGRaIn4OMHosObvsN
	hu/1fBhu3u/kqw==;
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWtqL-0001wk-To; Fri, 27 Nov 2026 06:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWtqD-0001rZ-Sg; Fri, 27 Nov 2026 06:10:10 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWtqB-0000xq-WD; Fri, 27 Nov 2026 06:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=UeX8SnOllnOdDr9UCEyqkUkQd5UOG8RMpCIk+3lBRd4=; b=liyBGlODmZ8MVcY
 b6NgEdbPOZ7vWi7fQTav4LbbcX8sRuqHbcR5QmkH++8cYPWKDQG0V4EDThnFMhVkHT7o2ZUHPQVhr
 NYs0LJhD5s6WXYdrYAG5GAOJsKWymsbL4ANu3aojxjOr1EZWKukcCo2Kq4s+xnNYMYOMWOlmF/6tp
 sc=;
Date: Fri, 27 Nov 2026 12:16:31 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 11/24] target/m68k: Use 64-bit TB flags
Message-ID: <awlmfznytaH-SVpv@hive.localdomain>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
 <20261126233604.67722-12-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126233604.67722-12-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/11/26, Philippe Mathieu-Daudé wrote:
> TranslationBlock::flags and TCGTBCPUState::flags are now
> 64-bit, use matching types for the values derived from them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/m68k/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index f7d289e591a2..74ac2a177cd5 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -47,7 +47,7 @@ static vaddr m68k_cpu_get_pc(CPUState *cs)
>  static TCGTBCPUState m68k_get_tb_cpu_state(CPUState *cs)
>  {
>      CPUM68KState *env = cpu_env(cs);
> -    uint32_t flags;
> +    uint64_t flags;
>  
>      flags = (env->macsr >> 4) & TB_FLAGS_MACSR;
>      if (env->sr & SR_S) {
> -- 
> 2.55.0
> 
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

