Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCFAD116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQAbB-0005Ce-2b; Mon, 01 Dec 2025 15:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAb9-00059Y-TY
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:34:15 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAb8-0003x6-Im
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:34:15 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-787da30c53dso44859637b3.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 12:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764621253; x=1765226053; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PlAozQd/rSA/EXl2fvBtDQnZeqgaTHW7d8bQdRluexI=;
 b=lyvscQg+sKnec0oZQVcWXaQtzdUfa5n6VL+zzWea7g8sdwDdf5kILcDIzlJECOmQeK
 zEhe8xWG0dC1Hfsx4146O9qYcMytRsHClz6uSHAYK43/3Sp8WKNis+t0Z1GENbDRhbi+
 Bzqnt/dWzw3FL13t3sleK9m1U0dWhjilDUnLiG71i2cTLjJm8Xox0VdUKr1bq2drgqnB
 +4S+f6GrT9VgbhfJbVdkLlrZVuwy1z/DcezaiaHx4zaT3KrT5AzmJDWtF7g39ChAe1Ip
 PX2y3GdRW1hTyyDC6ws667DZ8Cqks9umtevnJRTp+lYj177GDP6HtnrjNaGHUJLnDiwg
 xaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764621253; x=1765226053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PlAozQd/rSA/EXl2fvBtDQnZeqgaTHW7d8bQdRluexI=;
 b=ZJOOFz0qDKAf6UavYz4/ycXtsLGBguZ1QiIFJiKzkdAK1fl29gJQa8HVGyLkdJkstF
 bz/YM9AULkpl4q0J10kNjAliPmSvNmWRmG9clcXz36JhcPIeS8clc9tgIhzNk6idoKo5
 R4GMx3gqRXjyXtDMZYHN1+E3+tLeBf2E146zGIezpFcYGR5DNojSOhnFEdWajjl7F+Y6
 sYP8sE5k23uJTXWfBexMYEhdhidBWKUbUVi9SMg7WJJ5sZLHuypx9lDYM0rntML94bxV
 q0Ayh1ZJ0o7ZYpMwY6nhz7R4d6dOTOQYi4CRG+de3KpWCss2UlKnIpmnN9MKWEqj2yQc
 eDLg==
X-Gm-Message-State: AOJu0YyjfBF4cSJlw3SmFNtBlLFtaNFsF86WrVcMrTFbHAQ6cn21qr4y
 uyKALIZoX0Mz8mLPTLdXmbp7kQmgT2pkKh6c51xnCOPa4zduSeiuA+fXhC2dTzqWR7+qn7o5G+W
 cFz1BadwuxdXzRZZG4QeWFa/I1UQuizRaTsAvnKHu2w==
X-Gm-Gg: ASbGncsF24F77d5FPXcdAwMYLFlP5nLxC1rFK1/oLqc5Td1IxuxG9fQX+8vn4NUwIo1
 HTQDnzy75V1TjbKgUnExNbScEP1HCxXU2fONWhBDmIRRCtXpg1/JQalWEi6w8oiMvIr9F2V8K5f
 V4FFGo7zQU7V7O/tMTh7Du8v9YuYcqvW0mSC6wIs1F6Jj9kMplnD5qUXCdYhxE6Pcr+nBsUOtEK
 QbDaG1VUAp2ze+zEqAB+kq6tKF0FWLwIAXImSVkb+F0z3+2gSYVGMA7hPqKz1QoB3dcEX+xfrJ+
 cp9Efsc=
X-Google-Smtp-Source: AGHT+IH9+lqbbi70xFkeQLp3VjAAel7XQiM1Z+d5IcRt4m2v4xOnvF8A7WeZr5gbQ2smJZQoe8aNHuhMIqPu94SXPX0=
X-Received: by 2002:a05:690c:9c08:b0:787:ab13:eedd with SMTP id
 00721157ae682-78a8b528950mr331335107b3.40.1764621253234; Mon, 01 Dec 2025
 12:34:13 -0800 (PST)
MIME-Version: 1.0
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-13-gaurav.sharma_7@nxp.com>
In-Reply-To: <20251119130027.3312971-13-gaurav.sharma_7@nxp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Dec 2025 20:34:00 +0000
X-Gm-Features: AWmQ_bnOuHdKab43om_nMduNfGrrX5QekpjCSAybgZYI6jdULf6UFUOygdOnFk4
Message-ID: <CAFEAcA_Sc2N9sjFOZ7DydAjG0H0yx6P3jjY+nT6hPpe3DJo_dw@mail.gmail.com>
Subject: Re: [PATCHv3 12/13] hw/arm/fsl-imx8mm: Adding support for USB
 controller
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
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

On Wed, 19 Nov 2025 at 13:00, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
>
> It enables emulation of USB on iMX8MM
> Enables testing and debugging of USB drivers
>
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

