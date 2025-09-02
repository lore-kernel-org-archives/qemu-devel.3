Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A226ECA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 21:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utYEp-0006m5-89; Tue, 02 Sep 2025 17:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utYEn-0006lU-Ld
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 17:08:21 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utYEl-00056w-BS
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 17:08:21 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b042ec947e4so399468166b.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 14:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756847297; x=1757452097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahLAWzT+VhNtsYbfq5AhuxwmH4JDIOklfWn3TtCLJbY=;
 b=KBzlAUQpgN1dnF2vy3840uWmERj3ZMjeEuZfFndtiQkRjeZ/lhGXROQ2vK2btfJ6sj
 iC6aF06lYFWkgxRuCFvE8eduKDASI2sNowpNBMOx4gCYIL/S8VkezEsWD/jeWaZl/J5z
 6P1kViyf/0traXYlxqdFYeRTZmZ2LRx88lTLvd9PZ8f4C7wwXJOfP4T6wqYu8BWROx7M
 OzzZlhoCNek0ixmKTUcrQKMqRXDseBDGLSknbzbhqm/gFTKL1LEouW/ShCAp24Qpu/k9
 WOcyI0tmThkok+P9BF14x8rDYd8XIzqjwDTsbJd17a/uRD5jwyVbVhKBpoorkK3PalgA
 UGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756847297; x=1757452097;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ahLAWzT+VhNtsYbfq5AhuxwmH4JDIOklfWn3TtCLJbY=;
 b=kHwrWtVePBq3cIlIj5l5RnT0fxZYTKl6Rw8almDCdtv29d5VKK4iAyRrfPa9HmJxes
 zLnfgHyfP1HGBcxhrhWDC0juhONNOZoS7sCrFdwl26WmLuBdIlZyWkNUymyg23eS6MUo
 QiHk4+dECe3oQ70V0BLGydjeSrZGHYwoSe4zqDW8HTV57ZKMothgObhmuXtu01Ypc2in
 /VdW/20fGeQV4bBU4neIykMwc2VHQIbwvcaraMa7WO47iSdZZwD8usqg4aD87R7BnUnE
 h6fB+hwr3OQxdZzSzZON2wAREfTATfxsJiLTZMH9xmv02GS6gRdSfBrKvFP3xZ+YqHH4
 SNyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkLvhYSTGZwvugd90iwMl7wlwa6qbuWS9xqYsuHVCG5Qf5OLFjiqtlCsuacEr3p9XeP3HltNNO8D7i@nongnu.org
X-Gm-Message-State: AOJu0Yzk59f/Uqpy0YkO30+EwiCcOTlsygxJGYlzHgBC5I4dMgYY4SEj
 S0Nuj9+2JAK9yO5q16BNdav1WjqGVQXrPkLjY2KIUh+UniycqRbqmgJdYvg0HSRHxrM=
X-Gm-Gg: ASbGncs+UwfkedrT45e6mhQCmfDDx3R/bdsYT48G2fAi9ABf2GUyTNoRs5NvGWG5KDu
 cmm7NIPJxUaQAUGqJMGeqWaWmWqeabvGQxuZj+ap9qypPLnYHGtXekp32ipNuMNk5ZaRiTtksnW
 KblkLLH34QXI1rg7dtNOb4lPj70PtMKkQkztqZzaj+m35Ms3bVrkYKhEIqXz1lJueQZedB65QmF
 Tm1UfknoaPWK9jlPjR9Je3CyR3y8BnfJEx71KHqT+mClA+amhRS7cckgx2Qx7r+RWdlwMVkqZwQ
 adCZz8VDeVTxKvW3aNZrPxKRO4uj/ZafFugrjnVsXt4g7z54DGtHmH1LR/QIM8squV5hwDIec8i
 ecre4C3E3UxRM/yFQO+u7oYA=
X-Google-Smtp-Source: AGHT+IFo6epFWG7ocYX7QZrndQ7WYSeeYoZ4qryb8TdujuqafIsHkhdOg/rf/1nEm2QEmMducHf8XQ==
X-Received: by 2002:a17:906:6a0a:b0:b04:3402:393b with SMTP id
 a640c23a62f3a-b0434024070mr762886266b.40.1756847297352; 
 Tue, 02 Sep 2025 14:08:17 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff9918dbd2sm977210066b.103.2025.09.02.14.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 14:08:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8406E5F82D;
 Tue, 02 Sep 2025 22:08:15 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: peter.maydell@linaro.org,  qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm/raspi4b: remove redundant check in
 raspi_add_memory_node
In-Reply-To: <20250902200818.43305-1-osama.abdelkader@gmail.com> (Osama
 Abdelkader's message of "Tue, 2 Sep 2025 22:08:18 +0200")
References: <20250902200818.43305-1-osama.abdelkader@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 02 Sep 2025 22:08:15 +0100
Message-ID: <87cy88zhog.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Osama Abdelkader <osama.abdelkader@gmail.com> writes:

> The if (acells =3D=3D 0 || scells =3D=3D 0) check is redundant in
> raspi_add_memory_node, since it is already checked in the call
> chain, arm_load_dtb. Also the return value of the function is
> not checked/used so it's removed.
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

