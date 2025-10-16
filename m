Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBADCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 23:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9XcY-00063p-BC; Thu, 16 Oct 2025 19:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9XcW-00063h-Lp
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:42:57 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9XcU-0002t6-7j
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:42:55 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-63bfbbbdd0bso2571369a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 16:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760658172; x=1761262972; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bj8dPshwGuLhSnu5rIGIi5mpOwcKw8nZHqZqEMckfMk=;
 b=AHwyW02MBGqXtv7gD37rhLg4Eex1Zw7jufPCiVA1iV/X534ITqq2pQEDXkzUOv8RBy
 TS9BtnyY4eyfGuojW4SNuH2gR6NajHoBTqwMLIsNn1Yv8FnxadCxREmkle/IYm4vQ8Nm
 SIgonzwWGwwavdkET/gsPMVlMsRK76Ku3A/xKFLeKVZblY3LTapW/CpMTXumh/WwWxTw
 JnhEPxPMTjrVn2BS+K2SrsIvApD5A6JIvGKEQpHcP8UgKjOeiqhkGV2xLOVXF+yGpmc3
 md48BsqxLwur9kF3gW4ZO9NvvYaOz11s/dfKGcHpi/XCFaeQjCpCLPhmUvUvB7nDHvA2
 r0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760658172; x=1761262972;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bj8dPshwGuLhSnu5rIGIi5mpOwcKw8nZHqZqEMckfMk=;
 b=B2oGZeJqlga/smfhZK5M6bHH3BdSsG7RKNT5CJ+dDTzkeH+a06T3NtkxJXDw8q1s75
 gi4nzUTMbpG5Pekit8JHqAbJeQUBu//Bz7Onh0kXTIPzmQoojNBpxP356ctU+HMiLk44
 Eivu0FCAFltz2nnde7i2MGnylv9DHxJC8o8ztzTLSqmQ/Nz0vIjLz8TyrKNiOaT+byX1
 WXchTnIQvMqolR/7Ll6JFKWhy1Mw3ng/4tbPF1BX7Kifdy4sBFUg7vbPy6EbmaY3jCm0
 KkM9PpiC7/NYy2nMGMv5+m1X8ivaWGl56ppohcp/9kFdzxOUbl3dL9rJ2l3kH9zrPNP6
 hF7Q==
X-Gm-Message-State: AOJu0YyFK8HatQMYFup1Qp9daKoYUkWPvNueWa2vXjMkAyMt4JZwy+HR
 6t6WvT/uOhgxltKMqAzk/llx/RPDGKBq+Kaet3d6UvWVfWWKT5yyRPR8V+xDhEvJ48YJtr7zWQw
 8fJEeEtgS55tgYroDZJBuqR+DPSQxzFk=
X-Gm-Gg: ASbGncsIMuPgC+1ssx3/mG91H9YreY11NF5rGTEmtUBRNHIaKd12qKwI1XChGd+GXTN
 oSQumzUvDL1Q9QdKOaPS7R3w/dB/rNDW4mmkqUV5ZKhAnrUeaj3KWji3ZXDOP7sjRRQuvGxOpm4
 9FIL4NhxooDqrucPI7/FkuF7+vUZDg9gPOn9h+eVWtfIvqBMlIUdwRNM4BXrc9q2kevP+Lq2c82
 A19k7u+ZP2PslqhBL90rSiEXm61+gX10vYGl8q5Vo0T9TjwZyGEYE8G24cbica5zdbQI6CzzpS5
 qhnnu8KNTL3lT8IC5Y7FdWhL1zbBwCB1ODyA
X-Google-Smtp-Source: AGHT+IFJIS9tsgFLtS8th27uajNpiTrDG6LP8nx1a0Yvhbphqy2UcLAsY9UBdPvCa5d9KgqZNt+tz0Q+FI+5ehXBm/I=
X-Received: by 2002:a05:6402:44c7:b0:637:e253:45d0 with SMTP id
 4fb4d7f45d1cf-63c1f63e335mr1287652a12.11.1760658172132; Thu, 16 Oct 2025
 16:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
 <20251015-feature-single-binary-hw-v1-v1-3-8b416eda42cf@rev.ng>
In-Reply-To: <20251015-feature-single-binary-hw-v1-v1-3-8b416eda42cf@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Oct 2025 09:42:25 +1000
X-Gm-Features: AS18NWC7Rafi8wLwVS04iB0coPs4pLO9jEuNsZR4NUs4rttEbM7hValEf3BBWWY
Message-ID: <CAKmqyKP_ycSWuBv_Li38y0P2eZpRA9PUQLMpcfmObbs6b+UrdA@mail.gmail.com>
Subject: Re: [PATCH 3/5] hw/riscv: Widen OpenSBI dynamic info struct
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
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

On Wed, Oct 15, 2025 at 11:29=E2=80=AFPM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> Since fw_dynamic_info is only used for non 32 bit targets, target_long
> is int64_t anyway.  Rename struct to fw_dynamic_info64 and use int64_t.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/riscv/boot_opensbi.h | 14 +++++++-------
>  hw/riscv/boot.c                 | 22 ++++++++++++----------
>  2 files changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/include/hw/riscv/boot_opensbi.h b/include/hw/riscv/boot_open=
sbi.h
> index 18664a174b..ab9999be3f 100644
> --- a/include/hw/riscv/boot_opensbi.h
> +++ b/include/hw/riscv/boot_opensbi.h
> @@ -29,17 +29,17 @@ enum sbi_scratch_options {
>  };
>
>  /** Representation dynamic info passed by previous booting stage */
> -struct fw_dynamic_info {
> +struct fw_dynamic_info64 {
>      /** Info magic */
> -    target_long magic;
> +    int64_t magic;
>      /** Info version */
> -    target_long version;
> +    int64_t version;
>      /** Next booting stage address */
> -    target_long next_addr;
> +    int64_t next_addr;
>      /** Next booting stage mode */
> -    target_long next_mode;
> +    int64_t next_mode;
>      /** Options for OpenSBI library */
> -    target_long options;
> +    int64_t options;
>      /**
>       * Preferred boot HART id
>       *
> @@ -55,7 +55,7 @@ struct fw_dynamic_info {
>       * stage can set it to -1UL which will force the FW_DYNAMIC firmware
>       * to use the relocation lottery mechanism.
>       */
> -    target_long boot_hart;
> +    int64_t boot_hart;
>  };
>
>  /** Representation dynamic info passed by previous booting stage */
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 4eadcff26c..64608e58c7 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -387,7 +387,8 @@ void riscv_rom_copy_firmware_info(MachineState *machi=
ne,
>                                    uint64_t kernel_entry)
>  {
>      struct fw_dynamic_info32 dinfo32;
> -    struct fw_dynamic_info dinfo;
> +    struct fw_dynamic_info64 dinfo64;
> +    void *dinfo_ptr =3D NULL;
>      size_t dinfo_len;
>
>      if (riscv_is_32bit(harts)) {
> @@ -397,15 +398,17 @@ void riscv_rom_copy_firmware_info(MachineState *mac=
hine,
>          dinfo32.next_addr =3D cpu_to_le32(kernel_entry);
>          dinfo32.options =3D 0;
>          dinfo32.boot_hart =3D 0;
> +        dinfo_ptr =3D &dinfo32;
>          dinfo_len =3D sizeof(dinfo32);
>      } else {
> -        dinfo.magic =3D cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VALUE);
> -        dinfo.version =3D cpu_to_le64(FW_DYNAMIC_INFO_VERSION);
> -        dinfo.next_mode =3D cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
> -        dinfo.next_addr =3D cpu_to_le64(kernel_entry);
> -        dinfo.options =3D 0;
> -        dinfo.boot_hart =3D 0;
> -        dinfo_len =3D sizeof(dinfo);
> +        dinfo64.magic =3D cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VALUE);
> +        dinfo64.version =3D cpu_to_le64(FW_DYNAMIC_INFO_VERSION);
> +        dinfo64.next_mode =3D cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
> +        dinfo64.next_addr =3D cpu_to_le64(kernel_entry);
> +        dinfo64.options =3D 0;
> +        dinfo64.boot_hart =3D 0;
> +        dinfo_ptr =3D &dinfo64;
> +        dinfo_len =3D sizeof(dinfo64);
>      }
>
>      /**
> @@ -419,8 +422,7 @@ void riscv_rom_copy_firmware_info(MachineState *machi=
ne,
>      }
>
>      rom_add_blob_fixed_as("mrom.finfo",
> -                           riscv_is_32bit(harts) ?
> -                           (void *)&dinfo32 : (void *)&dinfo,
> +                           dinfo_ptr,
>                             dinfo_len,
>                             rom_base + reset_vec_size,
>                             &address_space_memory);
>
> --
> 2.51.0
>
>

