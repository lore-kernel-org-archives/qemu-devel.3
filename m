Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB25AC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCl0-0005OY-3c; Wed, 16 Jul 2025 20:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucChO-0005ju-AD
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucChL-0005KX-HI
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UaNetO2Qn1xjqwHWbrWgZcK9a9Y4Ysw6MagpqH4pFTg=;
 b=M/pRXlzSDVxaFbwfvc+puPJ0LFc3gQUXQ9Kz4btU3IjDq9SSzrkBMAVs5BY/lzFkL5V8G8
 baX+pglCpN/IIyAHek0V3g7WJm3285b5f1lqQ3cZ0ZMfTSYFD3ZaAELuBPEz6yxPY7awfo
 iFCZC7i2jbTgmrdaNZ5tZAR8XhQAHjM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-kqK5JYbcMVSYdazTzrpVgw-1; Wed, 16 Jul 2025 20:42:03 -0400
X-MC-Unique: kqK5JYbcMVSYdazTzrpVgw-1
X-Mimecast-MFC-AGG-ID: kqK5JYbcMVSYdazTzrpVgw_1752712922
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-31cb0471b45so159416a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712922; x=1753317722;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UaNetO2Qn1xjqwHWbrWgZcK9a9Y4Ysw6MagpqH4pFTg=;
 b=LCk0YH1JEdiPsL3Hg/NI0hKPnXACKobIJBB9Oig34JbPaTGDHYynDITUrJKjanbm2I
 tFoNq7nmCtrZQc458tSn3SaowYq7dehqAs0PSsmyIiEX7a/whRzS7ZKWTza1KsiJizpI
 YwCMMDiiOgpKF2rnjRyLwf5/JLilWtjFE+1/REi2ksKnS1IA3NywmeKw/c5dHwPZPq77
 0YwXIwo9MPkX7Dhao8FoPFfxwYk/XcpBCHBmYkHvh1gZ86m08uxsoeaAc74wn7S6pCXB
 rq/jSf9xF9lbKKQy2YwdBEEMazGQpPgg+pw2oboqSs6TJ4LwQW7MJdA6b5pxPqFoWZPN
 RCpQ==
X-Gm-Message-State: AOJu0YwDs/+Z564ttCEIiUlgM376LkC0Omecgl0TUDjzyhIDRsl/X8LU
 chQW87Lpj2l7yJlc8yRU8SO9uB9VV1iHeDZ7EYuxYMd3ZDNlbCP5uWlRJJcT2MF5SbF1lbGrozH
 0Z70i4WmKEvHCUmf7pWWtyPNQXVcC/Cm09GgMyVD1rqMMEmjp/URWbAgc
X-Gm-Gg: ASbGnctySMq4yuVQW7H/UG1HtxOInayi01ieu22TCU87FbDspJl1RONVLmLbhxATglM
 mfB4SvGUSXSfjaPNKYMzMknXtY0GL2JA9cVEh7xcEHVt7MxuhXs2AhGfBQLCLGqcHC+RwP3VAY/
 hKPAO7KOsEzlT/tdjs2sS6QB2DBWBNzVzd+EWnJp8DDAvGSXJPr6UjQ/4RGm6kG9HLLLQR/LGaI
 yvIpGWmvTrUnX3KP13ADyrdmS3ZBo32oY7qg0N4O56/HxX7nIsb0MtWJ725zZ+J/hE02tewDB+4
 SclsHE2lwZe4uAKT9KXgHrt0GKujSfx/4XAEDbCC5pIZTwhje72J
X-Received: by 2002:a17:90b:5446:b0:311:482a:f956 with SMTP id
 98e67ed59e1d1-31cae9989e4mr1609991a91.5.1752712922302; 
 Wed, 16 Jul 2025 17:42:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERJSQdSSL8Vo3WArCwO2D+1ROILgOberqXZPMTsuecnhPfXXsILl4OADCEzpvNuMViRToPgg==
X-Received: by 2002:a17:90b:5446:b0:311:482a:f956 with SMTP id
 98e67ed59e1d1-31cae9989e4mr1609954a91.5.1752712921886; 
 Wed, 16 Jul 2025 17:42:01 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:42:01 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:44 +0530
Subject: [PATCH v5 21/23] migration: Capture error in
 postcopy_ram_listen_thread()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-21-1f406f88ee65@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2959; i=armenon@redhat.com;
 h=from:subject:message-id; bh=42uhy85WkdN9bMSUXABk6f8LoYWAKhZekD76Ts14rfw=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm/LcVSX3Ww+8nSl1JsVzYSerZG50kLWXseV9DaNFb
 F75j1U6SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATOT9IUaG1vJed0+Thc5GNY8Y
 btmcWfEr2Tu16tM/4SPispMdzlebMDL8Y7s8JUdf5enJr3dYJS4mROyUKjZf3Pd9qZx7WhS/zF8
 mAA==
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
index 1f0a8bd6ab28ff09bb76919564bdbfbde35c5e42..efd02d917cfe4d1221907123eadd98932b02e8bc 100644
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
index 0fff65c96344c65191353311e72730cd6e3bfb23..4f67eebe5321c175d51e8029e36ceb336c98ad1f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2086,6 +2086,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     QEMUFile *f = mis->from_src_file;
     int load_res;
     MigrationState *migr = migrate_get_current();
+    Error *local_err = NULL;
 
     object_ref(OBJECT(migr));
 
@@ -2102,7 +2103,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis, NULL);
+    load_res = qemu_loadvm_state_main(f, mis, &local_err);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2128,7 +2129,12 @@ static void *postcopy_ram_listen_thread(void *opaque)
                          __func__, load_res);
             load_res = 0; /* prevent further exit() */
         } else {
-            error_report("%s: loadvm failed: %d", __func__, load_res);
+            if (local_err != NULL) {
+                error_prepend(&local_err, "%s: loadvm failed: %d", __func__,
+                              load_res);
+                migrate_set_error(migr, local_err);
+                error_report_err(local_err);
+            }
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                            MIGRATION_STATUS_FAILED);
         }

-- 
2.50.0


