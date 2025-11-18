Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9754CF2560
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 22:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLTzQ-0000ZF-Af; Tue, 18 Nov 2025 17:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1vLTzO-0000Z6-JT
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 17:15:54 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1vLTzM-0002nu-8s
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 17:15:53 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b3c5defb2so4118774f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 14:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20230601.gappssmtp.com; s=20230601; t=1763504149; x=1764108949;
 darn=nongnu.org; 
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5rkVbiflIMstp22h/QJ/Y0HRJI+K5d11KMEv3WDeZS4=;
 b=l5+INslHPVSgMITUxupBdkNggG4TsAhFC8tUtYU7UtGk/RNjqnMoUDDwzpEcLu2VCD
 gXdHkfastXe3J06Nh/Bi06Ltx5JzHjY8egIreBvRamvIXEwPXGeBWB3lRnI0ZYtY320J
 JcPo+0cphMwBynKd0FRctPtpgVnLFUUYu8OkOe6TQIDspya+wprIzm8LxPSRrTjqMgpF
 y89Bv+oKkgc7PfUKyXYUblaTT3Uqd5TC8acOXlIh3iSbT9NftKB1cs733k1TNaVksIUw
 k95xDbCNniXEx9nVcOuZAF7fG7pQHQifB5zYkUfEGWy6zTY8mj1oEO+NDrmYuUfWLXGv
 fm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763504149; x=1764108949;
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5rkVbiflIMstp22h/QJ/Y0HRJI+K5d11KMEv3WDeZS4=;
 b=po6cHpm4zyHrKtM4v/G6EikVlA4K0dDfFrL7kV/MHlMN/5kTpZHJQIbvUVBrEslytl
 pNk6JTHjeJU13t+QEkhgtF6eAPODzQLnIQQMCyNvW3MzdJE+uhqkmb21AZnTnBK69iPL
 AbRqn2JmfoRsrWKf81IfE7Mb83KNCb1S+gpq/XkMlgcuWFv8v9VXGbt/rRnhWeYMtDaE
 c4IBNJ6UM9qZ08Ifg1Enwz2uSwb3j+7fN7OwBD+DtV8T91yQ4Ri6himCqoqYiGdUDTNJ
 l+0ImPFE7bvRhrOrGVcBi77YmQ10I1XxDgN5PN/bhj20KqL7qfTQLpzd14xQ/5ZHd94O
 JGlQ==
X-Gm-Message-State: AOJu0YxA3unzyFhCgC0GGCt30B0fi1rTLQO+jw2iwPjYP82CjMJqII09
 bK2K74DR2I8ri2n1SOY4H6FR0wwv5TDU4oLnkHK9fLJmPQACJEa7V0FRkxyr3M+hlIxhNUDr4nr
 74i7opew=
X-Gm-Gg: ASbGncviqDkNAKy6+dRnFsLf9hZWuYLGUoIlRB0RT1rYw3miAOZIL3cUbIMqOis6bK9
 Flf1bmzoHbLnw/EhngoaSigv2EdBYTZq3eVowjFD47usRZQflqavRwDa8sD+1B6SpKOSeBTiGHa
 +Fa/guJEhUoRPvNMQljd18Z9odWBD474BYeITdFAaXgaVAAjqX6DmT70E5cO3ABVTgVl8NYblEM
 dNGO5C9am8C6rjqfFM4TcvWJebAQKWuQitBK6DC+MhDG702n/R4bwACoPqxV68QyJXSPjiAPptg
 EXU6y/xEIopuSCOR2ck3RqJkJVMDkz6OSLLvKJNE86gBHPJ08f7mHpNc1+T6X1d85fYxuO/JEx+
 Zo+khWPti/pSPcN6fKZREpvx5g0Phm1xrpvY8wQwsALPNnHq3gVXnuj9YXetcu+vZzb5ud0aSQ7
 KMtCivmqXT+/2udIo=
X-Google-Smtp-Source: AGHT+IFmPwJd9v81346IPyS0CuZdjBw8Dd69Skyk6nDfTxswBWpPgoUFRvXTrrf+99et/dCha9cetQ==
X-Received: by 2002:a05:6000:613:b0:42b:3302:f7d0 with SMTP id
 ffacd0b85a97d-42b5934b447mr16342887f8f.22.1763504149057; 
 Tue, 18 Nov 2025 14:15:49 -0800 (PST)
Received: from smtpclient.apple ([5.12.109.3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e85e6fsm34494711f8f.18.2025.11.18.14.15.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Nov 2025 14:15:48 -0800 (PST)
From: Liviu Ionescu <ilg@livius.net>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: unaligned access for cortex-a15?
Message-Id: <77419EC3-BFC1-4F0C-9287-2E753D0C30DE@livius.net>
Date: Wed, 19 Nov 2025 00:15:37 +0200
To: QEMU Developers <qemu-devel@nongnu.org>
X-Mailer: Apple Mail (2.3826.700.81.1.3)
Received-SPF: none client-ip=2a00:1450:4864:20::435;
 envelope-from=ilg@livius.net; helo=mail-wr1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

After upgrading to 9.2.4, which seems to be more strict with unaligned =
accesses, and after fixing the cortex-a76 alignment faults by enabling =
the mmu, I have a related issue with the cortex-a15 tests.

=46rom what I read, this is not related to mmu, apparently the core =
itself must handle unaligned accesses.

However, even after explicitly clearing the A bit in SCTLR, I still get =
a data fault.

The code is quite simple:

```
    .globl _interrupt_vectors
    // "x" makes it visible in the listing.
    .section .interrupt_vectors,"awx",%progbits

    .align  7
_interrupt_vectors:

    .balign 4
    b     Reset_Handler
    b     undefined_handler
    b     swi_handler
    b     prefetch_handler
    b     data_handler
    nop   // Reserved vector
    b     irq_handler
    b     fiq_handler

...

    .section .after_vectors,"awx",%progbits

    .align 2
    .globl Reset_Handler
    .type Reset_Handler, %function
Reset_Handler:

#if defined(__ARM_ARCH_7A__)

    // DEN0013D_cortex_a_series_PG.pdf
    // 13.1 Booting a bare-metal system

    // Only CPU 0 performs the initializations. All other CPUs go into =
WFI.
    // To do this, first work out which CPU this is by reading MPIDR.
    mrc     p15, 0, r1, c0, c0, 5 // Read Multiprocessor Affinity =
Register
    and     r1, r1, #0x3 // Extract CPU ID bits
    cmp     r1, #0
    beq     .Lcpu0_initialize // If we=E2=80=99re on CPU0 goto the =
start.

.Lcpu_sleep:
    wfi     // Other CPUs are left sleeping.
    b       .Lcpu_sleep

.Lcpu0_initialize:
    ldr     r0, =3D__stack
    mov     sp, r0

    ldr     r0, =3D_interrupt_vectors
    mcr     p15, 0, r0, c12, c0, 0
    dsb

    // Configure SCTLR in one operation: disable MMU + configure =
unaligned access
    mrc     p15, 0, r1, c1, c0, 0   // Read SCTLR once
    bic     r1, r1, #0x1            // Clear M bit (MMU)
    bic     r1, r1, #(1 << 1)       // Clear A bit (alignment faults)
    orr     r1, r1, #(1 << 22)      // Set U bit (unaligned access =
model)
    mcr     p15, 0, r1, c1, c0, 0   // Write SCTLR once
    dsb                             // Data Synchronization Barrier
    isb                             // Instruction Synchronization =
Barrier

    // Test unaligned access
    ldr     r0, =3D0x40000001          // Odd address (unaligned for =
32-bit load)
    ldr     r1, [r0]                 // This should work with hardware =
handling

    // Use bl instead of b to have a proper stack record for GDB
    // to display a full stack trace.
    bl      _start
```


If I run this in a debugger, when executing the `ldr r1, [r0]` =
instruction, the debugger halts at address 0x40000010, which is the =
branch to the data_handler, with DFSR =3D 1 (unaligned access) and DFAR =
=3D 0x40000001 (the odd address).

I don't have a physical board at hand, so I do not know if my =
initialisation sequence is correct or not.

Is there anything else I have to configure for the emulated cortex-a15 =
in order to accept unaligned accesses?


Thank you,

Liviu





