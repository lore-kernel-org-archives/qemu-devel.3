Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56AAEBFD16
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCChy-0007G6-Fv; Mon, 13 Apr 2026 04:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCChu-0007Em-H0
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:31:46 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCCht-0005Cj-2F
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:31:46 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6501725d888so2990558d50.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 01:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776069103; cv=none;
 d=google.com; s=arc-20240605;
 b=Z6hF+WB6xh6Fr5UOUEPIh6dN+4VnG47YW/U/ltQ7xTnHI19W/DRAQ8zIdB1KEDi8L5
 X7AImNz2OXaWE/R7Eci6mra9e2BpuMKZHEFEQtq/6v+ciRzF0QwFOtljeq4LncFbZuwn
 7u9X45b2gQIC0oPpJ2jfS5NGa5fRVDKMzd6Pem0oUf/CCw1krAGOY5kmPU2029rHuaeW
 L88jvbDL3grOkvd5hm7A0JArusgJdVAq81bOFJXjZ/a4RGMBtgIGY++++pMF5WGUQ2zF
 yMPk7nsbpq9AmEVmAnN9Huag7Z+cklWqgd9YFUDoJV+Fylw8jlxjDnzczfzgUJ0eLfqo
 +tuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=klKksQP1r6P32ErEKkGG269qIBOlQlQS5DCB+6d/CNk=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=Y3wurvNHe0FHUCBRbJDzVASi5eTY781441kkjOkECPJl9zOdYQHuC07UL2d8nVr8yD
 PtvpIioFFJ828AqJ/qwIOTWa7fVE4opYuNu+Zunf6KocAfrD8q5aom9SeDGQLISHijI6
 snqrQVPYogVLK5TzS3S7lM9qKLnbMI3oXe2gFs1nuDtRXZ6gWMujr8EQrxreVNCCC5j/
 tuqpttDiLF8cvWdxY6xrwz1G1EKM/rkcAn/lAO1xsvnAFiGd//ianPsC6eqGDgiKO+eP
 dbcatZ6g0lDNWZK4yLQCagQLqr4DL2rT6piqlv7m8+iLJzaA3BeSdcBcMAYAP7zCEF6a
 FsNQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776069103; x=1776673903; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=klKksQP1r6P32ErEKkGG269qIBOlQlQS5DCB+6d/CNk=;
 b=hTYSd7CHN+E60vfngOVXlrOv+3G7+aE2vZ3NMsiEnY8D9NOW33zvQPrp7p0WbDN7i2
 D4BaM1C0fym8yNIOp5wJFjyx67mcVmG+5NWCH7lx7bVrw1RbW/kvyB+wKsa53Uyd60mv
 jTZ6LaIPPd0WOIUob/v+QpBzcxmIMY/pDTwZU4JhoKrbrQwuJ7o1qsNRWm5zJOSz4O8h
 3PcvVGFQQZU4229xw+hIxRRRdL8yXFnpXKILX16tlxga4sQaVCzWGzkBW+qjvyN6mUu+
 Qp5l2OUxdzWXLBF66rDzx7ADAB+mwVy5sEUwKK+8gTOTwP5YEyjlNudWPssiO5P8zkEW
 IBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776069103; x=1776673903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=klKksQP1r6P32ErEKkGG269qIBOlQlQS5DCB+6d/CNk=;
 b=tKi5eUBqOXJpOt+zwmpr7feF2NdmY3HeEWxPUHw8e3S8GvoA/T8IfDSJUZqq9Ok48y
 a5Mq6ggWSiV2GFERjHfE3f0zb1Oeo2aP6Pk7MAGYj6ZM0EIF7w5IsoNbQe9BnmEh6SVG
 h44MzcaBs0vSebqJmHiaal8mSI/cYLjINHpERW5WVNhFJ+2AtLz+JEqgUKbCWBdnnuNB
 h+p0spjYiwDTsdRSN++QiDYRg2EEiwp26yUYzc7tiQc9s9Clj2fEdqpA/pYVeqoxOCX9
 QCFXh53r89d5VWGrV43CKxSY6mjikbEncI2FztHbYLZoeRJduxNRJ2Vwz29aPNjuNDBD
 RAAw==
X-Gm-Message-State: AOJu0YyDUCkG33tLNpEwMMsOiaRxcFa8lcrAhP8VI9crXLD+n/SXNvqf
 hO5X57P114sET+MyxOZCvwaO56vGrDnq7kAmnCiEh09JoitqY34CJWFYRznEtsk1Frej4reIZJ9
 BSwi2sK7TfYiGWkWz/Ds+9w5kFpwkj3XBB2EpYWVWS/thpnVZ0xJ01nI=
X-Gm-Gg: AeBDieuRw/inx/Yi42IIEU6kCNYbe4nO9ux5BEyOvmzUKsNlWy9XCOru8WGLOC3bKaX
 i405kGPOooede39qv24sol93onktDolA6HezBp1++PQSfoIroBPN3TWbQyuYJ7nj3p0cC1roh16
 kDPq2as3SUrMfo9uA3mNgqRfqMY3KBBcsTA4WrAwRt3zFELjFRgs/ibEalEah1wvj3SCM1sqLhS
 3hlboHWzBzucBBVqT1jIAYjfK3IuGTQSrGfd2fJK5ftOv3FUivd33PhQKdiOA50w0drL/KbsFZE
 QxfqSFrxWTKYY+yjPtBIq96Sj3SLf1xjjCJDPpWghTlNqb5w1jHZlsJSOqbLvUxRwIs=
X-Received: by 2002:a05:690e:12cc:b0:651:b64a:ea1c with SMTP id
 956f58d0204a3-651b64af863mr5747671d50.50.1776069103446; Mon, 13 Apr 2026
 01:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260413073215.29968-1-richard.henderson@linaro.org>
In-Reply-To: <20260413073215.29968-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2026 09:31:32 +0100
X-Gm-Features: AQROBzD3paqdwqxetlTieIMnyFteXZDhzB3xkn7PZ8Ua0c1AeOraCAxuJjWXWac
Message-ID: <CAFEAcA_UHaUV3NQ3S6b9HcPF0m0RgiZZAgQ-BbWLPHSCS0hGrg@mail.gmail.com>
Subject: Re: [PATCH for-11.1] linux-user/arm: Remove nwfpe
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Mon, 13 Apr 2026 at 08:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This emulation is present in the linux kernel only for
> a very restricted set of configurations:
>
> config FPE_NWFPE
>         bool "NWFPE math emulation"
>         depends on (!AEABI || OABI_COMPAT) && !THUMB2_KERNEL
>
> EABI is the default for all armv6 capable kernels, so this
> isn't enabled in practice for some time.
>
> GCC removed support for the FPA11 somewhere before gcc-5.
>
> The code within nwfpe is not thread-safe, using several
> global variables.

I agree that this is probably something we should drop, but I
think it needs to go through the deprecate-and-drop cycle first.

We probably just have time to mark it deprecated for 11.0
if we're quick about the patch and we have something else
that needs to go into rc4.

thanks
-- PMM

