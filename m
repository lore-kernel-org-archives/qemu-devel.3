Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB31CCA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0wy-0004Wk-Tx; Thu, 21 Aug 2025 04:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0vL-0002Xi-OG
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:45:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0v1-0000z5-RM
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755765907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kk3+NIQtXaA5i+x7tx8agPDX605CM/z42iyH0dQieuI=;
 b=UU8gwl+ZD4vg6VO1pyaW03cbT1aWKme4dmivccCrJVcLoV7nvNsMFCQTXS910HBgSm674D
 Cyp6bqdGZhpas3U8YiUaTmxCds2k2wP2gAefgMUmff7ewTxk0BZdFPSQBI2JdbgSp9eauT
 WDEm12uktZ2mZTgzxrh8NAf8FX82M0g=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-EBO65Uq5OaCCOPWJ17vZeQ-1; Thu, 21 Aug 2025 04:45:06 -0400
X-MC-Unique: EBO65Uq5OaCCOPWJ17vZeQ-1
X-Mimecast-MFC-AGG-ID: EBO65Uq5OaCCOPWJ17vZeQ_1755765905
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-24458121274so9608485ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755765905; x=1756370705;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kk3+NIQtXaA5i+x7tx8agPDX605CM/z42iyH0dQieuI=;
 b=qbzFfoye1AuFYV1yEpXgqLKgFdFmwCXOfNVtoAyUugIKbaHJ3PL06SCb6puTU04Vrk
 wlRTCdGMWWYWRg4GcYQ5Pcg7ViTKE8uiIsx7lVz5fvxWNWuEHW96EdTB4jpeRwLDpO2C
 aldrcWspojy01HOB2/nmvBLhq5lDyE8BCdaOlR0c9FE4nxi0EgjyGRsyD1nOWRumictk
 KFc2aw5wBojdWXfZoRmYxTgzYlBTrxOmvoKHJbJjTdS8SJfYkSMbblScrJcYGsYGqcWa
 sMkOKkfcq59psbmr4pdkcvh7fPyKKorAM+v1sjWl5QzGMMXpGohx3MpMvnjumUDJcO+8
 6L7A==
X-Gm-Message-State: AOJu0Ywe+SBsNELJm8gxoN3XiUVWgPhKksNFpixobTFWQYf20eILuvWH
 HCz+LtA/saSyT/ixcmcP7OIPBKwNpGeZaCLACpk/j1FK++BAzAjkFvICepiI5XUARy83mc4cbA1
 /TQxL1TLjTVvAnP2V1/pswGL4SbqsgUCx/Yqt/TR8rcdb55snivDZ5F7c
X-Gm-Gg: ASbGncuAwq7mt0TLf0Tf/xNHo17hw2T8d9Y3n9j3doxTYq1gAww7sK3y/HVts6zPmo9
 6qhgLBh6ilI04XBpcQ4zBZMt5e2ECJnqmJCRbZKH3gab/R2tMZR1Eg9uYx4tKMSUnOJpZ+MmMeQ
 RTR6VuWWrwSkM4KtCNl6jvDsiEknojAQ7DpioL9gSEIAzl/15Xt1z4/7Z7H6ATYV2HkLnMiQtsd
 eV3+wUC8H9TlPNoB/5TRAe2a87Ajfg+3ZcOZxuH5zaYJuuhVH+VRGUKzr2TnV9MRbShE1XOROHa
 B+MzIjOU7bMonk5SAwchUXV4YOhFuW0lLopQmiJIa3Gm3TpWdWzu
X-Received: by 2002:a17:903:1b47:b0:242:b315:dda7 with SMTP id
 d9443c01a7336-245febef6famr21950125ad.3.1755765904785; 
 Thu, 21 Aug 2025 01:45:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErWudDrfu/11rJtG6vyCSxTFO235r8JrfhYj7BXT9JKMACBaOn9fzjFxvZdNyWvoCPSjnLdg==
X-Received: by 2002:a17:903:1b47:b0:242:b315:dda7 with SMTP id
 d9443c01a7336-245febef6famr21949305ad.3.1755765904037; 
 Thu, 21 Aug 2025 01:45:04 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:45:03 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:13:57 +0530
Subject: [PATCH v12 03/27] migration: push Error **errp into
 qemu_loadvm_state_header()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-propagate_tpm_error-v12-3-72b803e707dc@redhat.com>
References: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
In-Reply-To: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2972; i=armenon@redhat.com;
 h=from:subject:message-id; bh=R7CNvPEGSj+XRsy4a7OPYyRxze4h7ZRH+EvjhrcS4IE=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayO8nC1ldvqh5UNxCJZAnNclxzJiWvPr94oVzg31/ru
 GernFHvKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMBHeJQz/TO9tm7tj7c+gsgP7
 3lfer05w/t004ceiTXd+bLoa5MsvEcDwV+CO+ZsFzaedt/9PWhq1cPX1bvEvk9S8J9mlbslvVX4
 aywYA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
It is ensured that qemu_loadvm_state_header() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 464e8b778404a642bf60f368205f5e6fa59118ba..0c445a957fc99f826e6753ed3795bcdd51f1e3f5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2814,38 +2814,43 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     return 0;
 }
 
-static int qemu_loadvm_state_header(QEMUFile *f)
+static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
 {
     unsigned int v;
     int ret;
-    Error *local_err = NULL;
 
     v = qemu_get_be32(f);
     if (v != QEMU_VM_FILE_MAGIC) {
-        error_report("Not a migration stream");
+        error_setg(errp, "Not a migration stream, magic: %x != %x",
+                   v, QEMU_VM_FILE_MAGIC);
         return -EINVAL;
     }
 
     v = qemu_get_be32(f);
     if (v == QEMU_VM_FILE_VERSION_COMPAT) {
-        error_report("SaveVM v2 format is obsolete and don't work anymore");
+        error_setg(errp,
+                   "SaveVM v2 format is obsolete and no longer supported");
+
         return -ENOTSUP;
     }
     if (v != QEMU_VM_FILE_VERSION) {
-        error_report("Unsupported migration stream version");
+        error_setg(errp, "Unsupported migration stream version, "
+                   "file version %x != %x",
+                   v, QEMU_VM_FILE_VERSION);
         return -ENOTSUP;
     }
 
     if (migrate_get_current()->send_configuration) {
-        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
-            error_report("Configuration section missing");
+        v = qemu_get_byte(f);
+        if (v != QEMU_VM_CONFIGURATION) {
+            error_setg(errp, "Configuration section missing, %x != %x",
+                       v, QEMU_VM_CONFIGURATION);
             return -EINVAL;
         }
-        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
-                                 &local_err);
 
+        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
+                                 errp);
         if (ret) {
-            warn_report_err(local_err);
             return ret;
         }
     }
@@ -3121,8 +3126,9 @@ int qemu_loadvm_state(QEMUFile *f)
 
     qemu_loadvm_thread_pool_create(mis);
 
-    ret = qemu_loadvm_state_header(f);
+    ret = qemu_loadvm_state_header(f, &local_err);
     if (ret) {
+        error_report_err(local_err);
         return ret;
     }
 

-- 
2.50.1


