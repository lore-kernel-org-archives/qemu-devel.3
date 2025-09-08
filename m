Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB314CAC582
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 21:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvjHg-0000b2-JI; Mon, 08 Sep 2025 17:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvjHd-0000aW-BP
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 17:20:17 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvjHb-0004DF-5K
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 17:20:16 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45ded619608so1181515e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 14:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757366412; x=1757971212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gdLHNzmH7mA9ve8T/CvWPlFDAqdOAh6fhGY3xIHxsfI=;
 b=Mobc+UmtB96FYP7xRK/TXzw3ea1fElQLG5FwdWPKJ5nlYd/0KGGUzHp8a+52uWP0JZ
 QZfUJ8oANbClzU8NCEvy0GSbOD+N+nM4Jv72mVdBSaPc+j/OtjldTnptICuDI8INTtLI
 f6jnUJmfoo5rEJ6topHoaDp8uoJtWWijPlnkprersNSnwcWXjChUNd6L494ckWJeKkbd
 U6q/aS4Apx/IkzJFa0ZTzRJHVyEZ+qe87Af9WmBQpiwAh3tCw8vDefwk9l6ly8U3TeVf
 RD6hBP102u+6F0SggC5Q3pAzi0ywHjWkkNAm+EOftOgvvmxRxjg4MiGBDrV0QntV0hNi
 b1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757366412; x=1757971212;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gdLHNzmH7mA9ve8T/CvWPlFDAqdOAh6fhGY3xIHxsfI=;
 b=DJf/pXzDpHonLkMv8pRBdzgfj7iSQXfwgJYFBB341AVqRhocS2DJaJozDTNX9Gvzk9
 k1ZwU0idqRuWlHY8UgDkCiTYQOpDgI81HryQVOuVQ92J+1r3wwBEcaMzKkXB2hYjrDgk
 Udw6FnPgQfXn66w8X8bYaFyG2NTtutF8c+0uPlrNYzpwHsz+hsUAnApiHO1pjy8Z5r2B
 c3tO52qTx1KnR1ZKrdYCtJOrkX5LeyDrmQBkQYK2iygtRQTTwExS3y3jhfz4U2cy7i/X
 m5qfBxV9n+iqohi5aFuDTdQPK6zFdygICmZwIZ0jFkG3PtX+M1XfP3Pt6q4wKfBAeV4O
 jszQ==
X-Gm-Message-State: AOJu0Yyn8PHiHm3F/SdokqiNVBXSdtiCGAeE6vb3Evsz6hE8FxFHB/N2
 O0v9iQXv7vEx/SFpZlIuf/NxTs85tK3dh78JAbI2r01pTJxLQOjtlp2iqtCikbQAA6Y=
X-Gm-Gg: ASbGncvSRZTHx97ZLrzhtk4GzWTMXK9/jCiuik5JmsPayABIArJgCakfumhCPWwOoEZ
 zE+Jbr/lqhfyLZIVrWyt7OFhrGY/Pd1LnYQ2bxYqi0jtHPnNtfpkdhhg20/BDJ3kdETmy1fW7WG
 kJnP/6GI6T0zMDeije+R1Ojr+DLPdeKwTltPHeUOgB5D4tqZWhPGG8QqWFFvkXTiJxWaFyqoN/Q
 VCKQxhHyoDKOOP91srEW0lsrxlvz5LHZkYuTNIM8IAz7IaCJOFKYaTINJTYNlqDowrZkDHi7qvS
 7Now8vq2xpP/0lkLp3Q06JBNL492m4e+o6YzYuck4zgjpyLLUeo3RFzag3X5fL/Y4QFuJT0QCfe
 Jv9eq9XvoYt2FGQkfVPmdkak=
X-Google-Smtp-Source: AGHT+IEz0zj29CU7CCCm+TvlNwgBHmyP/pKmSSNlehHLrhRfTCQk0u2YEIOnfT7u0YVDIPUIlkFp3Q==
X-Received: by 2002:a05:600c:1c9a:b0:45c:b5f7:c6e1 with SMTP id
 5b1f17b1804b1-45de746216amr36797735e9.0.1757366412521; 
 Mon, 08 Sep 2025 14:20:12 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45ddfe0b654sm110637405e9.3.2025.09.08.14.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 14:20:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 233735F7C1;
 Mon, 08 Sep 2025 22:20:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yonggang Luo
 <luoyonggang@gmail.com>
Subject: Re: [PATCH 1/4] gitlab: replace avocado results files with meson
 results files
In-Reply-To: <20250908190901.3571859-2-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 8 Sep 2025 20:08:58 +0100")
References: <20250908190901.3571859-1-berrange@redhat.com>
 <20250908190901.3571859-2-berrange@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 08 Sep 2025 22:20:11 +0100
Message-ID: <87cy808wvo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The 'results.xml' file and 'test-results' directory were both outputs
> of the avovcado test runner. Since we're now using meson with the new
> functional test framework, we must reference meson results files as the
> CI artifacts.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

