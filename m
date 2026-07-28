Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242D4C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woi6j-0004AO-8z; Tue, 28 Jul 2026 09:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woi6g-00048A-Vt
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:44:31 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woi6f-0008OD-K2
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:44:30 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66899c7b57bso4292984d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 06:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785246268; cv=none;
 d=google.com; s=arc-20260327;
 b=eoBEIK8IX0VWdnE5Yizt/9n9HiGPcuuh5PDfSO02BdqyWNLhRd/m2Z8iPgivp8oQfx
 YQijemjxhUOvipc/4xsu1/X9lR/ukB9Y2xVwJlzTYLBLbw+L1NcJJM9CQ94W5HPb0MDh
 gIBApy8rrTr7R8WfiYfFIjn67W66BOsGHGw3F5PzayHpMPKQ5+parfExEVw6bLPD8Fzr
 oMenhBS+8ZPeBBfsdrLTaOz03la8j5WhenpNLPSsbPyG8BjQxQ0OlZNB9nX+Jox228rP
 ThPlj2LXO12DOmOfLsn9XYFcKIGNJ/HdoJofiwCuAFuelTkQb4ONwBw+LUpmiDaG0bOY
 yQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TZ4ELxbCc2C7PNjqxVaTv20MiL8J+V2ohP5HRYlBugk=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=ZYUfT+QA0nU1ZariPwLS9db23XjxM+io6lhYbtivxUiSFdShaVN4jrFabuE+6I0QSF
 iFSRvFwAuLNiI8/KjW2zqCfzYTAOozrEhBmutyOBjwJ7gWJCjD+88CcFekD9ZL+Sfpi7
 R98pmnnE5fTjO7+8fbs9FpbMj1Cqab3ka+PTmfUZOJbYZeq4GUczP986xCL/zT/hX4P6
 D9+ZKDclk2WxFnfa3AeX0hQ3bm99HET+q6XMvJgc8cCpwy7sValTXkONBguhJV7XL4Rf
 Pwm+FSB5ZH/4ejsPg5s8i+GoriNwIbB4gpNu7mJteMZJuxyGFX6Tbda4vrNV5+oKALtr
 npvw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785246268; x=1785851068; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TZ4ELxbCc2C7PNjqxVaTv20MiL8J+V2ohP5HRYlBugk=;
 b=wa0nnD2hlvspu9xg1jhDDppCECXP2BodV4FDTL9GqUCl4w5sdQyZWbPFbbFfXkcldq
 8Z0/JUKyronS2yy4Ne79PAdN0elj6Ruh3ANy87w/NYExHIxy71H782wpOyshB6KMU2Zu
 /MjjPA9nPqkeCIjY94BR7vr8A3+zJ+gOnVFAf2IJk02OQBoHFgoHMPomEx7GjCsczsOC
 dUyn8ghhtUHfiqPRCXy4hMJdJat0U9xZKmmBbdQbi4ilj6QZ1EFAIK59k3JvOulgIHum
 uuPrGcj03uTiAxcijW+LYfPUD4qO+o1MItJTQqLN9K5jtZAfIMANLX1kbkUSjFEMn1kb
 /VOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785246268; x=1785851068;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TZ4ELxbCc2C7PNjqxVaTv20MiL8J+V2ohP5HRYlBugk=;
 b=fDlR3vmbNzCSgWT942AgXY0e/OH/9S6N8zfoN2jEa9H+pJv65+KVgQ99tB5Ea6AIyI
 eu3LPWl0Kf2XSKTqlr3vud7Bb1XPqSNx37PQBSDBxMd4mMmkS3pemw3NGLSNBUole+Ls
 f4J1b3xaIPR9YLLBd8I4rw4yjpqvRD/TMrfFBgPMkHunemQumyyjyI9/slubDNba2AKH
 wFdR2LSkY3T6txmCFJFgyDzIcxibvW+ucYLvIM7A0iSACn4H7djsBN1q+FBVQflq+Ru5
 OoMYyL6pG73uOmXKYYqbyLFjBrkYtcqkuR2Qh4YDIeoArdt77LrC2E7++vpJh1mBhuXz
 SI/A==
X-Gm-Message-State: AOJu0YzYJqwUAPc7Yc9akX0IonKoT08Cnu0YQeP3AQYumNKccsRTeo3N
 X8BzUOeqpi8NMxlR01TrQ531L2cwwKaeu7jDI/Jr6Ma0Yy53QZ/0s9Ls/cbmFsl5TJLoAXFNyvE
 rm23IWKTf4Z6eAk7leH0o1iukPCVxmaEWIcIZKNmbrNzkOtYiiohP
X-Gm-Gg: AR+sD10TuO1oRzn8mVuBTi/kQvHlGnrNXS1Xs521cd0zbC/0sVx1JZIfmrrSqLZcSVu
 eyJDDmvyl2pYy2TopIHCF9jTthIG2bny7jqogkQ/Q/oN3WtTTrLpAPKIM2TF1BmYl0xmzvZf2Kt
 ioQ/4fNmhMNVwuddO1pVVlg7wU/SCeSzv1DdODz0K31/+Bs5lCTE50VP/8MWBDPBCRuzend3CnM
 aFuJKuBD9fsaCPhaUoKvW9Ev4RDl7AIFHSPUUjsUlym2HpcolFiYfSGcLg48vXbE+7jDP5bePk8
 7nTDlvd0j6xCxZCHYgyk0bW8wFTDpHfptHeOumdm2KTQWw==
X-Received: by 2002:a05:690e:408e:b0:667:b964:d72b with SMTP id
 956f58d0204a3-669058a41ebmr834165d50.107.1785246268280; Tue, 28 Jul 2026
 06:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260719174905.420725-1-richard.henderson@linaro.org>
 <20260719174905.420725-7-richard.henderson@linaro.org>
In-Reply-To: <20260719174905.420725-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 14:44:16 +0100
X-Gm-Features: AUfX_mwop3LAdYmP4GW2p0dsp6_lCdOcMNGsCzu91IRcACd-grA7RuRbYDc0obU
Message-ID: <CAFEAcA-quyjPnt-idF0Q-hLoPwUEpmsW117ULa5T4KEg5ML5wA@mail.gmail.com>
Subject: Re: [PATCH 6/6] target/arm: Enable FEAT_SVE2p2 and FEAT_SME2p2 for
 -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 19 Jul 2026 at 18:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These features are tied together if both SVE and SME are enabled.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/elfload.c  | 2 ++
>  target/arm/tcg/cpu64.c        | 5 +++--
>  docs/system/arm/emulation.rst | 2 ++
>  3 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

