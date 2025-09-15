Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FD6CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyBe0-0004pu-2N; Mon, 15 Sep 2025 12:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1uyBdP-0004dQ-9k
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:00:55 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1uyBd0-0000oB-Hx
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=MysrRuEtvpP4IcBeszM2iANpf3LYtSBk08ItDNxCbqY=; b=EwhuCdHSZSgCJD9
 i2MXB1YvIdkJR+DQJRvDH+VH9W7BpnWW7wFDgkdimehQLWsMG0V/62VIJuZjppqXL00Na6fo7+ZzP
 xOrFOka3lDu7Yu7hZSP3Q4glswVb1CVUQ4nkrsamCGVHGW6esL4vMVnLQsTFZhbl+OuwY3MBnhUae
 +g=;
Date: Mon, 15 Sep 2025 18:02:32 +0200
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Anton Johansson via <qemu-devel@nongnu.org>, philmd@linaro.org
Subject: Re: [PATCH] target/mips: Fix msaregnames and mxuregnames off-by-one
Message-ID: <3lpthf7dt2vhvhwvih5cvbtmt64ultmyn4pqrivurejxugeecc@re7qb3aonrgk>
References: <20250912142927.20919-1-anjo@rev.ng>
 <87h5x3pyii.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h5x3pyii.fsf@draig.linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 15/09/25, Alex Bennée wrote:
> Anton Johansson via <qemu-devel@nongnu.org> writes:
> 
> > The msaregnames and mxuregnames arrays contains strings of 7 bytes
> > ("w10.d0", ...) and 5 bytes ("XR10", ...) in length including the
> > NULL byte.
> >
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >  target/mips/tcg/msa_translate.c | 2 +-
> >  target/mips/tcg/mxu_translate.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
> > index 82b149922f..0e947125a0 100644
> > --- a/target/mips/tcg/msa_translate.c
> > +++ b/target/mips/tcg/msa_translate.c
> > @@ -32,7 +32,7 @@ static inline int plus_2(DisasContext *s, int x)
> >  /* Include the auto-generated decoder.  */
> >  #include "decode-msa.c.inc"
> >  
> > -static const char msaregnames[][6] = {
> > +static const char msaregnames[][7] = {
> >      "w0.d0",  "w0.d1",  "w1.d0",  "w1.d1",
> >      "w2.d0",  "w2.d1",  "w3.d0",  "w3.d1",
> >      "w4.d0",  "w4.d1",  "w5.d0",  "w5.d1",
> > diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
> > index 35ebb0397d..7e8cc8b06f 100644
> > --- a/target/mips/tcg/mxu_translate.c
> > +++ b/target/mips/tcg/mxu_translate.c
> > @@ -609,7 +609,7 @@ enum {
> >  static TCGv mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
> >  static TCGv mxu_CR;
> >  
> > -static const char mxuregnames[NUMBER_OF_MXU_REGISTERS][4] = {
> > +static const char mxuregnames[NUMBER_OF_MXU_REGISTERS][5] = {
> >      "XR1",  "XR2",  "XR3",  "XR4",  "XR5",  "XR6",  "XR7",  "XR8",
> >      "XR9",  "XR10", "XR11", "XR12", "XR13", "XR14", "XR15", "XCR",
> >  };
> 
> Maybe not quite so silly question. Why are we setting 2D dimensions on
> the regnames anyway? Shouldn't we just use static const char * and be
> done with it?
> 
> AFAICT all the references only care about the number anyway.

Previously a 1D array of pointers was used, here's the original patch
introducing the 2D array

  https://lists.gnu.org/archive/html/qemu-devel/2021-06/msg04706.html

It's an optimization to reduce memory usage and runtime relocations.

Assuming a 64-bit linux system we can estimate the memory required for
using 1D arrays for msaregnames and mxuregnames to

    64*(8 + 24) + 16*(8 + 24) = 2560 bytes

with 8 byte pointers and 24 byte relocation table entries, the above
does not include the memory for the actual strings. And with the 1D
change we get

    64*7 + 16*5 = 528 bytes

Though I can't speak to the impact on runtime performance.

-- 
Anton Johansson
rev.ng Labs Srl.

