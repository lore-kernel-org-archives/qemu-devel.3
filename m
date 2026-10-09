Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5271CA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF7Du-00045K-Ol; Fri, 09 Oct 2026 05:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xF7Dq-00044Z-Ul
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 05:49:04 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xF7Dp-0004e8-Lf
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 05:49:02 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48b02b1b4cfso1102989f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 02:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791539339; x=1792144139; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iekTtIyfqhClx8lzdggH837LZU04iv0fatAxdMHhpQI=;
 b=pE16jzaODkiiBiSYbnx8h97bZgqd3eC+VN9sSa51cx95ZH+LRB4X0rpXK+cn4XUKKC
 49P3nv8PaZfeaotYKZggcR7B0wYPObhNe75+1ydaizsiw7BBTg4KQA4HpxIFoUhl3Ro7
 vNvsurrgou7tFy1pUTh2ulpxwefV7gavF7+Dw4bbfRGOvKNkcXFrPC86evmZXv0jPR/R
 mmHmadn/5Tbd+UYUssNKkOqyNAF+gkLpOctmndFXPLo2xN07buLj5HAPVWqRdcTMdd/4
 MFVMe50uiZ/2If1ovSo9bjr43EphUfLtYT34Gqm6hmTp8YPOZaeEJBj/j9N6a7cKlWfD
 Lggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791539339; x=1792144139;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iekTtIyfqhClx8lzdggH837LZU04iv0fatAxdMHhpQI=;
 b=psaDcOCVIGf81wHm/Qd8QBTg/sJEhYqDnohEDeOFsoDjjqIE/tsUkPZOcMPu8pq8NB
 6OheKc5s8danzhEl69yX2Q7pQJzxx39KkUh/L3ssNUhDOGPfUcsqlDq4XDMxaXWiXuzZ
 zbqkT9lvei9yzAv87qIugOl1pcULmCOBbE8qKTJ4qUi3U/6Kvs01mF26KRYGyhB+Pf0e
 BV8ctlh6/2PdI1VKw9grR4WOJ5iYcQR57G/KHOUZvZTyMBvo6Es++Nm/btB0aNVNirpt
 hhLmk64P0RSvRDH5PPf7uPXsmVMhcQ1xO8J57TtcsdigZw7AspjMD5ePK27hLOypmIiU
 0q/w==
X-Gm-Message-State: AFq9FYKV1ggYyVth30CuqzwYcXPAFBicOpd9YfB0Jg4JZ+g9doTQRVcM
 eIcY4Mzixzjb7Pk4bIydZGPbeUkOOnWv65ur7NjSjJjxLZ8lvTahyC1XkiZDW0fZBfd/06EY181
 7D0SSUXM=
X-Gm-Gg: AYBFou1Kuq1ZlLBA5CE1PpwqcW8bBKWwFkFlGP90XLxu6EtkjPEcvUcZyxIqroNKoC6
 Q6nFW83mFVjuw95VQIeGCldZGf286lMjMgPjMLUGMUNZ4Fxhg7TZIR5GTog8aqkY/WCqhFaWLv8
 /yaEKc6fTUgko7EuezCoAIeFH+4SNdJvHshEV36HviKfmw0XRw66YLjzZ9uj8PfF2bYqYdxKa12
 gaHQcvNMJ/pnNW1xkMLYoRgh2shMW2oFsDqpbOf20RZSZ39gMoeZLY6Li1LrqKGkHwSyWi/qzHb
 c7X3F+91gOFQTmlXN32vnbwxVfG2vpR2bg6EkgJ4RO50iHa2RygS1iey66lkgMEu/Dudhzmjiw3
 ko1FRCukH7GJD33FhpYC6FRszdpIMmFwstY1h41hiThfaSTzQxzoA9VCqQm0LQ6DXnSbW+eg1A0
 LXZpsFxUvdMoCNFXR4VObEmD9MPt1vTLnoJrGMVQEolU+wRtEL7oX041F1/6VlFeTit/BbCG72C
 Crm8XrMPfE=
X-Received: by 2002:a05:6000:298d:20b0:48b:469:b562 with SMTP id
 ffacd0b85a97d-48dba7b3284mr1939816f8f.2.1791539339035; 
 Fri, 09 Oct 2026 02:48:59 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:fde2:547b:5069:256e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aca657sm2981436f8f.43.2026.10.09.02.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 02:48:58 -0700 (PDT)
Date: Fri, 9 Oct 2026 10:48:57 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com
Subject: Re: [PATCH] hw/intc/arm_gicv5: Make IRS_IDR0 reads return actual
 value, not 0
Message-ID: <asi4iR9eMPPgQIkS@linaro.org>
References: <20261008092327.4036856-1-peter.maydell@linaro.org>
 <5d81e092-86f2-4459-a34b-460d69009568@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d81e092-86f2-4459-a34b-460d69009568@oss.qualcomm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x435.google.com
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

On Thu, Oct 08, 2026 at 11:36:59AM +0200, Philippe Mathieu-Daudé wrote:
> On 8/10/26 11:23, Peter Maydell wrote:
> > IN the code for handling reads of IRS_IDR0, we carefully construct
> > the correct value starting with cs->irs_idr0 and adjusting it.
> > However, we never actually write the final value into *data, so
> > the guest will always see zero.
> > 
> > We didn't notice this before, because Linux happens to not care
> > about this register value except to check for the presence of
> > virtualization.
> > 
> > Cc: qemu-stable@nongnu.org
> > Fixes: 405ad2e76f13254 ("hw/intc/arm_gicv5: Implement IRS ID regs")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/intc/arm_gicv5.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> > index 08878193dfc..ebfb0878af3 100644
> > --- a/hw/intc/arm_gicv5.c
> > +++ b/hw/intc/arm_gicv5.c
> > @@ -1433,6 +1433,7 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
> >               /* ...which means VIRT_ONE_N is also RES0 */
> >               v &= ~R_IRS_IDR0_VIRT_ONE_N_MASK;
> >           }
> 
> Looking at the code path it is obvious, I wonder why compilers or
> coverity didn't warned 'v' is set but not used...

AFAICT, 'param @= RHS' counts as a use with -Wunused-but-set-variable in GCC up to version 15; GCC 16.1 adds an exception for this and should warn.

Jim

