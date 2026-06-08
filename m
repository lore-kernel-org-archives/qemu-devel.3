Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86442CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWb4j-0001de-RU; Mon, 08 Jun 2026 10:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wWb4d-0001cu-5v
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wWb4a-0000Jk-V2
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780929327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=idpFh90Vgx90mVssXYaIvdpbfEGRhlcJJVtTlaFUQOk=;
 b=FSxbs8DwAEu5Ip88fitA9Wonm3F85gyhf1PvXuK77NHKVTVWPxVRx/PhCHDHBUkMPCljGY
 VgXw7RxuAwMUq1E0u3lM15IVK8m37d6MLXpyD1nkKWEVOtmuFx/YddIOpYkknvFdpCMVV4
 MQUhhdgCQzkoUrypNVThN/bt1PBVsB8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-q_QNfCbONp22ZYtzoxAuxg-1; Mon, 08 Jun 2026 10:35:23 -0400
X-MC-Unique: q_QNfCbONp22ZYtzoxAuxg-1
X-Mimecast-MFC-AGG-ID: q_QNfCbONp22ZYtzoxAuxg_1780929323
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8cecac0e467so76801686d6.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780929323; x=1781534123; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=idpFh90Vgx90mVssXYaIvdpbfEGRhlcJJVtTlaFUQOk=;
 b=Zg37YG5wqbhcJG2D3buBC48RtxJgXNKvKS5YY9XXVhe4KzqiLlX1Ci1dFBgIBgSTA0
 Ac7X7GUZ5R2UYSmslq5DHl4E2I2XPhsKGCgyvLsfaioz6QfqtjKk0tq1Xzk9NUFjIA2Z
 avYEnToH2QbCU+cJTOqHbVXbKHeaO6Wd+GSQvCMymSMJCDwRNXZP/goctWiRLwaOs8ms
 38mcEcZmIC7sGXJ4elw38/3DiYWYdzPRL2Rh2p0zXQtfKbx/VcoP34dDbQDpqdGEELEU
 sIU1jH1sHtjIzZsFhePDM0Iw59xt+mgD4RHbOE27n165Pf4EQtqZ6dTQ51XjoufIM4nE
 z97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780929323; x=1781534123;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=idpFh90Vgx90mVssXYaIvdpbfEGRhlcJJVtTlaFUQOk=;
 b=Eethx/Z2NpKJUW4dbMNoKrM+K5AE8AC+k29eLQrmy0U2p/cBtEv5RNwr4V3fN/TZHv
 8Gxayi1SZBd/FunqaBsFqE0kJxFIX9kZ6zSkXnj62i4KvS/QuqVg/50t+/iOB1EZPeZC
 hZmYkPM36rxa/SfFg52gsInMyif+WJisfOwZfgK4XYX7dVbD/ZzxvfxBeH+vu/KFxI1t
 cJiNz8Hz7DEpRzP2lsZHLr+swuAiVOftHf4+PHRB7v0Iq+wN/024KgUxc4KW5NLaeV7y
 pn9b8TP0Wgl09PGdFh7hHNfokysiokobm1qF6w3gcBdOPTbLDstaSr6wuiW6p/Y1182R
 n7AA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/v596l/Hqxur+9PqP+lFfQG3vooNnCf8e9FogWUPWr6OHViZoTWALppjQdAS6AkfgG9naw/XbMQCRY@nongnu.org
X-Gm-Message-State: AOJu0Yz0lPLI6nbXP6HvcadnqTXIxWXhCFWaoj1UAi7xs0wfZ70ETPbg
 2ifNxCK37yIqd6xRP0UyruGA5WfOjMWHOCSK2pdJDf47C5m/I+sJnqc0TcGxjyOJMDChCSZA0KD
 sUpu4OvGovQFFhjYP2nn+uRD9cDXAChEh/yql7wlKojHi3cMfetvKdmuM
X-Gm-Gg: Acq92OGVuvb/kFOS3YSSrj5+LYj28jlrqroczCX/23VPQRpXuueglh8hkHzMVp8pNzk
 4FMECi+PDkua1wsp5W4c4oMi/scZnTA1XxgxJwwQ2hN7p7qHE25XEJHFG1+OBgZdF/e5ybHO0S0
 9yR/tySjPvhONWsQMGmZWtjEM7soheygVICAywfTRio7LpCJ7u5vCQKQHRhtvoskdUjUTmOcube
 9kNq0K8Tco/mex+u/qeEDF6+0QqISDln1s5v+22d1SRpyIC6ZtxfYF613pVEHHLVxgRj0CdKf3a
 SHlUu1NJGUhVa6e0h/VMovXxRDrydN4eGEMfknYJI6L01jXa25gwAmmPvUqapC/rC+cOA/P2GQz
 VZd7BuP+K6LXk8S1Pr79xTfjyNQ==
X-Received: by 2002:a0c:ea45:0:b0:8cc:f354:f47f with SMTP id
 6a1803df08f44-8cee60233b7mr199354066d6.29.1780929323008; 
 Mon, 08 Jun 2026 07:35:23 -0700 (PDT)
X-Received: by 2002:a0c:ea45:0:b0:8cc:f354:f47f with SMTP id
 6a1803df08f44-8cee60233b7mr199353176d6.29.1780929322268; 
 Mon, 08 Jun 2026 07:35:22 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd07629dsm169055706d6.39.2026.06.08.07.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:35:21 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:35:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest/migration: Add migration test on loongarch
Message-ID: <aibTKGCz7vIS-fMH@x1.local>
References: <20260608065947.428141-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608065947.428141-1-maobibo@loongson.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 08, 2026 at 02:59:47PM +0800, Bibo Mao wrote:
> Add migration qtest on loongarch64 system, the test passes to run with
> the following result:
>   qemu:qtest+qtest-loongarch64/qtest-loongarch64/migration-test OK 15.94s 9 subtests passed
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  MAINTAINERS                                   |  1 +
>  tests/qtest/meson.build                       |  3 +-
>  tests/qtest/migration/Makefile                |  2 +-
>  tests/qtest/migration/bootfile.c              |  4 ++
>  tests/qtest/migration/bootfile.h              |  4 ++
>  tests/qtest/migration/framework.c             |  6 +++
>  tests/qtest/migration/loongarch64/Makefile    | 20 ++++++++
>  .../qtest/migration/loongarch64/a-b-kernel.S  | 46 +++++++++++++++++++
>  .../qtest/migration/loongarch64/a-b-kernel.h  | 13 ++++++
>  9 files changed, 97 insertions(+), 2 deletions(-)
>  create mode 100644 tests/qtest/migration/loongarch64/Makefile
>  create mode 100644 tests/qtest/migration/loongarch64/a-b-kernel.S
>  create mode 100644 tests/qtest/migration/loongarch64/a-b-kernel.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 79ecac16fe..2105db7155 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1368,6 +1368,7 @@ F: hw/intc/loongarch_*.c
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
> index c183b69941..b94836eb0f 100644
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
> index 0000000000..132db292b9
> --- /dev/null
> +++ b/tests/qtest/migration/loongarch64/a-b-kernel.h
> @@ -0,0 +1,13 @@
> +
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

The binary data matches with what I tested with this patch, but it misses
the __note, please re-generate with the current Makefile to make it aligned
with the rest headers; also it won't show up as modifications with
re-generations then.

The other thing is I saw we added enforcements to use SPDX license
identifiers since last year (b36934063c5), IIUC we can add that line into
__note of the Makefile.

Thanks,

> +
> 
> base-commit: 3390aba56c354637eccd2d5ab5fd6efc2f026f06
> -- 
> 2.54.0
> 
> 

-- 
Peter Xu


