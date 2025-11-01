Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8C1CCFA02
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 23:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFL2C-0003Jh-0C; Sat, 01 Nov 2025 19:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r@drigo.nl>) id 1vFL2A-0003JS-IP
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 19:29:22 -0400
Received: from smtp-190e.mail.infomaniak.ch ([2001:1600:4:17::190e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r@drigo.nl>) id 1vFL26-0007Yk-Ui
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 19:29:22 -0400
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4czYvv0Np7z5n2;
 Sun,  2 Nov 2025 00:29:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drigo.nl;
 s=20241108; t=1762039754;
 bh=I0JWtZX0yQJNag8Hihbx+M4jmHoojRc7kpXpfJidF50=;
 h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
 b=E9gACsgQizbD5/6lEkRPGSNOe8JP6cCqhcEpjse7UzlcrmpY5bN69uPqWu5q6d9N0
 2xkVZB+j/D0LQjCAcq0dv+/iLwCQWH8sptIvD/Bp7su+fmX8v15eKTCSdOWi/oZG+P
 Mv0x5Ak3J+2PkXNyE3EFUqlG6ol8E24yZ/KTevnzn8uqh/CzNaaYTZ4FFIcbJaaB2i
 +hle5T/WOcEQi6IiFBHa4XjmqssU8iOihxVobQ+OD/c04OiYxGKeW9s55LRfrbmEUj
 y55e67YxpMD8zXGnflDz8voaxX2AS+ZhKC+HHoF2pOt1J2dcclzPe8gTslSgXfH8H3
 szL64yJnREIRw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4czYvt3B9YzDJ1; Sun,  2 Nov 2025 00:29:14 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Nov 2025 00:29:14 +0100
Message-Id: <DDXQYO68GHXQ.NZTDPMLYKROT@drigo.nl>
Cc: <qemu-trivial@nongnu.org>, "Kostiantyn Kostiuk" <kkostiuk@redhat.com>
Subject: Re: [PATCH trivial v3] qga: use access(2) to check for command
 existance instead of questionable stat(2)
From: "Rodrigo Dias Correa" <r@drigo.nl>
To: "Michael Tokarev" <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.20.0
References: <20251101131456.792868-1-mjt@tls.msk.ru>
In-Reply-To: <20251101131456.792868-1-mjt@tls.msk.ru>
X-Infomaniak-Routing: alpha
Received-SPF: pass client-ip=2001:1600:4:17::190e; envelope-from=r@drigo.nl;
 helo=smtp-190e.mail.infomaniak.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat Nov 1, 2025 at 2:14 PM CET, Michael Tokarev wrote:

> The code checks existance of a command (halt/poweroff/reboot) by using

> stat(2) and immediately checking for S_ISLNK() on the returned stat

> struct.  This check will never be true, because stat(2) always follows

> symbolic links and hence will either return ENOENT (in case of dangling

> symlink) or the properties for the final target file.  It is lstat(2)

> which might return information about the symlink itself.  However, even

> there, we want to check the final file properties, not the first symlink.

>

> This check - S_ISLNK - is harmful but useless in this case.  However, it

> is confusing and it helps the wrong usage of stat(2) to spread, so it is

> better to remove it.

>

> Additionally, the code would better to check for the executable bits

> of the final file, not check if it's a regular file - it's sort of

> dubious to have anything but regular files in /sbin/.

>

> But a POSIX system provides another command which suits the purpose

> perfectly: it is access(2).  And it is so simple that it's not

> necessary to create a separate function when usin it.

>

> Replace stat(2) with access(X_OK) to check for file existance in

> qga/commands-posix.c

>

> Fixes: c5b4afd4d56e "qga: Support guest shutdown of BusyBox-based systems=
"

> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>


Reviewed-by: Rodrigo Dias Correa <r@drigo.nl>

Thanks for fixing it.
Rodrigo
> ---

> v3: and actually don't forget to commit the changes.

>     I'm sorry for the noize.

> v2: fix reverse logic of the access() tests.

>     I should write code more often :)

>

>  qga/commands-posix.c | 12 +++---------

>  1 file changed, 3 insertions(+), 9 deletions(-)

>

> diff --git a/qga/commands-posix.c b/qga/commands-posix.c

> index c7059857e4..7785150fe4 100644

> --- a/qga/commands-posix.c

> +++ b/qga/commands-posix.c

> @@ -213,12 +213,6 @@ out:

>      return retcode;

>  }

> =20

> -static bool file_exists(const char *path)

> -{

> -    struct stat st;

> -    return stat(path, &st) =3D=3D 0 && (S_ISREG(st.st_mode) || S_ISLNK(s=
t.st_mode));

> -}

> -

>  #define POWEROFF_CMD_PATH "/sbin/poweroff"

>  #define HALT_CMD_PATH "/sbin/halt"

>  #define REBOOT_CMD_PATH "/sbin/reboot"

> @@ -245,17 +239,17 @@ void qmp_guest_shutdown(const char *mode, Error **e=
rrp)

> =20

>      slog("guest-shutdown called, mode: %s", mode);

>      if (!mode || strcmp(mode, "powerdown") =3D=3D 0) {

> -        if (file_exists(POWEROFF_CMD_PATH)) {

> +        if (access(POWEROFF_CMD_PATH, X_OK) =3D=3D 0) {

>              shutdown_cmd =3D POWEROFF_CMD_PATH;

>          }

>          shutdown_flag =3D powerdown_flag;

>      } else if (strcmp(mode, "halt") =3D=3D 0) {

> -        if (file_exists(HALT_CMD_PATH)) {

> +        if (access(HALT_CMD_PATH, X_OK) =3D=3D 0) {

>              shutdown_cmd =3D HALT_CMD_PATH;

>          }

>          shutdown_flag =3D halt_flag;

>      } else if (strcmp(mode, "reboot") =3D=3D 0) {

> -        if (file_exists(REBOOT_CMD_PATH)) {

> +        if (access(REBOOT_CMD_PATH, X_OK) =3D=3D 0) {

>              shutdown_cmd =3D REBOOT_CMD_PATH;

>          }

>          shutdown_flag =3D reboot_flag;




