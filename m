Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46151E74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 18:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIXH3-0000if-Oy; Tue, 03 Dec 2024 13:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIXGy-0000hn-N4
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:05:21 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIXGw-0000op-TP
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=S1PMJytKEualRf+ZuSddXe0rqUnGoVGmcLlwHSRg6S0=; b=J7K6UrnUybg4Ym+
 qWcHupcqluzkHrno1eNF24tACROeWScmoT4/Gh482BfTPeEBn0yzsOsw81NaSxiVu6yDeu+qryCSD
 ouqdemo/3Np6gqM7ENF7Dv/pS6MlPnZ2oKD8E9lBzHqj4VbMAX0kR+b+sYA14Hk8C1AKM+y92EOjI
 iA=;
Date: Tue, 3 Dec 2024 19:08:18 +0100
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, ale@rev.ng, ltaylorsimpson@gmail.com, 
 bcain@quicinc.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [RFC PATCH v1 03/43] accel/tcg: Add gvec size changing operations
Message-ID: <v5pkpmxto7vtshg7a5mifaozrzn6n5d7raknvydad3oxk67jeu@i4jydb4wylpb>
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-4-anjo@rev.ng>
 <b2986b74-2c74-491b-90a1-9ec79367c2e8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2986b74-2c74-491b-90a1-9ec79367c2e8@linaro.org>
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
> > Adds new functions to the gvec API for truncating, sign- or zero
> > extending vector elements.  Currently implemented as helper functions,
> > these may be mapped onto host vector instructions in the future.
> > 
> > For the time being, allows translation of more complicated vector
> > instructions by helper-to-tcg.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   accel/tcg/tcg-runtime-gvec.c     | 41 +++++++++++++++++
> >   accel/tcg/tcg-runtime.h          | 22 +++++++++
> >   include/tcg/tcg-op-gvec-common.h | 18 ++++++++
> >   tcg/tcg-op-gvec.c                | 78 ++++++++++++++++++++++++++++++++
> >   4 files changed, 159 insertions(+)
> > 
> > diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
> > index afca89baa1..685c991e6a 100644
> > --- a/accel/tcg/tcg-runtime-gvec.c
> > +++ b/accel/tcg/tcg-runtime-gvec.c
> > @@ -1569,3 +1569,44 @@ void HELPER(gvec_bitsel)(void *d, void *a, void *b, void *c, uint32_t desc)
> >       }
> >       clear_high(d, oprsz, desc);
> >   }
> > +
> > +#define DO_SZ_OP1(NAME, DSTTY, SRCTY)                                      \
> > +void HELPER(NAME)(void *d, void *a, uint32_t desc)                         \
> > +{                                                                          \
> > +    intptr_t oprsz = simd_oprsz(desc);                                     \
> > +    intptr_t elsz = oprsz/sizeof(DSTTY);                                   \
> > +    intptr_t i;                                                            \
> > +                                                                           \
> > +    for (i = 0; i < elsz; ++i) {                                           \
> > +        SRCTY aa = *((SRCTY *) a + i);                                     \
> > +        *((DSTTY *) d + i) = aa;                                           \
> > +    }                                                                      \
> > +    clear_high(d, oprsz, desc);                                            \
> 
> This formulation is not valid.
> 
> (1) Generic forms must *always* operate strictly on columns.  This
> formulation is either expanding a narrow vector to a wider vector or
> compressing a wider vector to a narrow vector.
> 
> (2) This takes no care for byte ordering of the data between columns.  This
> is where sticking strictly to columns helps, in that we can assume that data
> is host-endian *within the column*, but we cannot assume anything about the
> element indexing of ptr + i.

Concerning (1) and (2), is this a limitation imposed on generic vector
ops. to simplify mapping to host vector instructions where
padding/alignment of elements might differ?  From my understanding, the
helper above should be fine since we can assume contiguous elements?

But maybe it doesn't make sense to add a gvec op. that is only
implemented via helper, I'm not sure.

> (3) This takes no care for element overlap if A == D.

Ah, good point!

> The only form of sign/zero-extract that you may add generically is an alias for
> 
>   d[i] = a[i] & mask
> 
> or
> 
>   d[i] = (a[i] << shift) >> shift
> 
> where A and D use the same element type.  We could add new tcg opcodes for
> these (particularly the second, for sign-extension), though x86_64 does not
> support it, afaics.

I see, I don't think we can make this work for Hexagon vector ops., as
an example consider V6_vadduwsat which performs an unsigned saturated
add of 32-bit elements, currently we emit

    void emit_V6_vadduwsat(intptr_t vec2, intptr_t vec7, intptr_t vec6) {
        VectorMem mem = {0};
        intptr_t vec5 = temp_new_gvec(&mem, 256);
        tcg_gen_gvec_zext(MO_64, MO_32, vec5, vec7, 256, 128, 256);

        intptr_t vec1 = temp_new_gvec(&mem, 256);
        tcg_gen_gvec_zext(MO_64, MO_32, vec1, vec6, 256, 128, 256);

        tcg_gen_gvec_add(MO_64, vec1, vec1, vec5, 256, 256);

        intptr_t vec3 = temp_new_gvec(&mem, 256);
        tcg_gen_gvec_dup_imm(MO_64, vec3, 256, 256, 4294967295ull);

        tcg_gen_gvec_umin(MO_64, vec1, vec1, vec3, 256, 256);

        tcg_gen_gvec_trunc(MO_32, MO_64, vec2, vec1, 128, 256, 128);
    }

so we really do rely on the size-changing property of zext here, the
input vectors are 128-byte and we expand them to 256-byte.  We could
expand vector operations within the instruction to the largest vector
size, but would need to zext and trunc to destination and source
registers anyway.

//Anton

