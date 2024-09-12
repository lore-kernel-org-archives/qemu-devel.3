Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53701EEB59D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 12:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soirx-0002pN-EN; Thu, 12 Sep 2024 08:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soiru-0002oZ-CM
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 08:24:14 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soirq-0007aC-RU
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 08:24:13 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-374cacf18b1so656583f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 05:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726143847; x=1726748647; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6wyRHVhxtcRH9lI1hIIWLnLmUXTRghP4aR+V0jfmXMU=;
 b=uYJel1K5PylCJ01nP9lVDI13hPWXb4L1zIFI9Pjy19auySygsT05pnZkROl7Do69eI
 N5tATtK/ttF+AP9emmeaif3xskr75ip8d6oSn7v4Y/Ffb4OxVU59IZQIvpp7fYCIiBJ/
 F0syF+Z7qkv7uH3F9yW+EfMki+rmNe5aO7wfgt4VIHDde0tqCqw7SBwJRv5njxDuOcBW
 xdy+f2uqvO2VK0fvH2HTbuT/BqV9YUWqaWsvJ/6ydn+RpYV0H+l/+kpUfY9itGe3fF5W
 fXZf66iLfVZmXb+BypLNT7FnmH8clamabrl3ZaGEJBy+mp0w0Gwhny0TRLAZVU0ixKMB
 zDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726143847; x=1726748647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6wyRHVhxtcRH9lI1hIIWLnLmUXTRghP4aR+V0jfmXMU=;
 b=RHz78zgheGfZdlPhe4haboWMeehKMrQqpqtZeTqvu7QCiXzNv9oG8a/mGps0hooWi9
 F+u0AD2MxG9Jkp7Tj4k5kqAie21PgSdqp34uzu7MgfM3CYFHblgz9nKPJkJBIhe5LPUl
 mRVr+ZfP0pfqvXlAbWoywalAYpBiSxlerVEWSJ3vS2kwi4qGFrHkKcbI8mhnp2E0zH/U
 JvMDFvlphTVvM2ubL+4wmhIz6XlKgvMdia0h6ktH4hBwD0lbnCSXrxs9mkoWATg9ujHi
 Q2Bvm34tFOAW20Gr9vkEnlkymRMYY3FfPv44dEBaCtPR1pCajd9PfppGwFPFiHwb8EB1
 5Nxg==
X-Gm-Message-State: AOJu0YwiSmoJjwPlZU6e9yLulCY2Fz58y3+LdqNRK6SdQkcHll0+kYKb
 LBDJCa+X4C3Y2hbe2LLQqDBR99FHWNSXcR7XJJdlSBMp/dylvP5xohHXf7G7wQehu5KGhWBMDp8
 DxJ6q4fZHcq6qz79C0LWoO/BycgKNx4O+1pkZGA==
X-Google-Smtp-Source: AGHT+IEsIi74XZV72x3sJPZPhYyIN1xvrZm8lFhwysRlXwMZ2anjtX0YuHo3+/maeYoBMhZefnfm15Z4Y/JX1yTNlbY=
X-Received: by 2002:a5d:4983:0:b0:368:7f4f:9ead with SMTP id
 ffacd0b85a97d-378c2cd546fmr1517198f8f.7.1726143847166; Thu, 12 Sep 2024
 05:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240906181645.40359-1-francisco.iglesias@amd.com>
In-Reply-To: <20240906181645.40359-1-francisco.iglesias@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2024 13:23:52 +0100
Message-ID: <CAFEAcA_1vD5D=jvY2AZJioU8VAJ=zJkdF20XyY-gFuifBY6_ng@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] CAN & Xilinx OSPI maintainer updates
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, pisa@cmp.felk.cvut.cz
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

On Fri, 6 Sept 2024 at 19:16, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> Hi all,
>
> I'm not in possesion of Vikram's new email address at his new job, because of
> this the first patch in the series suggest's to remove Vikram as maintainer for
> the Xilinx CAN models and also the CAN bus subsystem. The second patch in the
> series updates my email address to the amd.com one on the Xilinx Versal
> OSPI maintaintership section. In the third I volunteer to replace Vikram as
> maintainer for the CAN bus subsystem.
>
> Best regards,
> Francisco
>
> Francisco Iglesias (3):
>   MAINTAINERS: Remove Vikram Garhwal as maintainer
>   MAINTAINERS: Update Xilinx Versal OSPI maintainer's email address
>   MAINTAINERS: Add my-self as CAN maintainer



Applied to target-arm.next, thanks.

-- PMM

