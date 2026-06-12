Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110AFCD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY6y3-0007QO-Ah; Fri, 12 Jun 2026 14:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wY6y1-0007PT-7d
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 14:50:57 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wY6xz-0003Hm-1Z
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 14:50:56 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490b211ee6aso9490985e9.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781290253; x=1781895053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9d5XdG4nK+gC6Q3Lj8SelKF0sJUz9ob8Vfp1Hz7sKDY=;
 b=ARKB0T4HX4naOG/YR7BiIBicJltwp/+pgLBD1vLgQTsUBZYZwp7EHelI8QjdOP2Ikg
 XCUDsKeqpT9xOxLn2szXaQLMTXjcV5W1JZmTrjNPjftsaprnv9uZYSlYxr/UzBuRAVXT
 UF41qZB6KDEPLDwm7EObnla3rZAM9C89Yb8/tzCC2O9MG2wtV78xd2y1ad59RZSyIrnI
 xdnTr4fLTh27JEp8+dzop28p5zdgoOgHoO97hPaKYJ2D3qKihEwrxnWwsceKSeMDE4W9
 MzOU7OoWYYFEYy4f6+0Oqwwrk1xGOyzV8/sjHeWpWCbP1LZTQo98iVHH7t1U41ZMnrbj
 tkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781290253; x=1781895053;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9d5XdG4nK+gC6Q3Lj8SelKF0sJUz9ob8Vfp1Hz7sKDY=;
 b=IVGs4+pIYlnE7YLQCUxHUr3AJuI/aHHKFmllLd8Q+3+kvHhnsvBCskwYXUk+zSAz8p
 188wjg5pO/ST4cdF0+yLodCsudEEr2p1vKjtkntheeOz5UPv52aTYlUDjZGYRMluVMEw
 adel1Ap4RZjNv15dTAry2fGgZDK2bsPw0jjyuM6Junh9vI//qOCx7R1eEATqbh1veMBM
 wIGHI/EIi0Jm6qkb+CyMBsZ7BqVD92CPkLHjMqlExog+fKe+D0MIFtFB6t+95dYxZ8oy
 P9V/zgbAqLdlci4OExzu3MeEjW5It+j5KJTO7JTfL/JfLBbOmWfvIMquPFq+YtvwFS5E
 39kw==
X-Gm-Message-State: AOJu0YyaQiTO3230QVCDriJlddUSsJgGOhVrySyc+1/Q8C32WWYK/Ocl
 8wQVViyapgXNwV7+KPLu/3SV5cW+KGFAHy86I09pViiXELv5axnI9RWrgUwo9O3/ET4=
X-Gm-Gg: Acq92OGSydze0dT3kzegLORZpefCeZhvBx+fZ6NDZaE1hDVy2roOW769wqiI8evD8to
 Tm6++j5ZodQk0GigKQaOnvidGQf155BjLhzG/I6YAYiCWdZGk+zjFSrhIoMJNYpr6LtWsrH0UkY
 i9NP32Zzp7vTHbQ7TGAaJTNVXx4rquEPThYU0yJy9aUabA4FLiI5a3FSLKyBKo6xaXOxVfMJRrB
 mrXRKDRdcY578TFxoC9SgD9EF2z8S5PSfYV0KI99r0L4/e2GobkBUXCx4kZebrt/g1BuOaHeHrn
 FdtyaDNU8O2D2gVhBC+qtNoPEgjARFBNqhz+/7JJ9nG+1cmydfkDFYwGsSquUvPQLgJNY5YDB/l
 lM/BVA3UM6krGt5DQHHSBQioEsfsttjyw15mOSHQNR1ZDXg56yvlT8VeT1WDGuqGJcWz0dGCcZT
 IdJ/BZH711ljhrHN53IswgJ1A=
X-Received: by 2002:a05:600c:638d:b0:492:1e36:d16f with SMTP id
 5b1f17b1804b1-4921e36d1b4mr21725105e9.37.1781290252735; 
 Fri, 12 Jun 2026 11:50:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220345528sm9705825e9.8.2026.06.12.11.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:50:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DA3A85F814;
 Fri, 12 Jun 2026 19:50:50 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Alexander
 Graf <agraf@csgraf.de>,  Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,  qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v7 0/8] target/arm: fully model WFxT instructions for
 A-profile
In-Reply-To: <CAFEAcA8yNGiKeMpN_wgWtc5EnfjsnxSvG6an4-UjBf6XG+4Yvw@mail.gmail.com>
 (Peter Maydell's message of "Fri, 12 Jun 2026 18:46:48 +0100")
References: <20260529082948.363931-1-alex.bennee@linaro.org>
 <CAFEAcA94+mh_pigFDi+tEPRJ416fSWfxsQ1Lj8Byemug9kBp6w@mail.gmail.com>
 <87h5n7ekxw.fsf@draig.linaro.org>
 <CAFEAcA8yNGiKeMpN_wgWtc5EnfjsnxSvG6an4-UjBf6XG+4Yvw@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Fri, 12 Jun 2026 19:50:50 +0100
Message-ID: <87bjdfegol.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

> On Fri, 12 Jun 2026 at 18:18, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>> >>
>> >> This series fully models the behaviour of WFxT instructions. We
>> >> already had support for WFE for M-profile but we left off A-profile as
>> >> it has more potential sources of wake-ups. The main one is the event
>> >> stream which includes events from significant bits of the timer
>> >> ticking over.
>> >>
>> >> The refactoring from the previous iterations of the patch have now
>> >> been merged.
>> >>
>> >> I've dropped trying to fully model the global monitor in favour of
>> >> taking advantage of the architectural flexibility to have an IMPDEF
>> >> event wake up for any reason. We treat the setting of exclusive_addr
>> >> as such a reason because it indicates the current vCPU is in a ldstx
>> >> exclusive region and we don't want the guest to deadlock. This does m=
ean
>> >> the system won't sleep on WFE enabled locks but people shouldn't be
>> >> relying on QEMU to model real world sleep patterns anyway given the
>> >> efficiency of emulation compared to real HW.
>> >>
>> >> I've written a test case using kvm-unit-tests:
>> >>
>> >>   Message-ID: <20260527111822.1563679-1-alex.bennee@linaro.org>
>> >>   Date: Wed, 27 May 2026 12:18:21 +0100
>> >>   Subject: [kvm-unit-tests PATCH v2] arm: add wfx test case
>> >>   From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.=
org>
>> >>
>> >> All patches are now reviewed.
>> >
>> >
>> >
>> > Applied to target-arm.next, thanks.
>>
>> Is it too late to drop them? I've a fix for 2/8:
>
> That change is already in upstream git, so you'll need to
> send the fix as a standalone patch, I'm afraid.

No worries, I'll fix it up in the re-base.

>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

