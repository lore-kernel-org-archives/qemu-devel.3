Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9706C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzasB-0003Qw-Ia; Thu, 27 Aug 2026 10:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzas7-00039G-Dl
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzas0-0005yq-4A
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IilviUqqjzVWhgY9u/Hx8KtxRScZH2+N6NtXQO4Y+nI=;
 b=dG6GUg7Z6VNPvlAF2UspZlhFKwOYBw/vWg6N2qQFkRgr0beBJhjM6/lsiWIbb5OAKUxWPI
 LEGPHR73jgp4mzs2UeKxI6Ahe9FIREZYeu/3yKJzw1Q+KEEHlnq6SbpJxU+yzyymuFM+mn
 T5XGAnfn1HpKR5v2cv0qPy75X1nhObQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-JqyqpZ-jNPWRayfAEGC2OA-1; Thu, 27 Aug 2026 10:14:18 -0400
X-MC-Unique: JqyqpZ-jNPWRayfAEGC2OA-1
X-Mimecast-MFC-AGG-ID: JqyqpZ-jNPWRayfAEGC2OA_1787840057
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-482e5323310so1547397f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840057; x=1788444857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IilviUqqjzVWhgY9u/Hx8KtxRScZH2+N6NtXQO4Y+nI=;
 b=g/3GLBW5APlLSJNJexSqTxZKO20MuacPE7gjAL4K3Wyw3z940Kpdq13enap+cmmryf
 kInP4C7TuHeSnlaCn9ol+LDaOw9RDTCv65UIUz34ZZuBrU3y7zictPc+djjG06FEmckM
 7uhRFa/yBURXk4SyEivOsWfdFXVWRukidIQLn1E6kPDRzLBemmtLx8hUuiQRQz+XVzSC
 LwLZHuJPKft+nOmXepM0Y4j907sfJ+WPMPYulM5p4IFPWBxJ9NEWWsRLqnWb5rEeqoQk
 wkG5KM6oPxHT2H5y6PHra4MpANjx/u/ikZErufIeoY24Mx889PC0AR4Vs0eYqxdolTzJ
 Y01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840057; x=1788444857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IilviUqqjzVWhgY9u/Hx8KtxRScZH2+N6NtXQO4Y+nI=;
 b=Eyq2YP6giQrOME3OAVeQiQaC+pt8uqklRDQGHVQZoeLHgu09Kb4aKcGo/3st2sYU2F
 7RZN2Bs7oNAQZsogH9+Z97OCtShYXdDKyKIcb3Aemkh5QZPUuDsZSyetvMIyvJv0q2wM
 PNKYPaA/k8dvLTzmChh/fsOBErUWbIWvGz+3WcQyy5EBFswV1UVpS/Zp2CafItYY83Gs
 vX9uj/dq+h0yKEQdzbFoim1JsTpAIdBiUqmpW8/DS8W9BAW4R2bIz6ayxh7o8XdErNSD
 1rUGoR5CTEdauYQwg/a/R1rMTyj483SULtxjkR4UoZpN+iJfrbBxmIs6tj61inpCjRZr
 tK4Q==
X-Gm-Message-State: AFuF++k1Yo9Hua+fYope7Q4P5ucTmTTRw/FxMoSg96nnSQwXb11TS+SW
 FT33HyGwJu3CXE5ccUYxBOcgwuAc7qnUDJ64hytIG3Uv7LKiSMTUGNjUNOBmJErGBSYttPvqz24
 9upzq+JwjtpSyIYjOhLfv44NgD6t+/bb7Xzzn6OxvqPey56J8Z1Eovm2vWy4Dph2YWz6yK3kNQq
 A0uvFPKXU7a1nwswQ0QvW1ah03sD4qXn/EFw14gmTy
X-Gm-Gg: AR+sD10WoH03O/S4b+N2P5w9hACedZDLlhIUO3w7SnGCftsR2ennDu8wZPuMsidFqna
 rJ1Wf4BzaRYBcP2GuhsU8piIwF6ChBk7KC9BNHqUN6b7g9u/noy0qMmj5VEAEAr2Qy6haNz7T+n
 5eLhZLmZkixHiSstQgXjq9NS+TWyNtKusoG2K4AwdIs+dpbxkIdkmAjZ7G9XmWePfYhyaOS204w
 B8d3dWrzpVYgQTIR3uLGm1xwGmqi5LrFajkrZuXBYpPuMeJRWOynxoOn1YqvngjUnXvQO1UH665
 lhoNlYWx92oXup/k944BeCdxurtTjW1MAv4frBvqmmN+Ql/5C+hhomHvbgSOTcCVCZkFReyd3k1
 Y5ov5l5CdFfdBnADrGiEl6ono5MY8vsl32UpJku0iThyqRYes5cY1+tOxCoW3CJl2QtzTMHMO6E
 sg6UQ=
X-Received: by 2002:a05:600c:1393:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-499dc7253d8mr190065875e9.11.1787840056717; 
 Thu, 27 Aug 2026 07:14:16 -0700 (PDT)
X-Received: by 2002:a05:600c:1393:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-499dc7253d8mr190064115e9.11.1787840056176; 
 Thu, 27 Aug 2026 07:14:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b40ccb345sm39195615e9.2.2026.08.27.07.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:14:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 21/23] scsi: hide MODE SELECT block size change behind a quirk
Date: Thu, 27 Aug 2026 16:13:09 +0200
Message-ID: <20260827141314.1099352-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Cc: qemu-stable@nongnu.org
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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


