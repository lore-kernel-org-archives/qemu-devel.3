Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F49CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2kZ-0003FW-GN; Mon, 17 Nov 2025 12:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlugg@mlugg.co.uk>) id 1vL2kT-00033b-Mu
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:10:42 -0500
Received: from mlugg.co.uk ([2001:19f0:7401:8244:5400:ff:fe24:ff33]
 helo=mail.mlugg.co.uk) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlugg@mlugg.co.uk>) id 1vL2kR-0006GB-Vm
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:10:41 -0500
Received: from localhost.localdomain
 (3.c.0.2.2.e.e.a.9.8.5.7.2.1.b.b.f.b.9.2.0.c.b.a.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:abc0:29bf:bb12:7589:aee2:20c3])
 by mail.mlugg.co.uk (Postfix) with ESMTPSA id 67E4435A1F;
 Mon, 17 Nov 2025 17:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mlugg.co.uk; s=20200703;
 t=1763399431; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3sbIpdXlqwqmTBhiIu3GcMxjkWPw2uw95lJmCAqaivE=;
 b=H0eG4I4/fGKTdvwUZq58prOUn3tToruMVVqkstrmrJwaBrINHwHVHtA5HH7Ev8xK30wzGY
 uct1rebgQ8foQhVVPZBHGWd4xC6/YbKxOUeuI2nwl32L34hLdXAkjIvNQxsNvCYD62n1jJ
 bjcJ30/SZRJcjiicGe/2W74DwmWfNeU=
From: Matthew Lugg <mlugg@mlugg.co.uk>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, peter.maydell@linaro.org,
 Matthew Lugg <mlugg@mlugg.co.uk>
Subject: [PATCH v2 3/4] linux-user: fix reserved_va page leak in do_munmap
Date: Mon, 17 Nov 2025 17:09:53 +0000
Message-ID: <20251117170954.31451-4-mlugg@mlugg.co.uk>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251117170954.31451-1-mlugg@mlugg.co.uk>
References: <20251117170954.31451-1-mlugg@mlugg.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:19f0:7401:8244:5400:ff:fe24:ff33;
 envelope-from=mlugg@mlugg.co.uk; helo=mail.mlugg.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The old logic had an off-by-one bug. For instance, assuming 4k pages on
host and guest, if 'len' is '4097' (indicating to unmap 2 pages), then
'last = start + 4096', so 'real_last = start + 4095', so ultimately
'real_len = 4096'. I do not believe this could cause any observable bugs
in guests, because `target_munmap` page-aligns the length it passes in.
However, calls to this function in `target_mremap` do not page-align the
length, so those calls could "drop" pages, leading to a part of the
reserved region becoming unmapped. At worst, a host allocation could get
mapped into that hole, then clobbered by a new guest mapping.

Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
---
 linux-user/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

The refactor in the last revision has been dropped in favour of a simple
two-line patch. The added 'ROUND_UP' on the first line of the diff is necessary
to prevent the last 'for (prot = 0, ...' in the function from considering a page
which 'len' partially covers.

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 6163f1a0d1..4bcfaf7894 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1029,9 +1029,9 @@ static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
     void *host_start;
     int prot;
 
-    last = start + len - 1;
+    last = ROUND_UP(start + len, TARGET_PAGE_SIZE) - 1;
     real_start = start & -host_page_size;
-    real_last = ROUND_UP(last, host_page_size) - 1;
+    real_last = ROUND_UP(last + 1, host_page_size) - 1;
 
     /*
      * If guest pages remain on the first or last host pages,
-- 
2.51.2


