Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3652CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNbN-0005kh-5Y; Sat, 30 Aug 2025 11:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5Jb-0004tg-Ek
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5JZ-0004ZM-Pi
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756497792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oOSafeLF/cdHj0WUrje7Rzs54rhm0NEYGyektqV3rfY=;
 b=UvMki49I244pyN+/W9oF5kelqgrmC8zx9Xw2lF2AzS92nWF0fIAv8h46Xn/eVDqnQ6mEd8
 0MrqO+yRdLSqhEyZD6prk47ipfsVfIl5OiCV0qZfoeUEcjG3bfrB8PcbBJCg3M4MFCkSwg
 JNgWOYDLh6Gv5h6NN+SudIIouT7NKm0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-PQSVp_BtMjGdC61lsnmxNg-1; Fri, 29 Aug 2025 16:03:11 -0400
X-MC-Unique: PQSVp_BtMjGdC61lsnmxNg-1
X-Mimecast-MFC-AGG-ID: PQSVp_BtMjGdC61lsnmxNg_1756497790
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3235e45b815so2915220a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756497789; x=1757102589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oOSafeLF/cdHj0WUrje7Rzs54rhm0NEYGyektqV3rfY=;
 b=WX64tI17lcJ5iqeTb5N+pCRhEE44pFuoLewQR1bJc41l/bytxsgsXe2YUXnj97TkOa
 pZjP9t/mLS35C5pDWKrac8or3Zf+abuoVFw65CjNWLrKna/ORGU+GwkO4+SedpK+vbbK
 F8vRl6CcDmd1zjytqnOWqQvouH37NEj+FWcEQjB0pNW9TZqrpLj7yOyUsx76AGomOG2K
 P/H5lshp7yViWdmm4mfuZbJRcPTS9Qu2PavClDyesZFUELG8sGXVzqDhrLTFzGCfE25y
 B0zoYgzmztGFptAmiXHBqbF9Ev8H2LSePCnZg6uxRUr+FtLRGwHO54EC8uxvaNaDKC1n
 v5+Q==
X-Gm-Message-State: AOJu0YxD/Dgkj2svDNTjxUVxZANN6ZdEbYfb7iOd30rAk4kd6D7HzaJI
 4/L24bHIFWorIr53sHZe8C33vuj1oU8AyXRf6NCGOJaqb2cbhccgsEKMDubJvL4WME+V60ZNdCd
 QC3h4BWS0j234UBOAomgh2s9OiCX8T8BpQ9TT5PojZ31Z3zpNcp9QEGPtZJtsIIG6
X-Gm-Gg: ASbGncsJfhMWXEnGSu8P8YhNLGAvWolPV2gm8qfmmgxNKtKpIwqXpEsrQzYnxvGOxBC
 C+kTFI8bFzP/wrJInAKDd+typl2M8Z69zhig1I9zz9uPQ5b4Ej9DYANoc77/rTfuyHzCNtzDjFJ
 4MTR9gcZ1zqs2ToGVJbsYstuQaJBF6E0BCaOhdu/JJDftGHpHRdlMoEuGNpTtolJ7TBJcpAVgzp
 /7k1ABmtAUgLe3d9wzx+SPamTSg9k0Cd93COsNnHmmNm4OGEs/6Izye8iy3mcl7yt4bjWOK/kKj
 mlWrRioSfzkrwZ37MVvOqIUZ2CKLzK0S+RQEzynbxZhA1AkMxihr2A==
X-Received: by 2002:a17:90a:d2ce:b0:328:a79:9f1 with SMTP id
 98e67ed59e1d1-3280a790bcdmr1380415a91.1.1756497789574; 
 Fri, 29 Aug 2025 13:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFAFrNTt5uGgjI5rTVWUW0yqi4Q0YqnFQ2MhqOfDyua7LrwsJvjm7FWu1xsftHgk9cjztQqg==
X-Received: by 2002:a17:90a:d2ce:b0:328:a79:9f1 with SMTP id
 98e67ed59e1d1-3280a790bcdmr1380360a91.1.1756497788997; 
 Fri, 29 Aug 2025 13:03:08 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:03:08 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Sat, 30 Aug 2025 01:31:43 +0530
Subject: [PATCH v13 03/27] migration: push Error **errp into
 qemu_loadvm_state_header()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250830-propagate_tpm_error-v13-3-a4e777b7eb2c@redhat.com>
References: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
In-Reply-To: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2973; i=armenon@redhat.com;
 h=from:subject:message-id; bh=08fs5yPRSN3G4fsuHEbQFA8WwDnIkqC0cHdPyjoW6j0=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8Ymdp//1XvLpi1Luxj+8Vv5vZglM23Uc1bFNr2XmXjKZ
 KfAUf6yjlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABOZqsfIsDjJJnti0JU7oVyq
 DnVXOPMKAnpXdj32tFh7fIFN69G3gYwMR7f8SgliyX4+i2tlZCOPY5nb5M2/VweuDJ+koJT6QN6
 PFwA=
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
It is ensured that qemu_loadvm_state_header() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index f5a1ab91016dba51f9cd1dee19a1c7ba31417423..0c445a957fc99f826e6753ed3795bcdd51f1e3f5 100644
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
-            error_report_err(local_err);
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
2.51.0


