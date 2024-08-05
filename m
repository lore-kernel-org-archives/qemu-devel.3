Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F2AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 12:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sax05-0002Qb-Sj; Mon, 05 Aug 2024 08:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sax03-0002Gn-3Y
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:39:43 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sax01-00054B-B4
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:39:42 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso932202266b.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722861579; x=1723466379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ienWlf+VwSq2/Iu68xm6DShiUfxfLb2JlS1QTOKch88=;
 b=TbIOrw1tz48DETzNIyiAyIQRzZouFLAua3VQoApv9UjoC2GIG0SryLiM/i+pOY5y6s
 9po63hProcJ7fh7B4vvjw4lUiVOUeKnE/2cM642ZVBj/o4ctdUvcpUUTNSOSjK24Djj7
 yXqv5hIbA16e7nNP0hnxmsDt2JSlIxG5LsQIPjzcapnolUVyPsiAGpAFCDfeqFcqV3NN
 SNpG3iH2x3wQg6gDKN6boIPzJlfUkoQAoa8Lp6dSxctnYaPBBiERxbyT/II0ZlDG42Cn
 52uB+bqNsqwI6aX9wkV3ebOsLbYg2eBbXh50CFRv713eH7JDUz9U45RvHOfXY5SHA0iY
 uJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722861579; x=1723466379;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ienWlf+VwSq2/Iu68xm6DShiUfxfLb2JlS1QTOKch88=;
 b=bunb0xsIZBJfgD+20YHQWcNGrXRecg7w8YEx9Msr3xsm5i9eTRPPtrj0DxjDUsmGFW
 QbSKqmovET+4Kzz7kZtCEQeP8ddgFylWXEXtoX1iW/5Eyu1+g3Cz4XZ35GQELr9wE6ua
 1CsV6wa7Xb7N76C2aa4+ulBvBVQjaaha+wAcjsvYtRX0aGALoluM71j1s9D4fT0oJIEC
 6TeSu41MNlvrklfq/qtZa9gVhHxXBzFzD9AjrD3gDFh3pA2QUIvYWNgx2e2srGr+O4GX
 rcnD4jC7Dx5Z2wpWW0HX/h/VlrOaNyJPO8bqZ3VW7BK7VjayfKso6x4IvvtlXSLoDEjv
 yi2Q==
X-Gm-Message-State: AOJu0Yz4LrZMD0nGKUq8sSbMkcZLxZW2dFAZemXIayjiKMEendU3SFuw
 4FdytN2ibLTwYVnbZ+2ppzApTUOx0pcYAs69wN68UhJGX+FY2+ccfbCg1jumH1E=
X-Google-Smtp-Source: AGHT+IEtqC/qkG8ISkHqZwiB9uVo7E3pLM7zANGNbauB6M8cwp5Sk1leEyA1nxMIPJ+G/6t2x6qoPQ==
X-Received: by 2002:a17:907:c291:b0:a7d:e5b1:bf65 with SMTP id
 a640c23a62f3a-a7de5b1c431mr257095366b.21.1722861578206; 
 Mon, 05 Aug 2024 05:39:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bcac58sm449634666b.35.2024.08.05.05.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 05:39:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C8A755F87D;
 Mon,  5 Aug 2024 13:39:36 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Yoshinori Sato
 <ysato@users.sourceforge.jp>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH] tests/avocado: Re-enable gdbsim-r5f562n8 testing
 U-Boot
In-Reply-To: <20240801172332.65701-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 1 Aug 2024 19:23:32
 +0200")
References: <20240801172332.65701-1-philmd@linaro.org>
Date: Mon, 05 Aug 2024 13:39:36 +0100
Message-ID: <87cymnrvnb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> We disabled all RX tests on commit 9b45cc9931 ("docs/devel:
> rationalise unstable gitlab tests under FLAKY_TESTS") for
> being flaky. However I don't recall the U-Boot test to fail
> (the problematic line checking the 'version' string is already
> commented out), and I'm running this test reliably, so re-enable
> it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Queued to for-9.1/misc-fixes, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

