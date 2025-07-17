Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A52C83F27
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCf7-0003Mg-13; Wed, 16 Jul 2025 20:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCex-0003EI-D2
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCeu-0004az-Rf
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EAAn8p8gxY87pkvl7mytiCpjUT1424U2xaE6IZz2+tc=;
 b=NVbX0qtwi1KieuqVFH08JhG71vkk0hdwZsqRZDwP4Gzrrajv6ZEpiwmOiRT1W3qdPmVM4F
 G0mqBj2+QJbPu0r9bZrcvJRXoqz84b7K0x6yvXHOb2lC7rMjYL8kvZ6vX7kmgvTEp1+Qcz
 IUbiu8mDyyWXc/s2/ghtWgzLsQPn+wI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-3Q3nBYo-NXStNA3paPaEMQ-1; Wed, 16 Jul 2025 20:39:34 -0400
X-MC-Unique: 3Q3nBYo-NXStNA3paPaEMQ-1
X-Mimecast-MFC-AGG-ID: 3Q3nBYo-NXStNA3paPaEMQ_1752712773
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b31cc625817so1133187a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712773; x=1753317573;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAAn8p8gxY87pkvl7mytiCpjUT1424U2xaE6IZz2+tc=;
 b=qtffIwRUiU9UFqw2tChCrm1tS8XgNpiTH2o5C8LJJngdPMQVYhIng2j1/JT/jVRz2z
 yFDmbBGgopf6n6U7HatfBJj059aMeOS91x7ts2tGPraLmpAcAtYjfUu0MuR0nAT1pth6
 a+BNiCew2o8F3aXcOgGo0699xFNv9Jn1Elqsj7B26nJu8RChckew3FVQrbgZlhTvsgTR
 9ibVGclr38FCdFgjpfBIyBV0wS+S+V1w6AJ5ZSZzZ6dpZ0HffsZyfHOBCkjTrSnH+7Os
 jkm8MqtAeLMqYHHt6FD/eHHSoifLTCwzvqaLZG9ldnEr7fS7SNTA+yD/ehpn2+YKq9nW
 fPeA==
X-Gm-Message-State: AOJu0YwykGnyuTJpL2crBseHoZl/96okQHFUlGIqlTTlJwAiku7ntZTz
 PsHxlp6PVZsNxWxN7vjstc5GkkpC+YA4zq8oKaLUEXTMuUoT37CrUB1nH262Bcw4EhTXolxeEOb
 QwPDyIKUpgR0McU7LFBD0sJlKnOZEar+0MSwR8QFhJcPsqla0h/NwvruI
X-Gm-Gg: ASbGnctQz66dZ5YopthyItr2OYMQIybROdn+w9KlyONtNivwxUnKNHIefptPy6uX4bp
 YhonHAGoMTjKrLlPbsRD+4/EV1zgUYKhqDa4IKmPPyIxpoZPEW/bCmsUzfuf7FVMO/0I3kJQJmN
 j+6JUCVMco48jnRq/qYFQE9Eh9RuyxGJGDtD+7QoNjf7p2hOQROuQjJvmJMQoDcaddF9Uduw6yc
 h2aj1mOyZBPAzujT5SIioQE4xfI8t54CWT8qRxMztR9UIweNgnjDLU5H1XOGViw+4z0Q5xMswhf
 ryL7alBqMW2lzmMC+f0zv/YJaq0H4POoh23oI18+hSSGbvVaYq6o
X-Received: by 2002:a17:903:1208:b0:234:595d:a58e with SMTP id
 d9443c01a7336-23e2f4e9127mr19595965ad.25.1752712773478; 
 Wed, 16 Jul 2025 17:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ/RnTuNOqfMFUeb6x8JW/GZy2VYTwpLHbVkm1RVdq8T7yQFOGJYY6HJxUk1gB/f2fY0EV5A==
X-Received: by 2002:a17:903:1208:b0:234:595d:a58e with SMTP id
 d9443c01a7336-23e2f4e9127mr19595475ad.25.1752712773036; 
 Wed, 16 Jul 2025 17:39:33 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:39:32 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:26 +0530
Subject: [PATCH v5 03/23] migration: push Error **errp into
 qemu_loadvm_state_header()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-3-1f406f88ee65@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
In-Reply-To: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786; i=armenon@redhat.com;
 h=from:subject:message-id; bh=xt53pEr1ggy03OrfBWGIIyKPwsWGunsZ/7AAWO8gTog=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm1zn9jNT7X6yW7c25Ei9fnJKT+LzbuEzD4pfK75SD
 DnksGFHRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIl0xzMyPHx5nnt+4ZEJj7vL
 d4Ze3zW9K3DTJNnPD5iMTTg4rXZfUmP4X3NuZ5u4/zS5rUvTni14kR5Q4Js4i/18YoCBWLRR234
 jVgA=
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
It is ensured that qemu_loadvm_state_header() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index ab947620f724874f325fb9fb59bef50b7c16fb51..3ccbc724eb808db09b77088a858ecc7f06b21155 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2814,35 +2814,42 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     return 0;
 }
 
-static int qemu_loadvm_state_header(QEMUFile *f)
+static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
 {
     unsigned int v;
     int ret;
 
     v = qemu_get_be32(f);
     if (v != QEMU_VM_FILE_MAGIC) {
-        error_report("Not a migration stream");
+        error_setg(errp, "Not a migration stream, "
+                   "magic: %x != %x", v, QEMU_VM_FILE_MAGIC);
         return -EINVAL;
     }
 
     v = qemu_get_be32(f);
     if (v == QEMU_VM_FILE_VERSION_COMPAT) {
-        error_report("SaveVM v2 format is obsolete and don't work anymore");
+        error_setg(errp, "SaveVM v2 format is obsolete and don't "
+                   "work anymore, file version %x != %x",
+                   v, QEMU_VM_FILE_VERSION_COMPAT);
+
         return -ENOTSUP;
     }
     if (v != QEMU_VM_FILE_VERSION) {
-        error_report("Unsupported migration stream version");
+        error_setg(errp, "Unsupported migration stream "
+                   "version, file version %x != %x", v, QEMU_VM_FILE_VERSION);
         return -ENOTSUP;
     }
 
     if (migrate_get_current()->send_configuration) {
-        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
-            error_report("Configuration section missing");
+        v = qemu_get_byte(f);
+        if (v != QEMU_VM_CONFIGURATION) {
+            error_setg(errp, "Configuration section missing,"
+                       "%x != %x", v, QEMU_VM_CONFIGURATION);
             return -EINVAL;
         }
-        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
-                                 NULL);
 
+        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
+                                 errp);
         if (ret) {
             return ret;
         }
@@ -3119,7 +3126,7 @@ int qemu_loadvm_state(QEMUFile *f)
 
     qemu_loadvm_thread_pool_create(mis);
 
-    ret = qemu_loadvm_state_header(f);
+    ret = qemu_loadvm_state_header(f, NULL);
     if (ret) {
         return ret;
     }

-- 
2.50.0


