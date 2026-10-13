Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75020CC6B1C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfBz-0001cx-H5; Tue, 13 Oct 2026 12:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGfBq-0001bw-CT
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:17:24 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGfBn-0002u6-56
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:17:22 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8ac551be4d3so24713067b3.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791908237; cv=none;
 d=google.com; s=arc-20260327;
 b=pPkuEZmGiXllU6Xokgkf0vXObTYJvarUHi0idKO28Cy4wJfKTIAIgCwgzkkSpbFZyb
 slgnFlqJMkFJsMYEx5NJn3hgfnCk6vMQQ5kkeh5MpLuSsf30CVUqDRaicvAZuMTd/tYW
 7WayZu9vTc06Yoq7sA+FwJYyybyOLMcrJ/UdJqs+MBAcb6GTfMPX/zRqkcf43qf8uGl4
 gb+5ZgiPA3qxRUYgU2seTYqTNbaHqWj7J4FlMl/hMe5pboPUlh3aNJTcHtzP3LHdiMRr
 eM/gWJzWj6qOgX0hO+mZyT0XkAEWRwZ+lDd+dqurfPva6l6t5zMldhFjewaem53Z4U2k
 9pag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kgoBvoAdxeg9Tf8BY5zhua20aW3N8dGlw1G/CJAK2no=;
 fh=H0PJC8/WRFc6MzXpeYaIZyo6ULbOfgGOqW+VCXwZGzc=;
 b=N21WkKl3BpOfn7J9ZTg1OkJurm1dF9PzXAJI5P4OUQEKjyZJiEEYVKolEFY7UXREw/
 a7F/4UJgVLOgU+nLMtkkLpRqM7LAGMOpXIno0dHiApJBXIA5BDjNxnKaLuDVcSpGUUZv
 Z+1SWMPMcTtYYWPS9WZDEU9cnnNOqsRBeonkqvmF0BnR3AUEE6fuAHBz2thxulcK1jrn
 6lInmc8bdvamTteSFcrpxRPFn6sVqxVYRoXytcMFtfqSOcDd3jQsO5CmQzi7AbEWpI9b
 uticit+xkKNv3h6sv7pyc9m42HHv4jT12PqCoreMXl5We8LiF5Q69gVpAu2QQiyoAsDs
 ynPA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791908237; x=1792513037; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kgoBvoAdxeg9Tf8BY5zhua20aW3N8dGlw1G/CJAK2no=;
 b=Hd5f2779IPTF5yxV1zEscnMDe29W4WxAfRCMUnOALrAy2Ynxe3SvpM1my83CcqfsEY
 aa8zuZOXA9N0/HcOmLJ9N10jWGB1vbO64Ifqm96DrASx44iLhvzaLv284/i6mPxxaNm7
 44zT+pEgLBWzD87IneI7kVgiJjOrvgTYB5apPfwvIr4Qp0yKeb4SM7tZP8b6zZWqCgmh
 MmWVeYkpxmCA49NbXeaCqDpHe+DHu8w4YkztR7c9+1SajE1xj6uJM2NhsndmOr+ES2Rm
 lb6/O2cYDA4BLGUA+Fmktt2t/Kd+kn0SXFvPd6msL4NJ4GOguzifBdvROrBEMHngErM2
 xJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791908237; x=1792513037;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kgoBvoAdxeg9Tf8BY5zhua20aW3N8dGlw1G/CJAK2no=;
 b=Zk3y6HaCZHWcyTX/G0aiEmcLcx+QL4cvoWdZWFPX3nckcjk8KGy6foAou8TsfVKxJz
 GXwnPPBoeOGXp/lNgCGjJ/rp8+YDwqJHykWqppJbzlwmrGMn8R0yArdgfUpyWGZ/I5yk
 i7YZ5hmbwv4BWKlNQOGrtWRiadwu5TtXV6jbmWlUkv0QLyhyzzfuW9kt/Lgwtgqa7DAv
 eVKG3Kt8dCiKLyTSAMNJLgYNekfmgAUP9FEbKompNCsu0or7kMLpP946UeiID5z+Ijuo
 Nr6sII25cMM9AhlQ0In92l3e/RmYHFW2Eeun1Jk/S5OFsHVrSBD6p4Q0rMfhZsGLzGDT
 BdJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBylgJTaMj6uF8Xac4o/JfjSfy54TUGwuytB1eaypEH/EI9OKzYH/XXUarcD3OKmJ0k3TThmFQOJdvH+@nongnu.org
X-Gm-Message-State: AFq9FYL8q0Kc71pxQFaql9VTFLj3JYY9NrYjnTSALrxH483njoCwzSUk
 cUHH1VCQUSSQDePIFLyVCdQ08Ljd8CcB2QZ0lACvdDEx93WDGujyglG6zyaSM3o7Fzz+SRqiqb1
 h6K4tuYXoxJx/jcokTylqvvjq+nVpR5vOcnInSEJdGw==
X-Gm-Gg: AYBFou1QEXR/LRDwM7Ay7s2Vm5XqcdLC1mSWK3aBvlf5dP1aBM5YZvpe69Y6O36ioxy
 DWGx9eMpj16lhuNS98fr5wqCD04RLkWaSt6YEeTy2joFb/Bn9CXKo4fm05074DLAo1glFsFLoUF
 s7Rq5uaOQA1Qp6i9D6lcy8kySswmUAfD64DQFb6N1ZzvL/8872d7VbZ0SoghUZBGi9a1yNkydsx
 YIZwsWDC+fKEOu6KLxiIsb0RI8iLrCk1vQ2hm1UYya1/q3GGPoXEdWbnmBhul5R9/J0Ga6n0kA6
 /ObuB/wURoHdXCex6hAOaSBuhnJpq+1a0r2sruPgwoP/MRhtmrwZoX9rBoPFuSx4MJbTvAeqd9Z
 nLeQ32mQ37WlY8cU5EdWJ+EgjA/PuYW7Fcz4h9X8=
X-Received: by 2002:a05:690c:a1cb:b0:891:faab:ff1e with SMTP id
 00721157ae682-8b07ec9b9c9mr32688387b3.4.1791908236645; Tue, 13 Oct 2026
 09:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-14-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-14-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 17:17:04 +0100
X-Gm-Features: AclHuK-dBFJEqC_er2SVrafwbd048DTjYp8TESdTJHeoIpTuqcihJui1eCKi-p0
Message-ID: <CAFEAcA-FFiWEs3ZLztVwZ72_TGLuhEBbfKnaZ3NFJJ1W-Wd33A@mail.gmail.com>
Subject: Re: [PATCH 13/22] i8259.c: introduce TYPE_I8259_PIC device
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 16 Sept 2026 at 11:50, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This device represents a PIC for an x86 machine consisting of 2 cascaded i8259
> devices wired accordingly.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/intc/i8259.c | 133 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 118 insertions(+), 15 deletions(-)
>
> diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
> index af33b71591..fcc94e12f8 100644
> --- a/hw/intc/i8259.c
> +++ b/hw/intc/i8259.c
> @@ -25,7 +25,9 @@
>  #include "qemu/osdep.h"
>  #include "hw/intc/i8259.h"
>  #include "hw/core/irq.h"
> +#include "hw/core/qdev-properties.h"
>  #include "hw/isa/isa.h"
> +#include "qapi/error.h"
>  #include "qemu/timer.h"
>  #include "qemu/log.h"
>  #include "hw/isa/i8259_internal.h"
> @@ -36,6 +38,22 @@
>
>  #define TYPE_I8259 "isa-i8259"
>
> +#define TYPE_I8259_PIC "isa-i8259-pic"
> +
> +struct I8259PICState {
> +    DeviceState parent_obj;
> +
> +    qemu_irq pic_out_irq;
> +    qemu_irq pass_irqs[ISA_NUM_IRQS];
> +
> +    ISABus *isabus;
> +    IRQState i8259_primary_out_irq;
> +    I8259CommonState i8259[2];

This allocates only enough space for the common base class's
instance struct, but later we do an object_initialize_child()
of the child class. If the child class's state struct is
ever bigger than the common class, this will break.

>  static const TypeInfo i8259_type_infos[] = {
>      {
>          .name       = TYPE_I8259,
>          .parent     = TYPE_I8259_COMMON,
>          .class_init = i8259_class_init,
>      },
> +    {
> +        .name          = TYPE_I8259_PIC,
> +        .parent        = TYPE_DEVICE,

Devices that directly inherit from TYPE_DEVICE are awkward,
because they never get reset. Conviently this device doesn't
currently need a reset method, but still, is this a good idea?

> +        .class_init    = i8259_pic_class_init,
> +        .instance_init = i8259_pic_init,
> +        .instance_size = sizeof(I8259PICState),
> +    },
>  };
>
>  DEFINE_TYPES(i8259_type_infos)

-- PMM

