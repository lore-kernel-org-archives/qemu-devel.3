Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8D7C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 08:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rog8N-0002r6-39; Mon, 25 Mar 2024 04:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1rog8K-0002qB-P2; Mon, 25 Mar 2024 04:56:44 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1rog8I-0008UY-Hk; Mon, 25 Mar 2024 04:56:44 -0400
Received: from localhost (sekoia-laptop.home.lmichel.fr [192.168.61.102])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id 0DAF0C60172;
 Mon, 25 Mar 2024 09:56:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1711357000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tPHKlcMjIAG9i8s53/hAPdDcGiPubMh2yTJuSv7Vaqc=;
 b=EMvhUfwc6vwqaCreCJma+9Ft+o6b+wO21TgsgXe5neYOYRLbSoFFAjg2ylfvudUNipo2QY
 byeP0a/bbF1nTlEGLn8QsnxtiSknkxnSVx76yfH6pca1X5KK2C9ZGeVRd1w84ui0ic6hSp
 NGAsT/OOK2DlyDgNwn5+qJvHqDYy52NgOIk/o5W+0omOrpewu5pNCEeOvHrsCzzgBvHX93
 phti3gwMOocK1gVhaMhWAjnOB3GcGSA4iaAOu7nMJgsvMSHXxyzjHMxn+ob14TLOyTySvf
 O0NOtAMT5sEf92mJW6YLr9pqFXiX0tV+iBz9uXHFEJvatHj7wK+TbPcQIC3Skw==
Date: Mon, 25 Mar 2024 09:56:39 +0100
From: Luc Michel <luc@lmichel.fr>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Luc Michel <luc.michel@amd.com>,
 Damien Hedde <damien.hedde@dahe.fr>,
 =?utf-8?B?SW7DqHM=?= Varhol <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org
Subject: Re: [PATCH-for-9.0 2/2] hw/misc/stm32l4x5_rcc: Propagate period when
 enabling a clock
Message-ID: <ZgE8R2WxPSvybpVH@michell-laptop.localdomain>
References: <20240322155810.5733-1-philmd@linaro.org>
 <20240322155810.5733-3-philmd@linaro.org>
 <CAFEAcA_nFsWfXckLBJ72X6PTjmBYSRF77UoYs=gPB_GNshoyRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_nFsWfXckLBJ72X6PTjmBYSRF77UoYs=gPB_GNshoyRw@mail.gmail.com>
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

On 16:39 Fri 22 Mar     , Peter Maydell wrote:
> On Fri, 22 Mar 2024 at 15:59, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> >
> > From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> >
> > The "clock_set_mul_div" function doesn't propagate the clock period
> > to the children if it is changed (e.g. by enabling/disabling a clock
> > multiplexer).
> > This was overlooked during the implementation due to late changes.
> >
> > This commit propagates the change if the multiplier or divider changes.
> >
> > Fixes: ec7d83acbd ("hw/misc/stm32l4x5_rcc: Add an internal clock multiplexer object")
> > Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> > Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> > Message-ID: <20240317103918.44375-2-arnaud.minier@telecom-paris.fr>
> > [PMD: Check clock_set_mul_div() return value]
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> >  hw/misc/stm32l4x5_rcc.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
> > index bc2d63528b..7ad628b296 100644
> > --- a/hw/misc/stm32l4x5_rcc.c
> > +++ b/hw/misc/stm32l4x5_rcc.c
> > @@ -59,7 +59,10 @@ static void clock_mux_update(RccClockMuxState *mux, bool bypass_source)
> >          freq_multiplier = mux->divider;
> >      }
> >
> > -    clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier);
> > +    if (clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier)) {
> > +        clock_propagate(mux->out);
> > +    }
> > +
> >      clock_update(mux->out, clock_get(current_source));
> 
> clock_update() also calls clock_propagate(), so this doesn't
> seem entirely right: shouldn't we figure out whether we need to
> do a clock_propagate() and do it once? (Maybe what seems odd to me
> is that clock_set() does clock_propagate() for you but
> clock_set_mul_div() does not...)
clock_set() does not call clock_propagate(). clock_update() is a
clock_set() followed by a clock_propagate() if the period changed.

I think this is where the problem comes from here. clock_update() call
won't call clock_propagate() if the clock period does not change.

I think you'll want something like:
    bool changed;

    changed = clock_set_mul_div(mux->out, freq_multiplier, mux->multiplexer);
    changed ||= clock_set(clock_get(current_source));

    if (changed) {
        clock_propagate(mux->out);
    }
 
Thanks,

-- 
Luc

> 
> (Also I think we should have the information we need now to be able
> to do the "reduce log spam" in the comment -- if neither
> clock_set_mul_div() nor clock_update() needed to do anything
> then we didn't actually change the config.)
> 
> -- PMM

-- 

