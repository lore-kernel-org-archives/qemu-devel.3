Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66247CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2ke-0003Oj-8p; Mon, 17 Nov 2025 12:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlugg@mlugg.co.uk>) id 1vL2kV-000398-0n
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:10:44 -0500
Received: from mlugg.co.uk ([2001:19f0:7401:8244:5400:ff:fe24:ff33]
 helo=mail.mlugg.co.uk) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlugg@mlugg.co.uk>) id 1vL2kS-0006Ft-AT
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:10:42 -0500
Received: from localhost.localdomain
 (3.c.0.2.2.e.e.a.9.8.5.7.2.1.b.b.f.b.9.2.0.c.b.a.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:abc0:29bf:bb12:7589:aee2:20c3])
 by mail.mlugg.co.uk (Postfix) with ESMTPSA id 68FCB35A1A;
 Mon, 17 Nov 2025 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mlugg.co.uk; s=20200703;
 t=1763399428; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wCgFAaPHpD5gNoEv09hbpHDRSkXCw2FXZqDCN4+OZNk=;
 b=ACjzg5neOfZAPpwEuTf391NQv6nOG/gaejiWYNHdKaGjkWCsjUb1ZWRlSAU9g4bgNyZTMC
 Hq2nxt1ihPwBeYgQ7XYGmWy/h3i349bugS+w1Z+hUwBEH8ljTBX6wJ7JCWHZ96cFHZyxVz
 miYW7svGg7K2p8GiP7W4gouunHxleU0=
From: Matthew Lugg <mlugg@mlugg.co.uk>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, peter.maydell@linaro.org,
 Matthew Lugg <mlugg@mlugg.co.uk>
Subject: [PATCH v2 1/4] linux-user: fix mremap unmapping adjacent region
Date: Mon, 17 Nov 2025 17:09:51 +0000
Message-ID: <20251117170954.31451-2-mlugg@mlugg.co.uk>
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

This typo meant that calls to `mremap` which shrink a mapping by some N
bytes would, when the virtual address space was pre-reserved (e.g.
32-bit guest on 64-bit host), unmap the N bytes following the *original*
mapping.

Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
---
 linux-user/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

No changes from last revision, just rebased.

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 423c77856a..ef3833a2bb 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1171,7 +1171,8 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                     errno = ENOMEM;
                     host_addr = MAP_FAILED;
                 } else if (reserved_va && old_size > new_size) {
-                    mmap_reserve_or_unmap(old_addr + old_size,
+                    /* Re-reserve pages we just shrunk out of the mapping */
+                    mmap_reserve_or_unmap(old_addr + new_size,
                                           old_size - new_size);
                 }
             }
-- 
2.51.2


