Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A46BCF8853
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 17:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swm9g-0003Lw-9a; Fri, 04 Oct 2024 13:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1swm9b-0003KL-Gl; Fri, 04 Oct 2024 13:31:49 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1swm9W-0003pf-Tr; Fri, 04 Oct 2024 13:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=pgShBPi3db+/ogjufvHb1oLDpXge2eirsd8XxyB6NPQ=; b=ax59n5frQzZEUkvILd66Q5Rzew
 OT/06aM14oVhob5+O2OmDyG8xpc6yE6xhz/j0pEB7am6NyV86ioh2MdV5orGX/DTaftl9sjdQ5Ey7
 UATt6hCkjA5XSaKfUCTk8rdTyyK5KRWMBwbIOBpJRfxkI5CvbgW0yapTYGzxWd2b7zydhe9jqsTgZ
 uSuh/XZzthdfx/lg567k0iAC4sLS/e3GDXuedfcTWgOV1wXytfkp4oiBirvQC0knSH+9DTYpqqHkX
 zyDwWMFb9EkWWy34emJigMiWewadA8dfeCmlFv1Wg/owQ2rL9HqZJnGRcsADZfGWwD0YeaoYwxdXG
 4NtEcQyWxdDnlU161BoGM7HgeCMASi5hXhZugJbs/WFnWmV7mSYCG+np017nBL6DhzUicYfxV8S2M
 MKdSy/NE2RO9NWTXbLn/gbyRuIn+Qz4WSSD9Vz10X5rnQUnMdVMBeC5+ChAuo/ha05te1aQ6hCJJu
 y0wMwnpdyGmTuFS02E2fqGWxP+a21EoffE+SoOki6ZC4G8ck9k+14x6V4FnY45bM1MUzSVHL7Il2Q
 YTx4DkvgrJG7KrdXe9LwEzazx/CCU7niZDGf0td+KYY8mZjfUlrDuPWBB7bia5z6cQncxE6pfLE0t
 Euy1PkFz544U59+shrZy+59nd8YqKmX2OfSdhgBN4=;
Received: from [2a00:23c4:8bb8:7000:a881:a1c6:b783:4187]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1swm96-0008Nt-PK; Fri, 04 Oct 2024 18:31:20 +0100
Message-ID: <5310183f-b11d-45d5-bab3-7193042181e9@ilande.co.uk>
Date: Fri, 4 Oct 2024 18:31:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Eric Farman <farman@linux.ibm.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20241003234211.53644-1-philmd@linaro.org>
 <20241003234211.53644-12-philmd@linaro.org>
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
In-Reply-To: <20241003234211.53644-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:7000:a881:a1c6:b783:4187
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 11/16] hw/sparc: Use explicit big-endian LD/ST API
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

On 04/10/2024 00:42, Philippe Mathieu-Daudé wrote:

> The SPARC architecture uses big endianness. Directly use
> the big-endian LD/ST API.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sparc/leon3.c   | 42 +++++++++++++++++++++---------------------
>   hw/sparc/sun4m.c   |  6 +++---
>   hw/sparc64/sun4u.c |  6 +++---
>   3 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 6aaa04cb191..021b5070128 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -78,21 +78,21 @@ typedef struct ResetData {
>   
>   static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
>   {
> -    stl_p(code++, 0x82100000); /* mov %g0, %g1                */
> -    stl_p(code++, 0x84100000); /* mov %g0, %g2                */
> -    stl_p(code++, 0x03000000 +
> +    stl_be_p(code++, 0x82100000); /* mov %g0, %g1                */
> +    stl_be_p(code++, 0x84100000); /* mov %g0, %g2                */
> +    stl_be_p(code++, 0x03000000 +
>         extract32(addr, 10, 22));
>                                  /* sethi %hi(addr), %g1        */
> -    stl_p(code++, 0x82106000 +
> +    stl_be_p(code++, 0x82106000 +
>         extract32(addr, 0, 10));
>                                  /* or %g1, addr, %g1           */
> -    stl_p(code++, 0x05000000 +
> +    stl_be_p(code++, 0x05000000 +
>         extract32(val, 10, 22));
>                                  /* sethi %hi(val), %g2         */
> -    stl_p(code++, 0x8410a000 +
> +    stl_be_p(code++, 0x8410a000 +
>         extract32(val, 0, 10));
>                                  /* or %g2, val, %g2            */
> -    stl_p(code++, 0xc4204000); /* st %g2, [ %g1 ]             */
> +    stl_be_p(code++, 0xc4204000); /* st %g2, [ %g1 ]             */
>   
>       return code;
>   }
> @@ -112,13 +112,13 @@ static void write_bootloader(void *ptr, hwaddr kernel_addr)
>   
>       /* If we are running on a secondary CPU, jump directly to the kernel.  */
>   
> -    stl_p(p++, 0x85444000); /* rd %asr17, %g2      */
> -    stl_p(p++, 0x8530a01c); /* srl  %g2, 0x1c, %g2 */
> -    stl_p(p++, 0x80908000); /* tst  %g2            */
> +    stl_be_p(p++, 0x85444000); /* rd %asr17, %g2      */
> +    stl_be_p(p++, 0x8530a01c); /* srl  %g2, 0x1c, %g2 */
> +    stl_be_p(p++, 0x80908000); /* tst  %g2            */
>       /* Filled below.  */
>       sec_cpu_branch_p = p;
> -    stl_p(p++, 0x0BADC0DE); /* bne xxx             */
> -    stl_p(p++, 0x01000000); /* nop */
> +    stl_be_p(p++, 0x0BADC0DE); /* bne xxx             */
> +    stl_be_p(p++, 0x01000000); /* nop */
>   
>       /* Initialize the UARTs                                        */
>       /* *UART_CONTROL = UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
> @@ -133,17 +133,17 @@ static void write_bootloader(void *ptr, hwaddr kernel_addr)
>       p = gen_store_u32(p, 0x80000318, 3);
>   
>       /* Now, the relative branch above can be computed.  */
> -    stl_p(sec_cpu_branch_p, 0x12800000
> -          + (p - sec_cpu_branch_p));
> +    stl_be_p(sec_cpu_branch_p, 0x12800000
> +             + (p - sec_cpu_branch_p));
>   
>       /* JUMP to the entry point                                     */
> -    stl_p(p++, 0x82100000); /* mov %g0, %g1 */
> -    stl_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
> -                            /* sethi %hi(kernel_addr), %g1 */
> -    stl_p(p++, 0x82106000 + extract32(kernel_addr, 0, 10));
> -                            /* or kernel_addr, %g1 */
> -    stl_p(p++, 0x81c04000); /* jmp  %g1 */
> -    stl_p(p++, 0x01000000); /* nop */
> +    stl_be_p(p++, 0x82100000); /* mov %g0, %g1 */
> +    stl_be_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
> +                               /* sethi %hi(kernel_addr), %g1 */
> +    stl_be_p(p++, 0x82106000 + extract32(kernel_addr, 0, 10));
> +                               /* or kernel_addr, %g1 */
> +    stl_be_p(p++, 0x81c04000); /* jmp  %g1 */
> +    stl_be_p(p++, 0x01000000); /* nop */
>   }
>   
>   static void leon3_cpu_reset(void *opaque)
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index d52e6a7213f..f375f0d389b 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -271,9 +271,9 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
>           if (*initrd_size > 0) {
>               for (i = 0; i < 64 * TARGET_PAGE_SIZE; i += TARGET_PAGE_SIZE) {
>                   ptr = rom_ptr(KERNEL_LOAD_ADDR + i, 24);
> -                if (ptr && ldl_p(ptr) == 0x48647253) { /* HdrS */
> -                    stl_p(ptr + 16, INITRD_LOAD_ADDR);
> -                    stl_p(ptr + 20, *initrd_size);
> +                if (ptr && ldl_be_p(ptr) == 0x48647253) { /* HdrS */
> +                    stl_be_p(ptr + 16, INITRD_LOAD_ADDR);
> +                    stl_be_p(ptr + 20, *initrd_size);
>                       break;
>                   }
>               }
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 4ece1ac1ffc..e591e5a741a 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -210,9 +210,9 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
>           if (*initrd_size > 0) {
>               for (i = 0; i < 64 * TARGET_PAGE_SIZE; i += TARGET_PAGE_SIZE) {
>                   ptr = rom_ptr(*kernel_addr + i, 32);
> -                if (ptr && ldl_p(ptr + 8) == 0x48647253) { /* HdrS */
> -                    stl_p(ptr + 24, *initrd_addr + *kernel_addr);
> -                    stl_p(ptr + 28, *initrd_size);
> +                if (ptr && ldl_be_p(ptr + 8) == 0x48647253) { /* HdrS */
> +                    stl_be_p(ptr + 24, *initrd_addr + *kernel_addr);
> +                    stl_be_p(ptr + 28, *initrd_size);
>                       break;
>                   }
>               }

For sun4m and sun4u:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


