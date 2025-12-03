Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96190D12D55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 12:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQlm2-0007no-A1; Wed, 03 Dec 2025 07:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vQllz-0007nJ-6g
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 07:15:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vQllw-0007AI-CX
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 07:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764764150;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RKazprwR6OXzPSfHRfLTVbpd2QvbI9Sf6+79Rqi4XqA=;
 b=B+LKieYwEZyaarYkJbZGODzuaz821Y1YcDgwdF2RaBhTt+6N2rlyJucqzBD/WuI+q+SHNR
 kJYH8kt/qTDxQ5DIkOl2ATbB/vaff5vT882Z6/Fbs5GhKFkYztJkbVsuhOOpaIaZ6mrlbX
 RQ0+2k4xplGqGd40RPGzp7Hc5fm+RPQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-93sDS1HzPu2c0u7lojAlOg-1; Wed,
 03 Dec 2025 07:15:44 -0500
X-MC-Unique: 93sDS1HzPu2c0u7lojAlOg-1
X-Mimecast-MFC-AGG-ID: 93sDS1HzPu2c0u7lojAlOg_1764764143
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36C0318002EC; Wed,  3 Dec 2025 12:15:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B68C4180035A; Wed,  3 Dec 2025 12:15:40 +0000 (UTC)
Date: Wed, 3 Dec 2025 12:15:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Luca Bonissi <qemu@bonslack.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/7] Add termios2 support to linux-user
Message-ID: <aTAp6fZ7f8hYupbh@redhat.com>
References: <745f18b6-ee62-4903-9a56-dcb903b610cf@bonslack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <745f18b6-ee62-4903-9a56-dcb903b610cf@bonslack.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 31, 2025 at 02:23:21PM +0100, Luca Bonissi wrote:
> From 6ddab7d3ba1035b5e2a6016bde4776436267c18b Mon Sep 17 00:00:00 2001
> From: Luca Bonissi <qemu@bonslack.org>
> Date: Fri, 31 Oct 2025 13:29:19 +0100
> Subject: [PATCH 1/7] Add termios2 support to linux-user

You've added this for a handful of archiecture targets, but
in Fedora we're seeing the incompatibility affect s390x and
aarch64 too, which this series hasn't implemented.

BTW, ideally send a cover letter with a multi-patch
series; there are tools which make this easier than
using git send-email directly:

  https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitting-your-patches

> 
> Signed-off-by: Luca Bonissi <qemu@bonslack.org>
> ---
>  linux-user/ioctls.h         |  6 +++
>  linux-user/strace.c         | 69 ++++++++++++++++++++++++++++++
>  linux-user/syscall.c        | 84 +++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_types.h  |  3 ++
>  linux-user/user-internals.h |  3 ++
>  5 files changed, 165 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 2f62fd2cb9..6ecfe6306e 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -1,5 +1,11 @@
>       /* emulated ioctl list */
>  
> +#ifdef TARGET_TCGETS2
> +     IOCTL(TCGETS2, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios2)))
> +     IOCTL(TCSETS2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
> +     IOCTL(TCSETSW2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
> +     IOCTL(TCSETSF2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
> +#endif
>       IOCTL(TCGETS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios)))
>       IOCTL(TCSETS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios)))
>       IOCTL(TCSETSF, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios)))
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 758c5d32b6..7afb94544f 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1935,6 +1935,75 @@ print_termios(void *arg)
>      qemu_log("}");
>  }
>  
> +#ifdef TARGET_TCGETS2
> +void
> +print_termios2(void *arg)
> +{
> +    const struct target_termios2 *target = arg;
> +
> +    target_tcflag_t iflags = tswap32(target->c_iflag);
> +    target_tcflag_t oflags = tswap32(target->c_oflag);
> +    target_tcflag_t cflags = tswap32(target->c_cflag);
> +    target_tcflag_t lflags = tswap32(target->c_lflag);
> +
> +    qemu_log("{");
> +
> +    qemu_log("c_iflag = ");
> +    print_flags(termios_iflags, iflags, 0);
> +
> +    qemu_log("c_oflag = ");
> +    target_tcflag_t oflags_clean =  oflags & ~(TARGET_NLDLY | TARGET_CRDLY |
> +                                               TARGET_TABDLY | TARGET_BSDLY |
> +                                               TARGET_VTDLY | TARGET_FFDLY);
> +    print_flags(termios_oflags, oflags_clean, 0);
> +    if (oflags & TARGET_NLDLY) {
> +        print_enums(termios_oflags_NLDLY, oflags & TARGET_NLDLY, 0);
> +    }
> +    if (oflags & TARGET_CRDLY) {
> +        print_enums(termios_oflags_CRDLY, oflags & TARGET_CRDLY, 0);
> +    }
> +    if (oflags & TARGET_TABDLY) {
> +        print_enums(termios_oflags_TABDLY, oflags & TARGET_TABDLY, 0);
> +    }
> +    if (oflags & TARGET_BSDLY) {
> +        print_enums(termios_oflags_BSDLY, oflags & TARGET_BSDLY, 0);
> +    }
> +    if (oflags & TARGET_VTDLY) {
> +        print_enums(termios_oflags_VTDLY, oflags & TARGET_VTDLY, 0);
> +    }
> +    if (oflags & TARGET_FFDLY) {
> +        print_enums(termios_oflags_FFDLY, oflags & TARGET_FFDLY, 0);
> +    }
> +
> +    qemu_log("c_cflag = ");
> +    if (cflags & TARGET_CBAUD) {
> +        print_enums(termios_cflags_CBAUD, cflags & TARGET_CBAUD, 0);
> +    }
> +    if (cflags & TARGET_CSIZE) {
> +        print_enums(termios_cflags_CSIZE, cflags & TARGET_CSIZE, 0);
> +    }
> +    target_tcflag_t cflags_clean = cflags & ~(TARGET_CBAUD | TARGET_CSIZE);
> +    print_flags(termios_cflags, cflags_clean, 0);
> +
> +    qemu_log("c_lflag = ");
> +    print_flags(termios_lflags, lflags, 0);
> +
> +    qemu_log("c_ispeed = ");
> +    print_raw_param("%u", tswap32(target->c_ispeed), 0);
> +
> +    qemu_log("c_ospeed = ");
> +    print_raw_param("%u", tswap32(target->c_ospeed), 0);
> +
> +    qemu_log("c_cc = ");
> +    qemu_log("\"%s\",", target->c_cc);
> +
> +    qemu_log("c_line = ");
> +    print_raw_param("\'%c\'", target->c_line, 1);
> +
> +    qemu_log("}");
> +}
> +#endif
> +
>  #undef UNUSED
>  
>  #ifdef TARGET_NR_accept
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8546f48a05..920bf23406 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -86,6 +86,7 @@
>  #endif
>  
>  #define termios host_termios
> +#define termios2 host_termios2
>  #define winsize host_winsize
>  #define termio host_termio
>  #define sgttyb host_sgttyb /* same as target */
> @@ -5885,6 +5886,89 @@ static const StructEntry struct_termios_def = {
>      .print = print_termios,
>  };
>  
> +#ifdef TARGET_TCGETS2
> +static void target_to_host_termios2 (void *dst, const void *src)
> +{
> +    struct host_termios2 *host = dst;
> +    const struct target_termios2 *target = src;
> +
> +    host->c_iflag =
> +        target_to_host_bitmask(tswap32(target->c_iflag), iflag_tbl);
> +    host->c_oflag =
> +        target_to_host_bitmask(tswap32(target->c_oflag), oflag_tbl);
> +    host->c_cflag =
> +        target_to_host_bitmask(tswap32(target->c_cflag), cflag_tbl);
> +    host->c_lflag =
> +        target_to_host_bitmask(tswap32(target->c_lflag), lflag_tbl);
> +    host->c_line = target->c_line;
> +    host->c_ispeed = tswap32(target->c_ispeed);
> +    host->c_ospeed = tswap32(target->c_ospeed);
> +
> +    memset(host->c_cc, 0, sizeof(host->c_cc));
> +    host->c_cc[VINTR] = target->c_cc[TARGET_VINTR];
> +    host->c_cc[VQUIT] = target->c_cc[TARGET_VQUIT];
> +    host->c_cc[VERASE] = target->c_cc[TARGET_VERASE];
> +    host->c_cc[VKILL] = target->c_cc[TARGET_VKILL];
> +    host->c_cc[VEOF] = target->c_cc[TARGET_VEOF];
> +    host->c_cc[VTIME] = target->c_cc[TARGET_VTIME];
> +    host->c_cc[VMIN] = target->c_cc[TARGET_VMIN];
> +    host->c_cc[VSWTC] = target->c_cc[TARGET_VSWTC];
> +    host->c_cc[VSTART] = target->c_cc[TARGET_VSTART];
> +    host->c_cc[VSTOP] = target->c_cc[TARGET_VSTOP];
> +    host->c_cc[VSUSP] = target->c_cc[TARGET_VSUSP];
> +    host->c_cc[VEOL] = target->c_cc[TARGET_VEOL];
> +    host->c_cc[VREPRINT] = target->c_cc[TARGET_VREPRINT];
> +    host->c_cc[VDISCARD] = target->c_cc[TARGET_VDISCARD];
> +    host->c_cc[VWERASE] = target->c_cc[TARGET_VWERASE];
> +    host->c_cc[VLNEXT] = target->c_cc[TARGET_VLNEXT];
> +    host->c_cc[VEOL2] = target->c_cc[TARGET_VEOL2];
> +}
> +
> +static void host_to_target_termios2 (void *dst, const void *src)
> +{
> +    struct target_termios2 *target = dst;
> +    const struct host_termios2 *host = src;
> +
> +    target->c_iflag =
> +        tswap32(host_to_target_bitmask(host->c_iflag, iflag_tbl));
> +    target->c_oflag =
> +        tswap32(host_to_target_bitmask(host->c_oflag, oflag_tbl));
> +    target->c_cflag =
> +        tswap32(host_to_target_bitmask(host->c_cflag, cflag_tbl));
> +    target->c_lflag =
> +        tswap32(host_to_target_bitmask(host->c_lflag, lflag_tbl));
> +    target->c_line = host->c_line;
> +    target->c_ispeed = tswap32(host->c_ispeed);
> +    target->c_ospeed = tswap32(host->c_ospeed);
> +
> +    memset(target->c_cc, 0, sizeof(target->c_cc));
> +    target->c_cc[TARGET_VINTR] = host->c_cc[VINTR];
> +    target->c_cc[TARGET_VQUIT] = host->c_cc[VQUIT];
> +    target->c_cc[TARGET_VERASE] = host->c_cc[VERASE];
> +    target->c_cc[TARGET_VKILL] = host->c_cc[VKILL];
> +    target->c_cc[TARGET_VEOF] = host->c_cc[VEOF];
> +    target->c_cc[TARGET_VTIME] = host->c_cc[VTIME];
> +    target->c_cc[TARGET_VMIN] = host->c_cc[VMIN];
> +    target->c_cc[TARGET_VSWTC] = host->c_cc[VSWTC];
> +    target->c_cc[TARGET_VSTART] = host->c_cc[VSTART];
> +    target->c_cc[TARGET_VSTOP] = host->c_cc[VSTOP];
> +    target->c_cc[TARGET_VSUSP] = host->c_cc[VSUSP];
> +    target->c_cc[TARGET_VEOL] = host->c_cc[VEOL];
> +    target->c_cc[TARGET_VREPRINT] = host->c_cc[VREPRINT];
> +    target->c_cc[TARGET_VDISCARD] = host->c_cc[VDISCARD];
> +    target->c_cc[TARGET_VWERASE] = host->c_cc[VWERASE];
> +    target->c_cc[TARGET_VLNEXT] = host->c_cc[VLNEXT];
> +    target->c_cc[TARGET_VEOL2] = host->c_cc[VEOL2];
> +}
> +
> +static const StructEntry struct_termios2_def = {
> +    .convert = { host_to_target_termios2, target_to_host_termios2 },
> +    .size = { sizeof(struct target_termios2), sizeof(struct host_termios2) },
> +    .align = { __alignof__(struct target_termios2), __alignof__(struct host_termios2) },
> +    .print = print_termios2,
> +};
> +#endif
> +
>  /* If the host does not provide these bits, they may be safely discarded. */
>  #ifndef MAP_SYNC
>  #define MAP_SYNC 0
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 6dd7a80ce5..ac45705acf 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -1,4 +1,7 @@
>  STRUCT_SPECIAL(termios)
> +#ifdef TARGET_TCGETS2
> +STRUCT_SPECIAL(termios2)
> +#endif
>  
>  STRUCT(winsize,
>         TYPE_SHORT, TYPE_SHORT, TYPE_SHORT, TYPE_SHORT)
> diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> index 7099349ec8..067c02bb93 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -129,6 +129,9 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
>  #endif /* TARGET_ABI_BITS != 32 */
>  
>  void print_termios(void *arg);
> +#ifdef TARGET_TCGETS2
> +void print_termios2(void *arg);
> +#endif
>  
>  /* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
>  #ifdef TARGET_ARM
> -- 
> 2.50.1
> 
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


