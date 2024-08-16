Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE115C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 12:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewMQ-0007Bq-H6; Fri, 16 Aug 2024 08:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sewMK-0007BJ-7s
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 08:47:12 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sewMH-0002Lz-RC
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 08:47:11 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-367963ea053so1361986f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 05:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723812426; x=1724417226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jT9YZFIjJDrHFg3iiZB2AkLQ+0gavYQPcnMhBp0J/w0=;
 b=Ojk1CiiZfQRZpfeSzcRSreEqwVROZ9Rau7jI8dc2fWkfztciVRFWAnR3MfjH7qJldG
 yxHQQc+YDuUuXuqkx8WWqOZeHcDqFYUYVLoCgyPkclQgk8N8Z4EJ9RAitSgqz1ucikUH
 xfJQkAvY6VekutueeGwEPeF7cdKeFl4Ux0O+m8ScJ2uGCzkHfkNz4zRq0fx0XpImjFEv
 ons9D16FWiCLuFIfCqCvTwaYFu5usONw7URUzm91S/QFDpZfFdAf/+eog4vz4JQkJCny
 ptfKle7wqvw9ZdNWqarmVk+bulbGQwD/k/GYzv2BFovQ8hOAvqpiMrx4qTD/jnriZsb3
 Lt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723812426; x=1724417226;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jT9YZFIjJDrHFg3iiZB2AkLQ+0gavYQPcnMhBp0J/w0=;
 b=p771wzWKSVpnN8eTcnUCfVdSzDI1Lzmt3Qj6WTpE7htg298I28OOBklJ0styA0grBI
 GKBc7a051hH9rFawpdnJhF3r6c7MQ7oi6K4O3NW7DcGxr1TUAZqxF7WeT9UzxVixP9OT
 h6aVTcMO6CuXKzhZ58n74Ab7kHGPyewmYwi2YRFuFWlMXx8KaxiqSoUJf6dOFGCZBagT
 kX3MbzP11zUS3UdAD59Pg3Nq/PUJo2jrtAR2tIwmd6G96DuxGgVBoZGHOJ45u9JtugAA
 2paDR8mMYCeBrrCLl0ja8cH7o33tWc7GeWDEIap/cMbdRXCtWu+R8o1P70+mA9auo24v
 sijw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiJSKzLxMwzthjQIoY9mZYL3qK0Rvq32Wxkw9skRZ353vGoYtBFnpYiNWmCk4nWkDENXfRaPU0mytatIFEX/QJuVSKGIs=
X-Gm-Message-State: AOJu0YwIyaUBPPEvgNn6TK8k+QKFbx3yjA5m7U9x1lctrJa7gU8sNLMw
 mUjKNWL72u+QCF9dOkFVRn2U+Ii1lVCVPxv7Ze7Xu8t0BFSzTqaQofoW/nhrMDo=
X-Google-Smtp-Source: AGHT+IHQ6cDnTj0Je5Ja6Ix9/th95NNncONPSFBdtuymj+oIkDkzCpf/nj6JBdcie8eXJjFCMEzJbQ==
X-Received: by 2002:adf:8b17:0:b0:371:8dd3:27c8 with SMTP id
 ffacd0b85a97d-37194452c49mr2290027f8f.23.1723812425551; 
 Fri, 16 Aug 2024 05:47:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839471c0sm250304366b.182.2024.08.16.05.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 05:47:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 084C15F867;
 Fri, 16 Aug 2024 13:47:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alexandre Iooss
 <erdnaxe@crans.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/6] contrib/plugins/cache: fix warning when compiling
 on 32bits host
In-Reply-To: <557ad237-9a46-4dff-9177-bd4b2108d26c@linaro.org> (Richard
 Henderson's message of "Fri, 16 Aug 2024 08:23:11 +1000")
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <20240814233645.944327-3-pierrick.bouvier@linaro.org>
 <491b34f6-a81a-4793-984c-6a588910d0e1@redhat.com>
 <87ttfm2em2.fsf@draig.linaro.org>
 <557ad237-9a46-4dff-9177-bd4b2108d26c@linaro.org>
Date: Fri, 16 Aug 2024 13:47:03 +0100
Message-ID: <87h6bk3a9k.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 8/15/24 21:46, Alex Benn=C3=A9e wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> On 15/08/2024 01.36, Pierrick Bouvier wrote:
>>>> Found on debian stable (i386).
>>>> ../contrib/plugins/cache.c: In function 'vcpu_tb_trans':
>>>> ../contrib/plugins/cache.c:477:30: error: cast from pointer to integer=
 of different size [-Werror=3Dpointer-to-int-cast]
>>>>     477 |             effective_addr =3D (uint64_t) qemu_plugin_insn_h=
addr(insn);
>>>>         |
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>    contrib/plugins/cache.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>> diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
>>>> index 512ef6776b7..82ed734d6d4 100644
>>>> --- a/contrib/plugins/cache.c
>>>> +++ b/contrib/plugins/cache.c
>>>> @@ -471,12 +471,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, s=
truct qemu_plugin_tb *tb)
>>>>        n_insns =3D qemu_plugin_tb_n_insns(tb);
>>>>        for (i =3D 0; i < n_insns; i++) {
>>>>            struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(t=
b, i);
>>>> -        uint64_t effective_addr;
>>>> +        uintptr_t effective_addr;
>>>>              if (sys) {
>>>> -            effective_addr =3D (uint64_t) qemu_plugin_insn_haddr(insn=
);
>>>> +            effective_addr =3D (uintptr_t) qemu_plugin_insn_haddr(ins=
n);
>>>>            } else {
>>>> -            effective_addr =3D (uint64_t) qemu_plugin_insn_vaddr(insn=
);
>>>> +            effective_addr =3D (uintptr_t)
>>>> qemu_plugin_insn_vaddr(insn);
>>>>            }
>>>
>>> Is this the right fix? I assume effective_addr stores an address of
>>> the guest, so if the guest is 64-bit and the host is 32-bit, you now
>>> lose the upper bits of the address...?
>> I think the problem is higher up, it was a mistake to have:
>>    void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn
>> *insn);
>> return *void.
>
> No, not a bug.  This is a host addr, right there in the name.
> Returning uint64_t would be a bug.

No it's:

 * Returns: hardware (physical) target address of instruction

I was kinda assuming that was what the underlying host_addr[] fields in
DisasContextDB are. Are we just saying its QEMU's vaddr of where the
guest physical address is mapped into QEMU?

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

