Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F482D2E01B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 06:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3VF7-0007fs-55; Wed, 23 Oct 2024 02:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1t3VF4-0007fd-UX
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 02:53:15 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1t3VF2-0002if-7r
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 02:53:14 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so90940961fa.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 23:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1729666390; x=1730271190; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fv6QgOu8va+ffwNGIts6R8cvh0crxlmotSObVyl0d54=;
 b=CaiDj18TeVMeOBF4abDgRQVuc5oHJkyVHFIv2PGHqr/4SeUEfEO3RvXMMfVfS1MufK
 ZG4qN5A59iFJxfsOV1A+vAz6KoztnGnuahfIsCJvfxm5OSWSLa49GDHsHjna7MX+f28n
 EmWAi4wmc9px9K+hZeY26K2Em1DTrI1AVos5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729666390; x=1730271190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fv6QgOu8va+ffwNGIts6R8cvh0crxlmotSObVyl0d54=;
 b=ckJgPJJ89CRWcRulo76Yp/b+kK+W+kfurGowWyiU58L3/NeWWW2dqG0wzCVqv7Z46i
 a7fvd4/BNoe9b4WPIEJBEiHlj6Yly0lXNk7lTtiDLsEsfAC/OA/0q1jWiDxqb0U/k2Vr
 BVHiIDoAEhkdoJxFhzW5z0JGr6dfcPnnmBH1rlhec0JhabfUXLz0m13DQAVtQ8m3LUR1
 sefHqfraw4Y0GuUcxc6fTBoO6+PY0cHkU+JfNJAFOiN6ROYhxmDHJq4Z1hYw20WhQS91
 92ZKxHdGHwkS7OAmLKUn6uxhEuHNrGZWTJBPsQnoIeh6Otho0L+XQ0xx+3ojNnl8etdm
 0ybw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCNXcKJoAANom2ASqc/eGxAJQnVTDFtUjLSRV45Hq2f+H/QbVPOqpHlP9ZfjiiVMCPUOHJPIoEiIRZ@nongnu.org
X-Gm-Message-State: AOJu0YwNpyrhhmj/41w0/tMiHfDGQ1h50zb6KubSsOC5CWt1M8+ue9AU
 t+REAAJu0TeRTq57kR9l21KDnqQiEN6O/TuTqNl85JzprJ41AdUAiaRlNcSCOdz+GQj/AsmZOl6
 ejBQj9B2DawzUKaPAAUTj/gJk+n0=
X-Google-Smtp-Source: AGHT+IElASbpVuAKf2rGRXoAvFve9a98ikaqUS2Muyq8cMCCti7LHLZ6D1Tl9vUS2X1uNyNtdbVuqUc6O0EhtWGGgWo=
X-Received: by 2002:a05:6512:3b07:b0:52e:936e:a237 with SMTP id
 2adb3069b0e04-53b1a328288mr1264806e87.16.1729666389627; Tue, 22 Oct 2024
 23:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241011053825.361544-1-clg@redhat.com>
 <eff3385f-6d43-42e7-8b36-7225e2fee7df@redhat.com>
 <SI2PR06MB50412DF87611BDBC21003BF6FC452@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CACPK8XfB=tfSBnPVUjJgAR23W3GXS_hxMiamPJT=7qL5Pgw8zQ@mail.gmail.com>
 <f7a8c0ed-27d2-4a0b-af2a-30f427812896@redhat.com>
In-Reply-To: <f7a8c0ed-27d2-4a0b-af2a-30f427812896@redhat.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 23 Oct 2024 17:22:57 +1030
Message-ID: <CACPK8XdM-RrT4wJFEokD+mbYU_vus_Pwoq9kiUwpQbdM9WLVWA@mail.gmail.com>
Subject: Re: [PATCH v6] hw/misc/aspeed_hace: Fix SG Accumulative hashing
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "berrange@redhat.com" <berrange@redhat.com>, 
 "kris.conklin@seagate.com" <kris.conklin@seagate.com>, 
 "jonathan.henze@seagate.com" <jonathan.henze@seagate.com>, 
 "evan.burgess@seagate.com" <evan.burgess@seagate.com>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Alejandro Zeise <alejandro.zeise@seagate.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=joel.stan@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.169,
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

On Wed, 23 Oct 2024 at 02:35, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> On 10/22/24 13:54, Joel Stanley wrote:
> > On Wed, 16 Oct 2024 at 01:23, Jamin Lin <jamin_lin@aspeedtech.com> wrot=
e:
> >
> >> 3. Test HACE model with u-boot hash command
> >> a. load test file to address 83000000 via tftp
> >> ast# tftp 83000000 jamin_lin/32MB
> >> b. get sha256
> >> ast# hash sha256 83000000 2000000
> >> sha256 for 83000000 ... 84ffffff =3D=3D> 1ddcccdba742d762e2b8da0bceaf4=
778727c5eba54a24d7ae0c573c65414f736
> >> c. get sha384
> >> ast# hash sha384 83000000 2000000
> >> sha384 for 83000000 ... 84ffffff =3D=3D> 825d9b24bb797695545b3cbd2f373=
b9738627c7a1878e620415570a57c7faed77916d47084c954254f101fc0f10c0591
> >> d. get sha512
> >> ast# hash sha512 83000000 2000000
> >> sha512 for 83000000 ... 84ffffff =3D=3D> b5ae725b2dc1e521f48eae37dd82c=
3d5fc94f7acb5fff3dabf1caa4bb4b5bcfb498e7cc1fbaa97dda2664bff99f9f8e778f823e9=
5afaf76fbf0985181522e478
> >
> > I attempted this same test and noticed that the 'hash' command was not
> > using the hardware. You can see this by putting some printf or
> > breakpoint in eg hw/misc/aspeed_hace.c do_hash_operation. There's some
> > missing work on the u-boot side to move the "hash" command over to the
> > hash uclass, so it can be used to test this code path (or add support
> > for the old API to the hace driver).
> >
> > Separately, I attempted to test with u-boot by enabling hash
> > verification of the FIT image, and it fails to calculate the correct
> > SHA.
> >
> > I think to have any confidence that this model works, we need to add
> > some testing to qemu. I did this for the initial version of the model
> > in tests/qtest/aspeed_hace-test.c.
>
> There are "accumulative mode" tests in QEMU, which were added by commit
> e0c371a0d23b ("tests/qtest: Add test for Aspeed HACE accumulative mode")
> They pass today with this patch. Are you suggesting we should add more?

I was trying to find a test case that showed the behaviour was broken
before (segfault?) and fixed after, but haven't had any luck so far.

The tests pass before this patch, and they pass after it. By that
logic there's no problem merging this one:

Reviewed-by: Joel Stanley <joel@jms.id.au>

Someone (aspeed?) should take a todo to resolve the HACE situation in u-boo=
t.

Cheers,

Joel

