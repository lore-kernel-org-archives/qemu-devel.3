Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1A8CFD2EF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 20:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMu5T-0006F1-9o; Sat, 22 Nov 2025 15:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vMu59-00065n-CJ
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 15:19:44 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vMu4z-0005IV-QX
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 15:19:41 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-37b9d8122fdso24724841fa.3
 for <qemu-devel@nongnu.org>; Sat, 22 Nov 2025 12:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763842754; x=1764447554; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wC+7MZp7zBskO8XTQphUohwsHBK2MpO3LHeDEqzsQcM=;
 b=nSn+xVfk2LbUucIlYQ1+MNBL9+9x2QxxN1SKau0mGD7gRbn0IS6XhVfPRNzuCDx2fZ
 RqrUzeJsMjPYsm65GbiI4PPh95hKcI9k94ANa+eagenCBLXXUsNwi+cLtLfqHEaJytG7
 nNcDg8yxozpTo4WcLsIL95z5umKGByYBHsKqjpCTXYwH0BXF7MlgqNdYSFgc7DesMqGo
 ncjg0MTaq86IJD/TlyEUW/xGgWF5O8Zjwr+dTM9IGwiCJYMSZAHOc4XxJ/ztUNJcXLMO
 K+NZiw/+vx7vtxFDsmmC2t5qPV6JS4948ycufdmLm8vthQjO8FyNreIMpRbXTO+P+ql7
 YUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763842754; x=1764447554;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wC+7MZp7zBskO8XTQphUohwsHBK2MpO3LHeDEqzsQcM=;
 b=IbTcDq4HghQ6V9bdI8z42h/wSphJGq7LIQN/8GTTZdtIBhXp0Xy7Y/SEySDxltCUGW
 0AoXPdwtGV4tW3+tcsE1xc80fYSjGhZWu4vI6WaK9E/fTn1AIKY8YjfBk3HpzZMj2e1y
 aQJbdjSlb2Ev4JDaFxtzWPGSvZDr/nUqv2P+zDSmnYn5FYHFF0s21Sf1XEsmFtqNz40+
 xGBUjB3sCKBGMvEk5NuyWR7j/AIEGirWYZWDCWQGKLlyN+Szl6MicEwpuYU27qzwLQk3
 40irIL9vAAb7OE3hknSjnQn7eA956c137Qip2UTJI396fTn7Mh9iToHID+hGBOWFC/76
 pYqQ==
X-Gm-Message-State: AOJu0Yxvca4woxtNrHfUECTM7LUoTzGUrsAJCxqAdz9U9tmd2clRWESF
 TTqjVZpO+mu1FKSgJh9GDx9U9lI9FGu833SGvC51U1rr0zHgrENjK/ggh092oQ==
X-Gm-Gg: ASbGncstRdrH3CXTZtvGj5lB/BUMPWO1aBgbEtp2mJ5ukMuHoj23dTmM11NX5ahoP39
 fncg5p5EOVfcMV/ngqJUJ9M1aWAainFdhPQWTHDYb1f8fvOSk7xm6PLgQsR4kC4GFsb1+OFYN8Z
 uFsO4F7Oqo6BmURt4evGo/WHmHTSRDyb1znlpozIE75FjCLwI8wS8aX3/RnsJOfkb7VP7Kg+fBE
 MNrwF22UdzixjY1/OpjQF2zui7B63klXRyC8wSMtpio0Ryo8xbblPmoIH9iW46h3ZZWSrrElZLz
 8S3tIz22IAy8NcXlnX7FUInRnrTqUHD0UNGjTEWrxunogPJI9pbuRrp5IXsPrm8pUWSzAfcI7i7
 god6D6QZLlCHceS48ZDBxIxQPsXzwx3mrP038UlkczlUBFd0A1GvgO/kBhWVIPRCt64ES/LwYzV
 ZyKjuXMxbb2eOCkx8a50UrXA==
X-Google-Smtp-Source: AGHT+IEUTGxwOGZl/1D0V6tYG3qlajDVyRrGY4zcqGnn8A3UPoM8coYWUD7v1zu5BLf5v+IdXzECWA==
X-Received: by 2002:a2e:91c4:0:b0:37a:3963:cec5 with SMTP id
 38308e7fff4ca-37cd92b2e33mr13504321fa.43.1763842753714; 
 Sat, 22 Nov 2025 12:19:13 -0800 (PST)
Received: from [192.168.88.253] ([82.215.83.93])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-37cc6bcb808sm17362651fa.44.2025.11.22.12.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Nov 2025 12:19:13 -0800 (PST)
Message-ID: <3c35955d-a57e-4203-81c5-395146e23f83@gmail.com>
Date: Sun, 23 Nov 2025 01:19:09 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
From: Andrey Erokhin <language.lawyer@gmail.com>
Subject: [PATCH v2] 9pfs: local: read native symlinks when
 security-model=mapped
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=language.lawyer@gmail.com; helo=mail-lj1-x22b.google.com
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

Directories attached using virtfs with security-model=mapped
may contain native symlinks

This can happen e.g. when booting from a rootfs directory tree
(usually with a writable overlay set up on the host side)

Currently, when security-model=mapped[-xattr|-file],
QEMU assumes that host-side "symlinks" are in the mapped format,
i.e. are regular files storing the linked path,
so it tries to open with O_NOFOLLOW
and fails with ELOOP on native symlinks

This patch introduces a fallback for such cases:
reuse security-model=[none|passthrough] else if branch logic
where readlink will be called for the path basename

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/173

Signed-off-by: Andrey Erokhin <language.lawyer@gmail.com>
---
 hw/9pfs/9p-local.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 6230466de1..ddf111b674 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -474,12 +474,16 @@ static ssize_t local_readlink(FsContext *fs_ctx, V9fsPath *fs_path,
 
         fd = local_open_nofollow(fs_ctx, fs_path->data, O_RDONLY, 0);
         if (fd == -1) {
+            if (errno == ELOOP) {
+                goto native_symlink;
+            }
             return -1;
         }
         tsize = RETRY_ON_EINTR(read(fd, (void *)buf, bufsz));
         close_preserve_errno(fd);
     } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
                (fs_ctx->export_flags & V9FS_SM_NONE)) {
+    native_symlink:;
         char *dirpath = g_path_get_dirname(fs_path->data);
         char *name = g_path_get_basename(fs_path->data);
         int dirfd;
-- 
2.34.1


