Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636C5C98311
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9fPM-0008GA-Q5; Thu, 24 Sep 2026 05:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x9fPD-0008EM-Au
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x9fPB-0000jH-0M
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790240772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Iey1EbontVM7Gl3HcB40O7kEWHACWTZ8TmHMXJFCwc=;
 b=W9b7cY3eqiR50eOW6zuNPR4DbOtxNaRCRqtCppUGIOlbCRRmH172HurgoXjD6u7pBKjZCX
 61vy+At37IDzRTRcFjq7bvPPNkaoskvX5IPEcDmeu0n+wK/KcSEUy7ctpqRnQCp8GsjjMX
 NjtyhV+v09ZScPsNBDGxruFgVVZyoCA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-6zxBTioKNZGpu-mnolXQhA-1; Thu,
 24 Sep 2026 05:06:08 -0400
X-MC-Unique: 6zxBTioKNZGpu-mnolXQhA-1
X-Mimecast-MFC-AGG-ID: 6zxBTioKNZGpu-mnolXQhA_1790240767
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C66081805A07; Thu, 24 Sep 2026 09:06:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D35D195604C; Thu, 24 Sep 2026 09:06:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Junjie Cao <junjie.cao@intel.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 4/7] hw/usb/hcd-xhci: fix interval alignment after MFINDEX
 passes 2^32
Date: Thu, 24 Sep 2026 11:05:55 +0200
Message-ID: <20260924090558.801845-5-thuth@redhat.com>
In-Reply-To: <20260924090558.801845-1-thuth@redhat.com>
References: <20260924090558.801845-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Junjie Cao <junjie.cao@intel.com>

epctx->interval is an unsigned int, so ~(epctx->interval - 1) is a
32-bit mask that is zero-extended when and-ed with the 64-bit microframe
index. Once mfindex no longer fits in 32 bits (2^32 * 125us, about 6.2
days after the controller was started), asap loses its upper half and
always compares below mfindex. Isoch TDs with SIA are then run at once
instead of at the next interval boundary. xhci_calc_intr_kick() has the
same expression.

Use ROUND_UP(), which builds the mask in the type of mfindex. The
interval is always a power of two.

The reporter of #3973 also saw the symptom with UHCI. This change does
not explain that.

Fixes: 3d1396842d ("xhci: iso xfer support")
Fixes: 4d7a81c06f ("xhci: emulate intr endpoint intervals correctly")
Link: https://gitlab.com/qemu-project/qemu/-/issues/3973
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <52c9f935428f2cfc65e4dee7e37638fcb965c6b2.1789968699.git.junjie.cao@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/hcd-xhci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 0ebf7a638a1..2f82b76272d 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1756,8 +1756,7 @@ static int xhci_fire_ctl_transfer(XHCIState *xhci, XHCITransfer *xfer)
 static void xhci_calc_intr_kick(XHCIState *xhci, XHCITransfer *xfer,
                                 XHCIEPContext *epctx, uint64_t mfindex)
 {
-    uint64_t asap = ((mfindex + epctx->interval - 1) &
-                     ~(epctx->interval-1));
+    uint64_t asap = ROUND_UP(mfindex, epctx->interval);
     uint64_t kick = epctx->mfindex_last + epctx->interval;
 
     assert(epctx->interval != 0);
@@ -1768,8 +1767,7 @@ static void xhci_calc_iso_kick(XHCIState *xhci, XHCITransfer *xfer,
                                XHCIEPContext *epctx, uint64_t mfindex)
 {
     if (xfer->trbs[0].control & TRB_TR_SIA) {
-        uint64_t asap = ((mfindex + epctx->interval - 1) &
-                         ~(epctx->interval-1));
+        uint64_t asap = ROUND_UP(mfindex, epctx->interval);
         if (asap >= epctx->mfindex_last &&
             asap <= epctx->mfindex_last + epctx->interval * 4) {
             xfer->mfindex_kick = epctx->mfindex_last + epctx->interval;
-- 
2.55.0


