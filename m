Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB66C35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 11:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvapc-0007Gg-TP; Fri, 21 Mar 2025 07:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tvapY-0007FK-Rh
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 07:46:28 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tvapX-0003uf-4K
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 07:46:28 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac3b12e8518so409945566b.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 04:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742557583; x=1743162383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEleFT8eL9IAm/t1fQpCxzOOBsSb9NZ1X1vSPjxWOeM=;
 b=v8vXuTEZZgdqJngShE1yQjDLuhSSMWvhehpHOqMDOJC0dPbZhko2X4D6lHn30Iiu9y
 HLDibLqrYBPKsxUHPkek1kXcjPdQ3Zk+VP5JGLN7RQScoW6/x/mJYWVYpU0CuRIKOQng
 B/kpqfe6+ked4eZ1Lfhly7AOhWxR0fXvTJKvd/mm/H8eTA9esrm5AF71LLUvPBwfUuuA
 CyejeXE65s5kTHjkL1aUJ+7iTt/qucn0pVi3OVIj7adOUw7jfTy3/JWcAfXD3Ty7khtr
 EkHgRacploR8lndOBAelJPoJBTQjFRmBr+PAekRR+m/1dLqQTrEIRDFxhfSbrpBtoD43
 HgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742557583; x=1743162383;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LEleFT8eL9IAm/t1fQpCxzOOBsSb9NZ1X1vSPjxWOeM=;
 b=VLPk/3HPtK4WUk+vpqHI3wXFG2rn7oWxv/eTJ6ggpmuK0A0snlHV+Gg2LR6/VRjyjs
 uTdk5UW+TW2ujbWz3TanHQsMydy1T5YNfby02+N91EcsRmQT4wAaXvu7pOEVzP7WDQYE
 Ac4hOEB60xY8UwYOWl+MqUCC+cncBgClnFI5a/UTFdXRRmUZm6PCJno7sRlVbZEg1c2u
 Tu3udZz0l14KsB8gziUMx0De4je+1wmsL08nf4KU5TJWa35DSxwL5eue+GHAfKd6k7HY
 BHhXhliTXfhRJMg+YSsToBPNergtB7z6CuZowun+G5JQiA36QD60twEmyHsSKLjhCU4E
 jjtg==
X-Gm-Message-State: AOJu0YxF8Qem5lDbFUJ7acZXpG2sI4pRUXDfG3KIlzBXRl/dSo89N2SI
 sL2bznMaP0AU1yWgzw9vOU/NMJlMEElKqCTE3HHhiLBNRK8++8qp9qBCJS0bj0E=
X-Gm-Gg: ASbGncstCdbLlUa3FYav93r82YJ01mP2PLwpVVv91/dDrigLZhV6Q9Y+blRumMfVq4n
 E6szQpb7tyY4t0lmqApb6m3KeWO4WHvYv3UkV6wMDwFenhwQzHbZuLP01Z964W3L+pCW5cu+VI9
 Y7WIKKoWO2m07w5QAcXPHhHqiYfLSeHVooqjjY7/xeVSPwupaMewULHnSNR2+kiWDLtjbvveguB
 6JfFEnnXNYiKNDpXaqIUKD54qRZHb4/lh6N4vcOeskb/JaGBTSnkcrKqqGmuJYDZS86LdzHecIB
 xugYTi6lGT8RJuUXloJCm9q+hfpnbyxB9Ah2DzxeNCkvYYTosBdIIQ3hXQ==
X-Google-Smtp-Source: AGHT+IHkF6tRqp1+aTmM7Iv2NAbqAoCjaeaY63kL09Obqw9obo52t+ocOuM0n2T6a9OdNoyya8dG4g==
X-Received: by 2002:a17:907:c88a:b0:ac3:bdd2:e70c with SMTP id
 a640c23a62f3a-ac3f24d1708mr315641966b.35.1742557582775; 
 Fri, 21 Mar 2025 04:46:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ebcd0c77edsm1195181a12.54.2025.03.21.04.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 04:46:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6CD5C5F7A5;
 Fri, 21 Mar 2025 11:46:21 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Juan
 Quintela <quintela@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>,  qemu-ppc@nongnu.org,  David Gibson
 <david@gibson.dropbear.id.au>,  qemu-s390x@nongnu.org,  Wainer dos Santos
 Moschetta <wainersm@redhat.com>,  Peter Xu <peterx@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  David Hildenbrand <david@redhat.com>,  Yonggang
 Luo <luoyonggang@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Beraldo Leal <bleal@redhat.com>,
 qemu-arm@nongnu.org,  Greg Kurz <groug@kaod.org>,  Philippe =?utf-8?Q?Ma?=
 =?utf-8?Q?thieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Nicholas Piggin <npiggin@gmail.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 00/10] gdbstub: conversion to runtime endianess helpers
In-Reply-To: <0bc36324-4fb7-41ee-a9f1-3a7de4ad7fa4@linaro.org> (Pierrick
 Bouvier's message of "Thu, 20 Mar 2025 12:52:22 -0700")
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <0bc36324-4fb7-41ee-a9f1-3a7de4ad7fa4@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 21 Mar 2025 11:46:21 +0000
Message-ID: <87a59eli7m.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 3/19/25 11:22, Alex Benn=C3=A9e wrote:
>> The aim of this work is to get rid of the endian aware helpers in
>> gdbstub/helpers.h which due to their use of tswap() mean target
>> gdbstubs need to be built multiple times. While this series doesn't
>> actually build each stub once it introduces a new helper -
>> gdb_get_register_value() which takes a MemOp which can describe the
>> current endian state of the system. This will be a lot easier to
>> dynamically feed from a helper function.
>> The most complex example is PPC which has a helper called
>> ppc_maybe_bswap_register() which was doing this.
>> This is still an RFC so I'm interested in feedback:
>>    - is the API sane
>>    - can we avoid lots of (uint8_t *) casting?
>
> Even though the series has a good intent, the fact we make everything
> "generic" makes that we lose all guarantees we could get by relying on
> static typing, and that we had possibility of mistakes when passing
> size (which happened in patch 4 if I'm correct). And explicit casting
> comes as a *strong* warning about that.
>
> By patch 7, I was really feeling it's not a win vs explicit functions
> per size.
>
> If the goal of the series is to get rid of endian aware helpers, well,
> this can be fixed in the helpers themselves, without needing to
> introduce a "generic" size helper. Maybe we are trying to solve two
> different problems here?

It did seem natural that if you were defining a MemOp you would use all
of it rather than only its endian definition. But you are right we could
introduce the same helpers with a bool flag for endianess.

Maybe we should have fully formed mops and just assert in the helper:

  gdb_get_reg32(MemOp op, GByteArray *buf, uint32_t val) {
      g_assert(op & MO_SIZE =3D=3D MO_32);
      gdb_get_register_value(op, buf, &val);
  }

I was also trying to avoid over boilerplating the code.

>
>>    - should we have a reverse helper for setting registers
>> If this seems like the right approach I can have a go at more of the
>> frontends later.
>> There are a few other misc clean-ups I did on the way which might be
>> worth cherry picking for 10.0 but I'll leave that up to maintainers.
>> Alex.
>> Alex Benn=C3=A9e (10):
>>    include/gdbstub: fix include guard in commands.h
>>    gdbstub: introduce target independent gdb register helper
>>    target/arm: convert 32 bit gdbstub to new helper
>>    target/arm: convert 64 bit gdbstub to new helper
>>    target/ppc: expand comment on FP/VMX/VSX access functions
>>    target/ppc: make ppc_maybe_bswap_register static
>>    target/ppc: convert gdbstub to new helper (!hacky)
>>    gdbstub: assert earlier in handle_read_all_regs
>>    include/exec: fix assert in size_memop
>>    target/microblaze: convert gdbstub to new helper
>>   include/exec/memop.h        |   4 +-
>>   include/gdbstub/commands.h  |   2 +-
>>   include/gdbstub/registers.h |  30 ++++++
>>   target/ppc/cpu.h            |   8 +-
>>   gdbstub/gdbstub.c           |  24 ++++-
>>   target/arm/gdbstub.c        |  57 +++++++----
>>   target/arm/gdbstub64.c      |  53 ++++++----
>>   target/microblaze/gdbstub.c |  44 ++++----
>>   target/ppc/gdbstub.c        | 194 ++++++++++++++++++++----------------
>>   9 files changed, 257 insertions(+), 159 deletions(-)
>>   create mode 100644 include/gdbstub/registers.h
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

