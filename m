Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9896E94607
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 21:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpYpT-00075U-QC; Mon, 09 Feb 2026 16:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vpYpS-000756-1y
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 16:29:58 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vpYpP-0005Jn-CJ
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 16:29:57 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-653780e9eb3so166987a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 13:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770672593; x=1771277393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQR6DXJmNhE6nvINFAipdW4ooh65QhuW3BopxiLShro=;
 b=gondNOFda4SVOxaWpHEDMZjx4vjk/DrXepd+4tDmG0Qqo/3CWv97p76voQjf87lO9R
 MnCts1Q4+rBlarE6n/1V5wzR9mn6ZXLEFhEToNhv/Pd8W6QHh4B91CfCkR5jfLcI0XgK
 xrdxczDzrRJjOk7jkvPFyjK5OcuSqwsCL9ar67z8wcriFaBU7zFXaZIRV0w7Fm7AhK4x
 j/9sdCdeuagVQNtoF6i0a5S/qBd8rDLoRtFbPt3Iyd34jOsAgv52CCVUXFJPDbpkyUrJ
 o2pK0WjxQIknl2SID2oanv6SN7ND5/A3IK4Yk8uystzhgcsAO8gZeftKvgwrcDNRYKXL
 vUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770672593; x=1771277393;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xQR6DXJmNhE6nvINFAipdW4ooh65QhuW3BopxiLShro=;
 b=gjjw6mY3MrgU9EVRzUHQRY4ZgtiYkBhyV0DKVAQBD4IB1hLUOwQKm3Y26JPqV+sCf7
 gGE4Q0Q0N1g6WrayGfk1TxmGAvOdMrKMjGOUeSdbWtNZdd7DL4hex/sJpOSVcQZuN2A5
 ENtyGa0Qx7iS65OcNxa45DlpbqFVldLAEUh/8vRJZRJ3A0v2y1ykfLn7kYVi+y9EA2r0
 r9bse2oCvkcLSc7ww4+CV6TuZRfq77CFYtMlhY3b/Q1wQz6QWu4Yf2h7x7SkBwJFP+Uh
 PSzIPAxaBtlA1PFvE55RLmQKwgZVqvSZ7onjjJh+ysNoXD0Rgx+wcsQ+RBPKGcHKsqjM
 n0/Q==
X-Gm-Message-State: AOJu0YwMgWN4tfYkpl5Goqz3ycIK5Bt4qnWHpqspFptGp/1FlFY6qF0u
 xI7rKKuScrpVJx9zBy7tlICIqCLrGUzlSjy/GfxtG38oySyddQy/K2NPzt2C2omNP+M=
X-Gm-Gg: AZuq6aJkHdzAlUz7Y92kVx7DmPzLmwbiv0uHQu+DQA41IF+tqRbnWAmY8utzkE36Z5e
 mKnoi9zdp/ycaj9w/r/QjuBLDWXtYkU5cXMbkRXAPebTRmw925OSd9hWJXa152Mv8SKQVby62T+
 2fGmMTNPBjCR/DUEgk2O043ORFpY5u5Qh483yv0gVTG8LxVvfCkpZz2iH5x+ogqzhqn2MCLTBrO
 rv9O+DWvstL5lTVNSvJTs91UM28qkUVB3DdHJdcz9jR/718iS0H9U0NL+StdryMzqWmUdC2AICD
 QiOU9ZDWNDPDC/Fggev0DZJt/nGKad0XfhOhKaOr5KL25tMm8v50HVg1cd79ietGYrYJKZJ6SJj
 72f6XP7+Vzkca7Y+P7BJ2+qaEw1uHzCWYfuIMHCV2ygfblqrNSlYOWdEfQ85jcmJoNLOR/iCGt2
 jTlVQHkL4XCtg=
X-Received: by 2002:a17:906:c10c:b0:b8a:f225:ede8 with SMTP id
 a640c23a62f3a-b8edf3498e0mr751333966b.41.1770672592885; 
 Mon, 09 Feb 2026 13:29:52 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6598400f182sm3332157a12.20.2026.02.09.13.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 13:29:52 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3D6295F810;
 Mon, 09 Feb 2026 21:29:51 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Maksim Davydov <davydov-max@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,  Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  Peter Xu <peterx@redhat.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?rc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Ed Maste <emaste@freebsd.org>,  Li-Wen Hsu
 <lwhsu@freebsd.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  qemu-block@nongnu.org
Subject: Re: [PATCH v6 13/16] tests: replace check-venv with vm-venv target
In-Reply-To: <20260209184124.1263625-14-jsnow@redhat.com> (John Snow's message
 of "Mon, 9 Feb 2026 13:41:20 -0500")
References: <20260209184124.1263625-1-jsnow@redhat.com>
 <20260209184124.1263625-14-jsnow@redhat.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Mon, 09 Feb 2026 21:29:51 +0000
Message-ID: <87v7g5y59s.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

John Snow <jsnow@redhat.com> writes:

> With the qemu.qmp and qemu.machine dependencies now installed by default
> at configure time and additional dependencies required by functional
> testing installed on demand, we do not need the explicit "check-venv" tar=
get.
>
> ...However, to facilitate running VM tests without running configure, we
> move some of the former logic into tests/vm/Makefile.include to create a
> new venv (vm-venv) on-demand when running VM tests from the source tree.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/Makefile.include    | 22 ++--------------------
>  tests/vm/Makefile.include | 18 ++++++++++++++----
>  2 files changed, 16 insertions(+), 24 deletions(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index f28c9e329aa..2a203e23718 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -21,7 +21,6 @@ ifneq ($(filter $(all-check-targets), check-softfloat),)
>  endif
>  	@echo
>  	@echo " $(MAKE) check-report.junit.xml   Generates an aggregated XML te=
st report"
> -	@echo " $(MAKE) check-venv               Creates a Python venv for test=
s"
>  	@echo " $(MAKE) check-clean              Clean the tests and related da=
ta"
>  	@echo
>  	@echo "The following are useful for CI builds"
> @@ -92,33 +91,16 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>  .PHONY: distclean-tcg
>  distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
>=20=20
> -# Python venv for running tests
> -
> -.PHONY: check-venv
> -
>  # Build up our target list from the filtered list of ninja targets
>  TARGETS=3D$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja-targe=
ts)))
>=20=20
> -TESTS_VENV_TOKEN=3D$(BUILD_DIR)/pyvenv/tests.group
> -
> -quiet-venv-pip =3D $(quiet-@)$(call quiet-command-run, \
> -    $(PYTHON) -m pip -q --disable-pip-version-check $1, \
> -    "VENVPIP","$1")
> -
> -$(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
> -	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
> -	$(MKVENV_ENSUREGROUP) $< tooling functests
> -	$(call quiet-command, touch $@)
> -
> -check-venv: $(TESTS_VENV_TOKEN)
> -
>  FUNCTIONAL_TARGETS=3D$(patsubst %-softmmu,check-functional-%, $(filter %=
-softmmu,$(TARGETS)))
>  .PHONY: $(FUNCTIONAL_TARGETS)
> -$(FUNCTIONAL_TARGETS): check-venv
> +$(FUNCTIONAL_TARGETS):
>  	@$(MAKE) SPEED=3Dthorough $(subst -functional,-func,$@)
>=20=20
>  .PHONY: check-functional
> -check-functional: check-venv
> +check-functional:
>  	@$(NINJA) precache-functional
>  	@$(PYTHON) $(SRC_PATH)/scripts/clean_functional_cache.py
>  	@QEMU_TEST_NO_DOWNLOAD=3D1 $(MAKE) SPEED=3Dthorough check-func check-fu=
nc-quick
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 14188bba1c6..217bc706c20 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -2,13 +2,23 @@
>=20=20
>  # Hack to allow running in an unconfigured build tree
>  ifeq ($(realpath $(SRC_PATH)),$(realpath .))
> -VM_PYTHON =3D PYTHONPATH=3D$(SRC_PATH)/python /usr/bin/env python3
> -VM_VENV =3D
> +VM_PYTHON =3D $(SRC_PATH)/vm-venv/bin/python3
> +VM_VENV =3D vm-venv
>  else
>  VM_PYTHON =3D $(PYTHON)
> -VM_VENV =3D check-venv
> +VM_VENV =3D
>  endif
>=20=20
> +VM_VENV_TOKEN=3D$(SRC_PATH)/vm-venv/tooling.group $(SRC_PATH)/vm-venv/fu=
nctests.group

Which group should the following be fixed in?

  make vm-build-openbsd V=3D1

leads too:

  DEBUG:root:ssh_cmd: ssh -t -o StrictHostKeyChecking=3Dno -o UserKnownHost=
sFile=3D/dev/null -o ConnectTimeout=3D1 -p 34187 -i /home/alex/lsrc/qemu.gi=
t/vm-test-0fzv014h.tmp/id_rsa -o IdentitiesOnly=3Dyes -o SendEnv=3Dhttps_pr=
oxy -o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o SendEnv=3Dno_proxy qe=
mu@127.0.0.1
          set -e;
          rm -rf /home/qemu/qemu-test.*
          cd $(mktemp -d /home/qemu/qemu-test.XXXXXX);
          mkdir src build; cd src;
          tar -xf /dev/rsd1c;
          cd ../build;
          ../src/configure --cc=3Dcc  --extra-cflags=3D-I/usr/local/include=
                          --extra-ldflags=3D-L/usr/local/lib ;
          gmake --output-sync -j16 all check V=3D1;

  Warning: Permanently added '[127.0.0.1]:34187' (ED25519) to the list of k=
nown hosts.
  python determined to be '/usr/local/bin/python3'
  python version: Python 3.12.11
  mkvenv: Creating non-isolated virtual environment at 'pyvenv'
  mkvenv: checking for meson>=3D1.5.0
  mkvenv: checking for pycotap>=3D1.1.0
  mkvenv: checking for qemu.qmp>=3D0.0.5
  mkvenv: installing meson=3D=3D1.10.0, pycotap=3D=3D1.3.1, qemu.qmp=3D=3D0=
.0.5
  mkvenv: installing /home/qemu/qemu-test.lk7TCA/src/python
  ERROR: Exception:
  Traceback (most recent call last):
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/cli/base_command.py", line 106, in _run_wrapper
      status =3D _inner_run()
               ^^^^^^^^^^^^
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/cli/base_command.py", line 97, in _inner_run
      return self.run(options, args)
             ^^^^^^^^^^^^^^^^^^^^^^^
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/cli/req_command.py", line 67, in wrapper
      return func(self, options, args)
             ^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/commands/install.py", line 386, in run
      requirement_set =3D resolver.resolve(
                        ^^^^^^^^^^^^^^^^^
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/resolution/resolvelib/resolver.py", line 76, in resolve
      collected =3D self.factory.collect_root_requirements(root_reqs)
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/resolution/resolvelib/factory.py", line 545, in collect_=
root_requirements
      reqs =3D list(
             ^^^^^
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/resolution/resolvelib/factory.py", line 501, in _make_re=
quirements_from_install_req
      cand =3D self._make_base_candidate_from_link(
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/resolution/resolvelib/factory.py", line 212, in _make_ba=
se_candidate_from_link
      self._editable_candidate_cache[link] =3D EditableCandidate(
                                             ^^^^^^^^^^^^^^^^^^
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/resolution/resolvelib/candidates.py", line 329, in __ini=
t__
      super().__init__(
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/resolution/resolvelib/candidates.py", line 159, in __ini=
t__
      self.dist =3D self._prepare()
                  ^^^^^^^^^^^^^^^
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/resolution/resolvelib/candidates.py", line 236, in _prep=
are
      dist =3D self._prepare_distribution()
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/resolution/resolvelib/candidates.py", line 339, in _prep=
are_distribution
      return self._factory.preparer.prepare_editable_requirement(self._ireq)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/operations/prepare.py", line 698, in prepare_editable_re=
quirement
      dist =3D _get_prepared_distribution(
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/operations/prepare.py", line 72, in _get_prepared_distri=
bution
      abstract_dist.prepare_distribution_metadata(
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/distributions/sdist.py", line 69, in prepare_distributio=
n_metadata
      self.req.prepare_metadata()
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/req/req_install.py", line 567, in prepare_metadata
      and self.supports_pyproject_editable
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/usr/local/lib/python3.12/functools.py", line 998, in __get__
      val =3D self.func(instance)
            ^^^^^^^^^^^^^^^^^^^
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_internal/req/req_install.py", line 258, in supports_pyproject_edi=
table
      return "build_editable" in self.pep517_backend._supported_features()
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_vendor/pyproject_hooks/_impl.py", line 180, in _supported_features
      return self._call_hook("_supported_features", {})
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/home/qemu/qemu-test.lk7TCA/build/pyvenv/lib/python3.12/site-pack=
ages/pip/_vendor/pyproject_hooks/_impl.py", line 402, in _call_hook
      raise BackendUnavailable(
  pip._vendor.pyproject_hooks._impl.BackendUnavailable: Cannot import 'setu=
ptools.build_meta'
  mkvenv did not complete successfully:
  Traceback (most recent call last):
    File "/home/qemu/qemu-test.lk7TCA/src/python/scripts/mkvenv.py", line 9=
65, in main
      ensure_group(
    File "/home/qemu/qemu-test.lk7TCA/src/python/scripts/mkvenv.py", line 8=
59, in ensure_group
      result =3D _do_ensure(to_install, online, wheels_dir)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/home/qemu/qemu-test.lk7TCA/src/python/scripts/mkvenv.py", line 8=
01, in _do_ensure
      pip_install(
    File "/home/qemu/qemu-test.lk7TCA/src/python/scripts/mkvenv.py", line 6=
89, in pip_install
      subprocess.run(
    File "/usr/local/lib/python3.12/subprocess.py", line 571, in run
      raise CalledProcessError(retcode, process.args,
  subprocess.CalledProcessError: Command '['/home/qemu/qemu-test.lk7TCA/bui=
ld/pyvenv/bin/python3', '-m', 'pip', 'install', '--disable-pip-version-chec=
k', '-q', '--no-index', '--find-links', '/home/qemu/qemu-test.lk7TCA/src/py=
thon/wheels', '--no-build-isolation', '-e', '/home/qemu/qemu-test.lk7TCA/sr=
c/python']' returned non-zero exit status 2.
  Connection to 127.0.0.1 closed.
  DEBUG:qemu.machine.machine:Shutting down VM appliance; timeout=3D90
  DEBUG:qemu.machine.machine:Attempting graceful termination
  DEBUG:qemu.machine.machine:Closing console socket
  DEBUG:qemu.machine.machine:Politely asking QEMU to terminate
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:--> {
    "execute": "quit"
  }
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:<-- {
    "timestamp": {
      "seconds": 1770671483,
      "microseconds": 668804
    },
    "event": "NIC_RX_FILTER_CHANGED",
    "data": {
      "path": "/machine/peripheral-anon/device[0]/virtio-backend"
    }
  }
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:<-- {
    "timestamp": {
      "seconds": 1770671497,
      "microseconds": 530684
    },
    "event": "SHUTDOWN",
    "data": {
      "guest": false,
      "reason": "host-qmp-quit"
    }
  }
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:<-- {
    "return": {}
  }
  INFO:qemu.qmp.protocol.7f9dfba48ec0:Task.Reader: EOFError
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Task.Reader: failure:
    | Traceback (most recent call last):
    |   File "/home/alex/lsrc/qemu.git/vm-venv/lib/python3.13/site-packages=
/qemu/qmp/protocol.py", line 914, in _bh_loop_forever
    |     await async_fn()
    |   File "/home/alex/lsrc/qemu.git/vm-venv/lib/python3.13/site-packages=
/qemu/qmp/protocol.py", line 952, in _bh_recv_message
    |     msg =3D await self._recv()
    |           ^^^^^^^^^^^^^^^^^^
    |   File "/home/alex/lsrc/qemu.git/vm-venv/lib/python3.13/site-packages=
/qemu/qmp/protocol.py", line 1053, in _recv
    |     message =3D await self._do_recv()
    |               ^^^^^^^^^^^^^^^^^^^^^
    |   File "/home/alex/lsrc/qemu.git/vm-venv/lib/python3.13/site-packages=
/qemu/qmp/qmp_client.py", line 459, in _do_recv
    |     msg_bytes =3D await self._readline()
    |                 ^^^^^^^^^^^^^^^^^^^^^^
    |   File "/home/alex/lsrc/qemu.git/vm-venv/lib/python3.13/site-packages=
/qemu/qmp/protocol.py", line 1021, in _readline
    |     raise EOFError
    | EOFError

  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Transitioning from 'Runstate.RUNNING=
' to 'Runstate.DISCONNECTING'.
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Scheduling disconnect.
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Task.Reader: exiting.
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Cancelling writer task.
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Waiting for tasks to complete ...
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:disconnect() called.
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Task.Writer: cancelled.
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Task.Writer: exiting.
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Closing StreamWriter.
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Waiting for StreamWriter to close ...
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:StreamWriter closed.
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Disconnected.
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:QMP Disconnected.
  DEBUG:qemu.qmp.protocol.7f9dfba48ec0:Transitioning from 'Runstate.DISCONN=
ECTING' to 'Runstate.IDLE'.
  DEBUG:qemu.machine.machine:Waiting (timeout=3D90) for QEMU process (pid=
=3D2646179) to terminate
  DEBUG:qemu.machine.machine:Cleaning up after VM process
  make: *** [tests/vm/Makefile.include:121: vm-build-openbsd] Error 3

Hmm maybe that failure is in the build itself...

> +
> +$(VM_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
> +		/usr/bin/env python3 $(SRC_PATH)/python/scripts/mkvenv.py create vm-ve=
nv
> +		$(SRC_PATH)/vm-venv/bin/python3 $(SRC_PATH)/python/scripts/mkvenv.py e=
nsuregroup --online $(SRC_PATH)/pythondeps.toml tooling functests
> +
> +.PHONY: vm-venv
> +vm-venv: $(VM_VENV_TOKEN)
> +# end hackery
> +
>  .PHONY: vm-build-all vm-clean-all
>=20=20
>  EFI_AARCH64 =3D $(wildcard $(BUILD_DIR)/pc-bios/edk2-aarch64-code.fd)
> @@ -102,7 +112,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
>  		$(if $(LOG_CONSOLE),--log-console) \
>  		--source-path $(SRC_PATH) \
>  		--image "$@" \
> -		$(if $(filter-out check-venv, $?), --force) \
> +		--force \
>  		--build-image $@, \
>  		"  VM-IMAGE $*")

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

