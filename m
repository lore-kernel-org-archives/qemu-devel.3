Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA65ACCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hu8-0004s9-JM; Fri, 03 Oct 2025 11:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htU-0004kQ-IM
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htF-0007bL-79
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xOHxQFXiSGgokjtDNVvLBGNx2XkLh2I61Euo7oEuFF4=;
 b=e99Mnu+mtHdn1f5JVqk5kvnGZ3KnswngDt53V8PI7WtrKjOhjtwlKHI4dQnRzrc8z2K7iX
 ah2+k+gfY7vqVtdZSSIXsrHdIwLy+sJByVHjDu4rJGguSYnrErBiwO+T4F4GmOsAqMk3r0
 KjRdCxIlBemk6dkNoThgRcY0eCfDeec=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-FT25U9WtPQmzpfrsX7agEA-1; Fri, 03 Oct 2025 11:40:08 -0400
X-MC-Unique: FT25U9WtPQmzpfrsX7agEA-1
X-Mimecast-MFC-AGG-ID: FT25U9WtPQmzpfrsX7agEA_1759506008
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-81a8065daf4so29076286d6.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506007; x=1760110807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xOHxQFXiSGgokjtDNVvLBGNx2XkLh2I61Euo7oEuFF4=;
 b=cgunVFk6gYkJeMFcKihLdJ+uxZXyl41mjzdcUBk1qf6XQOM6VkeH2A1SI1ZvrjNiPV
 vcpKAQ21ZGeqFTjeZkteUugQvoT0sSaWQEHWurCtVFx44kZmo08TGNDITtZbgfYIdjc+
 QfNFxqBnVsDutuDuNaZ1mO9jEnpMBiQ7clvPMic6ruTshKm4JOSGAddRAD6WHK/NFD5J
 4B+he9rk0zX/ELv9knRel2kDdCogLINBN1O911BSV7khTv+aKTa1G14uJtIzpbAqf7lj
 IxBESCBiNH3HmwvtT79cIsormeR803frxttufSceYiTEVtTCjcHKDxnPSqrKOIanbzCR
 qHxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMO0g/eICJFGQ0kk9HUIjDcrcct9wkq+hZbIf9P6LfoN+5zR0LFvsiY0+q8gkYEB1r2Nw6tzuF89v8@nongnu.org
X-Gm-Message-State: AOJu0Yw3a0nZxLVAvLcGP5HtEhM8UpS+oJg5O4mMleIUHd68lqUZ0zc3
 43WtNaGEjvIhvhNQMyLJ+rFd4VHmfxQ90PqO5pme/NiFWWpeweC0Tq4QH4wItRSO9+ofocKeeuV
 1qsKRI5AktPEf0cqZHhpQqedFbtDuPhYtGCMLhfNVNKJvpqmQ3EVu3A56xMKBAFbz
X-Gm-Gg: ASbGncvq3kDjw1mrCM3lgiF7Kfac9PfAGzE17Ao8nzRojEoPYPKiP8IMjsOlCh4Lr96
 3RWzAuRE4cUy0E7ueGy8Kjm7LFVUzziXhAIF40yVY1L6lWLNTJXIJHTyjmV9KuFQ3XiPM3HNrRm
 qPdw0/xYB3VPUn8PlkRw1b5uQOk1JZUFJpuLzDy6r75PufhOXZpxNrhFzxzM2KCBhA1a/kqTJrY
 egHb5jBHY8mOo3Md4KvJ1Q09e7Hy9tCYZF8YXc/MkO7QhnxORU31tL0g/LABa5sIZcZi1V7bDO0
 X8jjWW4Tq1t3xGYKUruzv4x1XVjANQBfbbSMaw==
X-Received: by 2002:a05:6214:40b:b0:817:2871:ae7 with SMTP id
 6a1803df08f44-879dc7e62b6mr51113816d6.23.1759506007314; 
 Fri, 03 Oct 2025 08:40:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZplH4RjIkpwyJfhVwcyb18zK+kNNqqp0q4FlL5/tsBI0Z/bXHNcTPLQcuUlq1O+lhd2Thng==
X-Received: by 2002:a05:6214:40b:b0:817:2871:ae7 with SMTP id
 6a1803df08f44-879dc7e62b6mr51113226d6.23.1759506006732; 
 Fri, 03 Oct 2025 08:40:06 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:06 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 10/45] migration: push Error **errp into
 qemu_loadvm_section_start_full()
Date: Fri,  3 Oct 2025 11:39:13 -0400
Message-ID: <20251003153948.1304776-11-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Arun Menon <armenon@redhat.com>

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that qemu_loadvm_section_start_full() must report an error
in errp, in case of failure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-10-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index f1338f5cf6..83d8fb8f41 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2722,21 +2722,21 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
 }
 
 static int
-qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 {
+    ERRP_GUARD();
     bool trace_downtime = (type == QEMU_VM_SECTION_FULL);
     uint32_t instance_id, version_id, section_id;
     int64_t start_ts, end_ts;
     SaveStateEntry *se;
     char idstr[256];
     int ret;
-    Error *local_err = NULL;
 
     /* Read section start */
     section_id = qemu_get_be32(f);
     if (!qemu_get_counted_string(f, idstr)) {
-        error_report("Unable to read ID string for section %u",
-                     section_id);
+        error_setg(errp, "Unable to read ID string for section %u",
+                   section_id);
         return -EINVAL;
     }
     instance_id = qemu_get_be32(f);
@@ -2744,8 +2744,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read instance/version ID: %d",
-                     __func__, ret);
+        error_setg(errp, "Failed to read instance/version ID: %d", ret);
         return ret;
     }
 
@@ -2754,17 +2753,17 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     /* Find savevm section */
     se = find_se(idstr, instance_id);
     if (se == NULL) {
-        error_report("Unknown savevm section or instance '%s' %"PRIu32". "
-                     "Make sure that your current VM setup matches your "
-                     "saved VM setup, including any hotplugged devices",
-                     idstr, instance_id);
+        error_setg(errp, "Unknown section or instance '%s' %"PRIu32". "
+                   "Make sure that your current VM setup matches your "
+                   "saved VM setup, including any hotplugged devices",
+                   idstr, instance_id);
         return -EINVAL;
     }
 
     /* Validate version */
     if (version_id > se->version_id) {
-        error_report("savevm: unsupported version %d for '%s' v%d",
-                     version_id, idstr, se->version_id);
+        error_setg(errp, "unsupported version %d for '%s' v%d",
+                   version_id, idstr, se->version_id);
         return -EINVAL;
     }
     se->load_version_id = version_id;
@@ -2772,7 +2771,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     /* Validate if it is a device's state */
     if (xen_enabled() && se->is_ram) {
-        error_report("loadvm: %s RAM loading not allowed on Xen", idstr);
+        error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
         return -EINVAL;
     }
 
@@ -2780,11 +2779,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se, &local_err);
+    ret = vmstate_load(f, se, errp);
     if (ret < 0) {
-        error_report("error while loading state for instance 0x%"PRIx32" of"
-                     " device '%s'", instance_id, idstr);
-        error_report_err(local_err);
+        error_prepend(errp,
+                      "error while loading state for instance 0x%"PRIx32" of"
+                      " device '%s': ", instance_id, idstr);
         return ret;
     }
 
@@ -2795,6 +2794,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Section footer error, section_id: %d",
+                   section_id);
         return -EINVAL;
     }
 
@@ -3100,7 +3101,7 @@ retry:
         switch (section_type) {
         case QEMU_VM_SECTION_START:
         case QEMU_VM_SECTION_FULL:
-            ret = qemu_loadvm_section_start_full(f, section_type);
+            ret = qemu_loadvm_section_start_full(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }
-- 
2.50.1


