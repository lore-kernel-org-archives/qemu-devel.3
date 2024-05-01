Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FEDC10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 07:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s24d5-0000pF-NO; Wed, 01 May 2024 03:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s24d4-0000og-0A
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s24d2-0003XG-0b
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714549426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a071wxoJFSMOnEW+thcNMYVdUE4CQQSmwvCAmyMk60E=;
 b=O7a8TI3ClQ16bEYa7Vi0Y9+S+gyy8noX+7n8CvEtP+yG+7tOwzbRM/XgTMCl6rh/jr1EHN
 bkvd8Mf+LMly3XfTjZa1Ex1SR5rL681lHWYJJKCuQuFaZLXAGWf2Y4cqfl/pUbKKac9zfX
 qXFJ3fXuns0lvYIb5j0mIJmH5FC9HTo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-btxkCw0uORahVPX7_Hkz2w-1; Wed, 01 May 2024 03:43:44 -0400
X-MC-Unique: btxkCw0uORahVPX7_Hkz2w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DE8C80017B;
 Wed,  1 May 2024 07:43:44 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5DFC40C5C2;
 Wed,  1 May 2024 07:43:43 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 1/9] qga: guest-get-fsinfo: add optional
 'total-bytes-privileged' field
Date: Wed,  1 May 2024 10:43:32 +0300
Message-ID: <20240501074340.19641-2-kkostiuk@redhat.com>
In-Reply-To: <20240501074340.19641-1-kkostiuk@redhat.com>
References: <20240501074340.19641-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Since the commit 25b5ff1a86 ("qga: add mountpoint usage info to
GuestFilesystemInfo") we have 2 values reported in guest-get-fsinfo:
used = (f_blocks - f_bfree), total = (f_blocks - f_bfree + f_bavail) as
returned by statvfs(3).  While on Windows guests that's all we can get
with GetDiskFreeSpaceExA(), on POSIX guests we might also be interested in
total file system size, as it's visible for root user.  Let's add an
optional field 'total-bytes-privileged' to GuestFilesystemInfo struct,
which'd only be reported on POSIX and represent f_blocks value as returned
by statvfs(3).

While here, also tweak the docs to reflect better where those values
come from.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20240320161648.158226-2-andrey.drobyshev@virtuozzo.com
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-posix.c | 2 ++
 qga/commands-win32.c | 1 +
 qga/qapi-schema.json | 7 +++++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 26008db497..7df2d72e9f 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1569,8 +1569,10 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
         nonroot_total = used + buf.f_bavail;
         fs->used_bytes = used * fr_size;
         fs->total_bytes = nonroot_total * fr_size;
+        fs->total_bytes_privileged = buf.f_blocks * fr_size;
 
         fs->has_total_bytes = true;
+        fs->has_total_bytes_privileged = true;
         fs->has_used_bytes = true;
     }
 
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 6242737b00..6fee0e1e6f 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1143,6 +1143,7 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
     fs = g_malloc(sizeof(*fs));
     fs->name = g_strdup(guid);
     fs->has_total_bytes = false;
+    fs->has_total_bytes_privileged = false;
     fs->has_used_bytes = false;
     if (len == 0) {
         fs->mountpoint = g_strdup("System Reserved");
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index d5af155007..1b9039e4f5 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1026,7 +1026,10 @@
 #
 # @used-bytes: file system used bytes (since 3.0)
 #
-# @total-bytes: non-root file system total bytes (since 3.0)
+# @total-bytes: filesystem capacity in bytes for unprivileged users (since 3.0)
+#
+# @total-bytes-privileged: filesystem capacity in bytes for privileged users
+#     (since 9.1)
 #
 # @disk: an array of disk hardware information that the volume lies
 #     on, which may be empty if the disk type is not supported
@@ -1036,7 +1039,7 @@
 { 'struct': 'GuestFilesystemInfo',
   'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
            '*used-bytes': 'uint64', '*total-bytes': 'uint64',
-           'disk': ['GuestDiskAddress']} }
+           '*total-bytes-privileged': 'uint64', 'disk': ['GuestDiskAddress']} }
 
 ##
 # @guest-get-fsinfo:
-- 
2.44.0


