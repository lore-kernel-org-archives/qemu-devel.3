Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF004CA1014
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 19:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uttK0-0007ey-70; Wed, 03 Sep 2025 15:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uttJy-0007ea-8M
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 15:39:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uttJu-0007Ft-Mk
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 15:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756928309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7ViEPDnqnaUJlWIvLFiXQ+Pg2yfwJuliieVyNpBRLGw=;
 b=Pw2hIPxRLYaBYB0k8xH73qEMHWtfdNDLLIaXMwmCGJSAUz7AkC493gfImKPUFLoQ2YEbUZ
 bULWf1bT49hC2+T9lUAy7nTo87lhflL9iKMlsGXjmY8N+lTypEXIMAqitfWmYJ1QoFpaj/
 H08Sqd/mDf3LxkJspS6Xyg2tSEFs87Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-d48-mJJdPiyPR46cz8U4eg-1; Wed,
 03 Sep 2025 15:38:26 -0400
X-MC-Unique: d48-mJJdPiyPR46cz8U4eg-1
X-Mimecast-MFC-AGG-ID: d48-mJJdPiyPR46cz8U4eg_1756928305
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3B0A195604F
 for <qemu-devel@nongnu.org>; Wed,  3 Sep 2025 19:38:25 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C8BEA1800578; Wed,  3 Sep 2025 19:38:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/spice: fix crash when disabling GL scanout on
Date: Wed,  3 Sep 2025 23:38:18 +0400
Message-ID: <20250903193818.2460914-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When spice_qxl_gl_scanout2() isn't available, the fallback code
incorrectly handles NULL arguments to disable the scanout, leading to:

Program terminated with signal SIGSEGV, Segmentation fault.
#0  spice_server_gl_scanout (qxl=0x55a25ce57ae8, fd=0x0, width=0, height=0, offset=0x0, stride=0x0, num_planes=0, format=0, modifier=72057594037927935, y_0_top=0)
    at ../ui/spice-display.c:983
983         if (num_planes <= 1) {

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2391334
Fixes: 98a050ca93afd8 ("ui/spice: support multi plane dmabuf scanout")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/spice-display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 669832c561..db71e866f8 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -980,7 +980,9 @@ static void spice_server_gl_scanout(QXLInstance *qxl,
     spice_qxl_gl_scanout2(qxl, fd, width, height, offset, stride,
                           num_planes, format, modifier, y_0_top);
 #else
-    if (num_planes <= 1) {
+    if (fd == NULL) {
+        spice_qxl_gl_scanout(qxl, -1, 0, 0, 0, 0, false);
+    } else if (num_planes <= 1) {
         spice_qxl_gl_scanout(qxl, fd[0], width, height, stride[0], format, y_0_top);
     } else {
         error_report("SPICE server does not support multi plane GL scanout");
-- 
2.51.0


