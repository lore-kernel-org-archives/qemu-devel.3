Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845A5C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 07:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnYkS-0002QD-D7; Thu, 27 Feb 2025 02:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnYkO-0002Lf-4A
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:55:57 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnYkM-0008OM-Ah
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:55:55 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38f1e8efe84so186126f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 23:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740642952; x=1741247752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYNPWnV7+zrTid8Ih9GNWbvKspk66g8wle5T9oqpHXY=;
 b=x7Ys9kBa/c9oBVpwxrJfbpJL54/D+eHcOBsoj1ZMLJ78gnfMbtIuoI3vbENcBg2C79
 sNqgBwulkU5Y41G+VnCY61H2lLgM4j+seR2fcAcgHxEm2ZxmU3LrCxCWil6kgLnvw0c+
 2xfV2M1nJWHUhn7RN+510fAjwwRD2Ed4OU12CkFpEkcdsa/oxT2AkL/dGky+JzEOVXUT
 hR0JJjMW/unP6CPZzGNHbE3geBSmvcOa3hTpPST6NrNkb/QnUKl95iwkCEgetkAFCqbw
 gO+c4HuXyXPZgcf30+eWEe7HKsZxjAHW7WYLx5A2dSUA1f4L3VYw8kN95AC+qoe5FTXz
 DAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740642952; x=1741247752;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RYNPWnV7+zrTid8Ih9GNWbvKspk66g8wle5T9oqpHXY=;
 b=wKWKO3dfoY43CevZng2BOIwZqActhobPF0K3ADfy5lyeNReWpTwMNi7YKVQQlTVpnX
 N7MincaFofuqDUAE7j/ctkOGtbic+uHzq+9IA+ogDcMpn/VrIDNbG/JkqLesJYiGmtJU
 NIp6u56reTDvqF9LKJMdCxpW5rqBU1F8+rp2wRD3yj4NZ6JR5uQlxahCBJC5AJzwu4BY
 f0y+qmeR57flUZO7NoKhu4Ae6XG9Zr2olEjRxqOfcyMn491651HxtzgdCqGDIuxUfpuh
 hsWCDS1b6fMpSJWwBOwE7xdKyUsgKxV0VmMdSxSOj9pII+gtXDe1rGV4/D8srIqa8+Xi
 mpxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVqE5cXdgM25N6n8wDBuHvxYv8F/9ewz6N1Yb5t5KzHEtFm0m6PWV6lk10mWNavTXH9wWwqffFyx46@nongnu.org
X-Gm-Message-State: AOJu0YwE/s+IxKIXPXPcVEzHHGoJO/6dsRA8nLB6x4n67MFhbouABRSW
 ofLL8azVgTmm7/JyJz9FgB3xWtKrwTcmg6vVVTUxE8zLUMD+4vBNc470appqOZE=
X-Gm-Gg: ASbGncsg3Z5UaIXI5RJKz3HMszcvbjotBEdba5EXqhyB8JJfpwG1MhjT5zVXR4vAWcz
 uJduojves26014gyvjLwfEFK9OwxWWiO3fMbYwc3fpHiTSBFCPfp55inw5bijjovqB1L4XYjT5e
 IUxaCLD37Vj6L9vyP7pvaOOBrj4yfCzJFMPlHU9kMqM8wsg1uRO7Bcjk9qyf95Kn9ceGakbdTeE
 v/oU5quTlD8Aeo6B19Ilbg/sV41vZ3Nv7oWpQS8YpwSiyGSoKiTn9bkqkRbsYfr2pT8gW+IfAEX
 XRdu3FVmmD1RwOFS4S8ozV3EMbvf
X-Google-Smtp-Source: AGHT+IGscGA/m7nEYpR0lJKIR/7dmsurqnXBgPgibgF2vmkTk9St2HMtKbDT1AFAXTL+5fAsIL/3Gw==
X-Received: by 2002:a5d:5985:0:b0:38f:3ee5:fd36 with SMTP id
 ffacd0b85a97d-38f6f0af903mr22231461f8f.53.1740642952109; 
 Wed, 26 Feb 2025 23:55:52 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba532bbcsm45446275e9.11.2025.02.26.23.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 23:55:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 034DF5F8AB;
 Thu, 27 Feb 2025 07:55:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,  Stefan Weil <sw@weilnetz.de>,
 Alexandre Iooss <erdnaxe@crans.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  Yonggang Luo <luoyonggang@gmail.com>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2 2/3] tests/functional: Introduce the dso_suffix() helper
In-Reply-To: <7c7880f1-fd41-4e49-959d-6bbbb5689348@daynix.com> (Akihiko
 Odaki's message of "Thu, 27 Feb 2025 16:06:10 +0900")
References: <20250220080215.49165-1-philmd@linaro.org>
 <20250220080215.49165-3-philmd@linaro.org>
 <7c7880f1-fd41-4e49-959d-6bbbb5689348@daynix.com>
User-Agent: mu4e 1.12.9; emacs 29.4
Date: Thu, 27 Feb 2025 07:55:49 +0000
Message-ID: <87y0xrx1mi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2025/02/20 17:02, Philippe Mathieu-Daud=C3=A9 wrote:
>> Introduce a helper to get the default shared library
>> suffix used on the host.
>> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   tests/functional/qemu_test/__init__.py | 2 +-
>>   tests/functional/qemu_test/cmd.py      | 1 -
>>   tests/functional/qemu_test/config.py   | 6 ++++++
>>   3 files changed, 7 insertions(+), 2 deletions(-)
>> diff --git a/tests/functional/qemu_test/__init__.py
>> b/tests/functional/qemu_test/__init__.py
>> index 5c972843a6d..45f7befa374 100644
>> --- a/tests/functional/qemu_test/__init__.py
>> +++ b/tests/functional/qemu_test/__init__.py
>> @@ -7,7 +7,7 @@
>>       from .asset import Asset
>> -from .config import BUILD_DIR
>> +from .config import BUILD_DIR, dso_suffix
>>   from .cmd import is_readable_executable_file, \
>>       interrupt_interactive_console_until_pattern, wait_for_console_patt=
ern, \
>>       exec_command, exec_command_and_wait_for_pattern, get_qemu_img, whi=
ch
>> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_t=
est/cmd.py
>> index dc5f422b77d..254e23ef748 100644
>> --- a/tests/functional/qemu_test/cmd.py
>> +++ b/tests/functional/qemu_test/cmd.py
>> @@ -15,7 +15,6 @@
>>   import os
>>   import os.path
>>   -
>>   def which(tool):
>>       """ looks up the full path for @tool, returns None if not found
>>           or if @tool does not have executable permissions.
>> diff --git a/tests/functional/qemu_test/config.py b/tests/functional/qem=
u_test/config.py
>> index edd75b7fd06..0eab1baa541 100644
>> --- a/tests/functional/qemu_test/config.py
>> +++ b/tests/functional/qemu_test/config.py
>> @@ -13,6 +13,7 @@
>>     import os
>>   from pathlib import Path
>> +import platform
>>       def _source_dir():
>> @@ -34,3 +35,8 @@ def _build_dir():
>>       raise Exception("Cannot identify build dir, set QEMU_BUILD_ROOT")
>>     BUILD_DIR =3D _build_dir()
>> +
>> +def dso_suffix():
>> +    '''Return the dynamic libraries suffix for the current platform'''
>> +    DSO_SUFFIXES =3D { 'Linux': 'so', 'Darwin': 'dylib', 'Windows': 'dl=
l' }> +    return DSO_SUFFIXES[platform.system()]
>
> It may be too late to comment, but:
> I'm a bit worried that this can break tests on platforms (BSDs?) not
> listed here though I don't know if plugin tests work on BSDs in the
> first place.

Currently we don't run any of the check-tcg tests on BSD. Mostly because
I couldn't find cross compilers packaged for BSD (and there is no
docker-like thing to bring them in) and for the "native" cross compiler
we currently block clang - although there are some fixes for that in my
current maintainer series.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

