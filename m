Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8894E74AC8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 18:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIXqr-0008RO-Tn; Tue, 03 Dec 2024 13:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIXqp-0008RA-FX
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:42:23 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIXqn-00082u-Px
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=XQ9b/Ny8PW80gAuT3odncp7phVqU47bzPbxWoHfK2vo=; b=btt3HJx/HbszE6x
 6qNmAh6JMcjTMs/C7gBITEehZn7LM1A6Vb6jnDFd0uGZygief0pRSGLSk3uM64d/akuHGn1/IVd+6
 pHS/PAs5ncuJBNymDdat3Z8AQg94ZKoYhLGtB7GYzKHL7ivLMMT1htYVyJWuSPcradiUPZqbdb6vj
 Ww=;
Date: Tue, 3 Dec 2024 19:45:23 +0100
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, ale@rev.ng, ltaylorsimpson@gmail.com, 
 bcain@quicinc.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [RFC PATCH v1 05/43] tcg: Add helper function dispatcher and
 hook tcg_gen_callN
Message-ID: <szh7qwurfs5jmonqvuy7ibtcywccr7mlnkmjxbrp226pwrm6dt@qaq66cdtbnxr>
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-6-anjo@rev.ng>
 <1e4bfa65-715a-4ac8-958f-48f0f6301218@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e4bfa65-715a-4ac8-958f-48f0f6301218@linaro.org>
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
> > Adds a function pointer to the TCGContext which may be set by targets via
> > the TARGET_HELPER_DISPATCHER macro.  The dispatcher is function
> > 
> >    (void *func, TCGTemp *ret, int nargs, TCGTemp **args) -> bool
> > 
> > which allows targets to hook the generation of helper calls in TCG and
> > take over translation.  Specifically, this will be used by helper-to-tcg
> > to replace helper function translation, without having to modify frontends.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   accel/tcg/translate-all.c | 4 ++++
> >   include/tcg/tcg.h         | 4 ++++
> >   tcg/tcg.c                 | 5 +++++
> >   3 files changed, 13 insertions(+)
> 
> I guess I'll have to read further to understand this, but my first reaction
> is: why would we not modify how the gen_helper_* functions are defined
> instead?

Hmm this might be a better idea, and we could call the generated could
directly without having to go through a massive switch statement.  What
I have in mind is something like

    #if !glue(OVERRIDE_HELPER_, name) \
    #define DEF_HELPER_FLAGS_1(name, flags, ret, t1)                        \
    extern TCGHelperInfo glue(helper_info_, name);                          \
    static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
        dh_arg_decl(t1, 1))                                                 \
    {                                                                       \
        tcg_gen_call1(glue(helper_info_,name).func,                         \
                      &glue(helper_info_,name), dh_retvar(ret),             \
                      dh_arg(t1, 1));                                       \
    }                                                                       \
    #endif

and we could emit gen_helper_* for helpers which are translated and
redefine OVERRIDE_HELPER_* to 1 (would have to be defaulted to 0
somewhere else).

//Anton

