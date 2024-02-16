Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E5BC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rawQA-0000w5-Rc; Fri, 16 Feb 2024 06:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rawQ1-0000b0-11
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:30:16 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rawPi-00069Y-Lf
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:29:56 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33d118a181fso748991f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708082993; x=1708687793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIaqEKxla8by4CNie5UtvlAxZ70g97+C9RyQ8V1R4Ko=;
 b=VFZfmG9MpAt+leTWgRHmWor6ns4uBX/NeEb3Jn6z39Tw8/Aa8/ELdGcenLtr8KGjZb
 lpEFeTXJXWZA5x4OimjZPCRcJc296T6GAmSy3ngOKV4erT+3LcUlyM5fy9jtVPqRiRmy
 qcdcUd9O97xwIHDtb3bNbrSI95kgnlu5IKoBKNZkPqbfzBdoF3ltBopQruPjGkOC8H4i
 LMIsK/aFw5AzPPbQAusXW6896jmNTsLQsGgDJeLQZxhbt6KbW8LEpH+FHP5u1WYECkjv
 g7N6T631AGDWEygF/K9/aZGFlGNkj/BhYEUZ9fHYlgXEZH9KDtNLhECZHNX9cQGm5ACy
 vGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708082993; x=1708687793;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZIaqEKxla8by4CNie5UtvlAxZ70g97+C9RyQ8V1R4Ko=;
 b=IsefkAdpcDgAsdVfnl2ToVX79dQPbj+lDgnWh/jAKsz1HwAtBVM4Z9nU5sruCCtPeB
 10efUPMBr7hxrUNkSEH3jzSvgmTRabC2INvVEPyHO0+aMBaDOL8qiQUm8GpYdZCpbkpA
 M+XDoPGhEJxPLZ5t1c6JhReWLomEfbHX6Dhsvl1vrNJUhmOjfJB8Qt1ZtZ+tupXy+PZW
 AU3q7QchhAtv7DU/pfPJwOEODRunFKVglG7K9ykOaNAVi4kiIiXo24LwdDQwq8YGFB4l
 Q1Cjc9hB1WuGpCg5Z4+uQZu++cBadYmTY0ZpC/X/TBppYUYEwLCtx87xiCws9z88Up45
 /7pg==
X-Gm-Message-State: AOJu0Yy0+1NyyqtGilzr+c2DgpxoJY1LsT2131rHSRVSoGmUnjL9Mdgw
 n/Y2yXWBlgO9b8HxazvSEbHxO5VvillHDUHNS96Wgrj4E/TQ8tAAkM23LZZCbtE=
X-Google-Smtp-Source: AGHT+IGwumDf0bhVBDaFLI4LnVi/zfpbD27OYbi2cV+yZlPU8UXmm8aLmg4cwUcge5/S/eODF8bSqQ==
X-Received: by 2002:a5d:6201:0:b0:33b:792e:e780 with SMTP id
 y1-20020a5d6201000000b0033b792ee780mr3222607wru.66.1708082992883; 
 Fri, 16 Feb 2024 03:29:52 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bs28-20020a056000071c00b0033d247309a9sm404508wrb.12.2024.02.16.03.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 03:29:52 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3BBF15F83F;
 Fri, 16 Feb 2024 11:29:52 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-stable@nongnu.org,  Yonggang Luo
 <luoyonggang@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] .gitlab-ci/windows.yml: Don't install libusb or spice
 packages on 32-bit
In-Reply-To: <20240215155009.2422335-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 15 Feb 2024 15:50:09 +0000")
References: <20240215155009.2422335-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Fri, 16 Feb 2024 11:29:52 +0000
Message-ID: <87y1bk4pfz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> When msys2 updated their libusb packages to libusb 1.0.27, they
> dropped support for building them for mingw32, leaving only mingw64
> packages.  This broke our CI job, as the 'pacman' package install now
> fails with:
>
> error: target not found: mingw-w64-i686-libusb
> error: target not found: mingw-w64-i686-usbredir
>
> (both these binary packages are from the libusb source package).
>
> Similarly, spice is now 64-bit only:
> error: target not found: mingw-w64-i686-spice
>
> Fix this by dropping these packages from the list we install for our
> msys2-32bit build.  We do this with a simple mechanism for the
> msys2-64bit and msys2-32bit jobs to specify a list of extra packages
> to install on top of the common ones we install for both jobs.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2160
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

