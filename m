Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B83BFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 02:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIH22-0006Ib-G1; Wed, 29 Apr 2026 22:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wIH20-0006I5-93
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 22:21:36 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wIH1r-0004zj-Lq
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 22:21:35 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-651b4d09141so680914d50.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 19:21:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777515686; cv=none;
 d=google.com; s=arc-20240605;
 b=jnoI78bXzc7pZhV7JKpNAlTDPBdgtiyjR725iW08ysc8MQg6XNzE6dq974U7aKEF9+
 8zmLr0vau7eVEd0uKGf7yKAEvHjkyuau9GzJ7FbjZkr9bfRzHHZdDsTGe1wvSdcFzimP
 haXHj5hCW/h+XlSHM8ckT3JMgGU6vIufW8GsDnQlWQ9BIiX5Uf7TZFjt4r64PfcSx7Uo
 HesVZvE2NWurxUDTMsEmxgSMkJeuA15lVVtt5h5LG9acKC9wVS/jCvHXI4FtniaNXGXz
 Y/pUy8SQdrGrPExlCqkGHDjJE8qgyEP/kGdRK+tCGk6tZfVna9zYYUVYsZ+SN6wtYsXk
 VnZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MZYgzxZZDYeik5V2fifaaTiIc3Gxs8CFa3AAhmYGM6Q=;
 fh=MZUwNFUepYLwj5XB7pInzgE8gETH7ALXQ6oomyX8hk8=;
 b=OVrIsAhq9y12gyoI+vL2utOZRtvRwU6uofUBrtfjSikYUkM6SlTN2Sl1ZWrLC1h0E4
 ExcD20oVIngGRCI7yAeRCIYmZ5lmxIrORqVquQEC8OSfpXR+2gW0yFEV/NP9nt37EJVu
 1NxzrqIZ4pj5gk6QBUNsZG+gc27u1JK6BbPkTerEni/PeD6KUJcg9gBLHr5/40a+CAmz
 p8BdGriZj1z1OcDDRD5UXWXeK7ky5s2EA/yZhUYBYrCf3Itq/BzrjLBREiedRcPWFpmq
 0A4HBntBotFZnaZaGSiUC2QSvVNzQXact+Uu4CW9iGYM66PvBJdfl3BfMP5gXy5dcRpg
 2Z0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777515686; x=1778120486;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MZYgzxZZDYeik5V2fifaaTiIc3Gxs8CFa3AAhmYGM6Q=;
 b=CLQ6qB4KguyYtC3TSZLEEuCzY1wsE3zVd3xGvVzr90iz5iyui67U0Z4LOamtVhUUUS
 SX5ETARZe+RZh6ZFuxgd6Kp+yKX45kIcJB73B/kmTpxvfv8hoemdJDE++npzWu3DdNTv
 CdyCT1DB8t0COoHx3Gubp+Lmz0a3QqZoJQ435RItBothme3BMg6w5mJhNJQ85BUfXMBl
 AlfPHV3Px09CkruZfO9iNww40b+xBCjnhUT8noMQpkeV/7zPFbpcCOil5ekqZEs8aShx
 L3TyBmdq9V6iPi0/+p2SzP1OnscHi32D7H6pkttRmDBvJ9hG+jLKOrwoXfXlTqYfBly6
 1raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777515686; x=1778120486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZYgzxZZDYeik5V2fifaaTiIc3Gxs8CFa3AAhmYGM6Q=;
 b=WlHFTnBcuHjNqTgOEQBcmAvPb9M0VYMxAisEKUsStnXbT3CEqjEGEgqvd+9I8ZnGT6
 YDJ/cQiHUy2AkCA45Lis9BcZ1mjY1ID4sf5pYJ/PEQ9J4VdCsF/oit/Tp2y8o25E68HK
 +klClVcS7adtMDEOSoPcQECKOIfn07KIS2ASTVWlWXJz3EmK61IstT5/iegabeHGsODt
 2X8OAqtyOeuFpA/M3LFfWknnfD+W1qw+m0wz71/Lsh41hg4NljGIlvoAnanM+NDdU7h6
 pRsscogYcgcchZkfb66q+6pN6hoz7z/19QZCd6wT7BKSjT4YXM7XqsiDMlAWH4qFOAsI
 Z30Q==
X-Gm-Message-State: AOJu0YwiSKVFPXRZasNT/QENW9/6frT5SK2HVAcqPoUBQWPGaI1XBx3T
 4pb2wGwSwYIFIuCYDPBH0rK5/RAy8fXxk/fygS/ZBcZ0gWhLnFgQ/uVeHwFOOKWQssGMTfrRCVW
 iW6VVgSqUAXJpQIHQLbG8MLj7/CputLAINhkq/ZRLEw==
X-Gm-Gg: AeBDieu4Q9rF4Hx9VqwbNMe6veOTDTTYfTZpiF1D/Cuqr81rundkvXF7qyBhoCYcSbX
 JTKlK2zQ2TXsRI1PyevmgpdYZS8MJMaymYRMQpLog6pEW+waDSdYQs6z1qUvWh8jhpTOqw+HoYU
 UDdtQxIUpubUO/mAIRpBKDPRZtKcLSSa/12C95zKkOacKraAKRIYoIUt4QVX4oUqFWuUIBa5sFm
 f1cUHrYB3OPnSppvo35r4FQytsmHN3SFESANNEMOYHnQg+cgQxEraKf+n5qnRdl+NADQEYH25HP
 TAyZB8z9sUl0aQKBBg==
X-Received: by 2002:a05:690e:d8f:b0:651:c221:9649 with SMTP id
 956f58d0204a3-65c1b044b00mr341592d50.19.1777515685994; Wed, 29 Apr 2026
 19:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com>
 <20260429-syscall-nr-v2-5-67a8d09dc13e@bsdimp.com>
 <6d3f5166-d1fe-410c-9fde-995b85f0045d@oss.qualcomm.com>
In-Reply-To: <6d3f5166-d1fe-410c-9fde-995b85f0045d@oss.qualcomm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 20:21:14 -0600
X-Gm-Features: AVHnY4KQQUto9GsCFBZ5lA9h5az4jbxUoPa0g6UaIB4nMbnfCB4fI5WA0ji7Wi0
Message-ID: <CANCZdfqGVDMLGaVJpcvOQnNRvM6P3SQz_i5nSw8w02H7wEiRTw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] bsd-user: Regnerate strace.list
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000bf4400650a41fa1"
Received-SPF: none client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=wlosh@bsdimp.com; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000000bf4400650a41fa1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 4:41=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:

> On 4/29/2026 7:38 AM, Warner Losh wrote:
> > Generate strace.list in a stable way. All FreeBSD system call numbers
> > are stable: they always and will forever mean only one thing (even if w=
e
> > abandon a syscall number and remove the code from the kernel, we'll
> > never reuse it). System calls are the same across all architectures, an=
d
> > newer versions just have more of them. Use the number in the generated
> > table so we can compile it on any version of FreeBSD.
> >
> > Also include the script that I used to generate this. It requires the
> > FreeBSD source tree, which is why we can't use it to generate
> > strace.list. This depends on the FreeBSD source tree at the moment,
> > since it uses the same system call generation machinery that FreeBSD
> > uses to generate its system call tables, so we can't connect it to the
> > qemu build until that issue is corrected. We've had a terrible
> strace.list
> > for a while, and this will make it better (and there's serious issues
> > with strace, just like linux-user, so it's a little-used feature).
> >
>
> That's fine for now, and you can eliminate the intree strace.list once
> it will be solved.
>

Yes. That's the plan.


> > Note: I derived this script from one of the FreeBSD system call
> > generation scripts, so it needs to be BSD-2-Clause license, which
> > deviates a bit from the GPL-2.0-or-newer preference, but I think is OK
> > since it's not folded into the qemu binaries themselves (and output of
> > scripts is typically public domain, as is the case here). This script i=
s
> > written in lua, but every FreeBSD installation has a 'flua' binary that
> > can run this script, and it leverages about 7k lines of library and
> > metadata FreeBSD maintains well.
> >
>
> This sounds like a reasonable requirement given that it will be only
> called on FreeBSD hosts.
>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >  bsd-user/freebsd/scripts/strace.lua | 117 ++++++
> >  bsd-user/freebsd/strace.list        | 708
> ++++++++++++++++++++++--------------
> >  2 files changed, 556 insertions(+), 269 deletions(-)
> >
> > diff --git a/bsd-user/freebsd/scripts/strace.lua
> b/bsd-user/freebsd/scripts/strace.lua
> > new file mode 100755
> > index 0000000000..c89e8e3aeb
> > --- /dev/null
> > +++ b/bsd-user/freebsd/scripts/strace.lua
> > @@ -0,0 +1,117 @@
> > +#!/usr/libexec/flua
> > +--
> > +-- SPDX-License-Identifier: BSD-2-Clause
> > +--
> > +-- Copyright (c) 2026 Warner Losh <imp@FreeBSD.org>
> > +-- Copyright (c) 2024 Tyler Baxter <agge@FreeBSD.org>
> > +-- Copyright (c) 2019 Kyle Evans <kevans@FreeBSD.org>
> > +--
> > +
> > +-- Add library root to the package path.
> > +local path =3D arg[0]:gsub("/[^/]+.lua$", "")
> > +package.path =3D package.path .. ";" .. path .. "/?.lua;" ..
> os.getenv('FREEBSD_SYSCALL_DIR') .. "/?.lua"
> > +
> > +local FreeBSDSyscall =3D require("core.freebsd-syscall")
> > +local generator =3D require("tools.generator")
> > +local config =3D require("config")
> > +
> > +-- File has not been decided yet; config will decide file.  Default
> defined as
> > +-- /dev/null.
>
> Not sure what this comment means, given that it's declared and defined
> as stdout on next line
>

The comment is wrong. It was copied from what I started with and is bogus.
I'll fix that.


> > +file =3D "/dev/stdout"
> > +
> > +function generate(tbl, config, fh)
> > +     -- Grab the master system calls table.
> > +     local s =3D tbl.syscalls
> > +
> > +     table.sort(s, function(a, b)
> > +         return a.arg_alias < b.arg_alias
> > +     end)
> > +     -- Bind the generator to the parameter file.
> > +     local gen =3D generator:new({}, fh)
> > +     gen.storage_levels =3D {} -- make sure storage is clear
> > +
> > +     -- Write the generated preamble.
> > +     gen:preamble("FreeBSD strace list\nNOTE: Use syscall numbers so w=
e
> work on all the branches.")
> > +
> > +     for _, v in pairs(s) do
> > +             local c =3D v:compatLevel()
> > +
> > +             -- Handle non-compat:
> > +             if v:native() then
> > +                     -- All these negation conditions are because (in
> > +                     -- general) these are cases where code for
> sysproto.h
> > +                     -- is not generated.
> > +                     if not v.type.NOARGS and not v.type.NOPROTO and
> > +                         not v.type.NODEF then
> > +                             fmt =3D "NULL"
> > +                             fcn =3D "NULL"
> > +                             if v.arg_alias =3D=3D "__sysctl" then
> > +                                     fcn =3D "print_sysctl"
> > +                             elseif v.arg_alias =3D=3D "execve" or
> v.arg_alias =3D=3D "fexecve" then
> > +                                     fcn =3D "print_execve"
> > +                             elseif v.arg_alias =3D=3D "ioctl" then
> > +                                     fcn =3D "print_ioctl"
> > +                             elseif v.arg_alias =3D=3D "mmap" then
> > +                                     fcn =3D "print_mmap"
> > +                             elseif v.arg_alias =3D=3D "sysarch" then
> > +                                     fcn =3D "print_sysarch"
> > +                             elseif #v.args > 0 then
> > +                                     fmt =3D "\"%s("
> > +                                     for _, arg in ipairs(v.args) do
> > +                                             if arg.type =3D=3D "char =
*"
> then
> > +                                                     fmt =3D fmt .. "%=
s, "
> > +                                             elseif arg.type =3D=3D
> "mode_t" then
> > +                                                     fmt =3D fmt .. "%=
o, "
> > +                                             else
> > +                                                     fmt =3D fmt .. "%=
#x,
> "
> > +                                             end
> > +                                     end
> > +                                     fmt =3D fmt:sub(1, -3)  .. ")\""
> > +                             end
> > +                             gen:write(string.format(
> > +                                 "{ %d, \"%s\", %s, %s, NULL },\n",
> > +                                 v.num, v.arg_alias, fmt, fcn))
> > +                     end
> > +             -- Handle compat (everything >=3D FREEBSD9):
> > +             elseif c >=3D 9 then
> > +                     local idx =3D c * 10
> > +                     if not v.type.NOARGS and not v.type.NOPROTO and
> > +                         not v.type.NODEF then
> > +                             fmt =3D "NULL"
> > +                             if #v.args > 0 then
> > +                                     fmt =3D "\"%s("
> > +                                     for _, arg in ipairs(v.args) do
> > +                                             if arg.type =3D=3D "char =
*"
> then
> > +                                                     fmt =3D fmt .. "%=
s, "
> > +                                             elseif arg.type =3D=3D
> "mode_t" then
> > +                                                     fmt =3D fmt .. "%=
o, "
> > +                                             else
> > +                                                     fmt =3D fmt .. "%=
#x,
> "
> > +                                             end
> > +                                     end
> > +                                     fmt =3D fmt:sub(1, -3)  .. ")\""
> > +                             end
> > +                             gen:write(string.format(
> > +                                 "{ %d, \"%s\", %s, %s, NULL },\n",
> > +                                 v.num, v.arg_alias, fmt, fcn))
> > +                     end
> > +             end
> > +             -- Do nothing for obsolete, unimplemented, and reserved.
> > +     end
> > +end
> > +
> > +
> > +if #arg < 1 or #arg > 2 then
> > +     error("usage: " .. arg[0] .. " syscall.master")
> > +end
> > +
> > +local sysfile =3D arg[1]
> > +
> > +config.merge(None)
> > +config.mergeCompat()
> > +
> > +-- The parsed system call table.
> > +local tbl =3D FreeBSDSyscall:new{sysfile =3D sysfile, config =3D confi=
g}
> > +
> > +file =3D arg[2] or "/dev/stdout"
>
> I'm not very familiar with lua, but since file has a default value set
> to /dev/stdout, I guess it could be?
> file =3D arg[2] or file
>

Yea, this is just me being a little sloppy. I'll clean it up since I really
shouldn't have
the stuff at the top of the file and here. But you're intuition is right,
as written,
it would be better as 'or file' here. I'll fix that in the next iteration.

Warner


> > +generate(tbl, config, file)
> > diff --git a/bsd-user/freebsd/strace.list b/bsd-user/freebsd/strace.lis=
t
> > index d7f61f480e..2c4176475a 100644
> > --- a/bsd-user/freebsd/strace.list
> > +++ b/bsd-user/freebsd/strace.list
> > @@ -1,273 +1,443 @@
> >  /*
> > - *  FreeBSD strace list
> > + * FreeBSD strace list
> > + * NOTE: Use syscall numbers so we work on all the branches.
> >   *
> > - *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * DO NOT EDIT-- this file is automatically @generated.
> >   */
> >
> > -{ TARGET_FREEBSD_NR___acl_aclcheck_fd, "__acl_aclcheck_fd", "%s(%d, %d=
,
> %#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR___acl_aclcheck_file, "__acl_aclcheck_file",
> "%s(\"%s\", %d, %#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR___acl_aclcheck_link, "__acl_aclcheck_link",
> "%s(\"%s\", %d, %#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR___acl_delete_fd, "__acl_delete_fd", "%s(%d, %d)",
> NULL, NULL },
> > -{ TARGET_FREEBSD_NR___acl_delete_file, "__acl_delete_file", "%s(\"%s\"=
,
> %d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR___acl_delete_link, "__acl_delete_link", "%s(\"%s\"=
,
> %d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR___acl_get_fd, "__acl_get_fd", "%s(%d, %d, %#x)",
> NULL, NULL },
> > -{ TARGET_FREEBSD_NR___acl_get_file, "__acl_get_file", "%s(\"%s\", %d,
> %#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR___acl_get_link, "__acl_get_link", "%s(\"%s\", %d,
> %#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR___acl_set_fd, "__acl_set_fd", "%s(%d, %d, %#x)",
> NULL, NULL },
> > -{ TARGET_FREEBSD_NR___acl_set_file, "__acl_set_file", "%s(\"%s\", %d,
> %#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR___acl_set_link, "__acl_set_link", "%s(\"%s\", %d,
> %#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR___getcwd, "__getcwd", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR___semctl, "__semctl", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR___syscall, "__syscall", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR___sysctl, "__sysctl", NULL, print_sysctl, NULL },
> > -{ TARGET_FREEBSD_NR__umtx_op, "_umtx_op", "%s(%#x, %d, %d, %#x, %#x)",
> NULL, NULL },
> > -{ TARGET_FREEBSD_NR_accept, "accept", "%s(%d,%#x,%#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_accept4, "accept4", "%s(%d,%d,%#x,%#x)", NULL, NUL=
L
> },
> > -{ TARGET_FREEBSD_NR_access, "access", "%s(\"%s\",%#o)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_acct, "acct", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_adjtime, "adjtime", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_bind, "bind", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_bindat, "bindat", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_break, "break", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_cap_enter, "cap_enter", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_cap_fcntls_get, "cap_fcntls_get", NULL, NULL, NULL
> },
> > -{ TARGET_FREEBSD_NR_cap_fcntls_limit, "cap_fcntls_limit", NULL, NULL,
> NULL },
> > -{ TARGET_FREEBSD_NR_cap_getmode, "cap_getmode", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_cap_ioctls_get, "cap_ioctls_get", NULL, NULL, NULL
> },
> > -{ TARGET_FREEBSD_NR_cap_ioctls_limit, "cap_ioctls_limit", NULL, NULL,
> NULL },
> > -{ TARGET_FREEBSD_NR_cap_rights_limit, "cap_rights_limit", NULL, NULL,
> NULL },
> > -{ TARGET_FREEBSD_NR_chdir, "chdir", "%s(\"%s\")", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_chflags, "chflags", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_chflagsat, "chflagsat", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_chmod, "chmod", "%s(\"%s\",%#o)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_chown, "chown", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_chroot, "chroot", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_clock_getres, "clock_getres", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_clock_gettime, "clock_gettime", NULL, NULL, NULL }=
,
> > -{ TARGET_FREEBSD_NR_clock_settime, "clock_settime", NULL, NULL, NULL }=
,
> > -{ TARGET_FREEBSD_NR_close, "close", "%s(%d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_connect, "connect", "%s(%d,%#x,%d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_connectat, "connectat", "%s(%d,%d,%#x,%d)", NULL,
> NULL },
> > -{ TARGET_FREEBSD_NR_cpuset_getdomain, "cpuset_getdomain", NULL, NULL,
> NULL },
> > -{ TARGET_FREEBSD_NR_cpuset_setdomain, "cpuset_setdomain", NULL, NULL,
> NULL },
> > -{ TARGET_FREEBSD_NR_dup, "dup", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_dup2, "dup2", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_eaccess, "eaccess", "%s(\"%s\",%#x)", NULL, NULL }=
,
> > -{ TARGET_FREEBSD_NR_execve, "execve", NULL, print_execve, NULL },
> > -{ TARGET_FREEBSD_NR_exit, "exit", "%s(%d)\n", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_extattrctl, "extattrctl", "%s(\"%s\", %d, \"%s\",
> %d, \"%s\"", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_extattr_delete_fd, "extattr_delete_fd", "%s(%d, %d=
,
> \"%s\")", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_extattr_delete_file, "extattr_delete_file",
> "%s(\"%s\", %d, \"%s\")", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_extattr_delete_link, "extattr_delete_link",
> "%s(\"%s\", %d, \"%s\")", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_extattr_get_fd, "extattr_get_fd", "%s(%d, %d,
> \"%s\", %#x, %d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_extattr_get_file, "extattr_get_file", "%s(\"%s\",
> %d, \"%s\", %#x, %d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_extattr_get_file, "extattr_get_link", "%s(\"%s\",
> %d, \"%s\", %#x, %d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_extattr_list_fd, "extattr_list_fd", "%s(%d, %d,
> %#x, %d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_extattr_list_file, "extattr_list_file", "%s(\"%s\"=
,
> %#x, %d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_extattr_list_link, "extattr_list_link", "%s(\"%s\"=
,
> %d, %#x, %d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_extattr_set_fd, "extattr_set_fd", "%s(%d, %d,
> \"%s\", %#x, %d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_extattr_set_file, "extattr_set_file", "%s(\"%s\",
> %d, \"%s\", %#x, %d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_extattr_set_link, "extattr_set_link", "%s(\"%s\",
> %d, \"%s\", %#x, %d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_fchdir, "fchdir", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_fchflags, "fchflags", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_fchmod, "fchmod", "%s(%d,%#o)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_fchown, "fchown", "%s(%d,%d,%d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_fcntl, "fcntl", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_fdatasync, "fdatasync", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_fexecve, "fexecve", NULL, print_execve, NULL },
> > -{ TARGET_FREEBSD_NR_fhopen, "fhopen", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_fhstat, "fhstat", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_fhstatfs, "fhstatfs", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_freebsd11_fhstat, "freebsd11_fhstat", NULL, NULL,
> NULL },
> > -{ TARGET_FREEBSD_NR_freebsd11_fhstatfs, "freebsd11_fhstatfs", NULL,
> NULL, NULL },
> > -{ TARGET_FREEBSD_NR_flock, "flock", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_fork, "fork", "%s()", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_fpathconf, "fpathconf", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_fstat, "fstat", "%s(%d,%#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_fstatat, "fstatat", "%s(%d,\"%s\", %#x, %d)", NULL=
,
> NULL },
> > -{ TARGET_FREEBSD_NR_fstatfs, "fstatfs", "%s(%d,%#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_freebsd11_fstat, "freebsd11_fstat", "%s(%d,%#x)",
> NULL, NULL },
> > -{ TARGET_FREEBSD_NR_freebsd11_fstatat, "freebsd11_fstatat",
> "%s(%d,\"%s\", %#x, %d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_freebsd11_fstatfs, "freebsd11_fstatfs",
> "%s(%d,%#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_fsync, "fsync", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_ftruncate, "ftruncate", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_futimens, "futimens", "%s(%d,%p)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_futimes, "futimes", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getcontext, "getcontext", "%s(%#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getdirentries, "getdirentries", NULL, NULL, NULL }=
,
> > -{ TARGET_FREEBSD_NR_freebsd11_getdirentries, "freebsd11_getdirentries"=
,
> NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getegid, "getegid", "%s()", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_geteuid, "geteuid", "%s()", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getfh, "getfh", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getfsstat, "getfsstat", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_freebsd11_getfsstat, "freebsd11_getfsstat", NULL,
> NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getgid, "getgid", "%s()", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getgroups, "getgroups", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getitimer, "getitimer", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getlogin, "getlogin", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getpeername, "getpeername", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getpgid, "getpgid", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getpgrp, "getpgrp", "%s()", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getpid, "getpid", "%s()", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getppid, "getppid", "%s()", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getpriority, "getpriority", "%s(%#x,%#x)", NULL,
> NULL },
> > -{ TARGET_FREEBSD_NR_getrandom, "getrandom", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getresgid, "getresgid", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getresuid, "getresuid", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getrlimit, "getrlimit", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getrusage, "getrusage", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getsid, "getsid", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getsockname, "getsockname", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getsockopt, "getsockopt", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_gettimeofday, "gettimeofday", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_getuid, "getuid", "%s()", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_ioctl, "ioctl", NULL, print_ioctl, NULL },
> > -{ TARGET_FREEBSD_NR_issetugid, "issetugid", "%s()", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_freebsd11_kevent, "freebsd11_kevent", NULL, NULL,
> NULL },
> > -{ TARGET_FREEBSD_NR_kevent, "kevent", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_kill, "kill", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_kqueue, "kqueue", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_ktrace, "ktrace", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_lchown, "lchown", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_link, "link", "%s(\"%s\",\"%s\")", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_listen, "listen", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_lpathconf, "lpathconf", "%s(\"%s\", %d)", NULL,
> NULL },
> > -{ TARGET_FREEBSD_NR_lseek, "lseek", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_freebsd11_lstat, "freebsd11_lstat",
> "%s(\"%s\",%p)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_madvise, "madvise", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_mincore, "mincore", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_minherit, "minherit", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_mkdir, "mkdir", "%s(\"%s\",%#o)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_mkfifo, "mkfifo", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_mknodat, "mknodat", "%s(%d, \"%s\",%#o,%#x)", NULL=
,
> NULL },
> > -{ TARGET_FREEBSD_NR_freebsd11_mknod, "freebsd11_mknod",
> "%s(\"%s\",%#o,%#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_freebsd11_mknodat, "freebsd11_mknodat", "%s(%d,
> \"%s\",%#o,%#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_mlock, "mlock", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_mlockall, "mlockall", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_mmap, "mmap", NULL, NULL, print_syscall_ret_addr }=
,
> > -{ TARGET_FREEBSD_NR_mount, "mount", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_mprotect, "mprotect", "%s(%#x,%#x,%d)", NULL, NULL
> },
> > -{ TARGET_FREEBSD_NR_msgctl, "msgctl", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_msgget, "msgget", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_msgrcv, "msgrcv", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_msgsnd, "msgsnd", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_msync, "msync", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_munlock, "munlock", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_munlockall, "munlockall", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_munmap, "munmap", "%s(%p,%d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_nanosleep, "nanosleep", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_nfssvc, "nfssvc", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_open, "open", "%s(\"%s\",%#x,%#o)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_openat, "openat", "%s(%d, \"%s\",%#x,%#o)", NULL,
> NULL },
> > -{ TARGET_FREEBSD_NR_pathconf, "pathconf", "%s(\"%s\", %d)", NULL, NULL
> },
> > -{ TARGET_FREEBSD_NR_freebsd10_pipe, "freebsd10_pipe", NULL, NULL, NULL
> },
> > -{ TARGET_FREEBSD_NR_pipe2, "pipe2", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_poll, "poll", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_posix_fallocate, "posix_fallocate", NULL, NULL,
> NULL },
> > -{ TARGET_FREEBSD_NR_pread, "pread", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_preadv, "preadv", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_profil, "profil", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_ptrace, "ptrace", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_pwrite, "pwrite", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_pwritev, "pwritev", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_quotactl, "quotactl", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_read, "read", "%s(%d,%#x,%d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_readlink, "readlink", "%s(\"%s\",%p,%d)", NULL,
> NULL },
> > -{ TARGET_FREEBSD_NR_readv, "readv", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_reboot, "reboot", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_recvfrom, "recvfrom", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_recvmsg, "recvmsg", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_rename, "rename", "%s(\"%s\",\"%s\")", NULL, NULL =
},
> > -{ TARGET_FREEBSD_NR_revoke, "revoke", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_rfork, "rfork", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_rmdir, "rmdir", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_rtprio_thread, "rtprio_thread", "%s(%d, %d, %p)",
> NULL, NULL },
> > -#ifdef TARGET_FREEBSD_NR_sbrk
> > -{ TARGET_FREEBSD_NR_sbrk, "sbrk", NULL, NULL, NULL },
> > -#endif
> > -{ TARGET_FREEBSD_NR_sched_get_priority_max, "sched_get_priority_max",
> NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_sched_get_priority_min, "sched_get_priority_min",
> NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_sched_yield, "sched_yield", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_select, "select", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_semget, "semget", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_semop, "semop", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_sendmsg, "sendmsg", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_sendto, "sendto", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_setcontext, "setcontext", "%s(%#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_setegid, "setegid", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_seteuid, "seteuid", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_setgid, "setgid", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_setgroups, "setgroups", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_setitimer, "setitimer", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_setlogin, "setlogin", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_setpgid, "setpgid", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_setpriority, "setpriority", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_setregid, "setregid", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_setresgid, "setresgid", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_setresuid, "setresuid", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_setreuid, "setreuid", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_setrlimit, "setrlimit", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_setsid, "setsid", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_setsockopt, "setsockopt", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_settimeofday, "settimeofday", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_setuid, "setuid", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_shmat, "shmat", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_shmctl, "shmctl", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_shmdt, "shmdt", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_shmget, "shmget", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_shutdown, "shutdown", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_sigaction, "sigaction", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_sigaltstack, "sigaltstack", "%s(%p,%p)", NULL, NUL=
L
> },
> > -{ TARGET_FREEBSD_NR_sigpending, "sigpending", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_sigprocmask, "sigprocmask", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_sigreturn, "sigreturn", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_sigsuspend, "sigsuspend", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_socket, "socket", "%s(%d,%d,%d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_socketpair, "socketpair", NULL, NULL, NULL },
> > -#ifdef TARGET_FREEBSD_NR_sstk
> > -{ TARGET_FREEBSD_NR_sstk, "sstk", NULL, NULL, NULL },
> > -#endif
> > -{ TARGET_FREEBSD_NR_freebsd11_stat, "freebsd11_stat", "%s(\"%s\",%p)",
> NULL, NULL },
> > -{ TARGET_FREEBSD_NR_freebsd11_statfs, "freebsd11_statfs",
> "%s(\"%s\",%p)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_symlink, "symlink", "%s(\"%s\",\"%s\")", NULL, NUL=
L
> },
> > -{ TARGET_FREEBSD_NR_sync, "sync", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_sysarch, "sysarch", NULL, print_sysarch, NULL },
> > -{ TARGET_FREEBSD_NR_syscall, "syscall", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_ktimer_create, "timer_create" , NULL, NULL, NULL }=
,
> > -{ TARGET_FREEBSD_NR_ktimer_delete, "timer_delete" , NULL, NULL, NULL }=
,
> > -{ TARGET_FREEBSD_NR_ktimer_settime, "timer_settime" , NULL, NULL, NULL
> },
> > -{ TARGET_FREEBSD_NR_ktimer_gettime, "timer_gettime" , NULL, NULL, NULL
> },
> > -{ TARGET_FREEBSD_NR_ktimer_getoverrun, "timer_getoverrun" , NULL, NULL=
,
> NULL },
> > -{ TARGET_FREEBSD_NR_thr_create, "thr_create", "%s(%#x, %#x, %d)", NULL=
,
> NULL },
> > -{ TARGET_FREEBSD_NR_thr_exit, "thr_exit", "%s(%#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_thr_kill, "thr_kill", "%s(%d, %#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_thr_kill2, "thr_kill2", "%s(%d, %d, %d)", NULL,
> NULL },
> > -{ TARGET_FREEBSD_NR_thr_new, "thr_new", "%s(%#x, %d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_thr_self, "thr_self", "%s(%#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_thr_set_name, "thr_set_name", "%s(%d, \"%s\")",
> NULL, NULL },
> > -{ TARGET_FREEBSD_NR_thr_suspend, "thr_suspend", "%s(%d, %#x)", NULL,
> NULL },
> > -{ TARGET_FREEBSD_NR_thr_wake, "thr_wake", "%s(%d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_truncate, "truncate", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_umask, "umask", "%s(%#o)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_unlink, "unlink", "%s(\"%s\")", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_unmount, "unmount", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_utimes, "utimes", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_utimensat, "utimensat", "%s(%d,%s,%p,%#x)", NULL,
> NULL },
> > -{ TARGET_FREEBSD_NR_vfork, "vfork", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_wait4, "wait4", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_wait6, "wait6", NULL, NULL, NULL },
> > -{ TARGET_FREEBSD_NR_write, "write", "%s(%d,%#x,%d)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_writev, "writev", "%s(%d,%p,%#x)", NULL, NULL },
> > -{ TARGET_FREEBSD_NR_posix_openpt, "posix_openpt", "%s(%d)", NULL, NULL
> },
> > +{ 354, "__acl_aclcheck_fd_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 353, "__acl_aclcheck_file_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 428, "__acl_aclcheck_link_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 352, "__acl_delete_fd_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 351, "__acl_delete_file_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 427, "__acl_delete_link_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 349, "__acl_get_fd_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 347, "__acl_get_file_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 425, "__acl_get_link_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 350, "__acl_set_fd_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 348, "__acl_set_file_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 426, "__acl_set_link_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 515, "__cap_rights_get_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 326, "__getcwd_args", "%s(%s, %#x)", NULL, NULL },
> > +{ 415, "__mac_execve_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 386, "__mac_get_fd_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 387, "__mac_get_file_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 410, "__mac_get_link_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 409, "__mac_get_pid_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 384, "__mac_get_proc_args", "%s(%#x)", NULL, NULL },
> > +{ 388, "__mac_set_fd_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 389, "__mac_set_file_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 411, "__mac_set_link_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 385, "__mac_set_proc_args", "%s(%#x)", NULL, NULL },
> > +{ 574, "__realpathat_args", "%s(%#x, %#x, %s, %#x, %#x)", NULL, NULL }=
,
> > +{ 510, "__semctl_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 374, "__setugid_args", "%s(%#x)", NULL, NULL },
> > +{ 577, "__specialfd_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 202, "__sysctl_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL
> },
> > +{ 570, "__sysctlbyname_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL=
,
> NULL },
> > +{ 1, "_exit_args", "%s(%#x)", NULL, NULL },
> > +{ 454, "_umtx_op_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 463, "abort2_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 541, "accept4_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 30, "accept_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 33, "access_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 51, "acct_args", "%s(%#x)", NULL, NULL },
> > +{ 140, "adjtime_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 377, "afs3_syscall_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x, %#x)",
> NULL, NULL },
> > +{ 316, "aio_cancel_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 317, "aio_error_args", "%s(%#x)", NULL, NULL },
> > +{ 465, "aio_fsync_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 543, "aio_mlock_args", "%s(%#x)", NULL, NULL },
> > +{ 255, "aio_read_args", "%s(%#x)", NULL, NULL },
> > +{ 579, "aio_readv_args", "%s(%#x)", NULL, NULL },
> > +{ 314, "aio_return_args", "%s(%#x)", NULL, NULL },
> > +{ 315, "aio_suspend_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 359, "aio_waitcomplete_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 256, "aio_write_args", "%s(%#x)", NULL, NULL },
> > +{ 578, "aio_writev_args", "%s(%#x)", NULL, NULL },
> > +{ 445, "audit_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 453, "auditctl_args", "%s(%#x)", NULL, NULL },
> > +{ 446, "auditon_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 104, "bind_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 538, "bindat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 17, "break_args", "%s(%s)", NULL, NULL },
> > +{ 516, "cap_enter_args", NULL, NULL, NULL },
> > +{ 537, "cap_fcntls_get_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 536, "cap_fcntls_limit_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 517, "cap_getmode_args", "%s(%#x)", NULL, NULL },
> > +{ 535, "cap_ioctls_get_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 534, "cap_ioctls_limit_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 533, "cap_rights_limit_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 12, "chdir_args", "%s(%#x)", NULL, NULL },
> > +{ 34, "chflags_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 540, "chflagsat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 15, "chmod_args", "%s(%#x, %o)", NULL, NULL },
> > +{ 16, "chown_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 61, "chroot_args", "%s(%#x)", NULL, NULL },
> > +{ 247, "clock_getcpuclockid2_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 234, "clock_getres_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 232, "clock_gettime_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 244, "clock_nanosleep_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 233, "clock_settime_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 6, "close_args", "%s(%#x)", NULL, NULL },
> > +{ 575, "close_range_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 98, "connect_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 539, "connectat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 569, "copy_file_range_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)",
> NULL, NULL },
> > +{ 484, "cpuset_args", "%s(%#x)", NULL, NULL },
> > +{ 487, "cpuset_getaffinity_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL,
> NULL },
> > +{ 561, "cpuset_getdomain_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)",
> NULL, NULL },
> > +{ 486, "cpuset_getid_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 488, "cpuset_setaffinity_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL,
> NULL },
> > +{ 562, "cpuset_setdomain_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)",
> NULL, NULL },
> > +{ 485, "cpuset_setid_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 90, "dup2_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 41, "dup_args", "%s(%#x)", NULL, NULL },
> > +{ 376, "eaccess_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 59, "execve_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 373, "extattr_delete_fd_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 358, "extattr_delete_file_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 414, "extattr_delete_link_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 372, "extattr_get_fd_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NUL=
L
> },
> > +{ 357, "extattr_get_file_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL,
> NULL },
> > +{ 413, "extattr_get_link_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL,
> NULL },
> > +{ 437, "extattr_list_fd_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 438, "extattr_list_file_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL =
},
> > +{ 439, "extattr_list_link_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL =
},
> > +{ 371, "extattr_set_fd_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NUL=
L
> },
> > +{ 356, "extattr_set_file_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL,
> NULL },
> > +{ 412, "extattr_set_link_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL,
> NULL },
> > +{ 355, "extattrctl_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 592, "exterrctl_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 489, "faccessat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 13, "fchdir_args", "%s(%#x)", NULL, NULL },
> > +{ 35, "fchflags_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 124, "fchmod_args", "%s(%#x, %o)", NULL, NULL },
> > +{ 490, "fchmodat_args", "%s(%#x, %#x, %o, %#x)", NULL, NULL },
> > +{ 123, "fchown_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 491, "fchownat_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 590, "fchroot_args", "%s(%#x)", NULL, NULL },
> > +{ 92, "fcntl_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 550, "fdatasync_args", "%s(%#x)", NULL, NULL },
> > +{ 492, "fexecve_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 241, "ffclock_getcounter_args", "%s(%#x)", NULL, NULL },
> > +{ 243, "ffclock_getestimate_args", "%s(%#x)", NULL, NULL },
> > +{ 242, "ffclock_setestimate_args", "%s(%#x)", NULL, NULL },
> > +{ 565, "fhlink_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 566, "fhlinkat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 298, "fhopen_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 567, "fhreadlink_args", "%s(%#x, %s, %#x)", NULL, NULL },
> > +{ 553, "fhstat_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 558, "fhstatfs_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 131, "flock_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 2, "fork_args", NULL, NULL, NULL },
> > +{ 192, "fpathconf_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 434, "freebsd10__umtx_lock_args", "%s(%#x)", NULL, NULL },
> > +{ 435, "freebsd10__umtx_unlock_args", "%s(%#x)", NULL, NULL },
> > +{ 42, "freebsd10_pipe_args", NULL, NULL, NULL },
> > +{ 299, "freebsd11_fhstat_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 398, "freebsd11_fhstatfs_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 189, "freebsd11_fstat_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 493, "freebsd11_fstatat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL =
},
> > +{ 397, "freebsd11_fstatfs_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 272, "freebsd11_getdents_args", "%s(%#x, %s, %#x)", NULL, NULL },
> > +{ 196, "freebsd11_getdirentries_args", "%s(%#x, %s, %#x, %#x)", NULL,
> NULL },
> > +{ 395, "freebsd11_getfsstat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 363, "freebsd11_kevent_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)",
> NULL, NULL },
> > +{ 190, "freebsd11_lstat_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 14, "freebsd11_mknod_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 498, "freebsd11_mknodat_args", "%s(%#x, %#x, %o, %#x)", NULL, NULL }=
,
> > +{ 279, "freebsd11_nfstat_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 280, "freebsd11_nlstat_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 278, "freebsd11_nstat_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 188, "freebsd11_stat_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 396, "freebsd11_statfs_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 72, "freebsd11_vadvise_args", "%s(%#x)", NULL, NULL },
> > +{ 509, "freebsd12_closefrom_args", "%s(%#x)", NULL, NULL },
> > +{ 482, "freebsd12_shm_open_args", "%s(%#x, %#x, %o)", NULL, NULL },
> > +{ 424, "freebsd13_swapoff_args", "%s(%#x)", NULL, NULL },
> > +{ 79, "freebsd14_getgroups_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 80, "freebsd14_setgroups_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 580, "fspacectl_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 551, "fstat_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 552, "fstatat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 556, "fstatfs_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 95, "fsync_args", "%s(%#x)", NULL, NULL },
> > +{ 480, "ftruncate_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 568, "funlinkat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 546, "futimens_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 206, "futimes_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 494, "futimesat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 451, "getaudit_addr_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 449, "getaudit_args", "%s(%#x)", NULL, NULL },
> > +{ 447, "getauid_args", "%s(%#x)", NULL, NULL },
> > +{ 421, "getcontext_args", "%s(%#x)", NULL, NULL },
> > +{ 554, "getdirentries_args", "%s(%#x, %s, %#x, %#x)", NULL, NULL },
> > +{ 89, "getdtablesize_args", NULL, NULL, NULL },
> > +{ 43, "getegid_args", NULL, NULL, NULL },
> > +{ 25, "geteuid_args", NULL, NULL, NULL },
> > +{ 161, "getfh_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 564, "getfhat_args", "%s(%#x, %s, %#x, %#x)", NULL, NULL },
> > +{ 557, "getfsstat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 47, "getgid_args", NULL, NULL, NULL },
> > +{ 595, "getgroups_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 86, "getitimer_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 49, "getlogin_args", "%s(%s, %#x)", NULL, NULL },
> > +{ 523, "getloginclass_args", "%s(%s, %#x)", NULL, NULL },
> > +{ 31, "getpeername_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 207, "getpgid_args", "%s(%#x)", NULL, NULL },
> > +{ 81, "getpgrp_args", NULL, NULL, NULL },
> > +{ 20, "getpid_args", NULL, NULL, NULL },
> > +{ 39, "getppid_args", NULL, NULL, NULL },
> > +{ 100, "getpriority_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 563, "getrandom_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 361, "getresgid_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 360, "getresuid_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 194, "getrlimit_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 589, "getrlimitusage_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 117, "getrusage_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 310, "getsid_args", "%s(%#x)", NULL, NULL },
> > +{ 32, "getsockname_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 118, "getsockopt_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 116, "gettimeofday_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 24, "getuid_args", NULL, NULL, NULL },
> > +{ 593, "inotify_add_watch_at_args", "%s(%#x, %#x, %#x, %#x)", NULL,
> NULL },
> > +{ 594, "inotify_rm_watch_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 54, "ioctl_args", "%s(%#x, %#x, %s)", NULL, NULL },
> > +{ 253, "issetugid_args", NULL, NULL, NULL },
> > +{ 338, "jail_args", "%s(%#x)", NULL, NULL },
> > +{ 436, "jail_attach_args", "%s(%#x)", NULL, NULL },
> > +{ 597, "jail_attach_jd_args", "%s(%#x)", NULL, NULL },
> > +{ 506, "jail_get_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 508, "jail_remove_args", "%s(%#x)", NULL, NULL },
> > +{ 598, "jail_remove_jd_args", "%s(%#x)", NULL, NULL },
> > +{ 507, "jail_set_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 588, "kcmp_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 390, "kenv_args", "%s(%#x, %#x, %s, %#x)", NULL, NULL },
> > +{ 560, "kevent_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL }=
,
> > +{ 599, "kexec_load_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 37, "kill_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 306, "kldfind_args", "%s(%#x)", NULL, NULL },
> > +{ 309, "kldfirstmod_args", "%s(%#x)", NULL, NULL },
> > +{ 304, "kldload_args", "%s(%#x)", NULL, NULL },
> > +{ 307, "kldnext_args", "%s(%#x)", NULL, NULL },
> > +{ 308, "kldstat_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 337, "kldsym_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 305, "kldunload_args", "%s(%#x)", NULL, NULL },
> > +{ 444, "kldunloadf_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 461, "kmq_notify_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 457, "kmq_open_args", "%s(%#x, %#x, %o, %#x)", NULL, NULL },
> > +{ 458, "kmq_setattr_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 459, "kmq_timedreceive_args", "%s(%#x, %s, %#x, %#x, %#x)", NULL,
> NULL },
> > +{ 460, "kmq_timedsend_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL
> },
> > +{ 462, "kmq_unlink_args", "%s(%#x)", NULL, NULL },
> > +{ 362, "kqueue_args", NULL, NULL, NULL },
> > +{ 583, "kqueuex_args", "%s(%#x)", NULL, NULL },
> > +{ 400, "ksem_close_args", "%s(%#x)", NULL, NULL },
> > +{ 408, "ksem_destroy_args", "%s(%#x)", NULL, NULL },
> > +{ 407, "ksem_getvalue_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 404, "ksem_init_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 405, "ksem_open_args", "%s(%#x, %#x, %#x, %o, %#x)", NULL, NULL },
> > +{ 401, "ksem_post_args", "%s(%#x)", NULL, NULL },
> > +{ 441, "ksem_timedwait_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 403, "ksem_trywait_args", "%s(%#x)", NULL, NULL },
> > +{ 406, "ksem_unlink_args", "%s(%#x)", NULL, NULL },
> > +{ 402, "ksem_wait_args", "%s(%#x)", NULL, NULL },
> > +{ 235, "ktimer_create_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 236, "ktimer_delete_args", "%s(%#x)", NULL, NULL },
> > +{ 239, "ktimer_getoverrun_args", "%s(%#x)", NULL, NULL },
> > +{ 238, "ktimer_gettime_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 237, "ktimer_settime_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 45, "ktrace_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 391, "lchflags_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 274, "lchmod_args", "%s(%#x, %o)", NULL, NULL },
> > +{ 254, "lchown_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 160, "lgetfh_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 9, "link_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 495, "linkat_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 257, "lio_listio_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 106, "listen_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 513, "lpathconf_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 478, "lseek_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 276, "lutimes_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 394, "mac_syscall_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 75, "madvise_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 584, "membarrier_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 78, "mincore_args", "%s(%#x, %#x, %s)", NULL, NULL },
> > +{ 250, "minherit_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 136, "mkdir_args", "%s(%#x, %o)", NULL, NULL },
> > +{ 496, "mkdirat_args", "%s(%#x, %#x, %o)", NULL, NULL },
> > +{ 132, "mkfifo_args", "%s(%#x, %o)", NULL, NULL },
> > +{ 497, "mkfifoat_args", "%s(%#x, %#x, %o)", NULL, NULL },
> > +{ 559, "mknodat_args", "%s(%#x, %#x, %o, %#x)", NULL, NULL },
> > +{ 203, "mlock_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 324, "mlockall_args", "%s(%#x)", NULL, NULL },
> > +{ 477, "mmap_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 303, "modfind_args", "%s(%#x)", NULL, NULL },
> > +{ 302, "modfnext_args", "%s(%#x)", NULL, NULL },
> > +{ 300, "modnext_args", "%s(%#x)", NULL, NULL },
> > +{ 301, "modstat_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 21, "mount_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 74, "mprotect_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 511, "msgctl_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 225, "msgget_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 227, "msgrcv_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 226, "msgsnd_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 170, "msgsys_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL }=
,
> > +{ 65, "msync_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 204, "munlock_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 325, "munlockall_args", NULL, NULL, NULL },
> > +{ 73, "munmap_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 240, "nanosleep_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 155, "nfssvc_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 154, "nlm_syscall_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 378, "nmount_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 339, "nnpfs_syscall_args", "%s(%#x, %s, %#x, %#x, %#x)", NULL, NULL =
},
> > +{ 176, "ntp_adjtime_args", "%s(%#x)", NULL, NULL },
> > +{ 248, "ntp_gettime_args", "%s(%#x)", NULL, NULL },
> > +{ 5, "open_args", "%s(%#x, %#x, %o)", NULL, NULL },
> > +{ 499, "openat_args", "%s(%#x, %#x, %#x, %o)", NULL, NULL },
> > +{ 191, "pathconf_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 518, "pdfork_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 520, "pdgetpid_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 519, "pdkill_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 600, "pdrfork_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 601, "pdwait_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 542, "pipe2_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 209, "poll_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 531, "posix_fadvise_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 530, "posix_fallocate_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 504, "posix_openpt_args", "%s(%#x)", NULL, NULL },
> > +{ 545, "ppoll_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 475, "pread_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 289, "preadv_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 544, "procctl_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 44, "profil_args", "%s(%s, %#x, %#x, %#x)", NULL, NULL },
> > +{ 522, "pselect_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL =
},
> > +{ 26, "ptrace_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 476, "pwrite_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 290, "pwritev_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 148, "quotactl_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 528, "rctl_add_rule_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 527, "rctl_get_limits_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 525, "rctl_get_racct_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 526, "rctl_get_rules_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 529, "rctl_remove_rule_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL }=
,
> > +{ 3, "read_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 58, "readlink_args", "%s(%#x, %s, %#x)", NULL, NULL },
> > +{ 500, "readlinkat_args", "%s(%#x, %#x, %s, %#x)", NULL, NULL },
> > +{ 120, "readv_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 55, "reboot_args", "%s(%#x)", NULL, NULL },
> > +{ 29, "recvfrom_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL =
},
> > +{ 27, "recvmsg_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 128, "rename_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 602, "renameat2_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 501, "renameat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 56, "revoke_args", "%s(%#x)", NULL, NULL },
> > +{ 251, "rfork_args", "%s(%#x)", NULL, NULL },
> > +{ 137, "rmdir_args", "%s(%#x)", NULL, NULL },
> > +{ 576, "rpctls_syscall_args", "%s(%#x)", NULL, NULL },
> > +{ 166, "rtprio_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 466, "rtprio_thread_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 332, "sched_get_priority_max_args", "%s(%#x)", NULL, NULL },
> > +{ 333, "sched_get_priority_min_args", "%s(%#x)", NULL, NULL },
> > +{ 581, "sched_getcpu_args", NULL, NULL, NULL },
> > +{ 328, "sched_getparam_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 330, "sched_getscheduler_args", "%s(%#x)", NULL, NULL },
> > +{ 334, "sched_rr_get_interval_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 327, "sched_setparam_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 329, "sched_setscheduler_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 331, "sched_yield_args", NULL, NULL, NULL },
> > +{ 474, "sctp_generic_recvmsg_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x,
> %#x)", NULL, NULL },
> > +{ 472, "sctp_generic_sendmsg_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x,
> %#x)", NULL, NULL },
> > +{ 473, "sctp_generic_sendmsg_iov_args", "%s(%#x, %#x, %#x, %#x, %#x,
> %#x, %#x)", NULL, NULL },
> > +{ 471, "sctp_peeloff_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 93, "select_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 221, "semget_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 222, "semop_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 169, "semsys_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 393, "sendfile_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x, %#x)", NULL,
> NULL },
> > +{ 28, "sendmsg_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 133, "sendto_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL }=
,
> > +{ 452, "setaudit_addr_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 450, "setaudit_args", "%s(%#x)", NULL, NULL },
> > +{ 448, "setauid_args", "%s(%#x)", NULL, NULL },
> > +{ 422, "setcontext_args", "%s(%#x)", NULL, NULL },
> > +{ 591, "setcred_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 182, "setegid_args", "%s(%#x)", NULL, NULL },
> > +{ 183, "seteuid_args", "%s(%#x)", NULL, NULL },
> > +{ 175, "setfib_args", "%s(%#x)", NULL, NULL },
> > +{ 181, "setgid_args", "%s(%#x)", NULL, NULL },
> > +{ 596, "setgroups_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 83, "setitimer_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 50, "setlogin_args", "%s(%#x)", NULL, NULL },
> > +{ 524, "setloginclass_args", "%s(%#x)", NULL, NULL },
> > +{ 82, "setpgid_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 96, "setpriority_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 127, "setregid_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 312, "setresgid_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 311, "setresuid_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 126, "setreuid_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 195, "setrlimit_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 147, "setsid_args", NULL, NULL, NULL },
> > +{ 105, "setsockopt_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 122, "settimeofday_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 23, "setuid_args", "%s(%#x)", NULL, NULL },
> > +{ 571, "shm_open2_args", "%s(%#x, %#x, %o, %#x, %#x)", NULL, NULL },
> > +{ 572, "shm_rename_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 483, "shm_unlink_args", "%s(%#x)", NULL, NULL },
> > +{ 228, "shmat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 512, "shmctl_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 230, "shmdt_args", "%s(%#x)", NULL, NULL },
> > +{ 231, "shmget_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 171, "shmsys_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 134, "shutdown_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 416, "sigaction_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 53, "sigaltstack_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 573, "sigfastblock_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 343, "sigpending_args", "%s(%#x)", NULL, NULL },
> > +{ 340, "sigprocmask_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 456, "sigqueue_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 417, "sigreturn_args", "%s(%#x)", NULL, NULL },
> > +{ 341, "sigsuspend_args", "%s(%#x)", NULL, NULL },
> > +{ 345, "sigtimedwait_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 429, "sigwait_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 346, "sigwaitinfo_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 97, "socket_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 135, "socketpair_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 555, "statfs_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 423, "swapcontext_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 582, "swapoff_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 85, "swapon_args", "%s(%#x)", NULL, NULL },
> > +{ 57, "symlink_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 502, "symlinkat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 36, "sync_args", NULL, NULL, NULL },
> > +{ 165, "sysarch_args", "%s(%#x, %s)", NULL, NULL },
> > +{ 430, "thr_create_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 431, "thr_exit_args", "%s(%#x)", NULL, NULL },
> > +{ 481, "thr_kill2_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 433, "thr_kill_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 455, "thr_new_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 432, "thr_self_args", "%s(%#x)", NULL, NULL },
> > +{ 464, "thr_set_name_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 442, "thr_suspend_args", "%s(%#x)", NULL, NULL },
> > +{ 443, "thr_wake_args", "%s(%#x)", NULL, NULL },
> > +{ 585, "timerfd_create_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 586, "timerfd_gettime_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 587, "timerfd_settime_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 479, "truncate_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 60, "umask_args", "%s(%o)", NULL, NULL },
> > +{ 205, "undelete_args", "%s(%#x)", NULL, NULL },
> > +{ 10, "unlink_args", "%s(%#x)", NULL, NULL },
> > +{ 503, "unlinkat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 22, "unmount_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 547, "utimensat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 138, "utimes_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 335, "utrace_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 392, "uuidgen_args", "%s(%#x, %#x)", NULL, NULL },
> > +{ 66, "vfork_args", NULL, NULL, NULL },
> > +{ 7, "wait4_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 532, "wait6_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
> > +{ 4, "write_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 121, "writev_args", "%s(%#x, %#x, %#x)", NULL, NULL },
> > +{ 321, "yield_args", NULL, NULL, NULL },
> >
>
> Overall looks good, and my comments on file variable should not be
> blocking.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>
> Regards,
> Pierrick
>

--0000000000000bf4400650a41fa1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 29,=
 2026 at 4:41=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bo=
uvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On 4/29/2026 7:38 =
AM, Warner Losh wrote:<br>
&gt; Generate strace.list in a stable way. All FreeBSD system call numbers<=
br>
&gt; are stable: they always and will forever mean only one thing (even if =
we<br>
&gt; abandon a syscall number and remove the code from the kernel, we&#39;l=
l<br>
&gt; never reuse it). System calls are the same across all architectures, a=
nd<br>
&gt; newer versions just have more of them. Use the number in the generated=
<br>
&gt; table so we can compile it on any version of FreeBSD.<br>
&gt; <br>
&gt; Also include the script that I used to generate this. It requires the<=
br>
&gt; FreeBSD source tree, which is why we can&#39;t use it to generate<br>
&gt; strace.list. This depends on the FreeBSD source tree at the moment,<br=
>
&gt; since it uses the same system call generation machinery that FreeBSD<b=
r>
&gt; uses to generate its system call tables, so we can&#39;t connect it to=
 the<br>
&gt; qemu build until that issue is corrected. We&#39;ve had a terrible str=
ace.list<br>
&gt; for a while, and this will make it better (and there&#39;s serious iss=
ues<br>
&gt; with strace, just like linux-user, so it&#39;s a little-used feature).=
<br>
&gt;<br>
<br>
That&#39;s fine for now, and you can eliminate the intree strace.list once<=
br>
it will be solved.<br></blockquote><div><br></div><div>Yes. That&#39;s the =
plan.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
&gt; Note: I derived this script from one of the FreeBSD system call<br>
&gt; generation scripts, so it needs to be BSD-2-Clause license, which<br>
&gt; deviates a bit from the GPL-2.0-or-newer preference, but I think is OK=
<br>
&gt; since it&#39;s not folded into the qemu binaries themselves (and outpu=
t of<br>
&gt; scripts is typically public domain, as is the case here). This script =
is<br>
&gt; written in lua, but every FreeBSD installation has a &#39;flua&#39; bi=
nary that<br>
&gt; can run this script, and it leverages about 7k lines of library and<br=
>
&gt; metadata FreeBSD maintains well.<br>
&gt;<br>
<br>
This sounds like a reasonable requirement given that it will be only<br>
called on FreeBSD hosts.<br>
<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 bsd-user/freebsd/scripts/strace.lua | 117 ++++++<br>
&gt;=C2=A0 bsd-user/freebsd/strace.list=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 708 ++=
++++++++++++++++++++--------------<br>
&gt;=C2=A0 2 files changed, 556 insertions(+), 269 deletions(-)<br>
&gt; <br>
&gt; diff --git a/bsd-user/freebsd/scripts/strace.lua b/bsd-user/freebsd/sc=
ripts/strace.lua<br>
&gt; new file mode 100755<br>
&gt; index 0000000000..c89e8e3aeb<br>
&gt; --- /dev/null<br>
&gt; +++ b/bsd-user/freebsd/scripts/strace.lua<br>
&gt; @@ -0,0 +1,117 @@<br>
&gt; +#!/usr/libexec/flua<br>
&gt; +--<br>
&gt; +-- SPDX-License-Identifier: BSD-2-Clause<br>
&gt; +--<br>
&gt; +-- Copyright (c) 2026 Warner Losh &lt;imp@FreeBSD.org&gt;<br>
&gt; +-- Copyright (c) 2024 Tyler Baxter &lt;agge@FreeBSD.org&gt;<br>
&gt; +-- Copyright (c) 2019 Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
&gt; +--<br>
&gt; +<br>
&gt; +-- Add library root to the package path.<br>
&gt; +local path =3D arg[0]:gsub(&quot;/[^/]+.lua$&quot;, &quot;&quot;)<br>
&gt; +package.path =3D package.path .. &quot;;&quot; .. path .. &quot;/?.lu=
a;&quot; .. os.getenv(&#39;FREEBSD_SYSCALL_DIR&#39;) .. &quot;/?.lua&quot;<=
br>
&gt; +<br>
&gt; +local FreeBSDSyscall =3D require(&quot;core.freebsd-syscall&quot;)<br=
>
&gt; +local generator =3D require(&quot;tools.generator&quot;)<br>
&gt; +local config =3D require(&quot;config&quot;)<br>
&gt; +<br>
&gt; +-- File has not been decided yet; config will decide file.=C2=A0 Defa=
ult defined as<br>
&gt; +-- /dev/null.<br>
<br>
Not sure what this comment means, given that it&#39;s declared and defined<=
br>
as stdout on next line<br></blockquote><div><br></div><div>The comment is w=
rong. It was copied from what I started with and is bogus.</div><div>I&#39;=
ll fix that.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; +file =3D &quot;/dev/stdout&quot;<br>
&gt; +<br>
&gt; +function generate(tbl, config, fh)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0-- Grab the master system calls table.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0local s =3D tbl.syscalls<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0table.sort(s, function(a, b)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return a.arg_alias &lt; b.arg_alias=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0end)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0-- Bind the generator to the parameter file.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0local gen =3D generator:new({}, fh)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0gen.storage_levels =3D {} -- make sure storage is=
 clear<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0-- Write the generated preamble.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0gen:preamble(&quot;FreeBSD strace list\nNOTE: Use=
 syscall numbers so we work on all the branches.&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for _, v in pairs(s) do<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0local c =3D v:compatL=
evel()<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-- Handle non-compat:=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if v:native() then<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0-- All these negation conditions are because (in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0-- general) these are cases where code for sysproto.h<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0-- is not generated.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if not v.type.NOARGS and not v.type.NOPROTO and<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0not v.type.NODEF then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fmt =3D &quot;NULL&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fcn =3D &quot;NULL&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if v.arg_alias =3D=3D &quot;__sysctl&quo=
t; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fcn =3D &quo=
t;print_sysctl&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elseif v.arg_alias =3D=3D &quot;execve&q=
uot; or v.arg_alias =3D=3D &quot;fexecve&quot; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fcn =3D &quo=
t;print_execve&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elseif v.arg_alias =3D=3D &quot;ioctl&qu=
ot; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fcn =3D &quo=
t;print_ioctl&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elseif v.arg_alias =3D=3D &quot;mmap&quo=
t; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fcn =3D &quo=
t;print_mmap&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elseif v.arg_alias =3D=3D &quot;sysarch&=
quot; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fcn =3D &quo=
t;print_sysarch&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elseif #v.args &gt; 0 then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fmt =3D &quo=
t;\&quot;%s(&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for _, arg i=
n ipairs(v.args) do<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if arg.type =3D=3D &quot;char *&quot; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fmt =3D fmt .. &quot;%s, &quot=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0elseif arg.type =3D=3D &quot;mode_t&quot; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fmt =3D fmt .. &quot;%o, &quot=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fmt =3D fmt .. &quot;%#x, &quo=
t;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0end<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0end<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fmt =3D fmt:=
sub(1, -3)=C2=A0 .. &quot;)\&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0end<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen:write(string.format(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;{ %d, \&quot;%s\&quo=
t;, %s, %s, NULL },\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v.num, v.arg_alias, fmt, f=
cn))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0end<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-- Handle compat (eve=
rything &gt;=3D FREEBSD9):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elseif c &gt;=3D 9 th=
en<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0local idx =3D c * 10<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if not v.type.NOARGS and not v.type.NOPROTO and<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0not v.type.NODEF then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fmt =3D &quot;NULL&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if #v.args &gt; 0 then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fmt =3D &quo=
t;\&quot;%s(&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for _, arg i=
n ipairs(v.args) do<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if arg.type =3D=3D &quot;char *&quot; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fmt =3D fmt .. &quot;%s, &quot=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0elseif arg.type =3D=3D &quot;mode_t&quot; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fmt =3D fmt .. &quot;%o, &quot=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fmt =3D fmt .. &quot;%#x, &quo=
t;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0end<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0end<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fmt =3D fmt:=
sub(1, -3)=C2=A0 .. &quot;)\&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0end<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen:write(string.format(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;{ %d, \&quot;%s\&quo=
t;, %s, %s, NULL },\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v.num, v.arg_alias, fmt, f=
cn))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0end<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0end<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-- Do nothing for obs=
olete, unimplemented, and reserved.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0end<br>
&gt; +end<br>
&gt; +<br>
&gt; +<br>
&gt; +if #arg &lt; 1 or #arg &gt; 2 then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0error(&quot;usage: &quot; .. arg[0] .. &quot; sys=
call.master&quot;)<br>
&gt; +end<br>
&gt; +<br>
&gt; +local sysfile =3D arg[1]<br>
&gt; +<br>
&gt; +config.merge(None)<br>
&gt; +config.mergeCompat()<br>
&gt; +<br>
&gt; +-- The parsed system call table.<br>
&gt; +local tbl =3D FreeBSDSyscall:new{sysfile =3D sysfile, config =3D conf=
ig}<br>
&gt; +<br>
&gt; +file =3D arg[2] or &quot;/dev/stdout&quot;<br>
<br>
I&#39;m not very familiar with lua, but since file has a default value set<=
br>
to /dev/stdout, I guess it could be?<br>
file =3D arg[2] or file<br></blockquote><div><br></div><div>Yea, this is ju=
st me being a little sloppy. I&#39;ll clean it up since I really shouldn&#3=
9;t have</div><div>the stuff at the top of the file and here. But you&#39;r=
e intuition is right, as written,</div><div>it would be better as &#39;or f=
ile&#39; here. I&#39;ll fix that in the next iteration.</div><div><br></div=
><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; +generate(tbl, config, file)<br>
&gt; diff --git a/bsd-user/freebsd/strace.list b/bsd-user/freebsd/strace.li=
st<br>
&gt; index d7f61f480e..2c4176475a 100644<br>
&gt; --- a/bsd-user/freebsd/strace.list<br>
&gt; +++ b/bsd-user/freebsd/strace.list<br>
&gt; @@ -1,273 +1,443 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 FreeBSD strace list<br>
&gt; + * FreeBSD strace list<br>
&gt; + * NOTE: Use syscall numbers so we work on all the branches.<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * DO NOT EDIT-- this file is automatically @generated.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt; -{ TARGET_FREEBSD_NR___acl_aclcheck_fd, &quot;__acl_aclcheck_fd&quot;,=
 &quot;%s(%d, %d, %#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR___acl_aclcheck_file, &quot;__acl_aclcheck_file&qu=
ot;, &quot;%s(\&quot;%s\&quot;, %d, %#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR___acl_aclcheck_link, &quot;__acl_aclcheck_link&qu=
ot;, &quot;%s(\&quot;%s\&quot;, %d, %#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR___acl_delete_fd, &quot;__acl_delete_fd&quot;, &qu=
ot;%s(%d, %d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR___acl_delete_file, &quot;__acl_delete_file&quot;,=
 &quot;%s(\&quot;%s\&quot;, %d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR___acl_delete_link, &quot;__acl_delete_link&quot;,=
 &quot;%s(\&quot;%s\&quot;, %d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR___acl_get_fd, &quot;__acl_get_fd&quot;, &quot;%s(=
%d, %d, %#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR___acl_get_file, &quot;__acl_get_file&quot;, &quot=
;%s(\&quot;%s\&quot;, %d, %#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR___acl_get_link, &quot;__acl_get_link&quot;, &quot=
;%s(\&quot;%s\&quot;, %d, %#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR___acl_set_fd, &quot;__acl_set_fd&quot;, &quot;%s(=
%d, %d, %#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR___acl_set_file, &quot;__acl_set_file&quot;, &quot=
;%s(\&quot;%s\&quot;, %d, %#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR___acl_set_link, &quot;__acl_set_link&quot;, &quot=
;%s(\&quot;%s\&quot;, %d, %#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR___getcwd, &quot;__getcwd&quot;, NULL, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR___semctl, &quot;__semctl&quot;, NULL, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR___syscall, &quot;__syscall&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR___sysctl, &quot;__sysctl&quot;, NULL, print_sysct=
l, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR__umtx_op, &quot;_umtx_op&quot;, &quot;%s(%#x, %d,=
 %d, %#x, %#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_accept, &quot;accept&quot;, &quot;%s(%d,%#x,%#x)&=
quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_accept4, &quot;accept4&quot;, &quot;%s(%d,%d,%#x,=
%#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_access, &quot;access&quot;, &quot;%s(\&quot;%s\&q=
uot;,%#o)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_acct, &quot;acct&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_adjtime, &quot;adjtime&quot;, NULL, NULL, NULL },=
<br>
&gt; -{ TARGET_FREEBSD_NR_bind, &quot;bind&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_bindat, &quot;bindat&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_break, &quot;break&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_cap_enter, &quot;cap_enter&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_cap_fcntls_get, &quot;cap_fcntls_get&quot;, NULL,=
 NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_cap_fcntls_limit, &quot;cap_fcntls_limit&quot;, N=
ULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_cap_getmode, &quot;cap_getmode&quot;, NULL, NULL,=
 NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_cap_ioctls_get, &quot;cap_ioctls_get&quot;, NULL,=
 NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_cap_ioctls_limit, &quot;cap_ioctls_limit&quot;, N=
ULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_cap_rights_limit, &quot;cap_rights_limit&quot;, N=
ULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_chdir, &quot;chdir&quot;, &quot;%s(\&quot;%s\&quo=
t;)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_chflags, &quot;chflags&quot;, NULL, NULL, NULL },=
<br>
&gt; -{ TARGET_FREEBSD_NR_chflagsat, &quot;chflagsat&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_chmod, &quot;chmod&quot;, &quot;%s(\&quot;%s\&quo=
t;,%#o)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_chown, &quot;chown&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_chroot, &quot;chroot&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_clock_getres, &quot;clock_getres&quot;, NULL, NUL=
L, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_clock_gettime, &quot;clock_gettime&quot;, NULL, N=
ULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_clock_settime, &quot;clock_settime&quot;, NULL, N=
ULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_close, &quot;close&quot;, &quot;%s(%d)&quot;, NUL=
L, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_connect, &quot;connect&quot;, &quot;%s(%d,%#x,%d)=
&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_connectat, &quot;connectat&quot;, &quot;%s(%d,%d,=
%#x,%d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_cpuset_getdomain, &quot;cpuset_getdomain&quot;, N=
ULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_cpuset_setdomain, &quot;cpuset_setdomain&quot;, N=
ULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_dup, &quot;dup&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_dup2, &quot;dup2&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_eaccess, &quot;eaccess&quot;, &quot;%s(\&quot;%s\=
&quot;,%#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_execve, &quot;execve&quot;, NULL, print_execve, N=
ULL },<br>
&gt; -{ TARGET_FREEBSD_NR_exit, &quot;exit&quot;, &quot;%s(%d)\n&quot;, NUL=
L, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_extattrctl, &quot;extattrctl&quot;, &quot;%s(\&qu=
ot;%s\&quot;, %d, \&quot;%s\&quot;, %d, \&quot;%s\&quot;&quot;, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_extattr_delete_fd, &quot;extattr_delete_fd&quot;,=
 &quot;%s(%d, %d, \&quot;%s\&quot;)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_extattr_delete_file, &quot;extattr_delete_file&qu=
ot;, &quot;%s(\&quot;%s\&quot;, %d, \&quot;%s\&quot;)&quot;, NULL, NULL },<=
br>
&gt; -{ TARGET_FREEBSD_NR_extattr_delete_link, &quot;extattr_delete_link&qu=
ot;, &quot;%s(\&quot;%s\&quot;, %d, \&quot;%s\&quot;)&quot;, NULL, NULL },<=
br>
&gt; -{ TARGET_FREEBSD_NR_extattr_get_fd, &quot;extattr_get_fd&quot;, &quot=
;%s(%d, %d, \&quot;%s\&quot;, %#x, %d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_extattr_get_file, &quot;extattr_get_file&quot;, &=
quot;%s(\&quot;%s\&quot;, %d, \&quot;%s\&quot;, %#x, %d)&quot;, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_extattr_get_file, &quot;extattr_get_link&quot;, &=
quot;%s(\&quot;%s\&quot;, %d, \&quot;%s\&quot;, %#x, %d)&quot;, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_extattr_list_fd, &quot;extattr_list_fd&quot;, &qu=
ot;%s(%d, %d, %#x, %d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_extattr_list_file, &quot;extattr_list_file&quot;,=
 &quot;%s(\&quot;%s\&quot;, %#x, %d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_extattr_list_link, &quot;extattr_list_link&quot;,=
 &quot;%s(\&quot;%s\&quot;, %d, %#x, %d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_extattr_set_fd, &quot;extattr_set_fd&quot;, &quot=
;%s(%d, %d, \&quot;%s\&quot;, %#x, %d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_extattr_set_file, &quot;extattr_set_file&quot;, &=
quot;%s(\&quot;%s\&quot;, %d, \&quot;%s\&quot;, %#x, %d)&quot;, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_extattr_set_link, &quot;extattr_set_link&quot;, &=
quot;%s(\&quot;%s\&quot;, %d, \&quot;%s\&quot;, %#x, %d)&quot;, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_fchdir, &quot;fchdir&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_fchflags, &quot;fchflags&quot;, NULL, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_fchmod, &quot;fchmod&quot;, &quot;%s(%d,%#o)&quot=
;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_fchown, &quot;fchown&quot;, &quot;%s(%d,%d,%d)&qu=
ot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_fcntl, &quot;fcntl&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_fdatasync, &quot;fdatasync&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_fexecve, &quot;fexecve&quot;, NULL, print_execve,=
 NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_fhopen, &quot;fhopen&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_fhstat, &quot;fhstat&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_fhstatfs, &quot;fhstatfs&quot;, NULL, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_freebsd11_fhstat, &quot;freebsd11_fhstat&quot;, N=
ULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_freebsd11_fhstatfs, &quot;freebsd11_fhstatfs&quot=
;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_flock, &quot;flock&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_fork, &quot;fork&quot;, &quot;%s()&quot;, NULL, N=
ULL },<br>
&gt; -{ TARGET_FREEBSD_NR_fpathconf, &quot;fpathconf&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_fstat, &quot;fstat&quot;, &quot;%s(%d,%#x)&quot;,=
 NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_fstatat, &quot;fstatat&quot;, &quot;%s(%d,\&quot;=
%s\&quot;, %#x, %d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_fstatfs, &quot;fstatfs&quot;, &quot;%s(%d,%#x)&qu=
ot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_freebsd11_fstat, &quot;freebsd11_fstat&quot;, &qu=
ot;%s(%d,%#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_freebsd11_fstatat, &quot;freebsd11_fstatat&quot;,=
 &quot;%s(%d,\&quot;%s\&quot;, %#x, %d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_freebsd11_fstatfs, &quot;freebsd11_fstatfs&quot;,=
 &quot;%s(%d,%#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_fsync, &quot;fsync&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_ftruncate, &quot;ftruncate&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_futimens, &quot;futimens&quot;, &quot;%s(%d,%p)&q=
uot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_futimes, &quot;futimes&quot;, NULL, NULL, NULL },=
<br>
&gt; -{ TARGET_FREEBSD_NR_getcontext, &quot;getcontext&quot;, &quot;%s(%#x)=
&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_getdirentries, &quot;getdirentries&quot;, NULL, N=
ULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_freebsd11_getdirentries, &quot;freebsd11_getdiren=
tries&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_getegid, &quot;getegid&quot;, &quot;%s()&quot;, N=
ULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_geteuid, &quot;geteuid&quot;, &quot;%s()&quot;, N=
ULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_getfh, &quot;getfh&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_getfsstat, &quot;getfsstat&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_freebsd11_getfsstat, &quot;freebsd11_getfsstat&qu=
ot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_getgid, &quot;getgid&quot;, &quot;%s()&quot;, NUL=
L, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_getgroups, &quot;getgroups&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_getitimer, &quot;getitimer&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_getlogin, &quot;getlogin&quot;, NULL, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_getpeername, &quot;getpeername&quot;, NULL, NULL,=
 NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_getpgid, &quot;getpgid&quot;, NULL, NULL, NULL },=
<br>
&gt; -{ TARGET_FREEBSD_NR_getpgrp, &quot;getpgrp&quot;, &quot;%s()&quot;, N=
ULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_getpid, &quot;getpid&quot;, &quot;%s()&quot;, NUL=
L, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_getppid, &quot;getppid&quot;, &quot;%s()&quot;, N=
ULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_getpriority, &quot;getpriority&quot;, &quot;%s(%#=
x,%#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_getrandom, &quot;getrandom&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_getresgid, &quot;getresgid&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_getresuid, &quot;getresuid&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_getrlimit, &quot;getrlimit&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_getrusage, &quot;getrusage&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_getsid, &quot;getsid&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_getsockname, &quot;getsockname&quot;, NULL, NULL,=
 NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_getsockopt, &quot;getsockopt&quot;, NULL, NULL, N=
ULL },<br>
&gt; -{ TARGET_FREEBSD_NR_gettimeofday, &quot;gettimeofday&quot;, NULL, NUL=
L, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_getuid, &quot;getuid&quot;, &quot;%s()&quot;, NUL=
L, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_ioctl, &quot;ioctl&quot;, NULL, print_ioctl, NULL=
 },<br>
&gt; -{ TARGET_FREEBSD_NR_issetugid, &quot;issetugid&quot;, &quot;%s()&quot=
;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_freebsd11_kevent, &quot;freebsd11_kevent&quot;, N=
ULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_kevent, &quot;kevent&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_kill, &quot;kill&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_kqueue, &quot;kqueue&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_ktrace, &quot;ktrace&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_lchown, &quot;lchown&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_link, &quot;link&quot;, &quot;%s(\&quot;%s\&quot;=
,\&quot;%s\&quot;)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_listen, &quot;listen&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_lpathconf, &quot;lpathconf&quot;, &quot;%s(\&quot=
;%s\&quot;, %d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_lseek, &quot;lseek&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_freebsd11_lstat, &quot;freebsd11_lstat&quot;, &qu=
ot;%s(\&quot;%s\&quot;,%p)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_madvise, &quot;madvise&quot;, NULL, NULL, NULL },=
<br>
&gt; -{ TARGET_FREEBSD_NR_mincore, &quot;mincore&quot;, NULL, NULL, NULL },=
<br>
&gt; -{ TARGET_FREEBSD_NR_minherit, &quot;minherit&quot;, NULL, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_mkdir, &quot;mkdir&quot;, &quot;%s(\&quot;%s\&quo=
t;,%#o)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_mkfifo, &quot;mkfifo&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_mknodat, &quot;mknodat&quot;, &quot;%s(%d, \&quot=
;%s\&quot;,%#o,%#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_freebsd11_mknod, &quot;freebsd11_mknod&quot;, &qu=
ot;%s(\&quot;%s\&quot;,%#o,%#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_freebsd11_mknodat, &quot;freebsd11_mknodat&quot;,=
 &quot;%s(%d, \&quot;%s\&quot;,%#o,%#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_mlock, &quot;mlock&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_mlockall, &quot;mlockall&quot;, NULL, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_mmap, &quot;mmap&quot;, NULL, NULL, print_syscall=
_ret_addr },<br>
&gt; -{ TARGET_FREEBSD_NR_mount, &quot;mount&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_mprotect, &quot;mprotect&quot;, &quot;%s(%#x,%#x,=
%d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_msgctl, &quot;msgctl&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_msgget, &quot;msgget&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_msgrcv, &quot;msgrcv&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_msgsnd, &quot;msgsnd&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_msync, &quot;msync&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_munlock, &quot;munlock&quot;, NULL, NULL, NULL },=
<br>
&gt; -{ TARGET_FREEBSD_NR_munlockall, &quot;munlockall&quot;, NULL, NULL, N=
ULL },<br>
&gt; -{ TARGET_FREEBSD_NR_munmap, &quot;munmap&quot;, &quot;%s(%p,%d)&quot;=
, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_nanosleep, &quot;nanosleep&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_nfssvc, &quot;nfssvc&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_open, &quot;open&quot;, &quot;%s(\&quot;%s\&quot;=
,%#x,%#o)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_openat, &quot;openat&quot;, &quot;%s(%d, \&quot;%=
s\&quot;,%#x,%#o)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_pathconf, &quot;pathconf&quot;, &quot;%s(\&quot;%=
s\&quot;, %d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_freebsd10_pipe, &quot;freebsd10_pipe&quot;, NULL,=
 NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_pipe2, &quot;pipe2&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_poll, &quot;poll&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_posix_fallocate, &quot;posix_fallocate&quot;, NUL=
L, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_pread, &quot;pread&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_preadv, &quot;preadv&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_profil, &quot;profil&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_ptrace, &quot;ptrace&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_pwrite, &quot;pwrite&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_pwritev, &quot;pwritev&quot;, NULL, NULL, NULL },=
<br>
&gt; -{ TARGET_FREEBSD_NR_quotactl, &quot;quotactl&quot;, NULL, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_read, &quot;read&quot;, &quot;%s(%d,%#x,%d)&quot;=
, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_readlink, &quot;readlink&quot;, &quot;%s(\&quot;%=
s\&quot;,%p,%d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_readv, &quot;readv&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_reboot, &quot;reboot&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_recvfrom, &quot;recvfrom&quot;, NULL, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_recvmsg, &quot;recvmsg&quot;, NULL, NULL, NULL },=
<br>
&gt; -{ TARGET_FREEBSD_NR_rename, &quot;rename&quot;, &quot;%s(\&quot;%s\&q=
uot;,\&quot;%s\&quot;)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_revoke, &quot;revoke&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_rfork, &quot;rfork&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_rmdir, &quot;rmdir&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_rtprio_thread, &quot;rtprio_thread&quot;, &quot;%=
s(%d, %d, %p)&quot;, NULL, NULL },<br>
&gt; -#ifdef TARGET_FREEBSD_NR_sbrk<br>
&gt; -{ TARGET_FREEBSD_NR_sbrk, &quot;sbrk&quot;, NULL, NULL, NULL },<br>
&gt; -#endif<br>
&gt; -{ TARGET_FREEBSD_NR_sched_get_priority_max, &quot;sched_get_priority_=
max&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_sched_get_priority_min, &quot;sched_get_priority_=
min&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_sched_yield, &quot;sched_yield&quot;, NULL, NULL,=
 NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_select, &quot;select&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_semget, &quot;semget&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_semop, &quot;semop&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_sendmsg, &quot;sendmsg&quot;, NULL, NULL, NULL },=
<br>
&gt; -{ TARGET_FREEBSD_NR_sendto, &quot;sendto&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_setcontext, &quot;setcontext&quot;, &quot;%s(%#x)=
&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_setegid, &quot;setegid&quot;, NULL, NULL, NULL },=
<br>
&gt; -{ TARGET_FREEBSD_NR_seteuid, &quot;seteuid&quot;, NULL, NULL, NULL },=
<br>
&gt; -{ TARGET_FREEBSD_NR_setgid, &quot;setgid&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_setgroups, &quot;setgroups&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_setitimer, &quot;setitimer&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_setlogin, &quot;setlogin&quot;, NULL, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_setpgid, &quot;setpgid&quot;, NULL, NULL, NULL },=
<br>
&gt; -{ TARGET_FREEBSD_NR_setpriority, &quot;setpriority&quot;, NULL, NULL,=
 NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_setregid, &quot;setregid&quot;, NULL, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_setresgid, &quot;setresgid&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_setresuid, &quot;setresuid&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_setreuid, &quot;setreuid&quot;, NULL, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_setrlimit, &quot;setrlimit&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_setsid, &quot;setsid&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_setsockopt, &quot;setsockopt&quot;, NULL, NULL, N=
ULL },<br>
&gt; -{ TARGET_FREEBSD_NR_settimeofday, &quot;settimeofday&quot;, NULL, NUL=
L, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_setuid, &quot;setuid&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_shmat, &quot;shmat&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_shmctl, &quot;shmctl&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_shmdt, &quot;shmdt&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_shmget, &quot;shmget&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_shutdown, &quot;shutdown&quot;, NULL, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_sigaction, &quot;sigaction&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_sigaltstack, &quot;sigaltstack&quot;, &quot;%s(%p=
,%p)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_sigpending, &quot;sigpending&quot;, NULL, NULL, N=
ULL },<br>
&gt; -{ TARGET_FREEBSD_NR_sigprocmask, &quot;sigprocmask&quot;, NULL, NULL,=
 NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_sigreturn, &quot;sigreturn&quot;, NULL, NULL, NUL=
L },<br>
&gt; -{ TARGET_FREEBSD_NR_sigsuspend, &quot;sigsuspend&quot;, NULL, NULL, N=
ULL },<br>
&gt; -{ TARGET_FREEBSD_NR_socket, &quot;socket&quot;, &quot;%s(%d,%d,%d)&qu=
ot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_socketpair, &quot;socketpair&quot;, NULL, NULL, N=
ULL },<br>
&gt; -#ifdef TARGET_FREEBSD_NR_sstk<br>
&gt; -{ TARGET_FREEBSD_NR_sstk, &quot;sstk&quot;, NULL, NULL, NULL },<br>
&gt; -#endif<br>
&gt; -{ TARGET_FREEBSD_NR_freebsd11_stat, &quot;freebsd11_stat&quot;, &quot=
;%s(\&quot;%s\&quot;,%p)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_freebsd11_statfs, &quot;freebsd11_statfs&quot;, &=
quot;%s(\&quot;%s\&quot;,%p)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_symlink, &quot;symlink&quot;, &quot;%s(\&quot;%s\=
&quot;,\&quot;%s\&quot;)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_sync, &quot;sync&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_sysarch, &quot;sysarch&quot;, NULL, print_sysarch=
, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_syscall, &quot;syscall&quot;, NULL, NULL, NULL },=
<br>
&gt; -{ TARGET_FREEBSD_NR_ktimer_create, &quot;timer_create&quot; , NULL, N=
ULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_ktimer_delete, &quot;timer_delete&quot; , NULL, N=
ULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_ktimer_settime, &quot;timer_settime&quot; , NULL,=
 NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_ktimer_gettime, &quot;timer_gettime&quot; , NULL,=
 NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_ktimer_getoverrun, &quot;timer_getoverrun&quot; ,=
 NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_thr_create, &quot;thr_create&quot;, &quot;%s(%#x,=
 %#x, %d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_thr_exit, &quot;thr_exit&quot;, &quot;%s(%#x)&quo=
t;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_thr_kill, &quot;thr_kill&quot;, &quot;%s(%d, %#x)=
&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_thr_kill2, &quot;thr_kill2&quot;, &quot;%s(%d, %d=
, %d)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_thr_new, &quot;thr_new&quot;, &quot;%s(%#x, %d)&q=
uot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_thr_self, &quot;thr_self&quot;, &quot;%s(%#x)&quo=
t;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_thr_set_name, &quot;thr_set_name&quot;, &quot;%s(=
%d, \&quot;%s\&quot;)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_thr_suspend, &quot;thr_suspend&quot;, &quot;%s(%d=
, %#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_thr_wake, &quot;thr_wake&quot;, &quot;%s(%d)&quot=
;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_truncate, &quot;truncate&quot;, NULL, NULL, NULL =
},<br>
&gt; -{ TARGET_FREEBSD_NR_umask, &quot;umask&quot;, &quot;%s(%#o)&quot;, NU=
LL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_unlink, &quot;unlink&quot;, &quot;%s(\&quot;%s\&q=
uot;)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_unmount, &quot;unmount&quot;, NULL, NULL, NULL },=
<br>
&gt; -{ TARGET_FREEBSD_NR_utimes, &quot;utimes&quot;, NULL, NULL, NULL },<b=
r>
&gt; -{ TARGET_FREEBSD_NR_utimensat, &quot;utimensat&quot;, &quot;%s(%d,%s,=
%p,%#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_vfork, &quot;vfork&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_wait4, &quot;wait4&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_wait6, &quot;wait6&quot;, NULL, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_write, &quot;write&quot;, &quot;%s(%d,%#x,%d)&quo=
t;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_writev, &quot;writev&quot;, &quot;%s(%d,%p,%#x)&q=
uot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR_posix_openpt, &quot;posix_openpt&quot;, &quot;%s(=
%d)&quot;, NULL, NULL },<br>
&gt; +{ 354, &quot;__acl_aclcheck_fd_args&quot;, &quot;%s(%#x, %#x, %#x)&qu=
ot;, NULL, NULL },<br>
&gt; +{ 353, &quot;__acl_aclcheck_file_args&quot;, &quot;%s(%#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 428, &quot;__acl_aclcheck_link_args&quot;, &quot;%s(%#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 352, &quot;__acl_delete_fd_args&quot;, &quot;%s(%#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 351, &quot;__acl_delete_file_args&quot;, &quot;%s(%#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 427, &quot;__acl_delete_link_args&quot;, &quot;%s(%#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 349, &quot;__acl_get_fd_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 347, &quot;__acl_get_file_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 425, &quot;__acl_get_link_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 350, &quot;__acl_set_fd_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 348, &quot;__acl_set_file_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 426, &quot;__acl_set_link_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 515, &quot;__cap_rights_get_args&quot;, &quot;%s(%#x, %#x, %#x)&quo=
t;, NULL, NULL },<br>
&gt; +{ 326, &quot;__getcwd_args&quot;, &quot;%s(%s, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 415, &quot;__mac_execve_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&qu=
ot;, NULL, NULL },<br>
&gt; +{ 386, &quot;__mac_get_fd_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 387, &quot;__mac_get_file_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 410, &quot;__mac_get_link_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 409, &quot;__mac_get_pid_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 384, &quot;__mac_get_proc_args&quot;, &quot;%s(%#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 388, &quot;__mac_set_fd_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 389, &quot;__mac_set_file_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 411, &quot;__mac_set_link_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 385, &quot;__mac_set_proc_args&quot;, &quot;%s(%#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 574, &quot;__realpathat_args&quot;, &quot;%s(%#x, %#x, %s, %#x, %#x=
)&quot;, NULL, NULL },<br>
&gt; +{ 510, &quot;__semctl_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;,=
 NULL, NULL },<br>
&gt; +{ 374, &quot;__setugid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 577, &quot;__specialfd_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 202, &quot;__sysctl_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %=
#x)&quot;, NULL, NULL },<br>
&gt; +{ 570, &quot;__sysctlbyname_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, =
%#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 1, &quot;_exit_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 454, &quot;_umtx_op_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&q=
uot;, NULL, NULL },<br>
&gt; +{ 463, &quot;abort2_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 541, &quot;accept4_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 30, &quot;accept_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 33, &quot;access_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 51, &quot;acct_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 140, &quot;adjtime_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 377, &quot;afs3_syscall_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#=
x, %#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 316, &quot;aio_cancel_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 317, &quot;aio_error_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 465, &quot;aio_fsync_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 543, &quot;aio_mlock_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 255, &quot;aio_read_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 579, &quot;aio_readv_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 314, &quot;aio_return_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 315, &quot;aio_suspend_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 359, &quot;aio_waitcomplete_args&quot;, &quot;%s(%#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 256, &quot;aio_write_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 578, &quot;aio_writev_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 445, &quot;audit_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 453, &quot;auditctl_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 446, &quot;auditon_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 104, &quot;bind_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 538, &quot;bindat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 17, &quot;break_args&quot;, &quot;%s(%s)&quot;, NULL, NULL },<br>
&gt; +{ 516, &quot;cap_enter_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 537, &quot;cap_fcntls_get_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 536, &quot;cap_fcntls_limit_args&quot;, &quot;%s(%#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 517, &quot;cap_getmode_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 535, &quot;cap_ioctls_get_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 534, &quot;cap_ioctls_limit_args&quot;, &quot;%s(%#x, %#x, %#x)&quo=
t;, NULL, NULL },<br>
&gt; +{ 533, &quot;cap_rights_limit_args&quot;, &quot;%s(%#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 12, &quot;chdir_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 34, &quot;chflags_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 540, &quot;chflagsat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 15, &quot;chmod_args&quot;, &quot;%s(%#x, %o)&quot;, NULL, NULL },<=
br>
&gt; +{ 16, &quot;chown_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 61, &quot;chroot_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 247, &quot;clock_getcpuclockid2_args&quot;, &quot;%s(%#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 234, &quot;clock_getres_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 232, &quot;clock_gettime_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 244, &quot;clock_nanosleep_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 233, &quot;clock_settime_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 6, &quot;close_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 575, &quot;close_range_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 98, &quot;connect_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 539, &quot;connectat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 569, &quot;copy_file_range_args&quot;, &quot;%s(%#x, %#x, %#x, %#x,=
 %#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 484, &quot;cpuset_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br=
>
&gt; +{ 487, &quot;cpuset_getaffinity_args&quot;, &quot;%s(%#x, %#x, %#x, %=
#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 561, &quot;cpuset_getdomain_args&quot;, &quot;%s(%#x, %#x, %#x, %#x=
, %#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 486, &quot;cpuset_getid_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&qu=
ot;, NULL, NULL },<br>
&gt; +{ 488, &quot;cpuset_setaffinity_args&quot;, &quot;%s(%#x, %#x, %#x, %=
#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 562, &quot;cpuset_setdomain_args&quot;, &quot;%s(%#x, %#x, %#x, %#x=
, %#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 485, &quot;cpuset_setid_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 90, &quot;dup2_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 41, &quot;dup_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 376, &quot;eaccess_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 59, &quot;execve_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 373, &quot;extattr_delete_fd_args&quot;, &quot;%s(%#x, %#x, %#x)&qu=
ot;, NULL, NULL },<br>
&gt; +{ 358, &quot;extattr_delete_file_args&quot;, &quot;%s(%#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 414, &quot;extattr_delete_link_args&quot;, &quot;%s(%#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 372, &quot;extattr_get_fd_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, =
%#x)&quot;, NULL, NULL },<br>
&gt; +{ 357, &quot;extattr_get_file_args&quot;, &quot;%s(%#x, %#x, %#x, %#x=
, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 413, &quot;extattr_get_link_args&quot;, &quot;%s(%#x, %#x, %#x, %#x=
, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 437, &quot;extattr_list_fd_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 438, &quot;extattr_list_file_args&quot;, &quot;%s(%#x, %#x, %#x, %#=
x)&quot;, NULL, NULL },<br>
&gt; +{ 439, &quot;extattr_list_link_args&quot;, &quot;%s(%#x, %#x, %#x, %#=
x)&quot;, NULL, NULL },<br>
&gt; +{ 371, &quot;extattr_set_fd_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, =
%#x)&quot;, NULL, NULL },<br>
&gt; +{ 356, &quot;extattr_set_file_args&quot;, &quot;%s(%#x, %#x, %#x, %#x=
, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 412, &quot;extattr_set_link_args&quot;, &quot;%s(%#x, %#x, %#x, %#x=
, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 355, &quot;extattrctl_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 592, &quot;exterrctl_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 489, &quot;faccessat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 13, &quot;fchdir_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 35, &quot;fchflags_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 124, &quot;fchmod_args&quot;, &quot;%s(%#x, %o)&quot;, NULL, NULL }=
,<br>
&gt; +{ 490, &quot;fchmodat_args&quot;, &quot;%s(%#x, %#x, %o, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 123, &quot;fchown_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 491, &quot;fchownat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&q=
uot;, NULL, NULL },<br>
&gt; +{ 590, &quot;fchroot_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 92, &quot;fcntl_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 550, &quot;fdatasync_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 492, &quot;fexecve_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 241, &quot;ffclock_getcounter_args&quot;, &quot;%s(%#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 243, &quot;ffclock_getestimate_args&quot;, &quot;%s(%#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 242, &quot;ffclock_setestimate_args&quot;, &quot;%s(%#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 565, &quot;fhlink_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 566, &quot;fhlinkat_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 298, &quot;fhopen_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 567, &quot;fhreadlink_args&quot;, &quot;%s(%#x, %s, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 553, &quot;fhstat_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 558, &quot;fhstatfs_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 131, &quot;flock_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 2, &quot;fork_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 192, &quot;fpathconf_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 434, &quot;freebsd10__umtx_lock_args&quot;, &quot;%s(%#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 435, &quot;freebsd10__umtx_unlock_args&quot;, &quot;%s(%#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 42, &quot;freebsd10_pipe_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 299, &quot;freebsd11_fhstat_args&quot;, &quot;%s(%#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 398, &quot;freebsd11_fhstatfs_args&quot;, &quot;%s(%#x, %#x)&quot;,=
 NULL, NULL },<br>
&gt; +{ 189, &quot;freebsd11_fstat_args&quot;, &quot;%s(%#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 493, &quot;freebsd11_fstatat_args&quot;, &quot;%s(%#x, %#x, %#x, %#=
x)&quot;, NULL, NULL },<br>
&gt; +{ 397, &quot;freebsd11_fstatfs_args&quot;, &quot;%s(%#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 272, &quot;freebsd11_getdents_args&quot;, &quot;%s(%#x, %s, %#x)&qu=
ot;, NULL, NULL },<br>
&gt; +{ 196, &quot;freebsd11_getdirentries_args&quot;, &quot;%s(%#x, %s, %#=
x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 395, &quot;freebsd11_getfsstat_args&quot;, &quot;%s(%#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 363, &quot;freebsd11_kevent_args&quot;, &quot;%s(%#x, %#x, %#x, %#x=
, %#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 190, &quot;freebsd11_lstat_args&quot;, &quot;%s(%#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 14, &quot;freebsd11_mknod_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 498, &quot;freebsd11_mknodat_args&quot;, &quot;%s(%#x, %#x, %o, %#x=
)&quot;, NULL, NULL },<br>
&gt; +{ 279, &quot;freebsd11_nfstat_args&quot;, &quot;%s(%#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 280, &quot;freebsd11_nlstat_args&quot;, &quot;%s(%#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 278, &quot;freebsd11_nstat_args&quot;, &quot;%s(%#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 188, &quot;freebsd11_stat_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 396, &quot;freebsd11_statfs_args&quot;, &quot;%s(%#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 72, &quot;freebsd11_vadvise_args&quot;, &quot;%s(%#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 509, &quot;freebsd12_closefrom_args&quot;, &quot;%s(%#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 482, &quot;freebsd12_shm_open_args&quot;, &quot;%s(%#x, %#x, %o)&qu=
ot;, NULL, NULL },<br>
&gt; +{ 424, &quot;freebsd13_swapoff_args&quot;, &quot;%s(%#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 79, &quot;freebsd14_getgroups_args&quot;, &quot;%s(%#x, %#x)&quot;,=
 NULL, NULL },<br>
&gt; +{ 80, &quot;freebsd14_setgroups_args&quot;, &quot;%s(%#x, %#x)&quot;,=
 NULL, NULL },<br>
&gt; +{ 580, &quot;fspacectl_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 551, &quot;fstat_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 552, &quot;fstatat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 556, &quot;fstatfs_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 95, &quot;fsync_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 480, &quot;ftruncate_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 568, &quot;funlinkat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 546, &quot;futimens_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 206, &quot;futimes_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 494, &quot;futimesat_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 451, &quot;getaudit_addr_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 449, &quot;getaudit_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 447, &quot;getauid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 421, &quot;getcontext_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 554, &quot;getdirentries_args&quot;, &quot;%s(%#x, %s, %#x, %#x)&qu=
ot;, NULL, NULL },<br>
&gt; +{ 89, &quot;getdtablesize_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 43, &quot;getegid_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 25, &quot;geteuid_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 161, &quot;getfh_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 564, &quot;getfhat_args&quot;, &quot;%s(%#x, %s, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 557, &quot;getfsstat_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 47, &quot;getgid_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 595, &quot;getgroups_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 86, &quot;getitimer_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 49, &quot;getlogin_args&quot;, &quot;%s(%s, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 523, &quot;getloginclass_args&quot;, &quot;%s(%s, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 31, &quot;getpeername_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 207, &quot;getpgid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 81, &quot;getpgrp_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 20, &quot;getpid_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 39, &quot;getppid_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 100, &quot;getpriority_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 563, &quot;getrandom_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 361, &quot;getresgid_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 360, &quot;getresuid_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 194, &quot;getrlimit_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 589, &quot;getrlimitusage_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 117, &quot;getrusage_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 310, &quot;getsid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br=
>
&gt; +{ 32, &quot;getsockname_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 118, &quot;getsockopt_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 116, &quot;gettimeofday_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 24, &quot;getuid_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 593, &quot;inotify_add_watch_at_args&quot;, &quot;%s(%#x, %#x, %#x,=
 %#x)&quot;, NULL, NULL },<br>
&gt; +{ 594, &quot;inotify_rm_watch_args&quot;, &quot;%s(%#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 54, &quot;ioctl_args&quot;, &quot;%s(%#x, %#x, %s)&quot;, NULL, NUL=
L },<br>
&gt; +{ 253, &quot;issetugid_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 338, &quot;jail_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 436, &quot;jail_attach_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 597, &quot;jail_attach_jd_args&quot;, &quot;%s(%#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 506, &quot;jail_get_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 508, &quot;jail_remove_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 598, &quot;jail_remove_jd_args&quot;, &quot;%s(%#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 507, &quot;jail_set_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 588, &quot;kcmp_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 390, &quot;kenv_args&quot;, &quot;%s(%#x, %#x, %s, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 560, &quot;kevent_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %#x=
)&quot;, NULL, NULL },<br>
&gt; +{ 599, &quot;kexec_load_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot=
;, NULL, NULL },<br>
&gt; +{ 37, &quot;kill_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 306, &quot;kldfind_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 309, &quot;kldfirstmod_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 304, &quot;kldload_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 307, &quot;kldnext_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 308, &quot;kldstat_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 337, &quot;kldsym_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 305, &quot;kldunload_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 444, &quot;kldunloadf_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 461, &quot;kmq_notify_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 457, &quot;kmq_open_args&quot;, &quot;%s(%#x, %#x, %o, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 458, &quot;kmq_setattr_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 459, &quot;kmq_timedreceive_args&quot;, &quot;%s(%#x, %s, %#x, %#x,=
 %#x)&quot;, NULL, NULL },<br>
&gt; +{ 460, &quot;kmq_timedsend_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %=
#x)&quot;, NULL, NULL },<br>
&gt; +{ 462, &quot;kmq_unlink_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 362, &quot;kqueue_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 583, &quot;kqueuex_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 400, &quot;ksem_close_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 408, &quot;ksem_destroy_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 407, &quot;ksem_getvalue_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 404, &quot;ksem_init_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 405, &quot;ksem_open_args&quot;, &quot;%s(%#x, %#x, %#x, %o, %#x)&q=
uot;, NULL, NULL },<br>
&gt; +{ 401, &quot;ksem_post_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 441, &quot;ksem_timedwait_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 403, &quot;ksem_trywait_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 406, &quot;ksem_unlink_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 402, &quot;ksem_wait_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 235, &quot;ktimer_create_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;,=
 NULL, NULL },<br>
&gt; +{ 236, &quot;ktimer_delete_args&quot;, &quot;%s(%#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 239, &quot;ktimer_getoverrun_args&quot;, &quot;%s(%#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 238, &quot;ktimer_gettime_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 237, &quot;ktimer_settime_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 45, &quot;ktrace_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 391, &quot;lchflags_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 274, &quot;lchmod_args&quot;, &quot;%s(%#x, %o)&quot;, NULL, NULL }=
,<br>
&gt; +{ 254, &quot;lchown_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 160, &quot;lgetfh_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 9, &quot;link_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 495, &quot;linkat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&quo=
t;, NULL, NULL },<br>
&gt; +{ 257, &quot;lio_listio_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot=
;, NULL, NULL },<br>
&gt; +{ 106, &quot;listen_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 513, &quot;lpathconf_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 478, &quot;lseek_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 276, &quot;lutimes_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 394, &quot;mac_syscall_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 75, &quot;madvise_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 584, &quot;membarrier_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 78, &quot;mincore_args&quot;, &quot;%s(%#x, %#x, %s)&quot;, NULL, N=
ULL },<br>
&gt; +{ 250, &quot;minherit_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 136, &quot;mkdir_args&quot;, &quot;%s(%#x, %o)&quot;, NULL, NULL },=
<br>
&gt; +{ 496, &quot;mkdirat_args&quot;, &quot;%s(%#x, %#x, %o)&quot;, NULL, =
NULL },<br>
&gt; +{ 132, &quot;mkfifo_args&quot;, &quot;%s(%#x, %o)&quot;, NULL, NULL }=
,<br>
&gt; +{ 497, &quot;mkfifoat_args&quot;, &quot;%s(%#x, %#x, %o)&quot;, NULL,=
 NULL },<br>
&gt; +{ 559, &quot;mknodat_args&quot;, &quot;%s(%#x, %#x, %o, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 203, &quot;mlock_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 324, &quot;mlockall_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 477, &quot;mmap_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 303, &quot;modfind_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 302, &quot;modfnext_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 300, &quot;modnext_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 301, &quot;modstat_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 21, &quot;mount_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 74, &quot;mprotect_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 511, &quot;msgctl_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 225, &quot;msgget_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 227, &quot;msgrcv_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&quo=
t;, NULL, NULL },<br>
&gt; +{ 226, &quot;msgsnd_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 170, &quot;msgsys_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %#x=
)&quot;, NULL, NULL },<br>
&gt; +{ 65, &quot;msync_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 204, &quot;munlock_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 325, &quot;munlockall_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 73, &quot;munmap_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 240, &quot;nanosleep_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 155, &quot;nfssvc_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 154, &quot;nlm_syscall_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quo=
t;, NULL, NULL },<br>
&gt; +{ 378, &quot;nmount_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 339, &quot;nnpfs_syscall_args&quot;, &quot;%s(%#x, %s, %#x, %#x, %#=
x)&quot;, NULL, NULL },<br>
&gt; +{ 176, &quot;ntp_adjtime_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 248, &quot;ntp_gettime_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 5, &quot;open_args&quot;, &quot;%s(%#x, %#x, %o)&quot;, NULL, NULL =
},<br>
&gt; +{ 499, &quot;openat_args&quot;, &quot;%s(%#x, %#x, %#x, %o)&quot;, NU=
LL, NULL },<br>
&gt; +{ 191, &quot;pathconf_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 518, &quot;pdfork_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 520, &quot;pdgetpid_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 519, &quot;pdkill_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 600, &quot;pdrfork_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 601, &quot;pdwait_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&quo=
t;, NULL, NULL },<br>
&gt; +{ 542, &quot;pipe2_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 209, &quot;poll_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 531, &quot;posix_fadvise_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&q=
uot;, NULL, NULL },<br>
&gt; +{ 530, &quot;posix_fallocate_args&quot;, &quot;%s(%#x, %#x, %#x)&quot=
;, NULL, NULL },<br>
&gt; +{ 504, &quot;posix_openpt_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 545, &quot;ppoll_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 475, &quot;pread_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 289, &quot;preadv_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 544, &quot;procctl_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 44, &quot;profil_args&quot;, &quot;%s(%s, %#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 522, &quot;pselect_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %#=
x)&quot;, NULL, NULL },<br>
&gt; +{ 26, &quot;ptrace_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 476, &quot;pwrite_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 290, &quot;pwritev_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 148, &quot;quotactl_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;,=
 NULL, NULL },<br>
&gt; +{ 528, &quot;rctl_add_rule_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&q=
uot;, NULL, NULL },<br>
&gt; +{ 527, &quot;rctl_get_limits_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 525, &quot;rctl_get_racct_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 526, &quot;rctl_get_rules_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 529, &quot;rctl_remove_rule_args&quot;, &quot;%s(%#x, %#x, %#x, %#x=
)&quot;, NULL, NULL },<br>
&gt; +{ 3, &quot;read_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 58, &quot;readlink_args&quot;, &quot;%s(%#x, %s, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 500, &quot;readlinkat_args&quot;, &quot;%s(%#x, %#x, %s, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 120, &quot;readv_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 55, &quot;reboot_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 29, &quot;recvfrom_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %#=
x)&quot;, NULL, NULL },<br>
&gt; +{ 27, &quot;recvmsg_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 128, &quot;rename_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 602, &quot;renameat2_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 501, &quot;renameat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;,=
 NULL, NULL },<br>
&gt; +{ 56, &quot;revoke_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 251, &quot;rfork_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 137, &quot;rmdir_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 576, &quot;rpctls_syscall_args&quot;, &quot;%s(%#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 166, &quot;rtprio_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 466, &quot;rtprio_thread_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;,=
 NULL, NULL },<br>
&gt; +{ 332, &quot;sched_get_priority_max_args&quot;, &quot;%s(%#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 333, &quot;sched_get_priority_min_args&quot;, &quot;%s(%#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 581, &quot;sched_getcpu_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 328, &quot;sched_getparam_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 330, &quot;sched_getscheduler_args&quot;, &quot;%s(%#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 334, &quot;sched_rr_get_interval_args&quot;, &quot;%s(%#x, %#x)&quo=
t;, NULL, NULL },<br>
&gt; +{ 327, &quot;sched_setparam_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 329, &quot;sched_setscheduler_args&quot;, &quot;%s(%#x, %#x, %#x)&q=
uot;, NULL, NULL },<br>
&gt; +{ 331, &quot;sched_yield_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 474, &quot;sctp_generic_recvmsg_args&quot;, &quot;%s(%#x, %#x, %#x,=
 %#x, %#x, %#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 472, &quot;sctp_generic_sendmsg_args&quot;, &quot;%s(%#x, %#x, %#x,=
 %#x, %#x, %#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 473, &quot;sctp_generic_sendmsg_iov_args&quot;, &quot;%s(%#x, %#x, =
%#x, %#x, %#x, %#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 471, &quot;sctp_peeloff_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 93, &quot;select_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&quot=
;, NULL, NULL },<br>
&gt; +{ 221, &quot;semget_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 222, &quot;semop_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 169, &quot;semsys_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&quo=
t;, NULL, NULL },<br>
&gt; +{ 393, &quot;sendfile_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %=
#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 28, &quot;sendmsg_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 133, &quot;sendto_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %#x=
)&quot;, NULL, NULL },<br>
&gt; +{ 452, &quot;setaudit_addr_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 450, &quot;setaudit_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 448, &quot;setauid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 422, &quot;setcontext_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 591, &quot;setcred_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 182, &quot;setegid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 183, &quot;seteuid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 175, &quot;setfib_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br=
>
&gt; +{ 181, &quot;setgid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br=
>
&gt; +{ 596, &quot;setgroups_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 83, &quot;setitimer_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 50, &quot;setlogin_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 524, &quot;setloginclass_args&quot;, &quot;%s(%#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 82, &quot;setpgid_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 96, &quot;setpriority_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 127, &quot;setregid_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 312, &quot;setresgid_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 311, &quot;setresuid_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 126, &quot;setreuid_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 195, &quot;setrlimit_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 147, &quot;setsid_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 105, &quot;setsockopt_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 122, &quot;settimeofday_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 23, &quot;setuid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 571, &quot;shm_open2_args&quot;, &quot;%s(%#x, %#x, %o, %#x, %#x)&q=
uot;, NULL, NULL },<br>
&gt; +{ 572, &quot;shm_rename_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 483, &quot;shm_unlink_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 228, &quot;shmat_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 512, &quot;shmctl_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 230, &quot;shmdt_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 231, &quot;shmget_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 171, &quot;shmsys_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 134, &quot;shutdown_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 416, &quot;sigaction_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 53, &quot;sigaltstack_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 573, &quot;sigfastblock_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 343, &quot;sigpending_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 340, &quot;sigprocmask_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 456, &quot;sigqueue_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 417, &quot;sigreturn_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 341, &quot;sigsuspend_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 345, &quot;sigtimedwait_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 429, &quot;sigwait_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 346, &quot;sigwaitinfo_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 97, &quot;socket_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 135, &quot;socketpair_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot=
;, NULL, NULL },<br>
&gt; +{ 555, &quot;statfs_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 423, &quot;swapcontext_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 582, &quot;swapoff_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 85, &quot;swapon_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 57, &quot;symlink_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 502, &quot;symlinkat_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 36, &quot;sync_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 165, &quot;sysarch_args&quot;, &quot;%s(%#x, %s)&quot;, NULL, NULL =
},<br>
&gt; +{ 430, &quot;thr_create_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 431, &quot;thr_exit_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 481, &quot;thr_kill2_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 433, &quot;thr_kill_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 455, &quot;thr_new_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 432, &quot;thr_self_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 464, &quot;thr_set_name_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 442, &quot;thr_suspend_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 443, &quot;thr_wake_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 585, &quot;timerfd_create_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 586, &quot;timerfd_gettime_args&quot;, &quot;%s(%#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 587, &quot;timerfd_settime_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 479, &quot;truncate_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 60, &quot;umask_args&quot;, &quot;%s(%o)&quot;, NULL, NULL },<br>
&gt; +{ 205, &quot;undelete_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 10, &quot;unlink_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 503, &quot;unlinkat_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 22, &quot;unmount_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 547, &quot;utimensat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 138, &quot;utimes_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 335, &quot;utrace_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 392, &quot;uuidgen_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 66, &quot;vfork_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 7, &quot;wait4_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 532, &quot;wait6_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 4, &quot;write_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 121, &quot;writev_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 321, &quot;yield_args&quot;, NULL, NULL, NULL },<br>
&gt; <br>
<br>
Overall looks good, and my comments on file variable should not be blocking=
.<br>
<br>
Reviewed-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qu=
alcomm.com" target=3D"_blank">pierrick.bouvier@oss.qualcomm.com</a>&gt;<br>
<br>
Regards,<br>
Pierrick<br>
</blockquote></div></div>

--0000000000000bf4400650a41fa1--

