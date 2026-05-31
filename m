Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A6ACD5BD1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 04:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTXfj-0000p1-BQ; Sun, 31 May 2026 00:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXff-0000oT-If
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:21:07 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXfb-0001nG-8x
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:21:07 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2bf125989f2so18836305ad.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 21:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780201262; cv=none;
 d=google.com; s=arc-20240605;
 b=R/vyN9gq3+H9e2jejRjxKDly0DPArHLNhsIjc8LdLDGZjzQJfXZMROc/vIh7kG/UnH
 sdqrtNPXliztxTnGaBf5sHxXVGxAu2iocXdzVl/0qJ8JLmWP3/5KJdrP/CeyeUOuCAKD
 rNvWxLFfuRsmfmz3BFGx65D5rxS31ndbCMTBmKkN0phbSGsX0ilz/mp2pJhLJcr1rTNs
 rY+CSpgAZdRgNFEc+/xdbb9sAguKr1tsqg24f3H8G6uebBHHKWVmdQ9Vl5wQK7OvUjEd
 C6rWtFyS9F8e4d0L0DSU9JP7RLywBe+BtT8Cov9u9DECgfhNONZjkaaMZs5FohJ/Cq+Y
 z2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JiiPkeoMJ4Jc/9aZR8aKRB6k0a4QjjU+NTYAU5WxdJ0=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=OGv/zUwSP0/wVD1QFrUCaU+pFzTcBkuzBgjOfGLpvfy59JZaOZiDUEmHtB9ETp3EqA
 BgLAMfDDVGvvu0iK0XPYn2eflkwA28jtqhjmHoLOl4rXWv/YD7lQzSwt3W+mGvvGCb0D
 WP33cX9704wB4PjIe9yBstD7QjY9ZaGYkgYcTRJ3OkQvFqGQAWFR1kC5ezJNaE9c/odA
 O46WAGgAsvzVjDbfZd7dosZ9EUieI8WnS5H0U1VdpBJ8vuHlDiRWeOmsinKbFsV2BgBM
 eTL4us5tm7LRnl6OnuCPM6zEd8Jpmu5hE03WAbKIeo73knzQR7JhN8NFJGV1Po0qc1sN
 vZBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780201262; x=1780806062;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JiiPkeoMJ4Jc/9aZR8aKRB6k0a4QjjU+NTYAU5WxdJ0=;
 b=yuYvzVrtIMs7sHg0UE4HHk7HhsjrZ8hYatOWnEoPZcZYwwWn6Rgi42lUG7O51ap4p6
 9rWmNItKLrAiORjexl23z7vSAPHxKkM3cg0rRTyl9dF5aINPH9eCFHJjqc8MigGTMAV9
 MMAYvnMwM2rd+Y4eK5OpBurD8OhCpdUZ2FX2T1mju8I8JIcVf761U8FJcIAxLJYQsot9
 /cJed8k7MuKvcLy6mTvYklPXBte0LH23djMSqPOs5qKPZ9dnhTNWVZdD/x1dfnOLdMuR
 z/acwmOFHneR6OmTd9xpS/iCZB8i7cd4X+78YbfXuXidDMAKrRetonROJcAnMfRBvkN3
 544g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780201262; x=1780806062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JiiPkeoMJ4Jc/9aZR8aKRB6k0a4QjjU+NTYAU5WxdJ0=;
 b=hsXeVr0udAIe3pzToirdUK1LBBiNUBrWKo+PUKne2WFq9xCPjQj1MczL+66490Im8c
 L5r21RlrUR5Zg3qJnvp8TJJcQGOPVrGzZa0bj9bDl30D8TC2PiBwLLDxHUCT+Jl+3eJf
 D5Dwgtd8v1tS6/ijPP5B1GdTV1LQqLK5NVmqbjj1YRnDpOgg49/9uV+IsybqjFPH+alg
 hfOEH8R2f0iejh1nqhnr+75co+CzCEecQFJyNLswnWoaqIqAOCZUr9iXv9/Q8sf6G/jz
 qh8GaCd4pGbDUv1zCnlPVLsWl8SI8mVGpsNIbuT0nktVRBPIPRxMJm/tbOnjj+aiXoKS
 3MwQ==
X-Gm-Message-State: AOJu0YzZ+bQNHMfEFOV21DTYCaVjF6qNjAUD+cf/nTvOw/uD5olOBiPH
 TrOi9JWBozkdGts1gr2Liifaif8ZPVlfRhNiojKHRfaJCkv5O3EoTyu9/+eMx5v1CuKus99G1Zr
 PAoAhcQUgc3UAyVgcRm65UlDJUOaaCZqO925MyIUP7AqhnXY3cDAr
X-Gm-Gg: Acq92OGrxIvSAdgwuCvcCSjDUevS0GPLlaEqx3Wm8GbpP2BO99rqkE00MgQ77hrxYft
 aKKWuuJ0nl9BHlPiVCx8SFiNJtV4ay1wJyCDKR5acCgs3k9BQEmeSltW6gI7rImKdKhdONASoAx
 IINvM7Vng8Xdkr57lvnuaycGJpveZ7chro0wnEKrOfWywixmLAlrQtHoP7jvw1fi3N5uWgaFfHl
 2cPIu8uEOBgyUPiyGB+dy1R0f2z9Yu/Q0hR0EPrvFsojl6CaLw8m+CjiE1xxWEHHBAtuZWxPxkB
 1V1SznWXfp/Wm2eA98uiKBR75E01nU41A+Zbq0VxdJO9CKY=
X-Received: by 2002:a05:6a21:7a4a:b0:398:78c0:6dca with SMTP id
 adf61e73a8af0-3b427eb09eemr5864971637.15.1780201261672; Sat, 30 May 2026
 21:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-7-richard.henderson@linaro.org>
In-Reply-To: <20260530211248.375318-7-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 30 May 2026 22:20:50 -0600
X-Gm-Features: AVHnY4JxLNoZswjdpa4S79of9awLcAGetAzLXVgwYk-UHR_6BFcXJPjosN1Dc50
Message-ID: <CANCZdfpyJPbcOGhKHU9_hHZ-Y1c13PJzicxOmnxUzoEPwYQA0g@mail.gmail.com>
Subject: Re: [PATCH 06/13] common-user: Move mmap_min_addr from linux-user
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="000000000000d4b759065315672f"
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x632.google.com
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

--000000000000d4b759065315672f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:12=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Introduce user/mmap-min-addr.h.  Initialize the variable
> from a constructor instead of main.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/user/mmap-min-addr.h | 12 ++++++++++++
>  linux-user/user-internals.h  |  1 -
>  common-user/mmap-min-addr.c  | 37 ++++++++++++++++++++++++++++++++++++
>  linux-user/elfload.c         |  1 +
>  linux-user/main.c            | 33 +++-----------------------------
>  linux-user/mmap.c            |  1 +
>  common-user/meson.build      |  1 +
>  7 files changed, 55 insertions(+), 31 deletions(-)
>  create mode 100644 include/user/mmap-min-addr.h
>  create mode 100644 common-user/mmap-min-addr.c
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/include/user/mmap-min-addr.h b/include/user/mmap-min-addr.h
> new file mode 100644
> index 0000000000..ded0b6909d
> --- /dev/null
> +++ b/include/user/mmap-min-addr.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef USER_MMAP_MIN_ADDR_H
> +#define USER_MMAP_MIN_ADDR_H
> +
> +#ifndef CONFIG_USER_ONLY
> +#error Cannot include this header from system emulation
> +#endif
> +
> +extern uintptr_t mmap_min_addr;
> +
> +#endif
> diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> index 3f41d3f33c..bc6b9f44e6 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -29,7 +29,6 @@ void init_task_state(TaskState *ts);
>  void task_settid(TaskState *);
>  void stop_all_tasks(void);
>  extern const char *qemu_uname_release;
> -extern unsigned long mmap_min_addr;
>
>  typedef struct IOCTLEntry IOCTLEntry;
>
> diff --git a/common-user/mmap-min-addr.c b/common-user/mmap-min-addr.c
> new file mode 100644
> index 0000000000..b2b3762386
> --- /dev/null
> +++ b/common-user/mmap-min-addr.c
> @@ -0,0 +1,37 @@
> +/*
> + * Utility function to get the minimum mmap address.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "user/mmap-min-addr.h"
> +
> +uintptr_t mmap_min_addr;
> +
> +static void __attribute__((constructor)) init(void)
> +{
> +#ifdef __linux__
> +    /*
> +     * We prefer to not make NULL pointers accessible to QEMU.
> +     * If something goes wrong below, fall back to 1 page.
> +     */
> +    size_t min_addr =3D qemu_real_host_page_size();
> +    /*
> +     * Read in mmap_min_addr kernel parameter.  This value is used
> +     * When loading the ELF image to determine whether guest_base
> +     * is needed.  It is also used in mmap_find_vma.
> +     */
> +    FILE *fp =3D fopen("/proc/sys/vm/mmap_min_addr", "r");
> +
> +    if (fp) {
> +        unsigned long tmp;
> +        if (fscanf(fp, "%lu", &tmp) =3D=3D 1 && tmp !=3D 0) {
> +            min_addr =3D MAX(min_addr, tmp);
> +        }
> +        fclose(fp);
> +    }
> +    mmap_min_addr =3D min_addr;
> +#else
> +# error
> +#endif
> +}
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 5a30cebcc3..93ab2661e3 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -14,6 +14,7 @@
>  #include "exec/translation-block.h"
>  #include "exec/tswap.h"
>  #include "user/guest-base.h"
> +#include "user/mmap-min-addr.h"
>  #include "user-internals.h"
>  #include "signal-common.h"
>  #include "loader.h"
> diff --git a/linux-user/main.c b/linux-user/main.c
> index c08c73fd80..01cf5bf079 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -39,6 +39,7 @@
>  #include "qemu/module.h"
>  #include "qemu/plugin.h"
>  #include "user/guest-base.h"
> +#include "user/mmap-min-addr.h"
>  #include "user/page-protection.h"
>  #include "exec/gdbstub.h"
>  #include "gdbstub/user.h"
> @@ -78,7 +79,6 @@ static envlist_t *envlist;
>  static const char *cpu_model;
>  static const char *cpu_type;
>  static const char *seed_optarg;
> -unsigned long mmap_min_addr;
>  uintptr_t guest_base;
>  bool have_guest_base;
>
> @@ -914,35 +914,8 @@ int main(int argc, char **argv, char **envp)
>      target_environ =3D envlist_to_environ(envlist, NULL);
>      envlist_free(envlist);
>
> -    /*
> -     * Read in mmap_min_addr kernel parameter.  This value is used
> -     * When loading the ELF image to determine whether guest_base
> -     * is needed.  It is also used in mmap_find_vma.
> -     */
> -    {
> -        FILE *fp;
> -
> -        if ((fp =3D fopen("/proc/sys/vm/mmap_min_addr", "r")) !=3D NULL)=
 {
> -            unsigned long tmp;
> -            if (fscanf(fp, "%lu", &tmp) =3D=3D 1 && tmp !=3D 0) {
> -                mmap_min_addr =3D MAX(tmp, host_page_size);
> -                qemu_log_mask(CPU_LOG_PAGE, "host mmap_min_addr=3D0x%lx\=
n",
> -                              mmap_min_addr);
> -            }
> -            fclose(fp);
> -        }
> -    }
> -
> -    /*
> -     * We prefer to not make NULL pointers accessible to QEMU.
> -     * If we're in a chroot with no /proc, fall back to 1 page.
> -     */
> -    if (mmap_min_addr =3D=3D 0) {
> -        mmap_min_addr =3D host_page_size;
> -        qemu_log_mask(CPU_LOG_PAGE,
> -                      "host mmap_min_addr=3D0x%lx (fallback)\n",
> -                      mmap_min_addr);
> -    }
> +    qemu_log_mask(CPU_LOG_PAGE, "host mmap_min_addr=3D0x%" PRIxPTR "\n",
> +                  mmap_min_addr);
>
>      /*
>       * Prepare copy of argv vector for target.
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index b4b7b3e5cc..f81417182e 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -24,6 +24,7 @@
>  #include "exec/mmap-lock.h"
>  #include "qemu.h"
>  #include "user/page-protection.h"
> +#include "user/mmap-min-addr.h"
>  #include "user-internals.h"
>  #include "user-mmap.h"
>  #include "target_mman.h"
> diff --git a/common-user/meson.build b/common-user/meson.build
> index ac9de5b9e3..f9e2e83f9a 100644
> --- a/common-user/meson.build
> +++ b/common-user/meson.build
> @@ -5,6 +5,7 @@ endif
>  common_user_inc +=3D include_directories('host/' / host_arch)
>
>  user_ss.add(files(
> +  'mmap-min-addr.c',
>    'safe-syscall.S',
>    'safe-syscall-error.c',
>  ))
> --
> 2.43.0
>
>

--000000000000d4b759065315672f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 30,=
 2026 at 3:12=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Introduce user/mmap-min-add=
r.h.=C2=A0 Initialize the variable<br>
from a constructor instead of main.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0include/user/mmap-min-addr.h | 12 ++++++++++++<br>
=C2=A0linux-user/user-internals.h=C2=A0 |=C2=A0 1 -<br>
=C2=A0common-user/mmap-min-addr.c=C2=A0 | 37 ++++++++++++++++++++++++++++++=
++++++<br>
=C2=A0linux-user/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0linux-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 33 +++--=
---------------------------<br>
=C2=A0linux-user/mmap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 =
+<br>
=C2=A0common-user/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A07 files changed, 55 insertions(+), 31 deletions(-)<br>
=C2=A0create mode 100644 include/user/mmap-min-addr.h<br>
=C2=A0create mode 100644 common-user/mmap-min-addr.c<br></blockquote><div><=
br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com=
">imp@bsdimp.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
diff --git a/include/user/mmap-min-addr.h b/include/user/mmap-min-addr.h<br=
>
new file mode 100644<br>
index 0000000000..ded0b6909d<br>
--- /dev/null<br>
+++ b/include/user/mmap-min-addr.h<br>
@@ -0,0 +1,12 @@<br>
+/* SPDX-License-Identifier: GPL-2.0-or-later */<br>
+<br>
+#ifndef USER_MMAP_MIN_ADDR_H<br>
+#define USER_MMAP_MIN_ADDR_H<br>
+<br>
+#ifndef CONFIG_USER_ONLY<br>
+#error Cannot include this header from system emulation<br>
+#endif<br>
+<br>
+extern uintptr_t mmap_min_addr;<br>
+<br>
+#endif<br>
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h<br>
index 3f41d3f33c..bc6b9f44e6 100644<br>
--- a/linux-user/user-internals.h<br>
+++ b/linux-user/user-internals.h<br>
@@ -29,7 +29,6 @@ void init_task_state(TaskState *ts);<br>
=C2=A0void task_settid(TaskState *);<br>
=C2=A0void stop_all_tasks(void);<br>
=C2=A0extern const char *qemu_uname_release;<br>
-extern unsigned long mmap_min_addr;<br>
<br>
=C2=A0typedef struct IOCTLEntry IOCTLEntry;<br>
<br>
diff --git a/common-user/mmap-min-addr.c b/common-user/mmap-min-addr.c<br>
new file mode 100644<br>
index 0000000000..b2b3762386<br>
--- /dev/null<br>
+++ b/common-user/mmap-min-addr.c<br>
@@ -0,0 +1,37 @@<br>
+/*<br>
+ * Utility function to get the minimum mmap address.<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;user/mmap-min-addr.h&quot;<br>
+<br>
+uintptr_t mmap_min_addr;<br>
+<br>
+static void __attribute__((constructor)) init(void)<br>
+{<br>
+#ifdef __linux__<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* We prefer to not make NULL pointers accessible to QE=
MU.<br>
+=C2=A0 =C2=A0 =C2=A0* If something goes wrong below, fall back to 1 page.<=
br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 size_t min_addr =3D qemu_real_host_page_size();<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Read in mmap_min_addr kernel parameter.=C2=A0 This v=
alue is used<br>
+=C2=A0 =C2=A0 =C2=A0* When loading the ELF image to determine whether gues=
t_base<br>
+=C2=A0 =C2=A0 =C2=A0* is needed.=C2=A0 It is also used in mmap_find_vma.<b=
r>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 FILE *fp =3D fopen(&quot;/proc/sys/vm/mmap_min_addr&quot;, &=
quot;r&quot;);<br>
+<br>
+=C2=A0 =C2=A0 if (fp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long tmp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fscanf(fp, &quot;%lu&quot;, &amp;tmp) =3D=
=3D 1 &amp;&amp; tmp !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 min_addr =3D MAX(min_addr, tmp);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose(fp);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 mmap_min_addr =3D min_addr;<br>
+#else<br>
+# error<br>
+#endif<br>
+}<br>
diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>
index 5a30cebcc3..93ab2661e3 100644<br>
--- a/linux-user/elfload.c<br>
+++ b/linux-user/elfload.c<br>
@@ -14,6 +14,7 @@<br>
=C2=A0#include &quot;exec/translation-block.h&quot;<br>
=C2=A0#include &quot;exec/tswap.h&quot;<br>
=C2=A0#include &quot;user/guest-base.h&quot;<br>
+#include &quot;user/mmap-min-addr.h&quot;<br>
=C2=A0#include &quot;user-internals.h&quot;<br>
=C2=A0#include &quot;signal-common.h&quot;<br>
=C2=A0#include &quot;loader.h&quot;<br>
diff --git a/linux-user/main.c b/linux-user/main.c<br>
index c08c73fd80..01cf5bf079 100644<br>
--- a/linux-user/main.c<br>
+++ b/linux-user/main.c<br>
@@ -39,6 +39,7 @@<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;qemu/plugin.h&quot;<br>
=C2=A0#include &quot;user/guest-base.h&quot;<br>
+#include &quot;user/mmap-min-addr.h&quot;<br>
=C2=A0#include &quot;user/page-protection.h&quot;<br>
=C2=A0#include &quot;exec/gdbstub.h&quot;<br>
=C2=A0#include &quot;gdbstub/user.h&quot;<br>
@@ -78,7 +79,6 @@ static envlist_t *envlist;<br>
=C2=A0static const char *cpu_model;<br>
=C2=A0static const char *cpu_type;<br>
=C2=A0static const char *seed_optarg;<br>
-unsigned long mmap_min_addr;<br>
=C2=A0uintptr_t guest_base;<br>
=C2=A0bool have_guest_base;<br>
<br>
@@ -914,35 +914,8 @@ int main(int argc, char **argv, char **envp)<br>
=C2=A0 =C2=A0 =C2=A0target_environ =3D envlist_to_environ(envlist, NULL);<b=
r>
=C2=A0 =C2=A0 =C2=A0envlist_free(envlist);<br>
<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* Read in mmap_min_addr kernel parameter.=C2=A0 This v=
alue is used<br>
-=C2=A0 =C2=A0 =C2=A0* When loading the ELF image to determine whether gues=
t_base<br>
-=C2=A0 =C2=A0 =C2=A0* is needed.=C2=A0 It is also used in mmap_find_vma.<b=
r>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE *fp;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((fp =3D fopen(&quot;/proc/sys/vm/mmap_min_=
addr&quot;, &quot;r&quot;)) !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long tmp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fscanf(fp, &quot;%lu&quot;, =
&amp;tmp) =3D=3D 1 &amp;&amp; tmp !=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_min_addr =3D =
MAX(tmp, host_page_size);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(CPU_=
LOG_PAGE, &quot;host mmap_min_addr=3D0x%lx\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_min_addr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose(fp);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* We prefer to not make NULL pointers accessible to QE=
MU.<br>
-=C2=A0 =C2=A0 =C2=A0* If we&#39;re in a chroot with no /proc, fall back to=
 1 page.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 if (mmap_min_addr =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_min_addr =3D host_page_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_PAGE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;host mmap_min_addr=3D0x%lx (fallback)\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmap_min_addr);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_PAGE, &quot;host mmap_min_addr=3D0x%&q=
uot; PRIxPTR &quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_min_ad=
dr);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Prepare copy of argv vector for target.<br>
diff --git a/linux-user/mmap.c b/linux-user/mmap.c<br>
index b4b7b3e5cc..f81417182e 100644<br>
--- a/linux-user/mmap.c<br>
+++ b/linux-user/mmap.c<br>
@@ -24,6 +24,7 @@<br>
=C2=A0#include &quot;exec/mmap-lock.h&quot;<br>
=C2=A0#include &quot;qemu.h&quot;<br>
=C2=A0#include &quot;user/page-protection.h&quot;<br>
+#include &quot;user/mmap-min-addr.h&quot;<br>
=C2=A0#include &quot;user-internals.h&quot;<br>
=C2=A0#include &quot;user-mmap.h&quot;<br>
=C2=A0#include &quot;target_mman.h&quot;<br>
diff --git a/common-user/meson.build b/common-user/meson.build<br>
index ac9de5b9e3..f9e2e83f9a 100644<br>
--- a/common-user/meson.build<br>
+++ b/common-user/meson.build<br>
@@ -5,6 +5,7 @@ endif<br>
=C2=A0common_user_inc +=3D include_directories(&#39;host/&#39; / host_arch)=
<br>
<br>
=C2=A0user_ss.add(files(<br>
+=C2=A0 &#39;mmap-min-addr.c&#39;,<br>
=C2=A0 =C2=A0&#39;safe-syscall.S&#39;,<br>
=C2=A0 =C2=A0&#39;safe-syscall-error.c&#39;,<br>
=C2=A0))<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000d4b759065315672f--

