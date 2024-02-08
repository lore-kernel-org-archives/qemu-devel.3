Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99A8C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 20:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYAhP-0005bh-Qt; Thu, 08 Feb 2024 15:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYAhO-0005ax-5N
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:08:42 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYAhM-0002Ns-H4
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:08:41 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-560c696ccffso2393142a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 12:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707422918; x=1708027718; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JZ65eydw4YCzuP6CJb07VtIdfMy3zzeho4/H76W1l2g=;
 b=bW0rHREe1CsZNRnC3EjgH/4/TqhaifhoC/+Am/UYc18JXLqAulDWPebzOhp1mhgpe3
 CvU8H9+lhxgZXv84yK6ZbYZz7N43VnZ0QWTrIEGT+UYZlZZcA8+thcxsOkLuEoa8KZv8
 T7gJjaYIpCOb7mTBB3URIr2ZT5vE26nuKIVMe6KMsrXgTDXZ6M6y7fPciMWwls2Oi+Rx
 dYg5me0H7S8LNsVgxebdoJvoC9UC6HRJdPJA5hddrUl6XJa1DU3U1GOV4qPcscMkIUeY
 I/JXZn1Tc+t3d0owzja7ABKfdyp1yIw6/l6W0M2uwBq7ab0jGjGwLtVVORoReHcPgW/X
 eRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707422918; x=1708027718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JZ65eydw4YCzuP6CJb07VtIdfMy3zzeho4/H76W1l2g=;
 b=Ubrw/vPnXvGZnlFqLhT7eYP3r74RnqX2955BeTe+7yhbvHYPja1dIe+pZ/FfrZZ6S5
 I1xbXmthRQCoU8VTU5fo1HIyBxmDpKOaOZqS1pkENBZa1FSaglx81XtoGzOWZFbCjyr8
 BJvJei91cLrUPGGFzPyyVrpT68gPRHEZ8XLe8AoB0Tg8/4THoOhiNSVfdsY8IQ8fYhEI
 h8H/uQOdcFXUj1WGIrntExggC9r23pSFpFKGgQU1/kdK2bT9HKAFIBcW/I1kBATbzqtv
 VFDCbxKYOE1jMsFmb/2aKQXai+MzGHcddoHtKNh3WsdnC6hCQ2wnKl0tmONxpjM1BkUd
 sscQ==
X-Gm-Message-State: AOJu0YwyTJ/AjkrDk3i5Q7Q+jUyc543mHGKcyrlK0FYfUogDG+He/m9m
 h0iOVU7Cs/OO0QRaVE0BXQ7EosSPeYG+svf4HUfLzZkjnb1e/Qsj8ZHq3YP3JNnHlIMV0mwJzLE
 /ahf4I0h2zO6cD+UtTb6OSCqzfG/F1e12mUuZWY9ocqjtVPYN
X-Google-Smtp-Source: AGHT+IFZbxmGVWKgzaImKDJ8xOKjA9ztTQicZzDuY27BNRc525aGlnLauJMMOobt8mRjDyyjz+4R2QrsUYoImFzSemg=
X-Received: by 2002:a05:6402:3203:b0:561:ea0:e234 with SMTP id
 g3-20020a056402320300b005610ea0e234mr2974327eda.16.1707422917712; Thu, 08 Feb
 2024 12:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20240206032151.174516-1-richard.henderson@linaro.org>
In-Reply-To: <20240206032151.174516-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 20:08:26 +0000
Message-ID: <CAFEAcA-kBn7S3e=4UqMyzHtVRwQjyKF0dYoeFsSURQb_UF4ZHQ@mail.gmail.com>
Subject: Re: [PULL v2 00/39] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 6 Feb 2024 at 03:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> v2: Fix rebase error in patch 38 (tcg/s390x: Support TCG_COND_TST{EQ,NE}).
>
>
> r~
>
>
> The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:
>
>   Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240205-2
>
> for you to fetch changes up to 23c5692abc3917151dee36c00d751cf5bc46ef19:
>
>   tcg/tci: Support TCG_COND_TST{EQ,NE} (2024-02-05 22:45:41 +0000)
>
> ----------------------------------------------------------------
> tcg: Introduce TCG_COND_TST{EQ,NE}
> target/alpha: Use TCG_COND_TST{EQ,NE}
> target/m68k: Use TCG_COND_TST{EQ,NE} in gen_fcc_cond
> target/sparc: Use TCG_COND_TSTEQ in gen_op_mulscc
> target/s390x: Use TCG_COND_TSTNE for CC_OP_{TM,ICM}
> target/s390x: Improve general case of disas_jcc
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

