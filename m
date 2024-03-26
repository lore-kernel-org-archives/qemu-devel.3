Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E98DC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 17:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpAcz-0008A9-AT; Tue, 26 Mar 2024 13:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpAcw-00088G-6a
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:30:22 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpAcu-0004hI-AB
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:30:21 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a44f2d894b7so714208266b.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1711474218; x=1712079018; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uNR6ZmVTy1I7k4lM5R/62hpX5yWv9KwM07BigfA2l7o=;
 b=DerFuxpTyd4xfombXVT3VwrrybCWjy4S7g+Am85FCpTHAufO8JbsP2kW4SBonELu/N
 5b93ET4OvSoZQ1sei4L/Wl/BCpoIUYhLq7TCE71Ci7pRHL8V5bNBu/G31YFnCsvgPxlE
 tAf0eHROq9avX/eAV3HZunQ5a9lUb/1NMlqwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711474218; x=1712079018;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uNR6ZmVTy1I7k4lM5R/62hpX5yWv9KwM07BigfA2l7o=;
 b=Evl4VJ6YSuGZ+dtANeU0PsdvJb7SoOz9NKZz17gH9BKHfeUug3YH1JnfQonI/6RQ1T
 WjFUpgnAHkFgPav8eqnAFOK3OTfzgHyqJEzSq7pkZfu1wxIn/bEDfXoF2YPHwzrnTZJg
 0LkecExhGVBZKssUU7qO7CLbkcCOwIi7uBH4vW+2VSGpYhgUQJcumFEpW0za7vbbdUtJ
 7K3sJOfl0TNNv7BHyHHiqwfuLV5GTW4XybLpXZ7xcjdUWPO8vW0PFrN2vn/MTsAdYpFv
 dG02oRs8uAOt+ZeshwXFlNr1Xr5OH6klw9mRVxAbyd0LrNRcX8V0DlRmg5Bd9ftqfrpQ
 dyQQ==
X-Gm-Message-State: AOJu0YxhwzS+N50egPCgt9gppkEtDDsVEkj3N0AqZFXGWjBsXCJb/i1m
 JjablpVY+Ti3AGIVcI2aJKAJsdZ5waarvzobYljjN7ovufKpJ3Tey1p+rYkKy6YxJrYI30Qocwk
 M
X-Google-Smtp-Source: AGHT+IED9REL4AtbJHtg5KJCIkZv/TLyb2w+DD5qURrER6A4z01CVxLs3y3++VhhpbvvZ6RL62iyHw==
X-Received: by 2002:a17:906:29cd:b0:a47:5103:2d3 with SMTP id
 y13-20020a17090629cd00b00a47510302d3mr2629185eje.9.1711474217734; 
 Tue, 26 Mar 2024 10:30:17 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 u1-20020a1709063b8100b00a46fbff47a6sm4421282ejf.168.2024.03.26.10.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 10:30:17 -0700 (PDT)
Date: Tue, 26 Mar 2024 17:30:16 +0000
From: Anthony PERARD <anthony.perard@cloud.com>
To: Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?=
 <marmarek@invisiblethingslab.com>
Cc: qemu-devel@nongnu.org, Jason Andryuk <jandryuk@gmail.com>,
 =?iso-8859-1?Q?Fr=E9d=E9ric_Pierret_=28fepitre=29?=
 <frederic.pierret@qubes-os.org>, 
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 2/2] xen: fix stubdom PCI addr
Message-ID: <26006034-dc36-48ff-991b-898596bc2351@perard>
References: <20240305191312.321127-1-marmarek@invisiblethingslab.com>
 <20240305191312.321127-2-marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305191312.321127-2-marmarek@invisiblethingslab.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=anthony.perard@cloud.com; helo=mail-ej1-x632.google.com
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

First things first, could you fix the coding style?

Run something like `./scripts/checkpatch.pl @^..` or
`./scripts/checkpatch.pl master..`. Patchew might have run that for you
if the patch series had a cover letter.

On Tue, Mar 05, 2024 at 08:12:30PM +0100, Marek Marczykowski-Górecki wrote:
> diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
> index 8c6e9a1716..8ea2a5a4af 100644
> --- a/hw/xen/xen-host-pci-device.c
> +++ b/hw/xen/xen-host-pci-device.c
> @@ -9,6 +9,8 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
> +#include "hw/xen/xen-legacy-backend.h"

I'd like to avoid this header here, that would be complicated at the
moment, as the global variable `xenstore` would be missing. So for now,
that's fine. I guess that could be rework if something like Philippe
talked about at
https://lore.kernel.org/qemu-devel/429a5a27-21b9-45bd-a1a6-a1c2ccc484c9@linaro.org/
materialise.


Beside the coding style, the patch looks file.

Thanks,

-- 
Anthony PERARD

