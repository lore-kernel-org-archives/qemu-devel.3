Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DFDC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 15:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhrVx-0006fN-U6; Fri, 01 Aug 2025 11:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhr9Z-0002Lg-9b
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:54:48 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhr9X-0007bQ-RK
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:54:36 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-71b4677044bso24471877b3.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754060074; x=1754664874; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=coyH6pbxQ2ylBgyRwMKrYeEVK6lHa9ImQ/I6rTKQCl4=;
 b=kXZKzw5XcIjmrtAiaDQIahnYA8FvpNhhcKnp3DrOuNCTOXbOsr5DVpCZNh9gdNSp1v
 HHit3GQdA0mSbQRMYs7a2ECJ6/FY5yoRQqbh1Ma5n1h72Tf2dFQ/FVUabUky583WBFHd
 yfireUE1dQYl1T2dLnVlZWN+d+/H4orNHbb30j5GAaDRIh+MPmTGQnhQRpNBTx4e1uy+
 ozbNJcg2e1p2MEozeAeKWA2BgAby/F1bIzJ/sRrUilC5QsEBmLlGYhZqsC6CF9Fzo/SB
 bHiaVfGxoJqwrogd3Y+EZ9Z+cE/LiJpT1UUdV+6hhcPsUmIqPUzb/JmUB6L6WqG6HER/
 inoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754060074; x=1754664874;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=coyH6pbxQ2ylBgyRwMKrYeEVK6lHa9ImQ/I6rTKQCl4=;
 b=kjSFLr05RhKPhwfYfeO+uS8nKft3m1JhpW7lL2eX3P1mY26msrZnLUXH4jQhlgbO2G
 A8ehHVGb5pbD22Rd0WrOZ9puKDfynhGOU5E/0vAUdwkhfAgihLnm5+D8/lSQ22smtJH6
 0qgFIM+jB5ppx/qEZN3L5zx1bBbKxq1phamGCTfFBDWlFWb9Wk0PRQsop+giH7xSDyFT
 1do1OH+Q2HMzb9TpYg8cb0AEN54l5vapvy86ZKChLACdR7xdgICbFfIMZZ1YlhOCnvcd
 rEDTKIyDOCR9QNwB4cATQpKwNWvXj1D7Fzux/l7MKlJ4xuTm0Sus5re5YlyxyhKjUSzg
 qcQg==
X-Gm-Message-State: AOJu0YyMCwppTE1KrS03OShXAwa4KmV90D4t5gkEm81dZR7vQxqu6YJt
 ICqHSU2DoSOfv1ovF0RM2to05uwgCGL3EfnyiYHGG5DGQtrez7A05RQkh0v4bd5pcceDAnAUNHJ
 ffPcD3bHSHNK8XTDZBrX9/LW/PwX+GBJ8ccmeRPxNQw==
X-Gm-Gg: ASbGncsXodG/76bClWtb7g11WsnJ9f1xtwcGafQP2oFsdlrmPxooqDHXe5QB3lVIVTQ
 RKgJ/DE2cuWGCvwq4ESzNpUnRo/IAO8zSjz2fTs/J150k37e2yBpDpPPYYwE8PZJSUFZevR6vR/
 ZovZYOL2RYvlCJEolcmxoloD6GfsVK4a1d1G+430INxF6/hxT/6MJ3RTvLP4LjKgJQqhJgU6hxz
 x4vOts7
X-Google-Smtp-Source: AGHT+IHS+RF5xtv3J6KL91UHMLLBizRuig82hnYqt1jL7auby23xMlvy6j/ELnqzYA+DYk7u0WjFiDEaK1Ck2fwKNS0=
X-Received: by 2002:a05:690c:23c1:b0:70f:87c5:5270 with SMTP id
 00721157ae682-71a4665c892mr153567887b3.19.1754060074463; Fri, 01 Aug 2025
 07:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-6-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 15:54:21 +0100
X-Gm-Features: Ac12FXzWDvw2laVLh5QHRvB4014BT4Tk0ieM_bL-LCZzr-AETN2VisDP9AzGME8
Message-ID: <CAFEAcA-+SEyRCB71UJ+85kAPGeuBBbCSbvC4D1UT9P03iFXj_g@mail.gmail.com>
Subject: Re: [PATCH 05/89] linux-user: Move hwcap functions to ppc/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Wed, 30 Jul 2025 at 01:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Change the return type to abi_ulong, and pass in the cpu.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

