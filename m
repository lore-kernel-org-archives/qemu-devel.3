Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DF9C3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 16:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6oe-0004jZ-Pk; Tue, 25 Mar 2025 12:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6oC-0004VL-Ez
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6oA-0007PJ-Hx
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742918835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjFF7/NAnTPz1YSqozhAn7Ks81w0e1zU5LPdNmpLML8=;
 b=ei8t3ds+Ds0v4EHFovElFwxLYYbotIg6mbcaJ0OnTKriGr7cuk4H6UK3FC7KCIWaibC7xF
 A3lTUje+4N0VRNyEfBf5E9dPOU5fVvzLTvYORnykJyAYMEo+xV8oOe5/U1HTyxwM809qMb
 OZrdNZymHjoRjZeN3UTstRiLnKBzDD4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-VsC58CdeM1WAo8h1dX5nwg-1; Tue, 25 Mar 2025 12:07:13 -0400
X-MC-Unique: VsC58CdeM1WAo8h1dX5nwg-1
X-Mimecast-MFC-AGG-ID: VsC58CdeM1WAo8h1dX5nwg_1742918832
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so49082065e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 09:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742918832; x=1743523632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjFF7/NAnTPz1YSqozhAn7Ks81w0e1zU5LPdNmpLML8=;
 b=gyAugOK7y8qdgbeHdc/iCSqZ+D2oHu8Y8Au0v+Ef3Jm/IDkMIrInSGItxagBW7lAKf
 ZFNZA7VTQIun4Px+ZBd1DqOOwob+WONRhXlh6QCf6aMADtSux7Oh4gZXB51EW5NSrwUi
 UvPoGEKNwFkSYCBaFfYPCSwSIJ/J9gJynzxwQw+9hiYQjsy38RDgxgtjv+1UnW4Rqn49
 py1i0ArUKgvd21KOkfnqBZBT5JvcrW/12O6yH/hA2xdFPq/1NdJaQDDS7fZCNCW+UiPW
 fjvdcbjiPvYnP6scsiUU0KcDftq5eutUUIlMgTOSCDtttSFDMLWhjqRg9ipsC9f2Byyo
 9Y+w==
X-Gm-Message-State: AOJu0YxEt0U2xVN98JxiWS8NE+kSivCOY6Lssw3IO1g2AaSvpc1Jjucl
 UGdmfi/tyAT/wgFSlaqM3o/hRP5W5+TO+l/QGENCF8TK8GNgwymRdlDbZtyw/b3MX+xDlTsW5rq
 vN+F7PfwCpPH5pGopcLdEpIdoQdlTyHa34y5QFpz7xmRCga+9wfXM
X-Gm-Gg: ASbGnctW/1TYrQaLPo3jCNfKPY4WLNQEveLMrBN6ACfFuCbO8f/vVhVsoQ9F9ixyaIU
 Tj/kfrrAx/EDGYrIFYlKt2Sp3/JY6FdkZfuUsswHmjxZxHW/dykKMWrMPVeIjasGGYVfBiqSauG
 3qX4VONtzChhnyHqp9kbo30UJr2x8XZMNoEdyZoRIjR5C1cDYSTdvpOfV+irknj+Br9LQtbziyP
 Pb9ahrjXWA5CLkavqGr5P1kc3bHnYQPoajRZ/6NB70RSf5EV+uVk1hqzl48XiSv79o25AtzjDGF
 a45fHbrQ8ZfvTXa/0GfEikGTpUQ5BX5ck8vkolIpPlVheLdmJFL/BXuCrwKxoDVGr65W+h1vrQ=
 =
X-Received: by 2002:a05:600c:4512:b0:43c:f87c:24ce with SMTP id
 5b1f17b1804b1-43d50a3781amr120915875e9.21.1742918832346; 
 Tue, 25 Mar 2025 09:07:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUBgrGpYPXbqZB6tLBOLQtQlBqo13vqTWJnk1A1xcnG1uyuXkYtseU9zsy2hosH8lYgud0OQ==
X-Received: by 2002:a05:600c:4512:b0:43c:f87c:24ce with SMTP id
 5b1f17b1804b1-43d50a3781amr120915145e9.21.1742918831558; 
 Tue, 25 Mar 2025 09:07:11 -0700 (PDT)
Received: from localhost
 (p200300cfd74f9db6ee8035b86ef736e5.dip0.t-ipconnect.de.
 [2003:cf:d74f:9db6:ee80:35b8:6ef7:36e5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d6eab2466sm14707875e9.1.2025.03.25.09.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 09:07:09 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 06/15] fuse: Fix mount options
Date: Tue, 25 Mar 2025 17:06:46 +0100
Message-ID: <20250325160655.119407-5-hreitz@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325160529.117543-1-hreitz@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c        | 14 +++++++++++---
 tests/qemu-iotests/308     |  4 ++--
 tests/qemu-iotests/308.out |  3 ++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 7bdec43b5c..0d20995a0e 100644
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
index ea81dc496a..266b109ff3 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -177,7 +177,7 @@ stat -c 'Permissions pre-chmod: %a' "$EXT_MP"
 chmod u+w "$EXT_MP" 2>&1 | _filter_testdir | _filter_imgfmt
 stat -c 'Permissions post-+w: %a' "$EXT_MP"
 
-# But that we can set, say, +x (if we are so inclined)
+# Same for other flags, like, say +x
 chmod u+x "$EXT_MP" 2>&1 | _filter_testdir | _filter_imgfmt
 stat -c 'Permissions post-+x: %a' "$EXT_MP"
 
@@ -235,7 +235,7 @@ output=$($QEMU_IO -f raw -c 'write -P 42 1M 64k' "$TEST_IMG" 2>&1 \
 
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
2.48.1


