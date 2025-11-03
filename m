Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051E3CCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lP-0000wn-PJ; Mon, 03 Nov 2025 16:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lM-0000vC-2m
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lF-0005F0-UY
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TTTJ5KkeoKBsc0lcFpyJa0bBEoNg8mBqnoPB7lxFtyI=;
 b=XNobGNJ1InrO9SWMsrSl4Rdd5TJfYZ9A4PrxxhzA/Xn+4gG7y8ONhwWgn8D1973ga+x6GP
 5aeeUxngIrM7pfJqUG4rNNffrGskJ9/oqHF+b/PWcW97FHPXMGkGa6CcLgx0nMY7iATQEs
 7x9USAOCHGmWItHC6vYcuYrQkVNsBqQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-Ll90JzHJMhGez1flJifwaQ-1; Mon, 03 Nov 2025 16:06:41 -0500
X-MC-Unique: Ll90JzHJMhGez1flJifwaQ-1
X-Mimecast-MFC-AGG-ID: Ll90JzHJMhGez1flJifwaQ_1762204000
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8a15d36c209so1307635885a.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204000; x=1762808800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTTJ5KkeoKBsc0lcFpyJa0bBEoNg8mBqnoPB7lxFtyI=;
 b=NVMQZK4Ji+/9UIYTSjDnD75gUrcOHDK9XmNFDxoBkubfpYgoGzjAIfeiaLUA1F/2rs
 KQUbgZklzs21SMivElXslNWiEvRLDqYMWLVlVz1He7vNr20eM7/LKWjhGbtMBlhE/nfi
 brNhjO9ZdCrmtonKJ4Ojw9y/T+2TxH8LCUBbrHRuhsx3DVHVKoj9xicv77sjUWixdyd3
 I+qvMehr0wKHtVZaeEZ1Ba9KNBf7WnpM4Cw4CtECA1M+mj5ojkyLl1Hl5AZ/mqSOEnk1
 8OG22MlYJ2TkrV7r+Tnay0Fz1ytzGyEDpVKhkIj/VOJ6SXQX36FDy1Ko1K634rCadmut
 pkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204000; x=1762808800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTTJ5KkeoKBsc0lcFpyJa0bBEoNg8mBqnoPB7lxFtyI=;
 b=N4KXdRXmFjLEbc0QRXMos55Ky6LhwRdefje7dPjjXfGY23pD5ZFspJxYwonLwtixfz
 xrAOkWfcwef3dJ5wnEQZtlTjvvzsVT5SgWYkWVaV0I/2rKw7XWBYlqM+2b4HcpQTYe2o
 PEd/c5c4JezGB5JB2zftPRsHEpCYd4PWdbzckxZsJiNjWautVhjwgrYrnpM39QxSoNqM
 PGI2ZisrAcLDAqMruliggJ66gNBPru868IKjpvwoV9QxwlFS6/A0vgfXel4It2Pd5E5l
 ambslF1dBm8TZlkc3YHSHOF61O0RqxSKtiqszOYdo4FIhtp7kPEHKMyb56PdEm692ct1
 E/0w==
X-Gm-Message-State: AOJu0YwC5a0+Re1X2oGxBEgwMtKQ/X64q4TAdU38Ku00oxbO04XmqUSN
 7cNya5h9MpdvkeaPuqGxMR6AD1rsHNzf5fLklFuI9MTSmNs5x/X2JRhgrOgUr8Wfam7WodTRphL
 qttq+SxyTyKPIWCgoTEXopN+SxiUlae/SbmOwrB7hjD+9I5d2q1ds2nJJECQMe0JxfJFrxbaCrT
 HCzPT5dbY8UQtkK3u2pW+5vt0ZmlYgz25tVzHsew==
X-Gm-Gg: ASbGncuonqXwTvBpg1yOL7NSf3/nx3yssCVXG+CNbZEhbqV5ML+ijzMpCdVbq6VUeUx
 sEyAyftmxvSsmXgo8YNjnujUH4iLwtLxoxYftJaHq2Isk9yKx+P4nWmhO2659CchtOfohg6V0wl
 S+uHzU6JD9cWvBrbPtD6KMY0trYWaAoNBE+TMLgP64vJslYE9k4pqPNKCM8KPvOfvmSjMSX+wKc
 Up8AfUl7RaGeYBsrENbeD/5mh1DRIjIq498NYCfc5NA0816Y5ukwj2SaeoUFYIX3mIQ+mO6/Y4/
 eU6Y1f6HCrne03t93HrvXAQ7UDwOqlxgmKW63y5EUoCU/GMHxEiqBXpgur3aEi0i
X-Received: by 2002:a05:620a:7118:b0:8a1:94de:cdc4 with SMTP id
 af79cd13be357-8ab9b883c55mr1553940385a.83.1762204000017; 
 Mon, 03 Nov 2025 13:06:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8omSBDjPtGV9JiLFjB11GAK4g1Isibt3VefVL60uUKkJ1DJ7KEOfF+3MBQ7zpOJ/2lYP2Pg==
X-Received: by 2002:a05:620a:7118:b0:8a1:94de:cdc4 with SMTP id
 af79cd13be357-8ab9b883c55mr1553933285a.83.1762203999404; 
 Mon, 03 Nov 2025 13:06:39 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:38 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 08/36] migration/cpr: Fix coverity report in
 cpr_exec_persist_state()
Date: Mon,  3 Nov 2025 16:05:57 -0500
Message-ID: <20251103210625.3689448-9-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

Per reported and analyzed by Peter:

https://lore.kernel.org/r/CAFEAcA_mUQ2NeoguR5efrhw7XYGofnriWEA=+Dg+Ocvyam1wAw@mail.gmail.com

mfd leak is a false positive, try to use a coverity annotation (which I
didn't find manual myself, but still give it a shot).

Fix the other one by capture error if setenv() failed.  When at it, pass
the error to the top (cpr_state_save()).  Along the way, changing all
retval to bool when errp is around.

Resolves: Coverity CID 1641391
Resolves: Coverity CID 1641392
Fixes: efc6587313 ("migration: cpr-exec save and load")
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251021220407.2662288-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/cpr.h |  4 ++--
 migration/cpr-exec.c    | 10 ++++++++--
 migration/cpr.c         | 15 +++++++++------
 migration/migration.c   |  2 +-
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index a412d6663c..027cb98073 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -41,7 +41,7 @@ MigMode cpr_get_incoming_mode(void);
 void cpr_set_incoming_mode(MigMode mode);
 bool cpr_is_incoming(void);
 
-int cpr_state_save(MigrationChannel *channel, Error **errp);
+bool cpr_state_save(MigrationChannel *channel, Error **errp);
 int cpr_state_load(MigrationChannel *channel, Error **errp);
 void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
@@ -56,7 +56,7 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
 void cpr_exec_init(void);
 QEMUFile *cpr_exec_output(Error **errp);
 QEMUFile *cpr_exec_input(Error **errp);
-void cpr_exec_persist_state(QEMUFile *f);
+bool cpr_exec_persist_state(QEMUFile *f, Error **errp);
 bool cpr_exec_has_state(void);
 void cpr_exec_unpersist_state(void);
 void cpr_exec_unpreserve_fds(void);
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index d57714bc5d..087ca94c87 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -40,16 +40,22 @@ static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
     return qemu_file_new_output(ioc);
 }
 
-void cpr_exec_persist_state(QEMUFile *f)
+bool cpr_exec_persist_state(QEMUFile *f, Error **errp)
 {
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
+    /* coverity[leaked_storage] - mfd intentionally kept open across exec() */
     int mfd = dup(fioc->fd);
     char val[16];
 
     /* Remember mfd in environment for post-exec load */
     qemu_clear_cloexec(mfd);
     snprintf(val, sizeof(val), "%d", mfd);
-    g_setenv(CPR_EXEC_STATE_NAME, val, 1);
+    if (!g_setenv(CPR_EXEC_STATE_NAME, val, 1)) {
+        error_setg(errp, "Setting env %s = %s failed", CPR_EXEC_STATE_NAME, val);
+        return false;
+    }
+
+    return true;
 }
 
 static int cpr_exec_find_state(void)
diff --git a/migration/cpr.c b/migration/cpr.c
index 22dbac7c72..adee2a919a 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -176,7 +176,7 @@ bool cpr_is_incoming(void)
     return incoming_mode != MIG_MODE_NONE;
 }
 
-int cpr_state_save(MigrationChannel *channel, Error **errp)
+bool cpr_state_save(MigrationChannel *channel, Error **errp)
 {
     int ret;
     QEMUFile *f;
@@ -190,10 +190,10 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
     } else if (mode == MIG_MODE_CPR_EXEC) {
         f = cpr_exec_output(errp);
     } else {
-        return 0;
+        return true;
     }
     if (!f) {
-        return -1;
+        return false;
     }
 
     qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
@@ -202,11 +202,14 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
     ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0, errp);
     if (ret) {
         qemu_fclose(f);
-        return ret;
+        return false;
     }
 
     if (migrate_mode() == MIG_MODE_CPR_EXEC) {
-        cpr_exec_persist_state(f);
+        if (!cpr_exec_persist_state(f, errp)) {
+            qemu_fclose(f);
+            return false;
+        }
     }
 
     /*
@@ -217,7 +220,7 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
     qio_channel_shutdown(qemu_file_get_ioc(f), QIO_CHANNEL_SHUTDOWN_WRITE,
                          NULL);
     cpr_state_file = f;
-    return 0;
+    return true;
 }
 
 int cpr_state_load(MigrationChannel *channel, Error **errp)
diff --git a/migration/migration.c b/migration/migration.c
index a63b46bbef..c8a5712993 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2301,7 +2301,7 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
-    if (cpr_state_save(cpr_channel, &local_err)) {
+    if (!cpr_state_save(cpr_channel, &local_err)) {
         goto out;
     }
 
-- 
2.50.1


