Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4581C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 20:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUX1n-0002A3-16; Wed, 25 Jun 2025 16:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uUX1g-00029M-IL
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 16:47:26 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uUX1d-0004ku-H8
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 16:47:22 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6070293103cso488196a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 13:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750884439; x=1751489239; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ChGxeV2s2rxLhbGNNk5igHv7YLLEZvhWSgpwwh0Vbrw=;
 b=Pk4rF4/VRS/1Y9NLb4RrRx+kRDwCuXYwI6Fi8dN5uI9TSss2BpDA8eGyCDK1BqvfQo
 D5LJlQGPIX8iPoORB7mBA6rmrmnlOnfUOcNlKA5K9csGZpUchBS93s+wHN0p5Xtxbtcp
 nsTxZy24o2/ZehSIt0RR35f/4mLhjqZyQjBYKD5y5b6ETlhOkmdSAPXi2uNFD/9EHRaJ
 BcfHWMT3zApQ2MaSZXMcpb4XTYWYbHmtjGgGhKs8TypoBuZykW//C9Q9VqzHZfFaeVsU
 Pnp6yal5cG6KLNYII3gkrH8Np/5t/EoU7J4HhSIVHRk/Y7FszSBi+ehVoYILR/77VcXB
 xmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750884439; x=1751489239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ChGxeV2s2rxLhbGNNk5igHv7YLLEZvhWSgpwwh0Vbrw=;
 b=X4NaHbUt2SdFaCcXZBhlMPAb0x2c1AFuS8iW0lZ0h+0Sj/28AgJJwmJvwgwhJRjg9U
 UGLXfKqktz8jewHZAAXxBpvzZ2pzQH4WdvtZtVy33PeMINIK5UkkkRExRTs/7Rp8MRn5
 t2zJNMRofNFnwl8glOIiI1iVNkDeO7CkIf30BE/qNXlD3vUIo+EO5rm2Ew9A4gA1ukNq
 Tmn+RJBg2G+J8rOZRjII1VyfaAodAkb1OX5J0b3hQHsCV7q09bWPaOA/HGjVZMEyrDAR
 L2mZFvF7+J/DJokJ8SnTiVvCCQ/ddIXTvzH51LCl035/HUtu6ab7exjs9o4fAPg9yo79
 xkVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW8/XUwXfrhRKOZvj2rMkkj81LCL4KBfd2oL47dnq7X7UubHg6dIbmGJqUOQvgFL6E622QRGMjpiCT@nongnu.org
X-Gm-Message-State: AOJu0Yz4P0a+G1jcB0ChbTZnbonq6T0aiQcoJXbYXKTubee1x2mP/M17
 z/m1eh+aOGvDG77HcDo3scaN1jaWYaSxO2w8kZcUcSWLwVF1cnkic35iS+pKPKKy7hiFtUj5k74
 cAj1vrsyeBnSrHu7ICbpwy7Fsg2eIMPU=
X-Gm-Gg: ASbGncsJPZIOV6X8PgCVTh4mxhNM+D3osdjFKa5ddXW3rzKGNE9QHr2iovgyJCvChy8
 IzDC3slFjx3+JtNEFro7gPSa4MNbHUDcEN4pShxXgrq/iCg9Rquohj50mXdoJOJvv1RZqxzZzkI
 PAGpLjUDvfb6zbbI3BWjjAed7+RIpfPKEGEfo4ZfRkvvpxVrEWoEgY
X-Google-Smtp-Source: AGHT+IGZDckePmo1xiqwJb3ZIOG0toOBtG/MobDu4RzYfztDvW/iIOKaCXp4Ke4V9KPp8z6F1s5jq8KpZvIRe1izGYY=
X-Received: by 2002:a05:6402:3514:b0:608:6754:ec67 with SMTP id
 4fb4d7f45d1cf-60c4dee1430mr3987031a12.30.1750884439207; Wed, 25 Jun 2025
 13:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250616092241.212898-1-armbru@redhat.com>
 <20250616092241.212898-4-armbru@redhat.com>
 <20250625150941-mutt-send-email-mst@kernel.org> <aFxePYi6bzLQ8UvN@redhat.com>
In-Reply-To: <aFxePYi6bzLQ8UvN@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 25 Jun 2025 16:47:06 -0400
X-Gm-Features: Ac12FXxL7uDrMRq8HJMznTH9vOXj18W6oireLSfdIYl2Knx1JTfCX0SfM32IGt4
Message-ID: <CAJSP0QXG_QD+ZWsRgpxSNyXYBooMkfX+gSOOFE8XWghv1E-htw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] docs: define policy forbidding use of AI code
 generators
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x529.google.com
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

On Wed, Jun 25, 2025 at 4:39=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
>
> Am 25.06.2025 um 21:16 hat Michael S. Tsirkin geschrieben:
> > On Mon, Jun 16, 2025 at 11:22:41AM +0200, Markus Armbruster wrote:
> > > From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > >
> > > There has been an explosion of interest in so called AI code
> > > generators. Thus far though, this is has not been matched by a broadl=
y
> > > accepted legal interpretation of the licensing implications for code
> > > generator outputs. While the vendors may claim there is no problem an=
d
> > > a free choice of license is possible, they have an inherent conflict
> > > of interest in promoting this interpretation. More broadly there is,
> > > as yet, no broad consensus on the licensing implications of code
> > > generators trained on inputs under a wide variety of licenses
> > >
> > > The DCO requires contributors to assert they have the right to
> > > contribute under the designated project license. Given the lack of
> > > consensus on the licensing of AI code generator output, it is not
> > > considered credible to assert compliance with the DCO clause (b) or (=
c)
> > > where a patch includes such generated code.
> > >
> > > This patch thus defines a policy that the QEMU project will currently
> > > not accept contributions where use of AI code generators is either
> > > known, or suspected.
> > >
> > > These are early days of AI-assisted software development. The legal
> > > questions will be resolved eventually. The tools will mature, and we
> > > can expect some to become safely usable in free software projects.
> > > The policy we set now must be for today, and be open to revision. It'=
s
> > > best to start strict and safe, then relax.
> > >
> > > Meanwhile requests for exceptions can also be considered on a case by
> > > case basis.
> > >
> > > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >
> > Sorry about only reacting now, was AFK.
> >
> > So one usecase that to me seems entirely valid, is refactoring.
> >
> > For example, change a function prototype, or a structure,
> > and have an LLM update all callers.
> >
> > The only part of the patch that is expressive is the
> > actual change, the rest is a technicality and has IMHO nothing to do wi=
th
> > copyright. LLMs can just do it with no hassle.
> >
> >
> > Can we soften this to only apply to expressive code?
> >
> > I feel a lot of cleanups would be enabled by this.
>
> Hasn't refactoring been a (deterministically) solved problem long before
> LLMs became capable to do the same with a good enough probability?

It's easier to describe a desired refactoring to an LLM in natural
language than to figure out the regexes, semantic patches, etc needed
for traditional refactoring tools.

Also, LLMs can perform higher level refactorings that might not be
supported by traditional tools. Things like "split this interface into
callbacks that take a Foo * argument and implement the callbacks for
both a.c and b.c".

I think what Daniel mentioned is a good guide: if it's something that
you think it copyrightable, then avoid it.

Stefan

