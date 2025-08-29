Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394C2CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNcQ-0007yu-Hz; Sat, 30 Aug 2025 11:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5L5-0005Pb-KB
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:04:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5L2-0004jq-5w
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756497883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsBBzucx8y5i9VHunk1XF83aX/5bi21WNzwEAMu8Vec=;
 b=NGSinLqOpIumPS72NpwdirUr/G/IcKCiU+odqG7dW2cMwbxFl7LEiyxLpflK9XXW+Szb5j
 LV5UypliaSuBVTdZybtwSWuR7siyO0zmY5tTtnrRkw18zqSOQMmNr0lCGFQn/6fIlDuCDR
 XKnxr2S7kuwrZYr6FYZk7OrW6zlY2dw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-2zAYbtZTM2eVBBSvcGz0rA-1; Fri, 29 Aug 2025 16:04:41 -0400
X-MC-Unique: 2zAYbtZTM2eVBBSvcGz0rA-1
X-Mimecast-MFC-AGG-ID: 2zAYbtZTM2eVBBSvcGz0rA_1756497881
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-323766e64d5so3102183a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756497881; x=1757102681;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FsBBzucx8y5i9VHunk1XF83aX/5bi21WNzwEAMu8Vec=;
 b=bsGHe0mdJM1alR85SnTuR7HrKDP4PsqpV8mWLaPI2PqmjRu9ilrVHb4uMhT2OY7Y9O
 HmLnsVIgZHm5+gzAWJ25WZJg0uMg8sRhAzBVGkshlcUfKT7zDo0thu9GytuGwSGXiWxf
 1DxV27HRQru6AKIif8ga0KcInA7sIWosRR6ADCCDpMpla8hN+ApU2/wadQwTAL7bSabN
 OaUS09tSTc2CwswqStIikYrgJyYkP8tBO2EdGv11MjtthvqqZoebGOfvb7zRR+IliH/M
 SDMzv1q3pK1lYVc8qDaPNaXcI94HSphZ+ZMKQdWDH+0j0usST36YMK+7vlEgnjwOhaoV
 XnJg==
X-Gm-Message-State: AOJu0YxWxwu+jZUrw6rSyUO6ubu/+aZ2S5pZAHuZ3DxQPj9Iu0XhNRVA
 NHcbUPTN97zC+g9LmkAunYc/4ySYKsUkPMF4c4ipsSaurEwb+COt+Q+/eS2YOWyWgadF6E3Gvz5
 QLDQhNTPJiIi7GuwYPF/ouw9pdnGHeqqEmvP9ppZM5FDbRekpt/Frm0Ue
X-Gm-Gg: ASbGncsCcFVse8sSHXXfbUtONpm5Fd6vdOApstPhdtVTcqrx4cDJtIOzdBhYepo5Be1
 geJxQ0+Bl0y2nYJcxF3DFRmuGtDEqNFbOsktJ+Ne+7EdaZMWmQ9HjsUGdt/3X26MM4qrt4wS2CS
 CiGPZ2rwVU1mqRNggmlBS1ZsM/A+QNA8riqt5ALdQKBKHTS0PUm+/5XU/aaJ0cSkkZmv8t6HRer
 S+EYrWQH8dPFgZ+48CisDBTuwaGA4UMjgCm3uX/o7C7Opsi2NZWQfhgQb1kAUg8q/vJe4vh6uAM
 x2joxZzqMFJdtLaJ2+HcTwunsvTcLENRx5IBcrPOuC32/ST0Z1SmOg==
X-Received: by 2002:a17:90a:fc4f:b0:325:8fba:708d with SMTP id
 98e67ed59e1d1-3275085db6cmr19128348a91.18.1756497880481; 
 Fri, 29 Aug 2025 13:04:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgxvP8ns5R0YWDPu/saa6ZtVs08PC4P1eKJfga9WhW3stQRNH6XdbyEcYVMqRcKMICqey6pw==
X-Received: by 2002:a17:90a:fc4f:b0:325:8fba:708d with SMTP id
 98e67ed59e1d1-3275085db6cmr19128298a91.18.1756497879866; 
 Fri, 29 Aug 2025 13:04:39 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:04:39 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Sat, 30 Aug 2025 01:31:50 +0530
Subject: [PATCH v13 10/27] migration: push Error **errp into
 qemu_loadvm_section_start_full()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250830-propagate_tpm_error-v13-10-a4e777b7eb2c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4798; i=armenon@redhat.com;
 h=from:subject:message-id; bh=mjhvRtOfCNflzXKsd7LfnW6aMa0TrUuxLNhD6rtfZNc=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8Ymdt8CjnwHG1NThjs8yZ2fEo5KGJmrXykIr5+kpblM4
 fSVOY86SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATOR4IsM/1SUTyjzeTl3I2SoQ
 +zVm4tb3qvG9MZZVGqcnnWmcX7asnuE3m5vSn9Xqny0drOPWcb+1uB99uTZ6zTUF4d2OsdKJe3e
 wAAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
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
It is ensured that qemu_loadvm_section_start_full() must report an error
in errp, in case of failure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index eccb3f63f8dfc070263a1d19ec3415684e8fa60e..01e1a9739aa784d90f80bf2b561fd62f5e4678f8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2722,21 +2722,21 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
 }
 
 static int
-qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 {
+    ERRP_GUARD();
     bool trace_downtime = (type == QEMU_VM_SECTION_FULL);
     uint32_t instance_id, version_id, section_id;
     int64_t start_ts, end_ts;
     SaveStateEntry *se;
     char idstr[256];
     int ret;
-    Error *local_err = NULL;
 
     /* Read section start */
     section_id = qemu_get_be32(f);
     if (!qemu_get_counted_string(f, idstr)) {
-        error_report("Unable to read ID string for section %u",
-                     section_id);
+        error_setg(errp, "Unable to read ID string for section %u",
+                   section_id);
         return -EINVAL;
     }
     instance_id = qemu_get_be32(f);
@@ -2744,8 +2744,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read instance/version ID: %d",
-                     __func__, ret);
+        error_setg(errp, "Failed to read instance/version ID: %d", ret);
         return ret;
     }
 
@@ -2754,17 +2753,17 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     /* Find savevm section */
     se = find_se(idstr, instance_id);
     if (se == NULL) {
-        error_report("Unknown savevm section or instance '%s' %"PRIu32". "
-                     "Make sure that your current VM setup matches your "
-                     "saved VM setup, including any hotplugged devices",
-                     idstr, instance_id);
+        error_setg(errp, "Unknown section or instance '%s' %"PRIu32". "
+                   "Make sure that your current VM setup matches your "
+                   "saved VM setup, including any hotplugged devices",
+                   idstr, instance_id);
         return -EINVAL;
     }
 
     /* Validate version */
     if (version_id > se->version_id) {
-        error_report("savevm: unsupported version %d for '%s' v%d",
-                     version_id, idstr, se->version_id);
+        error_setg(errp, "unsupported version %d for '%s' v%d",
+                   version_id, idstr, se->version_id);
         return -EINVAL;
     }
     se->load_version_id = version_id;
@@ -2772,7 +2771,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     /* Validate if it is a device's state */
     if (xen_enabled() && se->is_ram) {
-        error_report("loadvm: %s RAM loading not allowed on Xen", idstr);
+        error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
         return -EINVAL;
     }
 
@@ -2780,11 +2779,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se, &local_err);
+    ret = vmstate_load(f, se, errp);
     if (ret < 0) {
-        error_report("error while loading state for instance 0x%"PRIx32" of"
-                     " device '%s'", instance_id, idstr);
-        error_report_err(local_err);
+        error_prepend(errp,
+                      "error while loading state for instance 0x%"PRIx32" of"
+                      " device '%s': ", instance_id, idstr);
         return ret;
     }
 
@@ -2795,6 +2794,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Section footer error, section_id: %d",
+                   section_id);
         return -EINVAL;
     }
 
@@ -3100,7 +3101,7 @@ retry:
         switch (section_type) {
         case QEMU_VM_SECTION_START:
         case QEMU_VM_SECTION_FULL:
-            ret = qemu_loadvm_section_start_full(f, section_type);
+            ret = qemu_loadvm_section_start_full(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }

-- 
2.51.0


