Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78961C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprzA-0007DF-1v; Wed, 05 Mar 2025 11:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tprz2-0007AN-Vz
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:52:39 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tprz1-0005wJ-BJ
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:52:36 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso5197826276.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741193553; x=1741798353; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=igUrSwpM829khWSgnZtJRplZak9Hy3/fYvzPQ4teyss=;
 b=qM/2QFUqpYNZPRsq6hZ0Yn4tG4pr3giO0lV4byQmbXy+woRwhIZY6eMpbai9iBAVHV
 eVKXbx0+vn8fpq0RlDZvz86xm1+TwUc0D9+DlM34oYT6WYSMP1CJ+nkqDhNKXlAruvr5
 uOHtqHi6mo9W2ipKK3fH0robTNrdX5SxduzlBWrK/qmoDqrdoMuYzK9ToryplLmBoUty
 non5Ww9F3OvK7m7lbpyWftjk3bFLhPlcUNEp4vdXvKhwjXfeOp1Xpz+i3OwSLqzViH4y
 esL1GUpraWy86f4tKj7YTHbSGjj/hHgwdHfLrj4EspGJDiWWXeawA0des1Pan7X7qtER
 msJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741193553; x=1741798353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=igUrSwpM829khWSgnZtJRplZak9Hy3/fYvzPQ4teyss=;
 b=uWHEBxhJSWjVEL0j0PWOg1c+1xvxntnevADvMmSEZO9hv6ZxjWrBQxl6UP9K71Gg9d
 XGHojngziEMrzbIayTrkPlZh4xPzhOrQPnXrlMRPtHPTZLkouUkabh+D1//uWsTN+28d
 p78Nzuksc/SVdb7LOcuBTcUPLHIKk0nQOVvippyd4S6xVj/ODVul1B5pWrSGmowYMMNR
 GMucuzdgx31teT5LtTc8aMQtbSHzh5LAXBwM9g0hqBos7Jpg/zPH+feQHaKtTNnxvaXG
 3FWs7QsvhXbFPuM18onktKam8HUyXoOmW6PMQsYGqjhNSwnhAAHqnKnDqgvTfzGEa46E
 5+zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUeNhMtrCBvLw7NFVT7sdr4oWEFAWjtOrY2/Ha6DK9CoCPE7MYHM1btZg+BYpAT9xSbK/d/DTVdyV8@nongnu.org
X-Gm-Message-State: AOJu0Yyyq+4tDeEg+u/PJbFR41OiDLOZwd8qW7WntmotAFkbBVrYtSCq
 lQfu3jCRxrAWkTOT+PZXrHxabD7sLbcbJBLrcOXgbe2lwkrs6B5/qYdCd36P581AfEbeGV1gqzN
 9mRCflArCXt9R2xUAeLtZNWo0V+//XUg3g5DAuA==
X-Gm-Gg: ASbGncvHgRJF3x5C0G4MlE9/Ti9ukllT2p2T9ftxhiDjT7vErV6kxnJv9MX+BRrD5FD
 uqqZYk2m9CA8HPGTUzamyuMJfscs7wGc0Na4XzqxHPW/GGUuLD3cF60FBImiOOC8CixSJlUFpjZ
 3k6SFdqs2HowXI8iEZbwJvEwM8rJY=
X-Google-Smtp-Source: AGHT+IGHip7qXEwbF37JJ6dixVrpeF/0m+R7g/3VkH1lK5+kgrfYR83hCS2uCgWf3JaaNMRAwsZD+rGFL+WRbG/SUaY=
X-Received: by 2002:a05:6902:18c7:b0:e60:9d12:c1db with SMTP id
 3f1490d57ef6-e611e311923mr4854866276.31.1741193553720; Wed, 05 Mar 2025
 08:52:33 -0800 (PST)
MIME-Version: 1.0
References: <20250227141343.1675415-1-peter.maydell@linaro.org>
 <87o6yh57r2.fsf@draig.linaro.org>
 <CAFEAcA9VDtWKoQ09dOt+ZxJ2MhdRTFY_X1ON58pEjYTM_NtZ-A@mail.gmail.com>
 <2de21adf-204b-4417-aa2b-2d16d22148f8@oss.qualcomm.com>
In-Reply-To: <2de21adf-204b-4417-aa2b-2d16d22148f8@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Mar 2025 16:52:22 +0000
X-Gm-Features: AQ5f1Jpk-Z9MGBddkvVIDe2HIHLlXKILHqmEwGs4hxl2GYZ50_JBxVRQi-oyRB0
Message-ID: <CAFEAcA-ya3qjG4P500p7=PwWdiX4yRWKxAv1Q_SKeJSgiqXZpw@mail.gmail.com>
Subject: Re: [PATCH] tests/tcg: Suppress compiler false-positive warning on
 sha1.c
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 5 Mar 2025 at 14:56, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
> I was going to volunteer to update the toolchain used for hexagon to
> address this.  But unfortunately this warning is still not supported in
> clang 21.
>
> https://github.com/llvm/llvm-project/issues/72455 sounds like it's not
> very likely to arrive any time soon.
>
>
> So "-Wno-unknown-warning-option" does indeed seem like a good workaround.

I think the main problem with clang is that it doesn't default to
"don't complain about unknown warning options", whereas gcc does:

e104462:noble:qemu$ gcc -Wno-bang -o /tmp/hello /tmp/hello.c
e104462:noble:qemu$ clang -Wno-bang -o /tmp/hello /tmp/hello.c
warning: unknown warning option '-Wno-bang' [-Wunknown-warning-option]
1 warning generated.

-- PMM

