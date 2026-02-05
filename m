Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C984CECD98C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo2qs-0000I1-DE; Thu, 05 Feb 2026 12:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vo2qr-0000HL-2W
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:09:09 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vo2qp-0005uU-4O
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:09:08 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6505cac9879so1504573a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770311344; x=1770916144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LgHxrvhRL8g50uucUbTkWEjxuVlftVqb/GlBSHvPo/k=;
 b=e0sDMxEZw2TPSXeM8yr6JnRfGoNabcf/IgCP4g7JW7aVgMwLD+R1Cv1YpHbWERESAq
 svme5CjjpTtN4DSDX6yFNtZsLl00MA7syPQwAonMnJlKDtuR8KisgDT+4Kl+g1bGH7AE
 nUNDUclhGAhG/R3G6KxbLTT+4bq9Y2ja2tYypdYk0UAM6XAvmwH0JQfHzB5fOhF1EsUR
 a2ccJsCuIjKCt0sMk5bbMySjebEy2HCyap7ITpSQeHAQTsomXUVG8dRJzdSJDvtRira/
 1qK6srOhMh0uGtDc8uXjH4XXd33mpAe0Ia9yYlER+VimIdHWCY8gwugQQ8v5t8xkdR89
 hFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770311344; x=1770916144;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LgHxrvhRL8g50uucUbTkWEjxuVlftVqb/GlBSHvPo/k=;
 b=dRFQs5AfG53EVkGywSR6rVx4/9dJqpCrPhMG1bJ/jf5ApUhSJxFS5x3j3LlaRDb21r
 PBy1J763/XhSMbebn+so3OlkluMMg1X9U+B9otrtDQhxKfRDdNJs+ZD0w7wi/83IxgQe
 bT1nhdSelVxftK+ZnTPlVKXsiLR23kUS3QhlXdfykQE2xZ4Z6Dm8IlivsMCAGV1JGthd
 1nbbo6g6V2irDShv5RDWU7uG2bqbRLgS/ppb6eJFn0d2L9eySz6DGsjXIiK1TwNJc2AW
 wOZS/Wrs3crq/a5XZuQdi1sU0g+47bqmAqcqmXxKZx+YICrA1qaBEaHE/6XWC3qI3S6K
 WAVw==
X-Gm-Message-State: AOJu0Yy9w5g49eykChd1yPj7oblyyk47oaGwobB8PuZOYwrBEXMastra
 W1sjQjWoNXscWY/aT1hV1i8CtoA9rSSQcscuP7t0W/n3aeS/cP386CVAN3WdYYgGMkE=
X-Gm-Gg: AZuq6aLOhMXcNEznx3m2BYiiyrsJhRm2Bo9vg7PEvwxfFK2VknS8vQv8P4k9BsnTf2C
 aKjRZVXHBG7Y6QcUIxvPilvsKjVlCYHPAjhS02YiPkKHXwlJ56YadAhM+cDAQBfohy+Qg1+Pz/t
 mlelHeRaTDuL3bRPDsnqIr/ZH14lj0P6I05khTx0Rr4kF29WX3WMvqqcYb5Dnz4C44yC0kaX6uV
 xXT8t9PIcwb5kDf+N7z5tRhN6Ww13h0Wv9NJqHCPcRnQcNgRRbgDZi+t2OaBFK/xTGFBgMbTamG
 eYvKQNXy7690yqZUEti8F3yOtnHm4IomgbwdlkLUG5M6IncC1/N4rPz2M3t29k6maNamFZX/oGn
 IHKaZkXStmv66wUl28jUlwNrK5gDbIgzLPhrxua1wqyuUaedeXkD2C5maesYeG9N6MQvrCzX/hU
 80M7VBN8OdgOg=
X-Received: by 2002:a05:6402:f22:b0:659:33df:c60d with SMTP id
 4fb4d7f45d1cf-65949abd86emr3819868a12.13.1770311344435; 
 Thu, 05 Feb 2026 09:09:04 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6594a2289cfsm2187952a12.24.2026.02.05.09.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:09:03 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AA5D75F825;
 Thu, 05 Feb 2026 17:09:02 +0000 (GMT)
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
In-Reply-To: <20260203203512.672552-14-jsnow@redhat.com> (John Snow's message
 of "Tue, 3 Feb 2026 15:35:08 -0500")
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-14-jsnow@redhat.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Thu, 05 Feb 2026 17:09:02 +0000
Message-ID: <87y0l7m829.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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
> testing installed on demand, there is no longer any reason to have an
> explicit target.
>
> FIXME: This forces image regeneration for vm tests whenever Make
> determines that the image needs to be rebuilt; which is a regression
> over the previous behavior.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/Makefile.include    | 22 ++--------------------
>  tests/vm/Makefile.include | 24 +++++++-----------------
>  2 files changed, 9 insertions(+), 37 deletions(-)
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
> index 14188bba1c6..095ec2eefa3 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -1,14 +1,5 @@
>  # Makefile for VM tests
>=20=20
> -# Hack to allow running in an unconfigured build tree
> -ifeq ($(realpath $(SRC_PATH)),$(realpath .))
> -VM_PYTHON =3D PYTHONPATH=3D$(SRC_PATH)/python /usr/bin/env python3
> -VM_VENV =3D
> -else
> -VM_PYTHON =3D $(PYTHON)
> -VM_VENV =3D check-venv
> -endif
> -

It's a shame to loose this because the build directory should have no
influence on what we build in the VM. Surely if we have qmp installed on
the system (and therefor its deps) we should still want the ability to
build in the src dir. Currently I get:

  =E2=9E=9C  make vm-build-netbsd V=3D1
  tests/vm/netbsd  --debug     --source-path . --image "/home/alex/.cache/q=
emu-vm/images/netbsd.img" --force --build-image /home/alex/.cache/qemu-vm/i=
mages/netbsd.img
  Traceback (most recent call last):
    File "/home/alex/lsrc/qemu.git/tests/vm/netbsd", line 19, in <module>
      import basevm
    File "/home/alex/lsrc/qemu.git/tests/vm/basevm.py", line 32, in <module>
      from qemu.machine import QEMUMachine
  ModuleNotFoundError: No module named 'qemu'
  make: *** [tests/vm/Makefile.include:86: /home/alex/.cache/qemu-vm/images=
/netbsd.img] Error 1

>  .PHONY: vm-build-all vm-clean-all
>=20=20
>  EFI_AARCH64 =3D $(wildcard $(BUILD_DIR)/pc-bios/edk2-aarch64-code.fd)
> @@ -90,11 +81,10 @@ vm-clean-all:
>=20=20
>  $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
>  			$(SRC_PATH)/tests/vm/basevm.py \
> -			$(SRC_PATH)/tests/vm/Makefile.include \
> -			$(VM_VENV)
> +			$(SRC_PATH)/tests/vm/Makefile.include
>  	@mkdir -p $(IMAGES_DIR)
>  	$(call quiet-command, \
> -		$(VM_PYTHON) $< \
> +		$(PYTHON) $< \
>  		$(if $(V)$(DEBUG), --debug) \
>  		$(if $(GENISOIMAGE),--genisoimage $(GENISOIMAGE)) \
>  		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
> @@ -102,14 +92,14 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
>  		$(if $(LOG_CONSOLE),--log-console) \
>  		--source-path $(SRC_PATH) \
>  		--image "$@" \
> -		$(if $(filter-out check-venv, $?), --force) \
> +		--force \

I think this is fine, as danp says if the deps are touched we should
re-build the VM.

>  		--build-image $@, \
>  		"  VM-IMAGE $*")
>=20=20
>  # Build in VM $(IMAGE)
> -vm-build-%: $(IMAGES_DIR)/%.img $(VM_VENV)
> +vm-build-%: $(IMAGES_DIR)/%.img
>  	$(call quiet-command, \
> -		$(VM_PYTHON) $(SRC_PATH)/tests/vm/$* \
> +		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
>  		$(if $(V)$(DEBUG), --debug) \
>  		$(if $(DEBUG), --interactive) \
>  		$(if $(J),--jobs $(J)) \
> @@ -133,9 +123,9 @@ vm-boot-serial-%: $(IMAGES_DIR)/%.img
>  		-device virtio-net-pci,netdev=3Dvnet \
>  	|| true
>=20=20
> -vm-boot-ssh-%: $(IMAGES_DIR)/%.img $(VM_VENV)
> +vm-boot-ssh-%: $(IMAGES_DIR)/%.img
>  	$(call quiet-command, \
> -		$(VM_PYTHON) $(SRC_PATH)/tests/vm/$* \
> +		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
>  		$(if $(J),--jobs $(J)) \
>  		$(if $(V)$(DEBUG), --debug) \
>  		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

