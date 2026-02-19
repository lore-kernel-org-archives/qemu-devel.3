Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D65E9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9Nv-0003T2-GN; Thu, 19 Feb 2026 14:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vt9Np-0003SA-NC
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:08:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vt9Nm-0005De-JH
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771528092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rX3Txn1xk7hCRYo2nyBsBQQXxfF+QmYQ3H/ugfMi+ac=;
 b=EvmVtiXp5eMGDBMSNjfd52b9v6bKdpCLhXYW/zXOmt2wsaUmiZmtJj6NDTaIbNrlVr4S8A
 dxdQTuZUB5QOtQg5/jA9t3x+DxYr52azxQdHeL6NIZViNtUjfIbPHn5q/NxophA/xL/LwC
 6TjEz4mQmS9r7ar6qYHAsZyU7Z2AuZU=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-8BqlpQHsMkylJORslcW2Bg-1; Thu, 19 Feb 2026 14:08:10 -0500
X-MC-Unique: 8BqlpQHsMkylJORslcW2Bg-1
X-Mimecast-MFC-AGG-ID: 8BqlpQHsMkylJORslcW2Bg_1771528090
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-649df163c11so1919541d50.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:08:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771528090; cv=none;
 d=google.com; s=arc-20240605;
 b=JC/4fsTC+U0UcisI6z4YXIbscwTBlFGitYbtEOID0b+qKb9zfamMA4q3tcmHJFaYGf
 1FiJzPLCZLv7RRRcBDYE4MLDYlTV9ABbQMdl9Q4HrsD361NcqCqGtHIMRUHIRx71lGJm
 4NmrYBfpvyAl9wcVC0ZKUUOYuUn7836bMoZabqj0xEVE32EgLsQq4iddHbGcz3mdZGFI
 dvExJdbk5FM7eW9lGmRkkEeEqHPXKpIweD+P0L9Xyl2THfCR856iKTVQJnVmCcN4LMGI
 XRjAYMh2JCeY0OwmGqXvhuKGUT3CzEms+2yWVl8zZjCHHDvi3ZDkoTFiHFm75yDv2qrb
 RIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rX3Txn1xk7hCRYo2nyBsBQQXxfF+QmYQ3H/ugfMi+ac=;
 fh=LRxVxKnmrNcZh5zYEfRraAIukbJ3EKy4GpKn7Y41+Ro=;
 b=TMpy8C0NL0qVT3q3BujD73vUSqNHwQ5GLlVK3q3EREIocH2JbzMRRsCTlAVqRkTx27
 VLJVcSUbHL11MuyvFaALnxzoiHfb/ffFh93pTfdHG65O39ATptmsdlZDAPFPtI8dz/MB
 7EENvh36luD9N2MUAHkjrJipa5rWaiXOwCQktgiCuWwzr50APIVCEdJSnLnjztzGFYdV
 j8/Vu3vBdldbQg0K+TBbY564J7GH1HE2UbAvr06kt+mh8/IcBo+bHVN2bp33U4twUkLs
 6UWqLod1lV2eCxIyHAMbQ5A/r+syBYWXEGzlAXplPn/4cXbXo/fERHBvMY+SANMJe8gL
 diNQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771528090; x=1772132890; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rX3Txn1xk7hCRYo2nyBsBQQXxfF+QmYQ3H/ugfMi+ac=;
 b=cUXKbDy7DMfBBz+1smKen1MkdoBIcq98S0CffMOLvRq1fy7k3V29NmHWzNYu3vWklu
 OjJ1IHOdxRAISdFQb5LF0B7j28VH0zDy+OQapMWHFfHVd03zUyllUECbnEXpMJmIG8hT
 ircmpdVl8w4gK5PMLVYROKmXUC1tvL4toyvTNVsGrvtK9UpNXHldNc/LYuxqbcUVfENQ
 44A+kOqU3FExmVl04hDe13qYoaNKmk8Ap9jpBafbxET02LTKZJMrvr1O05Cbs+ZYrAUB
 6pT1gYB91Qm43zAqK8OPH/VLiVJU/Z6gGq47HbRUsmRi2z3tOrZX0CAsljMNlTpyjUdE
 azzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528090; x=1772132890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rX3Txn1xk7hCRYo2nyBsBQQXxfF+QmYQ3H/ugfMi+ac=;
 b=PuZ5BC+yem1f7+QotJ9ENG29FaS799ZG+ob7CtCNtVc1VN+TXrvbbhqnAM6uSX2L6w
 1vR5LlWTT09v6qZxkVLHsXgtZ8u8nXUS/dYWjPoafnKs7OzWrSaCiKPRw9hpOcKBG8J9
 JA/N+NDN8aBHgXAzar2y3Nt5tWOmYnkz6QDxtoR2INd0orFsTZA06gdheX9tK/38//fi
 vUtjvV1ANYRKgqbrxrYkMjjm8qoqZwl5h32mxHWC+6yJjbes4mNJXeWZQ+GzdVGyqFnW
 4We0IA0IcbIEM2UvY1+TMiCnC5zn+7sqky9+q8FjpfP4ONE4KqLzw6dKlSlWfWwQzKVu
 uPCw==
X-Gm-Message-State: AOJu0YySeMeTf/1f1xcj2Ka6FIumkWtHHTCkF+RLNb2gPbaQBfaAVK8f
 JnYtD4U/grp6nP/uDpd+8QgQ7KwsoCztu6BAUfvp0rT7/FioVzmj0ReJxsl3f55LqqrKGMsCG7Y
 AvRhx/CXBNV7yAwRHZq0G1XdbYsXfv9YoYr1cU+NlAnNSMYAUECBF0caLWGBSa4H8oN6lLOjzed
 MXmmn9QCUNwRALTmZpvviCLLOuHkmQNVPGEkVw+lnWGQ==
X-Gm-Gg: AZuq6aKdKdHwS5rJNwOvnzyMe1zHGic6Hxtp2CZyDbhalse74EZg9kIq0zL1O1eEli4
 scJb57BUxgjBvWs5nE1d1omsqR1vScUTksYjTNMHLvFBThMOPKMkAi5ZumTz38PuaMppsKmxzhq
 l3DqEOHtAGwdIrO04Kx2GScE9ZDq9X73jIoK7mwEK+lLYHJJU3jD1JSUGXYB7jRFA1AIyC94QFP
 2TBOEqtWHnbN3nvbnfZECUa0o15zKOdXOVfmg==
X-Received: by 2002:a53:c044:0:10b0:649:cd05:c518 with SMTP id
 956f58d0204a3-64c14d39c0emr15696380d50.44.1771528089817; 
 Thu, 19 Feb 2026 11:08:09 -0800 (PST)
X-Received: by 2002:a53:c044:0:10b0:649:cd05:c518 with SMTP id
 956f58d0204a3-64c14d39c0emr15696355d50.44.1771528089435; Thu, 19 Feb 2026
 11:08:09 -0800 (PST)
MIME-Version: 1.0
References: <20260218213416.674483-1-jsnow@redhat.com>
In-Reply-To: <20260218213416.674483-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 19 Feb 2026 14:07:58 -0500
X-Gm-Features: AaiRm53JEhk1-Wm7tflMY3qvqt3PV-ZUOh8FPTWyY1SUXBjPECpi57p-bLOzsFs
Message-ID: <CAFn=p-a8nsocxGvJSqhV5-shpZ+pSJLoc6iUe2Aft+md6bH2Kw@mail.gmail.com>
Subject: Re: [PATCH v8 00/20] python: drop qemu.qmp from qemu.git tree
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>, 
 Hanna Reitz <hreitz@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>, 
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Cleber Rosa <crosa@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Feb 18, 2026 at 4:34=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> Hello!
>
> This series drops the in-tree version of our python-qemu-qmp package
> ("qemu.qmp") in favor of the version hosted on PyPI, whose repository is
> located at https://gitlab.com/qemu-project/python-qemu-qmp.
>
> GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2335222126
>
> The major effects of this patch series are:
>
> 1. qemu.qmp and the python/ directory will be installed to the
>    configure-time venv (build/pyvenv) by default.
> 2. qemu.qmp will be installed from PyPI or vendored packages instead of
>    being utilized directly from the qemu.git tree.
> 3. "make check-venv" is removed as it is no longer needed.
> 4. functional test dependencies are installed as-needed when running
>    those tests.
> 5. Unfortunately, python3-wheel and python3-setuptools are now required
>    on the host system if tests are to be executed and >=3D Python 3.13 is
>    used.
> 6. An awful lot of deleted lines of code, and a lot fewer headaches
>    managing two nearly-identical copies of this source code. O:-)
>
> v8:
>
>  - lcitool update patch(es):
>    - Fixed netbsd VM test
>    - Half-fixed Haiku VM test;
>      test fails now for reasons other than this patchset
>  - New patch; added compatibility for iotests ./check to run outside of
>    the venv, while tests will still run inside the venv, as a
>    transitional lubricant for block maintainer workflow (Thanks, Kevin!)
>  - I really think this is it, any other small change requests I think
>    should be addressed as follow-up patches at this point. Otherwise,
>    it's going to get out of hand...
>
> Note 1: The lcitool upgrade causes a failure in check-rust-tools-nightly
> (which is allowed to fail), and a separate standalone fix for this issue
> has been sent as
> https://patchew.org/QEMU/20260218192444.658046-1-jsnow@redhat.com/
>
> Note 2: This series does not fix the currently failing check-python-tox
> test (also allowed to fail), which is fixed separately in
> https://patchew.org/QEMU/20260217051112.446957-1-jsnow@redhat.com/
>
> Note 3: This series works around, but does not fix, the fact that we are
> still utilizing Debian 11 for our CI infrastructure. That is rectified
> in another separate series;
> https://patchew.org/QEMU/20260218193116.659213-1-jsnow@redhat.com/ - The
> only difference this patch series would make to this series is the
> version numbers chosen in the 20th patch, which can be trivially updated
> later depending on merge order.

I intend to submit a pull request for this series tomorrow, barring
any complaints. Most of the feedback has been largely details, with no
major pushback to the general strategy and content of the series, so I
will instead vow to fix any lingering problems or feedback in
follow-ups given that VM tests and GitLab CI see no regressions; I
believe due diligence has been done. I apologize if this seems
hasty...!

Next steps for the Python Agenda are:

- Fix rust nightly test (Patch v2 posted)
- Drop avocado from qemu.git to fix python-check-tox (Series posted)
- Drop debian 11 from GitLab CI tests (Series posted)
- Collect any lingering fixes for qemu.qmp standalone repository,
modernize to 3.9+, and publish v0.0.6
- Bump qemu.qmp in qemu.git to v0.0.6
- Bump minimum Python version to 3.12* and Sphinx to 7.x in June, when
Debian 12 support is dropped.
- Perform a "flag day" of autoformatting and cleaning up our Python
code using modern type hint syntax and removing compatibility goop;
introduce the use of the 'black' autoformatter for Python code
- Finally Implement "make check-python" as a first-class, supported test.
- Drop iotest 293 in favor of "make check-python".


* Assuming FreeBSD upgrades to at least Python 3.12+ by then,
otherwise, Python 3.11.

Thanks,
--js


