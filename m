Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CCBC8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZQM-0005Hj-MQ; Tue, 01 Jul 2025 07:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQI-0005Fk-Jk
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQA-0003Se-Sq
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y7T0WUQX6dKp3F4OQGLY2PFpVPrz9o7a5DFL8e21WBo=;
 b=LrnBlQuf698UQERNPmA5JeKPPHmQwqZxY5Xkc2JR8gnO5tt8Ghh8+LOrXs2ZC7zpjWwaCb
 1ZXKMuIrIk/X5/+w1lNrGaDlhSTqfmRUeF7oXXicPiy5svMJ3R9iU1BjxgKqvc7VwB+KrB
 oS4i/2es7QLNGqfufyZoNA98bZSKQMg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-V8hCM8NpMNaiEQKb4kF5-Q-1; Tue, 01 Jul 2025 07:45:04 -0400
X-MC-Unique: V8hCM8NpMNaiEQKb4kF5-Q-1
X-Mimecast-MFC-AGG-ID: V8hCM8NpMNaiEQKb4kF5-Q_1751370303
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450de98b28eso30671895e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370303; x=1751975103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7T0WUQX6dKp3F4OQGLY2PFpVPrz9o7a5DFL8e21WBo=;
 b=RovdqRIWQPQEi+PUCk4atP9IdhwKMfVhWzJv7CYPAl94kB5ya3TF6DU5xvqNuuoVgb
 Ww/tsP6rUuHV/71/sfQpPWDicj03O167DVotRIDKZ+YCap9BsRv2WYDUPOVXsOfp5IZu
 w0FWm2BPbnx69vLJDXCbpexe8OnYzo9URVbWXCIbp+NR0Sf4VMXbsTB/2l/5kZlN4e8f
 KWwDN2mRaYcwY4wW/MDTM0iOHYAQ5lsPEyKgOYNzrThSdICO3MPJldlAH84RqF+YSvYm
 NFLyl9v3IrrTswyxz2ecJ0M7MnLvd7DRFJzFTY0tesbhuWvG+KXpeD0H0Iu0Fs8u6Dc0
 JE6w==
X-Gm-Message-State: AOJu0YyjeWbLGJNYThISoKxCPElAfMnIg551p3+Ops+Gh8tdwzTyTnxN
 /rVh2RHweDTPI3gCrMxenCrHj6C5KEAterj6DjI4Xgrezz3uN+lQQHb6QrjxjncGezTf7SgIX/F
 AlwuZ66IBekLxytXqotwnWLAyuMaTbqYUVQ+Nfv6VXL914A92hZq+Sm5H
X-Gm-Gg: ASbGncsUfE2/lvvIkb1vcjaOHyUQz4ZkYXcy9hwqre6o78gUb1NQH/eVS15i3goxY5X
 JrbZO5XdhjV5o2CaC6jAKmgfn3Fxrm5n5Dx5vYsiosCxgsJzOrG3r8Is4qIYGEyPo/kwWau0poo
 kr2NSJdL/Ly0O+UlqH4N94UQbnYPx5peOo0KOolHHgArrTr8KGcGACYP+N6t1FPF4uCmEhLpBtC
 JibgBmkRc4eDFbld5ndc0BS8hy6bWvX2Lxm8O9Rg5EgCGmLmL793o6WxwSj6rVqZQiWBWZ5ge3r
 GdgyQGUupGTrU4ZgSEacemYu7nOQQkxvk77De8kJqtq+7vqhFd7qMZCgGHALsLkJcK0THkiCMIW
 yNXgP
X-Received: by 2002:a05:6000:4603:b0:3a5:23c6:eeee with SMTP id
 ffacd0b85a97d-3afb0247991mr1961373f8f.21.1751370303153; 
 Tue, 01 Jul 2025 04:45:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmjBvzQ/5k50VZZc5Jyr7+TLPvBxhbHjQhsPVZGTVtF2xObUsjRv7C1LPflqlKzQyj2hqjtg==
X-Received: by 2002:a05:6000:4603:b0:3a5:23c6:eeee with SMTP id
 ffacd0b85a97d-3afb0247991mr1961331f8f.21.1751370302587; 
 Tue, 01 Jul 2025 04:45:02 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80b5a3sm12899457f8f.40.2025.07.01.04.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:45:00 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 06/21] fuse: Fix mount options
Date: Tue,  1 Jul 2025 13:44:22 +0200
Message-ID: <20250701114437.207419-7-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Since I actually took a look into how mounting with libfuse works[1], I
now know that the FUSE mount options are not exactly standard mount
system call options.  Specifically:
- We should add "nosuid,nodev,noatime" because that is going to be
  translated into the respective MS_ mount flags; and those flags make
  sense for us.
- We can set rw/ro to make the mount writable or not.  It makes sense to
  set this flag to produce a better error message for read-only exports
  (EROFS instead of EACCES).
  This changes behavior as can be seen in iotest 308: It is no longer
  possible to modify metadata of read-only exports.

In addition, in the comment, we can note that the FUSE mount() system
call actually expects some more parameters that we can omit because
fusermount3 (i.e. libfuse) will figure them out by itself:
- fd: /dev/fuse fd
- rootmode: Inode mode of the root node
- user_id/group_id: Mounter's UID/GID

[1] It invokes fusermount3, an SUID libfuse helper program, which parses
    and processes some mount options before actually invoking the
    mount() system call.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c        | 14 +++++++++++---
 tests/qemu-iotests/308     |  4 ++--
 tests/qemu-iotests/308.out |  3 ++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 01a5716bdd..9d110ce949 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -246,10 +246,18 @@ static int mount_fuse_export(FuseExport *exp, Error **errp)
     int ret;
 
     /*
-     * max_read needs to match what fuse_init() sets.
-     * max_write need not be supplied.
+     * Note that these mount options differ from what we would pass to a direct
+     * mount() call:
+     * - nosuid, nodev, and noatime are not understood by the kernel; libfuse
+     *   uses those options to construct the mount flags (MS_*)
+     * - The FUSE kernel driver requires additional options (fd, rootmode,
+     *   user_id, group_id); these will be set by libfuse.
+     * Note that max_read is set here, while max_write is set via the FUSE INIT
+     * operation.
      */
-    mount_opts = g_strdup_printf("max_read=%zu,default_permissions%s",
+    mount_opts = g_strdup_printf("%s,nosuid,nodev,noatime,max_read=%zu,"
+                                 "default_permissions%s",
+                                 exp->writable ? "rw" : "ro",
                                  FUSE_MAX_BOUNCE_BYTES,
                                  exp->allow_other ? ",allow_other" : "");
 
diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
index 6eced3aefb..033d5cbe22 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -178,7 +178,7 @@ stat -c 'Permissions pre-chmod: %a' "$EXT_MP"
 chmod u+w "$EXT_MP" 2>&1 | _filter_testdir | _filter_imgfmt
 stat -c 'Permissions post-+w: %a' "$EXT_MP"
 
-# But that we can set, say, +x (if we are so inclined)
+# Same for other flags, like, say +x
 chmod u+x "$EXT_MP" 2>&1 | _filter_testdir | _filter_imgfmt
 stat -c 'Permissions post-+x: %a' "$EXT_MP"
 
@@ -236,7 +236,7 @@ output=$($QEMU_IO -f raw -c 'write -P 42 1M 64k' "$TEST_IMG" 2>&1 \
 
 # Expected reference output: Opening the file fails because it has no
 # write permission
-reference="Could not open 'TEST_DIR/t.IMGFMT': Permission denied"
+reference="Could not open 'TEST_DIR/t.IMGFMT': Read-only file system"
 
 if echo "$output" | grep -q "$reference"; then
     echo "Writing to read-only export failed: OK"
diff --git a/tests/qemu-iotests/308.out b/tests/qemu-iotests/308.out
index e5e233691d..aa96faab6d 100644
--- a/tests/qemu-iotests/308.out
+++ b/tests/qemu-iotests/308.out
@@ -53,7 +53,8 @@ Images are identical.
 Permissions pre-chmod: 400
 chmod: changing permissions of 'TEST_DIR/t.IMGFMT.fuse': Read-only file system
 Permissions post-+w: 400
-Permissions post-+x: 500
+chmod: changing permissions of 'TEST_DIR/t.IMGFMT.fuse': Read-only file system
+Permissions post-+x: 400
 
 === Mount over existing file ===
 {'execute': 'block-export-add',
-- 
2.49.0


