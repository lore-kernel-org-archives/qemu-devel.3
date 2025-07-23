Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB92C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 00:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueNhf-0002D7-VC; Tue, 22 Jul 2025 20:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueNhR-00029W-MY
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 20:51:14 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueNhO-0002PP-7e
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 20:51:13 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-236377f00a1so50945855ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753231868; x=1753836668; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ViHs8lO1yKuk6ZlebtqImrC+a0Oqws/LSApTC1/NPPs=;
 b=y5oIcsCVDaqkM6vfwZpn7Rb9jg1jjA8E3XjQuBCn8U+Lbttx9Vl/BKf+nT5Vf9OG9c
 istbpnjVgv85/sKn1Vol0YVJc5E8Uu5AuB/kxsUnmZM/cykDeuAUwpwt6PrwOApbVikO
 2fb6ebdI/2MdI4btnE1XWxNGTHH/qzMfltzvsJI3hjqFlpdLfduk/fEBDIAeUCWK70Vu
 krMhdgodP53ZcqwbXFYIu8PQkuyYcp6IMGjSbXAP15qvVbTGgSBXA6MpzMDGmdPd8HdV
 IJCxKpTV4EczhzNKnyaeQVe+6+gY4/+5fdcha+cBzQiLQQNluDvEtfSJF3fz8PqqvtF0
 +2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753231868; x=1753836668;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ViHs8lO1yKuk6ZlebtqImrC+a0Oqws/LSApTC1/NPPs=;
 b=g7h/k0oxnQK7DTUFFK1MOfqveTQu6P8GVyIOIZnJ5YeBp0auS8pEOhWXx0NmkY1iqX
 p+OSoZQ6siULr0WfwwjTyqlzErK/rezHv+Klpw3iE+yHsXzuY/byTRb6j4F/iVyr9eMc
 xiwjBFLF6GPPE+VQo9I3doMl5IxAYpf84OaxhFmReDbg3IikGzsXKg4zgmqNVY2qpAOZ
 got6kREdkqr2dhY6YHHbGdPjtdjaFYTcvO9/2ucU0gme98E7QAQHi+ijZib2texMJTcN
 kAI7aiNSC2RAKhvXG1Es5xHEY0yALpWHmF3qBUHMxeQYr/6zgMuwW/MbZOSt04IZLgvY
 /yLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3xeaq5np1EooFFFa3Ag5uM1jIrCUjVL0v8OR4epOozeUUUR795yX2YJXV/kIJa2Z6X6IA/uyJy+w9@nongnu.org
X-Gm-Message-State: AOJu0YxI1VAqj2zxSl1ZFKMbJ4SSp+1/OC0F9QUaog842CVOPHIZkqxT
 mEYZL+xBsGnk0W6lFIHgrjHYoG1Ep6Fo2+SdEN17LXrd6T2FAs/D+M4vMu1YmjoF5Es=
X-Gm-Gg: ASbGncszOftoGbhkWZ0yckJ1PH5814W9YZlBo27pMOa2xDVLk77VLk+er9yfa10yjYs
 eqCxKYO9CKZhnNJ9TK1WsHdxpGjT4QWmt7EJkuMRHXj2KOmzMhbrvetTQxa9iAqC/guowxMrzbr
 zubGrDDcP8sgyuxV7EAPf9GTSNx0IJxKRVanCS5JDDsRpJqtCNlMgPtXJoe6fIyVwLTfXPv6+Z0
 h1MY9gaKpaX1+iZ+qf4zgKQ1xGNPEYl1IHm6ratZ6uLmt3ybYfhgWm/XKm37j53snjIX4xHKjcb
 ewG186XoGR6liZ0pBJOduqph/iWAMaOGvhcFRSvft1u25JgjsUL53qhNUiwmmej4OMlTgZ9kjfm
 ELUr7OuavSz8dLUF7LcZWyzFExd5jLBXsgjvA
X-Google-Smtp-Source: AGHT+IHs8R+szAZPnzbN/aTJbj9v/Qg0aDyCkRpiVMHUDoBitoSpafTPnZYZfhyUIm0OyF7R9kBFbw==
X-Received: by 2002:a17:902:f60d:b0:232:1daf:6f06 with SMTP id
 d9443c01a7336-23f982027e5mr11636335ad.47.1753231868170; 
 Tue, 22 Jul 2025 17:51:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e2e5csm83998085ad.14.2025.07.22.17.51.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 17:51:07 -0700 (PDT)
Message-ID: <64dbfec8-b125-4a99-8d3d-1c855786534e@linaro.org>
Date: Tue, 22 Jul 2025 17:51:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] TCTI TCG backend for acceleration on non-JIT
 AArch64
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
References: <20250722174228.16205-1-j@getutm.app>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250722174228.16205-1-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 7/22/25 10:42, Joelle van Dyne wrote:
> The following patch is from work by Katherine Temkin to add a JITless backend
> for aarch64. The aarch64-tcti target for TCG uses pre-compiled "gadgets" which
> are snippets of code for every TCG op x all operands and then at runtime will
> "thread" together the gadgets with jumps after each gadget. This results in
> significant speedup against TCI but is still much slower than JIT.
> 
> This backend is mainly useful for iOS, which does not allow JIT in distributed
> apps. We ported the feature from v5.2 to v10.0 but will rebase it to master if
> there is interest. Would this backend be useful for mainline QEMU?

That's certainly interesting.

(1) The generated gadget code is excessively large: 75MiB of code, 18MiB of tables.

$ ld -r -o z.o *gadgets.c.o && size z.o

     text      data
74556216  18358784

Have you done experiments with the number of available registers to see at what point you 
get diminishing returns?  The combinatorics on 16 registers is not in your favor.

I would expect you could make do with e.g. 6 writable registers, plus SP and ENV.  Note 
that SP and ENV may be read in controlled ways, but not written.  You would never generate 
a gadget that writes to either.  They need not be accessed in other ways, such as the 
source of a multiply.

Have you done experiments with 2-operand matching constraints?
I.e. "d*=m" instead of "d=n*m".
That will also dramatically affect combinatorics.

Have you experimented with, for the most part, generating *only* 64-bit code?  For many 
operations, the 32-bit operation can be implemented by the 64-bit instruction simply by 
ignoring the high 32 bits of the output.  E.g. add, sub, mul, logicals, left-shift.  That 
would avoid repeating some gadgets for _i32 and _i64.

(2) The use of __attribute__((naked)) means this is clang-specific.

I'm really not sure why you're generating C and using naked, as opposed to simply 
generating assembly directly.  By generating assembly, you could also emit the correct 
unwind info for the gadgets.  Or, one set of unwind info for *all* of the gadgets.

I'll also note that it takes up to 5 minutes for clang to compile some of these files, so 
using the assembler instead of the compiler would help with that as well.

(3) The tables of gadgets are writable, placed in .data.

With C, it's trivial to simply place the "const" correctly to place these tables in 
mostly-read-only memory (.data.rel.ro; constant after runtime relocation).

With assembly, it's trivial to generate 32-bit pc-relative offsets instead of raw 
pointers, which would allow truly read-only memory (.rodata).  This would require trivial 
changes to the read of the tables within tcg_out_*gadget.

(4) Some of the other changes are unacceptable, such as the ifdefs for movcond.

I'm surprised about that one, really.  I suppose you were worried about combinatorics on a 
5-operand operation.  But there's no reason you need to keep comparisons next to uses.

You are currently generating C*N^3 versions of setcond_i64, setcond_i32, negsetcond_i64, 
negsetcond_i32, brcond_i64, and brcond_i32.

But instead you can generate N^2 versions of compare_i32 and compare_i64, and then chain 
that to C versions of brcond, C*N versions of setcond and negsetcond, and C*N^2 versions 
of movcond.  The cpu flags retain the comparison state across the two gadgets.

(5) docs/devel/tcg-tcti.rst generates a build error.

This is caused by not being linked to the index.

(6) Do you actually see much speed-up from the vector code?

(7) To be properly reviewed, this would have to be split into many many patches.

(8) True interest in this is probably limited to iOS, and thus an aarch64 host.

I guess I'm ok with that.  I would insist that the code remain buildable on any aarch64 
host so that we can test it in CI.

I have thought about using gcc's computed goto instead of assembly gadgets, which would 
allow this general scheme to work on any host.  We would be at the mercy of the quality of 
code generation though, and the size of the generated function might break the compiler -- 
this has happened before for machine-generated interpreters.  But it would avoid two 
interpreter implementations, which would be a big plus.

Here's an incomplete example:

uintptr_t tcg_qemu_tb_exec(CPUArchState *env, const void *v_tb_ptr)
{
     static void * const table[20]
         __asm__("tci_table")  __attribute__((used)) = {
         &&mov_0_1,
         &&mov_0_2,
         &&mov_0_3,
         &&mov_1_0,
         &&mov_1_2,
         &&mov_1_3,
         &&mov_2_0,
         &&mov_2_1,
         &&mov_2_3,
         &&mov_3_0,
         &&mov_3_1,
         &&mov_3_2,
         &&stq_0_sp,
         &&stq_1_sp,
         &&stq_2_sp,
         &&stq_3_sp,
         &&ldq_0_sp,
         &&ldq_1_sp,
         &&ldq_2_sp,
         &&ldq_3_sp,
     };

     const intptr_t *tb_ptr = v_tb_ptr;
     tcg_target_ulong r0 = 0, r1 = 0, r2 = 0, r3 = 0;
     uint64_t stack[(TCG_STATIC_CALL_ARGS_SIZE + TCG_STATIC_FRAME_SIZE)
                    / sizeof(uint64_t)];
     uintptr_t sp = (uintptr_t)stack;

#define NEXT  goto *tb_ptr++

     NEXT;

     mov_0_1: r0 = r1; NEXT;
     mov_0_2: r0 = r2; NEXT;
     mov_0_3: r0 = r3; NEXT;
     mov_1_0: r1 = r0; NEXT;
     mov_1_2: r1 = r2; NEXT;
     mov_1_3: r1 = r3; NEXT;
     mov_2_0: r2 = r0; NEXT;
     mov_2_1: r2 = r1; NEXT;
     mov_2_3: r2 = r3; NEXT;
     mov_3_0: r3 = r0; NEXT;
     mov_3_1: r3 = r1; NEXT;
     mov_3_2: r3 = r2; NEXT;
     stq_0_sp: *(uint64_t *)(sp + *tb_ptr++) = r0; NEXT;
     stq_1_sp: *(uint64_t *)(sp + *tb_ptr++) = r1; NEXT;
     stq_2_sp: *(uint64_t *)(sp + *tb_ptr++) = r2; NEXT;
     stq_3_sp: *(uint64_t *)(sp + *tb_ptr++) = r3; NEXT;
     ldq_0_sp: r0 = *(uint64_t *)(sp + *tb_ptr++); NEXT;
     ldq_1_sp: r1 = *(uint64_t *)(sp + *tb_ptr++); NEXT;
     ldq_2_sp: r2 = *(uint64_t *)(sp + *tb_ptr++); NEXT;
     ldq_3_sp: r3 = *(uint64_t *)(sp + *tb_ptr++); NEXT;

#undef NEXT

     return 0;
}

This compiles to fragments like

   // ldq_x_sp
   3c:   f9400420        ldr     x0, [x1, #8]
   40:   f8410425        ldr     x5, [x1], #16
   44:   f86668a5        ldr     x5, [x5, x6]
   48:   d61f0000        br      x0

   // stq_x_sp
   7c:   aa0103e7        mov     x7, x1
   80:   f84104e0        ldr     x0, [x7], #16
   84:   f8266805        str     x5, [x0, x6]
   88:   f9400420        ldr     x0, [x1, #8]
   8c:   aa0703e1        mov     x1, x7
   90:   d61f0000        br      x0

   // mov_x_y
  154:   f8408420        ldr     x0, [x1], #8
  158:   aa0403e2        mov     x2, x4
  15c:   d61f0000        br      x0

While stq has two unnecessary moves, the other two are optimal.

Obviously, the function would be not be hand-written in a complete implementation.


r~

