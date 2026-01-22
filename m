Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AEFD3EE8E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 16:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vixmk-0006w1-8l; Thu, 22 Jan 2026 11:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vixmX-0006tE-En
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:43:45 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vixmV-0004Yr-P7
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:43:41 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so771263f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 08:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769100218; x=1769705018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wdWCZxBJbuXVMyf19t+a64jILL+2UiF9QpvghtKchk4=;
 b=v2OUeskiM4so58UZPRaCqHTjqVoGk/JFm3x99WjUtRjzeMYByDJ2caWQK3zyagd8BR
 zCOvy+WhW/zucOtLENIBi271YyqDJwyWNLlJtaDpkfCPQmJG/R48qM2bRtYnqfjrc7I2
 1zFsIrn1gnxdAmCC4jNUn6y6JKmSo5aAXvin8+au1FrqsA8RimAE0CHfrvzDQNoTU8Hj
 JNS7QD7MNY6oYfhSzDU8vstnSCrA/5j9yAjrduFVFh3ZJe1decWng/p+ah7dc/Fozas1
 VI4ZLE//zemnShel4BI00Srr7y6cp1lK6hHmYR4+KtQ/QYO8HVuNBImif6xU/gT3gRZ+
 IN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769100218; x=1769705018;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wdWCZxBJbuXVMyf19t+a64jILL+2UiF9QpvghtKchk4=;
 b=WS3pQ8QP00MIUSc1TnH+lSDO6XiA+SY0bv+/ugThZW5tJTg7kAygfs6P6OeoPIVXuv
 m2205jIvdDxAHrGsVtmaKSDbyqhnBGKLSwLgdxTYEAEjFqqMNNTZFDeJNKVmiXzM2cCS
 g8flbcGlA0MWr0raPVwhS2f8koZUninUqqQZWWMJDyxajrH7XmU6ITjvaQJkiVB4JnpT
 rTynwbmuMgB9CtO9OudKqM/FekoUCoROrbd2FxwtNaQI1DUtf4/2Ph92pk9gNNob+ZLc
 XAiAUHcW6LXatePDlRSOqLnG1jcFMzItnPNMPk1GInJKndvUnvLkg9EUWQJC57k7y8HP
 Be5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/3HH2wKDJ1ftSIQNz7kbjbQzL7Y7wWX791ZCbfm3qeyUw46TrIwqA4mSFqr9uKRhDhxSQGyn80vf8@nongnu.org
X-Gm-Message-State: AOJu0YwUU2pbyfYUIEJJ19PS7CSoO8FNAipSMubhjIJzvqSJYudzAzD+
 RCzU4ERQhCsYk6Ad+ZORgiIhj3XLDe+fzhLjX/PWE/IdJYSCKXuWc5ka2m1hQmWz4cM=
X-Gm-Gg: AZuq6aLC82xdIe33UXcD3hbTUKKt2BconKAAIujPDM0Obo71ZTDxuEsZS9Z91YQfJhM
 XyeIjbvb/ErGBUYQQ6u9RT7k11tAZHOHytfdjHuicsswXfO72tw1HRUqi13i9LFajBNg08qhzM2
 XFpCCJURR6pUXsrV/ANvQBuMMp3FylqWDf/ZtDmbLRAVZlAEi1HZ4xwiEr/lNGEsBrVFA0H+i/7
 PWi42hSyK/KWb0ql7RRGMYHOqgBY7pkPIWS5sVOmK9i6+mPq4K5v8qqqU92fsLCI4n7kgXeGeM9
 Ms4A8OEaeJUvQZkrl5wAN8EYwYjN9QTzRuqXMLhxaEZAX8cKKvBXnTZzooYUMv/Gefe0zW7jaXV
 m8ExVrJ30bT8nxTRWBqQQ4/Tnb41OnILxqVveNTeOkHeDOqo43XbrObFaRtLxXpWN3fVMoNXSVd
 xM7fNVeGzYXDht
X-Received: by 2002:a05:6000:2909:b0:431:3ba:1188 with SMTP id
 ffacd0b85a97d-435b15bdba3mr262124f8f.3.1769100217508; 
 Thu, 22 Jan 2026 08:43:37 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43597ae9f37sm16259183f8f.8.2026.01.22.08.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 08:43:36 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 38C105F7C3;
 Thu, 22 Jan 2026 16:43:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Hildenbrand <david@kernel.org>,
 qemu-s390x@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] tests/tcg/s390x: Test DIVIDE TO INTEGER
In-Reply-To: <20260121222116.713325-4-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Wed, 21 Jan 2026 23:12:33 +0100")
References: <20260121222116.713325-1-iii@linux.ibm.com>
 <20260121222116.713325-4-iii@linux.ibm.com>
User-Agent: mu4e 1.12.15; emacs 30.1
Date: Thu, 22 Jan 2026 16:43:36 +0000
Message-ID: <87jyx9mwcn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Add a test to prevent regressions. Data is generated using a
> libFuzzer-based fuzzer and hopefully covers all the important corner
> cases.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tests/tcg/s390x/Makefile.target     |   3 +
>  tests/tcg/s390x/divide-to-integer.c | 215 ++++++++++++++++++++++++++++
>  2 files changed, 218 insertions(+)
>  create mode 100644 tests/tcg/s390x/divide-to-integer.c
>
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.t=
arget
> index da5fe71a407..d5ec01d04fd 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -49,14 +49,17 @@ TESTS+=3Dcvd
>  TESTS+=3Dcvb
>  TESTS+=3Dts
>  TESTS+=3Dex-smc
> +TESTS+=3Ddivide-to-integer
>=20=20
>  cdsg: CFLAGS+=3D-pthread
>  cdsg: LDFLAGS+=3D-pthread
>=20=20
>  rxsbg: CFLAGS+=3D-O2
> +divide-to-integer: CFLAGS+=3D-O2

As we generally compile -O0 to make life easier for people debugging
behaviour via gdbstub could we have an explanation of why -O2 is needed
here? Is it the same reason as rxsbg?

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

