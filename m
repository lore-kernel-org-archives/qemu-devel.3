Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D09BC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzhG-0007Yx-SQ; Wed, 16 Jul 2025 06:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzdo-0000M2-Ce
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzdm-0000iT-5E
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dng6vSqrufpXyR51i5KxpTr40UkIvxFqTj6xvsgMitU=;
 b=DEZFL8ooheTqRc/yNezEEmXJcgL1WHDPn5E8QESrkGPaRglAyzs7rzTXhlXKvON4RVtocD
 4YsqnYuii0U5m9ELSBkoNIlqt+F6m3lwiKFYDZuZ5q9VZ5nqz+ACzx7xMrYhNxU1pjVFli
 budS1mlZOiQiVnD3GPs4ANlx/P0kBP8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-rGQkpOSFPDOl0IeKDKDGYA-1; Wed, 16 Jul 2025 06:45:27 -0400
X-MC-Unique: rGQkpOSFPDOl0IeKDKDGYA-1
X-Mimecast-MFC-AGG-ID: rGQkpOSFPDOl0IeKDKDGYA_1752662726
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-235c897d378so63935865ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662726; x=1753267526;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dng6vSqrufpXyR51i5KxpTr40UkIvxFqTj6xvsgMitU=;
 b=i7qdUwvIPko2t5eOv5K3FKSY/sN3rXKkyxDYorqGZeSbyJTJLs9b+R0AOp6WxX0v80
 Nu4T3UG1tOmhx+uoIzdR1m2tTbgfKdn4sRP4L1fM50Q5CeGo5QUPJYcN27waKrz5PuAy
 kVVActmSinb6gO9TSho5FUqR/Wp2wTyiefFp33run3yEDwR48MZVEP8xqJDmMWcl5T8a
 StbIqlYnRCEW4XiDxbWhU1JfsshkbC2/V7oNN5cFzhf+pK38mzvI+lAqorTJOzQ9iv5r
 Pbr80iMOraA4rDBNfNEsWL3YA/Z0gxTdPYvv32huvQArnYg9Zraa0R9LOuATUFyAM5rW
 IIVg==
X-Gm-Message-State: AOJu0YzfU3A0erQlWHDEmiT1myznYMWmDNB7rqr5o7/LTgdIMFqcbZMw
 ByrEGCwSYDzTRJg03/5NcaxyOeVgZhlbJ9cAcJsbBNScB9vM2GP9tZQuEJehGDpTZoLf3Q33XiH
 M5syt1HydXZUSUfqjIwK067eiWfDfMJ/UCa9UNeuiBv8Xtz0S3NSGEJ3t
X-Gm-Gg: ASbGncuknBe1afZHN9Afvc7RXRBxohHzdzXjMpLMPyGerfzb4XBiPqO5xvXxUt1C6oG
 ZW2iU9KvBHswwN12UOm266Ot3TNI6t26SGFOaBMy0Zn/GbSM8XMPaTJGTKGQP1n0Tun7J7rhr+2
 CVYd/OUy0PKcTsfdGyCXhcF4cGGG7EvKT2V7PFROAktf3ey9On/9hf4fo8pBlzDTC86gImIJzjD
 3rsSV46P9jkP+DodTmgKOnSRp8DjKI4cwi4e5vWUeXCnFybvJkYmzUQNObWbMp9kwtq13KPGBhJ
 UozW73m9opmLRLKjAyw+n5yV65BbGpG7+mhK0VlO2foh5t0h5g==
X-Received: by 2002:a17:902:db02:b0:235:e1d6:4e22 with SMTP id
 d9443c01a7336-23e24edad41mr30206875ad.18.1752662725958; 
 Wed, 16 Jul 2025 03:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ6Ek2ylb1ki6V8tAoqqUg8pwGxoDspMOVIOiqZZaqEokUoT+Q95CAxKy6kqdUkttuGSPXyQ==
X-Received: by 2002:a17:902:db02:b0:235:e1d6:4e22 with SMTP id
 d9443c01a7336-23e24edad41mr30206455ad.18.1752662725511; 
 Wed, 16 Jul 2025 03:45:25 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:45:25 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:13:05 +0530
Subject: [PATCH v4 15/23] migration: push Error **errp into
 loadvm_handle_recv_bitmap()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-15-7141902077c0@redhat.com>
References: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
In-Reply-To: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2610; i=armenon@redhat.com;
 h=from:subject:message-id; bh=OK/G4eLMLYGNnFMdJVvuVUfN3MCT7LeUHUqNn4XjsoY=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k710zZtLfk+ef731dIr3xoiV1hZPDxav8vrzj//Ts
 dUTsj8e7ChlYRDjYpAVU2Rp+Bog2xRQGBFp+/I6zBxWJpAhDFycAjCRW98YfjJmRcrufBB9tXut
 wk3FarXTV14m7TmtOmNz8q8H23+/Mepl+J914IST6Ue7hS9nObNvWGQw13B14jd37YpbS60uX5T
 a+IsfAA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_handle_recv_bitmap() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index b5cd6497cfe4eeb1a9428d4adfd52e4c8a7e7bb0..6f42ae111fd9c98c9b85e9b292caad737db0706d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2471,32 +2471,35 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
  * len (1 byte) + ramblock_name (<255 bytes)
  */
 static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
-                                     uint16_t len)
+                                     uint16_t len, Error **errp)
 {
     QEMUFile *file = mis->from_src_file;
     RAMBlock *rb;
     char block_name[256];
     size_t cnt;
+    int ret;
 
     cnt = qemu_get_counted_string(file, block_name);
     if (!cnt) {
-        error_report("%s: failed to read block name", __func__);
+        error_setg(errp, "%s: failed to read block name", __func__);
         return -EINVAL;
     }
 
     /* Validate before using the data */
-    if (qemu_file_get_error(file)) {
-        return qemu_file_get_error(file);
+    ret = qemu_file_get_error(file);
+    if (ret < 0) {
+        error_setg(errp, "migration stream has error: %d", ret);
+        return ret;
     }
 
     if (len != cnt + 1) {
-        error_report("%s: invalid payload length (%d)", __func__, len);
+        error_setg(errp, "%s: invalid payload length (%d)", __func__, len);
         return -EINVAL;
     }
 
     rb = qemu_ram_block_by_name(block_name);
     if (!rb) {
-        error_report("%s: block '%s' not found", __func__, block_name);
+        error_setg(errp, "%s: block '%s' not found", __func__, block_name);
         return -EINVAL;
     }
 
@@ -2637,12 +2640,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return 0;
 
     case MIG_CMD_RECV_BITMAP:
-        ret = loadvm_handle_recv_bitmap(mis, len);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        return loadvm_handle_recv_bitmap(mis, len, errp);
 
     case MIG_CMD_ENABLE_COLO:
         ret = loadvm_process_enable_colo(mis);

-- 
2.50.0


