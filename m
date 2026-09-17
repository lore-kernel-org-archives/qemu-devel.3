Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21016C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78P1-0002m9-Rt; Thu, 17 Sep 2026 05:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x78P0-0002l5-0B
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:27:34 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x78Ow-0000a3-S7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:27:33 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so3236625e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789637249; x=1790242049; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ROX8U4JzzzdRkmCSBVGIaoW1fUozFIaJ8HRnRqSJnA8=;
 b=B4h75R7V/Ym+m6GNotOWUDRRrDFaXEO+ufCL6d8k2Jpc+mGpKmVcOgwTH5XfEWK3CE
 0bANGGiZlKnKMC5G8Cql5C2L7c68LmFoX/j0FlhuDuz9U/5l3wVuH/sdmH70YC29+Yfi
 hNRJ3b/+h2RKc6GqVOZeqVhABTTYioDSUjvCf2xb/jtTV9FRzzOjR/AXXNkhAPvru/64
 FysmtqpEjYfLPjHV2Oo9dyQ9H9Ic6+2tx+RedUPo5OlVOj7gEWP7WgjdZSVMTXNowy6C
 RWF2lNfq6UXSvVyWEmNwxo+fL3mTPEMInepuEly3TVKxSMl0w0JD6jh4sB3qUpnSvKn1
 OEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789637249; x=1790242049;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ROX8U4JzzzdRkmCSBVGIaoW1fUozFIaJ8HRnRqSJnA8=;
 b=Mm0FyXWUffqcCL4m4jFfGJSakLXCr0uE8ONSQetCn+rJIF8i86/7v3dSbLv2AQHwJN
 MCLNdNBhtEI+wKt34xeFlU4EdSyMsYNmFi6IqRPhoHTPM4eyjW+dknKV5cQmU2R1eM0E
 6gT35bErpeAW9CpDy+Aha1GeMBDirmyaPTHU29Na7cqgXXaKgCe87UTAxhvdyIvTRytc
 q/iV/ye5bnS1PJuS09Z07qf+xISzHpWVEeIOfOaAEZMUX6JAkxFTGOnZFxjzGG/YAExx
 e5WUULfzVbLrupYLsqSp61MTj3NUVMBKqe84T8GZLrAjdcIrH2WyryPh7tE1YCZ1HOQ0
 MO9w==
X-Gm-Message-State: AFuF++kLlU22isRkjaw3uUcgWORvr38RL92GoyvNOdgqHucEZdeMK2dc
 6Vix0w7Wngg5Y251Oi9IM1Ha9n+2ha51c4g+B3WM/3+J2K2zd5f+7lggH4paDqaKpwU=
X-Gm-Gg: AYBFou0xF4wFRBABA2+Dg8CN9agcuMVIx8O6PdaFMT1V9u1803LiCzJxBqaFxGYbNWE
 vf/NIJNzeiStJDFRMca/C19qtUG7ia9VqI7PRNaxiqSaiXW6IiUzkTdGwllJbymh5Sd7zohKgGc
 8xPBW36OFHNYM704yJA8bXZ8dX8vai6cwG8TZJH/tXDuStHC85H5qhdrhrR22w1aSw/gJ4ahQSO
 0FGSGm/KCfjkH1qvDLuqSymwiqnhQHGFldu0h9Ke/FFoYiULCVGMyZahi/8u0ojvjX+P4DG71Zl
 wlohQYFj3yFEFeWCi7RFkyPyRMhwPaqxG+QvKyHkdmDuAgKAgKjd+24TvDvGY2d1Gkc0BEvI9Tt
 9okruRUXvxUDVwWb6nehiGp6CuaMT16h9d08B9WiNkGvhslwlACHbxcX+fbvNTChqq2LK9XMqj8
 knX8Z1bYEh++qx3aXbz2FBsiwuZP1vxvRE4aVm2BMXjtwUt7TAkZTcHe52MMH7n2BH3y4KPLo=
X-Received: by 2002:a05:600c:4e48:b0:49c:fc6e:a3d6 with SMTP id
 5b1f17b1804b1-49eb732d07emr77495845e9.21.1789637249217; 
 Thu, 17 Sep 2026 02:27:29 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd247809sm102273925e9.11.2026.09.17.02.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:27:28 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 669AB5F834;
 Thu, 17 Sep 2026 10:27:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-arm@nongnu.org,  Cornelia Huck <cohuck@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>,  David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Warner Losh
 <imp@bsdimp.com>,  Song Gao <gaosong@loongson.cn>,  Kyle Evans
 <kevans@freebsd.org>,  Eric Farman <farman@linux.ibm.com>,  Brad Smith
 <brad@comstyle.com>,  Fabiano Rosas <farosas@suse.de>,  Helge Deller
 <deller@gmx.de>,  Laurent Vivier <laurent@vivier.eu>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-s390x@nongnu.org,  Matthew Rosato <mjrosato@linux.ibm.com>,  Brian
 Cain <brian.cain@oss.qualcomm.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Jared Rossi <jrossi@linux.ibm.com>
Subject: Re: [PATCH v4 03/19] Revert "tests/tcg/meson.build: implement
 ./configure containers options"
In-Reply-To: <ef0cab70-4f36-4de1-bfdb-18501d801728@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Wed, 16 Sep 2026 09:33:50 -0700")
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
 <20260916153013.2134555-4-alex.bennee@linaro.org>
 <ef0cab70-4f36-4de1-bfdb-18501d801728@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Thu, 17 Sep 2026 10:27:27 +0100
Message-ID: <87eces8by8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

> On 9/16/2026 8:29 AM, Alex Benn=C3=A9e wrote:
>> We want to keep the container configuration inside configure for the
>> firmware builds.
>>=20
>> This partially reverts commit 522b299ca4316d8cad57f9496ffcba87dcc20719
>> while keeping the plumbing to disable containers within meson.
>>=20
>> Tested-by: Eric Farman <farman@linux.ibm.com>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> [AJB: untangle changes since]
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Tested-by: Jared Rossi <jrossi@linux.ibm.com>
>>=20
>> ---
>> v4
>>   - tweak revert to keep disable reported
>>   - update commit msg
>> ---
>>  configure             | 14 ++++++++++----
>>  meson_options.txt     |  3 +++
>>  tests/tcg/meson.build |  3 +++
>>  3 files changed, 16 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/configure b/configure
>> index bedde58b8cf..6084a7a065e 100755
>> --- a/configure
>> +++ b/configure
>> @@ -260,7 +260,7 @@ ninja=3D""
>>  python=3D
>>  download=3D"enabled"
>>  skip_meson=3Dno
>> -use_containers=3D""
>> +use_containers=3D"yes"
>>  rust=3D"disabled"
>>  rust_target_triple=3D""
>>=20=20
>> @@ -727,11 +727,14 @@ for opt do
>>    ;;
>>    --disable-plugins) plugins=3D"no"
>>    ;;
>> -  --enable-containers) # enabled by default
>> +  --enable-containers) use_containers=3D"yes"
>> +                       meson_option_add -Dcontainers=3Dtrue
>>    ;;
>> -  --disable-containers) meson_option_add -Dcontainers=3Dfalse
>> +  --disable-containers) use_containers=3D"no"
>> +                        meson_option_add -Dcontainers=3Dfalse
>>    ;;
>> -  --container-command=3D*) meson_option_add -Dcontainer_command=3D"$opt=
arg"
>> +  --container-command=3D*) container_command=3D"$optarg"
>> +                         meson_option_add -Dcontainer_command=3D"$optar=
g"
>
> Not sure if we want to keep this option (meson container_command).
> Related if in tests/tcg/meson.build can be removed also.

We want Makefile.include and meson to use the same container runtime
surely?

>
>>    ;;
>>    --rust-target-triple=3D*) rust_target_triple=3D"$optarg"
>>    ;;
>> @@ -1718,6 +1721,9 @@ echo all: >> $config_host_mak
>>=20=20
>>  echo "SRC_PATH=3D$source_path" >> $config_host_mak
>>  echo "TARGET_DIRS=3D$target_list" >> $config_host_mak
>> +if test "$container_command" !=3D ""; then
>> +    echo "CONTAINER_COMMAND=3D$container_command" >> $config_host_mak
>> +fi
>>  echo "SUBDIRS=3D$subdirs" >> $config_host_mak
>>  echo "PYTHON=3D$python" >> $config_host_mak
>>  echo "MKVENV_ENSUREGROUP=3D$mkvenv ensuregroup $mkvenv_online_flag" >> =
$config_host_mak
>> diff --git a/meson_options.txt b/meson_options.txt
>> index 66d3689d14c..daf301ed48a 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -389,6 +389,9 @@ option('rust', type: 'feature', value: 'disabled',
>>         description: 'Rust support')
>>  option('strict_rust_lints', type: 'boolean', value: false,
>>         description: 'Enable stricter set of Rust warnings')
>> +option('container_registry', type: 'string',
>> +       value: 'registry.gitlab.com/qemu-project/qemu',
>> +       description: 'container registry to cache from')
>>  option('containers', type: 'boolean', value: true,
>>         description: 'use containers to cross compile tcg tests')
>>  option('container_command', type: 'string',
>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>> index ce208e686ff..890da7b81e9 100644
>> --- a/tests/tcg/meson.build
>> +++ b/tests/tcg/meson.build
>> @@ -101,6 +101,9 @@ if get_option('containers')
>>    endif
>>  endif
>>  tcg_tests_summary +=3D {'container command': container_command}
>> +if get_option('container_registry') !=3D ''
>> +  tcg_tests_summary +=3D {'container registry': get_option('container_r=
egistry')}
>> +endif
>>=20
>
> Rebase issue?

Possibly - it got messy with the reverts.

>
>>  # plugins come first, as we need to build the list
>>  test_plugins =3D {}

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

