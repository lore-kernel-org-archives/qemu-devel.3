Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12F5CDB47C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcKrG-00076x-GR; Wed, 24 Jun 2026 06:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wcKrD-00075j-SR
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wcKrB-0007Gt-JV
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782296960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPHPJEflTJSX9W8Tr7SbmiMKyZuqzu4vD1amQlm5twU=;
 b=ehJmFVwHOgsvBkc2QXxgLeR0CiVxHyjBSWyxx3EkvzSP/DtgM1jTS+CfwefRhtvK0gRUN0
 J9HVs6LOvNxWMEvX3l6vwZo1nnltL5zrPgeQd7NSw+P232jZpB3OsiA+TC9moKFs/K+vJf
 iBUx7IaA2jjF9K9rhzo9NHiStCGmCWw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-_IXHDuHON72hCXGL3Hvs0w-1; Wed,
 24 Jun 2026 06:29:17 -0400
X-MC-Unique: _IXHDuHON72hCXGL3Hvs0w-1
X-Mimecast-MFC-AGG-ID: _IXHDuHON72hCXGL3Hvs0w_1782296956
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D2DF19560A5; Wed, 24 Jun 2026 10:29:16 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FEB430001A7; Wed, 24 Jun 2026 10:29:14 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, eauger@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: [PATCH v3 16/17] sbsa-gwdt: reschedule timer on direct WCV load
Date: Wed, 24 Jun 2026 12:28:29 +0200
Message-ID: <20260624102830.1355552-17-imammedo@redhat.com>
In-Reply-To: <20260624102830.1355552-1-imammedo@redhat.com>
References: <20260624102830.1355552-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

According to spec[1]:

 "The compare value can either be loaded directly or indirectly on an
  explicit refresh or timeout refresh"

QEMU accepts writes to WCV but doesn't reschedule the timer,
which it should per the spec pseudo code:

 "TimeoutRefresh = ( SystemCounter [63:0] > CompareValue [63:0])"

Fix it by updating the timer on WCV write.

Fixes Windows in GTDT mode, which never issues a WRR refresh.
Instead, it programs WOR to ~4 sec, enables WCS, and immediately
writes a large absolute value into WCV to push the timeout far
into the future. Without this fix, QEMU ignores the WCV write,
the short WOR expires, and the guest reboots unexpectedly.

1) Arm® Server Base System Architecture 6.0
   Platform Design Document
   DEN0029D 6.0
   "A.2 Watchdog Operation"

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/watchdog/sbsa_gwdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 5ee0e06af5..fb67db9672 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -44,6 +44,7 @@ static const VMStateDescription vmstate_sbsa_gwdt = {
 typedef enum WdtRefreshType {
     EXPLICIT_REFRESH = 0,
     TIMEOUT_REFRESH = 1,
+    WCV_LOAD = 2,
 } WdtRefreshType;
 
 static uint64_t sbsa_gwdt_rread(void *opaque, hwaddr addr, unsigned int size)
@@ -167,10 +168,16 @@ static void sbsa_gwdt_write(void *opaque, hwaddr offset, uint64_t data,
 
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


