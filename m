Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E84BD3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 20:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2cdH-0004Ex-Np; Sun, 20 Oct 2024 16:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t2cdF-0004EB-Jy
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 16:34:33 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t2cdE-0006ys-2M
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 16:34:33 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c948c41edeso4366251a12.1
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 13:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729456470; x=1730061270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7FP+Hz3sNeRNIYVqCJ3bmGxv9UjGLV2xCkZcFke+iE=;
 b=u/j6+3BohxxHfsJmVlQ0WSt+kGeBqH0sDcgKbC+hIBXiwEmaxxNDz+wg2Zn8bxdPNv
 N05KRuqlE05ok5WKjnpYmIV7h3Cp8Vp/FnUQO4Mp4k29/uF+esCBKb1GwLpSoWXNm5wo
 ptFT0wCh7wOGZ4R4M+eYC229Ra0dmyy84bHyh5nQwWCAzXRAyVvStl4btQ+3HGJL1eIw
 Tu92AJQgt/Wa1mmquo3RiFOGg/x8cArWItEgQDvUj1pPvCxGQ79HzbJmFuxQonphrpfL
 s37sQL1XsHgHTk+zsyPEazba4Qqe3c0WiPFDx7C/hvQ1YkTbCyhIJCKDhlgDlwfFBmbF
 hv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729456470; x=1730061270;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T7FP+Hz3sNeRNIYVqCJ3bmGxv9UjGLV2xCkZcFke+iE=;
 b=C3WFhewyPKjiyrsJuBsOfHoETzh0qK2q8GbAR4JfqyQ+HjNKEBGY8iqRZIRIFtiRPt
 LIs4l39bar2zhDWSiCArrSaxGR4a/p9pvB5hKplR1MA3axf48mCwrva8wZmpY0Ee3lhb
 FyujSyaJ2sE1iHMuI2aJeDLUlWiJQf+FGwqD2J8RPZixQhx5eFPd1UllkmTxIOScXqjs
 xcNqE0DmGy3mR5yFt7awAcEOMlchgo108z9UJhTWDCm3H+dxkihgeOi6p0Nv3OnhJQux
 Fn0E4S46W5q19+xa6yAhyIKDhTT8vLD96G6yqV7907Wqcl/KLaYWPP5e0US0gESc0fTw
 0n6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSYQ0Av088YH9yYOz91W69tvHRNW6apKmGJjyUn5jQjjuXeY/dR3IaeaOg2gu+Lmne+9mGVbWuPakF@nongnu.org
X-Gm-Message-State: AOJu0Yw4vO8bhSNy9xO75YcHFlGER5+39HmS92fum4V4wMJ1BD/LPSHN
 5+uLatBCvmhN7JWBk4bMvbVm1YPcyqD+tZWCMVVxc1u7R41Ih5gtSkGLQBaf9mw=
X-Google-Smtp-Source: AGHT+IH2uhq+ceHnc8hriZ6G6qhlcBvnadRqwG89PGOA3dMeVCmDOTOcW/sTN2bkeB2KRtrKSxSunA==
X-Received: by 2002:a05:6402:2693:b0:5ca:d533:1c7b with SMTP id
 4fb4d7f45d1cf-5cad5331cb4mr3617953a12.28.1729456469942; 
 Sun, 20 Oct 2024 13:34:29 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a653f5sm1218081a12.26.2024.10.20.13.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 13:34:28 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C25185F8A7;
 Sun, 20 Oct 2024 21:34:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@kaod.org>,  Jean-Christophe Dubois <jcd@tribudubois.net>,  Igor
 Mitsyanko <i.mitsyanko@gmail.com>,  Andrey Smirnov
 <andrew.smirnov@gmail.com>,  Alexandre Iooss <erdnaxe@crans.org>,
 Alistair Francis <alistair@alistair23.me>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 0/7] docs/system/arm: Provide at least skeleton docs for
 all boards
In-Reply-To: <20241018141332.942844-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 18 Oct 2024 15:13:25 +0100")
References: <20241018141332.942844-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Sun, 20 Oct 2024 21:34:26 +0100
Message-ID: <87bjzev7hp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In target-arm.rst there is an apologetic note:
>
>   Unfortunately many of the Arm boards QEMU supports are currently
>   undocumented; you can get a complete list by running
>   ``qemu-system-aarch64 --machine help``.
>
> However, the situation isn't actually as bleak as this suggests:
> over the years we have generally insisted on documentation for
> new machine types and have filled in some of the gaps where
> there was no documentation for older machine types. Plus we just
> deleted a lot of older undocumented or underdocumented boards.
>
> I did a check of all the board types listed in --help and we
> really don't have very many left that weren't listed in the
> documentation. This series does some cleanup of existing
> docs to ensure that every board covered by a .rst file has
> a line in the right place in the list that lists the board
> name explicitly. It then adds placeholder docs for the remaining
> undocumented boards:
>  * nuri, smdkc210 (Exynos4 boards)
>  * xlnx-zcu102
>  * mcimx6ul-evk
>  * mcimx7d-sabre
>
> and removes the apologetic note about the list being incomplete.
>
> The placeholder docs are obviously not very useful, but they
> mean we at least have an entry in the list for the board
> that gives the manufacturer's name for the board, and we
> have a place to put expanded information in future if anybody
> wants to write it.
>
> Anybody who has more information on the above boards is of
> course welcome to expand on the minimal files here :-)

For the series:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

