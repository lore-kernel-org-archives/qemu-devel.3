Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4B6C282DE
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 02:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsusj-0000XX-7N; Thu, 13 Mar 2025 22:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tsush-0000XA-5S; Thu, 13 Mar 2025 22:34:39 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tsusf-0008AA-Ea; Thu, 13 Mar 2025 22:34:38 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ff4a4f901fso2782561a91.2; 
 Thu, 13 Mar 2025 19:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741919675; x=1742524475; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qzOBfJzO2aOdVHwBhNeh24Lhja0wtjzY4vYbx8HfR0Y=;
 b=LxXMrkOg1lnvtNtaHlEsGB8CvXaP05zjsd2b6mvZQqJHQgHQKPBE60iDRGMNwJ7uNo
 P5T6glO9zuGAmaNkGRSbFjR3Ws94D3p3dGaBLAsipYt+R8hYc0Yglj2f+L4IKxccLX9O
 9vya6frIUdguRWgXqdpPREjjZWZi1Vb7cQ56NAkBf1BGp492RaFZx6AuZXX7W/z+TLhQ
 RluBB6SR9of2Vh0JqS+/Qymlj1RgqzkYBxnEmv1/gQF1TP7oXP72bNvaCc3XDjGBxdmM
 eY/tGg1P5urdaMzgFwfFjdEFb3NLYAlOg+xojNPXLE99uwz5HyMnn2j0cp1xKQEDKn+a
 aJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741919675; x=1742524475;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qzOBfJzO2aOdVHwBhNeh24Lhja0wtjzY4vYbx8HfR0Y=;
 b=EC+zXLEKpvhx1U8l0O26gVASsgiqjWJdyK8ex/U3gLzkC8tyu1T5Mfkk1Yb8Kggzgl
 0S7fNJKpgWSVGddxQmBH8KLFW2d9gmMMIzB/EYA67ycnpN9kfiq6qC2PS3X2A1BBCcEG
 hvYBmppnkybW4lEGEmSHnULZW5JNy4Q2uHRBeXOZIs87mezFu0JI/s/r/zto0bvJPl6n
 wJepNIbqlygk3jPRJijWeY34SZA5zvU+sAy97VQi3qSPgyArq6yzQIElCW1//bXGebwF
 2ala1UvST0edr0+9ZepdaAs9c9hiMC2MxL82LSjX7wWyTfmNObGctS3YOXX7HrorCi5Y
 U7kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbm1E1JaK2LyV8OBf1adKMQDxC5Cq1f1eBavpHBxP+aP/GqSIx7Y8mRvElFO5zbBRmUVb5fzblQg==@nongnu.org
X-Gm-Message-State: AOJu0Ywjy5Blw3eEfenRbqCOipduVKPkamq0uGQhCtdhfsYNPABOr15I
 nhw3xgVjeNLgLLs7Hh+W7rwnv7/Axy6qpgLUDQU7rboqEdpsVQDENJbqplDI
X-Gm-Gg: ASbGnct+LTCvUUHjHsb8k3mEQC3pewdXm/yPJFkWvNcAEYuhVhYEB9U7+ATt08p0nSU
 +6htC5d0TVwk7VwPZ3V8eeMxd38GmiU30FI/2A8ucaeLwYygvx7s8M+sVBV3UiEz7/m2IPG5V47
 kOsqE3s9P9X5rfcEJCmFmT0MCMRaNn1GqABxQ0y1k8lvA+Zd8kufe38MA0fIlGV9cIpeNZE9Plf
 J6N+XkV+0p8A/LyRcCyoZ7LiiIUR4fyU7PVJTJ9oIztSqS9+SRp0JyUivXFtg1sK2aCrPdeoLA5
 xnYdsrR/SraXYDKjzqtQtBq+ioz3EwJuqKo=
X-Google-Smtp-Source: AGHT+IGRq6F+cBKUg0hWfqSHJUEahM9j9yoBp0UbqsEG9AUP1yJaMo6B1DaQYkgpg9Dw2SZ+G0vdZQ==
X-Received: by 2002:a17:90b:314b:b0:2f5:88bb:118 with SMTP id
 98e67ed59e1d1-30151d70cc3mr894520a91.22.1741919675184; 
 Thu, 13 Mar 2025 19:34:35 -0700 (PDT)
Received: from localhost ([1.146.21.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301539ed03fsm100700a91.16.2025.03.13.19.34.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 19:34:34 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Mar 2025 12:34:30 +1000
Message-Id: <D8FMZLDM9Q5N.BOM6TN7LP5WD@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
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

