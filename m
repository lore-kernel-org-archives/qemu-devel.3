Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A297CF6A80
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 08:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdlM7-000600-KD; Thu, 08 Jan 2026 03:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vdlM6-0005yy-5B
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:26:54 -0500
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vdlM4-00046W-MU
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:26:53 -0500
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-8907ec50855so30895126d6.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 00:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767860809; x=1768465609; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2X/0t+GD0P49YT5CQj4W4mS1CPEHkXOQaQyAY6I1A8=;
 b=O+iRt7SxDqOYadfuiZONDDPXr7ZzCV4NQr2dbteny1Saobcm2omRPplynINLS9l3er
 +LXyDDloPYx7urKFgNp6KT2iZzOy98XNmU1X3ffEbyrsPtyt50emYTup9TQDdWq0rVn0
 Cj8+KmbnT8X7+LgQKQNh94q140VojA9tgog8dMV++E1WnQRRp4nNJI+opGK602wWrKA7
 8wcZirKPQyEYpsQLMi90wm6hytwyTgW8TvlTgSCtmxVnH6Iun9vFSMIE4GUYrzQRaeG5
 65nF74iEZ9sTfti92zXvq+4Kmcik5PTmcozvCzN/Q9u9nZ9lqvBnXdzKux8I391VlOO0
 83cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767860809; x=1768465609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s2X/0t+GD0P49YT5CQj4W4mS1CPEHkXOQaQyAY6I1A8=;
 b=I+/xwy5EWi45B46oH+khYCygLUzyuTIGZqrmRjgjhUAdt+ru7LMaevqgbkVCySk/QO
 1re2vrzqHIY4NVDrkccfRKorP/OygSgSCxpQaWFWjleUzrQ+LKSvj627Csz7wQXjGRtE
 MZmu27lU/gKuuim079i/Ac5uBt/wVvF1oPCjnBDK00mkduBpJ5udhXjIHRfAvUCFXJlB
 aWOTO/vAGR5Fk1NQ0zXXY/xM2waeFqYy3XzRtqd4FYjeGSE3hJCa7YSyZ8mSOeNn+R4l
 m6cxsHDVLjrNpjroxFi/9EKxTUmqdDhQUtCM2DlkLCcsT4SdPd0Yr1ZI2D10aaQigPiR
 fmLA==
X-Gm-Message-State: AOJu0YytiSuhW2jVLm3sBpb8cbaqQyb/gS++Lgo1mjOhWOACYCkRXsv8
 AjKNCbU3KnfdOSvjIIXXp+2f25Qixz8vfCrfWqkFVHjEO6QVRTAqEoiGjX6kZSmvpkqAH4b3EO8
 c0WLVqZyVf1tJJYTjF6zRUWsUjQb55Lw=
X-Gm-Gg: AY/fxX4ZLpI2sxsI3/rQHz1UqnPNQanMwrHbXGjaVmWfdQpsYDa+4qDC5w2I8L5tuHH
 kWZ4zXmOP8oVMbZucP6hdeyg7n36QGPZvDl1BGXvAbKAKzHK7osCKH/Zi5cux91lhwWeqPUAloN
 pX4cWXHRELsjuJxMn31VFJx5hcQUfbbn9D2L3tlDlbgRQhzXZuDhb6iV4w/326r9PDlyXh7hKBk
 Si5ZJFDFOE+cyRFpekr+8/FGkn4JObd7L0k1XPI/ArR6d5I1EwR38jTvTjE3Bpx35lP84TXfRV7
 vl+4a8oacNNMuuEsIZ+8ldEIrFJU6pnjgGvXhQ==
X-Google-Smtp-Source: AGHT+IE2ITyRuhLkQNfSFf0ym/pR7I4ZtBx13/L/Jdqoeaha3v7RsVdIFSMX7HtRIotcJWPUP05KQeQOc+PQprH4VB8=
X-Received: by 2002:ad4:5ccc:0:b0:890:195c:9626 with SMTP id
 6a1803df08f44-890842935dfmr73272626d6.50.1767860808666; Thu, 08 Jan 2026
 00:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20260107180519.50820-1-philmd@linaro.org>
 <20260107180519.50820-3-philmd@linaro.org>
In-Reply-To: <20260107180519.50820-3-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Jan 2026 12:26:37 +0400
X-Gm-Features: AQt7F2rH36qTl1gKUlfMSkZshU-s1aM57FmJcC9Ez35KZLSuWzNjXiAhBtZUNgU
Message-ID: <CAJ+F1CLbggv90Dk7+nrqGVh+1G66s-Qr+dk5xKpT_6zOM-gmbw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dump/win_dump: Use stubs on non-Windows hosts like
 POSIX
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf2e.google.com
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

Hi

On Wed, Jan 7, 2026 at 10:08=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Rather than compiling the same content for all targets (unused
> most of the time, i.e. qemu-system-avr ...), build it once per
> POSIX hosts. Check Windows host (less likely) before x86 host.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  dump/win_dump-stubs.c | 21 +++++++++++++++++++++
>  dump/win_dump.c       | 12 ++++++++----
>  dump/meson.build      |  6 +++++-
>  3 files changed, 34 insertions(+), 5 deletions(-)
>  create mode 100644 dump/win_dump-stubs.c
>
> diff --git a/dump/win_dump-stubs.c b/dump/win_dump-stubs.c
> new file mode 100644
> index 00000000000..722c66740a2
> --- /dev/null
> +++ b/dump/win_dump-stubs.c
> @@ -0,0 +1,21 @@
> +/*
> + * Windows crashdump stubs
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "win_dump.h"
> +
> +bool win_dump_available(Error **errp)
> +{
> +    error_setg(errp, "Windows dump is only available on Windows");
> +
> +    return false;
> +}
> +
> +void create_win_dump(DumpState *s, Error **errp)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/dump/win_dump.c b/dump/win_dump.c
> index 6e07913dfb4..5b2b55d9ff7 100644
> --- a/dump/win_dump.c
> +++ b/dump/win_dump.c
> @@ -12,14 +12,16 @@
>  #include "system/dump.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> +#include "win_dump.h"
> +
> +#ifdef CONFIG_WIN32

Why check CONFIG_WIN32 in a windows-only file?

> +#if defined(TARGET_X86_64)
> +
>  #include "exec/cpu-defs.h"
>  #include "hw/core/cpu.h"
>  #include "qemu/win_dump_defs.h"
> -#include "win_dump.h"
>  #include "cpu.h"
>
> -#if defined(TARGET_X86_64)
> -
>  bool win_dump_available(Error **errp)
>  {
>      return true;
> @@ -478,7 +480,9 @@ out_cr3:
>      first_x86_cpu->env.cr[3] =3D saved_cr3;
>  }
>
> -#else /* !TARGET_X86_64 */
> +#endif /* !TARGET_X86_64 */
> +
> +#else /* !CONFIG_WIN32 */
>
>  bool win_dump_available(Error **errp)
>  {
> diff --git a/dump/meson.build b/dump/meson.build
> index 4277ce9328a..0aaf3f65d9c 100644
> --- a/dump/meson.build
> +++ b/dump/meson.build
> @@ -1,2 +1,6 @@
>  system_ss.add([files('dump.c', 'dump-hmp-cmds.c'), snappy, lzo])
> -specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: files('win_dump.c')=
)
> +if host_os =3D=3D 'windows'
> +  system_ss.add(files('win_dump.c'))
> +else
> +  system_ss.add(files('win_dump-stubs.c'))
> +endif
> --
> 2.52.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

