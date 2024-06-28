Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86B0C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 10:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN9HV-00084z-SC; Fri, 28 Jun 2024 06:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sN9HU-00084d-D3
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 06:56:40 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sN9HR-0006NP-VT
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 06:56:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-424ad991c1cso5015055e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1719572194; x=1720176994; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RVvTwDt11IQ04NVruWZzdhynuBal70EZ3eKqx/s072A=;
 b=LUI9c5OmHUbLru2dv5LylwE9YdrRzAsDgMycgQvn47+8Txs1f1sZpF8qOMiWx8I2Nv
 +pUSeLcBfZgnHuIy2LO6Jd1VX3idcyAj4900HktHw1CQrcn2In5fIRNQfKiWChWMdBUH
 /FNCztL8w4D5jufNncpaeub0Nn9Js/uxP9uCj5Hvk3nmv9Htmv0SwwjKXgfVovreOmzJ
 uduyQCkd88/e3z+gujclviedCwJLWcKajU/G/OGgMRs60Cf5RzCoFJ1/FcxgrK8+kU++
 JJ1k/iqoTseyxsQNlLHjELXEXBZpNDZmoUZXXwRrQ62GAnGzQgLFLHL7wFLtGuD83AYD
 MtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719572194; x=1720176994;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RVvTwDt11IQ04NVruWZzdhynuBal70EZ3eKqx/s072A=;
 b=KozW1wJRQ/8yTSuGQTx5CiOFwc4puzXLhS4LMMrk3CeqD/w655c0ehra8Ips3EmhHs
 OKwSXKUQalnDqhm8o/V6K7YDf5VPnc2bJGissqo0JNdiaL7owBXx4nCs4tncg8Hjxi1E
 tfrFOBwd7TiIB+dY+3guC+Uwv3hEAHwTNQkVQv3Nrw70LZd3QsOA+XeJkfItyNTevs9/
 ucbKc45O9GAW+iIWzVQfNtBf2tPisF4I00JQfeqOjxplX4tI97w3QB9NeVD1S1e9JaW5
 SJcJmG7f78HnohL2jnz8SVbtZwzK5QF0seezS0FPjjxF/7pCROGaA4Nyu6ijzi1XKkoB
 Jv4A==
X-Gm-Message-State: AOJu0Yx9XPoePJ3wPjQ1CuTiDyraH9PiBR4tw4vxvsNblivSRfRjK3ud
 lBnHDh+DlcX1aiI+Gx6yM2J3f1rCc18cXL9yvdWc+ioXkWygDcimXhSTA4+Jwj0=
X-Google-Smtp-Source: AGHT+IGeOlHOuOkRuDxmzdTXvhaAzONd/tN3kMqgBxFM8/bp35sxN/FIs9sYd6GbnBOi+Iz41YpLUA==
X-Received: by 2002:a05:600c:3386:b0:424:aa35:9fb9 with SMTP id
 5b1f17b1804b1-424aa35a106mr76072935e9.2.1719572194582; 
 Fri, 28 Jun 2024 03:56:34 -0700 (PDT)
Received: from [192.168.7.249] ([145.40.191.116])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a32asm30120625e9.31.2024.06.28.03.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 03:56:34 -0700 (PDT)
Message-ID: <2d0405c573386b823636d805dc1a39e54dcf4ee1.camel@suse.com>
Subject: Re: [PATCH v3 00/15] Introduce support for IGVM files
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
Date: Fri, 28 Jun 2024 11:56:33 +0100
In-Reply-To: <Znl5p1vQYjSQi7Qk@redhat.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <Znl5p1vQYjSQi7Qk@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::329;
 envelope-from=roy.hopkins@suse.com; helo=mail-wm1-x329.google.com
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

On Mon, 2024-06-24 at 14:50 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Jun 21, 2024 at 03:29:03PM +0100, Roy Hopkins wrote:
> > Based-on: 02d9c38236
> >=20
> > Here is v3 of the set of patches to add support for IGVM files to QEMU.
> >=20
> > Firstly, apologies for the long gap between v2 and v3. This was due to =
a
> > number
> > of factors, but particularly holding back until SEV-SNP support landed =
in
> > QEMU
> > as well as for some changes to be merged in the upstream IGVM specifica=
tion
> > and
> > library. The delay meant that I could include the SEV-SNP IGVM changes =
that
> > I
> > had been separately maintaining for COCONUT-SVSM into this series, givi=
ng
> > full
> > support for the full range of SEV technologies.
> >=20
> > Thank-you to everyone who reviewed the previous set of patches [1]. I
> > have hopefully addressed all of the comments in those reviews. Some of =
these
> > changes required a reasonable amount of rework. Along with the inclusio=
n of
> > support for SEV-SNP, this has resulted in a fairly large set of differe=
nces
> > from
> > v2. This v3 patch series is also available on github: [2]
>=20
> snip
>=20
> FYI, I hit some compile problems reporting array bounds issues,
> with this posting. I'm using Fedora 40, which has gcc 14 in
> case that matters.
>=20

The reason I was not seeing this was because I included `--enable-debug` wh=
ich
apparently hides the problem.

There is technically a bounds issue with the function overflowing the end o=
f the
array for the TR and LDTR registers but, coincidently or not, it overflows =
into
the correct register storage meaning the code works correctly.

I've added a patch to fix this for v4.

>=20
> In file included from
> /var/home/berrange/src/virt/qemu/include/sysemu/kvm.h:214,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ../target/i386/sev.c:29:
> In function =E2=80=98cpu_x86_load_seg_cache=E2=80=99,
> =C2=A0=C2=A0=C2=A0 inlined from =E2=80=98sev_apply_cpu_context=E2=80=99 a=
t ../target/i386/sev.c:454:13:
> ../target/i386/cpu.h:2236:20: error: array subscript 6 is above array bou=
nds
> of =E2=80=98SegmentCache[6]=E2=80=99 [-Werror=3Darray-bounds=3D]
> =C2=A02236 |=C2=A0=C2=A0=C2=A0=C2=A0 sc =3D &env->segs[seg_reg];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ~~~~~~~~~^~~~~~~~~
> ../target/i386/cpu.h: In function =E2=80=98sev_apply_cpu_context=E2=80=99=
:
> ../target/i386/cpu.h:1682:18: note: while referencing =E2=80=98segs=E2=80=
=99
> =C2=A01682 |=C2=A0=C2=A0=C2=A0=C2=A0 SegmentCache segs[6]; /* selector va=
lues */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~
> In function =E2=80=98cpu_x86_load_seg_cache=E2=80=99,
> =C2=A0=C2=A0=C2=A0 inlined from =E2=80=98sev_apply_cpu_context=E2=80=99 a=
t ../target/i386/sev.c:454:13:
> ../target/i386/cpu.h:2236:20: error: array subscript 6 is above array bou=
nds
> of =E2=80=98SegmentCache[6]=E2=80=99 [-Werror=3Darray-bounds=3D]
> =C2=A02236 |=C2=A0=C2=A0=C2=A0=C2=A0 sc =3D &env->segs[seg_reg];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ~~~~~~~~~^~~~~~~~~
> ../target/i386/cpu.h: In function =E2=80=98sev_apply_cpu_context=E2=80=99=
:
> ../target/i386/cpu.h:1682:18: note: while referencing =E2=80=98segs=E2=80=
=99
> =C2=A01682 |=C2=A0=C2=A0=C2=A0=C2=A0 SegmentCache segs[6]; /* selector va=
lues */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~
> In function =E2=80=98cpu_x86_load_seg_cache=E2=80=99,
> =C2=A0=C2=A0=C2=A0 inlined from =E2=80=98sev_apply_cpu_context=E2=80=99 a=
t ../target/i386/sev.c:454:13:
> ../target/i386/cpu.h:2236:20: error: array subscript 6 is above array bou=
nds
> of =E2=80=98SegmentCache[6]=E2=80=99 [-Werror=3Darray-bounds=3D]
> =C2=A02236 |=C2=A0=C2=A0=C2=A0=C2=A0 sc =3D &env->segs[seg_reg];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ~~~~~~~~~^~~~~~~~~
> ../target/i386/cpu.h: In function =E2=80=98sev_apply_cpu_context=E2=80=99=
:
> ../target/i386/cpu.h:1682:18: note: while referencing =E2=80=98segs=E2=80=
=99
> =C2=A01682 |=C2=A0=C2=A0=C2=A0=C2=A0 SegmentCache segs[6]; /* selector va=
lues */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~
> ...cut many more similar warnings...
>=20
>=20
> With regards,
> Daniel


Regards,
Roy

