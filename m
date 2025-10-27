Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1274CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOBt-0000gh-1G; Mon, 27 Oct 2025 10:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDOBr-0000gG-Jv
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:27:19 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDOBk-00066C-AE
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:27:18 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7832691f86cso63630307b3.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761575226; x=1762180026; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zf91pYLZaUX8DgiYE445SqEFPpnFH6vYddWHbKANyQM=;
 b=F3igkDk8Q3LBAcg/k62YUZj1cn5lxpbfK6ztlzTcO7oi87w/sygSf46YY0R96qJjiI
 OhQgNtaQUGDJG8oBWRo6/dP8s/H3XmdaQqLKeq5fwcwL9nmq5+P1xSWKYlew6muGsbBl
 92dHYAufAIkMJJOgSlDE21zf60D3crqm9vm5fwu84Dn9qlLOWvQrM1Vd2GnW+MuZPopU
 kiQsyaJlWZgZXWyLeTZAUgOM4V0ekTou5UF8JLYeQKQ0TLsKKZZsV5q8ioH32HGGg+Bs
 d+eYwyW/KUBiFxEQfz85cwdQjyXF2vdaXa6afql7Ox5WjL6F3/ccO4IfoAqlRENu8Ei5
 OIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761575226; x=1762180026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zf91pYLZaUX8DgiYE445SqEFPpnFH6vYddWHbKANyQM=;
 b=mglHYg3/6izEKo+fyBXJOpgGXk4ZLMLJXQXJq5jbtPsgYMJFqXNkBIflrpgxrRQJD9
 Gp1WLIJEBzhdEPEczuIxECbD9v+Pj5vkFUzcZlLcrKljP8CoVjJfZywCZ1W/02QyBK8A
 nfY9nVdJ6NmayD+LEV+8cCN0dV0vs3HOl1GTTdASn9DbDrwvrSm59ii417yzuihDgmRt
 lsQIGtOub5cXmVOkosE8RXiTnSkUBe+iyAfOP34vwZ8guqPPRyIAUTODbQ7vTrwgXKVQ
 QQifHxzwmxSXG8Phd1eYduFOhkhr8C5q1cpxPQphNDtfs6yJe2mCU4qjH2LLCehK1ARg
 051Q==
X-Gm-Message-State: AOJu0YzOFPHpvDjtEZ/20I7b9uG0DMvH5lG9HZVlTOZYbLLIK85seEVx
 pDCMPpdC4lArGGJAU5PTtqSXoNSp8KYFhOmmTpJ30N5wVfIswgU/h4ixNYVfED8AdeXExEX2nLm
 cXOZgBG4u3Pgg2qv5X4QIcywvlnItH01wR7zmN0RHn2xKSH9MbUl8
X-Gm-Gg: ASbGncswOfO2Gd0ZRptsMB8Jk0e0OW5Mgrv3AGTtoXdlA1RAtQBLdDWR8ZQmBxXftfH
 pDSh62XZ+HMv2IYRG8wktAo3eJq/FCKY2WZ9+8iYTVdERFlEhNOqwQg/G9CekEgkaoxsNtCFSxP
 TCu2BFdHRoEX5J47PtCdzr/G0LgWcNcwQQ82/87mygg1vQ64OkteZ+OHP6rGJAd2GwD9juy2Ovh
 X30s6CeMoGCWD0hiImvyKELUd2qIBnZtBNilTP22g4tHF+WNKrwUAneXehE+w==
X-Google-Smtp-Source: AGHT+IHqI8KerS+RChahoTa4cwcBgeIZf8x26yXTb6o8EueI3mUL0Mb3PNt0z7s4K3QXRLFYx5mzSkCI2AiKQvcDPp8=
X-Received: by 2002:a05:690c:4441:b0:784:8ed9:e378 with SMTP id
 00721157ae682-785e0224408mr98948717b3.50.1761575226206; Mon, 27 Oct 2025
 07:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20251026105320.5591-1-fanyihao@rt-thread.org>
 <20251026105320.5591-2-fanyihao@rt-thread.org>
In-Reply-To: <20251026105320.5591-2-fanyihao@rt-thread.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 14:26:53 +0000
X-Gm-Features: AWmQ_bmIirx8J1oJhh4zjkt4OAYVnHZXhST6gUY_FsWPpi3gildDHhYqD0hzm9c
Message-ID: <CAFEAcA9ztaqc+Rhehgx-K_ByePDPpaPWObkt8Bs6o4xGY2aZ3w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/arm: Add support for the STM32F407 SoC|
To: fanyihao@rt-thread.org
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Sun, 26 Oct 2025 at 10:53, <fanyihao@rt-thread.org> wrote:
>
> From: Yihao Fan <fanyihao@rt-thread.org>
>
> This patch introduces a new QEMU machine type for the STM32F407 SoC featuring a Cortex-M4 core.
> This will be used by the RT-Spark to create a machine.
> Furthermore, I have updated the reusable USART, timer,
> and RCC drivers to align with the existing driver implementations.
>
> Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>

> +
> +    /* Timer 2 to 5 contoller */

"controller"

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

