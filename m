Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B289CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 14:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNXaW-0007qH-U4; Mon, 24 Nov 2025 09:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNXaV-0007pt-CG
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:30:43 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNXaS-000332-Gk
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:30:43 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b3720e58eso3363744f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 06:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763994639; x=1764599439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=eub1bFy+t4xXK+6m5mhLZ7tZT0c/BSBsQ4C1EdqDNvM=;
 b=VWqVhZKOAFX4IuGH6ExBVK6rzEMATPOhnHj0zZZA5vBut82Fd1ykWrI+GZezjsz2HQ
 7tj1Qcvs/O2Rim4LurYkfTQBKq3jfyYO0qHI7yuspHX0Q9WKwt0yXCVLaw9LJCT9HLWV
 LCu0elRKoA45V+JmCOCNrcNA9fuV5fjOJ7LhncK8A7iiUppWDOyfxkF7CGqDb8rbb10v
 jzNT22nxhr1V9dspVryaShIgIraRQUkt+PEzIGOEvlWufcu+vMVz/TLYj1MpLaR7dPGA
 k5p5Fvx1u6u8VPl/jYZpXz1wk1+PJijneQalR/yjuxdiRqlOOGcGSpH0jVPDiuLUeLIS
 3C0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763994639; x=1764599439;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eub1bFy+t4xXK+6m5mhLZ7tZT0c/BSBsQ4C1EdqDNvM=;
 b=L/LNoLdcsFvaB2HAwhloCrgwFtvhvPPNG0yMk0NJU5xVardTvrbKRCpLgMDJU9+C36
 yjpikBdvjTRtpnih0r2SsZXwLMNFm6Qs4+D0XbENN8vKHWSSbip38CSiI0vctPFrjSLH
 szjXTbR80VFVAk6b24I7tVM7wTqSfYBpdQSQQUGAeXY5pH9QcizcHL//N42ZerWxhL4z
 2pso4gzCb/vKUBwL3Jm4AJAXeraDD5tbfE4GMYBUx7MSkz+yOMQ59Igs4OegDCPnRfTJ
 fsESPyAH/z55WHnj4mpB+6bjpFJpywQ7x6TsjdzIxfiY4XTllX+JIDq1JZXCYc6YMOMI
 umBg==
X-Gm-Message-State: AOJu0YyMh2FYOY7xkb7YJ8anHYdT/KtGDoCAA13WzFh/iXVYqnoNZ9Ch
 yDfbpDHMURvqy92Epn0kdJ2bzMHRHIeYqbu4auitI0xm4yJev43DcnTSofBwWTUEwjr/l6G46av
 vQFvi
X-Gm-Gg: ASbGncuVw+hF3IdD6OiGjKAppCIm50pEDAFabeAHgu4iwf7REBQS8l7N11TTIOS5Ztq
 qyOytiNUgDIV4QKOEyGTEBlgmWMqp9czIrto/gE0jeozrW2j93+1t1mgyuRwwhUsxX8OOKaZvU4
 ccn+tL9cACuqR6x9uJYBIuHJ1BGWlaeIQB7d18Ho1pFdWBOV6RshfeoJTj3hlqwIWzjxTHYtG31
 t+cSkQtLRwFnPW+WcqEA8s+bMEzM4C3pZ1IMJte4CSfzMLJKXbeXEmGKQ783z8LLrRm8350/nkg
 jy/TufbTuA1XYCFzO6g6FwR7rxSMPTVYGGGiaG+LD+WuGVB2ANrA7hvQm8RFSixtmtJoTgcbagy
 Z6raRPToBaVh1+QfY1iBQ/brS2iX4HuVlgQEDFi8Y8aCmXfUDbk2+W5lfEFsOyXpUq6JRCjeGMd
 y3ms8VygUqh5cmKjx9nE3Yn5nBJ34=
X-Google-Smtp-Source: AGHT+IGUHB9b3A34BghBD1vIOLEV2D+gaWWRf4H533B1y2Tp73E09ItgfeCCVZp98aGJ3WtfohkAWA==
X-Received: by 2002:a05:6000:26cc:b0:42b:3c8d:1936 with SMTP id
 ffacd0b85a97d-42cc1cf4f69mr10854670f8f.26.1763994638426; 
 Mon, 24 Nov 2025 06:30:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f34ff3sm29408930f8f.16.2025.11.24.06.30.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 06:30:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] target-arm queue
Date: Mon, 24 Nov 2025 14:30:32 +0000
Message-ID: <20251124143036.4113886-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Hi; here's an arm pullreq for rc2: three small bug fixes and
one trivial removal of a duplicated #define.

thanks
-- PMM

The following changes since commit fb241d0a1fd36a1b67ecced29d8b533316cf9e2d:

  Merge tag 'staging-pull-request' of https://gitlab.com/peterx/qemu into staging (2025-11-23 11:46:53 -0800)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251124

for you to fetch changes up to 579be921f509fb9d2deccc4233496e36b221abb3:

  hw/display/exynos4210_fimd: Account for zero length in fimd_update_memory_section() (2025-11-24 11:01:23 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/display/exynos4210_fimd: Account for zero length in fimd_update_memory_section()
 * hw/arm/armv7m: Disable reentrancy guard for v7m_sysreg_ns_ops MRs
 * hw/display/exynos4210_fimd: Remove duplicated definition
 * hw/arm/Kconfig: Exclude imx8mp-evk machine from KVM-only build

----------------------------------------------------------------
Bernhard Beschow (1):
      hw/arm/Kconfig: Exclude imx8mp-evk machine from KVM-only build

Peter Maydell (2):
      hw/arm/armv7m: Disable reentrancy guard for v7m_sysreg_ns_ops MRs
      hw/display/exynos4210_fimd: Account for zero length in fimd_update_memory_section()

Philippe Mathieu-Daudé (1):
      hw/display/exynos4210_fimd: Remove duplicated definition

 hw/arm/armv7m.c              | 12 ++++++++++++
 hw/display/exynos4210_fimd.c |  8 +++++++-
 hw/arm/Kconfig               |  2 +-
 3 files changed, 20 insertions(+), 2 deletions(-)

