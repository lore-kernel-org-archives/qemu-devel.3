Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F8CCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN5p-0007Uf-FV; Wed, 07 Oct 2026 04:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xEI0K-0000EK-3P; Tue, 06 Oct 2026 23:07:57 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xEHzu-0007GJ-H8; Tue, 06 Oct 2026 23:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Kk5nB3ViPReoN1oos9OwhyYhHfcusOIN1+6kS0R+eqo=; b=cCgYyB3HnKe0iTT
 IyKg9N+LvZKX6DgQwgEnMZgsbtQeU+jNCGCugvHfDKEPyo+8YHhX5I8r9VIW7o8W6EIOpo1je4Zi0
 POT6CgcYv9JHOwOh91eRrvLbMcMCEQTK3KVYFQXzAhTGS2saTaBV036Jg7hydYyuI8datrF2YmeGp
 WA=;
Date: Wed, 7 Oct 2026 01:14:13 +0200
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
Subject: Re: [PATCH 01/18] target/riscv: Make internals.h target agnostic
Message-ID: <asV_najmI5UsUvKT@hive.localdomain>
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-1-ea69b07afd31@rev.ng>
 <d379ac03-6d53-4532-8f5b-5e635dde0699@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d379ac03-6d53-4532-8f5b-5e635dde0699@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 01/10/26, Pierrick Bouvier wrote:
> On 10/1/2026 8:59 AM, Anton Johansson wrote:
> > Replaces uses of target_ulong with fixed-size integers, this is a
> > prerequisite step to compiling cpu.c once for system-mode.
> > 
> > Note: the widening of target_long to int64_t in adjust_addr_body() is
> > safe as rv32 is ruled out earlier in the function via the check
> > 
> >   /* do nothing for rv32 mode */
> >   if (riscv_cpu_mxl(env) == MXL_RV32) {
> >       return addr;
> >   }
> > 
> > meaning target_long must be equal to int64_t anyway.
> > 
> > Duplicate includes between vector_helper.c and vector_internals.h are
> > removed.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >  target/riscv/internals.h            | 31 +++++++++---------
> >  target/riscv/tcg/vector_internals.h |  5 +--
> >  target/riscv/tcg/vector_helper.c    | 64 +++++++++++++++++--------------------
> >  3 files changed, 47 insertions(+), 53 deletions(-)
> > 
> 
> ...
> 
> >  /* Zjpm addr masking routine */
> > -static inline target_ulong adjust_addr_body(CPURISCVState *env,
> > -                                            target_ulong addr,
> > -                                            bool is_virt_addr)
> > +static inline uint64_t adjust_addr_body(CPURISCVState *env,
> > +                                        uint64_t addr,
> > +                                        bool is_virt_addr)
> >  {
> >      RISCVPmPmm pmm = PMM_FIELD_DISABLED;
> >      uint32_t pmlen = 0;
> > @@ -239,7 +238,7 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
> >  
> >      /* sign/zero extend masked address by N-1 bit */
> >      if (signext) {
> > -        addr = (target_long)addr >> pmlen;
> > +        addr = (int64_t)addr >> pmlen;
> >      } else {
> >          addr = addr >> pmlen;
> >      }
> 
> I think this one is incorrect, since for a 32-bit addr, value will not
> get sign extended, so shift will be unsigned.
> 
> ```
> #include <stdio.h>
> #include <stdint.h>
> #include <inttypes.h>
> 
> uint64_t out64(uint64_t in)
> {
>     return (int64_t) in >> 1;
> }
> 
> uint32_t out32(uint32_t in)
> {
>     return (int32_t) in >> 1;
> }
> 
> int main()
> {
>     printf("32: %"PRIx32"\n", out32(0xffffffff));
>     printf("64: %"PRIx64"\n", out64(0xffffffff));
> }
> ```
> 
> Output is:
> 32: ffffffff
> 64: 7fffffff
> 
> We need to add a:
> if (target_long_bits() == 32) {
>   addr = (int32_t)addr >> pmlen;
> else {
>   addr = (int64_t)addr >> pmlen;
> }
> 
> Regards,
> Pierrick

No this is not necessary unless I'm missing something, see commit comment.
MXL_RV32 is ruled out earlier in the function

  static inline uint64_t adjust_addr_body(CPURISCVState *env,
                                          uint64_t addr,
                                          bool is_virt_addr)
  {
      ...
  
      /* do nothing for rv32 mode */
      if (riscv_cpu_mxl(env) == MXL_RV32) {
          return addr;
      }

      ...

      /* sign/zero extend masked address by N-1 bit */
      if (signext) {
	  addr = (int64_t)addr >> pmlen;
      } else {
          addr = addr >> pmlen;
      }

      return addr;
  }

-- 
Anton Johansson
rev.ng Labs Srl.

