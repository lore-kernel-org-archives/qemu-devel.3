Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41244C9EC85
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 12:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHLl-0005pC-Vr; Mon, 12 Jan 2026 07:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfHLL-0005X4-4W
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 07:48:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfHLI-0006Xh-9c
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 07:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768222097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YzQtYltNX0aUV94lUYivQBNRqZBcsBEztgu7G9tGpT8=;
 b=gUKLVUudl32FRql1xaToD0qYmq0K+2gJTNoLO5z2HtXtpbVo7UJ7RV9OzqBb5HtCYLG1TK
 xG+Hr/CCfPcVbXW/e+Srn3SZApwq1Vmnm2DEnMwt300dHig+KGXjT0prVnBw8cr78Cbw53
 rTVztGv91G8XdH+aO8GcXgj9dt2LE/0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-ZG35En1pPbeNGrw_7ofEUw-1; Mon,
 12 Jan 2026 07:48:16 -0500
X-MC-Unique: ZG35En1pPbeNGrw_7ofEUw-1
X-Mimecast-MFC-AGG-ID: ZG35En1pPbeNGrw_7ofEUw_1768222095
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5684819344B7; Mon, 12 Jan 2026 12:47:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4602819560B2; Mon, 12 Jan 2026 12:47:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH] ppc/vof: Fix build error
Date: Mon, 12 Jan 2026 13:47:22 +0100
Message-ID: <20260112124722.1029212-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Newer gcc compiler (version 16.0.0 20260103 (Red Hat 16.0.0-0) (GCC))
detects an unused variable error:

../hw/ppc/vof.c: In function ‘vof_dt_memory_available’:
../hw/ppc/vof.c:642:12: error: variable ‘n’ set but not used [-Werror=unused-but-set-variable=]

Remove 'n'.

Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/ppc/vof.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index 5ecfc6891047eb63f498fe286d57f52a54c0a0db..fa7b73159a0b476dfc49326139d75cb87ca487c1 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -639,7 +639,7 @@ static gint of_claimed_compare_func(gconstpointer a, gconstpointer b)
 
 static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
 {
-    int i, n, offset, proplen = 0, sc, ac;
+    int i, offset, proplen = 0, sc, ac;
     target_ulong mem0_end;
     const uint8_t *mem0_reg;
     g_autofree uint8_t *avail = NULL;
@@ -677,7 +677,7 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
     g_assert(claimed->len && (g_array_index(claimed, OfClaimed, 0).start == 0));
 
     avail = g_malloc0(sizeof(uint32_t) * (ac + sc) * claimed->len);
-    for (i = 0, n = 0, availcur = avail; i < claimed->len; ++i) {
+    for (i = 0, availcur = avail; i < claimed->len; ++i) {
         OfClaimed c = g_array_index(claimed, OfClaimed, i);
         uint64_t start, size;
 
@@ -705,7 +705,6 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
 
         if (size) {
             trace_vof_avail(c.start + c.size, c.start + c.size + size, size);
-            ++n;
         }
     }
     _FDT((fdt_setprop(fdt, offset, "available", avail, availcur - avail)));
-- 
2.52.0


