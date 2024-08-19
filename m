Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAB7C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBEa-0000oK-Ml; Mon, 19 Aug 2024 18:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEB-0000Z8-3G
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:57 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBE9-0000hC-JH
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42803bbf842so53102355e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107911; x=1724712711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkmnMIiYe+27d0sNHWNILcAXDpFi/s5I0/diI446638=;
 b=sCYybkAExAFTgUSsJjYl8bw6c5CARMkMn45Lg5noMMOO0IkSraUe4WlM0qePXN2ZVt
 M8oIJvSP5eRo+9JdNnEWxKwGrMd/p0TcUtD65OaC/d15jhy+55QGoOp4SF/twNdS+Qq0
 c8OcHYdDOy0NvWKbo0jkPU80EXPKAU/jZWcX+FDzrEFM3/OtzY87T0Tx2AFPA0Qyf69e
 tRhaIEdsaWPAi379BwOkjreP1aj8Y2Qne7+34EiKw0xmzf6x1/oPHHQ8ha8qKCLQzldE
 jtfbHfU7SVN2yvOUk2pUAPtnEGxsy+nuGYy1U4jVCkRhBV9tIxPE16Him56jYhkfsOpb
 kyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107911; x=1724712711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fkmnMIiYe+27d0sNHWNILcAXDpFi/s5I0/diI446638=;
 b=qNVh/9jMERrcqKz49REKGWWtVVNO6GgAkHIhFWyXEeTpYxeBKoTjB6rL1VLAns3dIY
 qTikD0LOzlM2hQ6LRGxOygoFlfXcj6vWLSRuorNTwDOh7vB5K0dpyQCfLtCQjbp8zwMZ
 KM1krWBzXTK8K+l00O0y0/WyrtLdlkDdaGJyDaqe39kWQhlNLkZNBrwaPhPAYwn8ELtr
 +WgFocNznxqo7MnFuFw2+/3WFFt2gWerbfxQ++Pku7KoVGV5rc3Me/09tChI3DLgYc4R
 YXCeM4QEAbM92uxceeeb6oFiFfoeQRdwRpHh4JHIxCVytsR7QFnZOr5EVOLv7XxEmPIK
 L6Xg==
X-Gm-Message-State: AOJu0YxaBe0HQNjQtBlCpzSkyDOSACjt/M4XRP+dkVIPu3GPkyj9MyvV
 j1vi79V/1McA0pM8DbclMwrxI0CtHeA0P9DnwqKCdHjEpu36KmFEQgG/sq+GCp6xyVV9Y//MrcN
 CXhs=
X-Google-Smtp-Source: AGHT+IEWFQ1diX4iQPNwxuhhSfv9gv4sajZEOm9lJhZtI7t6aIpOjbgDL2wey6AKmNBKpdKicHNeFA==
X-Received: by 2002:a05:600c:1549:b0:429:d43e:dbc3 with SMTP id
 5b1f17b1804b1-429ed7ee077mr103606855e9.34.1724107911263; 
 Mon, 19 Aug 2024 15:51:51 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718985d9d6sm11572563f8f.64.2024.08.19.15.51.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:51:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/20] hw/dma/xilinx_axidma: Use semicolon at end of statement,
 not comma
Date: Tue, 20 Aug 2024 00:51:03 +0200
Message-ID: <20240819225116.17928-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In axidma_class_init() we accidentally used a comma at the end of
a statement rather than a semicolon. This has no ill effects, but
it's obviously not intended and it means that Coccinelle scripts
for instance will fail to match on the two statements. Use a
semicolon instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240813165250.2717650-6-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/dma/xilinx_axidma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index c9cfc3169b..7707634253 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -626,7 +626,7 @@ static void axidma_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->realize = xilinx_axidma_realize,
+    dc->realize = xilinx_axidma_realize;
     dc->reset = xilinx_axidma_reset;
     device_class_set_props(dc, axidma_properties);
 }
-- 
2.45.2


