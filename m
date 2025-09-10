Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8421CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 16:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwNHD-0003VK-Mo; Wed, 10 Sep 2025 12:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwNGr-0003AO-Nj
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwNGp-0004Vc-2w
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757520123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8p45ZSRefEV6HYOFhbXSS9og5rhg3/fjfKNb+/N5nuk=;
 b=ddM4K+0e3x7quWbroo5TyWEBD/IpyL5cDSWCzMuwfGkb5AYper1N9pT7tRN8rgDgozbqEV
 03Ufwn7dEL44FGQp5XVLDizd8L4tHrPwqNzFkNCksdpoG1cJfpeG8nqmCVNsSeJ0BUYApR
 OG/EBGdBw4DTQp0RezJPH6JpCjWSkX4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-1EeEGBzkPLqts47_5pHr8Q-1; Wed, 10 Sep 2025 12:02:01 -0400
X-MC-Unique: 1EeEGBzkPLqts47_5pHr8Q-1
X-Mimecast-MFC-AGG-ID: 1EeEGBzkPLqts47_5pHr8Q_1757520121
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7fff4abc97cso1772649985a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 09:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757520120; x=1758124920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8p45ZSRefEV6HYOFhbXSS9og5rhg3/fjfKNb+/N5nuk=;
 b=uJ/Vu5MyEL+h8AcmV8duV/abWSEi1jFJ9ivAeEPtmwB7wgQkTL/MClgzMTnGYNgtPG
 JYIDAg1DLY/ZosDF7sqZkZGu+BYQXwd2DW/Q9ytPpW3Pdbap64lbsVDR/bQysfqm53sM
 laXUovdlzTkJrYPIVRTZCiLr9JpsMD8JTIRLc4mgh4nzbnPNUJWWQ74RBfFE2wKY/Hrz
 ZWj5njNZqSLkaL368/dJt/mSefk+PQkILVQVDVyjQh6CLIfeYlilKPMo33rafUcpxd4U
 8RICv7Z4Gd2YfDhB/m2PNqbrw792IIrczHlXiTaxc/zOBrvHUxik0eugiYPgLZfFdsEt
 HW3Q==
X-Gm-Message-State: AOJu0YzR6zi94IDd8Ig+/FCY5MDz6EV7GCgcY3QdK9Al0epm4qiNgsQ4
 gfBZEcdeS8lFyH9y4SivdskORA6KaPFH0cNDoSkzlCXbOnklr97NNr5Gg6/DYJhY+41ZJwMsFwl
 bNtDJynq4FiSPy2mKKGdNI9u6S3ohditfCXoAqS4GebDwUExCBaRMeZE2OsUtV2Elp77R0v/14t
 5yIIY0mSwUAfJ0OVKgz1zmALCMVGGdWUgIe9KSjA==
X-Gm-Gg: ASbGncv+umYukGBxLfx+LjSBM3dt6aHinKJIiCqyXyXej7zUfQ6XVfOM6kubSwqyB9f
 PTUhMAej1vKcSDkieIQ53cIN5gStr8raYptM5q13qal22T40z1Dg0jsfn4t8+XSdGlcnI/5NGkJ
 /JmTey0iQc55dJnhWqnbI5C5xU2kc1JOFExU1jq6OqVke/K9rRJi/UJd9LtcWo4LVq8HaPzY6ta
 YJUjiraCnU9eMit21HSCgj4VHRpth8mmvOzBQkftAckRTR1lDvSEmQJ2P1fAzdbwGR5m4kxxCvK
 26kSZWfRwUyqeLqQDXvhA1JQmR/gpQ==
X-Received: by 2002:a05:620a:319c:b0:81f:f2aa:70ee with SMTP id
 af79cd13be357-81ff2ab173fmr16118385a.76.1757520120007; 
 Wed, 10 Sep 2025 09:02:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAY6gOHFyMYhlvAF6R9jjrSu6CnVNrLrTw5GRFwXnhj/qWNhZGXiqGlfdaVoBvgTDD39rbgA==
X-Received: by 2002:a05:620a:319c:b0:81f:f2aa:70ee with SMTP id
 af79cd13be357-81ff2ab173fmr16108085a.76.1757520118869; 
 Wed, 10 Sep 2025 09:01:58 -0700 (PDT)
Received: from x1.com ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b61bbe0a85sm26655281cf.42.2025.09.10.09.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 09:01:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Xiaohui Li <xiaohli@redhat.com>
Subject: [PATCH 1/3] migration/tls: Gracefully shutdown main and preempt
 channels
Date: Wed, 10 Sep 2025 12:01:42 -0400
Message-ID: <20250910160144.1762894-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250910160144.1762894-1-peterx@redhat.com>
References: <20250910160144.1762894-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

QEMU supported graceful shutdowns for multifd channels starting from commit
48796f6b44 ("migration/multifd: Terminate the TLS connection").  Then error
check was enabled for premature TLS terminations.

Now if we run the preempt TLS unit test, the test would pass, but there
will be a warning reported:

qemu-system-x86_64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
ok 1 /x86_64/migration/postcopy/preempt/tls/psk

To fix it, make the rest channels to be gracefully terminated too when it's
a TLS channel.

One note is that the qemufile helper needs to be in migration.c not
qemu-file.c, because qemu-file.c will be linked in unit tests, which will
not link channel.c unfortunately.

Reported-by: Xiaohui Li <xiaohli@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/channel.h   |  3 +++
 migration/migration.h |  2 ++
 migration/channel.c   | 13 +++++++++++++
 migration/migration.c | 24 +++++++++++++++++++++++-
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/migration/channel.h b/migration/channel.h
index 5bdb8208a7..0b25dd7c5b 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -29,4 +29,7 @@ int migration_channel_read_peek(QIOChannel *ioc,
                                 const char *buf,
                                 const size_t buflen,
                                 Error **errp);
+
+bool migration_channel_shutdown_gracefully(QIOChannel *c, Error **errp);
+
 #endif
diff --git a/migration/migration.h b/migration/migration.h
index 01329bf824..b5763af057 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -594,4 +594,6 @@ void migration_bitmap_sync_precopy(bool last_stage);
 void dirty_bitmap_mig_init(void);
 bool should_send_vmdesc(void);
 
+bool qemu_file_shutdown_gracefully(QEMUFile *f, Error **errp);
+
 #endif
diff --git a/migration/channel.c b/migration/channel.c
index a547b1fbfe..1ae839e5fe 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -145,3 +145,16 @@ int migration_channel_read_peek(QIOChannel *ioc,
 
     return 0;
 }
+
+/*
+ * This is only needed for a successful migration, no-op for non-TLS
+ * channels.  For unexpected interruptions, use qio_channel_shutdown().
+ */
+bool migration_channel_shutdown_gracefully(QIOChannel *c, Error **errp)
+{
+    if (object_dynamic_cast((Object *)c, TYPE_QIO_CHANNEL_TLS)) {
+        qio_channel_tls_bye(QIO_CHANNEL_TLS(c), errp);
+    }
+
+    return *errp == NULL;
+}
diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25d..7015c2b5e0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -113,6 +113,27 @@ static bool close_return_path_on_source(MigrationState *s);
 static void migration_completion_end(MigrationState *s);
 static void migrate_hup_delete(MigrationState *s);
 
+/*
+ * See migration_channel_shutdown_gracefully().  The "graceful" versions
+ * are only needed if migration succeeded.
+ */
+bool qemu_file_shutdown_gracefully(QEMUFile *f, Error **errp)
+{
+    int ret;
+
+    if (!migration_channel_shutdown_gracefully(qemu_file_get_ioc(f), errp)) {
+        return false;
+    }
+
+    ret = qemu_file_shutdown(f);
+    if (ret) {
+        error_setg_errno(errp, -ret, "qemu_file_shutdown() failed");
+        return false;
+    }
+
+    return true;
+}
+
 static void migration_downtime_start(MigrationState *s)
 {
     trace_vmstate_downtime_checkpoint("src-downtime-start");
@@ -2473,11 +2494,12 @@ static void migration_release_dst_files(MigrationState *ms)
      */
     if (ms->postcopy_qemufile_src) {
         migration_ioc_unregister_yank_from_file(ms->postcopy_qemufile_src);
-        qemu_file_shutdown(ms->postcopy_qemufile_src);
+        qemu_file_shutdown_gracefully(ms->postcopy_qemufile_src, &error_warn);
         qemu_fclose(ms->postcopy_qemufile_src);
         ms->postcopy_qemufile_src = NULL;
     }
 
+    qemu_file_shutdown_gracefully(file, &error_warn);
     qemu_fclose(file);
 }
 
-- 
2.50.1


