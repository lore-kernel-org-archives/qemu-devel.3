Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C330E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJduz-00046H-NV; Fri, 06 Dec 2024 14:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJduu-00044W-Kx
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:23:08 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJdus-0003UA-T9
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:23:08 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21577f65bdeso20573605ad.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733512985; x=1734117785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4FdoiVujAHlSAX1GNeXZCXDPP5ciq+pm5Du23bE3KQ=;
 b=oShX3QttcKmOuHUmGutrNo80BzmLGcKZGL18T3Iy2jagprimn8auB22IJW6TaSiDtu
 JpfhLjsqcTUmnkv6WGDVd/8MPAO1P9QBEd6JVQ/9VhkbSTmdY/jonEBgUaTaTYVSPexV
 1aXU5OIkG8ZkJ87EvEypu2kbj/4IC+ka6do73qwgDUy/w1cSp1dw+PGmMcG5LJ5/2J6i
 Cw0aC/L49O8GEkNv2GyMahnzi/Br5JAc1Uixj6lExjEluFrH1SJcfKjg0mVd4tAuq+Yc
 8QcsYlYBZFxU9/ok3X6ZSQGF3W8aCkU/8PBmOWuCb0QRLHsG6qGdZ1DGdFbO1DeTzn0x
 4+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512985; x=1734117785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4FdoiVujAHlSAX1GNeXZCXDPP5ciq+pm5Du23bE3KQ=;
 b=VnnDa51/BOexcPjNy7drEEB0aCjxH7049ApLZzEmr1XZHAtEge1WorBbAyoL2Bs3Ix
 b0KOCC9DfS6WHT6ci0pdk56sGXScrWJXDRYX9roe79x3d4ihSc+XjjeDCv5FO1rQ5GyO
 n18jm87YjXmK0+dUFKZRQk4OjaUovlmCBD9fWmqYxm5svmaCvdTBsz1qMtWMEifZa/9w
 qRPFBivvSS1Eq41diLYKOXk2Q9HPK8DKaAF6NN8Hvzk0oLkKnqpqi+rX9WoJaJMD+JVK
 BM8GMZvWx6MKwi2TdQIBlp9btcISRSO1yr6C9yA7bcjcfzSN6/YXChykw3F/xETcxAgF
 bYlA==
X-Gm-Message-State: AOJu0YyYpdnV3ae/KjO3IsfMAJ8Tvr7eYSIG1gSgDr3r6aCsnwhnPPcr
 LSDlbeeTwOIr2iFyO4pHXVqXpLpQZQPTBXj4s5+FeU7P1gRrAG9pkTa9WS4iEBMA4Yh0hOFAmGm
 TyGE=
X-Gm-Gg: ASbGncsNCAIZDpahL4xWM1CH8HZ9tbRfaZn/kL7j2I1kJZuPi99+zO1IBucPKHgn9tE
 amGzgLCtHpGhNKbx6uDX+E0TMGzPMwpiUTqJ66g3KRi9LC8kYMMha0huUAB5ZgaDoYTKd60eVN5
 fI7InJrMypwio9cwCZkyM7Y5dKQQKzLef77zWSZMa9Gu4KKQbdVdaVF5HxwH1KRsNPoYAe76Y5l
 TzpydssOYa70pFPgqM5qlt1xJVQHrCLHWnhQ2lIVyoqiLBrheunswvDAm0h+NIJp5Dnjzo5UCg4
 vHUcbEcz
X-Google-Smtp-Source: AGHT+IHWE/vj2WKDN2oXtn8sN4DKGt1jbQAa13dfknqCIdh/j9CJYJvwWqdbDroU1+spTCkjYk/EBg==
X-Received: by 2002:a17:902:dace:b0:215:65c2:f3f2 with SMTP id
 d9443c01a7336-215f3c56e3emr130015765ad.6.1733512985235; 
 Fri, 06 Dec 2024 11:23:05 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2161e5a6f23sm11720395ad.266.2024.12.06.11.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 11:23:04 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Troy Lee <leetroy@gmail.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, alex.bennee@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 3/4] docs/system/arm/xlnx-versal-virt: document ospi-flash
 property
Date: Fri,  6 Dec 2024 11:22:53 -0800
Message-Id: <20241206192254.3889131-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206192254.3889131-1-pierrick.bouvier@linaro.org>
References: <20241206192254.3889131-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/xlnx-versal-virt.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 0bafc76469d..c5f35f28e4f 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -178,6 +178,9 @@ Run the following at the U-Boot prompt:
   fdt set /chosen/dom0 reg <0x00000000 0x40000000 0x0 0x03100000>
   booti 30000000 - 20000000
 
+It's possible to change the OSPI flash model emulated by using the machine model
+option ``ospi-flash``.
+
 BBRAM File Backend
 """"""""""""""""""
 BBRAM can have an optional file backend, which must be a seekable
-- 
2.39.5


