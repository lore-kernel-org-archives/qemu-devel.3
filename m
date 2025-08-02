Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A1CC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiJ39-0007LI-N6; Sat, 02 Aug 2025 16:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJ37-0007Jb-MZ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:41:49 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJ36-0006Ms-9D
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:41:49 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71b6ad2d6fcso22216117b3.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754167307; x=1754772107; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T44i3x9dLC+w1fh5TMNpXFeKHi/BHI914c7O7opX/MM=;
 b=QEhaTwoPXEBH0ceD8F1sXAjHpx19GvWRT/wa2BzAXOVGjsRylj2fTK2n1+4LHvcLwx
 BBnY1rDXyZV/C2t4e3J/uGXZj2R2wqIFn8TsB01WdTYqx3WbaSOypj0IOfyUeUjQG5OE
 hnC3rWSp30jUPMOYLsbfELPhKp2DhskxTcDSNehJ1N/LJ1OMRU+6PpvBwI5MO1Dy7tZ+
 lINOTjlOx7GRBisyF24qoEJZJ0QNCDrfgqHCCcZIEWZUJBdtfwqZPQzV5FyKYNBqE6Z8
 2f98hANxHBmj3Of4YXay5GtsYA4lC78hnbyE9LOwmDBLc0DBTeKTYnaYe38yPh1AdWrO
 w8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754167307; x=1754772107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T44i3x9dLC+w1fh5TMNpXFeKHi/BHI914c7O7opX/MM=;
 b=NSxsnPhEhhVrt5CMpDbWfzGDij6QT+JWmclLjeAYGR98RGT/bD8yuc8vg5IZQGRhoT
 HaDGNSjUrRxYz3e9MNk44sN3OTCV5EABeSkQDOJWNeSS+t0UwpZ15YR0U0oWEz4lZYkn
 ZEaSji/hUUDcADQn48BxHkz9Giv2fyel5fsSxNGPHt3fmnQ3wxJLarRXW8iH40uSXKcn
 AsvM0ERtLGKM4ZYswwTKTdDbNRs8fCH4yqMXKBhohurmKbK1IkHAYeEfPYBhO8yv/5HL
 NQYg6eOfTVYWIRx1B97iO95XASxbXJSM0eaw3on2xi0wU5RJ5xfXOTtiQT4s6I8tbyJa
 i7MQ==
X-Gm-Message-State: AOJu0YwhxxKGTIwrcnofpjGwPfN7R9GJlhhVCFcsJFFGiTjBoJMFCAav
 4Danfvipoeop6ohsHo3kR1Ht/wica/Z41fe4CyIyqGrVrV/ORpJduXmdDy2N1j0on0MZhKj9ELh
 PwMt+syUdVtURe1kVtP6dS48FNch6Y26wou8Ut24FLQ==
X-Gm-Gg: ASbGncuQ6loZ1JVi37tlAVLSKK3pWK8JTf5Z/Z4GIoTmhe+1g5GUROtd/7gtRGbl48m
 HMwOA/XT4jUZxINae1zruawW2r9lZpVwW5aMaA7nJ4423HPHjwWIXGkzzOe29vmrsFn8k6TqzW6
 EV3vdInJ1/NthhWmRE3zjWnr3brxcG1arC6pKQuPnjkWt3yfRs1xv9+saiXKvr6qjs2Nh74reWW
 KFbBBAW
X-Google-Smtp-Source: AGHT+IFkR8cm5/b08V7ju8N6x+RNjxz0p2A8Ec54nYEg2++ERxUAu/kKQOPG90btLlmnPZrAT9BXOeNOBpc9U4iI5eI=
X-Received: by 2002:a05:690c:6911:b0:719:f7f3:cf0a with SMTP id
 00721157ae682-71b7ef77af6mr56819087b3.31.1754167307105; Sat, 02 Aug 2025
 13:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-85-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-85-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:41:35 +0100
X-Gm-Features: Ac12FXx1gUj5ZbHhlfuIpKs3acoQEWnrfJUS6FS2a8qOyBgSMunw1a34lJzsmJk
Message-ID: <CAFEAcA9h3g5DZye9opWpXV_PG0o0oERj5bkLeGLkdjuF=tBu+w@mail.gmail.com>
Subject: Re: [PATCH 84/89] linux-user: Remove a.out declarations from elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Wed, 30 Jul 2025 at 01:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 19 -------------------
>  1 file changed, 19 deletions(-)
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

