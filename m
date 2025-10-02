Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B205ECAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 16:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4M7C-0005G3-Ga; Thu, 02 Oct 2025 12:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v4M77-00058R-U0
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 12:25:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v4M6x-0003hb-T5
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 12:25:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso10325715e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 09:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759422283; x=1760027083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m99izO4r9jgab72834xowzWE5+08Sb+hWHqm6S4fLGE=;
 b=wiQOEeKuwukyIlu6nUqvgwRodIfen0iXfXTJnjDqr7FBiRbTgZO8Msnnn6qsjWS9m7
 vGn7DHErNACwVHYMaZ1QGc3YsNewNgMB13SSIyfslVe/8ZoyHYog+rD/MGEs80EghUvw
 blzu8kSmoERpabT+qkAsRI2LfcjUo+sGYuCX7wayaH2ZMpXqF+gEPnYcyZujdEwAPCj8
 8QDyItNZ0rexKjlKoJr/WobUGnIW5nUsUQIUE8U1WiBGdZmal6Fh6xa0K3b+cLszlzF9
 lC7uof9qk6RRDP31BRZrIqz5PnnYVz0WtIYJl4b2pBcLGPJpgV9NmRdA6Iy6sw3D7abW
 J1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759422283; x=1760027083;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m99izO4r9jgab72834xowzWE5+08Sb+hWHqm6S4fLGE=;
 b=r1eQCFb33nE0uCRv8ovQYZCDxDO1iD9oSKBf0zMpLmZzF7P0qR02D1+hjVedxTgd4I
 /6phPDlkMlSItuyaS3Qi/Q6IYsw1FckaP+g3pXh95T415hQpLcYcd2XJN/sacwLT9VbX
 OcuQjKsGS3Mk7nwN0fM1HmTCersZQnlSrVzoBQL4P4QWkBDWbZGNpG5QKiVORTd0DWs3
 FOhQO213HgxvCqGvups2lrMM0MPC9vNZVL9sU9S4vZcmv/r8BUVzN58W03jJRS0Xt7fb
 Yu3/qEXCvjRwUNUqBlC/vIxaM/xHE5ptJvLxLPqAz4m2JJj2uMWegpM4BRXoz36+5UFA
 /p2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx/2tOhDEA1hzifUeLbqinMJvSqPnFnVFjDtexz31zVD8ZPwn8Oo72TdazjJF2o8WJG5E5tkuXUMI1@nongnu.org
X-Gm-Message-State: AOJu0Yzx+cCYHXheUjriFFJ2kWXk0YY4V5T/UYcTwRV4Ym4kZCG5KtlG
 +XuskaH9uO9PeIOtDbXI9RjAZlYAqXvbaNsgDNHhHb/WTt9fYviPRoplMEjmPrnwO2Q=
X-Gm-Gg: ASbGncvfBfVqekYQFE4VOpagHxguON3pcIzaN1l/S4VYLJwuTqh5FaUPDfnP0QSS4pM
 aOeO0DIaihLoDQAn/b3uQO2DBvSlGqmoYwLix5b1j07prKTBJ3Yj3VYXPoaeYx4YSAsoRD8JC50
 mOdaJdbIlC7b7WeQd050jEEHIf/ZSoYl42kTc0N8+rfXQxH1E67JOA46mTQBr/NWo/CLfUowAvU
 65g1lqVS1vP00oaMSljlC50P+fkvFR9zuh8rtlRRUQVTD93C8BLILez0+XhdMUq/dmiEPvnn5Z0
 mKHn9z83d3ugYvJGT1o3D1jobBhRG1rgSLsl8uQl6mkU/10x4XwRwk5O9P477RutElzmWENLD3m
 afmsCShQjOhNrqmaNXRKYxQGCSKXGNLi+Cnpct978DcLngZkVg0E=
X-Google-Smtp-Source: AGHT+IEK80UwgNjV22g47ZXnJP8YbgrgOlOSagQEfbQaiK/6SJsmQK5+2by+KwdInLbXIryPhytPug==
X-Received: by 2002:a5d:5d0d:0:b0:3fb:9950:b9fe with SMTP id
 ffacd0b85a97d-4255781a8bbmr5534879f8f.47.1759422283145; 
 Thu, 02 Oct 2025 09:24:43 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9719sm4383031f8f.31.2025.10.02.09.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 09:24:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 663115F809;
 Thu, 02 Oct 2025 17:24:41 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 thuth@redhat.com,  qemu-arm@nongnu.org
Subject: Re: [PATCH v5 4/9] tests/functional: Add GDB class
In-Reply-To: <aN56GkbIFxs5IDRR@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 2 Oct 2025 14:11:54 +0100")
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
 <20251002020432.54443-5-gustavo.romero@linaro.org>
 <aN56GkbIFxs5IDRR@redhat.com>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Thu, 02 Oct 2025 17:24:41 +0100
Message-ID: <875xcxgtkm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Oct 02, 2025 at 02:04:27AM +0000, Gustavo Romero wrote:
>> Add GDB class, which provides methods to run GDB commands and capture
>> their output. The GDB class is a wrapper around the pygdbmi module and
>> interacts with GDB via GDB's machine interface (MI).
>>=20
>> Acked-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>  tests/functional/qemu_test/__init__.py |  1 +
>>  tests/functional/qemu_test/gdb.py      | 88 ++++++++++++++++++++++++++
>>  2 files changed, 89 insertions(+)
>>  create mode 100644 tests/functional/qemu_test/gdb.py
>
>
>> diff --git a/tests/functional/qemu_test/gdb.py b/tests/functional/qemu_t=
est/gdb.py
>> new file mode 100644
>> index 0000000000..05e4c29c2a
>> --- /dev/null
>> +++ b/tests/functional/qemu_test/gdb.py
>> @@ -0,0 +1,88 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# A simple interface module built around pygdbmi for handling GDB comma=
nds.
>> +#
>> +# Copyright (c) 2025 Linaro Limited
>> +#
>> +# Author:
>> +#  Gustavo Romero <gustavo.romero@linaro.org>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>
> Please remove these two lines - they should not be included in any
> newly authored files - SPDX alone is desired.

I can clean that up when I pull this to save another round trip from
Gustavo.

>
> If that is removed, then
>
>  Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

