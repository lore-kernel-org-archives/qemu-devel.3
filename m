Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F0AC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtAM-00020p-AX; Fri, 01 Aug 2025 13:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrkn-00065Y-Aj
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:33:18 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrkd-000688-1p
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:32:56 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71b49a8adb2so17812047b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754062372; x=1754667172; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d7kVpCiScY+c4c/JeCO+UZKGptrIF1deGEU+WAJd2RU=;
 b=sbyiG4DNoB2K9JIucSDFhP/G7pxzLBMpXdSFNWgSWpZJvt3nH/mWdp2HvANPclmdcP
 UqIfV5R/XVn7EdJuCPPKv4oP8EYSwPcYcHy866KyFR1X/l7x/ru7/bzGDzdkXDBbhdO4
 LD03b0BVwu6Mn2JwoVvvqY/afB2mE7MTuf9ZM0lP5JBh4tLXNo9MrcI3/lrYzlTWB32P
 2aVL2Eth++ftD3nqXTQb5vwEI2KjNfj+h9KHLqYXUrEYIH+OCIEeQr5U3cjPsSX/RCHU
 AwCqjEq7cg7e8y78yNMJbNM993oCNZBf0QKIeOKaD8UdmXMzNYDdFvWULNUEBgcyEfe/
 p+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754062372; x=1754667172;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d7kVpCiScY+c4c/JeCO+UZKGptrIF1deGEU+WAJd2RU=;
 b=fxbQoFz34FazU887DppYUkWFDBunaHkkhHOwltjI9mcMuN64iwLJiBj64s1a/yXtll
 vBke1eOPNTr/6U+aSblfs4vXjws2CfOWJhwuWIgGuPLCweoF0Gx/L8ZnfYRWV1S9p551
 z3+Ik2EeBOgv+W6MjxaYR2IiNbD3IaLtBdlavJoSt6SK4IQ4pHurQNeGkqp6P3g4QPJ5
 DgITc5/2GsGZn+XhNmm1WxPz1rMl7BVa5ytMLKJs/9I/XedW6wRkpaJd6fbBvX3aMIpi
 Rno4cHVqboukw8AxnOdwyAn1S73QclkecWpsYbaaGa8qMl7umMWp0ZZchGR3+aO0DRDv
 +5AA==
X-Gm-Message-State: AOJu0YxarDOm5GY7MK/Gds7eY77CuCBVCMihblBNVWaJfztGSyV2B7Tx
 igc2igGtkjU/YyVaWDJa2DcwTyzG+uhtkUAn7bHzs8w+cXRYePKSV4U5lsvBdFZ0FsqTwQOzlVh
 ydncTGbkVhwvgF4C7u98gvYk5Sr0BN1A9JtXfU82PCTJQehVoTLrx
X-Gm-Gg: ASbGncsRvBPS3eQuuFJXAZu7AnxJFFnbLLsnvpQ3y9rFY86PmaD6NOKcdoTzTIsiM9c
 MjDA2aHQv1E+M2MHknkfS2pSDv7KHpqtJF7ohx12p77xfJ7Id439Lv3o0ZLX3frtJ/Twq1DCk+T
 rqowxvA1sRDb4wZtO9Wk/XntcllaknEBDttD9/i1Oqmc5qXbbrEQWvku3nGCfivBl6IycPWfOWU
 3m9EUr4WdT5qXlsJUI=
X-Google-Smtp-Source: AGHT+IF+LlQUFaveOjoziIxx+9Obr/gWijZcdQ4YaFcVLItfmKqUT5Eigv9Ew5lLg1F0kDYGFeSqMKYPvQXGpJF1ej4=
X-Received: by 2002:a05:690c:2e05:b0:71a:4550:8ac3 with SMTP id
 00721157ae682-71a4665e036mr127837897b3.22.1754062372691; Fri, 01 Aug 2025
 08:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-18-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 16:32:41 +0100
X-Gm-Features: Ac12FXyjNgiKswkmSeg9HKj9b4YL2pVHJY3g5EBKVHi-Da4FMFWg0QjwPWggHFE
Message-ID: <CAFEAcA8JhbZD+fhM-resgwzfFNyKfyA7jKFeGa=6zg7JxXJzkg@mail.gmail.com>
Subject: Re: [PATCH 17/89] linux-user/hppa: Create get_elf_platform
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 30 Jul 2025 at 01:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move the string literal to a new function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c      |  2 +-
>  linux-user/hppa/elfload.c | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

