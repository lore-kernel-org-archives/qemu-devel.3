Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610B4FDEE43
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzIm-0004Ra-VX; Thu, 23 Apr 2026 15:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFzIk-0004Qv-H8
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:01:27 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFzIW-0002uV-KZ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:01:26 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-651bc8f864fso4015583d50.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 12:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776970871; cv=none;
 d=google.com; s=arc-20240605;
 b=alfg37ccxJb2TBCwg3BjyKoqYEowqp8iROfXh/0VsYHUhBhWltIeTmdKNO2TTLlz1P
 Xi1wH8YDLWrM6DKbPepee4EOmrlcJY9bVqukHhhGmy/DYA5AZxeHcXcjPPs7kf18d9NO
 okyJV5zXvUHkS+0psJg1MuSKd/jsP2PjRQT/A6nHhVYGg1GacMcPI3+zzD3SGPHFDL7R
 46zcxVt9sr9roFNIu/lNKGljhdE88sIXWf7M697NV+s7YKyy1du8xKFd5gp0S1kH29lp
 RqctB1S/vDwqc4c4rgIgnylV7pJESHEfjtMx0rM3WyY+avaJikC+PLcJV3NITh7TRDoN
 pWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M9HZqcM7NPebMy1NK9QiRhtV6VngaRi3FKGJMv8/iHQ=;
 fh=ukEXsNcMmgvP7vIRWVpwV/bHje32cgqtZkJrBhNlMEg=;
 b=dS1QWTXaEoy+PCCW/97mC9U3Y6w1umjxgtOfFul93AQE7aMPZNi4m1IBOs5rpX/FFN
 b9uTbyQ9Gy8OoYIKHH88YnBCjuAGrI8Ocm5sS/GJuNSDW91cImvxZ8uEDFKJc8rdtNfj
 LtTnGX/UTenGs5+uNK06caCYopdHTCbW6Nin8J1KnHae35cBF68MGFnqqozcsdPx6NWD
 XOu0HIfeNbC1dDL6x30BrCYvb5+Zdbm4D0vIEZq1hmR8B69toFavvIkqDDjdL+FVuAOG
 pVdDDJayZe/MNP9HqZrdu68VXFTbhHL4YZ8N+9wbXZXbMECQBIpIvUMLqZ25NWN1PMg4
 m0oA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776970871; x=1777575671; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M9HZqcM7NPebMy1NK9QiRhtV6VngaRi3FKGJMv8/iHQ=;
 b=wjPWIego1k0S9joTYedx5Nv2+alnMFUhJOrOu7I2CFTZT7avn3JO4R5MEs0hY3QgY7
 hE5VmJ/nWtQqePUcY6NXljNM8tIMLjmeGy4pYLOQnhh4M2jzGqWTu/vyGkTNZt722zZz
 +h00qqndy2s+apH2qLaPzptFUPXvP2DpMS0uTa9J9LlPWlQusH7UM7YdZIOnxPn/mbTk
 5RioZE0Wz2xkEJA4rcq06OzsJoBTNnSPU9KfS952JEwAVeb5WW2CkKEQoolY3Ebj8sJn
 Kj7es/Rz81KsCcF9tuuN7yd7qjc1LW1BRo61RK24YeHcNSgC/DtA1NZinD2V26Nc91Ln
 stvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776970871; x=1777575671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9HZqcM7NPebMy1NK9QiRhtV6VngaRi3FKGJMv8/iHQ=;
 b=Bct3ww7PmvKOEi+dzeoOkn1+60G7F7mBraW24pkfyaopkX2JM1YT/Lmioc4eyWepnN
 RGi8O0esJsSvcqiMJu1KRZsrBof1UtcDnNEzO6UTDMubODHne1FNG0st5NNeTz2GL5Ge
 BOoZGYMCBygXXuv9ouooBKmDoNUNiXKhRb6BC1QEBddukGdL0W4HhD6jY39883yIc1hm
 kMTqOc+XjNueC9dgPrBs/iCKgq5dorfkqsV25ASTafA17rG4iPRBebWu8ykebbKEuGK4
 65+KMUycOD6GQBPGXJU96HxgmRmog4Sdr6indypwYkghgC2n9Oaxkg8lmsafgOdJQWgr
 CnDw==
X-Gm-Message-State: AOJu0YysOKRC6qHYJ8D5Y9HZ3zGBnsFYFlJhylNII4d0mdJSvb8G7PR5
 eQmkqcXQBgnNRne0Vx3c/uSQ3UYIo74sx2xh3MuX8N904E+06FrFTZdXbT6PSA5fQsAZsoVsS4z
 ITW4UA/hVrM6YUTP5BWSB0yyakero/vlBd8RnpO2ZFw==
X-Gm-Gg: AeBDiesoxTjq6J4QufeKXLVJ7rBISp0TwrqfQc271qY8eKeQoa9afL2UHMiL74CbE5b
 A+YuOgFe1/NVl+wu9F1xIbN1SkgaxBwmUKo5MsVG9PXK5thjGMzUTEZulhDy/4R5fvEZ+b5mXlO
 SrjfBzQR4ra+kQiUCzcMQNmLUNkDhrEy7uskWZNgTyIqG0FpHd8N74I+rRkE2QoLKh3ShdkTqkG
 Vfuqmj+y/GPorQfbGkIx2XPp5ZH8VXbHH3ChGNg27h2BgfovFh560cOlVeqQYs2h4lkZ0xrI0wz
 YII/16xFY6F80BH8vdB1BAUsfuwibAegSTta0fZsxOKNbyJ0cubiMDe0Iau5HYnkCQTs19p1q8Y
 fZg==
X-Received: by 2002:a53:e1ea:0:b0:650:36e6:2ace with SMTP id
 956f58d0204a3-65310a27873mr21409542d50.31.1776970870954; Thu, 23 Apr 2026
 12:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
 <20260423180304.53789-1-lucaaamaral@gmail.com>
In-Reply-To: <20260423180304.53789-1-lucaaamaral@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Apr 2026 20:00:59 +0100
X-Gm-Features: AQROBzDtHEqsh78UYKKiqHGSESaDbY8oTWcsFIy_auUaZqkVLk9Ba7s5Qh9ZFJE
Message-ID: <CAFEAcA-mqtqcgMVeNgMawjN+RJF9DsfXvnLw5ncB9fRvTo2iJA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] target/arm: ISV=0 data abort emulation library
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de, 
 mohamed@unpredictable.fr, alex.bennee@linaro.org, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 23 Apr 2026 at 19:03, Lucas Amaral <lucaaamaral@gmail.com> wrote:
>
> Ping. This series has Reviewed-by from Mohamed Mediouni on all 6
> patches and addresses all v5 review feedback from Richard Henderson.
> Patches still apply cleanly on current master.
>
> https://patchew.org/QEMU/20260409220614.65558-1-lucaaamaral@gmail.com/

Yep, it's on my list to look at (along with 27 other series...):
I'm just waiting for my current pullreq to land before I start
assembling the next one.

thanks
-- PMM

