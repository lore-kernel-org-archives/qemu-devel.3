Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DEFC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 12:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Zyc-0002jU-67; Thu, 16 May 2024 08:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1s7Zya-0002ir-1b
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:12:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1s7ZyX-0006DC-2v
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715861563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XO8uGkQlVpeYGzDBomi3TaIA07u7WaOl613i3Gui/Qc=;
 b=cqcf3fRwfU/EV3n2DDVaZ05p3s803+LtRAUaqg7a5GMUnd/twUaACojviy/u9x3q4V0IE2
 yrIukis+w3KUNHXMoJz54wMdufO7MJ6DRqZ6OMnm5mazG8OTj9bd7XPk9N1O67qM8FBnwA
 BgLV1R6K8aQzI4u6/ozXY4CBwCRXc+0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-B1mYVx28PpW44CPoL7U_7w-1; Thu,
 16 May 2024 08:12:39 -0400
X-MC-Unique: B1mYVx28PpW44CPoL7U_7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C397C3C000A9;
 Thu, 16 May 2024 12:12:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 681EB5621;
 Thu, 16 May 2024 12:12:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 692D01800DE0; Thu, 16 May 2024 14:12:37 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v5] hw/pflash: fix block write start
Date: Thu, 16 May 2024 14:12:37 +0200
Message-ID: <20240516121237.534875-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move the pflash_blk_write_start() call.  We need the offset of the
first data write, not the offset for the setup (number-of-bytes)
write.  Without this fix u-boot can do block writes to the first
flash block only.

While being at it drop a leftover FIXME.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2343
Fixes: 284a7ee2e290 ("hw/pflash: implement update buffer for block writes")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/block/pflash_cfi01.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 1bda8424b907..c8f1cf5a8722 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -518,10 +518,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             break;
         case 0xe8: /* Write to buffer */
             trace_pflash_write(pfl->name, "write to buffer");
-            /* FIXME should save @offset, @width for case 1+ */
-            qemu_log_mask(LOG_UNIMP,
-                          "%s: Write to buffer emulation is flawed\n",
-                          __func__);
             pfl->status |= 0x80; /* Ready! */
             break;
         case 0xf0: /* Probe for AMD flash */
@@ -574,7 +570,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             }
             pfl->counter = value;
             pfl->wcycle++;
-            pflash_blk_write_start(pfl, offset);
             break;
         case 0x60:
             if (cmd == 0xd0) {
@@ -605,6 +600,9 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
         switch (pfl->cmd) {
         case 0xe8: /* Block write */
             /* FIXME check @offset, @width */
+            if (pfl->blk_offset == -1 && pfl->counter) {
+                pflash_blk_write_start(pfl, offset);
+            }
             if (!pfl->ro && (pfl->blk_offset != -1)) {
                 pflash_data_write(pfl, offset, value, width, be);
             } else {
-- 
2.45.0


