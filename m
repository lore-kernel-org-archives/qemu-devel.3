Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E104CC10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 18:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0450-0000bg-5h; Thu, 25 Apr 2024 14:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s044y-0000bR-K0
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 14:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s044B-0004ra-Jg
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 14:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714070609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kcZZ0kZSAdohuUyLtWV7fjOmIzrCShpRO748CvVclCE=;
 b=Gk5wdU/p6/HrzdnceVqMGmjhPopm9SkrOddghffgNCwELFTy9Rwjp9SvGTlmDqtAKhpJB8
 LizieSFHKubYSeqm0tiu37wz3k1rVlLvWdQgmr4n+aLfgAadp8ayJDWEQLAQ3P+5q3OJXh
 nCDBIbiwc7zsMC0Qwznko3p8i/1ndTg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-Y22rRTz_PEqS2jvnYdN4Ow-1; Thu, 25 Apr 2024 14:43:25 -0400
X-MC-Unique: Y22rRTz_PEqS2jvnYdN4Ow-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9992A18065AD;
 Thu, 25 Apr 2024 18:43:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F0885AD060;
 Thu, 25 Apr 2024 18:43:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
Subject: [PATCH 1/3] hw/i386/pc: Allow to compile without CONFIG_FDC_ISA
Date: Thu, 25 Apr 2024 20:43:13 +0200
Message-ID: <20240425184315.553329-2-thuth@redhat.com>
In-Reply-To: <20240425184315.553329-1-thuth@redhat.com>
References: <20240425184315.553329-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The q35 machine can work without FDC. But to be able to also link
a QEMU binary that does not include the FDC code, we have to make
it possible to disable the spots that call into the FDC code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 08c7de416f..93c48f6747 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -439,16 +439,19 @@ static void pc_boot_set(void *opaque, const char *boot_device, Error **errp)
 
 static void pc_cmos_init_floppy(MC146818RtcState *rtc_state, ISADevice *floppy)
 {
-    int val, nb, i;
+    int val, nb;
     FloppyDriveType fd_type[2] = { FLOPPY_DRIVE_TYPE_NONE,
                                    FLOPPY_DRIVE_TYPE_NONE };
 
+#ifdef CONFIG_FDC_ISA
     /* floppy type */
     if (floppy) {
-        for (i = 0; i < 2; i++) {
+        for (int i = 0; i < 2; i++) {
             fd_type[i] = isa_fdc_get_drive_type(floppy, i);
         }
     }
+#endif
+
     val = (cmos_get_fd_drive_type(fd_type[0]) << 4) |
         cmos_get_fd_drive_type(fd_type[1]);
     mc146818rtc_set_cmos_data(rtc_state, 0x10, val);
@@ -1132,7 +1135,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
     int i;
     DriveInfo *fd[MAX_FD];
     qemu_irq *a20_line;
-    ISADevice *fdc, *i8042, *port92, *vmmouse;
+    ISADevice *i8042, *port92, *vmmouse;
 
     serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
     parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
@@ -1142,11 +1145,13 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
         create_fdctrl |= !!fd[i];
     }
     if (create_fdctrl) {
-        fdc = isa_new(TYPE_ISA_FDC);
+#ifdef CONFIG_FDC_ISA
+        ISADevice *fdc = isa_new(TYPE_ISA_FDC);
         if (fdc) {
             isa_realize_and_unref(fdc, isa_bus, &error_fatal);
             isa_fdc_init_drives(fdc, fd);
         }
+#endif
     }
 
     if (!create_i8042) {
-- 
2.44.0


