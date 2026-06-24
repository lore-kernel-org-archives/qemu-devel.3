Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712F9CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRNg-0003ff-Et; Wed, 24 Jun 2026 13:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcRNY-0003ZL-R0
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:27:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcRNX-0001jj-37
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:27:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso9622885e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782322027; x=1782926827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yRVV7/eFbpbkCMGXUXw0L3SSwHfWwpq4buXl41AsEs=;
 b=S9+GgMUEWkq459nwjjahZLuYEETd9F4iVRhntcUKVCitFl1Vueo2Ligs/aPI1gNfEj
 ehQFxUR0FHw+t4V8k3/wQyLm34rEZ1iB5xnhz4RNK6ArpcjNCkHZ65KvQk75oaw2aEMW
 9iJyZQL6SpuXR6BIihUapDnGBk1GPQuvFG1Audsu2DCfvp20k9siBOtaw/Q0nPPYzuEx
 X+tICn16rwrs8MrAkJNS7TikExYYNARPW9GTuuH+U6z69PCJc4j2te9tXmoxjz+cO/bH
 YqF6GkrX7PHfthikW3GROPrFrGVtMd3m62YX4x5bslx88w49briQcnxM/1hgigjuZABU
 XV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782322027; x=1782926827;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4yRVV7/eFbpbkCMGXUXw0L3SSwHfWwpq4buXl41AsEs=;
 b=UzYTFzQ2sioclzFkgMnjpsBEiM9Yy0sz856VAG+GB8rdUimosj85kEjJKjctHn8/3V
 c8FABF0hmo7qTCipFcLvpI5QpVVjErMI5I8UQqa/+/LnK91rmS8gdMgx02rC8YqALQhU
 DteuyQm7H3pC/BDTa1K7QtS6E1usJZZVukFikWN6SQc7LPvBJuBmE8QBK3qjEhnKbA7k
 NN23THtH1QfgHk1AmYPcwJLbbNGnvcXluD0BZU1uvkg4r1TpP3fU1mHRtVDWQ6Y0gLes
 gGlBiQmslsfq12xjF3E2SQWIte2WLl1NBYHOrkm5Dp+FPsd7fgxvkaB87pZ+HBgOLMDU
 u5cg==
X-Gm-Message-State: AOJu0Yxdl0wDvZ4Cql2xQrwEJ+sxUp6VPfe1gbTrl5OualpSWlfFL8Eh
 tlB872cCB5npg6t+IISd3xoVtIHdJLsRLqrKhStInyotfUKd2VOhyN0w9QU62OuaVrE=
X-Gm-Gg: AfdE7ckMWeuv6UGkI0BVD09+Ht7ykjgVpTjJu0r6UMU2OjfevcK6IuyvRqFOEraq0KJ
 frkxMSRSz5JoyHENztTo9UqrceC8BkRB1MtB2b3lSS4qEXsPepAOdiwzBE/RItKAjF6I+LjbY1c
 L2HEnMVAgAWiuIAVe/ZaQXcR4jMAIthpLPvtvTS+ULsH4pTCkhddIkFtf82qbq+M0L4Iy+hZ4WD
 GDzgkDgEy9doqFptVC9bf1iBWiXKY/YIy06/Ao2z5buQCyJJBa1gIpI/Dj1ztJNaOdO1CoOp8Ey
 5vm6JIOs8CAJFo/UfuC/YR2uTvV4wc2oPTMhghed8i5c0sCXNJMXmmPexTPCPHJO1/UQ3xi/CvO
 4bOx492Q6VqBPoACitNt70iZ4bEeCz4wp7K8wYvdmgTedkpRYKCdb4Aawmg3dchLQBP+30G6odX
 AmKDypQAJ819WM/rbRwkQ/hOs=
X-Received: by 2002:a05:600c:46c3:b0:492:3214:cbe6 with SMTP id
 5b1f17b1804b1-49260873578mr55196115e9.23.1782322027376; 
 Wed, 24 Jun 2026 10:27:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926404ee91sm7360145e9.14.2026.06.24.10.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:27:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B40865F807;
 Wed, 24 Jun 2026 18:27:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-arm@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 05/27] tests/tcg/meson.build: introduce exe_name
In-Reply-To: <eac12939-fa27-4282-8913-1fbf463702a9@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Wed, 24 Jun 2026 10:01:12 -0700")
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-6-pierrick.bouvier@oss.qualcomm.com>
 <87pl1gj7vh.fsf@draig.linaro.org>
 <eac12939-fa27-4282-8913-1fbf463702a9@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 24 Jun 2026 18:27:05 +0100
Message-ID: <8733ybkfx2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On 6/24/2026 8:06 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> We add possibility to duplicate a test executable for a given source
>>> file. This is needed when different cflags need to be used (like
>>> vectorized vs non-vectorized for instance, like sve tests in aarch64).
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>  tests/tcg/meson.build | 17 +++++++++++++++--
>>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>>> index 72d1a9f8986..2c6d85c586a 100644
>>> --- a/tests/tcg/meson.build
>>> +++ b/tests/tcg/meson.build
>>> @@ -11,6 +11,7 @@ tcg_tests =3D {}
>>>  #     'tests': [
>>>  #       {
>>>  #         'src_file': {
>>> +#           'exe_name': ['provide an alternative binary name'],
>>>  #         }
>>>  #       },
>>>  #       ...
>>> @@ -18,10 +19,10 @@ tcg_tests =3D {}
>>>  #   }
>>>  # }
>>>  #
>>> -# Every test executable, is built only once.
>>> +# Every test executable, identified by 'exe_name' is built only once.
>>>  # Tests for a given src use the same executable by default, and their =
definition
>>>  # is guaranteed to be unique also.
>>> -# Default name is derived from src.
>>> +# Default name is derived from src if 'exe_name' is omitted.
>>>=20=20
>>>  # plugins come first, as we need to build the list
>>>  subdir('plugins')
>>> @@ -47,11 +48,23 @@ foreach target, plan: tcg_tests
>>>=20=20
>>>    foreach t : tests
>>>      foreach src, setup: t
>>> +      # return a clear error if user mispell a setup entry
>>> +      foreach key, _ : setup
>>> +        if key not in [
>>> +                       'exe_name',
>>> +                       ]
>>> +          error('unknown tcg setup entry \'' + key + '\' for test ' + =
src)
>>> +        endif
>>> +      endforeach
>>> +
>>>        # meson '/' operator drops left operand if right is an absolute =
path
>>>        src =3D folder / src
>>>        file =3D files(src)
>>>        test =3D fs.name(file)
>>>        exe_name =3D fs.stem(src)
>>> +      if 'exe_name' in setup
>>> +        exe_name =3D setup['exe_name']
>>> +      endif
>>>
>>=20
>> Would it be better to put exe_name =3D fs.stem(src) in an else leg?
>>
>
> The rest of the file follow the pattern
> var =3D default
> if (different)
>   var =3D other
>
> So better to stick with one pattern for consistency.

Sure - but the other meson files seem to follow the other pattern, e.g.:=20

if cpu not in supported_cpus
  host_arch =3D 'unknown'
else
  host_arch =3D cpu
endif


> It absolutely does not matter for "performance".
>
>> Anyway:
>>=20
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>>=20
>>>        exe_name =3D target + '-' + exe_name
>>>        test_name =3D exe_name
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

