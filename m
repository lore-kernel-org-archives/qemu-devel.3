Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC194F4180C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcEb-0000mU-Ic; Mon, 09 Mar 2026 11:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEZ-0000kj-Nm
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEY-0008LE-0J
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AjTAaQSicICfePI7g/xK9ptOOj5Iscs1cOcgIpNiDzQ=;
 b=MSD4esEVA6HEwGH+0nIXGCsGd213RktvGQGqbGfg2edwxG11rX9gYbAcGtm0HmjAfu6Xr+
 H6UgTtv4fI8B7XTFC2iRbSfiLDYDDXql6hQjM8AodDLi9chYpCo15xbn9OzePZsvmZUO6P
 5kVI6Yu0utRoFXYGjK+fvFh9HTGysF0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-gvZQ0n7VOYKaZw-cIQr0Vg-1; Mon, 09 Mar 2026 11:09:24 -0400
X-MC-Unique: gvZQ0n7VOYKaZw-cIQr0Vg-1
X-Mimecast-MFC-AGG-ID: gvZQ0n7VOYKaZw-cIQr0Vg_1773068963
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439c12269f3so4037781f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068963; x=1773673763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AjTAaQSicICfePI7g/xK9ptOOj5Iscs1cOcgIpNiDzQ=;
 b=DK/aw4eGuPwq/LFfwEbZD8VqsWW78vDMYMSUVO4WOvYkKqgsDSbyQr6NBY7AxiJLXT
 7mZWReDTaJGsM1i4efTSh/7Dml4L319qTOtERCvxRH1IRJNPodjtNux5ZB2QbMkbkECt
 Pe0H6wZmHsL6BCMnDr22AB0ZIAwUgjC6SDyLCo/a6v2kBz/WsujPjKa2srMzu6dyOf/m
 t0dHGTIVy7lox/KsTFMkrNsA0y6b2KkshAxTEdVUoI/igQQXcHMJIm1OWhx2l0eENo8F
 rQxV063RSHwO2Of1QhYpPHwwPaQBU0ZNFeLC99b0xTWjrnrlLrExPc8PSfqrWaSpN0rm
 pxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068963; x=1773673763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AjTAaQSicICfePI7g/xK9ptOOj5Iscs1cOcgIpNiDzQ=;
 b=qTX8cG0rdWsKScdXy6aIob/ZK3Uc/WBmC86vXgtCEZM2zFzF8hAPMkTTxe5hUNj8g+
 ORESwI6qwgT3Y5uiq6HK6NHaSY9VAm0ZZd23wwXR7B8BgFQCX8WVjw3Nj/XEwet0LjKc
 LGff0jSp/HRny8nDDCyh8KRhpOTLyIsIx/orp/sHHSFk9rH5qIktXbOHVtwp0ExiweIN
 6LBaewRsl1XS01Az8jnjW9ZO4346RP/lYMpv50hs7VmQKSGiZckmrkUxqEkDqNr5pacc
 P1LwmGIzgW5QAUcGJEpFYvJhd5Wpu0wOooab+GOhPRECAdy5Ev3mWEZbuf+Ug/RWTkNV
 E1lQ==
X-Gm-Message-State: AOJu0Yz6rtu73o03S5YpPgi3P65MLWEKilLswsHRIyntI1bCGZR5jljP
 mw5rV5Rr+Yn2g9y8t1KkwWZAf+hIuxEJxkR+YJiabyVbs1xGYjK4LMP0ED2kKD64C7ljTXA2fZz
 Eo+iU19O4gAfHQ/vbo8TMVlGfUJHV/XugzIp9xne08YrC9jqZmH37u7JH
X-Gm-Gg: ATEYQzyWK9dVNJa2bk6cz154voT7eIKK/rQ6I7WVWL8t8qbURWDBN3DppJ2Wgexa+KR
 6L7vDrCRaw73jp+mJeAWzWcoWDbWS+n2MTZ7AEbHo8qO2HQmjMm0JNE5kprO2L+D0H7aUNgt1Ex
 tecG5psV1SM1EXRFYeRV+1GBdWgirBtGjvgnzmFjjPde6YA6Y4l1GTN1XAgLrTXq3Ar79IOzmxL
 0uh0cKHUcPgq8dwW1FxQywK8bIClk8pEH2FD3sHAp9PdG8H+Ttns023GLowK5LO9oRiNyj67Yzb
 T8xwMe46xA6c0G7j059EjsXHbL2CjzyKofs2ei4S/I/4al9ywQNhEUMWiPWK0hQsutvmWHJJbxz
 XKu1YpULtSQMu0J44PKfdI6XiCgTBwnTIW7S+RyX2aX7DkRWn03PqSt23FrC0zjSyTUSb/A4/F0
 kbnwYL
X-Received: by 2002:adf:ff89:0:b0:439:de1d:74c6 with SMTP id
 ffacd0b85a97d-439de1d76famr14577665f8f.19.1773068962639; 
 Mon, 09 Mar 2026 08:09:22 -0700 (PDT)
X-Received: by 2002:adf:ff89:0:b0:439:de1d:74c6 with SMTP id
 ffacd0b85a97d-439de1d76famr14577594f8f.19.1773068962097; 
 Mon, 09 Mar 2026 08:09:22 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8ec97sm29994966f8f.5.2026.03.09.08.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:21 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 07/25] fuse: Fix mount options
Date: Mon,  9 Mar 2026 16:08:38 +0100
Message-ID: <20260309150856.26800-8-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150856.26800-1-hreitz@redhat.com>
References: <20260309150856.26800-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
  Similarly, in fuse-allow-other, we must now make the export writable
  to use SETATTR.

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
 block/export/fuse.c                           | 14 +++++++++++---
 tests/qemu-iotests/308                        |  4 ++--
 tests/qemu-iotests/308.out                    |  3 ++-
 tests/qemu-iotests/tests/fuse-allow-other     |  3 ++-
 tests/qemu-iotests/tests/fuse-allow-other.out |  9 ++++++---
 5 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 82560ca071..0422cf4b8a 100644
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
diff --git a/tests/qemu-iotests/tests/fuse-allow-other b/tests/qemu-iotests/tests/fuse-allow-other
index 19f494aefb..eaa39f8f23 100755
--- a/tests/qemu-iotests/tests/fuse-allow-other
+++ b/tests/qemu-iotests/tests/fuse-allow-other
@@ -101,7 +101,8 @@ run_permission_test()
 
     fuse_export_add 'export' \
         "'mountpoint': '$EXT_MP',
-         'allow-other': '$1'"
+         'allow-other': '$1',
+         'writable': true"
 
     # Should always work
     echo '(Removing all permissions)'
diff --git a/tests/qemu-iotests/tests/fuse-allow-other.out b/tests/qemu-iotests/tests/fuse-allow-other.out
index 3219fc35e0..62660b40bf 100644
--- a/tests/qemu-iotests/tests/fuse-allow-other.out
+++ b/tests/qemu-iotests/tests/fuse-allow-other.out
@@ -12,7 +12,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
                   'id': 'export',
                   'node-name': 'node-format',
                   'mountpoint': 'TEST_DIR/fuse-export',
-         'allow-other': 'off'
+         'allow-other': 'off',
+         'writable': true
               } }
 {"return": {}}
 (Removing all permissions)
@@ -41,7 +42,8 @@ stat: cannot statx 'fuse-export': Permission denied
                   'id': 'export',
                   'node-name': 'node-format',
                   'mountpoint': 'TEST_DIR/fuse-export',
-         'allow-other': 'on'
+         'allow-other': 'on',
+         'writable': true
               } }
 {"return": {}}
 (Removing all permissions)
@@ -68,7 +70,8 @@ Permissions seen by nobody: 440
                   'id': 'export',
                   'node-name': 'node-format',
                   'mountpoint': 'TEST_DIR/fuse-export',
-         'allow-other': 'auto'
+         'allow-other': 'auto',
+         'writable': true
               } }
 {"return": {}}
 (Removing all permissions)
-- 
2.53.0


