Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620CCC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 08:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNShE-0002a3-0i; Fri, 06 Jun 2025 04:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNShB-0002Yv-AA
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 04:45:01 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNSh7-0002qr-7P
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 04:45:00 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad88d77314bso368024166b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 01:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749199494; x=1749804294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEB3JdhbcNVJpQX9WTZM4n1TSotZiHHXmtYYsa3cJIo=;
 b=QHI5u7kLDOUhgXvEug8fbfyT/U98weV6N00uwCBPAri7lzpSkuVjXzEbwFC2yhlWxi
 rUtizArG4DhI/x6fTWQnadraryt7pH6d0CTBKpoB6yWlERTTpWhmNQGWerfmivOWW0DP
 ur0MR0huyY5kfT8WKHUdlK8UOpTd82Z8mokeRKtIbwgKFyafgsc+/2lb+HjqkhN9dt+W
 R49IKB2EgDhS7tbVKPjEJ0TUjUQ3EvqMnXDXkiA+apNOujkskr2vdjX1yLmNrn1Vtxdv
 8vJnwiQoO0A6RdAzISzRtdWokS6+2wAJf3tDHEAzE0frkQl1gtbDbaCKv6obGGouY1hO
 tzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749199494; x=1749804294;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LEB3JdhbcNVJpQX9WTZM4n1TSotZiHHXmtYYsa3cJIo=;
 b=LYvDWa6CbtljijQJY7YUYtg973yxG8IQxHHeezXZOKxSFgaDZUHzV15NRffAo9KVMb
 lgnAvepvW6r1YFLLuAQfnG+G1kVYTAF4Xsf2pdrtlUdLsfxEkLDlieI9cd8owEM3BuAQ
 M5CQRogVwbEAqATRRBLEGh72ANNf1z/UDkmmAWfw4wlq4zF1ruO77MoDZ0pAUt3m0Zqj
 BVWkqdfawo0qnpAHf5tp4tI8J7klOxDsWjjyT8vL+QZDAiqfd5u4Cy39sDIgx0XyND/h
 vLIDt3H3HEWvUepUrKM6R00KmUO8TDZqy3UeFuJyqpflvzsWN6d2044fNMGzcxJHbsYs
 juyg==
X-Gm-Message-State: AOJu0YylVwb5x6nmVqxs9wvsS2nae0cTEe2fAYVQKPnXnX2gAB4EvVwA
 7UwFGaJVcfUF8j69kD3gU8KxqvN3T9pnf820PIHmFvsXPi2VkPW+aRlpv6TT7ubgYgg=
X-Gm-Gg: ASbGncuaoGqAEBNEyLJCFLYKJWaDGVIu/r8axPG2Q5Id4jfK3hzL2vVFz2vII5WBdih
 OG6tqtuzBNoGk/8QmmRm5kufmNfaFXb8LkNapvFC3JPWHmHJOujLixSZLk1nlCpP4/PzAYq3qe/
 Rcj9fsP6oVds0J7JC3KE4FK06dJP5zrCcYNgbz/ZxijqeYy6aF3VzOWjscKJrK4PqURDauuo58t
 j4iFYdOyk6ot+H5bkChGI7/g7a6NpA+ybgMPxXJUuIJJZiY7KKcUKl0vDtlVcSCFUuEcT08TRvu
 01lZ6uSguJgfpZpEh4mTn7yKsSAUSSWCaDK9MhfDofiAHTPE3Rg2
X-Google-Smtp-Source: AGHT+IFHYT+P/xT5yVwc973HcDaZseVs2SXe1oM7lnHFPYeFnVbMWZK04VpK+vnzQBL+GMVPuMtWTQ==
X-Received: by 2002:a17:907:7e8f:b0:ad8:9b5d:2c1c with SMTP id
 a640c23a62f3a-ade1a909559mr208192866b.19.1749199494059; 
 Fri, 06 Jun 2025 01:44:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc3a5acsm81582866b.137.2025.06.06.01.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 01:44:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CDBFA5F7E1;
 Fri, 06 Jun 2025 09:44:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-ppc@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  qemu-arm@nongnu.org,  Glenn Miles
 <milesg@linux.ibm.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 0/4] system: Forbid alloca()
In-Reply-To: <20250605193540.59874-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Jun 2025 21:35:36
 +0200")
References: <20250605193540.59874-1-philmd@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 06 Jun 2025 09:44:52 +0100
Message-ID: <87h60t5ke3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Eradicate alloca() uses on system code, then enable
> -Walloca to prevent new ones to creep back in.

Should we also mention it in style.rst:

  Use of the ``malloc/free/realloc/calloc/valloc/memalign/posix_memalign``
  APIs is not allowed in the QEMU codebase. Instead of these routines,

>
> Philippe Mathieu-Daud=C3=A9 (4):
>   hw/gpio/pca9552: Avoid using g_newa()
>   backends/tpmL Avoid using g_alloca()
>   tests/unit/test-char: Avoid using g_alloca()
>   buildsys: Prohibit alloca() use on system code
>
>  meson.build                 | 4 ++++
>  backends/tpm/tpm_emulator.c | 4 ++--
>  hw/gpio/pca9552.c           | 2 +-
>  tests/unit/test-char.c      | 3 +--
>  4 files changed, 8 insertions(+), 5 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

