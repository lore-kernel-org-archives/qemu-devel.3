Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150A5CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 19:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrNgR-0000wt-8S; Mon, 01 Apr 2024 15:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1rrNgP-0000wd-8i
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 15:51:05 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1rrNgN-0000lN-RW
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 15:51:05 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6145a4c79cfso31183377b3.0
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712001062; x=1712605862; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Pd55Y+vARHrQxPhfwaPhmm6KoU+c237oNpdTSmmTlk0=;
 b=P/pFvmQvwqLMHMVmmFEnKliLh8/qR+MrUjwuwRqMP3t2+28CIezeHlBndc9VlhQ705
 ZVL5obL7wSt1YDFKTc9dmm6mRl/9vGrlazDdb/osKO6cQAs++KTccOi68K2vkdN2gJNy
 tBg3lsGZM9A5CJArE66YVrZFc0pJBL++Qj0+ZCT/HeYNwtvvqLYKoqg69SK8LOzKgcQs
 NogIgfolrE3ARkl6X44RNkOa/pYFGPbbJ4y3cS+/+06iY++JMRhUcW8IlxwoPZCIH787
 VqIRJBTrQ/ggI7OnuOYPIR52T5nV559r596VydGkG2SBOm2skIFWfhi+1dor1rUxQxcF
 olng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712001062; x=1712605862;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pd55Y+vARHrQxPhfwaPhmm6KoU+c237oNpdTSmmTlk0=;
 b=hQg3D5Zt0+JcUNYyICTSxteabLC8hEwPX9lTDnQ8BkidiQQkUnUPrA74gwXtGlhw/s
 ovlGniUAfFNFHvISL3GjjjhzIA+tW4kc9l2gRwAf4NE/7eOdtGb5hC9Ut5Z92xSOCLcj
 JQ/uVhcmpoGYX57mhado6dlDprM3wu+MZSrOlcVnq6YkZN7JqLlJaWVZ5WvRTOOdBNjb
 l1GijaYAaszsqPzxB+aNAKY8XmkyF/iPKjAtXFdSys2kp78GFVFJ4J80m17tJFpVDNni
 h6aHH3LcAUx0Vovh5LZPW6nTeC4SUtv+SHXI56GRpnwK5hQQ8OjG35jeN8HINshpA3Gw
 tcmA==
X-Gm-Message-State: AOJu0YxJkj3K1jO7ogaggsY7jcgXYNRthDpzLV1EcVbGGqHim7P/uz+v
 4U7cOa8IgAD6jZ+Q6wV2TuTLwenoZP/zsbfL8ApwJNEEpKDljOtI/YUfHEOzqG/Jy493dq/T3+x
 4Cm5zkVAztWxJEFQKAIqvR8AdBfgJhFGLE7U=
X-Google-Smtp-Source: AGHT+IHkGgY8zAjSIRS4HOa/PwT8aaYurhb8TGXcjLtgI7FfuxkKyEJj9CkjSp4W+AmNUQz8XQM30PWWVmgzcpG5SNc=
X-Received: by 2002:a25:1454:0:b0:dc6:aed5:718a with SMTP id
 81-20020a251454000000b00dc6aed5718amr9803753ybu.26.1712001061813; Mon, 01 Apr
 2024 12:51:01 -0700 (PDT)
MIME-Version: 1.0
From: Gautam Bhat <mindentropy@gmail.com>
Date: Tue, 2 Apr 2024 01:20:50 +0530
Message-ID: <CAM2a4uwktAA=Uk9_GRnxusvHhfrZg+EUWjfxy95YgxGsQQntjA@mail.gmail.com>
Subject: Point where target instructions are read
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=mindentropy@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,

Some background: I am trying to write a CPU emulator for MSP430 with
Qemu. I am loading the MSP430 program as follows using the generic
device loader:

/qemu-system-msp430 -machine msp430-launchpad -device
loader,file=simple_test -d in_asm,out_asm

I have implemented somewhat the TranslatorOps callbacks and my sample
output with some prints is as follows:

===msp430_tr_disas_log:204===

OUT: [size=51]
 -- guest addr 0x00000000000007fa + tb prologue
0x7fff6403fe00:  8b 5d f0                 movl     -0x10(%rbp), %ebx
0x7fff6403fe03:  85 db                    testl    %ebx, %ebx
0x7fff6403fe05:  0f 8c 1c 00 00 00        jl       0x7fff6403fe27
0x7fff6403fe0b:  c6 45 f4 01              movb     $1, -0xc(%rbp)
0x7fff6403fe0f:  e9 00 00 00 00           jmp      0x7fff6403fe14
0x7fff6403fe14:  c7 45 00 fc 07 00 00     movl     $0x7fc, (%rbp)
0x7fff6403fe1b:  48 8d 05 1e ff ff ff     leaq     -0xe2(%rip), %rax
0x7fff6403fe22:  e9 f1 01 fc ff           jmp      0x7fff64000018
0x7fff6403fe27:  48 8d 05 15 ff ff ff     leaq     -0xeb(%rip), %rax
0x7fff6403fe2e:  e9 e5 01 fc ff           jmp      0x7fff64000018

===gen_intermediate_code:251===
===msp430_tr_init_disas_context:84===
===msp430_tr_tb_start:99===
===msp430_tr_insn_start:107===
===msp430_tr_translate_insn:122===
CTX Dump State
==============
pc_first 2044
pc_next 2044
is_jmp 0
max_insns 1
num_insns 1
TB flags: 1
TB cflags: 4278190081
TB CS base: 0
TB PC: 2044
==============
Opcode: 0
is_jmp: 1
DISAS_TOO_MANY ===msp430_tr_tb_stop:170===

I was trying to find out where exactly in the Qemu code does it read
the target instructions from the file loaded (I could trace it to
load_elf(...) loading the FW file) and call my TranslatorOps
callbacks.  I get the above output continuously in a loop. Also when
the device generic loader is used, should I set the program counter to
a specific value?

I am not able to understand how to proceed. Any help would be greatly
appreciated.

