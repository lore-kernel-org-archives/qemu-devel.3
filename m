Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB4CC71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 10:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRTfE-0007Hb-0b; Tue, 17 Jun 2025 06:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRTfB-0007HR-AN
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 06:35:33 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRTf8-00062t-JW
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 06:35:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so61749705e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750156527; x=1750761327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPvPGzFs0a3PkB4JAWcIGIJWqK5K2TevyIQjprK6q1k=;
 b=e4d3PwKhTql+pHXzOrLcU6DsPTAK8Hvdras+h/DC8zbzH9oBzDUTFuXOmlV/vmiUmj
 hahd/imrX0XwoJ+8G+fAsixvNGdsnEqR7LMhNqNkxMrk7o9XhJhLF705oV3LStOXVapc
 0EzezyJIwetq3/OK/uthOy64mSMKJTDg4qj7sZdDqeQis388bOjqgVG8SedV/DIgKyQ6
 E5093+Wic7CpyuA6qDu+iFsBj75i5PKm4tmTJn2ds7sQdGiLxcg4WlZxTE7HGIxZWvNJ
 nOmNISHq04TM1azIonARPt2Zf3F2HLFVxgTyDaXeH9QaA75A6StbUUJF4VLqwv3cgICS
 2MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750156527; x=1750761327;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GPvPGzFs0a3PkB4JAWcIGIJWqK5K2TevyIQjprK6q1k=;
 b=iECy2PlP+bSy6ZrIJ+UK5Tg+nmkCGrkKRGTe9N+wpkoVNMZQnjOCP3yHIOKSD1LAYv
 oyJJKNrLuj9My0fnX4FMGo2QdFtct6L0hxzXSeEAuvlhaMR1A/PIaJJAy70njwdo/qaJ
 YcuvfLLQrqgixlbrKg0lmfmyZLPIU8kLxXnKfMpmDmYC63LgIMHmKzc10Q1GK9UaJlXK
 IOAXmMKtY8JHF0Hgtg3Qh+B0+nnca8xvXDxUfBX3lDYkNMlQ3sFoLa0rmOIPJhkuDhxf
 Ea49aZaiaaLplfEiddUm3Zr4hDYcv0YoaLEapBZh7zL5YtYcE3PfvMXGgCA731TCMICw
 w9iw==
X-Gm-Message-State: AOJu0YxyO5nv/QwCIbjOFbif2NAw3KCWO61d8I/vbBWbpUXMkKotWejp
 6RD8/2YxbHICGpVT84vue6Xrw82yUmF7amgp8EMtn0of5cHrOXeptNCDClzSN3xyDoc=
X-Gm-Gg: ASbGnctunvc0Z+m+Kc/Ff141oFt0F/E49Wcx3hQfi1MNEJcVZweMCelB/39BbmFmtaw
 epxi4EIatX2BHlXmTxbjG10WvhSynCFIf+SY1Z4NLpPz60ZUUALPCUk0bOa2yATXh9YMygunELD
 SR/wFlWmcj0Izzxu8ySFhSqNXnavh//duFfB+/3pfFQRpwR88kxLYGsqeS/Apia9Ru7H0tGgAAb
 NdFCZLIw7VnhlJTyzlyd60hA8Dfkcg3/gkiNXCjl+cQBYYxDInosbkMe0uU1xuPwTMzI+Crjl/b
 H377AgtTnObukJxr7lvUTniI7Da04s8LOPNo71JOU9HNiKLj8AH9z7gcWw5AOQo=
X-Google-Smtp-Source: AGHT+IGCdgPWXS1A4l5Y8ZFCMXmwkvCP/rG9QQ7Wpi8QPSpwgxZH2q/vIp9SWwF7c1b0tUPMSMxUNA==
X-Received: by 2002:a05:600c:1e1d:b0:442:ccfa:1461 with SMTP id
 5b1f17b1804b1-4533ca6ace2mr130706555e9.13.1750156527018; 
 Tue, 17 Jun 2025 03:35:27 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c2d2sm177401215e9.1.2025.06.17.03.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 03:35:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B706D5F834;
 Tue, 17 Jun 2025 11:35:25 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rowan Hart <rowanbhart@gmail.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Alexandre Iooss <erdnaxe@crans.org>,  Zhao
 Liu <zhao1.liu@intel.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v12 6/7] plugins: Add patcher plugin and test
In-Reply-To: <20250611232409.2936521-7-rowanbhart@gmail.com> (Rowan Hart's
 message of "Wed, 11 Jun 2025 16:24:08 -0700")
References: <20250611232409.2936521-1-rowanbhart@gmail.com>
 <20250611232409.2936521-7-rowanbhart@gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 17 Jun 2025 11:35:25 +0100
Message-ID: <87bjqmveoi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Rowan Hart <rowanbhart@gmail.com> writes:

> From: novafacing <rowanbhart@gmail.com>
>
> This patch adds a plugin that exercises the virtual and hardware memory
> read-write API functions added in a previous patch. The plugin takes a
> target and patch byte sequence, and will overwrite any instruction
> matching the target byte sequence with the patch.
>
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>  tests/tcg/Makefile.target                 |   1 +
>  tests/tcg/plugins/meson.build             |   2 +-
>  tests/tcg/plugins/patch.c                 | 241 ++++++++++++++++++++++
>  tests/tcg/x86_64/Makefile.softmmu-target  |  32 ++-
>  tests/tcg/x86_64/system/patch-target.c    |  27 +++
>  tests/tcg/x86_64/system/validate-patch.py |  39 ++++
>  6 files changed, 336 insertions(+), 6 deletions(-)
>  create mode 100644 tests/tcg/plugins/patch.c
>  create mode 100644 tests/tcg/x86_64/system/patch-target.c
>  create mode 100755 tests/tcg/x86_64/system/validate-patch.py
>
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index 95ff76ea44..4b709a9d18 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -176,6 +176,7 @@ RUN_TESTS+=3D$(EXTRA_RUNS)
>  # Some plugins need additional arguments above the default to fully
>  # exercise things. We can define them on a per-test basis here.
>  run-plugin-%-with-libmem.so: PLUGIN_ARGS=3D$(COMMA)inline=3Dtrue
> +run-plugin-%-with-libpatch.so: PLUGIN_ARGS=3D$(COMMA)target=3Dffffffff$(=
COMMA)patch=3D00000000
>

I think we need to manually add this to the x86_64 specific tests because...

>  ifeq ($(filter %-softmmu, $(TARGET)),)
>  run-%: %
> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
> index 41f02f2c7f..163042e601 100644
> --- a/tests/tcg/plugins/meson.build
> +++ b/tests/tcg/plugins/meson.build
> @@ -1,6 +1,6 @@
>  t =3D []
>  if get_option('plugins')
> -  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall=
']
> +  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall=
', 'patch']
>      if host_os =3D=3D 'windows'
>        t +=3D shared_module(i, files(i + '.c') + '../../../contrib/plugin=
s/win32_linker.c',
>                          include_directories: '../../../include/qemu',

... the problem with adding test patches into tests/tcg is we balloon the
number of test cases. Whats worse we are running on linux-user tests
where we don't exercise anything.

So I think we should filter out the test from the general testing by
fixing up:

PLUGINS=3D$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))

<snip>
> +
> +static void usage(void)
> +{
> +    fprintf(stderr, "Usage: <lib>,target=3D<bytes>,patch=3D<new_bytes>"
> +            "[,use_hwaddr=3Dtrue|false]");
> +}
> +
> +/*
> + * Called when the plugin is installed
> + */
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info, int =
argc,
> +                                           char **argv)
> +{
> +
> +    use_hwaddr =3D true;
> +    target_data =3D NULL;
> +    patch_data =3D NULL;
> +
> +    if (argc > 4) {
> +        usage();
> +        return -1;
> +    }
> +
> +    for (size_t i =3D 0; i < argc; i++) {
> +        char *opt =3D argv[i];
> +        g_auto(GStrv) tokens =3D g_strsplit(opt, "=3D", 2);
> +        if (g_strcmp0(tokens[0], "use_hwaddr") =3D=3D 0) {
> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &use_hwadd=
r)) {
> +                fprintf(stderr,
> +                        "Failed to parse boolean argument use_hwaddr\n");
> +                return -1;
> +            }
> +        } else if (g_strcmp0(tokens[0], "target") =3D=3D 0) {
> +            target_data =3D str_to_bytes(tokens[1]);
> +            if (!target_data) {
> +                fprintf(stderr,
> +                         "Failed to parse target bytes.\n");
> +                return -1;
> +            }
> +        } else if (g_strcmp0(tokens[0], "patch") =3D=3D 0) {
> +            patch_data =3D str_to_bytes(tokens[1]);
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
> +    if (target_data->len !=3D patch_data->len) {
> +        fprintf(stderr, "Target and patch data must be the same length\n=
");
> +        return -1;
> +    }
> +
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans_cb);
> +
> +    return 0;
> +}
> diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/=
Makefile.softmmu-target
> index ef6bcb4dc7..154910ab72 100644
> --- a/tests/tcg/x86_64/Makefile.softmmu-target
> +++ b/tests/tcg/x86_64/Makefile.softmmu-target
> @@ -7,18 +7,27 @@
>  #
>=20=20
>  I386_SYSTEM_SRC=3D$(SRC_PATH)/tests/tcg/i386/system
> -X64_SYSTEM_SRC=3D$(SRC_PATH)/tests/tcg/x86_64/system
> +X86_64_SYSTEM_SRC=3D$(SRC_PATH)/tests/tcg/x86_64/system

Can we have symbol renaming in a separate patch as it makes diffs messy
to follow otherwise.

>=20=20
>  # These objects provide the basic boot code and helper functions for all=
 tests
>  CRT_OBJS=3Dboot.o
>=20=20
> -CRT_PATH=3D$(X64_SYSTEM_SRC)
> -LINK_SCRIPT=3D$(X64_SYSTEM_SRC)/kernel.ld
> +X86_64_TEST_C_SRCS=3D$(wildcard $(X86_64_SYSTEM_SRC)/*.c)
> +X86_64_TEST_S_SRCS=3D
> +
> +X86_64_C_TESTS =3D $(patsubst $(X86_64_SYSTEM_SRC)/%.c, %, $(X86_64_TEST=
_C_SRCS))
> +X86_64_S_TESTS =3D $(patsubst $(X86_64_SYSTEM_SRC)/%.S, %, $(X86_64_TEST=
_S_SRCS))
> +
> +X86_64_TESTS =3D $(X86_64_C_TESTS)
> +X86_64_TESTS +=3D $(X86_64_S_TESTS)
> +
> +CRT_PATH=3D$(X86_64_SYSTEM_SRC)
> +LINK_SCRIPT=3D$(X86_64_SYSTEM_SRC)/kernel.ld
>  LDFLAGS=3D-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
>  CFLAGS+=3D-nostdlib -ggdb -O0 $(MINILIB_INC)
>  LDFLAGS+=3D-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
>=20=20
> -TESTS+=3D$(MULTIARCH_TESTS)
> +TESTS+=3D$(X86_64_TESTS) $(MULTIARCH_TESTS)
>  EXTRA_RUNS+=3D$(MULTIARCH_RUNS)
>=20=20
>  # building head blobs
> @@ -27,11 +36,24 @@ EXTRA_RUNS+=3D$(MULTIARCH_RUNS)
>  %.o: $(CRT_PATH)/%.S
>  	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -Wa,--noexecstack -c $< -o $@
>=20=20
> -# Build and link the tests
> +# Build and link the multiarch tests
>  %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
>  	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
>=20=20
> +# Build and link the arch tests
> +%: $(X86_64_SYSTEM_SRC)/%.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
> +

Is this needed? The aarch64 vtimer system test didn't need a new build stan=
za.

>  memory: CFLAGS+=3D-DCHECK_UNALIGNED=3D1
> +patch-target: CFLAGS+=3D-O0
>=20=20
>  # Running
>  QEMU_OPTS+=3D-device isa-debugcon,chardev=3Doutput -device isa-debug-exi=
t,iobase=3D0xf4,iosize=3D0x4 -kernel
> +
> +# Add patch-target to ADDITIONAL_PLUGINS_TESTS
> +ADDITIONAL_PLUGINS_TESTS +=3D patch-target
> +
> +run-plugin-patch-target-with-libpatch.so:		\
> +	PLUGIN_ARGS=3D$(COMMA)target=3Dffc0$(COMMA)patch=3D9090$(COMMA)use_hwad=
dr=3Dtrue
> +run-plugin-patch-target-with-libpatch.so:		\
> +	CHECK_PLUGIN_OUTPUT_COMMAND=3D$(X86_64_SYSTEM_SRC)/validate-patch.py $@=
.out
> \ No newline at end of file
> diff --git a/tests/tcg/x86_64/system/patch-target.c b/tests/tcg/x86_64/sy=
stem/patch-target.c
> new file mode 100644
> index 0000000000..8a7c0a0ae8
> --- /dev/null
> +++ b/tests/tcg/x86_64/system/patch-target.c
> @@ -0,0 +1,27 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This test target increments a value 100 times. The patcher converts t=
he
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
> +    unsigned int x =3D 0;
> +    for (int i =3D 0; i < 100; i++) {
> +        asm volatile (
> +            "inc %[x]"
> +            : [x] "+a" (x)
> +        );
> +    }
> +    ml_printf("Value: %d\n", x);
> +#else
> +    #error "This test is only valid for x86_64 architecture."
> +#endif

This is a bit redundant given the test is in tests/tcg/x86_64/system.

> +    return 0;
> +}
> diff --git a/tests/tcg/x86_64/system/validate-patch.py b/tests/tcg/x86_64=
/system/validate-patch.py
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
> +    parser =3D ArgumentParser(description=3D"Validate patch")
> +    parser.add_argument('test_output',
> +                        help=3D"The output from the test itself")
> +    parser.add_argument('plugin_output',
> +                        help=3D"The output from plugin")
> +    args =3D parser.parse_args()
> +
> +    with open(args.test_output, 'r') as f:
> +        test_data =3D f.read()
> +    with open(args.plugin_output, 'r') as f:
> +        plugin_data =3D f.read()
> +    if "Value: 1" in test_data:
> +        sys.exit(0)
> +    else:
> +        sys.exit(1)
> +
> +if __name__ =3D=3D "__main__":
> +    main()
> +

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

