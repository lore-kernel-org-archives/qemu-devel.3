Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A416D59D72
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 21:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFgY5-0005En-Nf; Mon, 25 Nov 2024 16:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFgY1-0005DF-L2
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 16:23:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFgXz-0001FP-7w
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 16:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732569786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8pesJWlkCFKpjvMcKW83UfoOrOC2UC1pwNeHxKcKo0E=;
 b=XLcGs1wlDCb/log0C0GfktzJqyr4lcaUcRJRv1OfWStTPVP4KpAqrq2i0rzpWOoHh+YYIF
 oOQOjEerCMcOq2yOibSIh8IWQJbcEDSrWLt0N99N0z7CdtOeRTqwz0euvkt9cyAbZyLq7m
 RJIxaqD4BwlPcjhVfn25MrlcpDZag7c=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-IIq4GtrJNFegv0QL2HJ5gg-1; Mon, 25 Nov 2024 16:23:04 -0500
X-MC-Unique: IIq4GtrJNFegv0QL2HJ5gg-1
X-Mimecast-MFC-AGG-ID: IIq4GtrJNFegv0QL2HJ5gg
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3a77a0ca771so34459695ab.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 13:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732569782; x=1733174582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8pesJWlkCFKpjvMcKW83UfoOrOC2UC1pwNeHxKcKo0E=;
 b=rs8jlrhN7OmTwFzYLmcyoWvCQ7d6YZP5iFybl0GPds92H5zAy5Uw6+X87lMMRu+L11
 9UMCuKxqITStUP0OsTnKwHjBD8VzT9vVE80RMCuLLRvmfC7ahpW/l0uDLguGCFOjBiGh
 Et6h4UkQd2zulvmRk4W0fywBJzpsPKfbigd5kcREyJU7pXsK4ogPGeOyV+bSBjP5ch16
 MRGTxujZya9gCGX9PnNaL4Hdqb2YpKSpVhRWYHkUXEJHlk5sQFgkvBgzhBFCkvA0vilD
 Wm4WNWFlVb1g8Lr3j60JCDtC8ayr0v1GqGzegghnwTpE8ed8hAabUi/6c7IcrbY2VMoO
 a8sw==
X-Gm-Message-State: AOJu0YxFpE/+xn1EGzJkvMa8LG5L/bgycHjNHURAfGc4/gzQnMGsJMKq
 CZCn7sfP2XL1Zb1z7WV1GKMgwlyScAV+iheUNgvcShXjgVz4J1Vs2pdVmwjwyuJLMunicCH6bwd
 PMpBtFOahD9/KDpDKr4hL35o5EAtdtsjYxUSzUlKbC+zWGpjX9NyWlMCgyQ23vTVv4R+oZAuQV6
 6JWxczoG09HhTCwMRyOi5PxOmJuw4vv1odgA==
X-Gm-Gg: ASbGncuP74yxxYchB1B9bF4LlOm2nNdFZI2Ypn2uGFWka4ZiYODLDsXhNCmN03aAzzs
 2ij3ol1U/CxZ3g/QxyrbNqPpY3/XS+ud17rOCotyibZZDxtytXj3TKmFA0wg+4Qk7e4XfEiRS39
 w6wrrBAHR5UNvxlH06P3HVdmZof/rCpddjegvGdxo2TJWcRlOeaQZMNwnGQiEBBAC7tuJCS0Qrk
 XjPx1kqgfjg5xkJA1bEJ79rYCczMsceRceF9O7Igbtbd28RRSb3w9Zz5nh1YCOwcvQc++Do975r
 HbnWTYI6FxM8RQVJLw5SmdStWg==
X-Received: by 2002:a92:cda3:0:b0:3a3:b3f4:af42 with SMTP id
 e9e14a558f8ab-3a79adbb0e4mr131636125ab.7.1732569780949; 
 Mon, 25 Nov 2024 13:23:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmkRBwe2Uwnrjxh7ZR3dHpUBQsaFZLpzRzPHnvRPZTj4TzGzH4JgEasa31RdyNQ3ZvCkwy0A==
X-Received: by 2002:a92:cda3:0:b0:3a3:b3f4:af42 with SMTP id
 e9e14a558f8ab-3a79adbb0e4mr131635925ab.7.1732569780615; 
 Mon, 25 Nov 2024 13:23:00 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a79acb7b6fsm18989815ab.67.2024.11.25.13.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 13:22:59 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 peterx@redhat.com, qemu-stable <qemu-stable@nongnu.org>,
 Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 1/2] migration: Allow pipes to keep working for fd migrations
Date: Mon, 25 Nov 2024 16:22:55 -0500
Message-ID: <20241125212256.62608-2-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125212256.62608-1-peterx@redhat.com>
References: <20241125212256.62608-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Libvirt may still use pipes for old file migrations in fd: URI form,
especially when loading old images dumped from Libvirt's compression
algorithms.

In that case, Libvirt needs to compress / uncompress the images on its own
over the migration binary stream, and pipes are passed over to QEMU for
outgoing / incoming migrations in "fd:" URIs.

For future such use case, it should be suggested to use mapped-ram when
saving such VM image.  However there can still be old images that was
compressed in such way, so libvirt needs to be able to load those images,
uncompress them and use the same pipe mechanism to pass that over to QEMU.

It means, even if new file migrations can be gradually moved over to
mapped-ram (after Libvirt start supporting it), Libvirt still needs the
uncompressor for the old images to be able to load like before.

Meanwhile since Libvirt currently exposes the compression capability to
guest images, it may needs its own lifecycle management to move that over
to mapped-ram, maybe can be done after mapped-ram saved the image, however
Dan and PeterK raised concern on temporary double disk space consumption.
I suppose for now the easiest is to enable pipes for both sides of "fd:"
migrations, until all things figured out from Libvirt side on how to move
on.

And for "channels" QMP interface support on "migrate" / "migrate-incoming"
commands, we'll also need to move away from pipe.  But let's leave that for
later too.

So far, still allow pipes to happen like before on both save/load sides,
just like we would allow sockets to pass.

Cc: qemu-stable <qemu-stable@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Peter Krempa <pkrempa@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Fixes: c55deb860c ("migration: Deprecate fd: for file migration")
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20241120160132.3659735-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/fd.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index aab5189eac..9bf9be6acb 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -25,6 +25,29 @@
 #include "io/channel-util.h"
 #include "trace.h"
 
+static bool fd_is_pipe(int fd)
+{
+    struct stat statbuf;
+
+    if (fstat(fd, &statbuf) == -1) {
+        return false;
+    }
+
+    return S_ISFIFO(statbuf.st_mode);
+}
+
+static bool migration_fd_valid(int fd)
+{
+    if (fd_is_socket(fd)) {
+        return true;
+    }
+
+    if (fd_is_pipe(fd)) {
+        return true;
+    }
+
+    return false;
+}
 
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp)
 {
@@ -34,7 +57,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
         return;
     }
 
-    if (!fd_is_socket(fd)) {
+    if (!migration_fd_valid(fd)) {
         warn_report("fd: migration to a file is deprecated."
                     " Use file: instead.");
     }
@@ -68,7 +91,7 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
         return;
     }
 
-    if (!fd_is_socket(fd)) {
+    if (!migration_fd_valid(fd)) {
         warn_report("fd: migration to a file is deprecated."
                     " Use file: instead.");
     }
-- 
2.47.0


