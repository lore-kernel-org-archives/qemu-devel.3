Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACECD6DDED
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 11:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBug6-0003Th-Fh; Fri, 15 Nov 2024 06:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBug3-0003TC-UP
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 06:39:51 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBug2-0002Vw-IT
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 06:39:51 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cf9ce5356eso159279a12.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 03:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731670789; x=1732275589; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kii2YWywKauC3hB7pN5JC1zMPV7lHRwolEY6ItFdkqE=;
 b=RHnDpC9pjGduP0T358VwRdYltfkcIM3R0Xtq4C/7o+/vxb/CT54RoAFXA8QIbnGpNJ
 8d2FBkMvIbuNFvTPrSf/WYPY6fvCh2jzrJawu+ni1lkT61y47d9j4bNL1Cv44A0ZKd41
 H1jT21x5Ex7R0DP0NGo8kPojtBno6N/7Juf1zL0RocN1ZSt1Hrt0/URNLHtStZYTcS98
 Ovmx6oSRjQB+JYvtwUvXcV+fiLjS98kXD3qJROPe1cc/lIi0/0aRG/RDs/rhrvy7iE11
 esblD9ihtgA0z4dbO4smLXpt19I/0QvIfAo9E2d9tDyuPNHJf7qS0uL0jhx2kiKXyJAR
 ZTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731670789; x=1732275589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kii2YWywKauC3hB7pN5JC1zMPV7lHRwolEY6ItFdkqE=;
 b=LWlVDujS5H78JprtK+86u7XI9cma52qzw74t9cxM7zbWeZyl4zHnuomZytubkiLqVB
 wHL1CsdDc+kD3wzz0m2uJMRRCLOYq5a4b+2XKV2R8hPyNqCZ/8+QT+rkOP61S80TS7TA
 evPi8n5rd3GSlMGHJBs4ydmCXdukRSXq8ybUDaOXozRtfhMb/ozFDhTtMSd/4xPh0SfN
 Q+IsZP2EsZe2hO2ZOO/LrZ0ipfIy1joTuK/b7uZpq3lPZawoJfb9G1L7Bc7Sr9EQYfO9
 irX4FXZfIJ4Zkv7xvYCqscB5JIFM4l0DKripmtd5brigD/R3PdqZEGapNzD6Yco79wAa
 z2/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGsBjUHZot1nDWqHf0V4TljcOLdiudDMPR0lhwXc9ELSPgc3sarjFy2raTH5VRHgg3IR6uYLKZOMHh@nongnu.org
X-Gm-Message-State: AOJu0YzqAnDBSBH/aFLxzM7zzZ/nOgQbrlAh89Quv7fut3iJdxEyGnfy
 g8AWIEL08l7QbgHdlGdeVoyyfV9UmvjTqaMOipSpyAQofkoluqvotBA3oD31UjoJEX9n0lvlfDZ
 RfGF3RgYC7i/0VT84B/7X+gyXNUJEPK3tKWgILg==
X-Google-Smtp-Source: AGHT+IE3nzWYtsi8SGiOtQRGdzxhJ5vlYneG9A+Upp4f4a7bRMD50HSpE/iX0Xwsi/wMZEjPzIBuEoLTsxg9G08wY00=
X-Received: by 2002:a05:6402:34c1:b0:5c9:8a75:a707 with SMTP id
 4fb4d7f45d1cf-5cf8fc13cafmr1561816a12.2.1731670788921; Fri, 15 Nov 2024
 03:39:48 -0800 (PST)
MIME-Version: 1.0
References: <20241023000147.34035-1-iii@linux.ibm.com>
 <20241023000147.34035-3-iii@linux.ibm.com>
In-Reply-To: <20241023000147.34035-3-iii@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 11:39:38 +0000
Message-ID: <CAFEAcA9pG=_KqNZxxQMDFCJ7JTVL3wfgsN09d2dCVy667zvyyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/tcg/s390x: Add the floating-point
 multiply-and-add test
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 23 Oct 2024 at 01:02, Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Add a test to prevent regressions.
> Share some useful pieces with the vfminmax test.
> Remove the duplicates from the floating point class values.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tests/tcg/s390x/Makefile.target |   5 +-
>  tests/tcg/s390x/float.h         | 104 ++++++++++++++
>  tests/tcg/s390x/fma.c           | 233 ++++++++++++++++++++++++++++++++
>  tests/tcg/s390x/vfminmax.c      | 223 +++++++++++-------------------
>  4 files changed, 420 insertions(+), 145 deletions(-)
>  create mode 100644 tests/tcg/s390x/float.h
>  create mode 100644 tests/tcg/s390x/fma.c

I haven't looked at this very closely, but it's only test
code, so

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

