Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A164F33A77
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9ul-0003cN-L9; Thu, 05 Mar 2026 09:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy9uk-0003c6-He
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:42:58 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy9ui-0004VA-Fo
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:42:58 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso9980259d50.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:42:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772721775; cv=none;
 d=google.com; s=arc-20240605;
 b=aP4hLrjHBUs/2gyM9zwMV8f2g/UVFzi5CiIRqhEhpKtk5ue6gvj1cpkW57jBYJLDbT
 ihJwId4rUlnnJDRR7mKO4uGyPLdFOz3yIeUth1rnM/jvGAbQhaN84/klxUNgDvFF8rR4
 HXBAiSEg4kMWEnm3Cc0Hy93q4KL14h1bJP5C8JwV4K5TKmKG6OKEjRiusqAoHQsoGHJD
 JjdeNTKlMQ22IE0TeFSoMNBMZtgLULwFl8pXXf3TLbWAnY9HP+uLe1c3/JEjAGUeYMIw
 lGf2clI62tsfD87np99MvS7UE3QlohvpTujUU+ldC+MSQGL7DG9k9qtYrtQh2Cs05WGE
 po7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cDrKQ5010Z3oJx7Ld2AxBFVhSAsu+u4zp8E+NOJOK98=;
 fh=Vz8s/HVZQOzJV0tZXMmAOmhFQB6aATfDutT1YYrem9g=;
 b=HPZ2cifpivR6Q5XWD923G7+tVeQFjPQMSlIEsFrTFrdAmuhzpaUQOwPMP/hdyrcoQV
 gdg040ESnRQ3wkPCtEt8dXR8nszJRSqjPu0qj89fTmrvInVduPO/ceQX1RICuQwPrkrR
 pMCEpBQdYYGBRE63byhuwNxiArwa1l+UlgItV3lwJo4j6SoKiVWQEZCJnhdovUqrpuwz
 MrZGNV01qBDKHrBhchJFr/K6Lp7MB6ReULyi1PhFisRqWGmCP7jgL4xCftrA31hY2dFg
 RlC/+0TPIDDQjq31L/H5O/WfYHy2GMzcWz80BTarP4PTnBboe0BwuJx0fcej50tScWt1
 iFVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772721775; x=1773326575; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cDrKQ5010Z3oJx7Ld2AxBFVhSAsu+u4zp8E+NOJOK98=;
 b=h4QEaqZEHKvYUXSS8L9VW0Z1oa9gx/WjoBztvKG3fjEjY+21oumvyVDJ0Ho0sidKf1
 M6BfiY4zUYAOTcNKDj9Mrs9HxsmZlIQbLZMf7cp3ajHlxy4DOucplf7tOYC3Hcf1nzwQ
 r02M8jCH1ounELTKqm0zPmNqwEJuDFP7H8xU2R6vRgx1Jax7gRaCvFsROUbb5+ImwZKR
 q4kWXShSJhnFKNAhPEizf+RSGGD9tWc1sd7xf0btJcOzBev9mY4dBSZJSz6X/6LlOohn
 G5LzVL0YX0Lf+VWgwhfwIvIS+bPgVMJq5x2pws3kcJlct8E7W+BOZvjLfyd3M2tozxAw
 xN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772721775; x=1773326575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDrKQ5010Z3oJx7Ld2AxBFVhSAsu+u4zp8E+NOJOK98=;
 b=u5OHQsaF/G/FZZWCzk27N8Xflg40hJLLzDYWWv+Hi1XutO5nKsfxNlGjsbkJiVfIMB
 C7vQjbV/mXpmRH91hbnhSkSUtijOmnIjwYXkhAK6DDxME8mtkj+srOgWBLp5RO9UTB/p
 69ZFOw0K6h1GJ5jbUSlNvdn7+jd9XpGAY5DbQPEZ5IooVIo9F72f2kX+JpS67n9tJzgh
 B3C8aDg9KWEm+sZM4Ow/gCHfeBglH+qkMPYS6gI2p5aljXBAe9sCvVguoxRysCxSRG3E
 5qHs/zxrUJrbFw/f629kOpgxnD/VvYtODI7sEtMroArJl7t29VWkPv9mqpvgyRmzcQP7
 A2TA==
X-Gm-Message-State: AOJu0Yx7TugPhmX+VH/ZCxZPxUfmMR5+vZkP6ob/hdTBhmoWQtMVSW2l
 HJFI+CqaPEbJDMAfrTuXVLB44Lbf7608DEbk5xYgCnxNgRNdzAeJj5HcteRjCxdRCZ4SI3lRYHf
 KmTtvGlTvZmLjSZPoTVVwG9oiu5wMfxpjiCnL2aWzbI4BVVwbZqGYPOM=
X-Gm-Gg: ATEYQzx17Acr8g7mKp3Mwb+J36fiocXeZha9/AWG+ZV49fqFjqpN6fYgo5F4nrlWN38
 gOjP+W0aj6PA8wUy4z354gbSZtpmUTMI9ITPlViZlOjgveNLXN5LbAcBTM/AzOPkMWgo97jEFdU
 Us+IWL/gM71Ncqsq/1YVEF6zSA46hILTeFIc+OmW7psAiKsn+1fmnOvcO5aVdlJXEiCtWhFmOwR
 YML6PTQc2/d1x+SXzeYQe9pwsIH6DuawhVohy60NO3RFVcj9WFKZ7zyup94ZCgpC8caszbtZISa
 LkGyIIlOBQba87Q6VXh7MG2ajGYvC9vlWhrxSMnMRobYcTwMw19CGzRKLpJazS+0vIA=
X-Received: by 2002:a05:690e:1a93:b0:64a:d742:6773 with SMTP id
 956f58d0204a3-64d0715016bmr1388432d50.43.1772721774996; Thu, 05 Mar 2026
 06:42:54 -0800 (PST)
MIME-Version: 1.0
References: <20260305120104.1254578-1-peter.maydell@linaro.org>
In-Reply-To: <20260305120104.1254578-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 14:42:43 +0000
X-Gm-Features: AaiRm52d3vuWUCD42H6vs6b67LmagQZUTfMnsziXnIzuibnsXkoIcanAOe1J3F0
Message-ID: <CAFEAcA_kSC9mV-mX0EEZ4+oQomMb5rvpV7ocmauAJVBT4O-Mxw@mail.gmail.com>
Subject: Re: [PATCH] tests/plugins/tcg/mem: Don't access unaligned memory
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 5 Mar 2026 at 12:01, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In commit eb3f69cac62670 we removed the dependency of this
> mem plugin on the QEMU headers, but in doing that we introduced
> undefined behaviour when the plugin accesses unaligned memory.
> This shows up if you build with the gcc or clang address
> sanitizer and run 'make check-tcg', in numerous warnings like:

This should read "with the gcc or clang undefined behaviour
sanitizer", which then lines up with what the error message
below reports itself as:

>
> ../../tests/tcg/plugins/mem.c:167:27: runtime error: load of misaligned address 0x7f1f300354b1 for type 'uint16_t' (aka 'unsigned short'), which requires 2 byte alignment
> 0x7f1f300354b1: note: pointer points here
>  00 00 00  00 01 02 03 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12 13 14 15 16 17  18 19 1a 1b 1c
>               ^
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../tests/tcg/plugins/mem.c:167:27

Specifically, I see this with
  '../../configure' '--cc=clang' '--cxx=clang++' '--enable-ubsan'

Here's a specific failure;

timeout -s KILL --foreground 120
/home/pm215/qemu/build/clang/qemu-system-aarch64 -monitor none
-display none -chardev file,path=run-plugin-memory-with-libmem.s
o.out,id=output -plugin ../plugins/libmem.so,region-summary=true -d
plugin -D memory-with-libmem.so.pout -M virt -cpu max -display none
-semihosting-config enabl
e=on,target=native,chardev=output -kernel memory
../../tests/tcg/plugins/mem.c:167:27: runtime error: load of
misaligned address 0x754e340357c1 for type 'uint16_t' (aka 'unsigned
short'), which requires 2 byte
alignment
0x754e340357c1: note: pointer points here
 00 00 00  00 01 02 03 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12
13 14 15 16 17  18 19 1a 1b 1c
              ^
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../../tests/tcg/plugins/mem.c:167:27
../../tests/tcg/plugins/mem.c:179:27: runtime error: load of
misaligned address 0x754e340357c1 for type 'uint32_t' (aka 'unsigned
int'), which requires 4 byte alignment
0x754e340357c1: note: pointer points here
 00 00 00  00 01 02 03 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12
13 14 15 16 17  18 19 1a 1b 1c
              ^
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../../tests/tcg/plugins/mem.c:179:27
../../tests/tcg/plugins/mem.c:191:27: runtime error: load of
misaligned address 0x754e340357c1 for type 'uint64_t' (aka 'unsigned
long'), which requires 8 byte alignment
0x754e340357c1: note: pointer points here
 00 00 00  00 01 02 03 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12
13 14 15 16 17  18 19 1a 1b 1c
              ^
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../../tests/tcg/plugins/mem.c:191:27
../../tests/tcg/plugins/mem.c:165:13: runtime error: store to
misaligned address 0x754e340357c1 for type 'uint16_t' (aka 'unsigned
short'), which requires 2 byte alignment
0x754e340357c1: note: pointer points here
 00 00 00  00 00 00 00 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12
13 14 15 16 17  18 19 1a 1b 1c
              ^
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../../tests/tcg/plugins/mem.c:165:13
../../tests/tcg/plugins/mem.c:177:13: runtime error: store to
misaligned address 0x754e340357c1 for type 'uint32_t' (aka 'unsigned
int'), which requires 4 byte alignment
0x754e340357c1: note: pointer points here
 00 00 00  00 00 00 00 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12
13 14 15 16 17  18 19 1a 1b 1c
              ^
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../../tests/tcg/plugins/mem.c:177:13
../../tests/tcg/plugins/mem.c:189:13: runtime error: store to
misaligned address 0x754e340357c1 for type 'uint64_t' (aka 'unsigned
long'), which requires 8 byte alignment
0x754e340357c1: note: pointer points here
 00 00 00  00 00 00 00 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12
13 14 15 16 17  18 19 1a 1b 1c
              ^
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../../tests/tcg/plugins/mem.c:189:13

Similar with i386 and x86-64 targets.

-- PMM

