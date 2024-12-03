Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7532DE74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 17:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIX17-0005b6-L3; Tue, 03 Dec 2024 12:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIX15-0005ay-Oy
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 12:48:55 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIX14-00059P-2I
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 12:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=isONK10BhMZeU7HHivlZ8Nxl5Heqwtr2sCiIT2r0YZ4=; b=QYpBY85hJUBswj2
 vWEWiS7LCo3gBcwhFk+Oz1si1hJLn7dyr3MliFOWH5ZfrDn4aCs50oYrL344Gkmheo93hVS8ILksT
 xfbPeMuamgbUPC91yKAx1uZUM5ydRCk+eKFd2lxlytCDWw2rQYzTLw8XiaB1S/O0xx50p8TEtlUQN
 zg=;
Date: Tue, 3 Dec 2024 18:50:00 +0100
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, ale@rev.ng, ltaylorsimpson@gmail.com, 
 bcain@quicinc.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [RFC PATCH v1 02/43] accel/tcg: Add bitreverse and funnel-shift
 runtime helper functions
Message-ID: <vippd3swjcb7yfoncacbi43taxyfyiy7qlx35nefnw24kmhfwb@7xzivys6m36s>
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-3-anjo@rev.ng>
 <a6785c40-fa77-4cff-8244-479fc539fbfd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6785c40-fa77-4cff-8244-479fc539fbfd@linaro.org>
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

On 22/11/24, Richard Henderson wrote:
> On 11/20/24 19:49, Anton Johansson wrote:
> > Adds necessary helper functions for mapping LLVM IR onto TCG.
> > Specifically, helpers corresponding to the bitreverse and funnel-shift
> > intrinsics in LLVM.
> > 
> > Note: these may be converted to more efficient implementations in the
> > future, but for the time being it allows helper-to-tcg to support a
> > wider subset of LLVM IR.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   accel/tcg/tcg-runtime.c | 29 +++++++++++++++++++++++++++++
> >   accel/tcg/tcg-runtime.h |  5 +++++
> >   2 files changed, 34 insertions(+)
> 
> For things in tcg-runtime.c, we generally have wrapper functions in
> include/tcg/tcg-op-common.h which hide the fact that the operation is being
> expanded by a helper.
> 
> We would also have tcg_gen_bitreverse{8,16,32}_i64, and *_tl macros in include/tcg/tcg-op.h.
> 
> I've been meaning to add something like these for a while, because they are
> common to quite a few targets.
> 
> > +uint32_t HELPER(bitreverse8_i32)(uint32_t x)
> > +{
> > +  return revbit8((uint8_t) x);
> > +}
> 
> Also common is bit-reversing every byte in the word, not just the lowest.
> Worth implementing both?  Or simply zero-extending the input/output when the
> target only requires the lowest byte?
> 
> We might want to audit the other targets to determine which forms are used...

I'll take a stab at auditing usage of revbit*() in targets, and add
appropriate tcg_gen_bitreverse*() versions.  I guess it makes sense to split
this out into a small separate patchset in that case.

//Anton

