Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83252C282DE
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 02:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsuzy-0003Xg-6c; Thu, 13 Mar 2025 22:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tsuzt-0003Wj-Mc; Thu, 13 Mar 2025 22:42:07 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tsuzq-00016r-LY; Thu, 13 Mar 2025 22:42:05 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso3459287a91.1; 
 Thu, 13 Mar 2025 19:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741920121; x=1742524921; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qzOBfJzO2aOdVHwBhNeh24Lhja0wtjzY4vYbx8HfR0Y=;
 b=d+0nhqKsNWJ0RYyfuFYwLlh0EcZ3M9ZRIfAnAXwQLdYJoKdZdjf+vS24RKPDQxnhA8
 YDzvbNPRZSF7oH8Vnv9ATMtWPhrO+W9v3l6ne98Sjn9ickrYWlId3HS/fjcJKTKeooX7
 HVExMYDp2ZlVkwST6OKgIjTFym+m480sGr3ta+8kkRS4+Y6iglP/f1n6/z2RCwzPDED5
 nwbHaMHMCWP3ElVllRsC7Vfpy4FtTyDVRfYUrD0EgKIWk8GLOO+yF7+WgpfoqACTC6jL
 RRHLaHvWAq9lJ59qDneS0LikeaVQezKZocLeugvn40BwMuFWsEauytebfAgJMvK+YcBD
 wFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741920121; x=1742524921;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qzOBfJzO2aOdVHwBhNeh24Lhja0wtjzY4vYbx8HfR0Y=;
 b=pBUIwyaHun47JGLOP5b5rxF8FcHAJDJaXAJIXQ7yYVSVQVYshSfTWmQAqrKsDpnirn
 U70I/I0WfmFwA+L+3rX4F0Q7Z+ftCtuHM48SiDSwtbdhs+SKDBv7OPDd5gYQJIeu/kJW
 W1drJLXsq60Wx7CBZNFVCUUN92ZhSm7gnPBtdlp79wr9fXu9UGeK8n1i0+/U5Ut3YKsa
 IZLJ6/BZb6IbXhbYKL0ZNz8HOAqs0Pli0jHSdmSGmM2SvEAGBofwm9wUfqukmKUxTXAy
 3qLqXK95JAIr5vLBI64XrGtxILfmWnJO4BbZDWjRslXTAT+0fjE0SBpumrp7d2Ioe2c1
 IE6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAbsOtksnL6uWiT7S9VUaLaoy+MNE10rk3IG1dfgAz1Pm8gL4kD1sqdOWjFzlSKOBPWMcFB1OUhg==@nongnu.org
X-Gm-Message-State: AOJu0YyyLpUoZ98M4OLTiKQfIjlaK5pJWhakNEyGBC6QqScXeOTAs8If
 vIR5IA+HLZmAZWwOmHPovWa1MSrM2jpjpTQBaomB+p0ddSnGtD4v
X-Gm-Gg: ASbGnctM+PbL3Jrd0GosQ8Xh22jzspXQEqaa7tXbq2BMiROOVRgal06LUBUCHEU4HgA
 3ORhgDuVjliTLmH2eb3hdtd6OTZfU1XR3Xu9TkOkES6UGfB6e8QtHvFR/+O2MaSyAQqzMjEVQaF
 Aptea5gH3OYfbQqbMCekyo5D1ljLfsp/itWSUl23L4mYMCHkHqU3vdfDqbCoHcUP20EMl21lvRC
 yIHg9qGUjncHA+JEwGF/IOozRlVoLHxXqoKbzOFhC6MMbNAEivt+rc2PAzbYrBnEGCL+SDrDp6F
 L315tvFOZafYO2619K95MDik/M9ZoC/Z/2EmXOqLtuQWGQ==
X-Google-Smtp-Source: AGHT+IGaLxxMcnH91KJXQ/0ZJGBneLvkWSCnxhTFvom9Ptl0W8REA8XjGiD9wsZBecSNLQPq/djIiw==
X-Received: by 2002:a17:90a:d60f:b0:2fc:b40:339a with SMTP id
 98e67ed59e1d1-30151cd77f2mr1313007a91.10.1741920120852; 
 Thu, 13 Mar 2025 19:42:00 -0700 (PDT)
Received: from localhost ([1.146.21.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30153b994besm100471a91.34.2025.03.13.19.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 19:42:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Mar 2025 12:41:56 +1000
Message-Id: <D8FN5AAQ56G1.1BSTPDHV5IQBJ@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PULL 00/72] ppc-for-10.0-1 queue
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Thomas
 Huth" <thuth@redhat.com>, "Stefan Hajnoczi" <stefanha@gmail.com>
X-Mailer: aerc 0.19.0
References: <20250311125815.903177-1-npiggin@gmail.com>
 <CAJSP0QWLW+YwsLeJ1496Q8uT92E3wUDsOiVyzVFwrOFid3FUWA@mail.gmail.com>
 <71d0b4bf-7732-44f2-8796-f19eb2822958@redhat.com>
 <fff0b105-a317-4148-82d1-ac847a3fce6e@linaro.org>
In-Reply-To: <fff0b105-a317-4148-82d1-ac847a3fce6e@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Mar 13, 2025 at 8:49 PM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> On 13/3/25 07:13, Thomas Huth wrote:
>> On 13/03/2025 03.34, Stefan Hajnoczi wrote:
>>> On Tue, Mar 11, 2025 at 8:59=E2=80=AFPM Nicholas Piggin <npiggin@gmail.=
com>=20
>>> wrote:
>>>>
>>>> The following changes since commit=20
>>>> 825b96dbcee23d134b691fc75618b59c5f53da32:
>>>>
>>>> =C2=A0=C2=A0 Merge tag 'migration-20250310-pull-request' of https://gi=
tlab.com/=20
>>>> farosas/qemu into staging (2025-03-11 09:32:07 +0800)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>> =C2=A0=C2=A0 https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-10.=
0-1-20250311
>>>>
>>>> for you to fetch changes up to 0f17ae24b53eaab4bbe9cfab267c536e2f7fdbd=
7:
>>>>
>>>> =C2=A0=C2=A0 docs/system/ppc/amigang.rst: Update for NVRAM emulation=
=20
>>>> (2025-03-11 22:43:32 +1000)
>>>>
>>>> ----------------------------------------------------------------
>>>> * amigaone enhancements, NVRAM and kernel/initrd support
>>>> * Next round of XIVE group/crowd changes
>>>> * SPI updates for powernv
>>>> * Power10 2nd DAWR support for powernv and spapr
>>>> * powernv HOMER/OCC fixes and improvements for power management
>>>> * powernv PNOR support
>>>> * Big cleanup to move TCG code under ifdef or into its own file
>>>> * Update SLOF and skiboot ROMs
>>>> * Remove 405 boards and deprecate 405 CPU
>>>> * Add support for nested KVM "hostwide state" data.
>>>
>>> I fixed a CI failure on FreeBSD 14 hosts because of the __packed macro
>>> redefinition in hw/ppc/pnv_occ.c:
>>> https://gitlab.com/qemu-project/qemu/-/jobs/9388495246#L5857
>>>
>>> Here is my fix in the merge commit, if you prefer a different fix,
>>> please send a follow-up commit:
>>> diff --git i/hw/ppc/pnv_occ.c w/hw/ppc/pnv_occ.c
>>> index d9ce35a4d6..bda6b23ad3 100644
>>> --- i/hw/ppc/pnv_occ.c
>>> +++ w/hw/ppc/pnv_occ.c
>>> @@ -394,7 +394,9 @@ type_init(pnv_occ_register_types);
>>> =C2=A0 #define s64 int64_t
>>> =C2=A0 #define __be16 uint16_t
>>> =C2=A0 #define __be32 uint32_t
>>> +#ifndef __packed
>>> =C2=A0 #define __packed QEMU_PACKED
>>> +#endif /* !__packed */
>>=20
>> We should never define such macros in userspace - everything with two=20
>> underscores at the beginning is reserved for the system and the compiler=
=20
>> and must not be created by the userspace code.
>> Why doesn't this code use QEMU_PACKED directly instead?
>
> Similar question with __be16 / __be32.

Okay these were just because the type definition is taken from
skiboot firmware, so I added those defs just in the .c file to
make it a bit less change. It's not too much to change if that
is preferred.

Thanks,
Nick

