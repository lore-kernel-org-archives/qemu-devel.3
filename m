Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DBFD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQAas-0004iI-9O; Mon, 01 Dec 2025 15:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAao-0004fX-30
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:33:54 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAam-0003vI-LM
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:33:53 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-640f88b873bso3946224d50.3
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 12:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764621231; x=1765226031; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ybi93G2jJxIpjaemLfP4mWVNGkca3WnmJj8LpP1w960=;
 b=zIe+n5KON41LDCgtUB/5TO7w8A40vmcRYVpRwxGb5CYLwYHafJvslk7/31MRfdmwLZ
 OTWnkaK+o0CZX+uaMdlm1g91/xyoxZaftfKhsP+JNoW/6UN6krgBnkonSinmu2YU+J2j
 odW/BJIYLZ43qcRauPEG+hyj39DI7H+k/e4XFJfIfo36FWFh/j2KF1M+vH7hnyZoJm/k
 Gw20JtDvgVL37y3w+QHmJdTpXWOgXuUcg7nhHa/8m0k97RQ++e1KQwmKLyhITvbP6cNz
 Tko3eMLdEGTj1CSoIQcp87NDWfggWljgAkkzNDII24190V3pppzH4TQwv/WYBWh+Lrny
 noLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764621231; x=1765226031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybi93G2jJxIpjaemLfP4mWVNGkca3WnmJj8LpP1w960=;
 b=gHWhofa+l/sNkwubn+s67JdQ5B97IUJtUUxeM1niB55eauzfE0pQNSmB7FNWqvqkXq
 pgj04Orm2rb+bHJLFCt3yU+Trr4HrdhvoFKaXbe8DyDjextKlYzAcYZE3vWlMfUHWx+U
 iBPV3PeKai+0WNeyRUleefe4/ewiD10Ux5G2/6AJrahj+bVE9v2OgVtcF2bqHZYGD+ai
 4uPTAo7WQfv+FUiFuNcc++ZJED5KkKGjNFvVSneZnRuB7joUBkpPB0JMyZjmPy2DKEda
 zIjcjj3v4fbdBcXmac+2hmN1fYNJwThFby8bGDy7N5yE+zryzEbLroBxLgcvg0sJW+i9
 TG9w==
X-Gm-Message-State: AOJu0Yw/+5wxw4Ke4rrKjNsCbTun1hJcwpVDa2HIpOd2D0/WrR1f3BZR
 o0QYWxgSuEAmq+7jchva84O1VeVYw9r/YClbrqNvBRggDxWeNyI9ziL4qKYFiHYeOH4GrSMKfcs
 ow3Ou4oH5yV7PgzQhahU8SnUHtkNJa3LHHwHcLlskEA==
X-Gm-Gg: ASbGncsTn7dJ0JMrSDQyxsbMg/eBzfJGBq8k1nvcrIPVvmFjsmMhnwn9ThdEVnjtbog
 srxDiyW4Rs73On/izQ/ng4PksgziggpyvU0epuHMrSxSE2u3O7XrAPvmiNT5DLP9jGwhHM6UM/Z
 36Vio/tTftIRzQ6a8wA2uex0V+byQmG0vN2Eb9WRKVGRT3WJjHGa7ybN0yVRa8KUEaZb2s5SkSn
 L6b9Y7/+tnmpET1VaPhR/qqUULXGAIAyPBopzQGe4BCXnIJLmBpNYGXw44ShTdx5K/RiY2AhGxT
 1azOw2I=
X-Google-Smtp-Source: AGHT+IEUoqiHlgTEG4igNobz89k2CUrTA1cqs4y9VYS73lL2HWD360AlrUu4O8Vn2UrEtuYRBts768LRRXxfycvdclM=
X-Received: by 2002:a53:85c9:0:b0:641:f5bc:698f with SMTP id
 956f58d0204a3-64302b1f506mr22475887d50.75.1764621231472; Mon, 01 Dec 2025
 12:33:51 -0800 (PST)
MIME-Version: 1.0
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-12-gaurav.sharma_7@nxp.com>
In-Reply-To: <20251119130027.3312971-12-gaurav.sharma_7@nxp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Dec 2025 20:33:40 +0000
X-Gm-Features: AWmQ_bkO6uSaua1WowDDoCjB7wiWk-300lWOqnuz0oLSjvHzTEdapLnf5iVD5Jc
Message-ID: <CAFEAcA89p0hGtH3bXeQfeqH+EoqkJ+9bdT63hdEbwQVwsnCTGA@mail.gmail.com>
Subject: Re: [PATCHv3 11/13] hw/arm/fsl-imx8mm: Adding support for ENET
 ethernet controller
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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
> It enables emulation of ENET ethernet controller in iMX8MM
> Enables testing and debugging of network dependent drivers
> Added ENET MAC IRQ lines
>
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

