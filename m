Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05263D2FED2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCo-0005Wd-Fy; Tue, 27 Jan 2026 13:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBp-0003FH-58
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBn-0000oE-0E
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769540002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r5tMYOv+4JK4eT6CrqSaDeE9RQFeH3UxvgkGd+VWeXg=;
 b=fSSbL6+EF6zB3sbHQHJHMHFCpOZBzjX7ED0e6hY3EtSJzSaFCgZnHNS6+O6VAkNU8Qt3Mh
 theS/6Im8UQ3uCiMReV09G1s5axrUMVfbIkCHQWOrFhOTMG5n68oEfI2i8sQBELAd3NW9K
 kk6XffSVbfqSRcrQmB+c6w75Ex46qjk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-pBBIY3ggM9a8cCzUs_v68A-1; Tue, 27 Jan 2026 13:53:21 -0500
X-MC-Unique: pBBIY3ggM9a8cCzUs_v68A-1
X-Mimecast-MFC-AGG-ID: pBBIY3ggM9a8cCzUs_v68A_1769540001
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c6a87029b6so1939555485a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769540000; x=1770144800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5tMYOv+4JK4eT6CrqSaDeE9RQFeH3UxvgkGd+VWeXg=;
 b=pcrfCYDPGy0PBhMxV0apXwxg9/qX5LDzZdkLnEnGVVdwTm5ZjyOpvBPwXxo4DEeQN6
 8JAo2IgrDr/XqN8kqQ5YmKo7DGEjUge1/bQ8A4NpIb/RANWpYuvu0C8S+IUMLLge63Ck
 +4si5FTuqgjm8AIKke3WM7aefHVjDGp+n8pQjwPPsNvIgltcCJG+aJUr0Q7vaRhy08OV
 V18WBP5Ozed9V+e2ZbOMDffkAXjwoy0B3YqOl3Ypika98HSxvwbbKdR8gl1jza5KVuhQ
 I1N/fTXLMHgOLKBNmZORAew/IA77e44P4EwPJ0nrRWWXZeWZkLPZAHum6PnzhQvC9tFF
 I5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769540000; x=1770144800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r5tMYOv+4JK4eT6CrqSaDeE9RQFeH3UxvgkGd+VWeXg=;
 b=lLT6nBVDZGfBkUn5giYvE5+TyDS6Y8qC1pylTDjALnCBmCplx2z5TwxvFI5HG4veXW
 eiTEwEmr1VO5dYFmVNKfhwKBq0eb1y9pHh0wElcllqwfcKTUBb6Sk+nfhsgQGE/h6fUD
 lMMLSS/Cm17XIPnaI3+h52iUgY8tL2U5VKtfo5h/FvQj+2n5nVKdI6hwdaHXb1yyxgH1
 3Novs2+WV+GCNKzrcXBbHAKwG5TPrd9VZ2/JNpc2fZi5tPzwktmcfFQ4eEEupnGCh1R/
 ZVf6JUMozWX+XOzy9TEtJP/N498hVAvIuu+pb4Hucy2/y74YuC/SwEv3eSlG0a8SsMI5
 UpxQ==
X-Gm-Message-State: AOJu0Ywb6jlTgQ1apLsbGz3ghxgw3LbXYafoAPx1Zpd4/jFYtc/e3xxE
 Ft7C85nNnKoJ4DASo04piVTAmkKnrE20NpA6HQ786RHVW7/bVQYqtD8cNsOkin67lzh4IbJvwd3
 SeCKvyXL4+v64H8CYEYB7a50zygQf/NSf5DgbNfwjEquu5NNqrFsfoPmYSAyZmmhRH+p1/KFqv3
 yUgVVBhz05QOn6pdApXwSEUdxUgHmB3QMZzhZdFw==
X-Gm-Gg: AZuq6aL7HErZUNJLmMgDSA3beAovqUf8dFRbVBQ1aqMFQ8BaGM3mWfWipGFf75GRf67
 8QtmOiYoWgjiVMn5oplNdtjptULb3YcQR1qih9Vu5DFUZoppFmJfwmJ4IuS/OoPlnawI1TrJLSY
 PUTvbabsitN6/3aHCAR5U34OEkISup35bfAn58A12bDw1wAENbfBxdf1Fj8eOdbcaAJZDEd5MGL
 SBqxmo83V2WzgfxZKlt3WTdhs4RYu2JZzwS8Y3Y+NH6tkXVDzwmFPNQrWcpBeXOyYps8aqLsIrc
 xFpTdbBG9qzx3/GMjxGqsYCBp5xjeCFj18Km4rP6n6TqJ8IkXi9oCorqjtB4caCIoRxtv6atY0o
 i
X-Received: by 2002:a05:620a:2886:b0:8c6:e8f6:2c7 with SMTP id
 af79cd13be357-8c70b8858b5mr354679385a.38.1769540000404; 
 Tue, 27 Jan 2026 10:53:20 -0800 (PST)
X-Received: by 2002:a05:620a:2886:b0:8c6:e8f6:2c7 with SMTP id
 af79cd13be357-8c70b8858b5mr354675285a.38.1769539999897; 
 Tue, 27 Jan 2026 10:53:19 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:19 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 20/24] migration: Introduce qemu_savevm_state_active()
Date: Tue, 27 Jan 2026 13:52:50 -0500
Message-ID: <20260127185254.3954634-21-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce this helper to detect if a SaveStateEntry is active.

Note that this helper can actually also be used in loadvm paths, but let's
stick with this name for now because we still use SaveStateEntry for the
shared structure that both savevm/loadvm uses, where this name still suites.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 63 ++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index b04a21ffc9..c16951b532 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1071,6 +1071,16 @@ void qemu_savevm_state_end(QEMUFile *f)
     qemu_put_byte(f, QEMU_VM_EOF);
 }
 
+static inline bool qemu_savevm_state_active(SaveStateEntry *se)
+{
+    /* When no is_active() hook, always treat it as ACTIVE */
+    if (!se->ops->is_active) {
+        return true;
+    }
+
+    return se->ops->is_active(se->opaque);
+}
+
 /**
  * qemu_savevm_command_send: Send a 'QEMU_VM_COMMAND' type element with the
  *                           command and associated data.
@@ -1352,12 +1362,9 @@ int qemu_savevm_state_prepare(Error **errp)
         if (!se->ops || !se->ops->save_prepare) {
             continue;
         }
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
+        if (!qemu_savevm_state_active(se)) {
+            continue;
         }
-
         ret = se->ops->save_prepare(se->opaque, errp);
         if (ret < 0) {
             return ret;
@@ -1397,10 +1404,8 @@ static int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
         if (!se->ops || !se->ops->save_setup) {
             continue;
         }
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
+        if (!qemu_savevm_state_active(se)) {
+            continue;
         }
         save_section_header(f, se, QEMU_VM_SECTION_START);
         ret = se->ops->save_setup(f, se->opaque, errp);
@@ -1450,10 +1455,8 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
         if (!se->ops || !se->ops->resume_prepare) {
             continue;
         }
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
+        if (!qemu_savevm_state_active(se)) {
+            continue;
         }
         ret = se->ops->resume_prepare(s, se->opaque);
         if (ret < 0) {
@@ -1481,8 +1484,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
         if (!se->ops || !se->ops->save_live_iterate) {
             continue;
         }
-        if (se->ops->is_active &&
-            !se->ops->is_active(se->opaque)) {
+        if (!qemu_savevm_state_active(se)) {
             continue;
         }
         if (se->ops->is_active_iterate &&
@@ -1543,10 +1545,8 @@ static int qemu_savevm_complete(SaveStateEntry *se, QEMUFile *f)
 {
     int ret;
 
-    if (se->ops->is_active) {
-        if (!se->ops->is_active(se->opaque)) {
-            return 0;
-        }
+    if (!qemu_savevm_state_active(se)) {
+        return 0;
     }
 
     trace_savevm_section_start(se->idstr, se->section_id);
@@ -1596,10 +1596,8 @@ bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp)
             continue;
         }
 
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
+        if (!qemu_savevm_state_active(se)) {
+            continue;
         }
 
         trace_savevm_section_start(se->idstr, se->section_id);
@@ -1785,10 +1783,8 @@ void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
         if (!se->ops || !se->ops->state_pending_estimate) {
             continue;
         }
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
+        if (!qemu_savevm_state_active(se)) {
+            continue;
         }
         se->ops->state_pending_estimate(se->opaque, must_precopy, can_postcopy);
     }
@@ -1806,10 +1802,8 @@ void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
         if (!se->ops || !se->ops->state_pending_exact) {
             continue;
         }
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
+        if (!qemu_savevm_state_active(se)) {
+            continue;
         }
         se->ops->state_pending_exact(se->opaque, must_precopy, can_postcopy);
     }
@@ -2829,12 +2823,9 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
         if (!se->ops || !se->ops->load_setup) {
             continue;
         }
-        if (se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
+        if (!qemu_savevm_state_active(se)) {
+            continue;
         }
-
         ret = se->ops->load_setup(f, se->opaque, errp);
         if (ret < 0) {
             error_prepend(errp, "Load state of device %s failed: ",
-- 
2.50.1


