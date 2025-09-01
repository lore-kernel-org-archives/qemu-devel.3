Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99283CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 16:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut7Cp-0000Hd-SK; Mon, 01 Sep 2025 12:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut7Cn-0000Gl-Uv
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 12:16:30 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut7Cm-0005lt-B9
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 12:16:29 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-71d603b60cbso37106947b3.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 09:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756743387; x=1757348187; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NV1AhK+d7vIS7RbUx8PHzB8MCmPm6vGN/vhbTkD6MlU=;
 b=TKVYxaGj0HLolleWtGU+JfAhL2aMnxcKsOxfyhJN/j/x2ES8GvQh3KBSd4USBOZPXY
 /fasiDmQR45AwpdpAWm8Ay65Eraryn6snteRX4nIeb2kMvq1JZJ75s7jC4M6buhCzEZT
 V8Sy+mCtB1sCd5N577YZ9K2iwS6J3ER3nIxzDorY1hGSZrv3hYQpHqmwosMrM8nbcqHv
 xgkEb90/KnndYqbeEQE/Qmqz4cebLl5pZcWhB0WnKE3ChgD6e6z2D3PNiqzIVmHlpMLr
 kDf71+B+5lRCEt8PUWJKBqt9/CrhKazOyq9qSNGf8OKAChTjManNT+MMy6tKq19anm37
 47Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756743387; x=1757348187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NV1AhK+d7vIS7RbUx8PHzB8MCmPm6vGN/vhbTkD6MlU=;
 b=v+cCR2m9dHjUCyVxFduQ88ChrIW3I6l/U04LGUrglvB2MDjwpXFnrlbx6GjftMa0to
 gkS+AiZjdDLLPqqXrqi3ANILrYPoQe4d8TGmo1qMBv8VNlmMh04bUllMWdy+xKQT2WJv
 XE/Fym2edtyGpVvvtemYCeBwqumHRKxOsNrKDoLNVV2wpI/FuFbhtkBa1H96mZNqZObX
 DB91CjUUqd9MEPHB4gzmgHnmpGjBB0dEVsiqP1rfgAYm8TsY2JCiveIscNxRBKLXSyod
 AM2auWzOMKh28+6wn87o4HkXbRs/zkND0fb32H9TfJFDpSfd/OXfSVUKiKxO8/2FwQB0
 RLlA==
X-Gm-Message-State: AOJu0YwI7iUUJff1GJegpkV1gQQJlHNSImaemiualNryeAzGC6OWGiDI
 z1NO1ku5mwg8aIlDwfmm30x3Cis84ja09E7ZVclgLfF0aYk8iHcIO3QOQCrrU8mwIXtZpzNO0Tx
 7nBkxaH4sDXSKMg5WpjHlDG59WKY3wIjinHP/OBctoOPf63NBk+7P
X-Gm-Gg: ASbGnctdvUkEXPbRG2NOU48RXoONzyLLBoeIRbdyYOXcAASccziIKSJ/L16T9PH5f4F
 evaVc2C8llynHqd8t09T3VflYsEUi9JOz2/4Qo61AbIk4k/VjeFaNnOlWxYqAs/B4VEJaEuFwMH
 hFgT6s8CGQGA/2R0fHpwC3C+fcmxAdPUaOVXJoopsEdXCfWS3HdPY18AkJZ7kjbNYGivSYXLgzN
 qRkC+vJN8SrMMjmltg=
X-Google-Smtp-Source: AGHT+IG46UQIHhC4f/UfMqnKWgCuAw7YVpAJMqmMq9ByClkm7voY8T6CQl9+m52NJIfHYmr6nbFNHWJDNiqSrEF71mI=
X-Received: by 2002:a05:690c:6b11:b0:71e:7ee9:839b with SMTP id
 00721157ae682-722763a49d3mr112361607b3.12.1756743386780; Mon, 01 Sep 2025
 09:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250819102409.2117969-1-peter.maydell@linaro.org>
In-Reply-To: <20250819102409.2117969-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 17:16:14 +0100
X-Gm-Features: Ac12FXygXX6hugTf9GdD_d61BOwfkg0zEs7c0qoab75gyx2Kt9M2Z0T0rowOK_Y
Message-ID: <CAFEAcA8APXVZmaJtQoGHWxVeDsk2s3kPSt3d94L6zZR-P2ZFaw@mail.gmail.com>
Subject: Re: [PATCH] tests,
 scripts: Don't import print_function from __future__
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Tue, 19 Aug 2025 at 11:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Some of our Python scripts still include the line
>   from __future__ import print_function
>
> which is intended to allow a Python 2 to handle the Python 3 print()
> syntax. This particular part of the future arrived many years ago,
> and our minimum Python version is 3.9, so we don't need to keep
> this line around.
>
> NB: the scripts in tests/tcg/*/gdbstub/ are run with whatever Python
> gdb was built against, but we can safely assume that that was a
> Python 3 because our supported distros are all on Python 3.  In any
> case these are only run as part of "make check-tcg", not by
> end-users.
>
> Commit created with:
>
>  sed -i -e '/import print_function/d' $(git grep -l 'from __future__')
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

I'll apply this via target-arm.next, unless anybody would
prefer to take it via a different tree.

thanks
-- PMM

