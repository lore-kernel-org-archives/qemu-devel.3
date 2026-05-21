Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34D9CD5BB6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3u3-0008LA-Jc; Thu, 21 May 2026 09:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3tF-00083V-OQ
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3tD-0000me-V7
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=On8Mk9gAu5U17ABZAtKCiAmhp1/KVZmi53Z/Hu/36xQ=;
 b=hdh/bvlNi5TD/OlCLOn8svhcHpX7T/sWIs3+nGq3eM4sz+AITMJFVK93Vwt3t21Hluf1Gl
 05xS+nWkF0B0l04C0luWANd4TN1VmII1h1DJNhzRgeFQaKxYd83Iq58/CqM1FKKJmSTScR
 XwSLe5cxfYmpjKMVZ3eTs5MVOMjTyCI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-5ZCTX9SZPyukMCd3B5fd_w-1; Thu,
 21 May 2026 09:56:39 -0400
X-MC-Unique: 5ZCTX9SZPyukMCd3B5fd_w-1
X-Mimecast-MFC-AGG-ID: 5ZCTX9SZPyukMCd3B5fd_w_1779371798
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51524195604F; Thu, 21 May 2026 13:56:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 086B219560A3; Thu, 21 May 2026 13:56:36 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 07/38] ui/vnc: fix OOB read updating VNC update frequency
 stats
Date: Thu, 21 May 2026 17:55:18 +0400
Message-ID: <20260521135551.1752945-8-marcandre.lureau@redhat.com>
In-Reply-To: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

Incorrect loop bounds in vnc_update_freq result in iterating past the
last row and past the last column in the VNC stats array. With suitably
chosen dimensions this could be a OOB read that accesses memory beyond
the VncDisplay struct that the stats array is embedded in.

Should this hit a guard page, it could trigger a guest crash. If it
does not, then the VNC frequency stats will be updated with garbage.

Fixes: CVE-2026-48003
Reported-by: boy juju <agx1657748706@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260521103353.1645561-5-berrange@redhat.com>
---
 ui/vnc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 375ab207950..2159bb35d54 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3093,12 +3093,14 @@ double vnc_update_freq(VncState *vs, int x, int y, int w, int h)
     int i, j;
     double total = 0;
     int num = 0;
+    int x_end = x + w;
+    int y_end = y + h;
 
     x =  QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
     y =  QEMU_ALIGN_DOWN(y, VNC_STAT_RECT);
 
-    for (j = y; j <= y + h; j += VNC_STAT_RECT) {
-        for (i = x; i <= x + w; i += VNC_STAT_RECT) {
+    for (j = y; j < y_end; j += VNC_STAT_RECT) {
+        for (i = x; i < x_end; i += VNC_STAT_RECT) {
             total += vnc_stat_rect(vs->vd, i, j)->freq;
             num++;
         }
-- 
2.54.0


