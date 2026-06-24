Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41018CDB47C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcKqY-0006j9-UK; Wed, 24 Jun 2026 06:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcKqW-0006iR-L7
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:28:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcKqU-00077K-Sv
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:28:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49241896317so3861115e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 03:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782296916; x=1782901716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NzEtnUwLamRHMHtQXPitkpxP2yQEJDMokR1kTzHs1kI=;
 b=HC7X4g3awx/JObpgQZY5uXAYjgJNHe7wlJCVdD82RGA5jOevq6nF6AASIQO9UF93K/
 h8wacSdAaQSDvz2LmuDx00ED0niBntdDOIwVDuAQ2HMgHU9b3Iv2FZakZkazg3siHhwz
 n+bveGboDuRJDeml9TiO57dYNg4j/+TovtWeBeGBs2fhGuLsNOtP1bTVtKWOlvurEqSD
 mS2Ywd6+yD9kmgNMUfGeLrbFRdBnuC0/fCiN+UWu8k5kfF+i7x3GYTsBcvFFH9a2qI/N
 lPe8OfmyTPLHM5boMSrS8zPOl7uZHs3XhH4IOk+db6ouqw0zhp4qWQlqIHkL0W/1p0YB
 51tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782296916; x=1782901716;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NzEtnUwLamRHMHtQXPitkpxP2yQEJDMokR1kTzHs1kI=;
 b=mv49cKDXAC9HzmlOADF6gPRlL/4MLRgZLaSpmwtMVTG+ZcHuSqfLwFN0PFLJ28FZMb
 /V54jTDTy3PPg9aB2CxCWIL2iMsfDcJHyl9dcmWsTBvY571UvsxMNhZ1FU47CBUomUbI
 ERPn0xFeZOtuR14x13rHkmqNSN8Q9x0X9KNwt0miNqOD8q72bcLFCN8HifOybG5DWc26
 l0Dcx1jB0GCRxBznoBal61hZaReneGtO4xtI3zUhnIWYNDsluPH4LuM4h2cZms9lBxf4
 MbDIq/fWwByLUHPeU+CkBUkJTNkwdVVk+PckgFU1Mpc+jiN8ALYjygYHiRB+MW0I19Ai
 Y4xg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iX5kMrzPN7ImUq3MSaRn/5kdK+hmmYhPLjwg2S6P7tnBv0f4a3OBRoVWbzJ6QgXb9fS/bxepwQN7Z@nongnu.org
X-Gm-Message-State: AOJu0YzkJLeHmIlfeX0MsKh34oI0pHYyWdED4GgL5woWth8Nc1lUHaLd
 /KcbA5/xb1bqx0qYZl6nRj7vG7wja3hYxszj58a8UHChsUaEg+MS35S7U/buf7eGOmM=
X-Gm-Gg: AfdE7clA3ID69tEYTicCRIMSBhHL4U8HyVvjooX9NXzrkG7IhZyyfOefwebOuAoUGfc
 ms8IB5/EcNJ7tkguotiVN7n5EmKzEuPb6BUPT9fEVEunHkM7JG6CebWM8nqeFl3k73bwEoy1MfF
 ll7aZPJS50qKY3i8iM8H/SKnqXwJgTX4QCqjf0rFPXNblX+xsTtSn3JHETrOq9rUD6Ozqf+LCaG
 F+o2uIskpxaEPBptsDbhkd8wVRiYjZLIO0y9ZnKId92vFDEr0Ge3FyX5FqHNNcr7nmeaTdPEP14
 AkO56PIulCXAORT3O/3GhTimQMC4nct9jJJ0pxibmM5Zm5coYqL6rjp1GBvpEEDhJW2D8OD3Q3r
 6101Rtom8OXI+fVxY6Tsa6+orTuOwYBnG3CuTT17GElGfdfFwyRycckvckwn0a1Hs9D6lHIk5D7
 yxHwYKKeAvu7Ce
X-Received: by 2002:a05:600c:c04f:b0:492:348:ba08 with SMTP id
 5b1f17b1804b1-4926084d6f6mr26999315e9.16.1782296916352; 
 Wed, 24 Jun 2026 03:28:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494496cdsm330339785e9.10.2026.06.24.03.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 03:28:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B157D5F803;
 Wed, 24 Jun 2026 11:28:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Linisha
 <linisha232@gmail.com>,  qemu-devel@nongnu.org,  pbonzini@redhat.com,
 mjt@tls.msk.ru,  philmd@mailo.com
Subject: Re: [PATCH] docs/system: clarify pflash0 and pflash1 are virt-only
 options
In-Reply-To: <CAFEAcA9GSZXV5z=KDMLvM7enC1EqHwBt--=YOYb8HW6m=EHnqQ@mail.gmail.com>
 (Peter Maydell's message of "Wed, 24 Jun 2026 09:47:54 +0100")
References: <20260623205839.1294-1-linisha232@gmail.com>
 <ajuD4L_ZDEg8TI2R@redhat.com>
 <CAFEAcA9GSZXV5z=KDMLvM7enC1EqHwBt--=YOYb8HW6m=EHnqQ@mail.gmail.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 24 Jun 2026 11:28:34 +0100
Message-ID: <87v7b8kzal.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 24 Jun 2026 at 08:15, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>>
>> On Wed, Jun 24, 2026 at 02:28:39AM +0530, Linisha wrote:
>> > The pflash0 and pflash1 machine options shown in the Aarch64 virt
>> > example are only available for virt machine types on Arm, RISC-V,
>> > and LoongArch architectures. Add a note to clarify this for users
>> > who may try these options on x86 machines and be confused when
>> > they are not available.
>> >
>> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3254
>> > Signed-off-by: Linisha <linisha232@gmail.com>
>> > ---
>> >  docs/system/introduction.rst | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/docs/system/introduction.rst b/docs/system/introduction.r=
st
>> > index bec7291e47..0c400aefb6 100644
>> > --- a/docs/system/introduction.rst
>> > +++ b/docs/system/introduction.rst
>> > @@ -158,6 +158,12 @@ virtualisation so we can use KVM inside the emula=
ted guest. As the
>> >  ``virt`` machine comes with some built in pflash devices we give them
>> >  names so we can override the defaults later.
>> >
>> > +.. note::
>> > +   The ``pflash0`` and ``pflash1`` machine options are specific to the
>> > +   ``virt`` machine type on Arm, RISC-V, and LoongArch architectures.
>> > +   They are not available on x86 machines, which use ``-bios`` or
>> > +   ``-pflash`` for firmware instead.
>>
>> No this is wrong.
>>
>> The pflash0 and pflash1 properties apply to x86 pc & q35 machines too.
>>
>> -pflash is a legacy syntax which remaps to pflash0 and pflash1 internall=
y,
>> but also applies to other machines which don't use the new pflash0/pflas=
h1
>> properties.
>
> I think it is probably worth having something in the intro text that
> makes the point that for QEMU all architectures and machines are
> potentially different, and that options and command lines that work
> on for example an x86 PC machine will not necessarily work on
> an Arm machine, and so on. But we should do that as a kind of
> general warning somewhere near the start.

That was the intention with the wording:

  QEMU provides a rich and complex API which can be overwhelming to
  understand. While some architectures can boot something with just a
  disk image, those examples elide a lot of details with defaults that
  may not be optimal for modern systems.

  For a non-x86 system where we emulate a broad range of machine types,
  the command lines are generally more explicit in defining the machine
  and boot behaviour.

but it could probably be improved. Aside from working mostly on Arm I
chose the example because the default PC command lines are very prone to
using the old legacy shortcuts.

>
> The bug report notes that "./build/x86/qemu-system-x86_64 -M pc,help"
> does not list the pflash0 and pflash1 options. I think this is because
> we set these up as alias properties on the actual flash device object
> in pc_pflash_create(), so they don't exist as class properties that
> "help" can introspect on.
>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

