Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8089CF6D28
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw0av-0001pD-Px; Wed, 02 Oct 2024 10:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sw0aq-0001ol-IH; Wed, 02 Oct 2024 10:44:45 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sw0ao-0000vd-JE; Wed, 02 Oct 2024 10:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=DJ63MtFHAPC/hHOP++OWK25Hb38xmgQ1DqJ8bdPJD7k=; b=VWCHxqNn/MDz2m19uIk0pDsmSB
 vDGB1nI0NTWTiT0zOlUR+fLrWjXCoRd0Dil/bOduZhze2qujjC/NSOGpdDtV/sokTd2gm8Ew7Lwjn
 usGUid0h20RFIG5PUBgx1kAKlZxL7TDD6+GrZX+jpUue3Y227+Feg6idmfP47yPnmMkBojhyWRqTe
 bXQj+6TwxkRGrdyoYh5y4aeihcKkLqDNmT1dEkVMEjTu956KpqnAAZECTrKIMyR3S3TnoD29WDmeD
 K6vhmipktHrb4pnJuUSGR3E6IIbGxMw8tuc1uyry5ANCbXqxSlw5PWKaIx8N1ZSeeTw+5KnC/DJkz
 scwueHJ/JBY0GwdnpE1jIaa1ABDkpdy22mejv9zAME8iOGjvCBRWrabDhi9qgKkAQtgBN7ohWYboG
 0aCE5gbsp7JQnEYzI0CuNqI+/KdxOQyzIH0PyuWrH/uEU8kVaWowFwxQDEsQVoIne+azssZNLgq6w
 dRfn9Cz9CFyLzvoIeoMLvO+DfwBzIlo777A92Hq/B1rZQIpXGkh9L6y/v/0jxtSz+9azf9Topw8DA
 YGa6W5VHCKg/Z1W6J43v1l55QpbjZbIipX89LJ5Oz5fUZbiG3cBPW0LWXY4HQD8JhUYJKAFrkbw0a
 EmjBFIcT7n01yIBqcHGuWPj3fcg27MFs3JO/jXMxo=;
Received: from [2a00:23c4:8bb8:7000:9d60:c1f9:7d71:173a]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sw0aW-0003tZ-2a; Wed, 02 Oct 2024 15:44:27 +0100
Message-ID: <69ec3c06-ad14-4c86-8361-61dd8fbc67c7@ilande.co.uk>
Date: Wed, 2 Oct 2024 15:44:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
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
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <c08eef57-6e93-4856-a1a4-634ce687997e@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:7000:9d60:c1f9:7d71:173a
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/riscv/spike: Replace tswap64() by ldq_endian_p()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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

On 02/10/2024 15:17, Daniel Henrique Barboza wrote:

> Phil, this patch breaks 'make check-avocado' in my env:
> 
> 
>    AVOCADO tests/avocado
> JOB ID     : 2e98b3ea8b63d22f092ff73bdadfd975cbc27026
> JOB LOG    : 
> /home/danielhb/work/qemu/build/tests/results/job-2024-10-02T10.48-2e98b3e/job.log
>   (01/15) tests/avocado/riscv_opensbi.py:RiscvOpenSBI.test_riscv32_spike: STARTED
>   (01/15) tests/avocado/riscv_opensbi.py:RiscvOpenSBI.test_riscv32_spike: 
> INTERRUPTED: Test interrupted: Timeout reached (5.07 s)
> Interrupting job (failfast).
> RESULTS    : PASS 0 | ERROR 0 | FAIL 0 | SKIP 14 | WARN 0 | INTERRUPT 1 | CANCEL 0
> JOB TIME   : 7.57 s
> 
> Test summary:
> 01-tests/avocado/riscv_opensbi.py:RiscvOpenSBI.test_riscv32_spike: INTERRUPTED
> make[1]: *** [/home/danielhb/work/qemu/tests/Makefile.include:141: check-avocado] 
> Error 8
> 
> 
> In fact, if you try to execute the 'spike' machine with --nographics, you're
> supposed to see the OpenSBI banner and boot. With this patch I don't see
> anything:
> 
> 
> $ ./build/qemu-system-riscv32 -M spike --nographic
> (---nothing---)
> 
> 
> For reference this is what I applied on top of master to test it:
> 
> 
> 9de01b7f1c (HEAD -> review) hw/riscv/spike: Replace tswap64() by ldq_endian_p()
> 202986f968 hw/net/tulip: Use ld/st_endian_pci_dma() API
> 30aacb872e hw/pci/pci_device: Introduce ld/st_endian_pci_dma() API
> 8ee9a2310b hw/pci/pci_device: Add PCI_DMA_DEFINE_LDST_END() macro
> 54271f92e5 hw/virtio/virtio-access: Use ld/st_endian_phys() API
> 54ff063593 exec/memory_ldst_phys: Introduce ld/st_endian_phys() API
> 5749a411cc hw/xtensa/xtfpga: Replace memcpy()+tswap32() by stl_endian_p()
> 75b7a99a5d hw/xtensa/xtfpga: Remove TARGET_BIG_ENDIAN #ifdef'ry
> 652016da1e tests/tcg/plugins: Use the ld/st_endian_p() API
> d1e4d2544a hw/mips: Add cpu_is_bigendian field to BlCpuCfg structure
> 6a7b3e09bb hw/mips: Pass BlCpuCfg argument to bootloader API
> 0466217d0e target/arm/ptw: Use the ld/st_endian_p() API
> 920a241f00 hw/virtio/virtio-access: Use the ld/st_endian_p() API
> e5fc1a2224 qemu/bswap: Introduce ld/st_endian_p() API
> 062cfce8d4 (origin/master, origin/HEAD, master) Merge tag 'pull-target-arm-20241001' 
> of https://git.linaro.org/people/pmaydell/qemu-arm into staging
> 
> 
> Let me know if I did something wrong. Thanks,
> 
> 
> Daniel
> 
> On 9/30/24 9:48 AM, Philippe Mathieu-Daudé wrote:
>> Hold the target endianness in HTIFState::target_is_bigendian.
>> Pass the target endianness as argument to htif_mm_init().
>> Replace tswap64() calls by ldq_endian_p() ones.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Based-on: <20240930073450.33195-2-philmd@linaro.org>
>>            "qemu/bswap: Introduce ld/st_endian_p() API"
>>
>> Note: this is a non-QOM device!
>> ---
>>   include/hw/char/riscv_htif.h |  4 +++-
>>   hw/char/riscv_htif.c         | 17 +++++++++++------
>>   hw/riscv/spike.c             |  2 +-
>>   3 files changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/hw/char/riscv_htif.h b/include/hw/char/riscv_htif.h
>> index df493fdf6b..24868ddfe1 100644
>> --- a/include/hw/char/riscv_htif.h
>> +++ b/include/hw/char/riscv_htif.h
>> @@ -35,6 +35,7 @@ typedef struct HTIFState {
>>       hwaddr tohost_offset;
>>       hwaddr fromhost_offset;
>>       MemoryRegion mmio;
>> +    bool target_is_bigendian;
>>       CharBackend chr;
>>       uint64_t pending_read;
>> @@ -49,6 +50,7 @@ void htif_symbol_callback(const char *st_name, int st_info, 
>> uint64_t st_value,
>>   /* legacy pre qom */
>>   HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
>> -                        uint64_t nonelf_base, bool custom_base);
>> +                        uint64_t nonelf_base, bool custom_base,
>> +                        bool target_is_bigendian);
>>   #endif
>> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
>> index 9bef60def1..77951f3c76 100644
>> --- a/hw/char/riscv_htif.c
>> +++ b/hw/char/riscv_htif.c
>> @@ -30,7 +30,6 @@
>>   #include "qemu/timer.h"
>>   #include "qemu/error-report.h"
>>   #include "exec/address-spaces.h"
>> -#include "exec/tswap.h"
>>   #include "sysemu/dma.h"
>>   #include "sysemu/runstate.h"
>> @@ -211,13 +210,17 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t 
>> val_written)
>>                       SHUTDOWN_CAUSE_GUEST_SHUTDOWN, exit_code);
>>                   return;
>>               } else {
>> +                bool be = s->target_is_bigendian;
>>                   uint64_t syscall[8];
>> +
>>                   cpu_physical_memory_read(payload, syscall, sizeof(syscall));
>> -                if (tswap64(syscall[0]) == PK_SYS_WRITE &&
>> -                    tswap64(syscall[1]) == HTIF_DEV_CONSOLE &&
>> -                    tswap64(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
>> +                if (ldq_endian_p(be, &syscall[0]) == PK_SYS_WRITE &&
>> +                    ldq_endian_p(be, &syscall[1]) == HTIF_DEV_CONSOLE &&
>> +                    ldq_endian_p(be, &syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
>>                       uint8_t ch;
>> -                    cpu_physical_memory_read(tswap64(syscall[2]), &ch, 1);
>> +
>> +                    cpu_physical_memory_read(ldl_endian_p(be, &syscall[2]),

                                                  ^^^^^^^^^^^^

Shouldn't this be ldq_endian_p() for a 64-bit value?

>> +                                             &ch, 1);




>>                       qemu_chr_fe_write(&s->chr, &ch, 1);
>>                       resp = 0x100 | (uint8_t)payload;
>>                   } else {
>> @@ -320,7 +323,8 @@ static const MemoryRegionOps htif_mm_ops = {
>>   };
>>   HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
>> -                        uint64_t nonelf_base, bool custom_base)
>> +                        uint64_t nonelf_base, bool custom_base,
>> +                        bool target_is_bigendian)
>>   {
>>       uint64_t base, size, tohost_offset, fromhost_offset;
>> @@ -345,6 +349,7 @@ HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
>>       s->pending_read = 0;
>>       s->allow_tohost = 0;
>>       s->fromhost_inprogress = 0;
>> +    s->target_is_bigendian = target_is_bigendian;
>>       qemu_chr_fe_init(&s->chr, chr, &error_abort);
>>       qemu_chr_fe_set_handlers(&s->chr, htif_can_recv, htif_recv, htif_event,
>>           htif_be_change, s, NULL, true);
>> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
>> index 64074395bc..0989cd4a41 100644
>> --- a/hw/riscv/spike.c
>> +++ b/hw/riscv/spike.c
>> @@ -327,7 +327,7 @@ static void spike_board_init(MachineState *machine)
>>       /* initialize HTIF using symbols found in load_kernel */
>>       htif_mm_init(system_memory, serial_hd(0), memmap[SPIKE_HTIF].base,
>> -                 htif_custom_base);
>> +                 htif_custom_base, TARGET_BIG_ENDIAN);
>>   }
>>   static void spike_set_signature(Object *obj, const char *val, Error **errp)


ATB,

Mark.


