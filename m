Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1950CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 16:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU5Iq-0006nJ-06; Mon, 01 Jun 2026 12:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU5IT-0006fr-4Q
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 12:15:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU5IQ-00025u-2S
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 12:15:23 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490af320e2aso4722095e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780330520; x=1780935320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k3AhTnSj0cwgh2xQrOvRyEf14LO6K+Xsg02DkgNzXP8=;
 b=Dz5bKT4L2Nf2k9s1kNEND5BXt3xyw5jU+GeDECsn+qy2YvlYtXOT0CTSqnnq3wP3Rh
 qaa877dNsc2/hR/5+IMhFAbHpPWknGmMk7Ob5WwhvYsCqF4hVl84Po1DTiACrWch6Lw6
 MYqnlOLOsHtUdz1b5E0c0vHKb+QnKjDsjz1RaJV71rQ4nw24LEY7jpzGV5sOQGo7vkpA
 rRzwdy48sAho7+c63Bz7wh+iQelKvZAw+iIxGbBWU9zHLtEYwPN+EK8x40i/HeoNU/1a
 y6S5qpRe8ftYbkxuoah3VdfUMiNv7OAGnDMvudp7rj8luv0fTOY0H/VkPKlHhgjYJ/jm
 pP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780330520; x=1780935320;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k3AhTnSj0cwgh2xQrOvRyEf14LO6K+Xsg02DkgNzXP8=;
 b=HY/3S1jCVjMGwfKo5+F0bAvBFITdF+77h9Qs++1Qlvl2TCm6jd7qDkrW3PKkKHN9B5
 ul9kF0KzE3/quMRdyG1Ni20dCTZ4UU0kzaucVT9c6W7hw4KbbsrIoIgGhv5tetl4dI/Z
 YcuBRmiI10jmY3lWItGB+h8F/unN11GZz255I86Ggk3kCoeO1U8Nm1ZO02RiSx04bQ0V
 vS3F5YT8SKBkjYjqtDXWalJtvDCPPsXSvTLV5V5y4SozjNDXyL3BClJsyswf8/ORyKKR
 dT17A/qLEDToowl58dFYBA9bGU4ZFbAwXoGSyHIz5R0CZO/N9gLcc3eygPXE/wGVuMQW
 8dEQ==
X-Gm-Message-State: AOJu0YzD8Kv2mSFShanWCj2O47sw9Wn82rUKJrRCEAaWwO8x+/Pl6cZ/
 3Flr6jUew+WUMMHIY3TB5vYp9ktfGyWcwaB5aMf0sDS0CVl5Qg+Ed3OM211uMl2H1r4=
X-Gm-Gg: Acq92OFe9hyHTqdZ3qQaIqtFBR8t2opX8XCLZN+Wwt1w2YG37HQ5Rpj5N4kWQBUjoRJ
 CZN87Tr2fbyNR6JjcVtrxKcK67P0I8D+BL821z40sIKa7M1t0QE+yDwnkTFqeunLFQ7qSV/aNEt
 iffb7/BJ/FPe7zxMJCgUVWEyZvRIz9oQ6r6v4//R45gwjhXWDYMIy1p5+8+pjgpEm3BcjkN9UWW
 tS83KYRJ7V6Nc/X7VoI2myrpSXM5TtuGrlZ5LXwjiP8mYil0nh8w2vKp0u/SfWWnj9fMYcNI92E
 PIc7GStNr5d0W2cZrXFjXTxZvom1ot5VAklRn4XXjgQ6c6nIcXLfu08ZHs/sA3dQO6EiW6kukeK
 TWqS8aH28rNFSX/Kzw0Z/VIVuUTAt89noQYJG2LXbLlTIThS7JUkVGSclmdz2SBsGU+guBe72+M
 fF1FLZAex3dRgvkZ9UQ9075YvhTBlzOpQL/g==
X-Received: by 2002:a05:600d:8444:20b0:490:7136:ad02 with SMTP id
 5b1f17b1804b1-490b078f2d5mr9036295e9.7.1780330520170; 
 Mon, 01 Jun 2026 09:15:20 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34b47eesm28511335f8f.9.2026.06.01.09.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 09:15:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 02AED5F7C7;
 Mon, 01 Jun 2026 17:15:18 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Kyle Evans
 <kevans@freebsd.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  John Snow <jsnow@redhat.com>,  Thomas Huth
 <th.huth+qemu@posteo.eu>,  Brad Smith <brad@comstyle.com>,  Warner Losh
 <imp@bsdimp.com>,  qemu-arm@nongnu.org,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Song Gao <gaosong@loongson.cn>,  Cornelia
 Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/3] gitlab: work around the inability to build targets
 for MacOS
In-Reply-To: <57d0477a-3bbd-4948-8e18-33df41991545@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Mon, 1 Jun 2026 08:58:34 -0700")
References: <20260601143129.144786-1-alex.bennee@linaro.org>
 <20260601143129.144786-3-alex.bennee@linaro.org>
 <57d0477a-3bbd-4948-8e18-33df41991545@oss.qualcomm.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 01 Jun 2026 17:15:17 +0100
Message-ID: <87bjduxmne.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

> On 6/1/2026 7:31 AM, Alex Benn=C3=A9e wrote:
>> Unfortunately a previous fix to ensure .ninja-goals was set for the
>> TCG tests broken the ability to run check-functional-FOO. As we have
>> now reverted we need a solution for the MacOS gitlab run. The simplest
>> is to add an explicit make invocation to build the signed binaries
>> before we run the tests.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .gitlab-ci.d/macos.yml | 3 +++
>>  1 file changed, 3 insertions(+)
>>=20
>> diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
>> index f61750a3f4a..8366b4ad564 100644
>> --- a/.gitlab-ci.d/macos.yml
>> +++ b/.gitlab-ci.d/macos.yml
>> @@ -29,6 +29,7 @@
>>      - cd build
>>      - ../configure --enable-werror $CONFIGURE_ARGS || { cat config.log =
meson-logs/meson-log.txt; exit 1; }
>>      - $MAKE -j$(sysctl -n hw.ncpu)
>> +    - for TARGET in $TEST_BINARIES ; do $MAKE $TARGET ; done
>>      - for TARGET in $TEST_TARGETS ; do $MAKE $TARGET ; done
>>=20=20
>>  aarch64-macos-15-build:
>> @@ -44,6 +45,7 @@ aarch64-macos-15-build:
>>          --cross-prefix-i386=3Di686-elf-
>>          --cross-prefix-x86_64=3Dx86_64-elf-
>>          --disable-plugins
>> +    TEST_BINARIES: qemu-system-aarch64 qemu-system-i386 qemu-system-x86=
_64
>>      TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-test=
s-i386-softmmu run-tcg-tests-x86_64-softmmu
>>=20=20
>>  aarch64-macos-26-build:
>> @@ -60,4 +62,5 @@ aarch64-macos-26-build:
>>          --cross-prefix-i386=3Di686-elf-
>>          --cross-prefix-x86_64=3Dx86_64-elf-
>>          --disable-plugins
>> +    TEST_BINARIES: qemu-system-aarch64 qemu-system-i386 qemu-system-x86=
_64
>>      TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-test=
s-i386-softmmu run-tcg-tests-x86_64-softmmu
>
> Could make all be enough?

No - not without the goal having the signed binaries in them.

>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

