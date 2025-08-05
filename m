Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AE2C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMQc-0000Tf-Ua; Tue, 05 Aug 2025 14:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMPp-0007nc-2w
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMPn-0004Ax-FF
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7aJlwdJxmiIHB1Fbudf+74TnSkcndxknIvW/O+ppERY=;
 b=YBdpOvaAWdLNI+LcbbU23Bp8c5Hmmja42khua2h9UGruutrKV4n2ctLlQgAJzI+7GPVHnU
 bWxZmU9oB1uZjBJUM0IBwQRHgCoOZumcZvPzArzKm0lcNE9xmdKhaTtKElk0u3A6n+WIOo
 aFLdi/rU0r577JV0xlVqlg1aK1mVMtM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-QJYLbTuUNmuzOjnGxZeKWQ-1; Tue, 05 Aug 2025 14:29:33 -0400
X-MC-Unique: QJYLbTuUNmuzOjnGxZeKWQ-1
X-Mimecast-MFC-AGG-ID: QJYLbTuUNmuzOjnGxZeKWQ_1754418573
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b0e0c573531so4492363a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418572; x=1755023372;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7aJlwdJxmiIHB1Fbudf+74TnSkcndxknIvW/O+ppERY=;
 b=iJnnhdoDKTtOCD5u4MKkNr37d3kBzHGOOaXn2Igj0t3DB2+/AjePeis2hgPaI7R/ze
 eilwf3jJbZ2iSZrJQENUdQxXylhbJLNHLIarxWvJkV6c4dsfS4qb5Je+y6kaiKe9pzo6
 ELdsy1HGs9VfaNxB/o5XIc1Za0A6SM4rGN9pZnFWIGfJSED0n5UrIrJ+JYFIOi7p2w0N
 rrHKdqK0CjqJlYciIsmOsL1cIi0bxeUdKDQxibzTTnvxQIe8UOnbI3g/lHgqKQe23JX0
 lQaA4oQJpTsBXtq/Dwrv+99TV5c5nX/l85he5trT8XjpfpSMtWXwMaOuZ6/47tlijfyr
 Ih0A==
X-Gm-Message-State: AOJu0Yz2ODdvfUaqma6bBhYf/b+mgAwaFXSF//psFltD90/dgWo54vUT
 kMiTzx8X7oSkxRugXVLldVHNcwgaKHHxWbCFPVZzApl/yfeQ+pPq72b/xUspl/rRvYImkWxHjsn
 S7K2Y090LH2/lD6XRk0dmurrRHDb+IQr+hxKUzBjxHpXivtyKsJt5ispF
X-Gm-Gg: ASbGncvIYBUT10fAjn7xw2ZCBcqXEVRbjksuwmYMgs5iSLIvJ1Rg2mGNWqnhktk7XRD
 DJut85mReO2MgsxqahxYox/DgxcnJ/55XcaU0xehw7wmRBNYEX4G7kuudVVHhrX6hmpx6n7ooCE
 PFPoQ7ile8RZHlLPh5Zt+M6N4EgkGXnlyo7toHlqGXX/sxkmY9jzWTRXyEiHf5aDVx6t0PXEdat
 SSHWUtA2I+gHUJb65gu74f8YYtahpQQpHm0khyhe3awNPkWC5n+ieXbITbBhUfz9dMGMGUUjYTM
 vlz8VwxJQqy5PyF1wm27SOl/4GMJ8oq3E6xEVtaYhOrwi3+jvQ==
X-Received: by 2002:a17:903:1206:b0:23f:cf96:3071 with SMTP id
 d9443c01a7336-2429f45ad88mr1093115ad.49.1754418572513; 
 Tue, 05 Aug 2025 11:29:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0HJgEsK73GbQE6xYH2IQEcUfMdo41EnQ2Mb67f+U6at+23CrHCkYp80CW3iOruJCJB/TN9w==
X-Received: by 2002:a17:903:1206:b0:23f:cf96:3071 with SMTP id
 d9443c01a7336-2429f45ad88mr1092785ad.49.1754418572106; 
 Tue, 05 Aug 2025 11:29:32 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:29:31 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:18 +0530
Subject: [PATCH v9 11/27] migration: push Error **errp into
 qemu_loadvm_section_part_end()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-propagate_tpm_error-v9-11-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3062; i=armenon@redhat.com;
 h=from:subject:message-id; bh=XnYVXlzq7bjbR0/JNh5UZYmicLRY4O6/Yd5oUzZoK9E=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkX5lp22bUB+/dpG+TVnUonmelx0N+iTnFKWeu3tlhI
 vrt6erjHaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACZS4sfwV6brgc3B61aNxUnO
 P20KnH/acqbl9UuuiZykpV0uuPd7MiPDBOdD9ed17e5PZfReuobN32DCohWK3TP4ct91qgVw8Qk
 xAwA=
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
It is ensured that qemu_loadvm_section_part_end() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index e337e3c61e7627f09b853bf5e9b845c38cb5f082..1b93df7894dd332aea25da91e24d02fa16e73363 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2804,8 +2804,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 }
 
 static int
-qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
 {
+    ERRP_GUARD();
     bool trace_downtime = (type == QEMU_VM_SECTION_END);
     int64_t start_ts, end_ts;
     uint32_t section_id;
@@ -2816,8 +2817,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read section ID: %d",
-                     __func__, ret);
+        error_setg(errp, "Failed to read section ID: %d", ret);
         return ret;
     }
 
@@ -2828,7 +2828,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         }
     }
     if (se == NULL) {
-        error_report("Unknown savevm section %d", section_id);
+        error_setg(errp, "Unknown savevm section %d", section_id);
         return -EINVAL;
     }
 
@@ -2836,10 +2836,10 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se, NULL);
+    ret = vmstate_load(f, se, errp);
     if (ret < 0) {
-        error_report("error while loading state section id %d(%s)",
-                     section_id, se->idstr);
+        error_prepend(errp, "error while loading state section id %d(%s): ",
+                      section_id, se->idstr);
         return ret;
     }
 
@@ -2850,6 +2850,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Check section footer error, section_id: %d",
+                   section_id);
         return -EINVAL;
     }
 
@@ -3108,7 +3110,7 @@ retry:
             break;
         case QEMU_VM_SECTION_PART:
         case QEMU_VM_SECTION_END:
-            ret = qemu_loadvm_section_part_end(f, section_type);
+            ret = qemu_loadvm_section_part_end(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }
@@ -3132,9 +3134,6 @@ retry:
 
 out:
     if (ret < 0) {
-        if (*errp == NULL) {
-            error_setg(errp, "Loading VM state failed: %d", ret);
-        }
         qemu_file_set_error(f, ret);
 
         /* Cancel bitmaps incoming regardless of recovery */

-- 
2.50.1


