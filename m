Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CD2C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x9N-0002TG-Ng; Fri, 11 Sep 2026 05:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9B-0002I0-4Z
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x97-00087j-SJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=beU7FjgyA0BsZQfNfNmJBUW0kDGthpqeSLUuh7lD0jw=;
 b=UGZ60i7rJecYXT/EgFVmcWxV4I71otyxdB0fcz5nodt/Ju54XkEwbwbo20BIVmqtApK3kK
 G8tGb1xduwgumvzQ2mJWZNt/LKQ7kEbmWXbvzvEqigUtEdiLa5u7gFDXyW5ls1KKcRxpvH
 tVCgPiMRjCtbZp15ZkeaMHG8TdyqLbs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-85rYGe7wM2Kzmx68RLoSmA-1; Fri, 11 Sep 2026 05:02:07 -0400
X-MC-Unique: 85rYGe7wM2Kzmx68RLoSmA-1
X-Mimecast-MFC-AGG-ID: 85rYGe7wM2Kzmx68RLoSmA_1789117326
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49cced8309bso7107765e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117326; x=1789722126; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=beU7FjgyA0BsZQfNfNmJBUW0kDGthpqeSLUuh7lD0jw=;
 b=CJVv6XiMM+O4iP+4dTeCRcb/sFHFzzidKQ3G9S18+dOFicuPH/75b9RcJefA1ccqul
 IBti3ByHPGUNuz9ZmCoqMG+9S2Rswi4PKJCFKsnR6yUPxtF/S0jg1FIf5AndHy+weHqC
 aBs/fg7Uh9qix5WjICIIGnoMfZMeD2ZAiCkt/L6y6xxlnBf8uGS6q9Y6Yt/oeXgzjW7Q
 z5rczR9DbqRVhjZt8K1R97mzTuqf3U+WyOWSGux3wmBdlRLXNAeZYFu8/AVHOq5oJjTd
 UFDcfC3rmvQNEQYjk8IbHxvJB2KRRFsb8G0iy5xI83itZwXE4g/OxTlw8NiqUMOVBhJD
 V4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117326; x=1789722126;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=beU7FjgyA0BsZQfNfNmJBUW0kDGthpqeSLUuh7lD0jw=;
 b=PR+gndBcOZsnZJf5INulpiYGJTF3DT2vUmUIY07M4kbvUz7pYWDW+WUYqbSW2lINwG
 VS5c7jGQciwR3VkXK4K+4dld+WhMRaK8rmKJyHvPA8Obr7oPiGL9grPHvaU7wMT1tsWd
 8Mmnq5RQVXqvVwYeJvY2Zh8fO4Nt7ZOHKvwMS60SJVb0/Aq17g7+CDGAIa4hJUbgHieG
 F5SuIUMWi80B9Ua0sjUYO2RjCypl+owXgYXKB7JwL63LMa7DtK99nU96ZIxfkNzcdCh/
 dEpBek/PkK0WlTH/U54wZ/hhrlToWQYxLsq8NvzvhDlSGXsiWhnbQ1rvp98F+L5On8iR
 N8Jg==
X-Gm-Message-State: AFuF++k+h6hMxQNq7xG2BBqZauBQeq+mw5hwZ/4oaoHt5hbJTJddRUEI
 cxIkj4Vksaz5BhFmIODDV1QfBD7cXyBhwMxpKv/ztx1E9/WY/Qy14bhyqDokK9Fr9q39PebiSyA
 DmNNVn/N/txLrhhUXRqVGn2dawIN9EQ1LLRF0tcWX2ZLSPmgs3Csyx2GmTxXfOd0UGONOqEhsYV
 SOnVS9qs3exVaxgfyh3yEbQYcDrVFDyl9lDA==
X-Gm-Gg: AYBFou2V+WurktcDwNMBMpzqAzlxxHuGmvbUe1Eg8VbcX8B7Mi/16NaY5ugGiG3UILH
 owKCb4GOUHkoIgWoRKJso1CjzQeym8Lnvm1NUxchK/fQr5zymAoDUaoYGtlrvEogDJXnUwbS8N4
 NoqwkV5j0PZgxPDOzSOwVX4onJnfwhXQcI90bIuH06PGzfOPB3trjPO83PT3C0GtaNAZ7NDQil2
 QfKvoM7NRdRJnR5yG6PSRDM3FSlIx84SXIgUwDN5rcMYKluYWiRstz75Ok9uAgSJVBJWicOdLn1
 iG2LcZoWXcREGCG8OeX72H0BvVrdWfU5Ngd90wfSIJIlyvMBLNUeyQotmKdgW5+q0w8z2HnGBz0
 bgurA9pT0GefU/Hd33WAtD7o=
X-Received: by 2002:a05:600c:1991:b0:49e:663c:c67e with SMTP id
 5b1f17b1804b1-49e663cc7cdmr8298135e9.25.1789117325866; 
 Fri, 11 Sep 2026 02:02:05 -0700 (PDT)
X-Received: by 2002:a05:600c:1991:b0:49e:663c:c67e with SMTP id
 5b1f17b1804b1-49e663cc7cdmr8297255e9.25.1789117325274; 
 Fri, 11 Sep 2026 02:02:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ad08fcsm58970875e9.11.2026.09.11.02.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:04 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL v2 19/75] migration/fd: add errp parameter to
 migration_fd_valid()
Message-ID: <f1da5048106084ba6add285a800f84ceaa2305f3.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Let migration_fd_valid() report the error itself, instead of
duplicating the error message in both callers. This also prepares
for adding one more check (with a different error message) to the
function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-12-vsementsov@yandex-team.ru>
---
 migration/fd.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index 02b39b150e..78a27caca2 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -37,16 +37,14 @@ static bool fd_is_pipe(int fd)
     return S_ISFIFO(statbuf.st_mode);
 }
 
-static bool migration_fd_valid(int fd)
+static bool migration_fd_valid(int fd, Error **errp)
 {
-    if (fd_is_socket(fd)) {
-        return true;
-    }
-
-    if (fd_is_pipe(fd)) {
+    if (fd_is_socket(fd) || fd_is_pipe(fd)) {
         return true;
     }
 
+    error_setg(errp, "fd: migration to a file is not supported."
+               " Use file: instead.");
     return false;
 }
 
@@ -59,9 +57,7 @@ QIOChannel *fd_connect_outgoing(MigrationState *s, const char *fdname,
         goto out;
     }
 
-    if (!migration_fd_valid(fd)) {
-        error_setg(errp, "fd: migration to a file is not supported."
-                   " Use file: instead.");
+    if (!migration_fd_valid(fd, errp)) {
         close(fd);
         goto out;
     }
@@ -95,9 +91,7 @@ void fd_connect_incoming(const char *fdname, Error **errp)
         return;
     }
 
-    if (!migration_fd_valid(fd)) {
-        error_setg(errp, "fd: migration to a file is not supported."
-                   " Use file: instead.");
+    if (!migration_fd_valid(fd, errp)) {
         close(fd);
         return;
     }
-- 
MST


