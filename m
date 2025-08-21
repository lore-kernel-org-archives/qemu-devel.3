Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364D0CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0y4-000790-8k; Thu, 21 Aug 2025 04:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0wf-00042h-8e
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0wb-0001Gi-KM
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755766008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDx1TxydTVZaThhtxRqVTqCB3oMEq2EVEPaa9+iYYzg=;
 b=hZb+MRZ1w+fanft+HFy+aBWDQSndzCvlrpJ3xKTDBesRPubKBqTHBYdW0s1RVRcfkUJn0j
 epy3Yyf2bVP0VX4GtaXZCtRpHlZPKUfi374rbnDgv7rapxw26db+R6m8qUKd5xFBb6aJaL
 K/4gfyXTC/FVgVvU7t1m/m38L97bh2I=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-FdbKQ8QKNsi-jKUW6mnoHA-1; Thu, 21 Aug 2025 04:46:46 -0400
X-MC-Unique: FdbKQ8QKNsi-jKUW6mnoHA-1
X-Mimecast-MFC-AGG-ID: FdbKQ8QKNsi-jKUW6mnoHA_1755766005
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2445806b18aso10210595ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755766005; x=1756370805;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HDx1TxydTVZaThhtxRqVTqCB3oMEq2EVEPaa9+iYYzg=;
 b=H/VL8cKk9EqKeh3D2ihzbbRFy8Gk36/XO4Tzczqg1KmixmWyov9ixAZElkpw4degtJ
 SBYWlxYUsk8Cid8gz3RZWCxfh/y2kG2QNAuxJPYM3M5Egv5T9dA1QZ4YK87NpyEshHvA
 hgHrveOUseBLeOauvfWCq2AnmKx2PtDlaK9HufMbTISeBmkdC4TZOMxW7xH36e65hHb5
 b/uzGiUYy+prn2o48mZbwAxdu4XtWWNhRLtVHVMOUNn9e/UdQV0P1rl6ad/1z73eGPr2
 ry8cefvoifTiG+Bdboh3yE0YylgARcXAqLUwH2Mpk8j9f/2BEl3FrmRoTFcdQrw+JI/J
 7Rcg==
X-Gm-Message-State: AOJu0YydGPZut2UUsTyWydbHzYmARy6LVUUmRLAifmANRRuNOj3WNA3e
 F1EWmEpshyOlv0nw+sVNemltX3xSEaOrk3VZTP/Fdfl6p+rPBoQsLpjHko8/O3QGKyPQg3XaTld
 ie70rgLU5QfwBBtYOAZ65QnhZ12UhBS3kvOtBoAlc1RPsg0S7gOxwjCNq
X-Gm-Gg: ASbGncuC0eNbpgVCkG8xshD/0CnColiSMW2z+IGabQScchUiKu3koV+7ms6uPiwVTb/
 Qa2suNCP0bl9McZm2KDW8Tq3ECs+6ypWtQDM6KNmgwGutA9ZG95uejDkV5sIZmL76VsBGdSA+xs
 tz8yI73z7c7h0MbCeyMifEaCzfoAhAccZVa/5WjQtejiLl+2fs4YV7g/sWjk1CT2HaPQVCxWYSt
 CodN/FmfCDHGepJ7exhlT/fXQT5aXhLKcBWEIdtSS/UrZfJ6EEnOcnfdI2X9oOLzmi3T/d7zaEb
 Rb6Fvsqcv5rWL5uY4wf4WR3G+WakH1n5y3ZKgFBEplEpiISUEvHe
X-Received: by 2002:a17:902:d4c6:b0:23f:ecf6:463b with SMTP id
 d9443c01a7336-245fede2c3cmr25892665ad.45.1755766005405; 
 Thu, 21 Aug 2025 01:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJSyjyTeMOoAHBqrQdA8JNhICa6ztLFiZhLodGzIHVMp83m63LWfi2WqICz54r674NQQMFRQ==
X-Received: by 2002:a17:902:d4c6:b0:23f:ecf6:463b with SMTP id
 d9443c01a7336-245fede2c3cmr25892365ad.45.1755766005027; 
 Thu, 21 Aug 2025 01:46:45 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:46:44 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:14:06 +0530
Subject: [PATCH v12 12/27] migration: Update qemu_file_get_return_path()
 docs and remove dead checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-propagate_tpm_error-v12-12-72b803e707dc@redhat.com>
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
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3908; i=armenon@redhat.com;
 h=from:subject:message-id; bh=pYnktTUH4LvNohxqCio1lE2cWWMEzHkPr3eRbdcNnE8=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayO8nPuTgXlOf8Y9mX0GvQzvdLet7bdt2e/qn3HqW7v
 3+tEp/WUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCKafxn+8NgLmRgZpR0JT8nY
 dKdAdIVVzQEGrVunL0hv0jaqEX81jeEPZ96ZTSqx+d4LZz9jnGF83j/6sbvd3tV/C8+vCYs/+6m
 ZCwA=
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
index 8e0ee14cc86dfffee86e46e32c7500d23924dc8e..2446711e862233801d5689a775517adabec593d9 100644
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
2.50.1


