Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827A7C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfi4V-0005LA-02; Thu, 29 Feb 2024 10:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfi4R-0005KV-9Y
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:11:39 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfi4K-0000Tf-Jb
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:11:37 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412b246b386so7600295e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 07:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709219491; x=1709824291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v51iAGhvpR06nMOkU4KxwxSngIfOCe8PkpWX0YjJBbo=;
 b=FqyH5KdKBrY7TFyjmpaDN9pBJrchtoTPvnAVvrejiOs3Bqmq2XsI+cIPFcJb9Akc9N
 z7oiI+Xf8urOAkICrQQ1clXsczXqSX/HoGNDbsP1T+ncqOwshNYSWW9wnjmqEjxcuzEY
 kt6Py0eINSB2IUNIJkUUO7mtkPE67qZiuA4qKqPiPRQcbJs0p/fWSKebGIvPcgl6mGwa
 AZ+KijmCXfEc/2rEMPbpJKupgNuRxMV/w/0aWm3Ax0LkRoO7n75wzd0UQePtUB7XYqex
 QpULFxV1yBfzQU7RFxEXKBuIwXbDHcIz9+/a8LouPyQMD7zxIRfjDLyr3SISMV3TO7u6
 wo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709219491; x=1709824291;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v51iAGhvpR06nMOkU4KxwxSngIfOCe8PkpWX0YjJBbo=;
 b=fuswskaRtgYFsEnGUsdRCGKWS7WT/9WkOZH9stDk7dxiH+T/WFo/fv2wp1lSJVu67C
 JkosLlKoQK8E/HhsnyzduA1QbqmZ0UdcsEnYLNtliEdpvqkC8nKgqJz9f4CTH1I1MLwW
 f9/QBJKhQ7wQ6ohKL5g5LdLePMTNPIh862meKMFza/yyDrOf0ahIhKzdfwUmDnQwrnHY
 VKjYWGXmTFy3DNzjI0WmQG6aIft8S3bOdZ/3Mwk1VPEYEACIiHydiX79behEO489aYYp
 wiq9XYehmR+WxQMkRpJbhlyCbJ9Meo+A4gbZ/Dcvl45em250CrYyLYqa9OVwW6NmOPas
 LCFA==
X-Gm-Message-State: AOJu0YzT/oSYupU2ODGQAzoOKc5slRnAIQuRJE74fOH37+3vAjS1IhOh
 /UeV8PePJev/lTITCSwlyrGUGkZg4ZVRJJSe6ru9JErUVdjR5n19rhkAPB692Pej1PL3fuzp7qa
 P
X-Google-Smtp-Source: AGHT+IGkr4dQgjfwBQzcXc7pN3ZmpUSVBCiJw7Stz0JG0BV2WXRflAQspSYFMXfuh1SYPrIMZjSNXQ==
X-Received: by 2002:a5d:4b8a:0:b0:33d:d791:1164 with SMTP id
 b10-20020a5d4b8a000000b0033dd7911164mr1551477wrt.8.1709219490681; 
 Thu, 29 Feb 2024 07:11:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bk23-20020a0560001d9700b0033d282c7537sm2040356wrb.23.2024.02.29.07.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 07:11:30 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AC9D95F78F;
 Thu, 29 Feb 2024 15:11:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: Re: [PATCH v5 11/18] mcdstub: system and core queries added
In-Reply-To: <20231220162555.19545-12-nicolas.eder@lauterbach.com> (Nicolas
 Eder's message of "Wed, 20 Dec 2023 17:25:48 +0100")
References: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
 <20231220162555.19545-12-nicolas.eder@lauterbach.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 15:11:29 +0000
Message-ID: <87plwf8fvi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Nicolas Eder <nicolas.eder@lauterbach.com> writes:

> ---
>  debug/mcdstub/arm_mcdstub.c      | 243 ++++++++++++++++++++
>  debug/mcdstub/mcdstub.c          | 370 ++++++++++++++++++++++++++++++-
>  debug/mcdstub/meson.build        |   2 +-
>  include/mcdstub/arm_mcdstub.h    |  85 +++++++
>  include/mcdstub/mcdstub.h        |   5 -
>  include/mcdstub/mcdstub_common.h |  19 ++
>  6 files changed, 717 insertions(+), 7 deletions(-)
>
> diff --git a/debug/mcdstub/arm_mcdstub.c b/debug/mcdstub/arm_mcdstub.c
> index c24aaf1202..ce5264a617 100644
> --- a/debug/mcdstub/arm_mcdstub.c
> +++ b/debug/mcdstub/arm_mcdstub.c
> @@ -16,3 +16,246 @@
>   *
>   * SPDX-License-Identifier: LGPL-2.0+
>   */
> +
> +#include "qemu/osdep.h"
> +#include "mcdstub/arm_mcdstub.h"
> +
> +int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces)
> +{
> +    int nr_address_spaces =3D cpu->num_ases;
> +    uint32_t mem_space_id =3D 0;
> +
> +    mem_space_id++;
> +    mcd_mem_space_st non_secure =3D {
> +        .name =3D "Non Secure",
> +        .id =3D mem_space_id,
> +        .type =3D 34,
> +        .bits_per_mau =3D 8,
> +        .invariance =3D 1,
> +        .endian =3D 1,
> +        .min_addr =3D 0,
> +        .max_addr =3D -1,
> +        .supported_access_options =3D 0,
> +        .is_secure =3D false,
> +        .is_physical =3D false,
> +    };
> +    g_array_append_vals(memspaces, (gconstpointer)&non_secure, 1);
> +    mem_space_id++;
> +    mcd_mem_space_st phys_non_secure =3D {
> +        .name =3D "Physical (Non Secure)",
> +        .id =3D mem_space_id,
> +        .type =3D 18,
> +        .bits_per_mau =3D 8,
> +        .invariance =3D 1,
> +        .endian =3D 1,
> +        .min_addr =3D 0,
> +        .max_addr =3D -1,
> +        .supported_access_options =3D 0,
> +        .is_secure =3D false,
> +        .is_physical =3D true,
> +    };
> +    g_array_append_vals(memspaces, (gconstpointer)&phys_non_secure, 1);
> +    if (nr_address_spaces > 1) {
> +        mem_space_id++;
> +        mcd_mem_space_st secure =3D {
> +            .name =3D "Secure",
> +            .id =3D mem_space_id,
> +            .type =3D 34,
> +            .bits_per_mau =3D 8,
> +            .invariance =3D 1,
> +            .endian =3D 1,
> +            .min_addr =3D 0,
> +            .max_addr =3D -1,
> +            .supported_access_options =3D 0,
> +            .is_secure =3D true,
> +            .is_physical =3D false,
> +        };
> +        g_array_append_vals(memspaces, (gconstpointer)&secure, 1);
> +        mem_space_id++;
> +        mcd_mem_space_st phys_secure =3D {
> +            .name =3D "Physical (Secure)",
> +            .id =3D mem_space_id,
> +            .type =3D 18,
> +            .bits_per_mau =3D 8,
> +            .invariance =3D 1,
> +            .endian =3D 1,
> +            .min_addr =3D 0,
> +            .max_addr =3D -1,
> +            .supported_access_options =3D 0,
> +            .is_secure =3D true,
> +            .is_physical =3D true,
> +        };
> +        g_array_append_vals(memspaces, (gconstpointer)&phys_secure, 1);
> +    }
> +    mem_space_id++;
> +    mcd_mem_space_st gpr =3D {
> +        .name =3D "GPR Registers",
> +        .id =3D mem_space_id,
> +        .type =3D 1,
> +        .bits_per_mau =3D 8,
> +        .invariance =3D 1,
> +        .endian =3D 1,
> +        .min_addr =3D 0,
> +        .max_addr =3D -1,
> +        .supported_access_options =3D 0,
> +    };
> +    g_array_append_vals(memspaces, (gconstpointer)&gpr, 1);
> +    mem_space_id++;
> +    mcd_mem_space_st cpr =3D {
> +        .name =3D "CP15 Registers",
> +        .id =3D mem_space_id,
> +        .type =3D 1,
> +        .bits_per_mau =3D 8,
> +        .invariance =3D 1,
> +        .endian =3D 1,
> +        .min_addr =3D 0,
> +        .max_addr =3D -1,
> +        .supported_access_options =3D 0,
> +    };
> +    g_array_append_vals(memspaces, (gconstpointer)&cpr, 1);
> +    return 0;
> +}
> +
> +int arm_mcd_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
> +    GArray *registers, int *current_group_id)
> +{
> +    const char *xml_filename =3D NULL;
> +    const char *current_xml_filename =3D NULL;
> +    const char *xml_content =3D NULL;
> +    int i =3D 0;
> +
> +    /* 1. get correct file */
> +    xml_filename =3D cc->gdb_core_xml_file;
> +    for (i =3D 0; ; i++) {
> +        current_xml_filename =3D gdb_static_features[i].xmlname;
> +        if (!current_xml_filename || (strncmp(current_xml_filename,
> +            xml_filename, strlen(xml_filename)) =3D=3D 0
> +            && strlen(current_xml_filename) =3D=3D strlen(xml_filename)))
> +            break;
> +    }

I guess this will need re-writing to use the new GDBFeature builder
which has been merged:

  cc -m64 -mcx16 -Idebug/mcdstub/libmcd_system.fa.p -Idebug/mcdstub -I../..=
/debug/mcdstub -I. -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/glib-2.0 =
-I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fdiagnostics-color=3Dauto -Wa=
ll -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g -fstack-protector-strong -Wemp=
ty-body -Wendif-labels -Wexpansion-to-defined -Wformat-security -Wformat-y2=
k -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self -Wmissing-for=
mat-attribute -Wmissing-prototypes -Wnested-externs -Wold-style-declaration=
 -Wold-style-definition -Wredundant-decls -Wshadow=3Dlocal -Wstrict-prototy=
pes -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -=
Wno-psabi -Wno-shift-negative-value -isystem /home/alex/lsrc/qemu.git/linux=
-headers -isystem linux-headers -iquote . -iquote /home/alex/lsrc/qemu.git =
-iquote /home/alex/lsrc/qemu.git/include -iquote /home/alex/lsrc/qemu.git/h=
ost/include/x86_64 -iquote /home/alex/lsrc/qemu.git/host/include/generic -i=
quote /home/alex/lsrc/qemu.git/tcg/i386 -pthread -D_GNU_SOURCE -D_FILE_OFFS=
ET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -=
fzero-call-used-regs=3Dused-gpr -ftrivial-auto-var-init=3Dzero -fPIE -MD -M=
Q debug/mcdstub/libmcd_system.fa.p/arm_mcdstub.c.o -MF debug/mcdstub/libmcd=
_system.fa.p/arm_mcdstub.c.o.d -o debug/mcdstub/libmcd_system.fa.p/arm_mcds=
tub.c.o -c ../../debug/mcdstub/arm_mcdstub.c
  ../../debug/mcdstub/arm_mcdstub.c: In function =E2=80=98arm_mcd_parse_gen=
eral_xml_files=E2=80=99:
  ../../debug/mcdstub/arm_mcdstub.c:171:25: error: =E2=80=98GDBRegisterStat=
e=E2=80=99 has no member named =E2=80=98xml=E2=80=99
    171 |         xml_filename =3D r->xml;
        |                         ^~
  ../../debug/mcdstub/arm_mcdstub.c:175:15: error: =E2=80=98CPUClass=E2=80=
=99 has no member named =E2=80=98gdb_get_dynamic_xml=E2=80=99
    175 |         if (cc->gdb_get_dynamic_xml) {
        |               ^~
  ../../debug/mcdstub/arm_mcdstub.c:176:29: error: =E2=80=98CPUClass=E2=80=
=99 has no member named =E2=80=98gdb_get_dynamic_xml=E2=80=99
    176 |             xml_content =3D cc->gdb_get_dynamic_xml(cpu, xml_file=
name);
        |                             ^~

Hopefully the code can be more generic now and avoid having to re-parse
generated xml.


> +    /* without gpr registers we can do nothing */
> +    if (!current_xml_filename) {
> +        return -1;
> +    }
> +
> +    /* 2. add group for gpr registers */
> +    mcd_reg_group_st gprregs =3D {
> +        .name =3D "GPR Registers",
> +        .id =3D *current_group_id
> +    };
> +    g_array_append_vals(reggroups, (gconstpointer)&gprregs, 1);
> +    *current_group_id =3D *current_group_id + 1;
> +
> +    /* 3. parse xml */
> +    /* the offset for gpr is always zero */
> +    xml_content =3D gdb_static_features[i].xml;
> +    parse_reg_xml(xml_content, strlen(xml_content), registers,
> +        MCD_ARM_REG_TYPE_GPR, 0);
> +    return 0;
> +}
> +
> +int arm_mcd_parse_general_xml_files(CPUState *cpu, GArray *reggroups,
> +    GArray *registers, int *current_group_id) {
> +    const char *xml_filename =3D NULL;
> +    const char *current_xml_filename =3D NULL;
> +    const char *xml_content =3D NULL;
> +    uint8_t reg_type =3D 0;
> +    CPUClass *cc =3D CPU_GET_CLASS(cpu);
> +
> +    /* iterate over all gdb xml files*/
> +    GDBRegisterState *r;
> +    for (guint i =3D 0; i < cpu->gdb_regs->len; i++) {
> +        r =3D &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
> +
> +        xml_filename =3D r->xml;
> +        xml_content =3D NULL;
> +
> +        /* 1. get xml content */
> +        if (cc->gdb_get_dynamic_xml) {
> +            xml_content =3D cc->gdb_get_dynamic_xml(cpu, xml_filename);
> +        }
> +        if (xml_content) {
> +            if (strcmp(xml_filename, "system-registers.xml") =3D=3D 0) {
> +                /* these are the coprocessor register */
> +                mcd_reg_group_st corprocessorregs =3D {
> +                    .name =3D "CP15 Registers",
> +                    .id =3D *current_group_id
> +                };
> +                g_array_append_vals(reggroups,
> +                    (gconstpointer)&corprocessorregs, 1);
> +                *current_group_id =3D *current_group_id + 1;
> +                reg_type =3D MCD_ARM_REG_TYPE_CPR;
> +            }
> +        } else {
> +            /* its not a coprocessor xml -> it is a static xml file */
> +            int j =3D 0;
> +            for (j =3D 0; ; j++) {
> +                current_xml_filename =3D gdb_static_features[j].xmlname;
> +                if (!current_xml_filename || (strncmp(current_xml_filena=
me,
> +                    xml_filename, strlen(xml_filename)) =3D=3D 0
> +                    && strlen(current_xml_filename) =3D=3D strlen(xml_fi=
lename)))
> +                    break;
> +            }
> +            if (current_xml_filename) {
> +                xml_content =3D gdb_static_features[j].xml;
> +                /* select correct reg_type */
> +                if (strcmp(current_xml_filename, "arm-vfp.xml") =3D=3D 0=
) {
> +                    reg_type =3D MCD_ARM_REG_TYPE_VFP;
> +                } else if (strcmp(current_xml_filename, "arm-vfp3.xml") =
=3D=3D 0) {
> +                    reg_type =3D MCD_ARM_REG_TYPE_VFP;
> +                } else if (strcmp(current_xml_filename,
> +                    "arm-vfp-sysregs.xml") =3D=3D 0) {
> +                    reg_type =3D MCD_ARM_REG_TYPE_VFP_SYS;
> +                } else if (strcmp(current_xml_filename,
> +                    "arm-neon.xml") =3D=3D 0) {
> +                    reg_type =3D MCD_ARM_REG_TYPE_VFP;
> +                } else if (strcmp(current_xml_filename,
> +                    "arm-m-profile-mve.xml") =3D=3D 0) {
> +                    reg_type =3D MCD_ARM_REG_TYPE_MVE;
> +                }
> +            } else {
> +                continue;
> +            }
> +        }
> +        /* 2. parse xml */
> +        parse_reg_xml(xml_content, strlen(xml_content), registers, reg_t=
ype,
> +            r->base_reg);
> +    }
> +    return 0;
> +}
> +
> +int arm_mcd_get_additional_register_info(GArray *reggroups, GArray *regi=
sters,
> +    CPUState *cpu)
> +{
> +    mcd_reg_st *current_register;
> +    uint32_t i =3D 0;
> +
> +    /* iterate over all registers */
> +    for (i =3D 0; i < registers->len; i++) {
> +        current_register =3D &(g_array_index(registers, mcd_reg_st, i));
> +        /* add mcd_reg_group_id and mcd_mem_space_id */
> +        if (strcmp(current_register->group, "cp_regs") =3D=3D 0) {
> +            /* coprocessor registers */
> +            current_register->mcd_reg_group_id =3D 2;
> +            current_register->mcd_mem_space_id =3D 6;
> +            /*
> +             * get info for opcode
> +             * for 32bit the opcode is only 16 bit long
> +             * for 64bit it is 32 bit long
> +             */
> +            current_register->opcode |=3D
> +                arm_mcd_get_opcode(cpu, current_register->internal_id);
> +        } else {
> +            /* gpr register */
> +            current_register->mcd_reg_group_id =3D 1;
> +            current_register->mcd_mem_space_id =3D 5;
> +        }
> +    }
> +    return 0;
> +}
> +
> +uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n)
> +{
> +    /* TODO: not working with current build structure */
> +    return 0;
> +}
> diff --git a/debug/mcdstub/mcdstub.c b/debug/mcdstub/mcdstub.c
> index 45daa38689..4095b3f8ce 100644
> --- a/debug/mcdstub/mcdstub.c
> +++ b/debug/mcdstub/mcdstub.c
> @@ -34,6 +34,7 @@
>=20=20
>  #include "mcdstub/mcd_shared_defines.h"
>  #include "mcdstub/mcdstub.h"
> +#include "mcdstub/arm_mcdstub.h"
>=20=20
>  typedef struct {
>      CharBackend chr;
> @@ -150,6 +151,25 @@ static CPUState *mcd_first_attached_cpu(void)
>      return cpu;
>  }
>=20=20
> +/**
> + * mcd_get_cpu() - Returns the CPU the index i_cpu_index.
> + *
> + * @cpu_index: Index of the desired CPU.
> + */
> +static CPUState *mcd_get_cpu(uint32_t cpu_index)
> +{
> +    CPUState *cpu =3D first_cpu;
> +
> +    while (cpu) {
> +        if (cpu->cpu_index =3D=3D cpu_index) {
> +            return cpu;
> +        }
> +        cpu =3D mcd_next_attached_cpu(cpu);
> +    }
> +
> +    return cpu;
> +}
> +
>  /**
>   * mcd_vm_state_change() - Handles a state change of the QEMU VM.
>   *
> @@ -221,6 +241,15 @@ static int mcd_put_packet(const char *buf)
>      return mcd_put_packet_binary(buf, strlen(buf));
>  }
>=20=20
> +/**
> + * mcd_put_strbuf() - Calls :c:func:`mcd_put_packet` with the str_buf of=
 the
> + * mcdserver_state.
> + */
> +static void mcd_put_strbuf(void)
> +{
> +    mcd_put_packet(mcdserver_state.str_buf->str);
> +}
> +
>  /**
>   * cmd_parse_params() - Extracts all parameters from a TCP packet.
>   *
> @@ -480,6 +509,134 @@ static void handle_close_server(GArray *params, voi=
d *user_ctx)
>      }
>  }
>=20=20
> +/**
> + * handle_gen_query() - Handler for all TCP query packets.
> + *
> + * Calls :c:func:`process_string_cmd` with all query functions in the
> + * mcd_query_cmds_table. :c:func:`process_string_cmd` then selects the c=
orrect
> + * one. This function just passes on the TCP packet data string from the
> + * parameters.
> + * @params: GArray with all TCP packet parameters.
> + */
> +static void handle_gen_query(GArray *params, void *user_ctx)
> +{
> +    if (!params->len) {
> +        return;
> +    }
> +    /* iterate over all possible query functions and execute the right o=
ne */
> +    if (process_string_cmd(NULL, get_param(params, 0)->data,
> +                           mcdserver_state.mcd_query_cmds_table,
> +                           ARRAY_SIZE(mcdserver_state.mcd_query_cmds_tab=
le))) {
> +        mcd_put_packet("");
> +    }
> +}
> +
> +/**
> + * handle_open_core() - Handler for opening a core.
> + *
> + * This function initializes all data for the core with the ID provided =
in
> + * the first parameter. In has a swtich case for different architectures.
> + * Currently only 32-Bit ARM is supported. The data includes memory spac=
es,
> + * register groups and registers themselves. They get stored into GLists=
 where
> + * every entry in the list corresponds to one opened core.
> + * @params: GArray with all TCP packet parameters.
> + */
> +static void handle_open_core(GArray *params, void *user_ctx)
> +{
> +    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
> +    CPUState *cpu =3D mcd_get_cpu(cpu_id);
> +    mcdserver_state.c_cpu =3D cpu;
> +    CPUClass *cc =3D CPU_GET_CLASS(cpu);
> +    const gchar *arch =3D cc->gdb_arch_name(cpu);
> +    int return_value =3D 0;
> +
> +    /* prepare data strucutures */
> +    GArray *memspaces =3D g_array_new(false, true, sizeof(mcd_mem_space_=
st));
> +    GArray *reggroups =3D g_array_new(false, true, sizeof(mcd_reg_group_=
st));
> +    GArray *registers =3D g_array_new(false, true, sizeof(mcd_reg_st));
> +
> +    if (strcmp(arch, MCDSTUB_ARCH_ARM) =3D=3D 0) {
> +        /* TODO: make group and memspace ids dynamic */
> +        int current_group_id =3D 1;
> +        /* 1. store mem spaces */
> +        return_value =3D arm_mcd_store_mem_spaces(cpu, memspaces);
> +        if (return_value !=3D 0) {
> +            g_assert_not_reached();
> +        }
> +        /* 2. parse core xml */
> +        return_value =3D arm_mcd_parse_core_xml_file(cc, reggroups,
> +            registers, &current_group_id);
> +        if (return_value !=3D 0) {
> +            g_assert_not_reached();
> +        }
> +        /* 3. parse other xmls */
> +        return_value =3D arm_mcd_parse_general_xml_files(cpu, reggroups,
> +            registers, &current_group_id);
> +        if (return_value !=3D 0) {
> +            g_assert_not_reached();
> +        }
> +        /* 4. add additional data the the regs from the xmls */
> +        return_value =3D arm_mcd_get_additional_register_info(reggroups,
> +            registers, cpu);
> +        if (return_value !=3D 0) {
> +            g_assert_not_reached();
> +        }
> +        /* 5. store all found data */
> +        if (g_list_nth(mcdserver_state.all_memspaces, cpu_id)) {
> +            GList *memspaces_ptr =3D
> +                g_list_nth(mcdserver_state.all_memspaces, cpu_id);
> +            memspaces_ptr->data =3D memspaces;
> +        } else {
> +            mcdserver_state.all_memspaces =3D
> +                g_list_insert(mcdserver_state.all_memspaces, memspaces, =
cpu_id);
> +        }
> +        if (g_list_nth(mcdserver_state.all_reggroups, cpu_id)) {
> +            GList *reggroups_ptr =3D
> +                g_list_nth(mcdserver_state.all_reggroups, cpu_id);
> +            reggroups_ptr->data =3D reggroups;
> +        } else {
> +            mcdserver_state.all_reggroups =3D
> +                g_list_insert(mcdserver_state.all_reggroups, reggroups, =
cpu_id);
> +        }
> +        if (g_list_nth(mcdserver_state.all_registers, cpu_id)) {
> +            GList *registers_ptr =3D
> +                g_list_nth(mcdserver_state.all_registers, cpu_id);
> +            registers_ptr->data =3D registers;
> +        } else {
> +            mcdserver_state.all_registers =3D
> +                g_list_insert(mcdserver_state.all_registers, registers, =
cpu_id);
> +        }
> +    } else {
> +        /* we don't support other architectures */
> +        g_assert_not_reached();
> +    }
> +}
> +
> +/**
> + * handle_close_core() - Handler for closing a core.
> + *
> + * Frees all memory allocated for core specific information. This includ=
es
> + * memory spaces, register groups and registers.
> + * @params: GArray with all TCP packet parameters.
> + */
> +static void handle_close_core(GArray *params, void *user_ctx)
> +{
> +    /* free memory for correct core */
> +    uint32_t cpu_id =3D get_param(params, 0)->cpu_id;
> +    GArray *memspaces =3D g_list_nth_data(mcdserver_state.all_memspaces,=
 cpu_id);
> +    mcdserver_state.all_memspaces =3D
> +        g_list_remove(mcdserver_state.all_memspaces, memspaces);
> +    g_array_free(memspaces, TRUE);
> +    GArray *reggroups =3D g_list_nth_data(mcdserver_state.all_reggroups,=
 cpu_id);
> +    mcdserver_state.all_reggroups =3D
> +        g_list_remove(mcdserver_state.all_reggroups, reggroups);
> +    g_array_free(reggroups, TRUE);
> +    GArray *registers =3D g_list_nth_data(mcdserver_state.all_registers,=
 cpu_id);
> +    mcdserver_state.all_registers =3D
> +        g_list_remove(mcdserver_state.all_registers, registers);
> +    g_array_free(registers, TRUE);
> +}
> +
>  /**
>   * mcd_handle_packet() - Evaluates the type of received packet and choos=
es the
>   * correct handler.
> @@ -516,6 +673,36 @@ static int mcd_handle_packet(const char *line_buf)
>              cmd_parser =3D &close_server_cmd_desc;
>          }
>          break;
> +    case TCP_CHAR_QUERY:
> +        {
> +            static MCDCmdParseEntry query_cmd_desc =3D {
> +                .handler =3D handle_gen_query,
> +                .cmd =3D {TCP_CHAR_QUERY, '\0'},
> +                .schema =3D {ARG_SCHEMA_STRING, '\0'},
> +            };
> +            cmd_parser =3D &query_cmd_desc;
> +        }
> +        break;
> +    case TCP_CHAR_OPEN_CORE:
> +        {
> +            static MCDCmdParseEntry open_core_cmd_desc =3D {
> +                .handler =3D handle_open_core,
> +                .cmd =3D {TCP_CHAR_OPEN_CORE, '\0'},
> +                .schema =3D {ARG_SCHEMA_CORENUM, '\0'},
> +            };
> +            cmd_parser =3D &open_core_cmd_desc;
> +        }
> +        break;
> +    case TCP_CHAR_CLOSE_CORE:
> +        {
> +            static MCDCmdParseEntry close_core_cmd_desc =3D {
> +                .handler =3D handle_close_core,
> +                .cmd =3D {TCP_CHAR_CLOSE_CORE, '\0'},
> +                .schema =3D {ARG_SCHEMA_CORENUM, '\0'},
> +            };
> +            cmd_parser =3D &close_core_cmd_desc;
> +        }
> +        break;
>      default:
>          /* command not supported */
>          mcd_put_packet("");
> @@ -663,6 +850,49 @@ static void mcd_chr_event(void *opaque, QEMUChrEvent=
 event)
>      }
>  }
>=20=20
> +/**
> + * handle_query_system() - Handler for the system query.
> + *
> + * Sends the system name, which is "qemu-system".
> + * @params: GArray with all TCP packet parameters.
> + */
> +static void handle_query_system(GArray *params, void *user_ctx)
> +{
> +    mcd_put_packet(MCD_SYSTEM_NAME);
> +}
> +
> +/**
> + * handle_query_cores() - Handler for the core query.
> + *
> + * This function sends the type of core and number of cores currently
> + * simulated by QEMU. It also sends a device name for the MCD data struc=
ture.
> + * @params: GArray with all TCP packet parameters.
> + */
> +static void handle_query_cores(GArray *params, void *user_ctx)
> +{
> +    /* get first cpu */
> +    CPUState *cpu =3D mcd_first_attached_cpu();
> +    if (!cpu) {
> +        return;
> +    }
> +
> +    ObjectClass *oc =3D object_get_class(OBJECT(cpu));
> +    const char *cpu_model =3D object_class_get_name(oc);
> +
> +    CPUClass *cc =3D CPU_GET_CLASS(cpu);
> +    const gchar *arch =3D cc->gdb_arch_name(cpu);
> +
> +    uint32_t nr_cores =3D cpu->nr_cores;
> +    char device_name[ARGUMENT_STRING_LENGTH] =3D {0};
> +    if (arch) {
> +        snprintf(device_name, sizeof(device_name), "qemu-%s-device", arc=
h);
> +    }
> +    g_string_printf(mcdserver_state.str_buf, "%s=3D%s.%s=3D%s.%s=3D%u.",
> +        TCP_ARGUMENT_DEVICE, device_name, TCP_ARGUMENT_CORE, cpu_model,
> +        TCP_ARGUMENT_AMOUNT_CORE, nr_cores);
> +    mcd_put_strbuf();
> +}
> +
>  /**
>   * init_query_cmds_table() - Initializes all query functions.
>   *
> @@ -671,7 +901,24 @@ static void mcd_chr_event(void *opaque, QEMUChrEvent=
 event)
>   * @mcd_query_cmds_table: Lookup table with all query commands.
>   */
>  static void init_query_cmds_table(MCDCmdParseEntry *mcd_query_cmds_table)
> -{}
> +{
> +    /* initalizes a list of all query commands */
> +    int cmd_number =3D 0;
> +
> +    MCDCmdParseEntry query_system =3D {
> +        .handler =3D handle_query_system,
> +        .cmd =3D QUERY_ARG_SYSTEM,
> +    };
> +    mcd_query_cmds_table[cmd_number] =3D query_system;
> +    cmd_number++;
> +
> +    MCDCmdParseEntry query_cores =3D {
> +        .handler =3D handle_query_cores,
> +        .cmd =3D QUERY_ARG_CORES,
> +    };
> +    mcd_query_cmds_table[cmd_number] =3D query_cores;
> +    cmd_number++;
> +}
>=20=20
>  /**
>   * mcd_set_stop_cpu() - Sets c_cpu to the just stopped CPU.
> @@ -924,3 +1171,124 @@ int mcdserver_start(const char *device)
>=20=20
>      return 0;
>  }
> +
> +void parse_reg_xml(const char *xml, int size, GArray* registers,
> +    uint8_t reg_type, uint32_t reg_id_offset)
> +{
> +    /* iterates over the complete xml file */
> +    int i, j;
> +    uint32_t current_reg_id =3D reg_id_offset;
> +    uint32_t internal_id =3D 0;
> +    int still_to_skip =3D 0;
> +    char argument[64] =3D {0};
> +    char value[64] =3D {0};
> +    bool is_reg =3D false;
> +    bool is_argument =3D false;
> +    bool is_value =3D false;
> +    GArray *reg_data =3D NULL;
> +
> +    char c;
> +    char *c_ptr;
> +
> +    xml_attrib attribute_j;
> +    const char *argument_j;
> +    const char *value_j;
> +
> +    for (i =3D 0; i < size; i++) {
> +        c =3D xml[i];
> +        c_ptr =3D &c;
> +
> +        if (still_to_skip > 0) {
> +            /* skip unwanted chars */
> +            still_to_skip--;
> +            continue;
> +        }
> +
> +        if (strncmp(&xml[i], "<reg", 4) =3D=3D 0) {
> +            /* start of a register */
> +            still_to_skip =3D 3;
> +            is_reg =3D true;
> +            reg_data =3D g_array_new(false, true, sizeof(xml_attrib));
> +        } else if (is_reg) {
> +            if (strncmp(&xml[i], "/>", 2) =3D=3D 0) {
> +                /* end of register info */
> +                still_to_skip =3D 1;
> +                is_reg =3D false;
> +
> +                /* create empty register */
> +                mcd_reg_st my_register =3D (const struct mcd_reg_st){ 0 =
};
> +
> +                /* add found attribtues */
> +                for (j =3D 0; j < reg_data->len; j++) {
> +                    attribute_j =3D g_array_index(reg_data, xml_attrib, =
j);
> +
> +                    argument_j =3D attribute_j.argument;
> +                    value_j =3D attribute_j.value;
> +
> +                    if (strcmp(argument_j, "name") =3D=3D 0) {
> +                        strcpy(my_register.name, value_j);
> +                    } else if (strcmp(argument_j, "regnum") =3D=3D 0) {
> +                        my_register.id =3D atoi(value_j);
> +                    } else if (strcmp(argument_j, "bitsize") =3D=3D 0) {
> +                        my_register.bitsize =3D atoi(value_j);
> +                    } else if (strcmp(argument_j, "type") =3D=3D 0) {
> +                        strcpy(my_register.type, value_j);
> +                    } else if (strcmp(argument_j, "group") =3D=3D 0) {
> +                        strcpy(my_register.group, value_j);
> +                    }
> +                }
> +                /* add reg_type, internal_id and id*/
> +                my_register.reg_type =3D reg_type;
> +                my_register.internal_id =3D internal_id;
> +                internal_id++;
> +                if (!my_register.id) {
> +                    my_register.id =3D current_reg_id;
> +                    current_reg_id++;
> +                } else {
> +                    /* set correct ID for the next register */
> +                    current_reg_id =3D my_register.id + 1;
> +                }
> +                /* store register */
> +                g_array_append_vals(registers, (gconstpointer)&my_regist=
er, 1);
> +                /* free memory */
> +                g_array_free(reg_data, false);
> +            } else {
> +                /* store info for register */
> +                switch (c) {
> +                case ' ':
> +                    break;
> +                case '=3D':
> +                    is_argument =3D false;
> +                    break;
> +                case '"':
> +                    if (is_value) {
> +                        /* end of value reached */
> +                        is_value =3D false;
> +                        /* store arg-val combo */
> +                        xml_attrib current_attribute;
> +                        strcpy(current_attribute.argument, argument);
> +                        strcpy(current_attribute.value, value);
> +                        g_array_append_vals(reg_data,
> +                        (gconstpointer)&current_attribute, 1);
> +                        memset(argument, 0, sizeof(argument));
> +                        memset(value, 0, sizeof(value));
> +                    } else {
> +                        /*start of value */
> +                        is_value =3D true;
> +                    }
> +                    break;
> +                default:
> +                    if (is_argument) {
> +                        strncat(argument, c_ptr, 1);
> +                    } else if (is_value) {
> +                        strncat(value, c_ptr, 1);
> +                    } else {
> +                        is_argument =3D true;
> +                        strncat(argument, c_ptr, 1);
> +                    }
> +                    break;
> +                }
> +            }
> +        }
> +    }
> +}
> diff --git a/debug/mcdstub/meson.build b/debug/mcdstub/meson.build
> index 7e5ae878b0..3051a4e731 100644
> --- a/debug/mcdstub/meson.build
> +++ b/debug/mcdstub/meson.build
> @@ -1,6 +1,6 @@
>  # only system emulation is supported over mcd
>  mcd_system_ss =3D ss.source_set()
> -mcd_system_ss.add(files('mcdstub.c'))
> +mcd_system_ss.add(files('mcdstub.c', 'arm_mcdstub.c'))
>  mcd_system_ss =3D mcd_system_ss.apply(config_host, strict: false)
>=20=20
>  libmcd_system =3D static_library('mcd_system',
> diff --git a/include/mcdstub/arm_mcdstub.h b/include/mcdstub/arm_mcdstub.h
> index c24aaf1202..9961145f07 100644
> --- a/include/mcdstub/arm_mcdstub.h
> +++ b/include/mcdstub/arm_mcdstub.h
> @@ -16,3 +16,88 @@
>   *
>   * SPDX-License-Identifier: LGPL-2.0+
>   */
> +
> +#ifndef ARM_MCDSTUB_H
> +#define ARM_MCDSTUB_H
> +
> +#include "hw/core/cpu.h"
> +#include "mcdstub_common.h"
> +/* just used for the register xml files */
> +#include "exec/gdbstub.h"
> +
> +/* ids for each different type of register */
> +enum {
> +    MCD_ARM_REG_TYPE_GPR,
> +    MCD_ARM_REG_TYPE_VFP,
> +    MCD_ARM_REG_TYPE_VFP_SYS,
> +    MCD_ARM_REG_TYPE_MVE,
> +    MCD_ARM_REG_TYPE_CPR,
> +};
> +
> +/**
> + * arm_mcd_store_mem_spaces() - Stores all 32-Bit ARM specific memory sp=
aces.
> + *
> + * This function stores the memory spaces into the memspaces GArray.
> + * It only stores secure memory spaces if the CPU has more than one addr=
ess
> + * space. It also stores a GPR and a CP15 register memory space.
> + * @memspaces: GArray of memory spaces.
> + * @cpu: CPU state.
> + */
> +int arm_mcd_store_mem_spaces(CPUState *cpu, GArray *memspaces);
> +
> +/**
> + * arm_mcd_parse_core_xml_file() - Parses the GPR registers.
> + *
> + * This function parses the core XML file, which includes the GPR regist=
ers.
> + * The regsters get stored in a GArray and a GPR register group is store=
d in a
> + * second GArray.
> + * @reggroups: GArray of register groups.
> + * @registers: GArray of registers.
> + * @cc: The CPU class.
> + * @current_group_id: The current group ID. It increases after
> + * each group.
> + */
> +int arm_mcd_parse_core_xml_file(CPUClass *cc, GArray *reggroups,
> +    GArray *registers, int *current_group_id);
> +
> +/**
> + * arm_mcd_parse_general_xml_files() - Parses all but the GPR registers.
> + *
> + * This function parses all XML files except for the core XML file.
> + * The regsters get stored in a GArray and if the system-registers.xml f=
ile is
> + * parsed, it also adds a CP15 register group.
> + * @reggroups: GArray of register groups.
> + * @registers: GArray of registers.
> + * @cpu: The CPU state.
> + * @current_group_id: The current group ID. It increases after
> + * each added group.
> + */
> +int arm_mcd_parse_general_xml_files(CPUState *cpu, GArray* reggroups,
> +    GArray *registers, int *current_group_id);
> +
> +/**
> + * arm_mcd_get_additional_register_info() - Adds additional data to pars=
ed
> + * registers.
> + *
> + * This function is called, after :c:func:`arm_mcd_parse_core_xml_file` =
and
> + * :c:func:`arm_mcd_parse_general_xml_files`. It adds additional data fo=
r all
> + * already parsed registers. The registers get a correct ID, group, memo=
ry
> + * space and opcode, if they are CP15 registers.
> + * @reggroups: GArray of register groups.
> + * @registers: GArray of registers.
> + * @cpu: The CPU state.
> + */
> +int arm_mcd_get_additional_register_info(GArray *reggroups, GArray *regi=
sters,
> +    CPUState *cpu);
> +
> +/**
> + * arm_mcd_get_opcode() - Returns the opcode for a coprocessor register.
> + *
> + * This function uses the opc1, opc2, crm and crn members of the registe=
r to
> + * create the opcode. The formular for creating the opcode is determined=
 by ARM.
> + * @n: The register ID of the CP register.
> + * @cs: CPU state.
> + */
> +uint16_t arm_mcd_get_opcode(CPUState *cs, uint32_t n);
> +
> +#endif /* ARM_MCDSTUB_H */
> diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
> index 26aa33c0e3..ac14b2cda8 100644
> --- a/include/mcdstub/mcdstub.h
> +++ b/include/mcdstub/mcdstub.h
> @@ -151,11 +151,6 @@ typedef struct MCDState {
>  /* lives in mcdstub.c */
>  extern MCDState mcdserver_state;
>=20=20
> -typedef struct xml_attrib {
> -    char argument[ARGUMENT_STRING_LENGTH];
> -    char value[ARGUMENT_STRING_LENGTH];
> -} xml_attrib;
> -
>  typedef struct mcd_reset_st {
>      const char *name;
>      uint8_t id;
> diff --git a/include/mcdstub/mcdstub_common.h b/include/mcdstub/mcdstub_c=
ommon.h
> index b64748c080..d6ff55005e 100644
> --- a/include/mcdstub/mcdstub_common.h
> +++ b/include/mcdstub/mcdstub_common.h
> @@ -61,4 +61,23 @@ typedef struct mcd_reg_group_st {
>      uint32_t id;
>  } mcd_reg_group_st;
>=20=20
> +typedef struct xml_attrib {
> +    char argument[ARGUMENT_STRING_LENGTH];
> +    char value[ARGUMENT_STRING_LENGTH];
> +} xml_attrib;
> +
> +/**
> + * parse_reg_xml() -  Parses a GDB register XML file
> + *
> + * This fuction extracts all registers from the provided xml file and st=
ores
> + * them into the registers GArray. It extracts the register name, bitsiz=
e, type
> + * and group if they are set.
> + * @xml: String with contents of the XML file.
> + * @registers: GArray with stored registers.
> + * @reg_type: Register type (depending on file).
> + * @size: Number of characters in the xml string.
> + */
> +void parse_reg_xml(const char *xml, int size, GArray* registers,
> +    uint8_t reg_type, uint32_t reg_id_offset);
> +
>  #endif /* MCDSTUB_COMMON_H */

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

