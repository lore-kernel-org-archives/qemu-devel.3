Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5025BCF6D28
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 15:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw0rC-0006f7-Rw; Wed, 02 Oct 2024 11:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sw0rB-0006eh-Jf
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:01:37 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sw0r9-0002qj-Cw
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:01:37 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71dba8b05cbso2000824b3a.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727881294; x=1728486094; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XU/e+y9g7plHujV09FyoJRSn0zWYVvbtXItgvSgjDeo=;
 b=TrgIVdg7GeS0xodW6+k1p0oQjXTdEIFx/R5XsKmlfFlZNjsEVoqxOFxwZJDoVUtXz+
 DqVuWKDtuNYXydcRCkMo+Kvxa6CaqgzAybUz84yiEFmz/NgqhoEIPbfYz6frDdNU0jnI
 BQjfqIi5XVCBQDhws4EKuv3UHR3XNFK5KMj+sG2Rwbq6cYeG2cN1umJlmv6yrYapGvHv
 43szTboycBa7fFaJCRNlQOThDePeo5hQm5lRrRH+O4mOzscA5bqfJv5WO0CK7RBrBiRW
 Dd1dVVoG6C4IFvOG6NPOz/Qcwk7J71YEPeQoq9cLdEl/F75VxT5XXGB5u3QPxTM7d2Bc
 /ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727881294; x=1728486094;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XU/e+y9g7plHujV09FyoJRSn0zWYVvbtXItgvSgjDeo=;
 b=A4tgCrkO+IsSPSqqtKuMHSxHtsnmb6TSunSyvd68otfr5HeXs3t2ZZ3cZbDaQHFto5
 NBJbx8wgRBHtDdOQSNTsJLhztWB+trpeWxeKaa56NGYtmtsfQlmx06V6tFWr91U3NkUM
 Ga0jfgWTL62FMaDoSurYgYq+TPBnE2GCKiwNx6ax6Fu2ZfxfqNd3Lqthd+ljpRNTT+d/
 wug7uVO0Buh72wOsp7UzcCNxEhdWcGcDNLQ+QBauscIA+BT40si5SjvXIzuamM4v74p/
 cmU8gZfSBBJQm87/2XrKouWnnJjodnG9RzLE21oA2xQWEZ3cWjiwSNeR4NnUymMFcJ44
 Zzgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULjpdpShEOcbHnfkarRdnOlkZ73JWuRROXdPK9QQASHaHF/nuU3YOg6EXmOI5UVML95Fh4Ugp/wqvj@nongnu.org
X-Gm-Message-State: AOJu0YxhwkxoeUhRqdge0BsH4TiFGCm3wzT9XiH+kcbFbjOHiJiEgdzO
 fkpoESYexNfrrjV1pWol2lZ0/wdmFOL0UZxZ+sQ/hKLt/AIWNSV08i5X9/Gs3cY=
X-Google-Smtp-Source: AGHT+IF0uTMfQWXyRPdi9SEwdDaQlc+esjfYUY6EKTo41a9/2R7qRX9vbBRTo+0vuvKJbMf4lRKQPA==
X-Received: by 2002:a05:6a00:230a:b0:70b:176e:b3bc with SMTP id
 d2e1a72fcca58-71dc5d60276mr5163001b3a.28.1727881293473; 
 Wed, 02 Oct 2024 08:01:33 -0700 (PDT)
Received: from [192.168.68.110] (200-206-229-93.dsl.telesp.net.br.
 [200.206.229.93]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b26499743sm10279719b3a.18.2024.10.02.08.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 08:01:33 -0700 (PDT)
Message-ID: <3567507b-4e1e-4924-9088-8be3b09f552f@ventanamicro.com>
Date: Wed, 2 Oct 2024 12:01:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/spike: Replace tswap64() by ldq_endian_p()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Palmer Dabbelt <palmer@dabbelt.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>
References: <20240930124831.54232-1-philmd@linaro.org>
 <c08eef57-6e93-4856-a1a4-634ce687997e@ventanamicro.com>
 <69ec3c06-ad14-4c86-8361-61dd8fbc67c7@ilande.co.uk>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <69ec3c06-ad14-4c86-8361-61dd8fbc67c7@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/2/24 11:44 AM, Mark Cave-Ayland wrote:
> On 02/10/2024 15:17, Daniel Henrique Barboza wrote:
> 
>> Phil, this patch breaks 'make check-avocado' in my env:
>>
>>
>>    AVOCADO tests/avocado
>> JOB ID     : 2e98b3ea8b63d22f092ff73bdadfd975cbc27026
>> JOB LOG    : /home/danielhb/work/qemu/build/tests/results/job-2024-10-02T10.48-2e98b3e/job.log
>>   (01/15) tests/avocado/riscv_opensbi.py:RiscvOpenSBI.test_riscv32_spike: STARTED
>>   (01/15) tests/avocado/riscv_opensbi.py:RiscvOpenSBI.test_riscv32_spike: INTERRUPTED: Test interrupted: Timeout reached (5.07 s)
>> Interrupting job (failfast).
>> RESULTS    : PASS 0 | ERROR 0 | FAIL 0 | SKIP 14 | WARN 0 | INTERRUPT 1 | CANCEL 0
>> JOB TIME   : 7.57 s
>>
>> Test summary:
>> 01-tests/avocado/riscv_opensbi.py:RiscvOpenSBI.test_riscv32_spike: INTERRUPTED
>> make[1]: *** [/home/danielhb/work/qemu/tests/Makefile.include:141: check-avocado] Error 8
>>
>>
>> In fact, if you try to execute the 'spike' machine with --nographics, you're
>> supposed to see the OpenSBI banner and boot. With this patch I don't see
>> anything:
>>
>>
>> $ ./build/qemu-system-riscv32 -M spike --nographic
>> (---nothing---)
>>
>>
>> For reference this is what I applied on top of master to test it:
>>
>>
>> 9de01b7f1c (HEAD -> review) hw/riscv/spike: Replace tswap64() by ldq_endian_p()
>> 202986f968 hw/net/tulip: Use ld/st_endian_pci_dma() API
>> 30aacb872e hw/pci/pci_device: Introduce ld/st_endian_pci_dma() API
>> 8ee9a2310b hw/pci/pci_device: Add PCI_DMA_DEFINE_LDST_END() macro
>> 54271f92e5 hw/virtio/virtio-access: Use ld/st_endian_phys() API
>> 54ff063593 exec/memory_ldst_phys: Introduce ld/st_endian_phys() API
>> 5749a411cc hw/xtensa/xtfpga: Replace memcpy()+tswap32() by stl_endian_p()
>> 75b7a99a5d hw/xtensa/xtfpga: Remove TARGET_BIG_ENDIAN #ifdef'ry
>> 652016da1e tests/tcg/plugins: Use the ld/st_endian_p() API
>> d1e4d2544a hw/mips: Add cpu_is_bigendian field to BlCpuCfg structure
>> 6a7b3e09bb hw/mips: Pass BlCpuCfg argument to bootloader API
>> 0466217d0e target/arm/ptw: Use the ld/st_endian_p() API
>> 920a241f00 hw/virtio/virtio-access: Use the ld/st_endian_p() API
>> e5fc1a2224 qemu/bswap: Introduce ld/st_endian_p() API
>> 062cfce8d4 (origin/master, origin/HEAD, master) Merge tag 'pull-target-arm-20241001' of https://git.linaro.org/people/pmaydell/qemu-arm into staging
>>
>>
>> Let me know if I did something wrong. Thanks,
>>
>>
>> Daniel
>>
>> On 9/30/24 9:48 AM, Philippe Mathieu-Daudé wrote:
>>> Hold the target endianness in HTIFState::target_is_bigendian.
>>> Pass the target endianness as argument to htif_mm_init().
>>> Replace tswap64() calls by ldq_endian_p() ones.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> Based-on: <20240930073450.33195-2-philmd@linaro.org>
>>>            "qemu/bswap: Introduce ld/st_endian_p() API"
>>>
>>> Note: this is a non-QOM device!
>>> ---
>>>   include/hw/char/riscv_htif.h |  4 +++-
>>>   hw/char/riscv_htif.c         | 17 +++++++++++------
>>>   hw/riscv/spike.c             |  2 +-
>>>   3 files changed, 15 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/include/hw/char/riscv_htif.h b/include/hw/char/riscv_htif.h
>>> index df493fdf6b..24868ddfe1 100644
>>> --- a/include/hw/char/riscv_htif.h
>>> +++ b/include/hw/char/riscv_htif.h
>>> @@ -35,6 +35,7 @@ typedef struct HTIFState {
>>>       hwaddr tohost_offset;
>>>       hwaddr fromhost_offset;
>>>       MemoryRegion mmio;
>>> +    bool target_is_bigendian;
>>>       CharBackend chr;
>>>       uint64_t pending_read;
>>> @@ -49,6 +50,7 @@ void htif_symbol_callback(const char *st_name, int st_info, uint64_t st_value,
>>>   /* legacy pre qom */
>>>   HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
>>> -                        uint64_t nonelf_base, bool custom_base);
>>> +                        uint64_t nonelf_base, bool custom_base,
>>> +                        bool target_is_bigendian);
>>>   #endif
>>> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
>>> index 9bef60def1..77951f3c76 100644
>>> --- a/hw/char/riscv_htif.c
>>> +++ b/hw/char/riscv_htif.c
>>> @@ -30,7 +30,6 @@
>>>   #include "qemu/timer.h"
>>>   #include "qemu/error-report.h"
>>>   #include "exec/address-spaces.h"
>>> -#include "exec/tswap.h"
>>>   #include "sysemu/dma.h"
>>>   #include "sysemu/runstate.h"
>>> @@ -211,13 +210,17 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
>>>                       SHUTDOWN_CAUSE_GUEST_SHUTDOWN, exit_code);
>>>                   return;
>>>               } else {
>>> +                bool be = s->target_is_bigendian;
>>>                   uint64_t syscall[8];
>>> +
>>>                   cpu_physical_memory_read(payload, syscall, sizeof(syscall));
>>> -                if (tswap64(syscall[0]) == PK_SYS_WRITE &&
>>> -                    tswap64(syscall[1]) == HTIF_DEV_CONSOLE &&
>>> -                    tswap64(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
>>> +                if (ldq_endian_p(be, &syscall[0]) == PK_SYS_WRITE &&
>>> +                    ldq_endian_p(be, &syscall[1]) == HTIF_DEV_CONSOLE &&
>>> +                    ldq_endian_p(be, &syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
>>>                       uint8_t ch;
>>> -                    cpu_physical_memory_read(tswap64(syscall[2]), &ch, 1);
>>> +
>>> +                    cpu_physical_memory_read(ldl_endian_p(be, &syscall[2]),
> 
>                                                   ^^^^^^^^^^^^
> 
> Shouldn't this be ldq_endian_p() for a 64-bit value?

Bingo! This change fixes make check-avocado and the OpenSBI boot:

$ git diff
diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 77951f3c76..0ed038a70c 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -219,7 +219,7 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
                      ldq_endian_p(be, &syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
                      uint8_t ch;
  
-                    cpu_physical_memory_read(ldl_endian_p(be, &syscall[2]),
+                    cpu_physical_memory_read(ldq_endian_p(be, &syscall[2]),
                                               &ch, 1);
                      qemu_chr_fe_write(&s->chr, &ch, 1);
                      resp = 0x100 | (uint8_t)payload;

$ ./build/qemu-system-riscv32 -M spike --nographic

OpenSBI v1.5.1
    ____                    _____ ____ _____
   / __ \                  / ____|  _ \_   _|
  | |  | |_ __   ___ _ __ | (___ | |_) || |
  | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
  | |__| | |_) |  __/ | | |____) | |_) || |_
   \____/| .__/ \___|_| |_|_____/|____/_____|
         | |
         |_|
(...)



Thanks,

Daniel

> 
>>> +                                             &ch, 1);
> 
> 
> 
> 
>>>                       qemu_chr_fe_write(&s->chr, &ch, 1);
>>>                       resp = 0x100 | (uint8_t)payload;
>>>                   } else {
>>> @@ -320,7 +323,8 @@ static const MemoryRegionOps htif_mm_ops = {
>>>   };
>>>   HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
>>> -                        uint64_t nonelf_base, bool custom_base)
>>> +                        uint64_t nonelf_base, bool custom_base,
>>> +                        bool target_is_bigendian)
>>>   {
>>>       uint64_t base, size, tohost_offset, fromhost_offset;
>>> @@ -345,6 +349,7 @@ HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
>>>       s->pending_read = 0;
>>>       s->allow_tohost = 0;
>>>       s->fromhost_inprogress = 0;
>>> +    s->target_is_bigendian = target_is_bigendian;
>>>       qemu_chr_fe_init(&s->chr, chr, &error_abort);
>>>       qemu_chr_fe_set_handlers(&s->chr, htif_can_recv, htif_recv, htif_event,
>>>           htif_be_change, s, NULL, true);
>>> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
>>> index 64074395bc..0989cd4a41 100644
>>> --- a/hw/riscv/spike.c
>>> +++ b/hw/riscv/spike.c
>>> @@ -327,7 +327,7 @@ static void spike_board_init(MachineState *machine)
>>>       /* initialize HTIF using symbols found in load_kernel */
>>>       htif_mm_init(system_memory, serial_hd(0), memmap[SPIKE_HTIF].base,
>>> -                 htif_custom_base);
>>> +                 htif_custom_base, TARGET_BIG_ENDIAN);
>>>   }
>>>   static void spike_set_signature(Object *obj, const char *val, Error **errp)
> 
> 
> ATB,
> 
> Mark.
> 

