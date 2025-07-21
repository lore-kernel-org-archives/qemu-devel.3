Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2A3C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udolD-0003MI-6Y; Mon, 21 Jul 2025 07:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udojB-0000Pe-EH
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoj8-0000vx-7k
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/LNqUCu7dKPQ/SuGiYcMybR4TcCesQNHzWDsgprIUc0=;
 b=VCJeVhLPt1csVhr06vxN5lxH3IzFV0/Jk0q7Ovi54MNuiwdHr95xwUAQzXgJyWrQ9DAoQb
 jOs0osnZX9JoHCzPYDCgcUqLLxjfA+Gnr0WluLsw0N1NKKfo4ArWzAx/bJDdvb4obUzSv0
 0v4sYe3gpyRVdB4aVu2gz5uYPunoE6Q=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-ge81KtitMIukKsXxbl_UkQ-1; Mon, 21 Jul 2025 07:30:34 -0400
X-MC-Unique: ge81KtitMIukKsXxbl_UkQ-1
X-Mimecast-MFC-AGG-ID: ge81KtitMIukKsXxbl_UkQ_1753097434
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-23dc7d3e708so29870755ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097432; x=1753702232;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/LNqUCu7dKPQ/SuGiYcMybR4TcCesQNHzWDsgprIUc0=;
 b=As7Lmy1nHBjXHNl9J2RNZtUcxZv4tit8pqP0Z0wZ1KPj/owRxYrrmVrSGPknbIFzA+
 FyhtOTZ3RNaWb2DMzWR/hCv6/gF2LQTPc00Rw3Wbz5ZnAE0/vaLycNx2Wt3oQkdi8v/c
 T2KEjNSCTNQRXTlQKzvp5iLNFhWqEicxYJ28vjLLzdsItkWHIjNfgFbJqpD28JN2x5j6
 kQkXJc/Lnna+qj9egtGH0dddjnyqynIV8CIoh531nKOe+GsNS9PNtcXE+s9MmvXj3Ta8
 J2Auwwo+aOuEsMGV+Xwf4mM8AYXm7t7j77LFewbWb48bEsngObkAf+1Qr5OdFoLHrPQF
 j4WQ==
X-Gm-Message-State: AOJu0YzOAUX6Yo0W++G2OtCgbNsJJ7LJFC5+owIU2/NPn6FgqlwRwXsx
 dETx8zNknPBWloP6qhZ/iq27RT8vBfGyf5oAJQvPPu/1rTUHK57Iu9vmlEe2fRPf/rlVZCIc/EW
 wzNoRvrm4xh+hKKY8Ed249TEMKqJ13nXcTPqnEzFVYOGwmO16rGWBLQbT
X-Gm-Gg: ASbGnctgLNQRLri42e2j4VbZ9IF4aenSgz1hGKgW/GKDRGwqvvbn897qfeluyDD9vVR
 ZEcvx6yhkq2h7y8dJUhgBaLeDuMkizZjxhPgqDDBDbN3LX7iDoiVhEiYYPNx6j+8HjrDJWaghsE
 WKBY372f+PV0x/4NiceK8Cq7n+iyqQiCFma2h99Nefb169IECEO6bbzxR6H2YyP0MK/nCsu/gYH
 dWWpAm+kWq81hRyLRj1RlA0bEf2/7RabkQHS0WBGM1potPNr+KZSerw9r8yeXowOs0+f08r/+0B
 blpQ+2pBz7guAuTLIcUaQEqBgJV2o9chnGUjBpNmnFvJmgjiv1ca
X-Received: by 2002:a17:903:ace:b0:234:adce:3ebc with SMTP id
 d9443c01a7336-23e2578a8aemr309082525ad.52.1753097431654; 
 Mon, 21 Jul 2025 04:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwH+R2QUhaa3FhehiC+1lKY5szCrc6hJ8O/PHhTR1YRDlWDQqngxSbW4ms4MM/6cHGw1XM9w==
X-Received: by 2002:a17:903:ace:b0:234:adce:3ebc with SMTP id
 d9443c01a7336-23e2578a8aemr309081805ad.52.1753097431234; 
 Mon, 21 Jul 2025 04:30:31 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:30:30 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:12 +0530
Subject: [PATCH v6 07/24] migration: Update qemu_file_get_return_path()
 docs and remove dead checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-propagate_tpm_error-v6-7-fef740e15e17@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3725; i=armenon@redhat.com;
 h=from:subject:message-id; bh=XMQupSy2eiojmjsmzqjvvSwAHzmqZOlGldkjbKkKFOw=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adysSJ0jLCr/JCUu4FLpw+IX3XYpc4q5gmyflPJYS1/
 9eYBVzsKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMJHjaxn+CofGCq7qSShQbLnm
 +37lk+aCrAsTbzenHZa3dpLRuZxex8jQcnNH57Yby2TV/jzpX8fz9YvwscDtLzQ36x48plX+TcW
 fGwA=
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

The documentation of qemu_file_get_return_path() states that it can
return NULL on failure. However, a review of the current implementation
reveals that it is guaranteed that it will always succeed and will never
return NULL.

As a result, the NULL checks post calling the function become redundant.
This commit updates the documentation for the function and removes all
NULL checks throughout the migration code.

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
index bef2236799945ed63124b3a41559ca4ab02e094e..96af7b412f2ed43468f4bcac8b833cda223f8321 100644
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


