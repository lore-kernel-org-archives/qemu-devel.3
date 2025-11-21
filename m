Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF75ACFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdO3-0000b8-Oz; Fri, 21 Nov 2025 21:30:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vMdNz-0000W1-Ts
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 21:30:03 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vMdNI-0007Pd-EN
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 21:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=9OY0zMSyIAoYrTIJBCx72xA+MaQN/L7mV5TJtDEE3lA=; b=kfQAVsn0WPYMl07N3be3x38Oeo
 3sqen3wDnNsD+V2tybZfbFXBP9reaDrA+GhL9TIfSj1nt9VZPUtSE5gkbARuJgmxPoVwKtdLko//7
 ahXJpihJDjdKdcO39nEA8RfeJ4rQD803BGAxP9wIJcVM1opt4t4PnmckHtVX1LlwlUa1B4wgP7ab8
 CPaX40loq4IRn9PgiIObdMe7IlgurZqV7LAOzPYNA16Uh94Lr5JuR2d6NRSwvgeXcnCQXBFoadWiG
 y5frb/dLLD/KorQaRAH79NUHI0TxDco9GN/svLq/KumvUjDux+yYc5u2GjeIzmPv/ec3VGx0JfK9v
 mWz/EK8kfwPz0fiF4PRaeCXxDgigHU1X+P9he+5iHsamjV9rSG0WDwSulbnCwg0ffhsjS1S7OgtwR
 7Xhm27uRBAh+yi8uqLlT5/ecmNjNGm0vXbiVRwJ+jRdCfwgdU+J+7kuOLefdcmKZWOhK53ZXNWU0N
 5KsW24a7TdarPiFg8GCNg7rBMQZMy2aORRR3nRkcHcjYkfP+joyK1BPG/rKO5UEx0ttjNRXQipb/T
 uCNyxxTD4EZdh+4CELE2Zuy+Q+Uzt9wJ/qmyWw7b9qGJx8tYMmK0gOcHfOas+re0VbcKZ8B+phSk4
 L/XRAn6O7GUxGk0tew15bCvuUjeWoTwTY4J0ta8F8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Andrey Erokhin <language.lawyer@gmail.com>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] hw/9pfs: Follow native symlinks when security-model=mapped
Date: Fri, 21 Nov 2025 13:20:14 +0100
Message-ID: <13890690.uLZWGnKmhe@weasel>
In-Reply-To: <5e07267f-b990-47fc-ade7-934209ea942f@gmail.com>
References: <5e07267f-b990-47fc-ade7-934209ea942f@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Thursday, 20 November 2025 14:01:36 CET Andrey Erokhin wrote:
> A directory mounted via virtfs with security-model=mapped[-xattr|-file] can
> contain "native" symlinks
> 
> This can happen e.g. when booting from a rootfs directory tree (usually with
> writable overlay set up on the host side)
> 
> Currently, with security-model=mapped, QEMU expects that all host "symlinks"
> are in "mapped" format, i.e. are files containing the linked path, so it
> tries to open with O_NOFOLLOW and fails with ELOOP in case of a native
> symlink
> 
> This patch gives such cases a second chance: trying to open as a native
> symlink, by reusing security-model=[none|passthrough] else if branch

Hi Greg,

I would like to ask you to look at this patch as well.

As I already wrote on Gitlab, technically I think this patch is fine/harmless, 
as the resolved native symlink would solely be passed to guest for its own 
interpretation. AFAICS it would not be used by 9p server (host).

Andrey, just some minor issues from my side below:

Git commit log message should not exceed 76 characters per line.

> QEMU issues:
> https://gitlab.com/qemu-project/qemu/-/issues/173 (from
> https://bugs.launchpad.net/qemu/+bug/1831354)
> https://gitlab.com/qemu-project/qemu/-/issues/3088 (dup of the first one)

This should be:

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/173

The other links can be dropped. They are already linked by #173.

> Signed-off-by: Andrey Erokhin <language.lawyer@gmail.com>
> 
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 31e216227c..b4f8be2c81 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -468,12 +468,14 @@ static ssize_t local_readlink(FsContext *fs_ctx,
> V9fsPath *fs_path,
> 
>           fd = local_open_nofollow(fs_ctx, fs_path->data, O_RDONLY, 0);
>           if (fd == -1) {
> +            if (errno == ELOOP) goto native_symlink;
>               return -1;
>           }

scripts/checkpatch.pl complaints:

ERROR: trailing statements should be on next line
#33: FILE: hw/9pfs/9p-local.c:471:
+            if (errno == ELOOP) goto native_symlink;

ERROR: braces {} are necessary for all arms of this statement
#33: FILE: hw/9pfs/9p-local.c:471:
+            if (errno == ELOOP) goto native_symlink;
[...]

>           tsize = RETRY_ON_EINTR(read(fd, (void *)buf, bufsz));
>           close_preserve_errno(fd);
>       } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
>                  (fs_ctx->export_flags & V9FS_SM_NONE)) {
> +native_symlink:;

Semicolon is unnecessary here, isn't it?

>           char *dirpath = g_path_get_dirname(fs_path->data);
>           char *name = g_path_get_basename(fs_path->data);
>           int dirfd;



