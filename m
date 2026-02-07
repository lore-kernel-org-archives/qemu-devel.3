Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FE2EE0AE9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 16:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1volH9-0000m4-Bj; Sat, 07 Feb 2026 11:35:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1volH8-0000id-8f
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 11:35:14 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1volH4-0005Hu-98
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 11:35:13 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b884a84e622so548478166b.1
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 08:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770482108; x=1771086908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SL8dWJQ3PUA12DHglhqv/4qaKGaUuyEJHY58CGoJ1iU=;
 b=h+YIHT6Q5Dt7o/4wfaVUg77kAbAl0SlfUrfvIA/uufiCLekhkX7iiIDV8Px2BRcZpv
 JgJx78jC1OU8uaPlGbH8+sZSC3/dacx5mU5FWh0tlLk6g08nhgbAmD/9dGFrzQXeY+s1
 NdDH/m+h8dPfiFznJWd+O2mUJwZeRZxqHXzNH30Fa3USTLITcIeyC7DPN/ejuzBKGpiS
 OlnMWxYTASXbrHVScllz7l1eJrEr9pkGbx8U0qtFNf8O9k8CDwyUBBzp2PFkikoVbl4l
 nI5qxHQmVBmHyI+UMhbjFYSVghXsHh9UNyIRX5W2FXbgu2AOvieF/MK9XSnCPS+CYwU/
 VWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770482108; x=1771086908;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SL8dWJQ3PUA12DHglhqv/4qaKGaUuyEJHY58CGoJ1iU=;
 b=cA4iXzXfgZ1Gz9wcEwwsONJ+VX7AGwDvz+/IM4J3dWalVBDeJUC36YQD2cD6Z95E3r
 6VFefjGcqaDZwBcdQQkBLb0agbR8DJQJyDcVvk3qhk8nK2h6s4/BodTiJ0pdYa1OP2yE
 pMER/ynyiiPh2TaQQKjxy22H6xfMkIHmg3i8SclEH65Ol+nysiJCltskmIIbo0J7yvoP
 9YkDwjvxeoPaIOJ4O1/08s7wMDL9psNsRW7pg+moZVuvyOUKn76zvcnAAr5hLs2TWH/c
 urL+ZEcegKsZVkBjhBVkUxfybjJkjJKCGFrKrtj4ALokG+aabutcrfCFhI5ULywKSYPj
 1ZpQ==
X-Gm-Message-State: AOJu0YwotFwplGLPknoGJ2MmYQWOkLAwo3qFCXz2U0fq/BugACo0sktu
 L6QhPO4PN7Itel/O7h5DxIHpc4hf/Zzj4D4KfW23C0e5G9CIOmycMGfNKvyYO5O97GY=
X-Gm-Gg: AZuq6aKWG7BY89oGjL4B3xjUn7qRn+6EsZH0blOGiy4a/gOPTs5rOTIsNpFCJfoQlit
 3+4HS2i90BcmOisa+Hf8DF6CD1/qffz+99gSnuTL28FQt2ffdWc0f96r43fOms5AkWK95IGnt04
 SqnVw/ZxSU67JPMsesw2lZIu9BEiW/cAc9ce782a00TANtHxbpKrLKE4H7Byt5qMQB5EqAkNPbl
 tpAF82TEZRV4ZZvStBrzf88sYLxCu83hUAMkgWSpW7h9/M+rsoIa1/Du2EGBLg6u+9xpgs2O4+8
 Mdkxj+IM/46FiWQqHGZcwDXmVuBpq8gj89+Tzjqmf8uHK1zn8dS9Wup40+MkqrfCbBobiiLJ+YR
 bE8vKWQHT9nBzDSqQm1sSq4cth9OebLFQugBAdD3+tN5VDODm0B1VCDMp9BGRIIU2j/88lJ6Pfz
 n1Atcm26QnJCg=
X-Received: by 2002:a17:906:dc95:b0:b84:1fc7:944f with SMTP id
 a640c23a62f3a-b8edf35046fmr368283266b.45.1770482106562; 
 Sat, 07 Feb 2026 08:35:06 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65983eaa4d4sm1424307a12.4.2026.02.07.08.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 08:35:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E12D6607C3;
 Sat, 07 Feb 2026 16:35:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Thomas Huth
 <thuth@redhat.com>,  Maksim Davydov <davydov-max@yandex-team.ru>,  Markus
 Armbruster <armbru@redhat.com>,  Peter Xu <peterx@redhat.com>,  Ed Maste
 <emaste@freebsd.org>,  Li-Wen Hsu <lwhsu@freebsd.org>,  =?utf-8?Q?Marc-An?=
 =?utf-8?Q?dr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Vladimir
 Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Paolo Bonzini <pbonzini@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Yonggang Luo
 <luoyonggang@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,  Kevin Wolf
 <kwolf@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH v5 13/16] tests: remove "make check-venv" target
In-Reply-To: <CAFn=p-a3BK5PiFQv2C0FX8z8PhQ91A3xWLoDv9fw-yJAGHMCUg@mail.gmail.com>
 (John Snow's message of "Fri, 6 Feb 2026 17:41:35 -0500")
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-14-jsnow@redhat.com>
 <87y0l7m829.fsf@draig.linaro.org>
 <CAFn=p-a3BK5PiFQv2C0FX8z8PhQ91A3xWLoDv9fw-yJAGHMCUg@mail.gmail.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Sat, 07 Feb 2026 16:35:04 +0000
Message-ID: <87o6m0tsuf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

John Snow <jsnow@redhat.com> writes:

> On Thu, Feb 5, 2026 at 12:09=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > With the qemu.qmp and qemu.machine dependencies now installed by defau=
lt
>> > at configure time and additional dependencies required by functional
>> > testing installed on demand, there is no longer any reason to have an
>> > explicit target.
>> >
>> > FIXME: This forces image regeneration for vm tests whenever Make
>> > determines that the image needs to be rebuilt; which is a regression
>> > over the previous behavior.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  tests/Makefile.include    | 22 ++--------------------
>> >  tests/vm/Makefile.include | 24 +++++++-----------------
>> >  2 files changed, 9 insertions(+), 37 deletions(-)
>> >
>> > diff --git a/tests/Makefile.include b/tests/Makefile.include
>> > index f28c9e329aa..2a203e23718 100644
>> > --- a/tests/Makefile.include
>> > +++ b/tests/Makefile.include
>> > @@ -21,7 +21,6 @@ ifneq ($(filter $(all-check-targets), check-softfloa=
t),)
>> >  endif
>> >       @echo
>> >       @echo " $(MAKE) check-report.junit.xml   Generates an aggregated=
 XML test report"
>> > -     @echo " $(MAKE) check-venv               Creates a Python venv f=
or tests"
>> >       @echo " $(MAKE) check-clean              Clean the tests and rel=
ated data"
>> >       @echo
>> >       @echo "The following are useful for CI builds"
>> > @@ -92,33 +91,16 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>> >  .PHONY: distclean-tcg
>> >  distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
>> >
>> > -# Python venv for running tests
>> > -
>> > -.PHONY: check-venv
>> > -
>> >  # Build up our target list from the filtered list of ninja targets
>> >  TARGETS=3D$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja-ta=
rgets)))
>> >
>> > -TESTS_VENV_TOKEN=3D$(BUILD_DIR)/pyvenv/tests.group
>> > -
>> > -quiet-venv-pip =3D $(quiet-@)$(call quiet-command-run, \
>> > -    $(PYTHON) -m pip -q --disable-pip-version-check $1, \
>> > -    "VENVPIP","$1")
>> > -
>> > -$(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
>> > -     $(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
>> > -     $(MKVENV_ENSUREGROUP) $< tooling functests
>> > -     $(call quiet-command, touch $@)
>> > -
>> > -check-venv: $(TESTS_VENV_TOKEN)
>> > -
>> >  FUNCTIONAL_TARGETS=3D$(patsubst %-softmmu,check-functional-%, $(filte=
r %-softmmu,$(TARGETS)))
>> >  .PHONY: $(FUNCTIONAL_TARGETS)
>> > -$(FUNCTIONAL_TARGETS): check-venv
>> > +$(FUNCTIONAL_TARGETS):
>> >       @$(MAKE) SPEED=3Dthorough $(subst -functional,-func,$@)
>> >
>> >  .PHONY: check-functional
>> > -check-functional: check-venv
>> > +check-functional:
>> >       @$(NINJA) precache-functional
>> >       @$(PYTHON) $(SRC_PATH)/scripts/clean_functional_cache.py
>> >       @QEMU_TEST_NO_DOWNLOAD=3D1 $(MAKE) SPEED=3Dthorough check-func c=
heck-func-quick
>> > diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
>> > index 14188bba1c6..095ec2eefa3 100644
>> > --- a/tests/vm/Makefile.include
>> > +++ b/tests/vm/Makefile.include
>> > @@ -1,14 +1,5 @@
>> >  # Makefile for VM tests
>> >
>> > -# Hack to allow running in an unconfigured build tree
>> > -ifeq ($(realpath $(SRC_PATH)),$(realpath .))
>> > -VM_PYTHON =3D PYTHONPATH=3D$(SRC_PATH)/python /usr/bin/env python3
>> > -VM_VENV =3D
>> > -else
>> > -VM_PYTHON =3D $(PYTHON)
>> > -VM_VENV =3D check-venv
>> > -endif
>> > -
>>
>> It's a shame to loose this because the build directory should have no
>> influence on what we build in the VM. Surely if we have qmp installed on
>> the system (and therefor its deps) we should still want the ability to
>> build in the src dir. Currently I get:
>>
>>   =E2=9E=9C  make vm-build-netbsd V=3D1
>>   tests/vm/netbsd  --debug     --source-path . --image "/home/alex/.cach=
e/qemu-vm/images/netbsd.img" --force --build-image /home/alex/.cache/qemu-v=
m/images/netbsd.img
>>   Traceback (most recent call last):
>>     File "/home/alex/lsrc/qemu.git/tests/vm/netbsd", line 19, in <module>
>>       import basevm
>>     File "/home/alex/lsrc/qemu.git/tests/vm/basevm.py", line 32, in <mod=
ule>
>>       from qemu.machine import QEMUMachine
>>   ModuleNotFoundError: No module named 'qemu'
>>   make: *** [tests/vm/Makefile.include:86: /home/alex/.cache/qemu-vm/ima=
ges/netbsd.img] Error 1
>
> Ah, I see.... it used to be possible to run the VM tests *without a
> build directory at all*.
>
> So, this used to work because of this bit in tests/vm/Makefile.include:
>
> # Hack to allow running in an unconfigured build tree
> ifeq ($(realpath $(SRC_PATH)),$(realpath .))
> VM_PYTHON =3D PYTHONPATH=3D$(SRC_PATH)/python /usr/bin/env python3
> VM_VENV =3D
> else
> VM_PYTHON =3D $(PYTHON)
> VM_VENV =3D check-venv
> endif
>
> What this did was effectively treat qemu.git/python/ as an installed
> package directory and picked the most likely culprit for your actual
> python interpreter location. (Note that the configure script is a bit
> more thorough in picking a python interpreter to use that is bypassed
> here.) It's possible we can continue to do this, however, it will
> begin requiring that you just-so-happen to have qemu.qmp available in
> your python environment. The list of dependencies you might need for
> this to work successfully may increase as the years go by, so this is
> a little bit "porcelain". I'm not sure I like this, just because I
> don't wanna be on the hook for mysterious failures down the line.
>
> Otherwise, to get all of the dependencies and python configuration
> managed for you, you have to do this:
>
> mkdir build && pushd build && ../configure && make vm-test-netbsd
>
> ... But you don't actually have to build, and in fact you don't even
> really need to actually run configure either, so, hm.... yeah, how
> about this, using a new "vm-venv" folder in the source tree as the
> virtual environment location, using a dependency hook like check-venv
> but now localized specifically for VM tests benefit and only when it
> is run from the source tree:
>
> jsnow@jsnow-thinkpadp16vgen1 ~/s/qemu (python_drop_qmp_pyvenv)> make
> vm-build-netbsd
> /usr/bin/env python3 ./python/scripts/mkvenv.py create vm-venv
> mkvenv: Creating non-isolated virtual environment at 'vm-venv'
> /home/jsnow/src/qemu/vm-venv/bin/python3
> ./vm-venv/bin/python3 ./python/scripts/mkvenv.py ensuregroup --online
> ./pythondeps.toml tooling functests
> mkvenv: checking for qemu.qmp>=3D0.0.5
> mkvenv: checking for pip>=3D21.3.1
> mkvenv: checking for setuptools>=3D53.0.0
> mkvenv: checking for wheel>=3D0.36.2
> mkvenv: checking for pygdbmi>=3D0.11.0.0
> mkvenv: installing qemu.qmp=3D=3D0.0.5
> mkvenv: installing /home/jsnow/src/qemu/python
>     VM-IMAGE netbsd
> ### Preparing iso and disk image ...
> Formatting '/home/jsnow/.cache/qemu-vm/images/netbsd.img.tmp',
> fmt=3Dqcow2 cluster_size=3D65536 extended_l2=3Doff compression_type=3Dzlib
> size=3D21474836480 lazy_refcounts=3Doff refcount_bits=3D16
>
> This will take care of dependencies and everything for you and won't
> interfere with normal configured builds at all. Only downside is a new
> temporary folder that clutters up the source root that you'll have to
> delete now and then.

Can we just add it to .gitignore or do we want it to be visible so users
don't forget?

> Otherwise it uses the same dependency resolution
> as a normal full-blooded configure. Only difference is that it uses a
> simpler heuristic for which python to use (/usr/bin/env python3).
>
> Sound good?

Yes that sounds good.

> --js
>
>>
>> >  .PHONY: vm-build-all vm-clean-all
>> >
>> >  EFI_AARCH64 =3D $(wildcard $(BUILD_DIR)/pc-bios/edk2-aarch64-code.fd)
>> > @@ -90,11 +81,10 @@ vm-clean-all:
>> >
>> >  $(IMAGES_DIR)/%.img: $(SRC_PATH)/tests/vm/% \
>> >                       $(SRC_PATH)/tests/vm/basevm.py \
>> > -                     $(SRC_PATH)/tests/vm/Makefile.include \
>> > -                     $(VM_VENV)
>> > +                     $(SRC_PATH)/tests/vm/Makefile.include
>> >       @mkdir -p $(IMAGES_DIR)
>> >       $(call quiet-command, \
>> > -             $(VM_PYTHON) $< \
>> > +             $(PYTHON) $< \
>> >               $(if $(V)$(DEBUG), --debug) \
>> >               $(if $(GENISOIMAGE),--genisoimage $(GENISOIMAGE)) \
>> >               $(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
>> > @@ -102,14 +92,14 @@ $(IMAGES_DIR)/%.img:     $(SRC_PATH)/tests/vm/% \
>> >               $(if $(LOG_CONSOLE),--log-console) \
>> >               --source-path $(SRC_PATH) \
>> >               --image "$@" \
>> > -             $(if $(filter-out check-venv, $?), --force) \
>> > +             --force \
>>
>> I think this is fine, as danp says if the deps are touched we should
>> re-build the VM.
>>
>> >               --build-image $@, \
>> >               "  VM-IMAGE $*")
>> >
>> >  # Build in VM $(IMAGE)
>> > -vm-build-%: $(IMAGES_DIR)/%.img $(VM_VENV)
>> > +vm-build-%: $(IMAGES_DIR)/%.img
>> >       $(call quiet-command, \
>> > -             $(VM_PYTHON) $(SRC_PATH)/tests/vm/$* \
>> > +             $(PYTHON) $(SRC_PATH)/tests/vm/$* \
>> >               $(if $(V)$(DEBUG), --debug) \
>> >               $(if $(DEBUG), --interactive) \
>> >               $(if $(J),--jobs $(J)) \
>> > @@ -133,9 +123,9 @@ vm-boot-serial-%: $(IMAGES_DIR)/%.img
>> >               -device virtio-net-pci,netdev=3Dvnet \
>> >       || true
>> >
>> > -vm-boot-ssh-%: $(IMAGES_DIR)/%.img $(VM_VENV)
>> > +vm-boot-ssh-%: $(IMAGES_DIR)/%.img
>> >       $(call quiet-command, \
>> > -             $(VM_PYTHON) $(SRC_PATH)/tests/vm/$* \
>> > +             $(PYTHON) $(SRC_PATH)/tests/vm/$* \
>> >               $(if $(J),--jobs $(J)) \
>> >               $(if $(V)$(DEBUG), --debug) \
>> >               $(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
>>
>> --
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

