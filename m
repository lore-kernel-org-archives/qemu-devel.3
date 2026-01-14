Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C44D39013
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 19:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg702-0001bm-Qy; Wed, 14 Jan 2026 14:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg6zh-0001Nx-Ae
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 14:57:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg6zf-00023U-GV
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 14:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768420646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sao1wRkhL19NI6f8FC0xP3/0GVRrrC/sElfaU9Azbvw=;
 b=fDHxKhtjjMqkV3tWmiy5+u8q02A+O4T0ypzaCf7S/eab8xLqJ+LXERHNknI0yl4z8wg3Dw
 +4BiX31UYK/moAlr/QoYssmXGRoxhHHClmOP6udMbyruL6GEHoVWPKk69wRJTy8UhXjxgc
 sY0rsT/hPv4ZvMw29w4eR13tyfjXuLY=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-Zp13_39WPLmLNNwHeqdsxg-1; Wed, 14 Jan 2026 14:57:25 -0500
X-MC-Unique: Zp13_39WPLmLNNwHeqdsxg-1
X-Mimecast-MFC-AGG-ID: Zp13_39WPLmLNNwHeqdsxg_1768420644
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-5ed0a71c0beso162778137.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 11:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768420644; x=1769025444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sao1wRkhL19NI6f8FC0xP3/0GVRrrC/sElfaU9Azbvw=;
 b=guW4VtDEIgm3Zf1lW5DWg9HTQjNYdwhiG2BqmloUg+JcvlQ0UZIMVPJ+K+AjCNDmLz
 1sjjZONPh2jQbe6XO08sLTiuJfelKeinEcyXvhSY0jVG0anQsXQ/8zVdlWolxvs5jkzi
 MhL6fLSp8ZBiN9ZZB29ggbvDDs7zpYxLw/s3MLPnubOUZCwOIRNda4iccXQLa3S3k2Jj
 7DlurymPMzBSF9zSLTVCljy6sLtYbhIdrN7j5XodRTnEsOCjOJ0uXViemQ6BKz6oPwI+
 OTPD+rXskZ/RYKSAS60Oodw1S4pkLfTBKBApKHm350IAa42Slfu8A5PNWPKmWGuDAH1Q
 Whfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768420644; x=1769025444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sao1wRkhL19NI6f8FC0xP3/0GVRrrC/sElfaU9Azbvw=;
 b=IKjhCxD/2pbpV1b9Fv3QPd6yG2kmJEESOT0dwjVpFcyGiGN6sdvltzHXj+SgMrNJZ3
 FeIe+Tsv1au6JTHQEzyx1H1A/WhJyqFklhR793Y3igyNhaFvSv8/3Jln5Z57KmdRJLVI
 JOekxbWFcWPU84/ofXvy3ddAwCPZTZa6RHQrNNaJPVG9so581vD22AGZ2SMWw3cwgZzs
 TdljVaV5TGjqxfbsyFcq1hspRKIjKC073itmTPxY8Ser5ZBpPWOhDyOiyG16+gvRAJQv
 29eBkpXoi1PQs43rkD+JA1FVwyjgAUlPWu2l0HZ1gj5ZNHKfWbGM6Yjpeex5V6JTh10a
 yIjg==
X-Gm-Message-State: AOJu0Yye77kVE11nAZvb4INZS97wALlycdH9cfW5i51tdXysWvYcyY9C
 YIU4xNPNI78qoiZX77+vA4Juwz056KJgbe8HZYNoURDUAmj6wU8CCDRHwxW+h2+r/oXCQb46h2B
 UBfBk84DCm+2cU+SOA+nxtko/INrToEFVe3nKKeapfHubFEnfhHHnkG17VdQqpYioNhQxqAD7xU
 yDiMLfvj+lnW1ppk3+3nMgeALanGwZq9jVu+bePQ==
X-Gm-Gg: AY/fxX5jZYHet0ZNG6i8SR+dT60iIlesW5TzfRqqqanwClGzCpdsJoOWAbc4xdMeTS7
 lc8eFHnE+2gAnXDyxrzsmKhNcZRxrTeKGFBJAez8oQLBVtyhFA8MakbJH5WNIUrS2HgQPY4pkdG
 B7lqBmGB8qtd8mr3vUy7EQJDDhNFyKUnaP+Mu8USORA0vwtGZNnVNviUBsmsvXrQ7BBFB3xXUey
 5MGN3bLs/fzuDt0rYPyY2xjYlWnHZpte2CJTxZeP9cwPIZpt3mOWThaQJQJobf8jGL6G/z/YXs+
 X894xTUJPy1P8RNoLkd7FN1F6BiYRnBCLg2ywXpequdvWjdV3hasyKz+mx57CsMru85s929qmvF
 V
X-Received: by 2002:a05:6102:94e:b0:5ef:24aa:986f with SMTP id
 ada2fe7eead31-5f1838967f1mr1527372137.2.1768420644146; 
 Wed, 14 Jan 2026 11:57:24 -0800 (PST)
X-Received: by 2002:a05:6102:94e:b0:5ef:24aa:986f with SMTP id
 ada2fe7eead31-5f1838967f1mr1527359137.2.1768420643550; 
 Wed, 14 Jan 2026 11:57:23 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-944122d3040sm23024832241.4.2026.01.14.11.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 11:57:23 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 3/3] migration: Remove fd: support on files
Date: Wed, 14 Jan 2026 14:56:59 -0500
Message-ID: <20260114195659.2543649-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114195659.2543649-1-peterx@redhat.com>
References: <20260114195659.2543649-1-peterx@redhat.com>
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

This feature was deprecated in 9.1.  Remove it in this release (11.0).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/about/deprecated.rst       | 11 -----------
 docs/about/removed-features.rst |  9 +++++++++
 migration/fd.c                  | 11 +++++++----
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 6e4e2e4833..76ac735315 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -564,17 +564,6 @@ be rejected.
 Migration
 ---------
 
-``fd:`` URI when used for file migration (since 9.1)
-''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The ``fd:`` URI can currently provide a file descriptor that
-references either a socket or a plain file. These are two different
-types of migration. In order to reduce ambiguity, the ``fd:`` URI
-usage of providing a file descriptor to a plain file has been
-deprecated in favor of explicitly using the ``file:`` URI with the
-file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
-command documentation for details on the ``fdset`` usage.
-
 COLO migration framework (since 11.0)
 '''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 8a9d21068a..538914ef00 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -710,6 +710,15 @@ Use blockdev-mirror with NBD instead. See "QMP invocation for live
 storage migration with ``blockdev-mirror`` + NBD" in
 docs/interop/live-block-operations.rst for a detailed explanation.
 
+``migrate`` command with file-based ``fd:`` URI (removed in 11.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+In order to reduce ambiguity, the ``fd:`` URI usage of providing a
+file descriptor to a plain file has been removed in favor of
+explicitly using the ``file:`` URI with the file descriptor being
+passed as an ``fdset``. Refer to the ``add-fd`` command documentation
+for details on the ``fdset`` usage.
+
 ``migrate-set-capabilities`` ``block`` option (removed in 9.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/migration/fd.c b/migration/fd.c
index 9bf9be6acb..fdeece2101 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -24,6 +24,7 @@
 #include "qemu/sockets.h"
 #include "io/channel-util.h"
 #include "trace.h"
+#include "qapi/error.h"
 
 static bool fd_is_pipe(int fd)
 {
@@ -58,8 +59,9 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
     }
 
     if (!migration_fd_valid(fd)) {
-        warn_report("fd: migration to a file is deprecated."
-                    " Use file: instead.");
+        error_setg(errp, "fd: migration to a file is not supported."
+                   " Use file: instead.");
+        return;
     }
 
     trace_migration_fd_outgoing(fd);
@@ -92,8 +94,9 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
     }
 
     if (!migration_fd_valid(fd)) {
-        warn_report("fd: migration to a file is deprecated."
-                    " Use file: instead.");
+        error_setg(errp, "fd: migration to a file is not supported."
+                   " Use file: instead.");
+        return;
     }
 
     trace_migration_fd_incoming(fd);
-- 
2.50.1


