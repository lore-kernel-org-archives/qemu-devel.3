Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5EEEC047D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxM1m-00051l-St; Tue, 03 Mar 2026 04:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM1l-0004wd-Gf
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:26:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM1k-0004aF-0y
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772530011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2FbkwBaBchwCc7nB+/T0ZJRIDXeC+Ip+qqcXaU/gL3A=;
 b=INRkuPTltX63RXWs/QJssxpvLIeqIrPPFkaW97daK8H5LeehZR9JmR2YHtBvcudbRGGCMC
 dGISkKWum5ISzUfY/5e6Ft1bjGQHLQTm+wrkx0k9DWrJk8hLGnIM4ck8B3JbEHyBWn+9E/
 asZoU6iaTYWAt3P1rvqYD3QQSXp8mp4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-AFFqanjVPlK5jGx4WJNhvg-1; Tue,
 03 Mar 2026 04:26:47 -0500
X-MC-Unique: AFFqanjVPlK5jGx4WJNhvg-1
X-Mimecast-MFC-AGG-ID: AFFqanjVPlK5jGx4WJNhvg_1772530005
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACCE819560B5; Tue,  3 Mar 2026 09:26:45 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE82230001BF; Tue,  3 Mar 2026 09:26:42 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: [PATCH v2 21/21] sbsa_gwdt: limit compare_value to INT64_MAX
Date: Tue,  3 Mar 2026 10:25:32 +0100
Message-ID: <20260303092532.2410177-22-imammedo@redhat.com>
In-Reply-To: <20260303092532.2410177-1-imammedo@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

QEMU timer subsytem supports timeouts only upto INT64_MAX.
However WCV value geater than that will cause integer overflow
and timer will fire/expire immediately.

It looks like Windows tries to use SBSA watchdog when it's
exposed in GTDT ACPI table.
But instead of using WRR to refresh WCV with configured WOR,
it does direct load into WCV (probably as a means to
reschedule timer). While it's not against spec,
Windows does write following values:

 sbsa_gwdt_control_write [0x8] <- 0xffffffff
 sbsa_gwdt_control_write [0x0] <- 0x1
 sbsa_gwdt_control_write [0x14] <- 0xffffffff
 sbsa_gwdt_control_write [0x10] <- 0xa906ca28
 sbsa_gwdt_control_write [0x14] <- 0xecb1

1st intermediate write into 0x14 (WCVU),
puts WCV into timer overflow range,
triggering TimeoutRefresh and WS0 and WS1 asseritons.

Clamp WCV to INT64_MAX to avoid timer API overflow.
It prevents unexpected Windows reboots by watchdog.

PS:
Arguably Windows SBSA GWDT driver is broken,
as it:
  * sets WCV too far in the future so watchdog
    would never trigger in practice,
  * and typical watchdog flow for explict referesh
    also broken due to:
       1. small WOR value for explicit refresh (~4sec)
       2. never triggering explicit refresh (WRR or other)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/watchdog/sbsa_gwdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 7fec61b7b0..b1bce5008d 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -122,6 +122,8 @@ static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
     }
 
     timeout = (uint64_t)s->wcvu << 32 | s->wcvl;
+    /* clamp timeout to INT64_MAX to avoid timer overflow */
+    timeout &= INT64_MAX;
     timer_mod(s->timer, timeout);
 }
 
-- 
2.47.3


