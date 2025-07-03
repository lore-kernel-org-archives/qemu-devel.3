Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CBBC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGxG-0001hL-Tr; Thu, 03 Jul 2025 06:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGxE-0001go-RF
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:14:08 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGxD-0001BF-8t
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:14:08 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-712be7e034cso52474477b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751537646; x=1752142446; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v7zgT7zWQFgD1S/phkNHSfwCZgO8xUk5WSC3Vjo8mc8=;
 b=yvTwmHcyPd3lSujEcMASqHgq5NnKISOL6NywFcAzGhLQS4L5T2YuddQVietZeqTGAv
 ilLNAVBTbHKwHev+Bvq20foqyIyMQIz9bvpB6COnlH+yU2qN1nNM19pfns8QoP894fPV
 cRqMtAYu3qwweZUrqIcFmPbDjEu8WElqGVvEuFdc4XiqBC+WLUcR8Foy2DgCuA0mIc7K
 JLVg17vHHWYu+e0CXi4KkY6aU4iHf8zZVw95/9JTA+t14BG4MLW6Jx8kdLIp4VAZjEWe
 6DuwKpMY+sghE+1utXiiFb2fjCdgwbpF/GiJYkJ0XFEbUSUEy4Bng8yEIqfjUG5ZSVfv
 OB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751537646; x=1752142446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v7zgT7zWQFgD1S/phkNHSfwCZgO8xUk5WSC3Vjo8mc8=;
 b=nx+e9VBWcutm7lN9/W2atkzlwDW+I4PLM6ppx/f3xnOiuuuyF8zjjPgawC/V+XhKX5
 bTR0I/Kl1j05dmmeGS1hLwAxO0i18F5ZBi+qHeKwgchQc07f/aAqPSPzGz3rLp1xxirF
 w+GTZjHtk+3l9+i6zzx+OrWoQXvSd0KcLIfjklwmsTpfF3ZGSKZArxPCX/ah5yckuWZ7
 WpRyRmgd4YTTLXt1Q1IqGHneiN5Sz0jnJGN3dVHLXJGPU/Xd9dSkncduq909gdYUDu1P
 WFzY1UDpKPik0t9czn0nR+IJcWPMqkxJyinijZYFFoUE6F6wtcfi1e20MfXCIVVolYa0
 cJmg==
X-Gm-Message-State: AOJu0YyLfCmHX3D8WDV7naPEoOzDfN536tQ6M2JCKsBqM7iUx8kYqHG7
 A+8rbKT7E4CEPtR+sflnffimKQu/VecFbXKrYn5ln46nOArvVQvBb7g9I2QlVO8wtY/22uFJYrq
 McBsOlr16dDV6otqJ4Jipw+c3s3U5rMPGsGATlUCncJf6ZcGtOzZy
X-Gm-Gg: ASbGnct1ZlIi6m+MqG8WdCUyuPbsQmGQPA8OWJIfdzkIS3KiTIVrvYBoaWb8phIXtjr
 qNYBPqZS5K5RGqQpHJLbVuru7NhFB/vmSCH/yrUQrgbxAO6dfMXCENxPlwD9HUw4YL7lP6Ul3Q3
 7Edp5jDoTXCQtTn2JT2FXSWnTG1sYtXxRnNix4ESPV2qsG
X-Google-Smtp-Source: AGHT+IH4y4pZtiGWIFekUSSds5qXM4l2d26JHmrhl4+eHeY/yWT9qd9nF3CeamQ9WO3kccK6JbTqXBflNpZ3p2u4JKM=
X-Received: by 2002:a05:690c:6701:b0:70e:326:6ae8 with SMTP id
 00721157ae682-71658fdaec4mr43745087b3.2.1751537645647; Thu, 03 Jul 2025
 03:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-43-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-43-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:13:54 +0100
X-Gm-Features: Ac12FXwFPdVV1Bo-tG4n5589gaATktQGY7wNc7S837qdCOOZAcW6sqZmohslpZ0
Message-ID: <CAFEAcA_vgH68Cakob9UQXyKGangfRb-a3XjO0Ju1mcbo1WDJ8A@mail.gmail.com>
Subject: Re: [PATCH v3 42/97] target/arm: Implement SME2 BFCVT, BFCVTN, FCVT,
 FCVTN
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme.h    |  5 +++
>  target/arm/tcg/vec_internal.h  |  2 +
>  target/arm/tcg/sme_helper.c    | 74 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/sve_helper.c    |  2 +-
>  target/arm/tcg/translate-sme.c | 25 ++++++++++++
>  target/arm/tcg/sme.decode      | 12 ++++++
>  6 files changed, 119 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

