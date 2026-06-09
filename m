Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E947CD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsTX-0005vd-5g; Tue, 09 Jun 2026 05:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsTT-0005uX-EE
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:10:19 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsTN-0000wx-Sw
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:10:17 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6606678420bso5516032d50.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 02:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780996211; cv=none;
 d=google.com; s=arc-20240605;
 b=afNA06Peb0i4A58GsZN+Ha+lN5sjkq6JWuz6kjXMJK8AL07zzvlHRrO9JssG7hm/sh
 WSmS9PLqUjc1hmD7bO+bb9C50Nsoc4W55lC0wcW5x12wYLi9bdjpS5YgF/cBPONKNlQX
 3zZkPQFV9gn8IN/Ntpk7qTxYKzJYHDJC4tuKoL52nhcJ87kUzUvIUVkeiqCX9p8SfnpZ
 UZgctDqfO1h7kWkIC7ldDej4hBiWBRhV0WqKThwF3R3Ze5d3L/YG37519BrVxJ912ywZ
 wCJedwcrIzz3WMbcJnalamMoQaEZ5Ai/dcbKyB6amnaw+GRwNxh899mzfhgByGainXi7
 PJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oZsOPcAqbTVXMA0xIZPq890j8kiqsUk0YccP4wpcdyE=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=cnCxOl5R3rIBZ5kr7pPXLd3ACZ4mED+MOXXzEzAjKfXKjBjH+jlkjDTp9N5hgq3zie
 D4PN/wfUCiiw29GnHNVE3mtLnVs0axxmIslLMO/dEN+lMKn+a+C0u+LrAR6qwR1HmNLs
 GWZXKNQ09vejQFYS124dag51R3LpxlZSAzR4OE4iy/ff1eRNApd3YZwhVXP78Uy1Uchh
 QBe/GIIMAmuc6tlQTo16V95EhNCrXR/3x3AF6tJjOyRyGsX4YEkylqjUyJULCPUroe0M
 XceGKhabwPjJ+38HfZwJbom9eYxjfeCqSF7a93eNY9JCJ6ap+wJLXfV+Ra/BBUo5Klcy
 TMng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780996211; x=1781601011; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oZsOPcAqbTVXMA0xIZPq890j8kiqsUk0YccP4wpcdyE=;
 b=nnugn7JAn62PLMSDX8k3KaE09TkSsGQBrW2vDcpxvzyGG1czNNG1OL3dVa1ftIHk4/
 9ryk7o6t2g0FrkPdONkyXnsCv8R3KtGI1B9CHp2cORUCL7vxsgi+s9YVaL2HhpPEqVtK
 OoHugVHxiYPlAp+CJLhMPSq4R+r6HwDWb14O/2XiIq1QzPOZIqHu+5Y7xxcfkKXpECqZ
 kkhv77J687EsGzt66Pl9SSbgTEiAFRteAX0hoj/28NSiE76tk2YBgoIKhbLuj/OGZzSr
 MJ2H6BGmv1H2nogPjwfq9n7JJa3R1/5bKM5Vzo7a5Tbf/YNU+2GATIa7WSjM+47Sz5pO
 JuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780996211; x=1781601011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZsOPcAqbTVXMA0xIZPq890j8kiqsUk0YccP4wpcdyE=;
 b=PTn0UvQH/P0Ajfm0/8SpSbuuPhey2ShSQ36NCUdhYm11qJI3FTQp0Emf7MSv46pv5r
 aAb58DbiX0L8Kx2aUb07jmcil7c289f4xubtTdvfQ3Nm3ltADJTDgT2A2qNCxWqkfJK4
 pkkzmwjhyKxpqDteQ53Fqm4xwdoAuKQUXXxUYpaCUPa32lcgDFd+Rn+kZ8cIyjqF16Ol
 b8TpFHVnvepb/P5OGEmq9Nm7nbwRfxsiHuHir561ysiwMmQIkYBV+lh2E6MYFKt3NkmY
 qlFdhNXh7x7M64AqRMU67e8TQQ95GnE/kpvakmdf4dElqVQlwdkdXoNzRhMITiTiWlHg
 SqtQ==
X-Gm-Message-State: AOJu0YzTVWdsOdPnHTMwvW+0hgFsFwgLw5x+wgBVuwMiHUueW/IsNN6D
 RrWAG9Okx+OL2EK1kygv1PodhBomkoWhlgP9LozgaSPzDgHmZ5aluQsJ6d1dMYlE94lbEw56ckT
 tpStdYSeaHUJoXU+Ft5pYGTtFX+eCKw13Lc49QX9N5Q==
X-Gm-Gg: Acq92OEQ3A4BUlbfm2BRUkBg/JaxjV8u0Tt0Ldvw+6DeJgbQx2TijyE1RVMcMwTUTnU
 PlHzQsxkeZC6RDLOxlIemkVOG/8dreDyw4z6b+xT7y3Z9euendonigbm+MN0AhgTm3s3nP+ylOM
 y9CPCK70JtMiyCdqVBV7rGt8Rn6ZN/rFGUjCfLSoiaUZ+i8Dy3M021J5YPPbKJa+ZTQzP5R7gl6
 3m9j7KLf8V9w9RPmb4Pp3QuEpm5WE/d4oE1uS8TL0jEGd/UYe6+gwS03NfspYJCuYQ/7j+apUvi
 5+56GwNXSIYHoESBW+TgEQAyAjA1FVCGG25gRrtRtwJq45fHmdMo3eJR5Hu5fwv+WjQwCHfjo5j
 56g==
X-Received: by 2002:a05:690e:1248:b0:660:5dc3:3fe4 with SMTP id
 956f58d0204a3-66106e5b496mr16827497d50.28.1780996210788; Tue, 09 Jun 2026
 02:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-21-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 10:09:59 +0100
X-Gm-Features: AVVi8CdjKfyz_ovgExGYPmjBMmAUXKj7DWVsgY5QQ94OcbkRQBKOB_CAAGbxRg0
Message-ID: <CAFEAcA-P5SOyRzLeDGCiZTJEp0eEUAaxn8=_eGJNkGxPQ0yGBA@mail.gmail.com>
Subject: Re: [PATCH v9 20/45] target/arm: Implement FCVT, FCVTN (FP32 to FP8)
 for SME
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 3 Jun 2026 at 04:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

