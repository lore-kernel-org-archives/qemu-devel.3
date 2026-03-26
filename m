Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B3410A88D4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5mxK-00081r-DS; Thu, 26 Mar 2026 11:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5mxG-0007ys-6E
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:49:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5mxE-0006js-KZ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774540143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IR9A5fiIjIB0O3EAmFTHjVPiQ0G8a3sd0cBH977/86M=;
 b=KulwYTi7LLuTipZH8OSwBbOuG9sgqMWc0WF3rWEBpIgt1DQd1qXXm4S3c8oSYy0DTZah2c
 VEVaYezHis/5z0rFIvXIwU7LmFaM5gqHWV/thtQph0wiZpD2tHSXT5MCVHIsR9umtadowJ
 WGqCWIfQOt4UrvL0N9AeJUX9bKLwLu8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-SRJDcjRFM5irFYZBzJZT6g-1; Thu,
 26 Mar 2026 11:48:59 -0400
X-MC-Unique: SRJDcjRFM5irFYZBzJZT6g-1
X-Mimecast-MFC-AGG-ID: SRJDcjRFM5irFYZBzJZT6g_1774540138
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD1D5195604F; Thu, 26 Mar 2026 15:48:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3344C1800673; Thu, 26 Mar 2026 15:48:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] hw/display/cirrus_vga_isa: Disable global_vmstate by default
 for new machines
Date: Thu, 26 Mar 2026 16:48:50 +0100
Message-ID: <20260326154850.301609-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

In the long run, we would like to get rid of the code that allows to
register migration state globally, so set global_vmstate to false when
using the isa-cirrus-vga device with new machines, and only enable it
for older machines to avoid breaking the migration there.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/core/machine.c           | 1 +
 hw/display/cirrus_vga_isa.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6cf0e2f404e..0aa77a57e95 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -40,6 +40,7 @@
 
 GlobalProperty hw_compat_10_2[] = {
     { "scsi-block", "migrate-pr", "off" },
+    { "isa-cirrus-vga", "global-vmstate", "true" },
 };
 const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
 
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
index bad9ec7599c..76034a88605 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -56,7 +56,6 @@ static void isa_cirrus_vga_realizefn(DeviceState *dev, Error **errp)
                    s->vram_size_mb);
         return;
     }
-    s->global_vmstate = true;
     if (!vga_common_init(s, OBJECT(dev), errp)) {
         return;
     }
@@ -74,6 +73,8 @@ static const Property isa_cirrus_vga_properties[] = {
                        cirrus_vga.vga.vram_size_mb, 4),
     DEFINE_PROP_BOOL("blitter", struct ISACirrusVGAState,
                      cirrus_vga.enable_blitter, true),
+    DEFINE_PROP_BOOL("global-vmstate", struct ISACirrusVGAState,
+                     cirrus_vga.vga.global_vmstate, false),
 };
 
 static void isa_cirrus_vga_class_init(ObjectClass *klass, const void *data)
-- 
2.53.0


