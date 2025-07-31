Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93C0C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 19:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhYil-0000qZ-P0; Thu, 31 Jul 2025 15:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhWog-0007IU-W3
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 13:11:43 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhWod-0002no-SH
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 13:11:42 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e8ebd470b69so1304358276.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 10:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753981898; x=1754586698; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=437EfaWyAbws1fUTE8ezyQL7R2lax3qYd8TnsU763SA=;
 b=F+HmG3a9vsVIOyXYH28vXXiJxUHEU9L1+wz7eMALW+XpLSoPWDy1YoPElMdwQhjeLf
 AvAWWERS/0WbyFWQ53rgJQjUsuUG94irS/U8YfCsVXIZN4ZxheXv3xSZx14hxeeKdXVM
 /kh/m4jj6p6y5MUPPoFc37mr3UKnd5/Y3LZvKHG99AwgKBLl9o0623CnM7MMBIQ7tKs0
 HCScew90oxE8IBsZ9VkMFk34sUq2NybBOeFJqmXCwqEPmzW6cxeRBml6nstyo9pOt6NY
 RLXj/WXIIqds/SDAOX07zV33g60BW40+QmCdE8eKxi5yMByqRqciZ8u7Jh/AcJ9q+j27
 27OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753981898; x=1754586698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=437EfaWyAbws1fUTE8ezyQL7R2lax3qYd8TnsU763SA=;
 b=REQPb6tTmhrctVMsl9ivQtEpYcZxV1MDpDgAUzM31TccJAiJ6l0haJdDBd2WX+72kh
 LEGXC/f5p47wizqkkWhdxoS8R1QcPk++do36PWPb+9p1b03aXlj+DsMGRYBo7HzuL2/S
 AaZNuLY3zQsEPMhmSwsGzmX0+eXi61I/LACJO8OM6GMIFYU7n/fo5zPUYjMnNQugp0ei
 mcY4fWWbX3FRWTer0wFKDC5rvRDou1OGzIemuTiD1k7X2VZcwm/vafOfuaJevXJOC9p0
 AKYWQ/je+vO+KwhAt9NpQGp2GjQwq2kKIdTTSre5g5ljxYAUPkfpTeZSIwfmilqHix4d
 1GHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBTx3/rGFtoi+ywtMK+RlKDy/se+SzHuXyDIMUYHq1GlIBgxeYdNoDz0E4/JO+m/IjopqETndtTNDc@nongnu.org
X-Gm-Message-State: AOJu0YwHDifLd3yLUozSupVQvaZamGPRI/z5uIfXK1MVp5Mjm0JnY51b
 fz7A+Sts77SJ9hICEAIEhTPDTwc+w4MvxI+vCCqSSoVAJi5zbZx5FwkxeqPVuDhr2OFmswmDifB
 7v56Rjmb7PluFsQPFWH+ljYDURTkCnzzgIF4ie5oQPR5JYMIw2D9V
X-Gm-Gg: ASbGncvewY4sE3g2Dj9RPpZrpIw4zh5o7dkvGmbAPe+F+ZdxkHsCeEYLSl+Wpe4hD6v
 oMQZsNsAhHJZo+SIFt1ToLnp/M6krnWEUMeJn2vGrsYc07uhTc7A1iWfEUS5lfUzqN56dgfCRxf
 9SObmroX+yH5sTvLFCLnHNOtR7vkA2BVAlA1cu+zxA/78sxpx4VqPdSweEE5Hhs+ai8aJHuHNUd
 I8olhyz
X-Google-Smtp-Source: AGHT+IHaoyIgnDImdZj5451kF7XQGbW3EIfnRo8vHYw3SlJY8UcWyVte8JhrZ+emmvrNXOZvMMprn5DDS2GPPM2ppPA=
X-Received: by 2002:a05:690c:640d:b0:71a:251e:36ee with SMTP id
 00721157ae682-71a4696dc39mr105768417b3.39.1753981898059; Thu, 31 Jul 2025
 10:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250729161650.43758-1-zenghui.yu@linux.dev>
In-Reply-To: <20250729161650.43758-1-zenghui.yu@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jul 2025 18:11:26 +0100
X-Gm-Features: Ac12FXyCjxHGcxU3b0lInW5pSCJ6upqutpBN4ZWL-U213zkJ7YtcTibg5DA0wyg
Message-ID: <CAFEAcA-dRAViFBSvmYS+FSMKPhP_ej5Sv90n6+WLaR=jeQeiAg@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/intc/arm_gicv3_kvm: two small fixes about register
 accesses
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
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

On Tue, 29 Jul 2025 at 17:17, Zenghui Yu <zenghui.yu@linux.dev> wrote:
>
> Zenghui Yu (2):
>   hw/intc/arm_gicv3_kvm: Remove writes to ICPENDR registers
>   hw/intc/arm_gicv3_kvm: Write all 1's to clear enable/active
>
>  hw/intc/arm_gicv3_kvm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Did this cause any visible bugs, or did you just notice it
by code inspection ?

Applied to target-arm.next, thanks.

-- PMM

