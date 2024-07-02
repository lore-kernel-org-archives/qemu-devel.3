Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D09C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 10:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOasU-0003s6-03; Tue, 02 Jul 2024 06:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOasR-0003ra-Pl
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:36:47 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOasP-0002xK-7c
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:36:47 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2eabd22d3f4so39599921fa.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 03:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1719916602; x=1720521402; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lTY5CeHxdbWkXXqc36Gg5V3+v6M1jyfNNgh2RY6/ROs=;
 b=CQYB0x8NDrub80tXRGqn2Ie4pKxQn0VSlvAVNZOQunyaDvW7v+P45lHc/FbikRKuXb
 fZoJSjZ9QAMs28HazPMlwwC05Rk9q6uZooweB6Sm9B3/KVodXlS5dIJ/CreVikW3WZ+X
 TJ9QhQYFQ9CILcPjgKAlOLO0ToGVh87vKGCLzCqH+nmKeRH0CRP9ZJP/rayJriv+bnG2
 AidVtaWjqMhC4Hcte6F6wFAuEHaT6cbe1JC6Abyq+MRQKaf2UZwXS53C8X6MDU0E05yn
 /KQFkJ08KZckgkV+VQLgdc6tjV6B2UWht+dZROda3pNei+CIDtlKySlqj/O2DF33lPGn
 ZzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719916602; x=1720521402;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lTY5CeHxdbWkXXqc36Gg5V3+v6M1jyfNNgh2RY6/ROs=;
 b=GsymFFhpW1M8QvHvWDMzNvcAx2hLXpfdqPxJ535ijkF6lzg22jfsb6uoCSKMYmCJgr
 R3PCDYEjnihFSRhoqF3FTTK4OwNB5p6HX/UooF2o7/N+PiNkRfRvmGkhrNfJdTCpRa+X
 D35kd5NXzkVob0sh4N8YRa6J9xdcXKN2WecHDSUmwBjMfD6gqsX0orR6iKlhnYzNKQpj
 vGNW003kSiUGFobJCyiYjgCkRIszfs8bKmyT3ybK0kuOlc3708Fww6v4mpJN2vVd2gUU
 HoDSsMU2zYVuR/qYLin222ghwZZyjLDO8neQwFsl25g7znefHeEIVM1rZhAvEJFEeLY/
 ohQg==
X-Gm-Message-State: AOJu0YxcOgFfX8zJ20bu9p95r1B2r9ASY5YLiEFDlYvSRWQ0Idxh0o58
 /G9hiCodaDaPtjqkq4Fatpfx31uPkT+uExgjtJGA4AJUmJ5O/0vWn8uT+ap5qH4=
X-Google-Smtp-Source: AGHT+IF9pN4FYKJSN2F9ScfnGK7mG2aFXQHgGYqEIlXHNpVrPhWdjCKq0CBkVuoNch+B9DFMxnH1Gg==
X-Received: by 2002:a2e:bc0d:0:b0:2ec:4428:b6fd with SMTP id
 38308e7fff4ca-2ee5e37e0ffmr66396201fa.9.1719916601708; 
 Tue, 02 Jul 2024 03:36:41 -0700 (PDT)
Received: from [192.168.7.249] ([145.40.191.116])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce3fedesm8450126a91.13.2024.07.02.03.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 03:36:41 -0700 (PDT)
Message-ID: <2d38b88449e9ecbec80bcbed35c741143811e9d3.camel@suse.com>
Subject: Re: [PATCH v3 10/15] docs/interop/firmware.json: Add igvm to
 FirmwareDevice
From: Roy Hopkins <roy.hopkins@suse.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P ."
 =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia
 Huck <cohuck@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 =?ISO-8859-1?Q?J=F6rg?= Roedel <jroedel@suse.com>
Date: Tue, 02 Jul 2024 11:36:30 +0100
In-Reply-To: <culz2lmg4fsdugz54vy56f52dgoywt5nfg6aycn7exsb3j3jrv@d75i6hhipkje>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <1bcb6bdfe74f96c7c2553ff25fb79f1def381f74.1718979106.git.roy.hopkins@suse.com>
 <culz2lmg4fsdugz54vy56f52dgoywt5nfg6aycn7exsb3j3jrv@d75i6hhipkje>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::233;
 envelope-from=roy.hopkins@suse.com; helo=mail-lj1-x233.google.com
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

On Thu, 2024-06-27 at 14:53 +0200, Stefano Garzarella wrote:
> On Fri, Jun 21, 2024 at 03:29:13PM GMT, Roy Hopkins wrote:
> > Create an enum entry within FirmwareDevice for 'igvm' to describe that
> > an IGVM file can be used to map firmware into memory as an alternative
> > to pre-existing firmware devices.
> >=20
> > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > ---
> > docs/interop/firmware.json | 9 ++++++++-
> > 1 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> > index 54a1fc6c10..9a9178606e 100644
> > --- a/docs/interop/firmware.json
> > +++ b/docs/interop/firmware.json
> > @@ -55,10 +55,17 @@
> > #
> > # @memory: The firmware is to be mapped into memory.
> > #
> > +# @igvm: The firmware is defined by a file conforming to the IGVM
> > +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 specification and mapped i=
nto memory according to directives
> > +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defined in the file. This =
is similar to @memory but may
> > +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 include additional process=
ing defined by the IGVM file
> > +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 including initial CPU stat=
e or population of metadata into
> > +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the guest address space.
>=20
> Should we add (Since: 9.1) ?
>=20
> I'm not sure about that, since I don't see it used much in docs/interop/
>=20
> Thanks,
> Stefano
>=20

I'll add it to the end of the @igvm description. Thanks.

> > +#
> > # Since: 3.0
> > ##
> > { 'enum' : 'FirmwareDevice',
> > -=C2=A0 'data' : [ 'flash', 'kernel', 'memory' ] }
> > +=C2=A0 'data' : [ 'flash', 'kernel', 'memory', 'igvm' ] }
> >=20
> > ##
> > # @FirmwareTarget:
> > --=20
> > 2.43.0
> >=20
>=20


