Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A439EC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAMx-0003J3-V3; Wed, 12 Aug 2026 10:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuALo-0000VV-6H; Wed, 12 Aug 2026 10:54:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuALk-0007Rg-5G; Wed, 12 Aug 2026 10:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=lxSGRkRrXyDUQbQkyAB0HOqLTUi2At9dNb4DpP3pJfY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XmyCLoPSIFJ3Fea0BIRpwR0rfM1ZDN63baSLMdz7xnOJtMYQXOEg8nSEVQs78A6sp
 ETcJb5fMLWQLLGISqPseSHL2ZFXOidPCu/EHUMBZQAWElxINca+jwnV2/rBcLsMcko
 JkEC5E1K78EoiYD4r6w53r+cQ812u2lGRnCrpXda2p0XCwwvPgb+C1BIhYVQUDMh8B
 d0fdSXudRM1r2sDl8OcP2yLImHeEJvXnR5qT4x83skxg0joywbGelz0oHezTE8or6D
 dNONEnr6LujXi1QAJrLWHWv2CA1bYySdiLaKFNVOnweR9L7+GvKFAQba4cbvG0terv
 NF+YQJR6kL5RQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0237C1CA632;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5CFAE409D74;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BA7622F9BF; Wed, 12 Aug 2026 17:50:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael S. Tsirkin <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Yuri Benditovich <ybendito@redhat.com>,
 Wei Xu <wexu@redhat.com>, huntr bubble <bubblehuntr@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 046/120] virtio-net: fix OOB read in RSC receive path
Date: Wed, 12 Aug 2026 17:48:29 +0300
Message-ID: <20260812144955.649205-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

From: "Michael S. Tsirkin" <mst@redhat.com>

The RSC receive path parses incoming frames at guest_hdr_len byte
offsets, but the backend buffer contains only host_hdr_len bytes of vnet
header. If the lengths differ, RSC would read at the wrong offset and
cause an OOB read.

This is no longer possible after the previous patch, but the assumption
seem fragile. Along the defense in depth lines, let's validate.  To
ensure we are not breaking any valid setups by mistake, warn and fall
back to the normal receive path when host_hdr_len != guest_hdr_len.

Fixes: CVE-2026-63321
Fixes: 2974e916df ("virtio-net: support RSC v4/v6 tcp traffic for Windows HCK")
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Yuri Benditovich <ybendito@redhat.com>
Cc: Wei Xu <wexu@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3623
Reported-by: huntr bubble <bubblehuntr@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <f261dcd535edc890f8636d8ae5ac1007bc32b8b4.1784891251.git.mst@redhat.com>
(cherry picked from commit 52c7bb369b23dfcafb6e6d90665c777797b55e88)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f0e3beb2903..2761644dfd9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2674,6 +2674,13 @@ static ssize_t virtio_net_receive(NetClientState *nc, const uint8_t *buf,
 {
     VirtIONet *n = qemu_get_nic_opaque(nc);
     if ((n->rsc4_enabled || n->rsc6_enabled)) {
+        /* this never happens with existing backends, but just in case. */
+        if (n->host_hdr_len != n->guest_hdr_len) {
+            warn_report_once("virtio-net: host_hdr_len %zu != guest_hdr_len %zu, "
+                             "skipping RSC",
+                             n->host_hdr_len, n->guest_hdr_len);
+            return virtio_net_do_receive(nc, buf, size);
+        }
         return virtio_net_rsc_receive(nc, buf, size);
     } else {
         return virtio_net_do_receive(nc, buf, size);
-- 
2.47.3


