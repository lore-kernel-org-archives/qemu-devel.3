Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2630ACEDDA1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 14:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLN84-0007GA-BI; Tue, 18 Nov 2025 09:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLN7y-0007FF-F2
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:56:19 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLN7w-0002iX-Pz
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:56:18 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so29845065e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 06:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763477775; x=1764082575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9d2gAHZo7L2CTfU8YOYxTOD8AKPjn2BjhHOgQVBfgtg=;
 b=d8Nre8GO1n53DQub5h3sRE9/HDA3W/jT1l3SlkyaB6itkKdu9wyDHNulmOdDN0cD9O
 3LoRl4ZFAjm69gLR8BlUmQ+qdTfIFiVVmpD87Yw84fxTD0fsubIOj5F4iYQBsC+Br46w
 XibME5vJzAHWfpZf8yzmJ8JmRbRURzq8xN0Bel/fDFGL3gTFt+UWsAu/qXftjtG4wxoR
 enN+pHgfdlynFYycQUN8GkmUgGXcelZK03E0bEfmiF9VMf3ppi/v6XKpi9MIezx6nCDd
 b1ITmMoDtjmm6RtnzPpc1Hx4Vo6hdNaPSmnF6W+1iKtU/pa9uZPnwXbQTijhVqlrL7fi
 xIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763477775; x=1764082575;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9d2gAHZo7L2CTfU8YOYxTOD8AKPjn2BjhHOgQVBfgtg=;
 b=uuXllW6qpAd5D5e+vRtgQ81wk84EzG2/6XD0hwv+I2aZMHmGimfQpKv+Xs3Iuda4/Y
 fAzPyc5nh+zaDFsLBxiKJUByZhR2ZSrCiFu+GKuSZgEDezBncDRUXANg39VZtvP2zUI0
 z13HJiAUpl4CYYGx5FwxPmwUdEUkVCfoqJofKKEZv2O3JNXqYCOWhSPK/2pLc7GBytRH
 SA0f0gu9QIrB8kodXMuqAdvIYmyYv372UqtOTk9ucMr9GlVjezEoIY6yTZ4tdC+seDrv
 9AlxYsyM8l89Mt89B9fSka9CSceSKnEkz2/YXwTFMh7vwilK2ZOE8gkSzyOJahLP2BFS
 gklQ==
X-Gm-Message-State: AOJu0Yzuf1YeFAGOdZ19yoWd1EGhf9zIyb3CN6zAa450Wka13DfJ8R3o
 NQkNtQgUHdQCAJ3J1DsV6VPXtfGeexcOtuKDQEKCBJJtVJU+hgr8v+SdNXsddp+NvV56mhvB1/8
 0dTW9
X-Gm-Gg: ASbGncs8yWGSzifZsdt8taGcROoKsIBx4K1jecYzrOCdW1W7lx3+P8TV2qfHqzMjyFZ
 k420hU3eIbCrEzoyVq08EKRESfzO+l9ltHnCH6feWwKMUvvK08oaN+X0lMq8hfNO7crOouruHxl
 xOLl+H4SC26XwB0Kd1fscLecgfSvzJOv+9p4n2fXjZTkm43Jlad6FJDKWi0LlW1QeQDE8AUEBQv
 BbYXiCcqZXGz2bauYyLSO3FLBlK9PErvzvWgIfTuY0/I1I2aKpajux9/eRjiCqXpIwCKz5Eecq9
 JVUfAeTzvDuPIVoO/teo1+2vHSOdpab4riq5kCD/0rHtQsgIfjI4s/jg1Bn7nNAvot1VXC/nVcL
 4r0ueGn3TS9NjrZbQMXocHjBRvIuY7z+We2hWyQhSEo2hgg6QFfwXt88guAgl4g311mjAH25dlR
 ClE3KVhbRJVAg=
X-Google-Smtp-Source: AGHT+IHK4rLceBzk5WlTq/tj0va0cHFeFvh4MvYNVHnZpsB9Uaq/W9573Xi+P4S7jdJ4PB8k7BQytg==
X-Received: by 2002:a05:600c:a06:b0:475:e007:bae0 with SMTP id
 5b1f17b1804b1-4778fe5ef06mr209550445e9.16.1763477774608; 
 Tue, 18 Nov 2025 06:56:14 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477952823d3sm222397085e9.11.2025.11.18.06.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 06:56:13 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0F5335F8B9;
 Tue, 18 Nov 2025 14:56:13 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  jsnow@redhat.com
Subject: Re: [PATCH v2 0/3] mtest2make: clean up and make dependencies more
 precise
In-Reply-To: <20251118102942.551194-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 18 Nov 2025 11:29:39 +0100")
References: <20251118102942.551194-1-pbonzini@redhat.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 18 Nov 2025 14:56:13 +0000
Message-ID: <87cy5fjsoi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> You probably have never thought much about scripts/mtest2make.py, and in
> fact it has seen only a hendful of commits in the last few years.
> The idea is pretty simple: gather the list of testsuites and their
> dependencies, and turn a "make check-*" invocation into calling "ninja"
> first and "meson test" second.  On top of that, it magically turns
> SPEED=3Dthorough into invoking up to three suites named XYZ, XYZ-slow
> and XYZ-thorough.
>
> But even this incospicuous script can harbor a bug, or rather an "I
> didn't really think too much about it" situation.  Dependencies are added
> to suite XYZ independent of the speed that is used in the meson.build
> file: add a dependency to a func-thorough test and "make check-func"
> will build it at any requested speed.
>
> Fixing this is a one line change with some cleanup performed on the
> front, and that cleanup is patch 1.  This (at least to me) also makes
> the generated Makefile.mtest file a little bit easier to read, which is
> nice to have.

Have a:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

for the series.

>
> Paolo
>
> v1->v2: support "make check-SUITE" where SUITE includes a speed
>
> Paolo Bonzini (3):
>   mtest2make: cleanup mtest-suites variables
>   mtest2make: add dependencies to the "speed-qualified" suite
>   mtest2make: do not repeat the same speed over and over
>
>  Makefile              |  4 +++-
>  scripts/mtest2make.py | 43 ++++++++++++++++++-------------------------
>  2 files changed, 21 insertions(+), 26 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

