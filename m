Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4C3C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXG1y-0004KZ-CY; Thu, 03 Jul 2025 05:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXG1t-0004E0-4V
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:14:54 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXG1k-0002gO-0F
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:14:52 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-714066c7bbbso88079597b3.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751534082; x=1752138882; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pGSkVMNGir5NqYN9mf3Je1X84Aau+Zt/mS3etMOmdhM=;
 b=Qgjx55OeqKAdq1mFJ/tGYZlzj16lcjOXibp32ykZAGWGc8YpJzfz+hKcbQfnCsRtob
 3v5QqUFSO0Hgh2FF/9sQMcoUnqtwd0Ng1vUJTCCj/NFaIajzSfUA08RrJH8EPfx6z+Qt
 Wm0qqhPQ7/bUUSiJ9Bj2cNJt/ZiM8dZvjGIcoBJzpCaKr/b5X23g+0xjRWr6OeRmtHv6
 uVLcNOtBseUkm5kfL/bdPg1Jdr6+joPM/y9hVN9VPym8Pw09wg3ip4Q/SAg9J8aLniCp
 CoI/wkyxK6oIIj0vXUcrOVNxM/kWpUnRR4Co8bYy+UWhjdzMKFadQxXKCTQUkLdFcPMp
 HkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751534082; x=1752138882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pGSkVMNGir5NqYN9mf3Je1X84Aau+Zt/mS3etMOmdhM=;
 b=YaEpVwfqbQvVLaxXy+lyRnv2u74d+XZSRmz8L0tysEu0CjUFoD9FXoW8J4u/ZUcJla
 LuNlnvPQrzsTQlaOhR9tFTjLu5mIIofK0VnCY7kSkePunrqbxOhvIa0vBQdAvjX51pde
 41PbHrXxVX/6rN8+/pfJmQ2tSJ+9emmeB3qIEOTbN3UfAcwyDHJqa8DodZ/cXGWoR5q+
 OC6E2/2Uj2VD1cmSkhMhJQ2E+BhsPKY63bCowgcKZKaRzoxvdPbgu1Lj51ZxUhWbg4wL
 7Akrs6fOm6TZEuv6JZ5gNJZCtubeFT53J6BW6NASZhgGeTN1jPEqtI7R3tLhriceeR2I
 iYlQ==
X-Gm-Message-State: AOJu0Yzz5PyMUQME0+40iwUVErA0ocXDT+ZKqYrG+lGds8wdDdxKxZiN
 u/I2GrCHhezvQpjdkXDqVc/6V/YntA3mLlowGb0FOAbJQGRRGd4h2jdSTBQvP0AEGNeOT1mv+2j
 nKBK+dqZTZ36QVdOYI0Ujnn8XdYafqL9VltKkGtlqHw==
X-Gm-Gg: ASbGncvxjG0QatWUKBMbDIiyUzC5WmKLbi1zRX//3W9fLo4jTQhaDcTVCoqTC1l5dcT
 zl6X0KDbnjMdeDE2Q2zYLFUOjTi0Ul7xj5F1s9J4C0j/C2QBgBics7kdnT1eN2XKHIo3oyhY5PZ
 xvwmqf+qHczfuEaTXVFaRzDchvTp+SCsgOwkkeJdIwA9ID
X-Google-Smtp-Source: AGHT+IEA6E7LYkyVPfOEVdk46wvscw7PHTDe+DThCTi9y1suVfsLnl2suIA7GeAB6zEYBx+m6HSxfx21iHv5pabmmqY=
X-Received: by 2002:a05:690c:9b06:b0:714:691:6d1d with SMTP id
 00721157ae682-716590aecf7mr37960847b3.24.1751534081741; Thu, 03 Jul 2025
 02:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250702122213.758588-1-richard.henderson@linaro.org>
 <20250702122213.758588-5-richard.henderson@linaro.org>
In-Reply-To: <20250702122213.758588-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:14:30 +0100
X-Gm-Features: Ac12FXxydFfAJhHEDJzEFqG9DNUxbnmZQQLzqXDCJyLzg8-KyLgCHT196slmn68
Message-ID: <CAFEAcA_72=K-DZmkTMCjsL9unRzTFu+DKGKNFpw7-bvNhvu-4Q@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] target/arm: Replace @rda_rn_rm_e0 in sve.decode
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 2 Jul 2025 at 13:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Replace @rda_rn_rm_e0 with @rda_rn_rm_ex, and require
> users to supply an explicit esz.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/sve.decode | 48 +++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

