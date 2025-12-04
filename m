Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCB0D24477
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 18:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRE6M-0006ZM-Rw; Thu, 04 Dec 2025 13:30:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRE6F-0006Y0-DJ
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:30:43 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRE68-0005Si-Ob
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:30:41 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso12596545e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 10:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764873034; x=1765477834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hL6ZOvPwfZqJBGfFIRCJy/Qt10kZtQAF10c32kIyjEY=;
 b=fDG1khzjPy9WsxfYSuyM67+mb0GdgFryyow7Nj9qTfOPBWnppsWeBQMfnDC7aUQJFD
 Ql6UMVdOU0I/nY/gLf0QJut4QIckNbjURzoSptMFhEdaX3RK3nDOZ7sGqNlWMU1TCyEq
 3YkcG+S36DT7oZzxZ3W5qjj86Yvm6BhAX7rnIM1nmEK/7Fa0w3aCwKFV/DQpFWZou2cD
 AjKNoSqCh7pe4NRATxZ+AMYXBMd/BVWGqAYPE5NK3N5X3VxNCt/mH48jqf7mwb9yVgJh
 nIO8hzBukculYpMlB38x1rQttHIsx94iT2O6JfH7USTHMC/+/9r9XAHoJmt2kW3BoDHI
 ehyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764873034; x=1765477834;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hL6ZOvPwfZqJBGfFIRCJy/Qt10kZtQAF10c32kIyjEY=;
 b=Q3h7dnr6zoQrMyCa8Y/EDF9ILoh8sakf77bKxcyjk1RdVrL/06NcSJ7MLMxPq1OMpQ
 O3c1CJB/8ILUtyPodljcalADA0aKQwXkLha5bdxLmSZICSdCFuIfTFWyxL+DtQv7VmI0
 XVBn6uQ1GcJtLb0UtYgG7ni9VP3FAvFlbkn+lgZYD1Ev4suwAXHG2X2qRI0CSviFWMVA
 XG3ZjpIloLeebgMN3/HjRvAOQn0QPES28Zux5CPvdScimln1tJk25R5KQoYH1+PSSq8J
 +BzFE1ogko4MycdlqNlfpKeLPYR5gKAPFnBbj86TdbjF4K7sU21WJGOEeG9qCW7CAD0v
 ygQQ==
X-Gm-Message-State: AOJu0Yw9dqb7qrScktC8fT9yCP+bLA5HY0hCL7Ks/Y+7oS/XtBr4LzJa
 xd4oQkQdnJglmXC6Gcigx68I2haWisrcnoXfmZRXAOegfHyBsBAQarSNVxvp+ZELtIX3WoTg2HZ
 D7fYv
X-Gm-Gg: ASbGnctQfI+xUVyxZshyTWjGJe1iL8tC4XchxjfWTmJJuDBeAGHiEEbNV1wvNGHQTTt
 +bUvm5I2W+JiBpc/IZ1A1ab8DVI+eHXUccMsujpctcCqBqqxFCABwQ1SqlsFkcbaDM+n6/KpiLp
 yolSLJ8kT3vrNA0fHtVhM2VNvTw+C2WHT78hjg/zE1w3zmPVS+n/1+9g0AhpPmG3ENI2w2JyrnQ
 BReZYwRgfzait+VPLQW4/Q3XsNCvR1excn2DiS+tLeds/DR6zYx6nOh5wus+D6ZvvftT6yK2pc8
 E9As7Qmze9Srbv8T60dGZQlvCwLhsNCOBBv5I8tYt1vUyVN8aL0Mfj9VEnZiZcXWAD6G2QnbnjL
 hQzZ7Cu9DEyLzxwO7R7n+prpcXlaCF4rUpcfISfINz8ec5VkjTcRndu1SQsXmEHVW0C9qJlsgIX
 4Lt9LWP6dx7WU=
X-Google-Smtp-Source: AGHT+IHNf0OzwhoaAacAJeoKqwCBWtpJZMmNwyeYLW0mmnhiQjOhqkF/1I8JuYnIf9Y/S+dkmTp4Kg==
X-Received: by 2002:a05:600c:2052:b0:475:d7fd:5c59 with SMTP id
 5b1f17b1804b1-4792eb73281mr33329345e9.16.1764873034453; 
 Thu, 04 Dec 2025 10:30:34 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331df0sm4680443f8f.36.2025.12.04.10.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 10:30:33 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 24C0A5F7E9;
 Thu, 04 Dec 2025 18:30:33 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH V5 0/4] Basic ASID2 support
In-Reply-To: <20251204180617.1190660-1-jim.macarthur@linaro.org> (Jim
 MacArthur's message of "Thu, 4 Dec 2025 18:04:10 +0000")
References: <20251204180617.1190660-1-jim.macarthur@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Thu, 04 Dec 2025 18:30:33 +0000
Message-ID: <87pl8urtfa.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Jim MacArthur <jim.macarthur@linaro.org> writes:

> Thanks to Gustavo Romero for reviews.
>
> Changes in v5:
> - Patch 2:
>   - TLB flush when A2/FNG0/FNG1 could be written to.
> - Patch 4:
>   - SPDX License identifier moved to first line.

I think you missed picking up the Reviewed-by tags. I used to do this by
hand but using a tool like b4 makes it a lot easier. See:

  https://qemu.readthedocs.io/en/v10.0.3/devel/submitting-a-patch.html#prop=
er-use-of-reviewed-by-tags-can-aid-review

Also its worth adding to your summary what patches remain un-reviewed or
indeed noting they have all now been reviewed. It makes the maintainers
job easier when eyeballing the cover letter.

>
> Jim MacArthur (4):
>   target/arm: Enable ID_AA64MMFR4_EL1 register
>   target/arm: Allow writes to FNG1, FNG0, A2
>   target/arm/tcg/cpu64.c: Enable ASID2 for cpu_max
>   tests: Add test for ASID2 and write/read of feature bits
>
>  docs/system/arm/emulation.rst    |  1 +
>  target/arm/cpu-features.h        |  7 +++
>  target/arm/cpu-sysregs.h.inc     |  1 +
>  target/arm/helper.c              | 22 ++++++++-
>  target/arm/tcg/cpu64.c           |  4 ++
>  tests/tcg/aarch64/system/asid2.c | 76 ++++++++++++++++++++++++++++++++
>  6 files changed, 109 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tcg/aarch64/system/asid2.c

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

