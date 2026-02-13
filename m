Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AC6EDF14F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqPy-0000R2-Ls; Fri, 13 Feb 2026 05:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqqPw-0000QA-R9
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:28:56 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqqPv-0000MJ-B4
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:28:56 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-794fe16d032so7541097b3.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:28:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770978534; cv=none;
 d=google.com; s=arc-20240605;
 b=I34Jq/zCsgKm77fPRxJXy0wBe2JWVeAiiSzj82+V4rZ4yS8PcbcG64qJWIWvmWtN1J
 hVDAF3z9+Z3/VDp8s2C9zc4/zVBXgKrqVG35Qy7IwrBHhc6ONGntGxY2zamvx2ZjKaUP
 ubeOiqtJD6UT7NfnBu1euCR2yj4WE9IlCyNyw3PDBI2v298ZiAe93xWOQ7Idmx/75uev
 z3Gx9u1y1JiyjEAQ4108plB+sSBR3iyZbVomu3uU2Q3nRroDpNipaEuQayGflCY0oXMb
 3dpbCCCGyytKePDq99ZYenKhafMw3Yg9ujVrvS4xloUsUc3KPnwgZhDkxVM7HNXMyKjG
 C+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=71LwTNqT/NNqZ4a8HGvV/q/9xhMcMJWfeFJpDgLViVM=;
 fh=mTCsoxjBgOd/zuy0URx9dQbBAHYL6IL5i4qnzNiGkKw=;
 b=WS5L6EtNRQvrVfbB24DP84zJ7jyePEiKcYx/EhNW1kIActc2GZcdWZp21RZoK2n3Rp
 wGsnV5pIW0cfN4FxvB8/HhmVZYSMQjfEpUHQPlRsUHKWfI4auHDHqanoKRZCYcxzR0t+
 jPgCS/Qq9KWp/53IS1zw9NYFtPormHICmmRRHJ41+TvSYUeuf1vTnBB8sNtMG528TFiD
 5PAKd7tvVZeyET8I4fXjGsC0SFX7E4ioU4/dxC+axRqt8L0H+tk57pUwbRlbf0rUW3Xu
 JY+JEx80fIkXk3T1Wfuet4Fux9ZeGGCbNoRHcygtBMqSVOJ+TT6h1pEWDRbR/MxV1vJj
 /qGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770978534; x=1771583334; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71LwTNqT/NNqZ4a8HGvV/q/9xhMcMJWfeFJpDgLViVM=;
 b=w+TWO/01rOIqwR8Hs4hNfHxUWl0ER7l0RDlF6t2YtlKZMPsaRV2vOIAIOwE0TZ1jGi
 tZL8Lop4yXQeeL1brmCfRTrfF9XoBlYIlMQN6wBsWq3jzeS7FkNyYmaqb8ezt7/haQWx
 kg62u5EHPFCX+ULw3Jh7YXqCNR/FqPX2U+BPOqqSjnN8VU6ohTREFR6bAEu0qtjAS0TW
 DnpMp1BhtnujbeXeTzEI4e4NyZEnVT4aLX4z/xc0oPMNaiCb7ju8PPAtZBCizCto7MC0
 Bux1IZevM05Ft66ADtnm5fkPEkYUvhu1eyaEZvpzGAxP7RO5Td+G+mIKPZlPzm1wsePa
 fbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770978534; x=1771583334;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=71LwTNqT/NNqZ4a8HGvV/q/9xhMcMJWfeFJpDgLViVM=;
 b=of1+xFpZih61+7UfJjGNcWrYXrh26QwdInAVxq/5+kA34tEHrxdxuO5oskLM/OSDy5
 3EHTZepJfIdhMKMs/RVLQPsOT6+z5yif8pMlr3jJHpEbqvPNQ4w1unExe7bIXcTcgaMf
 eSQzmTkNKx2HTT0cXtyK8X+f4IoVuSIVz44cyO1qQV+l1riBUQojwAhNaWqba+Pi3/O1
 A1v1e9agfrtUECJCWyZX7u5Q4mvOH3rsDocKe3xw60iOjb3VzDMBUZ5uFww3HBaINxxg
 OkAOEO0fw6OSrli0FuAlzX8HyTI3oT2hQ1/VxKf/xtt8LX0T8MfFfS1x5ihe1z/P1jos
 qvGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3rlOiIlp7V/Ov+oqjo5ClMIutlkoP+XD1o1Y6cw/iuW+KMvlO8mtVdd5ksrTeCWi3f5s2qQZEe2bL@nongnu.org
X-Gm-Message-State: AOJu0Ywf+OOXcbI0IKCjnTScTS+Yt9+1Z/s9xs8nYigwRZJ9Q4mC5V6L
 8jkggSCGPFFTqhANVshfLOkMJ6PmCnYJLzFmAJxI4LRSWTUwQCY2xaBENchvej6Cw4SGYrEO+0C
 FdJSBQb2gHkieh/xGRKmU98SDeWEABgZfakWCmDd44w==
X-Gm-Gg: AZuq6aKPrN+iHa+1LVTjSfgbNoQ0FZ4bacVvwS4sdekkDArtbxnadQkBqeina5ix5Hl
 61Mfccc698hFc+0VRh28vRpY2Lf6POkvEQxqAtJW4+ssVNTVuRNuutP6P4zkEOpiXACU46ShQeS
 ZNukEkaH5RWxJFIcMyaUWESBLy9Vqm0c+UqgbtfbrJ580nk2Fe3JqgIO6jN0C+wPElpW55oOWd+
 /IOLivMhnqQg14YqL64NilaE5igKxcsGKltw6DoeEOk8gpdomlPiUIoqhSKLtSWHdyPX54/RI14
 IAwRh+OAH6G7Tr/uytWQ5vlBPfhbo7mxxCIMpxx0sNdQDMNclxnBMGBPzLqES+5e4q4=
X-Received: by 2002:a05:690e:1342:b0:649:468e:3673 with SMTP id
 956f58d0204a3-64c19b44ab0mr893630d50.72.1770978534145; Fri, 13 Feb 2026
 02:28:54 -0800 (PST)
MIME-Version: 1.0
References: <20260212213955.2225662-1-clg@redhat.com>
In-Reply-To: <20260212213955.2225662-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Feb 2026 10:28:42 +0000
X-Gm-Features: AZwV_Qi7lJMeFO8WaEXJECZPAHqmgLNbKiFuWVx9CJheba_nzKBTlVnL7qlXpvA
Message-ID: <CAFEAcA_Bc+TWkjOHGCt84GboQfdubxjSmsxUbDWeP8rY44m3EA@mail.gmail.com>
Subject: Re: [PULL 00/16] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Thu, 12 Feb 2026 at 21:40, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit 039fae56bb79af1124619daae60e01c257fcb2=
ee:
>
>   Merge tag 'pull-request-2026-02-12v2' of https://gitlab.com/thuth/qemu =
into staging (2026-02-12 11:52:31 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-aspeed-20260212
>
> for you to fetch changes up to 1b662879513fa9823a887cac9cfc3d91b9d3f616:
>
>   tests/functional/aarch64/test_aspeed_ast2700fc: Use AST2700 A2 SDK imag=
e for FC tests (2026-02-12 16:06:55 +0100)
>
> ----------------------------------------------------------------
> aspeed-next queue:
>
> * Adds support for the AST2700 A2 SoC, including a new machine and
>   a functional test
> * Enhances AST2600 OTP functional test
> * Restructures Aspeed ARM tests into separate files for better
>   parallelism.
> * Includes new SDK tests with Linux 5.15.
> * Fixes Aspeed I2C models
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

