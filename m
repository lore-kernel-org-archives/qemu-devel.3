Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381E7CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huy-0005Sd-9q; Fri, 03 Oct 2025 11:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4huR-00059t-Aa
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htm-0007iX-9g
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F57GWwPskqwfMnu+d0hvhYvdtgdyPoG9agbFZneeOEg=;
 b=emRW8tQu/FUQv/iRJug2TbXri40MDDuzZDpnSGW4eCmwBnaYCaYddthHtD+M5xDj4h/urN
 oW4XJR+fF018TZk/82XAjpiazhHYpM6bGeuVPJHNpdgBlpRnjiJSKSLBnSetjRQqXHEnCz
 xYdc1hcDOf2a3/1juNMbSpenyMgef64=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-JxU9-kzgPMuHzIzo39oq8A-1; Fri, 03 Oct 2025 11:40:37 -0400
X-MC-Unique: JxU9-kzgPMuHzIzo39oq8A-1
X-Mimecast-MFC-AGG-ID: JxU9-kzgPMuHzIzo39oq8A_1759506036
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-818bf399f8aso58418306d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506036; x=1760110836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F57GWwPskqwfMnu+d0hvhYvdtgdyPoG9agbFZneeOEg=;
 b=CyImPpmkN0IQdUhKeHdOb5PEIJbJFjnpzbLvFG84+HulMWbTQFxZqg3i7VVXgkXNZ7
 XVZ1hcwCss8TjPuwVo4rrHXOWTJ2nk4SmsHeLHbmI2uXKQnY8ZscA7ShXwzlz07AHsZ/
 8yly6UpmtnQRh2TetZBbjm19BeNk7l6W2fyjbRLu8Ba81PWPwQTm8x1jiKptSg6ACYLy
 jnGbE0MqoF/XF9fy0QIiV7DF6YLbLA8DfLsEXcvAmXMt47SLjNJXTy+ENUlTZcaPUebn
 GNOOs6W3tR1W534qLOIwsvrX1BozQnhXt+X5gFsGAAu1sZpmhPV/SdGBnNwYk92Mg/un
 n7dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyAews0j581QE6k2PBSMvFJHO6I+KRibB/MtM1QIHEZ2feavpWG35NWX0yNKl4XdshYImzy5zIclas@nongnu.org
X-Gm-Message-State: AOJu0Yw64MSv9SKgR9QlQ05Vk6hlGDxVj1uN7CL2NPBSakMbVx/sHso4
 e7DTNvY6JItWIUwfIaPmVxcnjSXiqJ3XSxcQZr9GmPFuqXbsK7s67WlavwmIgR4K0wY6KkiScw/
 0jHxO+fUaVqi2wZ9Y7kq7nPlMrVC0HWCRYUubcyrcljyMTTs1nD08afQr
X-Gm-Gg: ASbGnctFzGg+V9g6z/G7uz1mQK2s8ppJefGQPD4Y7nT+cRPLWSj803+kDLIZrAf2ZYH
 RN8LOGwCItkUwVdVBG3ooqRjXKZTXaS74rfJI+5P8VerxmV1HFqpNemWAj4ZVBupZDTpbiAFEs/
 a8zE5GcRInPucLLLkJ5rJKMu1RxqjbVa00viCS5wyFr5J/xX4LOg1rh9kE3/Gx0ZZ3OszPzdnKY
 LgLpuzcH9iG9U2Z0woltSVlMPyAT6bt422zTu7V+DmbSkO/0I+iG4UzXq2UoBvoDohlWvGYeWl8
 +IuG23BCXobM05gkRd/VI/T4BP0eVMXvi3g48g==
X-Received: by 2002:a05:6214:3018:b0:80c:2633:482d with SMTP id
 6a1803df08f44-879dc864f6dmr48831606d6.50.1759506035503; 
 Fri, 03 Oct 2025 08:40:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtBAv9cqS8wQeiyBnVgQzn/mP6SDGuFDF/DrIfdtKPLRLqK6yt8MYA9pqagrZVnYjud/d5Zg==
X-Received: by 2002:a05:6214:3018:b0:80c:2633:482d with SMTP id
 6a1803df08f44-879dc864f6dmr48831006d6.50.1759506034952; 
 Fri, 03 Oct 2025 08:40:34 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:33 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 30/45] migration/multifd/tls: Cleanup BYE message processing on
 sender side
Date: Fri,  3 Oct 2025 11:39:33 -0400
Message-ID: <20251003153948.1304776-31-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This patch is a trivial cleanup to the BYE messages on the multifd sender
side.  It could also be a fix, but since we do not have a solid clue,
taking this as a cleanup only.

One trivial concern is, migration_tls_channel_end() might be unsafe to be
invoked in the migration thread if migration is not successful, because
when failed / cancelled we do not know whether the multifd sender threads
can be writting to the channels, while GnuTLS library (when it's a TLS
channel) logically doesn't support concurrent writes.

When at it, cleanup on a few things.  What changed:

  - Introduce a helper to do graceful shutdowns with rich comment, hiding
    the details

  - Only send bye() iff migration succeeded, skip if it failed / cancelled

  - Detect TLS channel using channel type rather than thread created flags

  - Move the loop into the existing one that will close the channels, but
    do graceful shutdowns before channel shutdowns

  - local_err seems to have been leaked if set, fix it along the way

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250925201601.290546-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 65 ++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index b255778855..98873cee74 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -439,6 +439,39 @@ static void multifd_send_set_error(Error *err)
     }
 }
 
+/*
+ * Gracefully shutdown IOChannels. Only needed for successful migrations on
+ * top of TLS channels.  Otherwise it is same to qio_channel_shutdown().
+ *
+ * A successful migration also guarantees multifd sender threads are
+ * properly flushed and halted.  It is only safe to send BYE in the
+ * migration thread here when we know there's no other thread writting to
+ * the channel, because GnuTLS doesn't support concurrent writers.
+ */
+static void migration_ioc_shutdown_gracefully(QIOChannel *ioc)
+{
+    g_autoptr(Error) local_err = NULL;
+
+    if (!migration_has_failed(migrate_get_current()) &&
+        object_dynamic_cast((Object *)ioc, TYPE_QIO_CHANNEL_TLS)) {
+
+        /*
+         * The destination expects the TLS session to always be properly
+         * terminated. This helps to detect a premature termination in the
+         * middle of the stream.  Note that older QEMUs always break the
+         * connection on the source and the destination always sees
+         * GNUTLS_E_PREMATURE_TERMINATION.
+         */
+        migration_tls_channel_end(ioc, &local_err);
+        if (local_err) {
+            warn_report("Failed to gracefully terminate TLS connection: %s",
+                        error_get_pretty(local_err));
+        }
+    }
+
+    qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+}
+
 static void multifd_send_terminate_threads(void)
 {
     int i;
@@ -460,7 +493,7 @@ static void multifd_send_terminate_threads(void)
 
         qemu_sem_post(&p->sem);
         if (p->c) {
-            qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+            migration_ioc_shutdown_gracefully(p->c);
         }
     }
 
@@ -547,36 +580,6 @@ void multifd_send_shutdown(void)
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
     multifd_send_terminate_threads();
 
     for (i = 0; i < migrate_multifd_channels(); i++) {
-- 
2.50.1


