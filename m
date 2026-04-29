Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AF7FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6Hn-0003NC-Ho; Wed, 29 Apr 2026 10:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wI6Hm-0003N3-Cy
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:53:10 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>) id 1wI6Hk-0005tq-S5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:53:10 -0400
Received: by linux.microsoft.com (Postfix, from userid 1236)
 id 1FF3920B716C; Wed, 29 Apr 2026 07:53:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1FF3920B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777474388;
 bh=ulbsgmglWJFxHZVgAVotrjUU/zyHAz2tyZm6exAIthQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d2IQ4dD51yWq3a5SelZOnUtEqPe7saPoowNynIa1c8j5JbQe9mvfbbZgcijHFlPqz
 fLoZeLpJPS1b8DYUaVrzouGghnVAcNmJOeiPi5ETnf6EQgcHj7GM7vSWT3lrIQ/YsM
 kIAuCrVEi4cUR1B3sjspDI9DTIWAAzvsfRiU1uGY=
Date: Wed, 29 Apr 2026 07:53:08 -0700
From: Aastha Rawat <aastharawat@linux.microsoft.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 03/14] meson, target/arm/mshv: Enable arm64 build &
 add initial MSHV support
Message-ID: <afIbVDZwnqzu8wFM@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
 <20260421-mshv_accel_arm64_supp-v3-3-469f544778ba@linux.microsoft.com>
 <e049b50d-1ffb-49da-8d82-7ee77a18274b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e049b50d-1ffb-49da-8d82-7ee77a18274b@linaro.org>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 23, 2026 at 11:14:38AM +1000, Richard Henderson wrote:
> On 4/21/26 15:21, Aastha Rawat wrote:
> > diff --git a/target/arm/mshv/mshv-all.c b/target/arm/mshv/mshv-all.c
> > new file mode 100644
> > index 0000000000..1c82e2c593
> > --- /dev/null
> > +++ b/target/arm/mshv/mshv-all.c
> > @@ -0,0 +1,54 @@
> > +/*
> > + * QEMU MSHV support
> > + *
> > + * Copyright Microsoft, Corp. 2026
> > + *
> > + * Authors: Aastha Rawat<aastharawat@linux.microsoft.com>
> > + *          Anirudh Rayabharam<anirudh@anirudhrb.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "system/mshv.h"
> > +#include "system/mshv_int.h"
> 
> #include "qemu/osdep.h"
> 
> is always first, for all .c files.
> 
> 
> r~
>

Thanks, will add the missing #include "qemu/osdep.h" as the first
include. Will be fixed in v4.

Aastha  

