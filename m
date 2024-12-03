Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F820E74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 18:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIXw9-00023n-6R; Tue, 03 Dec 2024 13:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIXw4-0001xn-Bd
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:47:48 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIXvz-00008O-PH
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=CklkM6S5h4Kst2DXfb2+yNUzhSDwHpfm+sATlT6rj5c=; b=KFuhrwVIR3J1vZr
 0kQt7l7YtP7KZhM7+2UGJXgg4tovmFp0WoMsFcBU9lzZ0K5ypvqE0ZT2MffmHlmLqNsC2xxlWnqI/
 2f9YeL++heTdqRr7cM26zTam6Wz8sO8HLRObCf3wFk2z7f449qZOoaaJCpBZPFCkkOpRIAcH0VQ7P
 1I=;
Date: Tue, 3 Dec 2024 19:50:45 +0100
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, ale@rev.ng, ltaylorsimpson@gmail.com, 
 bcain@quicinc.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [RFC PATCH v1 34/43] target/hexagon: Add get_tb_mmu_index()
Message-ID: <uk4zvjo7222a5yox57yt5bdqwzz2u5dw7htd4oyl7eg4lizfid@xrrzbkeq7sfz>
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-35-anjo@rev.ng>
 <cef19610-7578-4e5f-809e-ab449fc7b710@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cef19610-7578-4e5f-809e-ab449fc7b710@linaro.org>
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
> > Adds a functions to return the current mmu index given tb_flags of the
> > current translation block.  Required by helper-to-tcg in order to
> > retrieve the mmu index for memory operations without changing the
> > signature of helper functions.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   target/hexagon/cpu.h | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> > 
> > diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> > index 764f3c38cc..7be4b5769e 100644
> > --- a/target/hexagon/cpu.h
> > +++ b/target/hexagon/cpu.h
> > @@ -153,6 +153,18 @@ static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
> >       }
> >   }
> > +// Returns the current mmu index given tb_flags of the current translation
> > +// block.  Required by helper-to-tcg in order to retrieve the mmu index for
> > +// memory operations without changing the signature of helper functions.
> > +static inline int get_tb_mmu_index(uint32_t flags)
> > +{
> > +#ifdef CONFIG_USER_ONLY
> > +    return MMU_USER_IDX;
> > +#else
> > +#error System mode not supported on Hexagon yet
> > +#endif
> > +}
> > +
> >   typedef HexagonCPU ArchCPU;
> >   void hexagon_translate_init(void);
> 
> I suggest placing this somewhere other than cpu.h, as it's private to the
> translator and its generated code.

Makes sense!

//Anton

