Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221BFC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 12:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stRYw-0004Zm-Qh; Wed, 25 Sep 2024 08:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1stRYu-0004YP-IH
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 08:56:08 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1stRYr-000851-5q
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 08:56:08 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c5cc65a8abso2923157a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727268963; x=1727873763; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wvmdd5i9VeVkhI1i1qcpe8blGrh3Ul0A7uGF//Hsgz0=;
 b=nngJQ29PPcjo6t2dgQjNhfhY2yuIhyO7B3Ml1H6GG8tdyXUKlPQqEzz/Qv7zx4cM5w
 unsgCH1WQPsUpwlsskrCWXT1gVrPGF4amyP1SReIogsD32sQYBkH9o4e88uMin/W3blz
 l2/o3jX75ZlwKAKXnnpeIo11YYLPHXoO9zHwwhhmWiPDvX6fKEDmus+LyWVWDQGmA9L1
 scB15DyUI50ib1o247hN/b/27Tt6zAdHFnTH35HmtCiE8uiE4EB/GvDhMbgMhAYZCY+T
 BzeTn1hMzFjQvoJz9lNKQE3R628HO0TW+SVCuQnFupwAFGldWmRoT7HZVkiPoC5z8Q16
 /Nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727268963; x=1727873763;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wvmdd5i9VeVkhI1i1qcpe8blGrh3Ul0A7uGF//Hsgz0=;
 b=AP3LtYC+7R3A/YqpQxx7hHjKIOh5DlnrM4BuKz3u1Ujq9SeC9RzowdmaHBeGv7FsLK
 G35aEpk7i/McEnla8EKWaZxqU/XF/1M5HvJS78ImiDGrSnf8Lz8RSV2xSkB+DthN451k
 V9PnMpHk4Pevvydz5ulh5tY90tWFMu51Q3yyHkm4JXjtx+FeoLUEgqLgFzuamSP/LxhB
 p8H8fDNR96uQ1sX9bFr1DsR+qyqcjLueUkXomtbEuzO9P37C+O7uJwIvvOezrCJO0Ev6
 tMBLH5hOfKksSXFnqSg0PAI8mIn5DHpdahEtxzFsBDRfPVsprD/r00yfWcPNhejsxAnF
 Q+UA==
X-Gm-Message-State: AOJu0YzV2fp/qMB6VRS2r7iCetAC8YSF3zYY+VZNXxoaf8ag18fYvS9d
 rcMuXuvt2WIR5HhIh5jUfaiI8qjVfdnpORzk4nzzLeNlRRd9x3viaIfWZ+p89Z+ij+qyJojyy2n
 w3y7kxc1NHJwyyatVMwThQVbe832P1gU79B61iw==
X-Google-Smtp-Source: AGHT+IGf0/z8mR1HFnQjZzYDCWZIHtNwHqIYsxzLXuBEu+86bPFUAN9BJNLo+AeAyWZuIjkEEpd+Jz3xcNtpHt8zJRE=
X-Received: by 2002:a05:6402:51c8:b0:5c5:cd4b:5c4d with SMTP id
 4fb4d7f45d1cf-5c72061a4dbmr1851530a12.8.1727268962911; Wed, 25 Sep 2024
 05:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240919173625.2859137-1-alex.bennee@linaro.org>
In-Reply-To: <20240919173625.2859137-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Sep 2024 13:55:51 +0100
Message-ID: <CAFEAcA8iYk=bweYz+gyzLmzBJv4TQUPAxirT4YRN=vOkm1yFJA@mail.gmail.com>
Subject: Re: [PULL v2 00/18] tcg plugins (deprecations, mem apis,
 contrib plugins)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 19 Sept 2024 at 18:37, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> The following changes since commit 14556211bc6d7125a44d5b5df90caba019b0ec=
0e:
>
>   Merge tag 'qemu-macppc-20240918' of https://github.com/mcayland/qemu in=
to staging (2024-09-18 20:59:10 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-tcg-plugin-memory-190924-=
1
>
> for you to fetch changes up to 8148fb56c753908fcc41d52846f9d8e6ae5f7daf:
>
>   contrib/plugins: avoid hanging program (2024-09-19 15:58:01 +0100)
>
> ----------------------------------------------------------------
> TCG plugin memory instrumentation updates
>
>   - deprecate plugins on 32 bit hosts
>   - deprecate plugins with TCI
>   - extend memory API to save value
>   - add check-tcg tests to exercise new memory API
>   - fix timer deadlock with non-changing timer
>   - add basic block vector plugin to contrib
>   - add cflow plugin to contrib
>   - extend syscall plugin to dump write memory
>   - validate ips plugin arguments meet minimum slice value
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

