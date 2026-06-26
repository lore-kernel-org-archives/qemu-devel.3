Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E16BCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd25S-00074U-Rr; Fri, 26 Jun 2026 04:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd25N-00073b-QY
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 04:38:55 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd25M-0004fQ-C3
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 04:38:53 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-80bb578d58bso4041667b3.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 01:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782463131; cv=none;
 d=google.com; s=arc-20260327;
 b=bPTrFjFDg7xR9IXedfpZT3NJ+2vDVOOiVmnAeiyASJ+qWpeUEbaVNBmQvvUn04kjEL
 QglD8hs0SVyPzHTSs+c9OXN0hvAczw7/AIh1JrCMEqW1sKD5+CKOWHiP7HTYXpoqGXYl
 ACNWT5JiBJfjK/eOL4RMVTqHaFFeptIV7435ajKr2vOJS1uumQXm7gSvA07AT6qDElmQ
 zbQZI1mNTtrNFV5BDs8KRZcZTTjlg7wxmao1hhhDXYsainFYhKRGXjYI85QIlvvkzONE
 vwSf8iI5V3+XslU7G1G5FxQsJYnPQwKiF/GfcO1FY9U9zdD20qYB7kYWwYrjq4iuAEdP
 dhaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J9m28pkmgly5HZUFVl0v0aZiBwYxGjHzVdJkK/0kMhg=;
 fh=EIpCzlYePrlYAT18bdL+pXfBQOTo+quKrLSHI8JNqhA=;
 b=by1AS7v7Xy7awK89QMkH1+lzDrHfflZZpeyOlhViWsdvfnxDwmR1O9ZrZuzqJN1e9w
 tcyn1eTCDoPMTaatoGBSN9nblSoUcJngxvyijVufnlM2dIIhgNNxSd+LWd1MxLNxV8pb
 m7fTVcP5V0c8naB9OZjJp7U0pqnqLtLg4S1eM4DdTTNLS4VF/JLfWducLqBe5JWpnq9u
 fNybEkEyBHBc6983R0psZ122qI4/MtMtiANjjiVkBR/l/ebyfvm4R6Yeh6oG19vwKZUk
 /dN3cDYqJvHqvym+x5qiZF0q1dtCzg3gabSCWsmMhtVxuGDwo4jXxvhMmq1MHokDHMVE
 TpCg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782463131; x=1783067931; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J9m28pkmgly5HZUFVl0v0aZiBwYxGjHzVdJkK/0kMhg=;
 b=kKI2VS5aSm60r8e5f+q1a7wDFYlJngcU0ibzhiGAxl1gOTwy54+X6EfdQ5VYpW73U9
 I5vRG9bEx1IIauy06GLf3F9cGTRgQYsgn/vwqTRhrqkbd7mFYSmPKFdtcWJHAvg+OctG
 /aHIm6WMT/LXEi/lSVYS/ajoj1PW24T0ujAmR00v9FGR56+BMfCJckLxApDAzvtbCio2
 +Sy98Cmvn+SCX7gkRhZNIzkIjFloN5v7wYzSx6Hh97RQ23ZF6iiyC+rwakd9Bk8k4F6x
 dqMBUG9mXSkBmReULs3uIPCGK15MO/GzxMxHU7odz7iRrmY2F2lKlTjBVDpWLoF/B/R7
 xPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782463131; x=1783067931;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J9m28pkmgly5HZUFVl0v0aZiBwYxGjHzVdJkK/0kMhg=;
 b=UHTnE4OtTHbj7jK/KolxtIxoCdl4zIicw+H3JIcZY2RXAhePbH5RTfE3Ey2O8nibaE
 owpmyLzKA/GrktjQ6IJterPQcU9OB0SJLXcY2327mKj/r4V0JnD4bTzsEMMhndXhm73J
 MUKRIsrCDP1FzMC99aWS/fof3k+FQj/recLwIHbdsGC8EdR4ZejHNLc0/LOBQtyu5g6p
 9ojrqCT2DfNyYgdG/zWRAOH7cCNOMFUBevuZgZnPSb5nvqt14rF9QgO/pHQ8v1uobEEI
 vfH3jG2X/1id0kcgKRejBJ78mkkQH4dQcyMD/tuiqi9AXnb+Ljco0MywHyyFrxl/KYjw
 hRMA==
X-Gm-Message-State: AOJu0Yzh3PN4NRIDz2CLInpe/d/aXxpmQI9W1WICeOz9ee6n1jmg3zB5
 5uGdrXEGpws5B8S2p7rFRZoPfLoxvuCWkViYGOoHaDwx7icgOnA2XHGGhNk1AKEkMNTVT+bPWT4
 fiq5GL0B1Sl3J+2l2Uup7ytOpwOC94eqpLo8x49XG+w==
X-Gm-Gg: AfdE7cnP26cOXtWvUbnmKixEav7gQa/NxTmhx5Exyys1Nrx90cqCa5zCQFGp8ib58Fh
 VfQMdGw5pKt6C+HgV8JPwIitQ/KB9jXUvllmgfw9eqQPGbYT8ckp501unu5Xcz9bNjH0N+pZL72
 zEyR04fi5xiBtxaqjPMjtlCP6xJB1fHn8k0IaunKpJUG0FI5P8nz09b/gYsLl5ZwSRq2dCzknG9
 VB+kAVbiwETXuuEohVDWJaRnpn/LtAYO5xJ2QXjkYRTEUpi00ouZgkhzogn1sCwS6i9iXF3C8Fe
 cFfGNe9Zq5f/shwu5zR4P7QDJCZuGSYF/Pw/9IAMAvyoSbi9Rc1xBZOe
X-Received: by 2002:a05:690c:47c6:b0:80b:5a9d:99d5 with SMTP id
 00721157ae682-80b5a9da340mr27332217b3.40.1782463130780; Fri, 26 Jun 2026
 01:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260624124527.1018912-1-alex.bennee@linaro.org>
In-Reply-To: <20260624124527.1018912-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 09:38:39 +0100
X-Gm-Features: AVVi8CemtiFs0k5hsvwV9phHA9M-jrD0h7dd3wyYfQl_opgY4-z4qYm8dQDJddc
Message-ID: <CAFEAcA8n_Y7teA_mznSkjhraXfH-9v6fKY8Pz1QswMHz6H_mkQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] target/arm: a few timer fixes while checking
 FEAT_ECV_POFF
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Wed, 24 Jun 2026 at 13:45, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> While I was checking what was needed for FEAT_ECV_POFF I discovered a
> few potential correctness issues. We had actually already done the
> work for the feature so the final patch is just documentation.
>
> v3
>   - tweaked the FEATURE_EL3 check per Richard
>



Applied to target-arm.next, thanks.

-- PMM

