Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13DAD17141
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 21:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t30KM-0001K1-NR; Mon, 21 Oct 2024 17:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t30KL-0001Js-Gd
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 17:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t30KJ-0006yi-CP
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 17:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729547549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=087OfFMmh0RHkgJbBmLUcTRUXDGVFXELFrxJJHeqAnk=;
 b=a2v05TAKnltxx8L51hkVZ7c2B55HqINJq8fXnYYjUDJwQBs2vi1RNJ/Zl7c30ybgUoy4UV
 ud4XeQe4HX9Rg9b1aTJBBn2c01SKoAqW10hTJfTnx/fRRYrBefAQWDDmglibXJo8hPhPCA
 sD5IZhFmZjQMgrFZPAPAp3EMsapOG3s=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-5_qW5FcaMYOW0ILVy-6uhg-1; Mon, 21 Oct 2024 17:52:24 -0400
X-MC-Unique: 5_qW5FcaMYOW0ILVy-6uhg-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-50d5127122cso960990e0c.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 14:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729547542; x=1730152342;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=087OfFMmh0RHkgJbBmLUcTRUXDGVFXELFrxJJHeqAnk=;
 b=boi9vDCWk9hZydWcQwqfBeJo9Kkm/X8UK0Bsl7w5JWrBUb21t9DAVQWqxh5c6BF79N
 JQzuFqWBT6jgGdi2uL0wcLmuCkHVsLJpTF+Al7ZZo81ryfOEvNOokXsKXeAgDVyGUMsf
 +TVrltgeyS7JmP3qnzklrjLIHrBMteZrxRLjw8bQom49tNq5kJZngtbqstuQN6/H7Mb5
 YceUr2WXk0JSdKTPfxK2Qm35PftQMniTRpHl37Hip3qp+8GUhfHtQ/HG7C52uSYbWTbS
 UYjHRlhBqixNDlvAIbtI/7u3EoyXUwau5DJjHNqWW3HvAqJeaq22LtZm26Vk0GMEO8Km
 tngA==
X-Gm-Message-State: AOJu0YxLfPTOyd7ZgGoz64szR/0RSHtjXVLGxOGRrgbkoZn3nm0ijFC+
 2dIsh11gLCk+pFENa5UE+K9PEp0NI/fVV+vlWS2ZlvOSG3rd7rr6Q3F/mwhCWpCejbK60TpkWd8
 cpnNC+3MUhnMsdeCq/OHqY9YuTtFJS3y/Mf9Xb5M5BvqAsxEc88AV9HnXBkvEnREgDORhpxsC5t
 mGQVRAOFgo49Pl72X6On8bniCSV2WnMVZnmA==
X-Received: by 2002:a05:6122:2521:b0:50d:74af:d480 with SMTP id
 71dfb90a1353d-50dda1bb590mr10517549e0c.1.1729547542591; 
 Mon, 21 Oct 2024 14:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnedorL7sAOyTa2Ngv3UWyelmQmeq1JO6kKK6aLq3V5m8BQxZDFwv5Hhz9ucRvSe3ezAJk2w==
X-Received: by 2002:a05:6122:2521:b0:50d:74af:d480 with SMTP id
 71dfb90a1353d-50dda1bb590mr10517503e0c.1.1729547542149; 
 Mon, 21 Oct 2024 14:52:22 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a86f43sm218566885a.126.2024.10.21.14.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 14:52:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 Juraj Marcin <jmarcin@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] migration: Deprecate query-migrationthreads command
Date: Mon, 21 Oct 2024 17:52:20 -0400
Message-ID: <20241021215220.982325-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Per previous discussion [1,2], this patch deprecates query-migrationthreads
command.

To summarize, the major reason of the deprecation is due to no sensible way
to consume the API properly:

  (1) The reported list of threads are incomplete (ignoring destination
      threads and non-multifd threads).

  (2) For CPU pinning, there's no way to properly pin the threads with
      the API if the threads will start running right away after migration
      threads can be queried, so the threads will always run on the default
      cores for a short window.

  (3) For VM debugging, one can use "-name $VM,debug-threads=on" instead,
      which will provide proper names for all migration threads.

[1] https://lore.kernel.org/r/20240930195837.825728-1-peterx@redhat.com
[2] https://lore.kernel.org/r/20241011153417.516715-1-peterx@redhat.com

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/about/deprecated.rst | 8 ++++++++
 qapi/migration.json       | 6 +++++-
 migration/threadinfo.c    | 4 ++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ce38a3d0cf..ffb147e896 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -147,6 +147,14 @@ options are removed in favor of using explicit ``blockdev-create`` and
 ``blockdev-add`` calls. See :doc:`/interop/live-block-operations` for
 details.
 
+``query-migrationthreads`` (since 9.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+To be removed with no replacement, as it reports only a limited set of
+threads (for example, it only reports source side of multifd threads,
+without reporting any destination threads, or non-multifd source threads).
+For debugging purpose, please use ``-name $VM,debug-threads=on`` instead.
+
 Incorrectly typed ``device_add`` arguments (since 6.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 3af6aa1740..a71a9f0cd3 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -2284,12 +2284,16 @@
 #
 # Returns information of migration threads
 #
+# Features:
+# @deprecated: This command is deprecated with no replacement yet.
+#
 # Returns: @MigrationThreadInfo
 #
 # Since: 7.2
 ##
 { 'command': 'query-migrationthreads',
-  'returns': ['MigrationThreadInfo'] }
+  'returns': ['MigrationThreadInfo'],
+  'features': ['deprecated'] }
 
 ##
 # @snapshot-save:
diff --git a/migration/threadinfo.c b/migration/threadinfo.c
index 262990dd75..2867413420 100644
--- a/migration/threadinfo.c
+++ b/migration/threadinfo.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/queue.h"
 #include "qemu/lockable.h"
+#include "qemu/error-report.h"
 #include "threadinfo.h"
 
 QemuMutex migration_threads_lock;
@@ -52,6 +53,9 @@ MigrationThreadInfoList *qmp_query_migrationthreads(Error **errp)
     MigrationThread *thread = NULL;
 
     QEMU_LOCK_GUARD(&migration_threads_lock);
+
+    warn_report("Command 'query-migrationthreads' is deprecated");
+
     QLIST_FOREACH(thread, &migration_threads, node) {
         MigrationThreadInfo *info = g_new0(MigrationThreadInfo, 1);
         info->name = g_strdup(thread->name);
-- 
2.45.0


