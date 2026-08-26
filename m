Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E786C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzEdu-0001iB-8G; Wed, 26 Aug 2026 10:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wzEds-0001eP-4g
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:30:16 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wzEdq-0002aw-6q
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787754614; x=1819290614;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/rbOGo0opVXre6UGFrrWYOWFNaGqlbi9zRLyrA3iEjw=;
 b=U30UwfawgSmiwxYUSmInvsaGUnT55m9uY2YstrUi2VGKRkML0JxGc+x+
 sD74RD+p0Ay8DfyrgKKugD1EUUbonsmUmtXQsy699kFR1xoOj9G0NpsDI
 RZywrpsVCt8pP4IAJ76lMz6yn965pbgJx23fh4NpzK/4rNm2v0Bq/aV9b
 Vh3jRaSw8rbkEC42nLjqhLO7a9TbD0PaANDLjpICEJWjL6RZ/b3mJo2Ow
 67qYyIgjQJS6EfosAjDYIe1ypSjaDhMAAjAwrXZvLFnXlqunTgj/Rr/3j
 XqK6QWLekPha2pkcNDZ05CUdPCuU9MH2Lyjpjq+KzSbXsXmMHyNjO3QXf g==;
X-CSE-ConnectionGUID: 98s2WDCqQDiuu8fL1mdV+Q==
X-CSE-MsgGUID: kO4JQA/eQNKqs9CsPdOviQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99397490"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="99397490"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 07:30:11 -0700
X-CSE-ConnectionGUID: hWA3AJIGSSe2xXQ1hJI0qQ==
X-CSE-MsgGUID: KMb+pDijS4i8LfhpUSh4wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="291115005"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa002.fm.intel.com with ESMTP; 26 Aug 2026 07:30:09 -0700
Date: Wed, 26 Aug 2026 22:30:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 10/20] target/i386/tcg: implement JMPABS instruction
Message-ID: <ao74cFO91SLv9WVB@intel.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
 <20260825122921.431739-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825122921.431739-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 25, 2026 at 02:29:11PM +0200, Paolo Bonzini wrote:
> Date: Tue, 25 Aug 2026 14:29:11 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 10/20] target/i386/tcg: implement JMPABS instruction
> X-Mailer: git-send-email 2.55.0
> 
> This is the same as an indirect jump, just with immediate operand.
> The requirement of W=0 and 0x67 are already available in the decoder.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/tcg/decode-new.h     | 3 +++
>  target/i386/tcg/decode-new.c.inc | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
> index c974ca9d7c5..4998712e86d 100644
> --- a/target/i386/tcg/decode-new.h
> +++ b/target/i386/tcg/decode-new.h
> @@ -184,6 +184,9 @@ typedef enum X86InsnCheck {
>  
>      /* No REX2 prefix allowed */
>      X86_CHECK_no_rex2 = 8192,
> +
> +    /* No 0x67 prefix allowed */
> +    X86_CHECK_no_adr = 16384,
>  } X86InsnCheck;
>  
>  typedef enum X86InsnSpecial {
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index 1f59fd665f7..d215d28cec5 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -1991,6 +1991,7 @@ static const X86OpEntry opcodes_root[256] = {
>  
>  #ifdef TARGET_X86_64
>  static const X86OpEntry opcodes_rex2_map0_A0toAF[16] = {
> +    [1] = X86_OP_ENTRY1(JMP_m,   I,q, p_00 chk2(W0, no_adr)),
>  };

Maybe it should use X86_OP_ENTRYr? since JMPABS doesn't need to write
back.

Just a simple test:

#include <stdio.h>

int main(void)
{
    __asm__ volatile (
        /* JMPABS: REX2(M0=0,W=0) = D5 00, opcode A1, then imm64 target */
        ".byte 0xd5, 0x00, 0xa1\n\t"
        ".quad  1f\n\t"
        "ud2\n\t"          /* this should be skipped */
        "1:\n\t");
    puts("JMPABS -- OK");
    return 0;
}

And this hits an abort():

$ ./build/qemu-x86_64 /tmp/jmpabs
**
ERROR:../target/i386/tcg/emit.c.inc:380:gen_writeback: code should not be reached
Bail out! ERROR:../target/i386/tcg/emit.c.inc:380:gen_writeback: code should not be reached
Aborted (core dumped)

more GDB backtrace:

Thread 1 "qemu-x86_64" received signal SIGABRT, Aborted.
__pthread_kill_implementation (no_tid=0, signo=6, threadid=140737352460800) at ./nptl/pthread_kill.c:44
44      ./nptl/pthread_kill.c: No such file or directory.
#0  __pthread_kill_implementation (no_tid=0, signo=6, threadid=140737352460800) at ./nptl/pthread_kill.c:44
#1  __pthread_kill_internal (signo=6, threadid=140737352460800) at ./nptl/pthread_kill.c:78
#2  __GI___pthread_kill (threadid=140737352460800, signo=signo@entry=6) at ./nptl/pthread_kill.c:89
#3  0x00007ffff7242476 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
#4  0x00007ffff72287f3 in __GI_abort () at ./stdlib/abort.c:79
#5  0x00007ffff76e3b57 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#6  0x00007ffff773d70f in g_assertion_message_expr () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#7  0x0000555555664f37 in gen_writeback (s=s@entry=0x7fffffffd240, decode=decode@entry=0x7fffffffd0b0, opn=opn@entry=0, v=<optimized out>) at ../target/i386/tcg/emit.c.inc:380
#8  0x0000555555677778 in disas_insn (cpu=0x55555593e780, s=0x7fffffffd240) at ../target/i386/tcg/decode-new.c.inc:3682
#9  i386_tr_translate_insn (dcbase=0x7fffffffd240, cpu=0x55555593e780) at ../target/i386/tcg/translate.c:3608
#10 0x00005555555d7962 in translator_loop (cpu=0x55555593e780, tb=0x7fffe80d0700 <code_gen_buffer+853715>, max_insns=0x7fffffffd4cc, pc=<optimized out>, host_pc=<optimized out>, ops=ops@entry=0x5555557dc5a0 <i386_tr_ops>, db=0x7fffffffd240, addr_type=TCG_TYPE_I64) at ../accel/tcg/translator.c:178
#11 0x000055555567b212 in x86_translate_code (cpu=<optimized out>, tb=<optimized out>, max_insns=<optimized out>, pc=<optimized out>, host_pc=<optimized out>) at ../target/i386/tcg/translate.c:3699
#12 0x00005555555d6644 in setjmp_gen_code (env=env@entry=0x5555559427f0, tb=tb@entry=0x7fffe80d0700 <code_gen_buffer+853715>, pc=pc@entry=4198710, host_pc=0x401136, max_insns=max_insns@entry=0x7fffffffd4cc, ti=<optimized out>) at ../accel/tcg/translate-all.c:251
#13 0x00005555555d6b0e in tb_gen_code (cpu=cpu@entry=0x55555593e780, s=...) at ../accel/tcg/translate-all.c:324
#14 0x00005555555cec1a in cpu_exec_loop (cpu=cpu@entry=0x55555593e780, sc=<optimized out>) at ../accel/tcg/cpu-exec.c:973
#15 0x00005555555ced99 in cpu_exec_setjmp (cpu=cpu@entry=0x55555593e780, sc=<optimized out>) at ../accel/tcg/cpu-exec.c:1019
#16 0x00005555555cf381 in cpu_exec (cpu=cpu@entry=0x55555593e780) at ../accel/tcg/cpu-exec.c:1045
#17 0x0000555555622c80 in cpu_loop (env=env@entry=0x5555559427f0) at ../linux-user/x86_64/../i386/cpu_loop.c:217
#18 0x00005555555a1d17 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at ../linux-user/main.c:1010

Regards,
Zhao


