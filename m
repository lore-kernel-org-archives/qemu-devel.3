Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7265FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIB7w-0003Vi-5e; Wed, 29 Apr 2026 16:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel@airwebreathe.org.uk>)
 id 1wI8M8-0005IO-W4
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:05:58 -0400
Received: from a-painless.mh.aa.net.uk ([2001:8b0:0:30::51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel@airwebreathe.org.uk>)
 id 1wI8M6-00057c-3u
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=airwebreathe.org.uk; s=aaisp1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pe6GyFPa/hBqabgpAFyDYMXmwXGg/Sf/InMHSwTP8vE=; b=UKz0IuDYt8nugKsXSpMu67hfej
 CO2CA/mNsKLN+gTR6TrkAu982IEeyLU812VyiWqINB+BCwhEQfGHqgGKsvNH4unojprncdydC7mcf
 crM1FHGcQ06PRjD8j+dHLJIwyJrLOxe80Kfa0uMZI8MrS6X5SABTvQljZp+ygdyHY8GxC6B2rd45l
 dG+1gAPMPK8QCi7XWIAGOSQL+PzsQN1V5nFBmwXhRe9Tqckw35Fdzl3+JQcsI2uDef25u9uhN6dQy
 nwiIu4CdJljrpjv9Bu7bHLm9KR5o2vfMxiWpDV+aEx2yrCTEKk2U46Ap/aMcdhKnvtBEzmRyD41l9
 641SumWA==;
Received: from thunderhill.nvidia.com ([216.228.112.22]
 helo=jholdsworth-sail.nvidia.com)
 by painless-a.thn.aa.net.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <joel@airwebreathe.org.uk>)
 id 1wI8M2-00000003iOT-0COE; Wed, 29 Apr 2026 18:05:42 +0100
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 0/2] target/or1k: fix arithmetic edge cases
Date: Wed, 29 Apr 2026 10:03:57 -0700
Message-ID: <20260429170519.2137725-1-joel@airwebreathe.org.uk>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:8b0:0:30::51;
 envelope-from=joel@airwebreathe.org.uk; helo=a-painless.mh.aa.net.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 16:03:09 -0400
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
Reply-to:  joel@airwebreathe.org.uk
From: joel--- via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Joel Holdsworth <jholdsworth@nvidia.com>

This series fixes two bugs in the OpenRISC TCG translation:

 1. gen_div: INT_MIN / -1 causes undefined behavior (hardware exception
    on x86/ARM hosts)
 2. gen_mulu: uses signed multiply instead of unsigned, producing
    incorrect carry flags

Note: these patches are AI-generated submissions.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>

Joel Holdsworth (2):
  target/or1k: fix gen_mulu using signed multiply for unsigned operation
  target/or1k: fix gen_div INT_MIN / -1 undefined behavior

 target/or1k/translate.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

-- 
2.51.2


