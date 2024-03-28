Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C270CD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprBH-0000ig-2d; Thu, 28 Mar 2024 10:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rprBF-0000c6-0Q
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:56:37 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rprBD-0007Nf-ID
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:56:36 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56c1a65275bso590779a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711637794; x=1712242594; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HBHpgXdLbvJDJait0Xg2FzYJIp/klWMuNnFTbCAHHjM=;
 b=x61ByZJSLDPkZjxCXsx+ecOvHP6wPRYwmnrpg4cWOXqXHBO/kP7uxIgk5p40BaRuSE
 656j7uQaVXRud3BPdfZWMV3o8XoHAZTl0NAP/AbYxM33XE2RsstdUv5R+g/f8sPh3+fH
 YFgo+ia32CM5vofzTrHuq4ITbAgevDHftEKVPPcSnjEyX2kpzRjc2o1OJWPzVFsrBHOA
 yp1F/RLBik+D7bCL2MK6tXwILZiYc7Ot2JRTJvsSf9z4HNy9GpRejsHrkaZnu8xvFOUq
 IkNoLSzLr3k+k2f1Jhp8CT10JfL4uDUEO9QKjPHIwH49OBpIfc+mNUrKt+P1g5piCGU+
 DiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711637794; x=1712242594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HBHpgXdLbvJDJait0Xg2FzYJIp/klWMuNnFTbCAHHjM=;
 b=w+F9K9pDxN01Xcajjesd/RLszz4YyL9OVNIGYzxHfciyuBlMMS7uEpkhZk5JLSByoF
 pE+/696dOiu+4wS5FwbE87EjqQl/c5DifhP6Pyu8T4RXqiEVfmkE1m+tpUNQ/D4tH7a6
 yH3arSIum2AY5J/IB8Lj5/ttAQWJ/AytXXs3DAim095KlJpwJWupbSwQb9+H5+Rl3i5M
 Tm0R04ZLZPSaBTvtSvRsd9hSXJAie0w0I5id3Gciu30tNJRGtg+T7+DTElt70MOOWPhA
 bIGW05PICWTAomKokxLraT8jbChkzOC4fBqOyREk2aYFV6BQHGtLofOw86pqCfpP7DXx
 WQCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/JGawZHiSPgsxbXkfmvmv91RSDHbDl4B8baJyJlw6tbDVMiZ5aF5ZXyMVlE7kMf/6WiNOk+hbh6mHm89Ul2Oo7ztzNR4=
X-Gm-Message-State: AOJu0Ywcct5rIq7fRFarJU0TebolHpaphhNdtIxdgMs8e0eSbf7CsRfl
 fvmtDXkog9CeRU+OLuRMNr55lxtoq/py3TB9uK4uDVSTZVMvM3rlG+tOCwl2vP6vTgINKfYDUx9
 e8v/szLm7DllJFr7ii7j7Btzjywp5IzkzEJTY/g==
X-Google-Smtp-Source: AGHT+IFmxZ9QKN14Sqve0vwoZnoHlgLHLjk2UjZb2B7NB3pb89GgmLEhpoeKPVZgYcIgMcvNIMmUrZW7l+hzhR/AutY=
X-Received: by 2002:a50:d6d0:0:b0:565:bb25:bb7b with SMTP id
 l16-20020a50d6d0000000b00565bb25bb7bmr3190440edj.6.1711637793925; Thu, 28 Mar
 2024 07:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240325084854.3010562-1-ruanjinjie@huawei.com>
 <20240325084854.3010562-16-ruanjinjie@huawei.com>
In-Reply-To: <20240325084854.3010562-16-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Mar 2024 14:56:23 +0000
Message-ID: <CAFEAcA9OTf9eOXpJFPANsC9kNdXUuo=WPkdP1ipJvTV6rwRkAA@mail.gmail.com>
Subject: Re: [PATCH v10 15/23] hw/intc/arm_gicv3_redist: Implement GICR_INMIR0
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 25 Mar 2024 at 08:52, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Add GICR_INMIR0 register and support access GICR_INMIR0.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v10:
> - gicr_isuperprio -> gicr_inmir0.
> v6:
> - Add Reviewed-by.
> v4:
> - Make the GICR_INMIR0 implementation more clearer.
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

