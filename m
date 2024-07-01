Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FE8C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 14:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOI1V-0005pk-NJ; Mon, 01 Jul 2024 10:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOI1U-0005pO-UB
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:28:52 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sOI1Q-0003Jj-1a
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:28:52 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ebe6495aedso32167121fa.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1719844125; x=1720448925; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lUJVagTalZhFN7cM0756/4IvVpgIqBNNBaLua9aRKaQ=;
 b=F9C7HOPO0gqMOpga4vAa1hy4IDiuoYklfuzQVAwOOq2hgeGyvD2Ntw9XRy3dhSCZoZ
 tQXsqtteR/WV6oFMy+cMqaruRf9jU5EMaRkkfapXrkz5UpAWXqYgUMvD29NW5wQU2EuE
 RgyAVEHcA6mN8eu3GRB3tVWxoPWDDW7tSdQybL/ppGrvGb8aftoUisyB7MeswqIHEsIs
 /pmluO3CzqJUAb2qMRrPgyWq0YpnCiFPUchXSYweyvPuyHGD/3kBl59yFDZVJIldinSD
 0e84zmEqUktdy4e8GGERFehAfvI1E4O4tnV+OrZV2q64y9dgA4GSMsXbA8/Y+ZB57a0R
 b0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719844125; x=1720448925;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lUJVagTalZhFN7cM0756/4IvVpgIqBNNBaLua9aRKaQ=;
 b=pbHrQPqrNBWVDmxOJBv4Q7qc70RPmNutAkIX8RI/ei4P9NLaS26yMuIfqJTeM0A/lU
 1DPOTD3yTnC3QmuSN5S//4boWz0+UXT7BOdGM7m8+DDeBAEfVtMWzarfiUeqdHrHD4Vi
 ZhjL0ZnHFo1KPtsi1ODhnBenIssWCNZMfZ2YR5bJ6B0RjLGooi6ByPsjYznJt4lzu1S0
 M1MqK2/kW61yidQzh58X6QBUVpmpU5I1KtmUnDdSTkMdoRh21S972ao6AqdiFq1LY1jF
 AoQsxXCm0Q1AhNMqo2cfpPF2W8bb1QjjRfd0jjfUB4YOfYc+fbVYMT1/Fm0xVstKklQR
 Vz6g==
X-Gm-Message-State: AOJu0YwPbc0dlf3CCpS2iIx6PjKgPs3sX6mosLC0TqaTmCVSQNex1Tcv
 CXF6KpxdCRPL7/59p38ZcYLT48gtTxLfizWdAX/z1JqrlY52Xl8++c5M849UXTA=
X-Google-Smtp-Source: AGHT+IGxIPfJd0s05o/QAFfHQzSm2Axxh9PfyGiP3VVqySNrfT1KODfDFbW9Re19xyp1MGT/49tPzQ==
X-Received: by 2002:a05:651c:54a:b0:2ec:5172:dbbc with SMTP id
 38308e7fff4ca-2ee5e37e7acmr49481311fa.5.1719844125012; 
 Mon, 01 Jul 2024 07:28:45 -0700 (PDT)
Received: from [192.168.7.249] ([145.40.191.116])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70801e631f0sm6553922b3a.4.2024.07.01.07.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 07:28:44 -0700 (PDT)
Message-ID: <0508e81fab119d475fada003e2bfd682b011e237.camel@suse.com>
Subject: Re: [PATCH v3 09/15] docs/system: Add documentation on support for
 IGVM
From: Roy Hopkins <roy.hopkins@suse.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Alistair Francis
 <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>,  =?ISO-8859-1?Q?J=F6rg?= Roedel <jroedel@suse.com>
Date: Mon, 01 Jul 2024 15:28:34 +0100
In-Reply-To: <Znl-EjTr30PrNe4F@redhat.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <b666f4e30e8785de3dc944ac8dbefd0a23f49f5d.1718979106.git.roy.hopkins@suse.com>
 <Znl-EjTr30PrNe4F@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::236;
 envelope-from=roy.hopkins@suse.com; helo=mail-lj1-x236.google.com
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

On Mon, 2024-06-24 at 15:09 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Jun 21, 2024 at 03:29:12PM +0100, Roy Hopkins wrote:
> > IGVM support has been implemented for Confidential Guests that support
> > AMD SEV and AMD SEV-ES. Add some documentation that gives some
> > background on the IGVM format and how to use it to configure a
> > confidential guest.
> >=20
> > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > ---
> > =C2=A0docs/system/i386/amd-memory-encryption.rst |=C2=A0=C2=A0 2 +
> > =C2=A0docs/system/igvm.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 157 +++++++++++++++++++++
> > =C2=A0docs/system/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A03 files changed, 160 insertions(+)
> > =C2=A0create mode 100644 docs/system/igvm.rst
>=20
> > diff --git a/docs/system/igvm.rst b/docs/system/igvm.rst
> > new file mode 100644
> > index 0000000000..b6e544a508
> > --- /dev/null
> > +++ b/docs/system/igvm.rst
>=20
> > +Running a Confidential Guest configured using IGVM
> > +--------------------------------------------------
> > +
> > +To run a confidential guest configured with IGVM you need to add an
> > +``igvm-cfg`` object and refer to it from the ``-machine`` parameter:
> > +
> > +Example (for AMD SEV)::
> > +
> > +=C2=A0=C2=A0=C2=A0 qemu-system-x86_64 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <other parameters> \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -machine ...,confidential-g=
uest-support=3Dsev0,igvm-cfg=3Digvm0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -object sev-guest,id=3Dsev0=
,cbitpos=3D47,reduced-phys-bits=3D1 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -object igvm-cfg,id=3Digvm0=
,file=3D/path/to/guest.igvm
>=20
> Perhaps also illustrate use of your 'buildigvm' tool for creating
> the igvm file first, assuming that's the tool users are most likely
> to end up needing ?
>=20
>=20
> With regards,
> Daniel

I'm not sure it is the tool that _most_ people will end up using, but it is=
 a
good example and I'm not aware of many other examples of IGVM build tools.

IGVM is likely to be used to package=C2=A0guests with custom configuration
requirements, such as the COCONUT-SVSM usage where the SVSM kernel is packa=
ged
along with OVMF, configuration and other data required to launch a guest ru=
nning
with a range of privilege levels in a confidential virtual machine.

But for the purposes of testing and examples it makes sense to update the
documentation to describe how to use the 'buildigvm' tool so I'll update th=
e
docs.

Regards,
Roy

