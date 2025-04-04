Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE339C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fqZ-0003tN-0N; Fri, 04 Apr 2025 08:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u0fqR-0003ph-MV
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:08:24 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u0fqP-0005Cq-PO
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:08:23 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5eb92df4fcbso3761246a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 05:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743768499; x=1744373299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1l4NwR1UggDpBhwB98wgWf7cfuuawxjTXb59a2Sz+4=;
 b=DrKX348eU2qgh1m/trUi1wRFT93M0ATEBmTuVTUENJaqWrKuepNBm0ovBllugxUhB6
 2Nj3vXgnUXqGbt02sQ1Nd33PEaRQV257p3wNm/ea8MgaxdKXtUctbp1tYW4uK6n2Xokd
 jTYFgkICqxXZGOg1y0rh4mwE5hq6Th8TeKikEw35hbzqE9U6pXyiC4ww1DO2N3IgaLnm
 y+CeZKaubCYhMdavsDZhwGHpQV1sgC1B9TXIDrgt/nh8E/bxc18FfgSJmq0/7QhVIy1r
 ZUz7z8o1rCIwq8zeVLLCGz+09ik2F/s+iOSYQRNK/5Qhkluoi5c6jGJuaYmbYxol1ztn
 mVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743768499; x=1744373299;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l1l4NwR1UggDpBhwB98wgWf7cfuuawxjTXb59a2Sz+4=;
 b=pEhrg2XBTxdVd1CaS0AMe+IEQx9e/mFE4IhcLmk0UFnYSwLnIKQPQdl6CCEJuiqSvW
 OigUex9wG4Obh1ELbQlSdMRzS0yJ8/IECaZULZVc8Ru4mi5wfH4Gzd+PA6x3CTkT524s
 z4PrBtacsGCbT/sTIqXFqnvX/QZ2QR55QGG63EhgA7J6p7f6R732iOvrMqiOgIZLryOz
 IqATRFz+Pj4EODH3NuoeKesJ8RpBo4MfinASOS3KRCK1zCbBWHuYr6jLdxWYKfL1jBPi
 vmLAMWoxEhBknDBo8IPo3TpV07Wx9nZQ+TYZXvg1HkoQTsw/Jqyo3Cc3YtOZzv5vd0I6
 YlqA==
X-Gm-Message-State: AOJu0YwNq2XFrgu1VkzlHrpSuKK51Kvb0xPt4KizuAvIddywNv5W6YfK
 FKWca10GGYTGNUZYz54FmwHSlEsGzJMy821mzEUJebCo0Xe41IvjCVTQY5T2k3k=
X-Gm-Gg: ASbGncsXYRedF9oOVZnTMeZ/32X7fi81in/FgCkH+GzD81WpCShCNvYVdonsKyBLF9Q
 4AwgNepQSDk7Dtrtg4eWuju+5DwY6Ihm0E7r4rzZNaRYxhJRzobGtt6/LnqbaoxlmpH/TUCFiRT
 9H/HFimJ35TmsWDqO9dXlgozVq8dCR2CwxZJ+8OsTM61A0ZzEytWOa1aRRrI+1qlewNE3jdWPcw
 SyT7YU43rpuqSOFqjnIbxoQOmI2iPb0N8qLxHetftsOD8zHfR5A1+OhYJFu+kFg8nTjy+2dCBap
 mZ+G6mQNbQNG6sS+zkCVdCRwm7ia/cLiQYVfOxFP+FVQtfk=
X-Google-Smtp-Source: AGHT+IHrXbSEmoCskW6eSSEUM9oiyy1ks0t1kLsBtjW89XCqw2nF2IQxMNWInWr5zCDavXZFeGlBrw==
X-Received: by 2002:a17:907:7216:b0:ac3:8899:d2a6 with SMTP id
 a640c23a62f3a-ac7d185ce57mr319087366b.12.1743768498703; 
 Fri, 04 Apr 2025 05:08:18 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c01c1085sm242601666b.183.2025.04.04.05.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 05:08:17 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 987585F871;
 Fri,  4 Apr 2025 13:08:16 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 philmd@linaro.org,  Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 0/2] fix deadlock with plugins reset/uninstall
In-Reply-To: <20250404032027.430575-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 3 Apr 2025 20:20:25 -0700")
References: <20250404032027.430575-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 04 Apr 2025 13:08:16 +0100
Message-ID: <87bjtcm8nj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> We first fix the issue reported in [1].
> We then add a test plugin making sure we don't regress in the future.
>
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2901

Queued to plugins/next, thanks.

>
> Pierrick Bouvier (2):
>   plugins/loader: fix deadlock when resetting/uninstalling a plugin
>   tests/tcg/plugins: add plugin to test reset and uninstall
>
>  plugins/loader.c              |  2 +-
>  tests/tcg/plugins/reset.c     | 73 +++++++++++++++++++++++++++++++++++
>  tests/tcg/plugins/meson.build |  2 +-
>  3 files changed, 75 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tcg/plugins/reset.c

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

