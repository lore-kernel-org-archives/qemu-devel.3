Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E320C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 12:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc370-0000Kp-2z; Mon, 19 Feb 2024 07:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rc36y-0000KR-Kn
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 07:51:08 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rc36w-0007ug-Qg
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 07:51:08 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55a5e7fa471so3950290a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 04:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708347064; x=1708951864; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLSBP78gt8LJQXQidrX/kh7Z6QEcHgLFfifzkPbImXc=;
 b=GQPMDnH3c+nEGVSeWcXtKBHubqwDIKX4Y3XCUcBJyOXqpIMVcBrIquPtiQdsC3Ea4j
 GmOAzLNGhJCBjR4GJ3qiFqpcWTZpdnq446vN3w2WvH/LJkFd1buBoXJNG2Ybc+Kz7AMw
 FgBQE31yYsEOdmXlPXub2UmLECqwPexlw09rylTDk7CC8OIeapAMZa9XeWVjpMhPOj+z
 9lsYkBg5yECsSSdFdchFlIzTrbxwSUhETC6EljEKYXKtoDneYJoxk+3nkEHebvu6UuXY
 9tFkgfy29F1lKpXjP0AP2R2WDq+vhVsy6MyG0C8Z+u3tuFe8E8Z12d1euPTCgOBmutZd
 ffvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708347064; x=1708951864;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mLSBP78gt8LJQXQidrX/kh7Z6QEcHgLFfifzkPbImXc=;
 b=F+eYUPsG2Grr8I7ITr8aH8bKlMT7OgCg3RV1fx0bwekV9rA8BvRhqRvNaXFubZl0CQ
 j47CelamrUhzNtN3jhY3Tu275AwC6uXPCm3KztnxrqdND5O8lfPkyGG3ODOjYzx3JZf2
 glLzSW/U3P7laFjDY51okClbkkCfoXRf+ZO1wzLsZQmahN+vQWaEWFXBGE6I7IW8Ll6l
 Dr4iCpzlRqNpVplXs9TutYp/UidU5lplRZd12xOpIidio0eq3vNdbstqQHxfvV65ChP+
 oO+1r3rGJjYEhCBqp87PS3GiWzJ7GKFnAfXUykXyM9zmLUuNa25/3q78E+dScZb98q0/
 9K7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk94hb7zZQfEMxMKRJkF8fUz4RbjKZTS+LYPIEfUElXFIWU6brolY5VucZGh3cEYbUHXJZ6Cyu0uTic+zs0M65Td0JKd4=
X-Gm-Message-State: AOJu0YzprcrFeDT0iA4BdivgglC8k5GnkzjXhkeKlMgmbu3wNMQiK0f7
 KEEkh9kPJISV2fNolHmJ7yXSfivM2/v/gdpyMQUlvRecbJRHjT00YzttLjhM9o/uxyglBSn0pQ/
 sDmPEMXgZ/vdxlIQ8LgSKNGPpIAbRfPMgx9KW8w==
X-Google-Smtp-Source: AGHT+IG0USLyesTYyw1rtvcdat9CeAShIp7+1XU755/h8VXxKbI4h8JuNqjq47VHOkRrr2JWE7ibsiT7IYJ8cmTS098=
X-Received: by 2002:a05:6402:6da:b0:564:7a2c:ea56 with SMTP id
 n26-20020a05640206da00b005647a2cea56mr1712700edy.31.1708347064268; Mon, 19
 Feb 2024 04:51:04 -0800 (PST)
MIME-Version: 1.0
References: <20240207005403.242235-1-peterx@redhat.com>
 <20240207005403.242235-2-peterx@redhat.com>
 <13862227-d782-46fe-b10f-94587c74745e@redhat.com>
In-Reply-To: <13862227-d782-46fe-b10f-94587c74745e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Feb 2024 12:50:51 +0000
Message-ID: <CAFEAcA-AVjn5JdG+6eBd69o5BiJjmA1G6i4F2wVPSmRSw-X=Yg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tests/migration-test: Stick with gicv3 in aarch64
 test
To: Thomas Huth <thuth@redhat.com>
Cc: peterx@redhat.com, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Sebastian Ott <sebott@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 19 Feb 2024 at 11:54, Thomas Huth <thuth@redhat.com> wrote:
>
> On 07/02/2024 01.54, peterx@redhat.com wrote:
> > From: Peter Xu <peterx@redhat.com>
> >
> > Recently we introduced cross-binary migration test.  It's always wanted
> > that migration-test uses stable guest ABI for both QEMU binaries in thi=
s
> > case, so that both QEMU binaries will be compatible on the migration
> > stream with the cmdline specified.
> >
> > Switch to a static gic version "3" rather than using version "max", so =
that
> > GIC should be stable now across any future QEMU binaries for migration-=
test.
> >
> > Here the version can actually be anything as long as the ABI is stable.=
  We
> > choose "3" because it's the majority of what we already use in QEMU whi=
le
> > still new enough: "git grep gic-version=3D3" shows 6 hit, while version=
 4 has
> > no direct user yet besides "max".
> >
> > Note that even with this change, aarch64 won't be able to work yet with
> > migration cross binary test, but then the only missing piece will be th=
e
> > stable CPU model.
> >
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   tests/qtest/migration-test.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.=
c
> > index 7675519cfa..8a5bb1752e 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -819,7 +819,7 @@ static int test_migrate_start(QTestState **from, QT=
estState **to,
> >       } else if (strcmp(arch, "aarch64") =3D=3D 0) {
> >           memory_size =3D "150M";
> >           machine_alias =3D "virt";
> > -        machine_opts =3D "gic-version=3Dmax";
> > +        machine_opts =3D "gic-version=3D3";
> >           arch_opts =3D g_strdup_printf("-cpu max -kernel %s", bootpath=
);
> >           start_address =3D ARM_TEST_MEM_START;
> >           end_address =3D ARM_TEST_MEM_END;
>
> Looks like the migration test now fails on aarch64 when "configure" has b=
een
> run with "--without-default-devices", since that disables the gicv3 in th=
e
> binary ... is there a way to check whether the gicv3 is available, and us=
e
> "=3Dmax" instead if it is not?

A QEMU for AArch64 with no GICv3 is of very little practical use,
so I'm not sure it makes sense to allow users to build one like that.
(I'm also a little surprised that it worked with 'max', because
without a GICv3 it would try to fall back to GICv2, and if we're
going to allow users to compile-time disable one of the GICs then
we should definitely allow them to choose to not build GICv2.)

I think I would go for disabling the migration test entirely if
the build doesn't include the GICv3.

thanks
-- PMM

