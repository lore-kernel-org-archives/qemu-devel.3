Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB57C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 14:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXMpm-0004AX-Em; Tue, 06 Feb 2024 09:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXMph-00044w-8V
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:53:58 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXMpf-0000xy-M2
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:53:57 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5112d5ab492so7942342e87.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 06:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707231232; x=1707836032; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8x4futTWw4A4d6/viIwlKHb4D/ab0/ZFVnzEgOcE40E=;
 b=F0StHZDhMtptWV0oRKlLjwcakkbC1OHHbto3RD2CjpcMKZmp0Nzk3YhkFYUK2lkKny
 NhqyJdAQYqrY4HxtCdG5Fkf/JP6BN9yQ5mNVPR/Mqz23HMvJ9mvh0PudWl6LnweaM/lo
 k66IIcQidDqp1VZBa3bY7zbiMdC57COATRQqLq1oNe5XA6HQo0H51wT6Q8O2hNu6Ls79
 iehHOoSo/KgDc+OSzB6Kd6NTP4/TkmdwYZMmlK2DalQ9f+fB2eBKDe/MaRppVjCAzTI3
 UBdrrFOCA7fhWmpyXVMr+j2O1rqxBucnBfABE8UgIZH70noNZGgGJuvfgAYCMT7U5VJb
 WItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707231232; x=1707836032;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8x4futTWw4A4d6/viIwlKHb4D/ab0/ZFVnzEgOcE40E=;
 b=tjzSz3UgsVhIiFMx/lhbipxg6hrnv4JSHhmYWh6jos+ldlOv7qm5FSsS/FCOseL55e
 MASqcLjqqZcis78ESThhT132+a9jUt88gZchiwLQDwrsvNoZEZc2+YH6WaGST68YYqyT
 2klb1fmoRl6KLFFvjIiJqTKLSafe7haBlwxazMI8bZWmibnz7TJc4JF6vv/wNoLoBk9x
 2LiD9R2CjFTh0Ed2RZuVKzBSLThmnmM+NOMtbRUmnpeyXuhp72vO4M7bruocclWCUsc9
 JiQxuOXzyZgvzD4CdH0yTXszoY4uh0jx0j4SH+easiiT797bqkPg15pSUu9F3duZYG+V
 i8Eg==
X-Gm-Message-State: AOJu0YzRxr3tCqNyrm4HJMjUM/X4Qp5PYfmgsKTwnC6KgU+Tf0Zf6hWH
 XW5snAJAmy5/8eIJDQzBkkMCw34meewyly8isCOztS40eC7CkjdgTR4j7jWUn1mrQHLqhP5pDKh
 lhP5pBpyko38+hi6Gie8OglLnHA7suKVrRTvjfw==
X-Google-Smtp-Source: AGHT+IHllfTIr8fmU8UobH9C6NZ8Ex/T/nMb/edzS8g8BTjJRkEhcfoX4OxDYeYPz4nOkJcxc7vawRAQBSc69Xx8SxQ=
X-Received: by 2002:ac2:530c:0:b0:510:a34:5121 with SMTP id
 c12-20020ac2530c000000b005100a345121mr2058828lfh.52.1707231232014; Tue, 06
 Feb 2024 06:53:52 -0800 (PST)
MIME-Version: 1.0
References: <20240206030527.169147-1-richard.henderson@linaro.org>
 <20240206030527.169147-6-richard.henderson@linaro.org>
In-Reply-To: <20240206030527.169147-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2024 14:53:41 +0000
Message-ID: <CAFEAcA8bJdofftvnPdYdZcUOR=e8ToNGm8HZU5rRcEuKNEgWtA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] target/arm: Handle mte in do_ldrq, do_ldro
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, gustavo.romero@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 6 Feb 2024 at 03:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These functions "use the standard load helpers", but
> fail to clean_data_tbi or populate mtedesc.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

