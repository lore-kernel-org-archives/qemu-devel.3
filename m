Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BC7C87FCB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 10:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiW19-00043o-FE; Sun, 03 Aug 2025 06:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiW14-0003yx-Fo
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 06:32:35 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiW13-0002vV-33
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 06:32:34 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7170344c100so20129537b3.0
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 03:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754217151; x=1754821951; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NcSR47MHzBHuv2UsC43vzshzwxJRPYuEbs48JV+Zc60=;
 b=Xhk06tBCnVFYI32GOASE1sEdiO2BiIiztTMFMF4kydtwVDSlQZq55fb6/gzfFihL4j
 7GZ2st7ZtLpS5ZmOECVnhvGYlqkhKgbAZ1D6A7Grpm+cMdYyQf5vPr6Hm8H56RXeexS2
 CpwcNk7C7QPPao20nr+V57jedOQkdeZUz3OeozU+hJKAQK+ig0lvZUR2mihxgAb8o2w2
 Tg1O30iCFEmV484u6ECQawHdu82VIdTlnkF+0sCCsxWs4ljrH3NoZIOBIv+ptYvup5pA
 T8Dr6fvY2zMaT0KfhnhQjoHGI1iNNaN8BX0kaf0lf4j+3kLAIJUDrwOiH8gQe26aCo+Z
 33Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754217151; x=1754821951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NcSR47MHzBHuv2UsC43vzshzwxJRPYuEbs48JV+Zc60=;
 b=ExXC5hVpDw3WUYVlcqw6pteekX7rwRovf4+ZOav7sCSkZv59Y8Ok5eRZTseGICTbtL
 9kZNF5TYoz1q5WS8IbpOL2kacydkTRTc48XmsMOzV4Gj/zwDowdaaaOHtl6DpTT4TqUi
 DClrAuQjlkBP3Ye6oXrOkzgDLTy8zEhQxqnuLfqkh6syDPLgFsQL9cR2Jk5aukjLf+Mo
 fntdtqYhkL+izOglWPTkE81Y8Su8uExgX/w7yq/ORDjD4Gys7GylMuaPmCQV20GXZ+hi
 eK9CKOm7LExSVvB4tVLFiQ+EPe7bHwHf3hWV/SWjIXSYKgnQhQ2JK1m1dOSlRfKAt/Nr
 Av1Q==
X-Gm-Message-State: AOJu0YxiCt7htYEH8kuq6ZONHmexVdwjDFxBEReXrOLz8C4pRoQHlZw5
 gkpJyTpmUXD4bp5Yr+6lIsYrS5hoC/rJvBO65Q48yYTIf7M5dHbVYk2aokj8kTt1wqAXNzAGB8z
 +lLINrdYRJvwL4Qs5KPWEgbJHRWwFs3ACeZXJ/BilSg==
X-Gm-Gg: ASbGncvv08g/i2HvGdwQzjEgpeJiYXZCKK2XJc18oRFfgR1BltjgFGUK19rxUo85TEx
 kyf8p2eknfVh2tYIJkIHw86nsnoCUv8C6QE61aOMJIXfif4pQ+2I2xyuTuioKHel+zAWkIDsjHO
 /ijzkyMKDH9Isn3ocxL3p4NUZFzGVHDj9QVTGzfYMOW1Zwz65Ult2u0qZStG+SJfZlu8VdC1b97
 x0ni8ae
X-Google-Smtp-Source: AGHT+IGy4rlghSnoaD10NRnfrQy0dCzA4aWlaxVlcVKgdAtDTo2Ineco74KsPuu9fxhEPNUWAJxznb7zZ5FPTZ+u1e4=
X-Received: by 2002:a05:690c:6993:b0:713:ff70:8588 with SMTP id
 00721157ae682-71b7f0afcc2mr73813217b3.36.1754217151074; Sun, 03 Aug 2025
 03:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250802230459.412251-1-richard.henderson@linaro.org>
 <20250802230459.412251-5-richard.henderson@linaro.org>
In-Reply-To: <20250802230459.412251-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 Aug 2025 11:32:19 +0100
X-Gm-Features: Ac12FXx-sLlryjOugb2J8xlfIxxWiFzKNmyMhJ-1-xzKWMQGc2YIOzPNa6HCSHA
Message-ID: <CAFEAcA_E0agr8iq_90C3aicJmOh9JQ5y2FXuvZ1BM_KRWX==qg@mail.gmail.com>
Subject: Re: [PATCH v2 04/95] linux-user: Move ppc uabi/asm/elf.h workaround
 to osdep.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Sun, 3 Aug 2025 at 00:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move the workaround out of linux-user/elfload.c, so that
> we don't have to replicate it in many places.  Place it
> immediately after the include of <signal.h>, which draws
> in the relevant symbols.
>
> Note that ARCH_DLINFO is not defined by the kernel header,
> and so there's no need to undef it either.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

