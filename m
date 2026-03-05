Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F8DEFCE5E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 03:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxzYo-0004dk-Lf; Wed, 04 Mar 2026 22:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxzYi-0004cH-Oc
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 22:39:33 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxzYf-0004CB-Rd
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 22:39:32 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b904e1cd038so1014474966b.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 19:39:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772681968; cv=none;
 d=google.com; s=arc-20240605;
 b=F6xfT7hvoDgFWDdedzHDaia+1AypO8nXyybDu8Lakcp9KPBHOxnxxFcM5gTHhubzwb
 +IeV7zKKAOV/YVgvDy0VbV4Rn05BfN5CQTAO682hf7YvNabK9vX5iiM+1YEWqDvtBe2D
 /wfmzxpeE8HY9q5b0F7ffd4f9huTHL2QDaB4dLN0N2b6o6v82zoy/vOZCJmiEmxqOC74
 XIaiLA27WEzUxbeUDEonvgCYA6Xb4h37WZVQWD26DwCps6Pq0/tMZxyEk5/omu3cLliY
 qpumtM3GX+QeHryFAsy5scesjZlPWXwESO0ROYp936MbuqVRbnsXvlA6+AI3pNWsotSz
 Zm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l08b++oja7YuBg+6RvJZfRAPXbC4PBaGiF1+T66frk4=;
 fh=bWymoCQQYbMHe/WVa4MGCVBkyVOUobjMdsRMeROUKP4=;
 b=UznvMjd8hjskHVvgmXFlTF0zOFFr8uFY5WhOVPUy2eMiLULKLD3Diyj8E2LkNdNQNA
 23r+cgbzokAzvYxjU6U73/6iXrOdt8UzcGWUXnrmX4fn5Typ+YEdvMZjHlhPbWTL9Ml5
 izpKPP7y5k27WLhUZ8pFRLPhoJrdUsDJ9aBcX4wWdC/adlPsc3KskyqocCv874mOj+US
 iyKmROhJcu14FntlBsc9olRms/X03q9N5VW+UGpPUca8wmHwAAAh9uviY45JtwAYAr8q
 IQonEOpoRTg/KUjThuDGChhpl/VCsO9Mjp7RoqS7/KecKz3PSZAjD+KNkt1FwfkDwluK
 Q5mA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772681968; x=1773286768; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l08b++oja7YuBg+6RvJZfRAPXbC4PBaGiF1+T66frk4=;
 b=ixnXYhmBDXU8JU4fF8iAWHlfdSAajU12eQP2i9MRYoPGxedXeTNSNwT5VEN1pL7mkl
 YZqSvpg8EPZrcCAkf93rf5EUpvzpnlaiDxybH79vnmkQ4FbrSZ6kfwOvup7tUgKyUq3X
 /OjrO7kWU6sV0la4ZUs6pV1iWpJBQCDCIFX3R2O3oLsuyDcIKPNsa1NRSSzeKkYiZVEj
 4GUKm5JHzogJ57O6UntXXBS0RBWHJV4VR3U27zfUIrKaukWaDl+LGjXUGmJEpTg/IUcs
 5fpfSRLnK8E0GWixOcGAmUueIYsSpp50VVmWArDp5JKlJCOlKPqva2NO0r6GCDieM92p
 UlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772681968; x=1773286768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l08b++oja7YuBg+6RvJZfRAPXbC4PBaGiF1+T66frk4=;
 b=aoAayojyAEvThFI02XX0X02iYg8+q36J7MRO8ofbZQL0FieLG2wn5rcHAFccDGKTat
 CllwGyHfsmhhbZ/BeAqrlm4q8Dtd7MFKcWM5b9mn+/EZasETnUqhGvQHREA1JObGaQ8+
 QHtzBO4OyOGzYwugIMtZU/Y9PuZu5PEAUlAHnlDlHwGjJgqyEBR4wJHT480GKdNGbbBd
 UZyp6qYMMiUQTnhuQ3CWCQCMhcjYpZNV+u31L3V0EBrnKMKtTx/iNbPuqOeara+QVNX7
 NajMOB/77bNQLD1oerEAOu/r6uh1FY4pIYMcUBQBw6nuPumWs6cucQcj8N492cfWh4AX
 natA==
X-Gm-Message-State: AOJu0YzQ7c+6QYbVfeB2Phq+/QHAfQUEwuS8iCsobSzJmFB1uF2A/SYK
 DMGQb+9f7MDOxANPJ/2mvtSW9dbqKkGvxhuephGPr7CbAeLl93Sv3qdA7y0PzyLMneuNP+i20Uv
 yzU4avRxUw34DDGinMxo+rkoHSY0w5yU=
X-Gm-Gg: ATEYQzyaJZOBFa8GT48f3WWmkwDVA5ldu2X/cTBgK8Qw+OORo8VyQZA2HEUy0NZsLJY
 D2o1mIJA/KpS7BAnaDTAyxuQfXtmy/8oDkz9p5Xyp9ycU7nP3sHI45JPqTQwZ7Kx1m4xqdrtBWH
 Fm0uEd+KXSJrZIWk+5Lkcir+BoTht6W4HKbhuMHiXdFaH6jKNlqUl5vdVrOd8IxVzU6lxgm9E8G
 9ha8DK5fd/xm8dF4kJRPZ/NZmz5QoBGzNbdw7qIOUXwqaiIsG1ij1DYSw6Py+Of1Ny3sZF8LvOu
 oJrwMu1eh8SRoCFUbbDa/hBsmZU0s5psd3bOFw==
X-Received: by 2002:a17:907:9611:b0:b93:8995:8f3a with SMTP id
 a640c23a62f3a-b93f10f83a8mr303025866b.3.1772681968035; Wed, 04 Mar 2026
 19:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20260227232838.23392-1-philmd@linaro.org>
In-Reply-To: <20260227232838.23392-1-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Mar 2026 13:39:01 +1000
X-Gm-Features: AaiRm517PZ7vb0YwynH8u60LF6GLYM8_kzUE-uCRbrGNA63_N2q7KLHAvQml4DY
Message-ID: <CAKmqyKP+xpoTzMheFOzuq9wv9uaTFGvieFQ3p1q2zXzr0piweg@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: Remove deprecated 'riscv,
 delegate' device-tree property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Conor Dooley <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Anup Patel <anup.patel@oss.qualcomm.com>, devel@lists.libvirt.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Feb 28, 2026 at 9:29=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The "riscv,delegate" DT property was added in QEMU 7.0 as part of
> the AIA APLIC support.  The property changed name during the
> review process in Linux and the correct name ended up being
> "riscv,delegation". The incorrect name was added as alias, and
> deprecated in v9.1 (commit 38facfa8432), so can be removed for
> v11.0.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Binary file pc-bios/opensbi-riscv32-generic-fw_dynamic.bin matches
> Binary file pc-bios/opensbi-riscv64-generic-fw_dynamic.bin matches
> ---
>  docs/about/deprecated.rst       | 11 -----------
>  docs/about/removed-features.rst | 11 +++++++++++
>  hw/riscv/virt.c                 |  9 ---------
>  3 files changed, 11 insertions(+), 20 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 1d5c4f3707c..cc5502e5394 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -494,17 +494,6 @@ versions, aliases will point to newer CPU model vers=
ions
>  depending on the machine type, so management software must
>  resolve CPU model aliases before starting a virtual machine.
>
> -RISC-V "virt" board "riscv,delegate" DT property (since 9.1)
> -''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -The "riscv,delegate" DT property was added in QEMU 7.0 as part of
> -the AIA APLIC support.  The property changed name during the review
> -process in Linux and the correct name ended up being
> -"riscv,delegation".  Changing the DT property name will break all
> -available firmwares that are using the current (wrong) name.  The
> -property is kept as is in 9.1, together with "riscv,delegation", to
> -give more time for firmware developers to change their code.
> -
>  x86 "isapc" board use of modern x86 CPUs (since 10.2)
>  '''''''''''''''''''''''''''''''''''''''''''''''''''''
>
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-feature=
s.rst
> index 41bec8b8e38..0a62e87ee35 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -1232,6 +1232,17 @@ converting to using TCG plugins they should contac=
t the qemu-devel
>  mailing list.
>
>
> +Firmware, ACPI, Device Tree
> +---------------------------
> +
> +RISC-V "virt" board "riscv,delegate" DT property (removed in 11.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The "riscv,delegate" DT property was added in QEMU 7.0 as part of
> +the AIA APLIC support.  The property changed name during the review
> +process in Linux and the correct name ended up being "riscv,delegation".
> +
> +
>  System emulator devices
>  -----------------------
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index bbce2fb6671..a1c323e66df 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -666,15 +666,6 @@ static void create_fdt_one_aplic(RISCVVirtState *s, =
int socket,
>          qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
>                                 aplic_child_phandle, 0x1,
>                                 VIRT_IRQCHIP_NUM_SOURCES);
> -        /*
> -         * DEPRECATED_9.1: Compat property kept temporarily
> -         * to allow old firmwares to work with AIA. Do *not*
> -         * use 'riscv,delegate' in new code: use
> -         * 'riscv,delegation' instead.
> -         */
> -        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
> -                               aplic_child_phandle, 0x1,
> -                               VIRT_IRQCHIP_NUM_SOURCES);
>      }
>
>      riscv_socket_fdt_write_id(ms, aplic_name, socket);
> --
> 2.52.0
>
>

