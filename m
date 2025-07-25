Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AEBC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHVG-00075m-M1; Fri, 25 Jul 2025 08:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHRW-0002u5-Na
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHRM-0000gc-8w
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753446139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bYqjpe6cfSoElxQy+WVXsgQT4SsxY66JlTODOphrzwk=;
 b=eLQ2pFp8slDqTz1ZcM7rh3eMattjM2rXCraiuCn4NgOW0H2PQCcAi4Zu/5DrVKKmXLal10
 IohqWHQyjcryUxHjBbiG8V6mRRbwC40FTp6NBBFxNHMpWMf321SZxusH5Rn52Lj/tf9f1A
 sjB4fKjE/5fUMHJFgIjL5G0snTepswo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-cu9BmWkeMk6wHRxbTUCVaQ-1; Fri, 25 Jul 2025 08:22:18 -0400
X-MC-Unique: cu9BmWkeMk6wHRxbTUCVaQ-1
X-Mimecast-MFC-AGG-ID: cu9BmWkeMk6wHRxbTUCVaQ_1753446137
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-315af0857f2so1930276a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753446137; x=1754050937;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYqjpe6cfSoElxQy+WVXsgQT4SsxY66JlTODOphrzwk=;
 b=iDJCEN6TtkV9zF64mBANiH5NtQlZFNwESKFkqn3+ZKXTNxAtT2IhSBvFvHrJ9hfRj3
 /in+uclpXQKsO/OpaPXfTwaiezgoCQal/gokhisguIB9XsdA5J00ikK/S4ZooaZ5ohUA
 mlkyBZtbYSNyBeeXu43UKxf9Wb8OgTXiR4FXLCDUUOYZwjY8YxzPBv4tbkkgX0woLQAv
 ZIUtlHPfJ+meYgdUnfIe6tclHa6DJOpVqEBqfIW8rC5mGZkYe3ElUKvFfdzZZSuMNs8/
 dnsLD6f1T9DZkBaxMLOmypYc1ePUOAET15a9WHyJkAa2rzd9Qo7i1e5CMq2AXEBSfK/E
 Xo4w==
X-Gm-Message-State: AOJu0Ywfe2wCJKxZR2OsxGNJy+3EtAkTKQ7al4gXtbabQskWnyg5Dbj0
 syzmCNZbMW2zZZX7o8Ew1LE/i6Enj6B2Wpc/gPv6iwJKkzD8RMUjCH82KvjU9EvnNIkhpQOLJXR
 2ifQm7G+OB3+x7y7BZ7F6Xks17lSf5aT+r6DE8L6ZHZB1GEhYve19oy7q
X-Gm-Gg: ASbGnct7zWnciojnPtO2XhuMBaQiOG5ycvdrK8ZoSwqxFUIhu1Sfy9pgeizqyYP2d+1
 I/63X7cnn53HfeUw+VVoOdiYLtkW2SEHOXmG+2J7FxP/wZwuy/kzAF69mOMWkRDzSrdxiDe1K+j
 9F3ozpzxhJdfS9gSxjrM4VtWU9w/YyyE5KU4DF4SV4LGYN39oYEbKc2EJ9yjEC/2NuzEzpI4wyQ
 UnlkI63kjTGUVIRg7UYCdCfaF+AoASmLjmLIEKHtcfny3PdhbFJzMNAL9Zzz5NTiq4uAfZ/rAQe
 M4iHxzArgkBcfrjRKC8KJRmBPLYlAH6YieeJBCsVjdJ3FHOCqd55wQ==
X-Received: by 2002:a17:90b:5104:b0:312:26d9:d5b4 with SMTP id
 98e67ed59e1d1-31e778f4107mr3018327a91.17.1753446136793; 
 Fri, 25 Jul 2025 05:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfep27hBZddfxp1sm0ABZ7gY5vgkb+BQF5QfgcPD8G08SfkcXbMEHSPDLYlfp8E5EemCcvnw==
X-Received: by 2002:a17:90b:5104:b0:312:26d9:d5b4 with SMTP id
 98e67ed59e1d1-31e778f4107mr3018253a91.17.1753446136309; 
 Fri, 25 Jul 2025 05:22:16 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:22:16 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:49:01 +0530
Subject: [PATCH v7 22/24] migration: Capture error in
 postcopy_ram_listen_thread()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-propagate_tpm_error-v7-22-d52704443975@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2963; i=armenon@redhat.com;
 h=from:subject:message-id; bh=E/DH1i88c4/KiNDhda4LU9lNjAUHsEOCIMyiwH9Svm4=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Zzme7S2/I/b/bG+rS2GYodKFxy2cX6xtweFZv061qPv
 UuXXv3SUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCIKGYwM9+otj91Y1q2vEioo
 47k5+syLDcuWyE+pbJmRfFHk//49OYwM/3zVjyYYcWSu13Da+bSFy1hLbOWFuX/nmXXeL52gvDi
 NCwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 0a5a8d5948b2b0a3f85163795e84f71903870d25..4a76d7ed730589bae87115368b0bf4819f8b161e 100644
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
index 810bba9799246c8d57514be0927bb474edee8e9b..202bb9f494c9185434a50967c439ce84e0b3acee 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2095,6 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     QEMUFile *f = mis->from_src_file;
     int load_res;
     MigrationState *migr = migrate_get_current();
+    Error *local_err = NULL;
 
     object_ref(OBJECT(migr));
 
@@ -2111,7 +2112,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis, NULL);
+    load_res = qemu_loadvm_state_main(f, mis, &local_err);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2137,7 +2138,12 @@ static void *postcopy_ram_listen_thread(void *opaque)
                          __func__, load_res);
             load_res = 0; /* prevent further exit() */
         } else {
-            error_report("%s: loadvm failed: %d", __func__, load_res);
+            if (local_err != NULL) {
+                error_prepend(&local_err,
+                              "loadvm failed during postcopy: %d: ", load_res);
+                migrate_set_error(migr, local_err);
+                error_report_err(local_err);
+            }
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                            MIGRATION_STATUS_FAILED);
         }

-- 
2.50.0


