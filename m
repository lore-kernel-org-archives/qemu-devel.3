Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD45CD5BB1
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 04:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQe5T-0008Ua-Hj; Sat, 23 May 2026 00:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wQe5R-0008U5-Jq
 for qemu-devel@nongnu.org; Sat, 23 May 2026 00:35:46 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wQe5N-0001Av-9T
 for qemu-devel@nongnu.org; Sat, 23 May 2026 00:35:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2bd2c147abaso48467005ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 21:35:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779510939; cv=none;
 d=google.com; s=arc-20240605;
 b=JkrtlTuQgCbod6k8fAuBxCPSJjzT1ZWbHLnEwherFEwVEAKdbemZkNF800de99ojrZ
 L62erZ4/3MZiY92NUyc3nfB7YHGbnzHcOIgvpB0EyQeZiPWnf3N1hEMktMd6LCh4r1BI
 bZGCVLmsOOchcTPV1dGyI4RByy4P87K/E/+OX31smZZOLHW7G0lcdRvMefJzuQqYs7f1
 Oo4JvdbdX6XBJL+9H5zVPQha5kCWDoNC0ShdaWnu1Z0pHk/IKkg3AHO5ch2xDfuUnpHC
 spOAaYQXvFFleUY9/Xz8GSogsziYEh6OFjJuwriT1kRXLhEjZTp46n6LFL7uVUAM9BMk
 InBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jPZ1iKdqGdy11LqZG57BEY0jM/f7h0T3j8kzjdAVRfQ=;
 fh=AyezYKVnd8isJXTt4hoVZiGonbnokCBpuUlXfZnpm6M=;
 b=jvAB7lW5QwRUW2MPO5ZTzB0HPJgbChR+Z3XOwXWwmL54YX17slfWEfPL4viRZEvvxz
 2LRHW5qba8FntzlOC3FfgZ0vbmY7RLDT/Nfw/aUm1SL+jT77XIauP2GLVPlkQG7a5BvF
 r0AVoyilHWHnxQSkOC/MuZtoIqhkzQwWtT+WyvyMwlSSOip2hMqZSpOPCM/ESKkfVkrQ
 tYIiy0UaQww18r+QYB+pPXnMcaHOFtU9rG5WZBfQ+6lNAEi7mvMQ+vLTS/MPPDhwZyd2
 5swwpIHhYZWtW0vIRU+4TEQKiWpmevuNFNiSErZf5iFOC0aN4u+rkTLZQyjCDE5XZBnD
 CvUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779510939; x=1780115739;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jPZ1iKdqGdy11LqZG57BEY0jM/f7h0T3j8kzjdAVRfQ=;
 b=PDdanWSvRglX5Dz3Cl+IE6gT74MCUf4mEkvWN58Vz2aFcSc2fY+ZUjQr0qqKSHbGJe
 vjJhCdRe6WJ3vn3WBCl/TOGB2HfRL19lQi8A8R+cTJtM4qLYkqiEiqnh+Uawn0+zsKpZ
 89a1uprrehXJ4M1OuVZtsZCzhLoDPIXvUX1vED7kYYbJU9bPGuVPzM8jlvWN2XibUgX7
 J2fZ6CcaEZH3lj/iCdH7dTT0LPawUxZWEo7flWs4M6EOLptZ6zG4KzBTb1jvgnMCm63L
 rOtvQUieltVEIDm06CB+9BSiPxvo6cGxyPZJwjmV0GrS+3rFjaHSvxwYduHw0a/o6YJf
 Bk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779510939; x=1780115739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPZ1iKdqGdy11LqZG57BEY0jM/f7h0T3j8kzjdAVRfQ=;
 b=LppoC9TJBdyQ282HGQU3CbrNUBaq963OfLW+Ga5bCyAEW0qUwAhCgFwR3sGWSsvMHr
 J7W1FJNJlO64P3fE2ysG9cIfz576ih/6HaVIynD/LSqy3yJhUfz01a6hYCP2qpblyMxI
 MFFC5vQ2G9CnGyvFsTj87gsmRT1CdPAVbipzpYNyrG08D5vLn94lH4xW1sxcOFF+hOEw
 hvwMrycJOmXNGTvt/fMl7AirFVf4VGt+VIb8nmyXRtYTULtU6jQk1Nea0Fz+pO0ZOuFA
 pDoPOVclzx5Ty2mFVpXacJR8ws2tdO+QLSf5+OQgo6R5wK441ATghGymgGJAyO8M5jX9
 DgwA==
X-Gm-Message-State: AOJu0YwUe+L14c9vqHTx12OjTsq4p76bxzDAIWUtVDXaQAF/+MAzCPxG
 H+eFE+hHIv/yeiAQEpxAVPgeqsh9OBB4vBuBBVIsaqcX6AoQe7zhJBYW6H2szGRdYrC19bfIgXQ
 yzIt5xQCy0h4Ok/S1DYzKEgvXKpZCUlIOVHQBCITYMw==
X-Gm-Gg: Acq92OHTf86gs9U+PjjdsLUMFc8X97rZR4x2F9h+iq0//dbxSDJfq1L8BsZRfqZzLBv
 IQEZeehis70LFVagKvMQEgUvj02zbdovRGfV+ss0xZN5mKklcDxNkSv4/QC7+EnG6efywRLdyzM
 qatR95BNP+5zLoD3weQnF7VZe0GWHERHVHZwY58iZARxx8AX41gRZ7RozqKem8UTT65ZELy6S8a
 fUB8eR1dHtdpClZowsoNmEBGFasqRtltIlXJ8QoIkK0Hm3c2RuuDXGNgTE2TDzxVsyeZ4hFaC8h
 r7X6To2hk+IDqZ3OnDs/ggoHO6L8ZfJ+P+cBIw==
X-Received: by 2002:a17:903:244c:b0:2bd:7ff4:ab0b with SMTP id
 d9443c01a7336-2beb06552bbmr70845585ad.39.1779510939222; Fri, 22 May 2026
 21:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-15-6c16fe448301@bsdimp.com>
 <00cd8976-321a-409a-bea0-d790ed91866b@oss.qualcomm.com>
In-Reply-To: <00cd8976-321a-409a-bea0-d790ed91866b@oss.qualcomm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 22 May 2026 22:35:27 -0600
X-Gm-Features: AVHnY4IuajRAG253TShRp6NB-Iub_l8CFyAAHkZQNH7BVrIttqRtXidDK81dpNY
Message-ID: <CANCZdfqWkzaGmmXCaQ6+T3b8v6TB4OSyGvsPiG7Byj=_BfZ9hA@mail.gmail.com>
Subject: Re: [PATCH v2 15/37] bsd-user: Add os-socket.c with cmsg conversion
 functions
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Stacey Son <sson@freebsd.org>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Michal Meloun <mmel@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000681265065274ad5e"
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62d.google.com
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

--000000000000681265065274ad5e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 5:31=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:

> On 5/18/2026 2:27 PM, Warner Losh wrote:
> > Add target-to-host and host-to-target control message conversion
> > functions (t2h_freebsd_cmsg and h2t_freebsd_cmsg) for sendmsg/recvmsg
> > support, and add os-socket.c to the FreeBSD build.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Mika=C3=ABl Urankar <mikael.urankar@gmail.com>
> > Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> > Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > Assisted-by: Claude Opus 4.6 (1M context)
> > ---
> >  bsd-user/freebsd/meson.build |   8 +-
> >  bsd-user/freebsd/os-socket.c | 234
> +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 240 insertions(+), 2 deletions(-)
> >
> > diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.buil=
d
> > index 38f2debf7e..0fc779749d 100644
> > --- a/bsd-user/freebsd/meson.build
> > +++ b/bsd-user/freebsd/meson.build
> > @@ -4,9 +4,13 @@ bsd_syscall_nr =3D custom_target('bsd-syscall-h',
> >      command: [sh, meson.current_source_dir() / 'scripts/syscallhdr.sh'=
,
> '@INPUT@', '@OUTPUT@', 'FREEBSD'])
> >
> >  bsd_user_ss.add(files(
> > -  'os-stat.c',
> > +  'os-extattr.c',
> >    'os-proc.c',
> > +  'os-socket.c',
> > +  'os-stat.c',
> >    'os-sys.c',
> > -  'os-syscall.c'),
> > +  'os-syscall.c',
> > +  'os-thread.c',
> > +  'os-time.c'),
> >    bsd_syscall_nr
> >  )
>
> Most of additions here seem to belong to previous patches.
>

I'll try to move these backwards in the series. I may have to reorder some
things
as well, since this is a known good compile point. It's worth trying.

Warner


> > diff --git a/bsd-user/freebsd/os-socket.c b/bsd-user/freebsd/os-socket.=
c
> > new file mode 100644
> > index 0000000000..8eb728240d
> > --- /dev/null
> > +++ b/bsd-user/freebsd/os-socket.c
> > @@ -0,0 +1,234 @@
> > +/*
> > + * FreeBSD socket related system call helpers
> > + *
> > + * Copyright (c) 2013 Stacey D. Son
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +#include "qemu/osdep.h"
> > +
> > +#include <sys/types.h>
> > +#include <sys/socket.h>
> > +#include <netinet/in.h>
> > +
> > +#include "qemu.h"
> > +#include "qemu-os.h"
> > +
> > +abi_long t2h_freebsd_cmsg(struct msghdr *msgh,
> > +        struct target_msghdr *target_msgh)
> > +{
> > +    struct cmsghdr *cmsg =3D CMSG_FIRSTHDR(msgh);
> > +    socklen_t msg_controllen;
> > +    abi_ulong target_cmsg_addr;
> > +    struct target_cmsghdr *target_cmsg, *target_cmsg_start;
> > +    socklen_t space =3D 0;
> > +
> > +    msg_controllen =3D tswap32(target_msgh->msg_controllen);
> > +    if (msg_controllen < sizeof(struct target_cmsghdr)) {
> > +        goto the_end;
> > +    }
> > +    target_cmsg_addr =3D tswapal(target_msgh->msg_control);
> > +    target_cmsg =3D lock_user(VERIFY_READ, target_cmsg_addr,
> msg_controllen, 1);
> > +    target_cmsg_start =3D target_cmsg;
> > +    if (!target_cmsg) {
> > +        return -TARGET_EFAULT;
> > +    }
> > +
> > +    while (cmsg && target_cmsg) {
> > +        void *data =3D CMSG_DATA(cmsg);
> > +        void *target_data =3D TARGET_CMSG_DATA(target_cmsg);
> > +        int len =3D (unsigned char *)(target_cmsg) +
> > +            tswap32(target_cmsg->cmsg_len) - (unsigned char
> *)target_data;
> > +
> > +        space +=3D CMSG_SPACE(len);
> > +        if (space > msgh->msg_controllen) {
> > +            space -=3D CMSG_SPACE(len);
> > +            /*
> > +             * This is a QEMU bug, since we allocated the payload area
> ourselves
> > +             * (unlike overflow in host-to-target conversion, which is
> just the
> > +             * guest giving us a buffer that's too small). It can't
> happen for
> > +             * the payload types we currently support; if it becomes a=
n
> issue in
> > +             * future we would need to improve our allocation strategy
> to
> > +             * something more intelligent than "twice the size of the
> target
> > +             * buffer we're reading from".
> > +             */
> > +            gemu_log("Host cmsg overflow\n");
> > +            break;
> > +        }
> > +
> > +        if (tswap32(target_cmsg->cmsg_level) =3D=3D TARGET_SOL_SOCKET)=
 {
> > +            cmsg->cmsg_level =3D SOL_SOCKET;
> > +        } else {
> > +            cmsg->cmsg_level =3D tswap32(target_cmsg->cmsg_level);
> > +        }
> > +        cmsg->cmsg_type =3D tswap32(target_cmsg->cmsg_type);
> > +        cmsg->cmsg_len =3D CMSG_LEN(len);
> > +
> > +        if (cmsg->cmsg_level =3D=3D SOL_SOCKET && cmsg->cmsg_type =3D=
=3D
> SCM_RIGHTS) {
> > +            int *fd =3D (int *)data;
> > +            int *target_fd =3D (int *)target_data;
> > +            int i, numfds =3D len / sizeof(int);
> > +
> > +            for (i =3D 0; i < numfds; i++) {
> > +                __get_user(fd[i], target_fd + i);
> > +            }
> > +        } else if ((cmsg->cmsg_level =3D=3D SOL_SOCKET) &&
> > +            (cmsg->cmsg_type =3D=3D SCM_TIMESTAMP) &&
> > +            (len =3D=3D sizeof(struct target_freebsd_timeval)))  {
> > +            /* copy struct timeval to host */
> > +            struct timeval *tv =3D (struct timeval *)data;
> > +            struct target_freebsd_timeval *target_tv =3D
> > +                (struct target_freebsd_timeval *)target_data;
> > +            __get_user(tv->tv_sec, &target_tv->tv_sec);
> > +            __get_user(tv->tv_usec, &target_tv->tv_usec);
> > +        } else {
> > +            gemu_log("Unsupported target ancillary data: %d/%d\n",
> > +                     cmsg->cmsg_level, cmsg->cmsg_type);
> > +            memcpy(data, target_data, len);
> > +        }
> > +
> > +        cmsg =3D CMSG_NXTHDR(msgh, cmsg);
> > +        target_cmsg =3D TARGET_CMSG_NXTHDR(target_msgh, target_cmsg,
> > +                                         target_cmsg_start);
> > +    }
> > +    unlock_user(target_cmsg_start, target_cmsg_addr, 0);
> > +the_end:
> > +    msgh->msg_controllen =3D space;
> > +    return 0;
> > +}
> > +
> > +abi_long h2t_freebsd_cmsg(struct target_msghdr *target_msgh,
> > +        struct msghdr *msgh)
> > +{
> > +    struct cmsghdr *cmsg =3D CMSG_FIRSTHDR(msgh);
> > +    socklen_t msg_controllen;
> > +    abi_ulong target_cmsg_addr;
> > +    struct target_cmsghdr *target_cmsg, *target_cmsg_start;
> > +    socklen_t space =3D 0;
> > +
> > +    msg_controllen =3D tswap32(target_msgh->msg_controllen);
> > +    if (msg_controllen < sizeof(struct target_cmsghdr)) {
> > +        goto the_end;
> > +    }
> > +    target_cmsg_addr =3D tswapal(target_msgh->msg_control);
> > +    target_cmsg =3D lock_user(VERIFY_WRITE, target_cmsg_addr,
> msg_controllen, 0);
> > +    target_cmsg_start =3D target_cmsg;
> > +    if (!target_cmsg) {
> > +        return -TARGET_EFAULT;
> > +    }
> > +
> > +    while (cmsg && target_cmsg) {
> > +        void *data =3D CMSG_DATA(cmsg);
> > +        void *target_data =3D TARGET_CMSG_DATA(target_cmsg);
> > +        int len =3D (unsigned char *)(cmsg) + cmsg->cmsg_len -
> > +            (unsigned char *)data;
> > +
> > +        int tgt_len, tgt_space;
> > +
> > +        /*
> > +         * We never copy a half-header but may copy half-data; this is
> Linux's
> > +         * behaviour in put_cmsg(). Note that truncation here is a
> guest problem
> > +         * (which we report to the guest via the CTRUNC bit), unlike
> truncation
> > +         * in target_to_host_cmsg, which is a QEMU bug.
> > +         */
> > +        if (msg_controllen < sizeof(struct target_cmsghdr)) {
> > +            target_msgh->msg_flags |=3D tswap32(MSG_CTRUNC);
> > +            break;
> > +        }
> > +
> > +        if (cmsg->cmsg_level =3D=3D SOL_SOCKET) {
> > +            target_cmsg->cmsg_level =3D tswap32(TARGET_SOL_SOCKET);
> > +        } else {
> > +            target_cmsg->cmsg_level =3D tswap32(cmsg->cmsg_level);
> > +        }
> > +        target_cmsg->cmsg_type =3D tswap32(cmsg->cmsg_type);
> > +
> > +        /*
> > +         * Payload types which need a different size of payload on the
> target
> > +         * must adjust tgt_len here.
> > +         */
> > +        tgt_len =3D len;
> > +        switch (cmsg->cmsg_level) {
> > +        case SOL_SOCKET:
> > +            switch (cmsg->cmsg_type) {
> > +            case SCM_TIMESTAMP:
> > +                tgt_len =3D sizeof(struct target_freebsd_timeval);
> > +                break;
> > +            default:
> > +                break;
> > +            }
> > +            break;
> > +        default:
> > +            break;
> > +        }
> > +
> > +        if (msg_controllen < TARGET_CMSG_LEN(tgt_len)) {
> > +            target_msgh->msg_flags |=3D tswap32(MSG_CTRUNC);
> > +            tgt_len =3D msg_controllen - sizeof(struct target_cmsghdr)=
;
> > +        }
> > +
> > +        /*
> > +         * We must now copy-and-convert len bytes of payload into
> tgt_len bytes
> > +         * of destination space. Bear in mind that in both source and
> > +         * destination we may be dealing with a truncated value!
> > +         */
> > +        switch (cmsg->cmsg_level) {
> > +        case SOL_SOCKET:
> > +            switch (cmsg->cmsg_type) {
> > +            case SCM_RIGHTS:
> > +            {
> > +                int *fd =3D (int *)data;
> > +                int *target_fd =3D (int *)target_data;
> > +                int i, numfds =3D tgt_len / sizeof(int);
> > +
> > +                for (i =3D 0; i < numfds; i++) {
> > +                    __put_user(fd[i], target_fd + i);
> > +                }
> > +                break;
> > +            }
> > +            case SCM_TIMESTAMP:
> > +            {
> > +                struct timeval *tv =3D (struct timeval *)data;
> > +                struct target_freebsd_timeval *target_tv =3D
> > +                    (struct target_freebsd_timeval *)target_data;
> > +
> > +                if (len !=3D sizeof(struct timeval) ||
> > +                    tgt_len !=3D sizeof(struct target_freebsd_timeval)=
) {
> > +                    goto unimplemented;
> > +                }
> > +
> > +                /* copy struct timeval to target */
> > +                __put_user(tv->tv_sec, &target_tv->tv_sec);
> > +                __put_user(tv->tv_usec, &target_tv->tv_usec);
> > +                break;
> > +            }
> > +            default:
> > +                goto unimplemented;
> > +            }
> > +            break;
> > +        default:
> > +        unimplemented:
> > +            gemu_log("Unsupported host ancillary data: %d/%d\n",
> > +                     cmsg->cmsg_level, cmsg->cmsg_type);
> > +            memcpy(target_data, data, MIN(len, tgt_len));
> > +            if (tgt_len > len) {
> > +                memset(target_data + len, 0, tgt_len - len);
> > +            }
> > +        }
> > +
> > +        target_cmsg->cmsg_len =3D tswap32(TARGET_CMSG_LEN(tgt_len));
> > +        tgt_space =3D TARGET_CMSG_SPACE(tgt_len);
> > +        if (msg_controllen < tgt_space) {
> > +            tgt_space =3D msg_controllen;
> > +        }
> > +        msg_controllen -=3D tgt_space;
> > +        space +=3D tgt_space;
> > +        cmsg =3D CMSG_NXTHDR(msgh, cmsg);
> > +        target_cmsg =3D TARGET_CMSG_NXTHDR(target_msgh, target_cmsg,
> > +                                         target_cmsg_start);
> > +    }
> > +    unlock_user(target_cmsg_start, target_cmsg_addr, space);
> > +the_end:
> > +    target_msgh->msg_controllen =3D tswap32(space);
> > +    return 0;
> > +}
> >
>
>

--000000000000681265065274ad5e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 22,=
 2026 at 5:31=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bo=
uvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On 5/18/2026 2:27 =
PM, Warner Losh wrote:<br>
&gt; Add target-to-host and host-to-target control message conversion<br>
&gt; functions (t2h_freebsd_cmsg and h2t_freebsd_cmsg) for sendmsg/recvmsg<=
br>
&gt; support, and add os-socket.c to the FreeBSD build.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Mika=C3=ABl Urankar &lt;<a href=3D"mailto:mikael.uranka=
r@gmail.com" target=3D"_blank">mikael.urankar@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Michal Meloun &lt;mmel@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; Assisted-by: Claude Opus 4.6 (1M context)<br>
&gt; ---<br>
&gt;=C2=A0 bsd-user/freebsd/meson.build |=C2=A0 =C2=A08 +-<br>
&gt;=C2=A0 bsd-user/freebsd/os-socket.c | 234 +++++++++++++++++++++++++++++=
++++++++++++++<br>
&gt;=C2=A0 2 files changed, 240 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.bui=
ld<br>
&gt; index 38f2debf7e..0fc779749d 100644<br>
&gt; --- a/bsd-user/freebsd/meson.build<br>
&gt; +++ b/bsd-user/freebsd/meson.build<br>
&gt; @@ -4,9 +4,13 @@ bsd_syscall_nr =3D custom_target(&#39;bsd-syscall-h&#=
39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 command: [sh, meson.current_source_dir() / &#39;sc=
ripts/syscallhdr.sh&#39;, &#39;@INPUT@&#39;, &#39;@OUTPUT@&#39;, &#39;FREEB=
SD&#39;])<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 bsd_user_ss.add(files(<br>
&gt; -=C2=A0 &#39;os-stat.c&#39;,<br>
&gt; +=C2=A0 &#39;os-extattr.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;os-proc.c&#39;,<br>
&gt; +=C2=A0 &#39;os-socket.c&#39;,<br>
&gt; +=C2=A0 &#39;os-stat.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;os-sys.c&#39;,<br>
&gt; -=C2=A0 &#39;os-syscall.c&#39;),<br>
&gt; +=C2=A0 &#39;os-syscall.c&#39;,<br>
&gt; +=C2=A0 &#39;os-thread.c&#39;,<br>
&gt; +=C2=A0 &#39;os-time.c&#39;),<br>
&gt;=C2=A0 =C2=A0 bsd_syscall_nr<br>
&gt;=C2=A0 )<br>
<br>
Most of additions here seem to belong to previous patches.<br></blockquote>=
<div><br></div><div>I&#39;ll try to move these backwards in the series. I m=
ay have to reorder some things</div><div>as well, since this is a known goo=
d compile point. It&#39;s worth trying.</div><div><br></div><div>Warner</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; diff --git a/bsd-user/freebsd/os-socket.c b/bsd-user/freebsd/os-socket=
.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..8eb728240d<br>
&gt; --- /dev/null<br>
&gt; +++ b/bsd-user/freebsd/os-socket.c<br>
&gt; @@ -0,0 +1,234 @@<br>
&gt; +/*<br>
&gt; + * FreeBSD socket related system call helpers<br>
&gt; + *<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + */<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +<br>
&gt; +#include &lt;sys/types.h&gt;<br>
&gt; +#include &lt;sys/socket.h&gt;<br>
&gt; +#include &lt;netinet/in.h&gt;<br>
&gt; +<br>
&gt; +#include &quot;qemu.h&quot;<br>
&gt; +#include &quot;qemu-os.h&quot;<br>
&gt; +<br>
&gt; +abi_long t2h_freebsd_cmsg(struct msghdr *msgh,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct target_msghdr *target_msgh)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct cmsghdr *cmsg =3D CMSG_FIRSTHDR(msgh);<br>
&gt; +=C2=A0 =C2=A0 socklen_t msg_controllen;<br>
&gt; +=C2=A0 =C2=A0 abi_ulong target_cmsg_addr;<br>
&gt; +=C2=A0 =C2=A0 struct target_cmsghdr *target_cmsg, *target_cmsg_start;=
<br>
&gt; +=C2=A0 =C2=A0 socklen_t space =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 msg_controllen =3D tswap32(target_msgh-&gt;msg_controll=
en);<br>
&gt; +=C2=A0 =C2=A0 if (msg_controllen &lt; sizeof(struct target_cmsghdr)) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto the_end;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 target_cmsg_addr =3D tswapal(target_msgh-&gt;msg_contro=
l);<br>
&gt; +=C2=A0 =C2=A0 target_cmsg =3D lock_user(VERIFY_READ, target_cmsg_addr=
, msg_controllen, 1);<br>
&gt; +=C2=A0 =C2=A0 target_cmsg_start =3D target_cmsg;<br>
&gt; +=C2=A0 =C2=A0 if (!target_cmsg) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 while (cmsg &amp;&amp; target_cmsg) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *data =3D CMSG_DATA(cmsg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *target_data =3D TARGET_CMSG_DATA(ta=
rget_cmsg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D (unsigned char *)(target_cmsg=
) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tswap32(target_cmsg-&gt;cms=
g_len) - (unsigned char *)target_data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 space +=3D CMSG_SPACE(len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (space &gt; msgh-&gt;msg_controllen) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 space -=3D CMSG_SPACE(len);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* This is a QEMU bug,=
 since we allocated the payload area ourselves<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* (unlike overflow in=
 host-to-target conversion, which is just the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* guest giving us a b=
uffer that&#39;s too small). It can&#39;t happen for<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the payload types w=
e currently support; if it becomes an issue in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* future we would nee=
d to improve our allocation strategy to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* something more inte=
lligent than &quot;twice the size of the target<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* buffer we&#39;re re=
ading from&quot;.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gemu_log(&quot;Host cmsg ov=
erflow\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tswap32(target_cmsg-&gt;cmsg_level) =
=3D=3D TARGET_SOL_SOCKET) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmsg-&gt;cmsg_level =3D SOL=
_SOCKET;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmsg-&gt;cmsg_level =3D tsw=
ap32(target_cmsg-&gt;cmsg_level);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmsg-&gt;cmsg_type =3D tswap32(target_cms=
g-&gt;cmsg_type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmsg-&gt;cmsg_len =3D CMSG_LEN(len);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cmsg-&gt;cmsg_level =3D=3D SOL_SOCKET=
 &amp;&amp; cmsg-&gt;cmsg_type =3D=3D SCM_RIGHTS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *fd =3D (int *)data;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *target_fd =3D (int *)t=
arget_data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int i, numfds =3D len / siz=
eof(int);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; numfds=
; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(fd=
[i], target_fd + i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if ((cmsg-&gt;cmsg_level =3D=3D SO=
L_SOCKET) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (cmsg-&gt;cmsg_type =3D=3D =
SCM_TIMESTAMP) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (len =3D=3D sizeof(struct t=
arget_freebsd_timeval)))=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* copy struct timeval to h=
ost */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct timeval *tv =3D (str=
uct timeval *)data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct target_freebsd_timev=
al *target_tv =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (struct targe=
t_freebsd_timeval *)target_data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(tv-&gt;tv_sec, &=
amp;target_tv-&gt;tv_sec);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __get_user(tv-&gt;tv_usec, =
&amp;target_tv-&gt;tv_usec);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gemu_log(&quot;Unsupported =
target ancillary data: %d/%d\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cmsg-&gt;cmsg_level, cmsg-&gt;cmsg_type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(data, target_data, l=
en);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmsg =3D CMSG_NXTHDR(msgh, cmsg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_cmsg =3D TARGET_CMSG_NXTHDR(target=
_msgh, target_cmsg,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0target_cmsg_start);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 unlock_user(target_cmsg_start, target_cmsg_addr, 0);<br=
>
&gt; +the_end:<br>
&gt; +=C2=A0 =C2=A0 msgh-&gt;msg_controllen =3D space;<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +abi_long h2t_freebsd_cmsg(struct target_msghdr *target_msgh,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct msghdr *msgh)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct cmsghdr *cmsg =3D CMSG_FIRSTHDR(msgh);<br>
&gt; +=C2=A0 =C2=A0 socklen_t msg_controllen;<br>
&gt; +=C2=A0 =C2=A0 abi_ulong target_cmsg_addr;<br>
&gt; +=C2=A0 =C2=A0 struct target_cmsghdr *target_cmsg, *target_cmsg_start;=
<br>
&gt; +=C2=A0 =C2=A0 socklen_t space =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 msg_controllen =3D tswap32(target_msgh-&gt;msg_controll=
en);<br>
&gt; +=C2=A0 =C2=A0 if (msg_controllen &lt; sizeof(struct target_cmsghdr)) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto the_end;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 target_cmsg_addr =3D tswapal(target_msgh-&gt;msg_contro=
l);<br>
&gt; +=C2=A0 =C2=A0 target_cmsg =3D lock_user(VERIFY_WRITE, target_cmsg_add=
r, msg_controllen, 0);<br>
&gt; +=C2=A0 =C2=A0 target_cmsg_start =3D target_cmsg;<br>
&gt; +=C2=A0 =C2=A0 if (!target_cmsg) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 while (cmsg &amp;&amp; target_cmsg) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *data =3D CMSG_DATA(cmsg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *target_data =3D TARGET_CMSG_DATA(ta=
rget_cmsg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D (unsigned char *)(cmsg) + cms=
g-&gt;cmsg_len -<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (unsigned char *)data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int tgt_len, tgt_space;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We never copy a half-header but m=
ay copy half-data; this is Linux&#39;s<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* behaviour in put_cmsg(). Note tha=
t truncation here is a guest problem<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* (which we report to the guest via=
 the CTRUNC bit), unlike truncation<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* in target_to_host_cmsg, which is =
a QEMU bug.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msg_controllen &lt; sizeof(struct tar=
get_cmsghdr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_msgh-&gt;msg_flags |=
=3D tswap32(MSG_CTRUNC);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cmsg-&gt;cmsg_level =3D=3D SOL_SOCKET=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_cmsg-&gt;cmsg_level =
=3D tswap32(TARGET_SOL_SOCKET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_cmsg-&gt;cmsg_level =
=3D tswap32(cmsg-&gt;cmsg_level);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_cmsg-&gt;cmsg_type =3D tswap32(cms=
g-&gt;cmsg_type);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Payload types which need a differ=
ent size of payload on the target<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* must adjust tgt_len here.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tgt_len =3D len;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (cmsg-&gt;cmsg_level) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case SOL_SOCKET:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (cmsg-&gt;cmsg_type)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case SCM_TIMESTAMP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tgt_len =3D s=
izeof(struct target_freebsd_timeval);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msg_controllen &lt; TARGET_CMSG_LEN(t=
gt_len)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_msgh-&gt;msg_flags |=
=3D tswap32(MSG_CTRUNC);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tgt_len =3D msg_controllen =
- sizeof(struct target_cmsghdr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We must now copy-and-convert len =
bytes of payload into tgt_len bytes<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* of destination space. Bear in min=
d that in both source and<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* destination we may be dealing wit=
h a truncated value!<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (cmsg-&gt;cmsg_level) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case SOL_SOCKET:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (cmsg-&gt;cmsg_type)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case SCM_RIGHTS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *fd =3D (=
int *)data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *target_f=
d =3D (int *)target_data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int i, numfds=
 =3D tgt_len / sizeof(int);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0;=
 i &lt; numfds; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 __put_user(fd[i], target_fd + i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case SCM_TIMESTAMP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct timeva=
l *tv =3D (struct timeval *)data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct target=
_freebsd_timeval *target_tv =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (struct target_freebsd_timeval *)target_data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len !=3D =
sizeof(struct timeval) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 tgt_len !=3D sizeof(struct target_freebsd_timeval)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 goto unimplemented;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* copy struc=
t timeval to target */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(tv=
-&gt;tv_sec, &amp;target_tv-&gt;tv_sec);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(tv=
-&gt;tv_usec, &amp;target_tv-&gt;tv_usec);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unimplem=
ented;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unimplemented:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gemu_log(&quot;Unsupported =
host ancillary data: %d/%d\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cmsg-&gt;cmsg_level, cmsg-&gt;cmsg_type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(target_data, data, M=
IN(len, tgt_len));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tgt_len &gt; len) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(target=
_data + len, 0, tgt_len - len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_cmsg-&gt;cmsg_len =3D tswap32(TARG=
ET_CMSG_LEN(tgt_len));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tgt_space =3D TARGET_CMSG_SPACE(tgt_len);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (msg_controllen &lt; tgt_space) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tgt_space =3D msg_controlle=
n;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_controllen -=3D tgt_space;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 space +=3D tgt_space;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmsg =3D CMSG_NXTHDR(msgh, cmsg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_cmsg =3D TARGET_CMSG_NXTHDR(target=
_msgh, target_cmsg,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0target_cmsg_start);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 unlock_user(target_cmsg_start, target_cmsg_addr, space)=
;<br>
&gt; +the_end:<br>
&gt; +=C2=A0 =C2=A0 target_msgh-&gt;msg_controllen =3D tswap32(space);<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000681265065274ad5e--

