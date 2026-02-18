Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1CEE9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshff-0004F3-Cv; Wed, 18 Feb 2026 08:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfR-0003yM-0z
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfA-0005GT-H7
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLvuW77pQ5x9M3qdYvEThGlMMRQ1FN319y82FStW6pw=;
 b=IuK+oieRBPbAHZ/PdGTg3HOp3VIzRwcwpMpn+WcQLUcTALzHNTjbV4dy8VZCFIcBztjEma
 F7eQfOBJAzZs54OdCKL5768EXo2ZzhUnwTnLIMe2/2aoRkIUUmpr5vWrVNYBRZvNTWH5Qv
 91BIoH3so7/vbaOAZ8ocUwmmM4sPUlo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-mM2CUbCqPAqmQL-72PjDug-1; Wed, 18 Feb 2026 08:27:03 -0500
X-MC-Unique: mM2CUbCqPAqmQL-72PjDug-1
X-Mimecast-MFC-AGG-ID: mM2CUbCqPAqmQL-72PjDug_1771421222
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4362456500eso5072545f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421222; x=1772026022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLvuW77pQ5x9M3qdYvEThGlMMRQ1FN319y82FStW6pw=;
 b=kZeWtETweoTM0EvS4KMJRSPB84n6SdJafqNl7hBgDfygtwwN1n3mi7JMA6InRe4Vz+
 HBcMHDDvt3WzXTrSXW/JAQw6H7cXhtHI8ZGxZjRtTtmhTw4Dzdyeli0MfQ5elmrw2hhu
 OBB0pB3Wem/rgIme0KxLFBslPs9XYCZ5yLizQoxAhO3P1ktR4hyevjG3b4+kAzh9e0Nb
 Ut/Snn+uH7f5FOwdFJQH2g/BV6ywZ1nDEPRohG6ArGYsdNB2dKbvmlWduNepP1yIaq3l
 Rb6eiwzdsgFW6BIbx+9iAhS+DheenxesBjFGv3co/pfhOyGa6Ht8OxrL3JEPaju0meb0
 VuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421222; x=1772026022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gLvuW77pQ5x9M3qdYvEThGlMMRQ1FN319y82FStW6pw=;
 b=lerPWVB7Pu2Xx2RkzLw/2XwpW3c2R9KsVS9wzAQRhe2S9ukBfAAXMNdHV2j8qA0/aM
 avo2HS/+2wa+cnkJ/pYrAVKMpyuox3OUA3vOVEURv4fSR39cxYpwV6kzzIwhuDytoLiS
 rlvHVSRvWw8YFYgByFiC+SeDKbhbDkS7aOsB2MIe/RI2pqYp+4Z+nIm7lQQyx+hH/w+H
 tA0QXXG792IU/Ha9S/AGy3/QwZ5OKMcBc1UOHwEldTAkQsVsRHTb2spm12oW3r3UAOuz
 F5hkuym/r2EOsKDrNwHU8TEXFOhpvkMsVVhtU4oEdxe5Z+NIzk2UiJ0KpUxApTqJb8D/
 liKQ==
X-Gm-Message-State: AOJu0Yy+tXNgPXQ2RMpTKQDF2+bYxwwKBMk2W+nPubTea1EpNaL8gdOc
 2mkWL/+jsFtxlhy8LSaB6LxrqWJ+IAwSC+M9n72/2DWblRbjuUNjd0zVEoOYCYyxjwkFo09+KwN
 g2viIQfX5076NYgSdSJNWUAF5AlQ2LEEEg0p1PsW4FnPIOSWTEy3kIxiT
X-Gm-Gg: AZuq6aIs2fyCJnRltZRVN1tqUgGf4BQYcB0lqr5qe0lDNbOi0feOxFDGDRpspq7ULru
 4hbKyOgua33j7c7voYtdCvFtU4D2ZLDnoXVqVggyfEyyyCco/czvERE8G69afGU0yQMczR7zJLH
 NyJT8vQ//WppU9pwxEVvKeUHjbtU9MvZAGluFMy4U3lDigWg06I40DEZnu4xZNcWLlLE893RAXy
 e3iWWXRC7xbgjJ/IUURNnHXEUqp0x+FUOAcnPaGEqxGmjSrmR2go93jmYFp1H6SPJICcrMsPBqa
 DXU6nZ8jOyVMW/6K71GnDluQxULEI0aTccbTb/d+/+QsOIUaNNtCMzxHIbExe8v+eWy8YgKns8R
 rSbMH5Peen9kZkPsYMVmqbhoapWFZbtQb5gaUFhqHcwP3IMhX9L5dLFt95zGwNb+zFR0MYbZ7Le
 pIn7KZ
X-Received: by 2002:a05:6000:4387:b0:437:75c1:5777 with SMTP id
 ffacd0b85a97d-43958e00726mr3005882f8f.16.1771421221778; 
 Wed, 18 Feb 2026 05:27:01 -0800 (PST)
X-Received: by 2002:a05:6000:4387:b0:437:75c1:5777 with SMTP id
 ffacd0b85a97d-43958e00726mr3005839f8f.16.1771421221290; 
 Wed, 18 Feb 2026 05:27:01 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8075sm40458516f8f.29.2026.02.18.05.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:26:59 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 07/24] fuse: Fix mount options
Date: Wed, 18 Feb 2026 14:26:16 +0100
Message-ID: <20260218132633.29748-8-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
-- 
2.53.0


