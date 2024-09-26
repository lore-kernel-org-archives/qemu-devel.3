Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9250ECDE009
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 13:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stov5-0008Hv-5Z; Thu, 26 Sep 2024 09:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1stov3-0008HQ-8z
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 09:52:33 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1stov1-0001xc-Jh
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 09:52:33 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5356ab89665so1252053e87.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 06:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727358749; x=1727963549; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UjkWOuh+wCMxMoSY3HQr88LMqbDumXIQ+T1Gs4X+5RI=;
 b=Y0K2fz08yUttueLuWsKsX2EmWUzrOqLXsIbWncv4apTbEDgh1L3Amp41hFxiNRf7Cp
 6CpcSlqf6MBrKDezCUT/FbSXlc4Kvn+Sl0qX5J+93GmxISdtDSxR8niL7cpoke2RpVjt
 2WFKANdOCFiBqrbJFguFNz8ycB+qVSQA8i4+S58O16aSbDeq+yEFTQiJmxkVR5gv0RVr
 9YkLdScDoX2iCEjHbMsXxPTrqWWZH0ODuoOSbRLk14EbWXsLgpkCzEFfLRED/4DDtPa0
 XVQq4Lc5jptgCRk+uNiFcmZOrmqK0UNq8Jkfod7BVWnbJk/tuDXFqX/e6lI0m4sgQjbx
 6xCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727358749; x=1727963549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UjkWOuh+wCMxMoSY3HQr88LMqbDumXIQ+T1Gs4X+5RI=;
 b=dznYGTEvccgBn6Wvr6pELcZ1hIj3B+1T3acYRKHuGF/gNGjwUEU2xUg1aSfg+m57+3
 b2CwyK9OWlGvLAjfoifzce5gJDWug0qqey2SQlEvSUtOViRflUS37yQQB1CcdtTpHPrh
 UjIcOVZ+Y7XZH+XboYzq4L8QeRDDcgwjp5z8YDlP9RFE4jfpjSz/VRkFKLq+Eaovb/M9
 GllmbLsBeY5DeRniteOUuoco8XnKpVpUCYEV65p60NU9D7zHihDQBALlKdMuxIsi1qEz
 F86NycyeTezSNjJlblzPFxDmmcW8V5+MsYcY2/pb+6NNs2zPk3rtTFBpItekk58A8c23
 cRcg==
X-Gm-Message-State: AOJu0YwyaYK7MaLpSVKV3DDJ/OZQpLKOLVSv9nIQGMGWz8ZAn7Iy/fId
 RtVfY+PuaoweoLCpJfeKVEwPHVUOKXFOpee7igqe4xFI2lkOElJsjZ1wDB3U8d/WP264tOSM/Ot
 +AQ3pVr01SsYkbEyFXlJsTP1AxRLnHPHCb+cbwA==
X-Google-Smtp-Source: AGHT+IGFBa2iN9APZIvgCdGS4PRMKInI1JQXHRZuqqX+VJRh9O6Xo+DQ+mQ/aBuTnvQ7VAe5gMo/keKCbOsx5YRo+7k=
X-Received: by 2002:a05:6512:b14:b0:52c:e170:9d38 with SMTP id
 2adb3069b0e04-53877530cd6mr4140937e87.31.1727358749143; Thu, 26 Sep 2024
 06:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <1832886563.20496.1725444713946.JavaMail.zimbra@embedded-brains.de>
In-Reply-To: <1832886563.20496.1725444713946.JavaMail.zimbra@embedded-brains.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Sep 2024 14:52:17 +0100
Message-ID: <CAFEAcA_kuDNzW8i6Sfx9WiEG4sxudts6zn=9+=KFn1dAGURyhg@mail.gmail.com>
Subject: Re: Are floating-point exceptions usable on AArch64?
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wed, 4 Sept 2024 at 11:32, Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> Hello,
>
> I tried to provoke a division-by-zero exception on AArch64 using:
>
>     uint64_t value;
>     __asm__ volatile (
>       "mrs %0, FPCR\n"
>       "orr %0, %0, 0x200\n"
>       "msr FPCR, %0" :  "=&r" ( value ) : : "memory"
>     );
>     volatile double x = 0x0;
>     volatile double y = 0x0;
>     x /= y;
>
> When I look with the debugger at $fpcr it still says 0x0 after the msr. Are floating-point exceptions usable on AArch64 in general?

Something I just noticed when I was playing around with this
example for other reasons -- it won't trigger an exception
even on a system where trapped floating point exceptions are
implemented. This is because in the FPCR you are setting the
DZE bit to request trapping of division by zero. However the
operation you are doing is 0 / 0, which is defined to
set the InvalidOp floating point exception. If you want
to get a DivideByZero condition you need to divide some
non-zero number by 0.

thanks
-- PMM

