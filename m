Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866FFCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXD5e-0002vi-Rw; Wed, 10 Jun 2026 03:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXD5d-0002uz-NL
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:11:05 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXD5b-0008SW-ST
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:11:05 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45ef616daf6so5865476f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 00:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781075462; x=1781680262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XU7VQ0/Dw54ASKD7i5p0PkhAv4r3Chrx9ylKdVzzDhI=;
 b=kuqHu5GLYPhYKtlvJrW7aDCAQRgO5Q9+iaaP0KrW6kzkujgLRIsNjXEyMrPDxCEFQR
 uYUOnQNQwRuFpvlgTRX7I71gx2CGcR2MEctQMOUkwskddrJrksPFdwurnCLZDfF/B7qM
 KYIL86STPD4uszlrnPmfEpK+3+6VW/4SatuL2OZWBKdvjoVtbu1D3FNguSV6RKNVi7Ue
 tBFfVVDe7nVLdclfo3QoIPkZYLs1XClQ8Y29peM84ulU5UrzjdH7XLfwIVx+Afek2Yqf
 Nq8wEDJztEeynRIfP3+LJYtWoInXx0jzfATR26cL4riowcSKDJcSNtAOrkiwEi/o5Fdh
 McWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781075462; x=1781680262;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XU7VQ0/Dw54ASKD7i5p0PkhAv4r3Chrx9ylKdVzzDhI=;
 b=jCNfgSzFMeIDu1Y2ToFHMH2/Jq7rLpXk9B3rBquciAUVJSg5bzBs6ovgpzp42Y9xSU
 Luue9FYntS1Mjm7FK4RUzp+0miXC78nJYxlcBhvT1oPNTqEYQPbD+0dbfO/ZJxNzd/F7
 sE0/NDKf2d2GkG3Bskg5BeRdoGmRC7IZ1W5LIrgpP8Gw6CV+TMA43jzrwSuikYmKR9HC
 Splty2in6n+A88TFjEqK559SdiWMx/b6uizfYod/jg1+TcJPt64Eiaw1sE1gUJpDfvq5
 geT1+4pXmbhmkXIWHnGmFAr6dWtLJ6domHEVQ0/SwvB7g+2ovW2Ndh8CO+HdGz+gQ0m2
 37aA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Y95hBOXawL2mUgBzfgNmwVHlzGYmUZ4cWuqI655NYvABVaLb2C32uE235CJ+OarbBW8uTN9lrSho6@nongnu.org
X-Gm-Message-State: AOJu0YykPsO9iBQq4YUk88zGfLdqp7Nuu7E3mLzMuWUxe8nSE6DMiElM
 +9aD3saOyw5kVDkdyzexK1s5crBSZRva/sKxf9AMeaD9ccKm3u7tRzAA/UhPd1jGGUk=
X-Gm-Gg: Acq92OHoTkcPngQX7vyJqJz48gtBAbJfukWCaYAFDuFDnCdNy6hCzIp+f40a0I3pqtz
 6qP7x0orm/ElpA53zklm1qJ8HTAxISHxSNlQ5a+ISn93PwuogNBu5zA/TXhYz+cDNEPNKOVOJm4
 xDdDnpVI3HoySeci8+MrM/T1ojVuu9RjGqi0hq3Bywq+WB7LX9iT2hKkAHdccsxg5JAktkbk3kU
 73AtQnO4oFRadFjjOLfw8oKUhi6ujwSMsLUm1WltUMvCFNblDpZDPc576pr+gQXOE83+FnWgLZg
 VUX23Gh725daAsZ2jcyXDcsA09ry76HTGKoj/pUSNktIR3xq7fRaDhrgn7SlYDclkO0g9KcozHj
 ocKnTX1UrcBjqtsaGObTYASPKwTVVdZnPrgwMAZSLIAsUy1sIFJmdqi+yjLqX2aRhHmp1HaYtoN
 degN4B9eHn6sm/8mK7rD0P3vofKmC62gNuYDPg/zK8+P32NWwB1MmSYHlALN/fBi2VkNglh0x9o
 bylLAH+5DpgaKb7JTc+NRUz27ZItgUpWzGFiArzdXG+2hn0951kQcc7blnVfJ2w
X-Received: by 2002:a05:6000:298f:10b0:45e:f381:cd7b with SMTP id
 ffacd0b85a97d-460302dc6b4mr26554153f8f.8.1781075461847; 
 Wed, 10 Jun 2026 00:11:01 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-144-251.home.otenet.gr. [2.86.144.251])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcde3sm70894010f8f.1.2026.06.10.00.11.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 00:11:01 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:08:21 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 06/27] tests/tcg/meson.build: introduce test_name
User-Agent: meli/0.8.13
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-7-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260609214745.772536-7-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgemmc.ymcxyhiodn9w@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

On Wed, 10 Jun 2026 00:47, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>We add possibility to duplicate a test for a given src. This allows to
>declare several tests that still share the same executable, thus saving
>space and compile time.
>
>A side note to mention that meson perfectly supports declaring several
>tests with the same name. However, we prevent that to force dev to
>clarify what is the intent of each individual test.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---
> tests/tcg/meson.build | 14 ++++++++++----
> 1 file changed, 10 insertions(+), 4 deletions(-)
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index 2c6d85c586a..bb0184732fd 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -12,6 +12,7 @@ tcg_tests = {}
> #       {
> #         'src_file': {
> #           'exe_name': ['provide an alternative binary name'],
>+#           'test_name': ['provide an alternative test name'],
> #         }
> #       },
> #       ...
>@@ -21,8 +22,8 @@ tcg_tests = {}
> #
> # Every test executable, identified by 'exe_name' is built only once.
> # Tests for a given src use the same executable by default, and their definition
>-# is guaranteed to be unique also.
>-# Default name is derived from src if 'exe_name' is omitted.
>+# is guaranteed to be unique also. They can be duplicated by setting 'test_name'.

While it's clear in the patch description, it might be a good idea to 
explain that "duplication" means using the same executable here, for 
clarity, if you respin this series.

>+# Default name is derived from src if 'exe_name' and 'test_name' are omitted.
> 
> # plugins come first, as we need to build the list
> subdir('plugins')
>@@ -51,7 +52,7 @@ foreach target, plan: tcg_tests
>       # return a clear error if user mispell a setup entry
>       foreach key, _ : setup
>         if key not in [
>-                       'exe_name',
>+                       'exe_name', 'test_name',
>                        ]
>           error('unknown tcg setup entry \'' + key + '\' for test ' + src)


Unrelated to this patch, but you could refactor the ['exe_name', 
'test_name'] etc key set outside and print the list of valid keys in the 
error message as well for UX.

>         endif
>@@ -66,8 +67,13 @@ foreach target, plan: tcg_tests
>         exe_name = setup['exe_name']
>       endif
> 
>-      exe_name = target + '-' + exe_name
>       test_name = exe_name
>+      if 'test_name' in setup
>+        test_name = setup['test_name']
>+      endif
>+
>+      exe_name = target + '-' + exe_name
>+      test_name = target + '-' + test_name
> 
>       if test_name in added_tests
>         error('test ' + test_name + ' was already added: ' +
>-- 
>2.43.0
>


LGTM (feel free to ignore the comments)

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

