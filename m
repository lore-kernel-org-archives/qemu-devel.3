Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B72C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 10:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udndj-00077Y-Cm; Mon, 21 Jul 2025 06:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udnde-000700-Ph
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:20:55 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udndc-0006w7-6D
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:20:53 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e818a572828so2776604276.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 03:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753093249; x=1753698049; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2P+qLiv05cnvssuW4eCw8tGUsEcJd5QTQNA1qCHuACo=;
 b=bBb2Ssf3aphGVc18bH/BiNKL1pYdbssvlY5MnMfWr1MtkoWb9V2NiDwph+eQ19Pt7l
 nKZCda/IuoEGVHTp5qBhU6LVVBRiLUChtpdaYokg8Gd6HNaqtcO5pgDCOD1MSFczzZ85
 IqrAG1yCQ5g5nX/qDfTfIEAKUX8vJGBfMPWPLJv74DCZAE9qxaA0GHYEx0oqvoVAQ5Ab
 ghLsEjrksuXdA2yHSQPOwkYRtOS96TCmeBySVYFNvqbIJi23jrMF04tHrp6lJD9KdaBm
 XnL6N3TOZNEfeyHZDGk7P4QwAGaeWJprca2zyImWhwg95sdVXokYA9rBAveKnLD7RfPi
 NNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753093249; x=1753698049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2P+qLiv05cnvssuW4eCw8tGUsEcJd5QTQNA1qCHuACo=;
 b=eNk2ZPwtYTtrO/01IhqhFodEAktsJ0zaIylwS/PQCH9MkHtyFAri/+6T4/LfYQ4qrb
 GZy8Sim4ywA9idQ25f9hDURBMOoazDzRF/R9o/A88EbjMLCZzCar3yF1lrlOjuVOzWr3
 FonnMCo0gzXC4lHBbuzNh2jBTD9u2BIKIezitLJ6R4whdZdWtM9irupYO24CLP0Jtovn
 O+VcDoYaBj7y8Fjqb8qFdnI5bK90MLHXaJwkF3jXEU8IVMx8g7m9wFHjQqXoxTpXy7RI
 lce1pYOK6d32TQ4CdYqXbbtL/uMh1DQ8zXEqKWNFVruzGev4qky35sj8ufXZGRPYCbV2
 Mw4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCURKx1EF/ixwN/Z5PhQAMLtHYMiuydGmd8Rgq8vuphUQBCmIUOXX4TNR66t95OaKd8HPIN1Z/QF9HTG@nongnu.org
X-Gm-Message-State: AOJu0YxcgMAv4G4XNjX6YCnn11foun1mf6ZRFzzd0xFGp/m0zcYjFn31
 ANOnTuJkH6YawjH9gRxhrHJO74kFvYhpC92ypGCmje3OVBp4dFAwTsxeCsea+8VAL0Gl3U03FTF
 V/u8ZhKnN5HDwmWE6J7mtd0E/nJyzWBvjttS7qwRvTGFj9Hle0znu
X-Gm-Gg: ASbGncu+EpYoQCuSCtGhFr3AsvQPbJ1xKQYa8QEkOpYs8bLCq74GX/F2YyuaxhYl2je
 y9pMuv+uZA6jmjgdWLteMRQS61f69Y7K7GRC20cF14epxA2n4iK9WnwTSyBFWi3I2m2uDmkKBLq
 H54x8N/wcVN7C9MTww/4ZUK2gTP0PuS6yytmZiMxDf1JMkyW5GKsBhU/cMkqZdvuJU+l62IgixC
 8cUyIHK
X-Google-Smtp-Source: AGHT+IFjHqkbWecQJ449Vlj0JfptaVmkGwDhLyEaWVI9yAZ18vLUd8z6Jsq7YpTFZ/iTAPH1IOCJ51gxePwb3xMIZiY=
X-Received: by 2002:a05:690c:3703:b0:70c:a854:8384 with SMTP id
 00721157ae682-719521a381cmr113637457b3.11.1753093249508; Mon, 21 Jul 2025
 03:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250714160139.10404-1-zenghui.yu@linux.dev>
In-Reply-To: <20250714160139.10404-1-zenghui.yu@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jul 2025 11:20:38 +0100
X-Gm-Features: Ac12FXxUnKM8-lSzqXHCTPcZvdgIZ6_qDIiv1MjX5fd2v2FOC3tFqcnk4jBIp_U
Message-ID: <CAFEAcA_iFDX7dmodE5WfVOov77YXVOk4tcJuE67zKVwQQCaBdQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] hvf: arm: two small GIC sysreg emulation fixes
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, agraf@csgraf.de, 
 mads@ynddal.dk
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Mon, 14 Jul 2025 at 17:01, Zenghui Yu <zenghui.yu@linux.dev> wrote:
>
> * From v1 [1]:
>   - add patch #1, as suggested by Peter
>
> [1] https://lore.kernel.org/r/20250315132030.95209-1-zenghui.yu@linux.dev
>
> Zenghui Yu (2):
>   hvf: arm: Add permission check in GIC sysreg handlers
>   hvf: arm: Emulate ICC_RPR_EL1 accesses properly

Applied to target-arm.next for 10.1, thanks.

-- PMM

