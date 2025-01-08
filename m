Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569AEE77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 10:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVStz-0003BI-LP; Wed, 08 Jan 2025 05:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tVStp-0003Ag-IJ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 05:02:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tVSto-0007bb-1q
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 05:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736330569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I9NE3z7kNsMBbqhUDW8tihTBQd8HYQLiFaWimPHs12Y=;
 b=cn7X711nzGQBB1GyaOBEu20BfrKWJ27QbqOFAW3Vxkb9g1mySmHUD3DKSpZen6DrsCOF7q
 ZJHoF9LHJE8HsQy1DgYNsNy5QwZxmvWIw7+Tv3dt7PHO29WzwHLU+/7KwFOz89Gn8hAOOi
 eP3OFl4YVIfRIm44zGq/gsUAA3LX33Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-fnvltWnjNhymUEBAGrJosg-1; Wed,
 08 Jan 2025 05:02:48 -0500
X-MC-Unique: fnvltWnjNhymUEBAGrJosg-1
X-Mimecast-MFC-AGG-ID: fnvltWnjNhymUEBAGrJosg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 259B719153C3; Wed,  8 Jan 2025 10:02:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.35])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AF4319560AA; Wed,  8 Jan 2025 10:02:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] hw/sd/sdcard: Remove sd_set_cb()
Date: Wed,  8 Jan 2025 11:02:40 +0100
Message-ID: <20250108100240.960593-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Last user of sd_set_cb() was removed in commit ce5dd27534b0 ("hw/sd:
Remove omap2_mmc device").

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/sd/sdcard_legacy.h | 1 -
 hw/sd/sd.c                    | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/include/hw/sd/sdcard_legacy.h b/include/hw/sd/sdcard_legacy.h
index 0dc388955512..a121232560d7 100644
--- a/include/hw/sd/sdcard_legacy.h
+++ b/include/hw/sd/sdcard_legacy.h
@@ -36,7 +36,6 @@ SDState *sd_init(BlockBackend *blk, bool is_spi);
 int sd_do_command(SDState *card, SDRequest *request, uint8_t *response);
 void sd_write_byte(SDState *card, uint8_t value);
 uint8_t sd_read_byte(SDState *card);
-void sd_set_cb(SDState *card, qemu_irq readonly, qemu_irq insert);
 
 /* sd_enable should not be used -- it is only used on the nseries boards,
  * where it is part of a broken implementation of the MMC card slot switch
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3e8fa1e35764..6765f743e118 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1034,14 +1034,6 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
     return sd;
 }
 
-void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert)
-{
-    sd->readonly_cb = readonly;
-    sd->inserted_cb = insert;
-    qemu_set_irq(readonly, sd->blk ? !blk_is_writable(sd->blk) : 0);
-    qemu_set_irq(insert, sd->blk ? blk_is_inserted(sd->blk) : 0);
-}
-
 static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 {
     trace_sdcard_read_block(addr, len);
-- 
2.47.1


