Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEE0CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNcH-0007JF-5v; Sat, 30 Aug 2025 11:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5Kk-0005ID-Sh
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5Kj-0004hu-9q
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756497864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BaRoLgnvXipTQIwgmh18VwtQRJZMUjxN2HSv+RmjctM=;
 b=M6L/mDHzPI5dhA8fCwqCXPlw8c/oN3UxFgMgL5qvVXrv5/omVKoMeQpIcJ/OzXbCst0Qks
 afHO/im8DMGeZ5623wjix//tnhKKijUidPjcBZSUl7sdcOZFlBlWpYkHyPNknwd9TjQSgJ
 TSdqi17IkzbajdkVKV8LVWElNLwaNTY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-azPTDkVIPuqPE9Se0v-ELw-1; Fri, 29 Aug 2025 16:04:17 -0400
X-MC-Unique: azPTDkVIPuqPE9Se0v-ELw-1
X-Mimecast-MFC-AGG-ID: azPTDkVIPuqPE9Se0v-ELw_1756497856
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-324e41e946eso4300922a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756497856; x=1757102656;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BaRoLgnvXipTQIwgmh18VwtQRJZMUjxN2HSv+RmjctM=;
 b=IH5FNmKK0c7dN+upDIsbvsxexjXi9QWezz/6GM092DCkMeJlEo/G97UjOFUEhU/dFZ
 2N64KOTVFc6WSBLwqtZcVbfD07oc1pmuQPwef5TYe4uI6gAJcNYczvAq5YMOf1oLks2m
 GCrD489tRyGagBo+2Ym5YeqF+xUETZerF/ULmxUBGoyVces8j6dx8f0iUnv/sWA6EFv4
 JwJof+k4/6HtPf2Ubcay/vYD6xkEcT9xh2Wy9E8oeB/yrfQhR9S+serKULWTEZkUHGW5
 dC7fS35DIZdsPN1sebnZ6L7p0B/wM3lENwsv+sDbwKfVqSXp+wdp5tWX1yABnDtCfajg
 ZJWA==
X-Gm-Message-State: AOJu0YzMEPCu7QyuKyLR+FMW+2wUCg9ef6nceCpvKF2CS370K8DdOJqN
 7uxNUOMYAq79152WtfIZHEKmPk0G3gG9aFQtg/2FRTUSoqKFZAZ48s4gI3Uh4Vq8jtcwjVXA0EC
 AUDIcOsMNcxGDNjGHcGbKM87i73f3WTspuGEzBaUD23OJtAdYT/llp1ic
X-Gm-Gg: ASbGnctSBCLwGKPqidizZqws4MueOPiySd6qVQNzYmXXBFpGy3qEEa/QRlGh/gMrw4r
 tIB7z+jF2LPdjmLzg8th41AYCZD2wbZQPsuWE2MZ5ZOWcFGt/QEdX7/vz0/f65hyxF7r0PbTnDa
 VuYykhZoxuNXWLzILPV+oXNeD7UanYnQw0HG8M6khqk1cvRYszKH3069EQuoIt2qty0znZ1PAM1
 i8twPMFgDktXdJWwKA+hCmSV0r/bOD1X2rtSKwvwY+u3RnRcbD1GDRFTVMuHhz+gIYQ++jCHBhg
 mgNWf1ZjLSyv7OMXctIenqoz7T5G0DI9VrSkoCI40M998UaOxshp3A==
X-Received: by 2002:a17:90b:4f44:b0:327:9e81:ebb1 with SMTP id
 98e67ed59e1d1-3279e81f451mr10353648a91.31.1756497856042; 
 Fri, 29 Aug 2025 13:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv8H08IlwNFTAlmeU6lJUrkYSJCahYKGC1k6IyFM9h8UDI6KXXimddarHwebX8ROKAiGzzvw==
X-Received: by 2002:a17:90b:4f44:b0:327:9e81:ebb1 with SMTP id
 98e67ed59e1d1-3279e81f451mr10353590a91.31.1756497855550; 
 Fri, 29 Aug 2025 13:04:15 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:04:15 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Sat, 30 Aug 2025 01:31:48 +0530
Subject: [PATCH v13 08/27] migration: push Error **errp into
 qemu_load_device_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250830-propagate_tpm_error-v13-8-a4e777b7eb2c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2697; i=armenon@redhat.com;
 h=from:subject:message-id; bh=UirhkFM9zKCc9fAhhyz10Rt0EBJQI4cJF89hFF4FZFs=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8Ymdh9esW5F1f1R1hM1t7EcnrL48Lpvtm5ht2tEq/r43
 wkv3Dipo5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwETOnWdkOP95m8njJWaqns9d
 dt9Z33uwZUIyk8H54MNOk2zfCMgdCWBkOO+pusv8/spZC6X1lqsv/Ol8eY/NiZR0Dl7LtQcT/7v
 yswEA
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
It is ensured that qemu_load_device_state() must report an error
in errp, in case of failure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c   | 3 +--
 migration/savevm.c | 4 ++--
 migration/savevm.h | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index e0f713c837f5da25d67afbd02ceb6c54024ca3af..2f524b19e6a79dcfe3861f1dfb768222f65a718a 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -729,9 +729,8 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
     bql_lock();
     vmstate_loading = true;
     colo_flush_ram_cache();
-    ret = qemu_load_device_state(fb);
+    ret = qemu_load_device_state(fb, errp);
     if (ret < 0) {
-        error_setg(errp, "COLO: load device state failed");
         vmstate_loading = false;
         bql_unlock();
         return;
diff --git a/migration/savevm.c b/migration/savevm.c
index 0087fca15ce108685667d3808350d80d37b807b1..5462eaff0dcec1fa207c08da6124fe91656201ac 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3264,7 +3264,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
     return ret;
 }
 
-int qemu_load_device_state(QEMUFile *f)
+int qemu_load_device_state(QEMUFile *f, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     int ret;
@@ -3272,7 +3272,7 @@ int qemu_load_device_state(QEMUFile *f)
     /* Load QEMU_VM_SECTION_FULL section */
     ret = qemu_loadvm_state_main(f, mis);
     if (ret < 0) {
-        error_report("Failed to load device state: %d", ret);
+        error_setg(errp, "Failed to load device state: %d", ret);
         return ret;
     }
 
diff --git a/migration/savevm.h b/migration/savevm.h
index b80770b7461a60e2ad6ba5e24a7baeae73d90955..b12681839f0b1afa3255e45215d99c13a224b19f 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -67,7 +67,7 @@ int qemu_save_device_state(QEMUFile *f);
 int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
-int qemu_load_device_state(QEMUFile *f);
+int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy);

-- 
2.51.0


