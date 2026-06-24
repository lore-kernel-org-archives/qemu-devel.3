Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2896CCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPuh-0007g1-Ol; Wed, 24 Jun 2026 11:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcPuf-0007fh-SS
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:53:17 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcPue-0000bC-3E
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:53:17 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-46cf972f281so222837f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 08:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782316394; x=1782921194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ZpPczxO2onEBhX7cgVjiZzCd0z2iIMUj2syRzJFcOg=;
 b=sENbT2Jc2taxV5KluMTmoS59mGmKN6pHnVh/HTHe+K/+wKOBhk+BQH4FGePj4htWgr
 Se236diSAW4+/vhi8t13JPIOSv0t6YoIKO6pUh0ot1d8VzLmSer4TWxbVSumT+UM80Ne
 Q8ZaR9evQf2TDBHq6E8b3ZPq1tqcH97Uadr4LUeR3PtXYBTL7qN1A+4ygki/WNFuxD88
 B0uJp6GbpIX7dUZ+bbRm4S+EBo21ewxmKXTYVJtiU4pPGHO9DpPjuiFfb2OyNytBPWni
 tVtArOCyRMDYQUGn6dVE46fQ6sB1kUSSo5WvI6/H6kNHk/kXbFdgNi/ul/xJbO1AmA3i
 2+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782316394; x=1782921194;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ZpPczxO2onEBhX7cgVjiZzCd0z2iIMUj2syRzJFcOg=;
 b=FG62khahiWP0Mcrm3K54WGT1+gzwdQvlGpieh9fdppdk3g9dK0oh+dl5V2ZoSus8XI
 8Wn7dfmsyDfO60LOKKzdEtA0DydH7Yjm0tubQ9kp+WlbmNaMe7yPE3xFXVfG8EmhJfG0
 wSLgZBDAxP+ZV/0DVX0xncipMknCpCIl3XnbjVJFyXMoK6D+8gZniXi2C27xqLKqX0kg
 Ynf91MgbfUwVRydcaOAP6ZUXEvz1hl++3vC25bqO8VA9TDBKHfLadUomOhZSaJ2EkhHp
 L4e+kFjMPCubP9J7pbxmj2Wp/tIQzejkspYCOybotT94HLOLzTSeMu4sHRSJy9L11c/F
 OONQ==
X-Gm-Message-State: AOJu0Yya6U5QFghm3en+j6w7vCtrdSL9U2rx1usUXZyRY2kGNe2POG1N
 HYdUQ2f9VRYdQ4GO3rrMyWnucNSCDzAd+7PQFrMZui2Fck882cR3voCXRII4tSgclyM=
X-Gm-Gg: AfdE7clgpAM/ZrupgHtWWozz1zums6MmjarFROWFjGbyjWs4oL3PvRrTN4dIc3baCql
 qqIlxgO+Fe5yO4mPufGiqhapgd4NcVcgUwUdHOdDVJeXCnSWOmLeJJ7Z7oyCmFYW7ROOVZ4QKsa
 mOS12o9jJSv9wo7igRU6HUkU7snAkzXQpeszvcBuLqopPz6F0TWPYFuHpwsT+/gEvEAvH8zJ2uM
 O0izvutFY+pYH0L5hPdRsQuYR8qIQYV4zqt7CWRJRqkcbcr30KNhUGv+hNwzS7ZbNBSq6+GRrCy
 omnezb2RN52m/7FZpkLJMyMsff9sH44HHbtDCAUch59QLDj8nFvuQydba3nH3tbsy1IkkhDwpbc
 CCXNMYbMurv+cH7xiXlujcP0sd9Sq0i5sZ6gVpZ7Ld0oVNAQWGyJsbJdx+tXs1vzRtDjKHiiBiw
 Xc32CMnWfvMld8
X-Received: by 2002:a05:6000:44d7:b0:460:2ee5:67b8 with SMTP id
 ffacd0b85a97d-46c07569d64mr4593194f8f.36.1782316393381; 
 Wed, 24 Jun 2026 08:53:13 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01c3bsm8633576f8f.10.2026.06.24.08.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 08:53:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E43CD5F807;
 Wed, 24 Jun 2026 16:53:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-arm@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 07/27] tests/tcg/meson.build: introduce cflags
In-Reply-To: <20260609214745.772536-8-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 9 Jun 2026 14:47:25 -0700")
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-8-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 24 Jun 2026 16:53:11 +0100
Message-ID: <87echwj5p4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> We add possibility to declare cflags for a given test. Since we want to
> preserve the uniqueness of test binaries, we prevent repeating those
> cflags later, for an existing binary.
>
> This ensures one executable =3D=3D one set of cflags, and if dev needs
> duplication, they can use a custom 'exe_name' to override this.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/meson.build | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index bb0184732fd..ad56fdf4ab5 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -13,6 +13,7 @@ tcg_tests =3D {}
>  #         'src_file': {
>  #           'exe_name': ['provide an alternative binary name'],
>  #           'test_name': ['provide an alternative test name'],
> +#           'cflags': ['cflags to compile test', ...],

additional cflags to compile test?

>  #         }
>  #       },
>  #       ...
> @@ -20,7 +21,8 @@ tcg_tests =3D {}
>  #   }
>  # }
>  #
> -# Every test executable, identified by 'exe_name' is built only once.
> +# Every test executable, identified by 'exe_name' is built only once, an=
d we
> +# ensure cflags are specified only once, on first declaration.
>  # Tests for a given src use the same executable by default, and their de=
finition
>  # is guaranteed to be unique also. They can be duplicated by setting 'te=
st_name'.
>  # Default name is derived from src if 'exe_name' and 'test_name' are omi=
tted.
> @@ -51,7 +53,7 @@ foreach target, plan: tcg_tests
>      foreach src, setup: t
>        # return a clear error if user mispell a setup entry
>        foreach key, _ : setup
> -        if key not in [
> +        if key not in ['cflags',
>                         'exe_name', 'test_name',
>                         ]
>            error('unknown tcg setup entry \'' + key + '\' for test ' + sr=
c)
> @@ -80,6 +82,15 @@ foreach target, plan: tcg_tests
>                'specify a different \'test_name\'')
>        endif
>=20=20
> +      cflags =3D []
> +      if 'cflags' in setup
> +        if exe_name in built_tests
> +          error('test ' + exe_name + ' was already built with cflags: ' +
> +                'remove cflags or set \'exe_name\' (if cflags are differ=
ent)')
> +        endif
> +        cflags =3D setup['cflags']
> +      endif
> +
>        # build executable if needed
>        if exe_name not in built_tests
>          exe =3D custom_target(exe_name,
> @@ -89,7 +100,7 @@ foreach target, plan: tcg_tests
>                                        '-MMD', '-MF', '@DEPFILE@',
>                                        '-Wall', '-Werror',
>                                        '-O0', '-g', '-fno-strict-aliasing=
',
> -                                      ],
> +                                      cflags],
>                              depfile: exe_name + '.d',
>                              output: exe_name + '.test',
>                              build_by_default: false)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

