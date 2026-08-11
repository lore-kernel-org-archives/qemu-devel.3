Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D80C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNI-0008N6-GA; Tue, 11 Aug 2026 12:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMn-0007lc-Q2
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMh-0000Qw-TQ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4kb9+FO8D9DMEG3OsHhAbeQGh9qiHrCiL0JH8s3Mpg=;
 b=Zs/SpxmQe5O8BkpA928iSzy96KRmf6zxsLO9tcxAfKchgR7g4l1ygzve0RBOAT0gt4LvVO
 6yDGpp3Bz8GRy+xvlu1jsu6qvTCBcu84u33sIE3Lh9rmw006YHiEy5jhOF844WfcL0uhCq
 apd4VZciybCHWTMRt8P8YGrYxstVnew=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-Ka_G6JZhMwqEkDrTBDUatw-1; Tue,
 11 Aug 2026 12:30:06 -0400
X-MC-Unique: Ka_G6JZhMwqEkDrTBDUatw-1
X-Mimecast-MFC-AGG-ID: Ka_G6JZhMwqEkDrTBDUatw_1786465805
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98CD1195608B; Tue, 11 Aug 2026 16:30:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E539B195DF91; Tue, 11 Aug 2026 16:30:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/83] hw/usb/hcd-ehci: Add ctrldssegment-default property
Date: Tue, 11 Aug 2026 18:28:25 +0200
Message-ID: <20260811162938.1403216-11-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

When 64-bit addressing is supported, the Linux EHCI driver programs the
segment register to zero. See ehci_run function:
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c

The driver comment also notes that descriptor structures allocated from
the DMA pool use segment zero semantics.

Descriptor memory is allocated using the DMA API. The platform driver
configures a 64-bit DMA mask so memory can be allocated above 4GB.
See ehci_platform_probe function:
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-platform.c

On AST2700 platforms, system DRAM is mapped above 4GB at 0x400000000.
As a result, descriptor addresses constructed directly from the guest
EHCI registers do not match the actual system address used by the
controller when fetching queue heads (QH) and queue element transfer
descriptors (qTD).

Add a ctrldssegment-default property so platforms can provide a
descriptor address offset when constructing descriptor addresses.
This allows systems where DRAM resides above 4GB to access EHCI
descriptors correctly.

The default value is zero, so existing machines are not affected.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260713032704.3583103-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/usb/hcd-ehci.h | 5 ++++-
 hw/usb/hcd-ehci.c | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 49176f3fd282..b5ac9c8670d9 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -268,6 +268,7 @@ struct EHCIState {
      */
     bool migrate_fetch_addr_64bit;
     bool caps_64bit_addr;
+    uint32_t ctrldssegment_default;
 
     /*
      *  EHCI spec version 1.0 Section 2.3
@@ -333,7 +334,9 @@ struct EHCIState {
     DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \
                      ehci.migrate_fetch_addr_64bit, true), \
     DEFINE_PROP_BOOL("caps-64bit-addr", _state, \
-                     ehci.caps_64bit_addr, false)
+                     ehci.caps_64bit_addr, false), \
+    DEFINE_PROP_UINT32("ctrldssegment-default", _state, \
+                       ehci.ctrldssegment_default, 0)
 
 extern const VMStateDescription vmstate_ehci;
 
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 9a80c74972c3..451a918e9f5f 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1162,6 +1162,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
                           "64-bit addressing capability is disabled\n");
             return;
         }
+        val |= s->ctrldssegment_default;
         break;
 
     case ASYNCLISTADDR:
-- 
2.55.0


