Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4CEC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIC3-0005bX-QA; Wed, 26 Aug 2026 14:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzIBv-0005a8-VJ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzIBu-0005WW-EP
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787768257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmA01+NJFdfF+QUZyWfl2umk/yb4CaXDHsGFoM/5q/U=;
 b=ilEG7FSLq0hbcI1kWXn3lHtZ+Gxk5LsYEWZT3VoixZ4CKetDYnNQaf29ujlfMcyQ7AAeyY
 eeItAB49Rwb3Sq0lYWAoVQCAb+/mxvVJT8OOFOFvyAJmNW38XYJKu6aQ6CfHxHU1nT59hp
 8Y4cFV8lO1Buo1/+DPzgI4FE10SodlQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-ULSGYlbePX-TyML1kKEWnA-1; Wed, 26 Aug 2026 14:17:36 -0400
X-MC-Unique: ULSGYlbePX-TyML1kKEWnA-1
X-Mimecast-MFC-AGG-ID: ULSGYlbePX-TyML1kKEWnA_1787768254
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c160b9c0676so68220266b.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787768254; x=1788373054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cmA01+NJFdfF+QUZyWfl2umk/yb4CaXDHsGFoM/5q/U=;
 b=VgfkoP8O4Mq8vJ1JeAKxcERkvtEL2CeHuAJapn+iwEDmlnk3/R+giTQ5ksjkOiLWWe
 2BcqGufJBYE3BqqLnKnTIRgvc2K7zSBRQE4LP5c7VeH5IFS1vViRigtCfyEZFPVicwE+
 lHf2BPjjYCz8IacpnqjTY3dWW+IlvSUkcJMQYbShsN8FwS1EFh2pd6412eySgg4lQcIb
 pSuFGPy9KDzrMr+1Q8c7ELPgp7CGMeMX0gDyuWrfIEyu720joLuEdw2uVoA+SfWGqBao
 tp6bdNpxftajzS0tVZ8w7k3nswlBfTzmK/Ien7B6Y+FkExIrm+lSI15VokJHShUfkqz5
 28wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787768254; x=1788373054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cmA01+NJFdfF+QUZyWfl2umk/yb4CaXDHsGFoM/5q/U=;
 b=fydb1pDwinl+/3m5sqPrQL2ODyw1GXx+pFf8g9QHSCA9TDWH34Q7+WSNzI4KPaSA+W
 rOXcXWRdcfOVvP0nZjONu9qeCIl48OTDPmYFZ2l60J/A1167H33pD0prGjoCEN2wk179
 HSzrGHPvZjEmAT5H21FJRsj2YkvFP/UeZbh5sMYGZXa9iTlXNQ7vtPcNUTntjLpnFN2R
 CHqAHqoaBT8wEIlGT2a/0NntxDR8xsLfGtvGSMJnQdEr4mhaWQVIoyuR+h4ZXdf61+jM
 N6wHhSMGuF0+vTywKEuInmpylzlgOzZSSOQJjzdRspodf/nWAIRFDIRm+nAOnyDvdQxc
 6WHw==
X-Gm-Message-State: AFuF++mYHXKuKKWZLSIlqQYcKQMyYYRTjoWJ3sdONU0THVwhwoYlmPn4
 zw0olGX/4waiRCVoNUa5/bYSLZXauxWVZuG9dB1ld9VTxs/RyH7bGmh4tgGGFKoAqajVamANO0f
 hZDWb9Jcv7z+K0/sarvhEWAvrAaLO7vP/QEdeYAw29Dt7bY7le0+7OAmgRQno0fiD3ze0TdDfS5
 9KwaxeStClnFzVDPSTUh0darlmiO5wKagXFLcerx0z
X-Gm-Gg: AR+sD13XQqeY1BSbZHYfQCP59eauz0FLPsUIYJ2zoeD1LHEadJLJ7u+3PxjVaGPmht/
 96iMBNNyVZR75yUwL36g8GWDQ39IMe3qDlH37uK6duVkWkUy6zkE7o2D0QG9tmW55auJj83rf0O
 E4NW+piW58lFC+teTTCLfajjesDWnB/od+335bM9yeSic/BQWdDdb2aHsxn3QX0LlbnCow3sf5b
 EbcGoa68vfakMkqC48h+nSNpvs4VcO9+mxaQab/g1eSKsY3j3/kpml7gwma/mvgDlHgjeDqdETk
 9be0AdS/n7IzzNaXjSgcU6E7biffjyJTiZ5cnfW3Z/wDYvolK5V/RCHwRtmY3jVIQJq+Mv4+YGa
 PsLHxJusxi2Xs1Xvte9GVfhsTv57NlI2KVNHee96ynbWg/bGizSBRhE/3UpWquMlQ8zwUBS6mwE
 xcIw==
X-Received: by 2002:a17:907:ea8e:b0:c24:d914:6d64 with SMTP id
 a640c23a62f3a-c250c32cb23mr1112104866b.23.1787768253926; 
 Wed, 26 Aug 2026 11:17:33 -0700 (PDT)
X-Received: by 2002:a17:907:ea8e:b0:c24:d914:6d64 with SMTP id
 a640c23a62f3a-c250c32cb23mr1112099866b.23.1787768253470; 
 Wed, 26 Aug 2026 11:17:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b4e9csm637572066b.54.2026.08.26.11.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:17:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH 2/2] scsi: hide MODE SELECT block size change behind a quirk
Date: Wed, 26 Aug 2026 20:17:25 +0200
Message-ID: <20260826181725.849718-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826181725.849718-1-pbonzini@redhat.com>
References: <20260826181725.849718-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a dangerous operation in that the block size is not
protected by a lock, but it can be written concurrently if
you have a multi-queue virtio-scsi HBA.  Put it behind a quirk
that is only enabled by the Q800 machine, since the MODE
SELECT feature was added for A/UX.

Fixes: 356c4c441ec ("scsi-disk: allow MODE SELECT block descriptor to set the block size", 2022-07-13)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/scsi/scsi.h |  1 +
 hw/m68k/q800.c         |  2 ++
 hw/scsi/scsi-disk.c    | 12 ++++++++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index c60c6e8810e..3eab339b0d2 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -262,5 +262,6 @@ bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp);
 #define SCSI_DISK_QUIRK_MODE_SENSE_ROM_USE_DBD             1
 #define SCSI_DISK_QUIRK_MODE_PAGE_VENDOR_SPECIFIC_APPLE    2
 #define SCSI_DISK_QUIRK_MODE_PAGE_TRUNCATED                3
+#define SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE           4
 
 #endif
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ab64250c47c..1ad3f93b294 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -710,12 +710,14 @@ static void q800_init(Object *obj)
 
 static GlobalProperty hw_compat_q800[] = {
     { "scsi-hd", "quirk_mode_page_vendor_specific_apple", "on" },
+    { "scsi-hd", "quirk_mode_page_set_block_size", "on" },
     { "scsi-hd", "vendor", " SEAGATE" },
     { "scsi-hd", "product", "          ST225N" },
     { "scsi-hd", "ver", "1.0 " },
     { "scsi-cd", "quirk_mode_page_apple_vendor", "on" },
     { "scsi-cd", "quirk_mode_sense_rom_use_dbd", "on" },
     { "scsi-cd", "quirk_mode_page_vendor_specific_apple", "on" },
+    { "scsi-cd", "quirk_mode_page_set_block_size", "on" },
     { "scsi-cd", "quirk_mode_page_truncated", "on" },
     { "scsi-cd", "vendor", "MATSHITA" },
     { "scsi-cd", "product", "CD-ROM CR-8005" },
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 5bb7a974d69..a42f7d8e77d 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1673,8 +1673,12 @@ static void scsi_disk_emulate_mode_select(SCSIDiskReq *r, uint8_t *inbuf)
         goto invalid_param;
     }
 
-    /* Allow changing the block size */
-    if (bd_len) {
+    /*
+     * Allow changing the block size only if the quirk is enabled for it.
+     * Writing s->qdev.blocksize is not thread safe!
+     */
+    if (bd_len && (s->quirks &
+                   (1 << SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE))) {
         bs = p[5] << 16 | p[6] << 8 | p[7];
 
         /*
@@ -3247,6 +3251,8 @@ static const Property scsi_hd_properties[] = {
     DEFINE_PROP_BIT("quirk_mode_page_vendor_specific_apple", SCSIDiskState,
                     quirks, SCSI_DISK_QUIRK_MODE_PAGE_VENDOR_SPECIFIC_APPLE,
                     0),
+    DEFINE_PROP_BIT("quirk_mode_page_set_block_size", SCSIDiskState,
+                    quirks, SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE, 0),
     DEFINE_BLOCK_CHS_PROPERTIES(SCSIDiskState, qdev.conf),
 };
 
@@ -3352,6 +3358,8 @@ static const Property scsi_cd_properties[] = {
                     0),
     DEFINE_PROP_BIT("quirk_mode_page_truncated", SCSIDiskState, quirks,
                     SCSI_DISK_QUIRK_MODE_PAGE_TRUNCATED, 0),
+    DEFINE_PROP_BIT("quirk_mode_page_set_block_size", SCSIDiskState,
+                    quirks, SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE, 0),
 };
 
 static void scsi_cd_class_initfn(ObjectClass *klass, const void *data)
-- 
2.55.0


