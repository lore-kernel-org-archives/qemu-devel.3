Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10890ECD6F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 22:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqIMc-00028l-B6; Wed, 11 Feb 2026 17:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vqIMa-000288-GD
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 17:07:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vqIMX-0000rE-DD
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 17:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770847626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fnUPbLkQ377q1H/kAy+GQHBtgN7Si/jC8VL1v9jUXuk=;
 b=Dgz5dym4xVYskSyLMW73L8Pw0SzXP8Tauz63tveMPgpQbYkk0EPK1hlCph36D2UFiQ7NLq
 CuQV4dnBpFDNuKizDC2QIX76mMOEOkM4WC1CCFXLYVLJGe2e9yTpwGczLQXqC7Y12W9Y9N
 QeiSZnOOU3Wmk3EjSfFQQSGOBjWmclM=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-7ab7nhM3NyyIi5GJo0y4rg-1; Wed, 11 Feb 2026 17:07:04 -0500
X-MC-Unique: 7ab7nhM3NyyIi5GJo0y4rg-1
X-Mimecast-MFC-AGG-ID: 7ab7nhM3NyyIi5GJo0y4rg_1770847624
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-794105cd922so37529417b3.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 14:07:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770847624; cv=none;
 d=google.com; s=arc-20240605;
 b=LF/QVE4wIPJbLOlNpWG+TIzsABlk8fmiC/SLfoKYBmrdJ/jPwRqBcla4cr509Tf6wl
 0YDFj6SBbhEy42dzkw7g2w+ebBvmNf/JiCCEIyyoEjD5T7RM/s3LH47g4dV+M/Tw+t87
 vZq9WUqeGN9MB5SKnJu556yCTB9iCWrHXrKGwfY/BrqFAFeB+bI3Zdxvg03w+NjJVBFz
 sQPMSwmJi1IIceqHsjpDSAuW79ShLlAi+D5/ZwCeaaZ/iIW+XbvCCtCJ6z6tz1ut+Ehx
 27GdiahjlJfYDozO4G1W0oDz9tGWc4r+EHyK051eNFnJ6e/b9ugp6G4CkDrL6geGicYY
 CMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fnUPbLkQ377q1H/kAy+GQHBtgN7Si/jC8VL1v9jUXuk=;
 fh=Lah7I+3ChAymqWZ+YdG/Tj4JYtVuZwVlf9ch9kwXops=;
 b=RGxpsX4kzy03/bekzZbnB61XV+BtonRmTHhUTodlId0EQw7LUDYOvcNY1b9i0dSwgx
 OjzVsR2xwBFPp9YccDy1mPZq8f+NU4deABoKJP0XjVpCubW8a2PSAdZ+SGro/mMqotrr
 2rrv1GNsQn4CMR8gCKGR9puDRvS+uiv3xnsTnqV/rESEy6sJhBzfLgd4I7BBbNLER3B4
 1QXcoXjhQjj2hfRE8Yv/UHHYiXZE3hN3Xal0Ydbj6LLZ36QOyWLoXpjSwV5niMUd9abw
 N6XNDN6T2Sbx00/AA6cF25ucCWOW9ybPZAOVDGTdQVvXJoPoNtfr9LWjuRAfA+fFJzJh
 CEhg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770847624; x=1771452424; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnUPbLkQ377q1H/kAy+GQHBtgN7Si/jC8VL1v9jUXuk=;
 b=cpGxKu4ffRzrdy2dToWEcUYmCgtyvKZp9wV19YF6i0X9f8cxfuYATvFOdP8J4sXOJS
 muy1U4zEgp/16gfWjYnoEpoB45e0dvWZ8pPBOkc449fwgCHtXarIG903GOB6LDu8uDWI
 14WbcVdKauiGjAYAHsWYg2GoQwzfbWuaT6BsOfF+/YMuKdtAn1qmxT1cis9BKPnF4t4S
 2X6FIh3LEYSa3wEFcJ8H/XQvIF2JN9xdprf5nOlT5t8NjGcOSHvrAvsoVtsgGg5a8mJT
 ahTUr7OeqOsZWeu8hbfRxAuuAe6sy0neBu7+kEW2cQiwBzlslJghS83RR+gXFoF10W4R
 52Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770847624; x=1771452424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fnUPbLkQ377q1H/kAy+GQHBtgN7Si/jC8VL1v9jUXuk=;
 b=XCutuYeVDIL5bYPXUNmKJCSWp4Ff1dGa3yLISXwJfeFS2orj6oRjYNs5bWFOqm6X4E
 jbQXflX69GPIuGy3kMcO/UqrLQjr09CYJpiwJ0/04TWXoUMrW8sLZGwo21cmiOXlMHjC
 9UBUFBmLpB/CdB3XRSx1aayrwg3w4jfCVQAleCqScx5xGcM2E+L4yTbP6UxlW52MGrdj
 PyZpMDpt94lBfEm69dIrpe7dk3wIyFzPVW4xAwbZ3Erl/myOp9D9TTX91rsgma+Zxmhx
 BzYxK46lrpg5plwS2OWH/NiThnjCh7nPKHOqpeIQqNbc41qFBv2PhpYjNMCZ0U+ADt5F
 8BTg==
X-Gm-Message-State: AOJu0Yx6KQBe+YrUFpWuMFWSt0gS4e6EHUxD/tBpWjYa54Q9h3fa1BPH
 z6i88wiaW0XzoXJSO1vrcqph5VQuYjlu7hTpaPWyIokHMUXJEz6vjUpsJLBJc1Yz/b/acAYWi2Q
 s7nca+9LM/agntt2vEYwPKRFrN9TCPAHEaSbBvmwXF75UAFrELiMatRWZH7pf4Jq0SSfMx6m11Y
 zvstTFCjp0E9MIVAWwDhvXeFEW+V/GVYk=
X-Gm-Gg: AZuq6aJn+Tdq+fgtGD8mqYkTu/Z50m6TLRtNJUqIgDClpBcjTsoHchXMFmeYbZzHf/d
 788LodFeyTy5MEPi/AX1LmfKsAai9bkYVjy/0bG1b6uHHzoeE8curEjntzmuAw19ze0wTi0JAkH
 AHIDDWWIIj0OyejmsDgE/GKDLwxFlQrf8PHYDrDUUjbM8hhEFhIVj1SsCrT8kBZ0tiQhc+msJQH
 cZZCCXDFF7uTNcCKBWgpraK2zFhnz4Ro1iF8g==
X-Received: by 2002:a05:690e:13ce:b0:649:ec90:e295 with SMTP id
 956f58d0204a3-64c0819f512mr71403d50.18.1770847623922; 
 Wed, 11 Feb 2026 14:07:03 -0800 (PST)
X-Received: by 2002:a05:690e:13ce:b0:649:ec90:e295 with SMTP id
 956f58d0204a3-64c0819f512mr71374d50.18.1770847623381; Wed, 11 Feb 2026
 14:07:03 -0800 (PST)
MIME-Version: 1.0
References: <20260209184124.1263625-1-jsnow@redhat.com>
 <20260209184124.1263625-14-jsnow@redhat.com>
 <87v7g5y59s.fsf@draig.linaro.org>
In-Reply-To: <87v7g5y59s.fsf@draig.linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 11 Feb 2026 17:06:52 -0500
X-Gm-Features: AZwV_QiLJEHHScqz2F7jpl_LFPiL059RcjtK_VwFWwEO6h1unf1nJJKQxYGCTbk
Message-ID: <CAFn=p-bnMOnN3NaQoE5fjjQr0eLZe95AkQk=FEgoYcKjgeLtHw@mail.gmail.com>
Subject: Re: [PATCH v6 13/16] tests: replace check-venv with vm-venv target
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Maksim Davydov <davydov-max@yandex-team.ru>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
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

On Mon, Feb 9, 2026 at 4:30=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > With the qemu.qmp and qemu.machine dependencies now installed by defaul=
t
> > at configure time and additional dependencies required by functional
> > testing installed on demand, we do not need the explicit "check-venv" t=
arget.
> >
> > ...However, to facilitate running VM tests without running configure, w=
e
> > move some of the former logic into tests/vm/Makefile.include to create =
a
> > new venv (vm-venv) on-demand when running VM tests from the source tree=
.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  tests/Makefile.include    | 22 ++--------------------
> >  tests/vm/Makefile.include | 18 ++++++++++++++----
> >  2 files changed, 16 insertions(+), 24 deletions(-)
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
> > index 14188bba1c6..217bc706c20 100644
> > --- a/tests/vm/Makefile.include
> > +++ b/tests/vm/Makefile.include
> > @@ -2,13 +2,23 @@
> >
> >  # Hack to allow running in an unconfigured build tree
> >  ifeq ($(realpath $(SRC_PATH)),$(realpath .))
> > -VM_PYTHON =3D PYTHONPATH=3D$(SRC_PATH)/python /usr/bin/env python3
> > -VM_VENV =3D
> > +VM_PYTHON =3D $(SRC_PATH)/vm-venv/bin/python3
> > +VM_VENV =3D vm-venv
> >  else
> >  VM_PYTHON =3D $(PYTHON)
> > -VM_VENV =3D check-venv
> > +VM_VENV =3D
> >  endif
> >
> > +VM_VENV_TOKEN=3D$(SRC_PATH)/vm-venv/tooling.group $(SRC_PATH)/vm-venv/=
functests.group
>
> Which group should the following be fixed in?
>
>   make vm-build-openbsd V=3D1
>
> leads too:
>
>   DEBUG:root:ssh_cmd: ssh -t -o StrictHostKeyChecking=3Dno -o UserKnownHo=
stsFile=3D/dev/null -o ConnectTimeout=3D1 -p 34187 -i /home/alex/lsrc/qemu.=
git/vm-test-0fzv014h.tmp/id_rsa -o IdentitiesOnly=3Dyes -o SendEnv=3Dhttps_=
proxy -o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o SendEnv=3Dno_proxy =
qemu@127.0.0.1
>           set -e;
>           rm -rf /home/qemu/qemu-test.*
>           cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
>           mkdir src build; cd src;
>           tar -xf /dev/rsd1c;
>           cd ../build;
>           ../src/configure --cc=3Dcc  --extra-cflags=3D-I/usr/local/inclu=
de                          --extra-ldflags=3D-L/usr/local/lib ;
>           gmake --output-sync -j16 all check V=3D1;
>
>   Warning: Permanently added '[127.0.0.1]:34187' (ED25519) to the list of=
 known hosts.
>   python determined to be '/usr/local/bin/python3'
>   python version: Python 3.12.11
>   mkvenv: Creating non-isolated virtual environment at 'pyvenv'
>   mkvenv: checking for meson>=3D1.5.0
>   mkvenv: checking for pycotap>=3D1.1.0
>   mkvenv: checking for qemu.qmp>=3D0.0.5
>   mkvenv: installing meson=3D=3D1.10.0, pycotap=3D=3D1.3.1, qemu.qmp=3D=
=3D0.0.5
>   mkvenv: installing /home/qemu/qemu-test.lk7TCA/src/python
>   ERROR: Exception:
>   Traceback (most recent call last):
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/cli/base_command.py", line 106, in _run_wrapper
>       status =3D _inner_run()
>                ^^^^^^^^^^^^
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/cli/base_command.py", line 97, in _inner_run
>       return self.run(options, args)
>              ^^^^^^^^^^^^^^^^^^^^^^^
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/cli/req_command.py", line 67, in wrapper
>       return func(self, options, args)
>              ^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/commands/install.py", line 386, in run
>       requirement_set =3D resolver.resolve(
>                         ^^^^^^^^^^^^^^^^^
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/resolution/resolvelib/resolver.py", line 76, in resolv=
e
>       collected =3D self.factory.collect_root_requirements(root_reqs)
>                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/resolution/resolvelib/factory.py", line 545, in collec=
t_root_requirements
>       reqs =3D list(
>              ^^^^^
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/resolution/resolvelib/factory.py", line 501, in _make_=
requirements_from_install_req
>       cand =3D self._make_base_candidate_from_link(
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/resolution/resolvelib/factory.py", line 212, in _make_=
base_candidate_from_link
>       self._editable_candidate_cache[link] =3D EditableCandidate(
>                                              ^^^^^^^^^^^^^^^^^^
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/resolution/resolvelib/candidates.py", line 329, in __i=
nit__
>       super().__init__(
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/resolution/resolvelib/candidates.py", line 159, in __i=
nit__
>       self.dist =3D self._prepare()
>                   ^^^^^^^^^^^^^^^
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/resolution/resolvelib/candidates.py", line 236, in _pr=
epare
>       dist =3D self._prepare_distribution()
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/resolution/resolvelib/candidates.py", line 339, in _pr=
epare_distribution
>       return self._factory.preparer.prepare_editable_requirement(self._ir=
eq)
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/operations/prepare.py", line 698, in prepare_editable_=
requirement
>       dist =3D _get_prepared_distribution(
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/operations/prepare.py", line 72, in _get_prepared_dist=
ribution
>       abstract_dist.prepare_distribution_metadata(
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/distributions/sdist.py", line 69, in prepare_distribut=
ion_metadata
>       self.req.prepare_metadata()
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/req/req_install.py", line 567, in prepare_metadata
>       and self.supports_pyproject_editable
>           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/usr/local/lib/python3.12/functools.py", line 998, in __get__
>       val =3D self.func(instance)
>             ^^^^^^^^^^^^^^^^^^^
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_internal/req/req_install.py", line 258, in supports_pyproject_e=
ditable
>       return "build_editable" in self.pep517_backend._supported_features(=
)
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_vendor/pyproject_hooks/_impl.py", line 180, in _supported_featu=
res
>       return self._call_hook("_supported_features", {})
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pa=
ckages/pip/_vendor/pyproject_hooks/_impl.py", line 402, in _call_hook
>       raise BackendUnavailable(
>   pip._vendor.pyproject_hooks._impl.BackendUnavailable: Cannot import 'se=
tuptools.build_meta'
>   mkvenv did not complete successfully:
>   Traceback (most recent call last):
>     File "/home/qemu/qemu-test.lk7TCA/src/python/scripts/mkvenv.py", line=
 965, in main
>       ensure_group(
>     File "/home/qemu/qemu-test.lk7TCA/src/python/scripts/mkvenv.py", line=
 859, in ensure_group
>       result =3D _do_ensure(to_install, online, wheels_dir)
>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/home/qemu/qemu-test.lk7TCA/src/python/scripts/mkvenv.py", line=
 801, in _do_ensure
>       pip_install(
>     File "/home/qemu/qemu-test.lk7TCA/src/python/scripts/mkvenv.py", line=
 689, in pip_install
>       subprocess.run(
>     File "/usr/local/lib/python3.12/subprocess.py", line 571, in run
>       raise CalledProcessError(retcode, process.args,
>   subprocess.CalledProcessError: Command '['/home/qemu/qemu-test.lk7TCA/b=
uild/pyvenv/bin/python3', '-m', 'pip', 'install', '--disable-pip-version-ch=
eck', '-q', '--no-index', '--find-links', '/home/qemu/qemu-test.lk7TCA/src/=
python/wheels', '--no-build-isolation', '-e', '/home/qemu/qemu-test.lk7TCA/=
src/python']' returned non-zero exit status 2.
>   Connection to 127.0.0.1 closed.
>   DEBUG:qemu.machine.machine:Shutting down VM appliance; timeout=3D90
>   DEBUG:qemu.machine.machine:Attempting graceful termination
>   DEBUG:qemu.machine.machine:Closing console socket
>   DEBUG:qemu.machine.machine:Politely asking QEMU to terminate
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:--> {
>     "execute": "quit"
>   }
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:<-- {
>     "timestamp": {
>       "seconds": 1770671483,
>       "microseconds": 668804
>     },
>     "event": "NIC_RX_FILTER_CHANGED",
>     "data": {
>       "path": "/machine/peripheral-anon/device[0]/virtio-backend"
>     }
>   }
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:<-- {
>     "timestamp": {
>       "seconds": 1770671497,
>       "microseconds": 530684
>     },
>     "event": "SHUTDOWN",
>     "data": {
>       "guest": false,
>       "reason": "host-qmp-quit"
>     }
>   }
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:<-- {
>     "return": {}
>   }
>   INFO:qemu.qmp.protocol.7f9dfba48ec0:Task.Reader: EOFError
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Task.Reader: failure:
>     | Traceback (most recent call last):
>     |   File "/home/alex/lsrc/qemu.git/vm-venv/lib/python3.13/site-packag=
es/qemu/qmp/protocol.py", line 914, in _bh_loop_forever
>     |     await async_fn()
>     |   File "/home/alex/lsrc/qemu.git/vm-venv/lib/python3.13/site-packag=
es/qemu/qmp/protocol.py", line 952, in _bh_recv_message
>     |     msg =3D await self._recv()
>     |           ^^^^^^^^^^^^^^^^^^
>     |   File "/home/alex/lsrc/qemu.git/vm-venv/lib/python3.13/site-packag=
es/qemu/qmp/protocol.py", line 1053, in _recv
>     |     message =3D await self._do_recv()
>     |               ^^^^^^^^^^^^^^^^^^^^^
>     |   File "/home/alex/lsrc/qemu.git/vm-venv/lib/python3.13/site-packag=
es/qemu/qmp/qmp_client.py", line 459, in _do_recv
>     |     msg_bytes =3D await self._readline()
>     |                 ^^^^^^^^^^^^^^^^^^^^^^
>     |   File "/home/alex/lsrc/qemu.git/vm-venv/lib/python3.13/site-packag=
es/qemu/qmp/protocol.py", line 1021, in _readline
>     |     raise EOFError
>     | EOFError
>
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Transitioning from 'Runstate.RUNNI=
NG' to 'Runstate.DISCONNECTING'.
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Scheduling disconnect.
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Task.Reader: exiting.
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Cancelling writer task.
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Waiting for tasks to complete ...
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:disconnect() called.
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Task.Writer: cancelled.
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Task.Writer: exiting.
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Closing StreamWriter.
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Waiting for StreamWriter to close =
...
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:StreamWriter closed.
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Disconnected.
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:QMP Disconnected.
>   DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Transitioning from 'Runstate.DISCO=
NNECTING' to 'Runstate.IDLE'.
>   DEBUG:qemu.machine.machine:Waiting (timeout=3D90) for QEMU process (pid=
=3D2646179) to terminate
>   DEBUG:qemu.machine.machine:Cleaning up after VM process
>   make: *** [tests/vm/Makefile.include:121: vm-build-openbsd] Error 3
>
> Hmm maybe that failure is in the build itself...
>
> > +
> > +$(VM_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
> > +             /usr/bin/env python3 $(SRC_PATH)/python/scripts/mkvenv.py=
 create vm-venv
> > +             $(SRC_PATH)/vm-venv/bin/python3 $(SRC_PATH)/python/script=
s/mkvenv.py ensuregroup --online $(SRC_PATH)/pythondeps.toml tooling functe=
sts
> > +
> > +.PHONY: vm-venv
> > +vm-venv: $(VM_VENV_TOKEN)
> > +# end hackery
> > +
> >  .PHONY: vm-build-all vm-clean-all
> >
> >  EFI_AARCH64 =3D $(wildcard $(BUILD_DIR)/pc-bios/edk2-aarch64-code.fd)
> > @@ -102,7 +112,7 @@ $(IMAGES_DIR)/%.img:      $(SRC_PATH)/tests/vm/% \
> >               $(if $(LOG_CONSOLE),--log-console) \
> >               --source-path $(SRC_PATH) \
> >               --image "$@" \
> > -             $(if $(filter-out check-venv, $?), --force) \
> > +             --force \
> >               --build-image $@, \
> >               "  VM-IMAGE $*")
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

Before patch:

vm-build-freebsd: OK
vm-build-openbsd: OK
vm-build-netbsd: fails

after patch **with recent upstream testing fix applied**:

vm-build-freebsd: OK
vm-build-openbsd: fails (!)
vm-build-netbsd: still fails.

... Oops! This is a genuine oversight, the openbsd package needs
"py3-setuptools" added to its pkg list. I will correct that and do
some more testing.


