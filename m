Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6DDE81BD7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 15:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpTRI-0001cB-Dk; Mon, 09 Feb 2026 10:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vpTR7-0001WK-WA
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 10:44:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vpTR1-0001Dn-KP
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 10:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770651861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=grK5JBegGbFz8UZKIhp4g1STJxPgukIKzIdhQ9zmJAg=;
 b=V3AiE2S2+Np7lGzlkzzeOFkbotup8girXPpFFbQ71pyneOsphk/Hkbtala+l5iMIHDQKSg
 Wob+aUoItv+cJbLgUseQC8EPc40WurQ9s/FlkDc9fILZtYhiGhH1AQd42Avxxfrh5yD7Nm
 /RX1BqpOw9gYOVCes8ij5zvQPnqNSug=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-ADaBOPdjNd2dMG_-CSPu-A-1; Mon, 09 Feb 2026 10:44:20 -0500
X-MC-Unique: ADaBOPdjNd2dMG_-CSPu-A-1
X-Mimecast-MFC-AGG-ID: ADaBOPdjNd2dMG_-CSPu-A_1770651860
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7960db651d9so35878947b3.1
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 07:44:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770651860; cv=none;
 d=google.com; s=arc-20240605;
 b=OiPqaGXoEbdGoLRo4CBKGGN2SSCcVuvW7udnYwLjkqfz3/2DFfcmqDFvh8V3VCBu4l
 YwYxxB5J4aky+9QuWLtlFFiqIIsXR0Eq5M3qC1WwWIOJdUnE19bq5AVuZ6dfYla8d4K7
 HGGEQDevWpD0BPnnfHFJYEkLq9Uaz2atXmf2xRFUvmQx/+stqmpK29oq4BBwMtATRKMf
 kWfET6qD/k6dQ3Udy+jFrFzLhWWybZsH5mmJLLIsH6yZvE8tP7hjamxPfmSoDhJ3DQeo
 IqfEFbUqfDufQwNgmGecCUb9hhgOhF4BMgYjhbPX4302/94QB0gPmTCs70PYALxs66/O
 Eb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=grK5JBegGbFz8UZKIhp4g1STJxPgukIKzIdhQ9zmJAg=;
 fh=Y5pWXNVsVgZka3sahhnq/iFl48x5DO/Rtu1CO0xPoEE=;
 b=CzJBK/Mhkt+k+dxdLHCBtNVdMzXQgQ5zuNoUNkelZ/VlnHJwcKkljdRBCSGWeAHayj
 V4JVj30c4h331FPAUUtEX72vZAAYXYkAYameJfOz+x7OGzYJVjRfo6hWH1ohuSeCPfCe
 BKKwdZVpsRDSgrfsM/O15URoF5ZVx5kFe2BKWvXKmb+Ras1GkcfRTn63qIt1DobkT5/Q
 LCL0dMXF/uVgihB9K6PrCRnLtjgcIqmhefLAcXjeXDzCkJbjb+k15oTHOpXH4OUTtz3e
 HCi1AZYjgEkR6ej+U8ryc0COqbM5l2ccCIkT8sNkr6daC5Mza+2sHPDoWcrrESTuz0ev
 9QBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770651860; x=1771256660; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=grK5JBegGbFz8UZKIhp4g1STJxPgukIKzIdhQ9zmJAg=;
 b=riIN7d0Sz8VyU0IUs1lL+RqHMP/LujOzuBN5iV1ebWmRme2yorlQOvrgxdD+4v8P5i
 FbSa7ntCHkp0pdqoJqcxtc9K8dxWd7VogOxbSRchTw8IvoQitYyAmCgBX3BQjiu7BEKb
 roXqQI7YigiewhyM7KwEtcyype8CtFM7iMys8WznvA8gyBVcoYvhdjtfZk4luqGJ3Db/
 6HulN466v0EH/8/w/iAxevwFtUp2kMyFF3r63dFRg5MBuaH1XQXPjHbwLAbBu6AC41v6
 AePa0SeoCjRvzLaqD3SNKzQUF+aRptKpN0607DuVwNdMEcqbIjdrjtW3Helk4B7DdP7p
 CYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770651860; x=1771256660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=grK5JBegGbFz8UZKIhp4g1STJxPgukIKzIdhQ9zmJAg=;
 b=mbCeWeF2FzMkIFTjrKB7wJxWMWUwqpRnSLY3ojrhWR+xn4bQAqwBpdMjG9nFaQeDlV
 CJAAkK8o6UXe21h4MqYx0AVyDLJXECl36SZV/Avb6W8bA7mAnWbidxHOM3vRlrGQsfgr
 LUz1c0izGWwZt0vqdUxEHR+y7cFGjBYivtzBDwAWLZUBok2rnMU4Zj3iBbrVaUYd6MLa
 CdkCiaikgGKBBaSn/dzTxykyAUZL+OnPz8NBIL75lKnptPf3M6CiGX8pQvEG1it4muQc
 LQ7lwIkfUtU0tBsQVFtnslGh7FCyLx6qVo0DIMuyoEfacbWRmH8kCOaBAcvg/ptSZPxR
 j70g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyLcYMz7MtizNAiQ+DcGLF6aZPg+rOnkaElI1DRx57G81UJGpIbbUDZibkOK/81aWfxI3Qr3AqxVjW@nongnu.org
X-Gm-Message-State: AOJu0YwFzKZlUH+MNFcjSKNk3CzxFsx02AIRWXsAXEU+2mt4eNhUF/mv
 puBuY086qLzw5GajsO6x8NHXJbRpM5t59PuRprrlA5f9G32Vo1Ir6AYiVcMPPsXmLF2CxVXg/BT
 cnwMyDz4RZwBnM5jmcvVTmOeFim8hh5XdpjSN8vf0uzP+cu3KndF7mVXI2lDzTMSnTUqA75CNWf
 gyQ0MSzbSPYn7MY5YaVxsH8RBWdQOLb3TZSWo8lmk=
X-Gm-Gg: AZuq6aJfUrvTog6j6PKoAlEqVf6T4A6EhnkUXIQUk/ntpsXLg8jr7+uFITJreu3fS/2
 6rrtNIhyU7a55nUk49QvYWR+AimBzmywJzIZg8Ks73HK+OCUtjkewDy3fxgUcUkye+7Gxww8nmc
 Jms08WQvykx3LV/vKj/3SxbsIB5WOG7sF17TeNfQvzpwxQaS8M47c4rk+tQDl2R5VUGoYyz4EM2
 jZBM+AaIdL4OCqU0ZzKp8toVA==
X-Received: by 2002:a05:690e:1c1d:b0:64a:d716:c8e8 with SMTP id
 956f58d0204a3-64ad716cb2bmr6066347d50.13.1770651859722; 
 Mon, 09 Feb 2026 07:44:19 -0800 (PST)
X-Received: by 2002:a05:690e:1c1d:b0:64a:d716:c8e8 with SMTP id
 956f58d0204a3-64ad716cb2bmr6066322d50.13.1770651859218; Mon, 09 Feb 2026
 07:44:19 -0800 (PST)
MIME-Version: 1.0
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-14-jsnow@redhat.com>
 <87y0l7m829.fsf@draig.linaro.org>
 <CAFn=p-a3BK5PiFQv2C0FX8z8PhQ91A3xWLoDv9fw-yJAGHMCUg@mail.gmail.com>
 <aYmWy0yMzyF3E310@redhat.com>
In-Reply-To: <aYmWy0yMzyF3E310@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 9 Feb 2026 10:44:05 -0500
X-Gm-Features: AZwV_QjR7fT8VnsuQS6psIChv6q2-wUYHB04SJCU9PlQyCD8l-sdSgekbcws4nA
Message-ID: <CAFn=p-Y5W2kU2YfSLA+yYEp3eyCNR14Fn_O6CtqUkWRveqJgUQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/16] tests: remove "make check-venv" target
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Yonggang Luo <luoyonggang@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Feb 9, 2026 at 3:13=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Fri, Feb 06, 2026 at 05:41:35PM -0500, John Snow wrote:
> > On Thu, Feb 5, 2026 at 12:09=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org> wrote:
> > >
> > > John Snow <jsnow@redhat.com> writes:
> > >
> > > > With the qemu.qmp and qemu.machine dependencies now installed by de=
fault
> > > > at configure time and additional dependencies required by functiona=
l
> > > > testing installed on demand, there is no longer any reason to have =
an
> > > > explicit target.
> > > >
> > > > FIXME: This forces image regeneration for vm tests whenever Make
> > > > determines that the image needs to be rebuilt; which is a regressio=
n
> > > > over the previous behavior.
> > > >
> > > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > > ---
> > > >  tests/Makefile.include    | 22 ++--------------------
> > > >  tests/vm/Makefile.include | 24 +++++++-----------------
> > > >  2 files changed, 9 insertions(+), 37 deletions(-)
> > > >
> > > > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > > > index f28c9e329aa..2a203e23718 100644
> > > > --- a/tests/Makefile.include
> > > > +++ b/tests/Makefile.include
> > > > @@ -21,7 +21,6 @@ ifneq ($(filter $(all-check-targets), check-softf=
loat),)
> > > >  endif
> > > >       @echo
> > > >       @echo " $(MAKE) check-report.junit.xml   Generates an aggrega=
ted XML test report"
> > > > -     @echo " $(MAKE) check-venv               Creates a Python ven=
v for tests"
> > > >       @echo " $(MAKE) check-clean              Clean the tests and =
related data"
> > > >       @echo
> > > >       @echo "The following are useful for CI builds"
> > > > @@ -92,33 +91,16 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
> > > >  .PHONY: distclean-tcg
> > > >  distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
> > > >
> > > > -# Python venv for running tests
> > > > -
> > > > -.PHONY: check-venv
> > > > -
> > > >  # Build up our target list from the filtered list of ninja targets
> > > >  TARGETS=3D$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja=
-targets)))
> > > >
> > > > -TESTS_VENV_TOKEN=3D$(BUILD_DIR)/pyvenv/tests.group
> > > > -
> > > > -quiet-venv-pip =3D $(quiet-@)$(call quiet-command-run, \
> > > > -    $(PYTHON) -m pip -q --disable-pip-version-check $1, \
> > > > -    "VENVPIP","$1")
> > > > -
> > > > -$(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
> > > > -     $(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
> > > > -     $(MKVENV_ENSUREGROUP) $< tooling functests
> > > > -     $(call quiet-command, touch $@)
> > > > -
> > > > -check-venv: $(TESTS_VENV_TOKEN)
> > > > -
> > > >  FUNCTIONAL_TARGETS=3D$(patsubst %-softmmu,check-functional-%, $(fi=
lter %-softmmu,$(TARGETS)))
> > > >  .PHONY: $(FUNCTIONAL_TARGETS)
> > > > -$(FUNCTIONAL_TARGETS): check-venv
> > > > +$(FUNCTIONAL_TARGETS):
> > > >       @$(MAKE) SPEED=3Dthorough $(subst -functional,-func,$@)
> > > >
> > > >  .PHONY: check-functional
> > > > -check-functional: check-venv
> > > > +check-functional:
> > > >       @$(NINJA) precache-functional
> > > >       @$(PYTHON) $(SRC_PATH)/scripts/clean_functional_cache.py
> > > >       @QEMU_TEST_NO_DOWNLOAD=3D1 $(MAKE) SPEED=3Dthorough check-fun=
c check-func-quick
> > > > diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> > > > index 14188bba1c6..095ec2eefa3 100644
> > > > --- a/tests/vm/Makefile.include
> > > > +++ b/tests/vm/Makefile.include
> > > > @@ -1,14 +1,5 @@
> > > >  # Makefile for VM tests
> > > >
> > > > -# Hack to allow running in an unconfigured build tree
> > > > -ifeq ($(realpath $(SRC_PATH)),$(realpath .))
> > > > -VM_PYTHON =3D PYTHONPATH=3D$(SRC_PATH)/python /usr/bin/env python3
> > > > -VM_VENV =3D
> > > > -else
> > > > -VM_PYTHON =3D $(PYTHON)
> > > > -VM_VENV =3D check-venv
> > > > -endif
> > > > -
> > >
> > > It's a shame to loose this because the build directory should have no
> > > influence on what we build in the VM. Surely if we have qmp installed=
 on
> > > the system (and therefor its deps) we should still want the ability t=
o
> > > build in the src dir. Currently I get:
> > >
> > >   =E2=9E=9C  make vm-build-netbsd V=3D1
> > >   tests/vm/netbsd  --debug     --source-path . --image "/home/alex/.c=
ache/qemu-vm/images/netbsd.img" --force --build-image /home/alex/.cache/qem=
u-vm/images/netbsd.img
> > >   Traceback (most recent call last):
> > >     File "/home/alex/lsrc/qemu.git/tests/vm/netbsd", line 19, in <mod=
ule>
> > >       import basevm
> > >     File "/home/alex/lsrc/qemu.git/tests/vm/basevm.py", line 32, in <=
module>
> > >       from qemu.machine import QEMUMachine
> > >   ModuleNotFoundError: No module named 'qemu'
> > >   make: *** [tests/vm/Makefile.include:86: /home/alex/.cache/qemu-vm/=
images/netbsd.img] Error 1
> >
> > Ah, I see.... it used to be possible to run the VM tests *without a
> > build directory at all*.
> >
> > So, this used to work because of this bit in tests/vm/Makefile.include:
> >
> > # Hack to allow running in an unconfigured build tree
> > ifeq ($(realpath $(SRC_PATH)),$(realpath .))
> > VM_PYTHON =3D PYTHONPATH=3D$(SRC_PATH)/python /usr/bin/env python3
> > VM_VENV =3D
> > else
> > VM_PYTHON =3D $(PYTHON)
> > VM_VENV =3D check-venv
> > endif
> >
> > What this did was effectively treat qemu.git/python/ as an installed
> > package directory and picked the most likely culprit for your actual
> > python interpreter location. (Note that the configure script is a bit
> > more thorough in picking a python interpreter to use that is bypassed
> > here.) It's possible we can continue to do this, however, it will
> > begin requiring that you just-so-happen to have qemu.qmp available in
> > your python environment. The list of dependencies you might need for
> > this to work successfully may increase as the years go by, so this is
> > a little bit "porcelain". I'm not sure I like this, just because I
> > don't wanna be on the hook for mysterious failures down the line.
> >
> > Otherwise, to get all of the dependencies and python configuration
> > managed for you, you have to do this:
> >
> > mkdir build && pushd build && ../configure && make vm-test-netbsd
> >
> > ... But you don't actually have to build, and in fact you don't even
> > really need to actually run configure either, so, hm.... yeah, how
> > about this, using a new "vm-venv" folder in the source tree as the
> > virtual environment location, using a dependency hook like check-venv
> > but now localized specifically for VM tests benefit and only when it
> > is run from the source tree:
>
> IMHO just keep life simple and expect configure to be run so we
> have the regular venv setup.
>

I'm sending a version that reflects Alex's desires, but it'd be nice
if the two of you could reach a consensus. The "no-configure" venv is
perhaps a little hacky, but it does otherwise use the same exact
pathways as the normal configure venv uses, so I am OK with it as a
convenience - and it is easy to remove in the future if it becomes a
hassle.


