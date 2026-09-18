Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9424AC982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7d2s-0002XY-GF; Fri, 18 Sep 2026 14:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x7d2S-0002Lq-5p
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 14:10:27 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x7d2O-0000hC-S4
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 14:10:18 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-85469a34908so1061853b3a.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1789755014; x=1790359814; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/Hfpy/x3gmRurkqv60Bg2/RIVF22wanQR3zYhofeKyo=;
 b=B4BnCvOTMP5kTv01wnoWSNYbaLa+JzAiuqsN/QyuuarqVzZ+TtGPr/uJ6uePPFMbKR
 PWFn9cE2bMz2+bCKXGvrQiXhPxdNjLkyWMb9h+EPsj25ieeLnI0wv8p/2mH+MVvWyLrK
 FUPbpLp3QF4F+XVB3JGQCTP3RMNlIFN4Dl0DkBhDkCWanKo236rO2l2JnSBfvtYw0+4e
 gJNd/YN8KRWtgOtVo1aMNUVHPypieisC4mHd0Td0RdUOaAQkrECIAyhP2xBwIhMAdHUb
 f6pHf2LV+ZkHxOfJTZ1En1fUQ6kCou7095ZkhW05o1zQruyS3gZD8mBhYy0FzGI3FYQa
 DlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789755014; x=1790359814;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/Hfpy/x3gmRurkqv60Bg2/RIVF22wanQR3zYhofeKyo=;
 b=IQaNxW/D6DouOYp04qqB73aGEBfGCM0HwqYFzYpKOrmbFZqn4jdWcZSLOif7+25ohT
 GO6Ajd99G+GOZ1xLU1IEIzT124kc2e8R0HK/A2e77KpOaq4InBW9OLwVxbNjPFXwatDV
 8oE1FIxQgOZzjqGtuIfQmOIcRo1oHpfYqKdcTIMQDuXdvruUEOqEGFYFySKglu1TXxbb
 HoBzsThChC7Hc7/dEF97IhHxymqEnZsiH0gQYQZbMugtHUxcriSKShrC1eWzC1fUT6nO
 1Bv/2wvTaoMe3KCnd8tB5II3UgdsgV0ulVW4CFBXJTcQCKu1EUSpyvHJ1YxadkyaN7l4
 dYPA==
X-Forwarded-Encrypted: i=1;
 AKwUvByD/3SWfkXKxlDaNQe6L2otoseiweSnkk6U01T7kYCRZev6GmGavi/0XmQKWXSvImCG4ptpv4zYApEi@nongnu.org
X-Gm-Message-State: AFuF++lCIpcLeEgUDiJz8faTS8JKDW8vU+yrMJ6m30wZO/XfW3oArE9y
 uUb2TMltXz2HidzjzyiiOz+g/EHOUUmeSgFPDsnXp4JVkWcW61cSwC+6jxY6VGKIGiM=
X-Gm-Gg: AYBFou327dzgJDALijcCdAPCRujFK7KKPtnGTVDDcjFRSZ3fFds2yiM05Y0+jFyEiuY
 P6VKS4AeTEXluwPKB5zFwfO33ce+w133AHvMIP36R/kGrOZofnrD8Hs/whUUJjCGwzM2Bew09oW
 SHKufYJ76jJXogIRAzJdL3Y1XUxm+9YiTqTiCoBesRY25o+tAKrVbNiP/hcTnxjTfFz4h9a8dK4
 BOeloFPOSxiVtFRH7f8qH+tWOfv215uYGL/mt7wyZWo6BJ+nq28qBo7d0FHjuGVc4/d5WExlx7/
 +5gmkP4+YgQq1Mr4UyRuI8cQ1j0eE9lUrQe5FiZjmYogRtpgu/1pthF7NaBOw3oua/b/w2vJ9r9
 ZZchqPizie70Bx2FOztMfSvw8hqPgTS/evea6cnjL/5uVtGsst1/+sxhqC29iUosiGXXKX7uI5K
 V6GUK25uHcOXeYxSV/RAZDCmOHLMRbknUVnH0Qrpx3jn2R/nSGWl8rylDHOReGIfSiKIgqmjHUE
 LwSPJzqu2PQGPT/Rb/9KfRPG3iH1cdVCD0rYovHknpM
X-Received: by 2002:a05:6a00:ad89:b0:847:77e9:acbb with SMTP id
 d2e1a72fcca58-874dc3f65a8mr6628507b3a.13.1789755013712; 
 Fri, 18 Sep 2026 11:10:13 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-877a94f4fefsm157029b3a.25.2026.09.18.11.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 11:10:13 -0700 (PDT)
Date: Sat, 19 Sep 2026 02:10:09 +0800
From: Max Chou <max.chou@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>, richard.henderson@linaro.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>, daniel.barboza@oss.qualcomm.com,
 joel@jms.id.au
Subject: Re: [PATCH v2] tcg/riscv64: Set vtype before whole-register vector
 moves
Message-ID: <aq184D2BedTg-Jjc@sifive.com>
References: <1f02f0fc-fee2-4722-9798-97bb0132561d@linaro.org>
 <mhng-2ECF390B-6BDB-4DF3-8133-18F4AC3A4DD2@Palmers-Mini.rwc.dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mhng-2ECF390B-6BDB-4DF3-8133-18F4AC3A4DD2@Palmers-Mini.rwc.dabbelt.com>
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=max.chou@sifive.com; helo=mail-pz2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 2026-09-17 17:21, Palmer Dabbelt wrote:
> On Thu, 17 Sep 2026 14:49:07 PDT (-0700), Richard Henderson wrote:
> > On 9/17/26 10:59, Palmer Dabbelt wrote:
> > > On Thu, 17 Sep 2026 13:51:10 PDT (-0700), Richard Henderson wrote:
> > > > On 9/17/26 03:37, Max Chou wrote:
> > > > > According to the RISC-V unpriviledge spec,
> > > > >    "vset{i}vl{i} and whole register loads and stores do not depend upon
> > > > >     vtype."
> > > > > The whole-register vector move instructions reuqire legal vtype that
> > > > > trap when VILL is set.
> > > > > 
> > > > > The tcg_out_mov in tcg/riscv64 missed the vtype setup before emitting
> > > > > the
> > > > > OPC_VMVNR_V.
> > > > > 
> > > > > Fixes: d4be6ee1111 ("tcg/riscv: Implement vector mov/dup{m/i}")
> > > > > Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> > > > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > > > > Signed-off-by: Max Chou <max.chou@sifive.com>
> > > > > ---
> > > > >   tcg/riscv64/tcg-target.c.inc | 4 ++++
> > > > >   1 file changed, 4 insertions(+)
> > > > > 
> > > > > diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> > > > > index 2ce9d47a633..e3cfedb579d 100644
> > > > > --- a/tcg/riscv64/tcg-target.c.inc
> > > > > +++ b/tcg/riscv64/tcg-target.c.inc
> > > > > @@ -778,6 +778,10 @@ static bool tcg_out_mov(TCGContext *s, TCGType
> > > > > type, TCGReg ret, TCGReg arg)
> > > > >           {
> > > > >               int lmul = type - riscv_lg2_vlenb;
> > > > >               int nf = 1 << MAX(lmul, 0);
> > > > > +
> > > > > +            if (s->riscv_cur_type == TCG_TYPE_COUNT) {
> > > > > +                set_vtype_len(s, type);
> > > > > +            }
> > > > >               tcg_out_opc_vi(s, OPC_VMVNR_V, ret, arg, nf - 1);
> > > > >           }
> > > > >           break;
> > > > 
> > > > Do you have a reproducer for this?  I ask because I still wonder how
> > > > this can occur.
> > > > 
> > > > Given that
> > > > 
> > > > (1) all vector registers are call-clobbered, there should be none live
> > > > across tcg_out_call_int (which clears the remembered vtype),
> > > > 
> > > > (2) the first vector action with no vector registers live must be a load
> > > > or movi (which will initialize vtype).
> > > > 
> > > > Performing a move between vector registers when all such registers must
> > > > be dead is... wrong.  It indicates that there's a bug elsewhere.
> > > 
> > > I'm not quite sure the commit message is right here, but this whole area
> > > is a bit of a landmine: one of the post-ratification changes to V was
> > > either this (or very close to this), so we've been through it for every
> > > project.
> > > 
> > > Here's the LLVM thread, which I think has links to everything else:
> > > https://github.com/llvm/llvm-project/issues/114518 (there's a GCC change
> > > as well).  IIRC hardware is a bit all over the place on this one, for
> > > the compilers we decided to just emit the code that's safe either way --
> > > that's not really an option for QEMU, though, so we'll have to pick one
> > > side or the other.
> > Yes, I get that.  But my point stands that after a function call (which
> > can set VILL), all vector registers should be dead.  A move of a dead
> > register is itself a bug.
> 
> That's true for standard ABI functions, but there's a variant for vector-ABI
> functions that allows some registers to be saved and that variant doesn't
> preserve vtype.  That's basically how we ended up in the mess with
> whole-register moves: pre-change vector-1.0 versions didn't trap
> whole-vector moves on vtype=VILL, so variant functions could use
> whole-register moves to save/restore registers and it was legal.  It was
> only when Linux started clobbering with VILL on implementations that
> respected the post-change ISA that we ended up with the traps.
> 
> That said, in GCC we just had a proper bug in there where we treated vytpe
> as saved over calls, so it was pretty easy to roll it up into that fix.
> Here's the GCC bug, if you're interested:
> <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117544>.  IIUC it was a little
> different in LLVM because they didn't have that bug and were thus actually
> correct for the pre-change ISA, but they also decided to just emit the code
> that's safe for both cases.
> 
> > There should have been *something* that brought the source vector
> > register back to life: a load or a movi.  Both of which reinitialize vtype.
> > 
> > That's why I'd like to see a reproducer, or if there isn't one,
> > 
> >      tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
> > 
> > I'm currently running the assert through the testsuite to make sure I've
> > not gone loopy.
> 
> Ya, seems reasonable.  It's certainly pretty likely this is masking some
> other bug as it was in GCC.

Hi Palmer and Richard,

Thanks Palmer for providing the toolchain discussion information and
links.

Richard, I have a reproducer for this issue listed below:

—
The reproducer follows this flow:

x86_64 `ls` executable -> qemu_x86-64 -> qemu-system-riscv64

1. Get x86_64 sysroot and `ls` executable from x86_64 host
```
$ podman create --name x86_64_container ubuntu:24.04
$ podman cp x86_64_container:/ {x86_64_sysroot}
```
2. Cross build qemu-x86_64
3. Obtain the riscv64 images (I built it using buildroot with
`qemu_riscv64_virt_defconfig` config).
4. Boot up riscv64 Linux on qemu-system-riscv64 and mount the
{x86_64_sysroot} (and the qemu-x86_64) directory.
5. Execute the x86_64 ls executable on qemu-x86_64 in
qemu-system-riscv64
```
# qemu-x86_64 -cpu max -L {x86_64_sysroot} {x86_64_sysroot}/usr/bin/ls
qemu-x86_64: QEMU internal SIGILL {code=ILLOPC, addr=0x7fff8c076450}
Illegal instruction
```
—

I understand that this reproducer could be simplified by building a
standalone executable without copying from the x86_64 container. I’ll
try to make it simpler.

rnax

