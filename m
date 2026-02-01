Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477DBE6527D
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 14:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmYQd-00071G-VY; Sun, 01 Feb 2026 09:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmYQb-00070T-P4
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 09:27:54 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmYQZ-00066u-EW
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 09:27:53 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so3055382f8f.2
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 06:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769956069; x=1770560869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1cEY5hd55vJSlo36RYqQKjeHZFEKX033NGVp/UYRj/8=;
 b=tBnoU2VVBzi5V5K+tZR98x0MXZwSKvirl2bSxjIKc0KXtqnQbvh+yKeaCi9nddSGJh
 Kma9jnSojkICY74FsAgLnA1WGSQRqDeIXmmJ0/nKauZbR28VXKNFmy5KD6P69tCl5w9J
 m/dw7dY0B0JwWxIWaHLhzvjj2lsbk2y8szp2dC0wFUVaRnQmAgexi3l0vlmAjKpfXgjR
 ACf1g5F5msHzyCnkf9fYBw68faRJg4rrXylz3VHoys3Qy9sxyr35Ha+R3W98cUVTtZRU
 fVugJ/3A1A3hFMov2umP3Gl2zgnvLIC5FiaNoIx6071JyPP6zz3gH+Pg5HaCDwi1eoEK
 BU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769956069; x=1770560869;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1cEY5hd55vJSlo36RYqQKjeHZFEKX033NGVp/UYRj/8=;
 b=gJ/kB2njaJ/r6pCyKyjqbn6G9TRlvUjySqtAa9Ze0BQfer/DmeXROijRPDIF4RgLpK
 HH+ckYCQ4ZkeRMdWD6pex+EPBO8qJnuN7khUeHmuEupf91PXmHmysAkWUbqS410r4/gm
 AyaG3SbzomqeSrpxfJ6Y8wfT+dgEQEtDbfq26xZxdZv4idEFlB4urX8wM07sx8Re1qmq
 QFJv6GGNAuZZxFKp+oXX8fkn6b6Ac/ikBmcnBSJjI8HfEtull7yZ5KlymNJPe61gMl2Y
 59fDR2/hFUkZZ8lFhXJf1bZivgpym0j+iXHwSyqi6wo6LnBEVb2vwWcJLcdSQST8RYuC
 5vHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHb29OJS4ijQdVhJNSU2tHnuMMkv+H87CcWBhLKLTwh5cLEalQMriRKmI2eqCSjWtCeABQhnwtXS8g@nongnu.org
X-Gm-Message-State: AOJu0Yy9HwkPbRhw/HdslJGgtuLUlR7CsH/JMgIi3BICgRVjKgwk/X/Q
 47nqJuMyGgtJgD82LszScf39RZ9edK3gJdmF1o+89p1s2JruZUFHAWpCZB7ZrSx9g6I=
X-Gm-Gg: AZuq6aJOA8JxGkjtUc7dIhlHB3igdeGX0noSm1Le212/4c47YKU7pG/BnvtO71Crpy1
 Yv11YVUezH1K8P9BLsjEj8I5I0DcrX+lKZCW5Q1OCcThgUYgZcRCR++7PBkaONoNh+UfDkU8uVA
 8Oqsr2ouyTSmBHnBkXSOAocX2omckfqs/6YfnQO+dgpb+caPm6I4/3oI90sbi7O6AifljGvjv+A
 qghC+l1XxNFezI7sXMIXbXR/KLi7iuufRAHwgW7K9CSFFwZNf+QRqFkxqIeU/9Iqu97FBjmPuvY
 QOz8AH7Ebfh5CXn1RcGQt3Ibuszh1LJKYx8G3TPZoHj41xPX0sK2UC01Mj7tHhgJpPxdAO+D5tO
 AxFCvVfch/ueCVush87u5tsrUV3aCDo4d4ao8OLfP5/LxXDk+fk7mdnVYw3uyznOgAltcrY3OcZ
 pzVC94w6rUaEs2tKgqsGN6+7fg0zhKbAmztIAfrI04lL3wi/p2vL0U5Q==
X-Received: by 2002:a05:6000:4312:b0:431:907:f324 with SMTP id
 ffacd0b85a97d-435f3ab3f55mr13360335f8f.61.1769956068677; 
 Sun, 01 Feb 2026 06:27:48 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e132303fsm37210513f8f.36.2026.02.01.06.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 06:27:48 -0800 (PST)
Message-ID: <479166c0-8135-4c99-a2bb-0532633d384d@linaro.org>
Date: Sun, 1 Feb 2026 15:27:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/vmmouse: Fix hypercall clobbers
Content-Language: en-US
To: Josh Poimboeuf <jpoimboe@kernel.org>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Justin Forbes <jforbes@fedoraproject.org>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <ae0b8f2c574abe8053e742260c794adcaeda975a.1769110562.git.jpoimboe@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ae0b8f2c574abe8053e742260c794adcaeda975a.1769110562.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi,

On 22/1/26 20:36, Josh Poimboeuf wrote:
> Fedora QA reported the following panic:
> 
>    BUG: unable to handle page fault for address: 0000000040003e54
>    #PF: supervisor write access in kernel mode
>    #PF: error_code(0x0002) - not-present page
>    PGD 1082ec067 P4D 0
>    Oops: Oops: 0002 [#1] SMP NOPTI
>    CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-0.rc4.260108gf0b9d8eb98df.34.fc43.x86_64 #1 PREEMPT(lazy)
>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20251119-3.fc43 11/19/2025
>    RIP: 0010:vmware_hypercall4.constprop.0+0x52/0x90
>    Code: 48 83 c4 20 5b e9 69 f0 fc fe 8b 05 a0 c1 b2 01 85 c0 74 23 b8 68 58 4d 56 b9 27 00 00 00 31 d2 bb 04 00 00 00 66 ba 58 56 ed <89> 1f 89 0e 41 89 10 5b e9 3c f0 fc fe 6a 00 49 89 f9 45 31 c0 31
>    RSP: 0018:ff5eeb3240003e40 EFLAGS: 00010046
>    RAX: 0000000000000000 RBX: 000000000000ffca RCX: 000000000000ffac
>    RDX: 0000000000000000 RSI: 0000000040003e58 RDI: 0000000040003e54
>    RBP: ff1e05f3c1204800 R08: ff5eeb3240003e5c R09: 000000009d899c41
>    R10: 000000000000003d R11: ff5eeb3240003ff8 R12: 0000000000000000
>    R13: 00000000000000ff R14: ff1e05f3c02f9e00 R15: 000000000000000c
>    FS:  0000000000000000(0000) GS:ff1e05f489e40000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 0000000040003e54 CR3: 000000010841d002 CR4: 0000000000771ef0
>    PKRU: 55555554
>    Call Trace:
>     <IRQ>
>     vmmouse_report_events+0x13e/0x1b0
>     psmouse_handle_byte+0x15/0x60
>     ps2_interrupt+0x8a/0xd0
>     ...
> 
> The panic was triggered by dereferencing a bad pointer (RDI) immediately
> after a VMware hypercall for VMWARE_CMD_ABSPOINTER_DATA in the vmmouse
> driver:
> 
>    ffffffff82135070 <vmware_hypercall4.constprop.0>:
>    ...
>    ffffffff821350ac:       b8 68 58 4d 56          mov    $0x564d5868,%eax
>    ffffffff821350b1:       b9 27 00 00 00          mov    $0x27,%ecx
>    ffffffff821350b6:       31 d2                   xor    %edx,%edx
>    ffffffff821350b8:       bb 04 00 00 00          mov    $0x4,%ebx
>    ffffffff821350bd:       66 ba 58 56             mov    $0x5658,%dx
>    ffffffff821350c1:       ed                      in     (%dx),%eax	<-- hypercall
>    ffffffff821350c2:       89 1f                   mov    %ebx,(%rdi)	<-- crash
> 
> Reading the disassembly shows that RDI should contain the value of a
> valid kernel stack address here (0xff5eeb3240003e54).  Instead it
> contains 0x40003e54, suggesting the hypervisor cleared the upper 32
> bits.
> 
> And indeed, Alexey discovered that QEMU's vmmouse_get_data() and
> vmmouse_set_data() are only saving/restoring the lower 32 bits, while
> clearing the upper 32.  Fix that by changing the type of the saved data
> array from uint32_t to target_ulong.
> 
> Fixes: 548df2acc6fc ("VMMouse Emulation, by Anthony Liguori.")
> Reported-by: Justin Forbes <jforbes@fedoraproject.org>
> Debugged-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   hw/i386/vmmouse.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> index 2ae7f3a242..3bba221d5f 100644
> --- a/hw/i386/vmmouse.c
> +++ b/hw/i386/vmmouse.c
> @@ -72,7 +72,7 @@ struct VMMouseState {
>       ISAKBDState *i8042;
>   };
>   
> -static void vmmouse_get_data(uint32_t *data)
> +static void vmmouse_get_data(target_ulong *data)
>   {
>       X86CPU *cpu = X86_CPU(current_cpu);
>       CPUX86State *env = &cpu->env;
> @@ -82,7 +82,7 @@ static void vmmouse_get_data(uint32_t *data)
>       data[4] = env->regs[R_ESI]; data[5] = env->regs[R_EDI];
>   }
>   
> -static void vmmouse_set_data(const uint32_t *data)
> +static void vmmouse_set_data(const target_ulong *data)
>   {
>       X86CPU *cpu = X86_CPU(current_cpu);
>       CPUX86State *env = &cpu->env;
> @@ -197,7 +197,7 @@ static void vmmouse_disable(VMMouseState *s)
>       vmmouse_remove_handler(s);
>   }
>   
> -static void vmmouse_data(VMMouseState *s, uint32_t *data, uint32_t size)
> +static void vmmouse_data(VMMouseState *s, target_ulong *data, uint32_t size)
>   {
>       int i;
>   
> @@ -221,7 +221,7 @@ static void vmmouse_data(VMMouseState *s, uint32_t *data, uint32_t size)
>   static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
>   {
>       VMMouseState *s = opaque;
> -    uint32_t data[6];
> +    target_ulong data[6];

Could we use uint64_t instead (also in the callees) and let
the implicit 32-bit truncation when assigning env->regs[] on
32-bit guests?

>       uint16_t command;
>   
>       vmmouse_get_data(data);
> @@ -247,7 +247,7 @@ static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
>               vmmouse_request_absolute(s);
>               break;
>           default:
> -            printf("vmmouse: unknown command %x\n", data[1]);
> +            printf("vmmouse: unknown command " TARGET_FMT_lx "\n", data[1]);
>               break;
>           }
>           break;


