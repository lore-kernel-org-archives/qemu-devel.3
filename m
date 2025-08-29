Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EACCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNf1-0005GU-Aa; Sat, 30 Aug 2025 11:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5Lr-0005mM-Rf
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5Lm-0004yb-Pi
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756497922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jz5BpGNEzo/txk0fwJKaeZgorVoPWniz9Wyv+M1UrT0=;
 b=K1GfM0gm3be9PQpteR1pATKumhVvtrv7Xcf+TZf49QAF6HCEBn7LbkVppVs37djqQk6ixG
 jk5ec40hBrrvd7p5NBXGdOU5JwfjyK/6/UJx7QWyQdXbvvqbrBkVGTKc+rvb9EprxmXoiV
 0bBjeZtJnQUD9aSLTCR6NZCxTl5/bro=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-Wmpla72iOWOyYRB54y1eeQ-1; Fri, 29 Aug 2025 16:05:21 -0400
X-MC-Unique: Wmpla72iOWOyYRB54y1eeQ-1
X-Mimecast-MFC-AGG-ID: Wmpla72iOWOyYRB54y1eeQ_1756497920
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-327b289e8easo2185052a91.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756497920; x=1757102720;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jz5BpGNEzo/txk0fwJKaeZgorVoPWniz9Wyv+M1UrT0=;
 b=GDvJInb2BxYHcWcCCIZ+kQsqQIVLP/afOVImqIkLLuTThJU8mhnwNnhOvmk21zOZl+
 Z3+/MLE+MGKiSMvcvcp4Odf61FnogbZTE74uQ1DIhoM1QRChX3swZZ/MxXhVOKZ+++jD
 zmmY6HwwT6ju+P8MIBsU+ECG6aWaT8fg1DkL+IG/Sz8kyXho3Gax1vhkZyNGNpA2i17W
 Y5wPSi9AbFeXUpeFUd5V6sGZadO0J3WUSx2wu8PzfSHcvowlXU0x56mHhySvWi+PgTxh
 QAJgPbkAVmO3LLKY1a4RzpvPKGnFvSNecRNC6LbSTfQiQEqm8b1SvVA+hRP1EsnELBgn
 v9ew==
X-Gm-Message-State: AOJu0YyeO9bYpfFgjlG8xYSC+FbBNK8fm9E3G2GQ7Siry8KoSb0fBvkG
 EjZ6mH4FQY7pq/hVReFpQMbzwaTQnY1unaku+4RkeaswkInzFlN/1tVAhJDGjjrX86n1AgRY5kg
 IjRrXzPRokGb/aOM/QJ+TCNdmCzThszPKSmlJfCtbOt3mRpRzW2j7yMjQ
X-Gm-Gg: ASbGncss0XWb/dUENEWNvf7Xq1AKQ7hhLOAiMWQfw96KhpPq/bRvyuDnXLAkF6nbZxC
 fsdjhd64SvFJPVdfOTKTxWYlHYOH+3TptT+jQ7DHb00hjpFj10ra/p6WTbaZavUagQIbEsGHZTZ
 pw4RCvUq3V0X+fefB7kYAkWZs+IXEaEosLtw6DGuJp076KCZiYjKP2zOYQfqJKjYeEo/PKxsctv
 /D/+jaPbVzXWUY5P+6OfkwggGTTWT3E61wf4U7na/8HdgI7Kb0gmHU5deBoc2dnCoUyY+egKT24
 O7EItFu5hAf7cKBShzWDuqSobpOGxSMx/VkJ/y3bxAML33NELiK7Tw==
X-Received: by 2002:a17:90b:4e87:b0:327:734a:ae8c with SMTP id
 98e67ed59e1d1-327734aafacmr14669209a91.10.1756497920005; 
 Fri, 29 Aug 2025 13:05:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGN3T+VDS5qm4suy07Tcc7/56fOvY6Eok6DyW8tUvsG7+AKLnAHJmdWajntXIIPDS6fyOrBQ==
X-Received: by 2002:a17:90b:4e87:b0:327:734a:ae8c with SMTP id
 98e67ed59e1d1-327734aafacmr14669147a91.10.1756497919518; 
 Fri, 29 Aug 2025 13:05:19 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:05:19 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Sat, 30 Aug 2025 01:31:52 +0530
Subject: [PATCH v13 12/27] migration: Update qemu_file_get_return_path()
 docs and remove dead checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250830-propagate_tpm_error-v13-12-a4e777b7eb2c@redhat.com>
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
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3908; i=armenon@redhat.com;
 h=from:subject:message-id; bh=2JbqiM5+ARKDi5QVvK8q/nOAQN+0N3zVUkcy/4NxTCk=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8Ymdl+nNUarONy0uT7ffHfa1Sek5FlqeNz5PrcQ0/9cA
 f5V1RwdpSwMYlwMsmKKLA1fA2SbAgojIm1fXoeZw8oEMoSBi1MAJpLzj5Hh4bP08qCbLTcOtzuZ
 zinYc0jwoOGhr7LPnmV8rlj0b8oNXUaGwwl7/gbI7LziEXrvXQbjYYniHc7P5Xo3nnVy3el6a89
 LTgA=
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

The documentation of qemu_file_get_return_path() states that it can
return NULL on failure. However, a review of the current implementation
reveals that it is guaranteed that it will always succeed and will never
return NULL.

As a result, the NULL checks post calling the function become redundant.
This commit updates the documentation for the function and removes all
NULL checks throughout the migration code.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c      |  4 ----
 migration/migration.c | 12 ++----------
 migration/qemu-file.c |  1 -
 migration/savevm.c    |  4 ----
 4 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 642d17487d92c0a9508e599ca3bf524e80b6fd46..07a32044b58541eb9bd7c5e63eb6ca598f8a8933 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -847,10 +847,6 @@ static void *colo_process_incoming_thread(void *opaque)
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
index c6768d88f45c870c7fad9b9957300766ff69effc..35f769bc55c235134abb5554ed01b94787d4bf78 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2647,12 +2647,9 @@ out:
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
 
@@ -2661,8 +2658,6 @@ static int open_return_path_on_source(MigrationState *ms)
     ms->rp_state.rp_thread_created = true;
 
     trace_open_return_path_on_source_continue();
-
-    return 0;
 }
 
 /* Return true if error detected, or false otherwise */
@@ -4011,10 +4006,7 @@ void migration_connect(MigrationState *s, Error *error_in)
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
index c8234f2ef7f413b207aebae7192c82f1f4d6d91d..d54028b1be4d7a1e4615c2b05611535bd7478e2b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2588,10 +2588,6 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
             return 0;
         }
         mis->to_src_file = qemu_file_get_return_path(f);
-        if (!mis->to_src_file) {
-            error_setg(errp, "CMD_OPEN_RETURN_PATH failed");
-            return -1;
-        }
 
         /*
          * Switchover ack is enabled but no device uses it, so send an ACK to

-- 
2.51.0


