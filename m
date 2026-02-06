Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84687EE6B69
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 22:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voUWc-0007Fn-8m; Fri, 06 Feb 2026 17:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1voUWR-0007FH-6G
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:41:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1voUWN-0002xn-Ux
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770417709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hMmvx22jToKZHap82msZo95c+P50ilpf9Ljihh2rP3E=;
 b=hYs5JwGmLX+7ehuXumEUyHXU1BD6hIT4QaEWTGMPWP1Qg8VeR7a2WhPwCRPfFRgzdbH9QM
 b4NzxU2XFJ8KLvOg+hiCJdtOc4r6vhKm59RU4+3RmamUp7FI1rCdg+q2/H8A9wgu4N8XzK
 OhIT/xzcAWlIehyrpCdhJMKR5/oU8hQ=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-eR3vcZlAMU6kKKUEiGrExg-1; Fri, 06 Feb 2026 17:41:47 -0500
X-MC-Unique: eR3vcZlAMU6kKKUEiGrExg-1
X-Mimecast-MFC-AGG-ID: eR3vcZlAMU6kKKUEiGrExg_1770417707
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-649deeeb00fso3342602d50.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 14:41:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770417707; cv=none;
 d=google.com; s=arc-20240605;
 b=f8JV83aJb2eAq5BtzDL5VcAjqout9sXgE8tvlHAOpk36kggPpII82BB26OM3SKGNYM
 T4RDWVwa71AHfoek8kuyvdaCHlud4VAHmwt0fuwm9wwNY2Kah7bsNHpi9dpi+id/jIM0
 dwZJlYMJL905HItdpjuZvKlt44vjEzH41UfH7zX7D+7S+T18lqsV8yCNWyphlu/XG61U
 Y/AMwEIA0LGk4aODRsnZNAfTh6h9/QA+MIjBHrG4dS9Y5Yb3eZOxbpgJ4NLuiui9zGCk
 YHGLL3EBemkMtuYyK/GEzyJPq/pWei5r76ahL6UteLBmPSF38FxoAiGCBMOQ+E4FWoBP
 RKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hMmvx22jToKZHap82msZo95c+P50ilpf9Ljihh2rP3E=;
 fh=3UjKkuN921KaaRcsQKBgprCyZT3jANJ0l1TRf6lWdHE=;
 b=D8/auvRr5pkMXiiaE3liBSfsTObg2V6HiKC3iuFnJiinpOcj/3YSz5JR9A8iiePMfO
 dsCRoZ30o3WpewRuYvjZvE/8mm97SkW8GuVXSXgM2dLqXJbaZfHSGvVftom8iXd8nhpi
 zvPTw3PBXfhqam0ma88ZpKo2EfX4ZX3CIL/S5C4utPF+iRcRz8lny/kleLBFaZQmgirb
 vN8r0OvQTEzoVzl8LdPTqkBZnjO+Bj4ODOwsHnNrXuo+ABuF1l2vwFVlvhKdExNo3V7A
 7d+ehhAtLkTuiGYl11EK+nC4K3PhcgYe6JnKgTqJUIpBRygukXcQqYn82Xn9aDOOERSq
 uuyA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770417707; x=1771022507; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMmvx22jToKZHap82msZo95c+P50ilpf9Ljihh2rP3E=;
 b=HrODWsNBfnVg9eOjdvUh1uUgqyCc1AIn43hZite4m+GoEHkwyEDOYS00uALw+1jtFB
 dY8TAIgTxe8M1mxh+6LBFxDG0YuVwuZt5ZwJAnWrlsgCBY+GK0qS66t2i6Osjbt91362
 c2XgcSqWQYtYuQU+91fyTROCZZ4sITodZH8YFP3NbiM6+DTIoLdYsunPiUBuRND7tmbl
 Oe8sFmIzS39ZplrRw0qPJuPb2fcX5LlQvjLQxRIhDXGIONmtoKHeWfQBD4YG8cniE0Be
 yTGUtC/UHWK2maly/ChVapCN0MpJIIEZ9ZEGyeuWWNZeI2JqWvQ8gSXm333Y72JwLrDq
 A/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770417707; x=1771022507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hMmvx22jToKZHap82msZo95c+P50ilpf9Ljihh2rP3E=;
 b=BkW2eHf0V8Y9XZzQ7WNmEayigQvbFxZcXPBJxH4H/SCe43YAfvAJoQvPP6Iyc9tmgp
 OpTgH6UoH/4L0DiUSSj2mXA17Edj03mILWrX9RwmilTnCF6L0+v0VJw0nW4uPUppRY4+
 gVXuVkPmreyzZTgmV5C3af2XwJxyz22/Uj8pInLMTgaf2mmb2sSyUN3n8Z/U46636TeJ
 Ek7486GyMKENIt8qKTEMVzKUra0jzqXVHzQhNZND++rAfSu0x7Ddx1t/JyqVEPlkqgsl
 aojWB5l/3sYzzFsocKcNRuY4TwRsWmgXTE96mPzEZD5ZkVwCVrs1WbDWBBLDmqxIF6+j
 HeMw==
X-Gm-Message-State: AOJu0YwW+E2lSL5LEH8h/RquSP3BT+lHbaVfJL4+qI9Ivor387sn9XQh
 nQzT+SJavnbpaJOUvO3ECCgam8xDMo4OWCw+YcNFo+ulfMdEo+4k6IQzu7df+FL/6oABsE4tNsS
 sLthNWq4jEHALz0fBomnijNjiHx8K2nHNB63BwhPyxWAYDE/YT1Yfxtr+VPpdBUF4uKMgYXmecO
 CYifPFhBKoRAGyvQSdlsdkXopmpxWCM0g=
X-Gm-Gg: AZuq6aL+k/A310PstqeQ1oO3whcw54ZWUhK3y19qtWeiOjPJzS2TH73l5iJZwrz3N8T
 SYPmHJtKQdKmKZuAfr8HQZk1nBG5Bj5LWSNMAWMWwr5J+jeK0VgUbM20Apet2yPB4bkYWx4ToE8
 4cTdRMOiyXUzy/l/phzJs/LuCEU+MlVI5ManaRvSHWA7I09tCG0fCxAPBoPbl0I/YSURQKZ63mE
 8DH0AQ+11zq7P7AT1zIQIcFEg==
X-Received: by 2002:a05:690e:118d:b0:64a:d1ef:d135 with SMTP id
 956f58d0204a3-64ad1efd339mr2363081d50.31.1770417707200; 
 Fri, 06 Feb 2026 14:41:47 -0800 (PST)
X-Received: by 2002:a05:690e:118d:b0:64a:d1ef:d135 with SMTP id
 956f58d0204a3-64ad1efd339mr2363049d50.31.1770417706745; Fri, 06 Feb 2026
 14:41:46 -0800 (PST)
MIME-Version: 1.0
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-14-jsnow@redhat.com>
 <87y0l7m829.fsf@draig.linaro.org>
In-Reply-To: <87y0l7m829.fsf@draig.linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 6 Feb 2026 17:41:35 -0500
X-Gm-Features: AZwV_Qgsqz6QimujzBZuu6qE5srLq6YmbPR-9qDFcbsDxJ9tG7e96avzy4vWd44
Message-ID: <CAFn=p-a3BK5PiFQv2C0FX8z8PhQ91A3xWLoDv9fw-yJAGHMCUg@mail.gmail.com>
Subject: Re: [PATCH v5 13/16] tests: remove "make check-venv" target
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>, 
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Yonggang Luo <luoyonggang@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Feb 5, 2026 at 12:09=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > With the qemu.qmp and qemu.machine dependencies now installed by defaul=
t
> > at configure time and additional dependencies required by functional
> > testing installed on demand, there is no longer any reason to have an
> > explicit target.
> >
> > FIXME: This forces image regeneration for vm tests whenever Make
> > determines that the image needs to be rebuilt; which is a regression
> > over the previous behavior.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  tests/Makefile.include    | 22 ++--------------------
> >  tests/vm/Makefile.include | 24 +++++++-----------------
> >  2 files changed, 9 insertions(+), 37 deletions(-)
> >
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index f28c9e329aa..2a203e23718 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -21,7 +21,6 @@ ifneq ($(filter $(all-check-targets), check-softfloat=
),)
> >  endif
> >       @echo
> >       @echo " $(MAKE) check-report.junit.xml   Generates an aggregated =
XML test report"
> > -     @echo " $(MAKE) check-venv               Creates a Python venv fo=
r tests"
> >       @echo " $(MAKE) check-clean              Clean the tests and rela=
ted data"
> >       @echo
> >       @echo "The following are useful for CI builds"
> > @@ -92,33 +91,16 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
> >  .PHONY: distclean-tcg
> >  distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
> >
> > -# Python venv for running tests
> > -
> > -.PHONY: check-venv
> > -
> >  # Build up our target list from the filtered list of ninja targets
> >  TARGETS=3D$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja-tar=
gets)))
> >
> > -TESTS_VENV_TOKEN=3D$(BUILD_DIR)/pyvenv/tests.group
> > -
> > -quiet-venv-pip =3D $(quiet-@)$(call quiet-command-run, \
> > -    $(PYTHON) -m pip -q --disable-pip-version-check $1, \
> > -    "VENVPIP","$1")
> > -
> > -$(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
> > -     $(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
> > -     $(MKVENV_ENSUREGROUP) $< tooling functests
> > -     $(call quiet-command, touch $@)
> > -
> > -check-venv: $(TESTS_VENV_TOKEN)
> > -
> >  FUNCTIONAL_TARGETS=3D$(patsubst %-softmmu,check-functional-%, $(filter=
 %-softmmu,$(TARGETS)))
> >  .PHONY: $(FUNCTIONAL_TARGETS)
> > -$(FUNCTIONAL_TARGETS): check-venv
> > +$(FUNCTIONAL_TARGETS):
> >       @$(MAKE) SPEED=3Dthorough $(subst -functional,-func,$@)
> >
> >  .PHONY: check-functional
> > -check-functional: check-venv
> > +check-functional:
> >       @$(NINJA) precache-functional
> >       @$(PYTHON) $(SRC_PATH)/scripts/clean_functional_cache.py
> >       @QEMU_TEST_NO_DOWNLOAD=3D1 $(MAKE) SPEED=3Dthorough check-func ch=
eck-func-quick
> > diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> > index 14188bba1c6..095ec2eefa3 100644
> > --- a/tests/vm/Makefile.include
> > +++ b/tests/vm/Makefile.include
> > @@ -1,14 +1,5 @@
> >  # Makefile for VM tests
> >
> > -# Hack to allow running in an unconfigured build tree
> > -ifeq ($(realpath $(SRC_PATH)),$(realpath .))
> > -VM_PYTHON =3D PYTHONPATH=3D$(SRC_PATH)/python /usr/bin/env python3
> > -VM_VENV =3D
> > -else
> > -VM_PYTHON =3D $(PYTHON)
> > -VM_VENV =3D check-venv
> > -endif
> > -
>
> It's a shame to loose this because the build directory should have no
> influence on what we build in the VM. Surely if we have qmp installed on
> the system (and therefor its deps) we should still want the ability to
> build in the src dir. Currently I get:
>
>   =E2=9E=9C  make vm-build-netbsd V=3D1
>   tests/vm/netbsd  --debug     --source-path . --image "/home/alex/.cache=
/qemu-vm/images/netbsd.img" --force --build-image /home/alex/.cache/qemu-vm=
/images/netbsd.img
>   Traceback (most recent call last):
>     File "/home/alex/lsrc/qemu.git/tests/vm/netbsd", line 19, in <module>
>       import basevm
>     File "/home/alex/lsrc/qemu.git/tests/vm/basevm.py", line 32, in <modu=
le>
>       from qemu.machine import QEMUMachine
>   ModuleNotFoundError: No module named 'qemu'
>   make: *** [tests/vm/Makefile.include:86: /home/alex/.cache/qemu-vm/imag=
es/netbsd.img] Error 1

Ah, I see.... it used to be possible to run the VM tests *without a
build directory at all*.

So, this used to work because of this bit in tests/vm/Makefile.include:

# Hack to allow running in an unconfigured build tree
ifeq ($(realpath $(SRC_PATH)),$(realpath .))
VM_PYTHON =3D PYTHONPATH=3D$(SRC_PATH)/python /usr/bin/env python3
VM_VENV =3D
else
VM_PYTHON =3D $(PYTHON)
VM_VENV =3D check-venv
endif

What this did was effectively treat qemu.git/python/ as an installed
package directory and picked the most likely culprit for your actual
python interpreter location. (Note that the configure script is a bit
more thorough in picking a python interpreter to use that is bypassed
here.) It's possible we can continue to do this, however, it will
begin requiring that you just-so-happen to have qemu.qmp available in
your python environment. The list of dependencies you might need for
this to work successfully may increase as the years go by, so this is
a little bit "porcelain". I'm not sure I like this, just because I
don't wanna be on the hook for mysterious failures down the line.

Otherwise, to get all of the dependencies and python configuration
managed for you, you have to do this:

mkdir build && pushd build && ../configure && make vm-test-netbsd

... But you don't actually have to build, and in fact you don't even
really need to actually run configure either, so, hm.... yeah, how
about this, using a new "vm-venv" folder in the source tree as the
virtual environment location, using a dependency hook like check-venv
but now localized specifically for VM tests benefit and only when it
is run from the source tree:

jsnow@jsnow-thinkpadp16vgen1 ~/s/qemu (python_drop_qmp_pyvenv)> make
vm-build-netbsd
/usr/bin/env python3 ./python/scripts/mkvenv.py create vm-venv
mkvenv: Creating non-isolated virtual environment at 'vm-venv'
/home/jsnow/src/qemu/vm-venv/bin/python3
./vm-venv/bin/python3 ./python/scripts/mkvenv.py ensuregroup --online
./pythondeps.toml tooling functests
mkvenv: checking for qemu.qmp>=3D0.0.5
mkvenv: checking for pip>=3D21.3.1
mkvenv: checking for setuptools>=3D53.0.0
mkvenv: checking for wheel>=3D0.36.2
mkvenv: checking for pygdbmi>=3D0.11.0.0
mkvenv: installing qemu.qmp=3D=3D0.0.5
mkvenv: installing /home/jsnow/src/qemu/python
    VM-IMAGE netbsd
### Preparing iso and disk image ...
Formatting '/home/jsnow/.cache/qemu-vm/images/netbsd.img.tmp',
fmt=3Dqcow2 cluster_size=3D65536 extended_l2=3Doff compression_type=3Dzlib
size=3D21474836480 lazy_refcounts=3Doff refcount_bits=3D16

This will take care of dependencies and everything for you and won't
interfere with normal configured builds at all. Only downside is a new
temporary folder that clutters up the source root that you'll have to
delete now and then. Otherwise it uses the same dependency resolution
as a normal full-blooded configure. Only difference is that it uses a
simpler heuristic for which python to use (/usr/bin/env python3).

Sound good?
--js

>
> >  .PHONY: vm-build-all vm-clean-all
> >
> >  EFI_AARCH64 =3D $(wildcard $(BUILD_DIR)/pc-bios/edk2-aarch64-code.fd)
> > @@ -90,11 +81,10 @@ vm-clean-all:
> >
> >  $(IMAGES_DIR)/%.img: $(SRC_PATH)/tests/vm/% \
> >                       $(SRC_PATH)/tests/vm/basevm.py \
> > -                     $(SRC_PATH)/tests/vm/Makefile.include \
> > -                     $(VM_VENV)
> > +                     $(SRC_PATH)/tests/vm/Makefile.include
> >       @mkdir -p $(IMAGES_DIR)
> >       $(call quiet-command, \
> > -             $(VM_PYTHON) $< \
> > +             $(PYTHON) $< \
> >               $(if $(V)$(DEBUG), --debug) \
> >               $(if $(GENISOIMAGE),--genisoimage $(GENISOIMAGE)) \
> >               $(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
> > @@ -102,14 +92,14 @@ $(IMAGES_DIR)/%.img:     $(SRC_PATH)/tests/vm/% \
> >               $(if $(LOG_CONSOLE),--log-console) \
> >               --source-path $(SRC_PATH) \
> >               --image "$@" \
> > -             $(if $(filter-out check-venv, $?), --force) \
> > +             --force \
>
> I think this is fine, as danp says if the deps are touched we should
> re-build the VM.
>
> >               --build-image $@, \
> >               "  VM-IMAGE $*")
> >
> >  # Build in VM $(IMAGE)
> > -vm-build-%: $(IMAGES_DIR)/%.img $(VM_VENV)
> > +vm-build-%: $(IMAGES_DIR)/%.img
> >       $(call quiet-command, \
> > -             $(VM_PYTHON) $(SRC_PATH)/tests/vm/$* \
> > +             $(PYTHON) $(SRC_PATH)/tests/vm/$* \
> >               $(if $(V)$(DEBUG), --debug) \
> >               $(if $(DEBUG), --interactive) \
> >               $(if $(J),--jobs $(J)) \
> > @@ -133,9 +123,9 @@ vm-boot-serial-%: $(IMAGES_DIR)/%.img
> >               -device virtio-net-pci,netdev=3Dvnet \
> >       || true
> >
> > -vm-boot-ssh-%: $(IMAGES_DIR)/%.img $(VM_VENV)
> > +vm-boot-ssh-%: $(IMAGES_DIR)/%.img
> >       $(call quiet-command, \
> > -             $(VM_PYTHON) $(SRC_PATH)/tests/vm/$* \
> > +             $(PYTHON) $(SRC_PATH)/tests/vm/$* \
> >               $(if $(J),--jobs $(J)) \
> >               $(if $(V)$(DEBUG), --debug) \
> >               $(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>


