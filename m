Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F75C87FD1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHPu-0005cx-BV; Fri, 25 Jul 2025 08:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHPa-0004Wp-T8
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHPW-0000GQ-QK
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753446009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XiLLA2pFC2xYpmP1BYxPIcSqMmLO+2uz/366CCMk2IE=;
 b=eHln5NzC1Rf9Ya8fsmRWI1ENuY0Ytre5Wl/I4/6dThUQ/Zr8EEzdi2dlDHfe8/2MwM3Vzd
 ySqkXWhA4CModUN0z7Y7pxl2DNwjqbmxQCG/LIVhqUM6XmNop5bRq+xBdma5XnKLPKQMdL
 Wy8aYCd+6IawhQ1VhN6fyJ4PizdiyGY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-u0E6bnffNSm_KO_JU2F3dg-1; Fri, 25 Jul 2025 08:20:08 -0400
X-MC-Unique: u0E6bnffNSm_KO_JU2F3dg-1
X-Mimecast-MFC-AGG-ID: u0E6bnffNSm_KO_JU2F3dg_1753446007
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-23dc7d3e708so15589105ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753446004; x=1754050804;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XiLLA2pFC2xYpmP1BYxPIcSqMmLO+2uz/366CCMk2IE=;
 b=JqzmHkem1BZLtgHi/HXCPgAaJlJvHRQgUWkz36F3RnP86bfVebOFWAgh/umKassL3O
 bK2MzJrcOgUi1fXLc1slwKGlVs1+1MF90ox03gjGgbPRBSwt7S33qmfQEYt8Keg3ZTk7
 4xgRLl4PlSts/JLuh8R+bGMg8YzLc/9mrmkE7nc+BDpudIBpl3yTbeMpyz8vejxPVT6P
 L9HRobRkRnxUKa+YgrXJBtyq5KqyMTmkaaNAgY/5hVGGL2Dce52Upzpv8gxuqSeQzJs5
 yBvvQlYhOXV7hb9sy1UMCGX98gcKqNGixepZhWSCh+45VmCkioCJHg2pPSHy3YjQvYyg
 6W+Q==
X-Gm-Message-State: AOJu0Yz1UnP0my3SOUhAZU6keQSltXqa5HNYYz6R7f1Rdhzmn5h48mLe
 ipASCoX5Z0mfOTLgmLPZZi6LXFfhHdCIGUR4pQx844G7gRWLqvG6YHqr4gNlV6ZdmF97jqdqOwC
 BoU5xwBVuhOK64awL5kXiD+d55HmKgZ9aZgQCgbvLtAFXS/R7zSmPi0lx
X-Gm-Gg: ASbGncsJ1TSIcNPo7bmCgqdNCfwsd4kGNSZYOS8oe0NGl0NKAUd5+FqWDmPq1OzdWoc
 1gMQevORXOasaNWO/xG5jeCnqoXTcM5IpgCpS0aVWZRGeGK9RKtEJLVKU3bWGPFuaq3aLhIQ8pM
 RmLOnPtEIXQzB/PMdNeCQuBVO31qLjWvPI1p4EWU18/gIrmfcdf6fkzG407bgmPNm83KpxsJJWG
 x8fmiIa4dBqjIMMDjzN8VXVDgDJMYTCb3GI/MIZzg60o77RYniZXsLqho9JaWLaGD0TjmGxuEEg
 Hb8vNkkx/v1Dijf6piqfWWSnmSSI7nssOW/gkpX4IP4U9bXKBR9lKg==
X-Received: by 2002:a17:902:f68f:b0:23f:afc3:83d4 with SMTP id
 d9443c01a7336-23fb3086eb3mr32111735ad.21.1753446004044; 
 Fri, 25 Jul 2025 05:20:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqc7cjXCeV8TCluoDv09iGbhYxdFCk2DRwcWzhy/E+wj2wnADN5GrWRbtM1krCJpYsXVBHHg==
X-Received: by 2002:a17:902:f68f:b0:23f:afc3:83d4 with SMTP id
 d9443c01a7336-23fb3086eb3mr32110985ad.21.1753446003445; 
 Fri, 25 Jul 2025 05:20:03 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:20:03 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:46 +0530
Subject: [PATCH v7 07/24] migration: Update qemu_file_get_return_path()
 docs and remove dead checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250725-propagate_tpm_error-v7-7-d52704443975@redhat.com>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3781; i=armenon@redhat.com;
 h=from:subject:message-id; bh=sZRorGDHHh8ajhNs75FyCxCFdP9sBLu7x6z/L8sXuDo=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0ZzmXbRHj2DD8bRjsftWh+wr3l7fmaa4dEehkPvkqqff
 Y1lO+nYUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCIXZRgZnqY57rh9c2Gk4LZK
 kTy1D9ExfzaqRDS/f5awcMqZFbMPdDMytE2UkWFROif5QfuvyF/xezO2r9yh0f73zZbmV/Lim1b
 d5wMA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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

The documentation of qemu_file_get_return_path() states that it can
return NULL on failure. However, a review of the current implementation
reveals that it is guaranteed that it will always succeed and will never
return NULL.

As a result, the NULL checks post calling the function become redundant.
This commit updates the documentation for the function and removes all
NULL checks throughout the migration code.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c      |  4 ----
 migration/migration.c | 12 ++----------
 migration/qemu-file.c |  1 -
 migration/savevm.c    |  4 ----
 4 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index e0f713c837f5da25d67afbd02ceb6c54024ca3af..981bd4bf9ced8b45b4c5d494acae119a174ee974 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -849,10 +849,6 @@ static void *colo_process_incoming_thread(void *opaque)
     failover_init_state();
 
     mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
-    if (!mis->to_src_file) {
-        error_report("COLO incoming thread: Open QEMUFile to_src_file failed");
-        goto out;
-    }
     /*
      * Note: the communication between Primary side and Secondary side
      * should be sequential, we set the fd to unblocked in migration incoming
diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25dec01f206eacad2edd24d21f00e614c..b3bccaeaee806abd01595863f6475057049b0688 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2646,12 +2646,9 @@ out:
     return NULL;
 }
 
-static int open_return_path_on_source(MigrationState *ms)
+static void open_return_path_on_source(MigrationState *ms)
 {
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
-    if (!ms->rp_state.from_dst_file) {
-        return -1;
-    }
 
     trace_open_return_path_on_source();
 
@@ -2660,8 +2657,6 @@ static int open_return_path_on_source(MigrationState *ms)
     ms->rp_state.rp_thread_created = true;
 
     trace_open_return_path_on_source_continue();
-
-    return 0;
 }
 
 /* Return true if error detected, or false otherwise */
@@ -4010,10 +4005,7 @@ void migration_connect(MigrationState *s, Error *error_in)
      * QEMU uses the return path.
      */
     if (migrate_postcopy_ram() || migrate_return_path()) {
-        if (open_return_path_on_source(s)) {
-            error_setg(&local_err, "Unable to open return-path for postcopy");
-            goto fail;
-        }
+        open_return_path_on_source(s);
     }
 
     /*
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index b6ac190034f777dbde0da1598483a892089d7538..f9ccee9a1091ecbd37e6b7d2081a4446442b544d 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -125,7 +125,6 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
 
 /*
  * Result: QEMUFile* for a 'return path' for comms in the opposite direction
- *         NULL if not available
  */
 QEMUFile *qemu_file_get_return_path(QEMUFile *f)
 {
diff --git a/migration/savevm.c b/migration/savevm.c
index 21899e6beee3d2661c9a694379039e82cefbee4f..d8f5f1966fda831899596173f20fbef25d78829d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2583,10 +2583,6 @@ static int loadvm_process_command(QEMUFile *f)
             return 0;
         }
         mis->to_src_file = qemu_file_get_return_path(f);
-        if (!mis->to_src_file) {
-            error_report("CMD_OPEN_RETURN_PATH failed");
-            return -1;
-        }
 
         /*
          * Switchover ack is enabled but no device uses it, so send an ACK to

-- 
2.50.0


