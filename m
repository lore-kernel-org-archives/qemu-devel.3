Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB700CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsXl-0003SV-L1; Tue, 26 May 2026 10:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsXd-0003S0-4C
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:13:58 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsXb-0004Wf-Mj
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:13:56 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-65318dafbcbso10642891d50.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779804834; cv=none;
 d=google.com; s=arc-20240605;
 b=Xh/wz4l7rcP65NkqdcvpjxPjGGJ62P7hwfI/l2/1/CFBXg1+MDQfCixvcsu0Sh5g4g
 crAME0Yj0aiFwx4nQDfn5Mxbu7N6FjsyYnUxRX9VbJjoGwatgKpgGYd17VKf/MVpMQu7
 3F5vOXXuVExwSqgaQe8P9zPeNPUK+N22XnVXKZTi6m8VXmXerxViBTbhnEsRwS/T1xbG
 kiWQQ6ijGeukdmRt42xWnzWg0zcp8Ib/7aSpViMEazGd2IJDNJfKePrWM4AGvwZP9H7D
 DMsRxpZZ7qrAxhlyRztav5VTT0VAUZa3qOIgbAxqaFDA610jLPh+V8c4ooAcEo/XARvB
 963g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WLX2aTvLFNIGbLPcUR82yfYjZSdUYMavJOGl+OQgvoI=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=QcZF7tT1aGMVaCkaXuAKEmrScaUtz60x68BrxM0ZMPNs/acW/vJfuzhUC024PNJ0o0
 yG6vK3CS7Db+hGR3D72jXEYSxUPyyPAyKS6aA4oDMjYRlthcmarqNowsYRbC148V8s9B
 DNsEjm2MEk4fWpWpBZnyRQ6hz2je9UT7f0PlACheMrPLod4XRaH0OVLqAzWhTysMczq4
 Ssnk5Vw8KaE4v881YbH+siSvphH3Ew92jNq+wo2gvKRRTDado8BaUoQUMAIyldwyHzWf
 UHo/JN+CaLHgxzBXPQ11OXLh7ZY3gODr8GyuYkerXc/BhUYiJvurKQ/3S0TSE0ghVzfi
 LdFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779804834; x=1780409634; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WLX2aTvLFNIGbLPcUR82yfYjZSdUYMavJOGl+OQgvoI=;
 b=IeXWoiZ/s1gtmd2qYX9a1gekx9jbKGGiFnFnFfRLTrLd4IqhNcRhQ4/ZYAQH96937d
 8+DFkCu8soWeNvFNra0oATXTrkTXfzSKyQ5DOlzxgTFiI9tuiWuJQn5mrsIvUUhrmxvx
 b/a7z0vDGKdvXE1dxEJgR7uOci8JVvlhxejEdwvuGLmQjSPxdhEx/nH+5pPWPJLJj7fA
 alnuEt6tmPOOQYSMGcG16oWREeRHWHfKnYLgfWuEJOaBSLBL74f20mmaUbKUATi4/WZu
 LMdQ15m/gFdWAiEvm8AeG/ZnZMwDyORrwvHoyvycuqdY2l22kFULhVlRvMkha483pilh
 jPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779804834; x=1780409634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLX2aTvLFNIGbLPcUR82yfYjZSdUYMavJOGl+OQgvoI=;
 b=SQNqbHwjPfjW54IiGSIYxPQ/HaDUXEcXdvP/+0SrWFh7+xAXjh6CA7o6VeZwAi4vic
 jjLtIAfNVdUVNae2rhjEq4a9kcyJdC2cZKAfC+Pn0y5t1h06Z2NFewDk2uqK/BFCB6Ev
 AIqmvUFbKNlWvMn2Fu9MKi0lxhSykJJhfUnXNnTHEAd3oMycMx/v74qsohH5CuYzTCnb
 wD+ylsqrRRiJshyLeV8MIozOLTpDJP4DJvYO8tniHGgA0QWq76ghjfFxLm3CBuXEvdw6
 czHUQ59BQrBEqF4z2CoeEZUcX+HsoHR5gE2NKY5A+4mAcKgAPgvWJFmu9eiTsm9Ea3Bj
 DPEg==
X-Gm-Message-State: AOJu0Yy+RogNT5Ywedn/V1pDPTRuGj5UQHPBlOZtk4/PgxdXQuhF5UfN
 n6ILYCWePpIm1CDlm7aB4jbhOp31tDLJ09E0p3dVswjcbQODhlqpZV9sLZyocvF73Ez/cGlX4HE
 RJwn/7P3Wcn5aJZ0uDCUC30oCDwD53v9o5TDWJDDUfF3GBmfDUXcd
X-Gm-Gg: Acq92OETRKPySG5IuKB46haxQgu8ypMlNbrTmEJ1SUdL7SL+/yCrPJ2ppshmD1+AA7d
 8hDY0+j3nT+phD4zI1XceN2QJIJRn7xF78g/0QM4jfCTxcoLfBTxI+Pjb1BVUFFokzulK+pzdhV
 8RPBMNgS4pna3xXyDaXAshBef23IVmdPOd2JjyhHMbbcybby96dWoz/17vyJBnuyQSYgYcK1q7h
 RJxSES1odZVNscj4qeK1cz6ImYyqHKHE3h6mIc/exXgy3Zk80QAhcN5QPXzeZ6a03b06oZ8BGLi
 POvhk3Akoh6s6CGg9ZBFVKKD08VfQvDCymmAnEIRJKGObP+qvCAhm8Ep9Pn8ft5PFC47rjHWW7e
 m7A==
X-Received: by 2002:a53:d04f:0:10b0:65c:6ffb:3023 with SMTP id
 956f58d0204a3-65ec97804d1mr14427533d50.23.1779804834455; Tue, 26 May 2026
 07:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260430091832.1846637-1-kchiu@axiado.com>
 <20260430091832.1846637-5-kchiu@axiado.com>
In-Reply-To: <20260430091832.1846637-5-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 15:13:42 +0100
X-Gm-Features: AVHnY4IjdBbuucVNDS10YLNcw9q1eIQiIgwYgI_bckTiw0WoA2oApF_1045UDBY
Message-ID: <CAFEAcA-f7SC1T3Q1Jr8z67RXRU2C9jAT6TOAX8_BVFz_7C4qQA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] hw/arm: ax3000-soc: Enable Cadence GPIO controllers
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Thu, 30 Apr 2026 at 10:19, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> Enable 8 Cadence GPIO controllers into Axiado AX3000 SoC
>
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

