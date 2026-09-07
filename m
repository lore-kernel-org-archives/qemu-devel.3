Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39375C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 02:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3P5D-0007ef-Ra; Sun, 06 Sep 2026 22:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x3P5C-0007eN-MX
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 22:27:42 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x3P5A-0007Br-DR
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 22:27:42 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-85b293528a9so35422217b3.1
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 19:27:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788748059; cv=none;
 d=google.com; s=arc-20260327;
 b=f5ol+gNLtxoKBeMWs6p1T4fopG/u5+XdeqSAkIY1uBzHbMczA2yaLtQ06XWaU50dqB
 lGyUT/yDvlv8CNJinrmAwD+8JIfYISXEPIC0YyRTE6f70k7maog1GAs91UQIVi/d5diQ
 0Iy/OCXCBTP+c3jMIWPdTxv0zXWFx6uHfQMszK5GeVO585eUvZ1y5tP6YtgxVedZO/XQ
 ieHyJuQVroIBwcGmW7F+QfTLsuUuV7s1tRLzjXXeP/cPCoORxQW3M4DRnVcQ2XQCuAlp
 dXgqywburCNTrRO99qw39zEE7LjHtY2VoQFYhzTGQEOVMH0vSPDWufctA2zibOvfWiYH
 Nmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Fmo+ecuEKQm+N37XLc/59ti0srpTndziRJEkJ+jpT3w=;
 fh=TaV04S92YTMBZqlQk5mgBoy046eIOdCT4qpsyQnPa0w=;
 b=e4ODBfLqlRTj3a2SZH5dc+5ux+tNH1Ib2D20LnrwUNEq0ASP1PtZfuttFjfPxY3Gbk
 xikcMEUU1BMx8GpSmtK6x0RtuysgQt/Ua/s8QHINIwrqLjvmrF4Wfe5ZP+/wShhWWBBg
 gspaeXa2pxiJT2ESp0z/svRiYUXEqJVlkQZv/5Yo6ILUs3W9qHegTmkVdiVRSC9gh9zW
 cNWd1wy0b7XVUtRRJVj8gMaH1hWBZncOg00gMEX6ZPmAJx37WyzX6fP27961VV3mzgi3
 /3+w2oLgVZlWqjAWiWOsZk8jIvg0j0x48QMGhs9IB5wo/FUej/qmzgXNy2uKdNzdeu0i
 AOLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1788748059; x=1789352859; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Fmo+ecuEKQm+N37XLc/59ti0srpTndziRJEkJ+jpT3w=;
 b=Nx1kW60kZbuNIVQmeRqzFWGNC3o6e1FQpSVIPgE8KjfeAT7FQ5ia2cBzgiLd1vGMQI
 j53IouVxPif6wVhXmj2w+l0X+eBWE3Zbv2qpF046gcQ0ptL/+ohfMsqKRwmTv+2VkWMg
 9DkkLFang8CSsqYf73cJAnT0JH5jhoUABnsxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788748059; x=1789352859;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Fmo+ecuEKQm+N37XLc/59ti0srpTndziRJEkJ+jpT3w=;
 b=aOC4yzEeL1N27dbl92Dp1pYBNRJDZyYL6nNty/AkF9qzgb0QAfNUpGgjDZWB07GwIE
 Wsr9Utj9jI7s/+QWMpeq8EOxuY1fM/ybYtBlZjfAULzT8ma9vHZvMwbfgpkv88hzPZRX
 HkvOasNjOx91aPGmTWksYK6YXSxkI0um1GdHe5A9/9H7+ffs0OEePQpOLB0C9UMjjWBa
 r+xrQTZ3xssyZJKXxyqm+V1tk/t+oRdltvrgjuhIb+9E30c1rWynIxQg+dvsP7OHJQwM
 cS851CsZPkQtaapctxCCspfH5PpYFZn78VrjTGP/aVO3S09PdlvTwUK1oPaTOzl+Ce5A
 dDrw==
X-Gm-Message-State: AFuF++nAZDX96p3GThOrs0Bj63SNfNBaY9BQDiP6uY6LTewwBCQ0/c2r
 2w+y0DYe7eynkxlZDqIA6w+St0wPng8c4Gqkp70BvtasZsvUCBph14vpc5Tfb4nMQbDIy8I9LEZ
 bT17Yuy1FFR3Lesb3WicY7t9si8wCM1A=
X-Gm-Gg: AYBFou0JOy1tblB6zbCQqG1JzzuH6nIzO+3bsV5NXArFsb3d0ZlmimvWhn7u9AljeFn
 6WZ/YKSMhiAceKGOQUHZci1vKl1LNdgKtfl3C9h7tebkZlcZCzVBZZafwc1UeBTeTFHfs442/+8
 G/IaW0l1Fgdgu5VqKb7D/JKaLVUrxJF61vrIGHD1T7KEl1B2SXMk9nMSBzseFroe5gVilnDoe3s
 whZKe9sKrCVrlhQ1YyZ5e6OTVfxWRdcW1xPyDZ/DC6RtVHFK779QN4G1maxH1nHiA4fH58iQtxU
 iJP1yb0BlaTOFs1l+4EVIyj9jIoID23yjfADx49Mip0tIc/B6E5T81GvcLVyFoWwggVS6Y8s/4U
 euwSDvMin2BR8+agZnEEp8uBywiIJo9qnQUMDn0wHothW8PSBYPnIqwR7vSmwpmH1pMMZqGhWUp
 SJSy90BqPJlGoao+/81ANbbS3A9aI=
X-Received: by 2002:a53:d012:0:b0:66a:b15e:bb93 with SMTP id
 956f58d0204a3-66fb6d605fdmr2544848d50.13.1788748059166; Sun, 06 Sep 2026
 19:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260831133000.982059-1-liumingliang.dev@bytedance.com>
 <20260831133000.982059-4-liumingliang.dev@bytedance.com>
In-Reply-To: <20260831133000.982059-4-liumingliang.dev@bytedance.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 7 Sep 2026 11:57:28 +0930
X-Gm-Features: AcwNN1WfmvzMZ69dvtEJC7ehjUvqaRiP4ezxDBKui0LJoE-ot9q9IAqmOLnmySA
Message-ID: <CACPK8Xc4u-79Tcga3tw3PKj9g3Om79evM1qK38d9pfbVi9kzeg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tests/tcg/riscv64: Add tests for Zvabd extension
To: Mingliang Liu <liumingliang.dev@bytedance.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, chao.liu@processmission.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 31 Aug 2026 at 23:00, Mingliang Liu
<liumingliang.dev@bytedance.com> wrote:
>
> Co-Auther: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Typo: Co-Author

This should include a Signed-off-by from Daniel as well.

Mention in the commit message that the assembler doesn't support the
opcodes yet so instructions are hardcoded for the time being.

Also worth mentioning that binutils/gas 2.47 has the 0.7 opcodes(!),
so the test should never be built with that version, even once support
is changed over to use the mnemonics.

https://github.com/gnutools/binutils-gdb/commit/d3b84dac949ac10f8736c85253b4a1073d244ac1

> Signed-off-by: Mingliang Liu <liumingliang.dev@bytedance.com>
> ---
>  tests/tcg/riscv64/Makefile.softmmu-target |   8 +
>  tests/tcg/riscv64/test-zvabd.S            | 659 ++++++++++++++++++++++
>  2 files changed, 667 insertions(+)
>  create mode 100644 tests/tcg/riscv64/test-zvabd.S
>
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> index 6a219c306c..787fdaab40 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -71,5 +71,13 @@ EXTRA_RUNS += run-test-misa-w
>  run-test-misa-w: test-misa-w
>         $(call run-test, $<, $(QEMU) -cpu rv64$(comma)x-misa-w=true$(comma)c=true$(comma)v=true $(QEMU_OPTS)$<)
>
> +EXTRA_RUNS += run-test-zvabd
> +ZVABD_CPU = rv64$(comma)v=true$(comma)vlen=256$(comma)x-zvabd=true
> +CLEANFILES += test-zvabd
> +test-zvabd: test-zvabd.o $(LINK_SCRIPT)
> +       $(LD) $(LDFLAGS) $< -o $@
> +run-test-zvabd: test-zvabd
> +       $(call run-test, $<, $(QEMU) -cpu $(ZVABD_CPU) $(QEMU_OPTS)$<)
> +
>  # We don't currently support the multiarch system tests
>  undefine MULTIARCH_TESTS
> diff --git a/tests/tcg/riscv64/test-zvabd.S b/tests/tcg/riscv64/test-zvabd.S
> new file mode 100644
> index 0000000000..01db2fd7dc
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-zvabd.S
> @@ -0,0 +1,659 @@
> +/*
> + * Test the Zvabd vector absolute-difference instructions and the vabs.v
> + * pseudoinstruction.
> + *

> +test_vabs_v:
> +       vsetivli zero, 2, e8, m1, ta, ma
> +
> +       /* Load .arr_neg array in v1 */
> +       la     t0,.arr_neg
> +       vle8.v v1,0(t0)
> +
> +       /* vabs.v v2, v1 (vabd.vx v2, v1, x0) raw opcode */
> +       .word   0x56106157

Palmer mentioned using .insn instead of .word. It is a little bit
easier to check than the raw .word:

.insn r 0x57, 0x6, 0x2b, x2, x0, x1

I don't have a strong opinion either way.

