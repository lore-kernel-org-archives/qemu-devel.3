Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133F0CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0xy-0006jr-6p; Thu, 21 Aug 2025 04:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0w5-0003Yu-P5
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0vz-000167-DZ
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755765963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FvrinIyy0xcmffDzqRiMjP4R3TFNdU5VAX1Szp3XoJU=;
 b=CuAtXuxIJfCClOvB4BINjyqjJ1ce84jLJP3EXxERAqNWdqpgeYDyvacER1R/3qc9m8Xrb3
 Os3gr1PmYGDSs0cjz/VEIbZAlgwsLcu0yVlD3a4bH3xrI4PnLuTWeGcGsC8e1zhyfYWVcd
 zVkWJfXvrXKpdBzshKx998JTAHgsFOg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-HlxdkGQGOL-47dQf3qMawQ-1; Thu, 21 Aug 2025 04:46:02 -0400
X-MC-Unique: HlxdkGQGOL-47dQf3qMawQ-1
X-Mimecast-MFC-AGG-ID: HlxdkGQGOL-47dQf3qMawQ_1755765961
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-24458274406so20174345ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755765961; x=1756370761;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FvrinIyy0xcmffDzqRiMjP4R3TFNdU5VAX1Szp3XoJU=;
 b=B0ZmqijWwBXMiTILMFu5CldUaxpxF2SuOjOEg9M2NW5c2CCCQivWK9sghJzOylD4tL
 CYZiZEqt2dSlViyjih5S/xwmnKMCfptaXoQk0nZ5Hz7FrcLk6netmCOiWsfjAoV3MROv
 OOrC/arYROAXBm/XPInP+or8oFmEIPXxAQn3LaVeixmUG8Qxp1QIEOONh/1goPUy6P5N
 +GCvC+VfqN7UFsKZ6PV7mA7vEDc2v4hezacWfOGf6LuWu8SrlJEjHSHoTuE7TIox2fLh
 2uDE4eJ+sAwYLcNNxErKSxhpzWL7Zkce/GhSsr5WPueUrj8/p6Po+A+DKEAKcg1+ad+h
 LUyA==
X-Gm-Message-State: AOJu0YyZEfttPHeQXP6QQIsVqbcuFazgiQHmLcHZTa4ypAcxTKA9TVwk
 BrnpViVKzp6k1v0mhSQoP6z/lVKb9fd9osJYgp5I3u1M6IezVHxpGtrk7K4DWGg3P2nDwCK6tDg
 nieFvxVhBMWUDVZYPR5GBQQTf1AkPM1NG86BUXEDMYcuVSGnNq/O3k/gR
X-Gm-Gg: ASbGncvhMHg093C2KaOZWWHPXR5LruldmjoX7EEV+CLQE7SrhIayT8V5vo3HqrYKoQg
 Qtgf5UsMLL8nNHNhPMFS0H48TI2ZBJKiFopPEsJEv+ocb4S672xogZ3s3lVMVJWo0d2uvsuvDcG
 PiEtFfm0rNk/jOSbhjrwFixhWSFfLebRORjFEHdrRVvFuQX4hALUtxNiMgfguZ18UflyHmRxw8E
 4IpD2G6V1s2v5JgCE/b58Nfmvsf+qdc6EatYBG/aLzdn0uc6ny70oWrUOJ5JKxRNKCunYfUMhFA
 3JjCTQFd/jqC2vQNQjvZV2Jz3uETmlJbnCIvKlBQNWH8NLe2zruE
X-Received: by 2002:a17:902:ea0b:b0:23f:e869:9a25 with SMTP id
 d9443c01a7336-245fedc893fmr22122225ad.44.1755765961268; 
 Thu, 21 Aug 2025 01:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPbtMtQvJjxULvrrCQo5pggCELl5lW0j4zYOkcmLNSAWUcaesCKVAwEbKLS8k93PwN1BVl1Q==
X-Received: by 2002:a17:902:ea0b:b0:23f:e869:9a25 with SMTP id
 d9443c01a7336-245fedc893fmr22121855ad.44.1755765960896; 
 Thu, 21 Aug 2025 01:46:00 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:46:00 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:14:02 +0530
Subject: [PATCH v12 08/27] migration: push Error **errp into
 qemu_load_device_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-propagate_tpm_error-v12-8-72b803e707dc@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2651; i=armenon@redhat.com;
 h=from:subject:message-id; bh=eyIgiFCgY7BgGnZ7hh4U3zUHt6p/btjeMo4ZulwLsqc=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayO8nOr/c/uuzEK+GadI8pSPNOabB0uWWJ7F3+vS2dX
 Qvsg5I6SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATGROG8P/cInQ16viHpf7/9tW
 ZqkubPf076RMfeU7dzj7ljPZHTSewfDfncva8sFLe2cJ+V2ucxdH/gl5+c6R5yQnr/zVx9Hr/rv
 zAAA=
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
It is ensured that qemu_load_device_state() must report an error
in errp, in case of failure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
index b4d21a4814d3b706e6b89b39528ca269559e2e0d..b46658b62ae5c27dbe9c02f6adde2d4900b182b7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3266,7 +3266,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
     return ret;
 }
 
-int qemu_load_device_state(QEMUFile *f)
+int qemu_load_device_state(QEMUFile *f, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     int ret;
@@ -3274,7 +3274,7 @@ int qemu_load_device_state(QEMUFile *f)
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
2.50.1


