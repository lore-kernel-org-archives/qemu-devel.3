Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACB6FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHf6u-00035K-Ms; Tue, 28 Apr 2026 05:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHf6t-00034n-2V
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:52:07 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHf6r-0006fd-KJ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:52:06 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-654672a6d68so5625065d50.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 02:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777369924; cv=none;
 d=google.com; s=arc-20240605;
 b=MktmqDJjfSnQLIJihT0LJff8q8Kpg0upQH2ncSiD+PFu5PBhJdirMtLTqzVyOVM9R5
 9oGZyiUeSB/XIs3joESB91rVi0NJn4lruwbQ1oamzcWsN9s9A1fzT1jSv2ydYmcH7DJM
 ZaN4gYoew/Kp6l56CiSHr8IaRhpwmn0zJykOHrhZDPEDgGY+0ZEdDe+RH+RZUpcXDBww
 imAiFbPzjjm103QdgNgPv3N6pUBEp6Xwbfh4eFL15TZstL9B8Rp+wS2WNedmSh5D2YuW
 sqZA26fcNi+B4VdXkMDM68a6adtWuQzrYhEG0g2j5sy/HcaqbqZ5H1PuLF43DvRyA98t
 +JKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Jf83sOe0igZW+OLTsh7KdIXlnA6gpK2sB4ZNna8MjBY=;
 fh=BBXXBmZbsnh1iUcPA7aYGot0GnoKedpL6BO7ZAJRQVM=;
 b=Kqoin7jsH401306KtV38YTPyylOEZk22H6vQZwR9rmVD227TX8BhsSTopFvTlP3UEU
 DyKVA8PGTm1aM4trQbCIOcDsq9sL3KsE7GVr6rQ8CkqqiA54RkIjKkly28FWVUX+njYe
 F8ClHbPYD48z3Ti0Y1h505+UgcoiW/x3r5okHNfjJkvrxZ1ZvZULVI4gPIw2bu8iFmhx
 IUdwukz/ijdcH0S6RC3rAKevt2z8wZbWdHEmctc3uRvQQQT+JgG4nYldWjdgCF4jEppv
 yn89cWC225rOiFiqx1KbW0b/C5CAAR5emIrGQNXcymF5Hg3bfBoBPBv5lG83lS0UaRQi
 HOEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777369924; x=1777974724; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jf83sOe0igZW+OLTsh7KdIXlnA6gpK2sB4ZNna8MjBY=;
 b=EKJB1l9KO+snjTd6eRM/5DLCoW7svOqmKFJUIC8RG4AyjKqw/0SweiDudlOJXkt1kV
 Y3VLt8H5Kx5stU5kIoY8rTik8cVgbKmXINfNAEfAJBCdfX2/weU1GvlOtJITJCT7y9q1
 40AUlcKnH7GbELi/5qHumJ+hGlPYgcPYG86B8JgjrmETbZnot9yzqT2Q7jMzu917U8UX
 qcaZ1S8flY6JBu/EeiGJoEHC/szFtnTd5OJvleUGbfaDBzlDMzJvCfiXu7BBQRYTZ1QQ
 utKWu33KEssOvhhcQHbS9WvUTdUrRvST5aOSV4njDMDAlt4xeWXxeRO56i1K0f1oGNop
 yyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777369924; x=1777974724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jf83sOe0igZW+OLTsh7KdIXlnA6gpK2sB4ZNna8MjBY=;
 b=LQXgIAzRvHvKQljb11/tldGThzp9U27B3d2nBve8+i4J28uuhq/v2HQ97qK5OTnpv6
 8v7XW9xmV46GWJUNt8lUcv8MqJF8tZLn0S2X0mmuRAnhz5XH/Bi2i7/8O18B8WFBUR7K
 jhcj8N/XyPbPjL5GF3K11XIOZQIlN7cJ9/pJzSYR1VCS7MjoT8RfSd7yN+6LyKDwqgv9
 A6b1mbrjoNu4NqUotZwsUT9T7+YLatLO75uyLmJ2Is7LGgsJqKAxXNxXqodzbainVPJe
 lY36G8+s8Jy1cicj15L5QqkJhQlhGvhLu/vU/wc4vfBTOE/DzURvH4sboGSMEixyorHO
 G+Aw==
X-Gm-Message-State: AOJu0YxF8ktMmwABZKCwWwHY/b5OPq6n69PrZPTl5aO/3m3coj8VB6P7
 /uCAvGcPMWYWSmFmvf0RPeYR5RdwUanV4megYrdLbtTSN1fUIdXSlTbQh2O8PFh6u2MIvtEsgHh
 d1lESJtBF1fWVnHfIOPbyCwUJoZ8oGHhYxPEqF/rIoQ==
X-Gm-Gg: AeBDiesmeY0tkCnNlxKaxTxdVelx+pwT4GPPi0B5UKafiKUt1ISx2PpWvw/ze/0uOGV
 a2Fa9q0HSR135JhSf3wEMaNjrFVEISbc85oiegR1UCpjF6tPfJ1YfIWzT61O3J+GoHHuJAzFJH8
 8nIKTNNjaJNjYPpcTiU/4bCXVvotH1qL19Xc64WUKcwrmGPf43W4R9m0bzaCmWhGSz7zQ62SHQI
 uZ9dinfNbsomDddnqAv2O52+HWXuNhCelZyQU7uG+pOGb/sTjnmN2aKNTcTa5Ozj0UZux+tbCsd
 OqrQ5PM9YWxzGI/uMks3JStP/j2y7UTl/0UcyjzI5fhO5v4fnIzGrhWmZULqF8tBu8IEulrWJW0
 LEQ==
X-Received: by 2002:a05:690e:4813:b0:654:a4fd:ebfc with SMTP id
 956f58d0204a3-65beed4b37dmr1477104d50.5.1777369924253; Tue, 28 Apr 2026
 02:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260308203516.160103-1-shentey@gmail.com>
 <20260308203516.160103-4-shentey@gmail.com>
In-Reply-To: <20260308203516.160103-4-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Apr 2026 10:51:53 +0100
X-Gm-Features: AVHnY4LN6oyQ5hgpGpRcO4ZdokEuLd-PlagZ965MDMbtumluQ7kS8dcp9G1gEZw
Message-ID: <CAFEAcA_BFzFSOrXB9DorTftGYVmvP7gB8_+14fpwGEC6vasAeA@mail.gmail.com>
Subject: Re: [PATCH 3/5] hw/arm/imx8mp-evk: Fix reference count of SoC object
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org, 
 qemu-arm@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Sun, 8 Mar 2026 at 20:35, Bernhard Beschow <shentey@gmail.com> wrote:
>
> object_new() leaves a reference count of one, and object_property_add_child()
> then leaves it at two. This would leak the SoC object if the machine object was
> destroyed since the machine is the SoC's sole owner. Fix this by converting to
> object_new_with_props() which gets the parenting and reference count right in
> one go.
>
> Fixes: a4eefc69b237 ("hw/arm: Add i.MX 8M Plus EVK board")
> cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/imx8mp-evk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
> index b84ac91a17..cfc3038c36 100644
> --- a/hw/arm/imx8mp-evk.c
> +++ b/hw/arm/imx8mp-evk.c
> @@ -74,8 +74,8 @@ static void imx8mp_evk_init(MachineState *machine)
>          .modify_dtb = imx8mp_evk_modify_dtb,
>      };
>
> -    s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
> -    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
> +    s = FSL_IMX8MP(object_new_with_props(TYPE_FSL_IMX8MP, OBJECT(machine),
> +                                         "soc", &error_fatal, NULL));
>      object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);

There are more boards doing this as object_new / add_child / unref
than with object_new_with_props(), but doing it in one call seems
better than three.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

