Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F35CC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 10:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI4Wy-0005kb-P2; Fri, 14 Jun 2024 06:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI4Ww-0005k0-I7
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 06:51:38 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI4Wt-0005Ls-Qi
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 06:51:38 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35f275c7286so1885742f8f.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 03:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718362294; x=1718967094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IgcYsH0om2C9kNUParMmYNYCWpcNEO1WrzjaQmvho48=;
 b=DXcAzDL5rlp0s5yYVHYnGOnha0TASMlzSI42uiWBvFwzrpZe21tLzu34Irtj7lg76t
 wqBA4ecYXVvGOljHu1a5iLZaKVTuMtkTcApGkVlXqcKlD6fhH66pLPbSeRzj8um+3KIV
 WG67ma+WPODsHSgsQlt60KPVAUeJWIsAIIRLeImG86+gyjL0R7tuBUuEy4Zl0pFoXJZO
 gKsEkp0S0AC5JEERGiTufBFCsLfZkgmzP+MpHNKQOrP6AocTe/cKon0stn5uZ+Pn/6tV
 uXgz7pmcsQVTJNcdQjYyWFNBghSdZSXa82y6+2HM5hmUGRtk7mUZsCfIYPSOz2/XSChF
 /5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718362294; x=1718967094;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IgcYsH0om2C9kNUParMmYNYCWpcNEO1WrzjaQmvho48=;
 b=VWnA4dlfGtAEj/HoD98aSnwZwLpZoPlPoOT4vHBeER39XTtUze8KkP2R8p3nccxckZ
 NGdbEa+G6/N7Ttr6NwdpAMl8cuSsC9j3jzkB7puZjEGMwP003C3ubs6OnOJSf6kI4xZc
 Vja5L40LGUwqKuplZIMlD4q7xfNU6PkH5QuV1OTXT9JWVgHu9xpojwcPs6giJwQyg2ep
 uY23cmNvPNq7D6Oc68X9hj0OhN35F1yfp/7Rf9HtqHyg3U7TxXfv2NGJUHXiqICi23Je
 snqcRw9adv1JiQNJkM/9/Ds8GNQ35BTWqPv7CzCeEs1zirotZtfPlxUEVC7thWFH1RWk
 llEw==
X-Gm-Message-State: AOJu0Yz02oDmlcwkw6lDUaz07tbcvYIlMSmeX+Th/yDwYEDy2p7BWfTp
 bb0Ewm51CDlJoUw0iKF0WYbE21N124pqcmQM1HHvnEA6udTcdtvWUzbCD6HyM1U=
X-Google-Smtp-Source: AGHT+IGajmC4fOBkPNnr4UES+oB8+YjT08W1l6e6e89abn61LZgRhrJSzT2T4VRcvAziaBXrcVnNvQ==
X-Received: by 2002:a05:6000:1f8a:b0:360:86ac:d765 with SMTP id
 ffacd0b85a97d-36086acd8abmr148944f8f.17.1718362293935; 
 Fri, 14 Jun 2024 03:51:33 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075093a3fsm4109370f8f.1.2024.06.14.03.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 03:51:33 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F2E845F794;
 Fri, 14 Jun 2024 11:51:32 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH v2 8/9] gdbstub: Add support for MTE in user mode
In-Reply-To: <20240613172103.2987519-9-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 13 Jun 2024 17:21:02 +0000")
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-9-gustavo.romero@linaro.org>
Date: Fri, 14 Jun 2024 11:51:32 +0100
Message-ID: <87le37vlu3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> This commit implements the stubs to handle the qIsAddressTagged,
> qMemTag, and QMemTag GDB packets, allowing all GDB 'memory-tag'
> subcommands to work with QEMU gdbstub on aarch64 user mode. It also
> implements the get/set functions for the special GDB MTE register
> 'tag_ctl', used to control the MTE fault type at runtime.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  configs/targets/aarch64-linux-user.mak |   2 +-
>  gdb-xml/aarch64-mte.xml                |  11 ++
>  target/arm/cpu.c                       |   1 +
>  target/arm/gdbstub.c                   | 253 +++++++++++++++++++++++++
>  target/arm/internals.h                 |   2 +
>  5 files changed, 268 insertions(+), 1 deletion(-)
>  create mode 100644 gdb-xml/aarch64-mte.xml
>
> diff --git a/configs/targets/aarch64-linux-user.mak b/configs/targets/aar=
ch64-linux-user.mak
> index ba8bc5fe3f..8f0ed21d76 100644
> --- a/configs/targets/aarch64-linux-user.mak
> +++ b/configs/targets/aarch64-linux-user.mak
> @@ -1,6 +1,6 @@
>  TARGET_ARCH=3Daarch64
>  TARGET_BASE_ARCH=3Darm
> -TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb=
-xml/aarch64-pauth.xml
> +TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb=
-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml
>  TARGET_HAS_BFLT=3Dy
>  CONFIG_SEMIHOSTING=3Dy
>  CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
> diff --git a/gdb-xml/aarch64-mte.xml b/gdb-xml/aarch64-mte.xml
> new file mode 100644
> index 0000000000..4b70b4f17a
> --- /dev/null
> +++ b/gdb-xml/aarch64-mte.xml
> @@ -0,0 +1,11 @@
> +<?xml version=3D"1.0"?>
> +<!-- Copyright (C) 2021-2023 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name=3D"org.gnu.gdb.aarch64.mte">
> +  <reg name=3D"tag_ctl" bitsize=3D"64" type=3D"uint64" group=3D"system" =
save-restore=3D"no"/>
> +</feature>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 35fa281f1b..14d4eca127 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2518,6 +2518,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>=20=20
>      register_cp_regs_for_features(cpu);
>      arm_cpu_register_gdb_regs_for_features(cpu);
> +    arm_cpu_register_gdb_commands(cpu);
>=20=20
>      init_cpreg_list(cpu);
>=20=20
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index a3bb73cfa7..1cbcd6fa98 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -21,10 +21,13 @@
>  #include "cpu.h"
>  #include "exec/gdbstub.h"
>  #include "gdbstub/helpers.h"
> +#include "gdbstub/commands.h"
>  #include "sysemu/tcg.h"
>  #include "internals.h"
>  #include "cpu-features.h"
>  #include "cpregs.h"
> +#include "mte.h"
> +#include "tcg/mte_helper.h"
>=20=20
>  typedef struct RegisterSysregFeatureParam {
>      CPUState *cs;
> @@ -474,6 +477,246 @@ static GDBFeature *arm_gen_dynamic_m_secextreg_feat=
ure(CPUState *cs,
>  #endif
>  #endif /* CONFIG_TCG */
>=20=20
> +#ifdef TARGET_AARCH64
> +#ifdef CONFIG_USER_ONLY
> +static int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, struct _GByteArray =
*buf, int reg)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +    CPUARMState *env =3D &cpu->env;
> +    uint64_t tcf0;
> +
> +    assert(reg =3D=3D 0);
> +
> +    tcf0 =3D extract64(env->cp15.sctlr_el[1], 38, 2);
> +
> +    return gdb_get_reg64(buf, tcf0);
> +}
> +
> +static int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int r=
eg)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +    CPUARMState *env =3D &cpu->env;
> +
> +    uint8_t tcf;
> +
> +    assert(reg =3D=3D 0);
> +
> +    tcf =3D *buf << PR_MTE_TCF_SHIFT;
> +
> +    if (!tcf) {
> +        return 0;
> +    }
> +
> +    /*
> +     * 'tag_ctl' register is actually a "pseudo-register" provided by GD=
B to
> +     * expose options regarding the type of MTE fault that can be contro=
lled at
> +     * runtime.
> +     */
> +    set_mte_tcf0(env, tcf);
> +
> +    return 1;
> +}
> +
> +static void handle_q_memtag(GArray *params, G_GNUC_UNUSED void *user_ctx)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(gdb_first_attached_cpu());
> +    CPUARMState *env =3D &cpu->env;
> +
> +    uint64_t addr =3D gdb_get_cmd_param(params, 0)->val_ull;
> +    uint64_t len =3D gdb_get_cmd_param(params, 1)->val_ul;
> +    int type =3D gdb_get_cmd_param(params, 2)->val_ul;
> +
> +    uint8_t *tags;
> +    uint8_t addr_tag;
> +
> +    g_autoptr(GString) str_buf =3D g_string_new(NULL);
> +
> +    /*
> +     * GDB does not query multiple tags for a memory range on remote tar=
gets, so
> +     * that's not supported either by gdbstub.
> +     */
> +    if (len !=3D 1) {
> +        gdb_put_packet("E02");
> +    }
> +
> +    /* GDB never queries a tag different from an allocation tag (type 1)=
. */
> +    if (type !=3D 1) {
> +        gdb_put_packet("E03");
> +    }
> +
> +    /* Note that tags are packed here (2 tags packed in one byte). */
> +    tags =3D allocation_tag_mem_probe(env, 0, addr, MMU_DATA_LOAD, 8 /* =
64-bit */,
> +                                    MMU_DATA_LOAD, true, 0);
> +    if (!tags) {
> +        /* Address is not in a tagged region. */
> +        gdb_put_packet("E04");
> +        return;
> +    }
> +
> +    /* Unpack tag from byte. */
> +    addr_tag =3D load_tag1(addr, tags);
> +    g_string_printf(str_buf, "m%.2x", addr_tag);
> +
> +    gdb_put_packet(str_buf->str);
> +}
> +
> +static void handle_q_isaddresstagged(GArray *params, G_GNUC_UNUSED void =
*user_ctx)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(gdb_first_attached_cpu());
> +    CPUARMState *env =3D &cpu->env;
> +
> +    uint64_t addr =3D gdb_get_cmd_param(params, 0)->val_ull;
> +
> +    uint8_t *tags;
> +    const char *reply;
> +
> +    tags =3D allocation_tag_mem_probe(env, 0, addr, MMU_DATA_LOAD, 8 /* =
64-bit */,
> +                                    MMU_DATA_LOAD, true, 0);
> +    reply =3D tags ? "01" : "00";
> +
> +    gdb_put_packet(reply);
> +}
> +
> +static void handle_Q_memtag(GArray *params, G_GNUC_UNUSED void *user_ctx)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(gdb_first_attached_cpu());
> +    CPUARMState *env =3D &cpu->env;
> +
> +    uint64_t start_addr =3D gdb_get_cmd_param(params, 0)->val_ull;
> +    uint64_t len =3D gdb_get_cmd_param(params, 1)->val_ul;
> +    int type =3D gdb_get_cmd_param(params, 2)->val_ul;
> +    char const *new_tags_str =3D gdb_get_cmd_param(params, 3)->data;
> +
> +    uint64_t end_addr;
> +
> +    int num_new_tags;
> +    uint8_t *tags;
> +
> +    g_autoptr(GByteArray) new_tags =3D g_byte_array_new();
> +
> +    /*
> +     * Only the allocation tag (i.e. type 1) can be set at the stub side.
> +     */
> +    if (type !=3D 1) {
> +        gdb_put_packet("E02");
> +        return;
> +    }
> +
> +    end_addr =3D start_addr + (len - 1); /* 'len' is always >=3D 1 */
> +    /* Check if request's memory range does not cross page boundaries. */
> +    if ((start_addr ^ end_addr) & TARGET_PAGE_MASK) {
> +        gdb_put_packet("E03");
> +        return;
> +    }
> +
> +    /*
> +     * Get all tags in the page starting from the tag of the start addre=
ss.
> +     * Note that there are two tags packed into a single byte here.
> +     */
> +    tags =3D allocation_tag_mem_probe(env, 0, start_addr, MMU_DATA_STORE,
> +                                    8 /* 64-bit */, MMU_DATA_STORE, true=
, 0);
> +    if (!tags) {
> +        /* Address is not in a tagged region. */
> +        gdb_put_packet("E04");
> +        return;
> +    }
> +
> +    /* Convert tags provided by GDB, 2 hex digits per tag. */
> +    num_new_tags =3D strlen(new_tags_str) / 2;
> +    gdb_hextomem(new_tags, new_tags_str, num_new_tags);
> +
> +    uint64_t address =3D start_addr;
> +    int new_tag_index =3D 0;
> +    while (address <=3D end_addr) {
> +        uint8_t new_tag;
> +        int packed_index;
> +
> +        /*
> +         * Find packed tag index from unpacked tag index. There are two =
tags
> +         * in one packed index (one tag per nibble).
> +         */
> +        packed_index =3D new_tag_index / 2;
> +
> +        new_tag =3D new_tags->data[new_tag_index % num_new_tags];
> +        store_tag1(address, tags + packed_index, new_tag);
> +
> +        address +=3D TAG_GRANULE;
> +        new_tag_index++;
> +    }
> +
> +    gdb_put_packet("OK");
> +}
> +
> +enum Command {
> +    qMemTags,
> +    qIsAddressTagged,
> +    QMemTags,
> +    NUM_CMDS
> +};
> +
> +static GdbCmdParseEntry cmd_handler_table[NUM_CMDS] =3D {
> +    [qMemTags] =3D {
> +        .handler =3D handle_q_memtag,
> +        .cmd_startswith =3D 1,
> +        .cmd =3D "MemTags:",
> +        .schema =3D "L,l:l0"
> +    },
> +    [qIsAddressTagged] =3D {
> +        .handler =3D handle_q_isaddresstagged,
> +        .cmd_startswith =3D 1,
> +        .cmd =3D "IsAddressTagged:",
> +        .schema =3D "L0"
> +    },
> +    [QMemTags] =3D {
> +        .handler =3D handle_Q_memtag,
> +        .cmd_startswith =3D 1,
> +        .cmd =3D "MemTags:",
> +        .schema =3D "L,l:l:s0"
> +    },
> +};
> +#endif /* CONFIG_USER_ONLY */
> +#endif /* TARGET_AARCH64 */
> +
> +void arm_cpu_register_gdb_commands(ARMCPU *cpu)
> +{
> +    GArray *query_table =3D
> +        g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
> +    GArray *set_table =3D
> +        g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
> +    GString *qsupported_features =3D g_string_new(NULL);
> +
> +#ifdef CONFIG_USER_ONLY
> +    /* MTE */
> +    if (cpu_isar_feature(aa64_mte3, cpu)) {
> +        g_string_append(qsupported_features, ";memory-tagging+");
> +
> +        g_array_append_val(query_table, cmd_handler_table[qMemTags]);
> +        g_array_append_val(query_table, cmd_handler_table[qIsAddressTagg=
ed]);
> +
> +        g_array_append_val(set_table, cmd_handler_table[QMemTags]);
> +    }
> +#endif

This fails:

  FAILED: libqemu-arm-linux-user.fa.p/target_arm_gdbstub.c.o=20
  cc -m64 -Ilibqemu-arm-linux-user.fa.p -I. -I../.. -Itarget/arm -I../../ta=
rget/arm -I../../common-user/host/x86_64 -I../../linux-user/include/host/x8=
6_64 -I../../linux-user/include -Ilinux-user -I../../linux-user -Ilinux-use=
r/arm -I../../linux-user/arm -Iqapi -Itrace -Iui -Iui/shader -I/usr/include=
/capstone -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/incl=
ude -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2=
 -g -fstack-protector-strong -Wempty-body -Wendif-labels -Wexpansion-to-def=
ined -Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthr=
ough=3D2 -Winit-self -Wmissing-format-attribute -Wmissing-prototypes -Wnest=
ed-externs -Wold-style-declaration -Wold-style-definition -Wredundant-decls=
 -Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-s=
trings -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value -isys=
tem /home/alex/lsrc/qemu.git/linux-headers -isystem linux-headers -iquote .=
 -iquote /home/alex/lsrc/qemu.git -iquote /home/alex/lsrc/qemu.git/include =
-iquote /home/alex/lsrc/qemu.git/host/include/x86_64 -iquote /home/alex/lsr=
c/qemu.git/host/include/generic -iquote /home/alex/lsrc/qemu.git/tcg/i386 -=
pthread -mcx16 -mpopcnt -msse4.2 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_=
LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-va=
r-init=3Dzero -fzero-call-used-regs=3Dused-gpr -fPIE -isystem../../linux-he=
aders -isystemlinux-headers -DCOMPILING_PER_TARGET '-DCONFIG_TARGET=3D"arm-=
linux-user-config-target.h"' '-DCONFIG_DEVICES=3D"arm-linux-user-config-dev=
ices.h"' -MD -MQ libqemu-arm-linux-user.fa.p/target_arm_gdbstub.c.o -MF lib=
qemu-arm-linux-user.fa.p/target_arm_gdbstub.c.o.d -o libqemu-arm-linux-user=
.fa.p/target_arm_gdbstub.c.o -c ../../target/arm/gdbstub.c
  In file included from /usr/include/glib-2.0/glib.h:33,
                   from /home/alex/lsrc/qemu.git/include/glib-compat.h:32,
                   from /home/alex/lsrc/qemu.git/include/qemu/osdep.h:161,
                   from ../../target/arm/gdbstub.c:20:
  ../../target/arm/gdbstub.c: In function =E2=80=98arm_cpu_register_gdb_com=
mands=E2=80=99:
  ../../target/arm/gdbstub.c:693:41: error: =E2=80=98cmd_handler_table=E2=
=80=99 undeclared (first use in this function)
    693 |         g_array_append_val(query_table, cmd_handler_table[qMemTag=
s]);
        |                                         ^~~~~~~~~~~~~~~~~
  /usr/include/glib-2.0/glib/garray.h:66:61: note: in definition of macro =
=E2=80=98g_array_append_val=E2=80=99
     66 | #define g_array_append_val(a,v)   g_array_append_vals (a, &(v), 1)
        |                                                             ^
  ../../target/arm/gdbstub.c:693:41: note: each undeclared identifier is re=
ported only once for each function it appears in
    693 |         g_array_append_val(query_table, cmd_handler_table[qMemTag=
s]);
        |                                         ^~~~~~~~~~~~~~~~~
  /usr/include/glib-2.0/glib/garray.h:66:61: note: in definition of macro =
=E2=80=98g_array_append_val=E2=80=99
     66 | #define g_array_append_val(a,v)   g_array_append_vals (a, &(v), 1)
        |                                                             ^
  ../../target/arm/gdbstub.c:693:59: error: =E2=80=98qMemTags=E2=80=99 unde=
clared (first use in this function)
    693 |         g_array_append_val(query_table, cmd_handler_table[qMemTag=
s]);
        |                                                           ^~~~~~~~
  /usr/include/glib-2.0/glib/garray.h:66:61: note: in definition of macro =
=E2=80=98g_array_append_val=E2=80=99
     66 | #define g_array_append_val(a,v)   g_array_append_vals (a, &(v), 1)
        |                                                             ^
  ../../target/arm/gdbstub.c:694:59: error: =E2=80=98qIsAddressTagged=E2=80=
=99 undeclared (first use in this function)
    694 |         g_array_append_val(query_table, cmd_handler_table[qIsAddr=
essTagged]);
        |                                                           ^~~~~~~=
~~~~~~~~~
  /usr/include/glib-2.0/glib/garray.h:66:61: note: in definition of macro =
=E2=80=98g_array_append_val=E2=80=99
     66 | #define g_array_append_val(a,v)   g_array_append_vals (a, &(v), 1)
        |                                                             ^
  ../../target/arm/gdbstub.c:696:57: error: =E2=80=98QMemTags=E2=80=99 unde=
clared (first use in this function)
    696 |         g_array_append_val(set_table, cmd_handler_table[QMemTags]=
);
        |                                                         ^~~~~~~~
  /usr/include/glib-2.0/glib/garray.h:66:61: note: in definition of macro =
=E2=80=98g_array_append_val=E2=80=99
     66 | #define g_array_append_val(a,v)   g_array_append_vals (a, &(v), 1)
        |                                                             ^
  In file included from ../../target/arm/gdbstub.c:29:
  ../../target/arm/mte.h: At top level:
  ../../target/arm/mte.h:27:13: error: =E2=80=98set_mte_tcf0=E2=80=99 defin=
ed but not used [-Werror=3Dunused-function]
     27 | static void set_mte_tcf0(CPUArchState *env, abi_long value)
        |             ^~~~~~~~~~~~
  cc1: all warnings being treated as errors

As the command handler table has a different set of ifdef protections to
the fill code. However I think it might be easier to move all these bits
over to gdbstub64.c which is implicitly TARGET_AARCH64.

I would suggest keeping arm_cpu_register_gdb_commands but add something
like:

    if (arm_feature(env, ARM_FEATURE_AARCH64)) {
    #ifdef TARGET_AARCH64
           aarch64_cpu_register_gdb_commands(...)
    #endif
    }

to setup the Aarch64 MTE specific bits.

> +
> +    /* Set arch-specific handlers for 'q' commands. */
> +    if (query_table->len) {
> +        gdb_extend_query_table(&g_array_index(query_table,
> +                                              GdbCmdParseEntry, 0),
> +                                              query_table->len);
> +    }
> +
> +    /* Set arch-specific handlers for 'Q' commands. */
> +    if (set_table->len) {
> +        gdb_extend_set_table(&g_array_index(set_table,
> +                             GdbCmdParseEntry, 0),
> +                             set_table->len);
> +    }
> +
> +    /* Set arch-specific qSupported feature. */
> +    if (qsupported_features->len) {
> +        gdb_extend_qsupported_features(qsupported_features->str);
> +    }
> +}
> +
>  void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
>  {
>      CPUState *cs =3D CPU(cpu);
> @@ -507,6 +750,16 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *=
cpu)
>                                       gdb_find_static_feature("aarch64-pa=
uth.xml"),
>                                       0);
>          }
> +
> +#ifdef CONFIG_USER_ONLY
> +        /* Memory Tagging Extension (MTE) 'tag_ctl' pseudo-register. */
> +        if (cpu_isar_feature(aa64_mte, cpu)) {
> +            gdb_register_coprocessor(cs, aarch64_gdb_get_tag_ctl_reg,
> +                                     aarch64_gdb_set_tag_ctl_reg,
> +                                     gdb_find_static_feature("aarch64-mt=
e.xml"),
> +                                     0);
> +        }
> +#endif
>  #endif
>      } else {
>          if (arm_feature(env, ARM_FEATURE_NEON)) {
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 11b5da2562..e27a9fa1e0 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -358,6 +358,8 @@ void init_cpreg_list(ARMCPU *cpu);
>  void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
>  void arm_translate_init(void);
>=20=20
> +void arm_cpu_register_gdb_commands(ARMCPU *cpu);
> +
>  void arm_restore_state_to_opc(CPUState *cs,
>                                const TranslationBlock *tb,
>                                const uint64_t *data);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

