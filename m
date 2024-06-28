Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7F0C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPh-0005fM-9y; Fri, 28 Jun 2024 13:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPc-0005cw-Dz
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPa-0002Ba-KZ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d1Zs3bNs8jOuOgSShaHDoScFAM7FpjL8r/fpmfWVVwk=;
 b=T2DvYMeSkrHW+pXRHcprHrlc4xhJBPx6gtIXQ3TFHDe49iBDMRPhvWDamIw4l6C1g8z1Sn
 Nq/l9bCDQq8bMwM7BK2YyGnbQZ4CRngW5FyAlgmJEuCosbKaVo003Cx+p/Wn7GMl+cD1xb
 ghxweEkBg8Ssh+/BOXGTHx8S13AIofk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-eCMFgWWvNCCEdjaW6Gl44g-1; Fri, 28 Jun 2024 13:29:20 -0400
X-MC-Unique: eCMFgWWvNCCEdjaW6Gl44g-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7246c24b00so60618166b.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595759; x=1720200559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d1Zs3bNs8jOuOgSShaHDoScFAM7FpjL8r/fpmfWVVwk=;
 b=U2d9Atwq5GiN0w5SyjkkMoUbPy+od0W3MXs6aknIfEhXRyrmYXHz1iKttIgwI7cyXl
 22jvK3pVtt0TRSs298VAsYwhkyGUfk1Aa3tI7hP5xatM/NHXUdpxhjPD8vLNLochIhFM
 yerAxKZ1QN7gIVhRvmMXOGReR+H/5ddtzT19nrWx6lOH9cnXE6On4SMzD+euZrAdi0yB
 itwn2R6y1jvCaKNcl4V96YLhVYuxh+xkwLj2LJrjBHdZG+xHjZIoJjH1f4tFSBG5gsmY
 4e6hh64Pg4BXkRN/1Phrvj0YIlW+aoo5uqr34M0i2M3cQMsy3lLiMy0nCV65mqF8msBV
 Bq+A==
X-Gm-Message-State: AOJu0YyaTNeCHEiPkSqViYDghYTVFdrLXAGPJQjfAlqPuvlrbU0f0Cel
 J11TvQJ9/sH9M3wIQq4WRLwa8Qh0xhrFqrzxQtFSS5qgVKidMAa/RgLNh+iYnhnz55qMltvjf+w
 Ypsaz/x3avyLgubjqSTue/vWofR4uMZucBdShOLXnZwZ34mB8YcGxKknpD+JGRSQKIAZWbOlt7u
 XL/n+g7fCh6Xezn8whZG0mseHByyBcfywB21IO
X-Received: by 2002:a17:906:809:b0:a6f:55e8:b361 with SMTP id
 a640c23a62f3a-a7242cb7a68mr1020278766b.41.1719595758835; 
 Fri, 28 Jun 2024 10:29:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9oM5KVphqpXNh2OvO743ZmV9F4ZdWQ1mUzkAed/5NKkds+i/hWn0P0i0U3qonPkZKnPNHCA==
X-Received: by 2002:a17:906:809:b0:a6f:55e8:b361 with SMTP id
 a640c23a62f3a-a7242cb7a68mr1020277466b.41.1719595758352; 
 Fri, 28 Jun 2024 10:29:18 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf1d201sm95793666b.9.2024.06.28.10.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 10/23] block: rename former bdrv_file_open callbacks
Date: Fri, 28 Jun 2024 19:28:42 +0200
Message-ID: <20240628172855.1147598-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
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

Since there is no bdrv_file_open callback anymore, rename the implementations
so that they end with "_open" instead of "_file_open".  NFS is the exception
because all the functions are named nfs_file_*.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/blkio.c | 8 ++++----
 block/null.c  | 8 ++++----
 block/nvme.c  | 8 ++++----
 block/ssh.c   | 6 +++---
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index 1a38064ce76..3d9a2e764c3 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -713,7 +713,7 @@ static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
          * for example will fail.
          *
          * In order to open the device read-only, we are using the `read-only`
-         * property of the libblkio driver in blkio_file_open().
+         * property of the libblkio driver in blkio_open().
          */
         fd = qemu_open(path, O_RDWR, NULL);
         if (fd < 0) {
@@ -791,8 +791,8 @@ static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
     return 0;
 }
 
-static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
-                           Error **errp)
+static int blkio_open(BlockDriverState *bs, QDict *options, int flags,
+                      Error **errp)
 {
     const char *blkio_driver = bs->drv->protocol_name;
     BDRVBlkioState *s = bs->opaque;
@@ -1088,7 +1088,7 @@ static void blkio_refresh_limits(BlockDriverState *bs, Error **errp)
  */
 #define BLKIO_DRIVER_COMMON \
     .instance_size           = sizeof(BDRVBlkioState), \
-    .bdrv_open               = blkio_file_open, \
+    .bdrv_open               = blkio_open, \
     .bdrv_close              = blkio_close, \
     .bdrv_co_getlength       = blkio_co_getlength, \
     .bdrv_co_truncate        = blkio_truncate, \
diff --git a/block/null.c b/block/null.c
index 6fa64d20d86..4730acc1eb2 100644
--- a/block/null.c
+++ b/block/null.c
@@ -77,8 +77,8 @@ static void null_aio_parse_filename(const char *filename, QDict *options,
     }
 }
 
-static int null_file_open(BlockDriverState *bs, QDict *options, int flags,
-                          Error **errp)
+static int null_open(BlockDriverState *bs, QDict *options, int flags,
+                     Error **errp)
 {
     QemuOpts *opts;
     BDRVNullState *s = bs->opaque;
@@ -283,7 +283,7 @@ static BlockDriver bdrv_null_co = {
     .protocol_name          = "null-co",
     .instance_size          = sizeof(BDRVNullState),
 
-    .bdrv_open              = null_file_open,
+    .bdrv_open              = null_open,
     .bdrv_parse_filename    = null_co_parse_filename,
     .bdrv_co_getlength      = null_co_getlength,
     .bdrv_co_get_allocated_file_size = null_co_get_allocated_file_size,
@@ -304,7 +304,7 @@ static BlockDriver bdrv_null_aio = {
     .protocol_name          = "null-aio",
     .instance_size          = sizeof(BDRVNullState),
 
-    .bdrv_open              = null_file_open,
+    .bdrv_open              = null_open,
     .bdrv_parse_filename    = null_aio_parse_filename,
     .bdrv_co_getlength      = null_co_getlength,
     .bdrv_co_get_allocated_file_size = null_co_get_allocated_file_size,
diff --git a/block/nvme.c b/block/nvme.c
index c84914af6dd..3b588b139f6 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -889,7 +889,7 @@ out:
         qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)regs, 0, sizeof(NvmeBar));
     }
 
-    /* Cleaning up is done in nvme_file_open() upon error. */
+    /* Cleaning up is done in nvme_open() upon error. */
     return ret;
 }
 
@@ -967,8 +967,8 @@ static void nvme_close(BlockDriverState *bs)
     g_free(s->device);
 }
 
-static int nvme_file_open(BlockDriverState *bs, QDict *options, int flags,
-                          Error **errp)
+static int nvme_open(BlockDriverState *bs, QDict *options, int flags,
+                     Error **errp)
 {
     const char *device;
     QemuOpts *opts;
@@ -1630,7 +1630,7 @@ static BlockDriver bdrv_nvme = {
     .create_opts              = &bdrv_create_opts_simple,
 
     .bdrv_parse_filename      = nvme_parse_filename,
-    .bdrv_open                = nvme_file_open,
+    .bdrv_open                = nvme_open,
     .bdrv_close               = nvme_close,
     .bdrv_co_getlength        = nvme_co_getlength,
     .bdrv_probe_blocksizes    = nvme_probe_blocksizes,
diff --git a/block/ssh.c b/block/ssh.c
index 1344822ed85..27d582e0e3d 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -837,8 +837,8 @@ static int connect_to_ssh(BDRVSSHState *s, BlockdevOptionsSsh *opts,
     return ret;
 }
 
-static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
-                         Error **errp)
+static int ssh_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
+                    Error **errp)
 {
     BDRVSSHState *s = bs->opaque;
     BlockdevOptionsSsh *opts;
@@ -1362,7 +1362,7 @@ static BlockDriver bdrv_ssh = {
     .protocol_name                = "ssh",
     .instance_size                = sizeof(BDRVSSHState),
     .bdrv_parse_filename          = ssh_parse_filename,
-    .bdrv_open                    = ssh_file_open,
+    .bdrv_open                    = ssh_open,
     .bdrv_co_create               = ssh_co_create,
     .bdrv_co_create_opts          = ssh_co_create_opts,
     .bdrv_close                   = ssh_close,
-- 
2.45.2


