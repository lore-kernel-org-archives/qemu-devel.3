Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7D5D216A4
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 16:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRC8s-0003Q0-53; Thu, 04 Dec 2025 11:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRC8q-0003Ps-EZ
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 11:25:16 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRC8o-0005rT-ON
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 11:25:16 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b735b89501fso124805466b.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 08:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764865512; x=1765470312; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5jY8/y3Q/QpWKyCG1CjewxCidBT4Ey7AIFViQE2bGmU=;
 b=IaYNp13I+5qf7le8RddL1SPvASvauqlNzlLsMEnoKoegcV5IkNGMP1JQBi+bC2A/xi
 JqMN0XqbCEyznwHne6lPrTX/82c27PYEqwHgGER1PGGpfwi/AEQO/bJI0KOUdPUBNPaG
 JtIR9OckHZBbAstD/sJjAW8f+Sq+becYcwJT4kCtgEitfN17cbNxRYjoZPdHsYVFs5xI
 drPbNNgZq06OO4Fx04BZkG5N8RxbJPxW/ZrF/lneS7rw3rNabfnLcyqp44ZGqx3hHTDS
 ApdW7OOYiX+4AyRYkB9bLwo38mg6MS3o6EI97a6cpJgHY4EqD6UrnHGIvKQIMY2rHPFG
 xZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764865512; x=1765470312;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jY8/y3Q/QpWKyCG1CjewxCidBT4Ey7AIFViQE2bGmU=;
 b=cfl1Glfanyj6/89JZCsr8Mnjrouy125RmnQf/PIIDo6AEX5BesDBrOgZI81suq2Iu5
 jdcEAhjO6YjZ+e3DCJSaapwxnIm/KrgmA2MXQuVeNys8gCQhQeisQchzEthJ17cl7aOR
 xS3JrCimMlcGFymPPvwcop7WfjQIuM0xs/ruFQ9M1voNqRw1g0Ul8ZMoahNA9r7hqoFf
 LaP5RXuDbYjAfEjUhP5vNM/bN2LJjc6ml0hPf6avUTMtOBfdHdhxEs0+UMFF7mdxsn9+
 0IXuvMpmfc6c4wX9fmbh8YQf4JaaGV7A+8zYVIfSz99fDcRuMpIbQiVGHrgw0t0DyrV0
 EMkg==
X-Gm-Message-State: AOJu0YwSy1a5iPTYO8GOSHz2jdJsKlAP24+SwjPxwU1bxQVoUOa+9rRF
 xIWWMueYimhUDuPst2gextGGZ6QYHqauLN+tXTRQWMDosgcJUP+cyeHgjZ+h2Ri1AjVmtsT7BMi
 ankKWZDSLDHf6PmI2P1wpAujWPxeJgLmrKrMP9a+fkw==
X-Gm-Gg: ASbGncuPSbqEp2BMoLak3dTvzuJrngdNeKTHNoKkitdl/ZhwBHaKYP4Y29ObPtvGy90
 hT3/dNa9SMyYz9nq8Ex5S8CxFnazAncCTzIr9fySqP7I9e58GFEP/weckp9INKLRPJxnqEysuRW
 XeKkiaF54Gn+sAh12I6L4vXaWsIZGSCYC+TT9xXp8vDqzBK5Xsg4zZ9iGm4kqT1SzR+pEvqDlxy
 3WmTXJVhnc8G6kmY2Xq47gQMycQpkxJR8L9q2X75EErm+vwSMYZTJnUxmLSOpTbwoZDj64JOdj0
 hfI385UsOquS5g27Kd1Ht214
X-Google-Smtp-Source: AGHT+IFyZKgk86ZLdKIhYGuNM0ugJYXTF6P9JewCZPfcbAs7zaoGcxNMkEDgVq/XONJKwbP5mJMOQy1CctjfeRTm8tg=
X-Received: by 2002:a17:907:2d13:b0:b72:58b6:b263 with SMTP id
 a640c23a62f3a-b79ec6edd72mr389452066b.60.1764865512308; Thu, 04 Dec 2025
 08:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20251202120250.763150-1-jim.macarthur@linaro.org>
 <20251202120250.763150-3-jim.macarthur@linaro.org>
 <c2747a88-436d-41bf-8277-b1c10a1aafc5@linaro.org>
In-Reply-To: <c2747a88-436d-41bf-8277-b1c10a1aafc5@linaro.org>
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 4 Dec 2025 16:25:01 +0000
X-Gm-Features: AWmQ_bnpyHYJsNEWKt-wpC3ybez0P_ljw8uN6yAi8mHGCo4szQgurDdruvBanU8
Message-ID: <CAJfKr9XzUw=-n72ozDv=nQTDMkj5VAYHeZjtdtXvJaK0sPPgpQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/4] target/arm: Allow writes to FNG1, FNG0, A2
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej1-x62f.google.com
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

On Tue, 2 Dec 2025 at 14:29, Gustavo Romero <gustavo.romero@linaro.org> wrote:
> Afaics, we are not flushing the TLB here like we do for TCR_ELx (in vmsa_tcr_el12_write) before
> we call raw_write(). Since here we could be changing the A2 & friends bits, which can change
> the value of the ASID being using (like the TCR_ELx.A1 bit), I believe we should flush the TLB
> explicitly here like we do in vmsa_tcr_el12_write().
>
> @rth wdyt?

I agree; the guest could reasonably expect TLB entries previously in
use to stop being matched. In any case, I don't imagine flushing the
TLB here will be a significant performance problem. Good spot!

Jim

