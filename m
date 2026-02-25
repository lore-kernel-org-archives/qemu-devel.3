Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1C8EFD214
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 09:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvB52-0000YL-PX; Wed, 25 Feb 2026 04:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvB50-0000XO-Qs
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:21:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvB4z-0003Ss-C0
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772011272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kKWUWB3jIiIlCxv/XW+CKGBcI6/0gY/mOb+y8lr9gI=;
 b=hoMUSNkeA5Ylqk2lmpMmgfoGrJs5TZqO6yZupwOD9nDe8skq2eyPYToHXBL84BeR8lyTCU
 z21FVHgtYGCfNt6CWhd68pNEQC41nYq/ZcEcJUc99IIpN2twfidJ0zTjydW0gDJ6qjmNc+
 IPL/sHs44Cu6MzLm1tftTndspubQceA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-md6RXJr_N1uuqowE3q7cVw-1; Wed,
 25 Feb 2026 04:21:08 -0500
X-MC-Unique: md6RXJr_N1uuqowE3q7cVw-1
X-Mimecast-MFC-AGG-ID: md6RXJr_N1uuqowE3q7cVw_1772011266
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EFCA195608F; Wed, 25 Feb 2026 09:21:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.158])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2695319560B6; Wed, 25 Feb 2026 09:21:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 05/16] hw/block/pflash: Remove
 PFlashCFI01::old_multiple_chip_handling field
Date: Wed, 25 Feb 2026 10:20:13 +0100
Message-ID: <20260225092024.794595-6-thuth@redhat.com>
In-Reply-To: <20260225092024.794595-1-thuth@redhat.com>
References: <20260225092024.794595-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The PFlashCFI01::old_multiple_chip_handling boolean was only set
in the hw_compat_2_8[] array, via the 'old-multiple-chip-handling=on'
property. We removed all machines using that array, let's remove that
property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501210456.89071-7-philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/block/pflash_cfi01.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index c0f5b9d8fad..5b9ddb20b18 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -84,7 +84,6 @@ struct PFlashCFI01 {
     char *name;
     void *storage;
     VMChangeStateEntry *vmstate;
-    bool old_multiple_chip_handling;
 
     /* block update buffer */
     unsigned char *blk_bytes;
@@ -703,13 +702,8 @@ static void pflash_cfi01_fill_cfi_table(PFlashCFI01 *pfl)
      * in the cfi_table[].
      */
     num_devices = pfl->device_width ? (pfl->bank_width / pfl->device_width) : 1;
-    if (pfl->old_multiple_chip_handling) {
-        blocks_per_device = pfl->nb_blocs / num_devices;
-        sector_len_per_device = pfl->sector_len;
-    } else {
-        blocks_per_device = pfl->nb_blocs;
-        sector_len_per_device = pfl->sector_len / num_devices;
-    }
+    blocks_per_device = pfl->nb_blocs;
+    sector_len_per_device = pfl->sector_len / num_devices;
     device_len = sector_len_per_device * blocks_per_device;
 
     /* Hardcoded CFI table */
@@ -765,7 +759,7 @@ static void pflash_cfi01_fill_cfi_table(PFlashCFI01 *pfl)
         pfl->cfi_table[0x2A] = 0x0B;
     }
     pfl->writeblock_size = 1 << pfl->cfi_table[0x2A];
-    if (!pfl->old_multiple_chip_handling && num_devices > 1) {
+    if (num_devices > 1) {
         pfl->writeblock_size *= num_devices;
     }
 
@@ -930,8 +924,6 @@ static const Property pflash_cfi01_properties[] = {
     DEFINE_PROP_UINT16("id2", PFlashCFI01, ident2, 0),
     DEFINE_PROP_UINT16("id3", PFlashCFI01, ident3, 0),
     DEFINE_PROP_STRING("name", PFlashCFI01, name),
-    DEFINE_PROP_BOOL("old-multiple-chip-handling", PFlashCFI01,
-                     old_multiple_chip_handling, false),
 };
 
 static void pflash_cfi01_class_init(ObjectClass *klass, const void *data)
-- 
2.53.0


