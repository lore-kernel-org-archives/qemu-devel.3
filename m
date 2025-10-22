Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D028CCCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBZP8-0007D7-5v; Wed, 22 Oct 2025 10:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBZP1-0007Bt-9b
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:01:23 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBZOy-0001co-64
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:01:22 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4710683a644so9292995e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761141678; x=1761746478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N5zOIT6yyRYMvDGxwuy/M05LXGeT1MKP7CDmxvvly/8=;
 b=oTc8+FEQtDePhI2DT9yBAWOOucU2l5k83zQr6VPN46KW0WQby8pcbmgy64S/F86D76
 alu4QwYiNu2UN1g1R2XhAOQR//fhQby9Empyk8sxAzZv3fKBdM1paobwIcRxm/f11hhk
 naiNfJVDK81US+Br/IcIrV+vqfZoy13GHt4IoiivT3Y02TTCcI8GbClhOpn1evmIq4Ya
 M6JoQOygKFvpaEgQycNpisjAhZqf5lQKBXye8rt1Q0UMcliwcJYoJD/DNQ8hEvN5mATm
 QP26ZflBEmYCX3RqQrnm/iErfEi9x/jkEgIuw1eLenf3ITG1Tg7hS9OuOuimaNf8RC7G
 zWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761141678; x=1761746478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N5zOIT6yyRYMvDGxwuy/M05LXGeT1MKP7CDmxvvly/8=;
 b=Wv2rR9G/tLQiSOKGVdyxpoOoGVgLkZYqdEB5VgdLxYkOy3reCExfPstwWrPZtX81iu
 pgeZvssHFLZb0B1fiFGnx4afpzUNIpXWb7Kz+n3E07VY73A9mc6aP0MQq3VUbcfO2dmV
 GuUeX5lSpSwMctSy8R9f4km61et0c6zhe5+N/DkT7neyEiqcPtAVpbmiVBuYIpL3JL9o
 FfmoPid9aLEcSh3UOhKLExp+ptY5AZJ9obRV6sL7Z813acH2Rp2R2Te86pS9sgIXUmAX
 B8AZSl0jce8tJCTLlC/axIkefOanvSBoSNV5bfWtvfE7zZ1yNgYm+DGp/ovvy+MavQo1
 c62Q==
X-Gm-Message-State: AOJu0YwUa+n3OI5X1NKZEQtoGRd7LLkMa6tBu7JlDVEB/d1paYYDKUEX
 V4kGeXM2RD8GlXfdhH1Tj7v5uAiBZofm1W8+Q5NR5NIw5ubajWBORryC05PX0n3O8SKydNRYm64
 h87OOzs8=
X-Gm-Gg: ASbGncvdU5JaUV7Ce14gOB3R/QhWn7mjoUTNN/2VbgdymgBSEorpjpAdcqQlb5mYadI
 c5eTcHn+WH1ne+fhEcUft6bp0UcASxQ1R8FKG9oyrJlWUN23eCj1EoV4Av1LMQPLyb6d0IFb2ep
 Q4rfiKdHb+JET80kBKOV3rTXAFhPphvltAbCvnfTFxy/GWpm0/vdHcjp9/1r1O/ffBPqoW1NoTu
 1qrbyKQmCk/ZsBX2kVaVslrpMfu2Ej1DY/sS+A/kFkB6doGNUk4V94A6XDacDu5w9osbCZyoLzl
 kPP2MczhLomT/bLMSTBpgCwC3DlPf1Gm7eveo5nvO82uh0Dqq/IIn2Q5kzfS+t+b23JzXpk1oip
 vkKefMhAGdAWWDBve676SJZiyxOPjT6PyoQmIKHylSonReHPbywsPhJnq9troUalDu5+HqbZnE/
 WrurZDkhEqHkTbFO7kyBWHw4AS8v+Jgg==
X-Google-Smtp-Source: AGHT+IHwD6XwUYTEWSIBNXw4avAFhtVwKLSbQflNayMy0B2n1fepXptONBhHDo/sWRqdW80YDOW2Yw==
X-Received: by 2002:a05:600c:8b17:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-475c3fe35f4mr26669155e9.16.1761141678027; 
 Wed, 22 Oct 2025 07:01:18 -0700 (PDT)
Received: from localhost.localdomain ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a993sm25420329f8f.24.2025.10.22.07.01.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 07:01:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anton Johansson <anjo@rev.ng>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] hw/xen: Build only once
Date: Wed, 22 Oct 2025 16:01:10 +0200
Message-ID: <20251022140114.72372-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Replace target-specific code to allow building
hw/xen/ files once.

Philippe Mathieu-Daudé (3):
  hw/xen: Use BITS_PER_BYTE & MAKE_64BIT_MASK() in req_size_bits()
  hw/xen: Replace target_ulong by agnostic target_long_bits()
  hw/xen: Build only once

 hw/xen/xen-hvm-common.c |  9 ++++++---
 hw/xen/meson.build      | 22 +++++++++-------------
 2 files changed, 15 insertions(+), 16 deletions(-)

-- 
2.51.0


