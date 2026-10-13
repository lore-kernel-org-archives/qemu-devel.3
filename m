Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AEECC6B10
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 06:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGWRl-0000Si-0h; Tue, 13 Oct 2026 02:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xGWRj-0000SK-Lj
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 02:57:11 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1xGWRg-0005qq-Vg
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 02:57:11 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c2e7496f947so410008666b.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 23:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791874627; cv=none;
 d=google.com; s=arc-20260327;
 b=P6oT+602eMLLWLkTLnnGwap7yICHODUSIGGxS1yXMqmHVl4fkSvwstsNSj4u96RCQQ
 u5m7tlhu7e8NYI+PfsEJqeGLzf5/14S685wznUCoxtIFATbV2XYIg/7cgyCJQ3bMEn+L
 OaJ5MoPBcKl6h/FsKNLl9QL19Pk9qNj1T8zLIDiLOjgVy8Ac+/4I0cMaQrsPBsxA0diD
 CqNsOi8R/BiBEwaDkC1Pi8s5C6yj4yDxvMTyKTyJGLBi/rr4Dszsb1urRN/JvxBw7sDo
 JLapEknt99FP5WzSCykyenY6CEeoPAhv/ZS/Dh+T/3GcsFdDBZvQ+GI0PC7iBUvDwzzh
 lq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yAF65vIl+Pcsu3zOYkkdhrkunAFE6hSr8dy/8TmbRZs=;
 fh=GM/I2I6fEf5qvJbdhgjZMuNCECIEwt8XqdRDAWXnLqc=;
 b=NcNG3WRmZ8MOQDNk2xx3YWFGeCHeZlS0lYUcGD2oEDv1S91ID8mTPI7a9414OIOwTI
 NIqW9nZB48WfUixiGUs42eAOxXrTXLm+ZvI4C/UCyyibV2cSQHcTiO3T1edU9/IG9hk6
 GPZJm5AJYZmnR53f+2BGqHIoOwxyaiEttp+tXb+LQM2bB2nwhmJA+FRXI66n3PyeHV0H
 S+OpJdEP7uJ+qbFJjSB1GrkhCVGT7hflOPdOEhPqRc5dUrJWe7WMfolfjHtn4lzz589J
 gbgwFbPxvw4VWXOiCC5Jw88J/7tqT1Yw4ZegrXW5N33kfObmQAQjyoAQDIDQ9GaaeaQz
 KGMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791874627; x=1792479427; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yAF65vIl+Pcsu3zOYkkdhrkunAFE6hSr8dy/8TmbRZs=;
 b=SbUpZxRGXh34TjbnwxhaaSFhwh0IdOBvEuwRW8DkOLXo61K6CMOLZzY6ODxJEV14cG
 hckbGgRONLVd2+ibUtY30VXXfR7qY1jjGEHaMnRhju64qv83pQzJ2UIYfOTwREX2PNNA
 njT3KJsywZnjB/GgroIb8Bq94RSg//IgO9qAsA+nZL5P6raIpzKFcu+MeiiaveWAPDhu
 kqsQO1IG1OlivcdnS5tq9wGayLE/pXaXJS+S+BIN/7pMhVQ/Ygmt2KXk7gVFWTVkFuY/
 dTWGd/8z3EqWZyg2x83KwkhLvrWyISMT5XDcjoMUk4Ywg43rE3vBxdijkTYjr/ic+fBj
 tOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791874627; x=1792479427;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yAF65vIl+Pcsu3zOYkkdhrkunAFE6hSr8dy/8TmbRZs=;
 b=U+H9rTe2cctb6ddlyqLnhoYpKqecFu1GGFbe2STVVvYe9cFpulstwrut4IrmRm6ZKi
 EFgwcxhHytc5bnOtMzn1zqL6VRpZOyqNevmLVmd3ONlopdFxTXcfba9l1qmoCkc6IJba
 /iBS9l/WFYNUxQl0r7epgPoMLn+KwllDqFeVaSeyWzUjcej1rLXW9A/nQ78SujopMawR
 +aSYzgnpvpF/D7k7NL+GjsSgk3pOXliF8YTo5h/PczyNc7TtrEWE0f8qHjdxdHqKde09
 dOcVTEikauqkLn7myECfASKiz+nL1MgE/NLMj8sC9AeX1e1IY97zmb18tgtJyBdZGlP2
 DaDQ==
X-Gm-Message-State: AFq9FYKw/vR2tNrmOxugrrNl3jBvQlNOIA0ez4Z5KnoTFtKaTDKetI1l
 NsDzeAF7EDpRKRAN+QFdTGnDnRTHQ9X1ghLvIydYAzYpDbY9so+hcMyfN4DiVxy0Q0jl4FQE0a1
 8eP57RrhmWj6AXC2COdwyByw3NATl22s=
X-Gm-Gg: AYBFou244NIbIi8ONqYE7B77eHHq58qxaTaX/YcQ3ZkIvH/Gw4qnSSoCu6xu7NIkfkG
 q56oW5ujoULT54AdcPKqTt6T3mM7I3R/RuzshVarpJAXyBjPuwv9xJeLkKYHa7azd2f0WKKeHw3
 VNk6GxsInrGMNtdk3+6BvoeNuCBQLyv9GlIgllGfrYDi+2YgYHPZy7bk5ifHaSC7OfLkF86IE3b
 yhF5R9PbihRyA6sVhhJTdGUYy7yan+ZKcIK/icb9sd6RI3QcbwwJJ1Ka0jHF254Ofhb0Ao5EULq
 5Fyu1CAnbmD3VVCuIS7Y2U9XLOoZ32PBCQTZcEcuYi4LkI16DCt1mzHL
X-Received: by 2002:a17:906:4fc9:b0:c35:d261:636e with SMTP id
 a640c23a62f3a-c3667073d72mr183803166b.18.1791874626719; Mon, 12 Oct 2026
 23:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-1-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-1-4c3dff084ec9@free.fr>
From: =?UTF-8?B?5p6X5bu65piO?= <jaminlin1207@gmail.com>
Date: Tue, 13 Oct 2026 14:56:56 +0800
X-Gm-Features: AclHuK-iO7GDPciJLqtJlVfRWCT89sEuQ5uPrEZdf-6ZUjsaLdfAwzuvIe1aHyA
Message-ID: <CA+8rw5ySLv3XbwcNwr2Rjj+6aSbAh_QX18O9ibr1iA1fUe=k1Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/50] docs/system/arm/aspeed: add the catalina-bmc
 machine
To: Emmanuel Blot <emmanuel.blot@free.fr>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=jaminlin1207@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Emmanuel Blot via qemu development <qemu-devel@nongnu.org> =E6=96=BC
2026=E5=B9=B410=E6=9C=8812=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8810:=
55=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The Facebook Catalina BMC machine is supported by hw/arm but has never
> been listed in the Aspeed documentation. Add it to the AST2600 machine
> table.
>
> While at it, shorten the document title. Listing every machine name in
> the title duplicates the tables right below it, and made the title (and
> its underline) grow past 350 columns. The machine list stays available
> where it is readable, in the per-SoC tables.
>
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  docs/system/arm/aspeed.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index 2d51ceeb84..933df41f96 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -1,5 +1,5 @@
> -Aspeed family boards (``anacapa-bmc``, ``ast2500-evb``, ``ast2600-evb``,=
 ``bletchley-bmc``, ``fuji-bmc``, ``gb200nvl-bmc``, ``fby35-bmc``, ``g220a-=
bmc``, ``palmetto-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bm=
c``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``=
witherspoon-bmc``, ``yosemitev2-bmc``)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Aspeed family boards
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
>  Aspeed evaluation boards. They are based on different releases of the
> @@ -33,6 +33,7 @@ AST2600 SoC based machines :
>  - ``fuji-bmc``             Facebook Fuji BMC
>  - ``bletchley-bmc``        Facebook Bletchley BMC
>  - ``fby35-bmc``            Facebook fby35 BMC
> +- ``catalina-bmc``         Facebook Catalina BMC
>  - ``anacapa-bmc``          Facebook Anacapa BMC
>  - ``gb200nvl-bmc``         Nvidia GB200nvl BMC
>
>
> --
> 2.50.1
>
>

Reviewed-by: Jamin Lin <jaminlin1207@gmail.com>

