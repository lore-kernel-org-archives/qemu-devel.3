Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB45C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 20:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXSNC-0004sc-Aw; Tue, 06 Feb 2024 15:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXSNA-0004sN-Dx
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:48:52 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rXSN8-0001b9-FD
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 15:48:52 -0500
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTP id 5CECD40737BC;
 Tue,  6 Feb 2024 20:48:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5CECD40737BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1707252505;
 bh=4F/C1B+cC2RgP3u18HGEcSex7qEoy24U/QdgIeuFhJw=;
 h=From:To:Cc:Subject:Date:From;
 b=UsH1JtuHfDeGLHEQQ/4iX5bCLImWs8YG37Tn8/qLmx6AqiCzKbQt/XMUKlPd1xDNv
 9rT+2ANRxe5cfbnEkCiKjTkEkFbq8WOUFavLx/IVF7DqLJtDZ40kDvTcHhlbBgyaXM
 ieO9ytNhZ1nGAAoaEOz5F2hdbS5xHwVkp2KYQZl0=
From: Alexander Monakov <amonakov@ispras.ru>
To: qemu-devel@nongnu.org
Cc: Mikhail Romanov <mmromanov@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH v3 0/6] Optimize buffer_is_zero
Date: Tue,  6 Feb 2024 23:48:03 +0300
Message-Id: <20240206204809.9859-1-amonakov@ispras.ru>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I am posting a new revision of buffer_is_zero improvements (v2 can be found at
https://patchew.org/QEMU/20231027143704.7060-1-mmromanov@ispras.ru/ ).

In our experiments buffer_is_zero took about 40%-50% of overall qemu-img run
time, even though Glib I/O is not very efficient. Hence, it remains an important
routine to optimize.

We substantially improve its performance in typical cases, mostly by introducing
an inline wrapper that samples three bytes from head/middle/tail, avoid call
overhead when any of those is non-zero. We also provide improvements for SIMD
and portable scalar variants.

Changed for v3:

- separate into 6 patches
- fix an oversight which would break the build on non-x86 hosts
- properly avoid out-of-bounds pointers in the scalar variant

Alexander Monakov (6):
  util/bufferiszero: remove SSE4.1 variant
  util/bufferiszero: introduce an inline wrapper
  util/bufferiszero: remove AVX512 variant
  util/bufferiszero: remove useless prefetches
  util/bufferiszero: optimize SSE2 and AVX2 variants
  util/bufferiszero: improve scalar variant

 include/qemu/cutils.h |  28 ++++-
 util/bufferiszero.c   | 280 +++++++++++++++---------------------------
 2 files changed, 128 insertions(+), 180 deletions(-)

-- 
2.32.0


