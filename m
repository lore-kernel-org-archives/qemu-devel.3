Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B18ECA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 08:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upNLJ-0008UJ-R5; Fri, 22 Aug 2025 04:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1upNL0-0008Rw-Gl
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 04:41:34 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1upNKr-0000eO-Ji
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 04:41:29 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45a15fd04d9so19485485e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 01:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755852078; x=1756456878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5OCfmQ5x2LgBhm0elF8RBif3vXF+baqv1IrFMzBI+7M=;
 b=BQMHMMBKgU37Upwjj30W3ER1J2lRu8zZ/A3WI32fK53r4y4t+YVSYNHWQ79lAz16Im
 nW+Zxevd+uZLwRyrRZ1oaegG/MHDNppNekLNSKY6dyhaoT0eUzZtz1Bf65nMg42qfhSx
 ROLYCdTH+LA+kJ1FKQa/6o0Kq3dFnNL7VtipY5Gp0RGL8eXYAbVeq/ShHh267HZnRT2t
 aXy96tSQY82k2tyowcp+FTorN5wQ68SryBPQ144lwY2tSpvxV3Vh+Qax/5+IY3mdTkxF
 +BPd2OVoETvxsti9d7DU8jp3UbojsJnJeKBjLmcLWYJZlGzNFlQKdW1LOmK2Vq6N7Cq1
 g0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755852078; x=1756456878;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5OCfmQ5x2LgBhm0elF8RBif3vXF+baqv1IrFMzBI+7M=;
 b=tcl6vEeMTa7KP9KZNnr2WhXVW7jqaYsOml2SPywHw+UOLxkHt8XiYOaCYp5iMX/c1P
 B1mEyFhSGECxtt5G/X/DdChreBFNVxUdqHCFQTvQvKGQXfmAwVxl2/MWnHPiTqmZYNAS
 cYX0xT+c9S9SUgsSNzOSu4VGU1TB9321IqFf3j+2cVgS3gv4XlJC2YM5ewAlJY2swA9N
 NjEVCL7i29WxXhUiF4qM/wzvSTNBsDHQjK01qZTXZNLivLGnEqp5s8Mk2kG20uY86V0s
 Qy1aQmJgy0/iec6mtpZ3/LObRIbSGLDfcGArmq+7Bd1fmG7yyqI/gWVa/L9BZ+MWUxHR
 HJNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2fq9xRk6lH2cJrFu53poiCz8cMgoB23n6EhTJSHNnYW7q6N9uKzTqDd6YOcd3rxlWPFhJqSEh4p6H@nongnu.org
X-Gm-Message-State: AOJu0YzFxFuCY12brSg3NjdNzm1pqOH1JIlemAGXySjuR8WyX28ISs94
 2cPhT4xlwLcDP0OIGVR0DnxUP+aBr9wDmaLOVKrVRF58gNo4QQ6wBtETnO2wqc4thq8=
X-Gm-Gg: ASbGncvRLzb2uEFx8KdjuyjNWVIeZ23s04zfEY/QGJnndQ0cloKOeXrZ1mdQDg8hu29
 Y/I8BY1dYenGkPklWPx1NEk9vYKenrB6y4+0/ObdV4enwXKRajuVhIVa2dmBZfRcCK3gPYW0lMA
 +hjmn0Qz99AzgIz7GOqdDimXDYyHMFVF1mHdNhYQFNKYr49sZTNKzR0Kl7zSbDKwl4lhb6+6yuv
 MRVMFp5RxINtLc3PFbegDteE3JCL/m1VfPkDknGLUwVLGMWQcobeqJw9s+VATP1u/BHLvl9/u/D
 qmx9z07UAahZCJz0ZMf+hRJeIq2YZzHePWeQ6DAdVYl2rc3IrMO7CZSZzMYYcPw40/QSC++RuSr
 BKDjsM0fWoHiKa48AlUeOpBM=
X-Google-Smtp-Source: AGHT+IE7oy94D12zmIL/13p+dkQtzudOuGwoe5yrBt9h33LqTCG7Z9fLvxF1SDY2uQColg9/8J5IPw==
X-Received: by 2002:a05:6000:4182:b0:3c4:edc0:28ae with SMTP id
 ffacd0b85a97d-3c4edc02d8amr3987353f8f.28.1755852078038; 
 Fri, 22 Aug 2025 01:41:18 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c3e673aaacsm8061448f8f.23.2025.08.22.01.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 01:41:17 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 42E695F810;
 Fri, 22 Aug 2025 09:41:16 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,  Laurent Vivier
 <laurent@vivier.eu>,  Warner Losh <imp@bsdimp.com>
Subject: Re: New capabilities for plugins
In-Reply-To: <729dbc9c-d2ca-4c39-ae87-699780092996@epfl.ch> (Florian
 Hofhammer's message of "Thu, 21 Aug 2025 17:58:29 +0200")
References: <205e6753-53a4-4739-99ed-26344403a437@epfl.ch>
 <87tt2n5az1.fsf@draig.linaro.org> <aJItXiCESEAPDzec@redhat.com>
 <729dbc9c-d2ca-4c39-ae87-699780092996@epfl.ch>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 22 Aug 2025 09:41:16 +0100
Message-ID: <871pp3lpeb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> Hi Daniel,
>
> My apologies for the late reply, I've been out of office the past two
> weeks.
>
>> Yeah, this sounds like it is potentially going a step too far in enabling
>> fully out of tree extension of core QEMU functionality.
>> If something conceptually is in scope of the core QEMU codebase,
>> then
>> IMHO, our plugin system should aim to avoid enabling external
>> implementations as far as is practical.  That was easy when plugins
>> were limited to observability, but the more we enable in terms of
>> state modification the wider pandora's box is opened.
>> Where to draw the line is a hard problem.
>
> As I'm new to the QEMU mailing list (not to tinkering with QEMU /
> implementing things in or on top of QEMU, though), I'm not fully
> familiar with the requirement of preventing out of tree extensions
> (or at least certain functionality in such plugins).

I don't think we can prevent out-of-tree extensions. We do however say
the plugin API is not considered a stable interface - we want to be able
to evolve the interface without worrying about supporting code we can't
see.

There is basic versioning support in the plugin interface to catch
mismatches but there is certainly no backward compatibility - unlike for
example QEMU's approach to machine model versioning.

> I personally (of course with a somewhat biased view :)) see features
> that allow modifying internal state (such as syscall behavior) as
> beneficial or even required for certain dynamic binary analysis use
> cases. Currently, the situation in academic research is that researchers
> (i.e., typically PhD students) for dynamic analysis use cases fork QEMU
> and implement their use case directly in the core logic. Such patches
> can of course never be upstreamed, as they're very use-case-specific and
> typically don't generalize to the full QEMU functionality (or might even
> break / deteriorate other functionality that's not relevant to this
> specific use case).
> As soon as the corresponding project is considered "done" / "finished",
> the code basically just rots and never gets rebased onto newer versions
> of QEMU anymore, basically freezing it in time with all current bugs and
> without potential future improvements to QEMU's core.

There is a long history of academic forks of QEMU which have been done
to support various papers. Usually these changes never get upstreamed
and as you say get left to bitrot on old branches. This is unfortunate
because potential improvements to upstream QEMU never get made.

I should point out there are some cases of academic work being
upstreamed - the MTTCG changes led to a number of papers being published
and I like to think the overall quality of the academic work was
improved by having early review of the patches on the list as it was
being developed.

> That's why I personally actually really love QEMU's plugin interface: it
> allows me to introspect the system state without adding custom hooks
> everywhere in the code that might not be portable to newer QEMU
> versions! Consequently, my code is reusable either by myself later on or
> other researchers with any version of QEMU that supports at least the
> specified plugin API version.

Absolutely - the aim of the plugin interface was to remove the need for
custom hooks which inevitably bitrot when the instruction frontends get
re-factored. The unicorn engine fork for example will never be as up to
date for emulating AArch64 as the upstream because it is an actively
maintained architecture forever adding new CPU features.

> However, I often wish to modify QEMU's state as well, such as in the
> provided example with modifying syscall return values or skipping
> over a syscall altogether.
>
> Do I understand correctly that handling syscalls is considered in scope
> of the core QEMU codebase and therefore shouldn't be possible to do via
> a plugin?

I'm not sure. As I understand it the communities general worry is
splitting development unnecessarily and leaving QEMU as an "open core"
to which proprietary extensions became the only way to emulate certain
hardware or syscalls.

The security use-case certainly seems like a new novel use case that I'm
personally minded to support. It doesn't sound like much else is needed
other than the ability to reset the PC while executing.

> If I understand correctly, as it stands, there's no way to
> modify syscall behavior on an emulator-level with QEMU instead of at the
> kernel-level via seccomp, eBPF, kernel modules, ...
>
> Best regards,
> Florian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

