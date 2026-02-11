Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBCFE9E31B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqBtK-0007OA-EK; Wed, 11 Feb 2026 10:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqBtJ-0007Nl-2m
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:12:33 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqBtH-00036m-CP
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:12:32 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64aedd812baso2175016d50.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 07:12:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770822750; cv=none;
 d=google.com; s=arc-20240605;
 b=Gq/RnZFU0NKkg80VJCykAJPkC24k+WcHY9jhXt/76ZKD7sb6SzxkwzK6CpeqlHQfK3
 34ghZNCFaYIoZ1AYAfK0aHCtLOCwu47ToSZfoYRP8RdyqlkIGnThmc8j/qctmIQ9y0sW
 vO9RFxBrEz5i7dba/66njkrRtIHzHsm8LXMA6KVwwK4bvHwxH+PnVBnQljyJq39hXIQM
 Wtg0UdZJbS/mSBjx1TAQhFcuKYyVj3Tfl/o+9xLZxghqEoqpn1qw3R9oYrgZy69HJNBq
 Vrr5zSl3VdqSZWsZZ9MB9RsWveFGx30awMmK4m1sVar1mzoEzyY+FVSNtnv/4AHabNTA
 goow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KKZ5Snk0cx6t/VhjKwe3oxluHCjvk62pgoEhsorhO20=;
 fh=/WjIsuMXN8wQyC5tKM4pTnLuXad59j8FogTeZ8yIAuo=;
 b=M3el6tWn+nZokmYRkltudLp+yQmgxXqGW3HuHBnvgBUtSKcL4lzqIkGYrp2dm4nABf
 qaoG0MLhimdR3JDpJcfFX/vOWDmA3C7MlPlmezEenIWReEBq56jN4tsFeseuQCigcL4c
 2eBXEQ1TzF62b6w7tABbFTX9rqN103AJUK19AL4jptxUBcqocrgAk/1bgwJMY+1mtw/o
 I0N/XKHmXdkLqQxvUuhFNL4/5CUfl2+057jvbHRZFMKWEXk7c+gzJQluuwGBK6McoSsD
 Pr0T+mhaeDrJQjZrOgftybOX9ZvPN6TdVB97BgaB0YkPxY5cxKZ9lBmnJn8+McuyBV0X
 +SSg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770822750; x=1771427550; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KKZ5Snk0cx6t/VhjKwe3oxluHCjvk62pgoEhsorhO20=;
 b=x554xFBPmMUhB97FcuT1FH4SpEsisdhTYS7f28EiGUvcastIn0hqY+cUw7Mp20BIR4
 rWDofUVUafgKcjGATONbIVaXpXPNRNA+f0DmYXRGkJyrZSCZ8mBQ3muqsJ4VxFBPk6X6
 37T7EWQepuNxYdC9455vJQn2lPvWcNSv23ROQTm66Mo2i8n4G3TXqCpan1GFkf2yAurD
 47LAbhQxWN+wQ9yKD6TJwR0a7wSPwkpvBWxITkdVHg9BMsRw0qNJLlDQ2u/Ngl0W9EyR
 zihJVdPHtLaN/H5tbXfXh+4nUHeZi2Jq4Q4kkF/qKpuLlqdB1Z4M3pQwOgsdqSvu7E9z
 JTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770822750; x=1771427550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKZ5Snk0cx6t/VhjKwe3oxluHCjvk62pgoEhsorhO20=;
 b=bH6mJnCBCBTEQRAOh11+zPEy4M+hYU2BDHPqeEKpx6fdmqbfgGEKH6was3BjXAFrbB
 Ou4c2DJ38DRtLGQzSryVGAj9Dnm08Lt5tsgsOApodFY3z8QJfnn82qnUo3rDI1gHTxm/
 rCMSb9T19O2h8N/atlV1pKPM9NkC6hGdFRnlXLf4OwrBFszOJh5GsGej7/e13VegwomK
 avYny3t0dcab4c0ziAtd3YPAZsaayPpzyMQd0Uwp3Ox+jImwIk2OKOP7yE93unouh0VC
 gONCngyOYc9QKWIffeKkIDR2UkKGIMijPM4U8fTbG3HOabQ9+b8Z+kf4/c5nDRv+XKui
 Lgxw==
X-Gm-Message-State: AOJu0YwluqStc3vNwBJUPXlRdtuu44O8gZgNtKDmYT+JqP13KptO1Yiz
 A75APqUk20XIWObCtI1gFFHHXwK71w4H0ygqW0tl/R+YGmyNG0Ti+krwU1rYSL4MZ7IGq5R0w8N
 Cjw9pN0rm5C3bgMX5508PA0O+mzSqJCy+qHj1Nu6ttqP6zy3AFngS/x4=
X-Gm-Gg: AZuq6aL1FDqS3+/RlidsLWnxOtMTysxQg8s5AAlhXi1aRt9s7YnE2e88nU/31SuFRcG
 qKVucuUQsObTlsyEPV5Xfce7FgmU1+B6TFyLetmXaVyWr/jpTPuRtgwdBc0kYMEJhfMD1q7xqzB
 ER3Sj2mqi/k9F+F4e+0/FO6iJerGZhy287edNiFI/hFXmeOdJoEaoslyy3tK0Fz3Ub6cNkt8dCe
 1MY6TkAT2dU7qnUSoLuEws9BybWYyTujU56o8J1NXbMYe+8IECNnEik+tAnVEQ4Pm3okssnO1ZA
 E8AbpP0XPc/YyEcZuBBVA3/5HeBSA5fHWB83nMgexMdBO8HaVNi1Htu5XuBZkwH1Ddc=
X-Received: by 2002:a53:e192:0:b0:649:ef06:15f4 with SMTP id
 956f58d0204a3-649f1e68212mr13052247d50.15.1770822749913; Wed, 11 Feb 2026
 07:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20260210201454.177202-1-stefanha@redhat.com>
In-Reply-To: <20260210201454.177202-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Feb 2026 15:12:18 +0000
X-Gm-Features: AZwV_QgSARl5E0upXeZeP961j0KOnQedVDQFlJQKnGfvwnKUBHZvhdtwm4GEZZ0
Message-ID: <CAFEAcA_jXEr1E+CP7C=Q0tkDQYkhkc3ccXRykYzgN7jw2spr5Q@mail.gmail.com>
Subject: Re: [PULL 0/1] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Tue, 10 Feb 2026 at 20:14, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 0b91040d23dc8820724a60c811223b777f3bc6b7:
>
>   Merge tag 'pull-loongarch-20260210' of https://github.com/gaosong715/qemu into staging (2026-02-10 09:12:38 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 80c15bcc5eb6d30abf90b2fd120cdf01f6ed2082:
>
>   tracetool-test: add QEMU_TEST_KEEP_SCRATCH=1 support (2026-02-10 14:47:14 -0500)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>
> Stefan Hajnoczi (1):
>   tracetool-test: add QEMU_TEST_KEEP_SCRATCH=1 support
>
>  tests/tracetool/tracetool-test.py | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)

This change seems to use some Python construct not supported
by all our platforms. CI job failures due to the tracetool tests
failing:

https://gitlab.com/qemu-project/qemu/-/jobs/13074647460
https://gitlab.com/qemu-project/qemu/-/jobs/13074647473

Traceback (most recent call last):
  File "/builds/qemu-project/qemu/tests/tracetool/tracetool-test.py",
line 121, in <module>
    with tempfile.TemporaryDirectory(prefix=sys.argv[4],
TypeError: __init__() got an unexpected keyword argument 'delete'


thanks
-- PMM

