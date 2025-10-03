Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77FDCCD182
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hup-0005Os-Vf; Fri, 03 Oct 2025 11:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htu-0004qU-Eh
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htQ-0007dV-G6
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5MLNi3k2lZmxwkmVReYycziCEVrRVDLkoTQAQ0cj1BI=;
 b=NlR5Zumr/sT9JdwRlOVH/0Z2J9A1BiyFxG3sduXlhycbROZaTxHPdSgB/QLrhsYCjqkSI8
 s62HPJryL/ggISSWcepZb3tc09/MWqqgfXsoxfbTNOC/OAYiElhWa3Z58bIgP/3aLSCStp
 OrbAr8henG3vdjNsD9xJpTXUfXKTmYY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-VSYRX6_hPl-4VHQaaxEOtQ-1; Fri, 03 Oct 2025 11:40:15 -0400
X-MC-Unique: VSYRX6_hPl-4VHQaaxEOtQ-1
X-Mimecast-MFC-AGG-ID: VSYRX6_hPl-4VHQaaxEOtQ_1759506015
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4d9ec6e592bso43616661cf.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506015; x=1760110815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5MLNi3k2lZmxwkmVReYycziCEVrRVDLkoTQAQ0cj1BI=;
 b=ivDgufHWBq5dNakgBPHx0kNqUo2DFa7/3sZakmrNrwv4sZJTQf9uaAUpujDLMBTL5m
 SBbLmvURqR0B7v8hR2zcx7Sx90XggHbBuOV+qR2CqjnqUrI1jS8KieMImaISpdcA0y1J
 ujhQHJABk0qg0/76LJM/nIZ5A9Tz7d1YO27VT9anDi4iSwYYJGAT/eTJATHxpN68UuJ6
 Vvj1E7JmyMCO/xfSzrPUk/0d3Hl4S1flNCcYD2nWB+LIuo7vDhPuU3YRvGWUMvYxjvru
 5NpdD9lf7MywfC+gqjXrRI9GEY9PvSzyzumTDssKJIkMnr7OpfMCks651opWSf7wcaTZ
 RKNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWmHcpSnoLnbdMqTW+3slcLOCGQWaS1vVA/wSy4fxbXi367PH/TgMW9zZloe4x2tHsBbLn8XZOiEeS@nongnu.org
X-Gm-Message-State: AOJu0YxQSgN7fNTzp3apfciOuLeh3r8i+sG5lVx2dlsJvdfoBgpPPYfQ
 nXyf0uD0pzFdsLsPFQwilPBNZ+GXjKyebUVKEvyU9f75dgWMroXo8JA+FJr4mfdAm9VTQWl0PJt
 REqa6owbjIKyuQGnaALVvh64yoVqa5NpDaAni6+iSmxf4Kzw+eGBCAtRc
X-Gm-Gg: ASbGncsvaihK8IQWCf2vPiM6jODfatMalyvKB9JB5sf56NR+Zuhbm2FmlZJgcY+LMZl
 QyegemjP7zWYL168HTOZKVZr/DCGzYZ1MURQ971XzN5uNbTMBXYzFm/WzeBSj1TNrb+yYtn4rEA
 upvdUNdg6O6pJNW2jlCtkWPzcEWJ1tpJuW1+QmhvdR/mB3xl9+1yxBehMHa4N+BPO7jdzatp+Cp
 ZhtABl4tM/cEbz4WIMzP+AKU+atTsYdRLMw+6JUSJpX9WOzHeTT3IJM0Moo3SM0MpVIkRHKEIYO
 p28MusKIfaSP5pupsGov4P862i0gLWSZZUemxg==
X-Received: by 2002:a05:622a:5989:b0:4df:6b24:ebee with SMTP id
 d75a77b69052e-4e576b13f95mr49105571cf.58.1759506015166; 
 Fri, 03 Oct 2025 08:40:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9Gb7Y52hF5+zywJuB1cY0Q3Dhisu61bcjWhg/GNZWrj1uLU6Hy2gSUh0EWPZOr9qfvK2DRQ==
X-Received: by 2002:a05:622a:5989:b0:4df:6b24:ebee with SMTP id
 d75a77b69052e-4e576b13f95mr49104781cf.58.1759506014453; 
 Fri, 03 Oct 2025 08:40:14 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 15/45] migration: push Error **errp into
 loadvm_postcopy_handle_advise()
Date: Fri,  3 Oct 2025 11:39:18 -0400
Message-ID: <20251003153948.1304776-16-peterx@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
It is ensured that loadvm_postcopy_handle_advise() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-15-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 338d1a9756..38e22b435b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1912,39 +1912,39 @@ enum LoadVMExitCodes {
  * quickly.
  */
 static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
-                                         uint16_t len)
+                                         uint16_t len, Error **errp)
 {
     PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
     uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps;
     size_t page_size = qemu_target_page_size();
-    Error *local_err = NULL;
 
     trace_loadvm_postcopy_handle_advise();
     if (ps != POSTCOPY_INCOMING_NONE) {
-        error_report("CMD_POSTCOPY_ADVISE in wrong postcopy state (%d)", ps);
+        error_setg(errp, "CMD_POSTCOPY_ADVISE in wrong postcopy state (%d)",
+                   ps);
         return -1;
     }
 
     switch (len) {
     case 0:
         if (migrate_postcopy_ram()) {
-            error_report("RAM postcopy is enabled but have 0 byte advise");
+            error_setg(errp, "RAM postcopy is enabled but have 0 byte advise");
             return -EINVAL;
         }
         return 0;
     case 8 + 8:
         if (!migrate_postcopy_ram()) {
-            error_report("RAM postcopy is disabled but have 16 byte advise");
+            error_setg(errp,
+                       "RAM postcopy is disabled but have 16 byte advise");
             return -EINVAL;
         }
         break;
     default:
-        error_report("CMD_POSTCOPY_ADVISE invalid length (%d)", len);
+        error_setg(errp, "CMD_POSTCOPY_ADVISE invalid length (%d)", len);
         return -EINVAL;
     }
 
-    if (!postcopy_ram_supported_by_host(mis, &local_err)) {
-        error_report_err(local_err);
+    if (!postcopy_ram_supported_by_host(mis, errp)) {
         postcopy_state_set(POSTCOPY_INCOMING_NONE);
         return -1;
     }
@@ -1967,9 +1967,10 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
          *      also fails when passed to an older qemu that doesn't
          *      do huge pages.
          */
-        error_report("Postcopy needs matching RAM page sizes (s=%" PRIx64
-                                                             " d=%" PRIx64 ")",
-                     remote_pagesize_summary, local_pagesize_summary);
+        error_setg(errp,
+                   "Postcopy needs matching RAM page sizes "
+                   "(s=%" PRIx64 " d=%" PRIx64 ")",
+                   remote_pagesize_summary, local_pagesize_summary);
         return -1;
     }
 
@@ -1979,17 +1980,18 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
          * Again, some differences could be dealt with, but for now keep it
          * simple.
          */
-        error_report("Postcopy needs matching target page sizes (s=%d d=%zd)",
-                     (int)remote_tps, page_size);
+        error_setg(errp,
+                   "Postcopy needs matching target page sizes (s=%d d=%zd)",
+                   (int)remote_tps, page_size);
         return -1;
     }
 
-    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, &local_err)) {
-        error_report_err(local_err);
+    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, errp)) {
         return -1;
     }
 
-    if (ram_postcopy_incoming_init(mis, NULL) < 0) {
+    if (ram_postcopy_incoming_init(mis, errp) < 0) {
+        error_prepend(errp, "Postcopy RAM incoming init failed: ");
         return -1;
     }
 
@@ -2617,11 +2619,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_handle_cmd_packaged(mis, errp);
 
     case MIG_CMD_POSTCOPY_ADVISE:
-        ret = loadvm_postcopy_handle_advise(mis, len);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_advise(mis, len, errp);
 
     case MIG_CMD_POSTCOPY_LISTEN:
         ret = loadvm_postcopy_handle_listen(mis);
-- 
2.50.1


