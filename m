Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C14BC2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 06:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRjJ-0003sq-Kp; Thu, 15 May 2025 02:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRjI-0003qf-4p
 for qemu-devel@nongnu.org; Thu, 15 May 2025 02:06:04 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRjG-0002tz-Dp
 for qemu-devel@nongnu.org; Thu, 15 May 2025 02:06:03 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-52c54b4d68bso168959e0c.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 23:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747289157; x=1747893957; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zOye18eDtHu/bi18IeVFGk7PweTozVAC9GpvdMdS7s=;
 b=R5rrODsSZENqcmmh9m8JnKSq29CNBFNecV8oMsxc5cfjdf2BbhZSD5BOkboc1/SFdu
 kgCvGOUlFujo0Bde6oJimQL63GEXLh8hI6IUfatuD8/vF7S4QO7LRgT9dhdkPATFZwa3
 NVl8bP+VlDm57oyfuapJH1qQeCzTAIsrlEWzjaRhZ6b16Y1nwkU97R6EKz0J3cSm5C9B
 DHGE2cX9CUtbuhOQi7gKE+rqdkXwUs62xe84tjnctj0ecNODH7XTG8YOhJu0o/gNyo6B
 y82yhdUsrBJrmEPeRzPO68atVo/S6mMcz6n5KoHmX8ZZutbKxAgijQcL8Cf5N+quWXOR
 zFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747289157; x=1747893957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8zOye18eDtHu/bi18IeVFGk7PweTozVAC9GpvdMdS7s=;
 b=N0ynGpbUA+5WKHfTcJfmMeKBCQLFsJcj2XuP700ea5nVENg3cKcaaAHWx/HuQkQ9gY
 JggBq0zz/GAuYxAFkBnQZSIfnn9P7IWbak7IfbEamXTbnwrqEdCLsB8ZsVvDaaJPNSRD
 BdOSJJvU8SMld7NwYVbLhfcaSMOy/pIO7VDEQsB7qwiL1c3oY48zps8hPhCtYW9PL5MY
 OmIqr2dGEWZFQmkPpZz4xe9uhksO3siSYlhxUD4SAsxCuLq7oXZ9QAV5Vc5CzM7Y8z+v
 2dCJnWpekUxIypNBq+Gg44IPwo6jA3O+1zgaiyXBD/2Tc2zl6wmh7Uw8CpoRvzjw1zIb
 rnSw==
X-Gm-Message-State: AOJu0YyGJwZc9M1F7bP7TCfrarcWul7yMVeW7fx7ouBp255wfv6fOsuH
 POo+bje7eaVo/aUnstuCt9/eFylU8fjXZjhYmgmePmF/Cku3R2a7n0AJdp7UdB3+s4GJb8UiOQM
 aRJPQylcCkjCsWehUwEQy3ctBD4M=
X-Gm-Gg: ASbGncvsvY56NtG5SjaCguv36ICPzOMrmifXZvZ+Ogrntx8fR1cxxnhx3XCq7rh9CY0
 9Hd2HrtYK6tey+iMExsGzFEigXWvJY6+63XbDDt1wXQSatl9QXngYerp7K1d86JZFUdPaKCs+cx
 uJAzA5oQ0oRa6uwT58Ai9ER2ZpMsuYKxM7ISd2XS3Qe2awtxHH/FhVJuLzRMPq6WA=
X-Google-Smtp-Source: AGHT+IEt9Q0QraLVHaOg0204w9boSmQae9hbdwJ2aSisGvUaBH5ZDxiA/WBNInkNp6sxzfIdjgTLrVxbRk+zHnP85r4=
X-Received: by 2002:a05:6122:a23:b0:529:2644:8c with SMTP id
 71dfb90a1353d-52dabf915e3mr842754e0c.8.1747289157622; Wed, 14 May 2025
 23:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 16:05:30 +1000
X-Gm-Features: AX0GCFtqkIoViQvhXqXHJmCwQ0Ye9U_mL9YzH2U5DcYaapropREE-M6DXbuRiyU
Message-ID: <CAKmqyKOomS2NsO=7V5AhxURjSMkEDiQ0k7t59KqYq=FqJDW=Rg@mail.gmail.com>
Subject: Re: [PATCH v5 00/26] target/riscv: SATP mode and CPU definition
 overhaul
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, May 12, 2025 at 7:53=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Same as v4, with suggestion from Richard to avoid parentheses---which als=
o
> fixes the issue with kvm-cpu.c reported by Daniel Barboza.  KVM/RISC-V is
> now covered in CI and passes with this version.
>
> Paolo
>
> Paolo Bonzini (26):
>   target/riscv: assert argument to set_satp_mode_max_supported is valid
>   target/riscv: cpu: store max SATP mode as a single integer
>   target/riscv: update max_satp_mode based on QOM properties
>   target/riscv: remove supported from RISCVSATPMap
>   target/riscv: move satp_mode.{map,init} out of CPUConfig
>   target/riscv: introduce RISCVCPUDef
>   target/riscv: store RISCVCPUDef struct directly in the class
>   target/riscv: merge riscv_cpu_class_init with the class_base function
>   target/riscv: move RISCVCPUConfig fields to a header file
>   target/riscv: include default value in cpu_cfg_fields.h.inc
>   target/riscv: add more RISCVCPUDef fields
>   target/riscv: convert abstract CPU classes to RISCVCPUDef
>   target/riscv: convert profile CPU models to RISCVCPUDef
>   target/riscv: convert bare CPU models to RISCVCPUDef
>   target/riscv: convert dynamic CPU models to RISCVCPUDef
>   target/riscv: convert SiFive E CPU models to RISCVCPUDef
>   target/riscv: convert ibex CPU models to RISCVCPUDef
>   target/riscv: convert SiFive U models to RISCVCPUDef
>   target/riscv: th: make CSR insertion test a bit more intuitive
>   target/riscv: generalize custom CSR functionality
>   target/riscv: convert TT C906 to RISCVCPUDef
>   target/riscv: convert TT Ascalon to RISCVCPUDef
>   target/riscv: convert Ventana V1 to RISCVCPUDef
>   target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
>   target/riscv: remove .instance_post_init
>   qom: reverse order of instance_post_init calls

This doesn't seem to have made it through to Patchew for some reason:
https://patchew.org/search?q=3DSATP+mode+and+CPU+definition+overhaul

Alistair

>
>  include/qom/object.h              |    3 +-
>  target/riscv/cpu-qom.h            |    2 +
>  target/riscv/cpu.h                |   42 +-
>  target/riscv/cpu_cfg.h            |  178 +----
>  target/riscv/cpu_cfg_fields.h.inc |  170 +++++
>  hw/riscv/boot.c                   |    2 +-
>  hw/riscv/virt-acpi-build.c        |   14 +-
>  hw/riscv/virt.c                   |    5 +-
>  qom/object.c                      |    8 +-
>  target/riscv/cpu.c                | 1014 +++++++++++++----------------
>  target/riscv/csr.c                |   11 +-
>  target/riscv/gdbstub.c            |    6 +-
>  target/riscv/kvm/kvm-cpu.c        |   27 +-
>  target/riscv/machine.c            |    2 +-
>  target/riscv/tcg/tcg-cpu.c        |   13 +-
>  target/riscv/th_csr.c             |   30 +-
>  target/riscv/translate.c          |    2 +-
>  17 files changed, 734 insertions(+), 795 deletions(-)
>  create mode 100644 target/riscv/cpu_cfg_fields.h.inc
>
> --
> 2.49.0
>

