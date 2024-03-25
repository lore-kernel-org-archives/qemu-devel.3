Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BDDC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 09:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rogHD-00063l-Iy; Mon, 25 Mar 2024 05:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1rogHB-00063K-R1; Mon, 25 Mar 2024 05:05:53 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1rogH9-0001Nd-Aq; Mon, 25 Mar 2024 05:05:53 -0400
Received: from localhost (sekoia-laptop.home.lmichel.fr [192.168.61.102])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id 98C7CC60172;
 Mon, 25 Mar 2024 10:05:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1711357547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFbWWOPY1D1zKbzjEaay7BQjUPLASvMl/ALiP5eFixk=;
 b=RYCNUUpMCoRcQGddDDf0Urm02TWZr/uNE+37SbRBzICTaHNFhCaU5JgkS1pry6Rw8/3Cpt
 A9bIS6bYU1dY7SuGthn0TmWqk2kkMzy7d8CCsAqZ9Fa0hTD3VHEZcaCvCajp4O435ANsRW
 OuXW7uxMDIVv7PoEQzdZPgRbDlGQwJVXdhfGLeM6qtb+YtI7Efr28C33I3pVINmDkhdnBg
 wOS+x375aF4+L7DYvmnjZNQOZFVm8G7cLoo8Gpg8iDY6kvlBTWieT5zbujJCnlU0U2nI5U
 WXslOy55r7MWHKh8vcwhgFagppKonfSc/pMsq9fiPsa5NF8BeRCKcCW32dMCkg==
Date: Mon, 25 Mar 2024 10:05:47 +0100
From: Luc Michel <luc@lmichel.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Luc Michel <luc.michel@amd.com>,
 Damien Hedde <damien.hedde@dahe.fr>,
 =?utf-8?B?SW7DqHM=?= Varhol <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org
Subject: Re: [PATCH-for-9.0 1/2] hw/clock: Let clock_set_mul_div() return
 boolean value
Message-ID: <ZgE-a5z-zCVnxXTy@michell-laptop.localdomain>
References: <20240322155810.5733-1-philmd@linaro.org>
 <20240322155810.5733-2-philmd@linaro.org>
 <ZgE3fZx7qNkYATms@michell-laptop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgE3fZx7qNkYATms@michell-laptop.localdomain>
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 09:40 Mon 25 Mar     , Luc Michel wrote:
> On 16:58 Fri 22 Mar     , Philippe Mathieu-Daudé wrote:
> > Let clock_set_mul_div() return a boolean value whether the
> > clock has been updated or not, similarly to clock_set().
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Acked-by: Luc Michel <luc@lmichel.fr>

Sorry, I forgot, as Peter suggested, can you add a word in the doc
about this?

Something in the vein of:

+ Similary to ``clock_set()``, ``clock_set_mul_div()`` returns ``true`` if
+ the clock state was modified, that it, if the multiplier or the diviser
+ or both were changed by the call.
+ 
Note that ``clock_set_mul_div()`` does not automatically
call ``clock_propagate()``. If you make a runtime change to the
multiplier or divider you must call clock_propagate() yourself.

Thanks!

-- 
Luc

> 
> > ---
> >  include/hw/clock.h | 4 +++-
> >  hw/core/clock.c    | 8 +++++++-
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/hw/clock.h b/include/hw/clock.h
> > index bb12117f67..eb58599131 100644
> > --- a/include/hw/clock.h
> > +++ b/include/hw/clock.h
> > @@ -357,6 +357,8 @@ char *clock_display_freq(Clock *clk);
> >   * @multiplier: multiplier value
> >   * @divider: divider value
> >   *
> > + * @return: true if the clock is changed.
> > + *
> >   * By default, a Clock's children will all run with the same period
> >   * as their parent. This function allows you to adjust the multiplier
> >   * and divider used to derive the child clock frequency.
> > @@ -374,6 +376,6 @@ char *clock_display_freq(Clock *clk);
> >   * Note that this function does not call clock_propagate(); the
> >   * caller should do that if necessary.
> >   */
> > -void clock_set_mul_div(Clock *clk, uint32_t multiplier, uint32_t divider);
> > +bool clock_set_mul_div(Clock *clk, uint32_t multiplier, uint32_t divider);
> >  
> >  #endif /* QEMU_HW_CLOCK_H */
> > diff --git a/hw/core/clock.c b/hw/core/clock.c
> > index d82e44cd1a..a19c7db7df 100644
> > --- a/hw/core/clock.c
> > +++ b/hw/core/clock.c
> > @@ -143,14 +143,20 @@ char *clock_display_freq(Clock *clk)
> >      return freq_to_str(clock_get_hz(clk));
> >  }
> >  
> > -void clock_set_mul_div(Clock *clk, uint32_t multiplier, uint32_t divider)
> > +bool clock_set_mul_div(Clock *clk, uint32_t multiplier, uint32_t divider)
> >  {
> >      assert(divider != 0);
> >  
> > +    if (clk->multiplier == multiplier && clk->divider == divider) {
> > +        return false;
> > +    }
> > +
> >      trace_clock_set_mul_div(CLOCK_PATH(clk), clk->multiplier, multiplier,
> >                              clk->divider, divider);
> >      clk->multiplier = multiplier;
> >      clk->divider = divider;
> > +
> > +    return true;
> >  }
> >  
> >  static void clock_initfn(Object *obj)
> > -- 
> > 2.41.0
> > 
> 

-- 

