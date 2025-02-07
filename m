Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7316C0219C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPU8-00025H-IW; Fri, 07 Feb 2025 09:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+283d3205a5fdf6ec7e2e+7838+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tgPU6-00024v-RP; Fri, 07 Feb 2025 09:37:34 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+283d3205a5fdf6ec7e2e+7838+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tgPU4-00049r-DI; Fri, 07 Feb 2025 09:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=jqKBIjWS/VL/NerjFJ7l2smMvefEMdIXeKueSmtNuXM=; b=MKKeF0WkOdZdx0i7NBRAm39on6
 y9Zmbv3IOMDNE0uJoQ39VshYEZvnKrIUoG1hJhXrBp3oBos2Cya+Ac4rigAlMgFSqu+Kxzawoo4mJ
 CgxgnkpqM8EJ2St4+/5PMDGEtWQbz5Tb0g8WLiPJBYkhtLR+W3cYK7V4GG+I3qbW9qwNAIsmbiXZq
 /henGsqGvm0qTFwL7jLGXGjgkakz6CPFNN40julayByQ98c+Baw6d9RnQyHyDYfaKvTKIf5L0AoRF
 WZvPTj8S7xheeQgO6xnRHiyuejR6S0lHRADH+4/XFzUkMVfPltm2R3mYXCLMNvnZTEViY7l4Kcu/+
 MpZaYsxQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tgPTx-0000000HBz1-3CSg; Fri, 07 Feb 2025 14:37:26 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tgPTw-0000000080s-1T6c; Fri, 07 Feb 2025 14:37:24 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org, kvm@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>
Subject: [PATCH 2/2] hw/xen: Add "mode" parameter to xen-block devices
Date: Fri,  7 Feb 2025 14:37:24 +0000
Message-ID: <20250207143724.30792-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207143724.30792-1-dwmw2@infradead.org>
References: <20250207143724.30792-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+283d3205a5fdf6ec7e2e+7838+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

Block devices don't work in PV Grub (0.9x) if there is no mode specified. It
complains: "Error ENOENT when reading the mode"

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/block/xen-block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 034a18b70e..e61eab466c 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -408,6 +408,8 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
     }
 
     xen_device_backend_printf(xendev, "info", "%u", blockdev->info);
+    xen_device_backend_printf(xendev, "mode",
+                              (blockdev->info & VDISK_READONLY) ? "r" : "w");
 
     xen_device_frontend_printf(xendev, "virtual-device", "%lu",
                                vdev->number);
-- 
2.48.1


