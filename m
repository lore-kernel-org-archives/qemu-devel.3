Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34C7CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZTEO-0001Ce-GX; Tue, 16 Jun 2026 08:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTEN-0001C3-4g
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:49:27 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTEL-0003H9-O7
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:49:26 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-662bb4dc1d6so544381d50.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781614164; cv=none;
 d=google.com; s=arc-20240605;
 b=Zox3iqtTH6/JWS2JxcgBC6ptMP1hGP6I3iODe8CuaxNo249lnxvMm8kD/WHFTC452T
 yMBskjXjjACcr56Mh3njs0tRfQLD8/rjwyq7rP0nYO9ly4tC84ECLGTYXqmsL7s5g8Mn
 SGgc+zHaQ9ahX8hn6T83iOI6aJlGR+BgVB3nYCpROHdqaRbnAGhnoCt5/EZDpyrURAMP
 Q//ShQ/kJrhtKxPs80qnVHegr0wpGO+0/FWvjUMSTxq63DQH5IY3cGM5HSE57GQx0bCC
 K6Rg7OU8Z4NnviXolX99lmzGZx8baQvP95Hh9bagJpXMSaa9zJypmINrIyRny0ou0LL3
 X5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5JbEuJns7zAobiJzmbg9EVXYlQ4aN3eRBrXEi1fjQq4=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=YsnhmJzbBkY4xYfJ/55TI0ldz7V0eCu1VQ9Z3mU5cf5/IQLcwaTRg+o1qsnDtLlByB
 QbJWXhQV4HIGrTLoLUj5k8FSXRhdSdaUnBFbDGQxVSd7WWUZ9He8mpv5nNpby+FTi9yC
 sHSr85wnVM94IznabJEqPSkScMkd952nehhvYcOoGhHXxmJgrvHtWCygVsRfe2OUhv+p
 jd51ruVB1/EtAA2jmiL4n70iztFpIw1w3JHnzwUdDzuLfAwNTgHCit59ZBkiRpPoZMvO
 TLVw9M08MW73hl6zt5VDBWvMy+iuycHTrxTKqc2YJ79VSylREvB+EC0qTk027lR7rk0e
 e7xg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781614164; x=1782218964; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5JbEuJns7zAobiJzmbg9EVXYlQ4aN3eRBrXEi1fjQq4=;
 b=TXov6UP4TkzsQPvDYGuyTxgF+IHp3ytULSqjO54zGbbPodyJyoMPerbs9U0Hb7twlj
 xBZhzJ7T9JB0tvqpOqHNH0r/kN5lS5pA1rukdwnkIMJ5YmF059fSmv8R6bXuO7pAVtsU
 /En0nV7Rbi6Gqtg9WkyOvp8+Gc2J89bSb4mODcVOE53/AgFSphac6Vwoi0vCAjwh1lsU
 RGFkIOgvwupsQF0PL7f6+cr87MvTCuT2fXPRL0tImJdBmG9ikSmeeT3TwEPbN1obNCxw
 +ZB9TkvMRoWSMe2PSu1Hc9PjVTgo3s2SBb6kukrCu1aNKL9hhfUfEzCqrY5i5MuoWwsP
 byLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781614164; x=1782218964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5JbEuJns7zAobiJzmbg9EVXYlQ4aN3eRBrXEi1fjQq4=;
 b=G8Zj33OhERq9bAo8M2pMVTAkvkAZgDiMNmRXeYLflL+161YwydbV2wneRrB6DyUaBs
 G3/FJO5pW0C9vug7rpF3Gbklt+qgUD4MKpYnb/HB1NC/vpGLznkvLAEd8vQyUhB1gQtC
 oZZ3gxOwIGu3TnzKbJAJezSWeSQ5lBUh2/omfPhPov3qPYHo7wkBPWNWvrqUeJI9f98E
 qgUK0qWmg41G+1mfqTjZhYlqyfFIco289jb85vcnvZQOuu5/r4WFOKJ5NvHcrsDn/zLv
 BOs8xZLv/2/78/RmJ3wxR/oPAQlgNMaKxP0ArhMhUQdq8BxBUXY+VvLFj9I75SNRRMeo
 mqfQ==
X-Gm-Message-State: AOJu0YzEiC04ainW2mChiEF8axYXnc06JJYswnqB/L9lCVd/f+2JdaRv
 F7R6TgIYRU+syC/Br54wSS6gBb2/ieUV1YFwrBQ7CWHS2uB2hgOwBpt1osfuDuEI5EC//bhKgtZ
 PXjL8kjQpDUzuqQmUyRdKRkvh1Av4PJ2ZPFHh7B/mdA==
X-Gm-Gg: AfdE7cn3adsQuzMi0CwHfH4jEKAcPSbtzgskwjFZfLmsETAEYkDS4XeAtIZ2dKjPpMI
 gGUg3c2fY40ev9g1f3ePVEoCBLkLQYV9jIogatjdwkpVF7NfhfQaSaWLPg/ke4mIZirKGfFEpwd
 Fdw0p3f6hywiIIRAqFbFeGREqkvaOmXJGXI1Tz8T57L2Uj6/xaMBmNK8nMNIxxHmxhRbonB95HM
 IzWtuHYPGRXub+pvxDIieTOqQNCCXgX6Udh8/VLlORWl/H1L9/6ctoyHV+/vUzlzl23LVkMOm2N
 fZscdOG1xFZ4Kpwfyc1FFwSmnx1jymS4pYgjIxpaGvBFEqyESYo6u8GXOJPT38xxwoY=
X-Received: by 2002:a53:c092:0:b0:660:877f:a5c4 with SMTP id
 956f58d0204a3-662b61cdf60mr1809187d50.50.1781614164561; Tue, 16 Jun 2026
 05:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-14-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 13:49:12 +0100
X-Gm-Features: AVVi8Cc_TVA49BConFNItOuRlD0YGpS2LQOau6VGEej_WBHQx_6cVpvBsGuvqPM
Message-ID: <CAFEAcA-r4DqADgn4cmeK-9eY9CAr4nKEusTvVSRRpw8FM60hmQ@mail.gmail.com>
Subject: Re: [PATCH 13/25] target/arm: Implement Floating-point square root
 (predicated, zeroing)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 5 Jun 2026 at 00:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is FRECPX and FSQRT.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

