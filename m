Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6E5C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcCg-0007sO-Ie; Tue, 19 Mar 2024 12:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rmcCa-0007l2-KK
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:20:37 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rmcCX-0004eY-Rq
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vTLKPQodINha7qU6s4RHVgSXzVej7Nq1XctXBLvVonM=; b=xCGid3y2rHVcXjVmCkIRWGjYXP
 pxZUlHXLcw+c/uuHrNzmD5UQ0Yr4Fk2vil0XtqmPg7sYcdRz7mFGmIA99pK3TidKs1dJwIUtGRWqR
 uGfy0NCyFTG4Kd6pmNywaDqpaLG+9dRitIkUKkfnV7QBJYg/k7N5CH6Z9lrLVv5dwI7w=;
Date: Tue, 19 Mar 2024 17:21:22 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Alistair Francis <alistair@alistair23.me>
Subject: Re: [RFC PATCH-for-9.1 8/8] target/microblaze: Widen $ear to 64-bit
Message-ID: <rbczkcp7whvovj55htcvongsc45xyhia5sgckqunszldag3iey@4vsbsjak4wr2>
References: <20240319062855.8025-1-philmd@linaro.org>
 <20240319062855.8025-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319062855.8025-9-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 19/03/24, Philippe Mathieu-Daudé wrote:
> The Exception Address Register is 64-bit wide.
> User emulation only access the 32 lower bits.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/microblaze/cpu.h       | 2 +-
>  linux-user/elfload.c          | 2 +-
>  target/microblaze/gdbstub.c   | 2 +-
>  target/microblaze/translate.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index c3e2aba0ec..a9f93b37b7 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -251,7 +251,7 @@ struct CPUArchState {
>      uint32_t pc;
>      uint32_t msr;    /* All bits of MSR except MSR[C] and MSR[CC] */
>      uint32_t msr_c;  /* MSR[C], in low bit; other bits must be 0 */
> -    target_ulong ear;
> +    uint64_t ear;
>      uint32_t esr;
>      uint32_t fsr;
>      uint32_t btr;
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 60cf55b36c..4612aef95a 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1498,7 +1498,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
>      (*regs)[pos++] = tswapreg(env->pc);
>      (*regs)[pos++] = tswapreg(mb_cpu_read_msr(env));
>      (*regs)[pos++] = 0;
> -    (*regs)[pos++] = tswapreg(env->ear);
> +    (*regs)[pos++] = tswapreg((uint32_t)env->ear);
As far as I can tell env->ear is never written to from TCG so we 
shouldn't have any problems w. endian mismatch between guest/host,
right?

Anyway,

Reviewed-by: Anton Johansson <anjo@rev.ng>

