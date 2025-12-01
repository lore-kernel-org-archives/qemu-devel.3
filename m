Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0839D116F6
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 19:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ9ps-0000l8-3z; Mon, 01 Dec 2025 14:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQ9pq-0000ki-Ao
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQ9po-0005HU-F3
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764618319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I9HG9Yy5lqRHBNLgg3hbny1TgDBAOnr/tELSIiqy61A=;
 b=eDw9Tp+91PPcUw4zd0cPkIFPa81uA/uJdCduPrj4hX4VpgZ/Ssv4ykPEa9AoEDXWqQC6kL
 H72wiQUHxosUODMMrMCTefcl8Jc4sjWJe1g28nYWEHuwIOpAbWpnHSpNRy804eeNZxjpFd
 MyH8NtNB6YLmRb09bOfzeQZ4fF1rvWw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-xUwQT4toOJCaPTv0ggWBoQ-1; Mon, 01 Dec 2025 14:45:17 -0500
X-MC-Unique: xUwQT4toOJCaPTv0ggWBoQ-1
X-Mimecast-MFC-AGG-ID: xUwQT4toOJCaPTv0ggWBoQ_1764618317
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8823f4666abso90557286d6.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 11:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764618317; x=1765223117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9HG9Yy5lqRHBNLgg3hbny1TgDBAOnr/tELSIiqy61A=;
 b=qaUvLNmV+KKMzotL6U9LReQd5fe5Ku7Adyx2jzPQ4P8fKxPeiyAZ/UyQQEthJp7LGa
 g47KGV8sge9GbRfBJynFW5gVJy878PqDGhjL8ssxrX7eDsXxUfFiLYjK1HLCzbRZZD+O
 Wv7+OgXrKEaBaROaJaS8xGaktaJBN/vPh+6hLVl/O45CPYIO3J9K34RRxSCuqOY6qQMz
 E4WCqyJifoRJLs52Cyy4Q7bwEirSshhimAcytle84Co0ndirL3SsvMGlhKQwd4rlnm7p
 EtMNafhOJXB+1TZghPB6eB11hq9KXRZuxwD9WvzXXpRtGKUufQaMEP6aENjK5ri5EAIQ
 sjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764618317; x=1765223117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I9HG9Yy5lqRHBNLgg3hbny1TgDBAOnr/tELSIiqy61A=;
 b=BUFcXMXG1SmKAyc8razZCReHKbdjhR1DUax0ZW7r9oxWLiGWY9i2hGgJyZieuDWbzz
 7JK0OFd+Y1PvsY2jkLXAb/+YdVMZJUx6j1PdxDk6AQr9XCGm56ZGNh/D8/0aKKzHJOmy
 eyu2fJwnOUurhYxPltVgXsa56NvsnSNiCbJ6Khmg0tZK9Bu/lyqMuastB0iHFI0HmgEk
 mROC8sgfKsugXZblsEeW+dzJ3XsvdDiqE+iyJ8ltKCv9o/wjotX8pV5K3bVaUwmG0cGK
 rVLKyLR+lLR4P3PmltqC3NclGYQNgBcRSSv2Qm1sZo77MzFuizdgvIZaTgbe29HvB0ZE
 YBeQ==
X-Gm-Message-State: AOJu0Yx2zI3CEwtOcFB4YdsRzGoT0ll/zbbwJTZsiMksUG6DY730O2xL
 LPFDqNe0tW41sl9HhgAzcXa+GqaGj4bQZPg67fZg4ynmQOzE59yMMPoAPfDeLnbZQ3eXeev4W6w
 DhaMS4+vZsUDj8UH54K5Wr/uTdN+31r4+S5dYOLAo8LDLwraslW5HbYq2E0XlL7G1ZCXV2Jbwzh
 WJyGAXvyh5sq2KY4fopxoYTHOpONBa1sd29Z+jCg==
X-Gm-Gg: ASbGnctdv/UuP7d7qZZGAyAUz7xVxNXYDD/p6FFWUfWFFwI5jyRhnuPoPHOoyqmNlAS
 L1tgmktoNeuOCgmQAqunG+OtcAvkg3q/KFo5rmlOjyxGpyRBMZ0m/KY2MSQqWMk9EC8JmZFIxPe
 JRO4ObXa23vzSVkZPenoMTGXIj1jG1fIn5MGT3PmG0r4jtoFnc4Dk6jTCtE8pWdI7PCKLAjt4Mx
 mYV37O6z49q+q2KT7BbAdANeNYiP/tPZovT5BFhqcXZEPGVurHx4Ujhs8DYMOeBxmlyfi3j5QgG
 KCZwOQhTTnnzlUXgbb38vvDrLn0j2dXW5XkYdOfw3TfRWgrQjYV++Du8aPeaYyGaEV3MuEA50SZ
 E
X-Received: by 2002:a05:6214:226c:b0:87d:fc3e:6d9b with SMTP id
 6a1803df08f44-8847c525de0mr579976506d6.42.1764618316703; 
 Mon, 01 Dec 2025 11:45:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv+ASfjl8QbJ/I8sN5xAcsuRT0epwC3Ptzmxdhs/3aARiqxinq8sF/dM25RfM+M+tdX4yM8w==
X-Received: by 2002:a05:6214:226c:b0:87d:fc3e:6d9b with SMTP id
 6a1803df08f44-8847c525de0mr579975506d6.42.1764618316044; 
 Mon, 01 Dec 2025 11:45:16 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88652b91ba3sm88835156d6.53.2025.12.01.11.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 11:45:14 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH for-11.0 v2 1/7] migration: Use explicit error_free() instead
 of g_autoptr
Date: Mon,  1 Dec 2025 14:45:04 -0500
Message-ID: <20251201194510.1121221-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201194510.1121221-1-peterx@redhat.com>
References: <20251201194510.1121221-1-peterx@redhat.com>
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

There're only two use cases of g_autoptr to free Error objects in migration
code paths.

Due to the nature of how Error should be used (normally ownership will be
passed over to Error APIs, like error_report_err), auto-free functions may
be error prone on its own.  The auto cleanup function was merged without
proper review, as pointed out by Dan and Markus:

https://lore.kernel.org/r/aSWSLMi6ZhTCS_p2@redhat.com

Remove the two use cases so that we can remove the auto cleanup function,
hence suggest to not use auto frees for Errors.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd-device-state.c | 3 ++-
 migration/savevm.c               | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index fce64f00b0..db3239fef5 100644
--- a/migration/multifd-device-state.c
+++ b/migration/multifd-device-state.c
@@ -140,7 +140,7 @@ static void multifd_device_state_save_thread_data_free(void *opaque)
 static int multifd_device_state_save_thread(void *opaque)
 {
     SaveCompletePrecopyThreadData *data = opaque;
-    g_autoptr(Error) local_err = NULL;
+    Error *local_err = NULL;
 
     if (!data->hdlr(data, &local_err)) {
         MigrationState *s = migrate_get_current();
@@ -159,6 +159,7 @@ static int multifd_device_state_save_thread(void *opaque)
          * return we end setting is purely arbitrary.
          */
         migrate_set_error(s, local_err);
+        error_free(local_err);
     }
 
     return 0;
diff --git a/migration/savevm.c b/migration/savevm.c
index 62cc2ce25c..638e9b364f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2823,7 +2823,7 @@ static int qemu_loadvm_load_thread(void *thread_opaque)
 {
     struct LoadThreadData *data = thread_opaque;
     MigrationIncomingState *mis = migration_incoming_get_current();
-    g_autoptr(Error) local_err = NULL;
+    Error *local_err = NULL;
 
     if (!data->function(data->opaque, &mis->load_threads_abort, &local_err)) {
         MigrationState *s = migrate_get_current();
@@ -2841,6 +2841,7 @@ static int qemu_loadvm_load_thread(void *thread_opaque)
          * return we end setting is purely arbitrary.
          */
         migrate_set_error(s, local_err);
+        error_free(local_err);
     }
 
     return 0;
-- 
2.50.1


