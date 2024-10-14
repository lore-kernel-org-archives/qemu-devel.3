Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B05D1812B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 16:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0NZd-0002S3-Ct; Mon, 14 Oct 2024 12:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0NZT-0002Mg-VG
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:05:26 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0NZS-00062W-HD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:05:23 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c94dd7e1c0so4293311a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728921920; x=1729526720; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4xrmNJdLU4j9twvy8409RlqJVZ28DrTnbGJt/4aQ5s=;
 b=jEad3WPVKaCtWWyrsbj1yEl2MIBtaXsOnsAOQcHY3jwZlFIZmxBzIBisBtcD1itkZ+
 KQ2G1ov8heuLz6H5tM6MfucxNSuDnju8aV35u0qR3U8VIDmgSIeIt1WxnPUkFQxXMDAQ
 T1wArrlR9RJM/AKgpiZdnt10nNXgORL5LIRBk+dd4/GPv1xnlrNyzDD357sPEcZZT5Mz
 npYK+yom7Ju2qSfxB/qP2AjwuwF56jy0fhjgTjjDlRIVZjUWqn2ZqddSAhCQkq4PkeDb
 7RiT0SDYtpnavAhAHSopvWaQeYG8owDRPUqJtwadCTiZV13ePqhAl5rJYY/S6aJ2rdQ7
 4LGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921920; x=1729526720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4xrmNJdLU4j9twvy8409RlqJVZ28DrTnbGJt/4aQ5s=;
 b=YU4KOacaY1mKFbRmWSfm4wOF7PwOZZiHAdj2SIWzcCVH7Z+z7fab6dOK67vHv9p/lv
 au140xdqgBtQXR4FcUmkTCJvm1fEVoxjQEOZrAV+5QOPt7N9IwuBPZdHaLHCqrTe9SFn
 qF4DdWGragMEWNzO7sfa+LN/v63FO61SoFjP4SuIBvhCgCj96EYZJYr84qLY8GhzYc3Q
 9+/OmtZdHHNDsKpxwGQtXIW0o8YeL0RyeLbGla/D/X916uOXxDFUflb7ruKTdyoRTdRe
 0KCFM7wcbQa40fSKFEUE/PG9egLsG6AQj0luUMuX3x9N6+/ka3VAjtqpE0fywu9iw27q
 85bQ==
X-Gm-Message-State: AOJu0YzeCp++lPT1RlrxaidZs8CBPNXl4JTLoRTusLpsk6aOrLNarfem
 KoesXw4xV5V/KC5gP13PQ2FvevvIO9iKfmVGkFTkWmSq4w9mQrwMWfEhYcC930Es27Vj4gr2fEQ
 8RC/xVoiyWqExgWj0LGt/HkmaCNTWdQ/mYKvYKQ==
X-Google-Smtp-Source: AGHT+IGzSNT0hYfN+pfoSU3lxkvXHMOdv3oCzveHpYuaQivbGKEs3AilEODrDa3L++VY2Au6yZzMSaxGO631f08Fzj0=
X-Received: by 2002:a50:c907:0:b0:5c9:f49:fbc6 with SMTP id
 4fb4d7f45d1cf-5c95ac610b8mr4697608a12.34.1728921920300; Mon, 14 Oct 2024
 09:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241014130255.10119-1-berrange@redhat.com>
In-Reply-To: <20241014130255.10119-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 17:05:09 +0100
Message-ID: <CAFEAcA9KdbcijsPDcHH0j+Ow85HbGzDRySm4dbNevhEV=psCSw@mail.gmail.com>
Subject: Re: [PATCH] tests: update lcitool to fix freebsd py311-yaml rename
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 14 Oct 2024 at 14:03, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> This addresses the py311-yaml -> py311-pyyaml rename in FreeBSD.
>
> The change to the OpenSUSE dockerfile is something that will allow
> QEMU to access rust bindgen in future.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

Applied directly to git to fix the ci job; thanks.

-- PMM

