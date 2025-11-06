Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22233CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 17:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH3WA-0005xK-RD; Thu, 06 Nov 2025 12:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vH3W2-0005rn-6L
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:11:20 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vH3Vq-0004QT-Kl
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=4/6FaPdFnOy/DcD9OfqXzcsmuUKsRTf8q2ECPUxoQ4I=; b=jLZ0EnDI6kXY09/
 mkhomvLOLb8u7fTHZJ6D80FgCk4DLKrnyE3631b7og739TEm984S1eyzRWmbJDIDPyIc89rzBJdhg
 2eZyu9CSX4pqoDlZTWlHC8fKZaA1EGiN+gtODxHArnj46cMJmn4VFK7h+IxPdodKJMUQu3EXBFaH2
 ac=;
Date: Thu, 6 Nov 2025 18:14:04 +0100
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] target/arm: Fix accidental write to TCG constant
Message-ID: <wpbkrbw2nysjlmluhdaep5qcojqfmemboajhcc37awjsp43z3g@pw6i4jrjpfzb>
References: <20251106144909.533997-1-richard.henderson@linaro.org>
 <5ad511f4-eb36-4d49-90a6-fbb1e5f67c6c@linaro.org>
 <CAFEAcA_gkyMTynt6ndVCDaq1RwwvpOUbYNm-=RjE17xuuTTCyw@mail.gmail.com>
 <40afd528-ece1-42eb-8d02-d2094ebc58c9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40afd528-ece1-42eb-8d02-d2094ebc58c9@linaro.org>
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

On 06/11/25, Richard Henderson wrote:
> On 11/6/25 16:57, Peter Maydell wrote:
> > On Thu, 6 Nov 2025 at 15:48, Gustavo Romero <gustavo.romero@linaro.org> wrote:
> > > 
> > > Hi folks,
> > > 
> > > On 11/6/25 15:49, Richard Henderson wrote:
> > > > Currently an unpredictable movw such as
> > > > 
> > > >     movw pc, 0x123
> > > 
> > > bah, how did you get this insn.? Are you using any fuzzer? :P

Not the most familiar with arm myself, but I noticed assemblers aren't
happy with producing this instruction.  We use QEMU primarily for
lifting code for decompilation, and found this instruction when lifting
some android binary.  Looking back at the instructions it might be
incorrectly identified thumb code on our end, so I doubt you'd encounter
this instruction in the wild.  Still I think the code transformation
from Richard makes sense since store_reg() is used with TCG constants.

> > > 
> > > 
> > > > results in the tinycode
> > > > 
> > > >      and_i32 $0x123,$0x123,$0xfffffffc
> > > >      mov_i32 pc,$0x123
> > > >      exit_tb $0x0
> > > > 
> > > > which is clearly a bug, writing to a constant is incorrect and discards
> > > > the result of the mask.  Fix this by adding a temporary in store_reg().
> > 
> > > The difference between v1 and v2 is:
> > > 
> > > v1:
> > >    mov_i32 tmp3,$0x123
> > >    and_i32 tmp3,tmp3,$0xfffffffc
> > >    mov_i32 pc,tmp3
> > > 
> > > v2 (this version)
> > > and_i32 pc,$0x123,$0xfffffffc
> > > 
> > > 
> > > I think we need only a v3 that updates the commit message since we
> > > are not adding a temporary anymore.
> > > 
> > > Interestingly, I was not able to crash the host when native code
> > > was generated from:
> > > 
> > > and_i32 $0x123,$0x123,$0xfffffffc
> > 
> > The commit message doesn't say this crashes, it says it
> > discards the result of the mask. (That is, we intended to
> > clear the low bits of the guest PC but don't.)
> > 
> > Should there be a TCG debug assert for "TCGv for the
> > result of an operation is a constant" ?
> 
> There is, at least with --enable-debug-tcg.
> I assumed there was a crash from the description,
> but I haven't yet tried the test case Gustavo put together.
> 
> 
> r~
> 

-- 
Anton Johansson
rev.ng Labs Srl.

