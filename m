Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85535C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7GBI-0004JG-Im; Thu, 17 Sep 2026 13:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7GBF-0004Fw-Gw
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:45:53 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7GBD-0002AZ-TA
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:45:53 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ccff31419so9503565e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 10:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789667150; x=1790271950; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WidEHgTxlK3+Y8ica2DT63uylQstSG3MoUmxmbfym+k=;
 b=zWIitNejcz2gJ3XKD6iahx63tJFfoyco3lCt605Pqg7Swo1e1QF1YYfbYUD4qoKIAm
 yBhfG/RL4dD+XGLIW3kIKPybBLWxn2cvysJmgKFnq8vaJJeZ7ztivafH7Z8/2YtZeN6T
 pZWHDaJTbxiCycS/OzT2+3KpYOxOBcWkYXxdlZu5RalkXLwRtbY78cw4Qfpt0B6Zy4qZ
 IgK4VrDHUk3lRZO+M/0hzmhZQowkm8DacM25FtwymtKfsLNX0kUf1jIgQS/Um0NP7G6d
 2kIk7h4/whGpsAQoSeHYKdVfI34ulFsOirfn8w+YtJ1AP22/QCw7nEL5SZ9OGDYqiJ5W
 xblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789667150; x=1790271950;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WidEHgTxlK3+Y8ica2DT63uylQstSG3MoUmxmbfym+k=;
 b=p2mt/7ylTGN+k4JGUHr/sT9nWavUPemwdY3OIFaKUTfAKbhnkHvkYd8BczuBUEW+fu
 tGThcqrUpxrtsh3XjUjasaP/dROaJCX9fYdUnM09AWD1w9aTyBD8wH1fgvf6fqfTjOX+
 yyWfRIJsIEY4aSNyKlInl8QSv5T1k0wJHEEccIlrQlotN6vVK50x3/9GotlejZdqNsbi
 J1Shtnv2LV/W3xTo9KOymfDRVkUAs2rJGNlqHrnvtTM0eslHqcj3dzKiaRTaL07CNSEg
 etTGLpwh99LJq1xBnCsurdt7CxTqQ4pi2ejJejWRRzdLU22vBwu/r8sTuiAxi1lyJLZ0
 enrA==
X-Gm-Message-State: AFuF++ngwGd3ObRYjo1pi9lT44sKliOIjgRCkDBpKycc8WkE0W0o9pT0
 v1Df3juqX2FFxxukWXyXl749wTn5meamcbmV/+CM0YebZnsOeuRpy4A46Lr2rUI60LA=
X-Gm-Gg: AYBFou2D43tLtJFrI1cA08A16bRmhPmK713TYBejurPe6qePTFYF1dTRwYzyzSWtTc6
 zlJ1pP8yPG4gm75s3HCoTlEI0Ra2dE312DvmiS6hr4OTC+5mfS5es7gCJWZi1paD2LzKjthNYad
 PO2p+FRfoDzz3IhDvbJLXCEvBwlQfwvugEX3+p7FD4FAoRzem5VjNl1z+nHGD0yzz2ZqfLnVJHE
 YzK8iJgHee2+igKRUgA8r1pdbd3pfCrArImRuXzHsUY0cJUkwtUBRdr0v/wbc7D4Kfmm5NkWUBh
 FCUh4TL/S0TgDmR3ibpsG13nnLl1xtXZF+mFV2DwdhDx6n20md+hgNdfvzWCWTQF25KgtaTHfvn
 Lv0Z5g9uNhqc/KuP4cIfTqPCtvtsNFPfMSJv7PwDeYzfRO6lEMp5JNHap8bQpiywD74w9tvPbSF
 W6QfU/tVOCC2jPUcKvPTB9iy8ImRsav19YnRPdsnPx1xLa38/cUg7Xvl9yCgHigU1FG4YmhUc=
X-Received: by 2002:a05:600c:8b86:b0:49c:fff9:f684 with SMTP id
 5b1f17b1804b1-49eb7320be4mr90447925e9.21.1789667149870; 
 Thu, 17 Sep 2026 10:45:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd227141sm109699905e9.2.2026.09.17.10.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:45:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CD2A85F872;
 Thu, 17 Sep 2026 18:45:47 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Helge Deller
 <deller@gmx.de>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  qemu-arm@nongnu.org,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Thomas Huth <th.huth+qemu@posteo.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>,  David Hildenbrand
 <david@kernel.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Song Gao
 <gaosong@loongson.cn>,  Warner Losh <imp@bsdimp.com>,  John Snow
 <jsnow@redhat.com>,  Eric Farman <farman@linux.ibm.com>,  Cornelia Huck
 <cohuck@redhat.com>,  qemu-s390x@nongnu.org,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>,  Brad Smith <brad@comstyle.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: Re: [PATCH v5 00/17] testing: various docker clean-ups post meson
 tcg conversion (pre-PR)
In-Reply-To: <c0c5cf55-b4ff-495b-babd-3a75fd991127@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Thu, 17 Sep 2026 10:20:12 -0700")
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
 <c0c5cf55-b4ff-495b-babd-3a75fd991127@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Thu, 17 Sep 2026 18:45:47 +0100
Message-ID: <87qzir7ovo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 9/17/2026 9:55 AM, Alex Benn=C3=A9e wrote:
>> This cleans up a few bits and pieces although doesn't totally solve
>> the issue of an apparent stall while meson builds the docker image.
>> However with these changes there should be no difference between the
>> meson build and the equivalent "make docker-image-foo" invocation.
>>=20
>> We also finally get rid of the ill-advised magic caching support in
>> docker.py.
>>=20
>> v5
>>  - fixup a bunch of rebase damage
>>  - swap out my ccache fix for Anders
>>  - rename revert to "configure: ensure it also honours container configu=
ration"
>>  - use Pierricks solution for avoid too many SKIPs while validating conf=
ig
>>
>
> It seems that this version removes patch:
> Revert "tests/tcg/meson.build: implement ./configure -cross-cc-* options"
>
> That's fine and correct, but we're missing two things:
> - cross-cc-cflags and prefix should be passed to config.mak also
> (similar to the merge for container options). Not strictly needed as I'm
> not sure anyone needs this "extra" flexibility for roms/vdso, but needed
> if we want to make sure we don't break anything for anyone.

The rom builds are outside the main makefile anyway so they just include
random bits as they want.

> - scripts/meson_buildoptions.sh update that was missing originally for
> those meson options.

We need to do something about it because at various times
"update-buildoptions" does and doesn't change things. Sometimes there
are more options than I've been messing with. It is super confusing.

>
> For the rest, it looks good and ready!
>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

