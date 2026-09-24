Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647D8C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9o1y-0006M9-JM; Thu, 24 Sep 2026 14:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x9o1x-0006Lu-18
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 14:18:49 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x9o1u-00089h-W1
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 14:18:48 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so54298f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 11:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790273925; x=1790878725; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U+EB0Wj9BQa2gLO7kJ9YcQzjvzL9fprWoGiN//cAhfM=;
 b=boYyzR53FbJ8YomBMkHs7ggDbO90XDBV6GzERq5St0Q26aL2XFpSTnaheiAqvv8NM+
 SIUJR5UfKK/U7WqTqtV3Vt6zeP/DBeMYIRdEhowB1xWBFduCj3LvSERhtlLlyKIQLmCa
 +tcpXXXh9OO1n7H6WpSaj9zMVXzsjwdqjIhcDZHmAq0cMzaIlH6DYkZlifc1CGrc8n8f
 06gRis24/s+Ktcpql1QXMzLN+hiLEs/LwOBqWp/A76UUU9/HLnWGhKxiU8eRlt+Os9Qg
 H16GDZQvn0tnBETOA1MhxBIoU0i5Bvxq/2tP2wiQ2bePcY2lGFwF2u5bJI5rIm/NBlou
 ejWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790273925; x=1790878725;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U+EB0Wj9BQa2gLO7kJ9YcQzjvzL9fprWoGiN//cAhfM=;
 b=yAhW/XAcetn0wG/OIup60z4kuNdfMn0nsSBvgwvt3S6rVz6bGeYxDUJs8X5KHgN3vr
 egHFijfSGoJuHknwOSj9zBKxOJOJ+Cd1UKCi8eI2ff8k0R+bbqQMhMbwTIpomxLb4089
 ZXhBkbcpxeWUQ6lYsDp/tBMZL2lu69t/egfHbfzMT9o5L0vsS8IuWUe3YtVO10g/JnlK
 wAFO3ICYKDam6WUcZt+AxckAzGAk1X1XmKp4gXq1SKc7pgNBfZAHOIZAeqWAdkU2agt4
 irqehPhAKJBZdmE0jdUes7/erHVswq7ayGyx+MWp0jxZymKQDl4V9faw5kjqIT2POUWt
 z5Ug==
X-Forwarded-Encrypted: i=1;
 AKwUvBytTZeZ7MkvdX4TzBBYPbEg2rYDoxuHWR+f4jdrAb6opxZhpfULGFhlJIb7fpDEPWqFqDUeH1mzf/nJ@nongnu.org
X-Gm-Message-State: AFuF++n4RyfUm6bI3BplzuXK4lFmMdA0iDVh7+pUs5Fyx6LcFWrqGyPb
 pEM3WryUTPpHIabT30Dq1giXpDgu+C09ofJYhJlF3MtvQ0hrhK3J6Mdd
X-Gm-Gg: AYBFou3Dg1qrWtEifW1Bz3rxFteLxa8Q7TqJx/n4cRjYY8Lq/ZtceYMac4LgSnLcVrB
 fBPfn8uDZ9eqNocHjzyNDHmsZNH+0y+TPBhSdXiWEidHwtthF1tmbx3z4c9xCEWHWPlCz7EWWSl
 mLXHAK+OJGFIRiPh1pd0vxmGLWLuE1QEd9omlMy23ij7inFT5HmrTtXCRfIyjLpKksfrUOixp0c
 5xOpGNrFKf12LYklyx5+4pphP4WDrYOAy5ycECafRMFNsloxFPE2h6DBkDSCRLaOWjOw8N9UMVJ
 +upkTjd5knmaIjjsX2JFDm+cnYm1IfKJCSSeugvh9bWuuYfkzf1XTwaZvYnLkFNYjppUTttNcEA
 wdbWDgGIDFrix7GikJG5OmPFeVaQKjh+PoZICjlSwVIC7svYZCCueEMdm0qil3bqx7NnP3k3ZiB
 T/h2Z3MHbkM5I4e5Uz+CHp0e59CfFN4PpxnBvUUWBf22FUBOAH67mR322Dc6KtcGb6BUYDLA9mu
 OuctXxQgjA24kCMDrycuYdBjQfu2vuHVjzrKFO5brFd0Aoua4vvllmA518oPyCgnw==
X-Received: by 2002:a05:600c:c1c8:10b0:49f:e69d:9df9 with SMTP id
 5b1f17b1804b1-49fe69d9dffmr40931425e9.10.1790273925024; 
 Thu, 24 Sep 2026 11:18:45 -0700 (PDT)
Received: from [10.0.2.15] (dynamic-077-191-033-034.77.191.pool.telefonica.de.
 [77.191.33.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fee6cc7d3sm5355525e9.0.2026.09.24.11.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 11:18:43 -0700 (PDT)
Message-ID: <cae2d17b-571c-421d-98c8-fbc467134141@gmail.com>
Date: Thu, 24 Sep 2026 20:18:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 092/105] tests/tcg/x86_64: system tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-93-alex.bennee@linaro.org>
Content-Language: en-US
From: Bernhard Beschow <shentey@gmail.com>
In-Reply-To: <20260904124604.2207440-93-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 9/4/26 14:45, Alex Bennée wrote:
> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>
> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Message-ID: <20260827221506.91574-93-pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>
> diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
> deleted file mode 100644
> index 4e65f58b570..00000000000
> --- a/tests/tcg/x86_64/Makefile.softmmu-target
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -#
> -# x86_64 system tests
> -#
> -
> -X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
> -X64_SYSTEM_TESTS=$(patsubst $(X64_SYSTEM_SRC)/%.c, %, $(wildcard $(X64_SYSTEM_SRC)/*.c))
> -
> -VPATH+=$(X64_SYSTEM_SRC)
> -
> -# These objects provide the basic boot code and helper functions for all tests
> -CRT_OBJS=boot.o
> -
> -CRT_PATH=$(X64_SYSTEM_SRC)
> -LINK_SCRIPT=$(X64_SYSTEM_SRC)/kernel.ld
> -LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
> -CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
> -LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
> -
> -TESTS+=$(MULTIARCH_TESTS) $(X64_SYSTEM_TESTS)
> -EXTRA_RUNS+=$(MULTIARCH_RUNS)
> -
> -# building head blobs
> -.PRECIOUS: $(CRT_OBJS)
> -
> -%.o: $(CRT_PATH)/%.S
> -	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -Wa,--noexecstack -c $< -o $@
> -
> -# Build and link the tests
> -%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
> -	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
> -
> -memory: CFLAGS+=-DCHECK_UNALIGNED=1
> -
> -# Running
> -QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
> -
> -ifeq ($(CONFIG_PLUGIN),y)
> -run-plugin-patch-target-with-libpatch.so:		\
> -	PLUGIN_ARGS=$(COMMA)target=ffc0$(COMMA)patch=9090$(COMMA)use_hwaddr=true
> -run-plugin-patch-target-with-libpatch.so:		\
> -	CHECK_PLUGIN_OUTPUT_COMMAND=$(X64_SYSTEM_SRC)/validate-patch.py $@.out
> -run-plugin-patch-target-with-libpatch.so: patch-target libpatch.so
> -EXTRA_RUNS_WITH_PLUGIN+=run-plugin-patch-target-with-libpatch.so
> -endif
> diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
> index 2607a1cbcf4..ab336eca9b2 100644
> --- a/tests/tcg/x86_64/meson.build
> +++ b/tests/tcg/x86_64/meson.build
> @@ -2,6 +2,8 @@ cc = 'x86_64-linux-gnu-gcc'
>   cc_dockerfile = 'debian-amd64-cross'
>   cc_docker_host_arch = ['x86_64']
>   
> +subdir('system')
> +
>   tests = []
>   
>   tests += tcg_tests['multiarch-linux-user']['tests']
> diff --git a/tests/tcg/x86_64/system/meson.build b/tests/tcg/x86_64/system/meson.build
> new file mode 100644
> index 00000000000..80110d0ae57
> --- /dev/null
> +++ b/tests/tcg/x86_64/system/meson.build
> @@ -0,0 +1,63 @@
> +tests = []
> +
> +minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
> +minilib_printf = files(minilib_dir / 'printf.c')[0]
> +link_script = files('kernel.ld')[0]
> +boot = files('boot.S')[0]
> +cflags = ['-nostdlib',
> +          '-ffreestanding',
> +          '-Wa,--noexecstack',
> +          '-I', minilib_dir, minilib_printf, boot,
> +          '-Wl,-T', link_script,
> +          '-Wl,-melf_x86_64',
> +          '-Wl,--no-warn-rwx-segments',
> +          '-Wl,--build-id=none',
> +          '-lgcc']
> +qemu_def_args = ['-display', 'none',
> +                 '-device', 'isa-debugcon,chardev=stdio',
> +                 '-chardev', 'stdio,id=stdio',
> +                 '-device', 'isa-debug-exit,iobase=0xf4,iosize=0x4',
> +                 '-kernel']
> +
> +# Multi arch tests
> +multi_src = []
> +foreach t: tcg_tests['multiarch-softmmu']['tests']
> +  foreach src, setup: t
> +    new_cflags = cflags
> +    if fs.stem(src) == 'memory'
> +      new_cflags += '-DCHECK_UNALIGNED=1'
> +    endif
> +    if src not in multi_src
> +      setup += {'cflags': [new_cflags]}
> +      multi_src += src
> +    endif
> +    tests += {src: setup + {'qemu_args': qemu_def_args}}
> +  endforeach
> +endforeach
> +
> +tests += {
> +  'patch-target.c': {
> +    'cflags': cflags,
> +    'qemu_args': qemu_def_args,
> +    'plugin_test': {
> +      'plugin': 'patch',
> +      'args': ['target=ffc0', 'patch=9090', 'use_hwaddr=true'],
> +    },
> +    'wrapper': [prog_check_plugin_output,
> +                find_program('./validate-patch.py')]
> +  }
> +}
> +
> +if 'qemu-system-x86_64' in emulators
> +  tcg_tests += {
> +    'x86_64-softmmu': {
> +      'cc': cc,
> +      'cc_dockerfile': cc_dockerfile,
> +      'cc_docker_host_arch': cc_docker_host_arch,
> +      'folder': 'x86_64/system',
> +      'gdb_arch': 'x86_64',
> +      'qemu': emulators['qemu-system-x86_64'],
> +      'tests': tests,
> +    }
> +  }
> +endif

With this patch I get under Archlinux:

$ make tests/tcg/x86_64-softmmu-hello.test
[1/1] Generating tests/tcg/x86_64-softmmu-hello with a custom command
FAILED: [code=1] tests/tcg/x86_64-softmmu-hello.test
/usr/bin/x86_64-linux-gnu-gcc 
qemu/src/tests/tcg/multiarch/system/hello.c -o 
tests/tcg/x86_64-softmmu-hello.test -static -MMD -MF 
tests/tcg/x86_64-softmmu-hello.d -Wall -Werror -O0 -g 
-fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I 
qemu/src/tests/tcg/x86_64/system/../../minilib 
qemu/src/tests/tcg/x86_64/system/../../minilib/printf.c 
../src/tests/tcg/x86_64/system/boot.S -Wl,-T 
../src/tests/tcg/x86_64/system/kernel.ld -Wl,-melf_x86_64 
-Wl,--no-warn-rwx-segments -Wl,--build-id=none -lgcc
/usr/bin/ld: /tmp/ccRh6mPz.o: in function `print_num':
qemu/src/tests/tcg/x86_64/system/../../minilib/printf.c:45:(.text+0xec): 
undefined reference to `__stack_chk_fail'
/usr/bin/ld: /tmp/ccRh6mPz.o: in function `ml_printf':
qemu/src/tests/tcg/x86_64/system/../../minilib/printf.c:136:(.text+0x549): 
undefined reference to `__stack_chk_fail'
collect2: error: ld returned 1 exit status
ninja: build stopped: subcommand failed.
make: *** [Makefile:170: run-ninja] Error 1

Reverting this patch I'm able to run `make check` successfully again. 
Any idea what might be causing this?

Best regards,

Bernhard


