Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54603CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 16:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwNHI-0003bM-8U; Wed, 10 Sep 2025 12:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwNGs-0003AY-0a
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwNGp-0004Vz-VQ
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757520126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jsJ6uWuRVz9mme6Px6mGxd6bZciJc7GE+WQ3P+OnGj4=;
 b=Oz7tl68GBNbwZmHZcvsGMcyHbToLgLP1neIM8xEhNm0JK9fBIY/J3PeAL3lhDkjbCe7BLW
 58DI2dd2JyLebu+x8XlnDZVi+yhkDGDJ8q0XjqxGRGeWqpTiz/uu1iWSYlKSxDTL9Wq+DH
 z8DGugSKlcscTOUEPP0zZUUSXLImp2M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-hxh20QKjM_alN2jffMYnyQ-1; Wed, 10 Sep 2025 12:02:05 -0400
X-MC-Unique: hxh20QKjM_alN2jffMYnyQ-1
X-Mimecast-MFC-AGG-ID: hxh20QKjM_alN2jffMYnyQ_1757520125
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b47b4d296eso169645701cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 09:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757520124; x=1758124924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jsJ6uWuRVz9mme6Px6mGxd6bZciJc7GE+WQ3P+OnGj4=;
 b=SiGTszDgo0gApfp0nkFnPGRNerU1kAoylUPQjeR7/Kkd6pn3lH/CrdqR3A1wFcj8vi
 IsiSqWSYs073fc5PoBb6Ogk8198QWpWgjJoNwddnqyWcuWfs8deCsWqaEU8/DQlMbcme
 GxwMAqpQY2KnNwUy76jCc1yuJXygzSHUq+Kn2XaffxwqgOCpwDvvT+vcvkl+wX3v0rmo
 +Di/ADWU/MWb0xhb2HYNRxpkd3ttP4HFHceIR+jkSQqDDa1MgnBvcwce2MagcPaHDEZC
 mcpNseGt1J9s1AgOYAKamFD6qOUkiKO4WQ9a6KU2UVgtXG3Lx8Y8B1654AEm+vaT7xLn
 rJGQ==
X-Gm-Message-State: AOJu0Yyw6zITtxHJcMWE/R+1HJmMotd0gmRpS9Vyb01py3Ibttk4iLy/
 WTTZ89SJ8hnQ+t20icqviLJxhm1q8iezl1TcgZYsZeMIZs5taxfH2mP+7jYL06Aaby7YfOx/f2o
 nMbJmwfC0Gku4yIoxtuC7dullMhGThW9Gz1aNn0HIkSrFbjf07eINa5ob4oMBpg93m9+Ghx08NW
 PzBTwB3X84Dufemg34kgPdO5itNX/51rmZ32OjWw==
X-Gm-Gg: ASbGnctNnwDOeb2hJ1EmyWcKqUEH5YRYii9lDkln2vBuXF8gwbvlfMLezzCmDD5VHhv
 W2WUmeAJVfybqhvOYBJLObopz61Oy7Co9xtLbozHid/F9ZPn8ZWZOdnQyGgxKMJsy5spdiyosM8
 McnEKQg24XhQefATrI1TFiksAyrpY4D+9ZQyajf5Qi/ZKceI0+PTSULJbgRAQ3mxdOEAWL4KudZ
 9sEc0idriprp0NCeYuFQRYqeOSvj64e3XmvEeKwILdkri+xBxDeIUm4Mmkj8sWnHueMtzVnxCf0
 wFxajVvEb0Jd7Vnpkvo/CBzK0FtwDg==
X-Received: by 2002:a05:622a:5e0e:b0:4b6:144:faf3 with SMTP id
 d75a77b69052e-4b60144fc88mr98421271cf.30.1757520124049; 
 Wed, 10 Sep 2025 09:02:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5R2jBx42YgW4YgzFXkBFBkE3E17Jp840MW0gjhmmebGf2ZG0Jp9VZPOeQNkn4E37F0QmiOA==
X-Received: by 2002:a05:622a:5e0e:b0:4b6:144:faf3 with SMTP id
 d75a77b69052e-4b60144fc88mr98420631cf.30.1757520123086; 
 Wed, 10 Sep 2025 09:02:03 -0700 (PDT)
Received: from x1.com ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b61bbe0a85sm26655281cf.42.2025.09.10.09.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 09:02:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 3/3] migration/multifd: Use the new graceful termination helper
Date: Wed, 10 Sep 2025 12:01:44 -0400
Message-ID: <20250910160144.1762894-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250910160144.1762894-1-peterx@redhat.com>
References: <20250910160144.1762894-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Multifd has a separate loop to do TLS terminations gracefully.  Meanwhile,
it depends on two variables which records thread creations.

It works perfectly before, however relying on "whether some threads are
created" flag might be not as straightforward to decide a graceful
shutdown.

Since we'll need to dynamically identify TLS channels anyway with the new
helper (which is needed for main and postcopy channels), use the same
simple API for multifd channels too.  Also, we only need graceful shutdown
on success of migrations.

With that, we can remove the loop and drop migration_tls_channel_end().

The comment there is still a good explanation, move it over to the new
helper instead.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/tls.h     |  1 -
 migration/channel.c |  7 +++++++
 migration/multifd.c | 40 +++++++---------------------------------
 migration/tls.c     |  5 -----
 4 files changed, 14 insertions(+), 39 deletions(-)

diff --git a/migration/tls.h b/migration/tls.h
index 58b25e1228..75c918e156 100644
--- a/migration/tls.h
+++ b/migration/tls.h
@@ -36,7 +36,6 @@ void migration_tls_channel_connect(MigrationState *s,
                                    QIOChannel *ioc,
                                    const char *hostname,
                                    Error **errp);
-void migration_tls_channel_end(QIOChannel *ioc, Error **errp);
 /* Whether the QIO channel requires further TLS handshake? */
 bool migrate_channel_requires_tls_upgrade(QIOChannel *ioc);
 
diff --git a/migration/channel.c b/migration/channel.c
index 1ae839e5fe..a481b45eae 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -153,6 +153,13 @@ int migration_channel_read_peek(QIOChannel *ioc,
 bool migration_channel_shutdown_gracefully(QIOChannel *c, Error **errp)
 {
     if (object_dynamic_cast((Object *)c, TYPE_QIO_CHANNEL_TLS)) {
+        /*
+         * The destination expects the TLS session to always be properly
+         * terminated. This helps to detect a premature termination in the
+         * middle of the stream.  Note that older QEMUs always break the
+         * connection on the source and the destination always sees
+         * GNUTLS_E_PREMATURE_TERMINATION.
+         */
         qio_channel_tls_bye(QIO_CHANNEL_TLS(c), errp);
     }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index b255778855..cb0262076b 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -439,7 +439,7 @@ static void multifd_send_set_error(Error *err)
     }
 }
 
-static void multifd_send_terminate_threads(void)
+static void multifd_send_terminate_threads(bool succeeded)
 {
     int i;
 
@@ -460,6 +460,9 @@ static void multifd_send_terminate_threads(void)
 
         qemu_sem_post(&p->sem);
         if (p->c) {
+            if (succeeded) {
+                migration_channel_shutdown_gracefully(p->c, &error_warn);
+            }
             qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
         }
     }
@@ -541,50 +544,21 @@ static void multifd_send_cleanup_state(void)
 
 void multifd_send_shutdown(void)
 {
+    MigrationState *s = migrate_get_current();
     int i;
 
     if (!migrate_multifd()) {
         return;
     }
 
-    for (i = 0; i < migrate_multifd_channels(); i++) {
-        MultiFDSendParams *p = &multifd_send_state->params[i];
-
-        /* thread_created implies the TLS handshake has succeeded */
-        if (p->tls_thread_created && p->thread_created) {
-            Error *local_err = NULL;
-            /*
-             * The destination expects the TLS session to always be
-             * properly terminated. This helps to detect a premature
-             * termination in the middle of the stream.  Note that
-             * older QEMUs always break the connection on the source
-             * and the destination always sees
-             * GNUTLS_E_PREMATURE_TERMINATION.
-             */
-            migration_tls_channel_end(p->c, &local_err);
-
-            /*
-             * The above can return an error in case the migration has
-             * already failed. If the migration succeeded, errors are
-             * not expected but there's no need to kill the source.
-             */
-            if (local_err && !migration_has_failed(migrate_get_current())) {
-                warn_report(
-                    "multifd_send_%d: Failed to terminate TLS connection: %s",
-                    p->id, error_get_pretty(local_err));
-                break;
-            }
-        }
-    }
-
-    multifd_send_terminate_threads();
+    multifd_send_terminate_threads(!migration_has_failed(s));
 
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
         Error *local_err = NULL;
 
         if (!multifd_send_cleanup_channel(p, &local_err)) {
-            migrate_set_error(migrate_get_current(), local_err);
+            migrate_set_error(s, local_err);
             error_free(local_err);
         }
     }
diff --git a/migration/tls.c b/migration/tls.c
index 284a6194b2..ca1595e05d 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -165,11 +165,6 @@ void migration_tls_channel_connect(MigrationState *s,
                               NULL);
 }
 
-void migration_tls_channel_end(QIOChannel *ioc, Error **errp)
-{
-    qio_channel_tls_bye(QIO_CHANNEL_TLS(ioc), errp);
-}
-
 bool migrate_channel_requires_tls_upgrade(QIOChannel *ioc)
 {
     if (!migrate_tls()) {
-- 
2.50.1


