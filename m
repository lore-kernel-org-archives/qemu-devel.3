Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86F5C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHML-0001cQ-EM; Fri, 08 Aug 2025 03:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHKz-0006wJ-Ja
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHKn-0007Id-5N
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W/xJsGYLQ3l/15ghT8JrI6NoUQ8PtivMeVPGYf0S0Yc=;
 b=GvYSuv5cPhgm9i3Mf9xC5No1CcazgONQsyl+0ce2DKLlXeR5ACnhMcotAcDPYLIq9SmSVN
 5g6II0/uCuzN+OWJ/z7x09pLLoLTarc2TWGYi78AKzmBnEJ8+xGPPWyuQiYKRSgY4Fbypd
 hIioUv6H6hyeXw1IaW1OpvQR5QQDzUg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-tTTXOlGYNz2gsr-cl-Kitg-1; Fri, 08 Aug 2025 03:16:10 -0400
X-MC-Unique: tTTXOlGYNz2gsr-cl-Kitg-1
X-Mimecast-MFC-AGG-ID: tTTXOlGYNz2gsr-cl-Kitg_1754637369
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b4253124e77so1653608a12.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637369; x=1755242169;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/xJsGYLQ3l/15ghT8JrI6NoUQ8PtivMeVPGYf0S0Yc=;
 b=u+Xg/BdqHjSPXs+m1WkxkKTUye06nFfyvuONHtMUDbVJXsh+Rm+6pyNbxVaix3Ktfr
 DXa/oVZB/qd7XmWZRF2jVmXImQN0ZEygjPN4xXEcT045WVZw8d2JvCqff9fQy10sLScg
 3j35XQobP4Kqai7gVRMaCjAp6q+I5OYJFwk9bfBQx+fHnq7/jsaszzJtcbv8GKjZ3ZLP
 xieXewQYYDNW/Glvh2bmEQb/kq7ZB8eoRySM/u1WvONK46XM/fIDjd28ItQxFccAfiXA
 sbD2HRunumRK9gm1QhER2SyHrbS3vFcmjCyNTTa0FagbB2Re2apOg/6ajSitRcglj68z
 WzyA==
X-Gm-Message-State: AOJu0YxMlzua/crBDI5BYMaWtyeF9gX7tpOW9ukoURBGaJd0qBvicb6c
 bHjXPjPxu1ri0euSVlq4bsICHGaFP8XdbTXpYLQ6gYiyKLM1N37c4eelyc9uE1V8JxjxfTbf6Ub
 SnJIQNwGvbeVdeNQKeGw+D2NahFxsqxv0AVXWX43/t34VaKk//cKiK5l+
X-Gm-Gg: ASbGncufTwQH0Of22TgylcarTtRngl8/v6oWfVFJC2tQm9BPoQipOWwXqONsHySmXur
 fiMCmF1w/jehVmx2eYpgKpyyriYf9/Iu+hkxbdAqh0pFfIb/qFDxtDYDbRi95r0MWue+YIhph7l
 G3VanZIrpAWxXUqBURNGNOSlwGPeHFFoZtY4qE/kLkaWeAYaE2NNtsDFRZFBp4nqv6u++FjhT96
 DG8T++CTOpAENggCYzApfRt1IehxtC49QsLw53zJr2vsg1NiA+8+6NRMbtrCy9gNkST6pHsmTdA
 GZfkaQQxQ0QLuqMm+KX4NH4zDjaPK/Qa2K5vtcmCrSqCdBhasHmx3Q==
X-Received: by 2002:a17:903:b0e:b0:234:f4da:7ecf with SMTP id
 d9443c01a7336-242c1ecca84mr24763425ad.8.1754637368995; 
 Fri, 08 Aug 2025 00:16:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcEpAfjTjMF9F4ttdpU7tnnc13zZz12zoO1NeEej25IhophgyPPW89tiAGnjQEGWrdARrFsg==
X-Received: by 2002:a17:903:b0e:b0:234:f4da:7ecf with SMTP id
 d9443c01a7336-242c1ecca84mr24763165ad.8.1754637368569; 
 Fri, 08 Aug 2025 00:16:08 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:16:08 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:36 +0530
Subject: [PATCH v10 10/27] migration: push Error **errp into
 qemu_loadvm_section_start_full()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-propagate_tpm_error-v10-10-3e81a1d419b2@redhat.com>
References: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
In-Reply-To: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4804; i=armenon@redhat.com;
 h=from:subject:message-id; bh=jyiyBRDRCbEkSoT/i0OBlFzhgE/vTIugorgDNobXEvg=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxVcNJXi3b7zA8/vjcZEFV7hCo1bNeD5zRUxazlZXw
 xtfmraEdpSyMIhxMciKKbI0fA2QbQoojIi0fXkdZg4rE8gQBi5OAZjIHhOGvzKv/x+LCriyT8pt
 8iLHpmV+qfxXCk+4pzDsuePovmFSWTgjwzKGvCX23Zn/hLnnpZmFTP2nuOOzqcLt/F2CW3PuHXj
 HyggA
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
It is ensured that qemu_loadvm_section_start_full() must report an error
in errp, in case of failure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 3df78ac0026c4c098d3fd13f765b54db0eafdc61..6302e1cdc3bca0c16f64dc0f35a17e4d9b7705ea 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2724,8 +2724,9 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
 }
 
 static int
-qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 {
+    ERRP_GUARD();
     bool trace_downtime = (type == QEMU_VM_SECTION_FULL);
     uint32_t instance_id, version_id, section_id;
     int64_t start_ts, end_ts;
@@ -2736,8 +2737,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
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
@@ -2745,8 +2746,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read instance/version ID: %d",
-                     __func__, ret);
+        error_setg(errp, "Failed to read instance/version ID: %d", ret);
         return ret;
     }
 
@@ -2755,17 +2755,17 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     /* Find savevm section */
     se = find_se(idstr, instance_id);
     if (se == NULL) {
-        error_report("Unknown savevm section or instance '%s' %"PRIu32". "
-                     "Make sure that your current VM setup matches your "
-                     "saved VM setup, including any hotplugged devices",
-                     idstr, instance_id);
+        error_setg(errp, "Unknown savevm section or instance '%s' %"PRIu32". "
+                   "Make sure that your current VM setup matches your "
+                   "saved VM setup, including any hotplugged devices",
+                   idstr, instance_id);
         return -EINVAL;
     }
 
     /* Validate version */
     if (version_id > se->version_id) {
-        error_report("savevm: unsupported version %d for '%s' v%d",
-                     version_id, idstr, se->version_id);
+        error_setg(errp, "savevm: unsupported version %d for '%s' v%d",
+                   version_id, idstr, se->version_id);
         return -EINVAL;
     }
     se->load_version_id = version_id;
@@ -2773,7 +2773,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     /* Validate if it is a device's state */
     if (xen_enabled() && se->is_ram) {
-        error_report("loadvm: %s RAM loading not allowed on Xen", idstr);
+        error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
         return -EINVAL;
     }
 
@@ -2781,10 +2781,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se, &error_warn);
+    ret = vmstate_load(f, se, errp);
     if (ret < 0) {
-        error_report("error while loading state for instance 0x%"PRIx32" of"
-                     " device '%s'", instance_id, idstr);
+        error_prepend(errp,
+                      "error while loading state for instance 0x%"PRIx32" of"
+                      " device '%s': ", instance_id, idstr);
         return ret;
     }
 
@@ -2795,6 +2796,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Reading footer section of instance "
+                   "0x%"PRIx32" of device '%s' for version_id: %d failed",
+                   instance_id, idstr, version_id);
         return -EINVAL;
     }
 
@@ -3099,7 +3103,7 @@ retry:
         switch (section_type) {
         case QEMU_VM_SECTION_START:
         case QEMU_VM_SECTION_FULL:
-            ret = qemu_loadvm_section_start_full(f, section_type);
+            ret = qemu_loadvm_section_start_full(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }

-- 
2.50.1


