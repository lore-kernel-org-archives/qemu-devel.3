Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1A0C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1k4c-0006SM-35; Wed, 02 Sep 2026 08:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x1k4Y-0006RD-IK
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x1k4X-0004sw-0t
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788352088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5rMCPVhjC068rQLLNDke/LvXpMq7YJ3+AEL8uMXIMc=;
 b=KY96nWllhaWRCmxal+gIMldqLB2W7cYxtAZM0AGtfvMLDYCuvSFaWgZGXWWUhn3ECyoJsq
 u9eUlJmHWUU5Z0D+aXk1n0RSR4A0a3yhiFWj1KjbP05u/V16Yy9nx1erQ3N7Nui+vc6gCx
 wjzpfC9lH8e6oUR3D0JawRqozpjNHl0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-vMK76Q9xM-iM95PAaY3F_A-1; Wed,
 02 Sept 2026 08:26:54 -0400
X-MC-Unique: vMK76Q9xM-iM95PAaY3F_A-1
X-Mimecast-MFC-AGG-ID: vMK76Q9xM-iM95PAaY3F_A_1788352013
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFEEC1953994; Wed,  2 Sep 2026 12:26:52 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DF603000223; Wed,  2 Sep 2026 12:26:50 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, leif.lindholm@oss.qualcomm.com,
 eauger@redhat.com, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH 1/6] sbsa-gwdt: reduce code ident
Date: Wed,  2 Sep 2026 14:26:41 +0200
Message-ID: <20260902122646.2848464-2-imammedo@redhat.com>
In-Reply-To: <20260902122646.2848464-1-imammedo@redhat.com>
References: <20260902122646.2848464-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/watchdog/sbsa_gwdt.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 330a74798a..7cc5609b83 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -105,25 +105,27 @@ static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
 
     timer_del(s->timer);
 
-    if (s->wcs & SBSA_GWDT_WCS_EN) {
-        /*
-         * Extract the upper 16 bits from woru & 32 bits from worl
-         * registers to construct the 48 bit offset value
-         */
-        timeout = s->woru;
-        timeout <<= 32;
-        timeout |= s->worl;
-        timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, s->freq);
-        timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-
-        if ((rtype == EXPLICIT_REFRESH) || ((rtype == TIMEOUT_REFRESH) &&
-                (!(s->wcs & SBSA_GWDT_WCS_WS0)))) {
-            /* store the current timeout value into compare registers */
-            s->wcvu = timeout >> 32;
-            s->wcvl = timeout;
-        }
-        timer_mod(s->timer, timeout);
+    if (!(s->wcs & SBSA_GWDT_WCS_EN)) {
+        return;
+    }
+
+    /*
+     * Extract the upper 16 bits from woru & 32 bits from worl
+     * registers to construct the 48 bit offset value
+     */
+    timeout = s->woru;
+    timeout <<= 32;
+    timeout |= s->worl;
+    timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, s->freq);
+    timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    if ((rtype == EXPLICIT_REFRESH) || ((rtype == TIMEOUT_REFRESH) &&
+            (!(s->wcs & SBSA_GWDT_WCS_WS0)))) {
+        /* store the current timeout value into compare registers */
+        s->wcvu = timeout >> 32;
+        s->wcvl = timeout;
     }
+    timer_mod(s->timer, timeout);
 }
 
 static void sbsa_gwdt_rwrite(void *opaque, hwaddr offset, uint64_t data,
-- 
2.52.0


