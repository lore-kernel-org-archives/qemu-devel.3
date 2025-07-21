Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D85C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udoim-0008A3-78; Mon, 21 Jul 2025 07:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoiZ-0007sS-Oc
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:30:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoiX-0000f4-Jb
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+lcJjDO9msn7OGfgf0nE2HSuwgXK/hFIqqBLICsj1s=;
 b=LpPezCOLAlojrPIgrt1oYr9M596SQYKiqckuS7e9ujeTPlxN0dyipCFeeUL2Kcof2vqIfu
 DvMzzSW+UIq8TIsxh8i64rcuyaIAlXVpYyc/fihy3C0MmwKF58Zzg9l8gu1EO8mbu8b5rb
 G715n60shGARv7xvpVl1QxwOQUbf29c=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-oOkwqQ2vOK-n_i24M-XLAw-1; Mon, 21 Jul 2025 07:29:59 -0400
X-MC-Unique: oOkwqQ2vOK-n_i24M-XLAw-1
X-Mimecast-MFC-AGG-ID: oOkwqQ2vOK-n_i24M-XLAw_1753097398
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b31c38d4063so2967213a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097398; x=1753702198;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+lcJjDO9msn7OGfgf0nE2HSuwgXK/hFIqqBLICsj1s=;
 b=JfzWRzXwUhT4SoIwyhsEIYMSdUGNl9Zr6wSVR3UJtdeu/hqYPXA4SpVO7LWKNvaI7X
 n4G+Qsvu6ypkz1OoYwEWChpqo8AJHRYIEdWehK3n9wdCo/5yZTdPuAW5V8TxXz+PDTOT
 by7bpRSNTf0E8cgY+1KTcoK/R2Qrpd8JdSBtMsMtEy/doB6gVjwmhioDhfh9oUDL+oUl
 RwvRUhcsmSx7cO0yvILmROshnWXqMNkn0W9Lii8g7NmMWpN7zrLjbFwDP548HOPFQ/nl
 elw/hseTEU6cg3sVn/nDZK+3lyXYbb44c0eVw2oklpGLmjJAzbO/ARmct/Vezwm6XfLA
 g2pg==
X-Gm-Message-State: AOJu0YwlRs9ZTugvehz+ifg/r847fQtyj8OGpkkUvYzbVjQQdUMFzWgd
 Usb6BuI//nKColfRo5Wy3X3mtiBUckkg8kvJpcTvzpnbTv0K9q+oGhM+eZicRoQC3NZBFOXf+bI
 jWhVE8Mt53F351NuT8yoNtYjtbEd42HmFNb5br0K2GiqRNXQHoEA0mYfj
X-Gm-Gg: ASbGncsDun0V/B7f7h1rvMMx3R46M49nzZGXYO02vPDDiD2iy7Jp3r1wLgHbULwM1io
 fvIAirUJlFGlrhkZ/epwA2IHKmxnBYs197c2v95iXbiC8ksA8+Qh61scrELiti5dcgGOuO3B8Mx
 s/OJSIcJDLmd/t9tkxQSMfnc7KU3sF9naGnIaqkHJ7hwxEGAII1m4mlu12CWbbv/Cc7mBDpF+sa
 oBUotCM2igznjUnJVarIHoNth7OfGNns8V3+HEVKx85L7FWYnRkxcFA7DR+lmZLamiBIR3XCcxq
 4TiQKcKRWIhfp5ZgtRIQRgmmkf1LBVykXTTuhLx6kpmp/L8+Nenx
X-Received: by 2002:a17:903:188:b0:234:b735:dca8 with SMTP id
 d9443c01a7336-23e2566b042mr227297385ad.6.1753097398039; 
 Mon, 21 Jul 2025 04:29:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGgfFyhjcz+vsVGVzRMhlMpEICZclsfezsstQc+KLl4kbWav0E2ISs8FsNPKr8Xga9tOCiQg==
X-Received: by 2002:a17:903:188:b0:234:b735:dca8 with SMTP id
 d9443c01a7336-23e2566b042mr227296945ad.6.1753097397586; 
 Mon, 21 Jul 2025 04:29:57 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:29:57 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:08 +0530
Subject: [PATCH v6 03/24] migration: push Error **errp into
 qemu_loadvm_state_header()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-propagate_tpm_error-v6-3-fef740e15e17@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786; i=armenon@redhat.com;
 h=from:subject:message-id; bh=xco8shlK3y+9TUJ2IyDda8HXvkUfgV51Igdn0k6q+YE=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adysRmzuc6H4/HnlBtb5rOFlC+b9Kq+RtY43+E30hlN
 r9evFC2o5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwERaXjP8r2RrlLO1SdvL2+iZ
 L/dE6Nb2f0U31Vq72w0jV+SVJvlfZGQ47FRwtezMrF9RZnqznZM3bKiZa3E78Wnk//wr7y3/rNR
 kBgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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
index ab947620f724874f325fb9fb59bef50b7c16fb51..162fb05933fae5993eeef107811f97cb08726ac3 100644
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
+        error_setg(errp, "SaveVM v2 format is obsolete and no"
+                   "longer supported, file version %x != %x",
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


