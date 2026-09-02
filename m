Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156ABC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1k4Z-0006RX-Cc; Wed, 02 Sep 2026 08:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x1k4X-0006QT-Ch
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x1k4V-0004sj-SO
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788352087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTmlLnMyTw7vyUl+JIdD3NLOzd8/g0MoejD7oHwZt9Y=;
 b=ixGLawSFEZnNF2Se5Ih4NoimVSNqISvy5oHtAi0dME3Eca1TzZMu4Si3UGVNlrFw4XzH/u
 IgfJP8lKMz0QaABd1XRLbwei9ER4PlOcj6UZgI7+qzL9fXMrLWtYEkZRc4AuRIJjaOWIH2
 XrP2ufpgeN+d5Qoc/Coj/g8MQpbb3gA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-JcRniLefNmG6iW0av0pBaA-1; Wed,
 02 Sept 2026 08:26:58 -0400
X-MC-Unique: JcRniLefNmG6iW0av0pBaA-1
X-Mimecast-MFC-AGG-ID: JcRniLefNmG6iW0av0pBaA_1788352017
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B26381800D8F; Wed,  2 Sep 2026 12:26:57 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CA9F3000223; Wed,  2 Sep 2026 12:26:56 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, leif.lindholm@oss.qualcomm.com, eauger@redhat.com
Subject: [PATCH 4/6] sbsa-gwdt: rename sbsa_gwdt_update_timer() to
 sbsa_gwdt_wor_update_timer()
Date: Wed,  2 Sep 2026 14:26:44 +0200
Message-ID: <20260902122646.2848464-5-imammedo@redhat.com>
In-Reply-To: <20260902122646.2848464-1-imammedo@redhat.com>
References: <20260902122646.2848464-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The timer update helper computes the timeout from the WOR (watchdog
offset register). Rename it to sbsa_gwdt_wor_update_timer() to make room
for a separate WCV-based update helper added by a following patch.

No functional change.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/watchdog/sbsa_gwdt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index a9bf3f8312..1211f1ca65 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -99,7 +99,7 @@ static uint64_t sbsa_gwdt_read(void *opaque, hwaddr addr, unsigned int size)
     return ret;
 }
 
-static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
+static void sbsa_gwdt_wor_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
 {
     uint64_t timeout = 0;
 
@@ -138,7 +138,7 @@ static void sbsa_gwdt_rwrite(void *opaque, hwaddr offset, uint64_t data,
 
     trace_sbsa_gwdt_refresh_write(offset, data);
     if (offset == SBSA_GWDT_WRR) {
-        sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
+        sbsa_gwdt_wor_update_timer(s, EXPLICIT_REFRESH);
     } else {
         qemu_log_mask(LOG_GUEST_ERROR, "bad address in refresh frame write :"
                         " 0x%x\n", (int)offset);
@@ -154,19 +154,19 @@ static void sbsa_gwdt_write(void *opaque, hwaddr offset, uint64_t data,
     case SBSA_GWDT_WCS:
         s->wcs = data & SBSA_GWDT_WCS_EN;
         qemu_set_irq(s->irq, 0);
-        sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
+        sbsa_gwdt_wor_update_timer(s, EXPLICIT_REFRESH);
         break;
 
     case SBSA_GWDT_WOR:
         s->worl = data;
         qemu_set_irq(s->irq, 0);
-        sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
+        sbsa_gwdt_wor_update_timer(s, EXPLICIT_REFRESH);
         break;
 
     case SBSA_GWDT_WORU:
         s->woru = data & SBSA_GWDT_WOR_MASK;
         qemu_set_irq(s->irq, 0);
-        sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
+        sbsa_gwdt_wor_update_timer(s, EXPLICIT_REFRESH);
         break;
 
     case SBSA_GWDT_WCV:
@@ -205,7 +205,7 @@ static void sbsa_gwdt_timer_sysinterrupt(void *opaque)
     if (!(s->wcs & SBSA_GWDT_WCS_WS0)) {
         s->wcs |= SBSA_GWDT_WCS_WS0;
         trace_sbsa_gwdt_ws0_asserted();
-        sbsa_gwdt_update_timer(s, TIMEOUT_REFRESH);
+        sbsa_gwdt_wor_update_timer(s, TIMEOUT_REFRESH);
         qemu_set_irq(s->irq, 1);
     } else {
         s->wcs |= SBSA_GWDT_WCS_WS1;
-- 
2.52.0


