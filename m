Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C365CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 11:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v11ee-0002wX-4y; Tue, 23 Sep 2025 07:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v11ec-0002vm-7E
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 07:57:54 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v11eO-0002mX-O2
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 07:57:53 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-eb36a143370so361712276.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 04:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758628655; x=1759233455; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lE1VipkmBOyg2BmcW4qHbG37DbI6ALa9SZaG3Rr9V/0=;
 b=NNbn/zZg9Guoheuyc0dItUXc+kLEnli4KEix+eOjUYjEEya8cEG1cV6dH73XyY8DpG
 +gRVnP/JtqLjhs7Nsofx2dZmkxAAy9cSJYmKp7ffcGffXCYN2w2x4IUiHFW6FpLgY1bL
 GlkL7YaSXFeFGTn/UYBOIa9v9Z/NG7YK/kNLOy/1lf3BbN/9CKlBsD7VmoZpOERDl87J
 4BxO26iPJysOxiqwCfDXA0NahuwckTo+qmzBxBFwdYhjLFkWPIhhbQPeUa1Hf6YRn/S6
 QyT1t/CMkSErWmjxpgzapoOvK2xingSTQVKQ1n0L9FRKQzArB8yfQCynAg6s2KQRVsF5
 zmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758628655; x=1759233455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lE1VipkmBOyg2BmcW4qHbG37DbI6ALa9SZaG3Rr9V/0=;
 b=AXO13JSKL+6sDOw2tU9vSzx22ecZ7bsMX10HN0tsB4e3R9k62XBanua6qnkrgQLYQI
 jrYsMXmLn4p6CAHe223emAWvKB4WgChGLDpofd+W9tUBOZ6Wytf8Mi0xPeNcVhxH+SIV
 zY6ZXwDF+rrYlbzKf/0O2pPcsH9Z7owc1j+bnzUPggcutA0emkBmDgR7VpbEWbNbLDJ/
 inGGI2HQU8t4DEPRBAn2lGzVWOGvpL9ZXJbFk8Oo2wbLml0p5yLuRWxlWxM5Fwj0c1De
 zEIm2Z41M6hXHfTixvGbjK1TDwSnfpDW0HS4+MVgNxig6wGjPPRQFRcE++cIh69Ffl1K
 5DRg==
X-Gm-Message-State: AOJu0Yx+ccCkUS9I+dykLQr29vathfVLOG3FcNuohyAGLFx+sNCjMJR8
 LRUWYHV5/PObv/pkt8t2big8PRZwCqE14LtT2rDYgsosh54mz+iEmHuf6KpFkB3KrsOBRljNS4r
 98kUSx9ZgiYgVRU/jWtKFBMZIgS8ENMJzx0UhArjPzQ==
X-Gm-Gg: ASbGncvY9vohn+Tw33vW1lWsp1FSHBMFSprOWIbshD8jwFYs3OpIdWSt1QIrbDT38hw
 50jkf9tNplCsbbLLV1ypHORezBUzToK9BAbLYEYv+sr5Rp1+Zbc8slq1AW1bMCgzV8m0bz5wVPU
 zci1sH7r3ExZwFL0ai8hAh2J7vxET737rkBgTP52UII3MBtITwzKlDFPm9QQYAUuli/2G2BjLaD
 0+e8z/D
X-Google-Smtp-Source: AGHT+IHgwNTG1nMcJLI0f4g3+Ir2/7TN6bv3rUYdFSFZiv/fdne1hTyr5rtaQMGOjElHhiOxe3Xz8eHH4jWtKs2Rnk8=
X-Received: by 2002:a05:690e:42d9:b0:624:1660:ba01 with SMTP id
 956f58d0204a3-63604664255mr1240395d50.37.1758628655350; Tue, 23 Sep 2025
 04:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250922065714.93081-1-nanliu@redhat.com>
In-Reply-To: <20250922065714.93081-1-nanliu@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Sep 2025 12:57:23 +0100
X-Gm-Features: AS18NWD2wPs_QM-nDffrbHZokflHieUXf1f57Z8WZ3c1n8pedX5SIBQtHNLk3G0
Message-ID: <CAFEAcA8pLFu6eOK5N+E97qo5PCp3OW3BRfYNSEL7=YQS6+eh2g@mail.gmail.com>
Subject: Re: [PATCH] docs/devel: Correct uefi-vars-x64 device name
To: nanliu <nanliu@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 22 Sept 2025 at 07:59, nanliu <nanliu@redhat.com> wrote:
>
> The documentation for UEFI variable storage in uefi-vars.rst
> incorrectly listed the device name as `uefi-vars-x86`.
>
> The correct device name as implemented in the source code is
> `uefi-vars-x64`.
>
> This commit updates the documentation to use the correct name,
> aligning it with the implementation.
>
> Signed-off-by: Nana Liu <nanliu@redhat.com>
> ---

We could probably also correct the bit of the text in this file
that currently reads "depend on SMM emulation on x64" to either
say "x86" or "x86_64". (Nowhere else in our docs calls
the 64-bit x86 platform "x64".)

thanks
-- PMM

