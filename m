Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B84D767FF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 12:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWZlk-0001mE-QU; Fri, 19 Dec 2025 07:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWZlb-0001lE-W6
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 07:39:33 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWZlZ-0000bJ-6q
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 07:39:30 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so12192155e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 04:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766147967; x=1766752767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgfOvasujEQMBBi68r1Qnh1VvF00SEWVX1g8UbdAHS8=;
 b=xB/3XYxXeJOWqlQL2TtpJ/OYOhOtz+EZQLpIruloC8YJ3alNA7notTNULhBwv9M57r
 1I1kXZZu/CfP8SVvxnoqiUK1SKFQXRPbJD500QjDSA5Htdytku4B6z2p1iZb9pgo1dOG
 gGMJOMyErTCZxJt82ocjsXvGvjUR+dc7h6t0KX69mtX7Xo7IeEXD9F7X7ubxkZN7atl2
 UN+koF5dWubJt3xa/fLv04NDnSLm7Vr4jcEBmJAkUtA+wLMTqylqVPMaRoCEQSDiIVSj
 oe15G9ItN5zSCI1kV4L82UjXKrFkKSVN9Qelb/sr4X/CY+FaycdkL65gXmMrbD8/dAhd
 rBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766147967; x=1766752767;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hgfOvasujEQMBBi68r1Qnh1VvF00SEWVX1g8UbdAHS8=;
 b=MeI/sN8Q/HGGpsqeh3Ld5XHQJnEwA1CrFp+0gZZdZBfNbYlO9DfvvGH4K9rrKXo77u
 vHfvteNlawg7hVxLGdV2Pv2ELk/Zd2ClxjbxAUYBkTliodq4EIeSwY1Eq9YvqVpZvrM7
 /z1QisTizuxPqy5tM/iq/ipzgkn3FyoatytX4heOIVjPZyGNOoKtSWKTwn74ACl8cbCi
 rIyZ5IXqVbYkEkVBD1C94vTl1WVLoKqBta+EhjLYuDXDqyZitouMH+xThNUPgMX9UjQT
 BCGIV2xC3A/iUa780vF5Ya5BZYTuWqYHcjXYP0V6iUxfMUZ4Iv4VWf2Jw3EVdfOs4TLp
 Hc5w==
X-Gm-Message-State: AOJu0YxseEEOdT6LCikO4y3oIdPX16vU922Fpo6w7MhOXlaYao5Y2LbQ
 VM+pT/+FUOLzaDffgfmQEEuJNU06fr/OtJjjqACmD7mdMe36C1GtnrYrd9H8EL57XpolrJ7ySU2
 jBRj+
X-Gm-Gg: AY/fxX62MpXVk/yF7Kz23lQDAxu0DXnfpAHs71k2UrP4dnUbvWzqGb7KyGamFiaHHIP
 4AooB7nGl8md3PRv8sC/hvFcC71zX9eQ/L1dX66kt9uz7tD+CJP/kRZCD3TRfsqk8DjST6kOhWM
 itW7cLr1E/OmL+9j/UhVNSPUNmIoWcn1T6k5tcsMpbhbso6fJCYQPh8lG6HhZXRAGclJGzGaMJJ
 UTiH1xZlxEQkpVhlxPsAvKnEl42BVDIc4XCntrM62CtiWFEO3FiFZobblqErwJvdgAqObR8A/zz
 c9T1ROB4EjK+ac/sQd18QMRRDn5IFbBJTVHbXD4DL6kD4RrdNB3bf7lkVneCs1NyALRRAwx1il8
 mH9du6/ykIFv25+hJYcLDjTU9PZ0w18UoLbrosgEo0Nj/Et2ooCAoiI7nQTycQtdBD2ciRJZP82
 8bBe0+4yAHtiA=
X-Google-Smtp-Source: AGHT+IHtjCuwtTZ6divdaRgKNucUpiG0O93oT5QeThxxj3cAAGieVv4Ac3x0ys57qtT4FJUr2c5RBQ==
X-Received: by 2002:a05:6000:40ce:b0:430:f2ee:b220 with SMTP id
 ffacd0b85a97d-4324e4cb94dmr3448115f8f.19.1766147966677; 
 Fri, 19 Dec 2025 04:39:26 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08efsm4968909f8f.29.2025.12.19.04.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 04:39:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 358F65F879;
 Fri, 19 Dec 2025 12:39:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 04/14] tests/tcg: honour the available QEMU binaries when
 running check-tcg
In-Reply-To: <CABgObfa=pNuy7WeEM0ziavDH6r8XhjakJYr3fzJtqSJpiK3CGw@mail.gmail.com>
 (Paolo Bonzini's message of "Thu, 18 Dec 2025 19:04:21 +0100")
References: <20251205164125.2122504-1-alex.bennee@linaro.org>
 <20251205164125.2122504-5-alex.bennee@linaro.org>
 <CABgObfa=pNuy7WeEM0ziavDH6r8XhjakJYr3fzJtqSJpiK3CGw@mail.gmail.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 19 Dec 2025 12:39:25 +0000
Message-ID: <87qzsq1w8y.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Fri, Dec 5, 2025 at 5:41=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
>>  if test "$tcg" =3D "enabled"; then
>> -    echo "TCG_TESTS_TARGETS=3D$tcg_tests_targets" >> $config_host_mak
>> +    echo "TCG_TESTS_WITH_COMPILERS=3D$tcg_tests_with_compilers" >> $con=
fig_host_mak
>>  fi
>>
>>  if test "$skip_meson" =3D no; then
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index d4dfbf3716d..7728098981d 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -37,6 +37,15 @@ export SRC_PATH
>>
>>  SPEED =3D quick
>>
>> +
>> +# TCG_TESTS_WITH_COMPILERS represents the test targets we have cross co=
mpiler
>> +# support for, CONFIGURED_TEST_TARGETS it what meson has finally
>> +# configured having rejected stuff we can't build.
>> +CONFIGURED_TCG_TARGETS=3D$(patsubst %-config-target.h, %, $(wildcard *-=
config-target.h))
>
> Please use something like
>
>    echo "TARGET_DIRS=3D$target_list" >> $config_host_mak
>
> instead.  Using $(wildcard) risks picking stale files.

Can we do that from meson? The problem is configure doesn't have enough
information to know what the final target_list is.

>
> Paolo

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

