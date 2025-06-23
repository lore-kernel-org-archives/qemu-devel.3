Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5F1C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTfsk-0005ip-43; Mon, 23 Jun 2025 08:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTfsi-0005i7-LG
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:02:36 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTfsd-0006J7-JQ
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:02:36 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-712be7e034cso34410787b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750680149; x=1751284949; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KQMUDLcR2Slp5/UaEWePL+hi954xKxnOGkK2UzCldqA=;
 b=uQ33MpI90YPXtdiSJsUt4ch5P0eRbTaOJrJmWMHii44hiewLyK5ljTprNqdWRxypiQ
 Ygxg3e7jrxatgJZV8pZ5Qyy5x+ug81mxEiy7lUeozpTfrlcNJj1P2zMngTrIyjl6gd8v
 5W/J6iVKfG5wxbVkCQgzhapAjWxmcaY6wD4FNEEsU4q2AkRPuB4e/BZrWIBfLbOqVTmw
 cPrOcbQQYr3a5EEFPD5WyZnqnEK6ittBiaw4iQSHm5y7Aq5CGIDVX20lQ+8xFUCsIc0i
 NAjCgSaEli5jFQWoWws1nkKYakqK0TrYYqrD+w9dEFq1iHlHKJouleqCROym1OGBTiAc
 De9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680149; x=1751284949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KQMUDLcR2Slp5/UaEWePL+hi954xKxnOGkK2UzCldqA=;
 b=tWraC4gv+HtYpliLb6QrqzoBe0CtDuH27LVc8m3z27r36eOCYbEbXXDvccw+Uf15VH
 vlVG0ghUzltIMXzFe/VEY5MdyNAaM+WYbP/PcBNe6uOwVug/LkzUZDiiW8OuNBswWLoK
 r9S6bfgZV71h8paT0kP5rwrnbydP6emydpuDJN6gNH/0r/O1ckYwjAXvQksYyL6y9cs/
 Tqf4OCEaOcDURBeH3ZusXYtkCUz+BsS2JeSRnHD97cx7G+GI1bnzsW/YGl4kURclflVm
 PDdag8WiwxQIEtPWnEuVN6KFXE9ZoecNJHyWyh9MuftRFFHhDnMYdahyzK79n/B6kNUp
 xtSw==
X-Gm-Message-State: AOJu0YxlZJGTrakBY/FR+i7v3d7m/GFuWHOC0ZNBZgCFWj7hIBL2/PXf
 BfIwWsuIYba2qzjk7A8+fayjHAGQtSDNZsYlVsidKSaPEI/6/4au22Rcwp7ACWmGhN0rZMzWuU4
 PjrTL8gMZ5QaWsFGqWymoaMrmOMnmrXc57NtiAbYafJxUQxPMT3Et
X-Gm-Gg: ASbGncuH8dEvaDwkOCxHpKVShC6G82V/mYnE/0iq7DR0w0lCUqMYDzHZxW95OKo/v+d
 EOl/LkHTjcWkqLN14zANwHrWAGrbMhM05avzMSs7/NxiT+WF+/A9qyrwZ1q9Jq7nl4lBv/KY2Ka
 kwDke4DXTL+1Cf9dLnb1ZdJEcAms/VTUdseKZSQ03t7R3fnAFQcbF2PNE=
X-Google-Smtp-Source: AGHT+IFXMqezR+JGENMPa10SX+gLJ5/DoHfaFkUUqnfr+HGL0STtsoQNUPtPJq2BtQ2pvG9AlKntkHTIau2sIXg6jxo=
X-Received: by 2002:a05:690c:3608:b0:70c:d322:8587 with SMTP id
 00721157ae682-712c639d769mr166540557b3.6.1750680148803; Mon, 23 Jun 2025
 05:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-19-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 13:02:17 +0100
X-Gm-Features: AX0GCFvm6CuGEzkr0gAbKgvKe0875EnJA8MlSb8hhUbN9qtwgjFuUchdJtJgGP4
Message-ID: <CAFEAcA8cbA43+Qdya4ArBrvbjw9Z4nYzJyBDhChzgoCruij_Ag@mail.gmail.com>
Subject: Re: [PATCH v2 018/101] target/arm: Implement SME2 ZERO ZT0
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sun, 22 Jun 2025 at 00:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/syndrome.h          |  1 +
>  target/arm/tcg/translate-sme.c | 26 ++++++++++++++++++++++++++
>  target/arm/tcg/sme.decode      |  1 +
>  3 files changed, 28 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

