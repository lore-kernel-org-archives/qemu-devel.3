Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8AEC28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 13:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuAGv-0007FS-QX; Mon, 17 Mar 2025 09:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tuAGZ-00078g-C1
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 09:12:30 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tuAGW-0004Y1-Hq
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 09:12:27 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-301493f45aeso3067440a91.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742217143; x=1742821943;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Jeu1KTlsKhwm7xWBMBDC+MDS3XtetflS5MPkv/qg4A=;
 b=Nuh09LdTnz42U2Fs8wlLqy9Js2Wju3+1l+Uk2CMjoi2XM7xEUtvxOQly0id5Gdtund
 IhJLye6T70iH+XTYV5iCaDeJRWIbqK0tYod34+HolBdJCvzdAHknZpR+aCpXjxyTfH09
 q54dSgNxtnyVb/EkOMHN4Npy1UTY/Yk3iLowWaeCnq3KV+DSv3CjQfFbNhyqg5Ghnp7l
 VlrUKMUCEvFLqY1OibauRAGXmwndoAyOSiD7Cvcxa+g/ipyApMjj49EbZ+NxcIogqrMU
 FnX+ZrVHTz6WyLcq/slY3pSk6vsE4aqGl0tSQAsNwVbHBCLSrmJFAFkh0SPWD38ijMfR
 iRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742217143; x=1742821943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Jeu1KTlsKhwm7xWBMBDC+MDS3XtetflS5MPkv/qg4A=;
 b=GP9QHgqIV4A13ar0Hnu2niZSAn7xmPc5AQ14o0W0M4PA1joJoNXnqU0az2BETqjrGf
 s0EfMB3k/Apj7m3+RO0QsVHUQikt/eji0aXRFqT6eIjN9rnokoi9r7oZijZGncJq1E9Y
 6v97vKSzZrNURMJ/5fCOKxi127ES6i9MTPZNWlTJ9eZt5tCXECyz/6yr5geQHU4SYawW
 fXHHdkB2lHjCcOk69IL4hN1/DKx8/Ecpya/ztyjAxJi5+CUZCfQwwCXHB+mV2HmNLFcI
 ct3S+4CgXM0whBsYnpDzBgxQtNd+UPUQSGMOUcB76/HLg98aRPYg6E1jwzUOXHmGDXa7
 TKkA==
X-Gm-Message-State: AOJu0Yx1+RZxrgEk47wK1B5KqcgJDhGzHO2ateBs4iIJN/MhGx0rHzDr
 2MVWXlytupGudSPerx23zolna618e0g6FUgDQ4oY6/35Z3YGvPhmdx1WND0cDs2f69va7NymO90
 m98s=
X-Gm-Gg: ASbGncvmozlMkMJXNgIunJZrJwIwOd64/Y57rEF2WIZwNMKs2sso0+MLaLQSoWejy9t
 FYYtl41uHyd7FHsq8fVx3PQivt3SBMBjZl10EPLP1z1jbsC1YYEMxcxnkNzLxdZAgqXSU0Dmec8
 o3f9rPjacYlilmu3gbw/qASZqviMyxeaAW50ZdzPMR5WrD7yRF/uO/6rjty3xS3pgIflVZS9AoN
 9IlGk/Mwy432U1GcsUxP58Cg6Jrx0Ns3gl4GZlSxqQDUPG8vl6oXQ+ortVF/TJI9FT/gcIgg9X9
 B6QXWsvaa3eilXUvhJhoEiPGEq10rKLVi8VRymYIEPKt6ejzi9JlcCmUuQ==
X-Google-Smtp-Source: AGHT+IGKIrPNeSWB1NFIhRcMCnsDcHqM3Jx9YaFh3H5JxT9OpRn+ad4P2g69cbtZ8R9ZtVXYDYEmrw==
X-Received: by 2002:a17:90b:1f90:b0:2f8:49ad:4079 with SMTP id
 98e67ed59e1d1-30151c5df91mr13074562a91.6.1742217142914; 
 Mon, 17 Mar 2025 06:12:22 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301535a53f1sm6091413a91.1.2025.03.17.06.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 06:12:22 -0700 (PDT)
Message-ID: <b3ec57eb-30c3-4692-b262-184381090c44@daynix.com>
Date: Mon, 17 Mar 2025 22:12:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/arm: Flag PMCNTENCLR with ARM_CP_NO_RAW
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, devel@daynix.com
References: <20250317-raw-v1-0-09e2dfff0e90@daynix.com>
 <CAFEAcA9Cy_870gxNmPFykzTjXOfi0raotmA1NRpZEQKfFfB=0g@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA9Cy_870gxNmPFykzTjXOfi0raotmA1NRpZEQKfFfB=0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/03/17 20:53, Peter Maydell wrote:
> On Mon, 17 Mar 2025 at 11:16, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Supersedes: <20250314-clr-v2-1-7c7220c177c9@daynix.com>
>> ("[PATCH v2] target/arm: Define raw write for PMU CLR registers")
>>
>> A normal write to PMCNTENCLR clears written bits so it is not
>> appropriate for writing a raw value. This kind of situation is usually
>> handled by setting a raw write function, but flag the register with
>> ARM_CP_NO_RAW instead to workaround a problem with KVM.
> 
> I'm not sure there's a "problem with KVM" here -- it implements the
> write to PMCNTENCLR to have the semantics the architecture specifies.

The inline comment includes a reference:
 > KVM applies bit operations that prevents writing back raw values
 > since Linux 6.7:
 > 
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a45f41d754e0b37de4b7dc1fb3c6b7a1285882fc

> 
>> KVM also has the same problem with PMINTENSET so add a comment to
>> note that. This register is already flagged with ARM_CP_NO_RAW.
> 
> What are we trying to achieve with this patchset?
> You can't write to registers from gdb, and reading PMCNTENCLR
> just gives you the same value as PMCNTENSET, so you might as
> well read that, which we already expose.

That's also true for other registers marked with ARM_CP_ALIAS and 
exposed to GDB so I followed those examples. It's up to user what 
register to choose after all.

> 
> More generally, the gdb-stub access to system registers is
> something we put in on a "this is a minimal amount of code
> to provide something that more or less works" basis. If we
> want it to work better (i.e. more comprehensively, possibly
> with write support) then we should address that by looking at
> the design of doing that more holistically, not by making
> tweaks to address individual registers.
> 
> Specifically, I'm not really happy with adding explicit
> ARM_CP_NO_GDB flags to everything we currently mark as
> ARM_CP_NO_RAW. Either we stick with our existing
> "minimal changes to produce something that works" approach,
> in which case we deny gdb access to NO_RAW registers because
> that's easy and most of them it won't work or doesn't make
> sense. Or else we do the actual design work. That might turn
> out to mean "we explicitly mark no-gdb registers rather than
> overloading NO_RAW for this", or it might mean something else.
> But we won't know until we actually do that design work.
> 
> (see also https://gitlab.com/qemu-project/qemu/-/issues/2760 )

I suspect that some registers with ARM_CP_NO_RAW cannot be determined as 
GDB-visible or GDB-invisible based on the current ARMCPRegInfo fields, 
and explicit marking with some flag is inevitable for them.

That said, I understand explicit markings with ARM_CP_NO_GDB may 
interfere with the future design work, and I think I can still solve the 
problem with PMCNTENCLR and similar registers without it. Below is a 
detailed explanation:

The underlying problem here is that the current definitions of 
ARM_CP_ALIAS and ARM_CP_NO_RAW are contradicting and incompatible.

Now let me describe characteristics of PMCNTENCLR with yes/no table:
1) It has a state - yes
2) It will handle migration and reset - no
3) The state can be synchronized with KVM - no
4) The state is shared with another register - yes

1) the presence of the state usually implies it is visible to GDB.

The documentation of ARM_CP_ALIAS says:
 > Register is an alias view of some underlying state which is also
 > visible via another register, and that the other register is handling
 > migration and reset; registers marked ARM_CP_ALIAS will not be
 > migrated but may have their state set by syncing of register state
 > from KVM.

So ARM_CP_ALIAS implies:
1) It has a state - yes
2) It will handle migration and reset - no
3) The state can be synchronized with KVM - yes
4) The state is shared with another register - yes

1) is implied from 3) and 4); if there is no state, the state cannot be 
synchronized and cannot be shared with another register.

The documentation of ARM_CP_NO_RAW says:
 > Register has no underlying state and does not support raw access for
 > state saving/loading; it will not be used for either migration or KVM
 > state synchronization. Typically this is for "registers" which are
 > actually used as instructions for cache maintenance and so on.

So ARM_CP_NO_RAW implies:
1) It has a state - no
2) It will handle migration and reset - no
3) The state can be synchronized with KVM - no
4) The state is shared with another register - n/a (there is no state)

It also makes the register invisible from GDB since there is no 
underlying state.

As you can see, ARM_CP_ALIAS and ARM_CP_NO_RAW have contradicting 
semantics. A minimal change to make them compatible is to explicitly 
define what (ARM_CP_ALIAS | ARM_CP_NO_RAW) implies:
1) It has a state - yes (it has a state shared with its alias)
2) It will handle migration and reset - no
3) The state can be synchronized with KVM - no (due to no raw access)
4) The state is shared with another register - yes

More concretely, the documentation of ARM_CP_NO_RAW can be changed as 
follows:
"Register does not support raw access for state saving/loading; it will 
not be used for either migration of KVM state synchronization. It also 
implies reading the register does not expose a state and hides it from 
GDB unless ARM_CP_ALIAS is set."

With this change, we can express the semantics of PMCNTENCLR without 
extra explicit markings of ARM_CP_NO_GDB and any contradiction in code. 
This explanation is long but the code change should be minimal.

What do you think?

Regards,
Akihiko Odaki

> 
> thanks
> -- PMM


