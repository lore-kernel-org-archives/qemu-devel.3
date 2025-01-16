Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC8DC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRUs-00058x-87; Thu, 16 Jan 2025 10:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYRUq-00058Y-7D
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:09:24 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYRUo-0002jy-J8
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:09:23 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d9f0a6ad83so2129415a12.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737040161; x=1737644961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3b4Rd72+k4RM5voYAehUfTvoDb+fP5EHpSzg3GeuTn0=;
 b=QjtckCvj3uBk/xcj0mWL0bI1D1o1IpKeTY+DWUTf6L+wifJgeLJyH69LHn8sMSi9AY
 iKZglLPimuwr/74rvtq4cbodmJiSonju9FeXy/Cwg+dJ94knRGAgGLMX0vkvFRpVOVa6
 W4B8B6RXKYetFDFHvHzx3GmmL5XIbqZMjQjKHY6hmAd3f/ZO0up0FLPx8RXFaKvCBA98
 ige+Ogbva9U1ORG0laFFTmgL4NBGtdYG+Frdk5M04f4EnkByC8LJAOlxK5ZCwm4sIvqi
 dBcY4nsOXE4mSMuBCLKyMXzpd4iJQ+Op10hhUtgr6z/9eQuqfvFGZix0GNFjxD386GO+
 bpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737040161; x=1737644961;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3b4Rd72+k4RM5voYAehUfTvoDb+fP5EHpSzg3GeuTn0=;
 b=QcsgPvzVNFKeVI8S6GwdbijZDfCMzjIXQUlg/xlxeMdbB7ymc6DBKendaRamPfNzws
 5BYZj+FkiCjc9JDlqHFAL5fYUHRU1EmE7A1XVsXyxK/PYGZbuQtLB9StQXWDmBbFTp5I
 cSwnbdvcFh6cCGB1VnNFmi4KV37jHK2x/ATl02gcSiWC7+lycco/P2YQlRqx1/djxqJP
 K1YdG7aY7D4AU+hz0DvU9G2LqztAt0Sx42FmwyC1IyVJkmLbGLU3Fspyerz2YDulETbB
 eW2Mp/FG8TKCOFIO6AZPGDRA+8HH2QFJrQzXRUJN0RMVBrsSsIPXMOxnhW1VH3qL76pC
 LGpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUiGhvUhAHkgmy2YqmwvbrWFG9i8wNLd4/HNW73SEN3CRZgYjNzNWksSzQPLHkbabuUEfXj47l6xtc@nongnu.org
X-Gm-Message-State: AOJu0YwrFAe1zzhZpbm0j6QJFZ63ILFMBsMjphEUY/eeAc5PHMQH/Nlf
 qvXX3FDXZb/L7AZc23pMfKISS/6mlnBBuYKiDZuLlemJCuAnNj57J7BNYJ9qn0U=
X-Gm-Gg: ASbGncvIZrehIDZWMAaDkhYqN56EmecuPNdbgw7aE3BLb8lQHf68Co9aV5Ot8vGn+VY
 NGziaEmQaK8nAuF1cYFT41SUposdUjOjX3k8HBKFoPZskEceZ6pQDiVgl1AZ9kxhKCfodH2GpAS
 8ACnotyo3UtrdutEoPCeL2/OJuuf/4qCjhkljg5C+Mjr1Fim8yerGhqkQaCvOkzMTOFwsPQ5t1N
 dU3c0v900uOBfRxWw3sI+1YgiG+f/jCAlBMZU/3E5X9TeyBXjI6Klk=
X-Google-Smtp-Source: AGHT+IGkEPoDxoJQoBqVkRG0Igib8gG6/nm0JwLN3ExSIOjRv+jVt9YPJLAlpGReYBcArKs813Lhxw==
X-Received: by 2002:a05:6402:3225:b0:5d9:b8a:9e08 with SMTP id
 4fb4d7f45d1cf-5d972e1b768mr33364385a12.16.1737040160952; 
 Thu, 16 Jan 2025 07:09:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73642379sm61663a12.8.2025.01.16.07.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 07:09:19 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CC0D860812;
 Thu, 16 Jan 2025 15:09:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org,  Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH] accel/tcg: Call tcg_tb_insert() for one-insn TBs
In-Reply-To: <CAFEAcA-ZOJUQPGWs7Czt1A1CdyojNoQ2L62Z-MvREgkg6GO4-A@mail.gmail.com>
 (Peter Maydell's message of "Thu, 16 Jan 2025 12:24:53 +0000")
References: <20250115232022.27332-1-iii@linux.ibm.com>
 <ac4d48c3-d139-4af0-ab28-f2674b74cb8c@linaro.org>
 <a82c41712409ac77d66f03e19b98382bcf11ba45.camel@linux.ibm.com>
 <87frljhvzk.fsf@draig.linaro.org>
 <CAFEAcA-4M5W4=JH3s45+9JZnKrVVAgKcRcH+gVqMJqGxRfjrpw@mail.gmail.com>
 <65e146746377bc307affc627f47c4700aaaac4ba.camel@linux.ibm.com>
 <CAFEAcA-ZOJUQPGWs7Czt1A1CdyojNoQ2L62Z-MvREgkg6GO4-A@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 16 Jan 2025 15:09:18 +0000
Message-ID: <87y0zahk2p.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 16 Jan 2025 at 11:48, Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>>
>> On Thu, 2025-01-16 at 11:06 +0000, Peter Maydell wrote:
>> > The original reported problem here seems to me like it's a
>> > problem with whatever target's frontend code this is.
>> > This is a single instruction TB, so either:
>> >  * the generated code for it completes the insn without
>> >    raising an exception (no problem)
>> >  * the generated code for it should raise an exception
>> >    without having modified the CPU state (so there would
>> >    be nothing to do for restore_state_to_opc)
>> >
>> > It sounds like the target is generating code which does
>> > something like:
>> >  * do part of the instruction, including updating some of
>> >    the CPU state
>> >  * then decide it needs to raise an exception, and rely on
>> >    the restore_state_to_opc handling to undo the state updates
>> >    it did previously
>> >
>> > The assumption of the "throwaway single insn TB" is that
>> > you don't do that (i.e. that restore_state_to_opc is only
>> > there for the benefit of multi-insn TBs).
>
>> The problem is not a partial state update in an instruction, but rather
>> that on some targets restore_state_to_opc is more than just a
>> "restore" - it is also "prepare for handling an exception", i.e.:
>>
>> - arm: exception.syndrome
>> - hppa: unwind_breg, psw_n
>> - mips: btarget
>> - openrisc: ppc
>> - riscv: excp_uw2
>> - s390x: int_pgm_ilen
>>
>> Some of these may be wrong due to unfamiliarity with the respective
>> architectures, sorry - but this illustrates the idea.
>
> Ah, yes, thanks for the clear explanation. The "throw away
> the TB" design didn't consider that (or vice-versa).

We can certainly do with better docstrings for tcg_tb_lookup (via the
region tree) and tb_lookup (using cache and/or QHT) to make it clear the
difference between the two. I don't think we should ever use
tcg_tb_lookup for the purposes of executing a TB, just for resolution.

We have a few spare CF_ flags so maybe we could have a CF_RUNONCE flag
which is set for these TBs and assert its not set in tb_lookup along
with the current CF_INVALID flag. We could possibly set CF_INVALID
before executing the TB as we don't check the tb state from
tb_gen_code() before executing it but I guess that might be a little too
magic.

Rich, WDYT?

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

