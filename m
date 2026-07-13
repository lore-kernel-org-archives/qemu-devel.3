Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3C9C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDXY-0006MS-P2; Mon, 13 Jul 2026 06:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wjDXT-0006Kx-Lb
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wjDXS-0006Sf-6c
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783937125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VOJwklUEQ8Mub0KPu+2trNh461ZWY5s7bnxYeKpK3vE=;
 b=YVPEMr/XzspK+KOVR+AGSAnomcsXZuaqUIa8ZvbC4G74LcEktA8L0IRCZT+/EGG3Oqu+aM
 TJfBSgWHVDHaasXSOb6kkMlC4pWYyC0Ip7hpASHFLUtOl2WGDPeOpR6gnQwdGPTffnlKM9
 ybvd4tQCkbibrPCIbC1ziMI4BFVIDHc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-8SIJIqQVPuuYwc0XKp7tWw-1; Mon,
 13 Jul 2026 06:05:23 -0400
X-MC-Unique: 8SIJIqQVPuuYwc0XKp7tWw-1
X-Mimecast-MFC-AGG-ID: 8SIJIqQVPuuYwc0XKp7tWw_1783937122
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94B0118009F0; Mon, 13 Jul 2026 10:05:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59EBC36919; Mon, 13 Jul 2026 10:05:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 3/3] hw/usb/hcd-xhci: Use qemu_log_mask() instead of
 fprintf() statement
Date: Mon, 13 Jul 2026 12:05:08 +0200
Message-ID: <20260713100508.123623-4-thuth@redhat.com>
In-Reply-To: <20260713100508.123623-1-thuth@redhat.com>
References: <20260713100508.123623-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

We've got a proper way for logging unimplemented hardware features,
so use qemu_log_mask() instead of the fprintf() here now.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/hcd-xhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index ee913d5c4d5..527910d92d2 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1017,7 +1017,8 @@ static XHCIStreamContext *xhci_find_stream(XHCIEPContext *epctx,
         }
         sctx = epctx->pstreams + streamid;
     } else {
-        fprintf(stderr, "xhci: FIXME: secondary streams not implemented yet");
+        qemu_log_mask(LOG_UNIMP,
+                      "xhci: secondary streams not implemented yet");
         *cc_error = CC_INVALID_STREAM_TYPE_ERROR;
         return NULL;
     }
-- 
2.55.0


