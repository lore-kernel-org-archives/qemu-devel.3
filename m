Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A333DCD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWzDD-0002x5-Sg; Tue, 09 Jun 2026 12:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWzD5-0002vS-Er
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:21:52 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWzD3-0003ZV-Re
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:21:51 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bebc80100efso623786866b.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:21:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781022108; cv=none;
 d=google.com; s=arc-20240605;
 b=TnQodHMhKbsyiE9S9YAEwqhI3+062FIoO1kLfZ+dpPvgND0uIBNhJ9lD8EW92HsWui
 ksgHRgpTasaxaSL6OSkar1RB/UAizqLnOl2yf83UT9495vumhWUTBwWCvy8muwtj+5Lj
 HfjJH7VoSEE3sUQk3FhBLbZURxuB7v5cMr+5Ax2qrMGVow4qeHa5dOpcOCYy3Kdbkb2J
 +1Z9h9xMTTzFN0WebfbGrgh/TaIdcv+aLHj4h8iGqGfJzzAzzetGf0YEJh/HxwoNWEaO
 baWRdqCr/WVji135pMQv3tkXf9dy6FBLci2ITT84kFIfVvDw6zBKy9usVlztdljU4ukD
 HSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lJi0FUC+Wq3lY78M8l1ne60ubU4FPuJz6C4Y3c4UpzQ=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=cDkH+Ra+7F0V4B6h48fSlMXI2nRTLTpo6bdPoct/dHg/6v/ZYCIhYtWAf/rxnQYW28
 MOZtWpU6EpwwgTfp0fR0bpQCqaoDNRbBmFNl+r8gLp/zZTJoJuctbQ8dIqhfH6ec5dFU
 4sE4K8XEX3mFafUE2oE9HzeZ3dPwbPgGGUclCJTMTY68/1hyCKMLTd8t5aSUpGiZ5k28
 6ybh7R+QVEWToIDjmwEMRNt4g+gEHgX8yQUxOTwDn7pNns5Yl6xBy+eTVuKC8c6qFuZz
 P3oSjpCRZx8sDhe895+dIbmxbelmZV50sP4Pr5loTd1Vy3dlRM9X8PT6DwmTOzeYTNw5
 JkBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781022108; x=1781626908; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lJi0FUC+Wq3lY78M8l1ne60ubU4FPuJz6C4Y3c4UpzQ=;
 b=nedwTOsx8EjOYbfeIFj+AaqWAx5ZseG228LfleZlieGDWavUc7LlfTqOo8sGcMzJql
 hHT6Hg8+K5qpwoNLzD9z9epYPLTeDwUh4o/k7UU4CAiyuIhzA9dPerYw8DdU3D/CkdXN
 EEdN6J3X5EcWN8aLh2FwsFF0wta2j26jNHBxNCGFKv+lU9sOlbzcU2F19u4mayD7gKcg
 5du+70vA3cdKCnqmB0+BOz9GwViuy8ySkE5k4jwOeAPkRW5PthwDsJpbtq3ELgX8aqh5
 O12jRW2Zl2T/oBIMHFrqJ/JyFkAQeP/IQla+NafQdG76GAfIjS6A4NkBfFVFWt94l9VM
 5WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781022108; x=1781626908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJi0FUC+Wq3lY78M8l1ne60ubU4FPuJz6C4Y3c4UpzQ=;
 b=cRjabubQypcnIet/Cllx8DPuPkDkvZRhhTc+fK/plNo8medKNbs3OdoKpmEdJqLmed
 T1bwNx0XCjFqhhGK6f1vJ2CncNKUG1a1cEGJFlqs1IZLF7VjmFXvdBv1Bdfvjhj6q+vX
 vwEC+MpjeaZh4NTafjBKgs2NEKJiyfEJPrnlPZxopIftnnGtdPCPOttpUA83hQRV8xDB
 hkvCjCNJtkAJgdC5sY4M4UyxLIGZHJ2Nt6D5DlZs7PAVVvytuHKoWrjJcEn/o9z38wap
 bIjYG4TZg07IVI6HreTeeqZqKTRWJP16a7QuVoGRYwlo0V6brECgKda64YWfJFVi48wY
 qtOA==
X-Gm-Message-State: AOJu0YyeRfVX3RUgpstgQh1JU04Z4xd633DvZcusMPulktZA14ymSYLf
 7J5gP5GbOpgwePu8yC2FkMq1UX1OhIR0iEGGwrpWzdWy9NDt+3FD7MfqK7wEbI0yRGoFGNvtNY+
 sPrbcDE6KwbVbHqhbQafwxUEv7rlv/h3XaeGVLXujXA==
X-Gm-Gg: Acq92OFBpmW5oqYYcC1flX+i6W2T32KMCaRJIxlbEVkvLPbLlHLfd/kg3n0i7QdBfeN
 DebyRS3Brkvv41rdiRIRICqY+KUriiAzXxkhAmsYW9zn7uvwEfPcIbxYrhS+ZlIUniqU+7+3CFV
 mWqrx5cXak+vAIhnVobrZijPL3BplLVCelob5X3DVyvAKk8XsosDacqh4KFRyLyi9Zd41BT1qK2
 lmDu3qlWEnHrdlZeAAaWwnAE99zSIjK33IFgYSOJb33iunolGZuuGGbcedFr7Q1i65gN5YzLOcX
 pr1wl2JrBb+10oLYEiQc7Fetl0EHYukw1GVoUH6OWZn3uoAwHJBYeefDEdJvx9YYvtH4lxfvRio
 Y/A==
X-Received: by 2002:a17:907:7f89:b0:bec:7ab2:9128 with SMTP id
 a640c23a62f3a-bf36fd9c7f4mr990913066b.8.1781022107985; Tue, 09 Jun 2026
 09:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-41-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-41-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:21:34 +0100
X-Gm-Features: AVVi8Cd9ICfMsVIQhNBvhheiNHE6s2vD8rOTn_LtJvW5QBhLwkh9SeHRU4HBwcw
Message-ID: <CAFEAcA_XyWLi5UWwkJYtxFbdB9mySUwz1UwgNad3Kxt=4BXxxQ@mail.gmail.com>
Subject: Re: [PATCH v9 40/45] target/arm: Implement FMMLA (FP8 to FP32) for
 AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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

On Wed, 3 Jun 2026 at 04:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h        |  5 +++++
>  target/arm/tcg/helper-fp8-defs.h |  2 ++
>  target/arm/tcg/fp8_helper.c      | 25 +++++++++++++++++++++++++
>  target/arm/tcg/translate-a64.c   |  1 +
>  target/arm/tcg/a64.decode        |  2 ++
>  5 files changed, 35 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

