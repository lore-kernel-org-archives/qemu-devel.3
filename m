Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A13DCD5BD1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 04:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTY2Z-0005bi-4j; Sun, 31 May 2026 00:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTY2X-0005bL-1p
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:44:45 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTY2Q-0001e3-VN
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:44:44 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-36b9ec98144so1745765a91.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 21:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780202677; cv=none;
 d=google.com; s=arc-20240605;
 b=avbYwh9XyAiJq1UI08S7YTY9np5OlKVYyyTnIstSsXQ9nqVoG3iBfvNPdGVpAxcW+S
 /Iae1/0pViGttkoFmfAs6gqAbq/wRa9ChRHGZkgKbTqyw/J9XmQY+Is75+ubi2ofi+6D
 S6cnUi5C9hQi028cg1DaLY4lPBaWpL9F9bAifn/3UfNcN0hhSsyLnSZJXdw1+k64ik4m
 rXTmrgZpYsSkdjRpVP/ssDtXL86wa9REnjW0Kah2SDlzUqJRTecjQKaQrrxF/xhgKZ/O
 L77+7f3Vak27kYwSmarm2VqjFx4fM9GSfc2JFAwIBS2b16zUz792S4qRvpGepPsWmkX2
 JBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZfR0OaZ04vEjduJIqlyDnj6f6qKG8rc9VJoDKRyeWdQ=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=fxcr8jzQi03WgSXPwlzDFCKr55ZKYjIPdfg/QAtp82m0xxjDae9Bb8R5ZaL6SBvx9U
 u/IKZj4nTAEX6FR/SA9giKIHrD3UIED4fj8wUqe2i4wn1WiMceyauU6hjQrxFhI6WRKZ
 69Rel+DDjbOonfllYeCumFRtEKcxIJaGIZIRbo/cyKCXoqMnQp1Wu1Nj/342hdJKMnNX
 WYkpBvw5ASE3v4ONC3+PyCPX45w7Y7IXlgPCvZsL7H7T0Yuk2RekueZ/M1emRaWhYHa8
 zpYR7+KzOVp8JzqV7NKTS6QquEyZ86MKMO+b3PdDJwDOA6PU96vctie4rZWXlz9vmpyu
 Gy8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780202677; x=1780807477;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZfR0OaZ04vEjduJIqlyDnj6f6qKG8rc9VJoDKRyeWdQ=;
 b=P1iCQdgPxh087PKsNE1NqiLbrv5wpJytCDq4FJ65TKDJkI8J/HHOAT0N6AeAtN8dvb
 5yOrizZtOr0gioY7lAW7eeZRFikd4agXLD1cKE5ohrJvGVsaGftfzdkJ+uOj1JTgT970
 KqZL3pb5nFHsF6TZfNcd4MY7hB6gbczWCmlU9E13/ppIEHfCtSch2rMGtEi0gXNBKaWC
 bsgg7R5Me2131l7NKFAMh3KVYR2P7CWd9/h/vCgkINeVErMrwSjJwV/Tcpa/1c1XQp8+
 B4g6ZviQ1wAknQBKwSxpRJr+w+vFf0bBGTHgCGFALShFzYt2pUDpCZoG00KyKIMcVTIh
 +4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780202677; x=1780807477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfR0OaZ04vEjduJIqlyDnj6f6qKG8rc9VJoDKRyeWdQ=;
 b=Wo8DRyCT5lhicGNjNWWrHpC2mcHbS7aVD4ImBypQ4rbuCM4fruSP+U5sXNoMfneRg3
 We56ByR4QifryfhI2df/yyhU4wS45+DTsr32yhJf2QTLetv1e1HYLDct8xbfTFcnSmEK
 JUsgm4l4PPrg2JER7XARSqhYVo5CTqKnwMWzmYvYi7Ounbwq6VnSYAR4UqcKUg9QqFaL
 I+WXnkPKOYvuWknHRROI6+d80tHE7Be//0WiOUNrKqjSJyQky2cL45EfN2q/dghP9/+n
 ENHC+vaxzfhzxmXlI3wfh2HUglzmJdbBepNuYggS8q0tAmFh2kNiKY+BwsY2jOEML8zJ
 zn7g==
X-Gm-Message-State: AOJu0Yyz+DrB5JYFRqdLUH7je/otYK/a80LlzdXm9O5dhtKdL8CvEQjn
 vJ3BmO7qyWqy6h+B0GSnHHXT3tbbo27Ue1D+iZ+CUv6Azr5StZNjcJ5AmdSub88rul/0Pox+oAx
 OJVDSSIp/q3iblyv++3rwwAAS5q52OsloJXQCysXFKg==
X-Gm-Gg: Acq92OHBZKijKWIKL7qeY65B93jAhygY/FO3Sin5dnazYGDCafI2yQuIIBSymYH6HvZ
 MIChBfhRwdb24WUITSdgnRlHs/C/F2Uw9Jg/DiThFvFc45U5TpDgiFxE2dVh2+sDiOAXSDi9SOA
 dRwYN7zCnCGQsXOtnnuCk9bOs7iVoChAgq8wQkpYyYI6uHk79J2qRE7tk45aQLPfhsxzZcAUXxt
 xaBUGPgwptla2LwQD3x13rhlBRH8gLIhsKnEN5QeQLpDrLjMFsTaoBSSbudxKi8t/8Up9qaMXQ+
 pq4ebPWPMmiVjcB7Fdto9nmckt4KuuPVdlVn/2S0I9M8SIo=
X-Received: by 2002:a17:90b:180f:b0:35e:5ae3:299d with SMTP id
 98e67ed59e1d1-36c4ff65665mr5392256a91.11.1780202677065; Sat, 30 May 2026
 21:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-12-richard.henderson@linaro.org>
In-Reply-To: <20260530211248.375318-12-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 30 May 2026 22:44:25 -0600
X-Gm-Features: AVHnY4IwSvKzfdGGiJsXCwsrYbFdw81O1sv1MCt3kDc91I33hewy1Jw0z-K133g
Message-ID: <CANCZdfpLTPL4UKFMHrevMPJ-3NguLPpRXkNYrJnQjyMyvwVoQg@mail.gmail.com>
Subject: Re: [PATCH 11/13] common-user: Move probe_guest_base from linux-user
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="00000000000031eb89065315bc94"
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1033.google.com
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

--00000000000031eb89065315bc94
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:13=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Prepare to share probe_guest_base with bsd-user.
>
> Create a linux_probe_guest_base wrapper with the portions
> of probe_guest_base that are linux specific: managing the
> commpage for various targets.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/user/probe-guest-base.h |  37 ++++
>  linux-user/user-internals.h     |  10 +-
>  common-user/probe-guest-base.c  | 343 ++++++++++++++++++++++++++++++++
>  linux-user/elfload.c            | 337 +------------------------------
>  linux-user/flatload.c           |   2 +-
>  common-user/meson.build         |   1 +
>  6 files changed, 392 insertions(+), 338 deletions(-)
>  create mode 100644 include/user/probe-guest-base.h
>  create mode 100644 common-user/probe-guest-base.c
>
> diff --git a/include/user/probe-guest-base.h
> b/include/user/probe-guest-base.h
> new file mode 100644
> index 0000000000..d7492ef46c
> --- /dev/null
> +++ b/include/user/probe-guest-base.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef USER_PROBE_GUEST_BASE_H
> +#define USER_PROBE_GUEST_BASE_H
> +
> +#ifndef CONFIG_USER_ONLY
> +#error Cannot include this header from system emulation
> +#endif
> +
> +#include "exec/vaddr.h"
> +
> +typedef struct PGBRange {
> +    vaddr lo;
> +    vaddr hi;
> +} PGBRange;
> +
> +/**
> + * probe_guest_base:
> + * @image_name: the executable being loaded
> + * @image_range: the fixed addresses within the executable
> + *
> + * Creates the initial guest address space in the host memory space.
> + *
> + * If @image_range is NULL, then no address in the executable is fixed,
> + * i.e. it is fully relocatable.
> + *
> + * This function will not return if a valid value for guest_base
> + * cannot be chosen.  On return, the executable loader can expect
> + *
> + *    target_mmap(i->lo, i->hi - i->lo + 1, ...)
> + *
> + * to succeed.
> + */
> +void probe_guest_base(const char *image_name, const PGBRange *image_rang=
e,
> +                      const PGBRange *commpage_range);
> +
> +#endif
> diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> index bc6b9f44e6..71f72002b6 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -22,6 +22,7 @@
>  #include "qemu/log.h"
>  #include "exec/tb-flush.h"
>  #include "exec/translation-block.h"
> +#include "user/probe-guest-base.h"
>
>  extern char *exec_path;
>  extern char real_exec_path[PATH_MAX];
> @@ -74,13 +75,8 @@ void clone_fork_end(bool child);
>  void fork_start(void);
>  void fork_end(pid_t pid);
>
> -typedef struct PGBRange {
> -    vaddr lo;
> -    vaddr hi;
> -} PGBRange;
> -
>  /**
> - * probe_guest_base:
> + * linux_probe_guest_base:
>   * @image_name: the executable being loaded
>   * @image_range: the fixed addresses within the executable
>   *
> @@ -96,7 +92,7 @@ typedef struct PGBRange {
>   *
>   * to succeed.
>   */
> -void probe_guest_base(const char *image_name, const PGBRange
> *image_range);
> +void linux_probe_guest_base(const char *image_name, const PGBRange
> *image_range);
>
>  /* syscall.c */
>  int host_to_target_waitstatus(int status);
> diff --git a/common-user/probe-guest-base.c
> b/common-user/probe-guest-base.c
> new file mode 100644
> index 0000000000..77722fe63f
> --- /dev/null
> +++ b/common-user/probe-guest-base.c
> @@ -0,0 +1,343 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/units.h"
> +#include "qemu/target-info.h"
> +#include "qemu/log.h"
> +#include "user/guest-base.h"
> +#include "user/mmap-min-addr.h"
> +#include "user/guest-host.h"
> +#include "user/probe-guest-base.h"
> +#include "user/selfmap.h"
> +#include "exec/target_page.h"
> +#include <sys/shm.h>
> +
> +/* Linux and FreeBSD use different flags to express NOREPLACE. */
> +#ifdef __FreeBSD__
> +#define MAP_FIXED_NOREPLACE  (MAP_FIXED | MAP_EXCL)
> +#endif
> +
> +/**
> + * pgb_try_mmap:
> + * @addr: host start address
> + * @addr_last: host last address
> + * @keep: do not unmap the probe region
> + *
> + * Return 1 if [@addr, @addr_last] is not mapped in the host,
> + * return 0 if it is not available to map, and -1 on mmap error.
> + * If @keep, the region is left mapped on success, otherwise unmapped.
> + */
> +static int pgb_try_mmap(uintptr_t addr, uintptr_t addr_last, bool keep)
> +{
> +    size_t size =3D addr_last - addr + 1;
> +    void *p =3D mmap((void *)addr, size, PROT_NONE,
> +                   MAP_ANONYMOUS | MAP_PRIVATE |
> +                   MAP_NORESERVE | MAP_FIXED_NOREPLACE, -1, 0);
>

+    void *p =3D mmap((void *)addr, size, PROT_NONE,
+                   MAP_ANON | MAP_PRIVATE | MAP_FIXED | MAP_EXCL, -1, 0);

is what I had in my port. ANON and ANONYMOUS are the same. FreeBSD doesn't
define
MAP_NORESERVE that I can see, though you could define it above to be 0.
FreeBSD used
to define this, but it has no meaning in the current kernels.

Otherwise, this is a purely mechanical move, so

Reviewed-by: Warner Losh <imp@bsdimp.com>



> +    int ret;
> +
> +    if (p =3D=3D MAP_FAILED) {
> +        return errno =3D=3D EEXIST ? 0 : -1;
> +    }
> +    ret =3D p =3D=3D (void *)addr;
> +    if (!keep || !ret) {
> +        munmap(p, size);
> +    }
> +    return ret;
> +}
> +
> +/**
> + * pgb_try_mmap_skip_brk(uintptr_t addr, uintptr_t size, uintptr_t brk)
> + * @addr: host address
> + * @addr_last: host last address
> + * @brk: host brk
> + *
> + * Like pgb_try_mmap, but additionally reserve some memory following brk=
.
> + */
> +static int pgb_try_mmap_skip_brk(uintptr_t addr, uintptr_t addr_last,
> +                                 uintptr_t brk, bool keep)
> +{
> +    uintptr_t brk_last =3D brk + 16 * MiB - 1;
> +
> +    /* Do not map anything close to the host brk. */
> +    if (addr <=3D brk_last && brk <=3D addr_last) {
> +        return 0;
> +    }
> +    return pgb_try_mmap(addr, addr_last, keep);
> +}
> +
> +/**
> + * pgb_try_mmap_set:
> + * @ga: set of guest addrs
> + * @base: guest_base
> + * @brk: host brk
> + *
> + * Return true if all @ga can be mapped by the host at @base.
> + * On success, retain the mapping at index 0 for reserved_va.
> + */
> +
> +typedef struct PGBAddrs {
> +    PGBRange bounds[3];
> +    int nbounds;
> +} PGBAddrs;
> +
> +static bool pgb_try_mmap_set(const PGBAddrs *ga, uintptr_t base,
> uintptr_t brk)
> +{
> +    for (int i =3D ga->nbounds - 1; i >=3D 0; --i) {
> +        if (pgb_try_mmap_skip_brk(ga->bounds[i].lo + base,
> +                                  ga->bounds[i].hi + base,
> +                                  brk, i =3D=3D 0 && reserved_va) <=3D 0=
) {
> +            return false;
> +        }
> +    }
> +    return true;
> +}
> +
> +/**
> + * pgb_addr_set:
> + * @ga: output set of guest addrs
> + * @image_range: fixed guest image addresses
> + * @identity: create for identity mapping
> + *
> + * Fill in @ga with the image, COMMPAGE and NULL page.
> + */
> +static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *image_range,
> +                         const PGBRange *commpage_range, bool
> try_identity)
> +{
> +    int n;
> +
> +    /*
> +     * With a low commpage, or a guest mapped very low,
> +     * we may not be able to use the identity map.
> +     */
> +    if (try_identity) {
> +        if (commpage_range && commpage_range->lo < mmap_min_addr) {
> +            return false;
> +        }
> +        if (image_range && image_range->lo < mmap_min_addr) {
> +            return false;
> +        }
> +    }
> +
> +    memset(ga, 0, sizeof(*ga));
> +    n =3D 0;
> +
> +    if (reserved_va) {
> +        ga->bounds[n].lo =3D try_identity ? mmap_min_addr : 0;
> +        ga->bounds[n].hi =3D reserved_va;
> +        n++;
> +        /* Low COMMPAGE and NULL handled by reserving from 0. */
> +    } else {
> +        /* Add any low COMMPAGE or NULL page. */
> +        if (!try_identity || (commpage_range && commpage_range->lo =3D=
=3D 0))
> {
> +            ga->bounds[n].lo =3D 0;
> +            ga->bounds[n].hi =3D TARGET_PAGE_SIZE - 1;
> +            n++;
> +        }
> +
> +        /* Add the guest image for ET_EXEC. */
> +        if (image_range) {
> +            ga->bounds[n++] =3D *image_range;
> +        }
> +    }
> +
> +    /* Add any high COMMPAGE not covered by reserved_va. */
> +    if (commpage_range && reserved_va < commpage_range->hi) {
> +        ga->bounds[n].lo =3D commpage_range->lo &
> qemu_real_host_page_mask();
> +        ga->bounds[n].hi =3D commpage_range->hi;
> +        n++;
> +    }
> +
> +    ga->nbounds =3D n;
> +    return true;
> +}
> +
> +static void pgb_fail_in_use(const char *image_name)
> +{
> +    error_report("%s: requires virtual address space that is in use "
> +                 "(omit the -B option or choose a different value)",
> +                 image_name);
> +    exit(EXIT_FAILURE);
> +}
> +
> +static void pgb_fixed(const char *image_name, const PGBRange *image_rang=
e,
> +                      const PGBRange *commpage_range, uintptr_t align)
> +{
> +    PGBAddrs ga;
> +    uintptr_t brk =3D (uintptr_t)sbrk(0);
> +
> +    if (!QEMU_IS_ALIGNED(guest_base, align)) {
> +        fprintf(stderr, "Requested guest base %p does not satisfy "
> +                "host minimum alignment (0x%" PRIxPTR ")\n",
> +                (void *)guest_base, align);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    if (!pgb_addr_set(&ga, image_range, commpage_range, !guest_base)
> +        || !pgb_try_mmap_set(&ga, guest_base, brk)) {
> +        pgb_fail_in_use(image_name);
> +    }
> +}
> +
> +/**
> + * pgb_find_fallback:
> + *
> + * This is a fallback method for finding holes in the host address space
> + * if we don't have the benefit of being able to access /proc/self/map.
> + * It can potentially take a very long time as we can only dumbly iterat=
e
> + * up the host address space seeing if the allocation would work.
> + */
> +static uintptr_t pgb_find_fallback(const PGBAddrs *ga, uintptr_t align,
> +                                   uintptr_t brk)
> +{
> +    /* TODO: come up with a better estimate of how much to skip. */
> +    uintptr_t skip =3D sizeof(uintptr_t) =3D=3D 4 ? MiB : GiB;
> +
> +    for (uintptr_t base =3D skip; ; base +=3D skip) {
> +        base =3D ROUND_UP(base, align);
> +        if (pgb_try_mmap_set(ga, base, brk)) {
> +            return base;
> +        }
> +        if (base >=3D -skip) {
> +            return -1;
> +        }
> +    }
> +}
> +
> +static uintptr_t pgb_try_itree(const PGBAddrs *ga, uintptr_t base,
> +                               IntervalTreeRoot *root)
> +{
> +    for (int i =3D ga->nbounds - 1; i >=3D 0; --i) {
> +        uintptr_t s =3D base + ga->bounds[i].lo;
> +        uintptr_t l =3D base + ga->bounds[i].hi;
> +        IntervalTreeNode *n;
> +
> +        if (l < s) {
> +            /* Wraparound. Skip to advance S to mmap_min_addr. */
> +            return mmap_min_addr - s;
> +        }
> +
> +        n =3D interval_tree_iter_first(root, s, l);
> +        if (n !=3D NULL) {
> +            /* Conflict.  Skip to advance S to LAST + 1. */
> +            return n->last - s + 1;
> +        }
> +    }
> +    return 0;  /* success */
> +}
> +
> +static uintptr_t pgb_find_itree(const PGBAddrs *ga, IntervalTreeRoot
> *root,
> +                                uintptr_t align, uintptr_t brk)
> +{
> +    uintptr_t last =3D sizeof(uintptr_t) =3D=3D 4 ? MiB : GiB;
> +    uintptr_t base, skip;
> +
> +    while (true) {
> +        base =3D ROUND_UP(last, align);
> +        if (base < last) {
> +            return -1;
> +        }
> +
> +        skip =3D pgb_try_itree(ga, base, root);
> +        if (skip =3D=3D 0) {
> +            break;
> +        }
> +
> +        last =3D base + skip;
> +        if (last < base) {
> +            return -1;
> +        }
> +    }
> +
> +    /*
> +     * We've chosen 'base' based on holes in the interval tree,
> +     * but we don't yet know if it is a valid host address.
> +     * Because it is the first matching hole, if the host addresses
> +     * are invalid we know there are no further matches.
> +     */
> +    return pgb_try_mmap_set(ga, base, brk) ? base : -1;
> +}
> +
> +static void pgb_dynamic(const char *image_name, const PGBRange
> *image_range,
> +                        const PGBRange *commpage_range, uintptr_t align)
> +{
> +    IntervalTreeRoot *root;
> +    uintptr_t brk, ret;
> +    PGBAddrs ga;
> +
> +    /* Try the identity map first. */
> +    if (pgb_addr_set(&ga, image_range, commpage_range, true)) {
> +        brk =3D (uintptr_t)sbrk(0);
> +        if (pgb_try_mmap_set(&ga, 0, brk)) {
> +            guest_base =3D 0;
> +            return;
> +        }
> +    }
> +
> +    /*
> +     * Rebuild the address set for non-identity map.
> +     * This differs in the mapping of the guest NULL page.
> +     */
> +    pgb_addr_set(&ga, image_range, commpage_range, false);
> +
> +    root =3D read_self_maps();
> +
> +    /* Read brk after we've read the maps, which will malloc. */
> +    brk =3D (uintptr_t)sbrk(0);
> +
> +    if (!root) {
> +        ret =3D pgb_find_fallback(&ga, align, brk);
> +    } else {
> +        /*
> +         * Reserve the area close to the host brk.
> +         * This will be freed with the rest of the tree.
> +         */
> +        IntervalTreeNode *b =3D g_new0(IntervalTreeNode, 1);
> +        b->start =3D brk;
> +        b->last =3D brk + 16 * MiB - 1;
> +        interval_tree_insert(b, root);
> +
> +        ret =3D pgb_find_itree(&ga, root, align, brk);
> +        free_self_maps(root);
> +    }
> +
> +    if (ret =3D=3D -1) {
> +        int w =3D target_long_bits() / 4;
> +
> +        error_report("%s: Unable to find a guest_base to satisfy all "
> +                     "guest address mapping requirements", image_name);
> +
> +        for (int i =3D 0; i < ga.nbounds; ++i) {
> +            error_printf("  %0*" VADDR_PRIx "-%0*" VADDR_PRIx "\n",
> +                         w, ga.bounds[i].lo,
> +                         w, ga.bounds[i].hi);
> +        }
> +        exit(EXIT_FAILURE);
> +    }
> +    guest_base =3D ret;
> +}
> +
> +void probe_guest_base(const char *image_name, const PGBRange *image_rang=
e,
> +                      const PGBRange *commpage_range)
> +{
> +    /* In order to use host shmat, we must be able to honor SHMLBA.  */
> +    uintptr_t align =3D MAX(SHMLBA, TARGET_PAGE_SIZE);
> +
> +    /* Sanity check the guest binary. */
> +    if (reserved_va && image_range && image_range->hi > reserved_va) {
> +        error_report("%s: requires more than reserved virtual "
> +                     "address space (0x%" VADDR_PRIx " > 0x%lx)",
> +                     image_name, image_range->hi, reserved_va);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    if (have_guest_base) {
> +        pgb_fixed(image_name, image_range, commpage_range, align);
> +    } else {
> +        pgb_dynamic(image_name, image_range, commpage_range, align);
> +    }
> +
> +    assert(QEMU_IS_ALIGNED(guest_base, align));
> +    qemu_log_mask(CPU_LOG_PAGE, "Locating guest address space "
> +                  "@ 0x%" PRIx64 "\n", (uint64_t)guest_base);
> +}
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 0450aa13d8..4ab1a7b78c 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -4,7 +4,6 @@
>
>  #include <sys/prctl.h>
>  #include <sys/resource.h>
> -#include <sys/shm.h>
>
>  #include "qemu.h"
>  #include "user/tswap-target.h"
> @@ -13,8 +12,6 @@
>  #include "exec/mmap-lock.h"
>  #include "exec/translation-block.h"
>  #include "exec/tswap.h"
> -#include "user/guest-base.h"
> -#include "user/mmap-min-addr.h"
>  #include "user-internals.h"
>  #include "signal-common.h"
>  #include "loader.h"
> @@ -25,7 +22,6 @@
>  #include "qemu/queue.h"
>  #include "qemu/guest-random.h"
>  #include "qemu/units.h"
> -#include "user/selfmap.h"
>  #include "qemu/lockable.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> @@ -758,310 +754,8 @@ static abi_ulong create_elf_tables(abi_ulong p, int
> argc, int envc,
>      return sp;
>  }
>
> -#if !defined(COMMPAGE) && !defined(HAVE_GUEST_COMMPAGE)
> -bool init_guest_commpage(void) { return true; }
> -#endif
> -
> -/**
> - * pgb_try_mmap:
> - * @addr: host start address
> - * @addr_last: host last address
> - * @keep: do not unmap the probe region
> - *
> - * Return 1 if [@addr, @addr_last] is not mapped in the host,
> - * return 0 if it is not available to map, and -1 on mmap error.
> - * If @keep, the region is left mapped on success, otherwise unmapped.
> - */
> -static int pgb_try_mmap(uintptr_t addr, uintptr_t addr_last, bool keep)
> -{
> -    size_t size =3D addr_last - addr + 1;
> -    void *p =3D mmap((void *)addr, size, PROT_NONE,
> -                   MAP_ANONYMOUS | MAP_PRIVATE |
> -                   MAP_NORESERVE | MAP_FIXED_NOREPLACE, -1, 0);
> -    int ret;
> -
> -    if (p =3D=3D MAP_FAILED) {
> -        return errno =3D=3D EEXIST ? 0 : -1;
> -    }
> -    ret =3D p =3D=3D (void *)addr;
> -    if (!keep || !ret) {
> -        munmap(p, size);
> -    }
> -    return ret;
> -}
> -
> -/**
> - * pgb_try_mmap_skip_brk(uintptr_t addr, uintptr_t size, uintptr_t brk)
> - * @addr: host address
> - * @addr_last: host last address
> - * @brk: host brk
> - *
> - * Like pgb_try_mmap, but additionally reserve some memory following brk=
.
> - */
> -static int pgb_try_mmap_skip_brk(uintptr_t addr, uintptr_t addr_last,
> -                                 uintptr_t brk, bool keep)
> -{
> -    uintptr_t brk_last =3D brk + 16 * MiB - 1;
> -
> -    /* Do not map anything close to the host brk. */
> -    if (addr <=3D brk_last && brk <=3D addr_last) {
> -        return 0;
> -    }
> -    return pgb_try_mmap(addr, addr_last, keep);
> -}
> -
> -/**
> - * pgb_try_mmap_set:
> - * @ga: set of guest addrs
> - * @base: guest_base
> - * @brk: host brk
> - *
> - * Return true if all @ga can be mapped by the host at @base.
> - * On success, retain the mapping at index 0 for reserved_va.
> - */
> -
> -typedef struct PGBAddrs {
> -    PGBRange bounds[3];
> -    int nbounds;
> -} PGBAddrs;
> -
> -static bool pgb_try_mmap_set(const PGBAddrs *ga, uintptr_t base,
> uintptr_t brk)
> -{
> -    for (int i =3D ga->nbounds - 1; i >=3D 0; --i) {
> -        if (pgb_try_mmap_skip_brk(ga->bounds[i].lo + base,
> -                                  ga->bounds[i].hi + base,
> -                                  brk, i =3D=3D 0 && reserved_va) <=3D 0=
) {
> -            return false;
> -        }
> -    }
> -    return true;
> -}
> -
> -/**
> - * pgb_addr_set:
> - * @ga: output set of guest addrs
> - * @image_range: fixed guest image addresses
> - * @identity: create for identity mapping
> - *
> - * Fill in @ga with the image, COMMPAGE and NULL page.
> - */
> -static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *image_range,
> -                         const PGBRange *commpage_range, bool
> try_identity)
> -{
> -    int n;
> -
> -    /*
> -     * With a low commpage, or a guest mapped very low,
> -     * we may not be able to use the identity map.
> -     */
> -    if (try_identity) {
> -        if (commpage_range && commpage_range->lo < mmap_min_addr) {
> -            return false;
> -        }
> -        if (image_range && image_range->lo < mmap_min_addr) {
> -            return false;
> -        }
> -    }
> -
> -    memset(ga, 0, sizeof(*ga));
> -    n =3D 0;
> -
> -    if (reserved_va) {
> -        ga->bounds[n].lo =3D try_identity ? mmap_min_addr : 0;
> -        ga->bounds[n].hi =3D reserved_va;
> -        n++;
> -        /* Low COMMPAGE and NULL handled by reserving from 0. */
> -    } else {
> -        /* Add any low COMMPAGE or NULL page. */
> -        if (!try_identity || (commpage_range && commpage_range->lo =3D=
=3D 0))
> {
> -            ga->bounds[n].lo =3D 0;
> -            ga->bounds[n].hi =3D TARGET_PAGE_SIZE - 1;
> -            n++;
> -        }
> -
> -        /* Add the guest image for ET_EXEC. */
> -        if (image_range) {
> -            ga->bounds[n++] =3D *image_range;
> -        }
> -    }
> -
> -    /* Add any high COMMPAGE not covered by reserved_va. */
> -    if (commpage_range && reserved_va < commpage_range->hi) {
> -        ga->bounds[n].lo =3D commpage_range->lo &
> qemu_real_host_page_mask();
> -        ga->bounds[n].hi =3D commpage_range->hi;
> -        n++;
> -    }
> -
> -    ga->nbounds =3D n;
> -    return true;
> -}
> -
> -static void pgb_fail_in_use(const char *image_name)
> -{
> -    error_report("%s: requires virtual address space that is in use "
> -                 "(omit the -B option or choose a different value)",
> -                 image_name);
> -    exit(EXIT_FAILURE);
> -}
> -
> -static void pgb_fixed(const char *image_name, const PGBRange *image_rang=
e,
> -                      const PGBRange *commpage_range, uintptr_t align)
> -{
> -    PGBAddrs ga;
> -    uintptr_t brk =3D (uintptr_t)sbrk(0);
> -
> -    if (!QEMU_IS_ALIGNED(guest_base, align)) {
> -        fprintf(stderr, "Requested guest base %p does not satisfy "
> -                "host minimum alignment (0x%" PRIxPTR ")\n",
> -                (void *)guest_base, align);
> -        exit(EXIT_FAILURE);
> -    }
> -
> -    if (!pgb_addr_set(&ga, image_range, commpage_range, !guest_base)
> -        || !pgb_try_mmap_set(&ga, guest_base, brk)) {
> -        pgb_fail_in_use(image_name);
> -    }
> -}
> -
> -/**
> - * pgb_find_fallback:
> - *
> - * This is a fallback method for finding holes in the host address space
> - * if we don't have the benefit of being able to access /proc/self/map.
> - * It can potentially take a very long time as we can only dumbly iterat=
e
> - * up the host address space seeing if the allocation would work.
> - */
> -static uintptr_t pgb_find_fallback(const PGBAddrs *ga, uintptr_t align,
> -                                   uintptr_t brk)
> -{
> -    /* TODO: come up with a better estimate of how much to skip. */
> -    uintptr_t skip =3D sizeof(uintptr_t) =3D=3D 4 ? MiB : GiB;
> -
> -    for (uintptr_t base =3D skip; ; base +=3D skip) {
> -        base =3D ROUND_UP(base, align);
> -        if (pgb_try_mmap_set(ga, base, brk)) {
> -            return base;
> -        }
> -        if (base >=3D -skip) {
> -            return -1;
> -        }
> -    }
> -}
> -
> -static uintptr_t pgb_try_itree(const PGBAddrs *ga, uintptr_t base,
> -                               IntervalTreeRoot *root)
> -{
> -    for (int i =3D ga->nbounds - 1; i >=3D 0; --i) {
> -        uintptr_t s =3D base + ga->bounds[i].lo;
> -        uintptr_t l =3D base + ga->bounds[i].hi;
> -        IntervalTreeNode *n;
> -
> -        if (l < s) {
> -            /* Wraparound. Skip to advance S to mmap_min_addr. */
> -            return mmap_min_addr - s;
> -        }
> -
> -        n =3D interval_tree_iter_first(root, s, l);
> -        if (n !=3D NULL) {
> -            /* Conflict.  Skip to advance S to LAST + 1. */
> -            return n->last - s + 1;
> -        }
> -    }
> -    return 0;  /* success */
> -}
> -
> -static uintptr_t pgb_find_itree(const PGBAddrs *ga, IntervalTreeRoot
> *root,
> -                                uintptr_t align, uintptr_t brk)
> -{
> -    uintptr_t last =3D sizeof(uintptr_t) =3D=3D 4 ? MiB : GiB;
> -    uintptr_t base, skip;
> -
> -    while (true) {
> -        base =3D ROUND_UP(last, align);
> -        if (base < last) {
> -            return -1;
> -        }
> -
> -        skip =3D pgb_try_itree(ga, base, root);
> -        if (skip =3D=3D 0) {
> -            break;
> -        }
> -
> -        last =3D base + skip;
> -        if (last < base) {
> -            return -1;
> -        }
> -    }
> -
> -    /*
> -     * We've chosen 'base' based on holes in the interval tree,
> -     * but we don't yet know if it is a valid host address.
> -     * Because it is the first matching hole, if the host addresses
> -     * are invalid we know there are no further matches.
> -     */
> -    return pgb_try_mmap_set(ga, base, brk) ? base : -1;
> -}
> -
> -static void pgb_dynamic(const char *image_name, const PGBRange
> *image_range,
> -                        const PGBRange *commpage_range, uintptr_t align)
> -{
> -    IntervalTreeRoot *root;
> -    uintptr_t brk, ret;
> -    PGBAddrs ga;
> -
> -    /* Try the identity map first. */
> -    if (pgb_addr_set(&ga, image_range, commpage_range, true)) {
> -        brk =3D (uintptr_t)sbrk(0);
> -        if (pgb_try_mmap_set(&ga, 0, brk)) {
> -            guest_base =3D 0;
> -            return;
> -        }
> -    }
> -
> -    /*
> -     * Rebuild the address set for non-identity map.
> -     * This differs in the mapping of the guest NULL page.
> -     */
> -    pgb_addr_set(&ga, image_range, commpage_range, false);
> -
> -    root =3D read_self_maps();
> -
> -    /* Read brk after we've read the maps, which will malloc. */
> -    brk =3D (uintptr_t)sbrk(0);
> -
> -    if (!root) {
> -        ret =3D pgb_find_fallback(&ga, align, brk);
> -    } else {
> -        /*
> -         * Reserve the area close to the host brk.
> -         * This will be freed with the rest of the tree.
> -         */
> -        IntervalTreeNode *b =3D g_new0(IntervalTreeNode, 1);
> -        b->start =3D brk;
> -        b->last =3D brk + 16 * MiB - 1;
> -        interval_tree_insert(b, root);
> -
> -        ret =3D pgb_find_itree(&ga, root, align, brk);
> -        free_self_maps(root);
> -    }
> -
> -    if (ret =3D=3D -1) {
> -        int w =3D TARGET_LONG_BITS / 4;
> -
> -        error_report("%s: Unable to find a guest_base to satisfy all "
> -                     "guest address mapping requirements", image_name);
> -
> -        for (int i =3D 0; i < ga.nbounds; ++i) {
> -            error_printf("  %0*" VADDR_PRIx "-%0*" VADDR_PRIx "\n",
> -                         w, ga.bounds[i].lo,
> -                         w, ga.bounds[i].hi);
> -        }
> -        exit(EXIT_FAILURE);
> -    }
> -    guest_base =3D ret;
> -}
> -
> -void probe_guest_base(const char *image_name, const PGBRange *image_rang=
e)
> +void linux_probe_guest_base(const char *image_name,
> +                            const PGBRange *image_range)
>  {
>  #ifdef COMMPAGE
>      const PGBRange * const commpage_range =3D &(PGBRange){
> @@ -1071,32 +765,15 @@ void probe_guest_base(const char *image_name, cons=
t
> PGBRange *image_range)
>      const PGBRange * const commpage_range =3D NULL;
>  #endif
>
> -    /* In order to use host shmat, we must be able to honor SHMLBA.  */
> -    uintptr_t align =3D MAX(SHMLBA, TARGET_PAGE_SIZE);
> -
> -    /* Sanity check the guest binary. */
> -    if (reserved_va && image_range && image_range->hi > reserved_va) {
> -        error_report("%s: requires more than reserved virtual "
> -                     "address space (0x%" VADDR_PRIx " > 0x%lx)",
> -                     image_name, image_range->hi, reserved_va);
> -        exit(EXIT_FAILURE);
> -    }
> -
> -    if (have_guest_base) {
> -        pgb_fixed(image_name, image_range, commpage_range, align);
> -    } else {
> -        pgb_dynamic(image_name, image_range, commpage_range, align);
> -    }
> +    probe_guest_base(image_name, image_range, commpage_range);
>
>      /* Reserve and initialize the commpage. */
> +#if defined(COMMPAGE) || defined(HAVE_GUEST_COMMPAGE)
>      if (!init_guest_commpage()) {
>          /* We have already probed for the commpage being free. */
>          g_assert_not_reached();
>      }
> -
> -    assert(QEMU_IS_ALIGNED(guest_base, align));
> -    qemu_log_mask(CPU_LOG_PAGE, "Locating guest address space "
> -                  "@ 0x%" PRIx64 "\n", (uint64_t)guest_base);
> +#endif
>  }
>
>  enum {
> @@ -1345,10 +1022,10 @@ static void load_elf_image(const char *image_name=
,
> const ImageSource *src,
>               * Make sure that the low address does not conflict with
>               * MMAP_MIN_ADDR or the QEMU application itself.
>               */
> -            probe_guest_base(image_name, &range);
> +            linux_probe_guest_base(image_name, &range);
>          } else {
>              /* The binary is dynamic; we still need to select guest_base=
.
> */
> -            probe_guest_base(image_name, NULL);
> +            linux_probe_guest_base(image_name, NULL);
>
>              /*
>               * Avoid collision with the loader by providing a different
> diff --git a/linux-user/flatload.c b/linux-user/flatload.c
> index 45d69040c6..a551f083a4 100644
> --- a/linux-user/flatload.c
> +++ b/linux-user/flatload.c
> @@ -261,7 +261,7 @@ static int load_flat_file(struct linux_binprm * bprm,
>      /*
>       * Allocate the address space.
>       */
> -    probe_guest_base(bprm->filename, NULL);
> +    linux_probe_guest_base(bprm->filename, NULL);
>
>      /*
>       * there are a couple of cases here,  the separate code/data
> diff --git a/common-user/meson.build b/common-user/meson.build
> index 5e041de55e..2d4ffe07d3 100644
> --- a/common-user/meson.build
> +++ b/common-user/meson.build
> @@ -6,6 +6,7 @@ common_user_inc +=3D include_directories('host/' / host_a=
rch)
>
>  user_ss.add(files(
>    'mmap-min-addr.c',
> +  'probe-guest-base.c',
>    'safe-syscall.S',
>    'safe-syscall-error.c',
>    'selfmap.c',
> --
> 2.43.0
>
>

--00000000000031eb89065315bc94
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 30,=
 2026 at 3:13=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Prepare to share probe_gues=
t_base with bsd-user.<br>
<br>
Create a linux_probe_guest_base wrapper with the portions<br>
of probe_guest_base that are linux specific: managing the<br>
commpage for various targets.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0include/user/probe-guest-base.h |=C2=A0 37 ++++<br>
=C2=A0linux-user/user-internals.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 10 +-<br>
=C2=A0common-user/probe-guest-base.c=C2=A0 | 343 ++++++++++++++++++++++++++=
++++++<br>
=C2=A0linux-user/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 337 +=
------------------------------<br>
=C2=A0linux-user/flatload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A02 +-<br>
=C2=A0common-user/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A01 +<br>
=C2=A06 files changed, 392 insertions(+), 338 deletions(-)<br>
=C2=A0create mode 100644 include/user/probe-guest-base.h<br>
=C2=A0create mode 100644 common-user/probe-guest-base.c<br>
<br>
diff --git a/include/user/probe-guest-base.h b/include/user/probe-guest-bas=
e.h<br>
new file mode 100644<br>
index 0000000000..d7492ef46c<br>
--- /dev/null<br>
+++ b/include/user/probe-guest-base.h<br>
@@ -0,0 +1,37 @@<br>
+/* SPDX-License-Identifier: GPL-2.0-or-later */<br>
+<br>
+#ifndef USER_PROBE_GUEST_BASE_H<br>
+#define USER_PROBE_GUEST_BASE_H<br>
+<br>
+#ifndef CONFIG_USER_ONLY<br>
+#error Cannot include this header from system emulation<br>
+#endif<br>
+<br>
+#include &quot;exec/vaddr.h&quot;<br>
+<br>
+typedef struct PGBRange {<br>
+=C2=A0 =C2=A0 vaddr lo;<br>
+=C2=A0 =C2=A0 vaddr hi;<br>
+} PGBRange;<br>
+<br>
+/**<br>
+ * probe_guest_base:<br>
+ * @image_name: the executable being loaded<br>
+ * @image_range: the fixed addresses within the executable<br>
+ *<br>
+ * Creates the initial guest address space in the host memory space.<br>
+ *<br>
+ * If @image_range is NULL, then no address in the executable is fixed,<br=
>
+ * i.e. it is fully relocatable.<br>
+ *<br>
+ * This function will not return if a valid value for guest_base<br>
+ * cannot be chosen.=C2=A0 On return, the executable loader can expect<br>
+ *<br>
+ *=C2=A0 =C2=A0 target_mmap(i-&gt;lo, i-&gt;hi - i-&gt;lo + 1, ...)<br>
+ *<br>
+ * to succeed.<br>
+ */<br>
+void probe_guest_base(const char *image_name, const PGBRange *image_range,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const PGBRange *commpage_range);<br>
+<br>
+#endif<br>
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h<br>
index bc6b9f44e6..71f72002b6 100644<br>
--- a/linux-user/user-internals.h<br>
+++ b/linux-user/user-internals.h<br>
@@ -22,6 +22,7 @@<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;exec/tb-flush.h&quot;<br>
=C2=A0#include &quot;exec/translation-block.h&quot;<br>
+#include &quot;user/probe-guest-base.h&quot;<br>
<br>
=C2=A0extern char *exec_path;<br>
=C2=A0extern char real_exec_path[PATH_MAX];<br>
@@ -74,13 +75,8 @@ void clone_fork_end(bool child);<br>
=C2=A0void fork_start(void);<br>
=C2=A0void fork_end(pid_t pid);<br>
<br>
-typedef struct PGBRange {<br>
-=C2=A0 =C2=A0 vaddr lo;<br>
-=C2=A0 =C2=A0 vaddr hi;<br>
-} PGBRange;<br>
-<br>
=C2=A0/**<br>
- * probe_guest_base:<br>
+ * linux_probe_guest_base:<br>
=C2=A0 * @image_name: the executable being loaded<br>
=C2=A0 * @image_range: the fixed addresses within the executable<br>
=C2=A0 *<br>
@@ -96,7 +92,7 @@ typedef struct PGBRange {<br>
=C2=A0 *<br>
=C2=A0 * to succeed.<br>
=C2=A0 */<br>
-void probe_guest_base(const char *image_name, const PGBRange *image_range)=
;<br>
+void linux_probe_guest_base(const char *image_name, const PGBRange *image_=
range);<br>
<br>
=C2=A0/* syscall.c */<br>
=C2=A0int host_to_target_waitstatus(int status);<br>
diff --git a/common-user/probe-guest-base.c b/common-user/probe-guest-base.=
c<br>
new file mode 100644<br>
index 0000000000..77722fe63f<br>
--- /dev/null<br>
+++ b/common-user/probe-guest-base.c<br>
@@ -0,0 +1,343 @@<br>
+/* SPDX-License-Identifier: GPL-2.0-or-later */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/error-report.h&quot;<br>
+#include &quot;qemu/units.h&quot;<br>
+#include &quot;qemu/target-info.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+#include &quot;user/guest-base.h&quot;<br>
+#include &quot;user/mmap-min-addr.h&quot;<br>
+#include &quot;user/guest-host.h&quot;<br>
+#include &quot;user/probe-guest-base.h&quot;<br>
+#include &quot;user/selfmap.h&quot;<br>
+#include &quot;exec/target_page.h&quot;<br>
+#include &lt;sys/shm.h&gt;<br>
+<br>
+/* Linux and FreeBSD use different flags to express NOREPLACE. */<br>
+#ifdef __FreeBSD__<br>
+#define MAP_FIXED_NOREPLACE=C2=A0 (MAP_FIXED | MAP_EXCL)<br>
+#endif<br>
+<br>
+/**<br>
+ * pgb_try_mmap:<br>
+ * @addr: host start address<br>
+ * @addr_last: host last address<br>
+ * @keep: do not unmap the probe region<br>
+ *<br>
+ * Return 1 if [@addr, @addr_last] is not mapped in the host,<br>
+ * return 0 if it is not available to map, and -1 on mmap error.<br>
+ * If @keep, the region is left mapped on success, otherwise unmapped.<br>
+ */<br>
+static int pgb_try_mmap(uintptr_t addr, uintptr_t addr_last, bool keep)<br=
>
+{<br>
+=C2=A0 =C2=A0 size_t size =3D addr_last - addr + 1;<br>
+=C2=A0 =C2=A0 void *p =3D mmap((void *)addr, size, PROT_NONE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAP_A=
NONYMOUS | MAP_PRIVATE |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAP_N=
ORESERVE | MAP_FIXED_NOREPLACE, -1, 0);<br></blockquote><div><br></div><div=
>+ =C2=A0 =C2=A0void *p =3D mmap((void *)addr, size, PROT_NONE,<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MAP_ANON | MAP_PRI=
VATE | MAP_FIXED | MAP_EXCL, -1, 0);<br></div><div><br></div><div>is what I=
 had in my port. ANON and ANONYMOUS are the same. FreeBSD doesn&#39;t defin=
e</div><div>MAP_NORESERVE that I can see, though you could define it above =
to be 0. FreeBSD used</div><div>to define this, but it has no meaning in th=
e current kernels.</div><div><br></div><div>Otherwise, this is a purely mec=
hanical move, so</div><div><br></div><div>Reviewed-by: Warner Losh &lt;<a h=
ref=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div><br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 int ret;<br>
+<br>
+=C2=A0 =C2=A0 if (p =3D=3D MAP_FAILED) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return errno =3D=3D EEXIST ? 0 : -1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ret =3D p =3D=3D (void *)addr;<br>
+=C2=A0 =C2=A0 if (!keep || !ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 munmap(p, size);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+/**<br>
+ * pgb_try_mmap_skip_brk(uintptr_t addr, uintptr_t size, uintptr_t brk)<br=
>
+ * @addr: host address<br>
+ * @addr_last: host last address<br>
+ * @brk: host brk<br>
+ *<br>
+ * Like pgb_try_mmap, but additionally reserve some memory following brk.<=
br>
+ */<br>
+static int pgb_try_mmap_skip_brk(uintptr_t addr, uintptr_t addr_last,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uintptr_t brk, bool keep)<br>
+{<br>
+=C2=A0 =C2=A0 uintptr_t brk_last =3D brk + 16 * MiB - 1;<br>
+<br>
+=C2=A0 =C2=A0 /* Do not map anything close to the host brk. */<br>
+=C2=A0 =C2=A0 if (addr &lt;=3D brk_last &amp;&amp; brk &lt;=3D addr_last) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return pgb_try_mmap(addr, addr_last, keep);<br>
+}<br>
+<br>
+/**<br>
+ * pgb_try_mmap_set:<br>
+ * @ga: set of guest addrs<br>
+ * @base: guest_base<br>
+ * @brk: host brk<br>
+ *<br>
+ * Return true if all @ga can be mapped by the host at @base.<br>
+ * On success, retain the mapping at index 0 for reserved_va.<br>
+ */<br>
+<br>
+typedef struct PGBAddrs {<br>
+=C2=A0 =C2=A0 PGBRange bounds[3];<br>
+=C2=A0 =C2=A0 int nbounds;<br>
+} PGBAddrs;<br>
+<br>
+static bool pgb_try_mmap_set(const PGBAddrs *ga, uintptr_t base, uintptr_t=
 brk)<br>
+{<br>
+=C2=A0 =C2=A0 for (int i =3D ga-&gt;nbounds - 1; i &gt;=3D 0; --i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pgb_try_mmap_skip_brk(ga-&gt;bounds[i].lo =
+ base,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[i].hi + base,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brk, i =3D=3D 0 &amp;&amp; re=
served_va) &lt;=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/**<br>
+ * pgb_addr_set:<br>
+ * @ga: output set of guest addrs<br>
+ * @image_range: fixed guest image addresses<br>
+ * @identity: create for identity mapping<br>
+ *<br>
+ * Fill in @ga with the image, COMMPAGE and NULL page.<br>
+ */<br>
+static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *image_range,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const PGBRange *commpage_range, bool try_identity)<br>
+{<br>
+=C2=A0 =C2=A0 int n;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* With a low commpage, or a guest mapped very low,<br>
+=C2=A0 =C2=A0 =C2=A0* we may not be able to use the identity map.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (try_identity) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (commpage_range &amp;&amp; commpage_range-&=
gt;lo &lt; mmap_min_addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (image_range &amp;&amp; image_range-&gt;lo =
&lt; mmap_min_addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 memset(ga, 0, sizeof(*ga));<br>
+=C2=A0 =C2=A0 n =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 if (reserved_va) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].lo =3D try_identity ? mmap_mi=
n_addr : 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].hi =3D reserved_va;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 n++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Low COMMPAGE and NULL handled by reserving =
from 0. */<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add any low COMMPAGE or NULL page. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!try_identity || (commpage_range &amp;&amp=
; commpage_range-&gt;lo =3D=3D 0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].lo =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].hi =3D TARGET_P=
AGE_SIZE - 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add the guest image for ET_EXEC. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (image_range) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n++] =3D *image_ra=
nge;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Add any high COMMPAGE not covered by reserved_va. */<br>
+=C2=A0 =C2=A0 if (commpage_range &amp;&amp; reserved_va &lt; commpage_rang=
e-&gt;hi) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].lo =3D commpage_range-&gt;lo =
&amp; qemu_real_host_page_mask();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].hi =3D commpage_range-&gt;hi;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 n++;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 ga-&gt;nbounds =3D n;<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static void pgb_fail_in_use(const char *image_name)<br>
+{<br>
+=C2=A0 =C2=A0 error_report(&quot;%s: requires virtual address space that i=
s in use &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;(omit =
the -B option or choose a different value)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_name);=
<br>
+=C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
+}<br>
+<br>
+static void pgb_fixed(const char *image_name, const PGBRange *image_range,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const PGBRange *commpage_range, uintptr_t align)<br>
+{<br>
+=C2=A0 =C2=A0 PGBAddrs ga;<br>
+=C2=A0 =C2=A0 uintptr_t brk =3D (uintptr_t)sbrk(0);<br>
+<br>
+=C2=A0 =C2=A0 if (!QEMU_IS_ALIGNED(guest_base, align)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Requested guest base %p =
does not satisfy &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;host minimum=
 alignment (0x%&quot; PRIxPTR &quot;)\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (void *)guest_base=
, align);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!pgb_addr_set(&amp;ga, image_range, commpage_range, !gue=
st_base)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !pgb_try_mmap_set(&amp;ga, guest_base, brk)=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pgb_fail_in_use(image_name);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+/**<br>
+ * pgb_find_fallback:<br>
+ *<br>
+ * This is a fallback method for finding holes in the host address space<b=
r>
+ * if we don&#39;t have the benefit of being able to access /proc/self/map=
.<br>
+ * It can potentially take a very long time as we can only dumbly iterate<=
br>
+ * up the host address space seeing if the allocation would work.<br>
+ */<br>
+static uintptr_t pgb_find_fallback(const PGBAddrs *ga, uintptr_t align,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uintptr_t brk)<br>
+{<br>
+=C2=A0 =C2=A0 /* TODO: come up with a better estimate of how much to skip.=
 */<br>
+=C2=A0 =C2=A0 uintptr_t skip =3D sizeof(uintptr_t) =3D=3D 4 ? MiB : GiB;<b=
r>
+<br>
+=C2=A0 =C2=A0 for (uintptr_t base =3D skip; ; base +=3D skip) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 base =3D ROUND_UP(base, align);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pgb_try_mmap_set(ga, base, brk)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return base;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (base &gt;=3D -skip) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static uintptr_t pgb_try_itree(const PGBAddrs *ga, uintptr_t base,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IntervalTreeRoot *root)<br>
+{<br>
+=C2=A0 =C2=A0 for (int i =3D ga-&gt;nbounds - 1; i &gt;=3D 0; --i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t s =3D base + ga-&gt;bounds[i].lo;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t l =3D base + ga-&gt;bounds[i].hi;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 IntervalTreeNode *n;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (l &lt; s) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Wraparound. Skip to advance S=
 to mmap_min_addr. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return mmap_min_addr - s;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D interval_tree_iter_first(root, s, l);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Conflict.=C2=A0 Skip to advan=
ce S to LAST + 1. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return n-&gt;last - s + 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return 0;=C2=A0 /* success */<br>
+}<br>
+<br>
+static uintptr_t pgb_find_itree(const PGBAddrs *ga, IntervalTreeRoot *root=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t align, uintptr_t brk)<br>
+{<br>
+=C2=A0 =C2=A0 uintptr_t last =3D sizeof(uintptr_t) =3D=3D 4 ? MiB : GiB;<b=
r>
+=C2=A0 =C2=A0 uintptr_t base, skip;<br>
+<br>
+=C2=A0 =C2=A0 while (true) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 base =3D ROUND_UP(last, align);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (base &lt; last) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 skip =3D pgb_try_itree(ga, base, root);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (skip =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 last =3D base + skip;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (last &lt; base) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* We&#39;ve chosen &#39;base&#39; based on holes in th=
e interval tree,<br>
+=C2=A0 =C2=A0 =C2=A0* but we don&#39;t yet know if it is a valid host addr=
ess.<br>
+=C2=A0 =C2=A0 =C2=A0* Because it is the first matching hole, if the host a=
ddresses<br>
+=C2=A0 =C2=A0 =C2=A0* are invalid we know there are no further matches.<br=
>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 return pgb_try_mmap_set(ga, base, brk) ? base : -1;<br>
+}<br>
+<br>
+static void pgb_dynamic(const char *image_name, const PGBRange *image_rang=
e,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const PGBRange *commpage_range, uintptr_t align)<br>
+{<br>
+=C2=A0 =C2=A0 IntervalTreeRoot *root;<br>
+=C2=A0 =C2=A0 uintptr_t brk, ret;<br>
+=C2=A0 =C2=A0 PGBAddrs ga;<br>
+<br>
+=C2=A0 =C2=A0 /* Try the identity map first. */<br>
+=C2=A0 =C2=A0 if (pgb_addr_set(&amp;ga, image_range, commpage_range, true)=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 brk =3D (uintptr_t)sbrk(0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pgb_try_mmap_set(&amp;ga, 0, brk)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 guest_base =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Rebuild the address set for non-identity map.<br>
+=C2=A0 =C2=A0 =C2=A0* This differs in the mapping of the guest NULL page.<=
br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 pgb_addr_set(&amp;ga, image_range, commpage_range, false);<b=
r>
+<br>
+=C2=A0 =C2=A0 root =3D read_self_maps();<br>
+<br>
+=C2=A0 =C2=A0 /* Read brk after we&#39;ve read the maps, which will malloc=
. */<br>
+=C2=A0 =C2=A0 brk =3D (uintptr_t)sbrk(0);<br>
+<br>
+=C2=A0 =C2=A0 if (!root) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D pgb_find_fallback(&amp;ga, align, brk)=
;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Reserve the area close to the host brk=
.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* This will be freed with the rest of th=
e tree.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 IntervalTreeNode *b =3D g_new0(IntervalTreeNod=
e, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 b-&gt;start =3D brk;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 b-&gt;last =3D brk + 16 * MiB - 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 interval_tree_insert(b, root);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D pgb_find_itree(&amp;ga, root, align, b=
rk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 free_self_maps(root);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (ret =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int w =3D target_long_bits() / 4;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: Unable to find a guest_=
base to satisfy all &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;guest address mapping requirements&quot;, image_name);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; ga.nbounds; ++i) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_printf(&quot;=C2=A0 %0*&qu=
ot; VADDR_PRIx &quot;-%0*&quot; VADDR_PRIx &quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0w, ga.bounds[i].lo,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0w, ga.bounds[i].hi);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 guest_base =3D ret;<br>
+}<br>
+<br>
+void probe_guest_base(const char *image_name, const PGBRange *image_range,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const PGBRange *commpage_range)<br>
+{<br>
+=C2=A0 =C2=A0 /* In order to use host shmat, we must be able to honor SHML=
BA.=C2=A0 */<br>
+=C2=A0 =C2=A0 uintptr_t align =3D MAX(SHMLBA, TARGET_PAGE_SIZE);<br>
+<br>
+=C2=A0 =C2=A0 /* Sanity check the guest binary. */<br>
+=C2=A0 =C2=A0 if (reserved_va &amp;&amp; image_range &amp;&amp; image_rang=
e-&gt;hi &gt; reserved_va) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: requires more than rese=
rved virtual &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;address space (0x%&quot; VADDR_PRIx &quot; &gt; 0x%lx)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0image_name, image_range-&gt;hi, reserved_va);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (have_guest_base) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pgb_fixed(image_name, image_range, commpage_ra=
nge, align);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pgb_dynamic(image_name, image_range, commpage_=
range, align);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 assert(QEMU_IS_ALIGNED(guest_base, align));<br>
+=C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_PAGE, &quot;Locating guest address spa=
ce &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;@ 0x%=
&quot; PRIx64 &quot;\n&quot;, (uint64_t)guest_base);<br>
+}<br>
diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>
index 0450aa13d8..4ab1a7b78c 100644<br>
--- a/linux-user/elfload.c<br>
+++ b/linux-user/elfload.c<br>
@@ -4,7 +4,6 @@<br>
<br>
=C2=A0#include &lt;sys/prctl.h&gt;<br>
=C2=A0#include &lt;sys/resource.h&gt;<br>
-#include &lt;sys/shm.h&gt;<br>
<br>
=C2=A0#include &quot;qemu.h&quot;<br>
=C2=A0#include &quot;user/tswap-target.h&quot;<br>
@@ -13,8 +12,6 @@<br>
=C2=A0#include &quot;exec/mmap-lock.h&quot;<br>
=C2=A0#include &quot;exec/translation-block.h&quot;<br>
=C2=A0#include &quot;exec/tswap.h&quot;<br>
-#include &quot;user/guest-base.h&quot;<br>
-#include &quot;user/mmap-min-addr.h&quot;<br>
=C2=A0#include &quot;user-internals.h&quot;<br>
=C2=A0#include &quot;signal-common.h&quot;<br>
=C2=A0#include &quot;loader.h&quot;<br>
@@ -25,7 +22,6 @@<br>
=C2=A0#include &quot;qemu/queue.h&quot;<br>
=C2=A0#include &quot;qemu/guest-random.h&quot;<br>
=C2=A0#include &quot;qemu/units.h&quot;<br>
-#include &quot;user/selfmap.h&quot;<br>
=C2=A0#include &quot;qemu/lockable.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
@@ -758,310 +754,8 @@ static abi_ulong create_elf_tables(abi_ulong p, int a=
rgc, int envc,<br>
=C2=A0 =C2=A0 =C2=A0return sp;<br>
=C2=A0}<br>
<br>
-#if !defined(COMMPAGE) &amp;&amp; !defined(HAVE_GUEST_COMMPAGE)<br>
-bool init_guest_commpage(void) { return true; }<br>
-#endif<br>
-<br>
-/**<br>
- * pgb_try_mmap:<br>
- * @addr: host start address<br>
- * @addr_last: host last address<br>
- * @keep: do not unmap the probe region<br>
- *<br>
- * Return 1 if [@addr, @addr_last] is not mapped in the host,<br>
- * return 0 if it is not available to map, and -1 on mmap error.<br>
- * If @keep, the region is left mapped on success, otherwise unmapped.<br>
- */<br>
-static int pgb_try_mmap(uintptr_t addr, uintptr_t addr_last, bool keep)<br=
>
-{<br>
-=C2=A0 =C2=A0 size_t size =3D addr_last - addr + 1;<br>
-=C2=A0 =C2=A0 void *p =3D mmap((void *)addr, size, PROT_NONE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAP_A=
NONYMOUS | MAP_PRIVATE |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAP_N=
ORESERVE | MAP_FIXED_NOREPLACE, -1, 0);<br>
-=C2=A0 =C2=A0 int ret;<br>
-<br>
-=C2=A0 =C2=A0 if (p =3D=3D MAP_FAILED) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return errno =3D=3D EEXIST ? 0 : -1;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 ret =3D p =3D=3D (void *)addr;<br>
-=C2=A0 =C2=A0 if (!keep || !ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 munmap(p, size);<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return ret;<br>
-}<br>
-<br>
-/**<br>
- * pgb_try_mmap_skip_brk(uintptr_t addr, uintptr_t size, uintptr_t brk)<br=
>
- * @addr: host address<br>
- * @addr_last: host last address<br>
- * @brk: host brk<br>
- *<br>
- * Like pgb_try_mmap, but additionally reserve some memory following brk.<=
br>
- */<br>
-static int pgb_try_mmap_skip_brk(uintptr_t addr, uintptr_t addr_last,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uintptr_t brk, bool keep)<br>
-{<br>
-=C2=A0 =C2=A0 uintptr_t brk_last =3D brk + 16 * MiB - 1;<br>
-<br>
-=C2=A0 =C2=A0 /* Do not map anything close to the host brk. */<br>
-=C2=A0 =C2=A0 if (addr &lt;=3D brk_last &amp;&amp; brk &lt;=3D addr_last) =
{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return pgb_try_mmap(addr, addr_last, keep);<br>
-}<br>
-<br>
-/**<br>
- * pgb_try_mmap_set:<br>
- * @ga: set of guest addrs<br>
- * @base: guest_base<br>
- * @brk: host brk<br>
- *<br>
- * Return true if all @ga can be mapped by the host at @base.<br>
- * On success, retain the mapping at index 0 for reserved_va.<br>
- */<br>
-<br>
-typedef struct PGBAddrs {<br>
-=C2=A0 =C2=A0 PGBRange bounds[3];<br>
-=C2=A0 =C2=A0 int nbounds;<br>
-} PGBAddrs;<br>
-<br>
-static bool pgb_try_mmap_set(const PGBAddrs *ga, uintptr_t base, uintptr_t=
 brk)<br>
-{<br>
-=C2=A0 =C2=A0 for (int i =3D ga-&gt;nbounds - 1; i &gt;=3D 0; --i) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pgb_try_mmap_skip_brk(ga-&gt;bounds[i].lo =
+ base,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[i].hi + base,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brk, i =3D=3D 0 &amp;&amp; re=
served_va) &lt;=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return true;<br>
-}<br>
-<br>
-/**<br>
- * pgb_addr_set:<br>
- * @ga: output set of guest addrs<br>
- * @image_range: fixed guest image addresses<br>
- * @identity: create for identity mapping<br>
- *<br>
- * Fill in @ga with the image, COMMPAGE and NULL page.<br>
- */<br>
-static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *image_range,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const PGBRange *commpage_range, bool try_identity)<br>
-{<br>
-=C2=A0 =C2=A0 int n;<br>
-<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* With a low commpage, or a guest mapped very low,<br>
-=C2=A0 =C2=A0 =C2=A0* we may not be able to use the identity map.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 if (try_identity) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (commpage_range &amp;&amp; commpage_range-&=
gt;lo &lt; mmap_min_addr) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (image_range &amp;&amp; image_range-&gt;lo =
&lt; mmap_min_addr) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 memset(ga, 0, sizeof(*ga));<br>
-=C2=A0 =C2=A0 n =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 if (reserved_va) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].lo =3D try_identity ? mmap_mi=
n_addr : 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].hi =3D reserved_va;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 n++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Low COMMPAGE and NULL handled by reserving =
from 0. */<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add any low COMMPAGE or NULL page. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!try_identity || (commpage_range &amp;&amp=
; commpage_range-&gt;lo =3D=3D 0)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].lo =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].hi =3D TARGET_P=
AGE_SIZE - 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add the guest image for ET_EXEC. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (image_range) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n++] =3D *image_ra=
nge;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 /* Add any high COMMPAGE not covered by reserved_va. */<br>
-=C2=A0 =C2=A0 if (commpage_range &amp;&amp; reserved_va &lt; commpage_rang=
e-&gt;hi) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].lo =3D commpage_range-&gt;lo =
&amp; qemu_real_host_page_mask();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga-&gt;bounds[n].hi =3D commpage_range-&gt;hi;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 n++;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 ga-&gt;nbounds =3D n;<br>
-=C2=A0 =C2=A0 return true;<br>
-}<br>
-<br>
-static void pgb_fail_in_use(const char *image_name)<br>
-{<br>
-=C2=A0 =C2=A0 error_report(&quot;%s: requires virtual address space that i=
s in use &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;(omit =
the -B option or choose a different value)&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_name);=
<br>
-=C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
-}<br>
-<br>
-static void pgb_fixed(const char *image_name, const PGBRange *image_range,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const PGBRange *commpage_range, uintptr_t align)<br>
-{<br>
-=C2=A0 =C2=A0 PGBAddrs ga;<br>
-=C2=A0 =C2=A0 uintptr_t brk =3D (uintptr_t)sbrk(0);<br>
-<br>
-=C2=A0 =C2=A0 if (!QEMU_IS_ALIGNED(guest_base, align)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Requested guest base %p =
does not satisfy &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;host minimum=
 alignment (0x%&quot; PRIxPTR &quot;)\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (void *)guest_base=
, align);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (!pgb_addr_set(&amp;ga, image_range, commpage_range, !gue=
st_base)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 || !pgb_try_mmap_set(&amp;ga, guest_base, brk)=
) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pgb_fail_in_use(image_name);<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-/**<br>
- * pgb_find_fallback:<br>
- *<br>
- * This is a fallback method for finding holes in the host address space<b=
r>
- * if we don&#39;t have the benefit of being able to access /proc/self/map=
.<br>
- * It can potentially take a very long time as we can only dumbly iterate<=
br>
- * up the host address space seeing if the allocation would work.<br>
- */<br>
-static uintptr_t pgb_find_fallback(const PGBAddrs *ga, uintptr_t align,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uintptr_t brk)<br>
-{<br>
-=C2=A0 =C2=A0 /* TODO: come up with a better estimate of how much to skip.=
 */<br>
-=C2=A0 =C2=A0 uintptr_t skip =3D sizeof(uintptr_t) =3D=3D 4 ? MiB : GiB;<b=
r>
-<br>
-=C2=A0 =C2=A0 for (uintptr_t base =3D skip; ; base +=3D skip) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 base =3D ROUND_UP(base, align);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pgb_try_mmap_set(ga, base, brk)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return base;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (base &gt;=3D -skip) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-static uintptr_t pgb_try_itree(const PGBAddrs *ga, uintptr_t base,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IntervalTreeRoot *root)<br>
-{<br>
-=C2=A0 =C2=A0 for (int i =3D ga-&gt;nbounds - 1; i &gt;=3D 0; --i) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t s =3D base + ga-&gt;bounds[i].lo;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t l =3D base + ga-&gt;bounds[i].hi;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 IntervalTreeNode *n;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (l &lt; s) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Wraparound. Skip to advance S=
 to mmap_min_addr. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return mmap_min_addr - s;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D interval_tree_iter_first(root, s, l);<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Conflict.=C2=A0 Skip to advan=
ce S to LAST + 1. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return n-&gt;last - s + 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return 0;=C2=A0 /* success */<br>
-}<br>
-<br>
-static uintptr_t pgb_find_itree(const PGBAddrs *ga, IntervalTreeRoot *root=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t align, uintptr_t brk)<br>
-{<br>
-=C2=A0 =C2=A0 uintptr_t last =3D sizeof(uintptr_t) =3D=3D 4 ? MiB : GiB;<b=
r>
-=C2=A0 =C2=A0 uintptr_t base, skip;<br>
-<br>
-=C2=A0 =C2=A0 while (true) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 base =3D ROUND_UP(last, align);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (base &lt; last) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 skip =3D pgb_try_itree(ga, base, root);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (skip =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 last =3D base + skip;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (last &lt; base) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* We&#39;ve chosen &#39;base&#39; based on holes in th=
e interval tree,<br>
-=C2=A0 =C2=A0 =C2=A0* but we don&#39;t yet know if it is a valid host addr=
ess.<br>
-=C2=A0 =C2=A0 =C2=A0* Because it is the first matching hole, if the host a=
ddresses<br>
-=C2=A0 =C2=A0 =C2=A0* are invalid we know there are no further matches.<br=
>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 return pgb_try_mmap_set(ga, base, brk) ? base : -1;<br>
-}<br>
-<br>
-static void pgb_dynamic(const char *image_name, const PGBRange *image_rang=
e,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const PGBRange *commpage_range, uintptr_t align)<br>
-{<br>
-=C2=A0 =C2=A0 IntervalTreeRoot *root;<br>
-=C2=A0 =C2=A0 uintptr_t brk, ret;<br>
-=C2=A0 =C2=A0 PGBAddrs ga;<br>
-<br>
-=C2=A0 =C2=A0 /* Try the identity map first. */<br>
-=C2=A0 =C2=A0 if (pgb_addr_set(&amp;ga, image_range, commpage_range, true)=
) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 brk =3D (uintptr_t)sbrk(0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pgb_try_mmap_set(&amp;ga, 0, brk)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 guest_base =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* Rebuild the address set for non-identity map.<br>
-=C2=A0 =C2=A0 =C2=A0* This differs in the mapping of the guest NULL page.<=
br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 pgb_addr_set(&amp;ga, image_range, commpage_range, false);<b=
r>
-<br>
-=C2=A0 =C2=A0 root =3D read_self_maps();<br>
-<br>
-=C2=A0 =C2=A0 /* Read brk after we&#39;ve read the maps, which will malloc=
. */<br>
-=C2=A0 =C2=A0 brk =3D (uintptr_t)sbrk(0);<br>
-<br>
-=C2=A0 =C2=A0 if (!root) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D pgb_find_fallback(&amp;ga, align, brk)=
;<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Reserve the area close to the host brk=
.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* This will be freed with the rest of th=
e tree.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 IntervalTreeNode *b =3D g_new0(IntervalTreeNod=
e, 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 b-&gt;start =3D brk;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 b-&gt;last =3D brk + 16 * MiB - 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 interval_tree_insert(b, root);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D pgb_find_itree(&amp;ga, root, align, b=
rk);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 free_self_maps(root);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (ret =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int w =3D TARGET_LONG_BITS / 4;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: Unable to find a guest_=
base to satisfy all &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;guest address mapping requirements&quot;, image_name);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; ga.nbounds; ++i) {<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_printf(&quot;=C2=A0 %0*&qu=
ot; VADDR_PRIx &quot;-%0*&quot; VADDR_PRIx &quot;\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0w, ga.bounds[i].lo,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0w, ga.bounds[i].hi);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 guest_base =3D ret;<br>
-}<br>
-<br>
-void probe_guest_base(const char *image_name, const PGBRange *image_range)=
<br>
+void linux_probe_guest_base(const char *image_name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 const PGBRange *image_range)<br>
=C2=A0{<br>
=C2=A0#ifdef COMMPAGE<br>
=C2=A0 =C2=A0 =C2=A0const PGBRange * const commpage_range =3D &amp;(PGBRang=
e){<br>
@@ -1071,32 +765,15 @@ void probe_guest_base(const char *image_name, const =
PGBRange *image_range)<br>
=C2=A0 =C2=A0 =C2=A0const PGBRange * const commpage_range =3D NULL;<br>
=C2=A0#endif<br>
<br>
-=C2=A0 =C2=A0 /* In order to use host shmat, we must be able to honor SHML=
BA.=C2=A0 */<br>
-=C2=A0 =C2=A0 uintptr_t align =3D MAX(SHMLBA, TARGET_PAGE_SIZE);<br>
-<br>
-=C2=A0 =C2=A0 /* Sanity check the guest binary. */<br>
-=C2=A0 =C2=A0 if (reserved_va &amp;&amp; image_range &amp;&amp; image_rang=
e-&gt;hi &gt; reserved_va) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: requires more than rese=
rved virtual &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;address space (0x%&quot; VADDR_PRIx &quot; &gt; 0x%lx)&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0image_name, image_range-&gt;hi, reserved_va);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (have_guest_base) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pgb_fixed(image_name, image_range, commpage_ra=
nge, align);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pgb_dynamic(image_name, image_range, commpage_=
range, align);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 probe_guest_base(image_name, image_range, commpage_range);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0/* Reserve and initialize the commpage. */<br>
+#if defined(COMMPAGE) || defined(HAVE_GUEST_COMMPAGE)<br>
=C2=A0 =C2=A0 =C2=A0if (!init_guest_commpage()) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We have already probed for the commpag=
e being free. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 assert(QEMU_IS_ALIGNED(guest_base, align));<br>
-=C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_PAGE, &quot;Locating guest address spa=
ce &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;@ 0x%=
&quot; PRIx64 &quot;\n&quot;, (uint64_t)guest_base);<br>
+#endif<br>
=C2=A0}<br>
<br>
=C2=A0enum {<br>
@@ -1345,10 +1022,10 @@ static void load_elf_image(const char *image_name, =
const ImageSource *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Make sure that the low a=
ddress does not conflict with<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * MMAP_MIN_ADDR or the QEM=
U application itself.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 probe_guest_base(image_name, &am=
p;range);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linux_probe_guest_base(image_nam=
e, &amp;range);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The binary is dynamic; w=
e still need to select guest_base. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 probe_guest_base(image_name, NUL=
L);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linux_probe_guest_base(image_nam=
e, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Avoid collision with the=
 loader by providing a different<br>
diff --git a/linux-user/flatload.c b/linux-user/flatload.c<br>
index 45d69040c6..a551f083a4 100644<br>
--- a/linux-user/flatload.c<br>
+++ b/linux-user/flatload.c<br>
@@ -261,7 +261,7 @@ static int load_flat_file(struct linux_binprm * bprm,<b=
r>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Allocate the address space.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 probe_guest_base(bprm-&gt;filename, NULL);<br>
+=C2=A0 =C2=A0 linux_probe_guest_base(bprm-&gt;filename, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * there are a couple of cases here,=C2=A0 the separate=
 code/data<br>
diff --git a/common-user/meson.build b/common-user/meson.build<br>
index 5e041de55e..2d4ffe07d3 100644<br>
--- a/common-user/meson.build<br>
+++ b/common-user/meson.build<br>
@@ -6,6 +6,7 @@ common_user_inc +=3D include_directories(&#39;host/&#39; / =
host_arch)<br>
<br>
=C2=A0user_ss.add(files(<br>
=C2=A0 =C2=A0&#39;mmap-min-addr.c&#39;,<br>
+=C2=A0 &#39;probe-guest-base.c&#39;,<br>
=C2=A0 =C2=A0&#39;safe-syscall.S&#39;,<br>
=C2=A0 =C2=A0&#39;safe-syscall-error.c&#39;,<br>
=C2=A0 =C2=A0&#39;selfmap.c&#39;,<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--00000000000031eb89065315bc94--

