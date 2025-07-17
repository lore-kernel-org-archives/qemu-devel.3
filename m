Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BFDC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCjs-0003xW-KT; Wed, 16 Jul 2025 20:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucChD-0005Qh-Mo
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:42:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucChC-0005IX-0m
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v3M7SxUYCWLjJ1Ljl3xoXUUFS5YnBYCEqF7qG6inXOs=;
 b=BHY4sScSf6VJg4fvDRaU/pDwYxXqB5RlzdpSk2vh3vBIcDV3bWYLJETiQxju6ulmRRT4nY
 x6bKYvB7w0sXYdyvfM5s8EvoT4pU/RFjgTCy09Nat0KzpGkVCHes3skNc45Vci8Z+g0lzy
 TuTOb674F6FJ3oZHSb9+OaqmtIC4w30=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-uBPAjO0OMoSnBBaYMK4EfA-1; Wed, 16 Jul 2025 20:41:54 -0400
X-MC-Unique: uBPAjO0OMoSnBBaYMK4EfA-1
X-Mimecast-MFC-AGG-ID: uBPAjO0OMoSnBBaYMK4EfA_1752712914
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3138e65efe2so358463a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712914; x=1753317714;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v3M7SxUYCWLjJ1Ljl3xoXUUFS5YnBYCEqF7qG6inXOs=;
 b=b7+wjCAd3BgL1gtW6OOKxx+WNBkznAqtfWbJJtBhJoPrq7GASpqF9Xp1B6msT2T6Z1
 Kq+elmQCHH5+ggkxxxlj5ss3Ag5/oiaqkcdlZiR3b/J6H0R7SPfab+r8n6X5z0cH1j4s
 5PZ8HCUpDTN41eVo2hEyytvUJBnnqwXxWS8ifraGyzr6EGGD8LX/oQpYskMgKxtoKItG
 LzRy02KFf+aQHm1cf739Izifbhhs0m8d/yqR6Ghm5/Pzrz13l0cC2FIT4FnCylHBx72S
 QGmeVWtgpNvVj3qERGXTIRwE4lusB/lKGMj1PFdzagx9stFNiwq8Un2A/OsKvoszW5GA
 x0tA==
X-Gm-Message-State: AOJu0Yy2Q1vHO/E9k26xzHYJAcwy6LA0Xh9CF6rhegLQ1L+f0Mh+eM7e
 rsyWzufumP2ItjZ/zT5jjL8mHRnTURvSI1EjqkMh2P3HPVsCSfxDvV/ulOWxXvKspu2KhIY+7oF
 FGNjWyD/dKg6lPK36N+NWBS+vRw1dL5DxeRi7Czb/SeCNjgItGU+BOOTf
X-Gm-Gg: ASbGncv8kGsSl1lQxmRuV/tvUC+sfppKE6V82URhfGCemlGgqHNI1NdBYVVrjUmkr8I
 p1adcVKNqHvMaj+lNiDhjDkcUIoFmAJQZvlxcTdXrLnIEOr1Y+7Tj6wxL6pQjp2/c37COEm2a7Y
 ZjQzOGAAiXyMzHpPt0d1hrIaQ4k6r3MfxS0ugyTz5UED2fyE0G+wqNtNnpvcEvo2SOloDY0yvln
 GrK2kP8w08tmgSbRL9W+pAhUSYN1cPMB894bSQAnxuupdLUlON8X7PoPhWCOGrfN7NmzfAwqi0M
 iauXxWEa+2DJqQMJAuAWgCqLUpbTrKeyj8qIql9Ybpeke1cMaE/5
X-Received: by 2002:a17:90b:5281:b0:311:e8cc:4256 with SMTP id
 98e67ed59e1d1-31c9e758d15mr6362078a91.22.1752712913652; 
 Wed, 16 Jul 2025 17:41:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHu9ZcYYgxgG22WlxYVyPLEn/nx3QQkI27v+yt7fjl834YregjN1XJJxohB71hLq8S8jeK9A==
X-Received: by 2002:a17:90b:5281:b0:311:e8cc:4256 with SMTP id
 98e67ed59e1d1-31c9e758d15mr6362037a91.22.1752712913171; 
 Wed, 16 Jul 2025 17:41:53 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:41:52 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:43 +0530
Subject: [PATCH v5 20/23] migration: push Error **errp into
 qemu_load_device_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-20-1f406f88ee65@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2721; i=armenon@redhat.com;
 h=from:subject:message-id; bh=CYxCKw7STkdES3yRF1OwMbrxhOvfWfJPBgR1HKcyPFI=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm9IN54d5z368uHSs3rRxZ7Ya36w03rqmewy9Hc/2m
 5z6HPCro5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwERiHjL8FeEJ3hOcaK+j3+aa
 JWNybVZFsdGutpMZ/QEL1cUqPhxjYmQ4MqHMbG1c6qS15250i67xn3K16aNMd89XEyn3RVd/Xrn
 FCgA=
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
It is ensured that qemu_load_device_state() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c   | 5 +++--
 migration/savevm.c | 6 +++---
 migration/savevm.h | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index ddc628cab4194b3cb82388c5e878286c820004b2..7291df0d47d8e308f8b71973c908b5a05ec7f4d7 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -730,9 +730,10 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
     bql_lock();
     vmstate_loading = true;
     colo_flush_ram_cache();
-    ret = qemu_load_device_state(fb);
+    ret = qemu_load_device_state(fb, &local_err);
     if (ret < 0) {
-        error_setg(errp, "COLO: load device state failed");
+        error_propagate_prepend(errp, local_err,
+                                "COLO: load device state failed");
         vmstate_loading = false;
         bql_unlock();
         return;
diff --git a/migration/savevm.c b/migration/savevm.c
index ea64603b75ead17bcc21aebfa49ede3991387fb7..0fff65c96344c65191353311e72730cd6e3bfb23 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3232,15 +3232,15 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
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


