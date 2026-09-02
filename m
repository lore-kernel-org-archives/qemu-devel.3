Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D2FC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1k4p-0006Ui-1D; Wed, 02 Sep 2026 08:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x1k4Z-0006Rt-OQ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x1k4Y-0004tT-65
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788352089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7oqY+FZMGLsBaeHNfEEOWl5GCdp9881hq1+4SwL6EQ=;
 b=GuljDmGetLY1MsD8uEciyeGdMJYNfGvl9C7zAttRGAkYhqDGUcI2a2T0VqhIx5+fg+L746
 eWtUasZh68FoyY8ooYXSsvYdz1Ovo3QAhcOSbGGoNNdAt9X5Xt9EFvOOsHl9/Ob8TX4zz9
 HW1I9osYeJyCU1wlWyyzIk5i5VDhIx8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-SBH_cxtuOU2uxA_Xzctf0Q-1; Wed,
 02 Sept 2026 08:27:02 -0400
X-MC-Unique: SBH_cxtuOU2uxA_Xzctf0Q-1
X-Mimecast-MFC-AGG-ID: SBH_cxtuOU2uxA_Xzctf0Q_1788352021
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2ABFF1921ED0; Wed,  2 Sep 2026 12:27:01 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 014903000223; Wed,  2 Sep 2026 12:26:59 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, leif.lindholm@oss.qualcomm.com, eauger@redhat.com
Subject: [PATCH 6/6] sbsa-gwdt: reschedule timer on direct WCV load
Date: Wed,  2 Sep 2026 14:26:46 +0200
Message-ID: <20260902122646.2848464-7-imammedo@redhat.com>
In-Reply-To: <20260902122646.2848464-1-imammedo@redhat.com>
References: <20260902122646.2848464-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

According to spec[1]:

 "The compare value can either be loaded directly or indirectly on an
  explicit refresh or timeout refresh"

QEMU accepts writes to WCV but doesn't reschedule the timer,
which it should per the spec pseudo code:

 "TimeoutRefresh = ( SystemCounter [63:0] > CompareValue [63:0])"

Fix it by updating the timer on WCV write.

partialy[2] fixes Windows in GTDT mode, which never issues a WRR refresh.
Instead, it programs WOR to ~4 sec, enables WCS, and immediately
writes a large absolute value into WCV to push the timeout far
into the future. Without this, QEMU ignores the WCV write,
the short WOR expires, and the guest reboots unexpectedly.

1) Arm® Server Base System Architecture 6.0
   Platform Design Document
   DEN0029D 6.0
   "A.2 Watchdog Operation"
2) under KVM system counter (CNTPCT) as read by guest apprears to
   produce host's value, so watchdog timeout effectively gets
   extended on host uptime offset. But that's a separate issue
   to be fixed.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/watchdog/sbsa_gwdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 0a1d981072..9ed109d6eb 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -148,6 +148,13 @@ static void sbsa_gwdt_wor_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
     sbsa_gwdt_set_timer(s, timeout);
 }
 
+static void sbsa_gwdt_wcv_update_timer(SBSA_GWDTState *s)
+{
+    if (s->wcs & SBSA_GWDT_WCS_EN) {
+        sbsa_gwdt_set_timer(s, (uint64_t)s->wcvu << 32 | s->wcvl);
+    }
+}
+
 static void sbsa_gwdt_rwrite(void *opaque, hwaddr offset, uint64_t data,
                              unsigned size) {
     SBSA_GWDTState *s = SBSA_GWDT(opaque);
@@ -187,10 +194,12 @@ static void sbsa_gwdt_write(void *opaque, hwaddr offset, uint64_t data,
 
     case SBSA_GWDT_WCV:
         s->wcvl = data;
+        sbsa_gwdt_wcv_update_timer(s);
         break;
 
     case SBSA_GWDT_WCVU:
         s->wcvu = data;
+        sbsa_gwdt_wcv_update_timer(s);
         break;
 
     default:
-- 
2.52.0


