Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ED8CCF2CF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 09:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhlGC-0007E1-Kc; Mon, 19 Jan 2026 04:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vhlFx-00079o-Eu
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 04:09:10 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vhlFv-0003ka-K4
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 04:09:05 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4801bc328easo31692985e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 01:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768813740; x=1769418540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79YVb/hxSMCa6YrIkDWoxyVWkCyAHRMKt/lBTvO06Js=;
 b=PokBnGh7R1QAZyFjqvMVvOUplSItYKH49soXbfdpZYnPYJCSP+MC8Ef5GfiO9mIxLg
 6OloNMqMlbjI2XvUwwzrObyMITqjI49nUx9DrbzvEfCSTCzcfM3gPkAmBrKqn19EZt9i
 G/eW7528lzgi4hnrNg8I9VpcXcEHxV7roL2wFvZSXOAuatA+nvShQwBiFAjThke6pxEe
 4/oYpY35vfcdqubBfQoNEQ9EnP5HdmZ3q0gV/C29rAQ/L0tPopSsGc9g2SZ1YkwByCSC
 xBEYyFoMsKEUxKmR9p8JoB7AGic3GEj23X7fk1EXnSC3HKA1g54r1HVChF7ELr1ud4bb
 w2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768813740; x=1769418540;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=79YVb/hxSMCa6YrIkDWoxyVWkCyAHRMKt/lBTvO06Js=;
 b=Zgh9Zg+BhXnUs/XnbSIFhzC9KxiVzY86W5+C5Npd7s61LnhOfXQZYc3lIVjIv09BUl
 4pNZx7rB5cvgTyObhgLbrOwx/7RYKnR97jnyNNTfPNRKwdijTO4wVcnwKwc6egd7KxA4
 q0n3wAO7LmE9a7vAj27lrgUhYUS6I0uKfHjoKlPtCaLBQwSuoqXg3BMpM33vbK+DBaE8
 GgyU7X73uHpNlRZ92f3t4qXUNNQj3qjt7dC0Zt4yMZx5DQMlrnIbeUl7l4EkS2qMeYHG
 cIECpq5EZRkb/vUpzaa7j5L1nuiRsOrS/EWpc1SFaNWzqCgA6MVvXLlQlGWv73Rz2ekm
 zhWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwsGUA1zYnFiVCpzlkePPWBZT9LwoFAobtpJhNPZYt99zQ6xUByL7cbjaEgFHH/W3TgVHWcnoUpEhp@nongnu.org
X-Gm-Message-State: AOJu0YwgnYIeZR1+WnzheGbXp9iWNOI6govexbBJ8DFogOhANqrIZ9Jv
 97bXL5wRUWTA706yqdHlHYOBoLaK9qr7nL4moUf9JrYuwYKe1qLCzB/p8rup5vWEy1E=
X-Gm-Gg: AZuq6aKd7/Zj1+aIemUzASSStN+MovqpdnvnwZqWG2PT+XnKwP0ael9LTptsfgWkmsV
 WUCY/NMMdB5jhJmw0zLw/l0mRpG+0GunsZcnL4uSvdDwFy5AtSbZURerpez02yOSm4WdQB6Omf+
 /GKljZQerNIfDROrYnBAJdpzj3f+Hpr3VqXsYhRZydm15RvjOP6aP7ioPO1lVWtOTcoCS/hYeuW
 1Cfm/jjdgYiJvyMfy4jDjAGbA7ly7M6tw9R7qGNAXltGPeR+9nYkv10EBJxHtRLrjQJs8A0WqHO
 7eRheM0HoZa18lWuO0fA4u3UGLirfY9dzPiQgJd7+lg9YU7IME/2Ok5zAsaGO9phVdpdsUQhJGI
 v6/5p/sCWfLzUJY2yPJDwAJrwGsE3uHGDWeaHFrLSIHUEr2fBwsw9wBR2Rvdasw+cuKIsSTts1u
 OUbs5+VDiluQU=
X-Received: by 2002:a05:6000:2005:b0:42f:b707:56f0 with SMTP id
 ffacd0b85a97d-4356a0773camr15809483f8f.37.1768813740404; 
 Mon, 19 Jan 2026 01:09:00 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569926648sm22593369f8f.10.2026.01.19.01.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 01:08:59 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E41B65F856;
 Mon, 19 Jan 2026 09:08:58 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,  Laurent Vivier
 <laurent@vivier.eu>
Subject: Re: [PATCH trivial] plugins: correct docstring for write_register API
In-Reply-To: <9c71b7dc-ec43-4726-a868-c1c3a3ce3ba1@epfl.ch> (Florian
 Hofhammer's message of "Sat, 17 Jan 2026 18:51:44 +0100")
References: <60089475-3891-4448-bfe0-8dd698cd2435@epfl.ch>
 <0d32ba74-9171-425d-ac0e-1303d6ca154a@linaro.org>
 <0458a52c-b86b-43e8-84f6-ec75b012a9a2@epfl.ch>
 <3d9c9fbe-711c-4be1-84f6-5fa3cc18d2a8@linaro.org>
 <9c71b7dc-ec43-4726-a868-c1c3a3ce3ba1@epfl.ch>
User-Agent: mu4e 1.12.15-pre1; emacs 30.1
Date: Mon, 19 Jan 2026 09:08:58 +0000
Message-ID: <87tswias0l.fsf@draig.linaro.org>
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> On 16/01/2026 22:39, Pierrick Bouvier wrote:
>
>> For sake of consistency, we should make this use the same interface than
>> {read,write}_memory_vaddr, minus the len param.
>> bool qemu_plugin_read_memory_vaddr(uint64_t addr,
>>                                    GByteArray *data, size_t len);
>> bool qemu_plugin_write_memory_vaddr(uint64_t addr,
>>                                    GByteArray *data);
>>=20
>> So it would be:
>> bool qemu_plugin_read_register(uint64_t addr, GByteArray *data);
>> bool qemu_plugin_write_register(uint64_t addr, GByteArray *data);
>>=20
>> This is better and unambiguous, as no one needs a documentation to know =
what a bool return is, and data already holds the size information.
>
> Sounds like a good idea. This would break existing plugins though, is
> this acceptable? (Asking purely out of curiosity, as I'm not familiar
> yet with the processes and policies around breaking changes in QEMU
> development :))
>
>> As well, writing this, I realized that existing write_register is broken=
 by design: we never check the size of data array (except > 1) and blindly =
an arbitrary amount of memory from it, which is wrong.
>> Even though the doc mentions it, we should just fix it, detect when size=
 < reg_size, and return false.
>>=20
>> This comes from the fact gdb_write_register itself has no notion of
>> size and trust the pointer. so it would need another refactor also.
>> And while at it, change gdb_{read,write}_register definition to
>> return bool also.
>
> gdb_read_register already takes a GByteArray, it would make sense to
> also use GByteArray for gdb_write_register instead of a uint8_t* and use
> the size of the array for sanity checks.
> However, I'm not sure changing the return value to bool for those
> internal functions makes sense, as other parts of the codebase rely on
> the size information. E.g., handle_write_all_regs() in gdbstub/gdbstub.c
> relies on the size returned by gdb_write_register() to know how far to
> offset into the packet data it received from GDB, as GDB does not send
> register size information when writing multiple registers via a 'G'
> packet (just a flat byte stream with the register values
> concatenated).

We don't need to expose internal implementation details to the plugins.
If we have length already as part of GByteArray then returning a bool
for success/fail makes sense. Its the more modern pattern throughout
QEMU anyway.

>
>> I think it pushes a lot of changes just for a simple comment change,
>> so I would understand if you don't want to do this whole refactoring
>> beyond plugins interface. I can pick it up, or let you work on it if
>> you have time/interest. Feel free to let us know.
>
> I'd be happy to handle this!
>
> Best regards,
> Florian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

