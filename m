Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A52D3517B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 12:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7v15-0003Dc-Kz; Wed, 01 Apr 2026 08:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w7v13-0003DF-Fc
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 08:49:49 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w7v11-0000le-IZ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 08:49:49 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so220727366b.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 05:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775047785; x=1775652585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6eb1GRfytpe6aIIydgD5vn6V/3kc6oCrBbHpnS9gP0k=;
 b=O5RkrxHKlgIxvRNI2AJZkh254sc2vvWNfrFv6VzUon1R9skDksZwzrr48aNEu7fkf2
 VMGihIzi9C6St7RobKptPkkVkPLnR83tBU4lwqiHIkXJ45BEfBEujeEUIM01s02txPSS
 3lJ4ns/dHcnq4hOihsvLqrNTJlInkdLzVC5mA8ZeIALzi0KgffCltajUqqYR6Xyj3lgi
 CliEyKAqqFLR8XDVKFOl83GFJ+aaIEAyVynWZ1skOsFSAt9JEXgiyVRd41ksNstoxUOf
 R+8/DdJsqPgKHoXKroU/tRLJJjNQ5kwBP2B6YwYfu7kQjZ4xpLTRM7v6FTGIVUsB2MYH
 KTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775047785; x=1775652585;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6eb1GRfytpe6aIIydgD5vn6V/3kc6oCrBbHpnS9gP0k=;
 b=SEsow1j3Q25bSiqifhSG49h2yCdOHcTJEGlCpAIu9l7vc/7NuoHze6vKGlOlDH3QfN
 sEUKUGx+g4q4CHsmcFgojfWxzlzfeAI3X/jzt95pygazu9h8HxBw4XVi2WINBvwmcCLm
 PPlz6hvaZfesleXiMOv14JN3xitf5MWLQCVlhOVl28XUsmRxDvmVT6Qjydd5fW+JN6Ey
 PmR6R7O0qVZKvgNb+5ITQHjR/tp+oWPsnNb4semlHnmFCgp+MryE5hUHAvRG45eEOsQi
 Q9MN7UGn+lrLB2s/iVZnFgZXQ7rS8lLgxOe27008mNRzL7+cygdNuV2nlthIwWreLzTy
 BxlQ==
X-Gm-Message-State: AOJu0YwinJqZnVMONobal4fImvccFEjcZjcd6OYVRJ4MaX3ieY0UYoIQ
 84JC5kbwsTbCKhghCJ0hN5qLIPy5qkFfomF9y3IBRUpbYyt/ugY7T1ktXg3RFw5bLpo=
X-Gm-Gg: ATEYQzz6ubrWBWZbqzlZtEywwg5ozv4IATMo7Zt1FbIWJM9y15KR6u1zWrEQRilMGUu
 I0E+mqhr8WgW7KAbxbjjtDkF3qdf7dySqFPBYiSnlJIT2Csa+ma355Uuz9IXomFVNBwr5+3MjMk
 iyL7TTFSXIPef3Qi96aRiCCbMV/uiPPQcCBJtk+ozDndY9HnMKSFwpx4YHqzsfHcacdHlFro3Td
 QOVC3y3JzFTKu5VHzhqKvfs+tih5L49ed6Nx6uHdbj4l6GE/rzdSLVU5vSFMMU+hSJDtU8JytvX
 WLL+jYcrgV4XoZ7LVYousA+a6pEjGPdKEWqNqEcsxzNVJdAwY3Mb5jPZpOgFDOQKpri4sXYCIy0
 kIfcsLp0rQhFxUYn8XP90ihv5WosUy/JEgbn6pUl1VMjBFooO7T9HJU/wobEfnO65j0CGdBozDr
 S55M4oEUsUZ60nd6q3C8p7Vpo=
X-Received: by 2002:a17:907:2683:b0:b9b:63af:d9cf with SMTP id
 a640c23a62f3a-b9c13cc6cf8mr241405266b.48.1775047784983; 
 Wed, 01 Apr 2026 05:49:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7b225d4bsm504514766b.60.2026.04.01.05.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 05:49:44 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 432905F8D9;
 Wed, 01 Apr 2026 13:49:43 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC PATCH] hw/display: modernise the vga debug code (!!GenAI!!)
In-Reply-To: <a7b05743-c7f4-4626-b11c-ec8200913c33@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 1 Apr 2026 12:21:02
 +0200")
References: <6c3214ac-1679-d9db-2fed-c934fde8ddf2@eik.bme.hu>
 <20260330222900.982404-1-alex.bennee@linaro.org>
 <a7b05743-c7f4-4626-b11c-ec8200913c33@linaro.org>
User-Agent: mu4e 1.14.0; emacs 30.1
Date: Wed, 01 Apr 2026 13:49:43 +0100
Message-ID: <87fr5eq1zs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 31/3/26 00:28, Alex Benn=C3=A9e wrote:
>> Remove dead code, replace debug prints with trace points.
>> Link:
>> https://patchew.org/QEMU/20260330140656.46FE55969F2@zero.eik.bme.hu/
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> As an experiment I prompted Gemini with the thread contents and asked
>> it to make the changes. It cost about 9p in inference and I would
>> argue this barely counts as copyrightable as it is a simple
>> transformation of existing patterns.
>> ---
>>   hw/display/vga.c        | 89 ++++++++---------------------------------
>>   hw/display/trace-events | 11 +++++
>>   2 files changed, 27 insertions(+), 73 deletions(-)
>
>
>> @@ -873,9 +824,7 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, =
uint32_t val)
>>       uint32_t write_mask, bit_mask, set_mask;
>>       int plane =3D 0;
>>   -#ifdef DEBUG_VGA_MEM
>> -    printf("vga: [0x" HWADDR_FMT_plx "] =3D 0x%02x\n", addr, val);
>> -#endif
>> +    trace_vga_vram_write(addr, val);
>
> OK, ...
>
>>       /* convert to VGA memory offset */
>>       memory_map_mode =3D (s->gr[VGA_GFX_MISC] >> 2) & 3;
>>       addr &=3D 0x1ffff;
>> @@ -945,9 +894,7 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, =
uint32_t val)
>>       if (sr(s, VGA_SEQ_MEMORY_MODE) & VGA_SR04_CHN_4M) {
>>           if (mask) {
>>               s->vram_ptr[(addr << 2) | plane] =3D val;
>> -#ifdef DEBUG_VGA_MEM
>> -            printf("vga: chain4: [0x" HWADDR_FMT_plx "]\n", addr);
>> -#endif
>> +            trace_vga_vram_write((addr << 2) | plane, val);
>
> ... but why print the index instead of the address here?

I expect it makes the trace data more closely match the actual access.
As a human I probably would have written:

   if (mask) {
       size_t idx =3D (addr << 2) | plane;
       s->vram_ptr[idx] =3D val;
       trace_vga_vram_write(idx, val);
       ...
   }

to avoid the double calculation (even though I'm sure the compiler would
have clocked it).

>
>>               s->plane_updated |=3D mask; /* only used to detect font ch=
ange */
>>               memory_region_set_dirty(&s->vram, addr, 1);
>>           }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

