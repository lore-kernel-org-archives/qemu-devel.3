Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C45CF54ADA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w55Bg-0000CZ-Uz; Tue, 24 Mar 2026 13:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w55Bd-000061-SL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:05:02 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w55Bc-0001fX-42
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:05:01 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-797ab169454so44329647b3.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 10:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774371898; cv=none;
 d=google.com; s=arc-20240605;
 b=bX8vYkOj9lFbVJV3XxE1ZFvoW2HTJzJLG9lKSn7UgOSiq91qi5asOX7e3KRD7VxWe7
 YZoPtP8nt2quJZ85dt6pMdyATVG+Ei2f4ePIZ4DgcEN43WO+/6ieShMRK561UZDNaJhV
 gij3pRH/UNmpWv89MDEJY0ukCZiLIFP4TU2naGlgQz/in8LXbIbgZQ8yMHr37iWi4GBb
 JTDq4DKa7lIxYGmYMsShEp0s69ok2M5puBrZoG3PFaeWQVlhzYkfaD25INVQyO9TVPe8
 xEWgfWXyxXeceRwJNlQIXxN7uBUQWcypHJq3kzyWduWqGBoIRMSX03zcxl6zgOiSOkqI
 H/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oQzj8rdeZMv0F7O1sRbox6Ujt8ujtPq8+oNcjiyDO/c=;
 fh=8EqW8ptiFroiMunud588LTyXANxgV4vUbXxoMyNhrzQ=;
 b=Z0o74uHGZTiiS9HuWUUwedr4yQrfpXNboNSLoC+hy5TcfakRyYa6IJLEH2nT7EUknG
 w27fCJEG5ZXMXISnP60BpfYZ7jKSrZXWbuvuZwP8+qwo3y+J3JOGFG7DP9E1RvoeICpb
 nMwq/Az/yd38CDasYheHRxgjkYCjJXOSjkSy+bI6/Wl3Z0+OUxW66cYhbRKfwKaeraoF
 9SgQ8whcSmUP+nJ79Ac8zg4hOIGE+f5KcbKrbN9+NPrYAfA33tWswtpD2Ij+ljGJHLvQ
 uvw4h13kJgm9yEf4C+ZBhS1tSJtpXzLSKF5GNtFV+uEY8rfQpXWmMi8UgcEMcp4Kt1Aa
 WfDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774371898; x=1774976698; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQzj8rdeZMv0F7O1sRbox6Ujt8ujtPq8+oNcjiyDO/c=;
 b=OkYgQVBcFGLrNaATMQtKoLqA1uReW562HZ7BVp+IMeKWvv7SrUys3fAlPFh0x3rWmb
 kx92iraMNrNTmnL/a2it0fu6xkmnPkXaMP46Xnbp4ruHfq3tyLDnqqIgc7r0VWnkpIoC
 lwDsn/Dj8+NoWqBuP1dS9mOYeeAKDdHiAkcjL4vAl9EGOJeWesSATXFz12zP3/vldLKC
 e+ZsNsLc6C5f/bIfaj8y4CTcJ8zp135jaYw/5TuUOBU4czYYyMeH6ivuXBkr4m+w3X2n
 0MeAaK+98D3W0Mvs1pcXMgOq3GQH65/tG+1piqw9eRm2YS72Texo4Q+1/zyxFkYOwizV
 O60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774371898; x=1774976698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oQzj8rdeZMv0F7O1sRbox6Ujt8ujtPq8+oNcjiyDO/c=;
 b=ssud9xuTRlHJx2zuYakjKQcF7n4SjZszORznC7EU5lPvL+EUOLUfeQHFTDlxpgzQfl
 KOCJkqZCwAveEIh4A7wChq3LUA0DdUxbOdWs/x5YV9ZS16NAMh1T6/Ptj7jCqgzGzGEx
 6ZMJAgLPYw3b03uzyWJVzG9Wtuy7GKPIwz0QLdLn6dXYBOTYGzLKvItTPXbs3x0wh+O4
 qislqvuGhGA1hzYY75KqJfD/xWyQTEmYEtSbbCzodUwVrZIeO5IGDQ4uEz3uK9XCCwW1
 slElovhGmF4Dr8LKoRuG+cowWXsJJ1rQNyK/Pl9ugWLRKDzVwNMnuNcW3opCiEl+whoG
 IC/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6nT6gPQ+F/0Ulr/ye6CUn9jehU7NPNc+BlCM11j+qJSnxsGRcuIv7quYBmQKDngj3X9iF510D46qg@nongnu.org
X-Gm-Message-State: AOJu0YwaqL/TDWLmjkAXoTP8I6Xwp9FZwgp0pTp7JRuInEWL+e0ddtCH
 JaGsL1ZeI8EjXyv+FkFtJXZNZ5fppK+eh32YNSgKZ6r8kk8FD38ltfde/+e+/V3chGET8vxphDf
 3Q8T7JV5pm5XjjIrH1llBpxvkaGAI6XxJgeytNq62gA==
X-Gm-Gg: ATEYQzyvqIrpK3oUtr5MvDhvbICzUqUkLrXq/sGUzQDbBBZy66QSq8CfFxPN/UEqi7U
 zadfplU2n8QqrapYm+cWUsELmDgK4Og6or+HbQsZ2uGzJV2fNJAoV6WowldV61qQQfYo1EClyz2
 w4nR5mgjNTCuKkm0yqBWtnmDSLEvRtrkLjxjtiLD43LCgW6jT3+rmmk/MsH3Vgtn04M+GRkwZBU
 hf9M9tAaRi22QVqFDPaTH9+6Afp/jwcdtDZR+sHE1DJJYEk/gcas9UzmHyEfBCpS7QkdudRXIre
 3TOn6Kd3u2j9AMfmRelSS9PCN41MgN7fbH0GzZmru50oE/bl7OIJvLGM7oTy5LteVSo=
X-Received: by 2002:a05:690c:31e:b0:79a:2ef2:833 with SMTP id
 00721157ae682-79acf397b28mr5421677b3.20.1774371897498; Tue, 24 Mar 2026
 10:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260324165705.785605-1-pbonzini@redhat.com>
 <acLDpimgjedofUgE@redhat.com>
In-Reply-To: <acLDpimgjedofUgE@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 17:04:45 +0000
X-Gm-Features: AaiRm51kc9hidfL-DKOnRtYfagBpJoWoEWCHfkTAYU7RlJzwhdkj_z9y0xpdjhA
Message-ID: <CAFEAcA9nZ-ROCjRoydZ-uiZRfye4yKjpiORJJbLV9OaTzeOOug@mail.gmail.com>
Subject: Re: [PATCH] treewide: replace qemu_hw_version() with QEMU_HW_VERSION
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Tue, 24 Mar 2026 at 17:02, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> Also, is there any better place this can live now that this
> header file has a single #define and nothing else ?

It's used in half a dozen files -- I think that generally
"used by only a few things" is quite a good candidate for
going in its own header, rather than putting it in some
other header that gets pulled in by a lot more C files than
just the half dozen that need it.

-- PMM

