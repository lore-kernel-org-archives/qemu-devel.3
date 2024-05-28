Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D2EC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBz7V-0001Fh-0n; Tue, 28 May 2024 11:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBz7T-0001F8-EU
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:52:11 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBz7R-0006Tr-W3
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:52:11 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-578972defb3so1223189a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716911528; x=1717516328; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SlgBElTCsYex3FAMidcSlf36AqdT+FUpJCgxTFrJZGo=;
 b=K5YglK3pEmGD68pc4qAGCgFmeCVZAwXkS33SPgDI4PVz8q46pFivC1eJtvHDogHCRJ
 TTu170CC57/DNBaJrmkoz1gME4VoyJSGZ4jdSHbUhzPDWwiIRdhmI38owYBcoZo8SDgt
 v43oLmaSIc1vxXDakIZbJlLwxFzt09rDCIoQHYgfqJzSge2cMGE+z8b4uRUwjL5JSg7r
 2/jEIvBG2h0WwtsBwIUelbqIJ5qHTxcyaecEJtx69ORq3O7ybhS7HmGLAy4b5KiTGGfT
 837jfK0hTmEcm2TQtIauI403XHmXAwEIYUkZhirjaF7tL7I6R45aAu41oHASY2KIqeyY
 WcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911528; x=1717516328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SlgBElTCsYex3FAMidcSlf36AqdT+FUpJCgxTFrJZGo=;
 b=M3fn/gGTudwAo1dzg2+Zyr8mV90YYIeANtmGPsRy6auElTo1dlM56x0LUMS9XEa/9G
 PKaUZK7yxCFbBy7vhrah6LRtWVHXz1GOAqxMttJxNRhesPJ5uqYTxLL+jUjYs/c59/P3
 aaEduRarJ4yq+F3cUaGLmal/uHvUdlxPRDeG9DxO15LhPprnkYN15n/kAKiDiBPztHSw
 YuLYXLGcLJIAeeHr+WIzeX5Ul9nRCTq214kKhtcT82fZ1UFxchZQXPzxv5NI/KYBiD/G
 YXE9IJSfJkGvRtNb/sC8GRgrgSSBtNbUzPU1HQ2eRI/nqBGVjnVDPMO/0N7+6HaKUxz4
 ciWw==
X-Gm-Message-State: AOJu0YzsPS/Tdvku9dj3FKIYoIaZkBpNG5/H52TXQ5MuM+5eCwiFTq2Y
 Oz2DYI6N6aef06gvVrJrULdBuM1o2VgzHhus3DcXkLeUcbafOwDRGTRRTtxmYYyN7nVPUM2Fg36
 RlyaArqKneFtex7of58ZlUADZt3bzQPash9z4FSw8BD4XDoNv
X-Google-Smtp-Source: AGHT+IGrjbs60FWnW+HlE+JQAqw9Yy1uN11l70ZfDw+HoiI4qbX68WcYtkGr07YHW2XvdQK5AhjvuEb3zcouDXqxGCs=
X-Received: by 2002:a50:cc8f:0:b0:572:d1e1:b4b3 with SMTP id
 4fb4d7f45d1cf-578519709eamr8335479a12.7.1716911528611; Tue, 28 May 2024
 08:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-46-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-46-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 16:51:57 +0100
Message-ID: <CAFEAcA_W739Q9jpnO-ozg9p-41XzhcjgbwQ408XR9XJkQvx0Sw@mail.gmail.com>
Subject: Re: [PATCH v2 45/67] target/arm: Convert SRSHL, URSHL to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 25 May 2024 at 00:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  4 ++++
>  target/arm/tcg/translate-a64.c | 22 +++++++---------------
>  2 files changed, 11 insertions(+), 15 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

