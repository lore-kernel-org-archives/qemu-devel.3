Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB55EC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 04:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQ88-0006ey-M2; Tue, 30 Jun 2026 00:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ87-0006ec-Ex
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weQ85-0002zD-To
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 00:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782793885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xvU+UT8RJH8CNRGV8KgYl6yHDkqxJ9spzV3Le1jKkow=;
 b=ROGUxRTCf1W0qrHmZBF4ja+YfJIhLWYnF8OKX7hN888STio2ySWm+JSBOCDqB8O3cDNVZv
 49l1qtqM/ahHFzyYahTquuYQW93Rg3UdR2zmLnDx93LjikclugWp41LuTXl80/mE8cO6rh
 LeMNXZhlK9TEKc4SP8nTp09g11y7Pz8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-FxFKCZQsNJuyJsx1feBC_Q-1; Tue,
 30 Jun 2026 00:31:21 -0400
X-MC-Unique: FxFKCZQsNJuyJsx1feBC_Q-1
X-Mimecast-MFC-AGG-ID: FxFKCZQsNJuyJsx1feBC_Q_1782793880
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1794519560A2; Tue, 30 Jun 2026 04:31:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 309731956042; Tue, 30 Jun 2026 04:31:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: GuoHan Zhao <zhaoguohan@kylinos.cn>, John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/23] vfio-user: validate VERSION replies
Date: Tue, 30 Jun 2026 06:30:48 +0200
Message-ID: <20260630043107.1511076-5-clg@redhat.com>
In-Reply-To: <20260630043107.1511076-1-clg@redhat.com>
References: <20260630043107.1511076-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

The vfio-user protocol makes the VERSION payload optional, so a
reply may legally stop after the major and minor fields.

vfio_user_validate_version() currently assumes a capabilities string is
always present and NUL-terminated. When the server replies without
version data, QEMU ends up reusing the request-side capabilities buffer
and the terminating-NUL check underflows. Replies shorter than the fixed
VERSION header are also accessed before they are validated.

Reject replies shorter than the fixed VERSION header and only parse
capabilities when the reply actually carries version data.

Fixes: 36227628d824 (vfio-user: implement message send infrastructure)
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20260603062138.4008583-1-zhaoguohan@kylinos.cn
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/proxy.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 0f7d8425d61488f6af3747db4b9f5c774f3fc717..197aee07bf7a3e16b58f77b0ecb73bff46889ecb 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -1292,7 +1292,7 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
 {
     g_autofree VFIOUserVersion *msgp = NULL;
     GString *caps;
-    char *reply;
+    const char *reply = "";
     int size, caplen;
 
     caps = caps_json();
@@ -1322,17 +1322,24 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
         return false;
     }
 
-    reply = msgp->capabilities;
-    if (reply[msgp->hdr.size - sizeof(*msgp) - 1] != '\0') {
-        error_setg(errp, "corrupt version reply");
+    if (msgp->hdr.size < sizeof(*msgp)) {
+        error_setg(errp, "short version reply");
         return false;
     }
 
-    if (!caps_check(proxy, msgp->minor, reply, errp)) {
-        return false;
+    if (msgp->hdr.size > sizeof(*msgp)) {
+        reply = msgp->capabilities;
+        if (reply[msgp->hdr.size - sizeof(*msgp) - 1] != '\0') {
+            error_setg(errp, "corrupt version reply");
+            return false;
+        }
+
+        if (!caps_check(proxy, msgp->minor, reply, errp)) {
+            return false;
+        }
     }
 
-    trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
+    trace_vfio_user_version(msgp->major, msgp->minor, reply);
     return true;
 }
 
-- 
2.54.0


