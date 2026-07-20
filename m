Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F92C44527
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wllOb-0003jX-DS; Mon, 20 Jul 2026 06:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wllOW-0003jE-Ep
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wllOU-0008Fp-6C
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784543921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M1mbDPGNDDYLtz3dAfvpGEwZlm9V4lrrlmh7VeV1lw8=;
 b=OomYSHDdj0o0Ph82TkeM8wnuFeN7wuYSIUQHUlKwCa3ZX47uuMubJVSpiC/2LZlzTqsc8/
 P50wj2opToswE4No0KhvRCE4FhAb/0T5a0n2wSkZMqZ0HV+mL1UAMKorZtxUUZTkrgA5Du
 1mWin88yvrzAJDQVaLWn7S4AKgYgF+M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-3kCAbUIlPj-JDA4t0J-OAA-1; Mon,
 20 Jul 2026 06:38:39 -0400
X-MC-Unique: 3kCAbUIlPj-JDA4t0J-OAA-1
X-Mimecast-MFC-AGG-ID: 3kCAbUIlPj-JDA4t0J-OAA_1784543919
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08F341944D39; Mon, 20 Jul 2026 10:38:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.82])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 886C0158E; Mon, 20 Jul 2026 10:38:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Feifan Qian <bea1e@proton.me>
Subject: [PULL 1/7] hw/usb/xhci: clamp interval exponent to avoid UB shift in
 xhci_init_epctx()
Date: Mon, 20 Jul 2026 12:38:27 +0200
Message-ID: <20260720103833.364506-2-thuth@redhat.com>
In-Reply-To: <20260720103833.364506-1-thuth@redhat.com>
References: <20260720103833.364506-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

From: Feifan Qian <bea1e@proton.me>

The xHCI endpoint context dword 0 bits 23:16 ("Interval") are written
by the guest and passed directly as the shift amount in:

    epctx->interval = 1 << ((ctx[0] >> 16) & 0xff);

The shift amount can be 0-255.  Shifting a 32-bit `int` left by >= 32
is undefined behaviour under C11 §6.5.7p4.  With UBSan
(halt_on_error=1) this causes QEMU to abort; with aggressive compiler
optimisations that assume UB is unreachable the result is
unpredictable.

Clamp the exponent to [0, 18] with MIN() before the shift, and use
`1u` (unsigned) to avoid shifting a signed integer.  The xHCI
specification defines a maximum meaningful Interval value of 18 for
most endpoint types; thus clamping to 18 is a safe fix that
preserves the full unsigned 32-bit range for any compliant value.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3703
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Feifan Qian <bea1e@proton.me>
[thuth: Clamp to 18 instead of 31]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/hcd-xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index c7e050e38fd..47b7484d533 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1121,7 +1121,7 @@ static void xhci_init_epctx(XHCIEPContext *epctx,
         epctx->ring.ccs = ctx[2] & 1;
     }
 
-    epctx->interval = 1 << ((ctx[0] >> 16) & 0xff);
+    epctx->interval = 1u << MIN((ctx[0] >> 16) & 0xffu, 18u);
 }
 
 static TRBCCode xhci_enable_ep(XHCIState *xhci, unsigned int slotid,
-- 
2.55.0


