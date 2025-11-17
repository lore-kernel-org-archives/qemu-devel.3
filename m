Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C72CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 10:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKwcQ-0002iJ-7Z; Mon, 17 Nov 2025 05:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKwcP-0002hy-22
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 05:37:57 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKwcN-0006YZ-Cg
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 05:37:56 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b3c965cc4so2059882f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 02:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763375873; x=1763980673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gt7KXN0kf51wppv42sreiYYOAhM1z4v1+z7/C1VrtNA=;
 b=KF3B9XCObKey6HD9OOuKm6wbxNBVokQTA8P9ORO2OYAnwIL82k4rTmqfc824hs7FbZ
 iovXWFd/WSCi7c5RMkaE1nXtZax6UqY2jU/C8HzfxjsXFXlS2CE3cLwboBJYmhqpyA/F
 iUiqm1z8tzPDBzKprRmaedrWOgHztW9494JexsOIpXm0p7tc63ODbNLxofiyBD4IJma+
 pGDG4crSk0mhp7nHxS86wZw3ueNAq4kOJiyomIQ6Er/FSSVqsRvwH37V6L5rmK7gREqq
 t/584aEAnTPZsK8lbBaueoS+oYTEpbwzOZxcMA5ON3ForTfq91VrdjLFfpUJamDLHfCQ
 20ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763375873; x=1763980673;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gt7KXN0kf51wppv42sreiYYOAhM1z4v1+z7/C1VrtNA=;
 b=lOhDNkL/Yg0QcB4mPx0VhtmSaqhQbK7MZ7Z8yx8rYa8Ksz0MCBft7837S7H4lLor+X
 qA9FSo+Y5gZ/Qv75/f/k2RmxtvEqqg7KOboSLON3hv2/UfbRs8lyebm6HZEiYzVv0bmm
 hSTBFMM2qbZEShZlYoMAquY+Md21HjMysRqkGNiuyqkoughbxZxAHzU5IkTznkB9aUZD
 qrQMhbSjFzeT2HGRnbyhUORRh6kYuus/5YY0KZL9X2WqwmDJtdF5NwyRyTo1C4fnxo/m
 e4PWpvggfoMLYmoAcu/M8fCcd6u0hXq+wOiAuSjHv2Lvitbk2jtM0beCXbBL1gL19zNa
 XMGA==
X-Gm-Message-State: AOJu0YzFl4fmIeaYOyKe8V1Vk2dWRvwGYiwfimNnXpIJnr/guMMjHJTV
 jB4KkNGA7ey3ZCyK2ECTvNKllWqGhoGc5U5TLiWL2IdEegI3R/fIcaWpOBeGL4SgngI=
X-Gm-Gg: ASbGncvCGskG92CO0fhQZkSfqLZ0Wdl6ekTpOjD7eKTj+sE7vUNWzt5ZZfzEKQRP7XG
 026R1uTr1Je3F611GMR3jOrkPq3hJcojOYpdxUGPy9X/PjGLqusmDeX7jje7ErSU7qmLmpFkYx4
 WdjQIcZbzREVmnZC58+iFlYzYIHrLgYvscPuBYASBwKUm0GPMkzd+YlACd81P5bwTxGK5jndG3R
 VlLyEoV9n7Pl7utmwSsfXpjnE41ZnbR2g4TipA97GeUISv+v00SDoeZauJeFPw7SiiHkyIOROQv
 3BO3BgtJ6aH5qJ+K8+dG43FnVQRVAd6cYPgqmph8hJhblLmlxx+rNAaB1PV3KXZvpJT8fzK500w
 m/6R5yxZElpTsm/R1DIy8X4AKFFWgCGUnbPUSxSBiXhDJRxF1Df/KUf+nHk8bpsAh0Q1hw563Ml
 qEF91ghoMuI/4=
X-Google-Smtp-Source: AGHT+IEM5VmR/GqIW+79w0HlLSXqMLmnMI8y+5EWXewb/sjOLZOLIRjGIMEhqHzmqcyE3N5EIr7bXg==
X-Received: by 2002:a05:6000:200c:b0:426:fb27:974a with SMTP id
 ffacd0b85a97d-42b52844e62mr14896404f8f.27.1763375873313; 
 Mon, 17 Nov 2025 02:37:53 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae16sm25667680f8f.3.2025.11.17.02.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 02:37:52 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EA6645F804;
 Mon, 17 Nov 2025 10:37:51 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paul Durrant <paul@xen.org>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Kohei Tokunaga
 <ktokunaga.mail@gmail.com>,  Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>,  BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org,  Li-Wen Hsu <lwhsu@freebsd.org>,  David Woodhouse
 <dwmw2@infradead.org>,  Ed Maste <emaste@freebsd.org>
Subject: Re: [PATCH v2 16/18] gitlab: make custom runners need QEMU_CI to run
In-Reply-To: <aRr3WQfFnD1gpXdH@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 17 Nov 2025 10:22:17 +0000")
References: <20251113102525.1255370-1-alex.bennee@linaro.org>
 <20251113102525.1255370-17-alex.bennee@linaro.org>
 <aRr3WQfFnD1gpXdH@redhat.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 17 Nov 2025 10:37:51 +0000
Message-ID: <87y0o5kkqo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Nov 13, 2025 at 10:25:22AM +0000, Alex Benn=C3=A9e wrote:
>> In addition to not being triggered by schedule we should follow the
>> same rules about QEMU_CI. One day we may figure out how to fold the
>> custom runner rules into the .base_job_template but today is not that
>> day.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml    | 2 +-
>>  .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml | 2 +-
>>  .gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml   | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml b/.gitlab=
-ci.d/custom-runners/debian-13-ppc64le.yml
>> index 6492d013de8..be73c14b95e 100644
>> --- a/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
>> +++ b/.gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
>> @@ -11,7 +11,7 @@
>>      - ppc64le
>>    rules:
>>      - if: '$CI_PROJECT_NAMESPACE =3D=3D "qemu-project" && $CI_COMMIT_BR=
ANCH =3D~ /^staging/'
>> -    - if: '$PPC64LE_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE !=3D "sched=
ule"'
>> +    - if: '$PPC64LE_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE !=3D "sched=
ule" && $QEMU_CI'
>>    before_script:
>>      - source scripts/ci/gitlab-ci-section
>>      - section_start setup "Pre-script setup"
>> diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.git=
lab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
>> index c8adb8171c0..7a30a18d0bc 100644
>> --- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
>> +++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
>> @@ -11,7 +11,7 @@
>>      - aarch64
>>    rules:
>>      - if: '$CI_PROJECT_NAMESPACE =3D=3D "qemu-project" && $CI_COMMIT_BR=
ANCH =3D~ /^staging/'
>> -    - if: '$AARCH64_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE !=3D "sched=
ule"'
>> +    - if: '$AARCH64_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE !=3D "sched=
ule" && $QEMU_CI'
>>    before_script:
>>      - source scripts/ci/gitlab-ci-section
>>      - section_start setup "Pre-script setup"
>> diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml b/.gitla=
b-ci.d/custom-runners/ubuntu-24.04-s390x.yml
>> index fcb49ae884d..c30816a806e 100644
>> --- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
>> +++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
>> @@ -11,7 +11,7 @@
>>      - s390x
>>    rules:
>>      - if: '$CI_PROJECT_NAMESPACE =3D=3D "qemu-project" && $CI_COMMIT_BR=
ANCH =3D~ /^staging/'
>
> As a separate commit this should be changed to
>
>    - if: '$CI_PROJECT_NAMESPACE =3D=3D $QEMU_CI_UPSTREAM && $CI_COMMIT_BR=
ANCH =3D~ /^staging/'
>
> $QEMU_CI_UPSTREAM defaults to 'qemu-project' but devs can override it
> to point to their own repo, in order to test operation as if it were
> in upstream.

I'll wrap this in into the template clean-up as that also cleans up
other bits.

>
>> -    - if: '$S390X_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE !=3D "schedul=
e"'
>> +    - if: '$S390X_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE !=3D "schedul=
e" && $QEMU_CI'
>>    before_script:
>>      - source scripts/ci/gitlab-ci-section
>>      - section_start setup "Pre-script setup"
>
> This means the job will never get run by default in upstream context
> unless QEMU_CI is set. This is different from base.yml where in upstream
> context, jobs all run by default.
>
> ie in upstream we implicitly have QEMU_CI=3D=3D2 by default, while in
> forks we implicitly have QEMU_CI=3D=3D0 / unset.
>
> To get this matching better requires:
>
>  rules:
>    - if: '$CI_PROJECT_NAMESPACE =3D=3D $QEMU_CI_UPSTREAM && $CI_COMMIT_BR=
ANCH =3D~ /^staging/'
>    - if: '$QEMU_CI !=3D "1" && $QEMU_CI !=3D "2" && $CI_PROJECT_NAMESPACE=
 !=3D $QEMU_CI_UPSTREAM'
>      when: never
>    - if: '$S390X_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE !=3D "schedule" =
&& $QEMU_CI =3D=3D "1"'
>      when: manual
>    - if: '$S390X_RUNNER_AVAILABLE && $CI_PIPELINE_SOURCE !=3D "schedule"'
>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

