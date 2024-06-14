Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C38C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 11:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI5KT-0008JT-Q9; Fri, 14 Jun 2024 07:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI5KE-0008C3-Ns
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 07:42:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI5KC-0006im-DT
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 07:42:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42172ab4b60so20297105e9.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 04:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718365350; x=1718970150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J5GyuHdZvWPdCqq9g191uaR4amvP5VK8rk/ym+H4qJw=;
 b=R6ZQCliSghnuTqaCUsLfnbz//Wota5UzL6QY1SquaKPyMs17ArsxotvvI0U2/suQCF
 949fDJFreILuvRGGVNtLpmbqjzpRwbZ/wcn47O57VfZTMXHlrXQ6iuGax6YcH7fW7453
 7fGuhDd2Ek7+J/8cvY/P3gfaJzM75FZeGv21Ahe2/7sQ0CvPe6eLO11I5rr8+8hVeZXP
 9MWQVBbB1+M0fFhNZbAYJSm3+hHJP8hCXuFTnDx/YTzmWNm4AwfdamqjXa9mNDcxjuvA
 xphR4JxSezyUeqvoGvyZsHewqJNeKzVUezdhGwG4hfv9H03U3LrI96tBZbUXPlb+MEFJ
 pzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718365350; x=1718970150;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J5GyuHdZvWPdCqq9g191uaR4amvP5VK8rk/ym+H4qJw=;
 b=a/LS5izF3XVchuaU/o3vuvSOowKpLuMN6CgihymSBOMz1KmVnIwB7jE2QTaspQxrzD
 NoPWj2pJsRIqdva/dj7h7wvdrDqKyB6ZixFexr9CLQ1yNdePNB4XhlU6dudCJo/qiPBA
 HB2BRyspr2zOLpfxLkdIlJvyDB4ki/B7a+TzRjwNC1Arbf9MTwcw/MnUTgrTsJR783de
 2vI/RNn6KOA7NUiIHl9E8sfOM1etAfw3gSA8pJeV9C3MS6zYn7ROUT+GHKIaL0gtZkiA
 9vXHwbRKomZmSqeiDSa7haOE/wJebuSR9AUu5Yr60z7QifWVw/LePrp1CLMA7vRO8POf
 Xr0Q==
X-Gm-Message-State: AOJu0YyLyXy2fyqjcav+TebtsI7TrJBOKplKfrLmTf9WLukg1ihnON+X
 FcXPKIfjyXHQG9vouDZeWIcY2oSMeQgRyxSED+qbM0EgcsWPyFpPKcl/yq9nXn0=
X-Google-Smtp-Source: AGHT+IGJLUE05Kfw6SEAL8ZHRz/wPnLQrIBjMr/wbWBaR9rjSbKFDsBfFWaa9vFLOwbC2eYg//d28Q==
X-Received: by 2002:a05:600c:1d0f:b0:423:4c2:7a43 with SMTP id
 5b1f17b1804b1-42304c27b17mr20842825e9.0.1718365350099; 
 Fri, 14 Jun 2024 04:42:30 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422870e986asm97637045e9.27.2024.06.14.04.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 04:42:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4DB1E5F794;
 Fri, 14 Jun 2024 12:42:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH v2 9/9] tests/tcg/aarch64: Add MTE gdbstub tests
In-Reply-To: <20240613172103.2987519-10-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 13 Jun 2024 17:21:03 +0000")
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-10-gustavo.romero@linaro.org>
Date: Fri, 14 Jun 2024 12:42:29 +0100
Message-ID: <87o783u4wq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

> Add tests to exercise the MTE stubs.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  tests/tcg/aarch64/Makefile.target     |  11 ++-
>  tests/tcg/aarch64/gdbstub/test-mte.py |  86 ++++++++++++++++++++++
>  tests/tcg/aarch64/mte-8.c             | 102 ++++++++++++++++++++++++++
>  3 files changed, 197 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tcg/aarch64/gdbstub/test-mte.py
>  create mode 100644 tests/tcg/aarch64/mte-8.c
>
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefi=
le.target
> index 70d728ae9a..d2e3f251eb 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -62,7 +62,7 @@ AARCH64_TESTS +=3D bti-2
>=20=20
>  # MTE Tests
>  ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
> -AARCH64_TESTS +=3D mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7
> +AARCH64_TESTS +=3D mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8
>  mte-%: CFLAGS +=3D -march=3Darmv8.5-a+memtag
>  endif
>=20=20
> @@ -127,7 +127,14 @@ run-gdbstub-sve-ioctls: sve-ioctls
>  		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
>  	basic gdbstub SVE ZLEN support)
>=20=20
> -EXTRA_RUNS +=3D run-gdbstub-sysregs run-gdbstub-sve-ioctls
> +run-gdbstub-mte: mte-8
> +	$(call run-test, $@, $(GDB_SCRIPT) \
> +		--gdb $(GDB) \
> +		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> +		--bin "$< -s" --test $(AARCH64_SRC)/gdbstub/test-mte.py, \
> +	gdbstub MTE support)
> +
> +EXTRA_RUNS +=3D run-gdbstub-sysregs run-gdbstub-sve-ioctls run-gdbstub-m=
te
>  endif
>  endif
>=20=20
> diff --git a/tests/tcg/aarch64/gdbstub/test-mte.py b/tests/tcg/aarch64/gd=
bstub/test-mte.py
> new file mode 100644
> index 0000000000..ec49eb8d2b
> --- /dev/null
> +++ b/tests/tcg/aarch64/gdbstub/test-mte.py
> @@ -0,0 +1,86 @@
> +from __future__ import print_function
> +#
> +# Test GDB memory-tag commands that exercise the stubs for the qIsAddres=
sTagged,
> +# qMemTag, and QMemTag packets. Logical tag-only commands rely on local
> +# operations, hence don't exercise any stub.
> +#
> +# The test consists in breaking just after a atag() call (which sets the
> +# allocation tag -- see mte-8.c for details) and setting/getting tags in
> +# different memory locations and ranges starting at the address of the a=
rray
> +# 'a'.
> +#
> +# This is launched via tests/guest-debug/run-test.py
> +#
> +
> +
> +import gdb
> +import re
> +from test_gdbstub import main, report
> +
> +
> +PATTERN_0 =3D "Memory tags for address 0x[0-9a-f]+ match \(0x[0-9a-f]+\)=
."
> +PATTERN_1 =3D ".*(0x[0-9a-f]+)"
> +
> +
> +def run_test():
> +    gdb.execute("break 99", False, True)
> +    gdb.execute("continue", False, True)
> +    try:
> +        # Test if we can check correctly that the allocation tag for
> +        # array 'a' matches the logical tag after atag() is called.
> +        co =3D gdb.execute("memory-tag check a", False, True)
> +        tags_match =3D re.findall(PATTERN_0, co, re.MULTILINE)
> +        if tags_match:
> +            report(True, f"{tags_match[0]}")
> +        else:
> +            report(False, "Logical and allocation tags don't match!")
> +
> +        # Test allocation tag 'set and print' commands. Commands on logi=
cal
> +        # tags rely on local operation and so don't exercise any stub.
> +
> +        # Set the allocation tag for the first granule (16 bytes) of
> +        # address starting at 'a' address to a known value, i.e. 0x04.
> +        gdb.execute("memory-tag set-allocation-tag a 1 04", False, True)
> +
> +        # Then set the allocation tag for the second granule to a known
> +        # value, i.e. 0x06. This tests that contiguous tag granules are
> +        # set correct and don't run over each other.
> +        gdb.execute("memory-tag set-allocation-tag a+16 1 06", False, Tr=
ue)
> +
> +        # Read the known values back and check if they remain the same.
> +
> +        co =3D gdb.execute("memory-tag print-allocation-tag a", False, T=
rue)
> +        first_tag =3D re.match(PATTERN_1, co)[1]
> +
> +        co =3D gdb.execute("memory-tag print-allocation-tag a+16", False=
, True)
> +        second_tag =3D re.match(PATTERN_1, co)[1]
> +
> +        if first_tag =3D=3D "0x4" and second_tag =3D=3D "0x6":
> +            report(True, "Allocation tags are correctly set/printed.")
> +        else:
> +            report(False, "Can't set/print allocation tags!")
> +
> +        # Now test fill pattern by setting a whole page with a pattern.
> +        gdb.execute("memory-tag set-allocation-tag a 4096 0a0b", False, =
True)
> +
> +        # And read back the tags of the last two granules in page so
> +        # we also test if the pattern is set correctly up to the end of
> +        # the page.
> +        co =3D gdb.execute("memory-tag print-allocation-tag a+4096-32", =
False, True)
> +        tag =3D re.match(PATTERN_1, co)[1]
> +
> +        co =3D gdb.execute("memory-tag print-allocation-tag a+4096-16", =
False, True)
> +        last_tag =3D re.match(PATTERN_1, co)[1]
> +
> +        if tag =3D=3D "0xa" and last_tag =3D=3D "0xb":
> +            report(True, "Fill pattern is ok.")
> +        else:
> +            report(False, "Fill pattern failed!")
> +
> +    except gdb.error:
> +        # This usually happens because a GDB version that does not
> +        # support memory tagging was used to run the test.
> +        report(False, "'memory-tag' command failed!")
> +
> +
> +main(run_test, expected_arch=3D"aarch64")
> diff --git a/tests/tcg/aarch64/mte-8.c b/tests/tcg/aarch64/mte-8.c
> new file mode 100644
> index 0000000000..367768e6b6
> --- /dev/null
> +++ b/tests/tcg/aarch64/mte-8.c
> @@ -0,0 +1,102 @@
> +/*
> + * To be compiled with -march=3Darmv8.5-a+memtag
> + *
> + * This test is adapted from a Linux test. Please see:
> + *
> + * https://www.kernel.org/doc/html/next/arch/arm64/memory-tagging-extens=
ion.html#example-of-correct-usage
> + */
> +#include <errno.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/auxv.h>
> +#include <sys/mman.h>
> +#include <sys/prctl.h>
> +#include <string.h>
> +/*
> + * From arch/arm64/include/uapi/asm/hwcap.h
> + */
> +#define HWCAP2_MTE              (1 << 18)
> +
> +/*
> + * From arch/arm64/include/uapi/asm/mman.h
> + */
> +#define PROT_MTE                 0x20
> +
> +/*
> + * Insert a random logical tag into the given pointer.
> + */
> +#define insert_random_tag(ptr) ({                   \
> +    uint64_t __val;                                 \
> +    asm("irg %0, %1" : "=3Dr" (__val) : "r" (ptr));   \
> +    __val;                                          \
> +})
> +
> +/*
> + * Set the allocation tag on the destination address.
> + */
> +#define set_tag(tagged_addr) do {                                      \
> +        asm volatile("stg %0, [%0]" : : "r" (tagged_addr) : "memory"); \
> +} while (0)
> +
> +
> +int main(int argc, char *argv[])
> +{
> +    unsigned char *a;
> +    unsigned long page_sz =3D sysconf(_SC_PAGESIZE);
> +    unsigned long hwcap2 =3D getauxval(AT_HWCAP2);
> +
> +    if (!(argc =3D=3D 2 && strcmp(argv[1], "-s") =3D=3D 0)) {
> +        return 0;
> +    }

Whats this trying to do? I would expect the test case to be able to run
normally without being debugged by gdb, so why do we need a particular
command line to shortcut it here?

> +
> +    /* check if MTE is present */
> +    if (!(hwcap2 & HWCAP2_MTE))
> +            return EXIT_FAILURE;
> +
> +    /*
> +     * Enable the tagged address ABI, synchronous or asynchronous MTE
> +     * tag check faults (based on per-CPU preference) and allow all
> +     * non-zero tags in the randomly generated set.
> +     */
> +    if (prctl(PR_SET_TAGGED_ADDR_CTRL,
> +              PR_TAGGED_ADDR_ENABLE | PR_MTE_TCF_SYNC | PR_MTE_TCF_ASYNC=
 |
> +              (0xfffe << PR_MTE_TAG_SHIFT),
> +              0, 0, 0)) {
> +        perror("prctl() failed");
> +        return EXIT_FAILURE;
> +    }
> +
> +    a =3D mmap(0, page_sz, PROT_READ | PROT_WRITE,
> +             MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    if (a =3D=3D MAP_FAILED) {
> +        perror("mmap() failed");
> +        return EXIT_FAILURE;
> +    }
> +
> +    printf("a[] address is %p\n", a);
> +
> +    /*
> +     * Enable MTE on the above anonymous mmap. The flag could be passed
> +     * directly to mmap() and skip this step.
> +     */
> +    if (mprotect(a, page_sz, PROT_READ | PROT_WRITE | PROT_MTE)) {
> +        perror("mprotect() failed");
> +        return EXIT_FAILURE;
> +    }
> +
> +    /* access with the default tag (0) */
> +    a[0] =3D 1;
> +    a[1] =3D 2;
> +
> +    printf("a[0] =3D %hhu a[1] =3D %hhu\n", a[0], a[1]);
> +
> +    /* set the logical and allocation tags */
> +    a =3D (unsigned char *)insert_random_tag(a);
> +    set_tag(a);
> +
> +    printf("%p\n", a);
> +
> +    return 0;
> +}

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

