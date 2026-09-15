Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAE2C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WgZ-0001Ed-Js; Tue, 15 Sep 2026 13:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6WgP-0000vZ-Fj
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:11:02 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6WgN-00047P-5U
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:11:01 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so315285e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492257; x=1790097057; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lNmpvSJHvnl2sdQ2jxqWK0VXNL8g4jeFZWJYNeJdo1s=;
 b=uxar3EqBBWyq/W45DbAGhDUVB+0nLEVQvLGqEeaYuNcf3tkrRwkPITZdYqPvVG43Os
 ukFnBk9MWTu7m1WtXS8Hwcjoj+gIADJ1mkpYG1SQBb7vW5hNIhhuZzvEgRq1glDw6S/N
 MmGOQ51Ib/Hg0EWK2zyNJ1G3iHnXCC/bCqU0bmC/W2TwSv2tbJnVXakffUMl7PPrZ1pu
 o31LAZ+W8U3fc69zRPYxKxBc1GiuiL9dj9icentcgSwZzG4q5vmKg/dPjozEUCJHlB91
 r7HDBoFR0F0gEzirQ7XnxtWgTVS5gmKMcqfpJPhJ8VWy4D/AgusuzJZdzqG4oKrCRmQ8
 0oZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492257; x=1790097057;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lNmpvSJHvnl2sdQ2jxqWK0VXNL8g4jeFZWJYNeJdo1s=;
 b=r+Up7sbDxHTcA3cbIc0awUXBLnOyNCNK6oOAl3bMR1NPY7pu6HZAfygFBcGsUztzsG
 wseW4baeAzJNEF5kNJHEdjOCyl5EKwI69Ts+o8VxTqX3Wq0/fUNA/71a2qL/svEYoJzG
 eZeKoNaZAjwz4Sp+SEznNfXWN6dT7whZMoCFqxoyOpmrtq/2p1a51lYAuBSwD8FnUtQj
 VNvcM2QgMjpRoBcJGznmIzfyxqA6F35sOYA8zrWtbGdSYcaop2JBCT6TApBuMLWG5Hkm
 WgJcWXn9kmaIRVx4v7LQ60ZLk9kSOOAMBxBCRMRz588GkKySZnbU1CoN5pOignFSVBCl
 LkAA==
X-Gm-Message-State: AFuF++mvX/pSa/qcwfvhAo/Jta1A2kf9siP9cWe847gfzYsPGEFhX8Ip
 OubBbZG1QqpvUGRwXid3neg8xQSFrmuQvNcqQAoVJyOcGhbV38b2Obc2YtltymjO4EA=
X-Gm-Gg: AYBFou08W9EVtF0gzV41IkXLUtwABlSGCuBBeeH65k1NFCHGMVGE+v7LUJKGJ5lHqtz
 JJiFvTWGiNf2yAE4nNEpXxMBNTPogj9mjKoBCr/wN+2esXWZ28haxe2SSw14alyaGVUW/OJIN2e
 2brbFtwnMPPZWOkySDM5u5F43bY9+lu/3RlTDhmGge4sfHOFvc4FynBY+UDuB2wHlchX0jl7SpF
 eAk7ZtCHwoOa5jA3tyNjxAJYRIx2+YxF0lGTbe726VrujIQ8WhsfFnqkKZAuVgnQoWWzo3U1NG/
 1m8Iv6nVZvHhhHUObX0903C6VJ3yLdrMZb9LcUD1tq1a1XfmG2d05AAJlJcBgqoQKvMe06ID+CO
 cmGZglQVZ2/AbNUnZWmVenxSund2obPnRukPPTEQJ83xLvAna59n+bBmmzscLSLtHtbdJ5mSZsw
 afuHHIFA8I9UTAkRRFtxWeFPmg0gCYDbKnWIqWcfrLq4U9lZzpyty/vI29hol7J7x2K+Lj3rA=
X-Received: by 2002:a05:600c:3ba7:b0:49c:f4e1:4c2d with SMTP id
 5b1f17b1804b1-49e7a68698bmr122370795e9.16.1789492257074; 
 Tue, 15 Sep 2026 10:10:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83da9a7csm4099335e9.11.2026.09.15.10.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:10:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2D4455F825;
 Tue, 15 Sep 2026 18:10:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Brad Smith <brad@comstyle.com>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Song Gao <gaosong@loongson.cn>,  Warner Losh
 <imp@bsdimp.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Cornelia Huck <cohuck@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  John Snow <jsnow@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Thomas Huth <th.huth+qemu@posteo.eu>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  qemu-arm@nongnu.org,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Kyle Evans <kevans@freebsd.org>,  Richard
 Henderson <richard.henderson@linaro.org>,  Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 5/9] tests/docker: add container registry to configure
 and use
In-Reply-To: <9999cc6c-04e4-4507-beb0-5856bf614333@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Mon, 14 Sep 2026 09:18:06 -0700")
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <20260910181504.1010916-6-alex.bennee@linaro.org>
 <abacad10-b9af-4a39-93c9-14b882f60bea@oss.qualcomm.com>
 <87qziw1ebt.fsf@draig.linaro.org>
 <9999cc6c-04e4-4507-beb0-5856bf614333@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Tue, 15 Sep 2026 18:10:55 +0100
Message-ID: <87zexia19c.fsf@draig.linaro.org>
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

> On 9/14/2026 12:28 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> On 9/10/26 11:15 AM, Alex Benn=C3=A9e wrote:
>>>> Previously we had the default baked into Makefile.include but as the
>>>> meson container logic will also benefit from it we update the configure
>>>> machinery.
>>>> For now we allow direct make invocations to override but for the
>>>> normal case it is in one place now.
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> ---
>>>>   configure                     | 8 ++++++++
>>>>   meson_options.txt             | 3 +++
>>>>   tests/docker/Makefile.include | 4 +---
>>>>   tests/tcg/meson.build         | 6 ++++++
>>>>   4 files changed, 18 insertions(+), 3 deletions(-)
>>>> diff --git a/configure b/configure
>>>> index aaa41fe47aa..7d6b11ddd35 100755
>>>> --- a/configure
>>>> +++ b/configure
>>>> @@ -172,6 +172,7 @@ fi
>>>>   # some defaults, based on the host environment
>>>>     # default parameters
>>>> +container_registry=3D"registry.gitlab.com/qemu-project/qemu"
>>>>   cpu=3D""
>>>>   cross_compile=3D"no"
>>>>   cross_prefix=3D""
>>>> @@ -728,6 +729,9 @@ for opt do
>>>>     ;;
>>>>     --container-command=3D*) meson_option_add -Dcontainer_command=3D"$=
optarg"
>>>>     ;;
>>>> +  --container-registry=3D*) container_registry=3D"$optarg"
>>>> +                          meson_option_add -Dcontainer_registry=3D"$o=
ptarg"
>>>> +  ;;
>>>>     --rust-target-triple=3D*) rust_target_triple=3D"$optarg"
>>>>     ;;
>>>>     --gdb=3D*) meson_option_add -Dgdb=3D"$optarg"
>>>> @@ -862,6 +866,7 @@ Advanced options (experts only):
>>>>     --cpu=3DCPU                Build for host CPU [$cpu]
>>>>     --disable-containers     don't use containers for cross-building
>>>>     --container-command=3DCMD  which container command to use [autodet=
ect]
>>>> +  --container-registry=3DURL which container registry to cache from [=
$container_registry]
>>>>     --gdb=3DGDB-path           gdb to use for gdbstub tests [autodetec=
t]
>>>>     --wasm64-32bit-address-limit Restrict wasm64 address space to 32-b=
it (default
>>>>                                  is to use the whole 64-bit range).
>>>> @@ -1318,6 +1323,9 @@ echo "GENISOIMAGE=3D$genisoimage" >> $config_hos=
t_mak
>>>>   echo "MESON=3D$meson" >> $config_host_mak
>>>>   echo "NINJA=3D$ninja" >> $config_host_mak
>>>>   echo "EXESUF=3D$EXESUF" >> $config_host_mak
>>>> +if test -n "$container_registry"; then
>>>> +  echo "DOCKER_DEFAULT_REGISTRY=3D$container_registry" >> $config_hos=
t_mak
>>>> +fi
>>>>   if test "$default_targets" =3D "yes"; then
>>>>     echo "CONFIG_DEFAULT_TARGETS=3Dy" >> $config_host_mak
>>>>   fi
>>>> diff --git a/meson_options.txt b/meson_options.txt
>>>> index 292625af08a..030231492e1 100644
>>>> --- a/meson_options.txt
>>>> +++ b/meson_options.txt
>>>> @@ -391,6 +391,9 @@ option('containers', type: 'boolean', value: true,
>>>>          description: 'use containers to cross compile tcg tests')
>>>>   option('container_command', type: 'string',
>>>>          description: 'command to build/run containers')
>>>> +option('container_registry', type: 'string',
>>>> +       value: 'registry.gitlab.com/qemu-project/qemu',
>>>> +       description: 'container registry to cache from')
>>>>     option('tcg_tests_cross_cc_aarch64', type: 'string',
>>>>          description: 'cc for aarch64 tcg tests')
>>>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.inc=
lude
>>>> index 0adddb6a5c6..74bf471f171 100644
>>>> --- a/tests/docker/Makefile.include
>>>> +++ b/tests/docker/Makefile.include
>>>> @@ -11,9 +11,7 @@ USER =3D $(if $(NOUSER),,$(shell id -un))
>>>>   UID =3D $(if $(NOUSER),,$(shell id -u))
>>>>     DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>>>> -ifeq ($(HOST_ARCH),x86_64)
>>>> -DOCKER_DEFAULT_REGISTRY :=3D registry.gitlab.com/qemu-project/qemu
>>>> -endif
>>>> +DOCKER_DEFAULT_REGISTRY ?=3D registry.gitlab.com/qemu-project/qemu
>>>>   DOCKER_REGISTRY :=3D $(if $(REGISTRY),$(REGISTRY),$(DOCKER_DEFAULT_R=
EGISTRY))
>>>>
>>>
>>> Couldn't we read the default from config_host_mak generated by
>>> configure instead?
>>>
>>>>   CONTAINER_COMMAND ?=3D $(shell $(SRC_PATH)/tests/docker/docker.py pr=
obe)
>>>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>>>> index 814f2f8cd8c..22157a47c96 100644
>>>> --- a/tests/tcg/meson.build
>>>> +++ b/tests/tcg/meson.build
>>>> @@ -101,6 +101,9 @@ if get_option('containers')
>>>>     endif
>>>>   endif
>>>>   tcg_tests_summary +=3D {'container command': container_command}
>>>> +if get_option('container_registry') !=3D ''
>>>> +  tcg_tests_summary +=3D {'container registry': get_option('container=
_registry')}
>>>> +endif
>>>>     # plugins come first, as we need to build the list
>>>>   test_plugins =3D {}
>>>> @@ -257,6 +260,9 @@ foreach target, plan: tcg_tests
>>>>       if cc_dockerfile not in image_targets and has_docker
>>>>         cmd =3D [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qem=
u/' + cc_dockerfile,
>>>>                '--add-current-user']
>>>> +      if get_option('container_registry') !=3D ''
>>>> +        cmd +=3D ['--registry', get_option('container_registry')]
>>>> +      endif
>>>>         t =3D custom_target(image_name, command: cmd,
>>>>                           build_by_default: false,
>>>>                           output: 'no_output_' + image_name)
>>>
>>> Do user benefit from this, or is it mostly for CI need?
>>=20
>> The aim is for faster image builds because the CI registry should always
>> be up to date. Most of the time the images don't change.
>>
>
> Ok. In this case, you need to add --timestamp 0 (that's enough in what I
> tested) to original build command that generates those layers from our
> CI, and use it here also. Else --cache-from does not work as intended
> and you'll see have some duplication because timestamp is part of hash
> for each layer.
>
> See this guide for more info:
> https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html=
/building_running_and_managing_containers/introduction-to-reproducible-cont=
ainer-builds

Hmm is that a podman only option?

>>> The effect is to use --cache-from $registry, which I'm not sure is
>>> what we want by default, given all the "caching issues" we had
>>> previously with dockerfiles already.
>>> If that's for CI, maybe it could simply set with --container-command
>>> in our CI only.
>>>
>>> Regards,
>>> Pierrick
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

