Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D4BEC047C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxM1k-0004wN-4t; Tue, 03 Mar 2026 04:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM1i-0004vB-BB
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:26:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM1g-0004ZQ-PV
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772530008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NqYVdsmBxHw6Xm69IJ/3yY2NBlMNzsfIenqE5vc56as=;
 b=P5eBijjKNNY+KRT7orevBo4r9Ya6K79grgw4jmsZvgm69FRwk+f2JuMek6chnQwbMK19Dm
 YOTRR03o+sTb2fQ4rHA9zJxxlgLKUvXjuBkQRrCgzUVC59xXf2WLjE14MYE/eiI/f6tI2q
 JBuCnon9piEGWq2JQk1MJC0qnWGe6/M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-G6PYbvq7Phy9G6Qs-WQNsA-1; Tue,
 03 Mar 2026 04:26:44 -0500
X-MC-Unique: G6PYbvq7Phy9G6Qs-WQNsA-1
X-Mimecast-MFC-AGG-ID: G6PYbvq7Phy9G6Qs-WQNsA_1772530002
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96F2A19560A3; Tue,  3 Mar 2026 09:26:42 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 15EB530001B9; Tue,  3 Mar 2026 09:26:39 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: [PATCH v2 20/21] sbsa_gwdt: reschedule timer on direct WCV load
Date: Tue,  3 Mar 2026 10:25:31 +0100
Message-ID: <20260303092532.2410177-21-imammedo@redhat.com>
In-Reply-To: <20260303092532.2410177-1-imammedo@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_PASS=-0.001,
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

According to spec[1]

 "The compare value can either be loaded directly or indirectly on an
  explicit refresh or timeout refresh"

while QEMU does allow to write WCV, it doesn't act on
new value, which it should do according to pseudo code in spec:

 "TimeoutRefresh = ( SystemCounter [63:0] > CompareValue [63:0])"

fix it by updating timer on WCV write.

Fixes Windows watchdog reboots, since it sets
  WOR to ~4sec && never triggers WRR refresh
it however writes insane lage value into WCV
right after WOR & WCS enable, which effectively
cancels too small WOR value and missing WRR.

1) Arm® Server Base System Architecture 6.0
   Platform Design Document
   DEN0029D 6.0
   "A.2 Watchdog Operation"

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/watchdog/sbsa_gwdt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index c2d6f672f9..7fec61b7b0 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -44,6 +44,7 @@ static const VMStateDescription vmstate_sbsa_gwdt = {
 typedef enum WdtRefreshType {
     EXPLICIT_REFRESH = 0,
     TIMEOUT_REFRESH = 1,
+    WCV_LOAD = 2,
 } WdtRefreshType;
 
 static uint64_t sbsa_gwdt_rread(void *opaque, hwaddr addr, unsigned int size)
@@ -118,8 +119,6 @@ static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
         /* store (now + offset)ns in WCV */
         s->wcvu = timeout >> 32;
         s->wcvl = timeout;
-    } else {
-        g_assert_not_reached();
     }
 
     timeout = (uint64_t)s->wcvu << 32 | s->wcvl;
@@ -169,10 +168,16 @@ static void sbsa_gwdt_write(void *opaque, hwaddr offset, uint64_t data,
 
     case SBSA_GWDT_WCV:
         s->wcvl = data;
+        if (s->wcs & SBSA_GWDT_WCS_EN) {
+            sbsa_gwdt_update_timer(s, WCV_LOAD);
+        }
         break;
 
     case SBSA_GWDT_WCVU:
         s->wcvu = data;
+        if (s->wcs & SBSA_GWDT_WCS_EN) {
+            sbsa_gwdt_update_timer(s, WCV_LOAD);
+        }
         break;
 
     default:
-- 
2.47.3


