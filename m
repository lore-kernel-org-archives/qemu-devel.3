Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05328C47DB3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 00:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUcQC-0007n4-KX; Mon, 29 Jan 2024 19:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcQ9-0007kf-J6; Mon, 29 Jan 2024 19:56:13 -0500
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcQ6-0004yg-UB; Mon, 29 Jan 2024 19:56:13 -0500
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4bd9b71456fso589594e0c.2; 
 Mon, 29 Jan 2024 16:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706576168; x=1707180968; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aRw6jnCRjzD1gnHkyRcmhPH65k52Qp+1lLeCNAN+cho=;
 b=TVN8U00gQPTFHWNm0fGMEVSiH+j/BkHHwI4FuNqJVl4pQ4xpD9hJXPUEQcyJJdsO72
 j+MSK2vf83f0qiJx++9dVnxIbjMdhtWuVoyrAh7hDXGXU7FrH9hdWtwds8GALNscEUxV
 5Sf5am7bmTta8YmDbsDr5cCVfXDxEj/qdcJXpcIZ9mDC9XxkX3Z9vXyeO+CoBP0WXVbs
 h1Ngm8ZJMRihijoFuRYW2CwWM3VBRCQbwsvnCf2TPnnsGDe/GAtRc8SmFqvcr8IkHK4V
 J4EH5nqyPQnJpPyjOpeWxfjbsT0a+A06xq0FwQ21wq3tFOG0HNKSd8SXpYXblTcyncAt
 euTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706576168; x=1707180968;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aRw6jnCRjzD1gnHkyRcmhPH65k52Qp+1lLeCNAN+cho=;
 b=A7M7Jgy0rL/AjRLGHdEMmzlAVbtMCknRYa6JJfkokbVMjteGs/4ZlkmhjnqwlWZVxH
 na5TixALNdvSUZ/Rxb3GHUIDxwe2n1ud5gXxf8sWQyF6jEZMPd8/CJEYbx0wtVnRnVVa
 ltVJoNjL9vFZ7ynscIEG+0946hp99dsefZ7in1xx+l/7u/B3LShgmxrVviGE3lYd8+ya
 sTUQvNMHwm4OtLNG06NIt01xO2ferjEeKAqBbRIOVWu3GrgigLXnGMdBwGI96xRDpQdQ
 pPuXl409Ucbvr26d6UutmfHAm4e9Z0k8GsISHGSLHTEzgcs52ab09kyk7qSltsfaghOY
 6h4A==
X-Gm-Message-State: AOJu0YyEFxXwz0upD1+mvAMjAHCbZYCud4Te5rzaSbnsQLU0NP0qjV1m
 Ixnr5DilW7AZF7CkBagL3LjTTZHp2kts8BT2TsXpuvn7YdVbaRdEdYqeUsi8r4Xt/ldKhijDYqB
 AoAsIKfW0QFmJjEDqh7NwHvrNyhL8bp/LhQOXPw==
X-Google-Smtp-Source: AGHT+IEaw/SPAkGS5SGmDZXQCt0/Z56Gof16hNYLa0v7S4UvHOvOAsYij43AIKtgEie0MnD+u3hA4yoR4J7rKsr7nBQ=
X-Received: by 2002:a05:6122:4c1c:b0:4bf:d15b:ee3c with SMTP id
 ff28-20020a0561224c1c00b004bfd15bee3cmr1552469vkb.8.1706576168547; Mon, 29
 Jan 2024 16:56:08 -0800 (PST)
MIME-Version: 1.0
References: <20240128-riscv-v10-0-fdbe593976e9@daynix.com>
In-Reply-To: <20240128-riscv-v10-0-fdbe593976e9@daynix.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jan 2024 10:55:42 +1000
Message-ID: <CAKmqyKNFHnAv9axXXXZpf94XsCjCX2A_Js2seyfZUJe6Md-geQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/3] gdbstub and TCG plugin improvements
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov <a.anenkov@yadro.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Andrew Jones <ajones@ventanamicro.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Jan 28, 2024 at 6:29=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> This series extracts fixes and refactorings that can be applied
> independently from "[PATCH v9 00/23] plugins: Allow to read registers".
>
> The patch "target/riscv: Move MISA limits to class" was replaced with
> patch "target/riscv: Move misa_mxl_max to class" since I found instances
> may have different misa_ext_mask.

Do you mind rebasing this on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next ?

Alistair

>
> V6 -> V7:
>   Rebased.
>
> V5 -> V6:
>   Added patch "default-configs: Add TARGET_XML_FILES definition".
>   Rebased.
>
> V4 -> V5:
>   Added patch "hw/riscv: Use misa_mxl instead of misa_mxl_max".
>
> V3 -> V4:
>   Added patch "gdbstub: Check if gdb_regs is NULL".
>
> V2 -> V3:
>   Restored patch sets from the previous version.
>   Rebased to commit 800485762e6564e04e2ab315132d477069562d91.
>
> V1 -> V2:
>   Added patch "target/riscv: Do not allow MXL_RV32 for TARGET_RISCV64".
>   Added patch "target/riscv: Initialize gdb_core_xml_file only once".
>   Dropped patch "target/riscv: Remove misa_mxl validation".
>   Dropped patch "target/riscv: Move misa_mxl_max to class".
>   Dropped patch "target/riscv: Validate misa_mxl_max only once".
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v10:
> - Dropped patch "hw/riscv: Use misa_mxl instead of misa_mxl_max" due to
>   invalid assumption that the relevant code is only used for kernel
>   loading.
> - Link to v9: https://lore.kernel.org/r/20240115-riscv-v9-0-ff171e1aedc8@=
daynix.com
>
> Changes in v9:
> - Rebased to commit 977542ded7e6b28d2bc077bcda24568c716e393c.
> - Link to v8: https://lore.kernel.org/r/20231218-riscv-v8-0-c9bf2b1582d7@=
daynix.com
>
> Changes in v8:
> - Added a more detailed explanation for patch "hw/riscv: Use misa_mxl
>   instead of misa_mxl_max". (Alistair Francis)
> - Link to v7: https://lore.kernel.org/r/20231213-riscv-v7-0-a760156a337f@=
daynix.com
>
> ---
> Akihiko Odaki (3):
>       target/riscv: Remove misa_mxl validation
>       target/riscv: Move misa_mxl_max to class
>       target/riscv: Validate misa_mxl_max only once
>
>  target/riscv/cpu.h         |   4 +-
>  hw/riscv/boot.c            |   3 +-
>  target/riscv/cpu.c         | 183 ++++++++++++++++++++++++++-------------=
------
>  target/riscv/gdbstub.c     |  12 ++-
>  target/riscv/kvm/kvm-cpu.c |  10 +--
>  target/riscv/machine.c     |   7 +-
>  target/riscv/tcg/tcg-cpu.c |  44 ++---------
>  target/riscv/translate.c   |   3 +-
>  8 files changed, 135 insertions(+), 131 deletions(-)
> ---
> base-commit: 977542ded7e6b28d2bc077bcda24568c716e393c
> change-id: 20231213-riscv-fcc9640986cf
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>

