Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3ADC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 12:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA7QG-0005Hc-D4; Thu, 23 May 2024 08:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA7QE-0005HF-Qk
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:19:50 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA7QD-0005eW-5N
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:19:50 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-572c65cea55so3563850a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 05:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716466786; x=1717071586; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1+cVf4rDxeh57dwtYlokQVa3htFdPuopK6yJ45QAiM0=;
 b=ZecZI86UDdcSfJKLWB2RLLVz8FvpCL9oFCTK5yEnC8Sd4HjZFw48/Ok9Aydz+flTPC
 gCOQWzFJOrPQ8dRtk+YWo5iVCMY4rNGLdPSUkh4GU/Z++LzHYycx33gvyY8TjW5T53tE
 H6wujQcxnVA221kiBd+bKrQUOUxRKTaeN0hg9hgkKugNM0aZsv0F9DmEnpFq58o3w93Y
 KzdaDvHa8nZgXLBxRlC24PyuSRkQTK5LUQarK3RfGpaetugc4gbMTKyXPscS5G+WBKg5
 5VBNwRPx12UbmSHWfdL7PiRuRxnVnl2tkzfF32AGO5y7MflS8zlRu7+TUMRw63EG9H5e
 8CHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716466786; x=1717071586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1+cVf4rDxeh57dwtYlokQVa3htFdPuopK6yJ45QAiM0=;
 b=muUv8QTgmav86Nu8x/Dd/S8eUYO4Dmfh7nUC/jjudwgW8t7ORM07Zwtg5OKW/DepCU
 pCp6fSqyFigZk/YLiBW1maidxBYroCz0n5j7PC+nuS9qyrgN2ji2VvMbvHoh4a6UJtTG
 wLtlYD/by0Ykijt3GTjEenVNVIOe33LgIBXH85qTTr7egxI6LwTxa2jLnTULOfkvRY0Z
 BoW2T+U6qqKnLVxUrKUDbymDrUhXF3npoQ5s2KwGpgMLsgjehD2VH3x2L0hLh+HzsDg9
 bPmgcCRfeYGjZTmOCpwqGP3W2KMM2GxhnM/Ni4UvYSKx4t3wasvITLR5HjoWrZgKZzX5
 A46Q==
X-Gm-Message-State: AOJu0YxpgyiEi3u/M3XB6SKw1n304/lUwXNHbD1odXvenkU5f3pXFmDH
 6kB/b2tCsKYmjBs+Pqf2dC9v7IUC6jO2XIz5VOkaEMVb/c8bsIaDy3y9/O1HO3/1vSewJ36c6St
 V9brs+JizvB+DyYtBDSzbWc5WbFBi+9TCJoGOZozuhhren8um
X-Google-Smtp-Source: AGHT+IEAyMzJ217Af6GROVILQQc9xgpWPdT8zrOotDZkOZXunIKET1lZAy1MUrcPmpMzPBMm4/EJ5+mQHSnBcQ2i4Ew=
X-Received: by 2002:a50:cd43:0:b0:574:f83d:b282 with SMTP id
 4fb4d7f45d1cf-57843c4337cmr1767985a12.2.1716466786385; Thu, 23 May 2024
 05:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-21-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 13:19:35 +0100
Message-ID: <CAFEAcA9k=K9H+eqCU15N+FaWQZWJFMZPQX1mD7azqeiYDzMzpQ@mail.gmail.com>
Subject: Re: [PATCH 20/57] target/arm: Convert FRECPS, FRSQRTS to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Mon, 6 May 2024 at 02:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These are the last instructions within handle_3same_float
> and disas_simd_scalar_three_reg_same_fp16 so remove them.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  12 ++
>  target/arm/tcg/translate-a64.c | 293 ++++-----------------------------
>  2 files changed, 46 insertions(+), 259 deletions(-)
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

