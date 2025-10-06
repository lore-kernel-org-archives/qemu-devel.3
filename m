Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6ECCCA472
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 10:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5iDt-0001wv-CO; Mon, 06 Oct 2025 06:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v5iDR-0001f1-Cm
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 06:13:13 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v5iDP-0006PW-ET
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 06:13:13 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e2e6a708fso30619285e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 03:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759745589; x=1760350389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S27uLFqdarRJAqBGQLSekBvokGakda90uhNSpOUGR/g=;
 b=DmCvCQxDM+M+r6l7JqauO2jcJd58WoWIKViRxY4vTlObobhBonAj0qHQXX3Fkq2ZQ/
 9N2uh7u1zA3Jqyxz2f8YfCEFcbAjhvXEPU89RgBnUN7dHRu0+y/7sYh3sdPtdHrOsAvA
 UgdQ7b+Zj1N9c6NFByUx3mlOj08xfDtSLacvuNkKSxcpur0Ovo5sTChCFBpgGOZ7EEAu
 PoZ9cJ/eInVDz6igQUkCixHIo0m+ZvmyzyvVKJBiumTzedSPawWXXneOrCHndkeTKCJ1
 KT2xk/jG3GpYu5Tb/Rmxx7DYBXTvJRYQMTuJnet/i+FUAaUD2KC31UXaHHHK1kwzoH5W
 DGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759745589; x=1760350389;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S27uLFqdarRJAqBGQLSekBvokGakda90uhNSpOUGR/g=;
 b=nBo0RFjo5Kt0UkOjEqDadKPnyRyNizpixCwHHOM9FvM4elh29FWbHR2eZ+PCLTN1XM
 23RvS0xCrkqrp17ZLSrI7ayuJCeG/yzzdA5CrpvhVoOTSxPDsniTzxPRYnCZoN4xTwu0
 1Iu5CmLWx8z3KZCeyqht7wx+dH5qqgBM/vy5B+fiGgKMRVrjKKoKqmMwa48CTu2Ml+44
 Qb60SoN5s1yFfu1UCNcsxfC7MBOhM2xeENH1lCQR29aFvrWH/+gCkY0L+5IOh3biVlpC
 3UKg+DfraFpfvRoX+eTUUdFPRK9nQXRCX3BEGNkq9QNDwRJ6wpfokFz4h+Pohk4qYFwx
 i0rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjWadPObhvoj6fTpZy2loFpHf1T93+xecmx4a/mQNd6agztQobV7Rap4rP1ltDKZk9J1dR4Nv+y88A@nongnu.org
X-Gm-Message-State: AOJu0Yxkx2F4VIFtzyIPLPw8VO36hd9A4bpBGi5e2vVNSzsMWOLq9iAm
 uYI2gYymr6IdhK+D7F8bC2gaM9fu6x6RdXg5gfN+r7/66dHqKIv03dwpWX96rkxbNQ4=
X-Gm-Gg: ASbGncsEm2d6nvnH+GXIKM14PL55NmKzkxu84lGJILsg5FJ4js+kC7onRp0vxn/TEYr
 jgBwEM4qeJFWprf2RaEU3Dj9SHKGDI+8wt0MnD2rN1MVtcVkCrc7uRgc+7mpWqiZMThRw+arP7y
 gQ5+5PC0CrYH0Qdfgs1/aUbi7S9KrhgYy4OWqts5bQiBvKHsgAc4cdSrGYvselGpEPCMy0xMI8S
 ZV1LqcNr/ilX4McCTEkcIZ0adkAt/kDAx/z1aGuf/v23YPsFNngs6Mcg/+XoJ5ReVcNzVTlXuO1
 bQFCCVuJ8MGhQPFKMVD3J22QL+RCJGEmJEjwYrpq1llnXL4Q+7LWYtg99S5Cpbztrq+QFNk6kUK
 iNu0VQ7awry429kBVbuT4aM6FZPW2gjAP396ZxG/zFMcYrSu2e2E=
X-Google-Smtp-Source: AGHT+IHZzw8T+o7XFBCLrtC2yDC0uCOTN/vo2Dfr+4IlZyWhuIwPlXwRo7vqBL+Ce6FNEuvV7aYMhg==
X-Received: by 2002:a05:600c:19d0:b0:46e:3709:d88a with SMTP id
 5b1f17b1804b1-46e7115b0bcmr78471135e9.33.1759745588882; 
 Mon, 06 Oct 2025 03:13:08 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723614c9sm150018855e9.14.2025.10.06.03.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 03:13:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B10C95F845;
 Mon, 06 Oct 2025 11:13:06 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 berrange@redhat.com,  qemu-arm@nongnu.org
Subject: Re: [PATCH v6 4/9] tests/functional: Add GDB class
In-Reply-To: <7aae5daa-5e07-463c-bc3a-6581050688af@redhat.com> (Thomas Huth's
 message of "Mon, 6 Oct 2025 08:30:30 +0200")
References: <20251003141820.85278-1-gustavo.romero@linaro.org>
 <20251003141820.85278-5-gustavo.romero@linaro.org>
 <7aae5daa-5e07-463c-bc3a-6581050688af@redhat.com>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Mon, 06 Oct 2025 11:13:06 +0100
Message-ID: <87frbw1gp9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

> On 03/10/2025 16.18, Gustavo Romero wrote:
>> Add GDB class, which provides methods to run GDB commands and capture
>> their output. The GDB class is a wrapper around the pygdbmi module and
>> interacts with GDB via GDB's machine interface (MI).
>> Acked-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   tests/functional/qemu_test/__init__.py |  1 +
>>   tests/functional/qemu_test/gdb.py      | 88 ++++++++++++++++++++++++++
>>   2 files changed, 89 insertions(+)
>>   create mode 100644 tests/functional/qemu_test/gdb.py
>> diff --git a/tests/functional/qemu_test/__init__.py
>> b/tests/functional/qemu_test/__init__.py
>> index 6e666a059f..60d19891bf 100644
>> --- a/tests/functional/qemu_test/__init__.py
>> +++ b/tests/functional/qemu_test/__init__.py
>> @@ -18,3 +18,4 @@
>>       skipIfMissingImports, skipIfOperatingSystem, skipLockedMemoryTest
>>   from .archive import archive_extract
>>   from .uncompress import uncompress
>> +from .gdb import GDB
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
>  Hi,
>
> just as a reminder, this still needs the change requested by Daniel:
>
> https://lore.kernel.org/qemu-devel/aN56GkbIFxs5IDRR@redhat.com/

I've fixed that up in my current PR branch:

  https://gitlab.com/stsquad/qemu/-/commits/pr/031025-10.2-maintainer-1
=20=20
>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

