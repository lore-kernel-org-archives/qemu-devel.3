Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554C3E98FA8
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 04:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAgih-0001uj-N5; Thu, 09 Apr 2026 00:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAgif-0001uD-W3
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 00:10:18 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAgid-0006xt-67
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 00:10:17 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9b1ffbb9f5so55120866b.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 21:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775707813; cv=none;
 d=google.com; s=arc-20240605;
 b=QEOdG2tONCG3zpTnoet25fakeNd1+bC9HfkH9jhEth6j5CsT8wDEkSLzNQ/w7xtEbX
 x/WO30omsf0JvGinnjP5NWp+y2MS0NsSceiqzx8yCUUSn8JFFqKA9wcPkTE3A9Dgk5Oe
 2eSnKalxo8uwEtPaQ7jQmM+iVAiM7D4woQUSrvYStcEstzxioeVxO5FZE2oSTJb1Kmru
 qmxFL6LeUTzRyRSzbGlbbME9405VVD4Q//JoJeZc3+L1s7EEIMzgpYFaShdWOdY8ocHD
 Y7Flacs+DMR9dzGnfrCVd13NmhZtOv64neyDexbjjt83gFLykCakVGVb6x7YeZd26Ike
 kDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zifK6uToHKZ4orIFY0vWTJTsdZRrDYgXztGFPA91Sbk=;
 fh=02yfZO3MCi97EyXeoLg1BYIgpUdGEMk3Yh61+offrCA=;
 b=ODJv8oe7GjHAdVLTjS7ogfVQR9AEOktDblDGWsyaYoxpK1gcxweBMi9zfhs/4gSimk
 JS/1FcLakRH1lRcyObfOTt6Wj41rUkZC2zIgq6vAFtlnM+CXEYP9IHPRH2if5Z7dfR8L
 LIQZN5L/k/b3tyO3yqGGNv84/LQOUVi1KtSqjOan7TUUMhQIgmLtajsoitFylNgGUpCR
 RLTaZamKyXWnpnIhO6jkdGkRpr6ayw/Y5lZiEOZYL3PG3s3V+RfRgFELHJCd4U3QB5G4
 5iTDCXbiwbPE+oxuzIp8jEkmjpkbp8wuDL0nltmavfL9eOpirqr9EE5v/2/xPsP699A6
 40Vg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775707813; x=1776312613; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zifK6uToHKZ4orIFY0vWTJTsdZRrDYgXztGFPA91Sbk=;
 b=jlFfPDQAwH9bnglfbExKQIz/zTnIHWbwGUajtw/GKUcJpWv9sstP8JcOEuG/y7jLM8
 YnTVMIdnCsz74txMXmMO0KGgMujynLhNgxJw6OgeS9YGOpcaEwDhw9jBoRxnZLbVQ8LY
 peEDq4YkJiAeS5yRzoHghv9M/zU/932FKLVevjVeRy1TUNcPWaiOtQ4/uhzaiSMlIDFm
 cx9duNWnDn8OHDMKZeYrx0s9KJbyLQFRv/4Jy8l7BAaws+vTKicHHFPgMlOoS0YMyKQT
 ivu8++AolJUboopzORz/b1H/t9S2H7hmWaYHeOaXeF0JG3bvqa4e7L2UKMteM4S2CA7O
 Mvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775707813; x=1776312613;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zifK6uToHKZ4orIFY0vWTJTsdZRrDYgXztGFPA91Sbk=;
 b=YXnrH3qlACzBAvM/ab9Tk3fNYQMcxeBpqzHJdAWudTwPW6y8f4joyYm5dteIN31s5p
 1AYQ8O5EK046WypqPrCvlhcK85tiK5BBrZ0HibzoMSztteE5R4ZrfnOLhKrzbmPU0IBj
 QrBxYH5G7eNsP1rTfXKKTCgZj0/l7ATT7QXfj4qmmZkQI0v9aZ1+sRbW7evZ7uBGUgT7
 KQTb0+/VWMT0xJlVph32xAcJdyUH4qzbGjwrHTqcJ5gI0Du5AgsDRXMbEgDlQtHkl93l
 GJ/QSleL+DVjgrZI/MBmyhA4CBeH3RNi23s4K7DRKnpSs792x8ik1i/smAMepFsbr5Em
 uczQ==
X-Gm-Message-State: AOJu0YwdTfIEjZg4lKAp3N/DjsNuOFkae3fXtRx1J/LzHSDYybjw2lkb
 xOg3APRZFL1GbxX3x33oDdhtdrrDiNa80+ewL/Vnzczq9pTZWFq78fJk4tO6Zo08cIXnbj/OFsu
 U0NZbEX9Yb9oT2VDIe+JVcCmmFq82zoA=
X-Gm-Gg: AeBDieskBaBuE/lwsE84GB9MPnTCIulPOt9geEmm4IUXZF+DXDPFeSSjI/vhVoZjb1p
 o+we4D3k84IdNLMgcyho+EeWyzxFTb9gxkXgByN0aiATDVf/21vc5zVWw5rReLaPZJhz3pwJ9wm
 hlSao5kwgIKbCONDo3TfRD++QEKbeIYwPS593VINHTh2IlOmNo1yE1gdTIFxDMDQVEXCcs2r3VO
 fIz0KfPYt7v3qkYaQFZKigTC2RMxIFYxirJnTO0LGPvWFSO69p2yoEehI3k7iO6+vjRHhp60w/R
 syoQjg6lTELW/wnZFHnL5szxo1KnMFT4TBbKVA==
X-Received: by 2002:a17:906:50c:b0:b98:8690:d7b9 with SMTP id
 a640c23a62f3a-b9c679de11dmr957748766b.44.1775707812909; Wed, 08 Apr 2026
 21:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
 <20260406154935.144674-6-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260406154935.144674-6-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Apr 2026 14:09:44 +1000
X-Gm-Features: AQROBzCtyclwEDOktANFkUQse51wXgVrxXl2VJaWs3TZaMt8-fdPDAw1ncsxgXY
Message-ID: <CAKmqyKNfbKtsJGvoJVr77Tx6AOgVHimu5ukNyUJWyDVZAfjMGQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] hw/riscv: Make boot code endianness-aware at
 runtime
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "thuth@redhat.com" <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
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

On Tue, Apr 7, 2026 at 1:49=E2=80=AFAM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add riscv_is_big_endian() helper that checks the hart's big-endian CPU
> property and use it throughout the boot code:
>
> - ELF loading: pass ELFDATA2MSB or ELFDATA2LSB based on endianness
> - Firmware dynamic info: use cpu_to_be* or cpu_to_le* based on endianness
> - Reset vector: instructions (entries 0-5) remain always little-endian,
>   data words (entries 6-9) use target data endianness. For RV64 BE, the
>   hi/lo word pairs within each dword are swapped since LD reads as BE.
>
> This is part of the runtime big-endian support series which avoids
> separate BE binaries by handling endianness as a CPU property.
>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>  hw/riscv/boot.c         | 82 +++++++++++++++++++++++++++++++++++------
>  include/hw/riscv/boot.h |  2 +
>  2 files changed, 72 insertions(+), 12 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index e5490beda0..c7558b904f 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -40,6 +40,28 @@ bool riscv_is_32bit(RISCVHartArrayState *harts)
>      return mcc->def->misa_mxl_max =3D=3D MXL_RV32;
>  }
>
> +bool riscv_is_big_endian(RISCVHartArrayState *harts)
> +{
> +    return harts->harts[0].cfg.big_endian;
> +}
> +
> +/*
> + * Convert a pair of 32-bit words forming a 64-bit dword to target data
> + * endianness. For big-endian, the hi/lo word order is swapped since LD
> + * interprets bytes as BE.
> + */
> +static void riscv_boot_data_dword(uint32_t *data, bool big_endian)
> +{
> +    if (big_endian) {
> +        uint32_t tmp =3D data[0];
> +        data[0] =3D cpu_to_be32(data[1]);
> +        data[1] =3D cpu_to_be32(tmp);
> +    } else {
> +        data[0] =3D cpu_to_le32(data[0]);
> +        data[1] =3D cpu_to_le32(data[1]);
> +    }
> +}
> +
>  /*
>   * Return the per-socket PLIC hart topology configuration string
>   * (caller must free with g_free())
> @@ -72,6 +94,7 @@ void riscv_boot_info_init(RISCVBootInfo *info, RISCVHar=
tArrayState *harts)
>      info->kernel_size =3D 0;
>      info->initrd_size =3D 0;
>      info->is_32bit =3D riscv_is_32bit(harts);
> +    info->is_big_endian =3D riscv_is_big_endian(harts);
>  }
>
>  vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
> @@ -247,8 +270,9 @@ void riscv_load_kernel(MachineState *machine,
>       */
>      kernel_size =3D load_elf_ram_sym(kernel_filename, NULL, NULL, NULL, =
NULL,
>                                     &info->image_low_addr, &info->image_h=
igh_addr,
> -                                   NULL, ELFDATA2LSB, EM_RISCV,
> -                                   1, 0, NULL, true, sym_cb);
> +                                   NULL,
> +                                   ELFDATA2LSB,
> +                                   EM_RISCV, 1, 0, NULL, true, sym_cb);
>      if (kernel_size > 0) {
>          info->kernel_size =3D kernel_size;
>          goto out;
> @@ -391,21 +415,32 @@ void riscv_rom_copy_firmware_info(MachineState *mac=
hine,
>      struct fw_dynamic_info64 dinfo64;
>      void *dinfo_ptr =3D NULL;
>      size_t dinfo_len;
> +    bool big_endian =3D riscv_is_big_endian(harts);
>
>      if (riscv_is_32bit(harts)) {
> -        dinfo32.magic =3D cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VALUE);
> -        dinfo32.version =3D cpu_to_le32(FW_DYNAMIC_INFO_VERSION);
> -        dinfo32.next_mode =3D cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
> -        dinfo32.next_addr =3D cpu_to_le32(kernel_entry);
> +        dinfo32.magic =3D big_endian ? cpu_to_be32(FW_DYNAMIC_INFO_MAGIC=
_VALUE)
> +                                   : cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_V=
ALUE);
> +        dinfo32.version =3D big_endian ? cpu_to_be32(FW_DYNAMIC_INFO_VER=
SION)
> +                                     : cpu_to_le32(FW_DYNAMIC_INFO_VERSI=
ON);
> +        dinfo32.next_mode =3D big_endian
> +                          ? cpu_to_be32(FW_DYNAMIC_INFO_NEXT_MODE_S)
> +                          : cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
> +        dinfo32.next_addr =3D big_endian ? cpu_to_be32(kernel_entry)
> +                                       : cpu_to_le32(kernel_entry);
>          dinfo32.options =3D 0;
>          dinfo32.boot_hart =3D 0;
>          dinfo_ptr =3D &dinfo32;
>          dinfo_len =3D sizeof(dinfo32);
>      } else {
> -        dinfo64.magic =3D cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VALUE);
> -        dinfo64.version =3D cpu_to_le64(FW_DYNAMIC_INFO_VERSION);
> -        dinfo64.next_mode =3D cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
> -        dinfo64.next_addr =3D cpu_to_le64(kernel_entry);
> +        dinfo64.magic =3D big_endian ? cpu_to_be64(FW_DYNAMIC_INFO_MAGIC=
_VALUE)
> +                                   : cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_V=
ALUE);
> +        dinfo64.version =3D big_endian ? cpu_to_be64(FW_DYNAMIC_INFO_VER=
SION)
> +                                     : cpu_to_le64(FW_DYNAMIC_INFO_VERSI=
ON);
> +        dinfo64.next_mode =3D big_endian
> +                          ? cpu_to_be64(FW_DYNAMIC_INFO_NEXT_MODE_S)
> +                          : cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
> +        dinfo64.next_addr =3D big_endian ? cpu_to_be64(kernel_entry)
> +                                       : cpu_to_le64(kernel_entry);
>          dinfo64.options =3D 0;
>          dinfo64.boot_hart =3D 0;
>          dinfo_ptr =3D &dinfo64;
> @@ -474,10 +509,33 @@ void riscv_setup_rom_reset_vec(MachineState *machin=
e, RISCVHartArrayState *harts
>          reset_vec[2] =3D 0x00000013;   /*     addi   x0, x0, 0 */
>      }
>
> -    /* copy in the reset vector in little_endian byte order */
> -    for (i =3D 0; i < ARRAY_SIZE(reset_vec); i++) {
> +    /* RISC-V instructions are always little-endian */
> +    for (i =3D 0; i < 6; i++) {
>          reset_vec[i] =3D cpu_to_le32(reset_vec[i]);
>      }
> +
> +    /*
> +     * Data words (addresses at entries 6-9) must match the firmware's d=
ata
> +     * endianness.
> +     */
> +    if (riscv_is_32bit(harts)) {
> +        for (i =3D 6; i < ARRAY_SIZE(reset_vec); i++) {
> +            if (riscv_is_big_endian(harts)) {
> +                reset_vec[i] =3D cpu_to_be32(reset_vec[i]);
> +            } else {
> +                reset_vec[i] =3D cpu_to_le32(reset_vec[i]);
> +            }
> +        }
> +    } else {
> +        /*
> +         * For RV64, each pair of 32-bit words forms a dword. For big-en=
dian,
> +         * the hi/lo word order within each dword must be swapped since =
LD
> +         * interprets bytes as BE.
> +         */
> +        for (i =3D 6; i < ARRAY_SIZE(reset_vec); i +=3D 2) {
> +            riscv_boot_data_dword(reset_vec + i, riscv_is_big_endian(har=
ts));
> +        }
> +    }
>      rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
>                            rom_base, &address_space_memory);
>      riscv_rom_copy_firmware_info(machine, harts,
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index f00b3ca122..a54c2b397d 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -36,9 +36,11 @@ typedef struct RISCVBootInfo {
>      ssize_t initrd_size;
>
>      bool is_32bit;
> +    bool is_big_endian;

Is this used?

Alistair

