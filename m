Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC55C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uizsX-0004nt-7p; Mon, 04 Aug 2025 14:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uixgY-00088l-7i
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:05:15 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uixgV-00089s-63
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:05:13 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b7862bd22bso3129842f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754323509; x=1754928309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLwKhgsMsS29rhnm9N8Sckv8tzU3uJgHorjHxSXYiVM=;
 b=KTGRk6c97HQXU+fECxphzCksHyJcKAw8SO21xB2PZwo4RE9uZbK46nb4guSUstrbKN
 1ItWTJyIgfFrHPYbDJXjMv4MaNEZvdyKTHLrOyh1sSbi72uq3Ze3pCWe3wK+1TGWLvJ/
 TX2Vic+a2eGu8ULTtb1c2EgMvWYD8UxZo4HmdBlS+RGopyaDY0utwx5lgNIQBadAg/cM
 JSpiz94MP1mG14e9agX1kHHT42AhesP+GI3TOb+Rigj7P37+tBFIRQm9lYiWKhtnSJsx
 PV/QcHFg6e68nTh9vF/pWs7Q4WkUqJJA88ULrUxz4/mVmk2/4JvcmCXSokddnI9yKvD1
 O/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754323509; x=1754928309;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MLwKhgsMsS29rhnm9N8Sckv8tzU3uJgHorjHxSXYiVM=;
 b=nPELhisPqgIuClzBev8glL/Uv0/wylIBDHaC0kSFVMN2rjXFEu51BCM5FGyNOhC/6X
 LggJXmanyJWGYsgacxScclSLpck4HZgtlUzFbSMpcG+qXh3vnL3h1I/YPSqXwyB8JteR
 Te0oPWpuvrKZn+7EgkR5R/uopuh7tJFmgjyTcyVGkx5Im1Eumd8Mf0TokvR7IBUvJpsZ
 nOOANU0KQKDk/1nnXLhOXc/uMxkDoMpmnvaqqt3ATuM2OYb70nNNxkvbXZPA5s0P1ohW
 QgmmlZY9V5h40w9GDdEsx5BhPcZhLR2wCeYmhn9cfJFbfv2J9G/G6ImXoEcO3W15ppUJ
 IVwA==
X-Gm-Message-State: AOJu0YxYxoIGJSktnssg8Fvk5C0sf+hhX/Fhntj9tFDTK1IE6w3denBi
 88k6iMxdX/zdAUfcdT2yMg4bPq4KFZb9HKu1cxAi8PeB+6XZOqbcG9g4/TnnL4LHU2c=
X-Gm-Gg: ASbGncvIczU+lHmf2X45F0o6RrCounL2D0aNepzNHynS3NPkkddoUxTiNghz4Lalrb2
 10OVqITiO/S2BHJrC7jHKan9vuiMi5trhuQ+oTrdfWNTqQPY+EM4oUuhnDjodcNRy7ATqow782n
 EKVyyS0HBg1q1/JS2sCTVsShG8/trKy4xWglcBqpki8HA7nlqhKAh2i9EHQxflWq08O1dJ1uDif
 8dK0gS1/TpdRKbR6z1a2oMlLS/dNovh8DwXjbpJUEv6447y8zeFLhDM/waBXGKgEyYhIxf5lpo5
 L3ROAb6eCAEooGXH46FChIVoaS53zJEw2DVFwnwZCDAtTeXDFP9XOLojBezyoip/lyikOrke2yg
 TUUl7MHf9pFn3i/m0q/N4tCKizHY7S/3pTg==
X-Google-Smtp-Source: AGHT+IEVLvQegD5v5Fxle8fYKAWQDXoZkOsiQYSqaZVAEVTbDih4606my6asIl2EY3pw0YT99T3o4Q==
X-Received: by 2002:a05:6000:4029:b0:3a4:cec5:b59c with SMTP id
 ffacd0b85a97d-3b8ebedbfb7mr74275f8f.25.1754323508862; 
 Mon, 04 Aug 2025 09:05:08 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b95e9sm15842623f8f.16.2025.08.04.09.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:05:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F15D35F88A;
 Mon, 04 Aug 2025 17:05:06 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>
Subject: Re: New capabilities for plugins
In-Reply-To: <205e6753-53a4-4739-99ed-26344403a437@epfl.ch> (Florian
 Hofhammer's message of "Mon, 4 Aug 2025 12:14:06 +0200")
References: <205e6753-53a4-4739-99ed-26344403a437@epfl.ch>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 04 Aug 2025 17:05:06 +0100
Message-ID: <87tt2n5az1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

> Hello,

(Added the *-user MAINTAINERS to the CC)

> I'm currently working a lot with QEMU plugins for dynamic analysis of
> userspace binaries (i.e., running under qemu-user). While working on
> that, I found that the QEMU plugin API luckily has been getting more
> and more capabilities with recent versions but that I'm still lacking
> some functionality for my use cases.

We are slowly expanding the capabilities although we don't want to go to
fast lest we introduce APIs we need to fix later. That said we carry the
warning that the plugin API "reserves the right to change or break the
API should it need to do so" so hopefully plugin authors know what to
expect.

> More specifically, the "vcpu_syscall_cb" and "vcpu_syscall_ret"
> callbacks already allow me to instrument syscall translation entry and
> exit points. While the register read/write APIs also allow me to
> modify register contents in my syscall callback implementations, there
> is currently no good way to emulate a syscall myself in the plugin or
> explicitly set the syscall return value (as it will be overwritten
> with the original syscall's return value again, even if I set the
> corresponding guest register).
>
> I was wondering whether the QEMU community would be open to extending
> the plugin API so that a plugin can fully emulate a syscall without
> the original syscall being executed by QEMU.

I will defer to the *-user maintainers here. One thing we are keen to
avoid is plugins being used as a mechanism to work around the GPL
requirements of QEMU itself. It would be useful if you could outline the
use case for a plugin doing the emulation itself?

I'm fairly sure there are some syscalls where the plugin wouldn't be able to
do an emulation that makes sense, for example fork/vfork/execve because
QEMU itself has to do a bunch of housekeeping to keep track of stuff.

Also while the write memory helpers can take the place of QEMU's own
logic they come with a bunch of caveats about memory consistency. There
is stuff we do during lock_user() which those mechanisms don't.

> I had multiple approaches
> for that in mind, with some working patches locally that I'd be happy
> to share and build such a feature on:
>
> 1. Change the API of the existing callbacks so that the syscall entry
> point callback returns "bool" instead of "void" and if any of the
> registered callbacks returns true, execution of the actual syscall is
> skipped.
> 2. Introduce a new API function that sets a flag for a specific
> syscall to be skipped:
> 2a. A function that's called once in the manner of "always skip the
> syscall with this specific syscall number" or
> 2b. a function that's called every time in the syscall entry point
> callback in the manner of "skip this specific instance of the
> syscall".
>
> I'd be happy to get your opinion on those proposals and to
> develop/submit the corresponding patches!

Another option would be to have a set_pc function that would restart the
execution at new PC. Then the vcpu_syscall_cb callback could set the PC
to post the syscall with whatever state it wants to set up.

>
> Thanks in advance and best regards,
> Florian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

