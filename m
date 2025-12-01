Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C27D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 18:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ8DO-0004Sp-AB; Mon, 01 Dec 2025 13:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vQ8D2-0004Sd-3o
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 13:01:12 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vQ8Cx-00084v-8D
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 13:01:11 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5959d9a8eceso3926547e87.3
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 10:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764612060; x=1765216860; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+rrPKU+C+PoV3fBCCNpUSodQaRGibhXiLY/RrjSQ7tg=;
 b=IMa3E2wBvVNfX4Fztcyk362VkO0U5Ane/fMS3TALYP7Dc8SP0Yl9IxWudS4N1ntLpu
 Js5r/Cjwhi6X2cRl5/GOXwKplau80b7FbSPmQgjYonWQGn5J50hJaH5OH8vhu2nZ8vdo
 v633iaRmwifXNo79JLQPCG6V5D28TZT8tA0Rv8gU/pdMs5KUp6jUzNWF7te9EcK806y7
 CM3UIpprpGj4Udkgm1iNWx72BsThdYGUQzzJAmrpJM9ZlrbMOIC79/kSMCkSD0qaJxoG
 iAV12gD+M4QMicKwYqkrP4OPftXm2oU2MlJ0qv/pP0CV0lF9QzScXfpUPL+qyxYtfXI5
 qijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764612060; x=1765216860;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+rrPKU+C+PoV3fBCCNpUSodQaRGibhXiLY/RrjSQ7tg=;
 b=pSu0GfYbGrYx0sdVYmP1TTK1ivPgllKTBHYJybe2urPGFXFvxPECpsNj9n0IxLmU3+
 TJYr1OeHkNWR8q/T5fCij4XFnBvEHi/axktzA8u+FEdgQSiERcoS7QgpnD4ox/lwuPSC
 0pNkmwFP2YNQAWL6kmgTiccZBl6Mpd5RJEVVFu3WJuLwDCnDrUOOAAFV1RcaUn5hdXeU
 9Zb8L5//Bihr2D6arzthTUZZZRtZhtp4ywDRnQtJD1GSqXAF0Mj1wviKU0iA/ge91wC/
 qRmS7F7iJuTqI4R0OE5ya5DqFEeZkQO6Gyhhklb/5imyMwQzkDci/6SXd0wlH0fC/mc5
 TIvQ==
X-Gm-Message-State: AOJu0YzD0X35N1m7A9dVLo/YzgOJtlwyHk0i92AP0XYduSfTRvofur/z
 W9M6XRUe+Is1+Gn7d8FAq+Oioo+K4Yaiy9mp47XeW+ARxyZIzYj8WJqFMWltBw==
X-Gm-Gg: ASbGncs6fwYQmRbQh9/1PvuXOrQkrLpzN19JWLHx8Ap+sSz/HNxc1iJKeISHoKicAlC
 FdtzXACe3aiMLzEjhfX1UYjOGFQXaKstIf6ThzLdnSv5HKOzu1MH8noyRR16cUo4ie1AGWt1WSL
 zQEEhjgBd25eHACI5vr4lBdcB3oQ35OhWUezpbARJEhznwGQ51kzdKusKudEVDAgkeV0KBUt3Ub
 gk4QWLm1SV/lQTeq+PckdK7z1x/rgX/0vO2yCa2D+waqM9huEhdj6rrP1vyVjnHKJu1fexYIKO8
 vdMfX5dqSPmILsU/mhBxD1+xE4Rku03gbSqr/y3m7yjGKAFdnxJwZFZInBlUepqujKlVpnlQaTY
 Gz/6ddSYMRFEAZCqhaKLtkuFMCym7jeLfM7iTBzKY3Wu7cgjZO7Bux23kbDlaLAH3Q7bDEKTdPd
 oCSeehrIlGzWNGGqHRGX7pQQ==
X-Google-Smtp-Source: AGHT+IF9D/PhLbsIrZsfFjeYtbUAGm61YH/8cIJoq5JXTO8Q78quhWj7ppGP01fKVPLpmWbGDVxNWQ==
X-Received: by 2002:a05:6512:4005:b0:594:7380:98c0 with SMTP id
 2adb3069b0e04-596a3ea9d32mr13479345e87.17.1764612059443; 
 Mon, 01 Dec 2025 10:00:59 -0800 (PST)
Received: from [192.168.88.252] ([82.215.83.93])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-596bf8a7cffsm3850429e87.18.2025.12.01.10.00.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 10:00:57 -0800 (PST)
Message-ID: <fe7665bc-5ff6-4f78-82b7-1bea853583e3@gmail.com>
Date: Mon, 1 Dec 2025 23:00:53 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
From: Andrey Erokhin <language.lawyer@gmail.com>
Subject: [RFC PATCH] virtfs: 9p: local: add default uid and gid options
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=language.lawyer@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I was trying to boot from a directory tree owned by an ordinary user,
and some daemons weren't happy about non-root ownership of some files

Example use:
-virtfs local,path=rootfs,mount_tag=root,security_model=mapped,uid=0,gid=0

Works with any security_model

Signed-off-by: Andrey Erokhin <language.lawyer@gmail.com>
---
 fsdev/file-op-9p.h      |  5 +++++
 fsdev/qemu-fsdev-opts.c | 12 ++++++++++++
 fsdev/qemu-fsdev.c      |  2 ++
 hw/9pfs/9p-local.c      | 15 +++++++++++++++
 hw/9pfs/9p.c            |  2 ++
 system/vl.c             |  9 +++++++++
 6 files changed, 45 insertions(+)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index b9dae8c84c..46fb88001e 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -15,6 +15,7 @@
 #define FILE_OP_9P_H
 
 #include <dirent.h>
+#include <sys/types.h>
 #include <utime.h>
 #include "qemu-fsdev-throttle.h"
 #include "p9array.h"
@@ -94,6 +95,8 @@ typedef struct FsDriverEntry {
     FsThrottle fst;
     mode_t fmode;
     mode_t dmode;
+    uid_t dflt_uid;
+    gid_t dflt_gid;
 } FsDriverEntry;
 
 struct FsContext {
@@ -107,6 +110,8 @@ struct FsContext {
     void *private;
     mode_t fmode;
     mode_t dmode;
+    uid_t dflt_uid;
+    gid_t dflt_gid;
 };
 
 struct V9fsPath {
diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
index 07a18c6e48..c99abb3de6 100644
--- a/fsdev/qemu-fsdev-opts.c
+++ b/fsdev/qemu-fsdev-opts.c
@@ -46,6 +46,12 @@ static QemuOptsList qemu_fsdev_opts = {
         }, {
             .name = "dmode",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "uid",
+            .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "gid",
+            .type = QEMU_OPT_NUMBER,
         },
 
         THROTTLE_OPTS,
@@ -92,6 +98,12 @@ static QemuOptsList qemu_virtfs_opts = {
         }, {
             .name = "dmode",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "uid",
+            .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "gid",
+            .type = QEMU_OPT_NUMBER,
         },
 
         { /*End of list */ }
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 57877dad0a..faa84dc033 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -58,6 +58,8 @@ static FsDriverTable FsDrivers[] = {
             "writeout",
             "fmode",
             "dmode",
+            "uid",
+            "gid",
             "multidevs",
             "throttling.bps-total",
             "throttling.bps-read",
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 5ce97b76a6..cecf4aa50c 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -198,6 +198,12 @@ static int local_lstat(FsContext *fs_ctx, V9fsPath *fs_path, struct stat *stbuf)
     if (err) {
         goto err_out;
     }
+    if (fs_ctx->dflt_uid != -1) {
+        stbuf->st_uid = fs_ctx->dflt_uid;
+    }
+    if (fs_ctx->dflt_gid != -1) {
+        stbuf->st_gid = fs_ctx->dflt_gid;
+    }
     if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
         /* Actual credentials are part of extended attrs */
         uid_t tmp_uid;
@@ -788,6 +794,12 @@ static int local_fstat(FsContext *fs_ctx, int fid_type,
     if (err) {
         return err;
     }
+    if (fs_ctx->dflt_uid != -1) {
+        stbuf->st_uid = fs_ctx->dflt_uid;
+    }
+    if (fs_ctx->dflt_gid != -1) {
+        stbuf->st_gid = fs_ctx->dflt_gid;
+    }
     if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
         /* Actual credentials are part of extended attrs */
         uid_t tmp_uid;
@@ -1570,6 +1582,9 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
         return -1;
     }
 
+    fse->dflt_uid = qemu_opt_get_number(opts, "uid", -1);
+    fse->dflt_gid = qemu_opt_get_number(opts, "gid", -1);
+
     if (fse->export_flags & V9FS_SM_MAPPED ||
         fse->export_flags & V9FS_SM_MAPPED_FILE) {
         fse->fmode =
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index acfa7db4e1..492379d361 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -4317,6 +4317,8 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
 
     s->ctx.fmode = fse->fmode;
     s->ctx.dmode = fse->dmode;
+    s->ctx.dflt_uid = fse->dflt_uid;
+    s->ctx.dflt_gid = fse->dflt_gid;
 
     s->fids = g_hash_table_new(NULL, NULL);
     qemu_co_rwlock_init(&s->rename_lock);
diff --git a/system/vl.c b/system/vl.c
index 3b7057e6c6..d363b046a6 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3253,6 +3253,7 @@ void qemu_init(int argc, char **argv)
                 QemuOpts *fsdev;
                 QemuOpts *device;
                 const char *writeout, *sock_fd, *socket, *path, *security_model,
+                           *uid, *gid,
                            *multidevs;
 
                 olist = qemu_find_opts("virtfs");
@@ -3301,6 +3302,14 @@ void qemu_init(int argc, char **argv)
                     qemu_opt_set(fsdev, "security_model", security_model,
                                  &error_abort);
                 }
+                uid = qemu_opt_get(opts, "uid");
+                if (uid) {
+                    qemu_opt_set(fsdev, "uid", uid, &error_abort);
+                }
+                gid = qemu_opt_get(opts, "gid");
+                if (gid) {
+                    qemu_opt_set(fsdev, "gid", gid, &error_abort);
+                }
                 socket = qemu_opt_get(opts, "socket");
                 if (socket) {
                     qemu_opt_set(fsdev, "socket", socket, &error_abort);
-- 
2.34.1

