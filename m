Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2945BC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 05:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubBq4-0001Wb-Oi; Mon, 14 Jul 2025 01:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubBpp-000102-JS
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 01:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubBpo-000362-3a
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 01:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752471279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aE/wKQGzoh4jWmtAUGCBzWi5yGD7I8dxBOHfLcHtRck=;
 b=FspeL2YScgg3swIP/Dyd7oxUXj1PmR7FPKZmxxcoex2CKBV64G9qNmw3A3rZrrZnGRzn/M
 4G7FPFYgx+Klq08d+/UP1Xmi+fcX5vfjdtwWI3iyi73yYF063YWYpdyObeHWx1K5WmSnGs
 fYK48CN7fR7mYYZdC5rakkzPlb6Qe4g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-_RWvesbGOkO2Cy90mU4sFQ-1; Mon,
 14 Jul 2025 01:34:35 -0400
X-MC-Unique: _RWvesbGOkO2Cy90mU4sFQ-1
X-Mimecast-MFC-AGG-ID: _RWvesbGOkO2Cy90mU4sFQ_1752471274
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0D9F1800290; Mon, 14 Jul 2025 05:34:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.55])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC31F19560A3; Mon, 14 Jul 2025 05:34:30 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Anastasia Belova <nabelova31@gmail.com>, qemu-stable@nongnu.org,
 Ilya Maximets <i.maximets@ovn.org>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 01/13] net: fix buffer overflow in af_xdp_umem_create()
Date: Mon, 14 Jul 2025 13:34:11 +0800
Message-ID: <20250714053423.10415-2-jasowang@redhat.com>
In-Reply-To: <20250714053423.10415-1-jasowang@redhat.com>
References: <20250714053423.10415-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Anastasia Belova <nabelova31@gmail.com>

s->pool has n_descs elements so maximum i should be
n_descs - 1. Fix the upper bound.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: cb039ef3d9 ("net: add initial support for AF_XDP network backend")
Cc: qemu-stable@nongnu.org
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Anastasia Belova <nabelova31@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/af-xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index 01c5fb914e..d022534d76 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -323,7 +323,7 @@ static int af_xdp_umem_create(AFXDPState *s, int sock_fd, Error **errp)
 
     s->pool = g_new(uint64_t, n_descs);
     /* Fill the pool in the opposite order, because it's a LIFO queue. */
-    for (i = n_descs; i >= 0; i--) {
+    for (i = n_descs - 1; i >= 0; i--) {
         s->pool[i] = i * XSK_UMEM__DEFAULT_FRAME_SIZE;
     }
     s->n_pool = n_descs;
-- 
2.42.0


