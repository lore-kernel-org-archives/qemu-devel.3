Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D97C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLfji-00082b-B1; Mon, 24 Jun 2024 05:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLfjg-00080q-95
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:11:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLfjM-0003tc-Gs
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719220277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sBJxnGxxWlao4SQioulONYxmRwRuQuSonIEpsqeTDuU=;
 b=ENeziyc6QYxs4X+bNl+fpwW0BM1a6jtdsDUt5pu6HWXkOz7liN8RAkEHmoHyy3ABJn5iX4
 2W+Ly0mdfigbFFzg52qdz3cArlCbrzuYwtAH4i0q4f12YBHbxtetUoTSu0VnHMtHPN1FYY
 Xidoco5cBm5FYpz6jUPKI6HcuMQvFao=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-OH6eC_6iNQOHxLomabesXg-1; Mon,
 24 Jun 2024 05:11:13 -0400
X-MC-Unique: OH6eC_6iNQOHxLomabesXg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BC7F19560B2; Mon, 24 Jun 2024 09:11:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFE2A3000219; Mon, 24 Jun 2024 09:11:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 07/11] vfio/{ap,
 ccw}: Use warn_report_err() for IRQ notifier registration errors
Date: Mon, 24 Jun 2024 11:10:39 +0200
Message-ID: <20240624091043.177484-8-thuth@redhat.com>
In-Reply-To: <20240624091043.177484-1-thuth@redhat.com>
References: <20240624091043.177484-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

vfio_ccw_register_irq_notifier() and vfio_ap_register_irq_notifier()
errors are currently reported using error_report_err(). Since they are
not considered as failing conditions, using warn_report_err() is more
appropriate.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240522170107.289532-8-clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/vfio/ap.c  | 2 +-
 hw/vfio/ccw.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index c12531a788..0c4354e3e7 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -172,7 +172,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
          * Report this error, but do not make it a failing condition.
          * Lack of this IRQ in the host does not prevent normal operation.
          */
-        error_report_err(err);
+        warn_report_err(err);
     }
 
     return;
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 36f2677a44..1f8e1272c7 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -616,7 +616,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
          * Report this error, but do not make it a failing condition.
          * Lack of this IRQ in the host does not prevent normal operation.
          */
-        error_report_err(err);
+        warn_report_err(err);
     }
 
     return;
-- 
2.45.2


