Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B991090223
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3DKe-00088H-8M; Thu, 19 Mar 2026 09:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3DKZ-00087q-Q8
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:22:32 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3DKW-0006WN-Ml
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:22:31 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64e9f79cae8so562062d50.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 06:22:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773926546; cv=none;
 d=google.com; s=arc-20240605;
 b=QojyPV4TX3SejKKam8nsZR58w31wCgozHNj+0jNKpEkBFfo2vcSi7K3yBT6GwIcyw7
 PcdQjmFk45z3/JZ/zuc4TLF3QQzz9urNCC+y0Q6nz95Px5Oz6qfCurkq5XxoDiyw5MBM
 +JXFpO2KQyJm4MTz0CEdAyIWmIgNFR7L7x3TxJyukTwwCdzPiFL/8Rz20+vSYIoiYxcO
 AcQgwX4s8WWk9DQqqqwUfcIe2eGCyT/IdPLpfwau/aGrAdhLF2Q4RxTOB7NIVc+BTP33
 KmuPAS7WvCt4mwb/KgvSOtzYm/utrEWmLrG46ccjeddoCYLHCo3y7BnIPhcoUAHFKrUK
 kTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OCoZnCa/QBkJw5AMvENPcliP3ZgTbJfa4Y89s2YRD1k=;
 fh=wGqB1Cw2pSM7AnBxfoHkPrjRzE0sRF1nBQc6dDUPTPE=;
 b=LGksaAGF0mZg8hjTx/lBgbl1ZUsljUhijcm3GpLvu5pE79ruXYHC2wcfWKi+llvaOV
 5GNhfurnlntFwU2+pIyLYoMwcL92Nn9AHIn/sGlnaDrXZ1/AjM6oQhi17eYB6nTOFJPq
 8EjryRS/7KNYshtr1M0+yAZpOVbdMNHTQM+28P1GqxHSOmL5FYG+n08q9y3HZHkYeFlT
 eJmuOjcNJKuJXq29ZHRJ8VGAAKbBwmDjxpz1t4uue7pFKqYovuvoUnHAekckEq3sZrjY
 nl5UAX8I4B0DOt9cyprHVUT3ZBf8ua+pUt15wHnO0AwdskJS3umaIEo5lfmF+miNwL/W
 X8NQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773926546; x=1774531346; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OCoZnCa/QBkJw5AMvENPcliP3ZgTbJfa4Y89s2YRD1k=;
 b=I5UeeZuG3ZFb6/+6V/biaO5RY0h6e983EzMP26a/92d3T9IEBXEhNz9zTLpAGWhJu/
 oV4WhfBENiqEgf7AiVrllF646rTwCZQvvv21E+eEK054s4ocd/GTQZVRmwvm3VBOb9rC
 WPr0bS/8xuQ59m/UZWwNO8OLlotrGoWAHmnoatnOzUWLWqJzWQEqkVYvF5vo35cmEZhi
 74uneC2c1OIz7hc3gnpxeGEjJPEVpM5qdPyMcLhp5UxVkZj/VyaPTp/+8gnX/iEztect
 xCrZeCYEISmlEAYY46106xZpvvauhuVXo6czOJ9BCCuPsWk/a72UFjRb9AVu0LtbYL9a
 nYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773926546; x=1774531346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCoZnCa/QBkJw5AMvENPcliP3ZgTbJfa4Y89s2YRD1k=;
 b=eahnqVsd3V8AZ4fUlb54YYiWBpKJrsLyiuUrc6hMO3Eer6hKsogMx9KD+tbKraycmZ
 wE5glDVfaNABTp391w94+gPBIfuQtH0E3NcIRcrpQSs+jF1VevTjOy4rFee5LjjuXzOT
 nm8wVY2+YoMsCuIwC7NouZWXYjRrySnX5Spnaso/c5AJzHYKs2YXYPEpZ2eLuUJxNd8Z
 3GFQhRzBqYuVPObjSXm9GNNmMbM6T27fcawdj4Cdanhr2Cq0bs+LXXzk9VsodwGaHiGG
 8bmeqlv94Wzf8KzrKAjkqSOVpDeV1cwcV913xqRpYUDRQFylWrGytet/sNinkH/fy9rY
 xTcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrdP34fWaK6DgaM9ivCMR5srjVq05TvFZT3DTPCBtvJoDEctPkREszGiCugkypiQbyNBKPfXaNpAjK@nongnu.org
X-Gm-Message-State: AOJu0Yw+WfYbZPnSclM3Vx16q1KI0x7VcK4OStcYKB6SODuVVAQvI9BG
 yB1htPovtB74UzNSsZenpzE1Sm1KNc9vESejao1lxXa/S9E6zY8TtY5v234/ggTH/dnRWcu9s2j
 LZRi5j2t95saiB1feAl4twmUH1k25BD1btbQy/xADTFFB3ht8H9+f
X-Gm-Gg: ATEYQzwTEAE/YCsX+5R7rD2YdO7rwKENyjzRG3WdIkrxQV3w10JAUXFiJLPHiHeL03D
 O+X58eRlnNr/YDhxVDWjssMaOY9dL/ZDGK6DqTO4OsVp0+i8i33tx+ilRHAXhTJPDY3lnlMjWfv
 wNFgnq74LzPHNzqMmhzd3JkWee/tUNT8rgLqMZv7+8rjgiM4qNhl7x12oziRscaIxhYoofwg78D
 Dn8mef1zO+4T12WqGmiYGl1KvUwWFYllgx92iuEL5c9NbxMUcjVlBzgKQZF699KeZRJPgGAI9OZ
 q+wybonHOrKqtuebJKv0c56/PnRptrDjMFqgWSkGTdonks7OLDVUxI/XrwZAbdYq/8I=
X-Received: by 2002:a05:690e:8:b0:649:d3ee:bdab with SMTP id
 956f58d0204a3-64e9136c8f4mr5315043d50.34.1773926545837; Thu, 19 Mar 2026
 06:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-10-peter.maydell@linaro.org>
 <20260306161617.00000f71@huawei.com>
In-Reply-To: <20260306161617.00000f71@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2026 13:22:14 +0000
X-Gm-Features: AaiRm52-wDBY08rIaQcaDkA2S9--qNNwg1P79MWAxe0IRcNsepRRrxdQMBa1ngs
Message-ID: <CAFEAcA8PJ6n60nqXEEg75uxnOp3ybBPNX6HE5CRjBA8y2YpOdw@mail.gmail.com>
Subject: Re: [PATCH 09/65] hw/intc/arm_gicv5: Implement IRS ID regs
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, 6 Mar 2026 at 16:16, Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Mon, 23 Feb 2026 17:01:16 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > Implement the IRS frame ID registers IRS_IDR[0-7], IRS_IIDR and
> > IRS_AIDR.  These are all 32-bit registers.
> >
> > We make these fields in the GIC state struct rather than just
> > hardcoding them in the register read function so that we can later
> > code "do this only if X is implemented" as a test on the ID register
> > value.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  hw/intc/arm_gicv5.c                | 112 +++++++++++++++++++++++++++++
> >  include/hw/intc/arm_gicv5_common.h |  39 ++++++++++
> >  2 files changed, 151 insertions(+)
> >
> > diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> > index db754e7681..f34bb81966 100644
> > --- a/hw/intc/arm_gicv5.c
> > +++ b/hw/intc/arm_gicv5.c
> > @@ -268,6 +268,62 @@ REG64(IRS_SWERR_SYNDROMER1, 0x3d0)
> >  static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
> >                           uint64_t *data, MemTxAttrs attrs)
> >  {
> > +    GICv5Common *cs = ARM_GICV5_COMMON(s);
> > +    uint32_t v = 0;
> > +
> > +    switch (offset) {
> > +    case A_IRS_IDR0:
> > +        v = cs->irs_idr0;
> > +        /* INT_DOM reports the domain this register is for */
> > +        v = FIELD_DP32(v, IRS_IDR0, INT_DOM, domain);
> > +        if (domain != GICV5_ID_REALM) {
> > +            /* MEC field RES0 except for the Realm domain */
> > +            v &= ~R_IRS_IDR0_MEC_MASK;
> > +        }
> > +        if (domain == GICV5_ID_EL3) {
> > +            /* VIRT is RES0 for EL3 domain */
> > +            v &= ~R_IRS_IDR0_VIRT_MASK;
> > +        }
>
> There are some more complex RES0 conditions that kind of build
> off these, like VIRT_ONE_N is RES0 if VIRT is 0, including
> I think if VIRT is RES0 as a result of the above.  That particular
> condition is perhaps worth encoding in here as you can see we may
> have it implemented for everything other than EL3.

As it happens, I have no intention of implementing 1ofN support.
But yes, for consistency we should mask it out to follow a rule
of "mask stuff that will appear differently in the view of this
register in the different register frames".

> This is similar to what you do for the whole of IDR3.
>
> > +        return true;
> > +
> > +    case A_IRS_IDR1:
> > +        *data = cs->irs_idr1;
> > +        return true;
> > +
> > +    case A_IRS_IDR2:
> > +        *data = cs->irs_idr2;
> > +        return true;
> > +
> > +    case A_IRS_IDR3:
> > +        /* In EL3 IDR0.VIRT is 0 so this is RES0 */
> > +        *data = domain == GICV5_ID_EL3 ? 0 : cs->irs_idr3;
>
> The spec has that condition on a field by field bases. I wonder
> if it would be clearer to mask out each field rather than set
> whole thing to 0.

I think that the whole IDR3 register is clearly deliberately
"things related to virtualization" and it's clearer to zero
it all at once rather than have multiple lines and leave the
reader wondering if any fields don't get zeroed.

> > +        return true;
> > +
> > +    case A_IRS_IDR4:
> > +        /* In EL3 IDR0.VIRT is 0 so this is RES0 */
> > +        *data = domain == GICV5_ID_EL3 ? 0 : cs->irs_idr4;
> Similar for this one.  Most of register is currently res0 and
> we don't know if those bits will be used later for stuff that
> isn't dependent on IRS_IDR0.VIRT being 1.

There's a lot of spare space in the register offset map
after IDR7 and before the next register, so I imagine the
intention is to add more ID registers if there's a future
need for more ID information that's not related to the existing
fields in any ID register.

thanks
-- PMM

