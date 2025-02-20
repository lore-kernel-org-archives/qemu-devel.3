Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7F5C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 09:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl2hu-00056R-1W; Thu, 20 Feb 2025 04:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tl2hr-00055w-0d
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:18:55 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tl2ho-0001EC-KO
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:18:54 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5deb956aa5eso931227a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 01:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740043131; x=1740647931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DplKe3pv8/iBvTnhVF++uaTZ3sY1szl9g/ylIcnvurg=;
 b=kzm7aoydtGaKsNH/VvaJ4xZBdcLXKVzjNjoXkIA2T/TBnUqQfnBvwzPgGghHHRB7+f
 rJaN8y6GrKXYHQEV7t92AmTkX899ryA2XKkarnipy9Cdlv8Iw67W7y4X8ChEb4yI/GdD
 dWa0Qmi/faxt0wcx1CbxRYjqzoHlPWwT81XJwuMeHM04prunmVMU9cJAWN31lbZh6F9G
 nqLb8aksRm6LzoCI/4o3vnEKUVBqZfPzN0cI6UdVvqg13BxBhUUWRAs2Q8zU/apJe/FW
 gphQou1yEwjgZQh6o+giTS5E4vmu7tBt8HM/iOZEGAMFiYYgZ1XoEravcs0PXtf6nDD4
 YfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740043131; x=1740647931;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DplKe3pv8/iBvTnhVF++uaTZ3sY1szl9g/ylIcnvurg=;
 b=VFTGqhH/vGNoHu/wTzKkO4F38Xs5d+nI50TAC+N8r1RN+t249iw2tPpQMiT9m0SEaz
 pjTW+qbNOX2MxVfk/3VnymlQGaeeLAsV0hOBNwGhngaLg6khgqbe97eLMWQqwSsNsEkQ
 vm4nqWGFzN+/JTBOEiDAKJpjwr7YiBY4q9jK+D347iub2GJJw+9VN50jdMTAGZsfm1iy
 UzUptQwJ3EH63V0nbMBJuuWPH5l2AfeN4/0Md8D86do4AlMmR+wlfRQ9QYGGMUwyfo19
 AHQtUbQ4/x1Q9u+Oa2zCXcPLgTSccI2iJZ0Qrls5+CokGFLRINKtj6oG1ic28YNooOyC
 5Zkw==
X-Gm-Message-State: AOJu0YzeCQxZ/I5MO+E2o5OQzh0AifN6S3USzilwQRvh286Gb9b0eHzN
 ZDfgi6c3eHy7j/NC8mTXOhkYzFqu0aSL5KdE5ZE9acwyq7Mz/ir61YYwZcXgJro=
X-Gm-Gg: ASbGncvz9oIj4rIr2JgD3QBiuai69UcdU9usjEalqInvlEy251aXJHjWpVg/+6Ec5JG
 6PVWTaLqkBnFeMsoTmxnc47Fr81aHc5rkaGIb86alGT5Dzww/UGMEH5YFzRpvmFO7iexV00s1GG
 qZMCvc1815AzkHnotPxNQlfRmm4Au5rxwIeudY23UI0Ljk6xdbT2Lce5EfvY2PeKDutg6AjpaGc
 4sX4UWs01Q2nTWB2CZ7lVekMzaRjqPh4dUgNr2BaAGB/y+yCT2LdrWHbYX2yOmxWUzHXOdI2/th
 jfayvmXt/gCugyts6A==
X-Google-Smtp-Source: AGHT+IGXHrsElue6pnVkxm2HlqoZIQfdcMpbMv8BCjnbwTshXVkHBwqNdh7J15Zg8Vab1x1xjLi+rg==
X-Received: by 2002:a05:6402:3589:b0:5dc:9589:9f64 with SMTP id
 4fb4d7f45d1cf-5e03602f759mr46220265a12.13.1740043130530; 
 Thu, 20 Feb 2025 01:18:50 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece1b4e8dsm11659430a12.14.2025.02.20.01.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 01:18:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 783715F8AC;
 Thu, 20 Feb 2025 09:18:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Stefan
 Weil <sw@weilnetz.de>,  Alexandre Iooss <erdnaxe@crans.org>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Thomas
 Huth
 <thuth@redhat.com>,  Yonggang Luo <luoyonggang@gmail.com>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2 0/3] tests/functional: Allow running TCG plugins
 tests on macOS
In-Reply-To: <20250220080215.49165-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 20 Feb 2025 09:02:12
 +0100")
References: <20250220080215.49165-1-philmd@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 20 Feb 2025 09:18:47 +0000
Message-ID: <87cyfdj7ns.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

> Pierrick kindly helped me to resolve this issue which ended
> being trivial (to him!). Not tested on Windows so far.
>
> Since v1:
> - Include Pierrick's meson fix patch (adding Fixes: tag)
> - Addressed Thomas review comments (config.py, os.path.join)
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   tests/functional: Introduce the dso_suffix() helper
>   tests/functional: Allow running TCG plugins tests on non-Linux/BSD
>     hosts
>
> Pierrick Bouvier (1):
>   plugins: add explicit dependency in functional tests
>
>  meson.build                                  |  1 +
>  contrib/plugins/meson.build                  |  2 ++
>  tests/functional/meson.build                 |  2 +-
>  tests/functional/qemu_test/__init__.py       |  2 +-
>  tests/functional/qemu_test/cmd.py            |  1 -
>  tests/functional/qemu_test/config.py         |  6 ++++++
>  tests/functional/test_aarch64_tcg_plugins.py | 11 ++++++++---
>  tests/tcg/plugins/meson.build                |  2 ++
>  8 files changed, 21 insertions(+), 6 deletions(-)

Queued to testing/next (I fixed the cmd.py whitespace change), thanks.=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

