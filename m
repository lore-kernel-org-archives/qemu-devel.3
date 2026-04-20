Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2700EF5A8B8
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEuzP-0003gH-MX; Mon, 20 Apr 2026 16:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEuzN-0003g3-3d
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:13:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEuzL-0004Bf-Eb
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:13:00 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so25780905e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 13:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776715978; x=1777320778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SYVYGLv+vwoNpHesJVFj33FWrAlNal7SsLu4kzVmOaA=;
 b=qAmfYeFt39dYsUwCB1eL/rReIo9HDsrHswO+otXei2m75ExHTmI1UoqB955jVetosm
 Nol/+hWpVbsfu6MNk3VyvwThGf59NOfYyecTS6b/uZaY5hPR5VmBfNkZ70myYXAubKlS
 rC1B2GW8T+UO2jqHXQfXL14UYrmh+u/+/EavLzHDMXKc0CihW+l+ibM9avcSFo8q5J4F
 twSCGs+7MPU6N2/WIc/Flk/Xvjn6bvqNAZnr0Vj3Pso1kYG+2nOR7dVv7ztb5JZluIND
 uPmkhZkN9AV7IL4L16eN3+Po+6xR0em6Gc5qNivoo9Tq/79G7obtPKSy9kSCuQ1RPtbw
 0TZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776715978; x=1777320778;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SYVYGLv+vwoNpHesJVFj33FWrAlNal7SsLu4kzVmOaA=;
 b=mRj3q9Utt7D0S6zdgVu5oQ8Edk+c5Dg0sv924x+QSx8VRz5PEAwirCY7FlxDdwEacx
 G/8OPoJzWpOMV4Z0Siry7e5CL9T3Yi4TOATidVwYzhQPsChV7Pbrz95DJk/rZ1h763TK
 y8Gx0ZoT73eXuxCdWbKlWM7pY4F3I+3mPIOErlWu5VUECwNEqFnppt7421T+acuyo0zr
 ZDkHiBH29VqeNCqcI7rvRFGgY4tdpxQDtyr3vY+0SH12F12npVow8Onp50x+Efw7E1wM
 bWpll1RITBexKNw0CjC9F8Ri24BtORj9GBPKuGrCVuHOq0FaUHzacsxwuNvNutLhK2Lo
 ob8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hpItrBTYudh0JZ6fVpnGqpZduz8blMGVIndfeRm1Mxkp8aCjBLitQus8VUQ2bBJS+ak8X0xEbDx9F@nongnu.org
X-Gm-Message-State: AOJu0Yz2EjqNfPGZUWnHRv2JZ5X75HinjUYTWRV3swRmZpeI8BT5bAEa
 vOjAz7sDudnyjSpxh5BliXZlXTJk8W4UN3uzG03qHNMSTAFe4oAY8nR8q4lwVxhF2+Y=
X-Gm-Gg: AeBDievD6aQT3Ti7lY5Lr3bl2HHCVuwDgEm3Ij5jaRGHyjRL4kKyqmhyTlaZROE5+qY
 CcrsnZdg6d9ssOBAX9i8xOXotBXMjLmiamCpxrtw3U+TIcDgf5fZbVQWJKJA+CRaMRmCK1X5xCg
 Jf2ZnlYj/EtW+DLjH3bMGCEoWZ/VMVam91UsN9HDHxaLZHSEZLtO64ogvZ1U9OnJ0TFKxEI8E3i
 Ozo+haYonAyswWdRkyfXnzNrcZHyRq2ddsRtpwL+FMSrV+B3eFd5uGkfwfgo7t1VpBWVWyxlh9C
 w6ALJB5231ATblQV5F9vrUFpETMOAjEGSMd1d9dr220EXs6Yd1mk3msVZ2kQWuUDkV9YKWcSfBg
 1iHv2db9moJQMAqiSFIgbhooSjEHG/22sj+Tz+KG4SpQlKH1AqWkZkXAsgxyY0iYZEZmFpMCtnF
 u2qhV+qrHirnrYVpkeUmR/41lPUH2DJaXdWLo+eHeojOgKOMwtqzOVDbHV0UsYkGfT6DGYZ/IYw
 7UiFlz+5Lly7qE=
X-Received: by 2002:a05:600c:8a08:b0:488:a82f:bb9b with SMTP id
 5b1f17b1804b1-488ff369a1cmr140807235e9.30.1776715977582; 
 Mon, 20 Apr 2026 13:12:57 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm180944575e9.14.2026.04.20.13.12.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 13:12:56 -0700 (PDT)
Message-ID: <f7f7682f-08a5-448b-a936-38301a62f2e2@linaro.org>
Date: Mon, 20 Apr 2026 22:12:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386: Use qemu_open_old for kernel/initrd
Content-Language: en-US
To: Sertonix <sertonix@posteo.net>, qemu-devel@nongnu.org
References: <DHXDTYTOFYVL.3H531B0BJOQ22@posteo.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <DHXDTYTOFYVL.3H531B0BJOQ22@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi,

On 19/4/26 21:35, Sertonix wrote:
> 
> Allows using "-kernel /dev/fdset/0" and "-initrd /dev/fdset/1" (if the
> file descriptors are opened read-only).
> 
> For the sake of consistency it would be best to do the same change in
> the other hw/* subdirectories as well but I lack the means to test all
> of them.

Thanks for this patch. Note however there is a comment before
the qemu_open_old() declaration in "qemu/osdep.h":

   /*
    * Don't introduce new usage of this function, prefer the following
    * qemu_open/qemu_create that take an "Error **errp"
    */

Do you mind using the latter in your patch?

Thanks,

Phil.

> ---
>   hw/i386/x86-common.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)


