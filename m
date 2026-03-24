Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9624E9A75A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4yg5-0006eK-UT; Tue, 24 Mar 2026 06:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4yg3-0006e5-KO
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 06:07:59 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4yg1-0003hS-TA
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 06:07:59 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7947cf097c1so35572787b3.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 03:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774346876; cv=none;
 d=google.com; s=arc-20240605;
 b=DueKW4pCU8p3Rek+CzkLbN10afusAhe+uxVzaxwPVMj4iqwbREqK7sFS+9VDi5mKML
 bGSRR9/OBrVM9XKKarNPwGBVAOyzaZm1jwiT7dO8sUIs6KI170nagIelPUfIFe5GeXVA
 n7VraFn56CtoImPh64oglEBd+F1NFHOeNKpc5sRSqM1Yf3ALePlbSivdCTD1jy4+izj3
 54jvG0EThh8cC90msA+ghsdZvNPbpaDy/cCmeix5RU31tBforzSoigECCMiYtMFMnD5r
 92avibUuK8nx2UGHWss3zQOcuraDU/xmC5UpRPUaIxVOYKF0mHwegdjdsKIPvTcaJ5Jg
 SShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3bNpGPqeCEU4SDlzKSbCG5+gspVfkKwwSOjFPxNCaaM=;
 fh=axbB2bjiSokmisYx3H7DI5yUO3Z+Sykod4F4JR7lPwk=;
 b=YJABkHwlAha6/M/kOUWUL+QAkWKSVQmWd09PMtjDhNLUIFU2f0GKOqg1KUzo3N0MO8
 sqsgCmWjXoFYKovpkAJTtBiih4Tj/TSBV6TX2lVXZSAld5qlcDu/xqZk+hXJw1OWsRp8
 h11PjR1c130R749x08KZ+j+Dgahtz81ReX78Mr04d1M4g+wIem4+CjnHrBaEI/ESH+bs
 WPav5nncHpGSgarkagY7zw+7OVgWESfKq4DbbQnYwh3qOPdpYx5/8gOAx/B4cR7OpjP7
 XPiM+DY1oOYhqkJw+xQ4wx13tYG4uNdMCIANwT65jnzTJjDLM/lwRPxU2fTYR+asSQPs
 ggAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774346876; x=1774951676; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3bNpGPqeCEU4SDlzKSbCG5+gspVfkKwwSOjFPxNCaaM=;
 b=irgpzNCA6quza1DxoPUOyJloGe5BMeYoisiE6Kw1H0xF8dr809pGOAjQVznYKEsJ54
 ngPBtU6e0Jy0bnzUNoZ8/6NdPdgzUk29e4RCnzhY3myWXH6251MT1J2u6fJbpHK500FL
 052E6er/eBlBE4iszlZIHMQ+g2G0wLGzqvWv/CrfwKe1SiGW7EYYnBdoPbxtuO+UZ4rR
 jFZ9AhkUr2jcYl0OBpEkNMu597oxVxWXb8VzUCL3CgTNuZIblD1iusjwg2BjM7f0Cklg
 VhVe6jnbFUrMDEvWXQMqDexb5zdBd5GaDGdlncu18tXyzLW5hKL4ZTra8PRBU+3Ap+FS
 mkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774346876; x=1774951676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3bNpGPqeCEU4SDlzKSbCG5+gspVfkKwwSOjFPxNCaaM=;
 b=dABFIGSeIYdqpsRaHdJIjxgEMt9OqFSNUvx/4MsFzTrvzVA8iTuYE83SZ0Vcv3ok4O
 ltU1tmK+n8kRG+GA9PQTwV//Ph2VgTw6iiQWVnYTuAfea9xJUSH9M/hGMJnUxx2w17U0
 ZO8r7BFU39LNdTPVZiOt20JaBFJN+yefsJjVYs2iZVM8PBCfJut/OrPhbTmAv/C5llzy
 xYAyjHBpYfK2P9HDhmmJVnqD1QdSL2lKlEM1H58OqBJH2il4a7GNNuXoJSzj9AQO0HyT
 ib4F8mkukRArvWxSjM0unIKs5PX6WAqB9nVL5Z7uCn/fKnXHq/fRX5fW+CstaNMMpIze
 BOUg==
X-Gm-Message-State: AOJu0Yxhp7qalImpai8wF6v2WWdWrg+EuYamKYaTTRgAMoHk21qrYv8K
 X437/OoGVsr9JJfKDCqQUSub52zYuzSRh6w2xmyOpna5DClDXhpkqTFKswJBIq+SPyIF+aLbmJt
 GQEvZ3wHDejKF97llJxcyCMK7Zs/UPB2asqzt817SHQ==
X-Gm-Gg: ATEYQzwnozIeTuBtkPxJpHQwbmx3AUoymo4ezMklEODnG4+zrSuPRjmlv3m/ynbgRP7
 63JXFWsli/z+6GQ2i+z6gFwmQmr+5/TpiP7z+QAd7ATtgUsz9Xk+wGS0z2ZeFSHeWhYZSZXuszg
 dYa2k3SFom5oEANAvIN+oU9htgMWIJAOvCTEchM68T1ObjnIGxPpPJxJcWvamAVKQ/yDVfzhca1
 NO2otSjasXra+LhFjvhG7Bw3n4EMo4B6nllSd/H8dei/15ea8KRZyvQbGdkeIwMvyDL+S1HHasK
 qKLDY/R4o/pEbK3vWSFL97kPqZVNZ0l7zD59b1F6NAeQasYPShljpJ8g+sgo7j4csf8=
X-Received: by 2002:a05:690c:101:b0:79a:5e2f:45b8 with SMTP id
 00721157ae682-79a90c271damr160873357b3.51.1774346876528; Tue, 24 Mar 2026
 03:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260323155637.145015-1-alex.bennee@linaro.org>
In-Reply-To: <20260323155637.145015-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 10:07:44 +0000
X-Gm-Features: AaiRm51O-dErSawcnpSZnsfWLkowDCd2aIbUuKHpi1deaXgRBUF0evUhaYcTARE
Message-ID: <CAFEAcA-gdDmWeFwRjtTS10VgWeNLUF4mAwaowE4g_Bk+AXTwsg@mail.gmail.com>
Subject: Re: [PULL for 11.0 0/8] testing updates (tcg, functional, lcitool)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Mon, 23 Mar 2026 at 15:57, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit eb153d8fd3be325a5aa7e1a6a73be8854eeaaf=
27:
>
>   Merge tag 'pull-target-arm-20260323' of https://gitlab.com/pm215/qemu i=
nto staging (2026-03-23 10:55:20 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-11.0-testing-updates-2303=
26-1
>
> for you to fetch changes up to 643a171f56682360a9540783c9edb4f69d639965:
>
>   tests: Replace ncat with socat in migration test and drop ncat from con=
tainers (2026-03-23 13:13:07 +0000)
>
> ----------------------------------------------------------------
> testing updates: tcg, functional, lcitool
>
>   - add TCG_TEST_FILTER to filter check-tcg runs
>   - use portable version of dirent64 in linux-test
>   - add VBSA linux tests
>   - drop python3-sqlite from deps
>   - update openSUSE to version 16
>   - replace ncat with socat for migration tests
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

