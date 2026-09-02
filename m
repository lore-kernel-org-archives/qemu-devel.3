Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4985C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1k4c-0006SO-49; Wed, 02 Sep 2026 08:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x1k4Z-0006Rc-Dg
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x1k4X-0004tO-RP
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788352089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BwMO14EVESPgOIQPV2+HS2tSXE3S3XBWFrRFw8yLuE=;
 b=GJji9C3XgNNv122jqoBehRPPNCMGLtwKWrDlzfueN9gcJqogr0F1XvCTosW8jf9WMwnnPt
 SlkwdPJLK8kkz6Kd4Blpx1ZRcSzeY2bLQxkkpLinngB6sQ7XSKV5IaUa7D3/RbxMbjGYjL
 JZtT4CdQNo1Lb8lqTrizaemZ2nHRSa4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-F0yr_UMWPYSfKLcT5EqisA-1; Wed,
 02 Sept 2026 08:26:57 -0400
X-MC-Unique: F0yr_UMWPYSfKLcT5EqisA-1
X-Mimecast-MFC-AGG-ID: F0yr_UMWPYSfKLcT5EqisA_1788352016
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35CA8192DD51; Wed,  2 Sep 2026 12:26:56 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D93A3000223; Wed,  2 Sep 2026 12:26:54 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, leif.lindholm@oss.qualcomm.com, eauger@redhat.com
Subject: [PATCH 3/6] arm: gwdt: simplify WCV update condition
Date: Wed,  2 Sep 2026 14:26:43 +0200
Message-ID: <20260902122646.2848464-4-imammedo@redhat.com>
In-Reply-To: <20260902122646.2848464-1-imammedo@redhat.com>
References: <20260902122646.2848464-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Current code implements SBSA 5.0, revision 1 of the generic watchdog.
Which requires WCV retain time when WS1 was triggered.

towards that effect sbsa_gwdt_update_timer(), used condition
   (rtype == TIMEOUT_REFRESH) && !(s->wcs & SBSA_GWDT_WCS_WS0)
to make sure that WCV won't be updated on WS1.

However that is dead code as sbsa_gwdt_timer_sysinterrupt() when
signalling WS1, never calls sbsa_gwdt_update_timer().

Delete dead condition and add assert to make sure that
sbsa_gwdt_update_timer() is never called unnoticed on WS1 path.

Above change leaves us with always true remaining if condition:
  (rtype == EXPLICIT_REFRESH) || (rtype == TIMEOUT_REFRESH)
drop it and update WCV unconditionaly.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/watchdog/sbsa_gwdt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 2aa44573a7..a9bf3f8312 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -123,12 +123,12 @@ static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
     timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, s->freq);
     timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
-    if ((rtype == EXPLICIT_REFRESH) || ((rtype == TIMEOUT_REFRESH) &&
-            (!(s->wcs & SBSA_GWDT_WCS_WS0)))) {
-        /* store the current timeout value into compare registers */
-        s->wcvu = timeout >> 32;
-        s->wcvl = timeout;
-    }
+    g_assert(!(s->wcs & SBSA_GWDT_WCS_WS1));
+
+    /* store the current timeout value into compare registers */
+    s->wcvu = timeout >> 32;
+    s->wcvl = timeout;
+
     timer_mod(s->timer, timeout);
 }
 
-- 
2.52.0


