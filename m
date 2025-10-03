Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F49CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hv2-0005UH-DV; Fri, 03 Oct 2025 11:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4huq-0005O0-1N
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htw-0007kS-Dn
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89BRKDuSU239eBQPSg6ZWHWpyPPu3WW3GTnT1uWLOS8=;
 b=UUZ5DpFSCBCJzEV97EFg/U5gGhmINcduBGOzHYp7njmObT25Qpy4XCEQfnIDJGd7sbRswz
 sF15BIs2wYKMEtXPHOT53WXQ/qaR8ZXX5+ob6EVJPijfBjEyVQLFfLpom+j2GUrZfZWequ
 3k7rd1Ep2eo2vQrIl7uOy37xia/Qv+o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-QHUt-M67NdyN1_xbMG-SMg-1; Fri, 03 Oct 2025 11:40:49 -0400
X-MC-Unique: QHUt-M67NdyN1_xbMG-SMg-1
X-Mimecast-MFC-AGG-ID: QHUt-M67NdyN1_xbMG-SMg_1759506049
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-7946137e7c2so66844066d6.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506049; x=1760110849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=89BRKDuSU239eBQPSg6ZWHWpyPPu3WW3GTnT1uWLOS8=;
 b=jv9QbhRQVVrQDvMx2DAwnxx8Fk+SNri++pLzB0ukfr1EDeOTNE6/qlCQkpGaPsW3kf
 jvN8yVDQefWItPhnmkhtYxWzPd33d/sdXggKE6JIgZpDcLPkNqhUGEsrSHqaA/bl6jPH
 pS10Q7OCQgyK8w5tnCb7bz995efU5Y5xWVmHZX1XYsRaZPhEXGuV54WhL3fIAbEnoqBu
 jOu4ooEZQhGX1OMSKL+Up3MXmKjaoXepMB+zmX8ZFxpljVwm3V8Fhxw5TIJzyoLhyz/6
 RX9UQlo8h1Y3pq4qlK+AJYXJfNjHSwvc1sWKPPtxhh5MReqrijy+XlzjH8InaeFHObjC
 PMag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDl8sJX/Mj2bwl+JxQLfbDSkzgnk/BZGiJNGvDjJf3fsV6M66VU7Ru5+KVkepfFD8U3zLgRfZYkdKo@nongnu.org
X-Gm-Message-State: AOJu0YwaGlQHUmoqei4nsAkBApNed0T57ThRmszi6KzwoO10NeyjTR2h
 V27m2LLdF5bgieRPerYJ2FcMzRciQkYu9+GeHhXIUZrGdaU3LUt7vdHGBCCbskGIbnnEeLPSYU9
 Om2LOZ+5uz1CNwOx9M/VCU9OXIWysTKD5F/iyO2n2Z/klxu9Gt2c/H6RL
X-Gm-Gg: ASbGncuN8l5/c3g7OADgQCJR9d2tbSWkET9BafMlq4/kbmiCQGT8nxCgKxIADxIZSIY
 bRwt3GCHUW5ZLGHuL+g9l1Rru3GDFGoepS66vsT7mAhT7q1ux8jSg6FgSWz/qC0pHzW7I6XvFJh
 9PY67aIvG21zAiBRZ0isR7RI2U2v4Sai6rPVDjJjZvfbo2wi0pCWmGZ9v5CoON2ebn6ODS2CwRO
 4yfJ16nk35BLJVqvU+43XpdYOK4/Sl+a9nUvCq0uJLgQTD11eVhxYtPhrpYmNIQleEYzLEycHxD
 AZoTZqcZ6cJCTP6ZKN7Iw9+OKHfoq8skvHbiMA==
X-Received: by 2002:a05:6214:5e01:b0:879:e76e:b093 with SMTP id
 6a1803df08f44-879e76eb1a8mr2887306d6.13.1759506048769; 
 Fri, 03 Oct 2025 08:40:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHLwBRqSxny/SUUCT3hKWlnczb7IAvRMoRZava3CTtf1DWt6APPG4zvYwUlLe+avWCkGGK/w==
X-Received: by 2002:a05:6214:5e01:b0:879:e76e:b093 with SMTP id
 6a1803df08f44-879e76eb1a8mr2886876d6.13.1759506048242; 
 Fri, 03 Oct 2025 08:40:48 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 41/45] migration: cpr-exec save and load
Date: Fri,  3 Oct 2025 11:39:44 -0400
Message-ID: <20251003153948.1304776-42-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Steve Sistare <steven.sistare@oracle.com>

To preserve CPR state across exec, create a QEMUFile based on a memfd, and
keep the memfd open across exec.  Save the value of the memfd in an
environment variable so post-exec QEMU can find it.

These new functions are called in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/r/1759332851-370353-6-git-send-email-steven.sistare@oracle.com
[peterx: fix build for Windows]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/cpr.h |  5 +++
 migration/cpr-exec.c    | 99 +++++++++++++++++++++++++++++++++++++++++
 migration/meson.build   |  1 +
 3 files changed, 105 insertions(+)
 create mode 100644 migration/cpr-exec.c

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 2b074d7a65..b84389ff04 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -53,4 +53,9 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
 QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
 
+QEMUFile *cpr_exec_output(Error **errp);
+QEMUFile *cpr_exec_input(Error **errp);
+void cpr_exec_persist_state(QEMUFile *f);
+bool cpr_exec_has_state(void);
+void cpr_exec_unpersist_state(void);
 #endif
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
new file mode 100644
index 0000000000..81d84425e1
--- /dev/null
+++ b/migration/cpr-exec.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright (c) 2021-2025 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/memfd.h"
+#include "qapi/error.h"
+#include "io/channel-file.h"
+#include "io/channel-socket.h"
+#include "migration/cpr.h"
+#include "migration/qemu-file.h"
+#include "migration/misc.h"
+#include "migration/vmstate.h"
+#include "system/runstate.h"
+
+#define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
+
+static QEMUFile *qemu_file_new_fd_input(int fd, const char *name)
+{
+    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
+    QIOChannel *ioc = QIO_CHANNEL(fioc);
+    qio_channel_set_name(ioc, name);
+    return qemu_file_new_input(ioc);
+}
+
+static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
+{
+    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
+    QIOChannel *ioc = QIO_CHANNEL(fioc);
+    qio_channel_set_name(ioc, name);
+    return qemu_file_new_output(ioc);
+}
+
+void cpr_exec_persist_state(QEMUFile *f)
+{
+    QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
+    int mfd = dup(fioc->fd);
+    char val[16];
+
+    /* Remember mfd in environment for post-exec load */
+    qemu_clear_cloexec(mfd);
+    snprintf(val, sizeof(val), "%d", mfd);
+    g_setenv(CPR_EXEC_STATE_NAME, val, 1);
+}
+
+static int cpr_exec_find_state(void)
+{
+    const char *val = g_getenv(CPR_EXEC_STATE_NAME);
+    int mfd;
+
+    assert(val);
+    g_unsetenv(CPR_EXEC_STATE_NAME);
+    assert(!qemu_strtoi(val, NULL, 10, &mfd));
+    return mfd;
+}
+
+bool cpr_exec_has_state(void)
+{
+    return g_getenv(CPR_EXEC_STATE_NAME) != NULL;
+}
+
+void cpr_exec_unpersist_state(void)
+{
+    int mfd;
+    const char *val = g_getenv(CPR_EXEC_STATE_NAME);
+
+    g_unsetenv(CPR_EXEC_STATE_NAME);
+    assert(val);
+    assert(!qemu_strtoi(val, NULL, 10, &mfd));
+    close(mfd);
+}
+
+QEMUFile *cpr_exec_output(Error **errp)
+{
+    int mfd;
+
+#ifdef CONFIG_LINUX
+    mfd = qemu_memfd_create(CPR_EXEC_STATE_NAME, 0, false, 0, 0, errp);
+#else
+    mfd = -1;
+#endif
+
+    if (mfd < 0) {
+        return NULL;
+    }
+
+    return qemu_file_new_fd_output(mfd, CPR_EXEC_STATE_NAME);
+}
+
+QEMUFile *cpr_exec_input(Error **errp)
+{
+    int mfd = cpr_exec_find_state();
+
+    lseek(mfd, 0, SEEK_SET);
+    return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
+}
diff --git a/migration/meson.build b/migration/meson.build
index 0f71544a82..16909d54c5 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -16,6 +16,7 @@ system_ss.add(files(
   'channel-block.c',
   'cpr.c',
   'cpr-transfer.c',
+  'cpr-exec.c',
   'cpu-throttle.c',
   'dirtyrate.c',
   'exec.c',
-- 
2.50.1


