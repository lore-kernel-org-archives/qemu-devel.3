Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175AECAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0d67-0006jF-T9; Mon, 22 Sep 2025 05:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0d5q-0005pA-On
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:44:24 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0d5g-0002BN-Gx
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:44:19 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3fc36b99e92so556805f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758534250; x=1759139050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jr95vMRsHHMubUlsg4+sKMganqm23DvV5j1sCOAb5Cw=;
 b=bJh421HVTekd/pWHXRqmxCs8H+PE/pBS9SGOvSKSVdSb7o/CUpEsHSWnCAcSzTPt+p
 bzKoaBXmOtdogBl8kLMMVN31/HD1UWmII+wWNVfoiXG9yYY3hJOYkZ+FpKVo1Fvzfpg5
 u6UMgJrTMSA0f000fOMg5w/sRpxu7n8O6EXQwzzr9B8gG/0N7IRUE6xAkjBvhaInxv/T
 qcG7nqnnUnMW0LBd93f+jbdPW1aYCwBCZqWxhpGZm29+Slz5vv+0G+rDW0FAooJvYI0l
 HfbJWmKVEOgfxK37RdK29YpFpMSR5OhsJi+m62VKzPgIv9jOxEhyVaWR1Brdy8B3wC85
 PKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758534250; x=1759139050;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jr95vMRsHHMubUlsg4+sKMganqm23DvV5j1sCOAb5Cw=;
 b=lyES3nG8TOahojzzWBBWHpkhwFRlXUJ6jQS4wmXU4N4ITTiDsaZFKeB4zjp2dcfY4y
 AmQ6aNN56cfJ/+VzMgkBGsnWz71qFFY/v8huuls89QAGQ0FTfzjUasJbCNtXplAwld3J
 S8ZhT0E8kxVds1BCKUF/PZNb4WgwHbi4rOn1dJP7eL0nbPnWLlc/VMj0x5aFsKQTPpjj
 V0LuIYffS/sR/PMvr5LWkleQEf2N/PyJNJs3qDkQGLHo9u9V00iM6mvwdn8MwWjtKjr2
 DNnE8yajHTRIS+RMxdd5Cly3s31cnIqgTQ2frV4L0e9fP5jyex9hC5Nza5lnIGKqx5tL
 rvjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfDkTwryWrfiWxk9iUbw5jXNZ+yBdlSpxANWwAF/py2YusFunX1fvjQBkIR0YQw2xuuKYlB+8KERAg@nongnu.org
X-Gm-Message-State: AOJu0Yyv5w6RSKjCWrXvDbthNgmYZWsHYbjVhoeX3YdBLvjQ4j1lBuVm
 5+7P+4goXwlH9I7OqmsXJNxcsTcsXAN8w4OZX9CLt4AqrwQbwf0FbE2ezOGgEoAiVHNGH1djaFU
 0zNHAdjI=
X-Gm-Gg: ASbGncswXoL9kzRTmi/PIiZUr8LIK9LbnQ+fJipJFVgZ1mmqQxiHEbs6ZqgsTNda2ZU
 rqj6yArVD9bXSPul8RwC+WVZZiHZcWFqYmXwhxz4RAT7XEvTD74iKgQp61SwpNVKL7fJEyvv+/h
 n6OADACYs1MJpT5Hu5lKAonnAC9u1hEZ3fwbzzeN64v4/ilg8Lmx9STFUgVDOmTgdmcz5NRNm4U
 huxS/o0fKWS7H5Wgjo3XbOYRGx3HUMRsiFZG0zG4wIignSA5hddstB0I5Ge8IAnPlaZEguCaqIU
 qfwDGmEuHy9JIJeLncS8eCnq6rHGdujk/G+YAdeznyQ8xMapjOG475XtdyjVWetUlMe0nKqWTdT
 fxmnyljTJtfYBqEdxOHMZxOM=
X-Google-Smtp-Source: AGHT+IFWMcO0aFxfnbp0F8M6DiOuKwB33EE5iAnntvaffzKJQ5g55iC4Byz6uJdCroYAuGkO7VlRCw==
X-Received: by 2002:a05:6000:4024:b0:3bd:13d6:6c21 with SMTP id
 ffacd0b85a97d-3edc9e2ba59mr16426216f8f.0.1758534250193; 
 Mon, 22 Sep 2025 02:44:10 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ef166e62e5sm14263140f8f.40.2025.09.22.02.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:44:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 697245F7B1;
 Mon, 22 Sep 2025 10:44:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,  Ed Maste <emaste@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,  Li-Wen Hsu <lwhsu@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>,  Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Kohei Tokunaga <ktokunaga.mail@gmail.com>,  Kyle
 Evans <kevans@freebsd.org>
Subject: Re: [PATCH 14/24] tests: move mips to debian-legacy-test-cross
In-Reply-To: <aNERkB5WhM4ePIHn@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 22 Sep 2025 10:06:24 +0100")
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-15-marcandre.lureau@redhat.com>
 <aM1m13xBnM9WU_E3@redhat.com>
 <CAMxuvayXSdVaz=i56T686oKpKf5gE4y6YaPgedPBKGQEPx0v8w@mail.gmail.com>
 <aNERkB5WhM4ePIHn@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 22 Sep 2025 10:44:08 +0100
Message-ID: <878qi6q0t3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Sep 22, 2025 at 12:38:09PM +0400, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>=20
>> On Fri, Sep 19, 2025 at 6:21=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com>
>> wrote:
>>=20
>> > On Fri, Sep 19, 2025 at 05:33:08PM +0400, marcandre.lureau@redhat.com
>> > wrote:
>> > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > >
>> > > We are updating debian which dropped support for it:
>> > >
>> > https://www.debian.org/releases/trixie/release-notes/issues.html#mips-=
architectures-removed
>> >
>> > If Debian 13 has dropped it, why aren't we just keeping the mips
>> > dockerfiles on 12 ?
>> >
>> > The debian-legacy-test-cross a manually written dockerfile that
>> > has almost none of our deps installed, and is still on 11 which
>> > is outside our support matrix now. So I don't think we should
>> > be expanding use of debian-legacy-test-cross, ideally it would
>> > be removed entirely.
>> >
>> >
>> debian-legacy-test-cross is for tests/tcg. Debian 11 supports more
>> architecture than 12 or 13..
>
> If there are architectures in 11 that can't be tested in 12,
> then from QEMU's POV that is now an untestable feature, since
> 11 is outside our support target and we don't want to be
> holding back our support platforms for this.
>
>> > > diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
>> > > index 6f98a91277..917ff4abfb 100755
>> > > --- a/tests/lcitool/refresh
>> > > +++ b/tests/lcitool/refresh
>> > > @@ -215,16 +215,6 @@ try:
>> > >                                              "x86_64-linux-user,"
>> > >
>> > "i386-softmmu,i386-linux-user"))
>> > >
>> > > -    generate_dockerfile("debian-mips64el-cross", "debian-12",
>> > > -                        cross=3D"mips64el",
>> > > -                        trailer=3Dcross_build("mips64el-linux-gnuab=
i64-",
>> > > -
>> > "mips64el-softmmu,mips64el-linux-user"))
>> > > -
>> > > -    generate_dockerfile("debian-mipsel-cross", "debian-12",
>> > > -                        cross=3D"mipsel",
>> > > -                        trailer=3Dcross_build("mipsel-linux-gnu-",
>> > > -
>> > "mipsel-softmmu,mipsel-linux-user"))
>> > > -
>> >
>> > I'm not seeing the need to remove these, when they could just
>> > stay on -12, when the next commit updates the other arches
>> > to -13.
>> >
>>=20
>> Indeed.. it depends how much we want to keep covering. We already don't
>> cover all qemu cross compilations. The question is do we want to keep
>> cross-compiling for soon unsupported arches?

Cross compiling QEMU depends on decent multi-arch support and indeed we
should deprecate it now so we can drop it when bookworm finally drops
out of LTS.

debian-legacy-test-cross is the held back version of
debian-all-test-cross which is a native build + the cross compilers for
check-tcg.


>>=20
>> @Benn=C3=A9e, Alex <alex.bennee@linaro.org> might know, thanks
>
> A feature remains fully supported for production use the while time it
> is marked as deprecated. Provided one of our current supported platforms
> has the ability to test it, there should be no change to our testing
> status of deprecated features. Given that -12 is still a supported
> platform we should continue to use that, and certainly not replace it
> with -11 which is an unsupported platform.
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

