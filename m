Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9534EC52D73
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 11:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc1O2-00060s-K2; Thu, 08 Aug 2024 07:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc1O1-0005zp-Ld
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:32:53 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc1Ny-0005Tn-Jt
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:32:53 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5a108354819so1116587a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723116767; x=1723721567; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YIWu3C/JDdG6r3+leXuVMQr5m0dQJuoBGnIJzNv643I=;
 b=xs9BHrTcYB1td4Ouyhbr0kHmjC6DZVZmcMaVZDClY+u9sXvKQCSXkWJiH4OTtgZfA/
 evWa6kgYTEgARDsqqCVY01j2rV3grEFJHNPalE+nhYPPOz29qPi+6A4Txv64xoDcRzlw
 UcUjvBq87UVNVG5eP99zjdiW00pXHvLqufpviEe9OQOjQ7e+GBB3RU00feOEki0Dgzlj
 YeLntk0y803Bz7h8u0ROO0swy7m98eiGX5WNXh2flWLgESBsqrggfBFJ0SgfvZHIEMV9
 RdNG7K7bEMeuu39NLXsQCaJmJ4/61yf6u/cCchieyDHZEIidFTGuHoeE6QXbVSkwBAXj
 b0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723116767; x=1723721567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YIWu3C/JDdG6r3+leXuVMQr5m0dQJuoBGnIJzNv643I=;
 b=iIEp/N8WFmgl2r1Zl1zXDodRKrTPqgix+CS1cxtP8b7U7655qLEodYZyy+oQHhIGB0
 3KHEberzagxRpJTr2n9kHQ7jnWb3NmOXfxp/kINhXzJ71+A9f1KcO/40KF8w2vvVnmuE
 kZXTV2ISCDTSaOQCuLin6nxdGLh3M6sCIvh//boxeHZWyzU3Q4yFakk9lPL6tC8STIe0
 M6LlvBKurOxDOgXUCTeFdiNpPr/geJ6yOhSKUL9nB+cUbtGiNtLEM5iAbYXMArCqGcm+
 jRO2+LX/TZd5WSjEL8XVm8K57W2Mrz//laFldLdPdHw9QEXupB5fjiT+vIbY7D2ax5/l
 7j1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4pP5P4nGuu+Qtq6AMJ1zGDOQXb34a7978GPK5STxmSSgBElcizWX5geg60EGElmwPKuePI4m0yMmDhB66rHzyD+z2loQ=
X-Gm-Message-State: AOJu0YxNvyj1EvSwG2dNVRqoX4R8pldWwMP/F2mAf1/h9oqolL+5J1J5
 2UFKdqhZpYIiYrV2FBJwKr17rXP0tAsXwKfcGTV1HCtLxFyXabgwUlGGhIsCzbFKp3K2DMFoGsL
 pqFK/73N2AD0Wh33XA5qyfg4g+XLh6RUcURM79A==
X-Google-Smtp-Source: AGHT+IEyZVhUCWzHf68tbOd/01ZWFZuhV4ubOhG3Kqn2sSGQbfoJ2RMIJ88kP3K56mW7nEXdnitwSOjG028fV1sSOBU=
X-Received: by 2002:a05:6402:1ed5:b0:5a7:464a:abd with SMTP id
 4fb4d7f45d1cf-5bbb23f6708mr1258451a12.30.1723116766879; Thu, 08 Aug 2024
 04:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-2-philmd@linaro.org>
 <f82397e9-3be4-49be-b291-5598acdaf39b@linaro.org>
 <CAFEAcA9emwsK07+itUzMxReOLG8gHaxNdDE8ymuwyuBfsoY2Pg@mail.gmail.com>
 <87bk23skhq.fsf@pond.sub.org>
 <CAFEAcA8J4i-81rOEHBpqbV=c4F26o6qd3Lg9dZV+BuNyZPGg7Q@mail.gmail.com>
 <87ed6z1j77.fsf@pond.sub.org>
 <CAFEAcA_=GYBGpbvfKMGsYrUKWgcTLrriBKd37jOVFV1YMfy8Mw@mail.gmail.com>
 <ZrSqsEedC3rmVbD9@redhat.com>
In-Reply-To: <ZrSqsEedC3rmVbD9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 12:32:35 +0100
Message-ID: <CAFEAcA-c7bYaWdOp0ShzUE83kKaYmqoH5DpW+EnU_sVzJgdu4A@mail.gmail.com>
Subject: Re: [RFC PATCH-for-9.1? 1/2] target/arm: Move
 qmp_query_gic_capabilities() to hw/intc/
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 8 Aug 2024 at 12:23, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> On Thu, Aug 08, 2024 at 11:15:17AM +0100, Peter Maydell wrote:
> > It's not possible to use KVM with that machine type, so the
> > question is a bit moot. (This also indicates that the
> > interface is not very helpful -- it purports to tell the
> > management layer whether it can use an accelerated in-kernel
> > GIC, but because it doesn't specifiy the board type there's
> > no way to provide an accurate answer. It would be useful
> > to know exactly what libvirt/etc actually use this for...)
>
> Libvirt uses this exclusively with the arm 'virt' machine type.
>
> If the user didn't express any GIC preference, then if KVM is in use,
> we'll pick the highest GIC version QEMU reports as supported.

You can get that without querying QEMU by asking for 'gic-version=3Dmax'
if you like.

> If TCG
> is in use we'll always pick v2, even if QEMU reports v3 is emulatable
> due to the v3 impl lacking MSI controller which we need for PCI-e

Our emulated GICv3 supports the ITS which has MSI support, so I'm not
sure what forcing GICv2 is getting you here. Looking at the linked
RHEL bugzilla bug, I suspect this is an out-of-date policy from before
we added the ITS emulation in 2021 (it's present by default
in virt-2.8 and later machine types). So that is something that
libvirt should update I think.

thanks
-- PMM

