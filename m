Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8056AC61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzCxj-0002SX-1H; Wed, 26 Aug 2026 08:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzCxh-0002Ry-9S
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:42:37 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzCxf-0007Ad-JX
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:42:37 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c15d3cd51b2so130412066b.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 05:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787748154; x=1788352954; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KZSHEna/7ySSKrIgJic1RC6pkqXxsBOf9yQI+ViRLqQ=;
 b=TZaXkq/+3D8s/bqqVNkWX0kIN4fcm7qSfRP12czKKiO2I6szHj/w/gXns9NM7iyZl5
 CGoFU2xLWuxUEQyBrqycSroDktJcOMo4tI5ZX/MTzkeFFydKMkXg8/w9rdaxM8LQSyJB
 1+/H7WqlAGJih0t3A1HiJ3QWhqDAY3IxmkiUHgPivReNWY6prFruWCR5LaIOBns5VU9s
 awp0emnXoMTPgYTZm9B5UkPOd4T9adpfZ1fFlSGumLIb/7OOw0RwWVyvWemayIuT8heV
 9ZG409FGWANqqtPUxBpE6dzfHNLXoU7wL6KW3SavfQUx5PUBXBVBSp7BkW5gEYZkJNoU
 VD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787748154; x=1788352954;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KZSHEna/7ySSKrIgJic1RC6pkqXxsBOf9yQI+ViRLqQ=;
 b=QW9Wum6fbVPSvXYWZf4GKr9Dvn+rDtsPcUWXWgY0Ul0cgQEl2atoElK424yqHVSQOl
 ha+j2QdxCjOjSx0X9/sqnIa1Pj513CJ5j0J8tcGQso0Mz/VdWOkFDjp4k6Pzm5j6YGaM
 P/dKsAgNrWIFTyeJagHLNyOc6XdrnV1HTX+iF3i1+oItWbGepAR1ipO9+ABps9qGoYqD
 v+esxvnwPIywxWAu/K7XGfuerK8+6ELHu9BauLLnSFXCvIUpt5QbLqQbMMeul8L/Mf/d
 KjQpc+ocaUcCYxL8+8ax5nwXp422dddpzx/dHnTi0bjOSesHZCAK/oz6ohDlX49053LW
 lfkA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpv8s2+5YEhZX6F7SmGswJddsU2HoQX1Y6kUW64wtn5jEcOu87O7hHryK+q0MvsPzdyPT6CiX4zAn/D@nongnu.org
X-Gm-Message-State: AFuF++mgetVpa18Bwmpo08l+D9sXAlMw/2buq9yehSAM4fjRJgUODIm6
 CE5/2MG5UQxce+41GJBJE3Nk2CgyATb7hd1lSPcsdXQ8nyevYQn4XaXr9emRlWwGxJg=
X-Gm-Gg: AR+sD12COQcDjH4G7nVW+SXdpcgb4555Ts8AQH+HSkxxGqiuE3BarzIBlTIaD6Bdecw
 EZSfQjOwtnEWNYAGomtTK59WQHINgcnWgnDQq2NeXh6XHxuktzX4rYkPer0ovGYBYKQUCR0LEAM
 fHmE2+YwsWFzVfi9wf7K/isDGj1sMpHjB3fm+YlShWeUR69n5i+fV4mRLmdpTw3LeXLoFQmC/TK
 HhvZolV/erZ0zuYcoGWCSWiFkrced9zLwmuZ6ecVUrEjkLAK/P8Jtbgcbt9xpKZ5yJLYnobyq37
 bDWC7eNUGIj8qh0iADbzntGgceYjb7vSob76VLIT4qAYGufrOWufPfR9yUAEv2AO4HooGIJuMSy
 iFzQs9x3hKVwwUZzFmaG4o3zfMvlnSnI+VTkmV5wQyZ9qY8jKrqD4AdtY9oRziCwesj0HaEDbtJ
 aHf15Ct0BaCg/r0/zdRGQlD4SM/OX8YeKJVAvUt2/vlMxWe8uI850GOyLEYz9A
X-Received: by 2002:a17:907:6d17:b0:c21:72b:dec0 with SMTP id
 a640c23a62f3a-c250bb7e1c6mr708152166b.5.1787748153710; 
 Wed, 26 Aug 2026 05:42:33 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d68d1sm568474066b.11.2026.08.26.05.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 05:42:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2402A5F877;
 Wed, 26 Aug 2026 13:42:31 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,  Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Markus
 Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v7 000/104] tests/tcg: run tests with meson
In-Reply-To: <f885071f-95f8-446e-819d-7dcb7f161d96@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Wed, 19 Aug 2026 07:17:59 -0700")
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <5e603ff8-b885-4f86-922d-6e2ee93fdef2@oss.qualcomm.com>
 <f885071f-95f8-446e-819d-7dcb7f161d96@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Wed, 26 Aug 2026 13:42:31 +0100
Message-ID: <87h5khoxxk.fsf@draig.linaro.org>
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 8/19/26 4:23 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 18/8/26 21:21, Pierrick Bouvier wrote:
>>> This series replaces TCG tests makefiles with meson, with the
>>> goal of having something more readable and maintainable in the long ter=
m.
>>> Also it closes the gap that tcg tests had with the rest of tests, by in=
tegrating
>>=20
>>>    configure                                     | 530 +---------
>>>    docs/devel/build-system.rst                   |   4 +-
>>>    docs/devel/testing/main.rst                   |  35 +-
>>>    meson.build                                   |  21 +-
>>>    meson_options.txt                             |  95 +-
>>>    plugins/api.c                                 |   2 +
>>>    pythondeps.toml                               |   2 +-
>> ...>   tests/tcg/Makefile.target                     | 281 -----
>>>    tests/tcg/test_cc.c                           |   9 +
>>>    159 files changed, 30852 insertions(+), 3924 deletions(-)
>> This is a massive rewrite of TCG test harness. Markus noted on current
>> /master there are no maintainer:
>> $ ./scripts/get_maintainer.pl -f tests/tcg/
>> get_maintainer.pl: No maintainers found, printing recent contributors.
>> get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> (commit_signer:62/99=3D63%, gitlab:@pierrick.bouvier)
>> Richard Henderson <richard.henderson@linaro.org>
>> (commit_signer:34/99=3D34%, gitlab:@rth7680)
>> Still before this rewrite you are the first one listed.
>> Just saying, you are a good candidate ;)
>
> I can help on this if Alex is ok with it!

That is the plan - I'm happy for you to take over the sub-system.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

