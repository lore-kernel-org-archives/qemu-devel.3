Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A5ECCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHjV5-0003TO-Tc; Fri, 16 Oct 2026 11:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHjV3-0003SL-Os
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:05:37 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHjV2-0002uX-6N
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:05:37 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b0c5a64de8so10414217b3.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 08:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792163135; cv=none;
 d=google.com; s=arc-20260327;
 b=FJblZch9eoo2haAJNDYKQFSW2Y2KkecenXer/1Wr0GompyANtqjbXkoFOTC+HVAk4n
 +luU4IXhZTTGxNmYGrfmyG2+kzU1BfZvOn7PBF9+xXVGe0z54DZnmoRGU29GR1G1xx3+
 6nqGYo0zLZeT610M9eiYawbicKeuR6S4qGNFqaurybaBIsYxpMFvhoI4TqTYY1yoY/7U
 OwWJuXikwYCCV8vCKRHKVWmIKqXeMp0lh4QE7mm4meUHrVZelIMw0smdan3UOaZfDP1c
 Vh8ekFor4ZTc+MSWXJ+DUW1QAT8MJs2gxexsW/zNAt9XulLTozdFHkKwgKMVb4NtQCII
 xCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CBjVv1D6vmDpoQMIQgdUQT2reraa2p7SDTCCwForFs8=;
 fh=Lo6rZgc3RKiqxSP/Q7XwHPdPl4aEFi3KMChg+BxIXfc=;
 b=sjeKdScCuQk4I6rBiuo7xq/K/+eIVU/VL7khTWnPWLQISqOYNccVjWa0WytiZf1ngK
 0BR1XvbAk5ieGkjBMsUzNmpUF5zerbq/2Xr94Fid5+gXlUDo5speLs8JkmrrwytCKAOQ
 eiYerbWjl0BxNOdoWJ4/vvCdKlCy9isQLcuNeiZ3CAIwYfy4ss4lqQkocAKIgxW3I53L
 sqWqcopl+Wy0wR+eYrHZlT9Hui9CJQ9wTm5nP4GFESqLYm2vt/yeaDmHnqW85olkIP2I
 eNr8aipml/cIY8ny9akT/7AAHQoAMA8YnJlwYbjAUVYccOGbGdL5s1sY6HN/ogdsFbIO
 NqXw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792163135; x=1792767935; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CBjVv1D6vmDpoQMIQgdUQT2reraa2p7SDTCCwForFs8=;
 b=ctw1+ujZ9tZrFZk0sxxVZdeivo5yTgDEiHENIFepY7bDQ6YIQfQ3i9DvXsHqvb1+8y
 4e/zpVSSsYBPGuSUjmHiup1pAN2vDNoEX8t8kctJ7/jmjl8bo7oxC4G3UGgriphOfpjj
 pBr707qH9czfhwpwBwaiPfyAc6Jjd3uX9/7fEkyl0sA7hjkD6+p+nPp5Jxz2xXju9sJC
 Dx/u3OzPGaGfDEcWABTHQ6QuXVVkAz6PEv9yzLpVKc9J5mwS6lbESAFLHTHrswabeeD7
 FMqO62JICO+nR2nlQ6Qmskey2FF4YCtEqdTVz3DktvOOyo+8mHK5pTuwJtvHSpGr+kfU
 xXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792163135; x=1792767935;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CBjVv1D6vmDpoQMIQgdUQT2reraa2p7SDTCCwForFs8=;
 b=1JZi2DvIUGfDuJAcYibL3aeYpJt6BKt4olg3wwvascjPehQfyQOLM4E6vnaVJ4RYPe
 BppVnWznsgpQuCIzBegtme1m5+J7i2JNLw0B2XvDbzCfu1sCi54TZAOjQEXPo8+4qTHg
 rRMPwLm6R9XLjCNJtQtIkIjqx/nqjxzsPf0itpxjvzrsueCw6X8xYmbYRzl2S+05ORVs
 Wii/qo00ZvCDYN9s2nDANtPKqJEtoUmvUn0q+W8qe7WDwXPUIuu5wBQZGR4wMUvsOtPl
 GRLfhiTmBdf4a4IgNtGwuEBrK7cE5Z4360lE2//Dm55mtIqcH4seTZGQR7wCZCTSpNUy
 s/mw==
X-Gm-Message-State: AFq9FYKp0sMIOrovc4R/4YCGMid9VFobDej99uBdZtCbafOV0oAp9/X+
 RFyWRwRUTC1sOSXQ0cNZoi1dm8x2C8V6dJX6C0Rba3fuDkbUA1llm17zyFoLOgQrefK+QKYpvCp
 PvTBzA71BPc/lPfBWSR7wO/GE0tOaP/9tvpHWt4N+XA==
X-Gm-Gg: AYBFou14bSp6IALlikZjlMf0MjC9MmKCv+vw+TuF5N6gUE8z05viAZUnflnf4lFbr0w
 9UGEj6CqF1j7m32swqmOqZySU1EzwiRTWrI/6DWwGXKlq3al6JmVaxuycgdeuk5E43gMYp9lN8n
 FmUPQLmvyePMmPxy6V7E/3Mnlm3oGVQBk+VHjgN7NOtNkebldCm0H0ORTgLTRXjfWQQIF+hTbX7
 fa0BQeTYRt+Gc6yeStubouL44b8q3PF2e9VEG3l/pcVjOtw30zhTe7EO3zf6sV57I/d2xCI2Cai
 ipAxbv7UNy0Ih/2IxxNo3IXdRdoQq1oyifPE3ScJVsSNxhYn7gnEHHforssYYOR3hcn5LFK4eTE
 wUFi8RKysFeNmlfCdtooyglrVKIUkTN243J/3QEE=
X-Received: by 2002:a05:690c:399:b0:8b0:d206:16c1 with SMTP id
 00721157ae682-8b0f216a0d5mr778727b3.24.1792163134507; Fri, 16 Oct 2026
 08:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20261016143007.3474704-1-brian.cain@oss.qualcomm.com>
 <20261016143007.3474704-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261016143007.3474704-3-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 16:05:22 +0100
X-Gm-Features: AclHuK_PDthCLcEGt5loNC-b9kzEK8KG9WJYD7ate6U-zhb3OfXVHmvTerVLFCc
Message-ID: <CAFEAcA93YbtzhDpuK+R=2OZzuvarHvGpse+Vhcd2udB0CQsyzA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] target/hexagon: fix semihosting OPEN filename
 handling
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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

On Fri, 16 Oct 2026 at 15:30, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> HEX_SYS_OPEN copied guest bytes into a fixed-size buffer until it found a
> NUL. A missing terminator could overrun that buffer. Use lock_user() with
> the ABI filename length and validate its terminating NUL before opening it.
>
> Fixes: 7711fdba88b ("target/hexagon: add main arch-specific semihosting operations")
> Link: https://lore.kernel.org/all/CAFEAcA9MOs6VfHf2UHZ8z4cdvaB+7DY6hJb2emYZ2aLSe-t6iw@mail.gmail.com/
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hexswi.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
>

With the unlock call from patch 1 moved into here


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

