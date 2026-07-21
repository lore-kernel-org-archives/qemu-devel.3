Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855FCC44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmC0l-0007wD-Hu; Tue, 21 Jul 2026 11:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wmC0j-0007ue-7t
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:03:57 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wmC0h-0003ke-E8
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=b5HJ80IV0OLs5iX+NSB8WLsh9ARPEk8fkNJlHCKCI9M=; b=rjB2GFwLpE5U4Ni9dYnw5LmJXk
 sf+5j+P/vQiG8dCBbhohb4YfBS672uHiFXcNwZ2Se1mhQEAdYsG+r+5VhJTY1mXTwBHysT+eyFUqo
 mf875hQ8szgHMQyHOB0rghcZL6K67uiV+zb7DAWiHAaWOZTs8wtY1Hhj+e2F9hdiBMxclq0cYXPgZ
 KgiR3SOjmerL4RXHuFJYlrkxawBtfpmjRNg+mETUhq+PMmEUPo73pkc3Gr7r8elzGO+DjF04UL77K
 V30SOXoJMzuwl3Urs79DTdSyGt+iXFTMUhNWYgkspx07/NHbCyWFaadp7kF2RYDz3dkTG+qFfTyTy
 qKYV27Y34BolfoCbCBEpYfIYphiI6oJtKhueq9PiqOQdjmGEIIJSVgg4XQy9rHraY/zo9Im7RVMnR
 LYsg86V9oy0ar/88C6aS3T7YE4ikGO4I/bNCie+yGAUPFeogv/p2kTbBW0KXjPxLfhYw6sW7iJX3a
 qWmiH8Uhy4psg73WWT+Ew7hUp4POYXhTia0HAQgoLbki+QJWaU7lmhgREJLAURBiWG8CF7CnNS5dB
 wPEQ4Exze7DyIVh0avSrGuH3knxhWhv0A6ehDgzYlC5s4RXJFo+wVGsfic6xjMn1eOILbsqBIt+1c
 2mVa86TGi2897ZfhqfMi+aFIw5SihH2EFMTXm8d6I=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Kyohei Kadota <lufia@lufia.org>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] hw/9pfs: add support ORCLOSE flag to create and open
 request
Date: Tue, 21 Jul 2026 17:03:48 +0200
Message-ID: <4388079.1IzOArtZ34@weasel>
In-Reply-To: <CAFMepcnmdskwDZ6dN2wEEK=ve5B8hzghfrbUcGkQxCHGCDXVVA@mail.gmail.com>
References: <CAFMepcnmdskwDZ6dN2wEEK=ve5B8hzghfrbUcGkQxCHGCDXVVA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, PDS_OTHER_BAD_TLD=2,
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

On Friday, 17 July 2026 08:43:26 CEST Kyohei Kadota wrote:
> 9P, and its successor 9P2000, allows ORCLOSE flag to both open- and
> create-request.
> When 9pclient requests close(fid) operation to the 9pserver, and if
> the fid has ORCLOSE flag,
> 9pserver deletes the file, which is pointed of the fid, from
> 9pserver's filesystem.
> 
> However, the 9P specification does not allow any directories to be
> specified ORCLOSE flag.
> 
> Signed-off-by: KADOTA, Kyohei <lufia@lufia.org>

As this is not a trivial change, rather the contrary, I think this new feature 
deserves being covered by test cases:

https://wiki.qemu.org/Documentation/9p#Test_Cases

Tests should be separate patch(es).

> ---
>  hw/9pfs/9p.c | 17 +++++++++++++++++
>  hw/9pfs/9p.h |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 3119f01117..6fff57cc47 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -416,6 +416,9 @@ static int coroutine_fn free_fid(V9fsPDU *pdu,
> V9fsFidState *fidp)
>          if (fidp->fs.fd != -1) {
>              retval = v9fs_co_close(pdu, &fidp->fs);
>          }
> +        if (retval >= 0 && fidp->orclose) {
> +            retval = v9fs_co_remove(pdu, &fidp->path);
> +        }
>      } else if (fidp->fid_type == P9_FID_DIR) {
>          if (fidp->fs.dir.stream != NULL) {
>              retval = v9fs_co_closedir(pdu, &fidp->fs);

1. That would cause a silent ignore (neither removed, no error sent to client) 
when creating special files with Orclose, like symlink, hardlink, device, 
pipe, socket, as these end up as fid_type P9_FID_NONE, which are not covered 
by this change.

2. According to POSIX, close() errors should in general be ignored, with one 
exception: if errno == EBADF. You find this pattern at other locations of 
*close*() calls in this code base already.

> @@ -2164,6 +2167,10 @@ static void coroutine_fn v9fs_open(void *opaque)
>          goto out;
>      }
>      if (S_ISDIR(stbuf.st_mode)) {
> +        if (mode & Orclose) {
> +            err = -EINVAL;
> +            goto out;
> +        }
>          err = v9fs_co_opendir(pdu, fidp);
>          if (err < 0) {
>              goto out;
> @@ -2193,6 +2200,9 @@ static void coroutine_fn v9fs_open(void *opaque)
>          }
>          fidp->fid_type = P9_FID_FILE;
>          fidp->open_flags = flags;
> +        if (mode & Orclose) {
> +            fidp->orclose = true;
> +        }
>          if (flags & O_EXCL) {
>              /*
>               * We let the host file system do O_EXCL check
> @@ -2959,6 +2969,10 @@ static void coroutine_fn v9fs_create(void *opaque)
>          goto out;
>      }
>      if (perm & P9_STAT_MODE_DIR) {
> +        if (mode & Orclose) {
> +            err = -EINVAL;
> +            goto out;
> +        }
>          err = v9fs_co_mkdir(pdu, fidp, &name, perm & 0777,
>                              fidp->uid, -1, &stbuf);
>          if (err < 0) {
> @@ -3083,6 +3097,9 @@ static void coroutine_fn v9fs_create(void *opaque)
>          }
>          fidp->fid_type = P9_FID_FILE;
>          fidp->open_flags = omode_to_uflags(mode);
> +        if (mode & Orclose) {
> +            fidp->orclose = true;
> +        }
>          if (fidp->open_flags & O_EXCL) {
>              /*
>               * We let the host file system do O_EXCL check

That's just the handler for legacy 9p2000.u protocol version (Tcreate 
request). What's missing is also a similar change for v9fs_lcreate() which is 
the corresponding 9p2000.L protocol version handler (Tlcreate request).

> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 1a309664f6..16730cbd93 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -276,6 +276,7 @@ struct V9fsFidState {
>      V9fsFidOpenState fs;
>      V9fsFidOpenState fs_reclaim;
>      int flags;
> +    bool orclose;
>      int open_flags;
>      uid_t uid;
>      int ref;

V9fsFidState is typically allocated in a huge amount. Therefore I am not keen 
to make this struct (unnecessarily) larger. In this case you could simply use 
the already existing 'flags' field and just add a define for the new flag.

And last but not least: how should all of this behave with reclaiming file 
descriptors? That's happening when 9p server is getting under pressure and 
running against host's max. amount of open file descriptors limit. In this 
case 9p server must temporarily close older file descriptors for allowing 
opening new descriptors, and the old ones are then automatically re-opened if 
those old FIDs are re-used by client later on.

Maybe it is sufficient to call v9fs_mark_fids_unreclaim() just right before 
your added v9fs_co_remove() call, but not absolutely sure.

/Christian



