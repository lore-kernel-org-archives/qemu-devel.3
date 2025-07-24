Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90381C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 12:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uevBi-0004T9-1B; Thu, 24 Jul 2025 08:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uevBE-0003ru-Pg
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:36:15 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uevB9-0007wu-El
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:36:12 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ae3b336e936so178899066b.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753360565; x=1753965365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ityP9BPRXs9lGBmM75seOMPOKzPu4M4k6GTyNLaUSGw=;
 b=hOQDPMaZ+08HuVd8BplmWAbIAgdEwatsoLlL0kjLW0l2V5cROxQmxd8+QV9d3kiaxy
 D0nkSwHkt4GTmH2GsRMRxcHJZ6HVkMvnkcA2JLykSltl7p16fvdxIBFYDgQJFOXUHazO
 la+cF1SHuYRRPhleL1GwuuEK78y4ZaFYmXgGeliYz5stCgIjsE700blJ4+ZelzlAjd3T
 5sHHrFgX6R/ZSdVQ+IOGiHo9D8cGdQA/WgX7cGt0Fwd3pF30psOnz7TzbsaeSCsIDk9s
 GW37CfZrAlxgzlR1K4/h3OjMkMq40CMCicYdo/oEEeR30LwBBbl62AlVK9ifoAQ3w9i3
 /ouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753360565; x=1753965365;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ityP9BPRXs9lGBmM75seOMPOKzPu4M4k6GTyNLaUSGw=;
 b=mQzwPgXsTJZqU8T/2h/oFlikGAENxYmfmyCjqiCTOJY0JC/UmDElF7pHmXoUD909u0
 9z0liPz500Bs0tQLRjoEJ4Yy60+25MMqcoDLBl7xp7pBHBthZdlGKN5rjvc7Q+6oZ9aZ
 Tjz+GSAExm0Vcqn8qep0Pd9GjE4koAZDMLK0YeUb9HI6qH/QviZqdHbft54glUzqxFoQ
 duA0SvfvaISlFrt+q0ICYgZ8b1MNDkbNk6QyWq1oHDttDJrx4L4Qp0omL3/9Jjh8WswE
 y9Ecu8/TWjM23ZE+4uaeiPFpLc7JjM+L8uKhr/+Np9qaqqbt9HkuXVg3tiBpFws/uYE6
 2XMw==
X-Gm-Message-State: AOJu0YyrGWYTyNgHRRoHJqj7oiKMKdIsQylDWLYQm8wP6Peine8p/gCC
 9uQmaMp0Ky58mLegavBK/4bV9+ZnJ4E5DJhu1tGt6QwlEeMvjWmCQguzQwEQ6BWt14HXBbpvYar
 nqxUR
X-Gm-Gg: ASbGncvWw379tqntVXS2bULavXKXXM2cI2h1EAdlTiXbR+OMbVWwuxFwc1hjf/eE9Qs
 nIZklfXK+Np3oAe7UlZ55tC4zcTbk3UaYXkeHFjVEOdhCRkQv/XBDGmoGpMZ+0soduhl8/RDEoD
 YhaahM0dGRModADzI50sHpxXo+nZpXKZtm71ow5qk9TH3p/ij6uLeMDt3HLeA3t+BjCiY8D20ET
 N6bxUkP7rxN+UeliSn3/ARzMs63fKLYiGVuKqhLBTK3L6T7pivshfIuoWf1+Dfcp9eUwl43IKT/
 w5BP/3LjDQlSy21KdDHQCjrXz40b1EV0J/aCJ9fjXuA9Vii/WQGPbDOXJP5KmG57+LpUa5hRAdP
 Egs/dLyfMELjafRFTPtkj6xI=
X-Google-Smtp-Source: AGHT+IEe1mlm4Jh9/xcFs9tIGdsTFGldQ12oZPU0zP97tb6WPwHv5Aqu3Izv3XRJaG/HeC2CRD7q0Q==
X-Received: by 2002:a17:907:9693:b0:ade:3bec:ea40 with SMTP id
 a640c23a62f3a-af2f66c09a6mr783349966b.10.1753360564990; 
 Thu, 24 Jul 2025 05:36:04 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47f861d70sm107040366b.120.2025.07.24.05.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 05:36:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 38E9F5F7B0;
 Thu, 24 Jul 2025 13:36:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for 10.1 13/13] tests/docker: handle host-arch selection
 for all-test-cross
In-Reply-To: <CAAjaMXau4GyWidMNdYXgnMQTrv0mhVuCamDtaMLLJPeEDgyOQQ@mail.gmail.com>
 (Manos Pitsidianakis's message of "Thu, 24 Jul 2025 14:29:42 +0300")
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-14-alex.bennee@linaro.org>
 <CAAjaMXau4GyWidMNdYXgnMQTrv0mhVuCamDtaMLLJPeEDgyOQQ@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Thu, 24 Jul 2025 13:36:03 +0100
Message-ID: <875xfhvk98.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Thu, Jul 24, 2025 at 2:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>
>> When building on non-x86 we get a bunch but not all of the compilers.
>> Handle this in the Dockerfile by probing the arch and expanding the
>> list available.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .../dockerfiles/debian-all-test-cross.docker  | 31 ++++++++++---------
>>  1 file changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tes=
ts/docker/dockerfiles/debian-all-test-cross.docker
>> index 5aa43749ebe..16a83241270 100644
>> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
>> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
>> @@ -23,7 +23,9 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>>          bison \
>>          ccache \
>>          clang  \
>> +        dpkg-dev \
>>          flex \
>> +        gcc \
>>          git \
>>          libclang-rt-dev \
>>          ninja-build \
>> @@ -33,16 +35,11 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>>          python3-venv \
>>          python3-wheel
>>
>> -RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>> -        apt install -y --no-install-recommends \
>> -        gcc-aarch64-linux-gnu \
>> +# All the generally available compilers
>> +ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
>>          libc6-dev-arm64-cross \
>>          gcc-arm-linux-gnueabihf \
>>          libc6-dev-armhf-cross \
>> -        gcc-hppa-linux-gnu \
>> -        libc6-dev-hppa-cross \
>> -        gcc-m68k-linux-gnu \
>> -        libc6-dev-m68k-cross \
>>          gcc-mips-linux-gnu \
>>          libc6-dev-mips-cross \
>>          gcc-mips64-linux-gnuabi64 \
>> @@ -51,18 +48,24 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>>          libc6-dev-mips64el-cross \
>>          gcc-mipsel-linux-gnu \
>>          libc6-dev-mipsel-cross \
>> -        gcc-powerpc-linux-gnu \
>> -        libc6-dev-powerpc-cross \
>> -        gcc-powerpc64-linux-gnu \
>> -        libc6-dev-ppc64-cross \
>>          gcc-powerpc64le-linux-gnu \
>>          libc6-dev-ppc64el-cross \
>>          gcc-riscv64-linux-gnu \
>>          libc6-dev-riscv64-cross \
>>          gcc-s390x-linux-gnu \
>> -        libc6-dev-s390x-cross \
>> -        gcc-sparc64-linux-gnu \
>> -        libc6-dev-sparc64-cross && \
>> +        libc6-dev-s390x-cross
>> +
>> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=3D"$=
{AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; fi
>> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=3D"$=
{AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; fi
>> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=3D"$=
{AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; fi
>> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=3D"$=
{AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; fi
>> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=3D"$=
{AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; fi
>> +
>> +RUN echo "compilers: ${AVAILABLE_COMPILERS}"
>
> Nitpick, each `RUN` command will create a new cached layer for the
> container build. It makes more sense to fold them in a single `RUN`
> step to avoid unnecessary layers. Does not make a big difference so
> feel free to ignore.

I did try to figure out how to do a multi-line shell with an env
expansion but wasn't able to get the escaping right. If you can suggest
the right runes please do ;-)

>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>
>> +
>> +RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>> +        apt install -y --no-install-recommends \
>> +        ${AVAILABLE_COMPILERS} && \
>>          dpkg-query --showformat '${Package}_${Version}_${Architecture}\=
n' --show > /packages.txt
>>
>>
>> --
>> 2.47.2
>>
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

