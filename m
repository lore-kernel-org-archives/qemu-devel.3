Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9DAC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLyy-0004sh-K5; Thu, 17 Jul 2025 06:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ucLyx-0004qV-6s
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:36:55 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ucLyu-0001E6-8G
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:36:53 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso486335f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 03:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752748610; x=1753353410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwuNpPmxzGwb8R/Whlcr/GY3SicfNUIPsQQINOYciu4=;
 b=wJn/rN9HJxdxa26E3sdVlBvf7xtI2rh9Sp1Xu+2DHPLSb5qKgcDW4YYlMyeyXUbFos
 LRXUvtAnRTdSyN1VamSwtxxkOKeA1bIPLiNt/IqHm3L7/5N3+c7RqmTAi4mqqEUiB97g
 IWZkijs68FqNEg7vRjLLks7aZ1rSYhYHYt9HMaPmduRWyZvtR9rVD4kWWrV5dpbizMZo
 6kYLyHKUdj/puoZJ6fi7mpCfX/7Khc+uI3j2PtRIW8PmfwypkfPvQJaSXnFY/n7qWsrC
 7r+Ng8OlOHSFMw0nsw3LC3qn0lZ2THagPQrVUeucY1I2f4IADXFawfQwiFNTu8b2yG+U
 hn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752748610; x=1753353410;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kwuNpPmxzGwb8R/Whlcr/GY3SicfNUIPsQQINOYciu4=;
 b=r2MD0is9/QmnY25mb8HVxclUFxTicEV2Sz/q4lJ95AvD9vMRr++CtZRvVrjhM1cm6d
 D/SVurgNXa1YirSjq0hS96dauRDjMYxfEVdd65U8Vov2VpS+j5p6oFd9/N7h+vg804k7
 citwF32qJJegMrUmyqrqYRD0Qb7eqElNkhWP/rQzLppLm+bVckxNlL+n6UeQLI+4ULXa
 B6fbWJ/Q7KXqDnbsGR9tjhVldKki4/g7zC4WjR9WjmoqAhRRDvNzFzBfxVQgVNGxi9st
 Cz+DzB1R3vnuCnGwL9MimKtSCqrGXe9oaXQQOaBJfgrRicAS4ybaHuJ6+mxFKTZNyfn/
 vBgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXobFfTffGHebEs3VdslEyomnzDXmBvXWEZm05s6X5OgZJ+N4UhrcY1hE7gzAktyhDpf63O3U4OIwpN@nongnu.org
X-Gm-Message-State: AOJu0YwV+pNaQdTWJTjKxOuwmWGgjNojWZ5V/4EFqWH8HLxx2Ce0DgG1
 1AuqzxwaQbIRQZplTTYFrYOGmRBX/qe+yUfEW1bJSnicuwfjZt6SffBZmEIWqw2eVhg=
X-Gm-Gg: ASbGnctkezLagzPSNvcxqP98s9Hu8bQt2j55vypmZ2zJc1SGX36Eu35KGn26YspQXz3
 r1Z5EOgo5znEhualNXUPZRb7wNj2WZoF2PF1JKH3zANAJuj6i19PfNCRjsSeeP50MAckZSX1JDL
 DAu53LT7UvhZQ2SU03SSlZ/IhPlwURwdleIKVM1bt8zYXBbjZ9aYlnB6Sj9wGfWmsk8pVPkSYGx
 Cdzh2RNXgiUf5sBOpT2fxsGOhSTm9i22les03J+V8Hcxvz8dYGvUkx+vLg9BTWh9TXzXl/FZDq7
 mdsK86FQlwIj0t0j9lzlt7Q9tlo5DWhJERl2RuadpbaMgCLpvVBbK+ez7OcEOFa2IRp5up7w3an
 1CszrYAlJkqB9dw57Mh/5H3w=
X-Google-Smtp-Source: AGHT+IFQOeJ/UR6EbPhewdUzoDKZZSwigRxXMPzPkE8typoJINA/gOK2Ss28XI6yCyLJIdHiDpakfw==
X-Received: by 2002:a05:6000:460a:b0:3b5:dc04:3f59 with SMTP id
 ffacd0b85a97d-3b613e97badmr1654224f8f.37.1752748610064; 
 Thu, 17 Jul 2025 03:36:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1792sm20570226f8f.13.2025.07.17.03.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 03:36:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7328C5F812;
 Thu, 17 Jul 2025 11:36:48 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
In-Reply-To: <7924aab8-2d89-4b69-be5d-40ffb0c839a5@redhat.com> (Thomas Huth's
 message of "Thu, 17 Jul 2025 10:46:46 +0200")
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
 <87ms93xl69.fsf@draig.linaro.org>
 <7924aab8-2d89-4b69-be5d-40ffb0c839a5@redhat.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 17 Jul 2025 11:36:48 +0100
Message-ID: <875xfrxfwf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> On 17/07/2025 10.42, Alex Benn=C3=A9e wrote:
>> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>>=20
>>> Add argument parsing to functional tests to improve developer experience
>>> when running individual tests. All logs are printed to stdout
>>> interspersed with TAP output.
>>>
>>>    ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --help
>>>    usage: test_aarch64_virt [-h] [-d]
>> Am I holding it wrong?
>>    =E2=9E=9C  ./pyvenv/bin/python
>> ../../tests/functional/test_aarch64_virt.py --help
>>    Traceback (most recent call last):
>>      File "/home/alex/lsrc/qemu.git/builds/all/../../tests/functional/te=
st_aarch64_virt.py", line 16, in <module>
>>        from qemu_test import QemuSystemTest, Asset, exec_command_and_wai=
t_for_pattern
>>      File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/__init__.=
py", line 14, in <module>
>>        from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
>>      File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.=
py", line 26, in <module>
>>        from qemu.machine import QEMUMachine
>>    ModuleNotFoundError: No module named 'qemu'
>> I thought the point of the venv is we had all the modules we need
>> automatically available to the PYTHONPATH?
>
> The "qemu" module is special since we ship it in our repository. See
> the "PYTHONPATH" description in docs/devel/testing/functional.rst.

Is there anyway to setup the venv so it automatically does that?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

