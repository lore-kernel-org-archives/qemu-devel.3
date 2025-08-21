Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302D6CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0w8-0003MG-VG; Thu, 21 Aug 2025 04:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0vR-0002hM-U5
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0vE-000118-GO
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755765921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7FHj/lICNn3ML/tUvoadsWlJAIkq5LZEwx29bd9ayqA=;
 b=hlsybJXhNpeO3kUcdrJ6ButrSYUSqzu3TvMpyVtCK5miL/245IYiivTh2pXXHNBMp1JAGK
 B6iTiIZz4TJgN8czTGJ+GXXlRSSEJi3LPXn4VQhMqmFNVdOhdFebhVs8ViRgSlqCR9lPeI
 LkVR0BJt72bvWDSqJjPkXuQVS0E8naE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-NR1Vi2NeN9WrxENlOWgztA-1; Thu, 21 Aug 2025 04:45:19 -0400
X-MC-Unique: NR1Vi2NeN9WrxENlOWgztA-1
X-Mimecast-MFC-AGG-ID: NR1Vi2NeN9WrxENlOWgztA_1755765919
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24458345f5dso9340325ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755765919; x=1756370719;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7FHj/lICNn3ML/tUvoadsWlJAIkq5LZEwx29bd9ayqA=;
 b=PJI9Hi/87eMyBjyAPiVFh7yhgK3Y6flJgYQLE87y8O4ZqpSA7QW8/o0xt3YRXxJJtY
 XE5vqoHNzxgE0UHwOzwJOvlLbSo3OFkVSCM/rzME4m4agnVlVFKc3AWkZUn4XH+sb8oX
 iIfZ2mzzlHAW1OqaJoKwTYxlSRlhj1GxHA9C46HXy2iOSYkwR+AL6OhE6/m7RSuwRyeL
 JH6fRGrYo8DPVCGDQx+lfiFxcT4xEyvnoDK5pyHRxUAcnwvUwA/XRa0bvuelVyRJNMAC
 N/yggBmJDGjSLzdCSBirCyALeGtDN6fPQPXICRfiiWQdFSNzXZ8DJE3jiV52u/wSmdg6
 oQmQ==
X-Gm-Message-State: AOJu0Yy6L14j30t+vReQRRkzR8OPktxrDV3UDh4F7FkeRfHHu3umG9Yw
 CHw8pqBccTY47auwQOrAqme0yPZPGC4aOA/0cD3ab9nnYdgpBwGZd0bDs+p70AO7Oahg0XQJABW
 icKC3/P9KBznH3XqCM1rmy+p58nJ/dHv44HK7awnWbpaexLIuN9btb9ya
X-Gm-Gg: ASbGnctOQlAw2Nqc+nWzxMOuJTQGpIsIqplv0//xPoGz/TgbHehy/T1Acdm07CLIp62
 O/Ydjts+ZQM2MrJxWNdQ/I8qcuQU3+Bnh3zKINXUGRqXCByFbmlj+CxXyiGtJznUSXQEyUJcU9o
 S0d6Zu6zlLcuBTXQFKIztxS2Ap24dskEI2CUNbQjXi7gIRFHvWN+hZi38P5p1l5wzJKZYJJyh8N
 DrIK555N+AUTRwVT82PJgIwcTKV2Lws0WlcpWHD/KPFyVdoBuVRczPlL6mnqhs0dPXJmFDJvDoD
 6cSC7nHkX17vvHUttYKjgfJic46yGd6X2QgLO8SZlEmoumHixD9D
X-Received: by 2002:a17:903:37d0:b0:234:d1f2:da31 with SMTP id
 d9443c01a7336-245febe190fmr27355045ad.2.1755765918426; 
 Thu, 21 Aug 2025 01:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlMzUwOBltdKE0wwBWmO7Kvd6vmVNDQ2rsfSif1WJ9uJO20VZmr2B3kDPNtWBrIeL1+y1+LQ==
X-Received: by 2002:a17:903:37d0:b0:234:d1f2:da31 with SMTP id
 d9443c01a7336-245febe190fmr27352755ad.2.1755765914249; 
 Thu, 21 Aug 2025 01:45:14 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:45:13 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:13:58 +0530
Subject: [PATCH v12 04/27] migration: push Error **errp into vmstate_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-propagate_tpm_error-v12-4-72b803e707dc@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3214; i=armenon@redhat.com;
 h=from:subject:message-id; bh=lexYJKIf4MTAkJUsIsA8XptGUSYcowY9vJmjXRBJ4vg=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayO8mudtrpHlcWPtgeHF/1cuvkazwXGh6sMt5jmajqz
 Pza8kNhRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIlIiTMyrLFLNq4T6bvdkh+x
 sdnux+UWp9aCDQsrErmtRXlVrOYeYGQ4k+4tLldop8266M4fi1kTufMOtotbPuaVfBEtoW1S4Mg
 CAA==
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
It is ensured that vmstate_load() must report an error
in errp, in case of failure.

The errors are temporarily reported using warn_report_err().
This is removed in the subsequent patches in this series
when we are actually able to propagate the error to the calling
function.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 0c445a957fc99f826e6753ed3795bcdd51f1e3f5..e19156a280c00c5aead9ca84e143e6c7a7de7501 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -963,14 +963,20 @@ void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
     }
 }
 
-static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
+static int vmstate_load(QEMUFile *f, SaveStateEntry *se, Error **errp)
 {
+    int ret;
     trace_vmstate_load(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
     if (!se->vmsd) {         /* Old style */
-        return se->ops->load_state(f, se->opaque, se->load_version_id);
+        ret = se->ops->load_state(f, se->opaque, se->load_version_id);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load vmstate version_id: %d, ret: %d",
+                       se->load_version_id, ret);
+        }
+        return ret;
     }
     return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
-                              &error_fatal);
+                              errp);
 }
 
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
@@ -2692,6 +2698,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     SaveStateEntry *se;
     char idstr[256];
     int ret;
+    Error *local_err = NULL;
 
     /* Read section start */
     section_id = qemu_get_be32(f);
@@ -2741,10 +2748,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, &local_err);
     if (ret < 0) {
         error_report("error while loading state for instance 0x%"PRIx32" of"
                      " device '%s'", instance_id, idstr);
+        warn_report_err(local_err);
         return ret;
     }
 
@@ -2769,6 +2777,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     uint32_t section_id;
     SaveStateEntry *se;
     int ret;
+    Error *local_err = NULL;
 
     section_id = qemu_get_be32(f);
 
@@ -2794,10 +2803,11 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, &local_err);
     if (ret < 0) {
         error_report("error while loading state section id %d(%s)",
                      section_id, se->idstr);
+        warn_report_err(local_err);
         return ret;
     }
 

-- 
2.50.1


