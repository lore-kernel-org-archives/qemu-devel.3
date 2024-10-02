Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FBCCF31B4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 12:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svy8U-0002cW-6D; Wed, 02 Oct 2024 08:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svy8P-0002c1-Bc
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:07:13 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svy8G-0004EZ-FR
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:07:07 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8a7903cb7dso571485466b.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 05:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727870821; x=1728475621; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L3qYmUvOiOsGi4aszyqe9rzwIUR0RYnnGQCFOcsMzhQ=;
 b=l48dqKlSPEQWdG2SSnmOWx1N+oIqEDShkdF+X3yHlB8zB4cUIohlPDgadFnUF1P1Ib
 iQOuSMCYqk1Q7Ace9C3O5cGkIXHnSKMekbePFuU30lnGaX3U3UuX9AHyew3HWpjy5O9b
 f4klGLmv5XooDS9FM6aRlT02TijIsIFVnX7CXkvpMaEP/IesnlnylRrPVe7d/zDddI6d
 LWfP9LtF2X51wsTTP2hdRjuDivhcoFhQ5GVxWkeB3IwAnVOLnAs3aRTHv9gLdZhqtwtx
 BDAhwqRD/XXPcGWtSefcqcCPfY8Iutso3TISiAs4gTO3N7g4vNC7j2WH9Z6tTY/quAry
 jUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727870821; x=1728475621;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L3qYmUvOiOsGi4aszyqe9rzwIUR0RYnnGQCFOcsMzhQ=;
 b=Lj9qUPc9YKj3YsgIgh1dzaNO7lrrHQcFzk1BxBYW2xMWr5Bgdby6+D4rVfSUXYJutQ
 xac20brW95X4oWfYJt9HcajjBC4Gn3fKnX6w5jIZhUPU+J8BhnwqFaqJKzPLzsLlGN5V
 D4pNJu/hQgUVL+NZe5U3LDJ/962lx5tkGZOJ5DZpbOY0ktAEduSSj+qvJT3W+StxbACW
 juOi/2bOD8Xl7VPWU7PBMUipNQyyIJH+IgrkonPskU/dCm8aeAgYZ2EXCKKMpX9zCDVd
 /KqAA+gGWMpy3CZf9uyuHCKM76Q2O9WMQmjd2lt0IjIp/cHckKcAoTOWC+tJ+8A8RTXf
 Wq6Q==
X-Gm-Message-State: AOJu0Yx7BXib9L8IC6mB/n+AhztGZ+FJSjhM3b6oSPNkeccyobZri6wq
 YkbzeDCSjATOftzd8oyLBAI3ujkXrPxgK+24Aj6/qmZx/m3lnLPQIO008krVdHh7YJ9QWX/5ANf
 hpifIM2WaVtQvlq7nuB0+bbqQJYiiZnZaMs95SMh1jqyctmyS
X-Google-Smtp-Source: AGHT+IFuVitQddJMeVmh3n+6+7UjxR2zGFnHQUlCYtmwQH5/4bEItD2MqTdi9mI2DwRuvOR4VsLbJEz85uLQnyceNSw=
X-Received: by 2002:a05:6402:4405:b0:5c8:9f44:a0b2 with SMTP id
 4fb4d7f45d1cf-5c8b18b9d5cmr3458636a12.5.1727870821287; Wed, 02 Oct 2024
 05:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Oct 2024 13:06:49 +0100
Message-ID: <CAFEAcA_sMm8qRHc2cM1hw6XkOQX-jwVYQ5uo4gw4zxfeAFa+CA@mail.gmail.com>
Subject: Re: [PULL 00/54] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

On Tue, 1 Oct 2024 at 17:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This pullreq has a few miscellaneous fixes, plus the
> non-controversial (and largely reviewed) parts of my
> series removing deprecated arm boards. (The rest of that
> series I will send out a v2 for once this lands.)
>
> -- PMM
>
> The following changes since commit 718780d20470c66a3a36d036b29148d5809dc855:
>
>   Merge tag 'pull-nvme-20241001' of https://gitlab.com/birkelund/qemu into staging (2024-10-01 11:34:07 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20241001
>
> for you to fetch changes up to be025ce676d0f8fd094d17b34e87305a1c8fb595:
>
>   hw: Remove omap2 specific defines and enums (2024-10-01 16:08:02 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * MAINTAINERS: Update STM32L4x5 and B-L475E-IOT01A maintainers
>  * hw/arm/xlnx: Connect secondary CGEM IRQs
>  * m25p80: Add SFDP table for mt35xu01g flash
>  * target/arm: Avoid target_ulong for physical address lookups
>  * hw/ssi/xilinx_spips: Fix flash erase assert in dual parallel configuration
>  * hw: fix memory leak in IRQState allocation
>  * hw/sd/sdcard: Fix handling of disabled boot partitions
>  * arm: Remove deprecated board models
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

