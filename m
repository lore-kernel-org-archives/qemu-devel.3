Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A46C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8go-0003ua-Dz; Wed, 12 Aug 2026 09:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8gj-0003eU-7t; Wed, 12 Aug 2026 09:08:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8gh-0005R1-Fh; Wed, 12 Aug 2026 09:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=ARdpUhihh9KGFrYxGMspPLFGshuWmIMOUHm7J27MYNU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mXH0z5b7V5kVFVWeiootyNGIydqt3WEY3mYh5XdstLZFUgp/TihjRPv2EzgIwQ7LI
 r5boCAKIbCYgPe5TzCQhux1SPmF9u7tj73NI1eHweR0qOAeW6lMo4rYFP/83xtwRym
 rIFtY9BwnjdqGiFhAEs4IHJWm9zSPRoZO7UwwdnTegMzIkNGt1gUTbHnm933VdGL9N
 6RmuNjJ24H79h1A+/c7oAmRvT2dNDX7OQKlPkBPb9VzTmkQpdCXbfkVrxWZrJ7A4ZL
 Qxeu9+BbJYfG8eb7R3bE/T+rJa2TLeicnfZDZEQdQD48ltBxsZgycn0T8eccAIhbRi
 oFsMrMRmhFOyQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 147051CA4B5;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4AAF1409B98;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 57C8F2F900; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Haotian Jiang <jianghaotian.sunday@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 054/102] hw/cxl: fix OOB access in cxl_doe_cdat_rsp
 via entry_handle
Date: Wed, 12 Aug 2026 16:01:29 +0300
Message-ID: <20260812130233.621965-54-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Haotian Jiang <jianghaotian.sunday@gmail.com>

cxl_doe_cdat_rsp() takes ent = req->entry_handle (uint16_t, fully
guest-controlled, 0..0xFFFF) and directly indexes cdat->entry[ent]
without checking ent < cdat->entry_len. For a default cxl-type3 with
one volatile memory region, entry_len = 1 + CT3_CDAT_NUM_ENTRIES = 7,
so any entry_handle >= 7 reads past the CDATEntry array into host heap.

The OOB-read base/length are then used in
memcpy(read_mbox + offset, base, len) at cxl_type3.c:298-299, leaking
host heap memory to the guest via PCI_EXP_DOE_RD_DATA_MBOX, and
potentially overflowing the 1 MiB read_mbox heap buffer when the OOB
length field is large.

The same bug exists in the cxl-upstream implementation.

Existing checks do not bound ent: assert(cdat->entry_len) only ensures
the table is loaded; the minimum-length check only guards against a
truncated CDATReq; the entry_handle ternary at line 293 only decides
the next-handle echo, not the current access; pcie_doe_get_obj_len
reads header.length, not entry_handle.

Reproduce: build QEMU with CONFIG_CXL, boot
  -M q35,cxl=on -device pxb-cxl,bus_nr=52 ... -device cxl-type3,...
then send a CDATReq with entry_handle=0xFFFF via the DOE mailbox at
config offset 0x190. Under ASAN this reports SEGV in cxl_doe_cdat_rsp
at cxl_type3.c:281.

Fixes: f5ee7413d5 ("hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange")
Fixes: 882877fc35 ("hw/pci-bridge/cxl-upstream: Add a CDAT table access DOE")
Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260713072336.623604-2-jianghaotian.sunday@gmail.com>
(cherry picked from commit 292902ae4e93dcf33414ec3c6951e02d497cc850)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6fffa21ead1..b06f2ed32aa 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -271,6 +271,9 @@ static bool cxl_doe_cdat_rsp(DOECap *doe_cap)
     }
 
     ent = req->entry_handle;
+    if (ent >= cdat->entry_len) {
+        return false;
+    }
     base = cdat->entry[ent].base;
     len = cdat->entry[ent].length;
 
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 28b109c49af..01ef0d4fa9c 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -156,6 +156,9 @@ static bool cxl_doe_cdat_rsp(DOECap *doe_cap)
     }
 
     ent = req->entry_handle;
+    if (ent >= cdat->entry_len) {
+        return false;
+    }
     base = cdat->entry[ent].base;
     len = cdat->entry[ent].length;
 
-- 
2.47.3


