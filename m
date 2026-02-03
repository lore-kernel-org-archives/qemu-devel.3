Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE40E83040
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 03:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn7L3-0001yD-0X; Mon, 02 Feb 2026 22:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vn7Ku-0001x0-8M
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:44:23 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vn7Ks-00046C-AK
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:44:19 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2a77c1d5c3bso22790205ad.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 19:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770090256; x=1770695056; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XZLfgFE6MKBPPnrM/khUe8dh84fjWHNXRMOZ3I9D3iQ=;
 b=YdabzuybQbos0SibGkdw5//P2AwZyoH6UMUerGQtvm3Ws3J8X7vP8uRb9uZ8Md5ZFL
 CpuZ9LU6KCaQrJm8uv9UCw5bOML1WGNxHeJcnXE6MnLglLSXApCby/0vgb7XYgdZ0/Zn
 GsK0Es6I7owr1QchG7wJgQltC34j7wax1gy7aUwW+Hotetoq+HoX4DpNQ+9U0mZPgBu8
 foaB0cVzFIz8vZKDppBXR7CfoxRRwSxw6BENrxP7fovKswJ1pmmY0JLYC2aPECp2dtvO
 DCxU0z9EIDtDb0PhENf7OAdui2r2h+8XFpy5Ru5pWK1YyWuRnDNvqXnAaBFOUzgC1bTl
 oe0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770090256; x=1770695056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XZLfgFE6MKBPPnrM/khUe8dh84fjWHNXRMOZ3I9D3iQ=;
 b=aYVPgGyqkZX8uEksXevb7GBy7ALrvXl/JLSBgjhubQih0zmMZfj4TH8MWBJAzZPaNP
 YM/2/o2qLY17ZXt0h+tfIv5JXJLGCi9RGCwTgxSot/sCqbYaTphqw2fkxiUf5O+guLKm
 ZKVkKmTlg/pobFnhnV3LhqaK0NDNnzOk33wwNqwNWCI7Xs6d5r4dGYz+BqXS1wAay8QG
 DOdBUecFglWdjvKM+ACMJOtDSR1OnDZIQNBaehZzulnbBU6/AfHAOtuGzi1DQ91wvzUS
 Z4TgUq+St/70l+XQYgR+jF6WOg4bTL546TgHaMzLYlmliCNwLkPxlbPSRmKdYsDwG1Vu
 flig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiePMXdl2p8oZARt4E31YiH89RUJDFG+/eIRxkH5YaWE/7+kHh6dAh0AW+7UMsSZ//F+PsTOXvTWJI@nongnu.org
X-Gm-Message-State: AOJu0YxSM0QePb7xEzyTXP1ccv1GlBTgfYHia8V6We2sSnQTMzTzAc9q
 S/039Z+sKx3yI7u+StTxoRIabp/sGdf6gqUZhkYmVAh2XD8KBZtBIDE3
X-Gm-Gg: AZuq6aInLDp46dTooN4mIve3V+Wwd0sB8qRe3+gjDBqtYdr6Tn0U7UkR6jf2BbV64Pr
 tnv1W1Dufa8TEPL3wYTPVKrhXFIsnm6b8YjOqjM7dZBaQnzglLUyw5O8TCB7tBfmy+/W3Z7SSE/
 BckDvSsLEKcm913sdUdb1QBXODBoYWNTGulGk430Xb+GuaQnaBO9iuC48javbDxUnanuwNmQjV0
 LHFANkTc64KJ9OoK81kjwnXWiXWMcVKtrlGZstB1WEQ6Bm6c2PWqv4UqyrWvmiZJNaJA7FERZ29
 jmWAo27+0f5064jmiO7XiZyEZOVlp+awGVc3w1QPTozGJ2r6v4sScvFpMOKCCUu56+gspIf3EjR
 9td75aq4eOER6FzoRv3ijFwnu4bL3YtNxU0JG7SNPp6BT5S3zyerEnLbccgGoT6xlZJ/79dMQY4
 rcqEG1KSkbpVpWap/wAXu+XRG5OBmZNipo/uFtTc1VVYEeOb02SwHtGcRjZDUqkM/sP4517tyE8
 Q==
X-Received: by 2002:a17:902:ca8a:b0:2a0:be7b:1c50 with SMTP id
 d9443c01a7336-2a8d9698e79mr102933905ad.14.1770090256066; 
 Mon, 02 Feb 2026 19:44:16 -0800 (PST)
Received: from b962e8cb79b7 ([43.139.160.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b4c3df6sm160070565ad.49.2026.02.02.19.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 19:44:15 -0800 (PST)
Date: Tue, 3 Feb 2026 11:44:09 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, hust-os-kernel-patches@googlegroups.com
Subject: Re: [RFC PATCH v2 2/2] tests/qtest: Add RISC-V IOMMU bare-metal test
Message-ID: <aYFvCaE4MQyRcRIm@b962e8cb79b7>
References: <cover.1769678103.git.chao.liu.zevorn@gmail.com>
 <7cc1e085432336463dd19e11212cda516b97a33e.1769678103.git.chao.liu.zevorn@gmail.com>
 <47268fe5-32cd-4d97-bdcd-2d349d3bfc2a@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47268fe5-32cd-4d97-bdcd-2d349d3bfc2a@phytium.com.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x642.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Tao,

On Fri, Jan 30, 2026 at 11:49:11AM +0800, Tao Tang wrote:
> Hi Chao,
> 
> On 2026/1/29 17:39, Chao Liu wrote:
> > Add a qtest suite for the RISC-V IOMMU PCI device on the virt machine.
> > The test exercises bare, S-stage, G-stage, and nested translation paths
> > using iommu-testdev and the qos-riscv-iommu helpers.
> > 
> > The test validates:
> > - Device context (DC) configuration
> > - SV39 page table walks for S-stage translation
> > - SV39x4 page table walks for G-stage translation
> > - Nested translation combining both stages
> > - FCTL register constraints
> > 
> > This provides regression coverage for the RISC-V IOMMU implementation
> > without requiring a full guest OS boot.
> > 
> > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > ---
> >   MAINTAINERS                    |   1 +
> >   tests/qtest/iommu-riscv-test.c | 279 +++++++++++++++++++++++++++++++++
> >   tests/qtest/meson.build        |   5 +-
> >   3 files changed, 284 insertions(+), 1 deletion(-)
> >   create mode 100644 tests/qtest/iommu-riscv-test.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 830f56376b..73daaad841 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -349,6 +349,7 @@ F: common-user/host/riscv*
> >   F: tests/functional/riscv32
> >   F: tests/functional/riscv64
> >   F: tests/tcg/riscv64/
> > +F: tests/qtest/iommu-riscv-test.c
> >   RISC-V XThead* extensions
> >   M: Christoph Muellner <christoph.muellner@vrull.eu>
> > diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-test.c
> > new file mode 100644
> > index 0000000000..5a86b18db9
> > --- /dev/null
> > +++ b/tests/qtest/iommu-riscv-test.c
> > @@ -0,0 +1,279 @@
> > +/*
> > + * QTest testcase for RISC-V IOMMU with iommu-testdev
> > + *
> > + * This QTest file is used to test the RISC-V IOMMU with iommu-testdev so that
> > + * we can test RISC-V IOMMU without any guest kernel or firmware.
> > + *
> > + * Copyright (c) 2026 Chao Liu <chao.liu.zevorn@gmail.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "libqtest.h"
> > +#include "libqos/pci.h"
> 
> 
> libqtest.h and libqos/pci.h are redundant because they are already pulled in
> by libqos/generic-pcihost.h (libqos/pci.h itself includes libqtest.h)
> 
> 
Thanks for the review. I'ill fix this in v3.

Thanks,
Chao

> Besides
> 
> Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>
> 
> 
> Thanks,
> 
> Tao
> 
> > +#include "libqos/generic-pcihost.h"
> > +#include "hw/pci/pci_regs.h"
> > +#include "hw/misc/iommu-testdev.h"
> > +#include "hw/riscv/riscv-iommu-bits.h"
> > +#include "libqos/qos-riscv-iommu.h"
> > +#include "libqos/riscv-iommu.h"
> > +
> > +#define DMA_LEN           4
> 

