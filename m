Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA41FC87FCF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 09:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEwA-0008G5-93; Fri, 25 Jul 2025 05:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufEvz-0007zL-V7
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:41:49 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufEvx-0006Of-4Y
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:41:46 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e8d7ad77e4cso1542171276.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753436504; x=1754041304; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t/X0zMlCDAT7v/LtDcwSLg38D8Mdzkgsr5SMpu5YQBs=;
 b=K5Fg+rtRPTVSEm9j8B+FZPhothqXcsvu5ek/48gFGq4lACQN58Jp3Vr0PjlJlLitIz
 pkvNIr3V6MswhM6d90RhdSl6JjwtoelBEsPM1XGl2Ao5bTS1yXe2ZVYG2FKUP4t8srVW
 LYbijLGdemlrShpBGl1nQcisQDIvv9maJlA8qGLpTLtrVFwfH9pp4WnQvfec04JctbMQ
 DmFN/cmWAYk47e6X2NxxVcr1SYhcciFm/3PFMYdMr/wQP9IIdCEjXGlkyNSDW6DOIv8e
 /ZfsNRFfSntZh+4dmBtmgkR4oQRPsPDBsABizmLkDVioSjVGemnqMU8iaogYh9W21JVH
 eNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753436504; x=1754041304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t/X0zMlCDAT7v/LtDcwSLg38D8Mdzkgsr5SMpu5YQBs=;
 b=TxxHxQADyT7lPyUmRX6BAL1xnUssJfy8aJBpUn2k1WGxRegKWwjqHWAsAa3rf9BI8i
 NWPXazdPYpcdcIcPOU7nXxRCLzEI9IJ4Bq6DJQKJg/dJRZ/Jv845DIl21S2KgR56QW7z
 DgEWYW8mOsD5F1p7m/GE6Pi87CbSf2JFFwem4ymqxbGBoDdtQmd4E5BFFPVtDj70SJ4h
 wYjBXSTuPQYWYcF0A8zrHI4lHRWo3QIA3v0Sxpz8QM69UZA+1/kxaP20cAoWnyWNCiRt
 7St1TxA60W+rDkzFbjM/gn/LhzOTruZ3APaf/zCOtEhXgRMnXIxgN+Fj9x94kAQLAXVb
 cjkQ==
X-Gm-Message-State: AOJu0YxMBaylDBb6YqjubJr+m8c8RMMAKgAUDq/q2euo0W9H2/N+7WMX
 Z+kQnb+F16Qy+Iyf1R/cHxcEZEPlVc04k4toHyzt2ms/1WyvaWQHMPk1LmV/dt7cpdoWogasfMk
 Y0kd3Eet/+U0rDN16N3E41LG1hqsLvKIRWbAtXlvb+A==
X-Gm-Gg: ASbGncsHDkdwOq562PC5vTngAL7Rm7mOcHd1pSYI7j31iQIEe6HBxP8Ug48Zl5x3sYF
 WLhzmbehRne1a68yf8P8wEIPqvH+A8Dzn/g+wP6syxu4uu+tp2gv9p53m0rC9W1bhumhDXEPw4c
 aPTPq4VOusGWYC35a7RPY4AWUFGlAqZlZa2CiNgkGVfbeBTnypQ1Pq6oQqg8yFUs3qrjqU01au9
 Dp6DYbD
X-Google-Smtp-Source: AGHT+IFi/6HpTwevulilYzkC9MtcWn6bv4XEayflcv4zhFHtdQW5nHCmVBNqsHfhBahvP3Ln5P4FDhpqCVIUY4PVmhg=
X-Received: by 2002:a05:6902:228c:b0:e8b:9340:aa13 with SMTP id
 3f1490d57ef6-e8df1018055mr1180641276.0.1753436503798; Fri, 25 Jul 2025
 02:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250721152902.38671-1-mohamed@unpredictable.fr>
 <20250721152902.38671-3-mohamed@unpredictable.fr>
In-Reply-To: <20250721152902.38671-3-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jul 2025 10:41:31 +0100
X-Gm-Features: Ac12FXy-LO3CFVKq_T43PrimfDcvryg8fkcNZ17pQpdgAnV0XmKKzkNCWlSs9x8
Message-ID: <CAFEAcA8ngZzx8hk30YO6Si9cp8UMWSiZ-tZYfpuvfYLQG5Nkrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm: hvf: stubbing reads to LORC_EL1
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Mon, 21 Jul 2025 at 16:29, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Linux zeroes LORC_EL1 on boot at EL2, without further interaction with FEAT_LOR afterwards.
>
> Stub out LORC_EL1 accesses as FEAT_LOR is a mandatory extension on Armv8.1+.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  target/arm/hvf/hvf.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to target-arm.next, thanks (since it's a bugfix
even if it happens not to be triggered by Linux in normal
booting-into-EL1 config).

-- PMM

