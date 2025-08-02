Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDF0C87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIuh-0008Lc-IP; Sat, 02 Aug 2025 16:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIs2-0004Or-Tg
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:30:28 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIs1-0004Qx-Cc
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:30:22 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-71b73225060so18110367b3.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166620; x=1754771420; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AG/DyKpjvXRSuenZ6gUy6tLrJ4MBHK5G7abd7SygJxM=;
 b=A3ws0GVeto3n1KxchyFnJGJpPYL2c9ECc3xJbiKQ9FEUKxf8sFzIA3xuLYFMVsLMlr
 4ZycvtI5OTEQTJXCk7fVosgcdgS9SbJUCfwlUWu3j1ytH++f4e2xiZ+sKbXUF9nH4G3o
 HS3/fMNfmSOk1tpUwHc1O/udMxrxEDWYKYr7T6lFMSGcSxZxn1eA2Ud0hp0wCCEkUgFs
 jRn/iMVtf7ykAHjXx1DAzACuMmmVucNMIaFokIx24yBYSzGAyAEUfx1PuzJG7DG3b0FK
 Qq+NRs48mrj/URZcIDQnz/ULB09Rq7HTnYrnV/6qBBiUT2B4cyhhpG6VJ4PDxDe5VLzU
 9MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166620; x=1754771420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AG/DyKpjvXRSuenZ6gUy6tLrJ4MBHK5G7abd7SygJxM=;
 b=wW5HIo1ZMBXEw35k+OOiUSgJkNn8BgtSXEoL3Oh7I1Mvlti9ODAgBUMdAnIjwLNfYO
 X46ABddyCK+OjUFv85I7Kp++cGptgM18KMnDOyp0nSdF3GKmflAOq3eJl1QCVul6rpyo
 dY0NtHxruBZflz+MY23xaKxgkqzRMfz5fxRwXmwnbg0lFPjhzAFPonsRwBWNH/k77OR7
 apeCzKUyWnQ2lUPhIDUt72cdlOL6dzOv1reuvc0vnbxRutXJjilHZTOdwwHVB7s35p3c
 qhqGuzgCSO3dqEOj4Im+H6cgovqscmvgh3lMOmyIZYGhHOpmUxOuqGt9nGCsPX5fxSn5
 wh7A==
X-Gm-Message-State: AOJu0YwNH4MJqQ/SdgGcZK1RYLyCBF+TJW+4JT27Y55RsbptvccrdHBq
 P53awHLjtmk5xy27LsK+xTHcwi9VUPydahy0zq8Yi2+JEiFmFVxQ70Bebx5Y2FwFvhrr2bGKc62
 CsaSOlKKrtUAmfaIX20tRyvV2/QBjfjK+knemAS8NgxS9T+i5dPY0
X-Gm-Gg: ASbGnctRlNYnnZKiEhUDfgOv0rkMbbP4yoqDlFiJrWUNsQ6yvepGfJXnaHEeD7fvHBh
 qMtgxFottb/GSUd3p4c0jC0EgALYtENqvPMCuzbwoy/BrjLH/gQdJvbDy8hwHVO0D5whiRicErB
 VazXrNSqCgZez/ekvZwKOeXOc4GkRCukgzr5Fh4AEKhgNihN3yubXLwQkF42Aee+da+q2+j+6Vx
 NCEsyGj
X-Google-Smtp-Source: AGHT+IH4ZSvlTjazkTAbI7JVeTnx4r8QZ6HNmzli7tRULWuare4mmLEDZcna1BZBGqClxSuOM/D8Czg4BIHJeg/vZwo=
X-Received: by 2002:a05:690c:48c8:b0:71a:f22:28ea with SMTP id
 00721157ae682-71b7f924854mr56776897b3.40.1754166620200; Sat, 02 Aug 2025
 13:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-73-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-73-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:30:08 +0100
X-Gm-Features: Ac12FXy1mQBe-Ha2OLw86nVBYik2ounWBjDEl4v06JRj_yF7bfi8mRjDm8hlmd8
Message-ID: <CAFEAcA9Ji2MGBnK93TZ6MzZgPVrpskW732hWPZ6uxx7jHFdysw@mail.gmail.com>
Subject: Re: [PATCH 72/89] linux-user: Move elf parameters to m68k/target_elf.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Wed, 30 Jul 2025 at 01:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/m68k/target_elf.h | 4 ++++
>  linux-user/elfload.c         | 9 ---------
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

