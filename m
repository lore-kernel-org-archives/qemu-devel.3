Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6716AC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udooJ-0004ak-AV; Mon, 21 Jul 2025 07:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udol8-0003Dz-E5
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udol0-0001CB-Km
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t3ae3kJExW2Sg5pWJRDVUIOvol+Ctrurv2L52br01Kg=;
 b=N5z0jfcigEsXjJzjwmB3qFuxc8aJg4H9BvkakAOY3PPw98Dt94DiE+JKG8m/TL0VD04T8o
 DuH3jlA510GL37Vm9uRsgWYneW7FYlQ5k9o8BsIYdMAopOkB0+040JcEIcG8iT5YIJYPKt
 tfEFSk0ywDKo+IgrcTkNbt1KKdxWUc4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-KCp5uiZ-NyGfMaanGC_xrg-1; Mon, 21 Jul 2025 07:32:31 -0400
X-MC-Unique: KCp5uiZ-NyGfMaanGC_xrg-1
X-Mimecast-MFC-AGG-ID: KCp5uiZ-NyGfMaanGC_xrg_1753097550
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b3f2e05fb78so2389317a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097550; x=1753702350;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t3ae3kJExW2Sg5pWJRDVUIOvol+Ctrurv2L52br01Kg=;
 b=hNfFAHtaiDv+RaAtnwDTOGr+K9cgA5JW4uMjmciCpRsEDg/GDX/ySc69IPJ10VGpM6
 bm+1Bd52jdzFifUKqoWNISgQDGX9z52y/h8ZQDt+mQWE3UXuTZuaLaVi1nKq6iOT9G1h
 rHZFnDfH6KS2WcCleoz8B8cSg4+B+N2UjNRltiosmwarQsc8LZtdL5em6ISYCSA82ZHe
 NT2ah8+KqlbbJlDu0/1J4nj08Trll8R/0E3QGRPLWhgyzCnmsQwzcKLTc7E9xkyXyDx/
 xRx8RlMtbTlDtdc1hQc1VDU+Qx0DyM7CP0U6s89UtegzCdHdFkOuKgDZzzQI0iS6AsE5
 lY5g==
X-Gm-Message-State: AOJu0YxZmwPkG6UegUbLorsM5T7476RvCPlVi5DxjAJ8di+s+EEREirS
 ceVDf2ZqayVkdarQH8VhtB6bCMwhQiWVcgOAGLzEXW9AVCcuLnU07vdmchrug4fKsnQKYwhGMtK
 b1Pv6Xt2cKM1y+XyPR+oQjKiF6kYRtlAxcRHqC2iJsSaweIJujFcSUsEi
X-Gm-Gg: ASbGncvVS/nTj5rXIHVhdlXifPYQ+TfybPzLfkt0TWDTPq/wmy2mwpME14G4oceZx93
 s2s2IbVeryEGUoVWb6i8B7WTN3Dv+p5vDKTH2ob5vSS2UKfblSRHmVmZtoJ4i1PKodA1E4H5ea/
 zrXHFCdz3mQmSinDxCCjsMv8E41JTO4d8pEMOuDb43KY5ntZ8LGQB0UFLuqtI4hzDTWeKP/SmC3
 Ge35aJWl5+dq8vzz+Pm7cJC/eZJODR2M6dg3T0lAXS5tuYyoPuC4K4rfQ93F05O8IFW3ewJh018
 YZTVIaq0oJFH0TWuWbxPNi6xUk3DYFUDMyLoMjkhjucQuXYfUgkc
X-Received: by 2002:a17:902:ea04:b0:234:8c64:7885 with SMTP id
 d9443c01a7336-23e2578d9e2mr271660965ad.53.1753097550245; 
 Mon, 21 Jul 2025 04:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH006936SOWFLX0KeCHHYnhae+sSKEKnmeFxfNdsSqzcQLtt57uyechRQ3uZA+ymerwRrJ7kQ==
X-Received: by 2002:a17:902:ea04:b0:234:8c64:7885 with SMTP id
 d9443c01a7336-23e2578d9e2mr271660395ad.53.1753097549783; 
 Mon, 21 Jul 2025 04:32:29 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:32:29 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:26 +0530
Subject: [PATCH v6 21/24] migration: push Error **errp into
 qemu_load_device_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-propagate_tpm_error-v6-21-fef740e15e17@redhat.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
In-Reply-To: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2659; i=armenon@redhat.com;
 h=from:subject:message-id; bh=oyukj1JRYKQrUQbIkOMl3uoW1cNIxrsfV12H77J7t0g=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adyqR9N32vHtG6wF/l4lb774vex5W+loIVRpteG7/pb
 z+zLKuwo5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwESy/RgZppSbWnxatGLJ242v
 p87rk2LflPRsy7tI/Qf961+rn5GddYvhr5DCgvOPF9nb8L9bGSYlombxuKvwk9Viv476G63HLxn
 VMgEA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
It is ensured that qemu_load_device_state() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c   | 4 ++--
 migration/savevm.c | 6 +++---
 migration/savevm.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 03edf870e2bc9c724fc27e26e7ba54a40c13399e..650f7b61d92693eeace475f221a37cfa81331b97 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -729,9 +729,9 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
     bql_lock();
     vmstate_loading = true;
     colo_flush_ram_cache();
-    ret = qemu_load_device_state(fb);
+    ret = qemu_load_device_state(fb, errp);
     if (ret < 0) {
-        error_setg(errp, "COLO: load device state failed");
+        error_prepend(errp, "COLO: load device state failed ");
         vmstate_loading = false;
         bql_unlock();
         return;
diff --git a/migration/savevm.c b/migration/savevm.c
index 1261e81c86f836e6b5a155ba1880b5823a779567..b90505595091da27d3cf92984eb256f137fb9d36 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3236,15 +3236,15 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
     return ret;
 }
 
-int qemu_load_device_state(QEMUFile *f)
+int qemu_load_device_state(QEMUFile *f, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     int ret;
 
     /* Load QEMU_VM_SECTION_FULL section */
-    ret = qemu_loadvm_state_main(f, mis, NULL);
+    ret = qemu_loadvm_state_main(f, mis, errp);
     if (ret < 0) {
-        error_report("Failed to load device state: %d", ret);
+        error_prepend(errp, "Failed to load device state: %d ", ret);
         return ret;
     }
 
diff --git a/migration/savevm.h b/migration/savevm.h
index a6df5198f3fe1a39fc0e6ce3e79cf7a5d8e032db..c337e3e3d111a7f28a57b90f61e8f70b71803d4e 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -68,7 +68,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
-int qemu_load_device_state(QEMUFile *f);
+int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy);

-- 
2.50.0


