Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A737D2FED2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCm-0005Lk-Uy; Tue, 27 Jan 2026 13:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBs-0003Fu-BI
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBq-0000qW-2a
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769540005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UzVgFcW6WMbor1W3nR8DZ97qds5M3uYkKxz4VH+bjnA=;
 b=G4swFaLFcoqoP51PmNoexpm6T6xsJXNITz50DOvlGoBGi18ppa8u9a7Fo9VfNdXUcYD+0I
 CKm7L/zySIB29Bn9d9VlYj+bI8ZnxClmMWCzFwy6xchhnSrMJueVt+zSENQ8DDN1iQ7cZg
 GhaZMxPdc3TT2l/Q1zStrPE0aT8deNY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-rfSg46xFNNWq5jeSNw6p1w-1; Tue, 27 Jan 2026 13:53:23 -0500
X-MC-Unique: rfSg46xFNNWq5jeSNw6p1w-1
X-Mimecast-MFC-AGG-ID: rfSg46xFNNWq5jeSNw6p1w_1769540003
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-894a861fd7cso112498216d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769540003; x=1770144803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UzVgFcW6WMbor1W3nR8DZ97qds5M3uYkKxz4VH+bjnA=;
 b=RzWIkCHgLWU6qU1J/3ho6yDePNHSIUqyWV8w1bHdWrepHoieqifqZbR6/JINr8m0zY
 kq6bNY8v3UHSDnJnqk87l4CE/Twe41sy/Lbyq/B03wPTM8KTihZ3ZuZgs7eXcXEH8eLO
 XM7BCGvCZ6LXKn3xCa5SViZYKaAV4bKBNQAqeIkK725q5v48AfNmEtjdmtxH7ILH82g3
 3+CxpYkrIHnPU5roXVKh7Yv+XgVA18dkUictwTDzPOVxc66IJVWTmWKcn9jlRbvo+oZm
 2NpJQhbKHDcYep5+GnSadcEScYCH78HioZ5xsQuamZv4FLqMus7YspIBaSJRD/vf9XGb
 2bkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769540003; x=1770144803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UzVgFcW6WMbor1W3nR8DZ97qds5M3uYkKxz4VH+bjnA=;
 b=JUGLwsO6hCTvOeVj4y70+KVkIoWpt11HRY9Ubxu/w4CMu6YDq2c4KQPrXJPVqiIb3t
 3TjLTQu671zPOoq/QmSmKrBenlsKB0ICseXXoAHXqr6zgpateT+Qxb+RnE2lY51a53JE
 iWy4SsDVq/ah8q4bx5k05eKFxx7DWVEX7KwpIfpmNAOhbvmvIuq2L505oVw2ifBJN8kP
 GquLEyNEqyzyRCvyaAoM9P+crDAj+QIsdrZZ82vj0iy4g8vHOyzr2kt6QwDkvt/VBLrO
 MstBEaswHH+YVvLCtxEyp9h0DSZLCmV0zYKk2DaslUxSFaD+rJ3SU7LHbi13ovShbuGW
 z2WA==
X-Gm-Message-State: AOJu0Yz1s9VO7cnJnCljzTW0OauttQBS/B13Nmtlw9L3eT5YiAQUk38p
 J969SxhmHmHvwENjG23EHxQJbD6ayOx+khMiJRD59BcPDZWKaFPzrW1//yMh95Cq4sLKgpfQ8DW
 mJjtmUrdoqxbXl7u7ru0HFhwzONAp/viozkuC7B1RssLQmveZxG5dr5EdTBlTPb5vhbSXcm0Te3
 mE1aYf2PDyG5xDdVHJ8dyrmkJ2EaxSQetC2WV5Og==
X-Gm-Gg: AZuq6aIzXMKcmgY44G7FBWP2XfGA4nxBi9FhWT2mpKy5vGHsZ13fwS9zE56MdEVADq9
 Z3+nLIQx7BHcOudnmI1uGLOFBbWW56SgUiwF7lqz8kIr3YTILzxf28zWLmCLllNkfYultJgrZrQ
 ftRqWuP6+6ivpBqwefVkQ0WSJoKYTBUXjSHXNpN7GlJZvyswWIAMGb/CpLjcp5DqXOR4AKx83Kz
 C0jCs9CslZYus+/2AjzsVaMiRd+hHBky4yxzh+sx8/0m1Xswwe4C16DBBW/PuDwNLUONhDudjUQ
 Tddn9ea4L46ZCzHALvrsrrtL0G7D7RjNH2aelvjxmlFdNsxVqEsUNt9hOIUS9vrau0A4KdM2nyS
 N
X-Received: by 2002:a05:6214:234c:b0:894:6f32:8f04 with SMTP id
 6a1803df08f44-894cc8bf0aemr36055006d6.42.1769540002706; 
 Tue, 27 Jan 2026 10:53:22 -0800 (PST)
X-Received: by 2002:a05:6214:234c:b0:894:6f32:8f04 with SMTP id
 6a1803df08f44-894cc8bf0aemr36054716d6.42.1769540002172; 
 Tue, 27 Jan 2026 10:53:22 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:21 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 22/24] migration: Make qemu_savevm_state_non_iterable()
 take errp
Date: Tue, 27 Jan 2026 13:52:52 -0500
Message-ID: <20260127185254.3954634-23-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Let the function report errors to upper layers.  Out of three current
users, two of them already process the errors, except one outlier,
qemu_savevm_state_complete_precopy(), where we do it manually for now with
a comment for TODO.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h    |  2 +-
 migration/migration.c |  8 ++++----
 migration/savevm.c    | 13 +++++++------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index f2750eca09..6a589b2990 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -74,7 +74,7 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
-int qemu_savevm_state_non_iterable(QEMUFile *f);
+int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp);
 int qemu_savevm_state_non_iterable_early(QEMUFile *f,
                                          JSONWriter *vmdesc,
                                          Error **errp);
diff --git a/migration/migration.c b/migration/migration.c
index ddf6faab46..22cfa5f19f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2545,9 +2545,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     qemu_savevm_send_postcopy_listen(fb);
 
-    ret = qemu_savevm_state_non_iterable(fb);
+    ret = qemu_savevm_state_non_iterable(fb, errp);
     if (ret) {
-        error_setg(errp, "Postcopy save non-iterable device states failed");
+        error_prepend(errp, "Postcopy save non-iterable states failed: ");
         goto fail_closefb;
     }
 
@@ -3675,8 +3675,8 @@ static void *bg_migration_thread(void *opaque)
         goto fail_with_bql;
     }
 
-    if (qemu_savevm_state_non_iterable(fb)) {
-        error_setg(&local_err, "Failed to save non-iterable devices");
+    if (qemu_savevm_state_non_iterable(fb, &local_err)) {
+        error_prepend(&local_err, "Failed to save non-iterable devices");
         goto fail_with_bql;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index c16951b532..130b9764a7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1710,13 +1710,12 @@ void qemu_savevm_state_end_precopy(MigrationState *s, QEMUFile *f)
     qemu_savevm_state_vm_desc(s, f);
 }
 
-int qemu_savevm_state_non_iterable(QEMUFile *f)
+int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
 {
     MigrationState *ms = migrate_get_current();
     int64_t start_ts_each, end_ts_each;
     JSONWriter *vmdesc = ms->vmdesc;
     SaveStateEntry *se;
-    Error *local_err = NULL;
     int ret;
 
     /* Making sure cpu states are synchronized before saving non-iterable */
@@ -1730,10 +1729,8 @@ int qemu_savevm_state_non_iterable(QEMUFile *f)
 
         start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
 
-        ret = vmstate_save(f, se, vmdesc, &local_err);
+        ret = vmstate_save(f, se, vmdesc, errp);
         if (ret) {
-            migrate_error_propagate(ms, error_copy(local_err));
-            error_report_err(local_err);
             return ret;
         }
 
@@ -1750,6 +1747,7 @@ int qemu_savevm_state_non_iterable(QEMUFile *f)
 int qemu_savevm_state_complete_precopy(MigrationState *s)
 {
     QEMUFile *f = s->to_dst_file;
+    Error *local_err = NULL;
     int ret;
 
     ret = qemu_savevm_state_complete_precopy_iterable(f, false);
@@ -1757,8 +1755,11 @@ int qemu_savevm_state_complete_precopy(MigrationState *s)
         return ret;
     }
 
-    ret = qemu_savevm_state_non_iterable(f);
+    /* TODO: pass error upper */
+    ret = qemu_savevm_state_non_iterable(f, &local_err);
     if (ret) {
+        migrate_error_propagate(s, error_copy(local_err));
+        error_report_err(local_err);
         return ret;
     }
 
-- 
2.50.1


