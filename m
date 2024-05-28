Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019EFC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 12:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBwIX-0007zS-J8; Tue, 28 May 2024 08:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sBwIU-0007xn-KW
 for qemu-devel@nongnu.org; Tue, 28 May 2024 08:51:23 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sBwIR-0000wL-OQ
 for qemu-devel@nongnu.org; Tue, 28 May 2024 08:51:22 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-529614b8c29so1312183e87.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716900677; x=1717505477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=McwypF8hKw5r61wmqrTYHuwwTuLCEpVvspZJTkrxyjE=;
 b=zex+NTLe5TD4rPahkF0yRLWUI8wQfepuVJZ9KxmEu7W+gOEQy4gKP9m+/xdq566ukN
 XJT2uS+eVyrUw19q1zO+mCxlYLMACtFTfUy/n5sL3h0itYK0J8xUTwI/l4cpELy22orN
 6yzleylPQdfGvvJbNk8ciALBJK/HgI0WBvrRun/orF6TpnjFBZolS8wstolKwqZfcPgO
 QO+9PXj8VqkuVnw4mbvoXMcSZDje8LpkD0uOCq+NNr6s8ObDYSP8U+jUSDPZTXY47NYd
 bYuEJHA4wU6Tv6sNhQr7gRgzMFuFiazt9t16NFXB7Qp7Ev5X7R8FKX4m1TOorYHlN3Sk
 +q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716900677; x=1717505477;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McwypF8hKw5r61wmqrTYHuwwTuLCEpVvspZJTkrxyjE=;
 b=ZXrfP0b1uWx2tb1CLCUAr56U6bVYWACcNbg28ESjl7twLylGKWfKM8lFgxxT/vkW7A
 3nGjiD5R26IlOoNeBXwDHDXj0qlhX43g40E7HACbvyWElq4p2A2XKHO2zrcEXDH6Tn5B
 pOSTtsKknV9icSvKKMvUm1+tRyU5TzgMkPmymq1DQjOlIOGJ5fAAoDpXtbWTQGx+eJ+S
 WZh9QXoZE4ikkgKkQIQAfEgSV3QTPFbzCGV2uumAyIY40QWV0wn7z/a51lRe7oOakad8
 lv+ee/IjiECyFkwH35Tk1JOnQSiCR6G9yH2WmurtAe4OvZdxZYIZpf84LMcK6dT5nmcv
 Mf8Q==
X-Gm-Message-State: AOJu0YzpdCZ9ndDCQw0ISb3xYFBywhqyFdeEjkWyaLuoRP4Wx9fSIwVt
 phCj/WUEbrQsIRKfjG1daMoOPlsisgV0nPhdmjlT5tW70VO1Fcr6KHG69DPXbB8=
X-Google-Smtp-Source: AGHT+IHtTW+GAL4Dr3Xl6UL3ri/3UQPMY2KQVkD69LRlsLkfEqALS0CjEsPybSn1vSa2ED0GKZyolw==
X-Received: by 2002:a05:6512:4c1:b0:523:54a2:3836 with SMTP id
 2adb3069b0e04-52965f10e3dmr8907443e87.33.1716900676683; 
 Tue, 28 May 2024 05:51:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8c975sm610976466b.167.2024.05.28.05.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 05:51:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A539C5F88D;
 Tue, 28 May 2024 13:51:15 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,  Beraldo Leal
 <bleal@redhat.com>,  qemu-s390x@nongnu.org,  John Snow <jsnow@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Jiaxun
 Yang <jiaxun.yang@flygoat.com>,  Joel Stanley <joel@jms.id.au>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Aurelien Jarno <aurelien@aurel32.net>,
 Thomas Huth <thuth@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/4] testing/next: purging remaining centos 8 bits
In-Reply-To: <ed69a712-689a-4294-978d-d8d818a12b6f@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 27 May 2024 11:32:17
 +0200")
References: <20240521125314.1255403-1-alex.bennee@linaro.org>
 <ed69a712-689a-4294-978d-d8d818a12b6f@linaro.org>
Date: Tue, 28 May 2024 13:51:15 +0100
Message-ID: <87plt6f6bg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> Hi Alex,
>
> On 21/5/24 14:53, Alex Benn=C3=A9e wrote:
>> There are a few more bits referencing centos8 in the tree which needed
>> cleaning up. After this we can remove the dedicated runner from the
>> gitlab registration. If we want to keep a dedicated Centos runner then
>> we can add back the bits needed to set it up (although arguably we
>> could have a single build-environment setup that handles all distros
>> and integrates with lcitool).
>
> Do you you mean we should generate
> scripts/ci/setup/build-environment.yml with lcitool?
> Otherwise should we update it?

Yes - I've got some WIP patches which I'll post soon.

>
>> Alex.
>> Alex Benn=C3=A9e (4):
>>    ci: remove centos-steam-8 customer runner
>>    docs/devel: update references to centos to later version
>>    tests/vm: update centos.aarch64 image to 9
>>    tests/vm: remove plain centos image
>>   docs/devel/ci-jobs.rst.inc                    |   7 -
>>   docs/devel/testing.rst                        |   8 +-
>>   .gitlab-ci.d/custom-runners.yml               |   1 -
>>   .../custom-runners/centos-stream-8-x86_64.yml |  24 ---
>>   .../org.centos/stream/8/build-environment.yml |  82 --------
>>   .../ci/org.centos/stream/8/x86_64/configure   | 198 ------------------
>>   .../org.centos/stream/8/x86_64/test-avocado   |  65 ------
>>   scripts/ci/org.centos/stream/README           |  17 --
>>   tests/vm/Makefile.include                     |   1 -
>>   tests/vm/centos                               |  51 -----
>>   tests/vm/centos.aarch64                       |  10 +-
>>   11 files changed, 9 insertions(+), 455 deletions(-)
>>   delete mode 100644 .gitlab-ci.d/custom-runners/centos-stream-8-x86_64.=
yml
>>   delete mode 100644 scripts/ci/org.centos/stream/8/build-environment.yml
>>   delete mode 100755 scripts/ci/org.centos/stream/8/x86_64/configure
>>   delete mode 100755 scripts/ci/org.centos/stream/8/x86_64/test-avocado
>>   delete mode 100644 scripts/ci/org.centos/stream/README
>>   delete mode 100755 tests/vm/centos
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

