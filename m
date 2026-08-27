Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0FDC61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZoh-0000VG-0o; Thu, 27 Aug 2026 09:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzZof-0000Uq-1J
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:06:49 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzZoc-0003fx-UN
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:06:48 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8565d77c277so34053727b3.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 06:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787836001; cv=none;
 d=google.com; s=arc-20260327;
 b=oL8SplJlMfiIgq8u0Wjk248BXdOh49UEjj1uKq6MjDyJYUfo+DMamDBcTRqaTTr+LZ
 LoOtfGT97yCEEkWlECLMmQTgkF6Fl7CbyM/cDqz5Z3OZ+JAckapNicPtpa+W+i9zMOIu
 KCOx59bTYws/3hoDKZeK3ECvZ0MJ+APnCvHQJr93+2q9AONROyZ7kJBY8w7UXpW28ebN
 B1JE8WgDlf4YQNAunIiRWPxiFDsECGUSGSgIswRLYpIJc+lmQrrPw2HLijmdjC7HRMTj
 e+PEvzjOwf5hgEtG8kjteLFTxb8hThIuYaEbhNzQ4SSBGA2Xss0ddjF0bC6D1IoZv3Vq
 pW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HDL/+0Zqfgzn8IA0PGscT/LT+J6jFS9CRZtQ75YjUEQ=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=qiPAnQcpeGF+hyYRdLqD0izWyOwuj3e1Czfn95OChWi4oFYawvrw6p1GEHCwcbKJKw
 BH6djInPW4ujloSBHZlJbt6MVfWzTsk7PW/0Ko7wJkXRXt/sn8Y2mFrWZItXlSwmk9xP
 WjtK/1xh+PomWRSzX6dyKU/HyEof76vrbYhf87NvhwCR+kHpLtDVZy02ViiLMxu1WzmR
 HuZTCuyeYFUmtypU3syMNCdyXu8537owrZOg1O+HcHktxDnyyY9XZrytz65mxFqd/HEb
 UA1ufBa5uc4aTePIVVdbR+SoPdhPd+drVtlrw7OPnL58yFBZUEqlm4P6/yE+3WiOHRyk
 RfHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787836001; x=1788440801; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HDL/+0Zqfgzn8IA0PGscT/LT+J6jFS9CRZtQ75YjUEQ=;
 b=CXkdHPP4biy9SwdJkQnF5MQeMrQW2WFNZPEzY5Jbr5swooZCXsTWRYLuZ6yo4y6wLM
 GApzJvtJ21twsUrdmS/NCSOIy4W9U1U4qxODQM99A/lwS2QTMR0z9KMW4VmSq7ksnHfN
 31C4qQbJDOngbwCfjQNTsns2pDlSlAId4aDMK5nldnAjkkeXM3bFoWj2z2mk/pkTHQ5o
 diCpAbxuis0zOcV+u0JJiivt8CLg1+UiD+lVM3k0qdzt+L7Eu682fjVkO0ygtX6w5/mg
 C+viJx/yPQovy3iZwgNkrFXxk4+AP2gwrmMAfeZ1eguEemtn/DP1aV8wtis0y1sDLNbP
 OkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787836001; x=1788440801;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HDL/+0Zqfgzn8IA0PGscT/LT+J6jFS9CRZtQ75YjUEQ=;
 b=FhFcW1+8QUOWyOAS+n3EZiH6/ezSPmKBh756eiyw3oxQM3ZPXinsiQvydLRK5ZVJOP
 Sh/4Pg5RXNV9CaQcaw1CNEqcoOyDspQ5OafrKWV9agxX8i7YwgDWOSTSbTxQCUTxgVOC
 9sL0Logm510cpOABbZ7o8SwmjrSL3ntFrTq5L2/QnsZN+Q2YSPQipk3NVNq9aNw/XJh4
 ELSbMY9SGJnFf2XYSDfHWG1bDx2w6datMqidCu22PfEEwzncbLvTT7jU1mj7uzti66pi
 JVKJAW8E4O24Ovm/zBi1R5ZrAVS6vXqR3jqBJHo5xIa0WD7qRB9+anhGhf4VyE6ycBMj
 PsPA==
X-Gm-Message-State: AFuF++llpsODJLVkx2u9XNb9YFJGPyZPwJy/8vRfp0Mjo5OH0fgpwaBN
 468L+bDTs3BIRIGEjMUusU15o+mw8tsmB+0zjijGTokugn3Xd4+SxwZ7OHVjrwXpW1XhApTsjhB
 tjKTdF9APeKaDy/W2oImVyOlXTuS6kHXqcEuTkh81m0YQCe3KZoOfLkw=
X-Gm-Gg: AR+sD11Ua/XuTnLyVni2AVJpDKqxjvzmODfMRFskoj4VZblbDxc0sHrooOlMHyMvSPr
 Z6Ga/W4+d2QFBGmSvQcp3AeE7zv6wvJDnLrPXXlIp/4Zoa/+3JSD0hoHrDfrUwjNvobeHOGSHoi
 yX6tg5+UfrGj9EKs1d9GW7qTq/JEiIW/eheFDwHRnqkKl2A8IGxf+pi1Fmt2dC619il50r1pSn6
 eg6chkeeML4Cws11iUoIGjHxu83f5RNJj+dh55lZaDVUPJbYXsU5DM7LAlVbjV1C6rJ7nk8ayMp
 bi9EKOEKBv6rsR0gDR7lR1nOg6Nb1LW9JS8mLSL4808cmj4N4PfeV1A2Igj1euA6ui9Gt1pZwX6
 oS47JS690jl1Oo2vD9lWBMzr6diDJ
X-Received: by 2002:a05:690c:15:b0:809:9422:8c47 with SMTP id
 00721157ae682-857477a395amr58939267b3.22.1787836001017; Thu, 27 Aug 2026
 06:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260826174213.614571-1-richard.henderson@linaro.org>
 <20260826174213.614571-25-richard.henderson@linaro.org>
In-Reply-To: <20260826174213.614571-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 14:06:27 +0100
X-Gm-Features: AcwNN1VZpws4fD-nc8_ovgsWcAiyjO_rGKB8pEBhVcgTeNnRBch14NazL5FeYkg
Message-ID: <CAFEAcA9t-WzK0f_D_p-41H5Ts1+PNWKBnztq46LY3+MvXBFQqw@mail.gmail.com>
Subject: Re: [PATCH v2 24/25] target/arm: Implement PMULL, PMLAL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 26 Aug 2026 at 18:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

