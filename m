Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90758CD4F54
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 08:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQi9o-0004WE-Ik; Sat, 23 May 2026 04:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQi9m-0004Ve-8z
 for qemu-devel@nongnu.org; Sat, 23 May 2026 04:56:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQi9k-0001kT-BM
 for qemu-devel@nongnu.org; Sat, 23 May 2026 04:56:30 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4903997fcb5so25423275e9.2
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 01:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779526586; x=1780131386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6M/8l05AFbfgOIdA57LoyhfwfiKiF2lNHoBij0kWQYM=;
 b=Wsj2jo/Ut9IQXGpQxPPlntdcDQXnTleMY7wQ19h4qKxcG/lKeZdNyoXXRvM6xUM1pi
 iXg6pMzG+Vn3ORddXLt4wvFj0xnQgk21iCrinhuHxIKAog7y4Su9Y8l1AtLEKM4jrocN
 A2QeGNrSKwaEUGEixK3XeV7yPwcAIGUIpBRSBGy83ac2+WMpzMMyZFzKMTzc9mjKpu1X
 Av2Shz+ULXec5IVn4v3f/6gLBS4NtQFYKaswz5vIV3LPoMPLPXFw3+z/HaaLiV9FtD+t
 ntQIA8c4oIx/49E85ui/klL6VPg0M9LdT//TM26tCoOrUs7jKGl9K7U9p8q/dMSFpqRX
 I2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779526586; x=1780131386;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6M/8l05AFbfgOIdA57LoyhfwfiKiF2lNHoBij0kWQYM=;
 b=n9isuiVkYuv5XMrmRMsKABEtuViaZQDrlgeIyWXrfrqc0gyqZeBW1rAD6dJfFmX6tM
 oFkefiMghfF8v9OrlIWFxohOsblN0YFtUllYky/gkI1JBeGUE7EEcJJc8ml8z7QBjpEf
 YzO0q3WoJwZNNqCYzuanSo7S/ggJsNR75bW8Mj9wFzauANvByttXMLkwycecvwIx4mzb
 CfTY7thGch69zI8pzRcSmdsyY8d7gM22txfOqA9UkN1DZ+f+P5G0kBtFNrjr21GvKW5t
 jJhjRdd1xg5Uv09Q2m7cxE+HSzozFftnwjh6m9jh3teKKiGdrk4SHsurlmONZHT+ODds
 Bi4A==
X-Gm-Message-State: AOJu0YxPbGcSkdUvbxm5QOGJR78y+rZNOlldDnU+n6Jlu86oodSfjoOp
 dLjIXyFV60mVXiiB4fVwOJDyEN1MyrP+YIH7umYlqB/FrWT8BS2e1hLs5vXX2A6Om4Q=
X-Gm-Gg: Acq92OFKrwaz2YYK+LaYEYigz/trArOwpbH+JEbmzbtwFz49jcvHX9VYBiI16OmouJO
 29Rt+KNRXkDW4tvejwwT72eS56+nJUg4UsdI3ueoGSV4FpSj01/ANz59+dkjTpGL1qBvVcoUPCM
 CjH8Jo85z4T7aPGEEDnPnaohJS5c5AfJJ+cZmnXxJMhD7Iw/Zy+yH6kWae+jKzD1kPOITSbLGMH
 PT1ZVLYuknZn/HVKaKvCc2fvxQqTHLb1WdbAGSFwsOv5fiueMoHIRRToMmSobG1mExUpYQ+FXTb
 mk4jYXjaWRNWSn0z+nk3bDHNLjt/9J7MW1BzF0rFoMNsu6F2EhlH/llZRge5srZW/eM/EvO4hpI
 rkEpRsw9bRCwe4yFQ3S+y9ePJDkhB8CNN74lONAPXsYizYtk8PbLFWwUIjPlMsgrFecakxTt9dK
 jOnV+/Xe4OIF9BX/qtjv72NVy5OtelJifTXA==
X-Received: by 2002:a05:600c:c059:20b0:490:31e:d6fd with SMTP id
 5b1f17b1804b1-490426d3319mr79393095e9.25.1779526586395; 
 Sat, 23 May 2026 01:56:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490418c4497sm35370155e9.13.2026.05.23.01.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 01:56:25 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BFA645F7F1;
 Sat, 23 May 2026 09:56:24 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <th.huth+qemu@posteo.eu>,
 Song Gao <gaosong@loongson.cn>,  John Snow <jsnow@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Kyle Evans
 <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Cleber Rosa
 <crosa@redhat.com>,  Warner Losh <imp@bsdimp.com>,  Brad Smith
 <brad@comstyle.com>,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Max Filippov <jcmvbkbc@gmail.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,  Peter
 Maydell <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-arm@nongnu.org
Subject: Re: [PATCH v2 03/16] tests/Makefile.include: add binary dependency
 to run-tcg-tests-% rules
In-Reply-To: <093614fb-ced1-4b15-b1e1-5da755f87237@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Fri, 22 May 2026 12:44:07 -0700")
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-4-alex.bennee@linaro.org>
 <74e8bc86-cd81-43f9-b5cb-7e3de3bcd3d0@oss.qualcomm.com>
 <87tsrzl138.fsf@draig.linaro.org>
 <093614fb-ced1-4b15-b1e1-5da755f87237@oss.qualcomm.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Sat, 23 May 2026 09:56:24 +0100
Message-ID: <87cxymec7b.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

> On 5/22/2026 12:02 PM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> On 5/21/2026 6:17 AM, Alex Benn=C3=A9e wrote:
>>>> Explicitly set the appropriate QEMU binary as a dependency so we can
>>>> ensure they get built. This is especially important for MacOS which
>>>> otherwise only builds the unsigned binaries on a normal "make all"
>>>> run.
>>>>
>>>
>>> I'm not sure to see why it matters. tcg-tests don't make use of hvf, so
>>> unsigned binaries are plenty for it.
>>>
>>> Which other binary is this building that is not built by default?
>>>
>>> In general, if something is not included in "all" target, let's make
>>> sure it's included there (meson.build?) instead of adding a workaround
>>> here. Not only tests benefit this, but anyone doing a build on a
>>> platform that might have optional binaries not built by default.
>>=20
>> If you have a suggestion on how to make that work I'm all ears.
>>
>
> I would be happy to help, but I don't understand what the goal is. I
> have three questions that should help to provide a suggestion.
>
> Which exact test command do you run?

make check-tcg

>
> ```
> Explicitly set the appropriate QEMU binary as a dependency so we can
> ensure they get built.
> ```
> Aren't they built by all?

Apparently not.

> It seems to be a dependency, at least for check-tcg:
> .ninja-goals.check-tcg =3D all test-plugins
>
> ```
> This is especially important for MacOS which otherwise only builds the
> unsigned binaries on a normal "make all" run.
> ```
> Why do you need signed binaries for testing on MacOS (hvf?)?

In a previous iteration I made configure spit out the unsigned binaries
to config-target.mak but the request was to fix the dependencies
instead.

It all works on Linux so I'm not sure why MacOS is being so weird
because the meson emulators target mechanism should be the same.

> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

