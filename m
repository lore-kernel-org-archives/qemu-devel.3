Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83327109879E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3c0L-0005jo-2R; Fri, 20 Mar 2026 11:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c0J-0005ja-Gr
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:43:15 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c0G-00047A-MT
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:43:15 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6689033d0c3so1150183a12.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774021389; x=1774626189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LdbbLe6KjSYVQ+g6hSpf4e+wwR6TK3+UfDAjOenvcjs=;
 b=AHsNw7C5zilnwIr51sxA2RVX4gt+GL/6l/AzMev9uidLiJHtxYSC7ciagoCpZlSOTk
 4BCwmUO1OuBs/2yj8bQkdxkQwI7vAo/6cZcC21zQ4d2OxREM3RoOOcfAPE27/pkUk+hI
 lby0bd+GwS8wqcnRXTggdSvTHnLY+ki1WOZ3dyviXI6xsjaNjrtlcXAisiIvyt/03EkK
 J5xGP35Sd99wgDMZCOxRnoMRN2lle4lcwV7/i3wc6TPUF693+dhUr/WeQK/2kw1C8bhs
 Z3oE0sgVd1X/FxlRP6QrfQIXt9nqTLuFPu0a4Y8DGpcx3Oyk+flwtWeJnSa0eWNZqfay
 lH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021389; x=1774626189;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LdbbLe6KjSYVQ+g6hSpf4e+wwR6TK3+UfDAjOenvcjs=;
 b=nuLHBA2CFC53jMrRVsKOyudlhMQyzLw6oGXNU3iALAa69fGi8Cb9Ok634fw902Rate
 xw0r0SgUqeGinPU495io7EXjBOSjnHrBmzD6p2/MhZXdVd00TwDhx4FCzltDX/Kp0f81
 jgiaKQW0pC11CKZZDEXQfvbaNsYZSRsvWRHqtUwijLBHRiSMSz5DDbK3wx2aivZQEZpd
 PAFG6XDQdBXtlV2lQju0qtRJkdIPHutddNqpjDTFXUJVmVPRc6hQGHARLaC06/zJdCgZ
 6Bzb8oXzUpTu9kvMPLpP85LAhlUekLLpLTUz6qnyqdNabVg4mKzVOm2WmqoAjicxOO6i
 nQVQ==
X-Gm-Message-State: AOJu0Yw5+8PKfl2Hr+G90G8CvapSj+33Yv/rNEBkhm9ZozclDEEpCN1u
 Vh9D/xTMDbQVhpRB+AWkpreZD4XlOQ1SnUvfm3+gYzpsuq/JWY2IPsBjbEV5KgHMXDA=
X-Gm-Gg: ATEYQzyRiYH1m8fpSaUKZ9XVAtVPlMwJqOy++OJ6WEY/C55Z5S8G1woelgRTUaqzzjN
 OooWlC3E/reerKbOQe6rY0ChbexBLeBAkh/HCQ4+OKiks/vxNlOvGf1hLXCrLRmn4oggFY1vYRB
 HQj8M30FMVEf2DuQvAw3sxfobiB605eDxOx3DNavi/Xfgu62OXlvj6Ril4rKiunLcmkRHKYyKgK
 Ap2pwQE0KdJemreb18LyxDp71iXy6tFhX3cpINi5r9ato3TEjOCQfVCIjywDiLhVx8ZHFlJ+J4a
 f9TUX3xnEL5fIWl7gWPL/vpguJiO/yiJwL3/FI+VMS9/BlHL+IwELAAjtZ9J46ZRPK1Dm03/4Eo
 Uw4dEozGqKKuyfRyqbdECMJqg6RU5U6mMcRu7+08eDw5O91t58N7M1Y/3G8jX/sHeeE2zDHqym/
 DOeLa9l2e1d/FS8+ydm5i+XY8=
X-Received: by 2002:a05:6402:4005:b0:663:71dc:127e with SMTP id
 4fb4d7f45d1cf-668c9528336mr2517429a12.13.1774021389356; 
 Fri, 20 Mar 2026 08:43:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-669331c7450sm242435a12.6.2026.03.20.08.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:43:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D46475F82D;
 Fri, 20 Mar 2026 15:43:05 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 0/3] Update openSUSE to version 16 in our CI
In-Reply-To: <20260316135407.209072-1-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 16 Mar 2026 14:54:04 +0100")
References: <20260316135407.209072-1-thuth@redhat.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Fri, 20 Mar 2026 15:43:05 +0000
Message-ID: <87ms02v75i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> Since openSUSE 16 is available since a while already, and openSUSE 15
> is older than 5 years, it's time to update to the new major version now.
>
> The first patch is required since we are going to remove the "python3-sql=
ite3"
> entry from our mappings.yml and lcitool complains about it otherwise.
>
> Thomas Huth (3):
>   tests/lcitool: Remove python3-sqlite3 from the list of needed packages
>   tests/lcitool: Update openSUSE to version 16
>   tests/docker: Update the opensuse-leap container file to version 16
>
>  configure                                     |  1 -
>  tests/docker/dockerfiles/opensuse-leap.docker | 35 ++++++-----
>  tests/lcitool/mappings.yml                    | 58 -------------------
>  tests/lcitool/projects/qemu.yml               |  1 -
>  tests/lcitool/refresh                         |  2 +-
>  5 files changed, 18 insertions(+), 79 deletions(-)

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

