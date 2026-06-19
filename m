Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAB6CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waYte-0002r2-GA; Fri, 19 Jun 2026 09:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waYtc-0002q9-EH
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:04:32 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waYtb-0002zW-2N
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:04:32 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-662dc3879acso2061557d50.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781874270; cv=none;
 d=google.com; s=arc-20240605;
 b=NjoevEjkn7wUmBt+EQcOLlJOf8rBUjutMPM+pPDz02P2vJ2nMq59RgYKpQenfdFGEF
 CgfaDKGvcqh1hcWQUcrqTyWnoU7n/qEhi0d8tLTTpI11Pv4PZTF7fiCCli35zvGT8pnW
 2g33CgGNRkiXfOz3gn47LjkJIpsFfOgGUzg7V19LRnLtIo0TX+2FdslTvece/wy1QeMj
 1l7MpIQ4VTZxtPu6+bPkk5LqoMeMPqMwlFH8kR2kOc7O0P+OpygjXDhXdNOGwztPk9ID
 orxJB67Tl09zu7XTy9QFi/A0X4XzMf/g8x6dhQE6OfJJ4dMDaOf3qg65xBeDgRoMOft5
 6ClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nFkVED47i5T7H99JAAPTUwfpJcuACdvrIDt9iBTjRnU=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=gTXkouzR4G5xrZUB0AbCxOQw4rOEcILZ0Fuozpua/HX1h1lT2byVAtYzE0hKlJ46Dj
 aWHq55AD8Lc60+G6hNSg7gr9fosokwCCOuGNm9XQrEw70s4BNSIjateX0fRH4QNuZ2QX
 r9+CJ7P6mjNDLmE7jPixd1R+SkxYuJSzAy4aK0ZZZuBB2uS0g1VU03FmOWl5iILVMxmu
 qQsqCV1L6g+YZd2SXh6x1iibZINQ4ZPJdqMmRBQ55mGAmzEwYW9dev9v4nXX34U7DuXA
 f2I66ZM4ZH/XrrrnzpplMZvXLHlGwOIZ7U3YSYSc6GNdDdwWust7lwqn7rHkUaWCS3u2
 Tl0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781874270; x=1782479070; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nFkVED47i5T7H99JAAPTUwfpJcuACdvrIDt9iBTjRnU=;
 b=SfCrSjQ08Wl+4EhQx14Z6mDl9KYwMHg86ZGJojz0tnIAylxnxnADJ19fgavPMrghuA
 ywoGAUDOUqRVujXuCorevAfFLTnyvdpY6Zvu1vlIXz0S3g+hUlaUY28go/lKvL4MaR/P
 45o8unEo6A5zCmKtujGhUmhxUnUNYzFj0pOVI+YMqnrROLAtIdRgMjB54Ld8IeGFIP7C
 l1PnV9K6denIEWIfeoVigirMTUpHct5zTJU9B5MOt34/LUw2cDu5X43tY7w/sPAP5mH3
 NDJlV+MoqBFp6mRZJufQhthCd91DMSvr7ai3cHTGjY1xIpvakvh+MqR1BmuLPeWGqIWe
 +Sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781874270; x=1782479070;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFkVED47i5T7H99JAAPTUwfpJcuACdvrIDt9iBTjRnU=;
 b=mKWitwFLsnUyIUxC1Bd2rlZ4GcIpbyBNXVV1NFQFP+uhn7+FbHTZaCsEtXf2cI5h4K
 C0TYyv95+p90s//io35vVck3QGVS1HlXbGgj9gAcW7Xn5as/0ZfJ3aY3tdPCYHXXvn+n
 uMljC8BHt9WNyaM1GFp349AgjbMMR0+XlzR4FMsEp8hOUiiCwJHmCoXZ2F3HnqiS7YpN
 a85N6zWSwLQKpaEC8MoTTbq78MPiXYIqJk1gvHkfXJIRSTNmFY7yHNecw+fpEiAhm37e
 en7idMlolc/uI9FBiYUeJzYlDuWZzGwdDxmZBRMe13Rex8MDoWZdhUB+Uk5UbbNJrvKW
 RSSA==
X-Gm-Message-State: AOJu0YzThCaR12DzoM4xmi0DE4LUY8tPXm8fLay137DIIQWEqTjwi9KJ
 A8jlr935+Vfte9kvpTYQf6t34YznPmct+W5cX+Ih8ozxYED5XxDIJXc78RSDh5t+u9lKCJ9VGQn
 eT4N+I0pi7Pfg01rW0jSRF1TwE2PQJTdnh/ZAlkpPyQ==
X-Gm-Gg: AfdE7ckkm1lzsNtarHH/CCjwXugopndyGCyTfU2++lpk55k46YigOntimwW1n1XKbue
 ityC0sjs3JJYrqO+ydHcWiGqffg68/uxTD5jsvFlwXTWWZpREjZekUsH93w7mZfwxTnWGKaGSCN
 m/YFM1p9uRJRzfs7M3PC/0H4rYxi44+2jeLRW8axx82ikaiBpT1N/jaTBbG2/Tnc6VY8eDLmwX3
 lmvLG5K0ziAooIDcaP6bqnXQrKCYeWb7pPNSgWynJPxdjkERZXv3MSWINizA0liB6O+YGUp+49o
 ppkRRToqLTx63PwuS/EEM/ljaHvXbL1OBSBJTPOhSAyvJRQzxBB6JULKiIypUnx8wgw=
X-Received: by 2002:a05:690e:1341:b0:65d:93bc:dad4 with SMTP id
 956f58d0204a3-662ffdd7328mr2809854d50.52.1781874269794; Fri, 19 Jun 2026
 06:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260618040718.572950-1-richard.henderson@linaro.org>
 <20260618040718.572950-6-richard.henderson@linaro.org>
In-Reply-To: <20260618040718.572950-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:04:18 +0100
X-Gm-Features: AVVi8CcXs1kA0nJ7aKIcWMio5Wk1oFJopC5aBxvNtlYs_2ktiEiuXtwvaqTk63o
Message-ID: <CAFEAcA93AsT5wN-Cmkr_5piOHgBCb1WJ7EtaX+QNwdE6mJXLyA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] target/arm: Implement FIRSTP, LASTP
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Thu, 18 Jun 2026 at 05:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sve-defs.h |  3 ++
>  target/arm/tcg/sve_helper.c      | 30 +++++++++++++++++
>  target/arm/tcg/translate-sve.c   | 56 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/sve.decode        |  3 ++
>  4 files changed, 92 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

