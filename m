Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5022AC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtkbZ-0000TX-3i; Mon, 08 Apr 2024 04:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtkbT-0000S4-Rd
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:43:49 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtkbR-0003Ya-5s
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:43:47 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a51b008b3aeso239243166b.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 01:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712565822; x=1713170622; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5RlKwmYvIdOqZ1KCF5T2Eke6oZXTt5pYMqgH0ZOdX9M=;
 b=YbFfOu1lH+UYpVlkE7mGnUKj3+TIbcxWP+fJyzgM1ado0vagF9oILKghXnz6Y7aK4Q
 QfaLleB+BAnyh+s5GyZcW7UfEQm2OVo2KVaDJlZKs6FBpkZYiCe/HIBxJbs8CNhH69Md
 QhNZvdTs5BlBM/7qIRcciM75vZkln29b17AThhv7CPATOzxxF4uZ6gYAwerhkP+FTuTi
 ZyW0Ux1V2WGnTvqdnFJiwy18yqBn/jxHtTG/aout2GislAYXFn8AR83AxNW/F2ZVpvFD
 +ivs2co26auqUhsnvrY5Lofbr2uImGRwVLJ1958L+QPV2bV6WsJcQ+Rbi/5kJPaIqkuv
 jNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712565822; x=1713170622;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5RlKwmYvIdOqZ1KCF5T2Eke6oZXTt5pYMqgH0ZOdX9M=;
 b=Yvf00p/NN/L8A8dZH4FdC6aFcnaPdP0IUlwohrIjwO/zCVxrAafR/L65vck8OYAHmI
 1uzHR/SbfH7MgW//wl0gr8gP92VGPhpNdMt1UnbA5MEnM9ko+eOZzh1cb4Tt+DztNUOY
 SEN6XT35JSb2jGt3IgkTv83ubuZmsQlz+YkdDzDN5OaOt7YZ6t1GD6Ya8mJ6Un+Co4sK
 TBvvNcqfjQ6uVytz4T9GiUqx+qljTp2XgTb4APt7VLMSgqNkprryY+Qpy7kI1Mb6XbmO
 3fOZWSQpGVx1yZaS4U0gQNxIhjrRLLWhVhV47GbFhIo7xzWx60l4RBiWgUd2cecH5SNK
 7dFg==
X-Gm-Message-State: AOJu0YzdAkpqxsu+ndQE3dh8905qnRz+j7G9OsDfnuWMocIP1Q2REOQ5
 cNrxTlPaZ/j21ylVGPZv3K1oZJN3griQXozs/FeM/PQLiesOOeU+vyef0k9sZb6FW+fT8OncagD
 H
X-Google-Smtp-Source: AGHT+IFLc50rzguUN0yEmSDR5ziey44m7b6CkKWtL4pp6hE62qo3Lbxsn02I5mBie4omdhDSk0v7UQ==
X-Received: by 2002:a17:906:565a:b0:a51:9737:f23d with SMTP id
 v26-20020a170906565a00b00a519737f23dmr4769695ejr.70.1712565822665; 
 Mon, 08 Apr 2024 01:43:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a170906830500b00a4734125fd2sm4163164ejx.31.2024.04.08.01.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 01:43:42 -0700 (PDT)
Message-ID: <625490d9-f392-426c-8688-45438ab0e454@linaro.org>
Date: Mon, 8 Apr 2024 10:43:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? 3/3] hw/block/nand: Fix out-of-bound access in
 NAND block buffer
To: qemu-devel@nongnu.org
Cc: Qiang Liu <cyruscyliu@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20240408083605.55238-1-philmd@linaro.org>
 <20240408083605.55238-4-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240408083605.55238-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 8/4/24 10:36, Philippe Mathieu-Daudé wrote:
> nand_command() and nand_getio() don't check @offset points
> into the block, nor the available data length (s->iolen) is
> not negative.
> 
> In order to fix:
> 
> - check the offset is in range in nand_blk_load_NAND_PAGE_SIZE(),
> - do not set @iolen if blk_load() failed.
> 
> Reproducer:
> 
>    $ cat << EOF | qemu-system-arm -machine tosa \
>                                   -monitor none -serial none \
>                                   -display none -qtest stdio
>    write 0x10000111 0x1 0xca
>    write 0x10000104 0x1 0x47
>    write 0x1000ca04 0x1 0xd7
>    write 0x1000ca01 0x1 0xe0
>    write 0x1000ca04 0x1 0x71
>    write 0x1000ca00 0x1 0x50
>    write 0x1000ca04 0x1 0xd7
>    read 0x1000ca02 0x1
>    write 0x1000ca01 0x1 0x10
>    EOF
> 
> =================================================================
> ==15750==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x61f000000de0
>   at pc 0x560e61557210 bp 0x7ffcfc4a59f0 sp 0x7ffcfc4a59e8
> READ of size 1 at 0x61f000000de0 thread T0
>      #0 0x560e6155720f in mem_and hw/block/nand.c:101:20
>      #1 0x560e6155ac9c in nand_blk_write_512 hw/block/nand.c:663:9
>      #2 0x560e61544200 in nand_command hw/block/nand.c:293:13
>      #3 0x560e6153cc83 in nand_setio hw/block/nand.c:520:13
>      #4 0x560e61a0a69e in tc6393xb_nand_writeb hw/display/tc6393xb.c:380:13
>      #5 0x560e619f9bf7 in tc6393xb_writeb hw/display/tc6393xb.c:524:9
>      #6 0x560e647c7d03 in memory_region_write_accessor softmmu/memory.c:492:5
>      #7 0x560e647c7641 in access_with_adjusted_size softmmu/memory.c:554:18
>      #8 0x560e647c5f66 in memory_region_dispatch_write softmmu/memory.c:1514:16
>      #9 0x560e6485409e in flatview_write_continue softmmu/physmem.c:2825:23
>      #10 0x560e648421eb in flatview_write softmmu/physmem.c:2867:12
>      #11 0x560e64841ca8 in address_space_write softmmu/physmem.c:2963:18
>      #12 0x560e61170162 in qemu_writeb tests/qtest/videzzo/videzzo_qemu.c:1080:5
>      #13 0x560e6116eef7 in dispatch_mmio_write tests/qtest/videzzo/videzzo_qemu.c:1227:28
> 
> 0x61f000000de0 is located 0 bytes to the right of 3424-byte region [0x61f000000080,0x61f000000de0)
> allocated by thread T0 here:
>      #0 0x560e611276cf in malloc /root/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
>      #1 0x7f7959a87e98 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x57e98)
>      #2 0x560e64b98871 in object_new qom/object.c:749:12
>      #3 0x560e64b5d1a1 in qdev_new hw/core/qdev.c:153:19
>      #4 0x560e61547ea5 in nand_init hw/block/nand.c:639:11
>      #5 0x560e619f8772 in tc6393xb_init hw/display/tc6393xb.c:558:16
>      #6 0x560e6390bad2 in tosa_init hw/arm/tosa.c:250:12
> 
> SUMMARY: AddressSanitizer: heap-buffer-overflow hw/block/nand.c:101:20 in mem_and
> ==15750==ABORTING
> 
> Broken since introduction in commit 3e3d5815cb ("NAND Flash memory
> emulation and ECC calculation helpers for use by NAND controllers").
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1446

Also:

   Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1445

> Reported-by: Qiang Liu <cyruscyliu@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/block/nand.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

