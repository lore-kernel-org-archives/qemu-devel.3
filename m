Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEEFCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMHr-0003Pz-Rr; Wed, 27 May 2026 17:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7c4e53eb73c0580d7a321dbf3823ba5647652298@kylie.crudebyte.com>)
 id 1wSMHq-0003PY-3V; Wed, 27 May 2026 17:59:38 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7c4e53eb73c0580d7a321dbf3823ba5647652298@kylie.crudebyte.com>)
 id 1wSMHn-00041M-FI; Wed, 27 May 2026 17:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=LwNhhI3hE8IqgimhjcIWZMiFUZFgeoXrAM8FKvGMPZM=; b=NRmuc
 jreDHuAMjtiHYEOPMHnhIHiC354Me2js08j9oD5vfPhV6QMNVXIF98qM0yOPoyn8jR45AXlv4gFGf
 1RQK5PWFRFsbwT0aNE+vMsqmu2XJ/WlaX2CAzId+tU1+dLUg7JmSqAnYsBSxaJTd4HIDkB8lrUgeu
 V3FXrTCUtvWPtfEzMp1q0h8jGTdV8VgKxxXhJRi4c1GG8syG5o2f0T7jQaI7x6ujzFQVBpkT/KV/m
 vaUQDP5ywx63yMJVJQt22fdd9X5RjiAJChxnyMArJXxnvUiuymydCyX9xq1uDLLggG68xIOEF9KUP
 21cBf5Mk1y8gGDS3Q3CnVSjEdvOJPAjBIJusvxChXfkJfLesurMCUsFukt9tvnwEl3JptouI+xnTH
 Pw3vMOv+gytHwVumaAge97qPN9HhTkjz2jFdXcw1oPcNHlwBMyPlZkZ+/Oqe0i7G2YHcl7ydVsSJQ
 4xEvv+cP30kGYqKM0drVrtuNmn84n1KTE7cB3K9mVGMj2b5bbkWC//C4Dz0F7j5Wc0DYjpJguAZxt
 MbQlhvFvEVLAYXuCGgX5c1dXFScvMgIrNaGcI8mnK8YpacE67dMy3ZJZuT5IfK7v7tEa6obncmzMC
 LxWEa3WgyxrWbtHrdeKk/PxY7/Z40PK3bMdoLJ47+n7XGxJ1GfObbszYHhvGV4=;
Message-ID: <7c4e53eb73c0580d7a321dbf3823ba5647652298.1779916560.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1779916560.git.qemu_oss@crudebyte.com>
References: <cover.1779916560.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 27 May 2026 23:15:19 +0200
Subject: [PATCH 1/8] hw/9pfs: add msize_limit transport callback
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=7c4e53eb73c0580d7a321dbf3823ba5647652298@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add a new callback 'msize_limit' to the V9fsTransport structure.

This allows each transport implementation to provide its theoretical
maximum 'msize' value, which will be used to cap the negotiated
msize during Tversion handshake.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 65cc45e344..14111e041a 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -481,6 +481,7 @@ struct V9fsTransport {
     void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
                                          unsigned int *pniov, size_t size);
     void        (*push_and_notify)(V9fsPDU *pdu);
+    size_t      (*msize_limit)(V9fsState *s);
 };
 
 #endif
-- 
2.47.3


