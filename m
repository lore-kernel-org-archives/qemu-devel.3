Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27739CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 17:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjCK-0001oG-SG; Thu, 11 Jun 2026 13:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wXjCH-0001o3-Ng
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 13:28:05 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wXjCF-0004k9-5W
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 13:28:05 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C92C36AFCB;
 Thu, 11 Jun 2026 17:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781198878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJ4jAgFOMn+yNRuSuAswekrPYhoYlvf0HQKs+ianK4M=;
 b=FsHEZD4wyIG6Z1BcCFS+cvzoEFiBYZnUVn+elYxQejpGbRGzgNBRe/WQLL7DHN+GvosfQW
 UvLZ0TfriQ82Ff5jZbRjvD8Cw380sAsBMoTidWYLnOB+kTfXBURw9/wtHTDUP9VsX/Vmve
 I7n9V1tKcbHkaNwvl6CoPS/U7U6310c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781198878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJ4jAgFOMn+yNRuSuAswekrPYhoYlvf0HQKs+ianK4M=;
 b=jE03mwdCNblvMdZ2AaseJDBIZnazsAyIqPT5pOGNhL6kSf3Dwiy4Qm5lNnMGR+T2IluBCX
 RyRRGethWpbfwXBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FsHEZD4w;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jE03mwdC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781198878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJ4jAgFOMn+yNRuSuAswekrPYhoYlvf0HQKs+ianK4M=;
 b=FsHEZD4wyIG6Z1BcCFS+cvzoEFiBYZnUVn+elYxQejpGbRGzgNBRe/WQLL7DHN+GvosfQW
 UvLZ0TfriQ82Ff5jZbRjvD8Cw380sAsBMoTidWYLnOB+kTfXBURw9/wtHTDUP9VsX/Vmve
 I7n9V1tKcbHkaNwvl6CoPS/U7U6310c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781198878;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJ4jAgFOMn+yNRuSuAswekrPYhoYlvf0HQKs+ianK4M=;
 b=jE03mwdCNblvMdZ2AaseJDBIZnazsAyIqPT5pOGNhL6kSf3Dwiy4Qm5lNnMGR+T2IluBCX
 RyRRGethWpbfwXBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 639C9779A7;
 Thu, 11 Jun 2026 17:27:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MWC9DB7wKmpJfwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 11 Jun 2026 17:27:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bibo Mao <maobibo@loongson.cn>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] tests/qtest/migration: Add migration test on loongarch
In-Reply-To: <20260611084312.70042-1-maobibo@loongson.cn>
References: <20260611084312.70042-1-maobibo@loongson.cn>
Date: Thu, 11 Jun 2026 14:27:55 -0300
Message-ID: <8733ytng10.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid,loongson.cn:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C92C36AFCB
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Bibo Mao <maobibo@loongson.cn> writes:

> Add migration qtest on loongarch64 system, the test passes to run with
> the following result:
>   qemu:qtest+qtest-loongarch64/qtest-loongarch64/migration-test OK 15.94s 9 subtests passed
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> v1 ... v2:
>   1. Add SPDX-License in __note in file tests/qtest/migration/Makefile
>   2. Regerate file tests/qtest/migration/loongarch64/a-b-kernel.h with
>      __note information
> ---
>  MAINTAINERS                                   |  1 +
>  tests/qtest/meson.build                       |  3 +-
>  tests/qtest/migration/Makefile                |  4 +-
>  tests/qtest/migration/bootfile.c              |  4 ++
>  tests/qtest/migration/bootfile.h              |  4 ++
>  tests/qtest/migration/framework.c             |  6 +++
>  tests/qtest/migration/loongarch64/Makefile    | 20 ++++++++
>  .../qtest/migration/loongarch64/a-b-kernel.S  | 46 +++++++++++++++++++
>  .../qtest/migration/loongarch64/a-b-kernel.h  | 20 ++++++++
>  9 files changed, 106 insertions(+), 2 deletions(-)
>  create mode 100644 tests/qtest/migration/loongarch64/Makefile
>  create mode 100644 tests/qtest/migration/loongarch64/a-b-kernel.S
>  create mode 100644 tests/qtest/migration/loongarch64/a-b-kernel.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b5b581e17..91d72feebe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1359,6 +1359,7 @@ F: hw/intc/loongarch_*.c
>  F: hw/intc/loongson_ipi_common.c
>  F: hw/rtc/ls7a_rtc.c
>  F: gdbstub/gdb-xml/loongarch*.xml
> +F: tests/qtest/migration/loongarch64/
>  
>  M68K Machines
>  -------------
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 45ea497fa5..1636b8616e 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -154,7 +154,8 @@ qtests_loongarch64 = qtests_filter + \
>    (config_all_devices.has_key('CONFIG_LOONGARCH_VIRT') ? ['numa-test'] : []) + \
>    (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
>    ['boot-serial-test',
> -   'cpu-plug-test']
> +   'cpu-plug-test',
> +   'migration-test']
>  
>  qtests_m68k = ['boot-serial-test'] + \
>    qtests_filter
> diff --git a/tests/qtest/migration/Makefile b/tests/qtest/migration/Makefile
> index c183b69941..626e3974f7 100644
> --- a/tests/qtest/migration/Makefile
> +++ b/tests/qtest/migration/Makefile
> @@ -5,7 +5,7 @@
>  # See the COPYING file in the top-level directory.
>  #
>  
> -TARGET_LIST = i386 aarch64 s390x ppc64
> +TARGET_LIST = i386 aarch64 s390x ppc64 loongarch64
>  
>  SRC_PATH = ../../../..
>  
> @@ -23,6 +23,8 @@ help:
>  	@echo " Possible targets are: $(TARGET_LIST)"
>  
>  override define __note
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
>  /*
>   * This file is automatically generated from the assembly file in
>   * tests/qtest/migration/$@. Edit that file and then run "make"
> diff --git a/tests/qtest/migration/bootfile.c b/tests/qtest/migration/bootfile.c
> index 479c43231d..e46ad09de7 100644
> --- a/tests/qtest/migration/bootfile.c
> +++ b/tests/qtest/migration/bootfile.c
> @@ -19,6 +19,7 @@
>  #include "bootfile.h"
>  #include "i386/a-b-bootblock.h"
>  #include "aarch64/a-b-kernel.h"
> +#include "loongarch64/a-b-kernel.h"
>  #include "ppc64/a-b-kernel.h"
>  #include "s390x/a-b-bios.h"
>  
> @@ -57,6 +58,9 @@ char *bootfile_create(const char *arch, const char *dir, bool suspend_me)
>          content = aarch64_kernel;
>          len = sizeof(aarch64_kernel);
>          g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
> +    } else if (strcmp(arch, "loongarch64") == 0) {
> +        content = loongarch64_kernel;
> +        len = sizeof(loongarch64_kernel);
>      } else {
>          g_assert_not_reached();
>      }
> diff --git a/tests/qtest/migration/bootfile.h b/tests/qtest/migration/bootfile.h
> index 0ce5b34433..a4060ea4f7 100644
> --- a/tests/qtest/migration/bootfile.h
> +++ b/tests/qtest/migration/bootfile.h
> @@ -42,6 +42,10 @@
>   */
>  #define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
>  
> +/* LoongArch64 */
> +#define LOONGARCH_TEST_MEM_START (32 * 1024 * 1024)
> +#define LOONGARCH_TEST_MEM_END   (100 * 1024 * 1024)
> +
>  #ifndef MIGRATION_GUEST_CODE
>  void bootfile_delete(void);
>  char *bootfile_create(const char *arch, const char *dir, bool suspend_me);
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index a9b58d03aa..a830b96f41 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -360,6 +360,12 @@ int migrate_args(char **from, char **to, MigrateStart *args)
>          arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
>          start_address = ARM_TEST_MEM_START;
>          end_address = ARM_TEST_MEM_END;
> +    } else if (strcmp(arch, "loongarch64") == 0) {
> +        memory_size = "256M";
> +        machine_alias = "virt";
> +        arch_opts = g_strdup_printf("-bios %s", bootpath);
> +        start_address = LOONGARCH_TEST_MEM_START;
> +        end_address = LOONGARCH_TEST_MEM_END;
>      } else {
>          g_assert_not_reached();
>      }
> diff --git a/tests/qtest/migration/loongarch64/Makefile b/tests/qtest/migration/loongarch64/Makefile
> new file mode 100644
> index 0000000000..3c8cfeee86
> --- /dev/null
> +++ b/tests/qtest/migration/loongarch64/Makefile
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# To specify cross compiler prefix, use CROSS_PREFIX=
> +#   $ make CROSS_PREFIX=loongarch64-linux-gnu-
> +
> +.PHONY: all clean
> +all: a-b-kernel.h
> +
> +a-b-kernel.h: loongarch64.kernel
> +	echo "$$__note" > $@
> +	xxd -i $< | sed -e 's/.*int.*//' >> $@
> +
> +loongarch64.kernel: loongarch64.elf
> +	$(CROSS_PREFIX)objcopy -j .text -O binary $< $@
> +
> +loongarch64.elf: a-b-kernel.S
> +	$(CROSS_PREFIX)gcc -o $@ -nostdlib -Wl,--build-id=none $<
> +
> +clean:
> +	$(RM) *.kernel *.elf
> diff --git a/tests/qtest/migration/loongarch64/a-b-kernel.S b/tests/qtest/migration/loongarch64/a-b-kernel.S
> new file mode 100644
> index 0000000000..577d4b238c
> --- /dev/null
> +++ b/tests/qtest/migration/loongarch64/a-b-kernel.S
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "../bootfile.h"
> +
> +#define LOONGARCH_CSR_CRMD          0
> +#define LOONGARCH_VIRT_UART         0x1FE001E0
> +.section .text
> +
> +    .globl  _start
> +_start:
> +    /* output char 'A' to UART16550 */
> +    li.d    $t0, LOONGARCH_VIRT_UART
> +    li.w    $t1, 'A'
> +    st.b    $t1, $t0, 0
> +
> +    /* traverse test memory region */
> +    li.d    $t0, LOONGARCH_TEST_MEM_START
> +    li.d    $t1, LOONGARCH_TEST_MEM_END
> +    li.d    $t2, TEST_MEM_PAGE_SIZE
> +    li.d    $t4, LOONGARCH_VIRT_UART
> +    li.w    $t5, 'B'
> +
> +clean:
> +    st.b    $zero, $t0, 0
> +    add.d   $t0,   $t0, $t2
> +    bne     $t0,   $t1, clean
> +    /* keeps a counter so we can limit the output speed */
> +    addi.d  $t6,   $zero, 0
> +
> +mainloop:
> +    li.d    $t0, LOONGARCH_TEST_MEM_START
> +
> +innerloop:
> +    ld.bu   $t3, $t0, 0
> +    addi.w  $t3, $t3, 1
> +    ext.w.b $t3, $t3
> +    st.b    $t3, $t0, 0
> +    add.d   $t0, $t0, $t2
> +    bne     $t0, $t1, innerloop
> +
> +    addi.d  $t6, $t6, 1
> +    andi    $t6, $t6, 31
> +    bnez    $t6, mainloop
> +
> +    st.b    $t5, $t4, 0
> +    b       mainloop
> diff --git a/tests/qtest/migration/loongarch64/a-b-kernel.h b/tests/qtest/migration/loongarch64/a-b-kernel.h
> new file mode 100644
> index 0000000000..6d5d811f79
> --- /dev/null
> +++ b/tests/qtest/migration/loongarch64/a-b-kernel.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/*
> + * This file is automatically generated from the assembly file in
> + * tests/qtest/migration/loongarch64. Edit that file and then run "make"
> + * inside tests/qtest/migration to update, and then remember to send both
> + * the header and the assembler differences in your patch submission.
> + */
> +unsigned char loongarch64_kernel[] = {
> +  0x0c, 0xc0, 0x3f, 0x14, 0x8c, 0x81, 0x87, 0x03, 0x0d, 0x04, 0x81, 0x03,
> +  0x8d, 0x01, 0x00, 0x29, 0x0c, 0x00, 0x04, 0x14, 0x0d, 0x80, 0x0c, 0x14,
> +  0x2e, 0x00, 0x00, 0x14, 0x10, 0xc0, 0x3f, 0x14, 0x10, 0x82, 0x87, 0x03,
> +  0x11, 0x08, 0x81, 0x03, 0x80, 0x01, 0x00, 0x29, 0x8c, 0xb9, 0x10, 0x00,
> +  0x8d, 0xf9, 0xff, 0x5f, 0x12, 0x00, 0xc0, 0x02, 0x0c, 0x00, 0x04, 0x14,
> +  0x8f, 0x01, 0x00, 0x2a, 0xef, 0x05, 0x80, 0x02, 0xef, 0x5d, 0x00, 0x00,
> +  0x8f, 0x01, 0x00, 0x29, 0x8c, 0xb9, 0x10, 0x00, 0x8d, 0xed, 0xff, 0x5f,
> +  0x52, 0x06, 0xc0, 0x02, 0x52, 0x7e, 0x40, 0x03, 0x5f, 0xde, 0xff, 0x47,
> +  0x11, 0x02, 0x00, 0x29, 0xff, 0xd7, 0xff, 0x53
> +};
> +
>
> base-commit: 10a9fa0065a3cd3dcf12e2eae6b8caaac6ecdec7

Acked-by: Fabiano Rosas <farosas@suse.de>

