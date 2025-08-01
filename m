Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD54C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpwl-0000tZ-Fh; Fri, 01 Aug 2025 09:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhppV-000184-Hh
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:29:49 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhppT-0007rP-L6
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:29:49 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e8e0aa2e3f9so1605076276.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754054986; x=1754659786; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zM+4rocb0JLv14hOXdt5Pjwn/4EGFS6aEvPspBwLM8Q=;
 b=TSJU3nwQL0sQTGHwilWO8vwwkfEQJCzUzx5mB+OmAaKIIs68+3PtlStYPF1b3vmXB9
 tfumg10wt/F/fhKe3IbU4vzPYKyn/dyHujKD0TkLZ4KqCyX0QnNJLM9Z2ZeC8l/ei7Bu
 QGNJ2al7bLL68amRpB8ebrYsI9gJty9dOAt0km9pR/AphNAVvkmofQkDK5B4ozRLX+yE
 mEvIWxD2aEOSXl07410CwoBwPMK9ZhZTq3wXZOI5Fyf6pPvIOtVf+rinWbbviMtNMCAD
 emfXAA3hITLpNumNjp0xk29TTnFD05KaXcLcrik+SEDs6qSx5YjsTJH1XguT7kkC1O2e
 aLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754054986; x=1754659786;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zM+4rocb0JLv14hOXdt5Pjwn/4EGFS6aEvPspBwLM8Q=;
 b=IyQvT0DNuhs/yt7KeKR+64PsgEEJ/v7rVdCQgHm2rdRtKVNWOkf+PGdOb0WBsKC+0t
 lAt4RfCk3p15KLQ5LGxXI7lcn0ZGHEg6Koqc0YBLGL/KytwK/c5r2kH/ekHgdHQWmoip
 WgMFTRh4aehMpTkP40vo/fWNZdk9fW6GDycsCueHb9ePec9HlT8ODB6crUnN2o0T9AEK
 0NlMGDGRLfer3j58lHzu2C6gEr8hnQoChk8naCtVEo96bx2iNvuzu9KTC7fdKfjIAgMt
 uiVWNeST+BXcUyvRZ19X0mHi+JowrwTc8BcyRjhD3CbzFJi/SFm1v1BlOTrjD6jPGoFf
 5ZaA==
X-Gm-Message-State: AOJu0YwbnZwJOG3lDSCE8YfNnM110zpB5G4gEsHdAc2hdoQV8uwwykIs
 ht/ulvSrIlb+iYMf+6dxyT5dIwmK6IndQB11RK+t1l3SrO2Hu70XfaQjej8AfG5lYHfYpm2uo8G
 OV8d1eina+E7WbQmoNfk7HhpP4zGXGzRltRtWlTyCAw==
X-Gm-Gg: ASbGncunMMIpHwQy/NQTd9O5y/hbpUQSRL/dQ8Y35qrdnuYTfmEIMNU/9+cybddTm8G
 XKph8rXpiMdIcJ4PrylS+yCuIuWP2OE07c5rTJnUw0mrcpoHkjSQ5rystJtv/CXIRcHCsx4LsGo
 4hKhEXfMPZfqOt6FdA/1J6wOjiEDo9Zn/fBymT9J2UqEJtF4HNc19Sh7n05JUu22xlrgl64/lfR
 3iPX8dk
X-Google-Smtp-Source: AGHT+IHh0KFDihUeja+forBXW0gWsijwli54BLB+KUP58fCQImehs57Qquv30nTlsY7prWP3k8S3urlOVL/ZLbAUgqw=
X-Received: by 2002:a05:690c:d8c:b0:718:17b1:40d with SMTP id
 00721157ae682-71b6d49b617mr36811917b3.7.1754054986114; Fri, 01 Aug 2025
 06:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250801001305.2352554-1-gustavo.romero@linaro.org>
In-Reply-To: <20250801001305.2352554-1-gustavo.romero@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 14:29:33 +0100
X-Gm-Features: Ac12FXya5BjbgjqdDxkPbF0aOAsI_7Gl0aCf3t3NFKbAZKF2e-WjJ6uHqjwjfBg
Message-ID: <CAFEAcA-6wr+frdc4idVs45POcPVG54FFTbtqPu3x9Jzfa-gwow@mail.gmail.com>
Subject: Re: [PATCH v2] tests/tcg: Fix run for tests with specific plugin
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 manos.pitsidianakis@linaro.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Fri, 1 Aug 2025 at 01:18, Gustavo Romero <gustavo.romero@linaro.org> wro=
te:
>
> Commit 25aaf0cb7f (=E2=80=9Ctests/tcg: reduce the number of plugin test
> combinations=E2=80=9D) added support for running tests with specific plug=
ins
> passed via the EXTRA_RUNS variable.
>
> However, due to the optimization, the rules generated as a shuffled
> combination of tests and plugins might not cover the rules required to
> run the tests with a specific plugin passed via EXTRA_RUNS.
>
> This commit fixes it by correctly generating the rules for the tests
> that require a specific plugin to run, which are now passed via the
> EXTRA_RUNS_WITH_PLUGIN instead of via the EXTRA_RUNS variable.
>
> The fix essentially excludes the tests passed via EXTRA_RUNS_WITH_PLUGIN
> from the rules created by the shuffled combination of tests and plugins,
> to avoid running the tests twice, and generates the rules for the
> test/plugin combinations listed in the EXTRA_RUNS_WITH_PLUGIN variable.
>

Since Alex is away and I'm doing a target-arm pullreq for rc2
anyway, I'll take this via target-arm.next.

thanks
-- PMM

