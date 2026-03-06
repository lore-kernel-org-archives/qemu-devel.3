Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A216BF01816
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyRXn-0004uq-UT; Fri, 06 Mar 2026 04:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vyRXU-0004tF-JI
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:32:18 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vyRXR-00025J-5m
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:32:07 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-483bd7354efso118097595e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 01:31:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772789512; cv=none;
 d=google.com; s=arc-20240605;
 b=eYYFxWa6+kcdpSgh+UCQcxM6TkbpXT0nNLwVtT1n9lrmPqDU+HOwQRi64FliQDI61i
 U4aspC16gYNmrha9BemIKLsdyOMAnBq4YOUNplBoTvp2dMzrMQkKN5569QTLTQE3fQZc
 K0W7MsogJlS+9TrHwh35czOSRGVWJ704LTuA7DRyqDBmsOES8qKNcQ52gXEGgkg53WhO
 MIsnr/DCJ919QMUa5CwHkwIRHFYq3TFsmlm5rr7yMhDuvyBQwV6NB/6GE1uQ4kUsgfm6
 yTI+zfSMqkU4tsNPBU+3rK8u21cskKFvpS0AqQ0X5oICGEDxI7tEXjs1pC6TCRsJIKUG
 Rk2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qvcGBQuS3QfzV0JdzUqqf1NGYvG1FrQLFPBmrjC0hQY=;
 fh=pwbqm79EF4bnzcNJxti/08VsKIG75t/tIteUZN/fgpw=;
 b=UB0YHlisaf130MYGZAzsaSPlKi7nmOgAbcEBP7rocA+11jvXk0JJFHSBgOrfeptr6Z
 4vURhcxmeUGcar/QMQDRzcviTAcn3924prlSLJw5x6DGPr3YXd+N+DZ3z2kFc4udL8bP
 hiqYm+adYcgx957Mpx1PR1xEqqN5h2NBWwnrWUgPEPuxTCVr5Zxv+rH2sOwtw/dm5ImK
 lSsuVzPzUwsOYxyd87YjYxnWk2XMsH9JOtZBwWBeG+xq86uaBwjvirO1Kjnjl0mnN5s6
 vfn33qwk1D0ZuEM/jseumQfB6dF5KbzGOoB/e5fsypbxk1uoXkEhwbvzaADdJXOYIDSA
 jeww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772789512; x=1773394312; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qvcGBQuS3QfzV0JdzUqqf1NGYvG1FrQLFPBmrjC0hQY=;
 b=jgh58OI43T5OkKdd92Kx5WbErRZaeT8nmoH32oaGvIDyn/pNGOjOBu98VBcvkqzNQV
 4r9EhXD/6QPIZtIY1amh4rE4vXr1gSY6wZUNIMwV7k/ygcEIC1/sGELrc2U8yqbwyePE
 HgXOLxNyYnygalJoNB9OLqSxgSVOe8nO6j3608dbiPku1cKAG1YPKJcGZK/gNMZtjPOW
 z84Z6Sio+0m2ODRlNtWnC57kuy6CaZngsi3K5XBj0rvEQSMjLfIxZYmK5k9VoTQ8uW8N
 zx2YeLs5+5FLdw5dBfOLU4+AJrAVeK+gcUUcWedFPVAsNO77sDemlrppkU42PxekrKzU
 ZIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772789512; x=1773394312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qvcGBQuS3QfzV0JdzUqqf1NGYvG1FrQLFPBmrjC0hQY=;
 b=DZQGW7swOu+2w+b2WQ37IkuzClwtgcS7ZlNRSAFSpdu8FQTyoOtKNQUSQkbF7QjUZq
 f5038p03b43XOs0XuooEnW0nOgfv64VuaAoxMPiveUBQaEoNA54TgMYZEE54QCYX1qrq
 CgrinR4We/muJ1KZFpchQtez72lxMP2hb68aLodizfQ49i51q818GBSwuBDCGTHO5IyU
 DG1AQOd+cbgRT54RuunfRp/ecdaqu9yo51BeFK3YYkTlKY+QEsrae2rHbtPfWT0o9gdf
 ajtrrf1ok7cQd5fdysF77Rh6ZVMnMA4H8WPVAj0RUBP75FyQj2hR9Wul5SKKSRzzlOcL
 KM/A==
X-Gm-Message-State: AOJu0YwkJYuKmNiRVnu31Yfu4Na9usSJLp6yW4aXbxOs9QCuyVU+j78h
 jMdKBcmyDIPYFRhj0LoVGbu+BlF5W+ka5iWBbhS8kJI9zVbNDhbTXP+dwhS38ZrNqWYvDtFYQ6u
 HA+2iX+e03MOEXAK0qGwpPfwptoXs1lF1srDhqGSpWg==
X-Gm-Gg: ATEYQzwQ7Bfv7rSl6Gzqj7mL9Ik/x8klbMkOfp4n3C/R8fEctuKlaAdowoMDZSjd1pl
 UwNSUhXl//5++X8AbuYyHKx4ZeeIuDTG/6jIkW40yC7OH4ktLzt5nvkkqZB4J8oZ6UCwOcUkS/6
 FcYjo7nNG5yEdUAff4dkwB9nq/0TCO+eoVAWzA7W287buifw6D1QxEw8KNjRz4xXEUEOthfjngg
 jnB++MiMq8SVz5cAVnnMnH+TWc1UjKaaGeyLwTreZ77FIKYwtZERmHNPcJrl2+ZKTOZ7T5GK8mY
 xJTTHv7+wVoN6ygqfRavNq4xwduoemBBuMFJNDNMbPu73Yr7sQ==
X-Received: by 2002:a05:600c:1551:b0:47e:e87f:4bba with SMTP id
 5b1f17b1804b1-4852696934emr22390385e9.29.1772789512440; Fri, 06 Mar 2026
 01:31:52 -0800 (PST)
MIME-Version: 1.0
References: <20260303-sme2-hvf-v6-0-b473702d8287@linaro.org>
 <20260303-sme2-hvf-v6-1-b473702d8287@linaro.org>
 <CAFEAcA8zTkc4pyHQKoDkTMhGPLQmxBaJS3bZiGRrPgux3rDLzw@mail.gmail.com>
In-Reply-To: <CAFEAcA8zTkc4pyHQKoDkTMhGPLQmxBaJS3bZiGRrPgux3rDLzw@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 6 Mar 2026 11:31:26 +0200
X-Gm-Features: AaiRm531CxY9a4swvztKYl0fEGNIqco6Qum_hqbWYxHto7dV761FAriOPA1jokY
Message-ID: <CAAjaMXbXdrW9N1xLMPxL9OmjLqti6A3rqAmYipu6OkdBY8JPNQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] hvf/arm: handle FEAT_SME2 migration
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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

On Fri, Mar 6, 2026 at 11:19=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 3 Mar 2026 at 07:42, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >
> > SME2 support adds the following state for HVF guests:
> >
> > - Vector registers Z0, ... , Z31 (introduced by FEAT_SVE but HVF does
> >   not support it)
> > - Predicate registers P0, .., P15 (also FEAT_SVE)
> > - ZA register
> > - ZT0 register
> > - PSTATE.{SM,ZA} bits (SVCR pseudo-register)
> > - SMPRI_EL1 which handles the PE's priority in the SMCU
> > - TPIDR2_EL0 the thread local ID register for SME
>
> Mohamed points out that this breaks the build when compiling
> with GCC (which I hadn't noticed because I happen to do my testing
> of target-arm with clang on Linux these days):

Oops. same here, I was using clang.


>
> > --- /dev/null
> > +++ b/target/arm/hvf/hvf_sme_stubs.h
> > @@ -0,0 +1,158 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +
> > +typedef int32_t hv_return_t;
> > +typedef uint64_t hv_vcpu_t;
>
>
> > +typedef __attribute__((ext_vector_type(64))) uint8_t hv_sme_zt0_uchar6=
4_t;
>
> The "ext_vector_type()" attribute is clang specific and gcc
> doesn't recognize it.
>
> Since we're defining all these types specifically because the system
> headers are not providing them and only for the prototypes, my
> preference would be to simply drop the attribute from this
> declaration:
>
> typedef uint8_t hv_sme_zt0_uchar64_t;
>
> Could somebody confirm that that works OK on the relevant macos
> configurations ?

I think this works. Do you want me to send a new revision?

>
> thanks
> -- PMM

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

