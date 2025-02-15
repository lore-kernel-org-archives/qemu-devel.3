Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC908C021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 22:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjR7J-0000qK-3J; Sat, 15 Feb 2025 17:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tjR7G-0000q9-EG
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 17:58:30 -0500
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tjR7E-0008Gt-81
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 17:58:29 -0500
Received: from [192.168.1.8] (dynamic-cpe-pool.orcon.net.nz [121.99.116.25]
 (may be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 51FMwLOS3797476
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Sat, 15 Feb 2025 22:58:24 GMT
Authentication-Results: anarch128.org; auth=pass;
 dkim=pass (2048-bit rsa key sha256) header.d=anarch128.org
 header.i=@anarch128.org header.b=MNIUG/el header.a=rsa-sha256 header.s=100003;
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1739660305;
 bh=oGgKFRNB+p1CvAEl+mSKaH5SzGY8waQ+SUmfQKyfqQU=;
 h=Date:Subject:From:To:References:In-Reply-To:From;
 b=MNIUG/elkQCldiih1rgJ65WX0EYYR/EIKyrXN1Q3yrA9bV77KMWugkDinlmKn59Mq
 gVnK4u2pc7CWJx4RpFFvkFRK/9bR7nMcJFu7S6JrmL/INI1ZW4XU+D9sqoNrs7zF9d
 /mJiuA+zlIjtNwEfZPGG7ne62i5gprVeT01BT52TVN+jbHdeRhZlult4kAvsOtAqGB
 hLFiPi0s0CECuqNCFptuHrx9WLi3+Acq7XT6kMxXz0s+p8QRiB1538+FbbeMikvuPQ
 r1r4ANzBiNR+CJN1n3SN4Bqjoe4jtTAaLjr2OapnmXsIBiA0CyEFkhB8SUDzzXH4vM
 I+y0ionzP/ZzQ==
Message-ID: <6816c366-7a9d-4357-a70c-44626195bda2@anarch128.org>
Date: Sun, 16 Feb 2025 11:58:16 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: refactor pool data for simplicity and comprehension
From: Michael Clark <michael@anarch128.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250215021120.1647083-1-michael@anarch128.org>
 <a62ee246-4249-458c-9f9b-bad79816ce5e@linaro.org>
 <8f107cd4-f5a2-4d3e-b023-5e53225511d4@anarch128.org>
Content-Language: en-US
In-Reply-To: <8f107cd4-f5a2-4d3e-b023-5e53225511d4@anarch128.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4801:7825:104:be76:4eff:fe10:52ae;
 envelope-from=michael@anarch128.org; helo=anarch128.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/16/25 09:24, Michael Clark wrote:
> I actually have a VM in mind that has a constant stream with it's own 
> counter that branches called IB (immediate base). IB is set in call 
> procedure and we pack a vector into the link register with the relative 
> offset of the program counter and immediate base register (i32,i32) 
> gives call ±2GiB reach. link register no longer has absolute address. 
> and there is a branch instruction for the constant stream. return needs 
> two immediate offsets displaced from the text and constant entry points 
> to compute the return address.

btw here this is the instruction packet I have in mind for a CPU with 
immediate blocks. it has much simpler length decoding than RISC-V and 
less instruction forms too. two regslots can be bonded for a larger 
indirect immediate slot using a constant from the current constant block 
in the constant stream relative to PC/IB. 64-bit instructions can have 6 
inputs/outputs which I have packed for vector in a sketch and it works. 
it doesn't have 48-bit instructions because we simplified length 
decoding compared to RISC-V. and decoding can be more easily vectorized 
than RISC-V but we lost 1 bit in the 16-bit packet due to that. and I 
have a python model that synthesizes logic for parallel decoders

https://anarch128.org/~mclark/VLI.pdf

I'm filling out the 16-bit opcode space. I need to add a constant with a 
(i32,i32) relative immediate to ret to adjust for relative link register 
so the return also needs a constant from the constant block aswell. it's 
symmetrical but I don't have a software model yet.

https://gist.github.com/michaeljclark/8f9b81e5e40488035dc252c9da3ecc2e

in two to three years I may have a POC translator. I'm still working on 
codegen for a new X86 backend. for VLI, 16-wide or 8 x 32-bit packets 
(256-bits) is plausible with vastly simpler decode logic than X86. 
that's like a 16/32/64-bit RISC front-end. at the moment I am thinking 
of allowing 16-bit alignment for larger instruction words but I haven't 
tried to synthesize a decoder yet. but I think much simpler than RISC-V 
because 2 wires per packet for length vs up-to 7.

