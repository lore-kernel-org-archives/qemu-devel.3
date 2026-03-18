Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9614AFEDA09
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 01:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2frV-0000nM-Fa; Tue, 17 Mar 2026 21:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w2frT-0000mL-At
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 21:38:15 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w2frR-0001sQ-Sy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 21:38:15 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-358e3cc5e7eso182154a91.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 18:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773797892; x=1774402692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AhkdhQx9aRmLL5a5QU3cytszsavGGZENJUZf7NADP6E=;
 b=gD9ojpRPLGbs97yk6juQRJqrwrX9xJi3Ir0eiEVWOGQAIRmxG+B6Ii+DjvPuehVdVk
 7IyjroXNnOQvqqf7S51XGlnizocGVTL/dW+e0p2MBNMQUL78ktQ6FqkiiK2a6cKB15d1
 t5Gj+SCVsCPXFa+LrKLWIqTe8EN2Xfcaw2ij5HJxQ6R6zdkfHppLsJ3tDUSJdfKxRwK3
 N/HbMdmtEpJLdbZpHwhlkJu5lPhjjYra9eX1NaG+BIaG8tRhiYgdt8iumSy/VKjLjaNA
 DqdDRz/sRZ48cLyccTmk6q7tiQRGQoP2EbXsnnbTj5Ixe5Xb+M1xNP/wk2AdBqLsak4P
 gMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773797892; x=1774402692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhkdhQx9aRmLL5a5QU3cytszsavGGZENJUZf7NADP6E=;
 b=pU5U7D3kSmn1YM7kpNTUEObHjAn0YJpYUMdpHVxOWUfbvHC2+eEiSplBLBGtJMOItU
 ocpyaACtqc8AXWqkW2QQVG8psJXHi8Un6TdvU6GNCULGjKcVZ7pa1Zx0s1V8uVpcmqdR
 Dnv1BM08tLG/bN+fjxXa9fT7C5ePtYxnmnHdM9aLGFY6BGciF7OkR0UYk1Dev3Tc8kVK
 agq0WbfexYFAxI9yKfy/MJvrmiG59Ly6bh4znK78lH3SdQwUHA68s6wRCWgkrpbm6YnM
 B7kYk3lEfcafhROYAoPQdMVm2RzZvGlwpjg0NxX54fhs68qd5/1eJwiYhkwEdAPf9bxr
 GQzg==
X-Gm-Message-State: AOJu0Yx4sDtFBLPZ/ZU9SjlymTKMy3yBfwmz+EFjIa9tHiezr+hwOPjI
 lf0Nmoew2LDiB2W9hkPfucgmMhtjm6Y3VUAxboiPYFQQYyRzPTaHCnnuCV33Z7MF2XceA4UfW+7
 JwfRvK0nr71ifKhGJqNZSoR4GlbQAL3fN3yvDI6tGOWTQzpBm1Nox293vUYvJvgtH2gU6UxCJ+j
 5xqashNTyXhM4XZTe/7I+8kwND5llV/3dS0YaKmbmgCQ==
X-Gm-Gg: ATEYQzwKRL1qvNhZPrNo6sP0ZWTtx9pJ/Eq4n0LYxvXIqIr/SKPZJNcDk8BNYYjuiFF
 NiCsGA9LO1peYi2ww24EqhP5nZbS4VIGAyU6/TTjX5m8U8C1F7QPIYRfa5kjJ7nFehMLk5qc8Qf
 u+kMUfGJO4bqzCuCS7tH2Ka30+PTqkmzJaXlUlVT6EiacuEGWOozRLyvCyM4vT85HrQYcsTxEsc
 fb4D48N0mhXrdh8v50iQHytUBnccwWw0eBw/e1vDETG0elCDDcESvKxZ3Kv49ijkRp8syEUkqKx
 kUA2aWttnUvonvRarYhg+2g3oKZqHIal7SHGNk3nqH5+Etn4E6BIZVu2Z9Goqs5pUVijiqbYLr2
 VL/nmBvw/yD1E0pctEX507iVbbJLtP/2yuNHJct8FIxJJ4KG0S9k8sVTlHrmYXVK64lKWShHnoC
 /bKkz4R++ATEpjcswCDcYD9we3gRhz/oBzJzK8+yOBxOuO+LMThNffsbjl4/6eJcgok/4MB/lq+
 oDiUAaYBGbUycr4DmH5xlYWYuJhER2BN94EGQ==
X-Received: by 2002:a17:90b:2cce:b0:35b:96bb:47ba with SMTP id
 98e67ed59e1d1-35bb9f5fd15mr1198085a91.26.1773797891744; 
 Tue, 17 Mar 2026 18:38:11 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba4f2321sm788462a91.2.2026.03.17.18.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 18:38:11 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 0/2] Fix probe_pages and vext_ldff issues
Date: Wed, 18 Mar 2026 09:38:03 +0800
Message-ID: <20260318013805.1920377-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1036.google.com
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

This patchset fixes following issues in the RISC-V vector
fault-only-first load implementation and the probe_pages helper
function.

1. probe_pages flag handling:
   When probing memory spanning two pages, probe_pages calls
   probe_access_flags twice. The flags from the second page were
   overwriting the first page's flags instead of being merged, causing
   watchpoint and other TLB attributes to be lost.

2. vext_ldff cross-page logic:
   The manual two-phase probing in vext_ldff had three issues:
   a) Wrong condition: checked "env->vl > elems" instead of
      "env->vl > elems + env->vstart", missing the vstart offset
   b) Wrong address: used "addr + (elems << log2_esz)" instead of
      "addr + page_split", probing incorrect addresses for segment
      loads (nf > 1)
   c) Wrong size: used "elems * msize" (first page size) instead of
      calculating remaining size, potentially missing faults


Patch 1 fixes the probe_pages helper to properly merge flags from both
pages.

Patch 2 fixes vext_ldff by replacing the buggy manual cross-page logic
by a single probe_pages call with the correct total size. This
leverages the infrastructure that probe_pages already provides for
handling cross-page accesses automatically.

rnax


Max Chou (2):
  target/riscv: rvv: Fix missing flags merge in probe_pages for
    cross-page accesses
  target/riscv: rvv: Fix page probe issues in vext_ldff

 target/riscv/vector_helper.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

-- 
2.43.7


