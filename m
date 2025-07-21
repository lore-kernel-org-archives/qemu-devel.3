Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990DBC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udonl-0002RO-Qt; Mon, 21 Jul 2025 07:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udolG-0003lO-G0
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udol8-0001DT-OA
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hkw007WkL2bTNA6NzrTVjPjzDilf74VZVqgpQUpo1iQ=;
 b=MQ9ajdbn/BvRabG2AKG0IPE/4yjtjB0DeIVnSK/ILR+K2II2ylzTMnqcxDB3Bf/zYqxPHk
 fZIVfwUvXC9qkhmr8tte/tqL5TzvtwZoTyHRIDafkj95uI84T9ZdsLAFuJVil3F62gU7/i
 pOZQeVjzv4ay1RggaDVQ7asuxlyr0IQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-1Fr0RXw9PFSAAEGEhKLjww-1; Mon, 21 Jul 2025 07:32:39 -0400
X-MC-Unique: 1Fr0RXw9PFSAAEGEhKLjww-1
X-Mimecast-MFC-AGG-ID: 1Fr0RXw9PFSAAEGEhKLjww_1753097559
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-23dc7d3e708so29880255ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097558; x=1753702358;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hkw007WkL2bTNA6NzrTVjPjzDilf74VZVqgpQUpo1iQ=;
 b=v/h7pxCjxpbV2Lpp6GeOSo4+0dElUmu/B7zp+GxQkGSdG3tvynBh0Zrl43q5YZ00d6
 u0WW8Zg1xGvYj6pc7qtwd5z+qchMXhMI1wGD60jfiKfy0IPWVy7hdk+VK1GkenmNl9K8
 y2Nvw5X0bj51pdVjfRGiJSf0yqh/0J/HnM8fHYjuRHqbmwH+zbDwef0gyFSTKK3rqoKN
 6Nsf5TqawcfaQ4oRON1xzoDjEl65YQGzHSQSOgzDHuwb90ehGOXcBMAB2Eiq52oAnQOU
 z2O7KZgMtYrod7q/unyOcyUBrxzdwNnLkS2l90qvEzCADkXsKoy2LL4iGEAHMn4eRM2Q
 Kpjg==
X-Gm-Message-State: AOJu0YwD9Jn0lHti1Az8im3CAVSHnjPNxma6T+IchrsfdfpKYnJ0fjx6
 gA8VdOSoSnmjypuRppQePfBTJul9Twg9z8OKjzEHL8LxKe/1ezdo2uYgU6BvqvMo579nkrPiM/6
 2hM0/CIexGGLIMXw64Vs5Ao13m08AhS/RFyAczrCph/ZLv/lSJejTKfSf
X-Gm-Gg: ASbGncvGSHOC8n33NyTmMC3dO5itxW/i+qS7FNnrbZ16Wp5uqUSV21beqh7NxQ/vQfv
 jyd5zzKYriALsZhkH0IMahcm7fVJuLL+/mpngXACnxtyXgK4EnDUsP9zcIhJeOkH0HvUHyyautC
 hhMimKxdkBrU9VTC7Lqs45qRouEIMoEbTG/j7fEetIISwsCir+Hy8RIJhRp9kBIJhbqD0CWdpJC
 RqadUGvXikW4XJ/dZQHmMtIlSnlX5mfxFFKVCcKL7Ae3UGwN02OBXtYrdUwx2NAfl/OTaqPzm/C
 hcgYOqv+DGx9I0gXeGoVznJ28iqIosgcpFSpoohVf5Eh0AzZJbts
X-Received: by 2002:a17:903:1c6:b0:234:f182:a734 with SMTP id
 d9443c01a7336-23e2572fe2cmr266488175ad.31.1753097558410; 
 Mon, 21 Jul 2025 04:32:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOcXkvyO/2m94/qNR6kURY/gxJZ6l0VLzmjmmUWOSmET6QivsvVH3zNbalHI8kzy6/xmR/Yw==
X-Received: by 2002:a17:903:1c6:b0:234:f182:a734 with SMTP id
 d9443c01a7336-23e2572fe2cmr266487625ad.31.1753097557999; 
 Mon, 21 Jul 2025 04:32:37 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:32:37 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:27 +0530
Subject: [PATCH v6 22/24] migration: Capture error in
 postcopy_ram_listen_thread()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-propagate_tpm_error-v6-22-fef740e15e17@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2961; i=armenon@redhat.com;
 h=from:subject:message-id; bh=v3kIu8xv5CmXmOovgQtNwiMRjDivOP6smrquljBzKYk=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adyqT1j7Ui5bnqFsnw/pTx5ss+xqD6snlNr/7PYOME9
 UOZ26U7SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATERzKsNvlozJKwytysT6Niid
 tTn8ewvbsV07pttaemZOEDwnt3ffNkaG70trGjq/SJRWB6cud9zibmr0u2ZSd+XmJd+49s6/027
 DAgA=
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
postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
to load the vm, and in case of a failure, it should set the error
in the migration object.

When postcopy live migration runs, the device states are loaded by
both the qemu coroutine process_incoming_migration_co() and the
postcopy_ram_listen_thread(). Therefore, it is important that the
coroutine also reports the error in case of failure, with
error_report_err(). Otherwise, the source qemu will not display
any errors before going into the postcopy pause state.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/migration.c |  2 +-
 migration/savevm.c    | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 09fadf36dbbbd2f68df1e4cafbf3a51b18531978..8acbed207440fe4a2dfe303f97cfd83b40457db0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -925,7 +925,7 @@ fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
     migrate_set_error(s, local_err);
-    error_free(local_err);
+    error_report_err(local_err);
 
     migration_incoming_state_destroy();
 
diff --git a/migration/savevm.c b/migration/savevm.c
index b90505595091da27d3cf92984eb256f137fb9d36..55cda4566ac2f8c72fe5fa2f8df8475e175ee717 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2092,6 +2092,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     QEMUFile *f = mis->from_src_file;
     int load_res;
     MigrationState *migr = migrate_get_current();
+    Error *local_err = NULL;
 
     object_ref(OBJECT(migr));
 
@@ -2108,7 +2109,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis, NULL);
+    load_res = qemu_loadvm_state_main(f, mis, &local_err);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2134,7 +2135,12 @@ static void *postcopy_ram_listen_thread(void *opaque)
                          __func__, load_res);
             load_res = 0; /* prevent further exit() */
         } else {
-            error_report("%s: loadvm failed: %d", __func__, load_res);
+            if (local_err != NULL) {
+                error_prepend(&local_err, "loadvm failed during postcopy: %d",
+                              load_res);
+                migrate_set_error(migr, local_err);
+                error_report_err(local_err);
+            }
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                            MIGRATION_STATUS_FAILED);
         }

-- 
2.50.0


