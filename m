Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B151DD29C37
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 15:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqtT-0001z4-Cv; Mon, 19 Jan 2026 10:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vhqtQ-0001yN-P1
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 10:10:12 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vhqtN-0004gx-Ju
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 10:10:12 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7f89d0b37f0so2576947b3a.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 07:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1768835408; x=1769440208;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wRtSn2G0S3drQhF9FPIWGhoT23EyAVDQ4Ia0tZ5vJek=;
 b=ajDbAAd2O8147qOWxIbUxFbhUhwZBdM+AmcmcTl7a+54NcToUMn0dbpH5XuvTcCsXl
 WfQDuJRMTiLxV48/amyc8nsFfCXSnmJya4dhol0jrEFXncK6WP/jb6dWTNdo65Z8g1za
 VZEC2+IBV+YGSxR2RRw2FEU23zJHBZIohDmT7UH9NgkMas1+OHK/iKFHSof/z++8s5uc
 3HFH6Uaw5s2rQgXWtsWlFTw4fOlYNnCfWzaDI8FNdjKp2jZpBGUJnLoWXyGOIEK2CBPN
 +pTnwR4cTaflcYBTWmZ4tn60cf/U8I+r7HpbsnK9h2Mj8PcfIF+fF8/f9fsiOj+skIEB
 Wv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768835408; x=1769440208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRtSn2G0S3drQhF9FPIWGhoT23EyAVDQ4Ia0tZ5vJek=;
 b=w/Y2xDnAQ+IMIxhhDcpWzfJfzU3FKtRphmC759R0PnIG/q6I1VGgLEJvRFbuymzLdM
 JclT5q8iVoksSGet7iNhr71HptD/WghDot2WpiPW8cxtoK1S9hLZ1ddTK8Yu25NoRPYX
 tI+MlQDi6fottyX26DkI8XBcmlmG+GpqTzdpPVKX6dEDW5pbZ2wN46lKTZ/sUEorsHAF
 mDkZZ0eGwudtX8NMBKNG081TolWvahFBWDfj963pu/uUa1L2vt0wHjAVCG3Ms0kUi4sY
 oQ1hstb4sibPsq9e+ZKjd6aVZbAApBKTnpLt351HhPZsZkh1Hbu2l84iPBZYHEwtYczV
 UZ7Q==
X-Gm-Message-State: AOJu0YxD8EpzS2fJYBSgVBbO4GLHfsgbhH3EURPXp1eoLzz+z+bKcIom
 2rulHEbDKhfWha0/7Jg4vW0B7jtsctKpEFOXb7hwPqeLJ1dT2kyPdM4cHJppB6jgQ0U113T6Zoc
 G37hdKGfpmo6MfJm9UGZDuwa9NrnfDS52KX4ZlY/e+w==
X-Gm-Gg: AY/fxX5E9sptmzuCPtUyuMvCCOVj4Agds8g1xeRWbrdA0PAmHOoQ/xFmrN4GippoQTf
 9p7uG+XKbR1g0xzfMKadXpde3aED4tEHfwQ2BBnCqJjcMNLgPgbYfgV0Pi6i7n3a6AtbEYfGsKE
 kTJPO5CebgYoi2rU5SzBf/UE/TgYCWj09sN2IuaDDGnpcn3ImHovTBOh6ScOnk1pLcbTzHMnvJ2
 X1xYbw3+fqKUuf1Q0HHhiPvoma0vcs9q2WV/QM0nBLmrSAbou6iSVp6Ciaf5FKma7Frlxw=
X-Received: by 2002:a05:6a20:a123:b0:366:14b0:4b1a with SMTP id
 adf61e73a8af0-38dff3d3bb2mr11606025637.37.1768835407732; Mon, 19 Jan 2026
 07:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20260119100537.463312-1-armbru@redhat.com>
 <20260119100537.463312-4-armbru@redhat.com>
In-Reply-To: <20260119100537.463312-4-armbru@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 19 Jan 2026 08:09:56 -0700
X-Gm-Features: AZwV_QiBS6cjq3c3BPld1P124beZUxl0WdlvMqFbQAoctAojmI7AgEw3YMVEnDk
Message-ID: <CANCZdfoT5gRbqpb8JZf=aYGo37pBMAYJFVQg8k8P1yEMLDtKZA@mail.gmail.com>
Subject: Re: [PATCH 3/5] Clean up ill-advised or unusual header guards
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000024f0b80648bf16d9"
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x430.google.com
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

--00000000000024f0b80648bf16d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The bsd-user header

Reviewed-by: Warner Losh. <imp@bsdimp.com>

Seems like needless churn, though. Better to use #pragma once
everywhere instead. There's no varadic include files in the tree as
far as I recall...

Warner

On Mon, Jan 19, 2026 at 3:07=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Leading underscores are ill-advised because such identifiers are
> reserved.  Trailing underscores are merely ugly.  Strip both.
>
> Our header guards commonly end in _H.  Normalize the exceptions.
>
> Macros should be ALL_CAPS.  Normalize the exception.
>
> Done with scripts/clean-header-guards.pl.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  backends/tpm/tpm_ioctl.h             | 7 ++++---
>  bsd-user/bsd-proc.h                  | 6 +++---
>  hw/net/igb_regs.h                    | 4 ++--
>  include/exec/target_long.h           | 6 +++---
>  include/exec/tb-flush.h              | 7 ++++---
>  include/gdbstub/helpers.h            | 6 +++---
>  include/gdbstub/syscalls.h           | 6 +++---
>  include/hw/arm/raspberrypi-fw-defs.h | 7 +++----
>  include/hw/arm/stm32l4x5_soc.h       | 4 ++--
>  include/hw/gpio/pcf8574.h            | 6 +++---
>  include/hw/virtio/vhost-user-gpio.h  | 6 +++---
>  include/hw/virtio/vhost-user-scmi.h  | 6 +++---
>  include/hw/xen/xen-pvh-common.h      | 4 ++--
>  include/tcg/insn-start-words.h       | 6 +++---
>  qga/cutils.h                         | 6 +++---
>  15 files changed, 44 insertions(+), 43 deletions(-)
>
> diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
> index ee2dd15d35..e1e858c4bc 100644
> --- a/backends/tpm/tpm_ioctl.h
> +++ b/backends/tpm/tpm_ioctl.h
> @@ -5,8 +5,9 @@
>   *
>   * This file is licensed under the terms of the 3-clause BSD license
>   */
> -#ifndef _TPM_IOCTL_H_
> -#define _TPM_IOCTL_H_
> +
> +#ifndef TPM_IOCTL_H
> +#define TPM_IOCTL_H
>
>  #if defined(__CYGWIN__)
>  # define __USE_LINUX_IOCTL_DEFS
> @@ -341,4 +342,4 @@ enum {
>      CMD_LOCK_STORAGE,         /* 0x13 */
>  };
>
> -#endif /* _TPM_IOCTL_H_ */
> +#endif /* TPM_IOCTL_H */
> diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
> index 8b1c2deea3..8b7bd492ba 100644
> --- a/bsd-user/bsd-proc.h
> +++ b/bsd-user/bsd-proc.h
> @@ -17,8 +17,8 @@
>   *  along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>
> -#ifndef BSD_PROC_H_
> -#define BSD_PROC_H_
> +#ifndef BSD_PROC_H
> +#define BSD_PROC_H
>
>  #include <sys/resource.h>
>
> @@ -411,4 +411,4 @@ static inline abi_long do_bsd_setpriority(abi_long
> which, abi_long who,
>      return get_errno(setpriority(which, who, prio));
>  }
>
> -#endif /* !BSD_PROC_H_ */
> +#endif /* BSD_PROC_H */
> diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
> index 4dc4c31da2..3b135feef2 100644
> --- a/hw/net/igb_regs.h
> +++ b/hw/net/igb_regs.h
> @@ -4,8 +4,8 @@
>   * drivers/net/ethernet/intel/igb
>   */
>
> -#ifndef HW_IGB_REGS_H_
> -#define HW_IGB_REGS_H_
> +#ifndef HW_IGB_REGS_H
> +#define HW_IGB_REGS_H
>
>  #include "e1000x_regs.h"
>
> diff --git a/include/exec/target_long.h b/include/exec/target_long.h
> index 3cd8e26a23..db335ebb0b 100644
> --- a/include/exec/target_long.h
> +++ b/include/exec/target_long.h
> @@ -7,8 +7,8 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>
> -#ifndef _TARGET_LONG_H_
> -#define _TARGET_LONG_H_
> +#ifndef TARGET_LONG_H
> +#define TARGET_LONG_H
>
>  /*
>   * Usually this should only be included via cpu-defs.h however for
> @@ -41,4 +41,4 @@ typedef uint64_t target_ulong;
>  #error TARGET_LONG_SIZE undefined
>  #endif
>
> -#endif /* _TARGET_LONG_H_ */
> +#endif /* TARGET_LONG_H */
> diff --git a/include/exec/tb-flush.h b/include/exec/tb-flush.h
> index e971d4ba6d..76f51094e6 100644
> --- a/include/exec/tb-flush.h
> +++ b/include/exec/tb-flush.h
> @@ -5,8 +5,9 @@
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -#ifndef _TB_FLUSH_H_
> -#define _TB_FLUSH_H_
> +
> +#ifndef TB_FLUSH_H
> +#define TB_FLUSH_H
>
>  /**
>   * tb_flush__exclusive_or_serial()
> @@ -35,4 +36,4 @@ void queue_tb_flush(CPUState *cs);
>
>  void tcg_flush_jmp_cache(CPUState *cs);
>
> -#endif /* _TB_FLUSH_H_ */
> +#endif /* TB_FLUSH_H */
> diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
> index 197592036b..806195458f 100644
> --- a/include/gdbstub/helpers.h
> +++ b/include/gdbstub/helpers.h
> @@ -9,8 +9,8 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>
> -#ifndef _GDBSTUB_HELPERS_H_
> -#define _GDBSTUB_HELPERS_H_
> +#ifndef GDBSTUB_HELPERS_H
> +#define GDBSTUB_HELPERS_H
>
>  #include "qemu/bswap.h"
>  #include "qemu/target-info.h"
> @@ -115,4 +115,4 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray
> *buf, int len)
>  #endif
>  #endif /* COMPILING_PER_TARGET */
>
> -#endif /* _GDBSTUB_HELPERS_H_ */
> +#endif /* GDBSTUB_HELPERS_H */
> diff --git a/include/gdbstub/syscalls.h b/include/gdbstub/syscalls.h
> index d63228e96b..070b165b42 100644
> --- a/include/gdbstub/syscalls.h
> +++ b/include/gdbstub/syscalls.h
> @@ -6,8 +6,8 @@
>   * SPDX-License-Identifier: LGPL-2.0-or-later
>   */
>
> -#ifndef _SYSCALLS_H_
> -#define _SYSCALLS_H_
> +#ifndef SYSCALLS_H
> +#define SYSCALLS_H
>
>  /* For gdb file i/o remote protocol open flags. */
>  #define GDB_O_RDONLY  0
> @@ -119,4 +119,4 @@ void gdb_exit(int code);
>   */
>  void gdb_qemu_exit(int code);
>
> -#endif /* _SYSCALLS_H_ */
> +#endif /* SYSCALLS_H */
> diff --git a/include/hw/arm/raspberrypi-fw-defs.h
> b/include/hw/arm/raspberrypi-fw-defs.h
> index 60b8e5b451..906de53379 100644
> --- a/include/hw/arm/raspberrypi-fw-defs.h
> +++ b/include/hw/arm/raspberrypi-fw-defs.h
> @@ -7,9 +7,8 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>
> -#ifndef INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_
> -#define INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_
> -
> +#ifndef INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H
> +#define INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H
>
>  enum rpi_firmware_property_tag {
>      RPI_FWREQ_PROPERTY_END =3D                           0,
> @@ -172,4 +171,4 @@ typedef struct rpi_firmware_prop_request {
>      uint8_t payload[0];
>  } rpi_firmware_prop_request_t;
>
> -#endif /* INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_ */
> +#endif /* INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H */
> diff --git a/include/hw/arm/stm32l4x5_soc.h
> b/include/hw/arm/stm32l4x5_soc.h
> index 9c3d662bca..cc61d582cb 100644
> --- a/include/hw/arm/stm32l4x5_soc.h
> +++ b/include/hw/arm/stm32l4x5_soc.h
> @@ -21,8 +21,8 @@
>   *
> https://www.st.com/en/microcontrollers-microprocessors/stm32l4x5/document=
ation.html
>   */
>
> -#ifndef HW_ARM_STM32L4x5_SOC_H
> -#define HW_ARM_STM32L4x5_SOC_H
> +#ifndef HW_ARM_STM32L4X5_SOC_H
> +#define HW_ARM_STM32L4X5_SOC_H
>
>  #include "system/memory.h"
>  #include "hw/arm/armv7m.h"
> diff --git a/include/hw/gpio/pcf8574.h b/include/hw/gpio/pcf8574.h
> index 3291d7dbbc..9f46cf7167 100644
> --- a/include/hw/gpio/pcf8574.h
> +++ b/include/hw/gpio/pcf8574.h
> @@ -7,9 +7,9 @@
>   * Written by Dmitrii Sharikhin <d.sharikhin@yadro.com>
>   */
>
> -#ifndef _HW_GPIO_PCF8574
> -#define _HW_GPIO_PCF8574
> +#ifndef HW_GPIO_PCF8574_H
> +#define HW_GPIO_PCF8574_H
>
>  #define TYPE_PCF8574 "pcf8574"
>
> -#endif /* _HW_GPIO_PCF8574 */
> +#endif /* HW_GPIO_PCF8574_H */
> diff --git a/include/hw/virtio/vhost-user-gpio.h
> b/include/hw/virtio/vhost-user-gpio.h
> index 5814a8400a..4e50f45066 100644
> --- a/include/hw/virtio/vhost-user-gpio.h
> +++ b/include/hw/virtio/vhost-user-gpio.h
> @@ -6,8 +6,8 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>
> -#ifndef _QEMU_VHOST_USER_GPIO_H
> -#define _QEMU_VHOST_USER_GPIO_H
> +#ifndef QEMU_VHOST_USER_GPIO_H
> +#define QEMU_VHOST_USER_GPIO_H
>
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/vhost.h"
> @@ -21,4 +21,4 @@ struct VHostUserGPIO {
>      VHostUserBase parent_obj;
>  };
>
> -#endif /* _QEMU_VHOST_USER_GPIO_H */
> +#endif /* QEMU_VHOST_USER_GPIO_H */
> diff --git a/include/hw/virtio/vhost-user-scmi.h
> b/include/hw/virtio/vhost-user-scmi.h
> index 30ab0d7ab7..47bdde17ca 100644
> --- a/include/hw/virtio/vhost-user-scmi.h
> +++ b/include/hw/virtio/vhost-user-scmi.h
> @@ -6,8 +6,8 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>
> -#ifndef _QEMU_VHOST_USER_SCMI_H
> -#define _QEMU_VHOST_USER_SCMI_H
> +#ifndef QEMU_VHOST_USER_SCMI_H
> +#define QEMU_VHOST_USER_SCMI_H
>
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/vhost.h"
> @@ -28,4 +28,4 @@ struct VHostUserSCMI {
>      bool started_vu;
>  };
>
> -#endif /* _QEMU_VHOST_USER_SCMI_H */
> +#endif /* QEMU_VHOST_USER_SCMI_H */
> diff --git a/include/hw/xen/xen-pvh-common.h
> b/include/hw/xen/xen-pvh-common.h
> index 0ed07c5694..a1ec505518 100644
> --- a/include/hw/xen/xen-pvh-common.h
> +++ b/include/hw/xen/xen-pvh-common.h
> @@ -6,8 +6,8 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>
> -#ifndef XEN_PVH_COMMON_H__
> -#define XEN_PVH_COMMON_H__
> +#ifndef XEN_PVH_COMMON_H
> +#define XEN_PVH_COMMON_H
>
>  #include "system/memory.h"
>  #include "qom/object.h"
> diff --git a/include/tcg/insn-start-words.h
> b/include/tcg/insn-start-words.h
> index c52aec50a7..c2921c24bc 100644
> --- a/include/tcg/insn-start-words.h
> +++ b/include/tcg/insn-start-words.h
> @@ -4,9 +4,9 @@
>   * Copyright (c) 2008 Fabrice Bellard
>   */
>
> -#ifndef TCG_INSN_START_WORDS
> -#define TCG_INSN_START_WORDS
> +#ifndef TCG_INSN_START_WORDS_H
> +#define TCG_INSN_START_WORDS_H
>
>  #define INSN_START_WORDS 3
>
> -#endif /* TCG_INSN_START_WORDS */
> +#endif /* TCG_INSN_START_WORDS_H */
> diff --git a/qga/cutils.h b/qga/cutils.h
> index c1f2f4b17a..e6c73c8d83 100644
> --- a/qga/cutils.h
> +++ b/qga/cutils.h
> @@ -1,6 +1,6 @@
> -#ifndef CUTILS_H_
> -#define CUTILS_H_
> +#ifndef CUTILS_H
> +#define CUTILS_H
>
>  int qga_open_cloexec(const char *name, int flags, mode_t mode);
>
> -#endif /* CUTILS_H_ */
> +#endif /* CUTILS_H */
> --
> 2.52.0
>
>
>

--00000000000024f0b80648bf16d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The bsd-user header<div><br></div><div>Reviewed-by: Warner=
 Losh. &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><d=
iv><br></div><div>Seems like needless churn, though. Better to use #pragma =
once</div><div>everywhere instead. There&#39;s no varadic=C2=A0include file=
s in the tree as</div><div>far as I recall...</div><div><br></div><div>Warn=
er</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Jan 19, 2026 at 3:07=E2=80=AFAM Marku=
s Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Lead=
ing underscores are ill-advised because such identifiers are<br>
reserved.=C2=A0 Trailing underscores are merely ugly.=C2=A0 Strip both.<br>
<br>
Our header guards commonly end in _H.=C2=A0 Normalize the exceptions.<br>
<br>
Macros should be ALL_CAPS.=C2=A0 Normalize the exception.<br>
<br>
Done with scripts/<a href=3D"http://clean-header-guards.pl" rel=3D"noreferr=
er" target=3D"_blank">clean-header-guards.pl</a>.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0backends/tpm/tpm_ioctl.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 7 ++++---<br>
=C2=A0bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 6 +++---<br>
=C2=A0hw/net/igb_regs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 4 ++--<br>
=C2=A0include/exec/target_long.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
6 +++---<br>
=C2=A0include/exec/tb-flush.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 7 ++++---<br>
=C2=A0include/gdbstub/helpers.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
6 +++---<br>
=C2=A0include/gdbstub/syscalls.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
6 +++---<br>
=C2=A0include/hw/arm/raspberrypi-fw-defs.h | 7 +++----<br>
=C2=A0include/hw/arm/stm32l4x5_soc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++--<br>
=C2=A0include/hw/gpio/pcf8574.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
6 +++---<br>
=C2=A0include/hw/virtio/vhost-user-gpio.h=C2=A0 | 6 +++---<br>
=C2=A0include/hw/virtio/vhost-user-scmi.h=C2=A0 | 6 +++---<br>
=C2=A0include/hw/xen/xen-pvh-common.h=C2=A0 =C2=A0 =C2=A0 | 4 ++--<br>
=C2=A0include/tcg/insn-start-words.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 6 +++---<b=
r>
=C2=A0qga/cutils.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 6 +++---<br>
=C2=A015 files changed, 44 insertions(+), 43 deletions(-)<br>
<br>
diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h<br>
index ee2dd15d35..e1e858c4bc 100644<br>
--- a/backends/tpm/tpm_ioctl.h<br>
+++ b/backends/tpm/tpm_ioctl.h<br>
@@ -5,8 +5,9 @@<br>
=C2=A0 *<br>
=C2=A0 * This file is licensed under the terms of the 3-clause BSD license<=
br>
=C2=A0 */<br>
-#ifndef _TPM_IOCTL_H_<br>
-#define _TPM_IOCTL_H_<br>
+<br>
+#ifndef TPM_IOCTL_H<br>
+#define TPM_IOCTL_H<br>
<br>
=C2=A0#if defined(__CYGWIN__)<br>
=C2=A0# define __USE_LINUX_IOCTL_DEFS<br>
@@ -341,4 +342,4 @@ enum {<br>
=C2=A0 =C2=A0 =C2=A0CMD_LOCK_STORAGE,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 0=
x13 */<br>
=C2=A0};<br>
<br>
-#endif /* _TPM_IOCTL_H_ */<br>
+#endif /* TPM_IOCTL_H */<br>
diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h<br>
index 8b1c2deea3..8b7bd492ba 100644<br>
--- a/bsd-user/bsd-proc.h<br>
+++ b/bsd-user/bsd-proc.h<br>
@@ -17,8 +17,8 @@<br>
=C2=A0 *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
=C2=A0 */<br>
<br>
-#ifndef BSD_PROC_H_<br>
-#define BSD_PROC_H_<br>
+#ifndef BSD_PROC_H<br>
+#define BSD_PROC_H<br>
<br>
=C2=A0#include &lt;sys/resource.h&gt;<br>
<br>
@@ -411,4 +411,4 @@ static inline abi_long do_bsd_setpriority(abi_long whic=
h, abi_long who,<br>
=C2=A0 =C2=A0 =C2=A0return get_errno(setpriority(which, who, prio));<br>
=C2=A0}<br>
<br>
-#endif /* !BSD_PROC_H_ */<br>
+#endif /* BSD_PROC_H */<br>
diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h<br>
index 4dc4c31da2..3b135feef2 100644<br>
--- a/hw/net/igb_regs.h<br>
+++ b/hw/net/igb_regs.h<br>
@@ -4,8 +4,8 @@<br>
=C2=A0 * drivers/net/ethernet/intel/igb<br>
=C2=A0 */<br>
<br>
-#ifndef HW_IGB_REGS_H_<br>
-#define HW_IGB_REGS_H_<br>
+#ifndef HW_IGB_REGS_H<br>
+#define HW_IGB_REGS_H<br>
<br>
=C2=A0#include &quot;e1000x_regs.h&quot;<br>
<br>
diff --git a/include/exec/target_long.h b/include/exec/target_long.h<br>
index 3cd8e26a23..db335ebb0b 100644<br>
--- a/include/exec/target_long.h<br>
+++ b/include/exec/target_long.h<br>
@@ -7,8 +7,8 @@<br>
=C2=A0 * SPDX-License-Identifier: GPL-2.0-or-later<br>
=C2=A0 */<br>
<br>
-#ifndef _TARGET_LONG_H_<br>
-#define _TARGET_LONG_H_<br>
+#ifndef TARGET_LONG_H<br>
+#define TARGET_LONG_H<br>
<br>
=C2=A0/*<br>
=C2=A0 * Usually this should only be included via cpu-defs.h however for<br=
>
@@ -41,4 +41,4 @@ typedef uint64_t target_ulong;<br>
=C2=A0#error TARGET_LONG_SIZE undefined<br>
=C2=A0#endif<br>
<br>
-#endif /* _TARGET_LONG_H_ */<br>
+#endif /* TARGET_LONG_H */<br>
diff --git a/include/exec/tb-flush.h b/include/exec/tb-flush.h<br>
index e971d4ba6d..76f51094e6 100644<br>
--- a/include/exec/tb-flush.h<br>
+++ b/include/exec/tb-flush.h<br>
@@ -5,8 +5,9 @@<br>
=C2=A0 *<br>
=C2=A0 * SPDX-License-Identifier: GPL-2.0-or-later<br>
=C2=A0 */<br>
-#ifndef _TB_FLUSH_H_<br>
-#define _TB_FLUSH_H_<br>
+<br>
+#ifndef TB_FLUSH_H<br>
+#define TB_FLUSH_H<br>
<br>
=C2=A0/**<br>
=C2=A0 * tb_flush__exclusive_or_serial()<br>
@@ -35,4 +36,4 @@ void queue_tb_flush(CPUState *cs);<br>
<br>
=C2=A0void tcg_flush_jmp_cache(CPUState *cs);<br>
<br>
-#endif /* _TB_FLUSH_H_ */<br>
+#endif /* TB_FLUSH_H */<br>
diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h<br>
index 197592036b..806195458f 100644<br>
--- a/include/gdbstub/helpers.h<br>
+++ b/include/gdbstub/helpers.h<br>
@@ -9,8 +9,8 @@<br>
=C2=A0 * SPDX-License-Identifier: GPL-2.0-or-later<br>
=C2=A0 */<br>
<br>
-#ifndef _GDBSTUB_HELPERS_H_<br>
-#define _GDBSTUB_HELPERS_H_<br>
+#ifndef GDBSTUB_HELPERS_H<br>
+#define GDBSTUB_HELPERS_H<br>
<br>
=C2=A0#include &quot;qemu/bswap.h&quot;<br>
=C2=A0#include &quot;qemu/target-info.h&quot;<br>
@@ -115,4 +115,4 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf,=
 int len)<br>
=C2=A0#endif<br>
=C2=A0#endif /* COMPILING_PER_TARGET */<br>
<br>
-#endif /* _GDBSTUB_HELPERS_H_ */<br>
+#endif /* GDBSTUB_HELPERS_H */<br>
diff --git a/include/gdbstub/syscalls.h b/include/gdbstub/syscalls.h<br>
index d63228e96b..070b165b42 100644<br>
--- a/include/gdbstub/syscalls.h<br>
+++ b/include/gdbstub/syscalls.h<br>
@@ -6,8 +6,8 @@<br>
=C2=A0 * SPDX-License-Identifier: LGPL-2.0-or-later<br>
=C2=A0 */<br>
<br>
-#ifndef _SYSCALLS_H_<br>
-#define _SYSCALLS_H_<br>
+#ifndef SYSCALLS_H<br>
+#define SYSCALLS_H<br>
<br>
=C2=A0/* For gdb file i/o remote protocol open flags. */<br>
=C2=A0#define GDB_O_RDONLY=C2=A0 0<br>
@@ -119,4 +119,4 @@ void gdb_exit(int code);<br>
=C2=A0 */<br>
=C2=A0void gdb_qemu_exit(int code);<br>
<br>
-#endif /* _SYSCALLS_H_ */<br>
+#endif /* SYSCALLS_H */<br>
diff --git a/include/hw/arm/raspberrypi-fw-defs.h b/include/hw/arm/raspberr=
ypi-fw-defs.h<br>
index 60b8e5b451..906de53379 100644<br>
--- a/include/hw/arm/raspberrypi-fw-defs.h<br>
+++ b/include/hw/arm/raspberrypi-fw-defs.h<br>
@@ -7,9 +7,8 @@<br>
=C2=A0 * SPDX-License-Identifier: GPL-2.0-or-later<br>
=C2=A0 */<br>
<br>
-#ifndef INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_<br>
-#define INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_<br>
-<br>
+#ifndef INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H<br>
+#define INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H<br>
<br>
=C2=A0enum rpi_firmware_property_tag {<br>
=C2=A0 =C2=A0 =C2=A0RPI_FWREQ_PROPERTY_END =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00,<br>
@@ -172,4 +171,4 @@ typedef struct rpi_firmware_prop_request {<br>
=C2=A0 =C2=A0 =C2=A0uint8_t payload[0];<br>
=C2=A0} rpi_firmware_prop_request_t;<br>
<br>
-#endif /* INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_ */<br>
+#endif /* INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H */<br>
diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_soc.=
h<br>
index 9c3d662bca..cc61d582cb 100644<br>
--- a/include/hw/arm/stm32l4x5_soc.h<br>
+++ b/include/hw/arm/stm32l4x5_soc.h<br>
@@ -21,8 +21,8 @@<br>
=C2=A0 * <a href=3D"https://www.st.com/en/microcontrollers-microprocessors/=
stm32l4x5/documentation.html" rel=3D"noreferrer" target=3D"_blank">https://=
www.st.com/en/microcontrollers-microprocessors/stm32l4x5/documentation.html=
</a><br>
=C2=A0 */<br>
<br>
-#ifndef HW_ARM_STM32L4x5_SOC_H<br>
-#define HW_ARM_STM32L4x5_SOC_H<br>
+#ifndef HW_ARM_STM32L4X5_SOC_H<br>
+#define HW_ARM_STM32L4X5_SOC_H<br>
<br>
=C2=A0#include &quot;system/memory.h&quot;<br>
=C2=A0#include &quot;hw/arm/armv7m.h&quot;<br>
diff --git a/include/hw/gpio/pcf8574.h b/include/hw/gpio/pcf8574.h<br>
index 3291d7dbbc..9f46cf7167 100644<br>
--- a/include/hw/gpio/pcf8574.h<br>
+++ b/include/hw/gpio/pcf8574.h<br>
@@ -7,9 +7,9 @@<br>
=C2=A0 * Written by Dmitrii Sharikhin &lt;<a href=3D"mailto:d.sharikhin@yad=
ro.com" target=3D"_blank">d.sharikhin@yadro.com</a>&gt;<br>
=C2=A0 */<br>
<br>
-#ifndef _HW_GPIO_PCF8574<br>
-#define _HW_GPIO_PCF8574<br>
+#ifndef HW_GPIO_PCF8574_H<br>
+#define HW_GPIO_PCF8574_H<br>
<br>
=C2=A0#define TYPE_PCF8574 &quot;pcf8574&quot;<br>
<br>
-#endif /* _HW_GPIO_PCF8574 */<br>
+#endif /* HW_GPIO_PCF8574_H */<br>
diff --git a/include/hw/virtio/vhost-user-gpio.h b/include/hw/virtio/vhost-=
user-gpio.h<br>
index 5814a8400a..4e50f45066 100644<br>
--- a/include/hw/virtio/vhost-user-gpio.h<br>
+++ b/include/hw/virtio/vhost-user-gpio.h<br>
@@ -6,8 +6,8 @@<br>
=C2=A0 * SPDX-License-Identifier: GPL-2.0-or-later<br>
=C2=A0 */<br>
<br>
-#ifndef _QEMU_VHOST_USER_GPIO_H<br>
-#define _QEMU_VHOST_USER_GPIO_H<br>
+#ifndef QEMU_VHOST_USER_GPIO_H<br>
+#define QEMU_VHOST_USER_GPIO_H<br>
<br>
=C2=A0#include &quot;hw/virtio/virtio.h&quot;<br>
=C2=A0#include &quot;hw/virtio/vhost.h&quot;<br>
@@ -21,4 +21,4 @@ struct VHostUserGPIO {<br>
=C2=A0 =C2=A0 =C2=A0VHostUserBase parent_obj;<br>
=C2=A0};<br>
<br>
-#endif /* _QEMU_VHOST_USER_GPIO_H */<br>
+#endif /* QEMU_VHOST_USER_GPIO_H */<br>
diff --git a/include/hw/virtio/vhost-user-scmi.h b/include/hw/virtio/vhost-=
user-scmi.h<br>
index 30ab0d7ab7..47bdde17ca 100644<br>
--- a/include/hw/virtio/vhost-user-scmi.h<br>
+++ b/include/hw/virtio/vhost-user-scmi.h<br>
@@ -6,8 +6,8 @@<br>
=C2=A0 * SPDX-License-Identifier: GPL-2.0-or-later<br>
=C2=A0 */<br>
<br>
-#ifndef _QEMU_VHOST_USER_SCMI_H<br>
-#define _QEMU_VHOST_USER_SCMI_H<br>
+#ifndef QEMU_VHOST_USER_SCMI_H<br>
+#define QEMU_VHOST_USER_SCMI_H<br>
<br>
=C2=A0#include &quot;hw/virtio/virtio.h&quot;<br>
=C2=A0#include &quot;hw/virtio/vhost.h&quot;<br>
@@ -28,4 +28,4 @@ struct VHostUserSCMI {<br>
=C2=A0 =C2=A0 =C2=A0bool started_vu;<br>
=C2=A0};<br>
<br>
-#endif /* _QEMU_VHOST_USER_SCMI_H */<br>
+#endif /* QEMU_VHOST_USER_SCMI_H */<br>
diff --git a/include/hw/xen/xen-pvh-common.h b/include/hw/xen/xen-pvh-commo=
n.h<br>
index 0ed07c5694..a1ec505518 100644<br>
--- a/include/hw/xen/xen-pvh-common.h<br>
+++ b/include/hw/xen/xen-pvh-common.h<br>
@@ -6,8 +6,8 @@<br>
=C2=A0 * SPDX-License-Identifier: GPL-2.0-or-later<br>
=C2=A0 */<br>
<br>
-#ifndef XEN_PVH_COMMON_H__<br>
-#define XEN_PVH_COMMON_H__<br>
+#ifndef XEN_PVH_COMMON_H<br>
+#define XEN_PVH_COMMON_H<br>
<br>
=C2=A0#include &quot;system/memory.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
diff --git a/include/tcg/insn-start-words.h b/include/tcg/insn-start-words.=
h<br>
index c52aec50a7..c2921c24bc 100644<br>
--- a/include/tcg/insn-start-words.h<br>
+++ b/include/tcg/insn-start-words.h<br>
@@ -4,9 +4,9 @@<br>
=C2=A0 * Copyright (c) 2008 Fabrice Bellard<br>
=C2=A0 */<br>
<br>
-#ifndef TCG_INSN_START_WORDS<br>
-#define TCG_INSN_START_WORDS<br>
+#ifndef TCG_INSN_START_WORDS_H<br>
+#define TCG_INSN_START_WORDS_H<br>
<br>
=C2=A0#define INSN_START_WORDS 3<br>
<br>
-#endif /* TCG_INSN_START_WORDS */<br>
+#endif /* TCG_INSN_START_WORDS_H */<br>
diff --git a/qga/cutils.h b/qga/cutils.h<br>
index c1f2f4b17a..e6c73c8d83 100644<br>
--- a/qga/cutils.h<br>
+++ b/qga/cutils.h<br>
@@ -1,6 +1,6 @@<br>
-#ifndef CUTILS_H_<br>
-#define CUTILS_H_<br>
+#ifndef CUTILS_H<br>
+#define CUTILS_H<br>
<br>
=C2=A0int qga_open_cloexec(const char *name, int flags, mode_t mode);<br>
<br>
-#endif /* CUTILS_H_ */<br>
+#endif /* CUTILS_H */<br>
-- <br>
2.52.0<br>
<br>
<br>
</blockquote></div>

--00000000000024f0b80648bf16d9--

