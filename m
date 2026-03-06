Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226FEF01814
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyREv-0004SC-Dr; Fri, 06 Mar 2026 04:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyREr-0004Qw-7W
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:12:53 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyREp-00083y-Hv
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:12:52 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso11152777d50.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 01:12:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772788370; cv=none;
 d=google.com; s=arc-20240605;
 b=HkDg7RKlmWHmVovx8t1B0U5oaFvUrFMpv7HPgV1qYoXsF4TnaUk9YcZhje1w1dG40G
 IRvfPuKjjCxZZJxzl26W9BFLnvOdrHH8Hx8wtyoenH+UGQ2Htxoc7AGIq79ZhxfDLnQW
 3YbcFTxkHRzbY/EPtIRgW3pRDsueo0/YxpHuZ3M3DzI1rPwuyKeDee5kbXHjbRHyQGC+
 NZgtL/GTVmZLLUthwKDS4Rp7VqighQiMwC6zOC+R2ckZNpeCoAIEtRjDRZ/6tyPkHm/+
 TOBSvCnPZjoDEnHbzh11YEqsS3hnlhefKt4/Y2PHVsGaWYWvcQalGQ+yiC+HJwY024Mr
 YYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tKLJ5+fiyUnNHmV9IryplIWI4j0jIDkQvWn3V9Nn/ZU=;
 fh=jjZEu7rw45pNspIPqJIQrqSqcalXiWsfo2bfFRX5zu0=;
 b=WldMc0r8v0MrQfY56/LqyT1R11TiO1BhBf89GGCaWu/SzK+CvzgRLHN5gWZi5uUQwn
 8k/xadRcIu9vo7ccVCMAegiSsxlcRa9CgvkOq8G3upMOio7G2J2k+ch7z3xJDqrBYgqi
 pQOQXgFNFGKsW9vUppgWyB9eeVTjE+/XSzvpl94U3QFWoeyUGpn1KlENn4Vn99IqZJCr
 UduvJnB0JRsb5FCAz1hgqMQeQrWDuUd4teicRW0SDlLUgiiXc3seQti+ki3IgAO+SBH2
 UGmuYFvFOKktftDTcyyuUNuxd3RQa06b4vOpjwey4teCLP/eU2NmbJRgA/bp4Y1nV2Pj
 eoIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772788370; x=1773393170; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tKLJ5+fiyUnNHmV9IryplIWI4j0jIDkQvWn3V9Nn/ZU=;
 b=nYYWU10GtKchy9nMp20fN+hRdV0WTeTJhNPl/yurtC6PqE+f5aGpoX6qRSwRiKQbGw
 vK0Q+rB9b/rpu1M08mXsAABIh5+CKHir0BsMMHTE9U/z4vHGJ2uJcyleEINKDIwKl6mX
 RguGSR/+Zy1Wt9DZKZ2sYUVAS9I8MBq1jwGR+erXe0qzJRBK2/O+VKiHEaN5+EmK+hRq
 kQpcaQ0KfOVVRlkPjUk6wesN2VsWaP5xjD/TYTWF6L0DxyTHomIUVDijQy8XmeuSHHce
 S7Z6phT2y/pm5U2Txy+7NXoqyVcL2Dpj5uBSqb0m7E7TBnw4g/MGFTpn398bABqucJr7
 6N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772788370; x=1773393170;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tKLJ5+fiyUnNHmV9IryplIWI4j0jIDkQvWn3V9Nn/ZU=;
 b=VhdKvQJPnlHjcKT0aPfbmZYoG5UagRZy6IrOIXU3/NUId63ZOKhpAaJVlXruPvraOh
 M7T4Nj6QagTYKjz0UYbUyqmJeDSkjLacbzwLtPjwlE//SawomFniTi7mFC6leqSlHa7D
 Wwzk9ubRSM2mx5kZuR8LHGffw2a56LM9RPVVuldn/EL7ycB2KzSkaIuszjqG8m5F/g3X
 FaeHU5Z5+xIB/UHRxZVnIkn4/X2tpMvztoJY3OmmIxosXGnbYfyUlRxO3yKdmZTzIqLf
 PX+tkMGn32SyirUtvHJq2ubVUlRHq/E1GGptL11Da+oRkDLYgsrFxSCTNmc6wXWMPhev
 PruA==
X-Gm-Message-State: AOJu0Yz7FdxAH7IRzHXht+7OvTgqcCOnhuA9GVdEPwtCSQ8/emXCkCvT
 h2nJui56miu/lD2G3SX/eRpPBuZelLmmgEYh5AhERPSUeH9RATbvg48h0U9XlfAHXuY6Ew9UyVO
 lHjRY0FbSaUnLnRditozhge0+gBf5QtWN5uq9Q/BNWw==
X-Gm-Gg: ATEYQzw7gmaE5nGAT0MDbkyaOgpPa4AhM76/VTPQ6WjJpcc0HKjbnwpG7bjTIiOCkNt
 LKaoubmcQCYJmDzdSM8FqHdP1pat7bYfKQVzMzsVWXiByNr3hngbQ3QbO2lT6KF0kVraUYjLK2D
 uhs6oTMcaThvNTm6VvyJUWmu6Ll1Qb6YXRB1z+NtRr4UvEyvkVUUXG4koI+9VHi08v0/C6kUVK9
 3YTWO36OYYduF4x0o2CYJC5ZcfCnf7wY0Y6aZMw/JPbAjoKk+PHcoe/6j6nlL1ZaUUPVOvqJ5Ae
 ddATdx7BOi+6Az+GBgD59MmOT/d01CQ7EsEu1uAd1ngZvdeRLDACGMPvgBp7vTeCEc4=
X-Received: by 2002:a05:690e:128d:b0:64a:e62c:16d0 with SMTP id
 956f58d0204a3-64d0715a088mr4764121d50.25.1772788370232; Fri, 06 Mar 2026
 01:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
 <20260306083113.74177-2-mohamed@unpredictable.fr>
In-Reply-To: <20260306083113.74177-2-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 09:12:39 +0000
X-Gm-Features: AaiRm51dYvL5TEy2KcesCOtpGU6nJApG51IQ10CD9Z3R0p8zbYDeO3F_ZSE0Hps
Message-ID: <CAFEAcA8CpS4_HdTRQmPO+1k4ZktRifB2HcObNdWkTS-ANqZtmg@mail.gmail.com>
Subject: Re: [PATCH v14 01/19] hw/arm: virt: remove hvf_arm.h include
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>
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

On Fri, 6 Mar 2026 at 08:31, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Having that include breaks the build for Linux after inclusion of SME support.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  hw/arm/virt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index cab2e21e8a..7456614d05 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -71,7 +71,6 @@
>  #include "hw/intc/arm_gicv3_its_common.h"
>  #include "hw/core/irq.h"
>  #include "kvm_arm.h"
> -#include "hvf_arm.h"
>  #include "whpx_arm.h"
>  #include "hw/firmware/smbios.h"
>  #include "qapi/visitor.h"
> --

Regardless of what we want to do about the compile failure, if
we don't need to include this header we should drop the include, so
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

