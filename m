Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4864C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 15:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ6BX-0004pP-62; Fri, 13 Jun 2025 11:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uQ6BU-0004n6-JK
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 11:19:12 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uQ6BS-00039P-2m
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 11:19:12 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-234b440afa7so22712985ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749827948; x=1750432748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TASCar+QIcRCEKos7HPghKU5Bc6Pdq03w300XZ5NTN8=;
 b=OvodSbhVHFIqxXeRBSGSV44myujnQ97nWQpIw244osOnqfPfMdLTPxbdaGib/uW4DD
 u7Q2fDbsSI7x/DX42uaDwRxtnbdnByqmYWEU+v4LugKXBKuCQboCJ6R85PV80BBGLA4R
 4tCJuTDAzZg3y8fvb5OSv4VaKvHlEfrQWxqx09dwJcqVPajAWqM0y6lsqjCAnintEErl
 FWjujTLWqaQA2RkW4rpTVG4LQiJbrYVIuGb4xUYwIEawWXu7iEqBNg+E2/osHlOOiHME
 cWGBcpv8vdeicD0A6jY5AyaWQeRDuqtJXEwtC/uFD5rSk7zwy8H4J+wxhjAU17lHAvCG
 h1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749827948; x=1750432748;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TASCar+QIcRCEKos7HPghKU5Bc6Pdq03w300XZ5NTN8=;
 b=KlY4LWgAFfUQ23LV/aBWGrDBU6qTbCayTQG2eGwrG33S7HvOtZlmrHWFUItP24M9g6
 k468I4V++od9MQUKRydO/xSEx4UA9EOlh3rn6IPmN2fF0/Z91choBl7o0s/P635jWXd7
 n2A6SXWhqPrPBYWrqCcyZymH6DzlUTdZGfou3sivz2+n2H+KsauY0LKEDoIxyEh7z4Sp
 rKs+dYVFi4hs7LJ2lhPjY+xdN2xIFaOF/wo4XygNUoA8yh6MC6EK59D4eum3LBxLuQK+
 e9HSiFmy7wo2Jn2AAHGIyDyHXninjEXzpdwrmlAodwM54Ct/jF60DHMFgQ0GWlyHtYHw
 tcyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4jbhhuSUJrdkPA5k0oK/9N+PglCnApyBJpywCKS5vuugk9fBwWpcKL1SYSrD/JSHmceQ83VpN/iSI@nongnu.org
X-Gm-Message-State: AOJu0YzLhG2KNrX8cvJcTDQVPJGI/rrgVIZuqvCuZRyqnWq0BrzoWJZJ
 m6gRrtxXgIKIQmp1SljfbEljznJkebWLoQSG0SXPkr/CCrNIEBjGH60BgN2gAJY9luY=
X-Gm-Gg: ASbGncs1OrWaMUp2m4H5AADS/3cMa5jtMaQYpO+/46pi2HNP8jb8MseT32TD7MHIAhS
 h7YDAOnqLAPOWg7by0IbZ87Walup4GHqo9f7Lxd/X2qy05EqcWMAonDi3g1YM+PkqrWfS6Sfycn
 4mrJ8JOMXCDssKhb2hNP/eiPQ6PcPIgvuLN4nruGnQ0OfsENUlo4bYTIWZ3wDo/4SPo7Nc7/FGL
 gKNPtQpgXIFf5UWAZUu68ksrgOfuNQMS+ky5VMGFMZkW4h/becpmkrd/dhO5BCfORfpngicUIee
 wiDojJwSk6HZpRbfcM751RYCwnyoZ8QATeVGMCHAdqDjoplK3neTCkYIaVmwOZ1/SqYmls2mTNM
 =
X-Google-Smtp-Source: AGHT+IEc/l5eEFawTZUjLQjMgriAWMpzwp55BAai+R30AMr/Os4Q7ilcN9Epp/jOeYBFw3eLkR+pYg==
X-Received: by 2002:a17:903:234a:b0:234:e8db:432d with SMTP id
 d9443c01a7336-2365dd3f60amr46086795ad.39.1749827947923; 
 Fri, 13 Jun 2025 08:19:07 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-313c19b771esm3503912a91.9.2025.06.13.08.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Jun 2025 08:19:07 -0700 (PDT)
Message-ID: <45e636bc-a2e0-42da-9f71-24b2ccdc9072@linaro.org>
Date: Fri, 13 Jun 2025 08:19:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 6/7] plugins: Add patcher plugin and test
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250611232409.2936521-1-rowanbhart@gmail.com>
 <20250611232409.2936521-7-rowanbhart@gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250611232409.2936521-7-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 6/11/25 4:24 PM, Rowan Hart wrote:
> From: novafacing <rowanbhart@gmail.com>
> 
> This patch adds a plugin that exercises the virtual and hardware memory
> read-write API functions added in a previous patch. The plugin takes a
> target and patch byte sequence, and will overwrite any instruction
> matching the target byte sequence with the patch.
> 
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   tests/tcg/Makefile.target                 |   1 +
>   tests/tcg/plugins/meson.build             |   2 +-
>   tests/tcg/plugins/patch.c                 | 241 ++++++++++++++++++++++
>   tests/tcg/x86_64/Makefile.softmmu-target  |  32 ++-
>   tests/tcg/x86_64/system/patch-target.c    |  27 +++
>   tests/tcg/x86_64/system/validate-patch.py |  39 ++++
>   6 files changed, 336 insertions(+), 6 deletions(-)
>   create mode 100644 tests/tcg/plugins/patch.c
>   create mode 100644 tests/tcg/x86_64/system/patch-target.c
>   create mode 100755 tests/tcg/x86_64/system/validate-patch.py
> 
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index 95ff76ea44..4b709a9d18 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -176,6 +176,7 @@ RUN_TESTS+=$(EXTRA_RUNS)
>   # Some plugins need additional arguments above the default to fully
>   # exercise things. We can define them on a per-test basis here.
>   run-plugin-%-with-libmem.so: PLUGIN_ARGS=$(COMMA)inline=true
> +run-plugin-%-with-libpatch.so: PLUGIN_ARGS=$(COMMA)target=ffffffff$(COMMA)patch=00000000
>   
>   ifeq ($(filter %-softmmu, $(TARGET)),)
>   run-%: %
> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
> index 41f02f2c7f..163042e601 100644
> --- a/tests/tcg/plugins/meson.build
> +++ b/tests/tcg/plugins/meson.build
> @@ -1,6 +1,6 @@
>   t = []
>   if get_option('plugins')
> -  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall']
> +  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
>       if host_os == 'windows'
>         t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
>                           include_directories: '../../../include/qemu',
> diff --git a/tests/tcg/plugins/patch.c b/tests/tcg/plugins/patch.c
> new file mode 100644
> index 0000000000..450fc51c88
> --- /dev/null
> +++ b/tests/tcg/plugins/patch.c
> @@ -0,0 +1,241 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This plugin patches instructions matching a pattern to a different
> + * instruction as they execute
> + *
> + */
> +
> +#include "glib.h"
> +#include "glibconfig.h"
> +
> +#include <qemu-plugin.h>
> +#include <string.h>
> +#include <stdio.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> +
> +static bool use_hwaddr;
> +static GByteArray *target_data;
> +static GByteArray *patch_data;
> +
> +/**
> + * Parse a string of hexadecimal digits into a GByteArray. The string must be
> + * even length
> + */
> +static GByteArray *str_to_bytes(const char *str)
> +{
> +    size_t len = strlen(str);
> +
> +    if (len == 0 || len % 2 != 0) {
> +        return NULL;
> +    }
> +
> +    GByteArray *bytes = g_byte_array_new();
> +    char byte[3] = {0};
> +    guint8 value = 0;
> +
> +    for (size_t i = 0; i < len; i += 2) {
> +        byte[0] = str[i];
> +        byte[1] = str[i + 1];
> +        value = (guint8)g_ascii_strtoull(byte, NULL, 16);
> +        g_byte_array_append(bytes, &value, 1);
> +    }
> +
> +    return bytes;
> +}
> +
> +static void patch_hwaddr(unsigned int vcpu_index, void *userdata)
> +{
> +    uint64_t addr = (uint64_t)userdata;
> +    g_autoptr(GString) str = g_string_new(NULL);
> +    g_string_printf(str, "patching: @0x%"
> +                    PRIx64 "\n",
> +                    addr);
> +    qemu_plugin_outs(str->str);
> +
> +    enum qemu_plugin_hwaddr_operation_result result =
> +        qemu_plugin_write_memory_hwaddr(addr, patch_data);
> +
> +
> +    if (result != QEMU_PLUGIN_HWADDR_OPERATION_OK) {
> +        g_autoptr(GString) errmsg = g_string_new(NULL);
> +        g_string_printf(errmsg, "Failed to write memory: %d\n", result);
> +        qemu_plugin_outs(errmsg->str);
> +        return;
> +    }
> +
> +    GByteArray *read_data = g_byte_array_new();
> +
> +    result = qemu_plugin_read_memory_hwaddr(addr, read_data,
> +                                            patch_data->len);
> +
> +    qemu_plugin_outs("Reading memory...\n");
> +
> +    if (result != QEMU_PLUGIN_HWADDR_OPERATION_OK) {
> +        g_autoptr(GString) errmsg = g_string_new(NULL);
> +        g_string_printf(errmsg, "Failed to read memory: %d\n", result);
> +        qemu_plugin_outs(errmsg->str);
> +        return;
> +    }
> +
> +    if (memcmp(patch_data->data, read_data->data, patch_data->len) != 0) {
> +        qemu_plugin_outs("Failed to read back written data\n");
> +    }
> +
> +    qemu_plugin_outs("Success!\n");
> +
> +    return;
> +}
> +
> +static void patch_vaddr(unsigned int vcpu_index, void *userdata)
> +{
> +    uint64_t addr = (uint64_t)userdata;
> +    uint64_t hwaddr = 0;
> +    if (!qemu_plugin_translate_vaddr(addr, &hwaddr)) {
> +        qemu_plugin_outs("Failed to translate vaddr\n");
> +        return;
> +    }
> +    g_autoptr(GString) str = g_string_new(NULL);
> +    g_string_printf(str, "patching: @0x%"
> +                    PRIx64 " hw: @0x%" PRIx64 "\n",
> +                    addr, hwaddr);
> +    qemu_plugin_outs(str->str);
> +
> +    qemu_plugin_outs("Writing memory (vaddr)...\n");
> +
> +    if (!qemu_plugin_write_memory_vaddr(addr, patch_data)) {
> +        qemu_plugin_outs("Failed to write memory\n");
> +        return;
> +    }
> +
> +    qemu_plugin_outs("Reading memory (vaddr)...\n");
> +
> +    g_autoptr(GByteArray) read_data = g_byte_array_new();
> +
> +    if (!qemu_plugin_read_memory_vaddr(addr, read_data, patch_data->len)) {
> +        qemu_plugin_outs("Failed to read memory\n");
> +        return;
> +    }
> +
> +    if (memcmp(patch_data->data, read_data->data, patch_data->len) != 0) {
> +        qemu_plugin_outs("Failed to read back written data\n");
> +    }
> +
> +    qemu_plugin_outs("Success!\n");
> +
> +    return;
> +}
> +
> +/*
> + * Callback on translation of a translation block.
> + */
> +static void vcpu_tb_trans_cb(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> +{
> +    uint64_t addr = 0;
> +    g_autoptr(GByteArray) insn_data = g_byte_array_new();
> +    for (size_t i = 0; i < qemu_plugin_tb_n_insns(tb); i++) {
> +        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> +
> +        if (use_hwaddr) {
> +            uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
> +            if (!qemu_plugin_translate_vaddr(vaddr, &addr)) {
> +                qemu_plugin_outs("Failed to translate vaddr\n");
> +                continue;
> +            }
> +        } else {
> +            addr = qemu_plugin_insn_vaddr(insn);
> +        }
> +
> +        g_byte_array_set_size(insn_data, qemu_plugin_insn_size(insn));
> +        qemu_plugin_insn_data(insn, insn_data->data, insn_data->len);
> +
> +        if (insn_data->len >= target_data->len &&
> +            !memcmp(insn_data->data, target_data->data,
> +                    MIN(target_data->len, insn_data->len))) {
> +            if (use_hwaddr) {
> +                qemu_plugin_register_vcpu_tb_exec_cb(tb, patch_hwaddr,
> +                                                     QEMU_PLUGIN_CB_NO_REGS,
> +                                                     (void *)addr);
> +            } else {
> +                qemu_plugin_register_vcpu_tb_exec_cb(tb, patch_vaddr,
> +                                                     QEMU_PLUGIN_CB_NO_REGS,
> +                                                     (void *)addr);
> +            }
> +        }
> +    }
> +}
> +
> +static void usage(void)
> +{
> +    fprintf(stderr, "Usage: <lib>,target=<bytes>,patch=<new_bytes>"
> +            "[,use_hwaddr=true|false]");
> +}
> +
> +/*
> + * Called when the plugin is installed
> + */
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info, int argc,
> +                                           char **argv)
> +{
> +
> +    use_hwaddr = true;
> +    target_data = NULL;
> +    patch_data = NULL;
> +
> +    if (argc > 4) {
> +        usage();
> +        return -1;
> +    }
> +
> +    for (size_t i = 0; i < argc; i++) {
> +        char *opt = argv[i];
> +        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
> +        if (g_strcmp0(tokens[0], "use_hwaddr") == 0) {
> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &use_hwaddr)) {
> +                fprintf(stderr,
> +                        "Failed to parse boolean argument use_hwaddr\n");
> +                return -1;
> +            }
> +        } else if (g_strcmp0(tokens[0], "target") == 0) {
> +            target_data = str_to_bytes(tokens[1]);
> +            if (!target_data) {
> +                fprintf(stderr,
> +                         "Failed to parse target bytes.\n");
> +                return -1;
> +            }
> +        } else if (g_strcmp0(tokens[0], "patch") == 0) {
> +            patch_data = str_to_bytes(tokens[1]);
> +            if (!patch_data) {
> +                fprintf(stderr, "Failed to parse patch bytes.\n");
> +                return -1;
> +            }
> +        } else {
> +            fprintf(stderr, "Unknown argument: %s\n", tokens[0]);
> +            usage();
> +            return -1;
> +        }
> +    }
> +
> +    if (!target_data) {
> +        fprintf(stderr, "target argument is required\n");
> +        usage();
> +        return -1;
> +    }
> +
> +    if (!patch_data) {
> +        fprintf(stderr, "patch argument is required\n");
> +        usage();
> +        return -1;
> +    }
> +
> +    if (target_data->len != patch_data->len) {
> +        fprintf(stderr, "Target and patch data must be the same length\n");
> +        return -1;
> +    }
> +
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans_cb);
> +
> +    return 0;
> +}
> diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
> index ef6bcb4dc7..154910ab72 100644
> --- a/tests/tcg/x86_64/Makefile.softmmu-target
> +++ b/tests/tcg/x86_64/Makefile.softmmu-target
> @@ -7,18 +7,27 @@
>   #
>   
>   I386_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/i386/system
> -X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
> +X86_64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
>   
>   # These objects provide the basic boot code and helper functions for all tests
>   CRT_OBJS=boot.o
>   
> -CRT_PATH=$(X64_SYSTEM_SRC)
> -LINK_SCRIPT=$(X64_SYSTEM_SRC)/kernel.ld
> +X86_64_TEST_C_SRCS=$(wildcard $(X86_64_SYSTEM_SRC)/*.c)
> +X86_64_TEST_S_SRCS=
> +
> +X86_64_C_TESTS = $(patsubst $(X86_64_SYSTEM_SRC)/%.c, %, $(X86_64_TEST_C_SRCS))
> +X86_64_S_TESTS = $(patsubst $(X86_64_SYSTEM_SRC)/%.S, %, $(X86_64_TEST_S_SRCS))
> +
> +X86_64_TESTS = $(X86_64_C_TESTS)
> +X86_64_TESTS += $(X86_64_S_TESTS)
> +
> +CRT_PATH=$(X86_64_SYSTEM_SRC)
> +LINK_SCRIPT=$(X86_64_SYSTEM_SRC)/kernel.ld
>   LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
>   CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
>   LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
>   
> -TESTS+=$(MULTIARCH_TESTS)
> +TESTS+=$(X86_64_TESTS) $(MULTIARCH_TESTS)
>   EXTRA_RUNS+=$(MULTIARCH_RUNS)
>   
>   # building head blobs
> @@ -27,11 +36,24 @@ EXTRA_RUNS+=$(MULTIARCH_RUNS)
>   %.o: $(CRT_PATH)/%.S
>   	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -Wa,--noexecstack -c $< -o $@
>   
> -# Build and link the tests
> +# Build and link the multiarch tests
>   %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
>   	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
>   
> +# Build and link the arch tests
> +%: $(X86_64_SYSTEM_SRC)/%.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
> +
>   memory: CFLAGS+=-DCHECK_UNALIGNED=1
> +patch-target: CFLAGS+=-O0
>   
>   # Running
>   QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
> +
> +# Add patch-target to ADDITIONAL_PLUGINS_TESTS
> +ADDITIONAL_PLUGINS_TESTS += patch-target
> +
> +run-plugin-patch-target-with-libpatch.so:		\
> +	PLUGIN_ARGS=$(COMMA)target=ffc0$(COMMA)patch=9090$(COMMA)use_hwaddr=true
> +run-plugin-patch-target-with-libpatch.so:		\
> +	CHECK_PLUGIN_OUTPUT_COMMAND=$(X86_64_SYSTEM_SRC)/validate-patch.py $@.out
> \ No newline at end of file
> diff --git a/tests/tcg/x86_64/system/patch-target.c b/tests/tcg/x86_64/system/patch-target.c
> new file mode 100644
> index 0000000000..8a7c0a0ae8
> --- /dev/null
> +++ b/tests/tcg/x86_64/system/patch-target.c
> @@ -0,0 +1,27 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This test target increments a value 100 times. The patcher converts the
> + * inc instruction to a nop, so it only increments the value once.
> + *
> + */
> +#include <minilib.h>
> +
> +int main(void)
> +{
> +    ml_printf("Running test...\n");
> +#if defined(__x86_64__)
> +    ml_printf("Testing insn memory read/write...\n");
> +    unsigned int x = 0;
> +    for (int i = 0; i < 100; i++) {
> +        asm volatile (
> +            "inc %[x]"
> +            : [x] "+a" (x)
> +        );
> +    }
> +    ml_printf("Value: %d\n", x);
> +#else
> +    #error "This test is only valid for x86_64 architecture."
> +#endif
> +    return 0;
> +}
> diff --git a/tests/tcg/x86_64/system/validate-patch.py b/tests/tcg/x86_64/system/validate-patch.py
> new file mode 100755
> index 0000000000..700950eae5
> --- /dev/null
> +++ b/tests/tcg/x86_64/system/validate-patch.py
> @@ -0,0 +1,39 @@
> +#!/usr/bin/env python3
> +#
> +# validate-patch.py: check the patch applies
> +#
> +# This program takes two inputs:
> +#   - the plugin output
> +#   - the binary output
> +#
> +# Copyright (C) 2024
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import sys
> +from argparse import ArgumentParser
> +
> +def main() -> None:
> +    """
> +    Process the arguments, injest the program and plugin out and
> +    verify they match up and report if they do not.
> +    """
> +    parser = ArgumentParser(description="Validate patch")
> +    parser.add_argument('test_output',
> +                        help="The output from the test itself")
> +    parser.add_argument('plugin_output',
> +                        help="The output from plugin")
> +    args = parser.parse_args()
> +
> +    with open(args.test_output, 'r') as f:
> +        test_data = f.read()
> +    with open(args.plugin_output, 'r') as f:
> +        plugin_data = f.read()
> +    if "Value: 1" in test_data:
> +        sys.exit(0)
> +    else:
> +        sys.exit(1)
> +
> +if __name__ == "__main__":
> +    main()
> +

Thanks for the update Rowan.
Looks good to me,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


