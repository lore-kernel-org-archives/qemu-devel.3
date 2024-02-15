Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F1DC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 16:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raeGg-0004Lx-B1; Thu, 15 Feb 2024 11:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raeGe-0004LP-VS
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:07:20 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raeGc-0002wt-CZ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:07:20 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a30f7c9574eso140423266b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 08:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708013236; x=1708618036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U8/Siu9RsG5QThZz/o9Mah5ss88OOMP9i1PtfRXoEA0=;
 b=lXAsI2Ea7qE+x4LCFqOA47O8PQLLRsNDQ/RdgsFkYxs1tdVG2Eg33E3PK5yZP/zL8a
 cDE0tK5lXJr8SvnjOoe8NMtF42bFnuqBmL4G3etP/b7B6Vu4cz7nJV6Po57NIsHEPsQ/
 m/USzu9vRJl+XYSPB2+Tv8pVzveVHrNPqwoA98+5RHoNacgTdXqsJfesfAcvjGD/szaQ
 AuJ0IDoIy8nq2h5kq5JcThViqPGxXtlQKN8L9Faprnspywz8UxMTIX/jeA3T53zWCGyw
 DZBON5zwM0ZKNDLUZNuZRIQCG/Z6QNXlw2ms38D1p4xG9P4qi11xVjZ4ow4OcsF9XWpG
 7iCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708013236; x=1708618036;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U8/Siu9RsG5QThZz/o9Mah5ss88OOMP9i1PtfRXoEA0=;
 b=rs20xesUCEWKugXpKSRi0XGIAMELQPWevY1obAbFFfPhesLM28g7uY6coi/cvnrXGB
 Ogv0hRAjZ9zljUpfLSOXusETToez+odlqpnwOCmoTqNpdTwF49j77QERoW/Ua2W9c5TB
 wKtYvZOLiX6ykgpqMJf8obm0Cpfs4f2J4zqKFtxQcGnobLsl5DJCV7DRWrgEsSzDQ/F8
 pNaQbdpYKPpKpKusJNOLiAIu1lOVJWrOad923+DiD4nIkQOeVv2MVXXOMuGF8x95wo+e
 aXwEKr4foCWxZjiTOKqXf3MQNUjWi/GBkLKtUIpo4OL+mKX9hlj6tF73ZaCaJ23TGiFD
 7KvA==
X-Gm-Message-State: AOJu0Yx3peC1EMD2XBTm5WirRD9+JFUAGi6Ktg15DDDgdmM5/VrTH6Al
 T7E5Hk7TlK9YNmO/Yz9g+6++YxTJLCQ2Fc5M33bStceD47Xpa6jaUcJmHnro2bxUNkcPWETmead
 msb0=
X-Google-Smtp-Source: AGHT+IHsB0Uf/zWQ2tGVkNgw4XveFNizJOebeD6jKEmMn+KNtrStjUza+hX4BbfDloY9HiYBhmmv4w==
X-Received: by 2002:a17:907:78c2:b0:a3d:7cf5:c2af with SMTP id
 kv2-20020a17090778c200b00a3d7cf5c2afmr1664214ejc.14.1708013236481; 
 Thu, 15 Feb 2024 08:07:16 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 la24-20020a170906ad9800b00a3cfcd8772asm697069ejb.155.2024.02.15.08.07.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 08:07:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] MAINTAINERS: Cover hw/ide/ahci-allwinner.c with AllWinner A10
 machine
Date: Thu, 15 Feb 2024 17:07:13 +0100
Message-ID: <20240215160713.80409-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This code -- which was moved many times around -- was added in
commit 377e214539 ("ahci: Add allwinner AHCI") and belong to the
AllWinner machines. See also commit dca625768a ("arm: allwinner-a10:
Add SATA").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c19ea41d1..71c385e697 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -642,6 +642,7 @@ R: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/*/allwinner*
+F: hw/ide/ahci-allwinner.c
 F: include/hw/*/allwinner*
 F: hw/arm/cubieboard.c
 F: docs/system/arm/cubieboard.rst
-- 
2.41.0


